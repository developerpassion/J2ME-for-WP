#pragma once

// Font backend for MIDP text (javacall_winphone font.c): glyphs rendered with
// DirectWrite from the system fonts (Segoe UI: Latin + Vietnamese...),
// anti-aliased and cached. Call once at startup, before the VM runs.
void FontEngine_Init();
