/* J2MEWP: Siemens vibrator -> phone vibrator. startVibrator = until stop (max 5 s). */
package com.siemens.mp.game;

import com.sun.j2mewp.media.DeviceHw;

public class Vibrator {
    public static void startVibrator() { DeviceHw.vibrate(DeviceHw.MAX_VIBRATE_MS); }
    public static void stopVibrator() { DeviceHw.stopVibrate(); }
    public static void triggerVibrator(int duration) { DeviceHw.vibrate(duration); }
}
