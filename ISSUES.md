# Development issues and fixes

Notes on the hard problems hit while porting phoneME Feature (CLDC-HI + MIDP) to Windows Phone, kept so they are not rediscovered. Newest first.

| Platform tag | Meaning |
|---|---|
| **W10M** | Windows 10 Mobile app (VM `cpu/arm`, ARM mode) |
| **WP8.x** | Windows Phone 8.0 / 8.1 apps (VM `cpu/thumb2`, pure Thumb-2) |
| **all** | shared code |

---

## WP8.x: `Thread.sleep()` never returns (game stuck on a black screen)

**Symptom.** Mr Bean Racer 2 stayed black on WP8.0. A Java thread dump always showed the game thread in `Thread.sleep() bci=0`, and the VM kept asking the platform to wait about 101 ms. It happened with the JIT on and in interpreter-only mode (`-int`).

**Cause.** `BinaryAssembler::ldr_address(rd, 0)` in `cpu/thumb2` looks for a gp-table slot whose value equals the target and loads from it. For target `0`, the first zero slot is a *variable*, `_rt_timer_ticks` (gp+92), not a constant. So every "load 0" emitted by the Thumb-2 compiler (JIT and the AOT-compiled ROM) really loaded the current timer-tick count. The compiled native-call stub clears `Thread::async_redo` with that "zero", so the flag got the tick count. The invoke-native code then saw `async_redo != 0` and re-ran the native forever. `ldr_oop(rd, null)` goes through the same path.

**Fix.** `ldr_address` emits `movw rd, #0` for a zero target. Then regenerate the Thumb-2 ROM image (romgen + `gen_midp_sources.py thumb2`), because the AOT code in the ROM carries the bug.

**How it was found.**
1. A minimal MIDlet (`Project/tools/test/fccheck`) reproduced the start-up pattern.
2. The thread dump printed each thread's `wakeup_time - now`, and the wake-up time kept being reset.
3. Logging the `sleep` native showed `async_redo` growing about 33 times a second, which matches the 30 ms VM tick, and always equal to `_rt_timer_ticks`.

## WP8.x: illegal instruction (`C000001D`) in ARM-mode code

**Symptom.** On a real WP8.0 phone the app crashed as soon as a game started, inside A32 (ARM-mode) assembly such as `jvm_memcpy`, even when called correctly through an interworking thunk. The same VM works on Windows 10 Mobile.

**Cause.** Not proven. User-mode ARM-state code does not run reliably on the WP8.x kernel.

**Fix.** WP8.0/8.1 use the `cpu/thumb2` port built with `ENABLE_ARM_V7=false`. All ThumbEE instructions (`enterx/leavex`, `hb`, `chka`) are behind that flag, so the interpreter, JIT and AOT code are pure Thumb-2. Config: `cldc/build/javacall_winphone_thumb2`.

The Thumb-2 port is less mature than `cpu/arm`. Some code is still under `#if 0 // BEGIN_CONVERT_TO_T2`. Expect more bugs like the one above.

## W10M: `C000001D` right after `MIDLET_STARTED` (link.exe and A32 code)

**Cause.** The Windows `armasm` leaves a `BRANCH24` relocation on every `B`/`BL` and marks the section as Thumb (`IMAGE_SCN_MEM_16BIT`, warning A4238), even with the `ARM` directive. `link.exe` then treats the targets as Thumb code and inserts Thumb thunks or incremental-link padding. ARM code jumps into that padding and crashes. With incremental linking off, the linker instead reports about 80 `LNK2013 BRANCH24(A) fixup overflow` / `LNK2008` errors. Two tail calls (`b jvm_f2d_internal`, `b jvm_d2f_internal`) from ARM code into Thumb C functions were also wrong.

**Fix.** `Project/tools/patch_arm_obj.py` runs after `armasm` and fixes the object: clears the Thumb section flag and resolves the internal branches. `fix_armasm.py` adds `ARM` after each `AREA ... CODE` (the Windows `armasm` defaults to Thumb). A crash logger (vectored exception handler, `[crash]` lines in `j2me.log`) helps with post-mortems.

## W10M: JIT code jumps to garbage with a large heap

**Cause.** `CodeGenerator::call_through_gp` (`cpu/arm`) used `bl` to reach glue code. `BL` reaches only ±32 MB, and with a 256 MB heap the JIT code area is further away than that.

**Fix.** Use `bl` only when the glue is less than 31 MB from `compiler_area_end`. Otherwise call indirectly through the gp table.

## W10M 10586: launch crash `0xC0000135` (DLL not found)

**Cause.** The binary imported `kernel32.dll` directly (from `kernel32.lib`). Also, SDK 15063 `WindowsApp.lib` binds `VirtualAllocFromApp` / `VirtualProtectFromApp` to `api-ms-win-core-memory-l1-1-5`. Build 10586 (for example the Lumia 650) has neither. Newer builds hide the problem.

**Fix.** Link the 10586 SDK `mincore.lib` instead of `kernel32.lib`, and add a `.def` for `memory_l1_1_3`. After adding any Win32 API, run `dumpbin /imports` on the ARM binary and check that no `kernel32.dll` or newer api-set version appears.

## WP8.x: Java threads never wake up from `sleep`

**Cause.** The javacall clock used `clock()`. On Windows Phone that is CPU time, so it stands still while the process sleeps, and sleeping threads never reached their wake-up time.

**Fix.** `javacall_time_get_milliseconds_since_1970` and `javacall_time_get_clock_milliseconds` use `GetTickCount64()`.

## WP8.1: app killed without any log at the first frame

**Cause.** `IDrawingSurfaceRuntimeHostNative::RequestAdditionalFrame` was called from the UI thread before the first frame.

**Fix.** Never call it from the UI thread. `Draw` requests the next frame itself at the end of every frame. The host pointer is taken under the lock, but the call is made outside it.

## WP8.1 on 16:9 Windows 10 Mobile phones: picture offset when the navigation bar hides

**Limitation.** A Silverlight 8.1 app on a 16:9 W10M phone (for example the HP Elite x3) gets a 480x800 page at scale 160 (15:9). When the soft navigation bar hides, Windows leaves a black band, but no event or size change reaches the app. `ApplicationView.VisibleBounds` is readable through the ABI but always reports the whole screen. Using `DrawingSurface` instead of `DrawingSurfaceBackgroundGrid` keeps the picture in place. 15:9 phones (Lumia 920/1020) are not affected.

## all: MIDP native code silently replaced by stubs

**Cause.** `cldc_javanotify_stubs.c`, meant for CLDC-only builds, has an empty `JavaTask()` and `javanotify_*` stubs. When linked into the MIDP build it hides the real implementation, and the linker only warns (`LNK4006`).

**Fix.** `gen_midp_sources.py` leaves that file out of MIDP builds.

## Host build (Windows) pitfalls

- `vcvars` breaks if a `PLATFORM` environment variable is set. The scripts use `CLDC_PLATFORM`.
- Put the VC `bin` folder before msys in `PATH`, or the coreutils `link` hides `link.exe`.
- With MSVC 2015 or later, loopgen, romgen and the VM library must link the PCH object (`_build_pch_visCPP.obj`). Otherwise you get `LNK2011`, or romgen crashes.
- Host test build (`runMidlet.exe`): the pcsl heap is plain `malloc` memory, so DEP blocks the JIT code (`0xC0000005`). Run `editbin /NXCOMPAT:NO` on the exe. The phone builds allocate executable memory properly.

## Debugging tips

- Logs: `LocalState\j2me.log` (W10M), or the isolated store of the WP8.x app. To read the WP8.x one, use **ISETool from the Windows Phone 8.1 SDK**: `ISETool ts deviceindex:0 <ProductID> <dir>`. The 8.0 SDK's ISETool fails with `DeviceNotFoundException` on current setups. Close the app completely first.
- `midp\force_int.txt` in the app's storage turns the JIT off (interpreter only). It helps separate JIT bugs from VM bugs, but AOT-compiled ROM code still runs.
- When the VM has been idle for more than 6 s, it dumps every Java thread's stack to the log (`[threads]`).
