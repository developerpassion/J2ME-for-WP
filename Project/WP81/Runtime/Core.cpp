#include "pch.h"
#include "Core.h"
#include "../../W10M/App/AppState.h"
#include "../../W10M/App/AudioEngine.h"
#include "../../W10M/App/DeviceEngine.h"
#include "jvm_host.h"

using namespace J2MEWPRuntime;
using namespace Platform;
using namespace Windows::Foundation::Collections;
using J2MEW10M::ToStr;
using J2MEW10M::ToUtf8;

namespace
{
    int lastW = 0, lastH = 0;   // LCD size of the last CopyFrame (0 = force a copy)
    // jvm_host_lcd() clears its dirty flag on every call; the size getters below
    // call it too, so remember a change they saw for the next CopyFrame.
    volatile long pendingDirty = 0;
    const unsigned int* PeekLcd(int* w, int* h)
    {
        int d = 0;
        const unsigned int* px = jvm_host_lcd(w, h, &d);
        if (d) InterlockedExchange(&pendingDirty, 1);
        return px;
    }
    std::mutex g_errMutex;
    std::string g_lastError;

    std::wstring W(String^ s) { return s ? std::wstring(s->Data(), s->Length()) : std::wstring(); }

    GameEntry^ ToEntry(const j2mewp::GameInfo& g)
    {
        auto e = ref new GameEntry();
        e->Id = ToStr(g.id);
        e->Name = ToStr(g.name);
        e->Vendor = ToStr(g.vendor);
        e->Version = ToStr(g.version);
        e->IconPath = ToStr(g.icon);
        e->JarPath = ToStr(g.jar);
        e->Added = g.added;
        return e;
    }
}

void Core::Init()
{
    J2MEW10M::AppInitCore();
#ifdef NDEBUG
    J2MEW10M::AppLog("[ui] native build: Release");
#else
    J2MEW10M::AppLog("[ui] native build: DEBUG (unoptimized VM, slow)");
#endif
}

String^ Core::Version() { return ToStr(std::string(jvm_host_version())); }

void Core::Log(String^ line) { J2MEW10M::AppLog(ToUtf8(line)); }

String^ Core::LogPath() { return ToStr(J2MEW10M::LocalPath() + L"\\j2me.log"); }

IVector<GameEntry^>^ Core::ListGames()
{
    auto v = ref new Platform::Collections::Vector<GameEntry^>();
    for (const auto& g : J2MEW10M::Library().List()) v->Append(ToEntry(g));
    return v;
}

GameEntry^ Core::Install(String^ jarPath, String^ jadText)
{
    j2mewp::GameInfo info;
    std::string err;
    if (!J2MEW10M::Library().Install(W(jarPath), ToUtf8(jadText), &info, &err))
    {
        std::lock_guard<std::mutex> lk(g_errMutex);
        g_lastError = err.empty() ? "install failed" : err;
        J2MEW10M::AppLog("[ui] install failed: " + g_lastError);
        return nullptr;
    }
    J2MEW10M::AppLog("[ui] installed " + info.name);
    return ToEntry(info);
}

String^ Core::LastError::get()
{
    std::lock_guard<std::mutex> lk(g_errMutex);
    return ToStr(g_lastError);
}

bool Core::Remove(String^ id) { return J2MEW10M::Library().Remove(W(id)); }

GameSettings^ Core::LoadSettings(String^ id)
{
    j2mewp::GameSettings s = J2MEW10M::Library().LoadSettings(W(id));
    auto r = ref new GameSettings();
    r->Width = s.width; r->Height = s.height; r->KeepAspect = s.keepAspect;
    r->Background = (int)s.background; r->ScalePercent = s.scalePercent;
    r->Orientation = s.orientation; r->Gravity = s.gravity; r->ScaleType = s.scaleType;
    r->Filter = s.filter; r->ShowFps = s.showFps; r->LimitFps = s.limitFps;
    r->ShowKeypad = s.showKeypad; r->ShowTitle = s.showTitle; r->HeapMB = s.heapMB; r->PadPos = s.padPos;
    return r;
}

void Core::SaveSettings(String^ id, GameSettings^ r)
{
    if (!r) return;
    j2mewp::GameSettings s;
    s.width = r->Width; s.height = r->Height; s.keepAspect = r->KeepAspect;
    s.background = (unsigned int)r->Background & 0xFFFFFF; s.scalePercent = r->ScalePercent;
    s.orientation = r->Orientation; s.gravity = r->Gravity; s.scaleType = r->ScaleType;
    s.filter = r->Filter; s.showFps = r->ShowFps; s.limitFps = r->LimitFps;
    s.showKeypad = r->ShowKeypad; s.showTitle = r->ShowTitle; s.heapMB = r->HeapMB; s.padPos = r->PadPos;
    J2MEW10M::Library().SaveSettings(W(id), s);
}

bool Core::Start(String^ id)
{
    j2mewp::GameInfo g;
    if (!J2MEW10M::Library().Get(W(id), &g))
    {
        J2MEW10M::AppLog("[ui] start: unknown game");
        return false;
    }
    if (jvm_host_is_running())
    {
        J2MEW10M::AppLog("[ui] start: a game is still running");
        return false;
    }
    j2mewp::GameSettings s = J2MEW10M::Library().LoadSettings(g.id);
    jvm_host_set_lcd_size(s.width, s.height);
    lastW = lastH = 0;   // new page / bitmap: copy the first frame
    J2MEW10M::AppSetJavaHeap(s.heapMB);
    J2MEW10M::AppLog("[ui] run " + g.name + " (" + g.midletClass + ") " +
                     std::to_string(s.width) + "x" + std::to_string(s.height));
    return jvm_host_run_jar(g.jar.c_str(), g.midletClass.c_str()) == 0;
}

bool Core::Stop(int timeoutMs)
{
    bool ok = jvm_host_stop(timeoutMs) != 0;
    AudioEngine_CloseAll();
    DeviceEngine_Reset();
    return ok;
}

void Core::Pause() { jvm_host_pause(); AudioEngine_Suspend(true); }
void Core::Resume() { AudioEngine_Suspend(false); jvm_host_resume(); }

bool Core::IsRunning::get() { return jvm_host_is_running() != 0; }
int64 Core::FrameCount::get() { return jvm_host_frame_count(); }

void Core::Tick() { jvm_host_tick((unsigned int)GetTickCount64()); }

// For the D3D LCD (LcdSurface.cpp): current LCD and whether it changed since the last
// call, merging changes seen by the size getters. Any thread.
const unsigned int* J2MEWPRuntime_TakeLcd(int* w, int* h, int* dirty)
{
    int d = 0;
    const unsigned int* px = jvm_host_lcd(w, h, &d);
    if (InterlockedExchange(&pendingDirty, 0)) d = 1;
    *dirty = d;
    return px;
}

int Core::LcdWidth::get() { int w = 0, h = 0; PeekLcd(&w, &h); return w; }
int Core::LcdHeight::get() { int w = 0, h = 0; PeekLcd(&w, &h); return h; }

bool Core::CopyFrame(WriteOnlyArray<int>^ dst)
{
    int w = 0, h = 0, dirty = 0;
    const unsigned int* px = jvm_host_lcd(&w, &h, &dirty);
    if (!px || !dst || w <= 0 || h <= 0) return false;
    // same picture: keep the bitmap as it is (the caller recreates it, and forces
    // a copy, only when the LCD size changes)
    if (InterlockedExchange(&pendingDirty, 0)) dirty = 1;
    if (!dirty && w == lastW && h == lastH) return false;
    lastW = w; lastH = h;
    unsigned int n = (unsigned int)w * (unsigned int)h;
    if (dst->Length < n) n = dst->Length;
    int* out = dst->Data;
    for (unsigned int i = 0; i < n; ++i) out[i] = (int)(px[i] | 0xFF000000u);   // opaque = premultiplied
    return dirty != 0;
}

void Core::Key(int midpKey, bool pressed) { jvm_host_key(midpKey, pressed ? 1 : 0); }
void Core::Pointer(int x, int y, int type) { jvm_host_pointer(x, y, type); }

bool Core::KeepScreenOn::get() { return DeviceEngine_WantsLight(); }void Core::StopAllSounds() { AudioEngine_CloseAll(); }

#ifdef J2MEWP_WP80
extern "C" void j2mewp_font_atlas_add(int px, int bold, int ascent, int descent,
                                      const int* records, int recordInts,
                                      const unsigned char* alpha, int alphaLen);   // WP80/FontEngine80.cpp
#endif

void Core::SetFontGlyphs(int px, bool bold, int ascent, int descent,
                         const Array<int>^ records, const Array<uint8>^ alpha)
{
#ifdef J2MEWP_WP80
    if (!records || !alpha) return;
    j2mewp_font_atlas_add(px, bold ? 1 : 0, ascent, descent, records->Data, (int)records->Length,
                          alpha->Data, (int)alpha->Length);
#else
    (void)px; (void)bold; (void)ascent; (void)descent; (void)records; (void)alpha;
#endif
}

#ifdef J2MEWP_WP80
extern "C" int j2mewp_font_take_requests(int* out, int max);   // WP80/FontEngine80.cpp
extern "C" void j2mewp_font_glyph_add(int px, int bold, const int* rec, const unsigned char* alpha, int alphaLen);
#endif

Array<int>^ Core::TakeFontRequests()
{
#ifdef J2MEWP_WP80
    int buf[3 * 64];
    int n = j2mewp_font_take_requests(buf, 3 * 64);
    auto a = ref new Array<int>(n);
    for (int i = 0; i < n; i++) a[i] = buf[i];
    return a;
#else
    return ref new Array<int>(0);
#endif
}

void Core::AddFontGlyph(int px, bool bold, const Array<int>^ rec, const Array<uint8>^ alpha)
{
#ifdef J2MEWP_WP80
    if (!rec || rec->Length < 6) return;
    j2mewp_font_glyph_add(px, bold ? 1 : 0, rec->Data, alpha ? alpha->Data : nullptr, alpha ? (int)alpha->Length : 0);
#else
    (void)px; (void)bold; (void)rec; (void)alpha;
#endif
}

bool Core::HasHostFonts::get()
{
#ifdef J2MEWP_WP80
    return false;
#else
    return true;
#endif
}
