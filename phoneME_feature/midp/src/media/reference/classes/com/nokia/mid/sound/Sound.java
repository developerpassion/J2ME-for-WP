/*
 * J2MEWP: com.nokia.mid.sound.Sound - silent stand-in so games that create
 * Nokia sounds keep running (play() reports SOUND_STOPPED immediately).
 */
package com.nokia.mid.sound;

public class Sound {
    public static final int FORMAT_TONE = 1;
    public static final int FORMAT_WAV = 5;
    public static final int SOUND_PLAYING = 0;
    public static final int SOUND_STOPPED = 1;
    public static final int SOUND_UNINITIALIZED = 3;

    private SoundListener listener;
    private int state = SOUND_STOPPED;
    private int gain = 255;

    public Sound(byte[] data, int type) { init(data, type); }

    public Sound(int freq, long duration) { init(freq, duration); }

    public static int getConcurrentSoundCount(int type) { return 1; }

    public static int[] getSupportedFormats() { return new int[] { FORMAT_TONE, FORMAT_WAV }; }

    public void init(byte[] data, int type) {
        if (data == null) throw new NullPointerException();
        if (type != FORMAT_TONE && type != FORMAT_WAV) throw new IllegalArgumentException();
        state = SOUND_STOPPED;
    }

    public void init(int freq, long duration) { state = SOUND_STOPPED; }

    public void play(int loop) {
        if (loop < 0) throw new IllegalArgumentException();
        state = SOUND_STOPPED;
        if (listener != null) listener.soundStateChanged(this, SOUND_STOPPED);
    }

    public void stop() { state = SOUND_STOPPED; }

    public void resume() { }

    public void release() { state = SOUND_UNINITIALIZED; }

    public int getState() { return state; }

    public void setGain(int g) { gain = g < 0 ? 0 : (g > 255 ? 255 : g); }

    public int getGain() { return gain; }

    public void setSoundListener(SoundListener l) { listener = l; }
}
