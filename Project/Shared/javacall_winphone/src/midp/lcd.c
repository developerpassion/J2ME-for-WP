/*
 * lcd.c - javacall LCD for Windows Phone / UWP (J2MEWP).
 *
 * Replaces javacall/implementation/win32/midp/lcd.c (emulator window + skins).
 * MIDP draws into an RGB565 back buffer; javacall_lcd_flush() converts it to a
 * 32-bit 0xAARRGGBB front buffer that the UI thread reads via winphone_lcd_front().
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdlib.h>
#include <string.h>

#include "javacall_lcd.h"
#include "javacall_logging.h"
#include "winphone_port.h"

static int lcd_w = 240;
static int lcd_h = 320;
static javacall_pixel* back_buf = NULL;     /* RGB565, written by MIDP (VM thread) */
static unsigned int* front_buf = NULL;      /* ARGB, read by UI thread */
static volatile LONG front_dirty = 0;
static volatile LONG flush_count = 0;
static CRITICAL_SECTION lcd_lock;
static int lock_inited = 0;
static javacall_bool full_screen = JAVACALL_FALSE;
static javacall_bool initialized = JAVACALL_FALSE;

static void ensure_lock(void) {
    if (!lock_inited) { InitializeCriticalSection(&lcd_lock); lock_inited = 1; }
}

void winphone_lcd_set_size(int width, int height) {
    if (width > 0 && height > 0 && !initialized) {
        lcd_w = width;
        lcd_h = height;
    }
}

/* The UI thread keeps using the pointer returned here after the call (it copies
 * the frame), so buffers are never freed while a MIDlet can be stopped under it:
 * javacall_lcd_finalize() only retires them, and they are freed at the next
 * javacall_lcd_init() (a new game start, seconds later). Freeing them at once
 * crashed the phone when the game size was changed in play (stop + restart). */
static javacall_pixel* old_back_buf = NULL;
static unsigned int* old_front_buf = NULL;

const unsigned int* winphone_lcd_front(int* width, int* height, int* dirty) {
    const unsigned int* p;
    ensure_lock();
    EnterCriticalSection(&lcd_lock);
    *width = lcd_w;
    *height = lcd_h;
    *dirty = InterlockedExchange(&front_dirty, 0) != 0;
    p = initialized ? front_buf : NULL;
    LeaveCriticalSection(&lcd_lock);
    return p;
}

javacall_result javacall_lcd_init(void) {
    javacall_pixel* nb;
    unsigned int* nf;
    ensure_lock();
    if (initialized) return JAVACALL_OK;
    nb = (javacall_pixel*)calloc((size_t)lcd_w * lcd_h, sizeof(javacall_pixel));
    nf = (unsigned int*)calloc((size_t)lcd_w * lcd_h, sizeof(unsigned int));
    if (!nb || !nf) {
        free(nb); free(nf);
        return JAVACALL_FAIL;
    }
    EnterCriticalSection(&lcd_lock);
    free(old_back_buf); old_back_buf = NULL;
    free(old_front_buf); old_front_buf = NULL;
    back_buf = nb;
    front_buf = nf;
    initialized = JAVACALL_TRUE;
    LeaveCriticalSection(&lcd_lock);
    return JAVACALL_OK;
}

javacall_result javacall_lcd_finalize(void) {
    ensure_lock();
    EnterCriticalSection(&lcd_lock);
    initialized = JAVACALL_FALSE;
    free(old_back_buf); free(old_front_buf);   /* only if finalize runs twice */
    old_back_buf = back_buf; back_buf = NULL;
    old_front_buf = front_buf; front_buf = NULL;
    LeaveCriticalSection(&lcd_lock);
    return JAVACALL_OK;
}

javacall_pixel* javacall_lcd_get_screen(int hardwareId, int* screenWidth, int* screenHeight,
                                        javacall_lcd_color_encoding_type* colorEncoding) {
    (void)hardwareId;
    if (!initialized) return NULL;
    if (screenWidth) *screenWidth = lcd_w;
    if (screenHeight) *screenHeight = lcd_h;
    if (colorEncoding) *colorEncoding = JAVACALL_LCD_COLOR_RGB565;
    return back_buf;
}

/* Used by the win32 annunciator code: no top bar on the phone. */
javacall_pixel* getTopbarBuffer(int* screenWidth, int* screenHeight) {
    (void)screenWidth; (void)screenHeight;
    return NULL;
}

javacall_result javacall_lcd_set_full_screen_mode(int hardwareId, javacall_bool useFullScreen) {
    (void)hardwareId;
    full_screen = useFullScreen;
    return JAVACALL_OK;
}

javacall_bool javacall_lcd_get_full_screen_mode(int hardwareId) {
    (void)hardwareId;
    return full_screen;
}

static void convert_rows(int y0, int y1) {
    int x, y;
    if (y0 < 0) y0 = 0;
    if (y1 > lcd_h) y1 = lcd_h;
    for (y = y0; y < y1; ++y) {
        const javacall_pixel* s = back_buf + y * lcd_w;
        unsigned int* d = front_buf + y * lcd_w;
        for (x = 0; x < lcd_w; ++x) {
            unsigned int p = s[x];
            unsigned int r = (p >> 11) & 0x1F, g = (p >> 5) & 0x3F, b = p & 0x1F;
            d[x] = 0xFF000000u | (((r << 3) | (r >> 2)) << 16) | (((g << 2) | (g >> 4)) << 8) | ((b << 3) | (b >> 2));
        }
    }
}

javacall_result javacall_lcd_flush(int hardwareId) {
    return javacall_lcd_flush_partial(hardwareId, 0, lcd_h);
}

javacall_result javacall_lcd_flush_partial(int hardwareId, int ystart, int yend) {
    (void)hardwareId;
    if (!initialized) return JAVACALL_FAIL;
    EnterCriticalSection(&lcd_lock);
    convert_rows(ystart, yend);
    LeaveCriticalSection(&lcd_lock);
    InterlockedExchange(&front_dirty, 1);
    InterlockedIncrement(&flush_count);
    return JAVACALL_OK;
}

/* Frames the MIDlet pushed (for the FPS display). The UI only samples the
 * front buffer once per screen refresh, so counting "dirty" frames there
 * missed every flush in between and showed a far too low number. */
long winphone_lcd_flush_count(void) {
    return flush_count;
}

javacall_bool javacall_lcd_reverse_orientation(int hardwareId) {
    (void)hardwareId;
    return JAVACALL_FALSE;   /* TODO(W6.2): landscape games */
}

void javacall_lcd_handle_clamshell(void) {}

javacall_bool javacall_lcd_get_reverse_orientation(int hardwareId) {
    (void)hardwareId;
    return JAVACALL_FALSE;
}

javacall_bool javacall_lcd_is_native_softbutton_layer_supported(void) {
    return JAVACALL_FALSE;
}

javacall_result javacall_lcd_set_native_softbutton_label(const javacall_utf16* label, int len, int index) {
    (void)label; (void)len; (void)index;
    return JAVACALL_FAIL;
}

int javacall_lcd_get_screen_width(int hardwareId) { (void)hardwareId; return lcd_w; }
int javacall_lcd_get_screen_height(int hardwareId) { (void)hardwareId; return lcd_h; }
int javacall_lcd_get_current_hardwareId(void) { return 0; }
char* javacall_lcd_get_display_name(int hardwareId) { (void)hardwareId; return (char*)"Main display"; }
javacall_bool javacall_lcd_is_display_primary(int hardwareId) { (void)hardwareId; return JAVACALL_TRUE; }
javacall_bool javacall_lcd_is_display_buildin(int hardwareId) { (void)hardwareId; return JAVACALL_TRUE; }
javacall_bool javacall_lcd_is_display_pen_supported(int hardwareId) { (void)hardwareId; return JAVACALL_TRUE; }
javacall_bool javacall_lcd_is_display_pen_motion_supported(int hardwareId) { (void)hardwareId; return JAVACALL_TRUE; }
/* DisplayDevice.DISPLAY_DEVICE_SUPPORTS_*: input events, commands, forms, ticker,
   title, alerts, lists, textboxes (= win32 port). 0 made Display.setCurrent()
   reject any Screen with a title (IllegalArgumentException). */
int javacall_lcd_get_display_capabilities(int hardwareId) { (void)hardwareId; return 255; }

int* javacall_lcd_get_display_device_ids(int* n) {
    static int ids[1] = { 0 };
    *n = 1;
    return ids;
}
