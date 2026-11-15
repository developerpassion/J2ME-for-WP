#include "pch.h"
#include "GamesPage.xaml.h"
#include "MainPage.xaml.h"
#include "SettingsDialog.xaml.h"
#include "AppState.h"

#include <algorithm>

using namespace J2MEW10M;
using namespace concurrency;
using namespace Platform;
using namespace Platform::Collections;
using namespace Windows::Foundation;
using namespace Windows::Storage;
using namespace Windows::Storage::Pickers;
using namespace Windows::Storage::Streams;
using namespace Windows::UI::Popups;
using namespace Windows::UI::Xaml;
using namespace Windows::UI::Xaml::Controls;
using namespace Windows::UI::Xaml::Input;
using namespace Windows::UI::Xaml::Interop;
using namespace Windows::UI::Xaml::Media::Imaging;
using namespace Windows::UI::Xaml::Navigation;

GamesPage::GamesPage()
{
    InitializeComponent();
    AppInitCore();
}

void GamesPage::OnNavigatedTo(NavigationEventArgs^)
{
    Windows::UI::Core::SystemNavigationManager::GetForCurrentView()->AppViewBackButtonVisibility =
        Windows::UI::Core::AppViewBackButtonVisibility::Collapsed;
    Refresh();
}

void GamesPage::Refresh()
{
    std::vector<j2mewp::GameInfo> games = Library().List();
    if (m_sortByDate)
        std::stable_sort(games.begin(), games.end(),
            [](const j2mewp::GameInfo& a, const j2mewp::GameInfo& b) { return a.added > b.added; });

    auto items = ref new Vector<Object^>();
    for (const j2mewp::GameInfo& g : games)
    {
        auto it = ref new GameItem();
        it->Id = ToStr(g.id);
        it->Name = ToStr(g.name);
        it->Vendor = ToStr(g.vendor);
        it->Version = ToStr(g.version);
        if (!g.icon.empty())
        {
            String^ uri = L"ms-appdata:///local/games/" + Uri::EscapeComponent(it->Id) + L"/icon.png";
            it->Icon = ref new BitmapImage(ref new Uri(uri));
        }
        items->Append(it);
    }
    GameList->ItemsSource = items;
    EmptyText->Visibility = games.empty() ? Windows::UI::Xaml::Visibility::Visible
                                          : Windows::UI::Xaml::Visibility::Collapsed;
}

void GamesPage::Play(String^ id)
{
    Frame->Navigate(TypeName(MainPage::typeid), id);
}

void GamesPage::GameList_ItemClick(Object^, ItemClickEventArgs^ e)
{
    auto it = dynamic_cast<GameItem^>(e->ClickedItem);
    if (it) Play(it->Id);
}

void GamesPage::Item_RightTapped(Object^ sender, RightTappedRoutedEventArgs^ e)
{
    auto el = dynamic_cast<FrameworkElement^>(sender);
    if (!el || !el->Tag) return;
    String^ id = el->Tag->ToString();

    auto menu = ref new MenuFlyout();
    auto add = [&](const wchar_t* text, std::function<void()> fn)
    {
        auto item = ref new MenuFlyoutItem();
        item->Text = ref new String(text);
        item->Click += ref new RoutedEventHandler([fn](Object^, RoutedEventArgs^) { fn(); });
        menu->Items->Append(item);
    };
    add(L"Start", [this, id]() { Play(id); });
    add(L"Settings", [this, id]() { ShowSettings(id); });
    add(L"Remove from list", [this, id]() { ConfirmDelete(id); });
    menu->ShowAt(el, e->GetPosition(el));
    e->Handled = true;
}

void GamesPage::AboutButton_Click(Object^, RoutedEventArgs^)
{
    using namespace Windows::UI::Xaml::Controls;
    using namespace Windows::UI::Xaml::Documents;
    auto version = Windows::ApplicationModel::Package::Current->Id->Version;
    auto tb = ref new TextBlock();
    tb->TextWrapping = Windows::UI::Xaml::TextWrapping::Wrap;
    tb->IsTextSelectionEnabled = true;
    auto add = [tb](String^ text, bool bold) {
        auto r = ref new Run();
        r->Text = text;
        if (bold) r->FontWeight = Windows::UI::Text::FontWeights::SemiBold;
        tb->Inlines->Append(r);
        tb->Inlines->Append(ref new LineBreak());
    };
    add(L"J2ME Windows 10 Mobile " + version.Major.ToString() + L"." + version.Minor.ToString() + L"." +
        version.Build.ToString(), true);
    add(L"Runs J2ME games (MIDP 2.0 / CLDC 1.1) on Windows 10 Mobile.", false);
    add(L"", false);
    add(L"Source", true);
    add(L"Based on phoneME Feature (CLDC-HI Java VM + MIDP), the open source Java ME "
        L"implementation from Sun Microsystems, now Oracle, released under GPL v2. "
        L"Java and the Java logo are trademarks of Oracle and/or its affiliates.", false);
    add(L"", false);
    add(L"Free, non-commercial", true);
    add(L"This app is made only to share for free. It is not sold and no money is made from it. "
        L"Games belong to their authors.", false);
    add(L"", false);
    add(L"Support", true);
    add(L"If you want to support the project, donations only go to paying for the AI tools "
        L"used to build (\"vibe code\") this app. Thank you!", false);

    auto sv = ref new ScrollViewer();
    sv->Content = tb;
    sv->MaxHeight = 420;
    auto dlg = ref new ContentDialog();
    dlg->Title = L"About";
    dlg->Content = sv;
    dlg->PrimaryButtonText = L"OK";
    create_task(dlg->ShowAsync());
}

void GamesPage::ItemSettings_Click(Object^ sender, RoutedEventArgs^)
{
    auto b = safe_cast<Windows::UI::Xaml::FrameworkElement^>(sender);
    if (b->Tag) ShowSettings(b->Tag->ToString());
}

void GamesPage::ShowSettings(String^ id)
{
    std::wstring wid = id->Data();
    j2mewp::GameInfo info;
    if (!Library().Get(wid, &info)) return;
    auto dlg = ref new SettingsDialog();
    dlg->Title = ToStr(info.name);
    dlg->Load(Library().LoadSettings(wid));
    create_task(dlg->ShowAsync()).then([dlg, wid](ContentDialogResult r)
    {
        if (r == ContentDialogResult::Primary)
            Library().SaveSettings(wid, dlg->Read());
    }, task_continuation_context::use_current());
}

void GamesPage::ConfirmDelete(String^ id)
{
    std::wstring wid = id->Data();
    j2mewp::GameInfo info;
    if (!Library().Get(wid, &info)) return;
    // Only the app's own copy (LocalState\games\<id>) goes; the .jar the user
    // picked (Downloads, SD card...) is never touched.
    auto dlg = ref new MessageDialog(L"Remove \"" + ToStr(info.name) + L"\" from the game list?\n"
                                     L"Your original .jar file is not deleted.", L"Remove game");
    dlg->Commands->Append(ref new UICommand(L"Remove", nullptr, 1));
    dlg->Commands->Append(ref new UICommand(L"Cancel", nullptr, 0));
    dlg->DefaultCommandIndex = 1;
    dlg->CancelCommandIndex = 1;
    create_task(dlg->ShowAsync()).then([this, wid](IUICommand^ cmd)
    {
        if (cmd && cmd->Id && (int)cmd->Id == 1)
        {
            // RMS data of the suite lives in LocalState\midp\appdb and stays (MIDP owns it).
            Library().Remove(wid);
            AppLog("[ui] removed game " + ToUtf8(wid));
            Refresh();
        }
    }, task_continuation_context::use_current());
}

// ---- Select several games (delete together) ---------------------------------

void GamesPage::SetSelectMode(bool on)
{
    m_selectMode = on;
    GameList->SelectionMode = on ? ListViewSelectionMode::Multiple : ListViewSelectionMode::None;
    GameList->IsItemClickEnabled = !on;
    SelectBar->Visibility = on ? Windows::UI::Xaml::Visibility::Visible : Windows::UI::Xaml::Visibility::Collapsed;
    AddButton->Visibility = on ? Windows::UI::Xaml::Visibility::Collapsed : Windows::UI::Xaml::Visibility::Visible;
    // Header button shows the state: empty box = off, ticked box on accent = selecting.
    SelectButton->Content = on ? L"☑" : L"☐";
    SelectButton->Background = on
        ? safe_cast<Windows::UI::Xaml::Media::Brush^>(Windows::UI::Xaml::Application::Current->Resources->Lookup(L"SystemControlHighlightAccentBrush"))
        : ref new Windows::UI::Xaml::Media::SolidColorBrush(Windows::UI::Colors::Transparent);
    ToolTipService::SetToolTip(SelectButton, on ? L"Done selecting" : L"Select");
    GameList_SelectionChanged(nullptr, nullptr);
}

void GamesPage::SelectButton_Click(Object^, RoutedEventArgs^) { SetSelectMode(!m_selectMode); }
void GamesPage::SelectCancel_Click(Object^, RoutedEventArgs^) { SetSelectMode(false); }
void GamesPage::SelectAll_Click(Object^, RoutedEventArgs^)
{
    if (GameList->SelectedItems->Size == GameList->Items->Size) GameList->SelectedItems->Clear();
    else GameList->SelectAll();
}

void GamesPage::GameList_SelectionChanged(Object^, SelectionChangedEventArgs^)
{
    unsigned n = m_selectMode ? GameList->SelectedItems->Size : 0;
    SelectCountText->Text = n == 0 ? L"Select games" : n.ToString() + L" selected";
    DeleteSelectedButton->Content = n == 0 ? L"Remove" : L"Remove (" + n.ToString() + L")";
    DeleteSelectedButton->IsEnabled = n > 0;
}

void GamesPage::DeleteSelected_Click(Object^, RoutedEventArgs^)
{
    auto ids = std::make_shared<std::vector<std::wstring>>();
    for (unsigned i = 0; i < GameList->SelectedItems->Size; ++i)
    {
        auto item = dynamic_cast<GameItem^>(GameList->SelectedItems->GetAt(i));
        if (item) ids->push_back(item->Id->Data());
    }
    if (ids->empty()) return;
    auto dlg = ref new MessageDialog(L"Remove " + ids->size().ToString() + (ids->size() == 1 ? L" game" : L" games") +
                                     L" from the game list?\nYour original .jar files are not deleted.", L"Remove games");
    dlg->Commands->Append(ref new UICommand(L"Remove", nullptr, 1));
    dlg->Commands->Append(ref new UICommand(L"Cancel", nullptr, 0));
    dlg->DefaultCommandIndex = 1;
    dlg->CancelCommandIndex = 1;
    create_task(dlg->ShowAsync()).then([this, ids](IUICommand^ cmd)
    {
        if (!(cmd && cmd->Id && (int)cmd->Id == 1)) return;
        for (const std::wstring& id : *ids)
        {
            Library().Remove(id);
            AppLog("[ui] removed game " + ToUtf8(id));
        }
        StatusText->Text = L"Removed " + ids->size().ToString() + (ids->size() == 1 ? L" game" : L" games");
        SetSelectMode(false);
        Refresh();
    }, task_continuation_context::use_current());
}

void GamesPage::SortByName_Click(Object^, RoutedEventArgs^) { m_sortByDate = false; Refresh(); }
void GamesPage::SortByDate_Click(Object^, RoutedEventArgs^) { m_sortByDate = true; Refresh(); }

// + : pick a .jar (optionally with its .jad), copy it to the app's temp folder
// (Win32 file APIs cannot open picker locations), install into the library.
static std::string ToHex(unsigned v)
{
    char b[16];
    sprintf_s(b, "%08X", v);
    return b;
}

void GamesPage::AddButton_Tapped(Object^, TappedRoutedEventArgs^)
{
    // Only one picker at a time: a second PickMultipleFilesAsync while one is
    // open (double tap, tap while the picker is coming up) throws E_ACCESSDENIED
    // on Windows 10 Mobile and crashed the app.
    if (m_picking) return;
    auto picker = ref new FileOpenPicker();
    picker->ViewMode = PickerViewMode::List;
    picker->FileTypeFilter->Append(L".jar");
    picker->FileTypeFilter->Append(L".jad");

    Windows::Foundation::IAsyncOperation<Windows::Foundation::Collections::IVectorView<StorageFile^>^>^ op;
    try
    {
        op = picker->PickMultipleFilesAsync();
    }
    catch (Platform::Exception^ ex)
    {
        AppLog("[ui] file picker failed: 0x" + ToHex((unsigned)ex->HResult));
        StatusText->Text = L"Could not open the file picker (" + ex->Message + L"). Try again.";
        return;
    }
    m_picking = true;
    auto pick = create_task(op);
    pick.then([this](task<Windows::Foundation::Collections::IVectorView<StorageFile^>^> t)
    {
        m_picking = false;
        try { t.get(); }
        catch (Platform::Exception^ ex)
        {
            AppLog("[ui] file picker failed: 0x" + ToHex((unsigned)ex->HResult));
            StatusText->Text = L"Could not open the file picker. Try again.";
        }
        catch (const task_canceled&) {}
    }, task_continuation_context::use_current());
    pick.then([this](Windows::Foundation::Collections::IVectorView<StorageFile^>^ files)
    {
        if (!files || files->Size == 0) return;
        // Several games at once: each .jar is paired with the .jad of the same
        // name (or with the only .jad when exactly one .jar + one .jad are picked).
        std::vector<StorageFile^> jars, jads;
        for (StorageFile^ f : files)
        {
            std::wstring ext = f->FileType->Data();
            if (_wcsicmp(ext.c_str(), L".jar") == 0) jars.push_back(f);
            else if (_wcsicmp(ext.c_str(), L".jad") == 0) jads.push_back(f);
        }
        if (jars.empty())
        {
            StatusText->Text = L"Pick .jar files (a .jad can be picked together with its .jar).";
            return;
        }
        auto jobs = std::make_shared<std::vector<InstallJob>>();
        for (StorageFile^ jar : jars)
        {
            StorageFile^ jad = nullptr;
            std::wstring base = jar->DisplayName->Data();
            for (StorageFile^ d : jads)
                if (_wcsicmp(d->DisplayName->Data(), base.c_str()) == 0) { jad = d; break; }
            if (!jad && jars.size() == 1 && jads.size() == 1) jad = jads[0];
            jobs->push_back({ jar, jad });
        }
        auto stats = std::make_shared<InstallStats>();
        InstallNext(jobs, 0, stats);
    }, task_continuation_context::use_current());
}

// Installs jobs[i], then the next one (sequential: Install() works on one
// temp copy at a time). Shows progress and a summary at the end.
void GamesPage::InstallNext(std::shared_ptr<std::vector<InstallJob>> jobs, size_t i,
                            std::shared_ptr<InstallStats> stats)
{
    if (i >= jobs->size())
    {
        std::wstring msg = L"Added " + std::to_wstring(stats->ok) + L" game" + (stats->ok == 1 ? L"" : L"s");
        if (stats->failed) msg += L", " + std::to_wstring(stats->failed) + L" failed: " + stats->failedNames;
        if (jobs->size() == 1 && stats->ok == 1) msg = L"Added " + stats->lastName;
        if (jobs->size() == 1 && stats->failed == 1) msg = L"Install failed: " + stats->lastError;
        StatusText->Text = ref new String(msg.c_str());
        Refresh();
        return;
    }
    StorageFile^ jar = (*jobs)[i].jar;
    StorageFile^ jad = (*jobs)[i].jad;
    std::wstring progress = jobs->size() > 1
        ? std::to_wstring(i + 1) + L"/" + std::to_wstring(jobs->size()) + L": " : std::wstring();
    StatusText->Text = L"Installing " + ref new String(progress.c_str()) + jar->Name + L"...";
    auto jadText = std::make_shared<std::string>();
    task<void> readJad = jad
        ? create_task(FileIO::ReadBufferAsync(jad)).then([jadText](task<IBuffer^> t)
          {
              try
              {
                  IBuffer^ b = t.get();
                  unsigned char* p = BufferBytes(b);
                  if (p) jadText->assign((const char*)p, b->Length);
              }
              catch (Exception^) { }
          })
        : task_from_result();

    readJad.then([jar]()
    {
        return create_task(jar->CopyAsync(ApplicationData::Current->TemporaryFolder, L"install.jar",
                                          NameCollisionOption::ReplaceExisting));
    }).then([this, jobs, i, stats, jadText, jar](task<StorageFile^> t)
    {
        StorageFile^ tmp = nullptr;
        std::string err;
        try { tmp = t.get(); }
        catch (Exception^ ex) { err = "cannot copy the file: " + ToUtf8(ex->Message); }
        if (tmp)
        {
            std::wstring path = tmp->Path->Data();
            j2mewp::GameInfo info;
            bool ok = Library().Install(path, *jadText, &info, &err);
            DeleteFileW(path.c_str());
            if (ok)
            {
                AppLog("[ui] installed " + info.name + " (" + info.midletClass + ")");
                stats->ok++;
                stats->lastName = ToStr(info.name)->Data();
                Refresh();
            }
        }
        if (!err.empty())
        {
            AppLog("[ui] install failed (" + ToUtf8(jar->Name) + "): " + err);
            stats->failed++;
            if (!stats->failedNames.empty()) stats->failedNames += L", ";
            stats->failedNames += jar->Name->Data();
            stats->lastError = ToStr(err)->Data();
        }
        InstallNext(jobs, i + 1, stats);
    }, task_continuation_context::use_current());
}
