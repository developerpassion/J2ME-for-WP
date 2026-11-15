#include "pch.h"
#include "LcdPanel.h"
#include <windows.ui.xaml.media.dxinterop.h>
#include <algorithm>
#include <string>
#include "AppState.h"

using namespace J2MEW10M;
using Microsoft::WRL::ComPtr;

LcdPanel::LcdPanel() : m_rtW(0), m_rtH(0), m_needResize(true) {}

void LcdPanel::Attach(Windows::UI::Xaml::Controls::SwapChainPanel^ panel)
{
    m_panel = panel;
    m_needResize = true;
}

void LcdPanel::Detach()
{
    if (m_panel)
    {
        ComPtr<ISwapChainPanelNative> native;
        if (SUCCEEDED(reinterpret_cast<IUnknown*>(m_panel)->QueryInterface(IID_PPV_ARGS(&native))))
            native->SetSwapChain(nullptr);
    }
    m_rtv.Reset();
    m_swap.Reset();
    m_renderer.Release();
    m_ctx.Reset();
    m_device.Reset();
    m_panel = nullptr;
}

void LcdPanel::Resize() { m_needResize = true; }

bool LcdPanel::CreateDevice()
{
    if (m_device) return true;
    D3D_FEATURE_LEVEL levels[] = { D3D_FEATURE_LEVEL_11_0, D3D_FEATURE_LEVEL_10_1, D3D_FEATURE_LEVEL_10_0,
                                   D3D_FEATURE_LEVEL_9_3, D3D_FEATURE_LEVEL_9_2, D3D_FEATURE_LEVEL_9_1 };
    UINT flags = D3D11_CREATE_DEVICE_BGRA_SUPPORT;
    HRESULT hr = D3D11CreateDevice(nullptr, D3D_DRIVER_TYPE_HARDWARE, nullptr, flags, levels, ARRAYSIZE(levels),
                                   D3D11_SDK_VERSION, &m_device, nullptr, &m_ctx);
    if (FAILED(hr))
        hr = D3D11CreateDevice(nullptr, D3D_DRIVER_TYPE_WARP, nullptr, flags, levels, ARRAYSIZE(levels),
                               D3D11_SDK_VERSION, &m_device, nullptr, &m_ctx);
    if (FAILED(hr) || !m_renderer.Init(m_device.Get()))
    {
        char b[64]; sprintf_s(b, "[lcd] D3D device failed 0x%08X", (unsigned)hr); AppLog(b);
        m_ctx.Reset(); m_device.Reset();
        return false;
    }
    AppLog("[lcd] D3D11 device ready");
    return true;
}

bool LcdPanel::EnsureSwapChain()
{
    if (!m_panel || !CreateDevice()) return false;
    if (!m_needResize && m_swap) return true;
    double sx = m_panel->CompositionScaleX, sy = m_panel->CompositionScaleY;
    int w = (int)std::lround(m_panel->ActualWidth * (sx > 0 ? sx : 1));
    int h = (int)std::lround(m_panel->ActualHeight * (sy > 0 ? sy : 1));
    if (w <= 0 || h <= 0) return false;
    m_needResize = false;
    if (m_swap && w == m_rtW && h == m_rtH) return true;
    m_rtv.Reset();
    HRESULT hr;
    if (m_swap)
    {
        hr = m_swap->ResizeBuffers(2, w, h, DXGI_FORMAT_B8G8R8A8_UNORM, 0);
        if (FAILED(hr)) { Lost(); return false; }
    }
    else
    {
        ComPtr<IDXGIDevice1> dxgiDevice;
        ComPtr<IDXGIAdapter> adapter;
        ComPtr<IDXGIFactory2> factory;
        if (FAILED(m_device.As(&dxgiDevice)) || FAILED(dxgiDevice->GetAdapter(&adapter)) ||
            FAILED(adapter->GetParent(IID_PPV_ARGS(&factory)))) return false;
        DXGI_SWAP_CHAIN_DESC1 d = {};
        d.Width = w; d.Height = h;
        d.Format = DXGI_FORMAT_B8G8R8A8_UNORM;
        d.SampleDesc.Count = 1;
        d.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
        d.BufferCount = 2;
        d.SwapEffect = DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL;
        d.Scaling = DXGI_SCALING_STRETCH;
        d.AlphaMode = DXGI_ALPHA_MODE_IGNORE;
        hr = factory->CreateSwapChainForComposition(m_device.Get(), &d, nullptr, &m_swap);
        if (FAILED(hr)) { char b[64]; sprintf_s(b, "[lcd] swap chain failed 0x%08X", (unsigned)hr); AppLog(b); return false; }
        dxgiDevice->SetMaximumFrameLatency(1);
        ComPtr<ISwapChainPanelNative> native;
        if (FAILED(reinterpret_cast<IUnknown*>(m_panel)->QueryInterface(IID_PPV_ARGS(&native))) ||
            FAILED(native->SetSwapChain(m_swap.Get()))) { m_swap.Reset(); return false; }
    }
    // the panel is in DIPs; undo the composition scale so 1 buffer pixel = 1 screen pixel
    ComPtr<IDXGISwapChain2> swap2;
    if (SUCCEEDED(m_swap.As(&swap2)))
    {
        DXGI_MATRIX_3X2_F m = {};
        m._11 = (float)(1.0 / (sx > 0 ? sx : 1));
        m._22 = (float)(1.0 / (sy > 0 ? sy : 1));
        swap2->SetMatrixTransform(&m);
    }
    ComPtr<ID3D11Texture2D> back;
    if (FAILED(m_swap->GetBuffer(0, IID_PPV_ARGS(&back))) ||
        FAILED(m_device->CreateRenderTargetView(back.Get(), nullptr, &m_rtv))) { Lost(); return false; }
    m_rtW = w; m_rtH = h;
    return true;
}

void LcdPanel::Lost()
{
    AppLog("[lcd] device lost, recreating");
    if (m_panel)
    {
        ComPtr<ISwapChainPanelNative> native;
        if (SUCCEEDED(reinterpret_cast<IUnknown*>(m_panel)->QueryInterface(IID_PPV_ARGS(&native))))
            native->SetSwapChain(nullptr);
    }
    m_rtv.Reset(); m_swap.Reset(); m_renderer.Release(); m_ctx.Reset(); m_device.Reset();
    m_rtW = m_rtH = 0;
    m_needResize = true;
}

void LcdPanel::Present(const unsigned int* pixels, int w, int h, bool linear)
{
    if (!EnsureSwapChain()) return;
    if (pixels && w > 0 && h > 0) m_renderer.Upload(m_ctx.Get(), pixels, w, h);
    if (!m_renderer.HasFrame()) return;
    j2mewp::LcdQuad q;
    q.x[0] = 0;            q.y[0] = 0;
    q.x[1] = (float)m_rtW; q.y[1] = 0;
    q.x[2] = 0;            q.y[2] = (float)m_rtH;
    q.x[3] = (float)m_rtW; q.y[3] = (float)m_rtH;
    m_renderer.Draw(m_ctx.Get(), m_rtv.Get(), m_rtW, m_rtH, q, linear, 0);
    HRESULT hr = m_swap->Present(0, 0);
    if (hr == DXGI_ERROR_DEVICE_REMOVED || hr == DXGI_ERROR_DEVICE_RESET) Lost();
}
