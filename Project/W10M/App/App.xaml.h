#pragma once
#include "App.g.h"

namespace J2MEW10M
{
    ref class App sealed
    {
    protected:
        virtual void OnLaunched(Windows::ApplicationModel::Activation::LaunchActivatedEventArgs^ e) override;
    internal:
        App();
    private:
        void OnSuspending(Platform::Object^ sender, Windows::ApplicationModel::SuspendingEventArgs^ e);
    };
}
