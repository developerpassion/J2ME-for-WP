#!/bin/sh
# Regenerate everything the ARM JvmCore needs (cpu/arm, ARM mode + JIT), from scratch:
#   1. loopgen + romgen (cfg javacall_winphone_arm)  (Project/out/cldc_host/javacall_winphone_arm)
#   2. Interpreter_arm.asm (armasm syntax)          -> Project/Shared/romgen/arm
#   3. ARM ROMImage of the MIDP classes (AOT)        (Project/out/arm_gen/midp)
#   4. target/product: jvmconfig.h, incls, compile db (Project/out/arm_gen/compile_db.txt)
#   4b. hard-float/softfp bridge                     -> Project/Shared/host/arm_softfp_*
#   5. gen_midp_sources.py arm                -> Project/Shared/jvm/midp_arm.props + romgen/arm_midp
#   6. gen_wp81_props.py                      -> Project/Shared/jvm/midp_arm_wp81.props (WP8.1, VS2013 v120)
# Prerequisite: x86 host build (build_phoneme_host.bat all, CCWRAP=1) for pcsl/MIDP classes + db.
# Run from Git Bash: sh Project/tools/gen_arm_all.sh
set -e
ROOT=$(cd "$(dirname "$0")/../.." && pwd -W)
TOOLS="$ROOT/Project/tools"
OUT="$ROOT/Project/out"
T2="$OUT/cldc_host/javacall_winphone_arm"
GEN="$OUT/arm_gen"
H="$OUT/host"

rm -rf "$T2" "$GEN"
mkdir -p "$GEN/midp"

echo "=== 1. loopgen + romgen"
cmd //c "$(cygpath -w "$TOOLS/build_cldc_arm.bat") romgen" > "$TOOLS/arm_romgen.log" 2>&1 \
  || { tail -20 "$TOOLS/arm_romgen.log"; exit 1; }

echo "=== 2. interpreter"
(cd "$GEN" && "$T2/loopgen/app/loopgen.exe" -generateoptimized \
    -GenerateGNUCode +GenerateMicrosoftCode +GenerateThumbInterwork +AddExternCUnderscore > loopgen.log 2>&1)
mkdir -p "$ROOT/Project/Shared/romgen/arm"
python3 "$TOOLS/fix_armasm.py" "$GEN/Interpreter_arm.asm" "$ROOT/Project/Shared/romgen/arm/Interpreter_arm.asm"

echo "=== 3. ROMImage (MIDP classes, AOT)"
(cd "$GEN/midp" && "$T2/dist/bin/romgen.exe" -romconfig "$H/midp/generated/rom_configs.lst" \
    +GenerateROMStructs +EnableROMCompilation +EnableAllROMOptimizations \
    -cp "$H/midp/classes.zip" -romize =HeapCapacity96M \
    -romincludepath "$T2/dist/lib" -romincludepath "$ROOT/phoneME_feature/midp/build/common/config" \
    > romgen.log 2>&1) || { tail -5 "$GEN/midp/romgen.log"; echo "romgen failed"; exit 1; }
tail -1 "$GEN/midp/romgen.log"

echo "=== 4. target/product headers + compile db (asm/link errors expected)"
cmd //c "$(cygpath -w "$TOOLS/build_cldc_arm.bat") _product" > "$TOOLS/arm_product.log" 2>&1 || true
test -f "$T2/target/generated/jvmconfig.h"
test -s "$GEN/compile_db.txt"

python3 "$TOOLS/gen_arm_softfp.py"

echo "=== 5. MSBuild props"
python3 "$TOOLS/gen_midp_sources.py" arm | tail -1
python3 "$TOOLS/gen_wp81_props.py"
echo "=== done"
