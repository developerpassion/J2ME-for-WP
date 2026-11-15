/*
 * J2MEWP: Samsung AudioClip, played through javax.microedition.media.
 * MIDI and MP3 play; MMF (Yamaha SMAF) is not supported and stays silent.
 */
package com.samsung.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.ByteArrayInputStream;
import javax.microedition.media.Manager;
import javax.microedition.media.Player;
import javax.microedition.media.control.VolumeControl;

public class AudioClip {
    public static final int TYPE_MMF = 1;
    public static final int TYPE_MP3 = 2;
    public static final int TYPE_MIDI = 3;

    private Player player;

    public AudioClip(int type, String filename) throws IOException {
        if (filename == null) throw new NullPointerException();
        InputStream in = getClass().getResourceAsStream(filename);
        if (in == null) throw new IOException("not found: " + filename);
        open(type, in);
    }

    public AudioClip(int type, byte[] audioData, int audioOffset, int audioLength) {
        if (audioData == null) throw new NullPointerException();
        try {
            open(type, new ByteArrayInputStream(audioData, audioOffset, audioLength));
        } catch (IOException e) {
            player = null;
        }
    }

    private void open(int type, InputStream in) throws IOException {
        String mime = type == TYPE_MP3 ? "audio/mpeg" : type == TYPE_MIDI ? "audio/midi" : null;
        if (mime == null) { player = null; return; }   // MMF: silent
        try {
            player = Manager.createPlayer(in, mime);
            player.realize();
        } catch (Exception e) {
            player = null;
        }
    }

    public static boolean isSupported() { return true; }

    public void play(int loop, int volume) {
        if (player == null) return;
        try {
            player.stop();
            player.setMediaTime(0);
            player.setLoopCount(loop <= 0 ? -1 : loop);
            VolumeControl vc = (VolumeControl) player.getControl("VolumeControl");
            if (vc != null) vc.setLevel(Math.max(0, Math.min(5, volume)) * 20);
            player.start();
        } catch (Exception e) { }
    }

    public void pause() {
        try { if (player != null) player.stop(); } catch (Exception e) { }
    }

    public void resume() {
        try { if (player != null) player.start(); } catch (Exception e) { }
    }

    public void stop() {
        try {
            if (player != null) { player.stop(); player.setMediaTime(0); }
        } catch (Exception e) { }
    }
}
