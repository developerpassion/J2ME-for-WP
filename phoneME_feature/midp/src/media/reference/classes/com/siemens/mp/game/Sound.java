/* J2MEWP: Siemens tone, mapped to Manager.playTone(). */
package com.siemens.mp.game;

import javax.microedition.media.Manager;

public class Sound {
    /** Plays a tone of freq Hz for time ms. */
    public static void playTone(int freq, int time) {
        if (freq <= 0 || time <= 0) return;
        // MIDI note = 69 + 12 * log2(freq / 440), without Math.log in CLDC 1.1.
        int note = 69;
        double f = freq;
        while (f >= 440.0 * 1.0594630943592953 && note < 127) { f /= 1.0594630943592953; note++; }
        while (f < 440.0 / 1.0594630943592953 && note > 0) { f *= 1.0594630943592953; note--; }
        try { Manager.playTone(note, time, 80); } catch (Exception e) { }
    }
}
