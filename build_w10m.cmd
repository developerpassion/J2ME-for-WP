@echo off
rem Build the Windows 10 Mobile app (Release, ARM) and create a SIGNED .appx.
rem   build_w10m.cmd          -> Project\W10M\AppPackages\J2MEW10M\J2MEW10M_*_ARM_Test\
rem Signing uses Project\W10M\App\Signing\J2MEWP_Sideload.pfx with the password in
rem Signing.local.props next to it. Install J2MEWP_Sideload.cer on the phone once.
rem Needs Visual Studio 2017 (MSBuild 15) with the UWP workload and SDK 10.0.15063.
setlocal
set "ROOT=%~dp0"
set "SIGNDIR=%ROOT%Project\W10M\App\Signing"

if not exist "%SIGNDIR%\Signing.local.props" (
  echo [warn] %SIGNDIR%\Signing.local.props not found: the package will NOT be signed.
)

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" (
  echo vswhere.exe not found. Install Visual Studio 2017.
  exit /b 1
)
set "VS2017="
for /f "usebackq delims=" %%i in (`"%VSWHERE%" -version [15.0^,16.0^) -latest -property installationPath`) do set "VS2017=%%i"
if not defined VS2017 (
  echo Visual Studio 2017 not found ^(needed for the W10M app^).
  exit /b 1
)
set "MSBUILD=%VS2017%\MSBuild\15.0\Bin\MSBuild.exe"
if not exist "%MSBUILD%" (
  echo MSBuild not found: %MSBUILD%
  exit /b 1
)

"%MSBUILD%" "%ROOT%Project\W10M\J2MEW10M.sln" /p:Configuration=Release /p:Platform=ARM /m /v:m /nologo
if errorlevel 1 (
  echo Build failed.
  exit /b 1
)

echo.
echo Done. Package folder: %ROOT%Project\W10M\AppPackages
echo Install %SIGNDIR%\J2MEWP_Sideload.cer on the phone once, then the .appx
echo ^(with Dependencies\ARM\Microsoft.VCLibs.*.appx from the same folder^).
endlocal
