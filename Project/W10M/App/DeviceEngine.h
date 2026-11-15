#pragma once

// Vibrator + backlight for MIDlets (J2mewpDeviceBackend in j2mewp_audio.h):
// Windows.Phone VibrationDevice (phones only) and DisplayRequest to keep the
// screen on while a game asks for the backlight. Call Init once from the UI
// thread; Reset when the MIDlet ends.
void DeviceEngine_Init();
void DeviceEngine_Reset();
// The MIDlet asked for the backlight (WP8.1 Silverlight keeps the screen on from C#).
bool DeviceEngine_WantsLight();
