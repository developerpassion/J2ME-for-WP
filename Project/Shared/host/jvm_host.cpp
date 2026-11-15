#include "jvm_host.h"
#include <stdio.h>
#include <intrin.h>

#if defined(_M_ARM)
#  define J2MEWP_ARCH "ARM (Thumb-2)"
#elif defined(_M_IX86)
#  define J2MEWP_ARCH "x86"
#elif defined(_M_X64)
#  define J2MEWP_ARCH "x64"
#else
#  define J2MEWP_ARCH "unknown"
#endif

#ifndef J2MEWP_ENABLE_JIT
#  define J2MEWP_ENABLE_JIT 1
#endif

#define J2_STR2(x) #x
#define J2_STR(x) J2_STR2(x)

static jvm_host_log_fn g_log = 0;
static void* g_log_user = 0;

static void host_log(const char* s) {
    if (g_log) g_log(s, g_log_user);
}

#if J2MEWP_HAS_MIDP
#  define J2MEWP_VM_DESC "CLDC-HI VM + MIDP 2.0"
extern "C" int jvm_host_vm_start(const wchar_t* classpath, const char* main_class); /* jvm_host_vm.cpp */
extern "C" int jvm_host_vm_running(void); /* jvm_host_vm.cpp */
#elif J2MEWP_HAS_VM
#  define J2MEWP_VM_DESC "CLDC-HI VM"
extern "C" int jvm_host_vm_start(const wchar_t* classpath, const char* main_class); /* jvm_host_vm.cpp */
extern "C" int jvm_host_vm_running(void); /* jvm_host_vm.cpp */
#else
#  define J2MEWP_VM_DESC "no VM (stub)"
#endif

extern "C" const char* jvm_host_version(void) {
    return "J2MEWP 0.0.1 / phoneME Feature CLDC-HI MR4 / " J2MEWP_ARCH
           " / JIT=" J2_STR(J2MEWP_ENABLE_JIT) " / " J2MEWP_VM_DESC;
}

extern "C" void jvm_host_set_logger(jvm_host_log_fn fn, void* user) {
    g_log = fn;
    g_log_user = user;
}

/* Used by jvm_host_vm.cpp for System.out lines (any thread). */
extern "C" void jvm_host_log_line(const char* line) {
    host_log(line);
}

extern "C" int jvm_host_run_jar(const wchar_t* jar_path, const char* midlet_class) {
#if J2MEWP_HAS_VM
    /* CLDC-only build: plain main class. MIDP build: MIDlet class (jvm_host_vm.cpp). */
    return jvm_host_vm_start(jar_path, midlet_class);
#else
    (void)jar_path;
    char buf[256];
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[stub] run_jar midlet=%s (VM not built for this arch)",
                midlet_class ? midlet_class : "(null)");
    host_log(buf);
    return -1;
#endif
}

extern "C" int jvm_host_is_running(void) {
#if J2MEWP_HAS_VM
    return jvm_host_vm_running();
#else
    return 0;
#endif
}

extern "C" int jvm_host_vm_stop(int timeout_ms); /* jvm_host_vm.cpp */

#if J2MEWP_HAS_MIDP
extern "C" void javanotify_pause(void);
extern "C" void javanotify_resume(void);
#endif
static volatile long g_paused = 0;

extern "C" void jvm_host_pause(void) {
#if J2MEWP_HAS_MIDP
    if (jvm_host_is_running() && _InterlockedCompareExchange(&g_paused, 1, 0) == 0) {
        host_log("[lifecycle] pause");
        javanotify_pause();
    }
#endif
}

extern "C" void jvm_host_resume(void) {
#if J2MEWP_HAS_MIDP
    if (_InterlockedCompareExchange(&g_paused, 0, 1) == 1) {
        host_log("[lifecycle] resume");
        if (jvm_host_is_running()) javanotify_resume();
    }
#endif
}

extern "C" int jvm_host_is_paused(void) { return g_paused != 0; }

extern "C" int jvm_host_stop(int timeout_ms) {
    /* A suspended MIDP stack only listens for RESUME: wake it so it sees the shutdown. */
    jvm_host_resume();
#if J2MEWP_HAS_VM
    return jvm_host_vm_stop(timeout_ms);
#else
    (void)timeout_ms;
    return 1;
#endif
}

#if J2MEWP_HAS_MIDP
/* ------------------------------------------------------------------ */
/* MIDP build: LCD + input go through javacall_winphone.              */
/* ------------------------------------------------------------------ */
#include "javacall_keypress.h"
#include "javacall_penevent.h"
#include "winphone_port.h"

extern "C" const unsigned int* jvm_host_lcd(int* width, int* height, int* dirty) {
    return winphone_lcd_front(width, height, dirty);
}

extern "C" void jvm_host_tick(unsigned int now_ms) {
    (void)now_ms;   /* MIDP drives its own repaint */
}

extern "C" void jvm_host_set_lcd_size(int width, int height) {
    winphone_lcd_set_size(width, height);
}

extern "C" long jvm_host_frame_count(void) {
    return winphone_lcd_flush_count();
}

extern "C" void jvm_host_key(int midp_key, int pressed) {
    /* javacall_key values are the MIDP key codes ('0'..'9', '*', '#', -1..-7) */
    javanotify_key_event((javacall_key)midp_key, pressed ? JAVACALL_KEYPRESSED : JAVACALL_KEYRELEASED);
}

extern "C" void jvm_host_pointer(int x, int y, int type) {
    static const javacall_penevent_type map[3] = { JAVACALL_PENPRESSED, JAVACALL_PENDRAGGED, JAVACALL_PENRELEASED };
    if (type >= 0 && type <= 2) javanotify_pen_event(x, y, map[type]);
}

#else
/* ------------------------------------------------------------------ */
/* Stub LCD 240x320 test pattern to validate the render/input path.   */
/* Will be replaced by javacall_lcd (W4.3).                           */
/* ------------------------------------------------------------------ */
enum { LCD_W = 240, LCD_H = 320 };
static unsigned int g_lcd[LCD_W * LCD_H];
static int g_dirty = 1;
static int g_box_x = 100, g_box_y = 140;
static unsigned int g_last_ms = 0;

static void fill_rect(int x, int y, int w, int h, unsigned int c) {
    for (int j = y; j < y + h; ++j) {
        if (j < 0 || j >= LCD_H) continue;
        for (int i = x; i < x + w; ++i)
            if (i >= 0 && i < LCD_W) g_lcd[j * LCD_W + i] = c;
    }
}

extern "C" const unsigned int* jvm_host_lcd(int* width, int* height, int* dirty) {
    *width = LCD_W; *height = LCD_H;
    *dirty = g_dirty; g_dirty = 0;
    return g_lcd;
}

extern "C" void jvm_host_set_lcd_size(int width, int height) { (void)width; (void)height; }
extern "C" long jvm_host_frame_count(void) { return 0; }

extern "C" void jvm_host_tick(unsigned int now_ms) {
    if (now_ms - g_last_ms < 33) return;   /* ~30 fps like a J2ME game */
    g_last_ms = now_ms;
    unsigned int t = now_ms / 16;
    for (int y = 0; y < LCD_H; ++y)
        for (int x = 0; x < LCD_W; ++x)
            g_lcd[y * LCD_W + x] = 0xFF000000u | (((x + t) & 0xFF) << 16) | ((y & 0xFF) << 8) | 0x40;
    fill_rect(g_box_x, g_box_y, 40, 40, 0xFFFFFFFFu);
    g_dirty = 1;
}

extern "C" void jvm_host_key(int midp_key, int pressed) {
    char buf[64];
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "key %d %s", midp_key, pressed ? "down" : "up");
    host_log(buf);
    if (!pressed) return;
    switch (midp_key) {
    case -1: case '2': g_box_y -= 8; break;
    case -2: case '8': g_box_y += 8; break;
    case -3: case '4': g_box_x -= 8; break;
    case -4: case '6': g_box_x += 8; break;
    }
}

extern "C" void jvm_host_pointer(int x, int y, int type) {
    if (type != 2) { g_box_x = x - 20; g_box_y = y - 20; }
}
#endif /* J2MEWP_HAS_MIDP */
