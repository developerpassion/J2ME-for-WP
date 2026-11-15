/* J2MEWP: Samsung backlight control (on = keep screen awake). */
package com.samsung.util;

import com.sun.j2mewp.media.DeviceHw;

public class LCDLight {
    public static boolean isSupported() { return true; }
    public static void on(int duration) { DeviceHw.backlight(true); }
    public static void off() { DeviceHw.backlight(false); }
}
