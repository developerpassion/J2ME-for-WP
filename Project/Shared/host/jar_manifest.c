/*
 * jar_manifest.c - read META-INF/MANIFEST.MF from a JAR on the host side
 * (used by the UI to find the MIDlet class before starting the VM).
 * Uses MIDP's jarutil (jar.c: central directory + inflate), which needs no
 * MIDP memory: we pass our own file and heap objects.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "jvm_host.h"

#if defined(J2MEWP_HAS_MIDP)
#include "jar.h"

static long f_size(void* s) {
    FILE* f = (FILE*)s; long cur = ftell(f), n;
    fseek(f, 0, SEEK_END); n = ftell(f); fseek(f, cur, SEEK_SET);
    return n;
}
static long f_read(void* s, unsigned char* buf, long n) { return (long)fread(buf, 1, (size_t)n, (FILE*)s); }
static int f_seek(void* s, long off, int whence) { return fseek((FILE*)s, off, whence); }
static int f_readc(void* s) { return fgetc((FILE*)s); }
static void* h_alloc(void* s, int n) { (void)s; return malloc((size_t)n); }
static void h_free(void* s, void* h) { (void)s; free(h); }
static void* h_addr(void* s, void* h) { (void)s; return h; }

int jvm_host_read_jar_entry(const wchar_t* jar_path, const char* name, char* buf, int cap) {
    FILE* f = NULL;
    FileObj fo;
    HeapManObj hm = { NULL, h_alloc, h_free, h_addr };
    JarInfo ji;
    JarEntryInfo ei;
    unsigned char* cmp;
    unsigned char* data;
    int n = -1;
    size_t len;

    if (!name || !buf || cap <= 0 || _wfopen_s(&f, jar_path, L"rb") != 0 || !f) return -1;
    if (name[0] == '/') name++;              /* "/icon.png" -> "icon.png" */
    len = strlen(name);
    cmp = (unsigned char*)malloc(len + 1);
    fo.state = f; fo.size = f_size; fo.read = f_read; fo.seek = f_seek; fo.readChar = f_readc;
    ji = getJarInfo(&fo);
    if (cmp && ji.status == 0) {
        ei = findJarEntryInfo(&fo, &ji, (const unsigned char*)name, (unsigned int)len, cmp);
        if (ei.status == 0) {
            if ((long)ei.decompLen > (long)cap) {
                n = -2;                      /* buffer too small */
            } else {
                data = (unsigned char*)malloc(ei.decompLen + 1);
                if (data && inflateJarEntry(&fo, &hm, &ei, data, 0) == 0) {
                    n = (int)ei.decompLen;
                    memcpy(buf, data, (size_t)n);
                }
                free(data);
            }
        }
    }
    free(cmp);
    fclose(f);
    return n;
}

int jvm_host_read_jar_manifest(const wchar_t* jar_path, char* buf, int cap) {
    int n;
    if (!buf || cap <= 1) return -1;
    n = jvm_host_read_jar_entry(jar_path, "META-INF/MANIFEST.MF", buf, cap - 1);
    if (n == -2) {                           /* longer than buf: keep the start */
        static char big[1024 * 1024];
        n = jvm_host_read_jar_entry(jar_path, "META-INF/MANIFEST.MF", big, sizeof(big));
        if (n > cap - 1) n = cap - 1;
        if (n > 0) memcpy(buf, big, (size_t)n);
    }
    if (n < 0) return -1;
    buf[n] = '\0';
    return n;
}

#else

int jvm_host_read_jar_entry(const wchar_t* jar_path, const char* name, char* buf, int cap) {
    (void)jar_path; (void)name; (void)buf; (void)cap;
    return -1;   /* CLDC-only stack: no MIDlets */
}

int jvm_host_read_jar_manifest(const wchar_t* jar_path, char* buf, int cap) {
    (void)jar_path; (void)buf; (void)cap;
    return -1;
}

#endif
