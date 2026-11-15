#!/bin/sh
# Build phoneME Feature (javacall -> pcsl -> cldc -> midp) for the host PC (win32, VS2017 x86).
# Run through build_phoneme_host.bat (sets up VS2017 + msys + JDK).
#   build_phoneme_host.bat [all|javacall|pcsl|cldc|midp] [extra make args]
# Output: Project/out/host/{javacall,pcsl,cldc,midp}
set -e
STEP=${1:-all}
shift || true

ROOT=$(cd "$(dirname "$0")/../.." && pwd -W)
SRC=$ROOT/phoneME_feature
OUT=$ROOT/Project/out/host

export JDK_DIR=${JDK_DIR:-C:/PROGRA~1/Java/JDK18~1.0_1}
export JAVACALL_DIR=$SRC/javacall
export JAVACALL_OUTPUT_DIR=$OUT/javacall
export PCSL_DIR=$SRC/pcsl
export PCSL_OUTPUT_DIR=$OUT/pcsl
export JVMWorkSpace=$SRC/cldc
export JVMBuildSpace=$OUT/cldc
export CLDC_DIST_DIR=$JVMBuildSpace/javacall_i386_vc/dist
export MIDP_DIR=$SRC/midp
export MIDP_OUTPUT_DIR=$OUT/midp
export TOOLS_DIR=$SRC/tools
export TOOLS_OUTPUT_DIR=$OUT/tools

# Features: MIDP 2.0 (includes the ABB subset of javax.microedition.media: tones + WAV).
# JSR 135 (full MMAPI) off: javacall/implementation/win32/jsr135_mmapi does not match the interface headers.
COMMON="USE_VS2005=true USE_MIDP=true USE_JSR_135=false USE_ABB=true USE_JSR_120=false USE_JSR_177=false USE_JSR_211=false USE_NATIVE_AMS=false USE_STATIC_PROPERTIES=false"

step_javacall() {
  echo "=== javacall"
  make -C $JAVACALL_DIR/configuration/phoneMEFeature/win32_x86 $COMMON "$@"
}
step_pcsl() {
  echo "=== pcsl"
  make -C $PCSL_DIR PCSL_DIR=$PCSL_DIR PCSL_OUTPUT_DIR=$PCSL_OUTPUT_DIR PCSL_PLATFORM=javacall_i386_vc USE_CYGWIN=true $COMMON "$@"
}
step_cldc() {
  echo "=== cldc"
  make -C $JVMWorkSpace/build/javacall_i386_vc VC_MANIFEST_EMBED_EXE=true ENABLE_PCSL=true ENABLE_ISOLATES=true $COMMON "$@"
}
step_midp() {
  echo "=== midp"
  make -C $MIDP_DIR/build/javacall JAVACALL_PLATFORM=win32_i386_vc VC_MANIFEST_EMBED_EXE=true USE_DYNAMIC_PERMISSIONS=false MIDP_DIR=$MIDP_DIR PCSL_OUTPUT_DIR=$PCSL_OUTPUT_DIR CLDC_DIST_DIR=$CLDC_DIST_DIR USE_CYGWIN=true $COMMON "$@"
}

case $STEP in
  all) step_javacall "$@"; step_pcsl "$@"; step_cldc "$@"; step_midp "$@" ;;
  javacall|pcsl|cldc|midp) step_$STEP "$@" ;;
  *) echo "unknown step $STEP"; exit 1 ;;
esac
echo "=== done $STEP"
