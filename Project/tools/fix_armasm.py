#!/usr/bin/env python3
"""Convert phoneME loopgen output (ADS-style, cpu/arm or cpu/thumb2) to Microsoft armasm syntax.

Usage: python3 fix_armasm.py <in Interpreter_<arch>.asm> <out .asm>

cpu/arm output has no THUMB/ARM directive; VS armasm defaults to THUMB, so
"ARM" is inserted after every CODE AREA.

armasm (VS2017, ARM32) differences handled here:
  REQUIRE8 / PRESERVE8      -> dropped (not supported, MS ABI is 8-byte aligned anyway)
  cmps rX, #imm             -> cmp rX, #imm  (UAL: CMP always sets flags)
  swi imm                   -> svc #imm      (pre-UAL mnemonic rejected in THUMB)
  .short x                  -> DCW x         (GNU directive leaked from SourceMacros)
"""
import re
import sys

src, dst = sys.argv[1], sys.argv[2]
out = []
n = {"req": 0, "cmps": 0, "swi": 0, "short": 0}
with open(src, "r", encoding="latin-1") as f:
    for line in f:
        s = line.strip()
        if s in ("REQUIRE8", "PRESERVE8"):
            n["req"] += 1
            continue
        m = re.match(r"^(\s*)cmps(\s)", line)
        if m:
            line = m.group(1) + "cmp" + line[m.end(1) + 4:]
            n["cmps"] += 1
        m = re.match(r"^(\s*)swi\s+(0x[0-9a-fA-F]+|\d+)(.*)$", line.rstrip("\n"))
        if m:
            line = "%ssvc\t#%s%s\n" % (m.group(1), m.group(2), m.group(3))
            n["swi"] += 1
        m = re.match(r"^(\s*)\.short(\s.*)$", line.rstrip("\n"))
        if m:
            line = "%sDCW%s\n" % (m.group(1), m.group(2))
            n["short"] += 1
        # The generated arm_flush_icache uses a Linux swi / privileged cp15
        # ops. Rename it; the OS layer defines arm_flush_icache(addr, size)
        # in C with FlushInstructionCache().
        if re.match(r"^\s*EXPORT\s+arm_flush_icache\s*$", line):
            line = line.replace("arm_flush_icache", "linux_arm_flush_icache_unused")
            n["flush"] = n.get("flush", 0) + 1
        elif re.match(r"^arm_flush_icache\b", line):
            line = line.replace("arm_flush_icache", "linux_arm_flush_icache_unused", 1)
        out.append(line)

# ARM-mode file (cpu/arm): armasm for Windows defaults to THUMB.
if not any(l.strip() == "THUMB" for l in out):
    res = []
    for line in out:
        res.append(line)
        if re.match(r"^\s*AREA\s.*\bCODE\b", line):
            res.append("\tARM\n")
            n["arm"] = n.get("arm", 0) + 1
    out = res

# DCD tables reference C symbols (jvm_memcpy, ...) without IMPORT: add them.
defined, imported, used = set(), set(), []
for line in out:
    m = re.match(r"^([A-Za-z_]\w*)", line)
    if m:
        defined.add(m.group(1))
    m = re.match(r"^\s*(IMPORT|EXPORT)\s+(\w+)", line)
    if m and m.group(1) == "IMPORT":
        imported.add(m.group(2))
    m = re.match(r"^\s*DCD\s+([A-Za-z_]\w*)\s*(;.*)?$", line)
    if m:
        used.append(m.group(1))
missing = sorted(set(u for u in used if u not in defined and u not in imported))
if missing:
    for i, line in enumerate(out):
        if line.strip().startswith("AREA"):
            out[i + 1:i + 1] = ["\tIMPORT\t%s\n" % s for s in missing]
            break
n["imports"] = missing

# Tail calls "b <C function>": link.exe cannot turn a B into an interworking
# branch (only BL -> BLX), so ARM code would enter Thumb C code in ARM state.
# Use "ldr pc, =sym" (interworking load) + a literal pool right after it.
imported |= set(missing)
res = []
for line in out:
    m = re.match(r"^(\s*)b(?:al)?\s+([A-Za-z_]\w*)\s*(;.*)?$", line.rstrip("\n"))
    if m and m.group(2) in imported:
        res.append("%sldr\tpc, =%s\n" % (m.group(1), m.group(2)))
        res.append("%sLTORG\n" % m.group(1))
        n["tailcall"] = n.get("tailcall", 0) + 1
        continue
    res.append(line)
out = res

with open(dst, "w", encoding="latin-1", newline="\n") as f:
    f.writelines(out)
print("fix_thumb2_asm: %s -> %s %s" % (src, dst, n))
