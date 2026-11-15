using System;
using System.Collections.Generic;
using System.IO;
using System.IO.IsolatedStorage;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using J2MEWPRuntime;

namespace J2MEWP81
{
    // WP 8.0 has no DirectWrite, so MIDP text (Vietnamese...) is drawn with glyphs the app
    // renders itself with the phone font (Silverlight TextBlock -> WriteableBitmap), for the
    // MIDP sizes 12/14/16 px, regular + bold. Built once (a few seconds on the first start),
    // cached in fontcache.bin, then handed to the native side (Core.SetFontGlyphs).
    public static class FontAtlas
    {
        private const string CacheFile = "fontcache.bin";
        private const int CacheVersion = 1;
        private static readonly int[] Sizes = { 12, 14, 16 };
        private const string FontName = "Segoe WP";

        public static bool Ready { get; private set; }
        private static Task building;

        private class FaceData
        {
            public int Px, Bold, Ascent, Descent;
            public List<int> Records = new List<int>();
            public List<byte> Alpha = new List<byte>();
        }

        private static IEnumerable<int> Codepoints()
        {
            for (int c = 0x20; c <= 0x7E; c++) yield return c;
            for (int c = 0xA0; c <= 0x17F; c++) yield return c;           // Latin-1 + Latin Extended-A (Ă ă Đ đ Ĩ ĩ Ũ ũ...)
            foreach (int c in new[] { 0x1A0, 0x1A1, 0x1AF, 0x1B0 }) yield return c;   // Ơ ơ Ư ư
            for (int c = 0x1EA0; c <= 0x1EF9; c++) yield return c;         // Vietnamese precomposed
            foreach (int c in new[] { 0x300, 0x301, 0x303, 0x309, 0x323,  // combining tone marks
                                      0x2013, 0x2014, 0x2018, 0x2019, 0x201C, 0x201D, 0x2022, 0x2026, 0x20AB, 0x20AC, 0x2122 })
                yield return c;
        }

        // Call on the UI thread (MainPage loaded). Safe to call more than once.
        public static Task EnsureAsync(Action<string> status)
        {
            if (Core.HasHostFonts) { Ready = true; return Task.FromResult(0); }
            if (building == null) building = BuildAsync(status);
            return building;
        }

        private static async Task BuildAsync(Action<string> status)
        {
            List<FaceData> faces = LoadCache();
            if (faces == null)
            {
                faces = new List<FaceData>();
                var cps = new List<int>(Codepoints());
                int total = cps.Count * Sizes.Length * 2, done = 0;
                foreach (int px in Sizes)
                    for (int bold = 0; bold < 2; bold++)
                    {
                        var f = new FaceData { Px = px, Bold = bold };
                        Baseline(px, bold != 0, out f.Ascent, out f.Descent);
                        foreach (int cp in cps)
                        {
                            RenderGlyph(f, cp);
                            if (++done % 40 == 0)
                            {
                                if (status != null) status(string.Format("Preparing fonts (first start only): {0}%", done * 100 / total));
                                await Task.Delay(1);   // let the UI breathe
                            }
                        }
                        faces.Add(f);
                    }
                SaveCache(faces);
            }
            foreach (var f in faces)
            {
                Core.SetFontGlyphs(f.Px, f.Bold != 0, f.Ascent, f.Descent, f.Records.ToArray(), f.Alpha.ToArray());
                ascents[f.Px * 2 + f.Bold] = f.Ascent;
            }
            LoadExtra();
            Ready = true;
            if (status != null) status("");
            // from now on: render the characters the VM asks for (CJK, Thai...) on the fly
            CompositionTarget.Rendering += (s, e) => Pump();
        }

        // ---- on-demand glyphs (characters outside the prebuilt atlas) -------------

        private const string ExtraFile = "fontextra.bin";
        private static readonly Dictionary<int, int> ascents = new Dictionary<int, int>();   // px*2+bold -> ascent
        private static readonly List<int[]> extraRecs = new List<int[]>();     // px, bold, cp, w, h, left, top, adv
        private static readonly List<byte[]> extraAlpha = new List<byte[]>();
        private static int extraSaved;
        private static DateTime extraSaveAt = DateTime.MaxValue;

        private static void Pump()
        {
            int[] req = Core.TakeFontRequests();   // an empty WinRT array arrives as null
            if (req == null) req = new int[0];
            for (int i = 0; i + 2 < req.Length; i += 3)
            {
                int px = req[i], bold = req[i + 1], cp = req[i + 2];
                int asc;
                if (!ascents.TryGetValue(px * 2 + bold, out asc)) continue;
                var f = new FaceData { Px = px, Bold = bold, Ascent = asc };
                try { RenderGlyph(f, cp); }
                catch (Exception ex) { Core.Log("[font] cannot render U+" + cp.ToString("X4") + ": " + ex.Message); continue; }
                if (f.Records.Count < 6) continue;
                int[] rec = f.Records.GetRange(0, 6).ToArray();
                byte[] alpha = f.Alpha.ToArray();
                Core.AddFontGlyph(px, bold != 0, rec, alpha);
                extraRecs.Add(new[] { px, bold, rec[0], rec[1], rec[2], rec[3], rec[4], rec[5] });
                extraAlpha.Add(alpha);
                if (extraSaveAt == DateTime.MaxValue) extraSaveAt = DateTime.UtcNow.AddSeconds(3);
            }
            if (DateTime.UtcNow >= extraSaveAt) { extraSaveAt = DateTime.MaxValue; SaveExtra(); }
        }

        private static void LoadExtra()
        {
            try
            {
                using (var store = IsolatedStorageFile.GetUserStoreForApplication())
                {
                    if (!store.FileExists(ExtraFile)) return;
                    using (var r = new BinaryReader(store.OpenFile(ExtraFile, FileMode.Open, FileAccess.Read)))
                    {
                        if (r.ReadInt32() != 0x58464A32 || r.ReadInt32() != CacheVersion) return;   // "2JFX"
                        int n = r.ReadInt32();
                        for (int i = 0; i < n; i++)
                        {
                            var rec = new int[8];
                            for (int k = 0; k < 8; k++) rec[k] = r.ReadInt32();
                            byte[] alpha = r.ReadBytes(r.ReadInt32());
                            Core.AddFontGlyph(rec[0], rec[1] != 0, new[] { rec[2], rec[3], rec[4], rec[5], rec[6], rec[7] }, alpha);
                            extraRecs.Add(rec);
                            extraAlpha.Add(alpha);
                        }
                        extraSaved = extraRecs.Count;
                    }
                }
            }
            catch (Exception ex) { Core.Log("[font] extra cache unreadable: " + ex.Message); }
        }

        private static void SaveExtra()
        {
            if (extraRecs.Count == extraSaved) return;
            try
            {
                using (var store = IsolatedStorageFile.GetUserStoreForApplication())
                using (var w = new BinaryWriter(store.OpenFile(ExtraFile, FileMode.Create, FileAccess.Write)))
                {
                    w.Write(0x58464A32); w.Write(CacheVersion); w.Write(extraRecs.Count);
                    for (int i = 0; i < extraRecs.Count; i++)
                    {
                        foreach (int v in extraRecs[i]) w.Write(v);
                        w.Write(extraAlpha[i].Length); w.Write(extraAlpha[i]);
                    }
                }
                extraSaved = extraRecs.Count;
            }
            catch (Exception ex) { Core.Log("[font] cannot save extra cache: " + ex.Message); }
        }

        private static TextBlock MakeText(string text, int px, bool bold)
        {
            var tb = new TextBlock
            {
                Text = text,
                FontFamily = new FontFamily(FontName),
                FontSize = px,
                FontWeight = bold ? FontWeights.Bold : FontWeights.Normal,
                Foreground = new SolidColorBrush(Colors.White),
            };
            tb.Measure(new Size(double.PositiveInfinity, double.PositiveInfinity));
            tb.Arrange(new Rect(0, 0, tb.DesiredSize.Width, tb.DesiredSize.Height));
            return tb;
        }

        private const int Pad = 3;   // room for overhangs on both sides

        // Renders text into an alpha array (w x h); returns the cell size.
        private static byte[] Render(TextBlock tb, out int w, out int h)
        {
            w = (int)Math.Ceiling(tb.ActualWidth) + Pad * 2;
            h = (int)Math.Ceiling(tb.ActualHeight);
            if (w <= 0 || h <= 0) { w = h = 0; return new byte[0]; }
            var bmp = new WriteableBitmap(w, h);
            bmp.Render(tb, new TranslateTransform { X = Pad, Y = 0 });
            bmp.Invalidate();
            var a = new byte[w * h];
            int[] px = bmp.Pixels;
            for (int i = 0; i < a.Length; i++) a[i] = (byte)((px[i] >> 24) & 0xFF);
            return a;
        }

        // baseline = first row below the ink of "H"; ascent = rows above it, descent = rows below
        private static void Baseline(int px, bool bold, out int ascent, out int descent)
        {
            int w, h;
            byte[] a = Render(MakeText("H", px, bold), out w, out h);
            int bottom = -1;
            for (int y = 0; y < h; y++)
                for (int x = 0; x < w; x++)
                    if (a[y * w + x] > 96) { bottom = y; break; }
            ascent = bottom >= 0 ? bottom + 1 : (int)Math.Round(px * 0.8);
            descent = Math.Max(1, h - ascent);
        }

        private static void RenderGlyph(FaceData f, int cp)
        {
            string ch = cp > 0xFFFF ? char.ConvertFromUtf32(cp) : ((char)cp).ToString();
            string s = cp >= 0x300 && cp <= 0x36F ? " " + ch : ch;
            TextBlock tb = MakeText(s, f.Px, f.Bold != 0);
            int advance = cp >= 0x300 && cp <= 0x36F ? 0 : (int)Math.Round(tb.ActualWidth);
            int w, h;
            byte[] a = Render(tb, out w, out h);
            // ink bounding box
            int x0 = w, y0 = h, x1 = -1, y1 = -1;
            for (int y = 0; y < h; y++)
                for (int x = 0; x < w; x++)
                    if (a[y * w + x] != 0)
                    {
                        if (x < x0) x0 = x; if (x > x1) x1 = x;
                        if (y < y0) y0 = y; if (y > y1) y1 = y;
                    }
            if (x1 < 0)
            {   // blank (space)
                f.Records.AddRange(new[] { cp, 0, 0, 0, 0, advance });
                return;
            }
            int gw = x1 - x0 + 1, gh = y1 - y0 + 1;
            int left = x0 - Pad;
            if (cp >= 0x300 && cp <= 0x36F) left -= (int)Math.Round(MakeText(" ", f.Px, f.Bold != 0).ActualWidth);
            f.Records.AddRange(new[] { cp, gw, gh, left, y0 - f.Ascent, advance });
            for (int y = y0; y <= y1; y++)
                for (int x = x0; x <= x1; x++)
                    f.Alpha.Add(a[y * w + x]);
        }

        // ---- cache -----------------------------------------------------------------

        private static List<FaceData> LoadCache()
        {
            try
            {
                using (var store = IsolatedStorageFile.GetUserStoreForApplication())
                {
                    if (store.FileExists(CacheFile))
                        using (var st = store.OpenFile(CacheFile, FileMode.Open, FileAccess.Read))
                        {
                            var list = ReadCache(st);
                            if (list != null) return list;
                        }
                }
            }
            catch (Exception ex)
            {
                Core.Log("[font] cache unreadable: " + ex.Message);
            }
            // prebuilt atlas shipped in the package (Assets\fontcache.bin, pulled from a phone)
            try
            {
                var res = Application.GetResourceStream(new Uri("Assets/" + CacheFile, UriKind.Relative));
                if (res != null)
                    using (var st = res.Stream)
                    {
                        var list = ReadCache(st);
                        if (list != null) { Core.Log("[font] using the prebuilt atlas from the package"); return list; }
                    }
            }
            catch (Exception ex)
            {
                Core.Log("[font] prebuilt atlas unreadable, rebuilding: " + ex.Message);
            }
            return null;
        }

        private static List<FaceData> ReadCache(Stream st)
        {
            var r = new BinaryReader(st);
            if (r.ReadInt32() != 0x41464A32 || r.ReadInt32() != CacheVersion) return null;   // "2JFA"
            int n = r.ReadInt32();
            var list = new List<FaceData>();
            for (int i = 0; i < n; i++)
            {
                var f = new FaceData { Px = r.ReadInt32(), Bold = r.ReadInt32(), Ascent = r.ReadInt32(), Descent = r.ReadInt32() };
                int nr = r.ReadInt32();
                for (int k = 0; k < nr; k++) f.Records.Add(r.ReadInt32());
                int na = r.ReadInt32();
                f.Alpha.AddRange(r.ReadBytes(na));
                list.Add(f);
            }
            return list;
        }

        private static void SaveCache(List<FaceData> faces)
        {
            try
            {
                using (var store = IsolatedStorageFile.GetUserStoreForApplication())
                using (var w = new BinaryWriter(store.OpenFile(CacheFile, FileMode.Create, FileAccess.Write)))
                {
                    w.Write(0x41464A32); w.Write(CacheVersion); w.Write(faces.Count);
                    foreach (var f in faces)
                    {
                        w.Write(f.Px); w.Write(f.Bold); w.Write(f.Ascent); w.Write(f.Descent);
                        w.Write(f.Records.Count); foreach (int v in f.Records) w.Write(v);
                        w.Write(f.Alpha.Count); w.Write(f.Alpha.ToArray());
                    }
                }
            }
            catch (Exception ex) { Core.Log("[font] cannot save cache: " + ex.Message); }
        }
    }
}
