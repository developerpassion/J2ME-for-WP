#pragma once
#include "SettingsDialog.g.h"
#include "../../Shared/host/game_library.h"

namespace J2MEW10M
{
    // Per-game settings popup (screen size, scaling, background, FPS...).
    public ref class SettingsDialog sealed
    {
    public:
        SettingsDialog();

    internal:
        void Load(const j2mewp::GameSettings& s);
        j2mewp::GameSettings Read() const;   // invalid fields fall back to the loaded values

    private:
        void SwapButton_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void BackgroundBox_TextChanged(Platform::Object^ sender, Windows::UI::Xaml::Controls::TextChangedEventArgs^ e);
        void ResetButton_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);

        j2mewp::GameSettings m_loaded;
    };
}
