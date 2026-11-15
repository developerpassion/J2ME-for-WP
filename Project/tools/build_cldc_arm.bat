@echo off
rem Host-side generators for the ARM build of CLDC-HI.
rem   build_cldc_arm.bat romgen   [cfg] -> loopgen.exe + romgen.exe (Project\out\cldc_host\<cfg>)
rem   build_cldc_arm.bat _product [cfg] -> target/product: jvmconfig.h + incls for ARM. The C++ compile
rem                                        uses the x86 cl only to capture commands (ccwrap ->
rem                                        Project\out\arm_gen\compile_db.txt); asm/link failures are expected.
rem cfg: javacall_winphone_arm (default, cpu/arm ARM mode) or javacall_winphone_thumb2 (Thumb-2, ENABLE_ARM_V7=false: no ThumbEE; for WP8.0/8.1). Its compile db goes to Project\out\thumb2_gen.
setlocal
set CLDC_CFG=%2
if "%CLDC_CFG%"=="" set CLDC_CFG=javacall_winphone_arm
for %%I in ("%~dp0..\..") do set "J2ROOT=%%~fI"
set "JAVACALL_OUTPUT_DIR=%J2ROOT:\=/%/Project/out/host/javacall"
set "PCSL_OUTPUT_DIR=%J2ROOT:\=/%/Project/out/host/pcsl"
set "GENDIR=%J2ROOT%\Project\out\arm_gen"
if "%CLDC_CFG%"=="javacall_winphone_thumb2" set "GENDIR=%J2ROOT%\Project\out\thumb2_gen"
if "%1"=="_product" (
  if not exist "%GENDIR%" mkdir "%GENDIR%"
  set "CCWRAP_REAL_DIR=F:\Program Files\Microsoft Visual Studio\2017\Professional\VC\Tools\MSVC\14.16.27023\bin\Hostx86\x86"
  set "CCWRAP_LOG=%GENDIR%\compile_db.txt"
)
call "%~dp0build_cldc_host.bat" %CLDC_CFG% %1 "VC_MANIFEST_EMBED_EXE=true" "ENABLE_PCSL=true" "USE_VS2005=true" -k
exit /b %ERRORLEVEL%
