/*
 * game_library.cpp - see game_library.h.
 */
#define WIN32_LEAN_AND_MEAN
#define NOMINMAX
#include <windows.h>
#include "wp81_compat.h"
#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>

#include "game_library.h"
#include "jvm_host.h"

namespace j2mewp {

namespace {

std::string Trim(const std::string& s) {
    size_t a = s.find_first_not_of(" \t\r\n"), b = s.find_last_not_of(" \t\r\n");
    return a == std::string::npos ? std::string() : s.substr(a, b - a + 1);
}

std::wstring Widen(const std::string& s) {
    int n = MultiByteToWideChar(CP_UTF8, 0, s.c_str(), (int)s.size(), nullptr, 0);
    std::wstring w(n > 0 ? n : 0, L'\0');
    if (n > 0) MultiByteToWideChar(CP_UTF8, 0, s.c_str(), (int)s.size(), &w[0], n);
    return w;
}

std::string Narrow(const std::wstring& w) {
    int n = WideCharToMultiByte(CP_UTF8, 0, w.c_str(), (int)w.size(), nullptr, 0, nullptr, nullptr);
    std::string s(n > 0 ? n : 0, '\0');
    if (n > 0) WideCharToMultiByte(CP_UTF8, 0, w.c_str(), (int)w.size(), &s[0], n, nullptr, nullptr);
    return s;
}

// Manifests in the wild are often not valid UTF-8 (Windows-1252 / 1251...):
// keep valid UTF-8, map other bytes as Latin-1 so names never break.
std::string FixUtf8(const std::string& s) {
    if (MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, s.c_str(), (int)s.size(), nullptr, 0) > 0 || s.empty())
        return s;
    std::wstring w;
    for (unsigned char c : s) w += (wchar_t)c;
    return Narrow(w);
}

bool Exists(const std::wstring& p) {
    return GetFileAttributesW(p.c_str()) != INVALID_FILE_ATTRIBUTES;
}

typedef std::map<std::string, std::string> KeyValues;

KeyValues ReadKv(const std::wstring& path) {
    KeyValues kv;
    FILE* f = nullptr;
    if (_wfopen_s(&f, path.c_str(), L"rb") != 0 || !f) return kv;
    std::string text;
    char buf[4096];
    size_t n;
    while ((n = fread(buf, 1, sizeof(buf), f)) > 0) text.append(buf, n);
    fclose(f);
    size_t pos = 0;
    while (pos < text.size()) {
        size_t eol = text.find('\n', pos);
        if (eol == std::string::npos) eol = text.size();
        std::string line = text.substr(pos, eol - pos);
        size_t eq = line.find('=');
        if (eq != std::string::npos) kv[Trim(line.substr(0, eq))] = Trim(line.substr(eq + 1));
        pos = eol + 1;
    }
    return kv;
}

void WriteKv(const std::wstring& path, const KeyValues& kv) {
    FILE* f = nullptr;
    if (_wfopen_s(&f, path.c_str(), L"wb") != 0 || !f) return;
    for (const auto& e : kv) fprintf(f, "%s=%s\r\n", e.first.c_str(), e.second.c_str());
    fclose(f);
}

int ToInt(const KeyValues& kv, const char* k, int def) {
    auto it = kv.find(k);
    return it == kv.end() || it->second.empty() ? def : (int)strtol(it->second.c_str(), nullptr, 0);
}

void DeleteTree(const std::wstring& dir) {
    WIN32_FIND_DATAW fd;
    HANDLE h = FindFirstFileExW((dir + L"\\*").c_str(), FindExInfoBasic, &fd, FindExSearchNameMatch, nullptr, 0);
    if (h != INVALID_HANDLE_VALUE) {
        do {
            std::wstring name = fd.cFileName;
            if (name == L"." || name == L"..") continue;
            std::wstring p = dir + L"\\" + name;
            if (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) DeleteTree(p);
            else DeleteFileW(p.c_str());
        } while (FindNextFileW(h, &fd));
        FindClose(h);
    }
    RemoveDirectoryW(dir.c_str());
}

// Folder-safe, ASCII-only id from the suite name. The JAR path goes through
// MIDP/CLDC as a classpath string; on the ARM build a non-ASCII folder
// ("Liên Quân Mobile") ends in ClassNotFoundException, so diacritics are
// folded ("Lien Quan Mobile") and anything else non-ASCII becomes '_'.
#if defined(WINAPI_FAMILY) && (WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP)
// WP8.1 has no NormalizeString: fold the precomposed Latin letters by table
// (Latin-1, the Vietnamese ones in Latin Extended-A/B, U+1EA0..U+1EF9).
wchar_t FoldLatin(wchar_t c) {
    static const char kLatin1[] = "AAAAAAACEEEEIIIIDNOOOOO_OUUUUYTsaaaaaaaceeeeiiiidnooooo_ouuuuyty";
    static const char kViet[] = "AAAAAAAAAAAAEEEEEEEEIIOOOOOOOOOOOOUUUUUUUYYYY";   // pairs U+1EA0..
    if (c >= 0xC0 && c <= 0xFF) return (wchar_t)kLatin1[c - 0xC0];
    if (c >= 0x1EA0 && c <= 0x1EF9) {
        wchar_t b = (wchar_t)kViet[(c - 0x1EA0) / 2];
        return (c & 1) ? (wchar_t)(b + 32) : b;
    }
    switch (c) {
    case 0x102: case 0x100: case 0x104: return L'A';
    case 0x103: case 0x101: case 0x105: return L'a';
    case 0x128: return L'I'; case 0x129: return L'i';
    case 0x168: return L'U'; case 0x169: return L'u';
    case 0x1A0: return L'O'; case 0x1A1: return L'o';
    case 0x1AF: return L'U'; case 0x1B0: return L'u';
    }
    return c;
}
#endif

std::wstring MakeIdW(const std::wstring& w0) {
    std::wstring w = w0;
#if defined(WINAPI_FAMILY) && (WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP)
    for (wchar_t& c : w) c = FoldLatin(c);
#else
    int n = NormalizeString(NormalizationD, w0.c_str(), (int)w0.size(), nullptr, 0);
    if (n > 0) {
        w.resize(n);
        n = NormalizeString(NormalizationD, w0.c_str(), (int)w0.size(), &w[0], n);
        w.resize(n > 0 ? n : 0);
        if (n <= 0) w = w0;
    }
#endif
    std::wstring id;
    for (wchar_t c : w) {
        if (c >= 0x0300 && c <= 0x036F) continue;            // combining accents
        if (c == 0x0111) c = L'd'; else if (c == 0x0110) c = L'D';   // đ Đ
        if (c < 32 || c > 126 || wcschr(L"<>:\"/\\|?*.", c)) c = L'_';
        id += c;
        if (id.size() >= 40) break;
    }
    while (!id.empty() && (id.back() == L' ' || id.back() == L'_')) id.pop_back();
    return id.empty() ? std::wstring(L"game") : id;
}

std::wstring MakeId(const std::string& name) { return MakeIdW(Widen(name)); }

bool IsAscii(const std::wstring& s) {
    for (wchar_t c : s) if (c > 126) return false;
    return true;
}

long long NowKey() {
    FILETIME ft;
    GetSystemTimeAsFileTime(&ft);
    return ((long long)ft.dwHighDateTime << 32) | ft.dwLowDateTime;
}

bool ReadInfo(const std::wstring& dir, const std::wstring& id, GameInfo* g) {
    KeyValues kv = ReadKv(dir + L"\\info.txt");
    if (kv.empty() || !Exists(dir + L"\\game.jar")) return false;
    g->id = id;
    g->dir = dir;
    g->jar = dir + L"\\game.jar";
    g->icon = Exists(dir + L"\\icon.png") ? dir + L"\\icon.png" : std::wstring();
    g->name = kv["name"];
    g->vendor = kv["vendor"];
    g->version = kv["version"];
    g->midletClass = kv["class"];
    g->added = _strtoi64(kv["added"].c_str(), nullptr, 10);
    if (g->name.empty()) g->name = Narrow(id);
    return true;
}

} // namespace

std::string ManifestValue(const std::string& text, const char* key) {
    std::string k = std::string(key) + ":";
    size_t pos = 0;
    while (pos < text.size()) {
        size_t eol = text.find('\n', pos);
        if (eol == std::string::npos) eol = text.size();
        std::string line = text.substr(pos, eol - pos);
        if (_strnicmp(line.c_str(), k.c_str(), k.size()) == 0) {
            std::string v = line.substr(k.size());
            if (!v.empty() && v.back() == '\r') v.pop_back();
            for (size_t p2 = eol + 1; p2 < text.size() && text[p2] == ' ';) {   // continuation lines
                size_t e2 = text.find('\n', p2);
                if (e2 == std::string::npos) e2 = text.size();
                std::string c = text.substr(p2 + 1, e2 - p2 - 1);
                if (!c.empty() && c.back() == '\r') c.pop_back();
                v += c;
                p2 = e2 + 1;
            }
            return Trim(v);
        }
        pos = eol + 1;
    }
    return std::string();
}

// "MIDlet-1: Name, icon, class" -> class
std::string MidletClassOf(const std::string& text) {
    std::string v = ManifestValue(text, "MIDlet-1");
    size_t c = v.rfind(',');
    return c == std::string::npos ? std::string() : Trim(v.substr(c + 1));
}

GameLibrary::GameLibrary(const std::wstring& localFolder)
    : m_games(localFolder + L"\\games") {
    CreateDirectoryW(m_games.c_str(), nullptr);
}

std::vector<GameInfo> GameLibrary::List() const {
    std::vector<GameInfo> out;
    WIN32_FIND_DATAW fd;
    HANDLE h = FindFirstFileExW((m_games + L"\\*").c_str(), FindExInfoBasic, &fd, FindExSearchNameMatch, nullptr, 0);
    if (h == INVALID_HANDLE_VALUE) return out;
    do {
        std::wstring name = fd.cFileName;
        if (name == L"." || name == L".." || !(fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)) continue;
        if (!IsAscii(name)) {
            // Older installs used the raw suite name: move them to an ASCII id.
            std::wstring base = MakeIdW(name), id = base;
            for (int i = 2; Exists(m_games + L"\\" + id); ++i) id = base + L" (" + std::to_wstring(i) + L")";
            if (MoveFileExW((m_games + L"\\" + name).c_str(), (m_games + L"\\" + id).c_str(), 0)) name = id;
        }
        GameInfo g;
        if (ReadInfo(m_games + L"\\" + name, name, &g)) out.push_back(g);
    } while (FindNextFileW(h, &fd));
    FindClose(h);
    std::sort(out.begin(), out.end(), [](const GameInfo& a, const GameInfo& b) {
        return _wcsicmp(Widen(a.name).c_str(), Widen(b.name).c_str()) < 0;
    });
    return out;
}

bool GameLibrary::Get(const std::wstring& id, GameInfo* out) const {
    return ReadInfo(m_games + L"\\" + id, id, out);
}

bool GameLibrary::Install(const std::wstring& jarPath, const std::string& jadText,
                          GameInfo* out, std::string* error) {
    static char manifest[64 * 1024];
    std::string mf;
    if (jvm_host_read_jar_manifest(jarPath.c_str(), manifest, sizeof(manifest)) > 0) mf = manifest;

    // JAD attributes win over the manifest (MIDP rule for most of them).
    auto attr = [&](const char* k) {
        std::string v = ManifestValue(jadText, k);
        return FixUtf8(v.empty() ? ManifestValue(mf, k) : v);
    };
    std::string cls = MidletClassOf(jadText);
    if (cls.empty()) cls = MidletClassOf(mf);
    if (cls.empty()) {
        if (error) *error = mf.empty() ? "not a JAR file (no META-INF/MANIFEST.MF)" : "no MIDlet-1 in manifest/JAD";
        return false;
    }
    std::string midlet1 = attr("MIDlet-1");
    std::string name = attr("MIDlet-Name");
    if (name.empty()) name = Trim(midlet1.substr(0, midlet1.find(',')));
    if (name.empty()) name = cls;
    std::string vendor = attr("MIDlet-Vendor");
    std::string version = attr("MIDlet-Version");

    // Icon: MIDlet-Icon, else the icon field of MIDlet-1.
    std::string iconName = attr("MIDlet-Icon");
    if (iconName.empty()) {
        size_t c1 = midlet1.find(','), c2 = midlet1.rfind(',');
        if (c1 != std::string::npos && c2 > c1) iconName = Trim(midlet1.substr(c1 + 1, c2 - c1 - 1));
    }

    // Same suite again (name + vendor) -> update in place, keep settings.
    std::wstring id;
    for (const GameInfo& g : List())
        if (g.name == name && g.vendor == vendor) { id = g.id; break; }
    if (id.empty()) {
        std::wstring base = MakeId(name);
        id = base;
        for (int i = 2; Exists(m_games + L"\\" + id); ++i) id = base + L" (" + std::to_wstring(i) + L")";
    }
    std::wstring dir = m_games + L"\\" + id;
    CreateDirectoryW(dir.c_str(), nullptr);

    std::wstring dst = dir + L"\\game.jar";
    if (_wcsicmp(jarPath.c_str(), dst.c_str()) != 0 &&
        FAILED(CopyFile2(jarPath.c_str(), dst.c_str(), nullptr))) {
        if (error) *error = "cannot copy the JAR into the library";
        return false;
    }
    if (!jadText.empty()) {
        FILE* f = nullptr;
        if (_wfopen_s(&f, (dir + L"\\game.jad").c_str(), L"wb") == 0 && f) {
            fwrite(jadText.data(), 1, jadText.size(), f);
            fclose(f);
        }
    }

    DeleteFileW((dir + L"\\icon.png").c_str());
    if (!iconName.empty()) {
        static char icon[512 * 1024];
        int n = jvm_host_read_jar_entry(dst.c_str(), iconName.c_str(), icon, sizeof(icon));
        if (n > 0) {
            FILE* f = nullptr;
            if (_wfopen_s(&f, (dir + L"\\icon.png").c_str(), L"wb") == 0 && f) {
                fwrite(icon, 1, (size_t)n, f);
                fclose(f);
            }
        }
    }

    KeyValues kv;
    kv["name"] = name;
    kv["vendor"] = vendor;
    kv["version"] = version;
    kv["class"] = cls;
    kv["added"] = std::to_string(NowKey());
    WriteKv(dir + L"\\info.txt", kv);

    if (!Exists(dir + L"\\settings.txt")) {
        // Nokia-specific hint for the native screen size, if present.
        GameSettings s;
        std::string size = attr("Nokia-MIDlet-Original-Display-Size");
        int w = 0, h = 0;
        if (sscanf_s(size.c_str(), "%d,%d", &w, &h) == 2 && w >= 96 && h >= 64 && w <= 1024 && h <= 1024) {
            s.width = w;
            s.height = h;
        }
        SaveSettings(id, s);
    }
    GameInfo tmp;
    return ReadInfo(dir, id, out ? out : &tmp);
}

bool GameLibrary::Remove(const std::wstring& id) {
    if (id.empty() || id.find(L'\\') != std::wstring::npos || id == L"." || id == L"..") return false;
    std::wstring dir = m_games + L"\\" + id;
    if (!Exists(dir)) return false;
    DeleteTree(dir);
    return !Exists(dir);
}

GameSettings GameLibrary::LoadSettings(const std::wstring& id) const {
    GameSettings s;
    KeyValues kv = ReadKv(m_games + L"\\" + id + L"\\settings.txt");
    s.width = std::max(16, std::min(2048, ToInt(kv, "width", s.width)));
    s.height = std::max(16, std::min(2048, ToInt(kv, "height", s.height)));
    s.keepAspect = ToInt(kv, "keepAspect", s.keepAspect) != 0;
    s.background = (unsigned)ToInt(kv, "background", (int)s.background) & 0xFFFFFF;
    s.scalePercent = std::max(10, std::min(1000, ToInt(kv, "scalePercent", s.scalePercent)));
    s.orientation = std::max(0, std::min(2, ToInt(kv, "orientation", s.orientation)));
    s.gravity = std::max(0, std::min(2, ToInt(kv, "gravity", s.gravity)));
    s.scaleType = std::max(0, std::min(3, ToInt(kv, "scaleType", s.scaleType)));
    s.filter = ToInt(kv, "filter", s.filter) != 0;
    s.showFps = ToInt(kv, "showFps", s.showFps) != 0;
    s.limitFps = std::max(0, std::min(120, ToInt(kv, "limitFps", s.limitFps)));
    s.showKeypad = ToInt(kv, "showKeypad", s.showKeypad) != 0;
    s.padPos = std::max(0, std::min(100, ToInt(kv, "padPos", s.padPos)));
    s.showTitle = ToInt(kv, "showTitle", s.showTitle) != 0;
    s.heapMB = std::max(64, std::min(256, ToInt(kv, "heapMB", s.heapMB)));
    return s;
}

void GameLibrary::SaveSettings(const std::wstring& id, const GameSettings& s) const {
    char bg[16];
    sprintf_s(bg, "0x%06X", s.background & 0xFFFFFF);
    KeyValues kv;
    kv["width"] = std::to_string(s.width);
    kv["height"] = std::to_string(s.height);
    kv["keepAspect"] = s.keepAspect ? "1" : "0";
    kv["background"] = bg;
    kv["scalePercent"] = std::to_string(s.scalePercent);
    kv["orientation"] = std::to_string(s.orientation);
    kv["gravity"] = std::to_string(s.gravity);
    kv["scaleType"] = std::to_string(s.scaleType);
    kv["filter"] = s.filter ? "1" : "0";
    kv["showFps"] = s.showFps ? "1" : "0";
    kv["limitFps"] = std::to_string(s.limitFps);
    kv["showKeypad"] = s.showKeypad ? "1" : "0";
    kv["padPos"] = std::to_string(s.padPos);
    kv["showTitle"] = s.showTitle ? "1" : "0";
    kv["heapMB"] = std::to_string(s.heapMB);
    WriteKv(m_games + L"\\" + id + L"\\settings.txt", kv);
}

int GameLibrary::ImportLooseJars() {
    std::vector<std::wstring> jars;
    WIN32_FIND_DATAW fd;
    HANDLE h = FindFirstFileExW((m_games + L"\\*.jar").c_str(), FindExInfoBasic, &fd, FindExSearchNameMatch, nullptr, 0);
    if (h != INVALID_HANDLE_VALUE) {
        do {
            if (!(fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)) jars.push_back(m_games + L"\\" + fd.cFileName);
        } while (FindNextFileW(h, &fd));
        FindClose(h);
    }
    int n = 0;
    for (const std::wstring& j : jars) {
        GameInfo g;
        if (Install(j, std::string(), &g, nullptr)) {
            DeleteFileW(j.c_str());
            ++n;
        }
    }
    return n;
}

} // namespace j2mewp
