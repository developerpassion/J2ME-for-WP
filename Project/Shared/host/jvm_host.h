/*
 * jvm_host.h - C API between the platform UI (WP80 / WP81 / W10M) and the
 * J2ME core (CLDC-HI VM + MIDP + javacall). No WinRT headers here.
 */
#ifndef J2MEWP_JVM_HOST_H
#define J2MEWP_JVM_HOST_H

#ifdef __cplusplus
extern "C" {
#endif

typedef void (*jvm_host_log_fn)(const char* line, void* user);

/* Build description: version, arch, JIT on/off. */
const char* jvm_host_version(void);

/* Receive log lines (System.out / debug). May be called from the VM thread. */
void jvm_host_set_logger(jvm_host_log_fn fn, void* user);

/* Run a MIDlet from a JAR file. Returns 0 on success. (stub for now) */
int jvm_host_run_jar(const wchar_t* jar_path, const char* midlet_class);

/* MIDP build: folder holding appdb/ and lib/ (e.g. LocalState\midp). Call before run. */
void jvm_host_set_storage_root(const wchar_t* path);

/* Ask the VM to stop. */
/* Ask the running program to exit; waits up to timeout_ms.
   Returns 1 when the VM is no longer running. Call off the UI thread. */
int jvm_host_stop(int timeout_ms);

/* ---- LCD: 32-bit 0xAARRGGBB framebuffer of the MIDlet ----
 * Called by the UI every frame. *dirty = 1 if content changed since last call. */
const unsigned int* jvm_host_lcd(int* width, int* height, int* dirty);

/* Called from the UI loop every frame (the stub draws a test pattern). */
void jvm_host_tick(unsigned int now_ms);

/* ---- Input ----
 * MIDP key codes: '0'..'9', '*'=42, '#'=35,
 * UP=-1 DOWN=-2 LEFT=-3 RIGHT=-4 FIRE=-5 SOFT1=-6 SOFT2=-7 */
void jvm_host_key(int midp_key, int pressed);
/* Coordinates already mapped into LCD space. type: 0=down 1=move 2=up */
void jvm_host_pointer(int x, int y, int type);

/* Reads META-INF/MANIFEST.MF of a JAR into buf (NUL-terminated).
   Returns its length, or -1 on error. */
int jvm_host_read_jar_manifest(const wchar_t* jar_path, char* buf, int cap);

/* Reads (inflates) one entry of a JAR ("icon.png" or "/icon.png") into buf.
   Returns its length, -2 if longer than cap, -1 if missing / error. */
int jvm_host_read_jar_entry(const wchar_t* jar_path, const char* name, char* buf, int cap);

/* MIDlet screen size in pixels; applies to the next jvm_host_run_jar(). */
void jvm_host_set_lcd_size(int width, int height);

/* Number of frames the MIDlet has flushed so far (game FPS = delta per second). */
long jvm_host_frame_count(void);

/* App lifecycle (W6.3): pause = MIDlet.pauseApp() + MIDP resources suspended,
   resume = startApp() again. Safe to call when nothing runs; idempotent. */
void jvm_host_pause(void);
void jvm_host_resume(void);
int jvm_host_is_paused(void);

/* 1 while a Java program is running on the VM thread. */
int jvm_host_is_running(void);

#ifdef __cplusplus
}
#endif

#endif
