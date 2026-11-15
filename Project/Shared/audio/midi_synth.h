/*
 * midi_synth.h - small software synthesizer: renders a Standard MIDI File
 * (format 0/1) to mono 16-bit PCM. Portable C++ (no OS APIs), shared by the
 * WP8.0 / WP8.1 / W10M builds.
 *
 * Timbres are simple oscillators chosen by GM program family + ADSR; channel 10
 * uses synthesized drums. Good enough for J2ME game music; can be swapped for a
 * SoundFont renderer later without touching callers.
 */
#pragma once
#include <vector>
#include <cstdint>

namespace j2mewp {

// Renders `smf` to `out` (mono, `rate` Hz). Returns false if the file is not a
// valid SMF. `max_seconds` caps very long songs.
bool RenderMidi(const uint8_t* smf, size_t len, int rate, std::vector<int16_t>& out,
                int max_seconds = 300);

// Renders a single note (Manager.playTone): square-ish tone with short release.
void RenderTone(int note, int duration_ms, int volume, int rate, std::vector<int16_t>& out);

} // namespace j2mewp
