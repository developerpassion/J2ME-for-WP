# J2ME for Windows Phone

Run J2ME games (MIDP 2.0 / CLDC 1.1 `.jar` / `.jad`) on Windows Phone 8.0, Windows Phone 8.1 and Windows 10 Mobile.

It is a port of Sun's open-source **phoneME Feature** (CLDC-HI VM + MIDP) to the Windows Phone app platforms, with a JIT compiler for ARM.

| App | Platform | Project |
|---|---|---|
| **J2ME Windows 10 Mobile** | Windows 10 Mobile (UWP, C++/CX), build 10586 or later | `Project/W10M/J2MEW10M.sln` |
| **J2ME Windows Phone 8.1** | Windows Phone 8.1 (Silverlight 8.1 + C++ runtime component) | `Project/WP81/J2MEWP81.sln` |
| **J2ME Windows Phone 8** | Windows Phone 8.0 (Silverlight 8.0 + C++ runtime component) | `Project/WP80/J2MEWP80.sln` |

The three apps can be installed side by side.

## Features

- **VM:** CLDC-HI VM with an ARM JIT and AOT-compiled system classes. It falls back to the interpreter if the OS refuses executable memory.
- **Graphics:** MIDP 2.0 LCDUI, game API and RMS. The screen is drawn with Direct3D 11 (feature level 9_1 or higher, so low-end Lumias work), with nearest or smooth scaling.
- **Sound:** WAV, MIDI (built-in synthesizer), tones, and MP3/AMR through Media Foundation where the OS has it.
- **Device APIs:** vibration and backlight.
- **Fonts:** Unicode text (Vietnamese, Chinese and more) drawn with the phone's own fonts.
- **Vendor APIs:** Nokia UI API, plus Samsung, Siemens and Motorola device APIs (vibration/light).
- **Stubs:** JSR 120 (SMS), JSR 75 (file), JSR 82 (Bluetooth) and JSR 184 (M3G) are stubs, so games that only probe for them still start.
- **On-screen keypad:**
  - portrait and landscape layouts;
  - movable in landscape;
  - per-game settings: screen size, scaling, orientation, FPS, heap size.
- **Installing games:**
  - Windows 10 Mobile and 8.1: file picker.
  - 8.0: SD card, opening a `.jar` from e-mail / browser / OneDrive, or upload over Wi-Fi from a PC browser.

## Repository layout

```
phoneME_feature/          phoneME Feature sources (CLDC, MIDP, javacall, pcsl) with the patches this port needs
Project/
  Shared/                 code shared by the three apps
    host/                 VM host API (start/stop, LCD, keys, pointer), OS glue, game library
    javacall_winphone/    javacall port for Windows Phone (LCD, events, timers, files, sockets, sound...)
    render/               Direct3D LCD renderer + shaders
    audio/                MIDI synthesizer
    jvm/, romgen/         generated VM sources and build props (ROM image, interpreter, natives tables)
  W10M/                   Windows 10 Mobile app (C++/CX XAML) + JvmCore static library
  WP81/                   Windows Phone 8.1 Silverlight app (C#) + J2MEWPRuntime (C++ component)
  WP80/                   Windows Phone 8.0 Silverlight app (C#) + runtime (shares most WP81 sources)
  tools/                  scripts that regenerate the VM sources, icons, shaders
```

The generated VM sources (`Project/Shared/jvm`, `Project/Shared/romgen`) are checked in. You only need the phoneME host build (below) if you change the Java classes or the VM itself.

## Building the apps

You need Windows 10 (64-bit) with these tools installed. The paths in the project files assume the default install locations.

| App | Needs |
|---|---|
| Windows 10 Mobile | **Visual Studio 2017** with the *Universal Windows Platform* workload, the C++ ARM compiler (v141) and Windows 10 SDK **10.0.15063** (the minimum target is 10586). SDK **10.0.17763** is used for `signtool` / `fxc`. |
| Windows Phone 8.1 | **Visual Studio 2013** (Update 2 or later, Windows Phone 8.1 SDK: v120 compiler for ARM) and **Visual Studio 2015** (MSBuild 14 and `devenv` to deploy). |
| Windows Phone 8.0 | The above plus **Visual Studio 2012** with the Windows Phone 8.0 SDK (`v110_wp80` toolset). `armasm` from VS2013 is used. |

### Windows 10 Mobile

1. Open `Project/W10M/J2MEW10M.sln` in Visual Studio 2017.
2. Pick **ARM** + **Device** for a phone, or **x86** + **Local Machine** to run on the PC.
3. Build and run (F5).

Command line:

```
"%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\MSBuild.exe" Project\W10M\J2MEW10M.sln /p:Configuration=Release /p:Platform=ARM
```

**Release|ARM** also creates an `.appxbundle` in `Project/W10M/AppPackages/`. It is signed when a signing password file is present (see *Signing* below), otherwise it is left unsigned.

### Windows Phone 8.1 and 8.0

```
"%ProgramFiles(x86)%\MSBuild\14.0\Bin\MSBuild.exe" Project\WP81\J2MEWP81.sln /p:Configuration=Release /p:Platform=ARM
"%ProgramFiles(x86)%\MSBuild\14.0\Bin\MSBuild.exe" Project\WP80\J2MEWP80.sln /p:Configuration=Release /p:Platform=ARM
```

Output: `Project/WP81/App/Bin/ARM/Release/J2MEWP81_Release_ARM.xap` and `Project/WP80/App/Bin/ARM/Release/J2MEWP80_Release_ARM.xap`.

To install on a developer-unlocked phone over USB:

```
"%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" Project\WP81\J2MEWP81.sln /Deploy "Release|ARM"
```

The *Application Deployment* tool of the Windows Phone 8.1 SDK also works. A sideloaded `.xap` does not need to be signed.

Only ARM is supported for the phone apps; there is no x86 emulator build.

## Signing (Windows 10 Mobile)

The app is signed with a self-signed certificate, `CN=J2MEWP`, valid until 2125:

- `Project/W10M/App/Signing/J2MEWP_Sideload.pfx`: the signing key.
- `Project/W10M/App/Signing/J2MEWP_Sideload.cer`: the public certificate. Install it on the phone once, before installing the `.appx`/`.appxbundle`.

The key's password is **not** in the repository. To sign your own builds, create `Project/W10M/App/Signing/Signing.local.props` (it is ignored by git):

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <PackageCertificateKeyFile>$(MSBuildThisFileDirectory)J2MEWP_Sideload.pfx</PackageCertificateKeyFile>
    <PackageCertificatePassword>your password</PackageCertificatePassword>
  </PropertyGroup>
</Project>
```

If you use your own `.pfx`, its subject must match `Publisher` in `Project/W10M/App/Package.appxmanifest`.

To install without Visual Studio, use the phone's Device Portal (*Apps → Install app*):

1. Choose the package.
2. Add `Dependencies\ARM\Microsoft.VCLibs.*.appx`.
3. Add the `.cer` file as the certificate.

## Regenerating the VM sources (optional)

Only needed after changing phoneME Java classes or VM code. It needs:

- Visual Studio 2017 (x86 host compiler);
- a POSIX shell with `make` (Cygwin or MSYS2 / Git Bash);
- JDK 8;
- Python 3.

Steps:

1. Build the host tools and the PC baseline: `Project\tools\build_phoneme_host.bat all`. Use `set CCWRAP=1` first to record the compile commands. Output goes to `Project/out/host/`.
2. x86 sources: `python3 Project/tools/gen_midp_sources.py x86`.
3. ARM sources (interpreter, ROM image with AOT code, soft-float glue, WP8.1/8.0 props): `sh Project/tools/gen_arm_all.sh`.

Other generators:

- `Project/tools/make_app_icons.py`: app icons and splash screens.
- `Project/tools/make_lcd_shaders.sh`: Direct3D shaders.

## Notes and limitations

- **JIT on Windows Phone 8.0/8.1** depends on the OS allowing executable memory for sideloaded apps. When it does not, the VM runs interpreted (slower).
- **The 8.1 / 8.0 apps on 16:9 Windows 10 Mobile phones with on-screen buttons:** Silverlight shows the app as 15:9. When the navigation bar is hidden, the OS leaves a black band that the app cannot detect. Use the Windows 10 Mobile app on those phones.
- **MP3/AMR on Windows Phone 8.0:** not available (no Media Foundation source reader).
- **Not included:** game JARs. Use games you own.
- **Development issues:** the hard bugs hit during the port, with their causes and fixes, are written up in [ISSUES.md](ISSUES.md).

## License

This project is a derivative of **phoneME Feature**, released by Sun Microsystems (now Oracle) under the **GNU General Public License version 2**. This project is distributed under the same license; see [LICENSE](LICENSE).

Java and J2ME are trademarks of Oracle and/or its affiliates. This is a free, non-commercial, unofficial project and is not affiliated with Oracle, Microsoft or any phone or game vendor.
