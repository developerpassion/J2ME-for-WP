/*
 * main.c - javacall entry for Windows Phone / UWP (J2MEWP).
 *
 * Replaces javacall/implementation/win32/midp/main.c (console main, emulator
 * window, dialogs). The host calls winphone_run_midlet() on its VM thread; it
 * does what main() + ThreadProc() did on the PC, with the arguments that worked
 * there:  runMidlet -classpathext <jar> internal <MIDlet class>
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <wchar.h>

#include "javacall_lifecycle.h"
#include "javacall_logging.h"
#include "javacall_events.h"
#include "javacall_properties.h"
#include "javacall_lcd.h"
#include "../winphone_port.h"

/* MIDP javacall AMS (midp/src/ams/example/javacall_common) */
void JavaTask(void);
int getInternalPropertyInt(const char* key);

/* Phone number used by the win32 code (JSR 120 / properties). */
char* _phonenum = "5550000";

static wchar_t storage_root[MAX_PATH] = L"";

void winphone_set_storage_root(const wchar_t* path) {
    wcsncpy_s(storage_root, MAX_PATH, path ? path : L"", _TRUNCATE);
}

const wchar_t* winphone_storage_root(void) {
    return storage_root;
}

int winphone_run_midlet(const char* jar_path_utf8, const char* midlet_class, int interpreter_only) {
    static char jar[MAX_PATH * 3];
    static char cls[256];
    char* argv[8];
    int argc = 0;

    strncpy_s(jar, sizeof(jar), jar_path_utf8 ? jar_path_utf8 : "", _TRUNCATE);
    strncpy_s(cls, sizeof(cls), midlet_class ? midlet_class : "", _TRUNCATE);

    argv[argc++] = "runMidlet";
    if (interpreter_only) argv[argc++] = "-int";
    /* Many real games ship classes without StackMap (not preverified);
     * phones and other emulators run them anyway -> no bytecode verifier. */
    argv[argc++] = "-UseVerifier";
    argv[argc++] = "-classpathext";
    argv[argc++] = jar;
    argv[argc++] = "internal";
    argv[argc++] = cls;

    if (!javacall_events_init()) {
        javacall_print("[winphone] javacall_events_init failed\n");
        return -1;
    }
    {
        /* Properties file is opened read/write: keep it in LocalState\midp, not the
           (read-only) package folder that the default relative name resolves to. */
        static wchar_t ini[MAX_PATH];
        _snwprintf_s(ini, MAX_PATH, _TRUNCATE, L"%s\\jwc_properties.ini", storage_root);
        if (javacall_initialize_configurations_from_file((const javacall_utf16*)ini, (int)wcslen(ini)) != JAVACALL_OK)
            javacall_print("[winphone] cannot load jwc_properties.ini\n");
    }
    if (javacall_lcd_init() != JAVACALL_OK) {
        javacall_print("[winphone] javacall_lcd_init failed\n");
        return -1;
    }

    {
        char buf[128];
        _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[winphone] MAIN_MEMORY_CHUNK_SIZE=%d\n",
                    getInternalPropertyInt("MAIN_MEMORY_CHUNK_SIZE"));
        javacall_print(buf);
    }

    /* Queue the start request, then run the Java task loop on this thread.
       Events left from a previous run (END, keys) must not reach this one. */
    winphone_events_clear();
    javanotify_start_java_with_arbitrary_args(argc, argv);
    JavaTask();

    javacall_print("[winphone] JavaTask finished\n");
    return 0;
}
