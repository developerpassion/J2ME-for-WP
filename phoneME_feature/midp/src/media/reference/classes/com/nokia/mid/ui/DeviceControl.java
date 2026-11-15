/*
 * J2MEWP: Nokia UI API on top of MIDP 2.0. Vibra -> phone vibrator;
 * lights level > 0 keeps the screen on (brightness itself can't be set).
 */
package com.nokia.mid.ui;

import com.sun.j2mewp.media.DeviceHw;

public class DeviceControl {
    private DeviceControl() { }

    public static void setLights(int num, int level) {
        if (num != 0 || level < 0 || level > 100) throw new IllegalArgumentException();
        DeviceHw.backlight(level > 0);
    }

    public static void flashLights(long duration) {
        if (duration < 0) throw new IllegalArgumentException();
    }

    public static void startVibra(int freq, long duration) {
        if (freq < 0 || freq > 100 || duration < 0) throw new IllegalArgumentException();
        if (freq == 0) DeviceHw.stopVibrate(); else DeviceHw.vibrate(duration);
    }

    public static void stopVibra() { DeviceHw.stopVibrate(); }
}
