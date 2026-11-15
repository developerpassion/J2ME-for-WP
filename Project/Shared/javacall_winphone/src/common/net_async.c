/*
 * net_async.c - socket readiness + DNS for the UWP javacall port (see net_async.h).
 *
 * One watcher thread keeps a table of sockets with the FD_* events the network
 * code is waiting for and polls them with select(). Notifications are one-shot
 * (like WSAAsyncSelect used here: the caller re-arms on every WOULD_BLOCK).
 */
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
#include "wp81_compat.h"   /* WP8.x: hidden Win32 declarations */
#include <string.h>

#include "javacall_socket.h"
#include "javacall_datagram.h"
#include "net_async.h"

/* network.c / datagram.c use the macros; this file needs the real names. */
#undef WSAAsyncSelect
#undef PostMessage
#undef WSAAsyncGetHostByName

#define MAX_WATCH 64

typedef struct { SOCKET s; long mask; } Watch;

static CRITICAL_SECTION g_lock;
static HANDLE g_wake;                 /* signalled when the table changes */
static Watch g_watch[MAX_WATCH];
static int g_count;
static volatile LONG g_started;

static int is_stream(SOCKET s) {
    int type = 0, len = sizeof(type);
    if (getsockopt(s, SOL_SOCKET, SO_TYPE, (char*)&type, &len) != 0) return 1;
    return type == SOCK_STREAM;
}

/* Same mapping as the win32 window procedure (lcd.c handleNetwork*Events). */
static void notify(SOCKET s, long event, int error) {
    javacall_result st = error == 0 ? JAVACALL_OK : JAVACALL_FAIL;
    if (is_stream(s)) {
        switch (event) {
        case FD_CONNECT: javanotify_socket_event(JAVACALL_EVENT_SOCKET_OPEN_COMPLETED, (javacall_handle)s, st); break;
        case FD_WRITE:   javanotify_socket_event(JAVACALL_EVENT_SOCKET_SEND, (javacall_handle)s, st); break;
        case FD_READ:    javanotify_socket_event(JAVACALL_EVENT_SOCKET_RECEIVE, (javacall_handle)s, st); break;
        case FD_CLOSE:   javanotify_socket_event(JAVACALL_EVENT_SOCKET_CLOSE_COMPLETED, (javacall_handle)s, st); break;
        case FD_ACCEPT:
            javanotify_server_socket_event(JAVACALL_EVENT_SERVER_SOCKET_ACCEPT_COMPLETED,
                                           (javacall_handle)s, (javacall_handle)0, st);
            break;
        }
    } else {
        switch (event) {
        case FD_WRITE: javanotify_datagram_event(JAVACALL_EVENT_DATAGRAM_SENDTO_COMPLETED, (javacall_handle)s, st); break;
        case FD_READ:  javanotify_datagram_event(JAVACALL_EVENT_DATAGRAM_RECVFROM_COMPLETED, (javacall_handle)s, st); break;
        }
    }
}

static DWORD WINAPI watcher(void* unused) {
    (void)unused;
    for (;;) {
        fd_set rd, wr, ex;
        Watch snap[MAX_WATCH];
        int n, i, ready;
        struct timeval tv;

        EnterCriticalSection(&g_lock);
        n = g_count;
        memcpy(snap, g_watch, sizeof(Watch) * n);
        LeaveCriticalSection(&g_lock);

        if (n == 0) { WaitForSingleObjectEx(g_wake, INFINITE, FALSE); continue; }

        FD_ZERO(&rd); FD_ZERO(&wr); FD_ZERO(&ex);
        for (i = 0; i < n; i++) {
            if (snap[i].mask & (FD_READ | FD_ACCEPT | FD_CLOSE)) FD_SET(snap[i].s, &rd);
            if (snap[i].mask & (FD_WRITE | FD_CONNECT)) FD_SET(snap[i].s, &wr);
            if (snap[i].mask & FD_CONNECT) FD_SET(snap[i].s, &ex);
        }
        tv.tv_sec = 0; tv.tv_usec = 20000;   /* re-read the table often */
        ready = select(0, &rd, &wr, &ex, &tv);
        if (ready == SOCKET_ERROR) {
            /* A socket was closed under us: drop the dead ones. */
            EnterCriticalSection(&g_lock);
            for (i = 0; i < g_count; ) {
                int t, l = sizeof(t);
                if (getsockopt(g_watch[i].s, SOL_SOCKET, SO_TYPE, (char*)&t, &l) != 0)
                    g_watch[i] = g_watch[--g_count];
                else i++;
            }
            LeaveCriticalSection(&g_lock);
            Sleep(5);
            continue;
        }
        if (ready == 0) continue;

        for (i = 0; i < n; i++) {
            SOCKET s = snap[i].s;
            long m = snap[i].mask, fired = 0;
            int err = 0;
            if ((m & FD_CONNECT) && (FD_ISSET(s, &wr) || FD_ISSET(s, &ex))) {
                int l = sizeof(err);
                getsockopt(s, SOL_SOCKET, SO_ERROR, (char*)&err, &l);
                fired = FD_CONNECT;
            } else if ((m & FD_ACCEPT) && FD_ISSET(s, &rd)) {
                fired = FD_ACCEPT;
            } else if ((m & (FD_READ | FD_CLOSE)) && FD_ISSET(s, &rd)) {
                fired = (m & FD_READ) ? FD_READ : FD_CLOSE;
            } else if ((m & FD_WRITE) && FD_ISSET(s, &wr)) {
                fired = FD_WRITE;
            }
            if (!fired) continue;

            /* One-shot: clear the fired event before notifying (the VM re-arms). */
            EnterCriticalSection(&g_lock);
            {
                int k;
                for (k = 0; k < g_count; k++)
                    if (g_watch[k].s == s) {
                        g_watch[k].mask &= ~(fired == FD_READ ? (FD_READ | FD_CLOSE) : fired);
                        if (g_watch[k].mask == 0) g_watch[k] = g_watch[--g_count];
                        break;
                    }
            }
            LeaveCriticalSection(&g_lock);
            notify(s, fired, err);
        }
    }
    return 0;
}

static void ensure_started(void) {
    if (InterlockedCompareExchange(&g_started, 1, 0) == 0) {
        HANDLE t;
        InitializeCriticalSectionEx(&g_lock, 0, 0);
        g_wake = CreateEventExW(NULL, NULL, 0, EVENT_ALL_ACCESS);   /* auto-reset */
        t = CreateThread(NULL, 0, watcher, NULL, 0, NULL);
        if (t) CloseHandle(t);
        InterlockedExchange(&g_started, 2);
    }
    while (g_started != 2) SwitchToThread();
}

int j2mewp_async_select(SOCKET s, long mask) {
    int i;
    ensure_started();
    EnterCriticalSection(&g_lock);
    for (i = 0; i < g_count; i++) if (g_watch[i].s == s) break;
    if (mask == 0) {
        if (i < g_count) g_watch[i] = g_watch[--g_count];
    } else if (i < g_count) {
        g_watch[i].mask = mask;
    } else if (g_count < MAX_WATCH) {
        g_watch[g_count].s = s;
        g_watch[g_count].mask = mask;
        g_count++;
    }
    LeaveCriticalSection(&g_lock);
    SetEvent(g_wake);
    return 0;
}

typedef struct { SOCKET s; long event; int error; } PostedEvent;

static DWORD WINAPI posted(void* p) {
    PostedEvent e = *(PostedEvent*)p;
    free(p);
    notify(e.s, e.event, e.error);
    return 0;
}

void j2mewp_post_net_event(SOCKET s, long event, int error) {
    /* PostMessage is asynchronous: deliver after the caller returns. The
       socket is usually closed by then, so the type is decided now. */
    PostedEvent* e = (PostedEvent*)malloc(sizeof(PostedEvent));
    HANDLE t;
    if (!e) return;
    e->s = s; e->event = event; e->error = error;
    if (!is_stream(s)) { free(e); return; }   /* datagram FD_CLOSE: nothing to send */
    t = CreateThread(NULL, 0, posted, e, 0, NULL);
    if (t) CloseHandle(t); else free(e);
}

/* ---- DNS --------------------------------------------------------------- */

typedef struct { char name[256]; char* buf; int buflen; HANDLE handle; } DnsJob;

static DWORD WINAPI resolve(void* p) {
    DnsJob* job = (DnsJob*)p;
    struct addrinfo hints, *res = NULL;
    int ok = 0;
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_INET;          /* MIDP / javacall expect IPv4 */
    hints.ai_socktype = SOCK_STREAM;
    if (getaddrinfo(job->name, NULL, &hints, &res) == 0 && res) {
        /* Same layout WSAAsyncGetHostByName writes: hostent + its data. */
        struct hostent* h = (struct hostent*)job->buf;
        char** list = (char**)(job->buf + sizeof(struct hostent));
        char* addr = (char*)(list + 2);
        char* alias = addr + 4;
        if ((int)(sizeof(struct hostent) + 2 * sizeof(char*) + 4 + sizeof(char*)) <= job->buflen) {
            memcpy(addr, &((struct sockaddr_in*)res->ai_addr)->sin_addr, 4);
            list[0] = addr; list[1] = NULL;
            *(char**)alias = NULL;
            h->h_name = job->name;
            h->h_aliases = (char**)alias;
            h->h_addrtype = AF_INET;
            h->h_length = 4;
            h->h_addr_list = list;
            ok = 1;
        }
        freeaddrinfo(res);
    }
    javanotify_socket_event(JAVACALL_EVENT_NETWORK_GETHOSTBYNAME_COMPLETED, (javacall_handle)job->handle,
                            ok ? JAVACALL_OK : JAVACALL_FAIL);
    /* job->name is referenced by h_name: keep the job (a few bytes per lookup). */
    return 0;
}

HANDLE j2mewp_async_gethostbyname(const char* name, char* buf, int buflen) {
    static volatile LONG next = 0x4000;
    DnsJob* job;
    HANDLE t;
    if (!name || !buf) return 0;
    job = (DnsJob*)malloc(sizeof(DnsJob));
    if (!job) return 0;
    strncpy_s(job->name, sizeof(job->name), name, _TRUNCATE);
    job->buf = buf;
    job->buflen = buflen;
    job->handle = (HANDLE)(INT_PTR)InterlockedIncrement(&next);
    t = CreateThread(NULL, 0, resolve, job, 0, NULL);
    if (!t) { free(job); return 0; }
    CloseHandle(t);
    return job->handle;
}
