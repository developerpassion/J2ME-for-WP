// J2MEWP WP8.0: no DirectWrite on Windows Phone 8.0. The C# app renders the glyphs
// it needs (Latin + Vietnamese, regular/bold, MIDP sizes 12/14/16 px) with the
// phone's own font (Silverlight, "Segoe WP") once, caches them, and hands them over
// through Core::SetFontGlyphs -> j2mewp_font_atlas_add(). Until then (or for a
// size/style not sent) MIDP keeps its built-in Latin bitmap font.
//
// Characters outside that set (Chinese, Japanese, Korean, Thai...) are rendered on
// demand: the VM thread queues a request and waits a little (kRequestWaitMs) while
// the app's UI thread renders it (Core::TakeFontRequests / Core::AddFontGlyph, see
// FontAtlas.cs) and caches it on disk. A glyph that does not arrive in time is drawn
// as '?' and shows up at the next repaint once it is there.
// Replaces W10M/App/FontEngine.cpp in the WP8.0 runtime component. Builds with VS2012.
#include <windows.h>
#include <chrono>
#include <condition_variable>
#include <list>
#include <map>
#include <mutex>
#include <set>
#include <vector>
#include "../W10M/App/FontEngine.h"
#include "../Shared/javacall_winphone/src/winphone_port.h"

extern "C" void jvm_host_log_line(const char* line);   // Shared/host/jvm_host.cpp

namespace
{
    const int kRequestWaitMs = 100;

    struct Glyph { int w, h, left, top, adv; const unsigned char* data; };

    struct Face
    {
        int ascent, descent;
        std::map<unsigned int, Glyph> glyphs;
        std::vector<unsigned char> alpha;                 // atlas bitmaps (set once)
        std::list<std::vector<unsigned char> > extra;     // on-demand bitmaps (stable addresses)
        Face() : ascent(0), descent(0) {}
    };

    std::mutex g_lock;
    std::condition_variable g_arrived;
    std::map<int, Face> g_faces;     // key = px * 2 + bold
    bool g_backendSet = false;
    std::vector<int> g_requests;     // (px, bold, codepoint) triples not yet taken by the app
    std::set<long long> g_asked;     // (face key, codepoint) ever requested: ask only once

    // nearest size that was sent, same weight if possible
    int FindFaceKey(int px, int style)
    {
        int bold = (style & 1) ? 1 : 0;
        int best = -1;
        int bestScore = 1 << 30;
        for (std::map<int, Face>::const_iterator it = g_faces.begin(); it != g_faces.end(); ++it)
        {
            int fpx = it->first / 2, fb = it->first % 2;
            int score = (fpx > px ? fpx - px : px - fpx) * 4 + (fb != bold ? 1 : 0);
            if (score < bestScore) { bestScore = score; best = it->first; }
        }
        return best;
    }

    int B_Metrics(int px, int style, int* ascent, int* descent, int* leading)
    {
        std::lock_guard<std::mutex> lk(g_lock);
        int key = FindFaceKey(px, style);
        if (key < 0) return 0;
        const Face& f = g_faces[key];
        *ascent = f.ascent;
        *descent = f.descent;
        *leading = 0;
        return 1;
    }

    int B_Glyph(unsigned int cp, int px, int style, WinphoneGlyph* out)
    {
        std::unique_lock<std::mutex> lk(g_lock);
        int key = FindFaceKey(px, style);
        if (key < 0) return 0;
        Face& f = g_faces[key];
        std::map<unsigned int, Glyph>::const_iterator it = f.glyphs.find(cp);
        if (it == f.glyphs.end() && cp > 0x20 && cp <= 0x10FFFF)
        {
            long long id = ((long long)key << 32) | cp;
            if (g_asked.insert(id).second)
            {
                // first time: ask the app and give it a moment (it renders on its UI thread)
                g_requests.push_back(key / 2);
                g_requests.push_back(key % 2);
                g_requests.push_back((int)cp);
                g_arrived.wait_for(lk, std::chrono::milliseconds(kRequestWaitMs));
                it = f.glyphs.find(cp);
            }
        }
        if (it == f.glyphs.end()) it = f.glyphs.find('?');
        if (it == f.glyphs.end()) return 0;
        const Glyph& g = it->second;
        out->width = g.w;
        out->height = g.h;
        out->left = g.left;
        out->top = g.top;
        out->advance = g.adv;
        out->alpha = g.w > 0 && g.h > 0 ? g.data : 0;
        return 1;
    }

    const WinphoneFontBackend g_backend = { B_Metrics, B_Glyph };
}

void FontEngine_Init()
{
    jvm_host_log_line("[font] WP8.0: waiting for the glyph atlas from the app (MIDP bitmap font until then)");
}

// records: 6 ints per glyph = codepoint, width, height, left, top, advance; alpha bytes follow
// each other in record order. Called on the UI thread before a game starts.
extern "C" void j2mewp_font_atlas_add(int px, int bold, int ascent, int descent,
                                      const int* records, int recordInts,
                                      const unsigned char* alpha, int alphaLen)
{
    std::lock_guard<std::mutex> lk(g_lock);
    Face& f = g_faces[px * 2 + (bold ? 1 : 0)];
    f.ascent = ascent;
    f.descent = descent;
    f.alpha.assign(alpha, alpha + (alphaLen > 0 ? alphaLen : 0));
    size_t off = 0;
    unsigned count = 0;
    for (int i = 0; i + 6 <= recordInts; i += 6)
    {
        Glyph g;
        g.w = records[i + 1]; g.h = records[i + 2];
        g.left = records[i + 3]; g.top = records[i + 4]; g.adv = records[i + 5];
        size_t n = (size_t)(g.w > 0 ? g.w : 0) * (size_t)(g.h > 0 ? g.h : 0);
        if (off + n > f.alpha.size()) break;   // malformed: stop here
        g.data = n ? &f.alpha[off] : 0;
        off += n;
        f.glyphs[(unsigned int)records[i]] = g;
        ++count;
    }
    if (!g_backendSet)
    {
        winphone_font_set_backend(&g_backend);
        g_backendSet = true;
    }
    char buf[96];
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[font] atlas %dpx%s: %u glyphs", px, bold ? " bold" : "", count);
    jvm_host_log_line(buf);
}

// Requests the VM made since the last call: (px, bold, codepoint) triples into out
// (max ints). Returns the number of ints written. UI thread.
extern "C" int j2mewp_font_take_requests(int* out, int max)
{
    std::lock_guard<std::mutex> lk(g_lock);
    int n = (int)g_requests.size();
    if (n > max) n = max - max % 3;
    for (int i = 0; i < n; i++) out[i] = g_requests[i];
    g_requests.erase(g_requests.begin(), g_requests.begin() + n);
    return n;
}

// One on-demand glyph (same record layout as the atlas). Also used to load the
// app's on-disk cache of earlier on-demand glyphs. UI thread.
extern "C" void j2mewp_font_glyph_add(int px, int bold, const int* rec,
                                      const unsigned char* alpha, int alphaLen)
{
    {
        std::lock_guard<std::mutex> lk(g_lock);
        std::map<int, Face>::iterator fit = g_faces.find(px * 2 + (bold ? 1 : 0));
        if (fit == g_faces.end()) return;   // no atlas for this size: nothing to attach to
        Face& f = fit->second;
        Glyph g;
        g.w = rec[1]; g.h = rec[2]; g.left = rec[3]; g.top = rec[4]; g.adv = rec[5];
        size_t n = (size_t)(g.w > 0 ? g.w : 0) * (size_t)(g.h > 0 ? g.h : 0);
        if ((size_t)(alphaLen > 0 ? alphaLen : 0) < n) return;
        g.data = 0;
        if (n)
        {
            f.extra.push_back(std::vector<unsigned char>(alpha, alpha + n));
            g.data = &f.extra.back()[0];
        }
        f.glyphs[(unsigned int)rec[0]] = g;
    }
    g_arrived.notify_all();
}
