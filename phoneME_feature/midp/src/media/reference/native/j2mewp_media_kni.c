/*
 * J2MEWP: natives of com.sun.j2mewp.media.AudioPlayer -> host audio backend.
 */
#include <stdlib.h>
#include <kni.h>
#include <j2mewp_audio.h>

static const J2mewpAudioBackend* g_audio = NULL;

void j2mewp_audio_set_backend(const J2mewpAudioBackend* backend) {
    g_audio = backend;
}

KNIEXPORT KNI_RETURNTYPE_INT
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nCreate) {
    jint kind = KNI_GetParameterAsInt(2);
    jint h = 0;
    KNI_StartHandles(1);
    KNI_DeclareHandle(arr);
    KNI_GetParameterAsObject(1, arr);
    if (g_audio != NULL && !KNI_IsNullHandle(arr)) {
        jsize len = KNI_GetArrayLength(arr);
        unsigned char* buf = (unsigned char*)malloc(len > 0 ? len : 1);
        if (buf != NULL) {
            KNI_GetRawArrayRegion(arr, 0, len, (jbyte*)buf);
            h = g_audio->create(buf, (int)len, (int)kind);
            free(buf);
        }
    }
    KNI_EndHandles();
    KNI_ReturnInt(h);
}

KNIEXPORT KNI_RETURNTYPE_VOID
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nStart) {
    jint h = KNI_GetParameterAsInt(1);
    jint loops = KNI_GetParameterAsInt(2);
    if (g_audio != NULL) g_audio->start(h, loops);
    KNI_ReturnVoid();
}

KNIEXPORT KNI_RETURNTYPE_VOID
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nStop) {
    jint h = KNI_GetParameterAsInt(1);
    if (g_audio != NULL) g_audio->stop(h);
    KNI_ReturnVoid();
}

KNIEXPORT KNI_RETURNTYPE_VOID
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nClose) {
    jint h = KNI_GetParameterAsInt(1);
    if (g_audio != NULL) g_audio->close(h);
    KNI_ReturnVoid();
}

KNIEXPORT KNI_RETURNTYPE_VOID
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nSetVolume) {
    jint h = KNI_GetParameterAsInt(1);
    jint level = KNI_GetParameterAsInt(2);
    if (g_audio != NULL) g_audio->set_volume(h, level);
    KNI_ReturnVoid();
}

KNIEXPORT KNI_RETURNTYPE_BOOLEAN
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nIsPlaying) {
    jint h = KNI_GetParameterAsInt(1);
    jboolean r = (g_audio != NULL && g_audio->is_playing(h)) ? KNI_TRUE : KNI_FALSE;
    KNI_ReturnBoolean(r);
}

KNIEXPORT KNI_RETURNTYPE_INT
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nGetTime) {
    jint h = KNI_GetParameterAsInt(1);
    KNI_ReturnInt(g_audio != NULL ? g_audio->get_time(h) : -1);
}

KNIEXPORT KNI_RETURNTYPE_INT
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nGetDuration) {
    jint h = KNI_GetParameterAsInt(1);
    KNI_ReturnInt(g_audio != NULL ? g_audio->get_duration(h) : -1);
}

KNIEXPORT KNI_RETURNTYPE_VOID
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nSetTime) {
    jint h = KNI_GetParameterAsInt(1);
    jint ms = KNI_GetParameterAsInt(2);
    if (g_audio != NULL) g_audio->set_time(h, ms);
    KNI_ReturnVoid();
}

KNIEXPORT KNI_RETURNTYPE_VOID
KNIDECL(com_sun_j2mewp_media_AudioPlayer_nTone) {
    jint note = KNI_GetParameterAsInt(1);
    jint dur = KNI_GetParameterAsInt(2);
    jint vol = KNI_GetParameterAsInt(3);
    if (g_audio != NULL) g_audio->tone(note, dur, vol);
    KNI_ReturnVoid();
}

/* ---- com.sun.j2mewp.media.DeviceHw: vibrator / backlight ---- */

static const J2mewpDeviceBackend* g_device = NULL;

void j2mewp_device_set_backend(const J2mewpDeviceBackend* backend) {
    g_device = backend;
}

/* Also used by javacall_annunciator_vibrate (Display.vibrate). */
int j2mewp_device_vibrate(int ms) {
    if (g_device == NULL || g_device->vibrate == NULL) return 0;
    return g_device->vibrate(ms);
}

KNIEXPORT KNI_RETURNTYPE_VOID
KNIDECL(com_sun_j2mewp_media_DeviceHw_nVibrate) {
    j2mewp_device_vibrate(KNI_GetParameterAsInt(1));
    KNI_ReturnVoid();
}

KNIEXPORT KNI_RETURNTYPE_VOID
KNIDECL(com_sun_j2mewp_media_DeviceHw_nBacklight) {
    jint on = KNI_GetParameterAsInt(1);
    if (g_device != NULL && g_device->backlight != NULL) g_device->backlight(on);
    KNI_ReturnVoid();
}

KNIEXPORT KNI_RETURNTYPE_INT
KNIDECL(com_sun_j2mewp_media_DeviceHw_nHasVibrator) {
    jint r = (g_device != NULL && g_device->has_vibrator != NULL) ? g_device->has_vibrator() : 0;
    KNI_ReturnInt(r);
}
