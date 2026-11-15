/*
 * midi_synth.cpp - see midi_synth.h.
 */
#include "midi_synth.h"
#include <cmath>
#include <cstring>
#include <algorithm>

namespace j2mewp {

namespace {

// ---- SMF parsing -------------------------------------------------------------

struct Event {
    uint32_t tick;
    uint32_t order;        // stable sort key (track, position)
    uint8_t status;        // 0xFF = tempo meta
    uint8_t d1, d2;
    uint32_t tempo;        // for tempo events (us per quarter)
};

uint32_t Be32(const uint8_t* p) { return (uint32_t(p[0]) << 24) | (p[1] << 16) | (p[2] << 8) | p[3]; }
uint16_t Be16(const uint8_t* p) { return uint16_t((p[0] << 8) | p[1]); }

bool ReadVar(const uint8_t*& p, const uint8_t* end, uint32_t& v) {
    v = 0;
    for (int i = 0; i < 4; i++) {
        if (p >= end) return false;
        uint8_t b = *p++;
        v = (v << 7) | (b & 0x7F);
        if (!(b & 0x80)) return true;
    }
    return true;
}

// plain function, not a lambda: VS2012 (WP8.0) breaks name lookup after a lambda here
bool EventBefore(const Event& a, const Event& b) {
    return a.tick != b.tick ? a.tick < b.tick : a.order < b.order;
}

bool ParseSmf(const uint8_t* d, size_t len, std::vector<Event>& evs, int& division) {
    if (len < 14 || memcmp(d, "MThd", 4) != 0) return false;
    uint32_t hlen = Be32(d + 4);
    if (hlen < 6 || 8 + hlen > len) return false;
    int ntracks = Be16(d + 10);
    division = Be16(d + 12);
    if (division & 0x8000) division = 480;   // SMPTE: rare in games, approximate
    if (division <= 0) division = 480;
    size_t pos = 8 + hlen;
    uint32_t order = 0;
    for (int t = 0; t < ntracks && pos + 8 <= len; t++) {
        if (memcmp(d + pos, "MTrk", 4) != 0) {      // skip unknown chunk
            pos += 8 + Be32(d + pos + 4);
            t--;
            continue;
        }
        uint32_t tlen = Be32(d + pos + 4);
        const uint8_t* p = d + pos + 8;
        const uint8_t* end = std::min(p + tlen, d + len);
        pos += 8 + tlen;
        uint32_t tick = 0;
        uint8_t running = 0;
        while (p < end) {
            uint32_t delta;
            if (!ReadVar(p, end, delta)) break;
            tick += delta;
            if (p >= end) break;
            uint8_t st = *p;
            if (st & 0x80) p++;
            else st = running;                      // running status
            if (st == 0xFF) {                        // meta
                if (p >= end) break;
                uint8_t type = *p++;
                uint32_t mlen;
                if (!ReadVar(p, end, mlen)) break;
                if (type == 0x51 && mlen == 3 && p + 3 <= end) {
                    Event e = { tick, order++, 0xFF, 0, 0, uint32_t((p[0] << 16) | (p[1] << 8) | p[2]) };
                    evs.push_back(e);
                }
                if (type == 0x2F) break;             // end of track
                p += mlen;
                continue;
            }
            if (st == 0xF0 || st == 0xF7) {          // sysex
                uint32_t slen;
                if (!ReadVar(p, end, slen)) break;
                p += slen;
                continue;
            }
            if (!(st & 0x80)) break;                 // corrupt
            running = st;
            int n = ((st & 0xF0) == 0xC0 || (st & 0xF0) == 0xD0) ? 1 : 2;
            if (p + n > end) break;
            Event e = { tick, order++, st, p[0], uint8_t(n > 1 ? p[1] : 0), 0 };
            p += n;
            evs.push_back(e);
        }
    }
    std::stable_sort(evs.begin(), evs.end(), EventBefore);
    return true;
}

// ---- voices ----------------------------------------------------------------

enum Wave { W_SINE, W_SQUARE, W_SAW, W_TRI, W_PULSE25, W_NOISE };

struct Patch {
    Wave wave;
    float attack, decay, sustain, release;   // seconds / level
    float gain;
    bool percussive;                          // decays to 0 even while held
};

// (no brace-init returns / member initializers: VS2012 for WP8.0)
Patch MakePatch(Wave w, float a, float d, float s, float r, float g, bool perc) {
    Patch p; p.wave = w; p.attack = a; p.decay = d; p.sustain = s; p.release = r; p.gain = g; p.percussive = perc;
    return p;
}

Patch PatchFor(int program) {
    int fam = (program & 127) / 8;
    switch (fam) {
        case 0:  return MakePatch(W_TRI,     0.002f, 0.6f, 0.0f, 0.15f, 0.9f, true);   // piano
        case 1:  return MakePatch(W_SINE,    0.001f, 0.4f, 0.0f, 0.2f,  0.9f, true);   // chromatic perc
        case 2:  return MakePatch(W_SQUARE,  0.01f,  0.1f, 0.8f, 0.08f, 0.5f, false);  // organ
        case 3:  return MakePatch(W_PULSE25, 0.002f, 0.5f, 0.0f, 0.1f,  0.7f, true);   // guitar
        case 4:  return MakePatch(W_TRI,     0.005f, 0.3f, 0.6f, 0.08f, 1.0f, false);  // bass
        case 5:  return MakePatch(W_SAW,     0.08f,  0.2f, 0.8f, 0.25f, 0.45f, false); // strings
        case 6:  return MakePatch(W_SAW,     0.06f,  0.2f, 0.8f, 0.3f,  0.45f, false); // ensemble
        case 7:  return MakePatch(W_SAW,     0.02f,  0.1f, 0.8f, 0.1f,  0.5f, false);  // brass
        case 8:  return MakePatch(W_PULSE25, 0.03f,  0.1f, 0.8f, 0.1f,  0.5f, false);  // reed
        case 9:  return MakePatch(W_SINE,    0.03f,  0.1f, 0.9f, 0.12f, 0.9f, false);  // pipe/flute
        case 10: return MakePatch(W_SQUARE,  0.005f, 0.1f, 0.8f, 0.08f, 0.45f, false); // synth lead
        case 11: return MakePatch(W_TRI,     0.15f,  0.3f, 0.8f, 0.4f,  0.8f, false);  // synth pad
        case 12: return MakePatch(W_SAW,     0.05f,  0.3f, 0.6f, 0.3f,  0.4f, false);  // fx
        case 13: return MakePatch(W_PULSE25, 0.002f, 0.4f, 0.0f, 0.1f,  0.7f, true);   // ethnic
        case 14: return MakePatch(W_SINE,    0.001f, 0.2f, 0.0f, 0.1f,  0.9f, true);   // percussive
        default: return MakePatch(W_NOISE,   0.01f,  0.3f, 0.0f, 0.1f,  0.3f, true);   // sfx
    }
}

struct Voice {
    bool active;
    int ch, note;
    bool held;               // key still down (or sustained)
    bool drum;
    float phase, freq, freqEnd, freqDecay;
    float amp;               // velocity * channel gain
    float env;               // current envelope level
    int stage;               // 0 attack 1 decay 2 sustain 3 release
    Patch patch;
    float noiseMix;          // drums: tone/noise blend
    uint32_t noise;
    uint32_t age;
    Voice() : active(false), ch(0), note(0), held(false), drum(false), phase(0), freq(0), freqEnd(0),
              freqDecay(0), amp(0), env(0), stage(0), patch(MakePatch(W_SINE, 0, 0, 0, 0, 0, false)),
              noiseMix(0), noise(22222), age(0) {}
};

struct Channel {
    int program;
    float volume, expression;
    float bend;              // semitones
    bool sustain;
    Channel() : program(0), volume(100 / 127.f), expression(1.f), bend(0), sustain(false) {}
};

float NoteFreq(float n) { return 440.f * std::pow(2.f, (n - 69.f) / 12.f); }

class Synth {
public:
    explicit Synth(int rate) : rate_(float(rate)), clock_(0) {}

    void Event(uint8_t st, uint8_t d1, uint8_t d2) {
        int ch = st & 0x0F;
        Channel& c = ch_[ch];
        switch (st & 0xF0) {
            case 0x90:
                if (d2) { NoteOn(ch, d1, d2); break; }
                // fallthrough: velocity 0 = note off
            case 0x80: NoteOff(ch, d1); break;
            case 0xB0:
                if (d1 == 7) c.volume = d2 / 127.f;
                else if (d1 == 11) c.expression = d2 / 127.f;
                else if (d1 == 64) {
                    c.sustain = d2 >= 64;
                    if (!c.sustain) ReleaseSustained(ch);
                } else if (d1 == 120 || d1 == 123) AllOff(ch);
                else if (d1 == 121) { c.volume = 100 / 127.f; c.expression = 1; c.bend = 0; }
                break;
            case 0xC0: c.program = d1; break;
            case 0xE0: c.bend = ((((d2 << 7) | d1) - 8192) / 8192.f) * 2.f; break;
        }
    }

    void Render(int16_t* out, int n, float master) {
        for (int i = 0; i < n; i++) {
            float s = 0;
            for (Voice& v : v_) {
                if (!v.active) continue;
                s += Sample(v);
            }
            s *= master * 0.22f;
            if (s > 1.f) s = 1.f; else if (s < -1.f) s = -1.f;
            out[i] = int16_t(s * 32000.f);
        }
    }

    bool Busy() const {
        for (const Voice& v : v_) if (v.active) return true;
        return false;
    }

private:
    void NoteOn(int ch, int note, int vel) {
        Voice* v = Alloc();
        *v = Voice();
        v->active = true; v->held = true; v->ch = ch; v->note = note; v->age = clock_++;
        Channel& c = ch_[ch];
        float velf = vel / 127.f;
        v->amp = velf * velf;
        if (ch == 9) {
            SetupDrum(*v, note);
        } else {
            v->patch = PatchFor(c.program);
            v->freq = NoteFreq(float(note));
        }
    }

    void SetupDrum(Voice& v, int note) {
        v.drum = true;
        v.patch = MakePatch(W_SINE, 0.001f, 0.15f, 0.f, 0.05f, 1.0f, true);
        switch (note) {
            case 35: case 36:                                   // kick
                v.freq = 120; v.freqEnd = 45; v.freqDecay = 25; v.noiseMix = 0.05f;
                v.patch.decay = 0.25f; v.patch.gain = 1.6f; break;
            case 38: case 40: case 37: case 39:                 // snare / clap
                v.freq = 190; v.freqEnd = 160; v.freqDecay = 10; v.noiseMix = 0.7f;
                v.patch.decay = 0.18f; v.patch.gain = 1.0f; break;
            case 42: case 44: case 46:                          // hi-hats
                v.freq = 8000; v.noiseMix = 1.f;
                v.patch.decay = note == 46 ? 0.25f : 0.05f; v.patch.gain = 0.45f; break;
            case 49: case 51: case 52: case 55: case 57: case 59: // cymbals
                v.freq = 6000; v.noiseMix = 1.f; v.patch.decay = 0.8f; v.patch.gain = 0.35f; break;
            default:                                            // toms & misc
                v.freq = NoteFreq(float(note) - 12.f); v.freqEnd = v.freq * 0.6f; v.freqDecay = 8;
                v.noiseMix = 0.15f; v.patch.decay = 0.25f; v.patch.gain = 0.9f; break;
        }
    }

    void NoteOff(int ch, int note) {
        for (Voice& v : v_) {
            if (v.active && v.held && v.ch == ch && v.note == note) {
                v.held = false;
                if (!ch_[ch].sustain && v.stage < 3) v.stage = 3;
            }
        }
    }

    void ReleaseSustained(int ch) {
        for (Voice& v : v_)
            if (v.active && !v.held && v.ch == ch && v.stage < 3) v.stage = 3;
    }

    void AllOff(int ch) {
        for (Voice& v : v_) if (v.active && v.ch == ch) { v.held = false; v.stage = 3; }
    }

    Voice* Alloc() {
        Voice* best = nullptr;
        for (Voice& v : v_) {
            if (!v.active) return &v;
            if (!best || (v.stage == 3 && best->stage != 3) ||
                ((v.stage == 3) == (best->stage == 3) && v.age < best->age))
                best = &v;
        }
        return best;
    }

    float Sample(Voice& v) {
        const Patch& p = v.patch;
        const float dt = 1.f / rate_;
        // envelope
        switch (v.stage) {
            case 0:
                v.env += dt / std::max(p.attack, 0.0005f);
                if (v.env >= 1.f) { v.env = 1.f; v.stage = 1; }
                break;
            case 1: {
                float target = p.percussive ? 0.f : p.sustain;
                v.env -= dt / std::max(p.decay, 0.001f) * (1.f - target + 0.0001f);
                if (v.env <= target) {
                    v.env = target;
                    v.stage = p.percussive ? 3 : 2;
                    if (p.percussive && v.env <= 0.f) { v.active = false; return 0; }
                }
                break;
            }
            case 2: break;
            case 3:
                v.env -= dt / std::max(p.release, 0.005f);
                if (v.env <= 0.f) { v.active = false; return 0; }
                break;
        }
        const Channel& c = ch_[v.ch];
        float f = v.freq;
        if (v.drum) {
            if (v.freqDecay > 0 && v.freq > v.freqEnd) v.freq -= (v.freq - v.freqEnd) * v.freqDecay * dt;
        } else if (c.bend != 0) {
            f *= std::pow(2.f, c.bend / 12.f);
        }
        v.phase += f * dt;
        v.phase -= std::floor(v.phase);
        float ph = v.phase, o;
        switch (v.drum ? W_SINE : p.wave) {
            case W_SINE:    o = std::sin(ph * 6.2831853f); break;
            case W_SQUARE:  o = ph < 0.5f ? 0.6f : -0.6f; break;
            case W_PULSE25: o = ph < 0.25f ? 0.6f : -0.6f; break;
            case W_SAW:     o = (2.f * ph - 1.f) * 0.7f; break;
            case W_TRI:     o = (ph < 0.5f ? 4.f * ph - 1.f : 3.f - 4.f * ph); break;
            default:        o = 0; break;
        }
        float mix = v.drum ? v.noiseMix : (p.wave == W_NOISE ? 1.f : 0.f);
        if (mix > 0) {
            v.noise = v.noise * 1664525u + 1013904223u;
            float nz = (int32_t(v.noise) >> 8) / 8388608.f;
            o = o * (1.f - mix) + nz * mix;
        }
        return o * v.env * v.amp * p.gain * c.volume * c.expression;
    }

    float rate_;
    Voice v_[32];
    Channel ch_[16];
    uint32_t clock_;
};

} // namespace

bool RenderMidi(const uint8_t* smf, size_t len, int rate, std::vector<int16_t>& out, int max_seconds) {
    std::vector<Event> evs;
    int division = 480;
    if (!ParseSmf(smf, len, evs, division)) return false;

    Synth syn(rate);
    out.clear();
    const size_t max_samples = size_t(max_seconds) * size_t(rate);
    double us_per_tick = 500000.0 / division;
    double t_samples = 0;          // current time in samples (fractional)
    uint32_t last_tick = 0;
    size_t written = 0;

    auto render_to = [&](double target) {
        size_t want = std::min(size_t(target), max_samples);
        if (want <= written) return;
        out.resize(want);
        syn.Render(out.data() + written, int(want - written), 1.f);
        written = want;
    };

    for (const Event& e : evs) {
        t_samples += (e.tick - last_tick) * us_per_tick * rate / 1e6;
        last_tick = e.tick;
        render_to(t_samples);
        if (written >= max_samples) break;
        if (e.status == 0xFF) us_per_tick = double(e.tempo) / division;
        else syn.Event(e.status, e.d1, e.d2);
    }
    // let release tails ring out (max 2 s)
    double tail_end = t_samples + 2.0 * rate;
    while (syn.Busy() && written < size_t(tail_end) && written < max_samples)
        render_to(double(written + rate / 50));
    if (out.empty()) out.resize(rate / 10, 0);
    return true;
}

void RenderTone(int note, int duration_ms, int volume, int rate, std::vector<int16_t>& out) {
    Synth syn(rate);
    syn.Event(0xC0, 80, 0);                                  // square lead
    syn.Event(0xB0, 7, uint8_t(std::max(0, std::min(127, volume * 127 / 100))));
    syn.Event(0x90, uint8_t(note), 110);
    size_t on = size_t(duration_ms) * rate / 1000;
    out.assign(on + rate / 5, 0);
    syn.Render(out.data(), int(on), 1.f);
    syn.Event(0x80, uint8_t(note), 0);
    syn.Render(out.data() + on, int(out.size() - on), 1.f);
}

} // namespace j2mewp
