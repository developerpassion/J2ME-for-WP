@echo off
rem Build phoneME Feature (javacall, pcsl, cldc, midp) for the host PC.
rem Usage: build_phoneme_host.bat STEP MAKE_ARGS   (STEP = all, javacall, pcsl, cldc, midp)
setlocal
call "F:\Program Files\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars32.bat" >nul
where cl.exe >nul 2>&1
if errorlevel 1 (
  echo build_phoneme_host: cl.exe not found after vcvars32
  exit /b 1
)
rem MSVC bin first: msys coreutils "link" would shadow link.exe
set "PATH=%VCToolsInstallDir%bin\Hostx86\x86;C:\msys64\usr\bin;C:\Program Files\Java\jdk1.8.0_121\bin;%PATH%"
rem msys must not rewrite cl.exe /flags into paths
set MSYS2_ARG_CONV_EXCL=*
rem conforming preprocessor: phoneME macros rely on standard rescanning
set "CL=/experimental:preprocessor /wd5105 %CL%"
rem CCWRAP=1: record every cl/ml command into Project\out\host\compile_db.txt (see ccwrap\ccwrap.c)
if "%CCWRAP%"=="1" (
  set "CCWRAP_REAL_DIR=%VCToolsInstallDir%bin\Hostx86\x86"
  set "CCWRAP_LOG=%~dp0..\out\host\compile_db.txt"
  set "PATH=%~dp0ccwrap\bin;%PATH%"
)
sh "%~dp0build_phoneme_host.sh" %*
exit /b %ERRORLEVEL%
