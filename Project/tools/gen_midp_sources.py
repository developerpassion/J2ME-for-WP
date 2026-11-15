"""
Generate an MSBuild props file that compiles the whole MIDP stack (CLDC-HI VM +
pcsl + MIDP + romized classes) into JvmCore, from the compile commands recorded
by ccwrap during the host build (Project/out/host/compile_db.txt, see
build_phoneme_host.bat with CCWRAP=1).

The PC javacall implementation is NOT taken from the host build: the UWP port
lives in Project/Shared/javacall_winphone and is added here explicitly.

Host-generated files (ROMImage, jvmconfig.h, incls/, pcsl/javacall headers...)
are copied from Project/out/host/** to Project/Shared/romgen/<arch>_midp/** so
the VS solution builds without the host build tree.

Usage: python3 gen_midp_sources.py [x86|arm|thumb2]

arm (cpu/arm, ARM mode, cfg javacall_winphone_arm): CLDC compile list +
jvmconfig/incls come from the ARM target step (Project/out/arm_gen/compile_db.txt,
build_cldc_arm.bat _product); pcsl/MIDP from the x86 db (portable C);
ROMImage*/ROMStructs.h from the ARM romgen run in Project/out/arm_gen/midp;
interpreter = Shared/romgen/arm/Interpreter_arm.asm. CLDC sources force-include
host/arm_softfp_rename.h (hard-float/softfp bridge, gen_arm_softfp.py).
Output: Project/Shared/jvm/midp_<arch>.props
"""
import os, re, shutil, sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')).replace('\\', '/')
HOST = ROOT + '/Project/out/host'
PHONEME = ROOT + '/phoneME_feature'
SHARED = ROOT + '/Project/Shared'
arch = sys.argv[1] if len(sys.argv) > 1 else 'x86'
GEN = SHARED + '/romgen/%s_midp' % arch
DB = HOST + '/compile_db.txt'
OUT = ROOT + '/Project/out'
# arm (cpu/arm, ARM mode: W10M) or thumb2 (cpu/thumb2 without ThumbEE, Thumb-2 only:
# WP8.0/8.1, whose kernels do not run ARM-mode user code reliably)
IS_ARM = arch in ('arm', 'thumb2')
T2GEN = OUT + ('/thumb2_gen' if arch == 'thumb2' else '/arm_gen')
T2DB = T2GEN + '/compile_db.txt'
T2ROM = T2GEN + '/midp'
ARMCFG = 'javacall_winphone_thumb2' if arch == 'thumb2' else 'javacall_winphone_arm'
CPUDIR = 'thumb2' if arch == 'thumb2' else 'arm'

def norm(p):
    p = p.replace('\\', '/')
    m = re.match(r'^/([a-zA-Z])/(.*)$', p)          # msys /e/... -> E:/...
    if m:
        p = m.group(1).upper() + ':/' + m.group(2)
    return os.path.normpath(p).replace('\\', '/')

def split_cmdline(s):
    """CommandLineToArgvW-style splitting."""
    args, cur, inq, i, have = [], [], False, 0, False
    while i < len(s):
        c = s[i]
        if c == '\\':
            j = i
            while j < len(s) and s[j] == '\\':
                j += 1
            n = j - i
            if j < len(s) and s[j] == '"':
                cur.append('\\' * (n // 2))
                if n % 2:
                    cur.append('"'); i = j + 1
                else:
                    i = j
                have = True
                continue
            cur.append('\\' * n); i = j; have = True; continue
        if c == '"':
            if inq and i + 1 < len(s) and s[i + 1] == '"':
                cur.append('"'); i += 2; continue
            inq = not inq; i += 1; have = True; continue
        if c in ' \t' and not inq:
            if have or cur:
                args.append(''.join(cur)); cur = []; have = False
            i += 1; continue
        cur.append(c); i += 1; have = True
    if have or cur:
        args.append(''.join(cur))
    return args

def component(cwd, out_obj):
    key = (out_obj or cwd).lower()
    if '/out/host/midp/' in key + '/':
        return 'midp'
    if '/out/host/pcsl/' in key + '/':
        return 'pcsl'
    if '/javacall_i386_vc/target/product' in key:
        return 'cldc_x86'
    if '/javacall_winphone_arm/target/product' in key:
        return 'cldc_arm'
    if '/javacall_winphone_thumb2/target/product' in key:
        return 'cldc_thumb2'
    return None

SKIP_FLAG = re.compile(r'^[-/](c|nologo|W\d|WX|O\w*|G\w*|M[DT]d?|Zm\d+|Zi|Z7|Fd.*|Fp.*|Yc.*|Yu.*|TC|TP|EHsc|wd\d+|experimental:.*|Fe.*|Fa.*|FR.*|Fr.*)$')

entries = {}
_raw = open(DB, 'rb').read(4096)
_enc = 'utf-16-le' if (_raw[:2] == b'\xff\xfe' or (len(_raw) > 1 and _raw[1] == 0)) else 'utf-8'   # ccwrap writes UTF-16 without BOM
def _db_lines(db):
    raw = open(db, 'rb').read(4096)
    enc = 'utf-16-le' if (raw[:2] == bytes([0xff, 0xfe]) or (len(raw) > 1 and raw[1] == 0)) else 'utf-8'
    return open(db, encoding=enc, errors='replace').readlines()
for line in _db_lines(DB) + (_db_lines(T2DB) if IS_ARM else []):
    parts = line.rstrip('\r\n').split('\t', 2)
    if len(parts) != 3:
        continue
    tool, cwd, cmd = parts
    tool = tool.lower()
    cwd = norm(cwd)
    args = split_cmdline(cmd)
    if any(a in ('/P', '-P', '/E', '-E', '/EP', '-EP') for a in args):
        continue                                    # preprocess-only runs
    incs, defs, srcs, out_obj, extra = [], [], [], None, []
    i = 0
    while i < len(args):
        a = args[i]
        if re.match(r'^[-/]I$', a):
            incs.append(norm(os.path.join(cwd, args[i + 1]))); i += 2; continue
        if re.match(r'^[-/]I', a):
            incs.append(norm(os.path.join(cwd, a[2:]))); i += 1; continue
        if re.match(r'^[-/]D$', a):
            defs.append(args[i + 1]); i += 2; continue
        if re.match(r'^[-/]D', a):
            defs.append(a[2:]); i += 1; continue
        if re.match(r'^[-/]Fo', a):
            out_obj = norm(os.path.join(cwd, a[3:])); i += 1; continue
        if tool == 'ml.exe' and re.match(r'^[-/]Fo$', a):
            out_obj = norm(os.path.join(cwd, args[i + 1])); i += 2; continue
        if not a.startswith('-') and not a.startswith('/') and re.search(r'\.(c|cpp|asm)$', a, re.I):
            srcs.append(norm(os.path.join(cwd, a))); i += 1; continue
        if a.startswith('/') and re.search(r'\.(c|cpp|asm)$', a, re.I) and os.path.exists(norm(a)):
            srcs.append(norm(a)); i += 1; continue
        if SKIP_FLAG.match(a):
            i += 1; continue
        extra.append(a); i += 1
    for src in srcs:
        obj = out_obj
        if obj is None or obj.endswith('/'):
            obj = (obj or cwd + '/') + os.path.splitext(os.path.basename(src))[0] + '.obj'
        comp = component(cwd, obj)
        if comp is None:
            continue
        if comp.startswith('cldc_'):
            if comp != ('cldc_' + arch if IS_ARM else 'cldc_x86'):
                continue
            comp = 'cldc'
        entries[(comp, os.path.basename(obj).lower())] = dict(
            comp=comp, src=src, incs=incs, defs=defs, tool=tool, extra=extra)

# ---- objects built on the host but missing from compile_db -------------------
# (a few cl commands were not captured by ccwrap). Find the source under
# midp/src by name and borrow include dirs / defines from another MIDP file.
_midp_obj = HOST + '/midp/obj/i386'
if os.path.isdir(_midp_obj):
    _ref = max((e for k, e in entries.items() if k[0] == 'midp' and e['tool'] == 'cl.exe'),
               key=lambda e: len(e['incs']), default=None)
    _src_index = {}
    for dp, dn, fn in os.walk(PHONEME + '/midp/src'):
        for f in fn:
            if f.endswith('.c'):
                _src_index.setdefault(f.lower(), []).append(dp.replace(os.sep, '/') + '/' + f)
    for f in sorted(os.listdir(_midp_obj)):
        if not f.endswith('.o') or ('midp', f.lower()) in entries or _ref is None:
            continue
        cands = _src_index.get(f[:-2].lower() + '.c', [])
        if len(cands) != 1:
            if cands:
                print('WARNING: ambiguous source for', f, cands)
            continue
        e = dict(_ref); e['src'] = cands[0]
        e['incs'] = [os.path.dirname(os.path.dirname(cands[0])) + '/include'] + list(_ref['incs'])
        entries[('midp', f.lower())] = e
        print('recovered', f, '->', cands[0])

# ---- objects that were really linked into runMidlet ---------------------------
EXCLUDE = {
    # (midp runMidlet.o is kept: it defines runMidlet(), main() lives in javacall)
    ('cldc', 'main_javacall.obj'),
    # MIDP has its own romized image (CLDC + MIDP classes) and natives table;
    # on the PC they won over cldc_vm.lib's copies at link time.
    ('cldc', 'romimage.obj'),
    ('cldc', 'nativestable.obj'),
}
by_comp = {}
for k, e in entries.items():
    if k in EXCLUDE:
        continue
    by_comp.setdefault(e['comp'], []).append(e)
for c in by_comp:
    by_comp[c].sort(key=lambda e: e['src'])

# ---- copy host-generated files into Shared/romgen/<arch>_midp -----------------
if os.path.isdir(GEN):
    shutil.rmtree(GEN)

ROM_OVERRIDE = re.compile(r'^(ROMImage.*[.](cpp|hpp)|ROMStructs[.]h|JniAdapters[.]cpp|KvmNatives[.]cpp)$', re.I)

def _copy(sp, dst):
    # arm: the romized image comes from the ARM romgen, not the x86 MIDP build
    f = os.path.basename(sp)
    if IS_ARM and ROM_OVERRIDE.match(f) and os.path.isfile(T2ROM + '/' + f)             and sp.lower().startswith((HOST + '/midp/').lower()):
        sp = T2ROM + '/' + f
    # arm: MIDP natives include CLDC's dist/include -> use ARM config headers
    if IS_ARM and '/javacall_i386_vc/dist/include/' in sp.lower():
        if f.lower() == 'jvmconfig.h':
            sp = OUT + '/cldc_host/' + ARMCFG + '/target/generated/jvmconfig.h'
        elif f.lower() == 'kni_md.h':
            sp = PHONEME + '/cldc/src/vm/cpu/' + CPUDIR + '/kni_md.h'
    shutil.copy2(sp, dst)

def mirror(path):
    """Map a path under Project/out to the copy in Shared/romgen; copy on demand."""
    if path.lower().startswith(HOST.lower() + '/'):
        rel = path[len(HOST) + 1:]
    elif path.lower().startswith(OUT.lower() + '/'):
        rel = path[len(OUT) + 1:]
    else:
        return path
    dst = GEN + '/' + rel
    if os.path.isdir(path):
        if not os.path.isdir(dst):
            os.makedirs(dst, exist_ok=True)
            for f in os.listdir(path):
                sp = path + '/' + f
                if os.path.isfile(sp) and re.search(r'\.(h|hpp|incl|inc|c|cpp|asm)$', f, re.I):
                    _copy(sp, dst + '/' + f)
            for sub in ('incls',):
                if os.path.isdir(path + '/' + sub):
                    shutil.copytree(path + '/' + sub, dst + '/' + sub, dirs_exist_ok=True)
    elif os.path.isfile(path):
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        _copy(path, dst)
    return dst

def msb(path):
    """Absolute path -> MSBuild path with macros."""
    path = mirror(path)
    for base, macro in ((SHARED + '/', '$(J2MESharedDir)'), (PHONEME + '/', '$(PhoneMERoot)')):
        if path.lower().startswith(base.lower()):
            return macro + path[len(base):].replace('/', '\\')
    return path.replace('/', '\\')

DROP_DEFS = re.compile(r'^(_DEBUG|NDEBUG|RELEASE=.*|FULL_VERSION=.*|IMPL_VERSION=.*)$')

def xml(s):
    return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace('"', '&quot;')

JC = SHARED + '/javacall_winphone'
JC_INC = [JC + '/inc', JC + '/src', JC + '/src/midp', JC + '/src/common', JC + '/src/share',
          JC + '/src/share/prop_inc', JC + '/src/share/util_inc']
jc_srcs = []
for d in ('src/common', 'src/midp', 'src/share'):
    for f in sorted(os.listdir(JC + '/' + d)):
        # cldc_javanotify_stubs.c is for the CLDC-only stack: its empty JavaTask()
        # and javanotify_* stubs would shadow MIDP's real ones.
        if f.endswith('.c') and f != 'cldc_javanotify_stubs.c':
            jc_srcs.append(JC + '/' + d + '/' + f)

out = SHARED + '/jvm/midp_%s.props' % arch
lines = ['<?xml version="1.0" encoding="utf-8"?>',
         '<!-- GENERATED by Project/tools/gen_midp_sources.py from Project/out/host/compile_db.txt. Do not edit. -->',
         '<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">',
         '  <ImportGroup Label="ExtensionSettings">',
         '    <Import Project="$(VCTargetsPath)\\BuildCustomizations\\%s.props" />' % ('marmasm' if IS_ARM else 'masm'),
         '  </ImportGroup>',
         '  <ItemDefinitionGroup>',
         '    <ClCompile>',
         '      <AdditionalOptions>/experimental:preprocessor /wd5105 /U_DEBUG /Zm1000 %(AdditionalOptions)</AdditionalOptions>',
         '      <DisableSpecificWarnings>4996;4005;4244;4267;4800;4291;4355;4018;4146;4302;4311;4312;4838;4309;4133;4047;4024;4013;4022;4090;4101;4113;%(DisableSpecificWarnings)</DisableSpecificWarnings>',
         '      <PreprocessorDefinitions>J2MEWP_HAS_VM=1;J2MEWP_HAS_MIDP=1;%(PreprocessorDefinitions)</PreprocessorDefinitions>',
         '    </ClCompile>',
         '  </ItemDefinitionGroup>',
         '  <ItemGroup>']

def add_item(src, incs, defs, comp, obj_name):
    defs = [d for d in defs if not DROP_DEFS.match(d)] + ['_CRT_SECURE_NO_WARNINGS', '_WINSOCK_DEPRECATED_NO_WARNINGS']
    seen, inc_list = set(), []
    for p in incs:
        m = msb(p)
        if m.lower() not in seen:
            seen.add(m.lower()); inc_list.append(m)
    lines.append('    <ClCompile Include="%s">' % xml(msb(src)))
    lines.append('      <AdditionalIncludeDirectories>%s;%%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>' % xml(';'.join(inc_list)))
    lines.append('      <PreprocessorDefinitions>%s;%%(PreprocessorDefinitions)</PreprocessorDefinitions>' % xml(';'.join(defs)))
    if IS_ARM and comp == 'cldc':
        lines.append('      <ForcedIncludeFiles>$(J2MESharedDir)host\\arm_softfp_rename.h;%(ForcedIncludeFiles)</ForcedIncludeFiles>')
    if IS_ARM and obj_name == 'ROMImage':
        # AOT code lives in const _rom_text_block*: keep it in an executable section (.romtx, linked ER).
        lines.append('      <ForcedIncludeFiles>$(J2MESharedDir)host\\rom_exec_section.h;%(ForcedIncludeFiles)</ForcedIncludeFiles>')
    lines.append('      <ObjectFileName>$(IntDir)%s\\%s.obj</ObjectFileName>' % (comp, obj_name))
    lines.append('    </ClCompile>')

PCSL_INC = sorted({p for k, e in entries.items() if k[0] == 'pcsl' for p in e['incs'] if '/out/host/pcsl' in p.lower() and p.lower().endswith('/inc')})
counts = {}
asm = []
for comp in ('cldc', 'pcsl', 'midp'):
    for e in by_comp.get(comp, []):
        name = os.path.splitext(os.path.basename(e['src']))[0]
        if e['tool'] == 'ml.exe' or e['src'].lower().endswith('.asm'):
            asm.append(e); continue
        incs = list(e['incs'])
        # javacall headers come from the UWP port, not the PC build output
        incs = [p for p in incs if '/out/host/javacall' not in p.lower()] + JC_INC
        if comp == 'cldc' and IS_ARM:
            incs += PCSL_INC
        add_item(e['src'], incs, e['defs'], comp, name)
        counts[comp] = counts.get(comp, 0) + 1

midp_defs = by_comp['midp'][0]['defs'] if by_comp.get('midp') else []
for src in jc_srcs:
    add_item(src, JC_INC, ['WIN32', 'ENABLE_MULTIPLE_INSTANCES=1', 'USE_PROPERTIES_FROM_FS',
                           'ENABLE_NATIVE_AMS=0', 'ENABLE_NATIVE_AMS_UI=0', 'ENABLE_ON_DEVICE_DEBUG=0'],
             'javacall', os.path.splitext(os.path.basename(src))[0])
counts['javacall'] = len(jc_srcs)

if IS_ARM:
    lines.append('    <ClCompile Include="$(J2MESharedDir)host\\%s_softfp_glue.c" />' % arch)
for extra in ('host/jvm_host_vm.cpp', 'host/os_uwp_memory.cpp'):
    lines.append('    <ClCompile Include="$(J2MESharedDir)%s">' % extra.replace('/', '\\'))
    cldc0 = by_comp['cldc'][0]
    incs = [msb(p) for p in cldc0['incs']] + [msb(p) for p in JC_INC]
    lines.append('      <AdditionalIncludeDirectories>%s;%%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>' % xml(';'.join(incs)))
    lines.append('      <PreprocessorDefinitions>%s;%%(PreprocessorDefinitions)</PreprocessorDefinitions>' % xml(';'.join(d for d in cldc0['defs'] if not DROP_DEFS.match(d))))
    lines.append('    </ClCompile>')

lines.append('  </ItemGroup>')
lines.append('  <ItemGroup>')
if IS_ARM:
    lines.append('    <MARMASM Include="$(J2MESharedDir)romgen\\%s\\Interpreter_%s.asm" />' % (arch, arch))
else:
    for e in asm:
        lines.append('    <MASM Include="%s" />' % xml(msb(e['src'])))
lines.append('  </ItemGroup>')
if arch == 'arm':   # thumb2: all Thumb code, nothing to patch
    lines += ['  <!-- link.exe treats armasm B/BL relocations as Thumb and routes ARM code through Thumb', '       thunks/ILT (crash C000001D on the phone). Resolve internal branches in the obj. -->', '  <Target Name="J2MEWPPatchArmObj" AfterTargets="_MARMASM" Condition="\'$(Platform)\'==\'ARM\'">', '    <Exec Command="python3 &quot;$(J2MESharedDir)..\\tools\\patch_arm_obj.py&quot; &quot;$(IntDir)Interpreter_arm.obj&quot;" />', '  </Target>']
lines.append('</Project>')
open(out, 'w', newline='\r\n').write('\n'.join(lines) + '\n')
print('wrote', out, counts, 'asm', len(asm))
print('generated files copied to', GEN)
