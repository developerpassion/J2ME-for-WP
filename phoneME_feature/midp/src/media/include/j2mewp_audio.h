/*
 * J2MEWP: audio backend interface used by com.sun.j2mewp.media.AudioPlayer
 * natives (j2mewp_media_kni.c). The host app registers an implementation;
 * without one every player is silent (nCreate returns 0).
 * Player handles are > 0. Times are milliseconds, -1 = unknown.
 */
#ifndef J2MEWP_AUDIO_H
#define J2MEWP_AUDIO_H

#ifdef __cplusplus
extern "C" {
#endif

/* kind: 1 = WAV, 2 = MIDI (SMF), 3 = MP3, 4 = AMR */
typedef struct J2mewpAudioBackend {
    int  (*create)(const unsigned char* data, int len, int kind);
    void (*start)(int h, int loops);        /* loops: -1 forever, n >= 1 */
    void (*stop)(int h);
    void (*close)(int h);
    void (*set_volume)(int h, int level);   /* 0..100 */
    int  (*is_playing)(int h);
    int  (*get_time)(int h);
    int  (*get_duration)(int h);
    void (*set_time)(int h, int ms);
    void (*tone)(int note, int duration_ms, int volume);
} J2mewpAudioBackend;

void j2mewp_audio_set_backend(const J2mewpAudioBackend* backend);

/* Vibrator / backlight (com.sun.j2mewp.media.DeviceHw, Display.vibrate).
 * Calls may come from the VM thread; the host must marshal as needed. */
typedef struct J2mewpDeviceBackend {
    int  (*vibrate)(int ms);        /* ms <= 0 stops; returns 1 if supported */
    void (*backlight)(int on);      /* 1 = keep screen on, 0 = normal */
    int  (*has_vibrator)(void);
} J2mewpDeviceBackend;

void j2mewp_device_set_backend(const J2mewpDeviceBackend* backend);
int  j2mewp_device_vibrate(int ms);

#ifdef __cplusplus
}
#endif

#endif
