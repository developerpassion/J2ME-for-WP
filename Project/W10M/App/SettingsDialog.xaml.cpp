#include "pch.h"
#include "SettingsDialog.xaml.h"

using namespace J2MEW10M;
using namespace Platform;
using namespace Windows::UI;
using namespace Windows::UI::Xaml;
using namespace Windows::UI::Xaml::Controls;
using namespace Windows::UI::Xaml::Media;

// Common J2ME screen sizes (portrait first).
static const int kPresets[][2] = {
    { 128, 128 }, { 128, 160 }, { 176, 208 }, { 176, 220 }, { 208, 208 },
    { 240, 320 }, { 320, 240 }, { 240, 400 }, { 352, 416 }, { 360, 640 },
    { 640, 360 }, { 480, 800 }, { 800, 480 },
};

static const int kHeapMB[] = { 64, 96, 128, 192, 256 };

static int ParseInt(TextBox^ box, int def)
{
    std::wstring t = box->Text->Data();
    if (t.empty()) return def;
    wchar_t* end = nullptr;
    long v = wcstol(t.c_str(), &end, 10);
    return (end && *end == 0) ? (int)v : def;
}

static bool ParseColor(String^ text, unsigned int* rgb)
{
    std::wstring t = text->Data();
    if (!t.empty() && t[0] == L'#') t = t.substr(1);
    if (t.size() != 6) return false;
    wchar_t* end = nullptr;
    unsigned long v = wcstoul(t.c_str(), &end, 16);
    if (!end || *end) return false;
    *rgb = (unsigned int)v & 0xFFFFFF;
    return true;
}

SettingsDialog::SettingsDialog()
{
    InitializeComponent();
    for (auto& p : kPresets)
    {
        auto item = ref new MenuFlyoutItem();
        item->Text = ref new String((std::to_wstring(p[0]) + L" x " + std::to_wstring(p[1])).c_str());
        int w = p[0], h = p[1];
        item->Click += ref new RoutedEventHandler([this, w, h](Object^, RoutedEventArgs^)
        {
            WidthBox->Text = w.ToString();
            HeightBox->Text = h.ToString();
        });
        PresetMenu->Items->Append(item);
    }
}

void SettingsDialog::Load(const j2mewp::GameSettings& s)
{
    m_loaded = s;
    WidthBox->Text = s.width.ToString();
    HeightBox->Text = s.height.ToString();
    KeepAspectBox->IsChecked = s.keepAspect;
    wchar_t bg[8];
    swprintf_s(bg, L"%06X", s.background & 0xFFFFFF);
    BackgroundBox->Text = ref new String(bg);
    ScaleBox->Text = s.scalePercent.ToString();
    OrientationBox->SelectedIndex = s.orientation;
    GravityBox->SelectedIndex = s.gravity;
    ScaleTypeBox->SelectedIndex = s.scaleType;
    LimitFpsBox->Text = s.limitFps > 0 ? s.limitFps.ToString() : L"";
    FilterSwitch->IsOn = s.filter;
    ShowFpsSwitch->IsOn = s.showFps;
    ShowTitleSwitch->IsOn = s.showTitle;
    KeypadSwitch->IsOn = s.showKeypad;
    int hi = 0;
    for (int i = 0; i < _countof(kHeapMB); ++i) if (kHeapMB[i] <= s.heapMB) hi = i;
    HeapBox->SelectedIndex = hi;
}

j2mewp::GameSettings SettingsDialog::Read() const
{
    j2mewp::GameSettings s = m_loaded;
    int w = ParseInt(WidthBox, s.width), h = ParseInt(HeightBox, s.height);
    if (w >= 16 && w <= 2048) s.width = w;
    if (h >= 16 && h <= 2048) s.height = h;
    s.keepAspect = KeepAspectBox->IsChecked != nullptr && KeepAspectBox->IsChecked->Value;
    ParseColor(BackgroundBox->Text, &s.background);
    int scale = ParseInt(ScaleBox, s.scalePercent);
    if (scale >= 10 && scale <= 1000) s.scalePercent = scale;
    if (OrientationBox->SelectedIndex >= 0) s.orientation = OrientationBox->SelectedIndex;
    if (GravityBox->SelectedIndex >= 0) s.gravity = GravityBox->SelectedIndex;
    if (ScaleTypeBox->SelectedIndex >= 0) s.scaleType = ScaleTypeBox->SelectedIndex;
    int fps = ParseInt(LimitFpsBox, 0);
    s.limitFps = (fps > 0 && fps <= 120) ? fps : 0;
    s.filter = FilterSwitch->IsOn;
    s.showFps = ShowFpsSwitch->IsOn;
    s.showTitle = ShowTitleSwitch->IsOn;
    s.showKeypad = KeypadSwitch->IsOn;
    if (HeapBox->SelectedIndex >= 0) s.heapMB = kHeapMB[HeapBox->SelectedIndex];
    return s;
}

void SettingsDialog::SwapButton_Click(Object^, RoutedEventArgs^)
{
    String^ w = WidthBox->Text;
    WidthBox->Text = HeightBox->Text;
    HeightBox->Text = w;
}

void SettingsDialog::BackgroundBox_TextChanged(Object^, TextChangedEventArgs^)
{
    unsigned int rgb;
    if (ParseColor(BackgroundBox->Text, &rgb))
        BackgroundSwatch->Background = ref new SolidColorBrush(ColorHelper::FromArgb(255, (rgb >> 16) & 255, (rgb >> 8) & 255, rgb & 255));
}

void SettingsDialog::ResetButton_Click(Object^, RoutedEventArgs^)
{
    j2mewp::GameSettings keep = m_loaded;
    Load(j2mewp::GameSettings());
    m_loaded = keep;
}
