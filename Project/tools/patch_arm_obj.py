#!/usr/bin/env python3
"""
patch_arm_obj.py - make the ARM-mode (A32) interpreter object safe for link.exe.

Problem (session 14, crash C000001D on the phone): Microsoft armasm leaves an
IMAGE_REL_ARM_BRANCH24 relocation for EVERY B/BL in Interpreter_arm.obj, even
for branches to labels in the same section. link.exe for ARM assumes code is
Thumb, so it routes those branches through Thumb thunks / incremental-link ILT
entries -> ARM code jumps into Thumb code or zero padding and dies
(non-incremental links fail with LNK2013/LNK2008 instead).

Fix: resolve every BRANCH24 whose target symbol lives in the same section
directly into the instruction and delete the relocation. The section is copied
verbatim by the linker, so PC-relative branches inside it stay correct.
Branches to other sections/externals (BL to C helpers) are left for the linker
(it rewrites BL -> BLX); a conditional or plain B to an external symbol cannot
be interworked by the linker and is reported as an error.

Usage: patch_arm_obj.py <obj> [--check]   (in place; idempotent)
"""
import struct
import sys

IMAGE_FILE_MACHINE_ARMNT = 0x01C4
IMAGE_SCN_MEM_16BIT = 0x00020000  # on ARM COFF: section holds Thumb code
REL_ARM_BRANCH24 = 0x0003
REL_ARM_BLX24 = 0x0008     # armasm: BL to a symbol
REL_NAMES = {0x1: 'ADDR32', 0x2: 'ADDR32NB', 0x3: 'BRANCH24', 0x4: 'BRANCH11', 0x8: 'BLX24', 0xA: 'REL32',
             0xE: 'SECTION', 0xF: 'SECREL', 0x10: 'MOV32A', 0x11: 'MOV32T', 0x12: 'BRANCH20T',
             0x14: 'BRANCH24T', 0x15: 'BLX23T'}


def sym_name(data, strtab_off, raw):
    if raw[:4] == b'\0\0\0\0':
        off = struct.unpack_from('<I', raw, 4)[0]
        end = data.index(b'\0', strtab_off + off)
        return data[strtab_off + off:end].decode('latin-1')
    return raw.rstrip(b'\0').decode('latin-1')


def main():
    path = sys.argv[1]
    check_only = '--check' in sys.argv
    data = bytearray(open(path, 'rb').read())
    machine, nsec, _, symptr, nsym, optsz, _ = struct.unpack_from('<HHIIIHH', data, 0)
    if machine != IMAGE_FILE_MACHINE_ARMNT:
        sys.exit('%s: not an ARM object (machine %#x)' % (path, machine))
    strtab = symptr + nsym * 18

    syms = []
    i = 0
    while i < nsym:
        raw = bytes(data[symptr + i * 18: symptr + i * 18 + 8])
        value, secnum, typ, sclass, naux = struct.unpack_from('<IhHBB', data, symptr + i * 18 + 8)
        syms.append((sym_name(data, strtab, raw), value, secnum, sclass))
        for _ in range(naux):
            syms.append(None)
        i += 1 + naux

    resolved = 0
    cleared = 0
    errors = []
    left = {}
    for s in range(nsec):
        hdr = 20 + optsz + s * 40
        name = bytes(data[hdr:hdr + 8]).rstrip(b'\0').decode('latin-1')
        rawptr, relptr = struct.unpack_from('<II', data, hdr + 20)
        nrel = struct.unpack_from('<H', data, hdr + 32)[0]
        chars = struct.unpack_from('<I', data, hdr + 36)[0]
        if not (chars & 0x20):                     # IMAGE_SCN_CNT_CODE
            continue
        if chars & IMAGE_SCN_MEM_16BIT:
            # armasm keeps the area marked Thumb even after the ARM directive
            # (warning A4238). With it, link.exe sets bit 0 on every pointer to
            # this code and does not turn Thumb BL into BLX -> wrong CPU mode.
            struct.pack_into('<I', data, hdr + 36, chars & ~IMAGE_SCN_MEM_16BIT)
            cleared += 1
        if nrel == 0:
            continue
        if chars & 0x01000000:
            sys.exit('%s: section %s has extended relocation count (not supported)' % (path, name))
        keep = []
        for r in range(nrel):
            va, symidx, rtype = struct.unpack_from('<IIH', data, relptr + r * 10)
            sym = syms[symidx]
            if rtype in (REL_ARM_BRANCH24, REL_ARM_BLX24) and sym and sym[2] == s + 1:
                off = rawptr + va
                ins = struct.unpack_from('<I', data, off)[0]
                if (ins >> 28) == 0xF:
                    errors.append('%s+%#x: BLX imm to %s' % (name, va, sym[0]))
                    keep.append(bytes(data[relptr + r * 10: relptr + r * 10 + 10]))
                    continue
                addend = ins & 0x00FFFFFF
                if addend & 0x00800000:
                    addend -= 0x01000000
                disp = sym[1] + addend * 4 - (va + 8)
                if disp & 3 or not (-(1 << 25) <= disp < (1 << 25)):
                    errors.append('%s+%#x: bad displacement %d to %s' % (name, va, disp, sym[0]))
                    keep.append(bytes(data[relptr + r * 10: relptr + r * 10 + 10]))
                    continue
                struct.pack_into('<I', data, off, (ins & 0xFF000000) | ((disp >> 2) & 0x00FFFFFF))
                resolved += 1
                continue
            if rtype in (REL_ARM_BRANCH24, REL_ARM_BLX24) and sym:
                ins = struct.unpack_from('<I', data, rawptr + va)[0]
                is_bl = (ins >> 24) & 0xF == 0xB
                if (ins >> 28) != 0xE or not is_bl:
                    errors.append('%s+%#x: %s to external %s cannot interwork (use BL or ldr pc)'
                                  % (name, va, 'B' if not is_bl else 'BL<cond>', sym[0]))
            left[REL_NAMES.get(rtype, hex(rtype))] = left.get(REL_NAMES.get(rtype, hex(rtype)), 0) + 1
            keep.append(bytes(data[relptr + r * 10: relptr + r * 10 + 10]))
        for k, rec in enumerate(keep):
            data[relptr + k * 10: relptr + k * 10 + 10] = rec
        struct.pack_into('<H', data, hdr + 32, len(keep))

    print('patch_arm_obj: %s: resolved %d internal B/BL, cleared Thumb flag on %d section(s), left %s'
          % (path, resolved, cleared, ', '.join('%s=%d' % kv for kv in sorted(left.items())) or 'none'))
    for e in errors:
        print('patch_arm_obj: error: ' + e)
    if errors:
        sys.exit(1)
    if not check_only and (resolved or cleared):
        open(path, 'wb').write(data)


if __name__ == '__main__':
    main()
