/*
 * ccwrap.c - "compile database" recorder for the phoneME host build.
 * Copied as cl.exe / ml.exe into a directory placed first in PATH. Each call
 * appends one line "<tool>\t<cwd>\t<full command line>" to %CCWRAP_LOG%, then
 * runs the real tool found in %CCWRAP_REAL_DIR% with the same arguments.
 * Build: cl /nologo /O1 ccwrap.c /Fe:ccwrap.exe
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <wchar.h>

int wmain(void) {
    wchar_t self[MAX_PATH], tool[MAX_PATH], real_dir[MAX_PATH], log_path[MAX_PATH], cwd[MAX_PATH];
    GetModuleFileNameW(NULL, self, MAX_PATH);
    const wchar_t* base = wcsrchr(self, L'\\');
    base = base ? base + 1 : self;
    wcsncpy_s(tool, MAX_PATH, base, _TRUNCATE);

    /* Arguments = command line after argv[0]. */
    const wchar_t* cmd = GetCommandLineW();
    const wchar_t* args = cmd;
    if (*args == L'"') { args++; while (*args && *args != L'"') args++; if (*args) args++; }
    else { while (*args && *args != L' ' && *args != L'\t') args++; }

    if (GetEnvironmentVariableW(L"CCWRAP_LOG", log_path, MAX_PATH) > 0) {
        GetCurrentDirectoryW(MAX_PATH, cwd);
        FILE* f = NULL;
        if (_wfopen_s(&f, log_path, L"ab") == 0 && f) {
            fwprintf(f, L"%s\t%s\t%s\n", tool, cwd, args);
            fclose(f);
        }
    }

    if (GetEnvironmentVariableW(L"CCWRAP_REAL_DIR", real_dir, MAX_PATH) == 0) {
        fwprintf(stderr, L"ccwrap: CCWRAP_REAL_DIR not set\n");
        return 1;
    }
    size_t n = wcslen(real_dir) + wcslen(tool) + wcslen(args) + 8;
    wchar_t* line = (wchar_t*)malloc(n * sizeof(wchar_t));
    _snwprintf_s(line, n, _TRUNCATE, L"\"%s\\%s\"%s", real_dir, tool, args);

    STARTUPINFOW si = { sizeof(si) };
    PROCESS_INFORMATION pi;
    wchar_t exe[MAX_PATH];
    _snwprintf_s(exe, MAX_PATH, _TRUNCATE, L"%s\\%s", real_dir, tool);
    if (!CreateProcessW(exe, line, NULL, NULL, TRUE, 0, NULL, NULL, &si, &pi)) {
        fwprintf(stderr, L"ccwrap: cannot start %s (%lu)\n", exe, GetLastError());
        return 1;
    }
    WaitForSingleObject(pi.hProcess, INFINITE);
    DWORD code = 1;
    GetExitCodeProcess(pi.hProcess, &code);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    free(line);
    return (int)code;
}
