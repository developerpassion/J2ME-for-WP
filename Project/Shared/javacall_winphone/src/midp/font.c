/*
 * font.c - javacall font for Windows Phone / UWP (J2MEWP).
 *
 * Text is drawn with glyphs supplied by a host backend
 * (winphone_font_set_backend; W10M: App/FontEngine.cpp, DirectWrite) so any
 * Unicode text (Vietnamese...) renders. Without a backend every call returns
 * JAVACALL_FAIL / -1 and MIDP's putpixel port falls back to its built-in
 * Latin-only bitmap font (gxj_font_bitmap.c).
 */
#include "javacall_font.h"
#include "winphone_port.h"

static const WinphoneFontBackend* g_font;
static int g_style;   /* style | face of the current font */
static int g_px;

void winphone_font_set_backend(const WinphoneFontBackend* backend) {
    g_font = backend;
}

/* MIDP sizes -> em size in pixels (S40 240x320 phones: ~12/14/17 px lines) */
static int font_px(javacall_font_size size) {
    switch (size) {
    case JAVACALL_FONT_SIZE_SMALL: return 12;
    case JAVACALL_FONT_SIZE_LARGE: return 16;
    default:                       return 14;
    }
}

javacall_result javacall_font_set_font(javacall_font_face face, javacall_font_style style,
                                       javacall_font_size size) {
    if (!g_font) return JAVACALL_FAIL;
    g_style = (int)style | (int)face;
    g_px = font_px(size);
    return JAVACALL_OK;
}

javacall_result javacall_font_get_info(javacall_font_face face, javacall_font_style style,
                                       javacall_font_size size, int* ascent, int* descent, int* leading) {
    if (!g_font) return JAVACALL_FAIL;
    if (!g_font->metrics(font_px(size), (int)style | (int)face, ascent, descent, leading))
        return JAVACALL_FAIL;
    return JAVACALL_OK;
}

static unsigned int next_cp(const javacall_utf16* t, int n, int* i) {
    unsigned int c = t[*i];
    if (c >= 0xD800 && c <= 0xDBFF && *i + 1 < n && t[*i + 1] >= 0xDC00 && t[*i + 1] <= 0xDFFF) {
        c = 0x10000 + ((c - 0xD800) << 10) + (t[*i + 1] - 0xDC00);
        (*i)++;
    }
    (*i)++;
    return c;
}

int javacall_font_get_width(javacall_font_face face, javacall_font_style style, javacall_font_size size,
                            const javacall_utf16* text, int textLen) {
    int i = 0, w = 0, px = font_px(size), st = (int)style | (int)face;
    WinphoneGlyph g;
    if (!g_font) return -1;
    while (i < textLen) {
        if (g_font->glyph(next_cp(text, textLen, &i), px, st, &g)) w += g.advance;
    }
    return w;
}

static javacall_pixel blend565(javacall_pixel d, javacall_pixel s, int a) {
    int dr = (d >> 11) & 31, dg = (d >> 5) & 63, db = d & 31;
    int sr = (s >> 11) & 31, sg = (s >> 5) & 63, sb = s & 31;
    dr += ((sr - dr) * a + 127) / 255;
    dg += ((sg - dg) * a + 127) / 255;
    db += ((sb - db) * a + 127) / 255;
    return (javacall_pixel)((dr << 11) | (dg << 5) | db);
}

javacall_result javacall_font_draw(javacall_pixel color, int clipX1, int clipY1, int clipX2, int clipY2,
                                   javacall_pixel* dst, int dstW, int dstH,
                                   int x, int y, const javacall_utf16* text, int textLen) {
    int ascent, descent, leading, baseline, pen = x, i = 0;
    WinphoneGlyph g;
    if (!g_font) return JAVACALL_FAIL;
    if (!g_font->metrics(g_px, g_style, &ascent, &descent, &leading)) return JAVACALL_FAIL;
    if (clipX2 > dstW) clipX2 = dstW;
    if (clipY2 > dstH) clipY2 = dstH;
    /* gxj_text.c: y = top of the text box, baseline after leading + ascent */
    baseline = y + leading + ascent;

    while (i < textLen) {
        unsigned int cp = next_cp(text, textLen, &i);
        if (!g_font->glyph(cp, g_px, g_style, &g)) continue;
        if (g.alpha && g.width > 0 && g.height > 0) {
            int gx0 = pen + g.left, gy0 = baseline + g.top, r, c;
            for (r = 0; r < g.height; r++) {
                int py = gy0 + r;
                const unsigned char* src;
                javacall_pixel* row;
                if (py < clipY1 || py >= clipY2) continue;
                src = g.alpha + r * g.width;
                row = dst + py * dstW;
                for (c = 0; c < g.width; c++) {
                    int px = gx0 + c, a = src[c];
                    if (a == 0 || px < clipX1 || px >= clipX2) continue;
                    row[px] = a >= 250 ? color : blend565(row[px], color, a);
                }
            }
        }
        pen += g.advance;
    }

    if (g_style & JAVACALL_FONT_STYLE_UNDERLINE) {
        int uy = baseline + 1, c;
        if (uy >= clipY1 && uy < clipY2)
            for (c = x; c < pen; c++)
                if (c >= clipX1 && c < clipX2) dst[uy * dstW + c] = color;
    }
    return JAVACALL_OK;
}
