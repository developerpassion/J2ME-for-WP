// J2MEWP: draws the MIDlet LCD with Direct3D 11 (feature level 9_1+): one texture
// (updated when the VM flushed a new frame) and one textured quad, nearest or linear
// filtering. Plain C++/COM (no C++/CX) so it serves the WP8.0 / WP8.1 Silverlight
// DrawingSurfaceBackgroundGrid providers and the W10M SwapChainPanel.
// Builds with VS2012 (WP8.0): no member initializers, no C++11 library extras.
#pragma once
#include <d3d11.h>
#include <wrl/client.h>

namespace j2mewp
{
    // Where the LCD goes, in render target pixels: the four corners of the picture
    // (top-left, top-right, bottom-left, bottom-right of the MIDlet screen), so the
    // caller can rotate it (WP8 background grids are always portrait).
    struct LcdQuad
    {
        float x[4], y[4];
    };

    class LcdRenderer
    {
    public:
        LcdRenderer();
        ~LcdRenderer();

        // (Re)creates the device objects; call again when the device changes.
        bool Init(ID3D11Device* device);
        void Release();
        ID3D11Device* Device() const { return m_device.Get(); }

        // Copies a frame (0xAARRGGBB, w*h, rows packed) into the texture.
        void Upload(ID3D11DeviceContext* ctx, const unsigned int* pixels, int w, int h);
        bool HasFrame() const { return m_texW > 0; }

        // Clears the render target with bg (0xRRGGBB) and draws the LCD into quad.
        void Draw(ID3D11DeviceContext* ctx, ID3D11RenderTargetView* rtv, int rtW, int rtH,
                  const LcdQuad& quad, bool linear, unsigned int bg);

    private:
        Microsoft::WRL::ComPtr<ID3D11Device> m_device;
        Microsoft::WRL::ComPtr<ID3D11VertexShader> m_vs;
        Microsoft::WRL::ComPtr<ID3D11PixelShader> m_ps;
        Microsoft::WRL::ComPtr<ID3D11InputLayout> m_layout;
        Microsoft::WRL::ComPtr<ID3D11Buffer> m_vb;
        Microsoft::WRL::ComPtr<ID3D11SamplerState> m_point, m_linear;
        Microsoft::WRL::ComPtr<ID3D11RasterizerState> m_raster;
        Microsoft::WRL::ComPtr<ID3D11BlendState> m_blend;
        Microsoft::WRL::ComPtr<ID3D11DepthStencilState> m_depth;
        Microsoft::WRL::ComPtr<ID3D11Texture2D> m_tex;
        Microsoft::WRL::ComPtr<ID3D11ShaderResourceView> m_srv;
        int m_texW, m_texH;
    };
}
