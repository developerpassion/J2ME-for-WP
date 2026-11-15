/*
 * jvm_host_vm.cpp - runs the CLDC-HI VM on a background thread and implements
 * the JVMSPI_* callbacks that the stock launcher (Main_win32.cpp) provided.
 * Compiled only where the VM sources are part of JvmCore (see cldc_vm_<arch>.props).
 *
 * No STL here: VM sources are compiled with /U_DEBUG, which would mismatch the
 * app's debug CRT / iterator level for any STL object.
 */
/* LEAN_AND_MEAN: skips oaidl.h, which breaks under /experimental:preprocessor (needed by the VM macros). */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "wp81_compat.h"
#include <stdio.h>
#include <string.h>
#include <wchar.h>

#include "jvm.h"
#include "jvmspi.h"
#include "jvm_host.h"
#if J2MEWP_HAS_MIDP
#include "winphone_port.h"
#endif

extern "C" void jvm_host_log_line(const char* line);   /* jvm_host.cpp */
#if defined(WINAPI_FAMILY) && (WINAPI_FAMILY == WINAPI_FAMILY_APP || WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP)
extern "C" int j2mewp_exec_memory_mode(void);           /* os_uwp_memory.cpp */
#else
static int j2mewp_exec_memory_mode(void) { return 1; }  /* desktop: VirtualAlloc RWX works */
#endif

static CRITICAL_SECTION g_print_lock;
static char g_print_line[1024];
static int g_print_len = 0;
static volatile LONG g_running = 0;
static HANDLE g_vm_thread = NULL;

struct VmArgs {
    wchar_t classpath[1024];
    char main_class[256];
};

/* ---- JVMSPI callbacks --------------------------------------------------- */

static void ensure_print_lock() {
    static volatile LONG inited = 0;
    if (InterlockedCompareExchange(&inited, 1, 0) == 0) InitializeCriticalSection(&g_print_lock);
}

static void emit_line_locked() {
    g_print_line[g_print_len] = 0;
    jvm_host_log_line(g_print_line);
    g_print_len = 0;
}

/* Line-buffered output to the host log (System.out, javacall_print). */
extern "C" void j2mewp_print_raw(const char* s) {
    if (!s) return;
    ensure_print_lock();
    EnterCriticalSection(&g_print_lock);
    for (; *s; ++s) {
        if (*s == '\n') {
            emit_line_locked();
        } else if (*s != '\r') {
            if (g_print_len >= (int)sizeof(g_print_line) - 1) emit_line_locked();
            g_print_line[g_print_len++] = *s;
        }
    }
    LeaveCriticalSection(&g_print_lock);
}

static void flush_print() {
    EnterCriticalSection(&g_print_lock);
    if (g_print_len > 0) emit_line_locked();
    LeaveCriticalSection(&g_print_lock);
}

#if !J2MEWP_HAS_MIDP   /* the MIDP build has its own JVMSPI_* in midp_run.c */
void JVMSPI_PrintRaw(const char* s) {
    j2mewp_print_raw(s);
}

void JVMSPI_Exit(int code) {
    /* Called by the VM for fatal errors / System.exit in standalone mode.
       Never kill the app process: end only the VM thread. */
    char buf[64];
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[vm] JVMSPI_Exit(%d)", code);
    flush_print();
    jvm_host_log_line(buf);
    InterlockedExchange(&g_running, 0);
    ExitThread((DWORD)code);
}
#endif

/* ---- Crash logging ------------------------------------------------------ */
/* The phone gives no dump for these crashes, so log every first-chance exception
   (code, address, registers, exe base) before the process dies. Up to 16 entries. */
extern "C" IMAGE_DOS_HEADER __ImageBase;
#if defined(WINAPI_FAMILY) && (WINAPI_FAMILY == WINAPI_FAMILY_APP || WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP)
/* Hidden from the app partition headers but exported by kernel32 (fine for sideload). */
extern "C" __declspec(dllimport) PVOID WINAPI AddVectoredExceptionHandler(ULONG First, PVECTORED_EXCEPTION_HANDLER Handler);
#endif
static volatile LONG g_exc_logged = 0;

static LONG CALLBACK j2mewp_exc_logger(EXCEPTION_POINTERS* ep) {
    DWORD code = ep->ExceptionRecord->ExceptionCode;
    if (code == 0x406D1388 /* thread name */ || code == DBG_PRINTEXCEPTION_C ||
        code == 0x4001000A /* DBG_PRINTEXCEPTION_WIDE_C */ || code == 0xE06D7363 /* C++ throw */)
        return EXCEPTION_CONTINUE_SEARCH;
    if (InterlockedIncrement(&g_exc_logged) > 16) return EXCEPTION_CONTINUE_SEARCH;
    char buf[512];
    CONTEXT* c = ep->ContextRecord;
    ULONG_PTR info0 = ep->ExceptionRecord->NumberParameters > 0 ? ep->ExceptionRecord->ExceptionInformation[0] : 0;
    ULONG_PTR info1 = ep->ExceptionRecord->NumberParameters > 1 ? ep->ExceptionRecord->ExceptionInformation[1] : 0;
#if defined(_M_ARM)
    _snprintf_s(buf, sizeof(buf), _TRUNCATE,
        "[crash] code=%08lX addr=%p info=%p,%p exe=%p tid=%lu pc=%08lX lr=%08lX sp=%08lX cpsr=%08lX "
        "r0=%08lX r1=%08lX r2=%08lX r3=%08lX r4=%08lX r5=%08lX r6=%08lX r7=%08lX r8=%08lX r9=%08lX r10=%08lX r11=%08lX r12=%08lX",
        code, ep->ExceptionRecord->ExceptionAddress, (void*)info0, (void*)info1, (void*)&__ImageBase,
        GetCurrentThreadId(), c->Pc, c->Lr, c->Sp, c->Cpsr,
        c->R0, c->R1, c->R2, c->R3, c->R4, c->R5, c->R6, c->R7, c->R8, c->R9, c->R10, c->R11, c->R12);
#elif defined(_M_IX86)
    _snprintf_s(buf, sizeof(buf), _TRUNCATE,
        "[crash] code=%08lX addr=%p info=%p,%p exe=%p tid=%lu eip=%08lX esp=%08lX ebp=%08lX eax=%08lX ebx=%08lX ecx=%08lX edx=%08lX esi=%08lX edi=%08lX",
        code, ep->ExceptionRecord->ExceptionAddress, (void*)info0, (void*)info1, (void*)&__ImageBase,
        GetCurrentThreadId(), c->Eip, c->Esp, c->Ebp, c->Eax, c->Ebx, c->Ecx, c->Edx, c->Esi, c->Edi);
#else
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[crash] code=%08lX addr=%p exe=%p",
        code, ep->ExceptionRecord->ExceptionAddress, (void*)&__ImageBase);
#endif
    jvm_host_log_line(buf);
    return EXCEPTION_CONTINUE_SEARCH;
}

static void install_crash_logger() {
    static volatile LONG done = 0;
    if (InterlockedCompareExchange(&done, 1, 0) == 0) AddVectoredExceptionHandler(1, j2mewp_exc_logger);
}

/* ---- VM thread -------------------------------------------------------- */

static DWORD WINAPI vm_thread_main(void* p) {
    VmArgs* a = (VmArgs*)p;
    char buf[320];
    install_crash_logger();
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[vm] start main=%s", a->main_class);
    jvm_host_log_line(buf);

    {
        FILE* f = NULL;
        errno_t e = _wfopen_s(&f, a->classpath, L"rb");
        long len = -1;
        if (f) { fseek(f, 0, SEEK_END); len = ftell(f); fclose(f); }
        _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[vm] classpath %S open=%d size=%ld",
                    a->classpath, (int)e, len);
        jvm_host_log_line(buf);
    }

    ULONGLONG t0 = GetTickCount64();
#if !J2MEWP_HAS_MIDP
    JVM_Initialize();
#endif

    /* No executable heap available -> interpreter only (JIT code lives in the heap). */
    int no_jit = j2mewp_exec_memory_mode() == 0;
    if (no_jit) jvm_host_log_line("[vm] JIT disabled (-int)");

#if J2MEWP_HAS_MIDP
    {
        /* Debug switch: LocalState\midp\force_int.txt -> interpreter only (no JIT). */
        wchar_t flag[MAX_PATH];
        _snwprintf_s(flag, MAX_PATH, _TRUNCATE, L"%s\\force_int.txt", winphone_storage_root());
        if (!no_jit && GetFileAttributesW(flag) != INVALID_FILE_ATTRIBUTES) {
            no_jit = 1;
            jvm_host_log_line("[vm] JIT disabled by force_int.txt (-int)");
        }
    }
    char jar_utf8[1024 * 3];
    WideCharToMultiByte(CP_UTF8, 0, a->classpath, -1, jar_utf8, sizeof(jar_utf8), NULL, NULL);
    int code = winphone_run_midlet(jar_utf8, a->main_class, no_jit);
#else
    if (no_jit) {
        char* argv[] = { (char*)"-int" };
        JVM_ParseOneArg(1, argv);
    }
    int code = JVM_Start((const JvmPathChar*)a->classpath, a->main_class, 0, NULL);
#endif
    flush_print();
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[vm] exit code=%d after %llu ms",
                code, (unsigned long long)(GetTickCount64() - t0));
    jvm_host_log_line(buf);

    delete a;
    InterlockedExchange(&g_running, 0);
    return (DWORD)code;
}

extern "C" int jvm_host_vm_start(const wchar_t* classpath, const char* main_class) {
    ensure_print_lock();

    if (InterlockedCompareExchange(&g_running, 1, 0) != 0) {
        jvm_host_log_line("[vm] already running");
        return -2;
    }
    if (g_vm_thread) { CloseHandle(g_vm_thread); g_vm_thread = NULL; }

    VmArgs* a = new VmArgs();
    wcsncpy_s(a->classpath, classpath ? classpath : L"", _TRUNCATE);
    strncpy_s(a->main_class, main_class ? main_class : "", _TRUNCATE);

    /* CLDC-HI uses green threads: the whole VM runs on this one native thread.
       Reserve a large stack for deep recursion in the interpreter. */
    g_vm_thread = CreateThread(NULL, 4 * 1024 * 1024, vm_thread_main, a,
                               STACK_SIZE_PARAM_IS_A_RESERVATION, NULL);
    if (!g_vm_thread) {
        delete a;
        InterlockedExchange(&g_running, 0);
        jvm_host_log_line("[vm] CreateThread failed");
        return -1;
    }
    return 0;
}

/* Ask the running MIDlet to exit and wait for the VM thread (MIDP build).
   Returns 1 when no VM is running any more. */
#if J2MEWP_HAS_MIDP
extern "C" void javanotify_shutdown(void);
#endif
/* J2MEWP debug: the VM did not stop -> sample where its thread is (PC/LR/regs).
   Map PC to a symbol with the .map file: RVA = pc - anchor + RVA(vm_thread_main). */
#if defined(_M_ARM)
extern "C" __declspec(dllimport) DWORD WINAPI SuspendThread(HANDLE hThread);
extern "C" __declspec(dllimport) DWORD WINAPI ResumeThread(HANDLE hThread);
extern "C" __declspec(dllimport) BOOL WINAPI GetThreadContext(HANDLE hThread, LPCONTEXT lpContext);
static void sample_vm_thread(HANDLE t) {
    char buf[320];
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[hang] anchor vm_thread_main=%p", (void*)&vm_thread_main);
    jvm_host_log_line(buf);
    for (int i = 0; i < 16; ++i) {
        if (SuspendThread(t) == (DWORD)-1) { jvm_host_log_line("[hang] SuspendThread failed"); return; }
        CONTEXT c;
        memset(&c, 0, sizeof(c));
        c.ContextFlags = CONTEXT_FULL;
        BOOL ok = GetThreadContext(t, &c);
        ResumeThread(t);
        if (!ok) { jvm_host_log_line("[hang] GetThreadContext failed"); return; }
        _snprintf_s(buf, sizeof(buf), _TRUNCATE,
            "[hang] pc=%08lx lr=%08lx sp=%08lx r0=%08lx r1=%08lx r2=%08lx r3=%08lx r4=%08lx r5=%08lx r6=%08lx r7=%08lx r8=%08lx r9=%08lx r10=%08lx r11=%08lx r12=%08lx",
            c.Pc, c.Lr, c.Sp, c.R0, c.R1, c.R2, c.R3, c.R4, c.R5, c.R6, c.R7, c.R8, c.R9, c.R10, c.R11, c.R12);
        jvm_host_log_line(buf);
        WaitForSingleObjectEx(t, 7, FALSE);
    }
}
#else
static void sample_vm_thread(HANDLE) {}
#endif

extern "C" int jvm_host_vm_stop(int timeout_ms) {
    if (g_running == 0) return 1;
    HANDLE t = g_vm_thread;
#if J2MEWP_HAS_MIDP
    jvm_host_log_line("[vm] stop requested");
    javanotify_shutdown();
#endif
    if (t && WaitForSingleObjectEx(t, (DWORD)timeout_ms, FALSE) == WAIT_OBJECT_0) {
        jvm_host_log_line("[vm] stopped");
        return 1;
    }
    jvm_host_log_line("[vm] stop timed out");
    if (t) sample_vm_thread(t);
    return g_running == 0;
}

extern "C" int jvm_host_vm_running(void) {
    return g_running != 0;
}

/* Java home for the MIDP build (appdb, lib). */
extern "C" void jvm_host_set_storage_root(const wchar_t* path) {
#if J2MEWP_HAS_MIDP
    winphone_set_storage_root(path);
#else
    (void)path;
#endif
}
