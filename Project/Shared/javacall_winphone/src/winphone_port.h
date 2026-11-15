/*
 * winphone_port.h - glue between the J2MEWP host (Project/Shared/host) and the
 * javacall_winphone port. Plain C, usable from C and C++.
 */
#ifndef J2MEWP_WINPHONE_PORT_H
#define J2MEWP_WINPHONE_PORT_H

#include <wchar.h>

#ifdef __cplusplus
extern "C" {
#endif

/* lcd.c */
void winphone_lcd_set_size(int width, int height);                         /* before start */
const unsigned int* winphone_lcd_front(int* width, int* height, int* dirty); /* UI thread */
long winphone_lcd_flush_count(void);   /* frames flushed by the MIDlet so far */

/* main.c: run a MIDlet suite the same way as
   "runMidlet [-int] -classpathext <jar> internal <midlet class>" (blocks the VM thread). */
int winphone_run_midlet(const char* jar_path_utf8, const char* midlet_class, int interpreter_only);

/* events.c: drop queued events (before starting another MIDlet). */
void winphone_events_clear(void);

/* Root folder for appdb / RMS / properties (UTF-16, no trailing slash). Set before start. */
void winphone_set_storage_root(const wchar_t* path);
const wchar_t* winphone_storage_root(void);

/* font.c: glyphs rendered by the host (W10M: DirectWrite). Without a backend
   MIDP falls back to its built-in Latin-only bitmap font.
   style = javacall style bits (BOLD 1, ITALIC 2, UNDERLINE 4) | face (MONOSPACE 0x20,
   PROPORTIONAL 0x40); px = font em size in pixels. Called on the VM thread. */
typedef struct WinphoneGlyph {
    int width, height;          /* alpha bitmap size (0x0 for blanks) */
    int left, top;              /* bitmap offset from the pen position on the baseline */
    int advance;                /* pen advance in pixels */
    const unsigned char* alpha; /* width*height coverage 0..255; must stay valid (host caches) */
} WinphoneGlyph;

typedef struct WinphoneFontBackend {
    int (*metrics)(int px, int style, int* ascent, int* descent, int* leading);
    int (*glyph)(unsigned int codepoint, int px, int style, WinphoneGlyph* out);
} WinphoneFontBackend;

void winphone_font_set_backend(const WinphoneFontBackend* backend);

#ifdef __cplusplus
}
#endif

#endif
