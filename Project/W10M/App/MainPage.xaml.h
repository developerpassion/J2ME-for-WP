#pragma once
#include "MainPage.g.h"
#include "../../Shared/host/game_library.h"
#include "LcdPanel.h"

namespace J2MEW10M
{
    // Game screen: LCD + virtual keypad. Navigation parameter = game id in the
    // library (or "autorun" for LocalState\autorun.txt, used by test scripts).
    public ref class MainPage sealed
    {
    public:
        MainPage();

    protected:
        virtual void OnNavigatedTo(Windows::UI::Xaml::Navigation::NavigationEventArgs^ e) override;
        virtual void OnNavigatedFrom(Windows::UI::Xaml::Navigation::NavigationEventArgs^ e) override;

    private:
        void OnRendering(Platform::Object^ sender, Platform::Object^ e);
        void UpdateLcd();
        void UpdateLcdLayout();
        void ApplySettings();
        void StartGame();
        void LeaveGame();
        bool ToLcd(Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e, int& x, int& y);

        void OnSizeChanged(Platform::Object^ sender, Windows::UI::Xaml::SizeChangedEventArgs^ e);
        void LcdHost_SizeChanged(Platform::Object^ sender, Windows::UI::Xaml::SizeChangedEventArgs^ e);
        void ApplyLayout();
        void Key_Pressed(Platform::Object^ sender, Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e);
        void Key_Released(Platform::Object^ sender, Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e);
        void Lcd_PointerPressed(Platform::Object^ sender, Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e);
        void Lcd_PointerMoved(Platform::Object^ sender, Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e);
        void Lcd_PointerReleased(Platform::Object^ sender, Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e);
        void Page_KeyDown(Windows::UI::Core::CoreWindow^ sender, Windows::UI::Core::KeyEventArgs^ e);
        void Page_KeyUp(Windows::UI::Core::CoreWindow^ sender, Windows::UI::Core::KeyEventArgs^ e);
        void OnBackRequested(Platform::Object^ sender, Windows::UI::Core::BackRequestedEventArgs^ e);
        void MenuSettings_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void MenuKeypad_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void GameMenu_Opening(Platform::Object^ sender, Platform::Object^ e);
        void ShowGameMenu();
        void SetStatusBarVisible(bool visible);
        void MenuMovePad_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void PadEdit_PointerPressed(Platform::Object^ sender, Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e);
        void PadEdit_PointerMoved(Platform::Object^ sender, Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e);
        void PadEdit_PointerReleased(Platform::Object^ sender, Windows::UI::Xaml::Input::PointerRoutedEventArgs^ e);
        void PadEditDone_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void PlacePads();
        bool m_padEdit = false;
        bool m_landscape = false;
        bool m_vmWasRunning = false;   // to notice the MIDlet exiting by itself
        bool m_restarting = false;     // StartGame() is stopping the previous VM
        double m_scaleAreaW = 0, m_scaleAreaH = 0;   // portrait: box the scale % applies to
        bool m_padDrag = false;
        double m_padDragY = 0;
        int m_padDragStartPos = 50;
        double m_padAreaH = 0, m_padH = 0;   // pad row/column height and pad height (ApplyLayout)
        void LcdScale(double aw, double ah, int lw, int lh, double* kx, double* ky);
        void MenuRestart_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void MenuList_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);

        LcdPanel m_lcdPanel;
        bool m_lcdRedraw = true;     // panel resized: present the current frame again
        Windows::Foundation::EventRegistrationToken m_renderToken, m_keyDownToken, m_keyUpToken, m_backToken;
        int m_lcdW = 0;
        int m_lcdH = 0;
        double m_lcdAreaW = 0, m_lcdAreaH = 0;   // LCD area chosen by ApplyLayout
        bool m_lcdDown = false;
        bool m_leaving = false;

        std::wstring m_gameId;
        std::wstring m_jar;
        std::string m_class;
        Platform::String^ m_title;
        j2mewp::GameSettings m_settings;

        unsigned long long m_lastFrameMs = 0;
        unsigned long long m_fpsStartMs = 0;
        int m_fpsFrames = 0;
        long m_fpsFlushStart = 0;
    };
}
