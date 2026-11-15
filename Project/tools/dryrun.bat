@echo off
call "F:\Program Files\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvars32.bat" >nul
set "JDK_DIR=C:/PROGRA~1/Java/JDK18~1.0_1"
set "JVMWorkSpace=E:/Projects/J2MEWP/phoneME_feature/cldc"
set "JVMBuildSpace=E:/Projects/J2MEWP/Project/out/cldc_host"
set MSYS2_ARG_CONV_EXCL=*
set "PATH=%VCToolsInstallDir%bin\Hostx86\x86;C:\msys64\usr\bin;%PATH%"
cd /d E:\Projects\J2MEWP\Project\out\cldc_host\win32_i386\target\product
make -n -W E:/Projects/J2MEWP/phoneME_feature/cldc/src/vm/share/utilities/AccessFlags.cpp AccessFlags.obj Interpreter_i386.obj A=
