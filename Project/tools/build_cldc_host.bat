@echo off
rem Build phoneME CLDC-HI MR4 for the host (VS2017 x86, msys make, JDK 8).
rem Output: Project\out\cldc_host\PLATFORM\
rem Usage: build_cldc_host.bat PLATFORM MAKE_ARGS
setlocal
set CLDC_PLATFORM=%1
if "%CLDC_PLATFORM%"=="" set CLDC_PLATFORM=win32_i386

for %%I in ("%~dp0..\..") do set "J2ROOT=%%~fI"

call "F:\Program Files\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars32.bat" >nul
where cl.exe >nul 2>&1
if errorlevel 1 (
  echo build_cldc_host: cl.exe not found after vcvars32
  exit /b 1
)

set "JDK_DIR=C:/PROGRA~1/Java/JDK18~1.0_1"
set "JVMWorkSpace=%J2ROOT:\=/%/phoneME_feature/cldc"
set "JVMBuildSpace=%J2ROOT:\=/%/Project/out/cldc_host"
set "PATH=%VCToolsInstallDir%bin\Hostx86\x86;C:\msys64\usr\bin;C:\Program Files\Java\jdk1.8.0_121\bin;%PATH%"

rem CCWRAP_LOG set by caller (build_cldc_thumb2.bat): record cl/ml commands
if defined CCWRAP_LOG set "PATH=%~dp0ccwrap\bin;%PATH%"
cd /d "%J2ROOT%\phoneME_feature\cldc\build\%CLDC_PLATFORM%"
if errorlevel 1 exit /b 1
rem MSVC conforming preprocessor: phoneME macros rely on standard rescanning (JVM_CHECK / _IGNORE_ME_)
set "CL=/experimental:preprocessor /wd5105 %CL%"
rem msys must not rewrite cl.exe /flags into paths
set MSYS2_ARG_CONV_EXCL=*
echo JVMWorkSpace=%JVMWorkSpace%
echo JVMBuildSpace=%JVMBuildSpace%
make %2 %3 %4 %5 %6 %7 %8 %9
exit /b %ERRORLEVEL%
