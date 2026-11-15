#include "pch.h"
#include "MainPage.xaml.h"
#include "GamesPage.xaml.h"
#include "AppState.h"
#include "AudioEngine.h"
#include "jvm_host.h"

using namespace J2MEW10M;
using namespace Platform;
using namespace Windows::ApplicationModel;
using namespace Windows::ApplicationModel::Activation;
using namespace Windows::UI::Xaml;
using namespace Windows::UI::Xaml::Controls;
using namespace Windows::UI::Xaml::Interop;

App::App()
{
    InitializeComponent();
    Suspending += ref new SuspendingEventHandler(this, &App::OnSuspending);
    Resuming += ref new Windows::Foundation::EventHandler<Object^>([](Object^, Object^) {
        AudioEngine_Suspend(false);
        jvm_host_resume();   // MIDlet.startApp()
    });
}

void App::OnLaunched(LaunchActivatedEventArgs^ e)
{
    auto rootFrame = dynamic_cast<Frame^>(Window::Current->Content);
    if (rootFrame == nullptr)
    {
        rootFrame = ref new Frame();
        Window::Current->Content = rootFrame;
    }
    if (rootFrame->Content == nullptr)
    {
        // Start on the game list; autorun.txt in LocalState (test scripts) opens a game directly.
        rootFrame->Navigate(TypeName(GamesPage::typeid), e->Arguments);
        std::wstring autorun = LocalPath() + L"\\autorun.txt";
        if (GetFileAttributesW(autorun.c_str()) != INVALID_FILE_ATTRIBUTES)
            rootFrame->Navigate(TypeName(MainPage::typeid), L"autorun");
    }
    Window::Current->Activate();
}

void App::OnSuspending(Object^, SuspendingEventArgs^)
{
    // W6.3: MIDlet.pauseApp() + suspend MIDP resources; resumed in Resuming.
    jvm_host_pause();
    AudioEngine_Suspend(true);
}
