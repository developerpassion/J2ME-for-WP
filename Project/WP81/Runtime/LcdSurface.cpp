#include "pch.h"
#include "LcdSurface.h"
#include <wrl/implements.h>
#include <string>
#include <cstdio>

namespace J2MEW10M { void AppLog(const std::string& line); }

using namespace J2MEWPRuntime;
using namespace Microsoft::WRL;
using namespace Windows::Phone::Graphics::Interop;

const unsigned int* J2MEWPRuntime_TakeLcd(int* w, int* h, int* dirty);   // Core.cpp

// diagnostics (j2me.log): render-thread steps of the D3D LCD
static void SLog(const char* fmt, int a = 0, int b = 0, int c = 0, int d = 0)
{
    char buf[200];
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, fmt, a, b, c, d);
    J2MEW10M::AppLog(buf);
}

namespace
{
    // COM bridge the DrawingSurface element calls; forwards to LcdSurface.
    class ContentProvider : public RuntimeClass<RuntimeClassFlags<WinRtClassicComMix>,
                                                ABI::Windows::Phone::Graphics::Interop::IDrawingSurfaceContentProvider,
                                                IDrawingSurfaceContentProviderNative>
    {
    public:
        ContentProvider(LcdSurface^ s) : m_surface(s) {}
        HRESULT STDMETHODCALLTYPE Connect(IDrawingSurfaceRuntimeHostNative* host) override
        { return m_surface->Connect(host); }
        void STDMETHODCALLTYPE Disconnect() override { m_surface->Disconnect(); }
        HRESULT STDMETHODCALLTYPE PrepareResources(const LARGE_INTEGER* t, BOOL* dirty) override
        { return m_surface->PrepareResources(t, dirty); }
        HRESULT STDMETHODCALLTYPE GetTexture(const DrawingSurfaceSizeF* size, IDrawingSurfaceSynchronizedTextureNative** synced,
                                             DrawingSurfaceRectF* subRect) override
        { return m_surface->GetTexture(size, synced, subRect); }
    private:
        LcdSurface^ m_surface;
    };
}

LcdSurface::LcdSurface()
    : m_background(0), m_linear(false), m_active(false), m_lastActive(false),
      m_targetW(0), m_targetH(0), m_lastLinear(false), m_pendingUpload(false), m_lastBackground(0xFFFFFFFF), m_shown(0)
{
}

LcdSurface::~LcdSurface() {}

IDrawingSurfaceContentProvider^ LcdSurface::CreateContentProvider()
{
    ComPtr<ContentProvider> provider = Make<ContentProvider>(this);
    return reinterpret_cast<IDrawingSurfaceContentProvider^>(provider.Get());
}

void LcdSurface::SetStyle(int background, bool linear)
{
    std::lock_guard<std::mutex> lk(m_lock);
    m_background = (unsigned int)background & 0xFFFFFF;
    m_linear = linear;
}

void LcdSurface::SetActive(bool active)
{
    std::lock_guard<std::mutex> lk(m_lock);
    m_active = active;
}

int64 LcdSurface::FramesShown::get() { return m_shown; }

HRESULT LcdSurface::Connect(IDrawingSurfaceRuntimeHostNative* host)
{
    m_host = host;
    SLog("[lcd] connect");
    return S_OK;
}

void LcdSurface::Disconnect()
{
    m_synced.Reset(); m_rtv.Reset(); m_target.Reset();
    m_renderer.Release();
    m_context.Reset(); m_device.Reset();
    m_targetW = m_targetH = 0;
    m_host.Reset();
}

bool LcdSurface::CreateDevice()
{
    if (m_device) return true;
    // feature levels down to 9_1: Lumia 520/920/1020 class GPUs
    D3D_FEATURE_LEVEL levels[] = { D3D_FEATURE_LEVEL_11_1, D3D_FEATURE_LEVEL_11_0, D3D_FEATURE_LEVEL_10_1,
                                   D3D_FEATURE_LEVEL_10_0, D3D_FEATURE_LEVEL_9_3, D3D_FEATURE_LEVEL_9_2,
                                   D3D_FEATURE_LEVEL_9_1 };
    ComPtr<ID3D11Device> dev;
    ComPtr<ID3D11DeviceContext> ctx;
    HRESULT hr = D3D11CreateDevice(nullptr, D3D_DRIVER_TYPE_HARDWARE, nullptr, D3D11_CREATE_DEVICE_BGRA_SUPPORT,
                                   levels, ARRAYSIZE(levels), D3D11_SDK_VERSION, &dev, nullptr, &ctx);
    if (FAILED(hr) || FAILED(dev.As(&m_device)) || FAILED(ctx.As(&m_context)))
    {
        SLog("[lcd] D3D device failed 0x%08X", (int)hr);
        m_device.Reset(); m_context.Reset();
        return false;
    }
    SLog("[lcd] device ok, feature level %X", (int)m_device->GetFeatureLevel());
    if (!m_renderer.Init(m_device.Get()))
    {
        SLog("[lcd] renderer init failed (feature level %X)", (int)m_device->GetFeatureLevel());
        return false;
    }
    return true;
}

bool LcdSurface::EnsureTarget(int w, int h)
{
    if (m_synced && w == m_targetW && h == m_targetH) return true;
    m_synced.Reset(); m_rtv.Reset(); m_target.Reset();
    m_targetW = m_targetH = 0;
    if (w <= 0 || h <= 0) return false;
    D3D11_TEXTURE2D_DESC td;
    ZeroMemory(&td, sizeof(td));
    td.Width = (UINT)w; td.Height = (UINT)h;
    td.MipLevels = 1; td.ArraySize = 1;
    td.Format = DXGI_FORMAT_B8G8R8A8_UNORM;
    td.SampleDesc.Count = 1;
    td.Usage = D3D11_USAGE_DEFAULT;
    td.BindFlags = D3D11_BIND_RENDER_TARGET | D3D11_BIND_SHADER_RESOURCE;
    td.MiscFlags = D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX | D3D11_RESOURCE_MISC_SHARED_NTHANDLE;
    HRESULT hr = m_device->CreateTexture2D(&td, nullptr, &m_target);
    if (SUCCEEDED(hr)) hr = m_device->CreateRenderTargetView(m_target.Get(), nullptr, &m_rtv);
    if (SUCCEEDED(hr)) hr = m_host->CreateSynchronizedTexture(m_target.Get(), &m_synced);
    if (FAILED(hr))
    {
        SLog("[lcd] target %dx%d failed 0x%08X", w, h, (int)hr);
        m_synced.Reset(); m_rtv.Reset(); m_target.Reset();
        return false;
    }
    m_targetW = w; m_targetH = h;
    SLog("[lcd] target %dx%d", w, h);
    return true;
}

HRESULT LcdSurface::PrepareResources(const LARGE_INTEGER*, BOOL* isContentDirty)
{
    // GetTexture redraws only when something changed (new MIDlet frame, settings,
    // size); the element still shows the last texture otherwise.
    bool active, linear;
    unsigned int bg;
    {
        std::lock_guard<std::mutex> lk(m_lock);
        active = m_active; linear = m_linear; bg = m_background;
    }
    if (active)
    {
        // TakeLcd consumes the VM's dirty flag: remember it for GetTexture
        int w = 0, h = 0, dirty = 0;
        if (J2MEWPRuntime_TakeLcd(&w, &h, &dirty) && dirty) m_pendingUpload = true;
    }
    *isContentDirty = (m_pendingUpload || active != m_lastActive || linear != m_lastLinear ||
                       bg != m_lastBackground || !m_synced) ? TRUE : FALSE;
    if (m_host) m_host->RequestAdditionalFrame();   // render thread: keep polling for frames
    return S_OK;
}

HRESULT LcdSurface::GetTexture(const DrawingSurfaceSizeF* size, IDrawingSurfaceSynchronizedTextureNative** synced,
                               DrawingSurfaceRectF* subRect)
{
    *synced = nullptr;
    static volatile long first = 0;
    if (InterlockedIncrement(&first) == 1) SLog("[lcd] first GetTexture %dx%d", (int)size->width, (int)size->height);
    if (!CreateDevice()) return E_FAIL;
    int w = (int)(size->width + 0.5f), h = (int)(size->height + 0.5f);
    bool fresh = !m_synced || w != m_targetW || h != m_targetH;
    if (!EnsureTarget(w, h)) return E_FAIL;

    bool active, linear;
    unsigned int bg;
    {
        std::lock_guard<std::mutex> lk(m_lock);
        active = m_active; linear = m_linear; bg = m_background;
    }

    // new MIDlet frame (or a new texture / device: upload whatever the LCD holds)
    int lw = 0, lh = 0, dirty = 0;
    const unsigned int* px = active ? J2MEWPRuntime_TakeLcd(&lw, &lh, &dirty) : nullptr;
    if (px && lw > 0 && lh > 0 && (dirty || m_pendingUpload || fresh || !m_renderer.HasFrame()))
    {
        m_renderer.Upload(m_context.Get(), px, lw, lh);
        InterlockedIncrement64(&m_shown);
    }
    m_pendingUpload = false;
    m_lastActive = active; m_lastLinear = linear; m_lastBackground = bg;

    HRESULT hr = m_synced->BeginDraw();
    if (FAILED(hr)) { SLog("[lcd] BeginDraw failed 0x%08X", (int)hr); return hr; }
    j2mewp::LcdQuad q;
    q.x[0] = 0;        q.y[0] = 0;
    q.x[1] = (float)w; q.y[1] = 0;
    q.x[2] = 0;        q.y[2] = (float)h;
    q.x[3] = (float)w; q.y[3] = (float)h;
    if (active) m_renderer.Draw(m_context.Get(), m_rtv.Get(), w, h, q, linear, bg);
    else
    {
        j2mewp::LcdQuad none = {};
        m_renderer.Draw(m_context.Get(), m_rtv.Get(), w, h, none, linear, bg);   // clears only
    }
    m_synced->EndDraw();

    m_synced.CopyTo(synced);
    subRect->left = 0; subRect->top = 0;
    subRect->right = (float)w; subRect->bottom = (float)h;
    return S_OK;
}
