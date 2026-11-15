using System;
using System.IO;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using J2MEWPRuntime;

namespace J2MEWP81
{
    // One row of the game list (wraps the native GameEntry for data binding).
    public class GameItem
    {
        public GameEntry Entry { get; private set; }
        public string Id { get { return Entry.Id; } }
        public string Name { get { return Entry.Name; } }
        public string Details
        {
            get
            {
                string v = Entry.Vendor ?? "";
                if (!string.IsNullOrEmpty(Entry.Version)) v += (v.Length > 0 ? "  ·  " : "") + "v" + Entry.Version;
                return v;
            }
        }

        private ImageSource icon;
        public ImageSource Icon
        {
            get
            {
                if (icon == null && !string.IsNullOrEmpty(Entry.IconPath))
                {
                    try
                    {
                        using (var s = File.OpenRead(Entry.IconPath))
                        {
                            var bmp = new BitmapImage();
                            bmp.SetSource(s);
                            icon = bmp;
                        }
                    }
                    catch (Exception) { }
                }
                return icon;
            }
        }

        public GameItem(GameEntry e) { Entry = e; }
    }
}
