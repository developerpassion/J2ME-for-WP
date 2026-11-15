/* J2MEWP: Motorola vibrator -> phone vibrator (periodic = one long buzz). */
package com.motorola.multimedia;

import com.sun.j2mewp.media.DeviceHw;

public class Vibrator {
    public static final int MAX_VIBRATE_TIME = 10000;
    public static final int VIBRATE_SHORT = 0;
    public static final int VIBRATE_LONG = 1;
    public static final int VIBRATE_PULSE = 2;

    public static void vibrateFor(int duration) { DeviceHw.vibrate(duration); }
    public static void vibratePeriodicaly(int duration) { DeviceHw.vibrate(duration); }
    public static void vibratePeriodicaly(int duration, int interval) { DeviceHw.vibrate(duration); }
    public static void setVibrateTone(int tone) { }
    public static void stopVibrator() { DeviceHw.stopVibrate(); }
}
