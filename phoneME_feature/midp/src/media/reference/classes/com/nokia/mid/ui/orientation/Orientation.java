/*
 * J2MEWP: Nokia orientation API. The game screen orientation is chosen in the
 * app's game settings; the LCD size decides the reported orientation.
 */
package com.nokia.mid.ui.orientation;

import javax.microedition.lcdui.Canvas;

public class Orientation {
    public static final int ORIENTATION_PORTRAIT = 1;
    public static final int ORIENTATION_LANDSCAPE = 2;
    public static final int ORIENTATION_PORTRAIT_180 = 4;
    public static final int ORIENTATION_LANDSCAPE_180 = 8;

    private static int appOrientation = ORIENTATION_PORTRAIT;

    private Orientation() { }

    public static void setAppOrientation(int orientation) { appOrientation = orientation; }
    public static int getAppOrientation() { return appOrientation; }

    public static int getDisplayOrientation() {
        try {
            Canvas probe = new Canvas() { protected void paint(javax.microedition.lcdui.Graphics g) { } };
            return probe.getWidth() > probe.getHeight() ? ORIENTATION_LANDSCAPE : ORIENTATION_PORTRAIT;
        } catch (Throwable t) {
            return ORIENTATION_PORTRAIT;
        }
    }

    public static void addOrientationListener(OrientationListener listener) { }
    public static void removeOrientationListener(OrientationListener listener) { }
}
