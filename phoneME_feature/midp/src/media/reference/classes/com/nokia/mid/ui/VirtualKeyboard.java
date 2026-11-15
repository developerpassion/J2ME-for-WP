/*
 * J2MEWP: Nokia Series 40 touch virtual keyboard API. The phone app has its own
 * on-screen keypad, so these calls only remember the requested state.
 */
package com.nokia.mid.ui;

public class VirtualKeyboard {
    public static final int VKB_TYPE_ITUT = 1;
    public static final int VKB_TYPE_GAME = 3;
    public static final int VKB_MODE_DEFAULT = 0;
    public static final int VKB_MODE_NUMERIC = 1;
    public static final int VKB_MODE_ALPHA_LOWER_CASE = 2;
    public static final int VKB_MODE_ALPHA_UPPER_CASE = 3;
    public static final int VKB_MODE_ALPHA_UPPER_CASE_LOCKED = 4;

    private static boolean hideOpenCommand;

    private VirtualKeyboard() { }

    public static void hideOpenKeypadCommand(boolean hide) { hideOpenCommand = hide; }
    public static boolean isOpenKeypadCommandHidden() { return hideOpenCommand; }
    public static void suppressSizeChanged(boolean suppress) { }
    public static boolean isVisible() { return false; }
    public static int getXPosition() { return 0; }
    public static int getYPosition() { return 0; }
    public static int getWidth() { return 0; }
    public static int getHeight() { return 0; }
    public static void setVisibilityListener(KeyboardVisibilityListener listener) { }
}
