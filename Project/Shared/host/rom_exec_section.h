/*
 * rom_exec_section.h - force-included into ROMImage.cpp (ARM build only).
 *
 * _rom_text_block* holds AOT-compiled ARM code, but it is declared "const int[]",
 * so MSVC puts it in .rdata, which is not executable: on the phone the
 * interpreter jumped into it and got C0000005 "executing location".
 * Put all ROMImage constants in their own section; the app links it with
 * /SECTION:.romtx,ER (execute + read).
 */
#pragma once
#pragma const_seg(".romtx")
