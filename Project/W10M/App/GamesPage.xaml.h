#pragma once
#include "GamesPage.g.h"
#include <memory>
#include <string>
#include <vector>

namespace J2MEW10M
{
    // "+" with several files picked: one job per .jar (+ matching .jad).
    struct InstallJob
    {
        Windows::Storage::StorageFile^ jar;
        Windows::Storage::StorageFile^ jad;
    };
    struct InstallStats
    {
        int ok = 0, failed = 0;
        std::wstring failedNames, lastName, lastError;
    };

    // One row of the game list (bound in GamesPage.xaml).
    [Windows::UI::Xaml::Data::Bindable]
    public ref class GameItem sealed
    {
    public:
        property Platform::String^ Id;
        property Platform::String^ Name;
        property Platform::String^ Vendor;
        property Platform::String^ Version;
        property Windows::UI::Xaml::Media::ImageSource^ Icon;
    };

    // Start page: installed games (J2ME Loader style). Tap = play,
    // hold / right-click = menu (play, settings, delete), + = add JAR/JAD.
    public ref class GamesPage sealed
    {
    public:
        GamesPage();

    protected:
        virtual void OnNavigatedTo(Windows::UI::Xaml::Navigation::NavigationEventArgs^ e) override;

    private:
        void Refresh();
        void Play(Platform::String^ id);
        void ShowSettings(Platform::String^ id);
        void ItemSettings_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void AboutButton_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void ConfirmDelete(Platform::String^ id);

        void GameList_ItemClick(Platform::Object^ sender, Windows::UI::Xaml::Controls::ItemClickEventArgs^ e);
        void Item_RightTapped(Platform::Object^ sender, Windows::UI::Xaml::Input::RightTappedRoutedEventArgs^ e);
        void AddButton_Tapped(Platform::Object^ sender, Windows::UI::Xaml::Input::TappedRoutedEventArgs^ e);
        void InstallNext(std::shared_ptr<std::vector<InstallJob>> jobs, size_t i, std::shared_ptr<InstallStats> stats);
        void SortByName_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void SortByDate_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);

        void SelectButton_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void SelectAll_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void SelectCancel_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void DeleteSelected_Click(Platform::Object^ sender, Windows::UI::Xaml::RoutedEventArgs^ e);
        void GameList_SelectionChanged(Platform::Object^ sender, Windows::UI::Xaml::Controls::SelectionChangedEventArgs^ e);
        void SetSelectMode(bool on);

        bool m_sortByDate = false;
        bool m_picking = false;      // FileOpenPicker open (only one at a time)
        bool m_selectMode = false;
    };
}
