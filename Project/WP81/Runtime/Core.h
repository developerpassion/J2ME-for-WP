#pragma once
// J2MEWPRuntime: Windows Phone Runtime component used by the WP8.1 Silverlight
// (C#) app. Wraps Shared/host (VM, game library) and the W10M engines
// (audio, font, vibration) that compile unchanged for WP8.1.

namespace J2MEWPRuntime
{
    public ref class GameEntry sealed
    {
    public:
        property Platform::String^ Id;
        property Platform::String^ Name;
        property Platform::String^ Vendor;
        property Platform::String^ Version;
        property Platform::String^ IconPath;   // empty if the JAR has no icon
        property Platform::String^ JarPath;
        property int64 Added;
    };

    // Mirrors j2mewp::GameSettings (Shared/host/game_library.h).
    public ref class GameSettings sealed
    {
    public:
        property int Width;
        property int Height;
        property bool KeepAspect;
        property int Background;     // 0xRRGGBB
        property int ScalePercent;
        property int Orientation;    // 0 default, 1 portrait, 2 landscape
        property int Gravity;        // 0 top, 1 center, 2 bottom
        property int ScaleType;      // 0 fit, 1 stretch, 2 integer, 3 original
        property bool Filter;
        property bool ShowFps;
        property int LimitFps;
        property bool ShowKeypad;
        property bool ShowTitle;
        property int HeapMB;
        property int PadPos;
    };

    public ref class Core sealed
    {
    public:
        // Logger, MIDP home, audio/font/vibration backends, game library. Idempotent.
        static void Init();
        static Platform::String^ Version();
        static void Log(Platform::String^ line);
        static Platform::String^ LogPath();

        // ---- game library ----
        static Windows::Foundation::Collections::IVector<GameEntry^>^ ListGames();
        // jarPath: a JAR already copied into the app's local folder; jadText may be empty.
        // Returns the installed game, or null (error text in LastError).
        static GameEntry^ Install(Platform::String^ jarPath, Platform::String^ jadText);
        static bool Remove(Platform::String^ id);
        static GameSettings^ LoadSettings(Platform::String^ id);
        static void SaveSettings(Platform::String^ id, GameSettings^ s);
        static property Platform::String^ LastError { Platform::String^ get(); }

        // ---- VM ----
        // Applies LCD size + heap from the game's settings, then starts the MIDlet.
        static bool Start(Platform::String^ id);
        // Blocks up to timeoutMs; call from a background thread. True when stopped.
        static bool Stop(int timeoutMs);
        static void Pause();
        static void Resume();
        static property bool IsRunning { bool get(); }
        static property int64 FrameCount { int64 get(); }

        // Call every UI frame (drives timers that need the UI loop).
        static void Tick();
        static property int LcdWidth { int get(); }
        static property int LcdHeight { int get(); }
        // Copies the LCD into dst (WriteableBitmap.Pixels, w*h ints, opaque ARGB).
        // Returns true if the picture changed since the last call.
        static bool CopyFrame(Platform::WriteOnlyArray<int>^ dst);

        // MIDP key codes: '0'..'9', '*'=42, '#'=35, UP=-1 DOWN=-2 LEFT=-3 RIGHT=-4
        // FIRE=-5 SOFT1=-6 SOFT2=-7.
        static void Key(int midpKey, bool pressed);
        // type: 0 pressed, 1 released, 2 dragged; LCD coordinates.
        static void Pointer(int x, int y, int type);

        // The MIDlet asked for the backlight (keep the screen on while true).
        static property bool KeepScreenOn { bool get(); }        static void StopAllSounds();

        // WP8.0 only (no DirectWrite): glyphs rendered by the app with the phone font.
        // records = 6 ints per glyph (codepoint, width, height, left, top, advance);
        // alpha = the glyph coverage bitmaps, one after the other. Ignored on WP8.1.
        static void SetFontGlyphs(int px, bool bold, int ascent, int descent,
                                  const Platform::Array<int>^ records, const Platform::Array<uint8>^ alpha);
        // WP8.0: characters the VM is waiting for, as (px, bold 0/1, codepoint) triples;
        // the app renders each and answers with AddFontGlyph. Empty on WP8.1.
        static Platform::Array<int>^ TakeFontRequests();
        // One glyph: rec = codepoint, width, height, left, top, advance; alpha = width*height.
        static void AddFontGlyph(int px, bool bold, const Platform::Array<int>^ rec, const Platform::Array<uint8>^ alpha);
        // true: the native side draws text itself (DirectWrite, WP8.1); false: send glyphs.
        static property bool HasHostFonts { bool get(); }

    private:
        Core() {}
    };
}
