#include "pch.h"
#undef min
#undef max
#include <algorithm>
#include <cstdarg>
#include "AudioEngine.h"
#include "../../../phoneME_feature/midp/src/media/include/j2mewp_audio.h"
#include "../../Shared/audio/midi_synth.h"

#include <xaudio2.h>
#ifndef J2MEWP_WP80   // WP8.0 has no Media Foundation source reader: no MP3/AMR
#include <mfapi.h>
#include <mfidl.h>
#include <mfreadwrite.h>
#endif
#include <map>
#include <memory>
#include <vector>

#pragma comment(lib, "xaudio2.lib")
#ifndef J2MEWP_WP80
#pragma comment(lib, "mfplat.lib")
#pragma comment(lib, "mfreadwrite.lib")
#pragma comment(lib, "mfuuid.lib")
#endif

using Microsoft::WRL::ComPtr;

extern "C" void jvm_host_log_line(const char* line);

namespace {

const int kSynthRate = 22050;

void Log(const char* fmt, ...)
{
    char buf[256];
    va_list ap;
    va_start(ap, fmt);
    _vsnprintf_s(buf, sizeof(buf), _TRUNCATE, fmt, ap);
    va_end(ap);
    jvm_host_log_line(buf);
}

struct Clip
{
    std::vector<uint8_t> fmt;      // WAVEFORMATEX (+ extra)
    std::vector<uint8_t> data;     // audio bytes in that format
    IXAudio2SourceVoice* voice;
    uint32_t totalSamples;
    uint32_t startSample;          // resume position (PCM only)
    uint32_t blockAlign;
    bool pcm;
    float volume;

    // (no member initializers / make_unique: VS2012 for WP8.0)
    Clip() : voice(nullptr), totalSamples(0), startSample(0), blockAlign(1), pcm(true), volume(1.f) {}

    const WAVEFORMATEX* wfx() const { return reinterpret_cast<const WAVEFORMATEX*>(fmt.data()); }
};

ComPtr<IXAudio2> g_xa;
IXAudio2MasteringVoice* g_master = nullptr;
std::mutex g_mutex;
std::map<int, std::unique_ptr<Clip>> g_clips;
std::vector<std::unique_ptr<Clip>> g_tones;   // fire-and-forget
int g_next = 1;
bool g_mfReady = false;

// ---- decoding --------------------------------------------------------------

void MakePcmFormat(Clip& c, int rate, int channels)
{
    WAVEFORMATEX w = {};
    w.wFormatTag = WAVE_FORMAT_PCM;
    w.nChannels = WORD(channels);
    w.nSamplesPerSec = DWORD(rate);
    w.wBitsPerSample = 16;
    w.nBlockAlign = WORD(2 * channels);
    w.nAvgBytesPerSec = w.nSamplesPerSec * w.nBlockAlign;
    c.fmt.assign(reinterpret_cast<uint8_t*>(&w), reinterpret_cast<uint8_t*>(&w) + sizeof(w));
    c.blockAlign = w.nBlockAlign;
    c.pcm = true;
    c.totalSamples = uint32_t(c.data.size() / c.blockAlign);
}

// IMA ADPCM (0x11) -> PCM16; XAudio2 does not decode it.
bool DecodeImaAdpcm(const WAVEFORMATEX* w, const uint8_t* src, size_t len, std::vector<uint8_t>& out)
{
    static const int steps[89] = {
        7,8,9,10,11,12,13,14,16,17,19,21,23,25,28,31,34,37,41,45,50,55,60,66,73,80,88,97,107,118,
        130,143,157,173,190,209,230,253,279,307,337,371,408,449,494,544,598,658,724,796,876,963,
        1060,1166,1282,1411,1552,1707,1878,2066,2272,2499,2749,3024,3327,3660,4026,4428,4871,5358,
        5894,6484,7132,7845,8630,9493,10442,11487,12635,13899,15289,16818,18500,20350,22385,24623,
        27086,29794,32767 };
    static const int idx_adj[16] = { -1,-1,-1,-1,2,4,6,8,-1,-1,-1,-1,2,4,6,8 };
    int ch = w->nChannels, block = w->nBlockAlign;
    if (ch < 1 || ch > 2 || block < 4 * ch) return false;
    int spb = (block - 4 * ch) * 8 / (4 * ch) + 1;     // samples per block per channel
    out.clear();
    std::vector<int16_t> blk(size_t(spb) * ch);
    for (size_t off = 0; off + size_t(block) <= len; off += block) {
        const uint8_t* b = src + off;
        int pred[2], idx[2];
        for (int c = 0; c < ch; c++) {
            pred[c] = int16_t(b[4 * c] | (b[4 * c + 1] << 8));
            idx[c] = std::min(88, std::max(0, int(b[4 * c + 2])));
            blk[c] = int16_t(pred[c]);
        }
        const uint8_t* p = b + 4 * ch;
        int s = 1;
        while (s < spb) {
            for (int c = 0; c < ch; c++) {
                for (int k = 0; k < 8 && s + k < spb; k++) {
                    int nib = (p[k / 2] >> ((k & 1) * 4)) & 0xF;
                    int step = steps[idx[c]];
                    int diff = step >> 3;
                    if (nib & 1) diff += step >> 2;
                    if (nib & 2) diff += step >> 1;
                    if (nib & 4) diff += step;
                    if (nib & 8) diff = -diff;
                    pred[c] = std::max(-32768, std::min(32767, pred[c] + diff));
                    idx[c] = std::max(0, std::min(88, idx[c] + idx_adj[nib]));
                    blk[size_t(s + k) * ch + c] = int16_t(pred[c]);
                }
                p += 4;
            }
            s += 8;
        }
        const uint8_t* bp = reinterpret_cast<const uint8_t*>(blk.data());
        out.insert(out.end(), bp, bp + blk.size() * 2);
    }
    return !out.empty();
}

bool LoadWav(const uint8_t* d, size_t len, Clip& c)
{
    if (len < 12 || memcmp(d, "RIFF", 4) != 0 || memcmp(d + 8, "WAVE", 4) != 0) return false;
    const uint8_t* fmt = nullptr; size_t fmtLen = 0;
    const uint8_t* data = nullptr; size_t dataLen = 0;
    size_t pos = 12;
    while (pos + 8 <= len) {
        uint32_t sz = d[pos + 4] | (d[pos + 5] << 8) | (d[pos + 6] << 16) | (uint32_t(d[pos + 7]) << 24);
        const uint8_t* body = d + pos + 8;
        size_t avail = std::min<size_t>(sz, len - pos - 8);   // tolerate truncated files
        if (memcmp(d + pos, "fmt ", 4) == 0) { fmt = body; fmtLen = avail; }
        else if (memcmp(d + pos, "data", 4) == 0) { data = body; dataLen = avail; }
        pos += 8 + sz + (sz & 1);
    }
    if (!fmt || fmtLen < 16 || !data) return false;
    WAVEFORMATEX w = {};
    memcpy(&w, fmt, std::min(fmtLen, sizeof(w)));
    if (fmtLen < sizeof(w)) w.cbSize = 0;

    if (w.wFormatTag == 0x11) {                       // IMA ADPCM
        if (!DecodeImaAdpcm(&w, data, dataLen, c.data)) return false;
        MakePcmFormat(c, int(w.nSamplesPerSec), w.nChannels);
        return true;
    }
    if (w.wFormatTag == WAVE_FORMAT_PCM && w.wBitsPerSample == 8) {   // 8-bit -> 16-bit
        c.data.resize(dataLen * 2);
        int16_t* o = reinterpret_cast<int16_t*>(c.data.data());
        for (size_t i = 0; i < dataLen; i++) o[i] = int16_t((int(data[i]) - 128) << 8);
        MakePcmFormat(c, int(w.nSamplesPerSec), w.nChannels);
        return true;
    }
    if (w.wFormatTag == WAVE_FORMAT_PCM) {
        w.nBlockAlign = WORD(w.nChannels * w.wBitsPerSample / 8);
        w.nAvgBytesPerSec = w.nSamplesPerSec * w.nBlockAlign;
        c.fmt.assign(reinterpret_cast<uint8_t*>(&w), reinterpret_cast<uint8_t*>(&w) + sizeof(WAVEFORMATEX));
        reinterpret_cast<WAVEFORMATEX*>(c.fmt.data())->cbSize = 0;
        c.blockAlign = std::max<uint32_t>(1, w.nBlockAlign);
        size_t usable = dataLen - dataLen % c.blockAlign;
        c.data.assign(data, data + usable);
        c.pcm = true;
        c.totalSamples = uint32_t(usable / c.blockAlign);
        return true;
    }
    // Other formats (MS ADPCM...): let XAudio2 handle them as-is.
    c.fmt.assign(fmt, fmt + fmtLen);
    c.data.assign(data, data + dataLen);
    c.blockAlign = std::max<uint32_t>(1, w.nBlockAlign);
    c.pcm = false;
    c.totalSamples = 0;
    return true;
}

bool LoadMidi(const uint8_t* d, size_t len, Clip& c)
{
    std::vector<int16_t> pcm;
    if (!j2mewp::RenderMidi(d, len, kSynthRate, pcm)) return false;
    const uint8_t* b = reinterpret_cast<const uint8_t*>(pcm.data());
    c.data.assign(b, b + pcm.size() * 2);
    MakePcmFormat(c, kSynthRate, 1);
    return true;
}

// MP3 / AMR (if a decoder exists): Media Foundation source reader -> PCM16.
#ifdef J2MEWP_WP80
bool LoadMf(const uint8_t*, size_t, Clip&) { return false; }
#else
bool LoadMf(const uint8_t* d, size_t len, Clip& c)
{
    using namespace Windows::Storage::Streams;
    if (!g_mfReady) return false;
    CoInitializeEx(nullptr, COINIT_MULTITHREADED);   // VM thread: MF needs COM (ignore "already")
    try {
        auto ras = ref new InMemoryRandomAccessStream();
        auto writer = ref new DataWriter(ras);
        writer->WriteBytes(ref new Platform::Array<uint8_t>(const_cast<uint8_t*>(d), unsigned(len)));
        concurrency::create_task(writer->StoreAsync()).get();
        writer->DetachStream();
        ras->Seek(0);

        ComPtr<IMFByteStream> bs;
        if (FAILED(MFCreateMFByteStreamOnStreamEx(reinterpret_cast<IUnknown*>(ras), &bs))) return false;
        ComPtr<IMFSourceReader> rd;
        if (FAILED(MFCreateSourceReaderFromByteStream(bs.Get(), nullptr, &rd))) return false;
        ComPtr<IMFMediaType> want;
        MFCreateMediaType(&want);
        want->SetGUID(MF_MT_MAJOR_TYPE, MFMediaType_Audio);
        want->SetGUID(MF_MT_SUBTYPE, MFAudioFormat_PCM);
        want->SetUINT32(MF_MT_AUDIO_BITS_PER_SAMPLE, 16);
        if (FAILED(rd->SetCurrentMediaType(DWORD(MF_SOURCE_READER_FIRST_AUDIO_STREAM), nullptr, want.Get())))
            return false;
        ComPtr<IMFMediaType> got;
        rd->GetCurrentMediaType(DWORD(MF_SOURCE_READER_FIRST_AUDIO_STREAM), &got);
        UINT32 rate = 0, chans = 0;
        got->GetUINT32(MF_MT_AUDIO_SAMPLES_PER_SECOND, &rate);
        got->GetUINT32(MF_MT_AUDIO_NUM_CHANNELS, &chans);
        if (!rate || !chans) return false;
        c.data.clear();
        for (;;) {
            DWORD flags = 0;
            ComPtr<IMFSample> s;
            if (FAILED(rd->ReadSample(DWORD(MF_SOURCE_READER_FIRST_AUDIO_STREAM), 0, nullptr, &flags, nullptr, &s)))
                break;
            if (flags & MF_SOURCE_READERF_ENDOFSTREAM) break;
            if (!s) continue;
            ComPtr<IMFMediaBuffer> buf;
            if (FAILED(s->ConvertToContiguousBuffer(&buf))) break;
            BYTE* p = nullptr; DWORD n = 0;
            if (SUCCEEDED(buf->Lock(&p, nullptr, &n))) {
                c.data.insert(c.data.end(), p, p + n);
                buf->Unlock();
            }
        }
        if (c.data.empty()) return false;
        MakePcmFormat(c, int(rate), int(chans));
        return true;
    } catch (Platform::Exception^) {
        return false;
    }
}
#endif

// ---- voices -------------------------------------------------------------------

void DestroyVoice(Clip& c)
{
    if (c.voice) { c.voice->DestroyVoice(); c.voice = nullptr; }
}

uint32_t PlayedPos(Clip& c)
{
    if (!c.voice || !c.pcm || !c.totalSamples) return c.startSample;
    XAUDIO2_VOICE_STATE st;
    c.voice->GetState(&st, 0);
    return uint32_t((c.startSample + st.SamplesPlayed) % c.totalSamples);
}

bool Playing(Clip& c)
{
    if (!c.voice) return false;
    XAUDIO2_VOICE_STATE st;
    c.voice->GetState(&st, XAUDIO2_VOICE_NOSAMPLESPLAYED);
    return st.BuffersQueued > 0;
}

bool StartVoice(Clip& c, int loops)
{
    DestroyVoice(c);
    if (!g_xa || c.data.empty()) return false;
    if (FAILED(g_xa->CreateSourceVoice(&c.voice, c.wfx()))) { c.voice = nullptr; return false; }
    c.voice->SetVolume(c.volume);
    XAUDIO2_BUFFER b = {};
    b.Flags = XAUDIO2_END_OF_STREAM;
    b.AudioBytes = UINT32(c.data.size());
    b.pAudioData = c.data.data();
    if (c.pcm && c.startSample < c.totalSamples) b.PlayBegin = c.startSample;
    if (loops < 0 || loops > 1) {
        b.LoopBegin = 0;
        b.LoopLength = 0;
        b.LoopCount = loops < 0 ? XAUDIO2_LOOP_INFINITE : UINT32(std::min(loops - 1, 254));
        if (b.PlayBegin) { b.LoopBegin = 0; }
    }
    if (FAILED(c.voice->SubmitSourceBuffer(&b))) {
        // e.g. PlayBegin with loop region constraints: retry from the start
        b.PlayBegin = 0;
        c.startSample = 0;
        if (FAILED(c.voice->SubmitSourceBuffer(&b))) { DestroyVoice(c); return false; }
    }
    c.voice->Start();
    return true;
}

Clip* Find(int h)
{
    auto it = g_clips.find(h);
    return it == g_clips.end() ? nullptr : it->second.get();
}

void ReapTones()
{
    g_tones.erase(std::remove_if(g_tones.begin(), g_tones.end(), [](std::unique_ptr<Clip>& c) {
        if (Playing(*c)) return false;
        DestroyVoice(*c);
        return true;
    }), g_tones.end());
}

// ---- backend -------------------------------------------------------------------

int B_Create(const unsigned char* data, int len, int kind)
{
    auto c = std::unique_ptr<Clip>(new Clip());
    bool ok = false;
    switch (kind) {
        case 1: ok = LoadWav(data, size_t(len), *c); break;
        case 2: ok = LoadMidi(data, size_t(len), *c); break;
        case 3: case 4: ok = LoadMf(data, size_t(len), *c); break;
    }
    Log("[audio] create kind=%d len=%d -> %s (%u bytes pcm)", kind, len, ok ? "ok" : "unsupported",
        unsigned(c->data.size()));
    if (!ok) return 0;
    std::lock_guard<std::mutex> lk(g_mutex);
    int h = g_next++;
    g_clips[h] = std::move(c);
    return h;
}

void B_Start(int h, int loops)
{
    std::lock_guard<std::mutex> lk(g_mutex);
    ReapTones();
    if (Clip* c = Find(h)) {
        if (c->voice && !Playing(*c)) c->startSample = 0;  // previous run reached the end
        StartVoice(*c, loops);
    }
}

void B_Stop(int h)
{
    std::lock_guard<std::mutex> lk(g_mutex);
    if (Clip* c = Find(h)) {
        if (c->voice) {
            c->startSample = Playing(*c) ? PlayedPos(*c) : 0;
            DestroyVoice(*c);
        }
    }
}

void B_Close(int h)
{
    std::lock_guard<std::mutex> lk(g_mutex);
    if (Clip* c = Find(h)) {
        DestroyVoice(*c);
        g_clips.erase(h);
    }
}

void B_SetVolume(int h, int level)
{
    std::lock_guard<std::mutex> lk(g_mutex);
    if (Clip* c = Find(h)) {
        float v = std::max(0, std::min(100, level)) / 100.f;
        c->volume = v * v;     // perceptual-ish curve
        if (c->voice) c->voice->SetVolume(c->volume);
    }
}

int B_IsPlaying(int h)
{
    std::lock_guard<std::mutex> lk(g_mutex);
    Clip* c = Find(h);
    return c && Playing(*c) ? 1 : 0;
}

int B_GetTime(int h)
{
    std::lock_guard<std::mutex> lk(g_mutex);
    Clip* c = Find(h);
    if (!c || !c->pcm) return -1;
    return int(uint64_t(PlayedPos(*c)) * 1000 / c->wfx()->nSamplesPerSec);
}

int B_GetDuration(int h)
{
    std::lock_guard<std::mutex> lk(g_mutex);
    Clip* c = Find(h);
    if (!c || !c->pcm) return -1;
    return int(uint64_t(c->totalSamples) * 1000 / c->wfx()->nSamplesPerSec);
}

void B_SetTime(int h, int ms)
{
    std::lock_guard<std::mutex> lk(g_mutex);
    Clip* c = Find(h);
    if (!c || !c->pcm) return;
    uint32_t s = uint32_t(uint64_t(std::max(0, ms)) * c->wfx()->nSamplesPerSec / 1000);
    c->startSample = s < c->totalSamples ? s : 0;
}

void B_Tone(int note, int duration_ms, int volume)
{
    auto c = std::unique_ptr<Clip>(new Clip());
    std::vector<int16_t> pcm;
    j2mewp::RenderTone(note, std::max(1, std::min(duration_ms, 5000)), volume, kSynthRate, pcm);
    const uint8_t* b = reinterpret_cast<const uint8_t*>(pcm.data());
    c->data.assign(b, b + pcm.size() * 2);
    MakePcmFormat(*c, kSynthRate, 1);
    std::lock_guard<std::mutex> lk(g_mutex);
    ReapTones();
    if (StartVoice(*c, 1)) g_tones.push_back(std::move(c));
}

const J2mewpAudioBackend g_backend = {
    B_Create, B_Start, B_Stop, B_Close, B_SetVolume, B_IsPlaying,
    B_GetTime, B_GetDuration, B_SetTime, B_Tone
};

} // namespace

void AudioEngine_Init()
{
    HRESULT hr = XAudio2Create(&g_xa, 0, XAUDIO2_DEFAULT_PROCESSOR);
    if (SUCCEEDED(hr)) hr = g_xa->CreateMasteringVoice(&g_master);
    if (FAILED(hr)) {
        Log("[audio] XAudio2 init failed 0x%08x", unsigned(hr));
        g_xa.Reset();
        return;
    }
#ifndef J2MEWP_WP80
    g_mfReady = SUCCEEDED(MFStartup(MF_VERSION, MFSTARTUP_LITE));
#endif
    j2mewp_audio_set_backend(&g_backend);
    Log("[audio] XAudio2 ready, MF=%d", g_mfReady ? 1 : 0);
}

// The MIDlet ended (exit or stop): players it did not close itself would keep
// playing over the next game, so drop every clip and tone.
void AudioEngine_CloseAll()
{
    std::lock_guard<std::mutex> lk(g_mutex);
    size_t n = g_clips.size() + g_tones.size();
    for (auto& kv : g_clips) DestroyVoice(*kv.second);
    g_clips.clear();
    for (auto& t : g_tones) DestroyVoice(*t);
    g_tones.clear();
    if (n) Log("[audio] closed %u leftover sound(s)", unsigned(n));
}

void AudioEngine_Suspend(bool suspended)
{
    if (!g_xa) return;
    if (suspended) g_xa->StopEngine();
    else g_xa->StartEngine();
}
