/*
 * wp81_compat.h - Win32 APIs that WindowsPhoneCore.lib (WP8.1 Silverlight)
 * exports but the Windows 8.1 SDK headers hide behind the DESKTOP partition.
 * Include after <windows.h>. Does nothing outside WINAPI_FAMILY_PHONE_APP.
 */
#ifndef J2MEWP_WP81_COMPAT_H
#define J2MEWP_WP81_COMPAT_H

#if defined(WINAPI_FAMILY) && (WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP) && \
    !WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)

#ifndef PAGE_EXECUTE_READWRITE
#define PAGE_EXECUTE_READWRITE 0x40
#endif
#ifndef FILE_MAP_EXECUTE
#define FILE_MAP_EXECUTE 0x0020
#endif
#ifndef TLS_OUT_OF_INDEXES
#define TLS_OUT_OF_INDEXES ((DWORD)0xFFFFFFFF)   /* WP8.0 headers */
#endif

#ifdef __cplusplus
extern "C" {
#endif

WINBASEAPI LPVOID WINAPI VirtualAlloc(LPVOID lpAddress, SIZE_T dwSize, DWORD flAllocationType, DWORD flProtect);
WINBASEAPI BOOL   WINAPI VirtualFree(LPVOID lpAddress, SIZE_T dwSize, DWORD dwFreeType);
WINBASEAPI BOOL   WINAPI VirtualProtect(LPVOID lpAddress, SIZE_T dwSize, DWORD flNewProtect, PDWORD lpflOldProtect);
WINBASEAPI HANDLE WINAPI CreateFileMappingFromApp(HANDLE hFile, PSECURITY_ATTRIBUTES SecurityAttributes,
                                                  ULONG PageProtection, ULONG64 MaximumSize, PCWSTR Name);
WINBASEAPI PVOID  WINAPI MapViewOfFileFromApp(HANDLE hFileMappingObject, ULONG DesiredAccess,
                                              ULONG64 FileOffset, SIZE_T NumberOfBytesToMap);
WINBASEAPI BOOL   WINAPI UnmapViewOfFile(LPCVOID lpBaseAddress);
WINBASEAPI VOID   WINAPI InitializeCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
WINBASEAPI DWORD  WINAPI GetFileAttributesW(LPCWSTR lpFileName);

#if defined(J2MEWP_WP80)
/* WP8.0 headers hide CreateThread (8.1 shows it); WindowsPhoneCore.lib 8.0 exports it. */
typedef DWORD (WINAPI *J2MEWP_THREAD_START)(LPVOID lpThreadParameter);
WINBASEAPI HANDLE WINAPI CreateThread(LPSECURITY_ATTRIBUTES lpThreadAttributes, SIZE_T dwStackSize,
                                      J2MEWP_THREAD_START lpStartAddress, LPVOID lpParameter,
                                      DWORD dwCreationFlags, LPDWORD lpThreadId);
#endif

#ifdef __cplusplus
}
#endif

/* The A/W-less names are desktop-only macros; map them to the Ex versions.
   Object names are dropped (they only matter across processes). */
#ifndef MUTEX_ALL_ACCESS
#define MUTEX_ALL_ACCESS 0x1F0001
#endif
#ifndef CreateMutex
#define CreateMutex(sa, owned, name) \
    CreateMutexExW((sa), NULL, (owned) ? CREATE_MUTEX_INITIAL_OWNER : 0, MUTEX_ALL_ACCESS)
#endif
#ifndef CreateEvent
#define CreateEvent(sa, manual, initial, name) \
    CreateEventExW((sa), NULL, ((manual) ? CREATE_EVENT_MANUAL_RESET : 0) | \
                   ((initial) ? CREATE_EVENT_INITIAL_SET : 0), EVENT_ALL_ACCESS)
#endif

#endif /* WINAPI_FAMILY_PHONE_APP */
#endif /* J2MEWP_WP81_COMPAT_H */
