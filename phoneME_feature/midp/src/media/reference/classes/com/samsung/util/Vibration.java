/* J2MEWP: Samsung vibration -> phone vibrator (duration in ms per Samsung API docs). */
package com.samsung.util;

import com.sun.j2mewp.media.DeviceHw;

public class Vibration {
    public static boolean isSupported() { return DeviceHw.hasVibrator(); }
    public static void start(int duration, int strength) { DeviceHw.vibrate(duration); }
    public static void stop() { DeviceHw.stopVibrate(); }
}
