using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using J2MEWPRuntime;

namespace J2MEWP81
{
    public partial class SettingsPage : PhoneApplicationPage
    {
        private static readonly string[] Sizes =
        {
            "128 x 128", "128 x 160", "176 x 208", "176 x 220", "208 x 208", "240 x 320",
            "320 x 240", "240 x 400", "360 x 640", "640 x 360", "480 x 800"
        };

        private string gameId;
        private GameSettings s;

        public SettingsPage()
        {
            InitializeComponent();
            SizeList.ItemsSource = Sizes;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);
            if (s != null) return;
            NavigationContext.QueryString.TryGetValue("id", out gameId);
            foreach (var g in Core.ListGames()) if (g.Id == gameId) GameTitle.Text = g.Name.ToUpper();
            s = Core.LoadSettings(gameId);
            WidthBox.Text = s.Width.ToString();
            HeightBox.Text = s.Height.ToString();
            OrientDefault.IsChecked = s.Orientation == 0;
            OrientPortrait.IsChecked = s.Orientation == 1;
            OrientLandscape.IsChecked = s.Orientation == 2;
            ScaleSlider.Value = Math.Max(30, Math.Min(100, s.ScalePercent));
            StretchBox.IsChecked = s.ScaleType == 1 && !s.KeepAspect;
            KeypadBox.IsChecked = s.ShowKeypad;
            FpsBox.IsChecked = s.ShowFps;
            Heap64.IsChecked = s.HeapMB < 96;
            Heap96.IsChecked = s.HeapMB >= 96 && s.HeapMB < 128;
            Heap128.IsChecked = s.HeapMB >= 128;
            UpdateScaleLabel();
        }

        private void SizeList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var t = SizeList.SelectedItem as string;
            if (t == null) return;
            var parts = t.Split('x');
            WidthBox.Text = parts[0].Trim();
            HeightBox.Text = parts[1].Trim();
        }

        private void ScaleSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e) { UpdateScaleLabel(); }

        private void UpdateScaleLabel()
        {
            if (ScaleLabel != null) ScaleLabel.Text = string.Format("Picture size: {0:0}% of the space", ScaleSlider.Value);
        }

        private void Save_Click(object sender, EventArgs e)
        {
            int w, h;
            if (!int.TryParse(WidthBox.Text, out w) || !int.TryParse(HeightBox.Text, out h) || w < 96 || h < 96 || w > 1024 || h > 1024)
            {
                MessageBox.Show("Width and height must be numbers between 96 and 1024.");
                return;
            }
            s.Width = w; s.Height = h;
            s.Orientation = OrientPortrait.IsChecked == true ? 1 : OrientLandscape.IsChecked == true ? 2 : 0;
            s.ScalePercent = (int)Math.Round(ScaleSlider.Value);
            bool stretch = StretchBox.IsChecked == true;
            s.ScaleType = stretch ? 1 : 0;
            s.KeepAspect = !stretch;
            s.ShowKeypad = KeypadBox.IsChecked == true;
            s.ShowFps = FpsBox.IsChecked == true;
            s.HeapMB = Heap128.IsChecked == true ? 128 : Heap96.IsChecked == true ? 96 : 64;
            Core.SaveSettings(gameId, s);
            NavigationService.GoBack();
        }

        private void Cancel_Click(object sender, EventArgs e) { NavigationService.GoBack(); }
    }
}
