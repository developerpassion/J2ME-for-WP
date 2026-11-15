#pragma once
// J2MEWP (WP8.0 / WP8.1 Silverlight): the MIDlet LCD drawn with Direct3D into a XAML
// DrawingSurface element (the LCD placeholder of the game page). The system asks for
// a texture on its render thread every frame (independent of the Silverlight UI
// thread, which only managed ~32 updates/s with WriteableBitmap).
//
// Why DrawingSurface and not DrawingSurfaceBackgroundGrid: the background grid's
// render target is mapped to the screen in ways the app cannot see (on W10M it is
// stretched over the page above the nav bar, and differently when the nav bar is
// hidden, with no size change reported), so the LCD drifted over the keypad. A
// DrawingSurface is a normal element: XAML places, rotates and scales it.
//
// Rules learnt on the phone: never call IDrawingSurfaceRuntimeHostNative from the UI
// thread (RequestAdditionalFrame there killed the app); the render thread asks for
// the next frame itself.
#include <d3d11_1.h>
#include <wrl.h>
#include <DrawingSurfaceNative.h>
#include <windows.phone.graphics.interop.h>
#include <mutex>
#include "../../Shared/render/lcd_renderer.h"

namespace J2MEWPRuntime
{
    public ref class LcdSurface sealed
    {
    public:
        LcdSurface();

        // For DrawingSurface.SetContentProvider.
        Windows::Phone::Graphics::Interop::IDrawingSurfaceContentProvider^ CreateContentProvider();

        // background 0xRRGGBB (shown before the first frame), linear = smooth scaling
        void SetStyle(int background, bool linear);
        // false: draw only the background (no game / between games).
        void SetActive(bool active);
        // Frames uploaded to the GPU (= frames the player saw).
        property int64 FramesShown { int64 get(); }

    internal:
        HRESULT Connect(IDrawingSurfaceRuntimeHostNative* host);
        void Disconnect();
        HRESULT PrepareResources(const LARGE_INTEGER* presentTargetTime, BOOL* isContentDirty);
        HRESULT GetTexture(const DrawingSurfaceSizeF* size, IDrawingSurfaceSynchronizedTextureNative** synced,
                           DrawingSurfaceRectF* subRect);

    private:
        ~LcdSurface();
        bool CreateDevice();
        bool EnsureTarget(int w, int h);

        std::mutex m_lock;                 // guards the values set by the UI thread
        unsigned int m_background;
        bool m_linear, m_active, m_lastActive;

        // render thread only
        Microsoft::WRL::ComPtr<IDrawingSurfaceRuntimeHostNative> m_host;
        Microsoft::WRL::ComPtr<ID3D11Device1> m_device;
        Microsoft::WRL::ComPtr<ID3D11DeviceContext1> m_context;
        Microsoft::WRL::ComPtr<ID3D11Texture2D> m_target;
        Microsoft::WRL::ComPtr<ID3D11RenderTargetView> m_rtv;
        Microsoft::WRL::ComPtr<IDrawingSurfaceSynchronizedTextureNative> m_synced;
        j2mewp::LcdRenderer m_renderer;
        int m_targetW, m_targetH;
        bool m_lastLinear, m_pendingUpload;
        unsigned int m_lastBackground;
        volatile long long m_shown;
    };
}
