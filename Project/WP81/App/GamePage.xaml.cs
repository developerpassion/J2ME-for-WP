using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Shell;
using J2MEWPRuntime;

namespace J2MEWP81
{
    public partial class GamePage : PhoneApplicationPage
    {
        private string gameId;
        private string gameName = "";
        private GameSettings settings;
        private readonly LcdSurface surface = new LcdSurface();
        private long shown0;
        private bool vmWasRunning, leaving, restarting, rendering;
        private long fpsFrames0; private DateTime fpsTime0;
        private DateTime startTime;

        // [perf] line in j2me.log every 5 s: MIDlet frames, frames shown, UI ticks, copy cost
        private DateTime perfT0 = DateTime.UtcNow;
        private long perfFrames0;
        private int perfShown, perfTicks;
        private double perfUiMs;

        private void LogPerf()
        {
            double dt = (DateTime.UtcNow - perfT0).TotalSeconds;
            if (dt < 5) return;
            long n = Core.FrameCount;
            Core.Log(string.Format("[perf] midlet {0:0.0} fps, shown {1:0.0} fps, ui ticks {2:0.0}/s, copy {3:0.00} ms/tick, managed heap {4} MB",
                (n - perfFrames0) / dt, perfShown / dt, perfTicks / dt, perfTicks > 0 ? perfUiMs / perfTicks : 0,
                GC.GetTotalMemory(false) >> 20));
            perfT0 = DateTime.UtcNow; perfFrames0 = n; perfShown = perfTicks = 0; perfUiMs = 0;
        }

        // touch id -> MIDP key held by that finger
        // touch id -> key (Border) held by that finger; a key Tag is "M" (menu) or MIDP codes "-1" / "-1,-3" (diagonal)
        private readonly Dictionary<int, Border> heldKeys = new Dictionary<int, Border>();
        // MIDP code -> number of held keys sending it (diagonal + straight key share codes)
        private readonly Dictionary<int, int> codeRefs = new Dictionary<int, int>();
        private readonly List<Border> keys = new List<Border>();
        private int lcdTouchId = -1;

        public GamePage()
        {
            InitializeComponent();
            foreach (var pad in new[] { NavPad, NumPad })
                foreach (var child in pad.Children)
                    if (child is Border && ((Border)child).Tag != null) keys.Add((Border)child);
            keys.Add(FloatMenu);
            OrientationChanged += (s, e) => ApplyLayout();
            // the real page size (after rotation / system tray / nav bar changes)
            LayoutRoot.SizeChanged += (s, e) =>
            {
                if (Math.Abs(e.NewSize.Width - e.PreviousSize.Width) > 0.5 ||
                    Math.Abs(e.NewSize.Height - e.PreviousSize.Height) > 0.5) ApplyLayout();
            };
            LcdArea.SizeChanged += (s, e) => ApplyScale();
            // the game is drawn into the Lcd element (DrawingSurface): XAML places, rotates and scales it
            Core.Log("[lcd] page: set content provider");
            Lcd.SetContentProvider(surface.CreateContentProvider());
            Core.Log("[lcd] page: content provider set");
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);
            PhoneApplicationService.Current.UserIdleDetectionMode = IdleDetectionMode.Disabled;
            Touch.FrameReported += OnTouch;
            if (!rendering) { CompositionTarget.Rendering += OnRendering; rendering = true; }
            if (e.NavigationMode == NavigationMode.New)
            {
                NavigationContext.QueryString.TryGetValue("id", out gameId);
                foreach (var g in Core.ListGames()) if (g.Id == gameId) gameName = g.Name;
                MenuTitle.Text = gameName;
                LoadSettingsAndStart();
            }
            else if (settings != null && gameId != null)
            {
                // back from the settings page: new LCD size / heap need a restart
                var s = Core.LoadSettings(gameId);
                bool restart = s.Width != settings.Width || s.Height != settings.Height || s.HeapMB != settings.HeapMB;
                settings = s;
                ApplyLayout();
                if (restart) Restart();
            }
        }

        protected override void OnNavigatedFrom(NavigationEventArgs e)
        {
            base.OnNavigatedFrom(e);
            Touch.FrameReported -= OnTouch;
            ReleaseAllKeys();
            if (rendering) { CompositionTarget.Rendering -= OnRendering; rendering = false; }
            PhoneApplicationService.Current.UserIdleDetectionMode = IdleDetectionMode.Enabled;
        }

        private void LoadSettingsAndStart()
        {
            settings = Core.LoadSettings(gameId);
            switch (settings.Orientation)
            {
                case 1: SupportedOrientations = SupportedPageOrientation.Portrait; break;
                case 2: SupportedOrientations = SupportedPageOrientation.Landscape; break;
                default: SupportedOrientations = SupportedPageOrientation.PortraitOrLandscape; break;
            }
            LayoutRoot.Background = new SolidColorBrush(ToColor(settings.Background));
            ApplyLayout();
            StatusText.FontSize = 20;
            StatusText.Text = "Starting " + gameName + "...";
            if (!Core.Start(gameId)) StatusText.Text = "Could not start the game. See the log:\n" + Core.LogPath();
            else surface.SetActive(true);
            startTime = DateTime.UtcNow;
            shown0 = surface.FramesShown;
            fpsFrames0 = Core.FrameCount; fpsTime0 = DateTime.UtcNow;
        }

        private static Color ToColor(int rgb)
        {
            return Color.FromArgb(255, (byte)(rgb >> 16), (byte)(rgb >> 8), (byte)rgb);
        }

        // ---- layout ------------------------------------------------------------

        private void ApplyLayout()
        {
            bool pad = settings == null || settings.ShowKeypad;
            bool landscape = (Orientation & PageOrientation.Landscape) != 0;
            NavPad.Visibility = NumPad.Visibility = pad ? Visibility.Visible : Visibility.Collapsed;
            FloatMenu.Visibility = pad ? Visibility.Collapsed : Visibility.Visible;
            KeypadButton.Content = pad ? "Hide keypad" : "Show keypad";
            // moving the keypad only makes sense in landscape (portrait: pads fill their row)
            MovePadButton.Visibility = pad && (Orientation & PageOrientation.Landscape) != 0 ? Visibility.Visible : Visibility.Collapsed;
            double w = LayoutRoot.ActualWidth, h = LayoutRoot.ActualHeight;
            if (w <= 0 || h <= 0) { w = Application.Current.Host.Content.ActualWidth; h = Application.Current.Host.Content.ActualHeight; }
            double longSide = Math.Max(w, h), shortSide = Math.Min(w, h);
            // LCD aspect (width / height) of the game
            double aspect = settings != null && settings.Width > 0 && settings.Height > 0
                ? (double)settings.Width / settings.Height : 0.75;
            if (landscape)
            {
                // LCD as tall as the page with the game's aspect; each keypad gets the rest
                // (at least 18% of the width), cells kept about square (3 x 4 grid).
                double lcdW = pad ? Math.Min(shortSide * aspect, longSide * 0.64) : longSide;
                double padW = (longSide - lcdW) / 2;
                double padH = Math.Min(shortSide, padW * 4 / 3);
                Grid.SetRow(LcdArea, 0); Grid.SetRowSpan(LcdArea, 2);
                Grid.SetColumn(LcdArea, 1); Grid.SetColumnSpan(LcdArea, 1);
                Grid.SetRow(NavPad, 0); Grid.SetRowSpan(NavPad, 2); Grid.SetColumn(NavPad, 0);
                Grid.SetRow(NumPad, 0); Grid.SetRowSpan(NumPad, 2); Grid.SetColumn(NumPad, 2);
                LcdRow.Height = new GridLength(1, GridUnitType.Star);
                PadRow.Height = new GridLength(0);
                MidCol.Width = new GridLength(lcdW);
                LeftCol.Width = RightCol.Width = new GridLength(1, GridUnitType.Star);
                NavPad.Height = NumPad.Height = padH;
                // keypad position (0 = top, 100 = bottom), set with "Move keypad"
                padRoom = Math.Max(0, shortSide - padH - 8);
                int pos = settings != null ? Math.Max(0, Math.Min(100, settings.PadPos)) : 50;
                NavPad.VerticalAlignment = NumPad.VerticalAlignment = VerticalAlignment.Top;
                NavPad.Margin = NumPad.Margin = new Thickness(4, 4 + padRoom * pos / 100.0, 4, 4);
                ApplyScale();
                return;
            }
            // portrait: lcd on top, keypad (nav + numbers) below
            Grid.SetRow(LcdArea, 0); Grid.SetRowSpan(LcdArea, 1);
            Grid.SetColumn(LcdArea, 0); Grid.SetColumnSpan(LcdArea, 3);
            Grid.SetRow(NavPad, 1); Grid.SetRowSpan(NavPad, 1); Grid.SetColumn(NavPad, 0);
            Grid.SetRow(NumPad, 1); Grid.SetRowSpan(NumPad, 1); Grid.SetColumn(NumPad, 2);
            MidCol.Width = new GridLength(0);
            LeftCol.Width = RightCol.Width = new GridLength(1, GridUnitType.Star);
            LcdRow.Height = new GridLength(1, GridUnitType.Star);
            PadRow.Height = pad ? new GridLength(Math.Max(longSide * 0.34, 220)) : new GridLength(0);
            NavPad.Height = NumPad.Height = double.NaN;
            NavPad.VerticalAlignment = NumPad.VerticalAlignment = VerticalAlignment.Stretch;
            NavPad.Margin = NumPad.Margin = new Thickness(4);
            padRoom = 0;
            ApplyScale();
        }

        private void ApplyScale()
        {
            if (settings == null) return;
            double aw = LcdArea.ActualWidth, ah = LcdArea.ActualHeight;
            surface.SetStyle(settings.Background, settings.Filter);
            int gw = settings.Width > 0 ? settings.Width : Math.Max(1, Core.LcdWidth);
            int gh = settings.Height > 0 ? settings.Height : Math.Max(1, Core.LcdHeight);
            if (aw > 0 && ah > 0 && gw > 0 && gh > 0)
            {
                double fit = Math.Min(aw / gw, ah / gh), sx, sy;
                switch (settings.ScaleType)
                {
                    case 1:   // stretch
                        if (settings.KeepAspect) sx = sy = fit; else { sx = aw / gw; sy = ah / gh; }
                        break;
                    case 2:   // integer multiple (fit if the game is bigger than the area)
                        sx = sy = fit >= 1 ? Math.Floor(fit) : fit;
                        break;
                    case 3:   // original: one game pixel per DIP
                        sx = sy = Math.Min(1.0, fit);
                        break;
                    default:
                        sx = sy = fit;
                        break;
                }
                // scale % applied once, never larger than the area
                double s = Math.Min(Math.Max(10, settings.ScalePercent), 100) / 100.0;
                Lcd.Width = Math.Max(1, Math.Min(aw, gw * sx * s));
                Lcd.Height = Math.Max(1, Math.Min(ah, gh * sy * s));
            }
            Lcd.VerticalAlignment = settings.Gravity == 0 ? VerticalAlignment.Top
                                  : settings.Gravity == 2 ? VerticalAlignment.Bottom : VerticalAlignment.Center;
            FpsText.Visibility = settings.ShowFps ? Visibility.Visible : Visibility.Collapsed;
        }

        // ---- frame loop ----------------------------------------------------------

        private void OnRendering(object sender, EventArgs e)
        {
            Core.Tick();
            bool running = Core.IsRunning;
            if (vmWasRunning && !running && !leaving && !restarting)
            {
                // the MIDlet quit by itself (its own Exit command)
                if ((DateTime.UtcNow - startTime).TotalSeconds < 15)
                {
                    // stopped right after start: most likely a VM / MIDlet error -> show the log
                    Core.Log("[ui] MIDlet stopped right after start, showing the log");
                    surface.SetActive(false);
                    StatusText.FontSize = 13;
                    StatusText.Text = "The game stopped right after starting.\n" + LogTail(30)
                                    + "\n\n(Back -> Exit to return)";
                }
                else
                {
                    Core.Log("[ui] MIDlet exited, back to the game list");
                    Leave();
                }
            }
            vmWasRunning = running;
            if (!running) return;
            if (StatusText.Text.Length > 0 && !leaving && !restarting) StatusText.Text = "";

            // frames are drawn by LcdSurface on the compositor thread; count what it showed
            long shownNow = surface.FramesShown;
            perfShown += (int)(shownNow - shown0);
            shown0 = shownNow;
            perfTicks++;
            LogPerf();

            if (settings != null && settings.ShowFps)
            {
                double dt = (DateTime.UtcNow - fpsTime0).TotalSeconds;
                if (dt >= 1)
                {
                    long n = Core.FrameCount;
                    FpsText.Text = string.Format("{0:0} fps", (n - fpsFrames0) / dt);
                    fpsFrames0 = n; fpsTime0 = DateTime.UtcNow;
                }
            }
        }

        private static string LogTail(int lines)
        {
            try
            {
                using (var fs = new System.IO.FileStream(Core.LogPath(), System.IO.FileMode.Open,
                           System.IO.FileAccess.Read, System.IO.FileShare.ReadWrite))
                {
                    long n = Math.Min(fs.Length, 6000);
                    fs.Seek(-n, System.IO.SeekOrigin.End);
                    var buf = new byte[n];
                    int got = fs.Read(buf, 0, (int)n);
                    string[] all = System.Text.Encoding.UTF8.GetString(buf, 0, got).Replace("\r", "").Split('\n');
                    int from = Math.Max(0, all.Length - lines);
                    return string.Join("\n", all, from, all.Length - from);
                }
            }
            catch (Exception ex) { return "(log not readable: " + ex.Message + ")\n" + Core.LogPath(); }
        }

        // ---- input ---------------------------------------------------------------

        // Touch position of finger `id` relative to `el` (Silverlight applies every scale /
        // rotation / render transform itself; WP8.0 apps on 1080p+ phones are scaled, and
        // TransformToVisual-based maths drifted from the touch coordinates there).
        private static bool PointOn(TouchFrameEventArgs e, UIElement el, int id, out Point p)
        {
            foreach (TouchPoint tp in e.GetTouchPoints(el))
                if (tp.TouchDevice.Id == id) { p = tp.Position; return true; }
            p = new Point();
            return false;
        }

        // keys also take touches in the gaps around them (nearest key within KeySlop)
        private const double KeySlop = 12;

        private Border KeyAt(TouchFrameEventArgs e, int id)
        {
            Border best = null;
            double bestD = KeySlop;
            foreach (var k in keys)
            {
                if (k.Visibility != Visibility.Visible || k.ActualWidth <= 0) continue;
                FrameworkElement pad = k.Parent as FrameworkElement;
                if (pad != null && pad.Visibility != Visibility.Visible) continue;
                Point p;
                if (!PointOn(e, k, id, out p)) continue;
                double dx = p.X < 0 ? -p.X : (p.X > k.ActualWidth ? p.X - k.ActualWidth : 0);
                double dy = p.Y < 0 ? -p.Y : (p.Y > k.ActualHeight ? p.Y - k.ActualHeight : 0);
                double d = Math.Max(dx, dy);
                if (d < bestD || (d == 0 && bestD == 0)) { bestD = d; best = k; }
                if (d == 0) break;
            }
            return best;
        }

        private static bool IsMenu(Border k) { return k != null && (string)k.Tag == "M"; }

        private static IEnumerable<int> Codes(Border k)
        {
            foreach (string part in ((string)k.Tag).Split(','))
            {
                int c;
                if (int.TryParse(part.Trim(), out c)) yield return c;
            }
        }

        private void PressKey(Border k, bool down)
        {
            foreach (int code in Codes(k))
            {
                int n;
                codeRefs.TryGetValue(code, out n);
                if (down) { if (n == 0) Core.Key(code, true); codeRefs[code] = n + 1; }
                else if (n > 0) { if (n == 1) { Core.Key(code, false); codeRefs.Remove(code); } else codeRefs[code] = n - 1; }
            }
            k.Background = new SolidColorBrush(down ? Color.FromArgb(0x99, 0x52, 0x5B, 0xA0) : Color.FromArgb(0x33, 255, 255, 255));
        }

        private bool ToLcd(TouchFrameEventArgs e, int id, out int x, out int y)
        {
            x = y = 0;
            int gw = Core.LcdWidth, gh = Core.LcdHeight;
            if (gw <= 0 || gh <= 0 || Lcd.ActualWidth <= 0 || Lcd.ActualHeight <= 0) return false;
            Point q;
            if (!PointOn(e, Lcd, id, out q)) return false;
            x = (int)(q.X * gw / Lcd.ActualWidth);
            y = (int)(q.Y * gh / Lcd.ActualHeight);
            return x >= 0 && y >= 0 && x < gw && y < gh;
        }

        private void OnTouch(object sender, TouchFrameEventArgs e)
        {
            if (MenuPanel.Visibility == Visibility.Visible || PadEditPanel.Visibility == Visibility.Visible || !Core.IsRunning) return;
            foreach (TouchPoint tp in e.GetTouchPoints(LayoutRoot))
            {
                int id = tp.TouchDevice.Id;
                // a finger that started on the LCD stays a pointer (dragging over the keypad presses nothing)
                Border key = tp.Action == TouchAction.Up || id == lcdTouchId ? null : KeyAt(e, id);
                if (IsMenu(key))
                {
                    if (tp.Action == TouchAction.Down) { ReleaseAllKeys(); MenuPanel.Visibility = Visibility.Visible; return; }
                    continue;
                }
                Border old;
                bool had = heldKeys.TryGetValue(id, out old);
                if (had && old != key) { PressKey(old, false); heldKeys.Remove(id); had = false; }
                if (key != null && !had) { PressKey(key, true); heldKeys[id] = key; }

                // touch screen games: pointer events on the LCD
                if (key == null)
                {
                    int x, y;
                    bool inside = ToLcd(e, id, out x, out y);
                    if (tp.Action == TouchAction.Down && inside && lcdTouchId < 0) { lcdTouchId = id; Core.Pointer(x, y, 0); }
                    // jvm_host_pointer: 0 pressed, 1 dragged, 2 released (was swapped: every
                    // move sent a release -> drags in touch games jumped around)
                    else if (id == lcdTouchId && tp.Action == TouchAction.Move) Core.Pointer(Clamp(x, Core.LcdWidth), Clamp(y, Core.LcdHeight), 1);
                    else if (id == lcdTouchId && tp.Action == TouchAction.Up) { Core.Pointer(Clamp(x, Core.LcdWidth), Clamp(y, Core.LcdHeight), 2); lcdTouchId = -1; }
                }
            }
        }

        private static int Clamp(int v, int size) { return Math.Max(0, Math.Min(Math.Max(0, size - 1), v)); }

        private void ReleaseAllKeys()
        {
            foreach (var k in heldKeys.Values) PressKey(k, false);
            heldKeys.Clear();
            foreach (var code in codeRefs.Keys) Core.Key(code, false);
            codeRefs.Clear();
            lcdTouchId = -1;
        }

        // ---- menu / leaving --------------------------------------------------------

        protected override void OnBackKeyPress(System.ComponentModel.CancelEventArgs e)
        {
            e.Cancel = true;
            if (leaving) return;
            if (PadEditPanel.Visibility == Visibility.Visible) { PadEditDone_Click(null, null); return; }
            ReleaseAllKeys();
            MenuPanel.Visibility = MenuPanel.Visibility == Visibility.Visible ? Visibility.Collapsed : Visibility.Visible;
        }

        private void MenuContinue_Click(object sender, RoutedEventArgs e) { MenuPanel.Visibility = Visibility.Collapsed; }

        private void MenuKeypad_Click(object sender, RoutedEventArgs e)
        {
            MenuPanel.Visibility = Visibility.Collapsed;
            if (settings == null) return;
            settings.ShowKeypad = !settings.ShowKeypad;
            Core.SaveSettings(gameId, settings);
            ApplyLayout();
        }

        // ---- move keypad (landscape) -------------------------------------------------

        private double padRoom;          // free height above + below the pads (DIP)
        private double padDragPos;       // PadPos while dragging (double: smooth)

        private void MenuMovePad_Click(object sender, RoutedEventArgs e)
        {
            MenuPanel.Visibility = Visibility.Collapsed;
            if (settings == null) return;
            ReleaseAllKeys();
            padDragPos = Math.Max(0, Math.Min(100, settings.PadPos));
            PadEditPanel.Visibility = Visibility.Visible;
        }

        private void PadEdit_ManipulationDelta(object sender, ManipulationDeltaEventArgs e)
        {
            if (settings == null || padRoom <= 0) return;
            padDragPos = Math.Max(0, Math.Min(100, padDragPos + e.DeltaManipulation.Translation.Y * 100 / padRoom));
            settings.PadPos = (int)Math.Round(padDragPos);
            NavPad.Margin = NumPad.Margin = new Thickness(4, 4 + padRoom * padDragPos / 100.0, 4, 4);
            e.Handled = true;
        }

        private void PadEditDone_Click(object sender, RoutedEventArgs e)
        {
            PadEditPanel.Visibility = Visibility.Collapsed;
            if (settings == null) return;
            Core.SaveSettings(gameId, settings);
            ApplyLayout();
        }

        private void MenuRestart_Click(object sender, RoutedEventArgs e)
        {
            MenuPanel.Visibility = Visibility.Collapsed;
            Restart();
        }

        private void MenuExit_Click(object sender, RoutedEventArgs e)
        {
            MenuPanel.Visibility = Visibility.Collapsed;
            Leave();
        }

        private async void Restart()
        {
            if (restarting || leaving) return;
            restarting = true;
            surface.SetActive(false);
            StatusText.Text = "Restarting...";
            bool stopped = await Task.Run(() => Core.Stop(8000));
            vmWasRunning = false;
            restarting = false;
            if (!stopped) { StatusText.Text = "The game did not stop. Please restart the app."; return; }
            LoadSettingsAndStart();
        }

        private async void Leave()
        {
            if (leaving) return;
            leaving = true;
            surface.SetActive(false);
            StatusText.Text = "Stopping game...";
            await Task.Run(() => Core.Stop(8000));
            if (NavigationService.CanGoBack) NavigationService.GoBack();
        }
    }
}
