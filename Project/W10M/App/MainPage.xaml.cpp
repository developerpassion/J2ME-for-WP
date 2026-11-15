#include "pch.h"
#include "MainPage.xaml.h"
#include "SettingsDialog.xaml.h"
#include <limits>
#include "GamesPage.xaml.h"
#include "AppState.h"
#include "jvm_host.h"
#include "AudioEngine.h"
#include "DeviceEngine.h"

#include <algorithm>
#include <cmath>
#undef min
#undef max

using namespace J2MEW10M;
using namespace concurrency;
using namespace Platform;
using namespace Windows::Foundation;
using namespace Windows::Graphics::Display;
using namespace Windows::System;
using namespace Windows::UI;
using namespace Windows::UI::Core;
using namespace Windows::UI::Xaml;
using namespace Windows::UI::Xaml::Controls;
using namespace Windows::UI::Xaml::Input;
using namespace Windows::UI::Xaml::Media;
using namespace Windows::UI::Xaml::Media::Imaging;
using namespace Windows::UI::Xaml::Navigation;

// Test helper: LocalState\autorun.txt = "<jar>|<main class>"; <jar> is
// "local:games\x.jar", relative to the package, or absolute. When the JAR has
// already been moved into the library, the game with that class is used.
static bool ReadAutorun(std::wstring& jar, std::string& cls)
{
    std::wstring local = LocalPath();
    FILE* f = nullptr;
    if (_wfopen_s(&f, (local + L"\\autorun.txt").c_str(), L"rb") != 0 || !f) return false;
    char buf[1024] = {};
    size_t n = fread(buf, 1, sizeof(buf) - 1, f);
    fclose(f);
    std::string s(buf, n);
    while (!s.empty() && (s.back() == '\r' || s.back() == '\n' || s.back() == ' ')) s.pop_back();
    size_t bar = s.find('|');
    if (bar == std::string::npos) return false;
    std::wstring wj = ToStr(s.substr(0, bar))->Data();
    cls = s.substr(bar + 1);
    if (wj.compare(0, 6, L"local:") == 0)
        wj = local + L"\\" + wj.substr(6);
    else if (wj.size() < 2 || wj[1] != L':')
        wj = std::wstring(Windows::ApplicationModel::Package::Current->InstalledLocation->Path->Data()) + L"\\" + wj;
    jar = wj;
    return true;
}

MainPage::MainPage()
{
    InitializeComponent();
    AppInitCore();
    StatusText->Text = ToStr(std::string(jvm_host_version()));

    // Pad buttons: send key down/up on pointer press/release (Click fires only on release).
    Grid^ pads[] = { LeftPad, RightPad };
    for (Grid^ pad : pads)
    {
        for (unsigned i = 0; i < pad->Children->Size; ++i)
        {
            auto b = dynamic_cast<Button^>(pad->Children->GetAt(i));
            if (b == nullptr || b->Tag == nullptr) continue;
            b->AddHandler(UIElement::PointerPressedEvent, ref new PointerEventHandler(this, &MainPage::Key_Pressed), true);
            b->AddHandler(UIElement::PointerReleasedEvent, ref new PointerEventHandler(this, &MainPage::Key_Released), true);
            b->AddHandler(UIElement::PointerCanceledEvent, ref new PointerEventHandler(this, &MainPage::Key_Released), true);
            b->AddHandler(UIElement::PointerCaptureLostEvent, ref new PointerEventHandler(this, &MainPage::Key_Released), true);
        }
    }
    SizeChanged += ref new SizeChangedEventHandler(this, &MainPage::OnSizeChanged);

    // LCD drawn with Direct3D into the SwapChainPanel
    m_lcdPanel.Attach(LcdImage);
    LcdImage->SizeChanged += ref new SizeChangedEventHandler([this](Object^, SizeChangedEventArgs^)
    {
        m_lcdPanel.Resize();
        m_lcdRedraw = true;
    });
    LcdImage->CompositionScaleChanged += ref new TypedEventHandler<SwapChainPanel^, Object^>([this](SwapChainPanel^, Object^)
    {
        m_lcdPanel.Resize();
        m_lcdRedraw = true;
    });
}

void MainPage::OnNavigatedTo(NavigationEventArgs^ e)
{
    AppLog("[ui] game page: navigated to (mode " + std::to_string((int)e->NavigationMode) + ")");
    m_leaving = false;
    m_restarting = false;
    m_vmWasRunning = false;
    SetStatusBarVisible(false);   // the game also uses the strip under the status bar
    String^ param = dynamic_cast<String^>(e->Parameter);
    std::wstring id = param ? param->Data() : L"";
    j2mewp::GameInfo info;

    if (id == L"autorun")
    {
        std::wstring jar;
        std::string cls;
        if (ReadAutorun(jar, cls))
        {
            m_jar = jar;
            m_class = cls;
            m_gameId.clear();
            if (GetFileAttributesW(jar.c_str()) == INVALID_FILE_ATTRIBUTES)
                for (const j2mewp::GameInfo& g : Library().List())
                    if (g.midletClass == cls) { m_gameId = g.id; m_jar = g.jar; break; }
            m_title = ToStr(cls);
        }
    }
    else if (Library().Get(id, &info))
    {
        m_gameId = id;
        m_jar = info.jar;
        m_class = info.midletClass;
        m_title = ToStr(info.name);
    }
    m_settings = m_gameId.empty() ? j2mewp::GameSettings() : Library().LoadSettings(m_gameId);

    auto nav = SystemNavigationManager::GetForCurrentView();
    nav->AppViewBackButtonVisibility = AppViewBackButtonVisibility::Visible;
    m_backToken = nav->BackRequested += ref new EventHandler<BackRequestedEventArgs^>(this, &MainPage::OnBackRequested);
    auto cw = Window::Current->CoreWindow;
    m_keyDownToken = cw->KeyDown += ref new TypedEventHandler<CoreWindow^, KeyEventArgs^>(this, &MainPage::Page_KeyDown);
    m_keyUpToken = cw->KeyUp += ref new TypedEventHandler<CoreWindow^, KeyEventArgs^>(this, &MainPage::Page_KeyUp);
    m_renderToken = CompositionTarget::Rendering += ref new EventHandler<Object^>(this, &MainPage::OnRendering);

    ApplySettings();
    StartGame();
}

// Phone status bar (signal, battery). Only on Windows 10 Mobile.
void MainPage::SetStatusBarVisible(bool visible)
{
    using Windows::Foundation::Metadata::ApiInformation;
    if (!ApiInformation::IsTypePresent(L"Windows.UI.ViewManagement.StatusBar")) return;
    auto sb = Windows::UI::ViewManagement::StatusBar::GetForCurrentView();
    if (visible) concurrency::create_task(sb->ShowAsync());
    else concurrency::create_task(sb->HideAsync());
}

void MainPage::OnNavigatedFrom(NavigationEventArgs^)
{
    AppLog("[ui] game page: navigated from");
    SetStatusBarVisible(true);
    SystemNavigationManager::GetForCurrentView()->BackRequested -= m_backToken;
    auto cw = Window::Current->CoreWindow;
    cw->KeyDown -= m_keyDownToken;
    cw->KeyUp -= m_keyUpToken;
    CompositionTarget::Rendering -= m_renderToken;
    DisplayInformation::AutoRotationPreferences = DisplayOrientations::None;
}

// ---- Game lifetime ------------------------------------------------------------

void MainPage::StartGame()
{
    if (m_jar.empty() || m_class.empty())
    {
        StatusText->Text = L"Game not found.";
        return;
    }
    auto run = [this]()
    {
        jvm_host_set_lcd_size(m_settings.width, m_settings.height);
        AppSetJavaHeap(m_settings.heapMB);
        AppLog("[ui] run " + ToUtf8(m_title) + " (" + m_class + ") " +
               std::to_string(m_settings.width) + "x" + std::to_string(m_settings.height));
        StatusText->Text = m_settings.showTitle ? m_title : L"";   // setting "Show game name"
        jvm_host_run_jar(m_jar.c_str(), m_class.c_str());
    };
    if (!jvm_host_is_running())
    {
        run();
        return;
    }
    StatusText->Text = L"Stopping the previous game...";
    m_restarting = true;   // not a MIDlet exit: stay on this page
    create_task([]() { return jvm_host_stop(8000); }).then([this, run](int stopped)
    {
        m_restarting = false;
        AudioEngine_CloseAll();
        DeviceEngine_Reset();
        m_vmWasRunning = false;
        if (!stopped)
        {
            StatusText->Text = L"The previous game did not stop. Please restart the app.";
            return;
        }
        run();
    }, task_continuation_context::use_current());
}

void MainPage::LeaveGame()
{
    if (m_leaving) return;
    m_leaving = true;
    StatusText->Text = L"Stopping game...";
    create_task([]() { return jvm_host_stop(8000); }).then([this](int)
    {
        AudioEngine_CloseAll();
        DeviceEngine_Reset();
        if (this->Frame->CanGoBack) this->Frame->GoBack();
        else this->Frame->Navigate(Windows::UI::Xaml::Interop::TypeName(GamesPage::typeid));
    }, task_continuation_context::use_current());
}

void MainPage::OnBackRequested(Object^, BackRequestedEventArgs^ e)
{
    AppLog("[ui] back requested");
    e->Handled = true;
    // Back opens the game menu (works with the keypad hidden); "Game list" leaves.
    if (m_leaving) return;
    ShowGameMenu();
}

void MainPage::ShowGameMenu()
{
    auto menu = safe_cast<MenuFlyout^>(Resources->Lookup(L"GameMenu"));
    FrameworkElement^ anchor = m_settings.showKeypad ? static_cast<FrameworkElement^>(MenuButton)
                                                     : static_cast<FrameworkElement^>(FloatMenuButton);
    menu->ShowAt(anchor);
}

void MainPage::GameMenu_Opening(Object^ sender, Object^)
{
    auto menu = safe_cast<MenuFlyout^>(sender);
    for (unsigned i = 0; i < menu->Items->Size; ++i)
    {
        auto mi = dynamic_cast<MenuFlyoutItem^>(menu->Items->GetAt(i));
        if (mi && mi->Tag && mi->Tag->ToString() == L"keypad")
            mi->Text = m_settings.showKeypad ? L"Hide keypad" : L"Show keypad";
        if (mi && mi->Tag && mi->Tag->ToString() == L"movepad")   // landscape only
            mi->Visibility = m_landscape ? Windows::UI::Xaml::Visibility::Visible
                                         : Windows::UI::Xaml::Visibility::Collapsed;
    }
}

void MainPage::MenuKeypad_Click(Object^, RoutedEventArgs^)
{
    m_settings.showKeypad = !m_settings.showKeypad;
    if (!m_gameId.empty()) Library().SaveSettings(m_gameId, m_settings);
    AppLog(std::string("[ui] keypad ") + (m_settings.showKeypad ? "on" : "off"));
    ApplySettings();
}

void MainPage::MenuList_Click(Object^, RoutedEventArgs^) { AppLog("[ui] menu: list"); LeaveGame(); }

void MainPage::MenuRestart_Click(Object^, RoutedEventArgs^)
{
    if (!m_gameId.empty()) m_settings = Library().LoadSettings(m_gameId);
    ApplySettings();
    StartGame();
}

void MainPage::MenuSettings_Click(Object^, RoutedEventArgs^)
{
    if (m_gameId.empty()) return;
    auto dlg = ref new SettingsDialog();
    dlg->Title = m_title;
    dlg->Load(m_settings);
    create_task(dlg->ShowAsync()).then([this, dlg](ContentDialogResult r)
    {
        if (r != ContentDialogResult::Primary) return;
        j2mewp::GameSettings s = dlg->Read();
        bool restart = s.width != m_settings.width || s.height != m_settings.height;
        Library().SaveSettings(m_gameId, s);
        m_settings = s;
        ApplySettings();
        if (restart) StartGame();   // LCD size is fixed while a MIDlet runs
    }, task_continuation_context::use_current());
}

// ---- Settings -> view ---------------------------------------------------------

void MainPage::ApplySettings()
{
    const j2mewp::GameSettings& s = m_settings;
    unsigned bg = s.background;
    LcdHost->Background = ref new SolidColorBrush(ColorHelper::FromArgb(255, (bg >> 16) & 255, (bg >> 8) & 255, bg & 255));
    LcdImage->VerticalAlignment = s.gravity == j2mewp::GRAVITY_TOP ? Windows::UI::Xaml::VerticalAlignment::Top
                                : s.gravity == j2mewp::GRAVITY_BOTTOM ? Windows::UI::Xaml::VerticalAlignment::Bottom
                                : Windows::UI::Xaml::VerticalAlignment::Center;
    DisplayInformation::AutoRotationPreferences =
        s.orientation == j2mewp::ORIENT_PORTRAIT ? (DisplayOrientations::Portrait | DisplayOrientations::PortraitFlipped)
      : s.orientation == j2mewp::ORIENT_LANDSCAPE ? (DisplayOrientations::Landscape | DisplayOrientations::LandscapeFlipped)
      : DisplayOrientations::None;
    FpsText->Visibility = s.showFps ? Windows::UI::Xaml::Visibility::Visible : Windows::UI::Xaml::Visibility::Collapsed;
    if (jvm_host_is_running() && !m_leaving) StatusText->Text = s.showTitle ? m_title : L"";
    FpsText->Text = L"";
    auto vis = s.showKeypad ? Windows::UI::Xaml::Visibility::Visible : Windows::UI::Xaml::Visibility::Collapsed;
    LeftPad->Visibility = vis;
    RightPad->Visibility = vis;
    FloatMenuButton->Visibility = s.showKeypad ? Windows::UI::Xaml::Visibility::Collapsed
                                               : Windows::UI::Xaml::Visibility::Visible;
    ApplyLayout();
    UpdateLcdLayout();
}

void MainPage::OnSizeChanged(Object^, SizeChangedEventArgs^) { ApplyLayout(); }
void MainPage::LcdHost_SizeChanged(Object^, SizeChangedEventArgs^) { UpdateLcdLayout(); }

// landscape: [LeftPad | Lcd | RightPad]; portrait: Lcd on top, both pads below.
// Without the keypad the LCD area takes the whole window. When the pads are
// hidden, the menu stays reachable with the hardware/software Back button.
// Scale of the LCD image for an area of aw x ah (scale type + scale %).
void MainPage::LcdScale(double aw, double ah, int lw, int lh, double* kx, double* ky)
{
    double fit = std::min(aw / lw, ah / lh);
    switch (m_settings.scaleType)
    {
    case j2mewp::SCALE_STRETCH:
        if (m_settings.keepAspect) *kx = *ky = fit;
        else { *kx = aw / lw; *ky = ah / lh; }
        break;
    case j2mewp::SCALE_INTEGER:
        *kx = *ky = std::max(1.0, std::floor(fit));
        break;
    case j2mewp::SCALE_ORIGINAL:
        *kx = *ky = 1.0;
        break;
    default:
        *kx = *ky = fit;
        break;
    }
    *kx *= m_settings.scalePercent / 100.0;
    *ky *= m_settings.scalePercent / 100.0;
}

// The LCD gets the space it actually uses; the keypad gets everything else
// (no fixed pad size, so no empty bands around the game).
//   portrait : LCD full width at the top, keypad fills the rest (>= 35% height)
//   landscape: LCD full height in the middle, pads share the sides (>= 18% width each)
void MainPage::ApplyLayout()
{
    // On the phone the page also spans the area under the status / navigation
    // bars (landscape: left and right); the grid only gets the visible part.
    double w = ActualWidth, h = ActualHeight;
    auto vb = Windows::UI::ViewManagement::ApplicationView::GetForCurrentView()->VisibleBounds;
    if (vb.Width > 0 && vb.Height > 0) { w = std::min(w, (double)vb.Width); h = std::min(h, (double)vb.Height); }
    if (Root->ActualWidth > 0 && Root->ActualHeight > 0) { w = std::min(w, Root->ActualWidth); h = std::min(h, Root->ActualHeight); }
    if (w <= 0 || h <= 0) return;
    bool landscape = w >= h;
    bool pads = m_settings.showKeypad;
    int lw = m_lcdW > 0 ? m_lcdW : m_settings.width;
    int lh = m_lcdH > 0 ? m_lcdH : m_settings.height;
    if (lw <= 0) lw = 240;
    if (lh <= 0) lh = 320;
    double kx, ky;
    // Each pad is a 3x4 grid: keep its cells close to square (height <= 4/3 width),
    // centered in its area, instead of stretching keys into tall bars.
    // Pads are placed by PlacePads() (Top + margin from settings.padPos).
    // Landscape: fixed pad height (a Top-aligned Grid would shrink to its content,
    // so the drag range was wrong and the keypad could not move down).
    // Portrait: pads fill their row, no moving.
    auto va = landscape ? Windows::UI::Xaml::VerticalAlignment::Top : Windows::UI::Xaml::VerticalAlignment::Stretch;
    LeftPad->VerticalAlignment = va;
    RightPad->VerticalAlignment = va;
    LeftPad->Height = std::numeric_limits<double>::quiet_NaN();
    RightPad->Height = std::numeric_limits<double>::quiet_NaN();
    m_padAreaH = 0; m_padH = 0;
    m_scaleAreaW = 0; m_scaleAreaH = 0;
    m_landscape = landscape;
    if (landscape)
    {
        double padW = 0;
        if (pads)
        {
            // The game may use the full height and up to 64% of the width (each
            // pad keeps >= 18%); the scale setting applies inside that box.
            double boxW = std::floor(w * (1 - 2 * 0.18));
            LcdScale(boxW, h, lw, lh, &kx, &ky);
            double over = std::max(lw * kx / boxW, lh * ky / h);
            if (over > 1.0) { kx /= over; ky /= over; }
            double lcdW = std::min(boxW, std::ceil(lw * kx));
            m_scaleAreaW = boxW; m_scaleAreaH = h;
            padW = std::floor((w - lcdW) / 2);
            double padMaxH = std::min(h - 12, (padW - 12) * 4.0 / 3.0);
            LeftPad->MaxHeight = padMaxH;
            RightPad->MaxHeight = padMaxH;
            LeftPad->Height = padMaxH;
            RightPad->Height = padMaxH;
            m_padAreaH = h; m_padH = padMaxH;
        }
        Row0->Height = GridLength(1, GridUnitType::Star);
        Row1->Height = GridLength(0);
        Col0->Width = GridLength(padW);
        Col1->Width = GridLength(1, GridUnitType::Star);
        Col2->Width = GridLength(padW);
        m_lcdAreaW = w - 2 * padW; m_lcdAreaH = h;
        Grid::SetRow(LcdHost, 0);   Grid::SetColumn(LcdHost, 1);   Grid::SetColumnSpan(LcdHost, 1);
        Grid::SetRow(LeftPad, 0);   Grid::SetColumn(LeftPad, 0);
        Grid::SetRow(RightPad, 0);  Grid::SetColumn(RightPad, 2);
    }
    else
    {
        double lcdH = h;
        if (pads)
        {
            // The game may use up to the full width and 4/5 of the height; the
            // scale setting applies inside that box, the keypad gets the rest.
            // ... but leave the keypad at least 25% / 200 px so keys stay readable.
            double areaH = std::floor(std::min(h * 0.8, h - std::max(h * 0.25, 200.0)));
            LcdScale(w, areaH, lw, lh, &kx, &ky);
            double over = std::max(lw * kx / w, lh * ky / areaH);
            if (over > 1.0) { kx /= over; ky /= over; }
            lcdH = std::min(areaH, std::ceil(lh * ky));
            m_scaleAreaW = w; m_scaleAreaH = areaH;
            LeftPad->MaxHeight = std::numeric_limits<double>::infinity();
            RightPad->MaxHeight = std::numeric_limits<double>::infinity();
        }
        Row0->Height = pads ? GridLength(lcdH) : GridLength(1, GridUnitType::Star);
        Row1->Height = pads ? GridLength(1, GridUnitType::Star) : GridLength(0);
        Col0->Width = GridLength(1, GridUnitType::Star);
        Col1->Width = GridLength(0);
        Col2->Width = GridLength(1, GridUnitType::Star);
        m_lcdAreaW = w; m_lcdAreaH = lcdH;
        Grid::SetRow(LcdHost, 0);   Grid::SetColumn(LcdHost, 0);   Grid::SetColumnSpan(LcdHost, 3);
        Grid::SetRow(LeftPad, 1);   Grid::SetColumn(LeftPad, 0);
        Grid::SetRow(RightPad, 1);  Grid::SetColumn(RightPad, 2);
    }
    // Size the image for the new area now: LcdHost.SizeChanged is not reliable
    // after a rotation, and the old image size overflowed the new column.
    UpdateLcdLayout();
    PlacePads();

    // Key labels follow the key size (small portrait pads cut the text off).
    if (pads)
    {
        double padH = landscape ? m_padH : (h - m_lcdAreaH - 12);
        double padW = landscape ? Col0->Width.Value - 12 : w / 2 - 12;
        double cellH = padH / 3.7, cellW = padW / 3;   // LeftPad rows: 0.7 + 3 x 1
        double fs = std::max(11.0, std::min(22.0, std::min(cellH * 0.5, cellW * 0.4)));
        for (auto pad : { LeftPad, RightPad })
            for (unsigned i = 0; i < pad->Children->Size; ++i)
            {
                auto b = dynamic_cast<Button^>(pad->Children->GetAt(i));
                if (b) { b->FontSize = (b == MenuButton) ? fs * 0.75 : fs; b->Padding = Thickness(0); }
            }
    }
}

// Vertical position of both pads inside their area (settings.padPos 0..100).
void MainPage::PlacePads()
{
    double m = 6;
    if (!m_landscape || m_padH <= 0)
    {
        LeftPad->Margin = Thickness(m);
        RightPad->Margin = Thickness(m);
        return;
    }
    double free = std::max(0.0, m_padAreaH - m_padH - 2 * m);
    double top = m + free * m_settings.padPos / 100.0;
    Thickness t(6, top, 6, 0);
    LeftPad->Margin = t;
    RightPad->Margin = t;
}

void MainPage::MenuMovePad_Click(Object^, RoutedEventArgs^)
{
    if (!m_settings.showKeypad) { m_settings.showKeypad = true; ApplySettings(); }
    m_padEdit = true;
    PadEditOverlay->Visibility = Windows::UI::Xaml::Visibility::Visible;
}

void MainPage::PadEdit_PointerPressed(Object^, PointerRoutedEventArgs^ e)
{
    m_padDrag = true;
    m_padDragY = e->GetCurrentPoint(Root)->Position.Y;
    m_padDragStartPos = m_settings.padPos;
    PadEditOverlay->CapturePointer(e->Pointer);
    e->Handled = true;
}

void MainPage::PadEdit_PointerMoved(Object^, PointerRoutedEventArgs^ e)
{
    if (!m_padDrag) return;
    double range = std::max(1.0, m_padAreaH - m_padH - 12);   // same as PlacePads
    double dy = e->GetCurrentPoint(Root)->Position.Y - m_padDragY;
    int pos = (int)std::lround(m_padDragStartPos + dy * 100.0 / range);
    pos = std::max(0, std::min(100, pos));
    if (pos != m_settings.padPos) { m_settings.padPos = pos; PlacePads(); }
    e->Handled = true;
}

void MainPage::PadEdit_PointerReleased(Object^, PointerRoutedEventArgs^ e)
{
    m_padDrag = false;
    PadEditOverlay->ReleasePointerCapture(e->Pointer);
}

void MainPage::PadEditDone_Click(Object^, RoutedEventArgs^)
{
    m_padEdit = false;
    m_padDrag = false;
    PadEditOverlay->Visibility = Windows::UI::Xaml::Visibility::Collapsed;
    if (!m_gameId.empty()) Library().SaveSettings(m_gameId, m_settings);
    AppLog("[ui] keypad position " + std::to_string(m_settings.padPos));
}

// Size of the LCD image inside LcdHost from the scale type + scale %.
void MainPage::UpdateLcdLayout()
{
    // Use the area ApplyLayout just assigned: LcdHost->ActualWidth/Height still hold
    // the previous layout until XAML re-arranges, which made the image taller than
    // its row (cut at top and bottom).
    double aw = m_lcdAreaW > 0 ? m_lcdAreaW : LcdHost->ActualWidth;
    double ah = m_lcdAreaH > 0 ? m_lcdAreaH : LcdHost->ActualHeight;
    int lw = m_lcdW > 0 ? m_lcdW : m_settings.width;
    int lh = m_lcdH > 0 ? m_lcdH : m_settings.height;
    if (aw <= 0 || ah <= 0 || lw <= 0 || lh <= 0) return;

    double kx, ky;
    // Portrait with keypad: the row is already the scaled image height, so scale
    // against the box ApplyLayout used (full width x 4/5 height), not the row,
    // otherwise the scale % was applied twice / had no visible effect.
    if (m_scaleAreaW > 0 && m_scaleAreaH > 0) LcdScale(m_scaleAreaW, m_scaleAreaH, lw, lh, &kx, &ky);
    else LcdScale(aw, ah, lw, lh, &kx, &ky);
    // Never crop: a scale % above 100 (or Original on a small area) is limited
    // to what fits, keeping the aspect it would have had.
    double over = std::max(lw * kx / aw, lh * ky / ah);
    if (over > 1.0) { kx /= over; ky /= over; }
    LcdImage->Width = std::max(1.0, lw * kx);
    LcdImage->Height = std::max(1.0, lh * ky);
    {
        char b[160];
        _snprintf_s(b, sizeof(b), _TRUNCATE, "[ui] layout win=%.0fx%.0f root=%.0fx%.0f lcd=%dx%d area=%.0fx%.0f img=%.0fx%.0f",
                    ActualWidth, ActualHeight, Root->ActualWidth, Root->ActualHeight, lw, lh, aw, ah, lw * kx, lh * ky);
        static std::string last;
        if (last != b) { last = b; AppLog(b); }
    }
    // nearest / linear scaling is done by the GPU (LcdPanel)
    m_lcdRedraw = true;
}

// ---- Frame loop -----------------------------------------------------------------

void MainPage::OnRendering(Object^, Object^)
{
    jvm_host_tick((unsigned int)GetTickCount64());
    // VM ended: free its sounds; if the MIDlet quit by itself (its own Exit
    // item -> notifyDestroyed), go back to the game list.
    bool running = jvm_host_is_running() != 0;
    if (m_vmWasRunning && !running)
    {
        AudioEngine_CloseAll();
        DeviceEngine_Reset();
        if (!m_leaving && !m_restarting)
        {
            AppLog("[ui] MIDlet exited, back to the game list");
            LeaveGame();
        }
    }
    m_vmWasRunning = running;
    UpdateLcd();
}

void MainPage::UpdateLcd()
{
    unsigned long long now = GetTickCount64();
    if (m_settings.showFps)
    {
        // Game FPS = frames the MIDlet flushed (not the frames this loop happened
        // to pick up: several flushes between two screen refreshes count once here).
        long flushes = jvm_host_frame_count();
        if (m_fpsStartMs == 0) { m_fpsStartMs = now; m_fpsFlushStart = flushes; }
        if (now - m_fpsStartMs >= 1000)
        {
            double secs = (now - m_fpsStartMs) / 1000.0;
            int game = (int)std::lround((flushes - m_fpsFlushStart) / secs);
            int shown = (int)std::lround(m_fpsFrames / secs);
            FpsText->Text = game.ToString() + L" FPS" + (shown < game ? L" (" + shown.ToString() + L" shown)" : L"");
            m_fpsFrames = 0;
            m_fpsStartMs = now;
            m_fpsFlushStart = flushes;
        }
    }
    if (m_settings.limitFps > 0 && now - m_lastFrameMs < 1000ull / m_settings.limitFps) return;

    int w = 0, h = 0, dirty = 0;
    const unsigned int* px = jvm_host_lcd(&w, &h, &dirty);
    if (!px || w <= 0 || h <= 0) return;

    if (w != m_lcdW || h != m_lcdH)
    {
        m_lcdW = w; m_lcdH = h;
        ApplyLayout();      // pad sizes depend on the LCD aspect
        UpdateLcdLayout();
    }
    if (!dirty && !m_lcdRedraw) return;
    m_lcdRedraw = false;
    if (dirty) { m_lastFrameMs = now; ++m_fpsFrames; }
    m_lcdPanel.Present(px, w, h, m_settings.filter);
}

// ---- Input ------------------------------------------------------------------------

bool MainPage::ToLcd(PointerRoutedEventArgs^ e, int& x, int& y)
{
    if (m_lcdW == 0) return false;
    Point p = e->GetCurrentPoint(LcdImage)->Position;
    double aw = LcdImage->ActualWidth, ah = LcdImage->ActualHeight;
    if (aw <= 0 || ah <= 0) return false;
    x = (int)(p.X * m_lcdW / aw);
    y = (int)(p.Y * m_lcdH / ah);
    x = std::max(0, std::min(m_lcdW - 1, x));
    y = std::max(0, std::min(m_lcdH - 1, y));
    return true;
}

void MainPage::Lcd_PointerPressed(Object^, PointerRoutedEventArgs^ e)
{
    int x, y;
    if (!ToLcd(e, x, y)) return;
    LcdImage->CapturePointer(e->Pointer);
    m_lcdDown = true;
    jvm_host_pointer(x, y, 0);
    e->Handled = true;
}

void MainPage::Lcd_PointerMoved(Object^, PointerRoutedEventArgs^ e)
{
    int x, y;
    if (!m_lcdDown || !ToLcd(e, x, y)) return;
    jvm_host_pointer(x, y, 1);
    e->Handled = true;
}

void MainPage::Lcd_PointerReleased(Object^, PointerRoutedEventArgs^ e)
{
    int x, y;
    if (!m_lcdDown) return;
    m_lcdDown = false;
    LcdImage->ReleasePointerCapture(e->Pointer);
    if (ToLcd(e, x, y)) jvm_host_pointer(x, y, 2);
    e->Handled = true;
}

// Tag = "k" or "k1,k2" (diagonals press two keys).
static int TagToKeys(Object^ sender, int keys[2])
{
    auto b = dynamic_cast<FrameworkElement^>(sender);
    if (b == nullptr || b->Tag == nullptr) return 0;
    const wchar_t* s = b->Tag->ToString()->Data();
    int n = 0;
    keys[n++] = _wtoi(s);
    const wchar_t* comma = wcschr(s, L',');
    if (comma) keys[n++] = _wtoi(comma + 1);
    return n;
}

// Buttons currently held: Released, Canceled and CaptureLost can all fire for one
// press, so a key-up is sent only once per key-down.
static std::set<void*> g_heldButtons;

void MainPage::Key_Pressed(Object^ sender, PointerRoutedEventArgs^)
{
    void* id = reinterpret_cast<void*>(sender);
    if (!g_heldButtons.insert(id).second) return;
    int keys[2];
    int n = TagToKeys(sender, keys);
    for (int i = 0; i < n; ++i) if (keys[i]) jvm_host_key(keys[i], 1);
}

void MainPage::Key_Released(Object^ sender, PointerRoutedEventArgs^)
{
    void* id = reinterpret_cast<void*>(sender);
    if (g_heldButtons.erase(id) == 0) return;
    int keys[2];
    int n = TagToKeys(sender, keys);
    for (int i = n - 1; i >= 0; --i) if (keys[i]) jvm_host_key(keys[i], 0);
}

static int MapVirtualKey(VirtualKey k)
{
    switch (k)
    {
    case VirtualKey::Up: return -1;
    case VirtualKey::Down: return -2;
    case VirtualKey::Left: return -3;
    case VirtualKey::Right: return -4;
    case VirtualKey::Enter: case VirtualKey::Space: return -5;
    case VirtualKey::F1: return -6;
    case VirtualKey::F2: return -7;
    case VirtualKey::Multiply: return '*';
    case VirtualKey::Divide: return '#';
    default: break;
    }
    int v = (int)k;
    if (v >= (int)VirtualKey::Number0 && v <= (int)VirtualKey::Number9) return '0' + v - (int)VirtualKey::Number0;
    if (v >= (int)VirtualKey::NumberPad0 && v <= (int)VirtualKey::NumberPad9) return '0' + v - (int)VirtualKey::NumberPad0;
    return 0;
}

void MainPage::Page_KeyDown(CoreWindow^, KeyEventArgs^ e)
{
    if (e->KeyStatus.WasKeyDown) return;   // ignore auto-repeat
    int k = MapVirtualKey(e->VirtualKey);
    if (k) { jvm_host_key(k, 1); e->Handled = true; }
}

void MainPage::Page_KeyUp(CoreWindow^, KeyEventArgs^ e)
{
    int k = MapVirtualKey(e->VirtualKey);
    if (k) { jvm_host_key(k, 0); e->Handled = true; }
}
