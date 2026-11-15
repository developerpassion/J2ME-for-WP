#include "lcd_renderer.h"
#include "lcd_shaders.h"

using Microsoft::WRL::ComPtr;

namespace j2mewp
{
namespace
{
    struct Vertex { float x, y, u, v; };
}

LcdRenderer::LcdRenderer() : m_texW(0), m_texH(0) {}

LcdRenderer::~LcdRenderer() { Release(); }

void LcdRenderer::Release()
{
    m_srv.Reset(); m_tex.Reset();
    m_depth.Reset(); m_blend.Reset(); m_raster.Reset();
    m_linear.Reset(); m_point.Reset();
    m_vb.Reset(); m_layout.Reset(); m_ps.Reset(); m_vs.Reset();
    m_device.Reset();
    m_texW = m_texH = 0;
}

bool LcdRenderer::Init(ID3D11Device* device)
{
    Release();
    if (!device) return false;
    m_device = device;
    if (FAILED(device->CreateVertexShader(g_lcd_vs, sizeof(g_lcd_vs), 0, &m_vs))) return false;
    if (FAILED(device->CreatePixelShader(g_lcd_ps, sizeof(g_lcd_ps), 0, &m_ps))) return false;

    D3D11_INPUT_ELEMENT_DESC il[2];
    ZeroMemory(il, sizeof(il));
    il[0].SemanticName = "POSITION"; il[0].Format = DXGI_FORMAT_R32G32_FLOAT; il[0].AlignedByteOffset = 0;
    il[0].InputSlotClass = D3D11_INPUT_PER_VERTEX_DATA;
    il[1].SemanticName = "TEXCOORD"; il[1].Format = DXGI_FORMAT_R32G32_FLOAT; il[1].AlignedByteOffset = 8;
    il[1].InputSlotClass = D3D11_INPUT_PER_VERTEX_DATA;
    if (FAILED(device->CreateInputLayout(il, 2, g_lcd_vs, sizeof(g_lcd_vs), &m_layout))) return false;

    D3D11_BUFFER_DESC bd;
    ZeroMemory(&bd, sizeof(bd));
    bd.ByteWidth = sizeof(Vertex) * 4;
    bd.Usage = D3D11_USAGE_DYNAMIC;
    bd.BindFlags = D3D11_BIND_VERTEX_BUFFER;
    bd.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
    if (FAILED(device->CreateBuffer(&bd, 0, &m_vb))) return false;

    D3D11_SAMPLER_DESC sd;
    ZeroMemory(&sd, sizeof(sd));
    sd.AddressU = sd.AddressV = sd.AddressW = D3D11_TEXTURE_ADDRESS_CLAMP;
    sd.ComparisonFunc = D3D11_COMPARISON_NEVER;
    sd.MaxLOD = D3D11_FLOAT32_MAX;
    sd.MaxAnisotropy = 1;
    sd.Filter = D3D11_FILTER_MIN_MAG_MIP_POINT;
    if (FAILED(device->CreateSamplerState(&sd, &m_point))) return false;
    sd.Filter = D3D11_FILTER_MIN_MAG_MIP_LINEAR;
    if (FAILED(device->CreateSamplerState(&sd, &m_linear))) return false;

    D3D11_RASTERIZER_DESC rd;
    ZeroMemory(&rd, sizeof(rd));
    rd.FillMode = D3D11_FILL_SOLID;
    rd.CullMode = D3D11_CULL_NONE;
    rd.DepthClipEnable = TRUE;
    if (FAILED(device->CreateRasterizerState(&rd, &m_raster))) return false;

    D3D11_BLEND_DESC bl;
    ZeroMemory(&bl, sizeof(bl));
    bl.RenderTarget[0].BlendEnable = FALSE;
    bl.RenderTarget[0].RenderTargetWriteMask = D3D11_COLOR_WRITE_ENABLE_ALL;
    if (FAILED(device->CreateBlendState(&bl, &m_blend))) return false;

    D3D11_DEPTH_STENCIL_DESC ds;
    ZeroMemory(&ds, sizeof(ds));
    ds.DepthEnable = FALSE;
    ds.StencilEnable = FALSE;
    if (FAILED(device->CreateDepthStencilState(&ds, &m_depth))) return false;
    return true;
}

void LcdRenderer::Upload(ID3D11DeviceContext* ctx, const unsigned int* pixels, int w, int h)
{
    if (!m_device || !ctx || !pixels || w <= 0 || h <= 0) return;
    if (w != m_texW || h != m_texH)
    {
        m_srv.Reset(); m_tex.Reset(); m_texW = m_texH = 0;
        // low-end GPUs (Lumia 520/920/1020: Adreno 225/305, feature level 9_1..9_3):
        // textures max 2048 (9_1/9_2) / 4096 (9_3); non-power-of-two is fine with
        // MipLevels 1 + CLAMP (as here).
        UINT maxDim = m_device->GetFeatureLevel() >= D3D_FEATURE_LEVEL_9_3 ? 4096 : 2048;
        if ((UINT)w > maxDim || (UINT)h > maxDim) return;
        D3D11_TEXTURE2D_DESC td;
        ZeroMemory(&td, sizeof(td));
        td.Width = (UINT)w; td.Height = (UINT)h;
        td.MipLevels = 1; td.ArraySize = 1;
        td.Format = DXGI_FORMAT_B8G8R8A8_UNORM;   // 0xAARRGGBB little-endian = B,G,R,A bytes
        td.SampleDesc.Count = 1;
        td.Usage = D3D11_USAGE_DEFAULT;
        td.BindFlags = D3D11_BIND_SHADER_RESOURCE;
        if (FAILED(m_device->CreateTexture2D(&td, 0, &m_tex))) return;
        if (FAILED(m_device->CreateShaderResourceView(m_tex.Get(), 0, &m_srv))) { m_tex.Reset(); return; }
        m_texW = w; m_texH = h;
    }
    ctx->UpdateSubresource(m_tex.Get(), 0, 0, pixels, (UINT)w * 4, 0);
}

void LcdRenderer::Draw(ID3D11DeviceContext* ctx, ID3D11RenderTargetView* rtv, int rtW, int rtH,
                       const LcdQuad& q, bool linear, unsigned int bg)
{
    if (!ctx || !rtv || rtW <= 0 || rtH <= 0) return;
    float clear[4] = { ((bg >> 16) & 0xFF) / 255.f, ((bg >> 8) & 0xFF) / 255.f, (bg & 0xFF) / 255.f, 1.f };
    ctx->OMSetRenderTargets(1, &rtv, 0);
    ctx->ClearRenderTargetView(rtv, clear);
    if (!m_vs || !m_srv) return;

    D3D11_MAPPED_SUBRESOURCE m;
    if (FAILED(ctx->Map(m_vb.Get(), 0, D3D11_MAP_WRITE_DISCARD, 0, &m))) return;
    Vertex* v = (Vertex*)m.pData;
    // triangle strip: TL, TR, BL, BR (pixels -> clip space)
    static const float U[4] = { 0, 1, 0, 1 }, V[4] = { 0, 0, 1, 1 };
    for (int i = 0; i < 4; i++)
    {
        v[i].x = q.x[i] / rtW * 2.f - 1.f;
        v[i].y = 1.f - q.y[i] / rtH * 2.f;
        v[i].u = U[i];
        v[i].v = V[i];
    }
    ctx->Unmap(m_vb.Get(), 0);

    D3D11_VIEWPORT vp;
    vp.TopLeftX = 0; vp.TopLeftY = 0;
    vp.Width = (float)rtW; vp.Height = (float)rtH;
    vp.MinDepth = 0; vp.MaxDepth = 1;
    ctx->RSSetViewports(1, &vp);
    ctx->RSSetState(m_raster.Get());
    float bf[4] = { 0, 0, 0, 0 };
    ctx->OMSetBlendState(m_blend.Get(), bf, 0xFFFFFFFF);
    ctx->OMSetDepthStencilState(m_depth.Get(), 0);

    UINT stride = sizeof(Vertex), offset = 0;
    ID3D11Buffer* vb = m_vb.Get();
    ctx->IASetVertexBuffers(0, 1, &vb, &stride, &offset);
    ctx->IASetInputLayout(m_layout.Get());
    ctx->IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP);
    ctx->VSSetShader(m_vs.Get(), 0, 0);
    ctx->PSSetShader(m_ps.Get(), 0, 0);
    ID3D11ShaderResourceView* srv = m_srv.Get();
    ctx->PSSetShaderResources(0, 1, &srv);
    ID3D11SamplerState* smp = linear ? m_linear.Get() : m_point.Get();
    ctx->PSSetSamplers(0, 1, &smp);
    ctx->Draw(4, 0);
    ID3D11ShaderResourceView* none = 0;
    ctx->PSSetShaderResources(0, 1, &none);
}
}
