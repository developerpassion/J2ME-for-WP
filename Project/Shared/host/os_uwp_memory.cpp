/*
 * os_uwp_memory.cpp - executable memory for the VM heap in UWP.
 *
 * CLDC-HI puts JIT-compiled code inside the Java object heap, so the heap must
 * be readable, writable AND executable. UWP rejects VirtualAlloc(RWX), so:
 *   1. CreateFileMappingFromApp + MapViewOfFileFromApp(FILE_MAP_EXECUTE)
 *      (codeGeneration capability; Win10 10240+, target for W10M)
 *   2. VirtualAlloc(RW) + VirtualProtectFromApp(PAGE_EXECUTE_READWRITE)
 *   3. VirtualAlloc(RW) only -> no JIT: the VM must run with -int.
 * Blocks are committed whole (heap sizes here are a few MB).
 *
 * Exports:
 *   j2mewp_exec_memory_mode()          which strategy works (probe once)
 *   j2mewp_alloc_exec / j2mewp_free_exec   used by javacall memory.c (MIDP build)
 *   OsMemory_*_chunk                   replaces phoneME OsMemory_win32.cpp (CLDC-only build)
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "wp81_compat.h"
#include <stdio.h>

#if defined(WINAPI_FAMILY) && (WINAPI_FAMILY == WINAPI_FAMILY_APP || WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP)

extern "C" void jvm_host_log_line(const char* line);   /* jvm_host.cpp */

typedef unsigned char* address;

enum ChunkKind { CHUNK_NONE, CHUNK_MAPPING, CHUNK_VIRTUAL };

struct ChunkInfo {
    address base;
    size_t size;
    ChunkKind kind;
    HANDLE mapping;
};

#define MAX_CHUNKS 16
static ChunkInfo g_chunks[MAX_CHUNKS];
static int g_exec_mode = -1;   /* -1 unknown, 0 = no exec, 1 = mapping, 2 = VirtualProtectFromApp */

static void log_fmt(const char* fmt, unsigned long a, unsigned long b) {
    char buf[200];
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, fmt, a, b);
    jvm_host_log_line(buf);
}

static address alloc_mapping(size_t size, HANDLE* out_map) {
    HANDLE m = CreateFileMappingFromApp(INVALID_HANDLE_VALUE, NULL, PAGE_EXECUTE_READWRITE,
                                        (ULONG64)size, NULL);
    if (!m) return NULL;
    void* p = MapViewOfFileFromApp(m, FILE_MAP_READ | FILE_MAP_WRITE | FILE_MAP_EXECUTE, 0, size);
    if (!p) { CloseHandle(m); return NULL; }
    *out_map = m;
    return (address)p;
}

static address alloc_virtual(size_t size, bool want_exec, bool* got_exec) {
    void* p = VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
    *got_exec = false;
    if (!p) return NULL;
    if (want_exec) {
#if WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP
        /* WP8.1 Silverlight: no VirtualProtectFromApp, but VirtualProtect is
           exported (WindowsPhoneCore.lib); the OS decides whether RWX is allowed. */
        DWORD old = 0;
        *got_exec = VirtualProtect(p, size, PAGE_EXECUTE_READWRITE, &old) != FALSE;
#else
        ULONG old = 0;
        *got_exec = VirtualProtectFromApp(p, size, PAGE_EXECUTE_READWRITE, &old) != FALSE;
#endif
    }
    return (address)p;
}

extern "C" int j2mewp_exec_memory_mode(void) {
    if (g_exec_mode >= 0) return g_exec_mode;
    const size_t probe = 64 * 1024;
    HANDLE m = NULL;
    address p = alloc_mapping(probe, &m);
    if (p) {
        UnmapViewOfFile(p); CloseHandle(m);
        g_exec_mode = 1;
    } else {
        DWORD e1 = GetLastError();
        bool ex = false;
        p = alloc_virtual(probe, true, &ex);
        DWORD e2 = GetLastError();
        if (p) VirtualFree(p, 0, MEM_RELEASE);
        g_exec_mode = ex ? 2 : 0;
        log_fmt("[mem] exec mapping failed (err %lu), VirtualProtectFromApp err %lu", e1, ex ? 0 : e2);
    }
#if WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP
    static const char* names[] = { "NONE (interpreter only)", "file mapping RWX", "VirtualProtect RWX (JIT on)" };
#else
    static const char* names[] = { "NONE (interpreter only)", "file mapping RWX", "VirtualProtectFromApp RWX" };
#endif
    char buf[128];
    _snprintf_s(buf, sizeof(buf), _TRUNCATE, "[mem] executable heap: %s", names[g_exec_mode]);
    jvm_host_log_line(buf);
    return g_exec_mode;
}

static address chunk_alloc(size_t size) {
    int mode = j2mewp_exec_memory_mode();
    ChunkInfo c = { NULL, size, CHUNK_NONE, NULL };
    if (mode == 1) {
        c.base = alloc_mapping(size, &c.mapping);
        c.kind = CHUNK_MAPPING;
    }
    if (!c.base) {
        bool ex = false;
        c.base = alloc_virtual(size, mode == 2, &ex);
        c.kind = CHUNK_VIRTUAL;
    }
    if (!c.base) {
        log_fmt("[mem] alloc(%lu) failed, err %lu", (unsigned long)size, GetLastError());
        return NULL;
    }
    for (int i = 0; i < MAX_CHUNKS; ++i) {
        if (g_chunks[i].base == NULL) { g_chunks[i] = c; break; }
    }
    return c.base;
}

static ChunkInfo* chunk_find(address p) {
    for (int i = 0; i < MAX_CHUNKS; ++i)
        if (g_chunks[i].base == p) return &g_chunks[i];
    return NULL;
}

static void chunk_free(address p) {
    ChunkInfo* c = chunk_find(p);
    if (!c) return;
    if (c->kind == CHUNK_MAPPING) {
        UnmapViewOfFile(p);
        CloseHandle(c->mapping);
    } else {
        VirtualFree(p, 0, MEM_RELEASE);
    }
    c->base = NULL;
}

/* ---- javacall heap (MIDP build: pcsl heap -> VM heap + JIT code) ---------- */
extern "C" void* j2mewp_alloc_exec(size_t size) { return chunk_alloc(size); }
extern "C" void j2mewp_free_exec(void* p) { chunk_free((address)p); }

/* ---- CLDC-only build: replaces OsMemory_win32.cpp chunk functions --------- */
#if !J2MEWP_HAS_MIDP   /* with pcsl, OsMemory_* come from cldc/src/vm/os/javacall */
extern "C" address OsMemory_allocate_chunk(size_t initial_size, size_t max_size, size_t alignment) {
    (void)initial_size; (void)alignment;
    return chunk_alloc(max_size);
}

/* Whole chunk is committed: growing within max_size always succeeds. */
extern "C" size_t OsMemory_adjust_chunk(address chunk_ptr, size_t new_committed_size) {
    ChunkInfo* c = chunk_find(chunk_ptr);
    if (!c || new_committed_size > c->size) return 0;
    return c->size;   /* "old committed size": everything is committed */
}

extern "C" void OsMemory_free_chunk(address chunk_ptr) {
    chunk_free(chunk_ptr);
}
#endif

#endif /* WINAPI_FAMILY_APP */
