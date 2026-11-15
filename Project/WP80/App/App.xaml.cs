using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Shell;
using J2MEWPRuntime;

namespace J2MEWP81   // WP8.0 app; shares GamePage / SettingsPage / GameItem with the WP8.1 app
{
    public partial class App : Application
    {
        public static PhoneApplicationFrame RootFrame { get; private set; }

        public App()
        {
            UnhandledException += Application_UnhandledException;
            InitializeComponent();
            InitializePhoneApplication();
            Core.Init();
            Core.Log("[ui] WP8.0 Silverlight app " + Core.Version());
        }

        private void Application_Launching(object sender, LaunchingEventArgs e) { }

        private void Application_Activated(object sender, ActivatedEventArgs e)
        {
            if (Core.IsRunning) Core.Resume();
        }

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
            // .jar / .jad opened from email, the browser, OneDrive, the SD card...:
            // the OS navigates to /FileTypeAssociation?fileToken=... (WMAppManifest)
            RootFrame.UriMapper = new AssociationUriMapper();
            RootFrame.Navigated += CompleteInitializePhoneApplication;
            RootFrame.NavigationFailed += RootFrame_NavigationFailed;
            phoneApplicationInitialized = true;
        }

        private void CompleteInitializePhoneApplication(object sender, NavigationEventArgs e)
        {
            if (RootVisual != RootFrame) RootVisual = RootFrame;
            RootFrame.Navigated -= CompleteInitializePhoneApplication;
        }
    }

    // /FileTypeAssociation?fileToken=X  ->  /MainPage.xaml?fileToken=X
    internal class AssociationUriMapper : UriMapperBase
    {
        public override Uri MapUri(Uri uri)
        {
            string s = Uri.UnescapeDataString(uri.ToString());
            if (s.Contains("/FileTypeAssociation"))
            {
                int i = s.IndexOf("fileToken=", StringComparison.Ordinal);
                if (i >= 0)
                    return new Uri("/MainPage.xaml?fileToken=" + s.Substring(i + "fileToken=".Length), UriKind.Relative);
            }
            return uri;
        }
    }
}
