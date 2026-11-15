/*
 * J2MEWP: com.nokia.mid.ui.DirectGraphics implemented with MIDP 2.0 Graphics
 * (drawRegion for flips/rotations, drawRGB for raw pixels).
 */
package com.sun.j2mewp.nokia;

import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Image;
import javax.microedition.lcdui.game.Sprite;
import com.nokia.mid.ui.DirectGraphics;

public class DirectGraphicsImpl implements DirectGraphics {
    private final Graphics g;
    private int alpha = 0xFF;

    public DirectGraphicsImpl(Graphics g) {
        if (g == null) throw new NullPointerException();
        this.g = g;
    }

    public void setARGBColor(int argb) {
        alpha = (argb >>> 24) & 0xFF;
        g.setColor(argb & 0xFFFFFF);
    }

    public int getAlphaComponent() { return alpha; }

    public int getNativePixelFormat() { return TYPE_INT_8888_ARGB; }

    /**
     * Nokia manipulation (rotations counter-clockwise) -> Sprite TRANS_* (clockwise).
     * Same table as the common J2ME emulators (J2ME Loader / freej2me).
     */
    static int transform(int manipulation) {
        int rot = (manipulation & 0x0FFF) % 360;
        boolean h = (manipulation & FLIP_HORIZONTAL) != 0;
        boolean v = (manipulation & FLIP_VERTICAL) != 0;
        if (h && v) {
            switch (rot) {
                case ROTATE_90: return Sprite.TRANS_ROT90;
                case ROTATE_180: return Sprite.TRANS_NONE;
                case ROTATE_270: return Sprite.TRANS_ROT270;
                default: return Sprite.TRANS_ROT180;
            }
        }
        if (h) {
            switch (rot) {
                case ROTATE_90: return Sprite.TRANS_MIRROR_ROT90;
                case ROTATE_180: return Sprite.TRANS_MIRROR_ROT180;
                case ROTATE_270: return Sprite.TRANS_MIRROR_ROT270;
                default: return Sprite.TRANS_MIRROR;
            }
        }
        if (v) {
            switch (rot) {
                case ROTATE_90: return Sprite.TRANS_MIRROR_ROT270;
                case ROTATE_180: return Sprite.TRANS_MIRROR;
                case ROTATE_270: return Sprite.TRANS_MIRROR_ROT90;
                default: return Sprite.TRANS_MIRROR_ROT180;
            }
        }
        switch (rot) {
            case ROTATE_90: return Sprite.TRANS_ROT270;
            case ROTATE_180: return Sprite.TRANS_ROT180;
            case ROTATE_270: return Sprite.TRANS_ROT90;
            default: return Sprite.TRANS_NONE;
        }
    }

    public void drawImage(Image img, int x, int y, int anchor, int manipulation) {
        if (img == null) throw new NullPointerException();
        int t = transform(manipulation);
        if (t == Sprite.TRANS_NONE) {
            g.drawImage(img, x, y, anchor);
        } else {
            g.drawRegion(img, 0, 0, img.getWidth(), img.getHeight(), t, x, y, anchor);
        }
    }

    public void drawTriangle(int x1, int y1, int x2, int y2, int x3, int y3, int argb) {
        int old = g.getColor();
        g.setColor(argb & 0xFFFFFF);
        g.drawLine(x1, y1, x2, y2);
        g.drawLine(x2, y2, x3, y3);
        g.drawLine(x3, y3, x1, y1);
        g.setColor(old);
    }

    public void fillTriangle(int x1, int y1, int x2, int y2, int x3, int y3, int argb) {
        int old = g.getColor();
        g.setColor(argb & 0xFFFFFF);
        g.fillTriangle(x1, y1, x2, y2, x3, y3);
        g.setColor(old);
    }

    public void drawPolygon(int[] xs, int xo, int[] ys, int yo, int n, int argb) {
        int old = g.getColor();
        g.setColor(argb & 0xFFFFFF);
        for (int i = 0; i < n; i++) {
            int j = (i + 1) % n;
            g.drawLine(xs[xo + i], ys[yo + i], xs[xo + j], ys[yo + j]);
        }
        g.setColor(old);
    }

    /** Scanline even-odd fill (concave polygons too). */
    public void fillPolygon(int[] xs, int xo, int[] ys, int yo, int n, int argb) {
        if (n < 3) return;
        int old = g.getColor();
        g.setColor(argb & 0xFFFFFF);
        int minY = Integer.MAX_VALUE, maxY = Integer.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            int y = ys[yo + i];
            if (y < minY) minY = y;
            if (y > maxY) maxY = y;
        }
        int[] cross = new int[n];
        for (int y = minY; y <= maxY; y++) {
            int c = 0;
            for (int i = 0; i < n; i++) {
                int j = (i + 1) % n;
                int y1 = ys[yo + i], y2 = ys[yo + j];
                if ((y1 <= y && y2 > y) || (y2 <= y && y1 > y)) {
                    int x1 = xs[xo + i], x2 = xs[xo + j];
                    cross[c++] = x1 + (y - y1) * (x2 - x1) / (y2 - y1);
                }
            }
            for (int a = 1; a < c; a++) {
                int v = cross[a], b = a - 1;
                while (b >= 0 && cross[b] > v) { cross[b + 1] = cross[b]; b--; }
                cross[b + 1] = v;
            }
            for (int a = 0; a + 1 < c; a += 2) g.drawLine(cross[a], y, cross[a + 1], y);
        }
        g.setColor(old);
    }

    private void blit(int[] argb, int w, int h, int x, int y, boolean alphaChannel, int manipulation) {
        if (w <= 0 || h <= 0) return;
        if (manipulation == 0) {
            g.drawRGB(argb, 0, w, x, y, w, h, alphaChannel);
        } else {
            Image img = Image.createRGBImage(argb, w, h, alphaChannel);
            g.drawRegion(img, 0, 0, w, h, transform(manipulation), x, y, Graphics.TOP | Graphics.LEFT);
        }
    }

    public void drawPixels(int[] pixels, boolean transparency, int offset, int scanlength,
                           int x, int y, int w, int h, int manipulation, int format) {
        if (pixels == null) throw new NullPointerException();
        int[] argb = new int[w * h];
        boolean keepAlpha = transparency && format == TYPE_INT_8888_ARGB;
        for (int r = 0; r < h; r++) {
            for (int c = 0; c < w; c++) {
                int p = pixels[offset + r * scanlength + c];
                argb[r * w + c] = keepAlpha ? p : (p | 0xFF000000);
            }
        }
        blit(argb, w, h, x, y, keepAlpha, manipulation);
    }

    static int expand(short s, int format) {
        int p = s & 0xFFFF;
        switch (format) {
            case TYPE_USHORT_4444_ARGB: {
                int a = (p >> 12) & 15, r = (p >> 8) & 15, gg = (p >> 4) & 15, b = p & 15;
                return (a * 17 << 24) | (r * 17 << 16) | (gg * 17 << 8) | (b * 17);
            }
            case TYPE_USHORT_444_RGB: {
                int r = (p >> 8) & 15, gg = (p >> 4) & 15, b = p & 15;
                return 0xFF000000 | (r * 17 << 16) | (gg * 17 << 8) | (b * 17);
            }
            case TYPE_USHORT_1555_ARGB:
            case TYPE_USHORT_555_RGB: {
                int r = (p >> 10) & 31, gg = (p >> 5) & 31, b = p & 31;
                int a = (format == TYPE_USHORT_1555_ARGB && (p & 0x8000) == 0) ? 0 : 0xFF;
                return (a << 24) | ((r << 3 | r >> 2) << 16) | ((gg << 3 | gg >> 2) << 8) | (b << 3 | b >> 2);
            }
            default: { // 565
                int r = (p >> 11) & 31, gg = (p >> 5) & 63, b = p & 31;
                return 0xFF000000 | ((r << 3 | r >> 2) << 16) | ((gg << 2 | gg >> 4) << 8) | (b << 3 | b >> 2);
            }
        }
    }

    public void drawPixels(short[] pixels, boolean transparency, int offset, int scanlength,
                           int x, int y, int w, int h, int manipulation, int format) {
        if (pixels == null) throw new NullPointerException();
        boolean hasAlpha = transparency
            && (format == TYPE_USHORT_4444_ARGB || format == TYPE_USHORT_1555_ARGB);
        int[] argb = new int[w * h];
        for (int r = 0; r < h; r++) {
            for (int c = 0; c < w; c++) {
                int p = expand(pixels[offset + r * scanlength + c], format);
                argb[r * w + c] = hasAlpha ? p : (p | 0xFF000000);
            }
        }
        blit(argb, w, h, x, y, hasAlpha, manipulation);
    }

    /** 1-bit formats (0 = white, 1 = black), optional 1-bit transparency mask. */
    public void drawPixels(byte[] pixels, byte[] mask, int offset, int scanlength,
                           int x, int y, int w, int h, int manipulation, int format) {
        if (pixels == null) throw new NullPointerException();
        int[] argb = new int[w * h];
        for (int r = 0; r < h; r++) {
            for (int c = 0; c < w; c++) {
                int on, vis = 1;
                if (format == TYPE_BYTE_1_GRAY_VERTICAL) {
                    int idx = offset + (r / 8) * scanlength + c;
                    on = (pixels[idx] >> (r & 7)) & 1;
                    if (mask != null) vis = (mask[idx] >> (r & 7)) & 1;
                } else {
                    int bit = offset + r * scanlength + c;
                    on = (pixels[bit >> 3] >> (7 - (bit & 7))) & 1;
                    if (mask != null) vis = (mask[bit >> 3] >> (7 - (bit & 7))) & 1;
                }
                argb[r * w + c] = (vis == 0 ? 0 : 0xFF000000) | (on != 0 ? 0x000000 : 0xFFFFFF);
            }
        }
        blit(argb, w, h, x, y, mask != null, manipulation);
    }

    /* Reading back pixels is not possible through MIDP Graphics: left unchanged. */
    public void getPixels(int[] pixels, int offset, int scanlength, int x, int y, int w, int h, int format) { }

    public void getPixels(short[] pixels, int offset, int scanlength, int x, int y, int w, int h, int format) { }

    public void getPixels(byte[] pixels, byte[] mask, int offset, int scanlength,
                          int x, int y, int w, int h, int format) { }
}
