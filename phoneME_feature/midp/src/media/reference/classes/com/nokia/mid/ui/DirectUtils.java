/*
 * J2MEWP: Nokia UI API on top of MIDP 2.0.
 */
package com.nokia.mid.ui;

import javax.microedition.lcdui.Graphics;
import javax.microedition.lcdui.Image;

public class DirectUtils {
    private DirectUtils() { }

    public static DirectGraphics getDirectGraphics(Graphics g) {
        return new com.sun.j2mewp.nokia.DirectGraphicsImpl(g);
    }

    public static Image createImage(byte[] imageData, int imageOffset, int imageLength) {
        return Image.createImage(imageData, imageOffset, imageLength);
    }

    /** Mutable image filled with argb (MIDP mutable images are opaque). */
    public static Image createImage(int width, int height, int argb) {
        Image img = Image.createImage(width, height);
        Graphics g = img.getGraphics();
        g.setColor(argb & 0xFFFFFF);
        g.fillRect(0, 0, width, height);
        return img;
    }
}
