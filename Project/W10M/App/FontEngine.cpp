#include "pch.h"
#include "FontEngine.h"
#include "../../Shared/javacall_winphone/src/winphone_port.h"

#include <dwrite.h>
#include <wrl/client.h>
#include <cmath>
#include <map>
#include <memory>
#include <mutex>
#include <vector>

using Microsoft::WRL::ComPtr;

extern "C" void jvm_host_log_line(const char* line);   // Shared/host/jvm_host.cpp

namespace {

// javacall style / face bits (javacall_font.h)
const int kBold = 0x01, kItalic = 0x02, kMonospace = 0x20;

struct Face {
    ComPtr<IDWriteFontFace> face;
    DWRITE_FONT_METRICS metrics = {};
};

struct GlyphData {
    WinphoneGlyph g = {};
    std::vector<unsigned char> alpha;
};

ComPtr<IDWriteFactory> g_factory;
ComPtr<IDWriteFontCollection> g_fonts;
std::mutex g_lock;
std::map<int, std::vector<Face>> g_faces;                  // style -> font chain (primary + fallbacks)
std::map<unsigned long long, std::unique_ptr<GlyphData>> g_glyphs;

// Primary + fallbacks (first font that has the character wins): Latin/Vietnamese,
// then Chinese / Japanese / Korean / Thai / Indic / symbols. Missing ones are skipped
// (W10M ships CJK fonts with the matching language support).
const wchar_t* const kFamilies[] = {
    L"Segoe UI", L"Arial", L"Tahoma", L"Segoe WP",
    L"Microsoft YaHei UI", L"Microsoft YaHei", L"SimSun", L"DengXian",
    L"Microsoft JhengHei UI", L"Microsoft JhengHei", L"Yu Gothic UI", L"Meiryo UI",
    L"Malgun Gothic", L"Leelawadee UI", L"Nirmala UI",
    L"Segoe UI Symbol", L"Segoe UI Emoji", L"Segoe UI Historic" };
const wchar_t* const kMonoFamilies[] = { L"Consolas", L"Courier New", L"Segoe UI", L"Arial" };

void add_family(std::vector<Face>& chain, const wchar_t* name, int style) {
    UINT32 index = 0;
    BOOL exists = FALSE;
    if (FAILED(g_fonts->FindFamilyName(name, &index, &exists)) || !exists) return;
    ComPtr<IDWriteFontFamily> family;
    ComPtr<IDWriteFont> font;
    if (FAILED(g_fonts->GetFontFamily(index, &family))) return;
    if (FAILED(family->GetFirstMatchingFont(
            (style & kBold) ? DWRITE_FONT_WEIGHT_BOLD : DWRITE_FONT_WEIGHT_NORMAL,
            DWRITE_FONT_STRETCH_NORMAL,
            (style & kItalic) ? DWRITE_FONT_STYLE_ITALIC : DWRITE_FONT_STYLE_NORMAL, &font))) return;
    Face f;
    if (FAILED(font->CreateFontFace(&f.face))) return;
    font->GetMetrics(&f.metrics);
    chain.push_back(f);
}

std::vector<Face>& faces_for(int style) {
    style &= (kBold | kItalic | kMonospace);
    auto it = g_faces.find(style);
    if (it != g_faces.end()) return it->second;
    std::vector<Face>& chain = g_faces[style];
    if (style & kMonospace)
        for (auto n : kMonoFamilies) add_family(chain, n, style);
    for (auto n : kFamilies) add_family(chain, n, style);
    return chain;
}

int font_metrics(int px, int style, int* ascent, int* descent, int* leading) {
    std::lock_guard<std::mutex> lock(g_lock);
    std::vector<Face>& chain = faces_for(style);
    if (chain.empty()) return 0;
    const DWRITE_FONT_METRICS& m = chain[0].metrics;
    const float s = (float)px / m.designUnitsPerEm;
    *ascent = (int)std::ceil(m.ascent * s);
    *descent = (int)std::ceil(m.descent * s);
    *leading = 0;
    return 1;
}

void render(GlyphData& out, const Face& f, UINT16 index, int px) {
    const float s = (float)px / f.metrics.designUnitsPerEm;
    DWRITE_GLYPH_METRICS gm = {};
    f.face->GetDesignGlyphMetrics(&index, 1, &gm, FALSE);
    out.g.advance = (int)std::lround(gm.advanceWidth * s);

    DWRITE_GLYPH_RUN run = {};
    FLOAT advance = 0;
    DWRITE_GLYPH_OFFSET offset = {};
    run.fontFace = f.face.Get();
    run.fontEmSize = (FLOAT)px;
    run.glyphCount = 1;
    run.glyphIndices = &index;
    run.glyphAdvances = &advance;
    run.glyphOffsets = &offset;

    ComPtr<IDWriteGlyphRunAnalysis> analysis;
    if (FAILED(g_factory->CreateGlyphRunAnalysis(&run, 1.0f, nullptr,
            DWRITE_RENDERING_MODE_NATURAL, DWRITE_MEASURING_MODE_NATURAL,
            0.0f, 0.0f, &analysis))) return;
    RECT b = {};
    if (FAILED(analysis->GetAlphaTextureBounds(DWRITE_TEXTURE_CLEARTYPE_3x1, &b))) return;
    const int w = b.right - b.left, h = b.bottom - b.top;
    if (w <= 0 || h <= 0) return;
    std::vector<unsigned char> rgb((size_t)w * h * 3);
    if (FAILED(analysis->CreateAlphaTexture(DWRITE_TEXTURE_CLEARTYPE_3x1, &b, rgb.data(), (UINT32)rgb.size())))
        return;
    out.alpha.resize((size_t)w * h);
    for (size_t i = 0; i < out.alpha.size(); i++)   // grayscale coverage from the 3 sub-pixels
        out.alpha[i] = (unsigned char)((rgb[i * 3] + rgb[i * 3 + 1] + rgb[i * 3 + 2]) / 3);
    out.g.width = w;
    out.g.height = h;
    out.g.left = b.left;
    out.g.top = b.top;
}

int font_glyph(unsigned int cp, int px, int style, WinphoneGlyph* out) {
    std::lock_guard<std::mutex> lock(g_lock);
    style &= (kBold | kItalic | kMonospace);
    const unsigned long long key = ((unsigned long long)cp << 16) | ((unsigned)px << 8) | (unsigned)style;
    auto it = g_glyphs.find(key);
    if (it == g_glyphs.end()) {
        std::unique_ptr<GlyphData> gd(new GlyphData());
        std::vector<Face>& chain = faces_for(style);
        bool found = false;
        for (const Face& f : chain) {
            UINT32 c = cp;
            UINT16 index = 0;
            if (SUCCEEDED(f.face->GetGlyphIndices(&c, 1, &index)) && index != 0) {
                render(*gd, f, index, px);
                found = true;
                break;
            }
        }
        if (!found && !chain.empty()) {           // .notdef box from the primary font
            UINT32 c = cp;
            UINT16 index = 0;
            chain[0].face->GetGlyphIndices(&c, 1, &index);
            if (cp >= 0x20) render(*gd, chain[0], index, px);
        }
        gd->g.alpha = gd->alpha.empty() ? nullptr : gd->alpha.data();
        it = g_glyphs.emplace(key, std::move(gd)).first;
    }
    *out = it->second->g;
    return 1;
}

const WinphoneFontBackend kBackend = { font_metrics, font_glyph };

} // namespace

void FontEngine_Init() {
    if (FAILED(DWriteCreateFactory(DWRITE_FACTORY_TYPE_SHARED, __uuidof(IDWriteFactory),
            reinterpret_cast<IUnknown**>(g_factory.GetAddressOf()))) ||
        FAILED(g_factory->GetSystemFontCollection(&g_fonts, FALSE))) {
        jvm_host_log_line("[font] DirectWrite unavailable -> MIDP bitmap font");
        return;
    }
    if (faces_for(0).empty()) {
        jvm_host_log_line("[font] no system font found -> MIDP bitmap font");
        return;
    }
    winphone_font_set_backend(&kBackend);
    jvm_host_log_line("[font] DirectWrite fonts ready");
}
