/* J2MEWP: Siemens backlight control (on = keep screen awake). */
package com.siemens.mp.game;

import com.sun.j2mewp.media.DeviceHw;

public class Light {
    public static void setLightOn() { DeviceHw.backlight(true); }
    public static void setLightOff() { DeviceHw.backlight(false); }
}
