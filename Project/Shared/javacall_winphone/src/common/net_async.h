/*
 * net_async.h - WSAAsyncSelect / WSAAsyncGetHostByName replacement for UWP.
 *
 * The win32 javacall network code (network.c, datagram.c) expects socket
 * readiness to arrive as WM_NETWORK window messages. A UWP app has no Win32
 * window, so every connect/read/write that would block failed. A background
 * thread now waits with select() and calls javanotify_socket_event /
 * javanotify_datagram_event like the win32 window procedure did. DNS runs on
 * a worker thread (getaddrinfo) and fills the same hostent buffer.
 *
 * Include after <winsock2.h>; the macros keep network.c / datagram.c unchanged.
 */
#ifndef J2MEWP_NET_ASYNC_H
#define J2MEWP_NET_ASYNC_H

#include <winsock2.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Like WSAAsyncSelect: one-shot notification for the FD_* events in mask
 * (0 = cancel). Returns 0. */
int j2mewp_async_select(SOCKET s, long mask);

/* Like PostMessage(hwnd, WM_NETWORK, s, WSAMAKESELECTREPLY(event, error)). */
void j2mewp_post_net_event(SOCKET s, long event, int error);

/* Like WSAAsyncGetHostByName: resolves on a worker thread into buf (struct
 * hostent + data), then sends JAVACALL_EVENT_NETWORK_GETHOSTBYNAME_COMPLETED
 * with the returned handle. Returns the handle, 0 on failure. */
HANDLE j2mewp_async_gethostbyname(const char* name, char* buf, int buflen);

#ifdef __cplusplus
}
#endif

#define WSAAsyncSelect(s, hwnd, msg, mask)      j2mewp_async_select((SOCKET)(s), (long)(mask))
#define PostMessage(hwnd, msg, w, l)            j2mewp_post_net_event((SOCKET)(w), (long)WSAGETSELECTEVENT(l), (int)WSAGETSELECTERROR(l))
#define WSAAsyncGetHostByName(hwnd, msg, name, buf, len) j2mewp_async_gethostbyname((name), (buf), (len))

#endif
