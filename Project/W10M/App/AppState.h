#pragma once
// App-wide state shared by the pages: log, MIDP home, game library.
#include <string>
#include "../../Shared/host/game_library.h"

namespace J2MEW10M
{
    // Log to the VS Output window and LocalState\j2me.log (thread-safe).
    void AppLog(const std::string& line);

    // Logger, MIDP java home, audio + font backends, library import. Idempotent.
    void AppInitCore();

    // Writes JAVA_HEAP_SIZE (= heapMB) and MAIN_MEMORY_CHUNK_SIZE (= heapMB + 32) into
    // LocalState\midp\jwc_properties.ini; read by the VM on the next game start.
    void AppSetJavaHeap(int heapMB);

    j2mewp::GameLibrary& Library();
    std::wstring LocalPath();

    Platform::String^ ToStr(const std::string& utf8);
    Platform::String^ ToStr(const std::wstring& w);
    std::string ToUtf8(const std::wstring& w);
    std::string ToUtf8(Platform::String^ s);

    // Pointer to the bytes of an IBuffer.
    unsigned char* BufferBytes(Windows::Storage::Streams::IBuffer^ buffer);
}
