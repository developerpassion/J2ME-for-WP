#pragma once

// Audio backend for MIDP Players (j2mewp_audio.h): XAudio2 output; WAV (PCM,
// IMA ADPCM, others passed to XAudio2), MIDI via the software synth in
// Shared/audio, MP3 via Media Foundation. Call once at startup.
void AudioEngine_Init();

// App suspend / resume: pause all output.
void AudioEngine_Suspend(bool suspended);
void AudioEngine_CloseAll();   // MIDlet ended: stop and free every sound
