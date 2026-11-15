using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using Windows.ApplicationModel.Activation;
using Windows.Storage;
using Windows.Storage.Pickers;
using J2MEWPRuntime;

namespace J2MEWP81
{
    public partial class MainPage : PhoneApplicationPage
    {
        private static bool sortByAdded = false;
        private GameItem actionItem;

        public MainPage()
        {
            InitializeComponent();
            App.FilesPicked += OnFilesPicked;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);
            Refresh();
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
            NavigationService.Navigate(new Uri("/GamePage.xaml?id=" + Uri.EscapeDataString(item.Id), UriKind.Relative));
        }

        // ---- add games -------------------------------------------------------

        private void Add_Click(object sender, EventArgs e)
        {
            var picker = new FileOpenPicker();
            picker.FileTypeFilter.Add(".jar");
            picker.FileTypeFilter.Add(".jad");
            picker.SuggestedStartLocation = PickerLocationId.DocumentsLibrary;
            picker.PickMultipleFilesAndContinue();
        }

        private async void OnFilesPicked(FileOpenPickerContinuationEventArgs args)
        {
            var files = args.Files;
            if (files == null || files.Count == 0) return;
            var jars = files.Where(f => f.Name.EndsWith(".jar", StringComparison.OrdinalIgnoreCase)).ToList();
            var jads = files.Where(f => f.Name.EndsWith(".jad", StringComparison.OrdinalIgnoreCase)).ToList();
            int ok = 0;
            var failed = new List<string>();
            for (int i = 0; i < jars.Count; ++i)
            {
                var jar = jars[i];
                StatusText.Text = string.Format("Installing {0}/{1}: {2}", i + 1, jars.Count, jar.Name);
                try
                {
                    string jadText = "";
                    string stem = Path.GetFileNameWithoutExtension(jar.Name);
                    var jad = jads.FirstOrDefault(d => string.Equals(Path.GetFileNameWithoutExtension(d.Name), stem, StringComparison.OrdinalIgnoreCase));
                    if (jad != null) jadText = await FileIO.ReadTextAsync(jad);

                    var incoming = await ApplicationData.Current.LocalFolder.CreateFolderAsync("incoming", CreationCollisionOption.OpenIfExists);
                    var copy = await jar.CopyAsync(incoming, "pending.jar", NameCollisionOption.ReplaceExisting);
                    string path = copy.Path;
                    var entry = await Task.Run(() => Core.Install(path, jadText));
                    await copy.DeleteAsync();
                    if (entry != null) ok++;
                    else failed.Add(jar.Name + ": " + Core.LastError);
                }
                catch (Exception ex)
                {
                    failed.Add(jar.Name + ": " + ex.Message);
                }
            }
            StatusText.Text = "";
            Refresh();
            if (jars.Count == 0)
                MessageBox.Show("Pick the .jar file(s) of the game (a .jad alone is not enough).", "Add games", MessageBoxButton.OK);
            else if (failed.Count > 0)
                MessageBox.Show(string.Format("Installed {0} of {1}.\n\n{2}", ok, jars.Count, string.Join("\n", failed)), "Add games", MessageBoxButton.OK);
        }

        // ---- per-game actions --------------------------------------------------

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
                                    "The .jar file you picked is not touched.", "Remove game", MessageBoxButton.OKCancel);
            if (r == MessageBoxResult.OK) { Core.Remove(actionItem.Id); Refresh(); }
        }

        private void ActionCancel_Click(object sender, RoutedEventArgs e) { CloseActions(); }

        protected override void OnBackKeyPress(System.ComponentModel.CancelEventArgs e)
        {
            if (ActionPanel.Visibility == Visibility.Visible) { CloseActions(); e.Cancel = true; return; }
            base.OnBackKeyPress(e);
        }

        // ---- menu --------------------------------------------------------------

        private void SortName_Click(object sender, EventArgs e) { sortByAdded = false; Refresh(); }
        private void SortAdded_Click(object sender, EventArgs e) { sortByAdded = true; Refresh(); }

        private void About_Click(object sender, EventArgs e)
        {
            MessageBox.Show(
                "J2ME Windows Phone 8.1\n" + Core.Version() + "\n\n" +
                "Runs J2ME (MIDP 2.0) games. Based on the phoneME Feature sources by Sun Microsystems / Oracle (GPL v2).\n\n" +
                "Java and J2ME are trademarks of Oracle. This free, non-commercial app is not affiliated with Oracle.\n\n" +
                "Log: " + Core.LogPath(),
                "About", MessageBoxButton.OK);
        }
    }
}
