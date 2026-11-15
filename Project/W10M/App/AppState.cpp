#include "pch.h"
#include "AppState.h"
#include "../../Shared/host/wp81_compat.h"   // WP8.1: GetFileAttributesW
#include "AudioEngine.h"
#include "DeviceEngine.h"
#include "FontEngine.h"
#include "jvm_host.h"

using namespace Platform;

namespace J2MEW10M
{
    static std::wstring g_logPath;
    static std::mutex g_logMutex;
    static std::unique_ptr<j2mewp::GameLibrary> g_library;

    static void OnNativeLog(const char* line, void*)
    {
        // May be called from the VM thread.
        OutputDebugStringA("[J2ME] ");
        OutputDebugStringA(line);
        OutputDebugStringA("\n");
        std::lock_guard<std::mutex> lock(g_logMutex);
        if (g_logPath.empty()) return;
        FILE* f = nullptr;
        if (_wfopen_s(&f, g_logPath.c_str(), L"ab") == 0 && f)
        {
            SYSTEMTIME st;
            GetLocalTime(&st);
            fprintf(f, "%02d:%02d:%02d.%03d %s\r\n", st.wHour, st.wMinute, st.wSecond, st.wMilliseconds, line);
            fclose(f);
        }
    }

    void AppLog(const std::string& line) { OnNativeLog(line.c_str(), nullptr); }

    std::wstring LocalPath()
    {
        return Windows::Storage::ApplicationData::Current->LocalFolder->Path->Data();
    }

    // Copy a folder tree (seeds LocalState\midp from the package's Assets\midp).
    static void CopyTree(const std::wstring& from, const std::wstring& to)
    {
        CreateDirectoryW(to.c_str(), nullptr);
        WIN32_FIND_DATAW fd;
        HANDLE h = FindFirstFileExW((from + L"\\*").c_str(), FindExInfoBasic, &fd, FindExSearchNameMatch, nullptr, 0);
        if (h == INVALID_HANDLE_VALUE) return;
        do
        {
            std::wstring name = fd.cFileName;
            if (name == L"." || name == L"..") continue;
            if (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
                CopyTree(from + L"\\" + name, to + L"\\" + name);
            else
                CopyFile2((from + L"\\" + name).c_str(), (to + L"\\" + name).c_str(), nullptr);
        } while (FindNextFileW(h, &fd));
        FindClose(h);
    }

    // MIDP java home (appdb = installed suites/RMS, lib = properties/policy).
    static void PrepareMidpHome()
    {
        std::wstring home = LocalPath() + L"\\midp";
        std::wstring pkg = std::wstring(Windows::ApplicationModel::Package::Current->InstalledLocation->Path->Data()) + L"\\Assets\\midp";
        if (GetFileAttributesW((home + L"\\lib").c_str()) == INVALID_FILE_ATTRIBUTES &&
            GetFileAttributesW(pkg.c_str()) != INVALID_FILE_ATTRIBUTES)
        {
            CopyTree(pkg, home);
            AppLog("[ui] seeded LocalState\\midp from package");
        }
        // Configuration (heap sizes etc.) is not user data: always take the package copy.
        CopyFile2((pkg + L"\\jwc_properties.ini").c_str(), (home + L"\\jwc_properties.ini").c_str(), nullptr);
        jvm_host_set_storage_root(home.c_str());
    }

    void AppSetJavaHeap(int heapMB)
    {
        std::wstring ini = LocalPath() + L"\\midp\\jwc_properties.ini";
        FILE* f = nullptr;
        if (_wfopen_s(&f, ini.c_str(), L"rb") != 0 || !f) { AppLog("[mem] cannot open jwc_properties.ini"); return; }
        std::string text, line;
        char buf[1024];
        while (fgets(buf, sizeof(buf), f)) text += buf;
        fclose(f);
        long long heap = (long long)heapMB << 20, chunk = heap + (32ll << 20);
        std::string out;
        size_t pos = 0;
        while (pos < text.size())
        {
            size_t nl = text.find('\n', pos);
            size_t end = nl == std::string::npos ? text.size() : nl + 1;
            line = text.substr(pos, end - pos);
            if (line.compare(0, 22, "MAIN_MEMORY_CHUNK_SIZE") == 0) line = "MAIN_MEMORY_CHUNK_SIZE = " + std::to_string(chunk) + "\r\n";
            else if (line.compare(0, 14, "JAVA_HEAP_SIZE") == 0) line = "JAVA_HEAP_SIZE = " + std::to_string(heap) + "\r\n";
            out += line;
            pos = end;
        }
        if (_wfopen_s(&f, ini.c_str(), L"wb") != 0 || !f) { AppLog("[mem] cannot write jwc_properties.ini"); return; }
        fwrite(out.data(), 1, out.size(), f);
        fclose(f);
        AppLog("[mem] Java heap " + std::to_string(heapMB) + " MB, main chunk " + std::to_string(heapMB + 32) + " MB");
    }

    void AppInitCore()
    {
        if (g_library) return;
        g_logPath = LocalPath() + L"\\j2me.log";
        jvm_host_set_logger(&OnNativeLog, nullptr);
        AppLog("==== app start ====");
        AppLog(jvm_host_version());
        PrepareMidpHome();
        AudioEngine_Init();
        DeviceEngine_Init();
        FontEngine_Init();
        g_library.reset(new j2mewp::GameLibrary(LocalPath()));
        int n = g_library->ImportLooseJars();
        if (n > 0) AppLog("[ui] imported " + std::to_string(n) + " JAR(s) into the game library");
    }

    j2mewp::GameLibrary& Library()
    {
        AppInitCore();
        return *g_library;
    }

    String^ ToStr(const std::wstring& w) { return ref new String(w.c_str(), (unsigned)w.size()); }

    String^ ToStr(const std::string& s)
    {
        int n = MultiByteToWideChar(CP_UTF8, 0, s.c_str(), (int)s.size(), nullptr, 0);
        std::wstring w(n > 0 ? n : 0, L'\0');
        if (n > 0) MultiByteToWideChar(CP_UTF8, 0, s.c_str(), (int)s.size(), &w[0], n);
        return ToStr(w);
    }

    std::string ToUtf8(const std::wstring& w)
    {
        int n = WideCharToMultiByte(CP_UTF8, 0, w.c_str(), (int)w.size(), nullptr, 0, nullptr, nullptr);
        std::string s(n > 0 ? n : 0, '\0');
        if (n > 0) WideCharToMultiByte(CP_UTF8, 0, w.c_str(), (int)w.size(), &s[0], n, nullptr, nullptr);
        return s;
    }

    std::string ToUtf8(String^ s) { return s ? ToUtf8(std::wstring(s->Data(), s->Length())) : std::string(); }

    unsigned char* BufferBytes(Windows::Storage::Streams::IBuffer^ buffer)
    {
        Microsoft::WRL::ComPtr<IInspectable> insp(reinterpret_cast<IInspectable*>(buffer));
        Microsoft::WRL::ComPtr<Windows::Storage::Streams::IBufferByteAccess> access;
        if (FAILED(insp.As(&access))) return nullptr;
        unsigned char* p = nullptr;
        access->Buffer(&p);
        return p;
    }
}
