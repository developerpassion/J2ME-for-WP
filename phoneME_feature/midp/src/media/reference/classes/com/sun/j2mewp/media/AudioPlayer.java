/*
 * J2MEWP: minimal MIDP 2.0 media Player (WAV / MIDI / MP3 / AMR) backed by
 * the native audio engine of the host app (see j2mewp_media_kni.c).
 */
package com.sun.j2mewp.media;

import java.io.IOException;
import java.io.InputStream;
import java.util.Vector;

import javax.microedition.media.Control;
import javax.microedition.media.MediaException;
import javax.microedition.media.Player;
import javax.microedition.media.PlayerListener;
import javax.microedition.media.control.VolumeControl;

public final class AudioPlayer implements Player, VolumeControl, Runnable {

    /* Kinds understood by the native engine. */
    public static final int KIND_UNKNOWN = 0;
    public static final int KIND_WAV = 1;
    public static final int KIND_MIDI = 2;
    public static final int KIND_MP3 = 3;
    public static final int KIND_AMR = 4;

    private final byte[] data;
    private final String type;
    private final int kind;

    private int state = UNREALIZED;
    private int handle;            /* native player, 0 = none */
    private int loopCount = 1;     /* -1 = forever */
    private int level = 100;
    private boolean muted;
    private long pendingTime = -1; /* setMediaTime before prefetch (ms) */
    private final Vector listeners = new Vector();
    private Thread watcher;
    private int runId;             /* bumps on every start/stop */

    /* ---- natives ---------------------------------------------------- */
    private static native int nCreate(byte[] data, int kind);
    private static native void nStart(int h, int loops);
    private static native void nStop(int h);
    private static native void nClose(int h);
    private static native void nSetVolume(int h, int level);
    private static native boolean nIsPlaying(int h);
    private static native int nGetTime(int h);      /* ms, -1 unknown */
    private static native int nGetDuration(int h);  /* ms, -1 unknown */
    private static native void nSetTime(int h, int ms);
    public static native void nTone(int note, int durationMs, int volume);

    /* ---- creation ---------------------------------------------------- */
    public static byte[] readAll(InputStream in) throws IOException {
        byte[] buf = new byte[8192];
        int n = 0, r;
        while ((r = in.read(buf, n, buf.length - n)) > 0) {
            n += r;
            if (n == buf.length) {
                byte[] b2 = new byte[buf.length * 2];
                System.arraycopy(buf, 0, b2, 0, n);
                buf = b2;
            }
        }
        byte[] out = new byte[n];
        System.arraycopy(buf, 0, out, 0, n);
        return out;
    }

    public static int detectKind(byte[] d, String type) {
        if (d.length >= 4) {
            if (d[0] == 'R' && d[1] == 'I' && d[2] == 'F' && d[3] == 'F') return KIND_WAV;
            if (d[0] == 'M' && d[1] == 'T' && d[2] == 'h' && d[3] == 'd') return KIND_MIDI;
            if (d[0] == '#' && d[1] == '!' && d[2] == 'A' && d[3] == 'M') return KIND_AMR;
            if (d[0] == 'I' && d[1] == 'D' && d[2] == '3') return KIND_MP3;
            if ((d[0] & 0xFF) == 0xFF && (d[1] & 0xE0) == 0xE0) return KIND_MP3;
        }
        if (type != null) {
            String t = type.toLowerCase();
            if (t.indexOf("wav") >= 0) return KIND_WAV;
            if (t.indexOf("mid") >= 0) return KIND_MIDI;
            if (t.indexOf("mpeg") >= 0 || t.indexOf("mp3") >= 0) return KIND_MP3;
            if (t.indexOf("amr") >= 0) return KIND_AMR;
        }
        return KIND_UNKNOWN;
    }

    public AudioPlayer(byte[] data, String type) throws MediaException {
        this.data = data;
        this.type = type;
        this.kind = detectKind(data, type);
        if (kind == KIND_UNKNOWN) {
            throw new MediaException("Unsupported content: " + type);
        }
    }

    /* ---- state machine ---------------------------------------------- */
    private void checkClosed(boolean unrealizedToo) {
        if (state == CLOSED || (unrealizedToo && state == UNREALIZED)) {
            throw new IllegalStateException();
        }
    }

    public synchronized void realize() throws MediaException {
        checkClosed(false);
        if (state == UNREALIZED) state = REALIZED;
    }

    public synchronized void prefetch() throws MediaException {
        checkClosed(false);
        if (state >= PREFETCHED) return;
        realize();
        if (handle == 0) {
            handle = nCreate(data, kind);
            if (handle == 0) {
                /* No audio engine / unsupported format: behave as a silent
                   player so games keep running. */
                handle = -1;
            }
            applyVolume();
            if (pendingTime >= 0) {
                if (handle > 0) nSetTime(handle, (int) pendingTime);
                pendingTime = -1;
            }
        }
        state = PREFETCHED;
    }

    public synchronized void start() throws MediaException {
        checkClosed(false);
        if (state == STARTED) return;
        prefetch();
        state = STARTED;
        int id = ++runId;
        if (handle > 0) {
            nStart(handle, loopCount);
        }
        fire(PlayerListener.STARTED, new Long(getMediaTime()));
        Thread t = new Thread(this);
        watcher = t;
        watchId = id;
        t.start();
    }

    public synchronized void stop() throws MediaException {
        checkClosed(false);
        if (state != STARTED) return;
        runId++;
        if (handle > 0) nStop(handle);
        state = PREFETCHED;
        fire(PlayerListener.STOPPED, new Long(getMediaTime()));
    }

    public synchronized void deallocate() {
        checkClosed(false);
        if (state == STARTED) {
            try { stop(); } catch (MediaException e) { }
        }
        if (state == PREFETCHED) {
            releaseNative();
            state = REALIZED;
        }
    }

    public void close() {
        synchronized (this) {
            if (state == CLOSED) return;
            runId++;
            releaseNative();
            state = CLOSED;
        }
        fire(PlayerListener.CLOSED, null);
    }

    private void releaseNative() {
        if (handle > 0) {
            nStop(handle);
            nClose(handle);
        }
        handle = 0;
    }

    /* Watches playback end on its own thread (END_OF_MEDIA). */
    private int watchId;

    public void run() {
        int id;
        synchronized (this) { id = watchId; }
        /* Silent player: report end after the (unknown) media "plays". */
        int silentMs = 1000;
        while (true) {
            try { Thread.sleep(50); } catch (InterruptedException e) { }
            synchronized (this) {
                if (id != runId || state != STARTED) return;
                boolean playing;
                if (handle > 0) {
                    playing = nIsPlaying(handle);
                } else {
                    silentMs -= 50;
                    playing = silentMs > 0 || loopCount == -1;
                }
                if (playing) continue;
                state = PREFETCHED;
                runId++;
            }
            fire(PlayerListener.END_OF_MEDIA, new Long(getMediaTime()));
            return;
        }
    }

    /* ---- Player ------------------------------------------------------ */
    public synchronized long setMediaTime(long now) throws MediaException {
        checkClosed(true);
        long ms = now < 0 ? 0 : now / 1000;
        if (handle > 0) nSetTime(handle, (int) ms);
        else pendingTime = ms;
        return ms * 1000;
    }

    public synchronized long getMediaTime() {
        checkClosed(false);
        if (handle > 0) {
            int t = nGetTime(handle);
            return t < 0 ? TIME_UNKNOWN : (long) t * 1000;
        }
        return 0;
    }

    public int getState() { return state; }

    public synchronized long getDuration() {
        checkClosed(false);
        if (handle > 0) {
            int d = nGetDuration(handle);
            return d < 0 ? TIME_UNKNOWN : (long) d * 1000;
        }
        return TIME_UNKNOWN;
    }

    public String getContentType() {
        checkClosed(true);
        switch (kind) {
            case KIND_WAV: return "audio/x-wav";
            case KIND_MIDI: return "audio/midi";
            case KIND_MP3: return "audio/mpeg";
            case KIND_AMR: return "audio/amr";
        }
        return type;
    }

    public synchronized void setLoopCount(int count) {
        checkClosed(false);
        if (count == 0 || state == STARTED) throw new IllegalArgumentException();
        loopCount = count;
    }

    public void addPlayerListener(PlayerListener l) {
        checkClosed(false);
        if (l != null && !listeners.contains(l)) listeners.addElement(l);
    }

    public void removePlayerListener(PlayerListener l) {
        checkClosed(false);
        listeners.removeElement(l);
    }

    private void fire(String event, Object data) {
        Object[] ls;
        synchronized (listeners) {
            ls = new Object[listeners.size()];
            listeners.copyInto(ls);
        }
        for (int i = 0; i < ls.length; i++) {
            try {
                ((PlayerListener) ls[i]).playerUpdate(this, event, data);
            } catch (Throwable t) { }
        }
    }

    /* ---- Controllable ------------------------------------------------ */
    public Control[] getControls() {
        checkClosed(true);
        return new Control[] { this };
    }

    public Control getControl(String controlType) {
        checkClosed(true);
        if (controlType == null) throw new IllegalArgumentException();
        if (controlType.equals("VolumeControl")
                || controlType.equals("javax.microedition.media.control.VolumeControl")) {
            return this;
        }
        return null;
    }

    /* ---- VolumeControl ----------------------------------------------- */
    private void applyVolume() {
        if (handle > 0) nSetVolume(handle, muted ? 0 : level);
    }

    public synchronized void setMute(boolean mute) {
        if (muted == mute) return;
        muted = mute;
        applyVolume();
        fire(PlayerListener.VOLUME_CHANGED, this);
    }

    public boolean isMuted() { return muted; }

    public synchronized int setLevel(int l) {
        if (l < 0) l = 0;
        if (l > 100) l = 100;
        if (l != level) {
            level = l;
            applyVolume();
            fire(PlayerListener.VOLUME_CHANGED, this);
        }
        return level;
    }

    public int getLevel() { return muted ? -1 : level; }
}
