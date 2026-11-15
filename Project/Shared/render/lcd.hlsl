// J2MEWP: LCD quad shaders (D3D11 feature level 9_1). Precompiled into lcd_shaders.h by
// Project/tools/make_lcd_shaders.sh (fxc /T vs_4_0_level_9_1 / ps_4_0_level_9_1).
struct VSIn  { float2 pos : POSITION; float2 uv : TEXCOORD0; };
struct VSOut { float4 pos : SV_POSITION; float2 uv : TEXCOORD0; };

VSOut VS(VSIn i)
{
    VSOut o;
    o.pos = float4(i.pos, 0.0, 1.0);
    o.uv = i.uv;
    return o;
}

Texture2D lcd : register(t0);
SamplerState smp : register(s0);

float4 PS(VSOut i) : SV_TARGET
{
    // the MIDlet LCD is opaque (alpha of the framebuffer is not meaningful)
    return float4(lcd.Sample(smp, i.uv).rgb, 1.0);
}
