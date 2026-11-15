#pragma once
// W10M: MIDlet LCD drawn with Direct3D 11 into a SwapChainPanel (replaces the
// Image + WriteableBitmap path: no CPU upscale, nearest/linear done by the GPU).
// The panel is exactly the LCD picture; the swap chain matches its physical pixels.
// Used on the UI thread only (MainPage::UpdateLcd / SizeChanged).
#include <d3d11.h>
#include <dxgi1_3.h>
#include <wrl/client.h>
#include "../../Shared/render/lcd_renderer.h"

namespace J2MEW10M
{
    class LcdPanel
    {
    public:
        LcdPanel();
        void Attach(Windows::UI::Xaml::Controls::SwapChainPanel^ panel);
        void Detach();
        // Panel size or composition scale changed.
        void Resize();
        // New frame (0xAARRGGBB); pixels may be null to redraw the last one.
        void Present(const unsigned int* pixels, int w, int h, bool linear);

    private:
        bool CreateDevice();
        bool EnsureSwapChain();
        void Lost();

        Windows::UI::Xaml::Controls::SwapChainPanel^ m_panel;
        Microsoft::WRL::ComPtr<ID3D11Device> m_device;
        Microsoft::WRL::ComPtr<ID3D11DeviceContext> m_ctx;
        Microsoft::WRL::ComPtr<IDXGISwapChain1> m_swap;
        Microsoft::WRL::ComPtr<ID3D11RenderTargetView> m_rtv;
        j2mewp::LcdRenderer m_renderer;
        int m_rtW, m_rtH;
        bool m_needResize;
    };
}
