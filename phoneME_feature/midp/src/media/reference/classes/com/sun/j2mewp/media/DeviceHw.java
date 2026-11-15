/*
 * J2MEWP: phone vibrator / backlight for the vendor APIs (Nokia, Samsung,
 * Siemens, Motorola). Backed by the host (j2mewp_device_* in j2mewp_audio.h);
 * without a host backend every call is a no-op.
 */
package com.sun.j2mewp.media;

public final class DeviceHw {
    private DeviceHw() { }

    /** Longest single vibration the phone API accepts (5 s); longer = clamp. */
    public static final int MAX_VIBRATE_MS = 5000;

    /** Vibrate for ms milliseconds; ms <= 0 stops. */
    public static void vibrate(long ms) {
        int v = ms <= 0 ? 0 : (ms > MAX_VIBRATE_MS ? MAX_VIBRATE_MS : (int)ms);
        nVibrate(v);
    }

    public static void stopVibrate() { nVibrate(0); }

    /** Backlight on = keep the screen awake; off = normal timeout. */
    public static void backlight(boolean on) { nBacklight(on ? 1 : 0); }

    public static boolean hasVibrator() { return nHasVibrator() != 0; }

    private static native void nVibrate(int ms);
    private static native void nBacklight(int on);
    private static native int nHasVibrator();
}
