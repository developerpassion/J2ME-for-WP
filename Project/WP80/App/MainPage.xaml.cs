using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Navigation;
using Microsoft.Phone;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Storage;
using Windows.Phone.Storage.SharedAccess;
using Windows.Storage;
using J2MEWPRuntime;

namespace J2MEWP81   // WP8.0 app (see App.xaml.cs)
{
    // A .jar found on the SD card (with the .jad of the same name in the same folder, if any)
    public class SdGame
    {
        public string Name { get; set; }
        public string Folder { get; set; }
        public ExternalStorageFile Jar { get; set; }
        public ExternalStorageFile Jad { get; set; }
    }

    // WP 8.0 has no file picker for arbitrary files, so games come from:
    //  - the SD card (ExternalStorage: lists only the file types registered in WMAppManifest = .jar/.jad),
    //  - a .jar/.jad opened in email / IE / OneDrive (FileTypeAssociation -> ?fileToken=...),
    //  - a small HTTP server for a browser on the same Wi-Fi (WifiReceiver, from the Ruffle WP8 port).
    public partial class MainPage : PhoneApplicationPage
    {
        private const string IncomingFolder = "incoming";
        private const string WifiFolder = "wifi";
        private static bool sortByAdded = false;
        private GameItem actionItem;
        private WifiReceiver wifi;
        private readonly List<SdGame> sdGames = new List<SdGame>();
        private bool installing;

        public MainPage()
        {
            InitializeComponent();
        }

        protected override async void OnNavigatedTo(NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);
            Refresh();
            // WP8.0: glyphs for Vietnamese text (first start: a few seconds, then cached)
            await FontAtlas.EnsureAsync(t => StatusText.Text = t);
            string token;
            if (NavigationContext.QueryString.TryGetValue("fileToken", out token))
            {
                NavigationContext.QueryString.Remove("fileToken");
                await InstallShared(token);
            }
        }

        protected override void OnNavigatedFrom(NavigationEventArgs e)
        {
            base.OnNavigatedFrom(e);
            StopWifi();
        }

        private void Refresh()
        {
            var items = Core.ListGames().Select(g => new GameItem(g));
            items = sortByAdded ? items.OrderByDescending(i => i.Entry.Added)
                                : items.OrderBy(i => i.Name, StringComparer.CurrentCultureIgnoreCase);
            var list = items.ToList();
            GameList.ItemsSource = list;
            EmptyText.Visibility = list.Count == 0 ? Visibility.Visible : Visibility.Collapsed;
        }

        private void GameList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var item = GameList.SelectedItem as GameItem;
            if (item == null) return;
            GameList.SelectedItem = null;
            StartGame(item);
        }

        private void StartGame(GameItem item)
        {
            if (!FontAtlas.Ready) { StatusText.Text = "Preparing fonts, please wait..."; return; }
            NavigationService.Navigate(new Uri("/GamePage.xaml?id=" + Uri.EscapeDataString(item.Id), UriKind.Relative));
        }

        // ---- install ---------------------------------------------------------------

        public static string SafeName(string name)
        {
            if (string.IsNullOrEmpty(name)) return "game.jar";
            var sb = new StringBuilder();
            foreach (char c in name) sb.Append(Path.GetInvalidFileNameChars().Contains(c) ? '_' : c);
            return sb.ToString();
        }

        private static async Task<string> ReadText(Stream s)
        {
            using (var r = new StreamReader(s, Encoding.UTF8)) return await r.ReadToEndAsync();
        }

        // Copies the JAR into LocalFolder\incoming, installs it into the game library, deletes the copy.
        // Returns null on success, else the error text.
        // One install at a time: several Wi-Fi uploads arrive while the previous one is still
        // installing (they used to share one temp file and corrupted each other's copy).
        private static readonly System.Threading.SemaphoreSlim installLock = new System.Threading.SemaphoreSlim(1, 1);

        private static string TempName()
        {
            return "pending_" + Guid.NewGuid().ToString("N") + ".jar";
        }

        private async Task<string> InstallJar(string displayName, Func<Task<Stream>> openJar, string jadText)
        {
            await installLock.WaitAsync();
            try
            {
                StorageFolder incoming = await ApplicationData.Current.LocalFolder.CreateFolderAsync(IncomingFolder, CreationCollisionOption.OpenIfExists);
                StorageFile copy = await incoming.CreateFileAsync(TempName(), CreationCollisionOption.ReplaceExisting);
                using (Stream src = await openJar())
                using (Stream dst = await copy.OpenStreamForWriteAsync())
                    await src.CopyToAsync(dst);
                string path = copy.Path;
                string jad = jadText ?? "";
                GameEntry entry = await Task.Run(() => Core.Install(path, jad));
                string error = entry != null ? null : displayName + ": " + Core.LastError;
                try { await copy.DeleteAsync(); } catch (Exception) { }
                return error;
            }
            finally { installLock.Release(); }
        }

        private async Task<string> InstallLocalFile(StorageFile jar, StorageFile jad)
        {
            string jadText = "";
            if (jad != null)
                using (Stream s = await jad.OpenStreamForReadAsync()) jadText = await ReadText(s);
            return await InstallJar(jar.Name, () => jar.OpenStreamForReadAsync(), jadText);
        }

        private void ShowResult(int ok, int total, List<string> failed, string title)
        {
            StatusText.Text = "";
            Refresh();
            if (failed.Count > 0)
                MessageBox.Show(string.Format("Installed {0} of {1}.\n\n{2}", ok, total, string.Join("\n", failed)), title, MessageBoxButton.OK);
            else if (ok > 0)
                StatusText.Text = ok == 1 ? "Game installed." : ok + " games installed.";
        }

        // A file opened from email / the browser / OneDrive / the SD card: /MainPage.xaml?fileToken=...
        private async Task InstallShared(string token)
        {
            string name = "game.jar";
            try
            {
                name = SafeName(SharedStorageAccessManager.GetSharedFileName(token));
                if (name.EndsWith(".jad", StringComparison.OrdinalIgnoreCase))
                {
                    MessageBox.Show("A .jad file alone cannot be installed: open the .jar file of the game.", "Add games", MessageBoxButton.OK);
                    return;
                }
                StatusText.Text = "Installing " + name + "...";
                GameEntry entry;
                var failed = new List<string>();
                await installLock.WaitAsync();
                try
                {
                    StorageFolder dir = await ApplicationData.Current.LocalFolder.CreateFolderAsync(IncomingFolder, CreationCollisionOption.OpenIfExists);
                    IStorageFile copy = await SharedStorageAccessManager.CopySharedFileAsync(dir, TempName(), NameCollisionOption.ReplaceExisting, token);
                    string path = copy.Path;
                    entry = await Task.Run(() => Core.Install(path, ""));
                    if (entry == null) failed.Add(name + ": " + Core.LastError);
                    try { await copy.DeleteAsync(); } catch (Exception) { }
                }
                finally { installLock.Release(); }
                ShowResult(entry != null ? 1 : 0, 1, failed, "Add games");
            }
            catch (Exception ex)
            {
                StatusText.Text = "";
                MessageBox.Show("Cannot open " + name + ": " + ex.Message, "Add games", MessageBoxButton.OK);
            }
        }

        // ---- add panel ---------------------------------------------------------------

        private void Add_Click(object sender, EventArgs e)
        {
            AddPanel.Visibility = Visibility.Visible;
            ApplicationBar.IsVisible = false;
        }

        private void CloseAddPanel()
        {
            StopWifi();
            AddPanel.Visibility = Visibility.Collapsed;
            ApplicationBar.IsVisible = true;
            Refresh();
        }

        // SD card
        private async void SdScan_Click(object sender, RoutedEventArgs e)
        {
            SdScanButton.IsEnabled = SdAllButton.IsEnabled = false;
            SdStatus.Text = "Scanning...";
            sdGames.Clear();
            SdList.ItemsSource = null;
            try
            {
                int devices = 0;
                foreach (ExternalStorageDevice sd in await ExternalStorage.GetExternalStorageDevicesAsync())
                {
                    devices++;
                    await ScanSd(sd.RootFolder, "", 0);
                }
                if (devices == 0) SdStatus.Text = "No SD card found.";
                else if (sdGames.Count == 0) SdStatus.Text = "No .jar files on the SD card.";
                else SdStatus.Text = sdGames.Count + " game(s) found. Tap one to install it.";
            }
            catch (Exception ex)
            {
                SdStatus.Text = "Cannot read the SD card: " + ex.Message;
            }
            SdList.ItemsSource = sdGames.ToList();
            SdScanButton.IsEnabled = true;
            SdAllButton.IsEnabled = sdGames.Count > 0;
        }

        private async Task ScanSd(ExternalStorageFolder folder, string path, int depth)
        {
            // GetFilesAsync only lists the file types the app registered (.jar / .jad in WMAppManifest)
            var files = (await folder.GetFilesAsync()).ToList();
            foreach (ExternalStorageFile f in files)
            {
                if (!f.Name.EndsWith(".jar", StringComparison.OrdinalIgnoreCase)) continue;
                string stem = Path.GetFileNameWithoutExtension(f.Name);
                ExternalStorageFile jad = files.FirstOrDefault(d => d.Name.EndsWith(".jad", StringComparison.OrdinalIgnoreCase) &&
                    string.Equals(Path.GetFileNameWithoutExtension(d.Name), stem, StringComparison.OrdinalIgnoreCase));
                sdGames.Add(new SdGame { Name = f.Name, Folder = path.Length > 0 ? path : "(SD card root)", Jar = f, Jad = jad });
            }
            if (depth >= 8) return;
            foreach (ExternalStorageFolder sub in await folder.GetFoldersAsync())
                await ScanSd(sub, path.Length > 0 ? path + "\\" + sub.Name : sub.Name, depth + 1);
        }

        private async Task<string> InstallSd(SdGame g)
        {
            string jadText = "";
            if (g.Jad != null)
                using (Stream s = await g.Jad.OpenForReadAsync()) jadText = await ReadText(s);
            return await InstallJar(g.Name, () => g.Jar.OpenForReadAsync(), jadText);
        }

        private async Task InstallSdGames(List<SdGame> games)
        {
            if (installing || games.Count == 0) return;
            installing = true;
            SdScanButton.IsEnabled = SdAllButton.IsEnabled = false;
            int ok = 0;
            var failed = new List<string>();
            for (int i = 0; i < games.Count; ++i)
            {
                SdStatus.Text = string.Format("Installing {0}/{1}: {2}", i + 1, games.Count, games[i].Name);
                try
                {
                    string err = await InstallSd(games[i]);
                    if (err == null) ok++; else failed.Add(err);
                }
                catch (Exception ex) { failed.Add(games[i].Name + ": " + ex.Message); }
            }
            SdStatus.Text = string.Format("Installed {0} of {1}.", ok, games.Count);
            installing = false;
            SdScanButton.IsEnabled = true;
            SdAllButton.IsEnabled = sdGames.Count > 0;
            ShowResult(ok, games.Count, failed, "SD card");
        }

        private async void SdList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var g = SdList.SelectedItem as SdGame;
            if (g == null) return;
            SdList.SelectedItem = null;
            await InstallSdGames(new List<SdGame> { g });
        }

        private async void SdInstallAll_Click(object sender, RoutedEventArgs e)
        {
            await InstallSdGames(sdGames.ToList());
        }

        // Wi-Fi
        private static Task<StorageFolder> WifiDir()
        {
            return ApplicationData.Current.LocalFolder.CreateFolderAsync(WifiFolder, CreationCollisionOption.OpenIfExists).AsTask();
        }

        // one line of the Wi-Fi list: a file that arrived and what happened to it
        public class WifiItem
        {
            public string Name { get; set; }
            public string Result { get; set; }
            public System.Windows.Media.Brush ResultBrush { get; set; }
        }

        private readonly System.Collections.ObjectModel.ObservableCollection<WifiItem> wifiItems =
            new System.Collections.ObjectModel.ObservableCollection<WifiItem>();

        private static string Size(long bytes)
        {
            if (bytes >= 1024 * 1024) return (bytes / (1024.0 * 1024)).ToString("0.0") + " MB";
            if (bytes >= 1024) return (bytes / 1024) + " KB";
            return bytes + " B";
        }

        private void WifiLine(string name, string result, bool ok)
        {
            // subtle grey for progress / success, red for errors
            var brush = ok ? (System.Windows.Media.Brush)Application.Current.Resources["PhoneSubtleBrush"]
                           : new System.Windows.Media.SolidColorBrush(System.Windows.Media.Color.FromArgb(255, 0xE5, 0x14, 0x00));
            WifiItem item = wifiItems.FirstOrDefault(i => i.Name == name);
            if (item != null) wifiItems.Remove(item);
            wifiItems.Insert(0, new WifiItem { Name = name, Result = result, ResultBrush = brush });
        }

        private async void Wifi_Click(object sender, RoutedEventArgs e)
        {
            if (wifi != null && wifi.Running) { StopWifi(); return; }
            WifiList.ItemsSource = wifiItems;
            try
            {
                wifi = new WifiReceiver(WifiDir);
                wifi.Received += name => Dispatcher.BeginInvoke(() => OnWifiReceived(name));
                wifi.Error += msg => Dispatcher.BeginInvoke(() =>
                {
                    WifiProgress.Visibility = Visibility.Collapsed;
                    WifiStatus.Text = "Transfer error: " + msg;
                });
                wifi.Progress += (name, got, total) => Dispatcher.BeginInvoke(() =>
                {
                    double pct = total > 0 ? Math.Min(100, got * 100.0 / total) : 0;
                    WifiProgress.Visibility = Visibility.Visible;
                    WifiProgress.Value = pct;
                    WifiStatus.Text = "Receiving " + name + "... " + (int)pct + "% (" + Size(got) + " / " + Size(total) + ")";
                });
                await wifi.Start();
                List<string> addrs = WifiReceiver.Addresses();
                WifiButton.Content = "Stop Wi-Fi receiver";
                if (addrs.Count == 0)
                {
                    WifiAddress.Visibility = Visibility.Collapsed;
                    WifiStatus.Text = "No network. Connect the phone to Wi-Fi, then start the receiver again.";
                }
                else
                {
                    WifiAddress.Text = string.Join("\n", addrs);
                    WifiAddress.Visibility = Visibility.Visible;
                    WifiStatus.Text = "Open this address in a browser on the same Wi-Fi and choose the .jar files.";
                }
                Microsoft.Phone.Shell.PhoneApplicationService.Current.UserIdleDetectionMode = Microsoft.Phone.Shell.IdleDetectionMode.Disabled;
            }
            catch (Exception ex)
            {
                wifi = null;
                WifiStatus.Text = "Cannot start the receiver on port " + WifiReceiver.Port + ": " + ex.Message;
            }
        }

        private void StopWifi()
        {
            if (wifi == null) return;
            wifi.Stop();
            wifi = null;
            WifiButton.Content = "Start Wi-Fi receiver";
            WifiAddress.Visibility = Visibility.Collapsed;
            WifiProgress.Visibility = Visibility.Collapsed;
            WifiStatus.Text = "";
            Microsoft.Phone.Shell.PhoneApplicationService.Current.UserIdleDetectionMode = Microsoft.Phone.Shell.IdleDetectionMode.Enabled;
        }

        // a file arrived over Wi-Fi: install .jar files (with a .jad of the same name sent before it)
        private async void OnWifiReceived(string name)
        {
            WifiProgress.Visibility = Visibility.Collapsed;
            if (!name.EndsWith(".jar", StringComparison.OrdinalIgnoreCase))
            {
                WifiLine(name, "Received (used with the .jar of the same name)", true);
                WifiStatus.Text = "Received " + name + ".";
                return;
            }
            WifiLine(name, "Installing...", true);
            WifiStatus.Text = "Installing " + name + "...";
            try
            {
                StorageFolder dir = await WifiDir();
                StorageFile jar = await dir.GetFileAsync(name);
                StorageFile jad = null;
                try { jad = await dir.GetFileAsync(Path.GetFileNameWithoutExtension(name) + ".jad"); } catch (Exception) { }
                string err = await InstallLocalFile(jar, jad);
                try { await jar.DeleteAsync(); if (jad != null) await jad.DeleteAsync(); } catch (Exception) { }
                if (err == null) { WifiLine(name, "Installed", true); WifiStatus.Text = "Installed " + name + ". Send more, or press Back to see your games."; }
                else { WifiLine(name, "Failed: " + err, false); WifiStatus.Text = "Could not install " + name + "."; }
                Refresh();
            }
            catch (Exception ex)
            {
                WifiLine(name, "Failed: " + ex.Message, false);
                WifiStatus.Text = "Could not install " + name + ".";
            }
        }

        // ---- per-game actions ----------------------------------------------------------

        private void GameItem_Hold(object sender, GestureEventArgs e)
        {
            var item = (sender as FrameworkElement).DataContext as GameItem;
            if (item == null) return;
            e.Handled = true;
            actionItem = item;
            ActionTitle.Text = item.Name;
            ActionPanel.Visibility = Visibility.Visible;
            ApplicationBar.IsVisible = false;
        }

        private void CloseActions()
        {
            ActionPanel.Visibility = Visibility.Collapsed;
            ApplicationBar.IsVisible = true;
        }

        private void ActionPanel_Tap(object sender, GestureEventArgs e)
        {
            if (e.OriginalSource == ActionPanel) CloseActions();
        }

        private void ActionStart_Click(object sender, RoutedEventArgs e) { CloseActions(); if (actionItem != null) StartGame(actionItem); }

        private void ActionSettings_Click(object sender, RoutedEventArgs e)
        {
            CloseActions();
            if (actionItem != null)
                NavigationService.Navigate(new Uri("/SettingsPage.xaml?id=" + Uri.EscapeDataString(actionItem.Id), UriKind.Relative));
        }

        private void ActionRemove_Click(object sender, RoutedEventArgs e)
        {
            CloseActions();
            if (actionItem == null) return;
            var r = MessageBox.Show("Remove \"" + actionItem.Name + "\" from the list?\n\nThis deletes the app's copy of the game and its settings and saves. " +
                                    "The original .jar file is not touched.", "Remove game", MessageBoxButton.OKCancel);
            if (r == MessageBoxResult.OK) { Core.Remove(actionItem.Id); Refresh(); }
        }

        private void ActionCancel_Click(object sender, RoutedEventArgs e) { CloseActions(); }

        protected override void OnBackKeyPress(System.ComponentModel.CancelEventArgs e)
        {
            if (ActionPanel.Visibility == Visibility.Visible) { CloseActions(); e.Cancel = true; return; }
            if (AddPanel.Visibility == Visibility.Visible) { if (!installing) CloseAddPanel(); e.Cancel = true; return; }
            base.OnBackKeyPress(e);
        }

        // ---- menu ----------------------------------------------------------------------

        private void SortName_Click(object sender, EventArgs e) { sortByAdded = false; Refresh(); }
        private void SortAdded_Click(object sender, EventArgs e) { sortByAdded = true; Refresh(); }

        private void About_Click(object sender, EventArgs e)
        {
            MessageBox.Show(
                "J2ME Windows Phone 8\n" + Core.Version() + "\n\n" +
                "Runs J2ME (MIDP 2.0) games. Based on the phoneME Feature sources by Sun Microsystems / Oracle (GPL v2).\n\n" +
                "Java and J2ME are trademarks of Oracle. This free, non-commercial app is not affiliated with Oracle.\n\n" +
                "WP8.0 build: MIDP bitmap font (no Vietnamese/CJK text), no MP3/AMR sound.\n\n" +
                "Log: " + Core.LogPath(),
                "About", MessageBoxButton.OK);
        }
    }
}
