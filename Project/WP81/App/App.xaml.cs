using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Shell;
using Windows.ApplicationModel.Activation;
using J2MEWPRuntime;

namespace J2MEWP81
{
    public partial class App : Application
    {
        public static PhoneApplicationFrame RootFrame { get; private set; }

        // File picker results arrive through ContractActivated (PickMultipleFilesAndContinue).
        public static event Action<FileOpenPickerContinuationEventArgs> FilesPicked;

        public App()
        {
            UnhandledException += Application_UnhandledException;
            InitializeComponent();
            InitializePhoneApplication();
            Core.Init();
            Core.Log("[ui] WP8.1 Silverlight app " + Core.Version());
        }

        private void Application_Launching(object sender, LaunchingEventArgs e) { }

        // Back to the app (from the start screen, a call, the file picker...).
        private void Application_Activated(object sender, ActivatedEventArgs e)
        {
            if (Core.IsRunning) Core.Resume();
        }

        // Leaving the app: pause the MIDlet (pauseApp) and the sound.
        private void Application_Deactivated(object sender, DeactivatedEventArgs e)
        {
            if (Core.IsRunning) Core.Pause();
        }

        private void Application_Closing(object sender, ClosingEventArgs e)
        {
            if (Core.IsRunning) Core.Stop(3000);
        }

        private void RootFrame_NavigationFailed(object sender, NavigationFailedEventArgs e)
        {
            Core.Log("[ui] navigation failed: " + e.Exception);
            if (Debugger.IsAttached) Debugger.Break();
        }

        private void Application_UnhandledException(object sender, ApplicationUnhandledExceptionEventArgs e)
        {
            try { Core.Log("[ui] unhandled: " + e.ExceptionObject); } catch { }
            if (Debugger.IsAttached) Debugger.Break();
        }

        private bool phoneApplicationInitialized = false;

        private void InitializePhoneApplication()
        {
            if (phoneApplicationInitialized) return;
            RootFrame = new PhoneApplicationFrame();
            RootFrame.Navigated += CompleteInitializePhoneApplication;
            RootFrame.NavigationFailed += RootFrame_NavigationFailed;
            RootFrame.Navigated += CheckForResetNavigation;
            PhoneApplicationService.Current.ContractActivated += Application_ContractActivated;
            phoneApplicationInitialized = true;
        }

        private void Application_ContractActivated(object sender, IActivatedEventArgs e)
        {
            var picked = e as FileOpenPickerContinuationEventArgs;
            if (picked != null && FilesPicked != null) FilesPicked(picked);
        }

        private void CompleteInitializePhoneApplication(object sender, NavigationEventArgs e)
        {
            if (RootVisual != RootFrame) RootVisual = RootFrame;
            RootFrame.Navigated -= CompleteInitializePhoneApplication;
        }

        private void CheckForResetNavigation(object sender, NavigationEventArgs e)
        {
            if (e.NavigationMode == NavigationMode.Reset) RootFrame.Navigated += ClearBackStackAfterReset;
        }

        private void ClearBackStackAfterReset(object sender, NavigationEventArgs e)
        {
            RootFrame.Navigated -= ClearBackStackAfterReset;
            if (e.NavigationMode != NavigationMode.New && e.NavigationMode != NavigationMode.Refresh) return;
            while (RootFrame.RemoveBackEntry() != null) { }
        }
    }
}
