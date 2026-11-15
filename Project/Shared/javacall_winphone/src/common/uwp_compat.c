/*
 * uwp_compat.c - stand-ins for desktop-only Win32 calls still referenced by the
 * copied win32 javacall sources (J2MEWP, UWP build only).
 *
 * The win32 network.c uses window-message based async sockets
 * (WSAAsyncSelect / WSAAsyncGetHostByName + PostMessage to the emulator window).
 * None of that exists in UWP, so these stubs make networking fail cleanly
 * (JAVACALL_FAIL / connection errors) instead of breaking the link.
 * TODO(W4.6): real networking with blocking winsock2 on a worker thread.
 *
 * The functions are called without prototypes from C (implicit __cdecl int f()).
 */
#if defined(WINAPI_FAMILY) && (WINAPI_FAMILY == WINAPI_FAMILY_APP || WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP)

void* midpGetWindowHandle(void) { return 0; }
int PostMessage() { return 0; }                  /* FALSE */
int GetEnvironmentVariable() { return 0; }       /* variable not found */
void* WSAAsyncGetHostByName() { return 0; }      /* NULL handle = failure */
int WSAAsyncSelect() { return -1; }              /* SOCKET_ERROR */

#endif
