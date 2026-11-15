/* J2MEWP: Motorola backlight control (on = keep screen awake). */
package com.motorola.multimedia;

import com.sun.j2mewp.media.DeviceHw;

public class Lighting {
    public static void backlightOn() { DeviceHw.backlight(true); }
    public static void backlightOff() { DeviceHw.backlight(false); }
    public static void keypadLightOn() { }
    public static void keypadLightOff() { }
}
