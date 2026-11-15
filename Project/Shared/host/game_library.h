/*
 * game_library.h - installed J2ME games + per-game settings (J2MEWP).
 *
 * Plain C++ (Win32 file API only: CreateDirectoryW, CopyFile2, FindFirstFileExW,
 * _wfopen) so the same code serves the W10M UWP app and the WP8 / WP8.1 runtime
 * components. Layout under the app's local folder:
 *
 *   games\<id>\game.jar      the suite (copied from the picked file)
 *   games\<id>\info.txt      key=value (UTF-8): name, vendor, version, class, added
 *   games\<id>\icon.png      MIDlet icon extracted from the JAR (if any)
 *   games\<id>\settings.txt  key=value: GameSettings
 */
#ifndef J2MEWP_GAME_LIBRARY_H
#define J2MEWP_GAME_LIBRARY_H

#include <string>
#include <vector>

namespace j2mewp {

struct GameInfo {
    std::wstring id;          // folder name in the games folder
    std::wstring dir;         // full path of games\<id>
    std::wstring jar;         // full path of game.jar
    std::wstring icon;        // full path of icon.png, empty if none
    std::string name;         // MIDlet-Name (UTF-8)
    std::string vendor;       // MIDlet-Vendor
    std::string version;      // MIDlet-Version
    std::string midletClass;  // class of MIDlet-1
    long long added;          // FILETIME-ish ordering key
    GameInfo() : added(0) {}   // (no member initializers: VS2012 / WP8.0)
};

enum ScaleType { SCALE_FIT = 0, SCALE_STRETCH = 1, SCALE_INTEGER = 2, SCALE_ORIGINAL = 3 };
enum Gravity { GRAVITY_TOP = 0, GRAVITY_CENTER = 1, GRAVITY_BOTTOM = 2 };
enum Orientation { ORIENT_DEFAULT = 0, ORIENT_PORTRAIT = 1, ORIENT_LANDSCAPE = 2 };

struct GameSettings {
    int width;              // MIDlet screen (LCD) size
    int height;
    bool keepAspect;       // used by SCALE_STRETCH: false = fill the area
    unsigned int background;   // RGB around the LCD
    int scalePercent;       // applied after the scale type
    int orientation;
    int gravity; // vertical position of the LCD
    int scaleType;
    bool filter;          // false = sharp pixels (nearest), true = smooth
    bool showFps;
    int limitFps;             // 0 = unlimited (screen refresh)
    bool showKeypad;       // on-screen keypad
    bool showTitle;       // game name at the top of the game screen
    int heapMB;              // Java heap (JAVA_HEAP_SIZE), 64..256 MB; applies on game start
    int padPos;             // keypad vertical position in its area, 0 = top .. 100 = bottom

    GameSettings()   // (no member initializers: VS2012 / WP8.0)
        : width(240),
          height(320),
          keepAspect(true),
          background(0x000000),
          scalePercent(100),
          orientation(ORIENT_DEFAULT),
          gravity(GRAVITY_CENTER),
          scaleType(SCALE_FIT),
          filter(false),
          showFps(false),
          limitFps(0),
          showKeypad(true),
          showTitle(false),
          heapMB(64),
          padPos(50) {}
};

class GameLibrary {
public:
    explicit GameLibrary(const std::wstring& localFolder);

    std::vector<GameInfo> List() const;                 // sorted by name
    bool Get(const std::wstring& id, GameInfo* out) const;

    // Copies jarPath into a new games\<id>\ folder, reads the manifest (and the
    // JAD text if given), extracts the icon. Re-installing the same suite
    // (same name + vendor) replaces it and keeps its settings.
    bool Install(const std::wstring& jarPath, const std::string& jadText,
                 GameInfo* out, std::string* error);
    bool Remove(const std::wstring& id);

    GameSettings LoadSettings(const std::wstring& id) const;
    void SaveSettings(const std::wstring& id, const GameSettings& s) const;

    // Moves JARs left directly in games\ (older app versions) into the library.
    int ImportLooseJars();

    const std::wstring& GamesDir() const { return m_games; }

private:
    std::wstring m_games;
};

// Manifest / JAD helpers (exposed for the UI).
std::string ManifestValue(const std::string& text, const char* key);
std::string MidletClassOf(const std::string& text);

} // namespace j2mewp

#endif
