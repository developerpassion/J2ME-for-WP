#include "pch.h"
#include "DeviceEngine.h"
#include "AppState.h"
#include "../../../phoneME_feature/midp/src/media/include/j2mewp_audio.h"

using namespace Windows::Foundation;
#ifndef J2MEWP_WP81
using namespace Windows::Foundation::Metadata;
#endif
using namespace Windows::UI::Core;

namespace
{
using Windows::Phone::Devices::Notification::VibrationDevice;

VibrationDevice^ g_vib = nullptr;
CoreDispatcher^ g_dispatcher = nullptr;
Windows::System::Display::DisplayRequest^ g_displayRequest = nullptr;
volatile long g_lightOn = 0;   // UI thread owns g_displayRequest state
volatile long g_wantLight = 0; // last request from the MIDlet (any thread)

int B_Vibrate(int ms)
{
    VibrationDevice^ v = g_vib;
    if (v == nullptr) return 0;
    try
    {
        if (ms <= 0) v->Cancel();
        else
        {
            if (ms > 5000) ms = 5000;
            TimeSpan t; t.Duration = (long long)ms * 10000;
            v->Vibrate(t);
        }
    }
    catch (::Platform::Exception^) { return 0; }
    return 1;
}

void SetLightOnUi(bool on)
{
    if (g_displayRequest == nullptr) return;
    try
    {
        if (on && !g_lightOn) { g_displayRequest->RequestActive(); g_lightOn = 1; }
        else if (!on && g_lightOn) { g_displayRequest->RequestRelease(); g_lightOn = 0; }
    }
    catch (::Platform::Exception^) { }
}

void B_Backlight(int on)
{
    InterlockedExchange(&g_wantLight, on ? 1 : 0);
    if (g_dispatcher == nullptr) return;
    bool want = on != 0;
    g_dispatcher->RunAsync(CoreDispatcherPriority::Normal,
        ref new DispatchedHandler([want]() { SetLightOnUi(want); }));
}

int B_HasVibrator() { return g_vib != nullptr ? 1 : 0; }

const J2mewpDeviceBackend g_backend = { B_Vibrate, B_Backlight, B_HasVibrator };
} // namespace

void DeviceEngine_Init()
{
    try
    {
        auto win = CoreWindow::GetForCurrentThread();
        if (win != nullptr) g_dispatcher = win->Dispatcher;
        g_displayRequest = ref new Windows::System::Display::DisplayRequest();
    }
    catch (::Platform::Exception^) { }
#ifdef J2MEWP_WP81
    // WP8.1: phone-only build, VibrationDevice always exists (no ApiInformation in 8.1)
    if (true)
#else
    if (ApiInformation::IsTypePresent(L"Windows.Phone.Devices.Notification.VibrationDevice"))
#endif
    {
        try { g_vib = VibrationDevice::GetDefault(); }
        catch (::Platform::Exception^) { g_vib = nullptr; }
    }
    j2mewp_device_set_backend(&g_backend);
    J2MEW10M::AppLog(g_vib != nullptr ? "[device] vibrator ready" : "[device] no vibrator");
}

// MIDlet ended: stop vibrating and give the screen timeout back.
// Called on the UI thread.
void DeviceEngine_Reset()
{
    InterlockedExchange(&g_wantLight, 0);
    B_Vibrate(0);
    SetLightOnUi(false);
}

bool DeviceEngine_WantsLight() { return g_wantLight != 0; }
