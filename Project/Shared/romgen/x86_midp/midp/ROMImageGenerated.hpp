/*
 * Copyright  1990-2009 Sun Microsystems, Inc. All Rights Reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License version
 * 2 only, as published by the Free Software Foundation.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License version 2 for more details (a copy is
 * included at /legal/license.txt).
 * 
 * You should have received a copy of the GNU General Public License
 * version 2 along with this work; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
 * 
 * Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa
 * Clara, CA 95054 or visit www.sun.com if you need additional
 * information or have any questions.
 */

/* This file is auto-generated. Do not edit*/


#ifndef ROM_IMAGE_GENERATED_HEADER
#define ROM_IMAGE_GENERATED_HEADER
#include "jvmconfig.h"
#ifdef ROMIZING
#include "ROMImage.hpp"
#include "kni.h"
#undef TEXT0
#undef TEXTb0
#undef TEXT1
#undef TEXTb1
#undef TEXT2
#undef TEXTb2
#undef TEXT3
#undef TEXTb3
#undef TEXT4
#undef TEXTb4
#undef TEXT5
#undef TEXTb5
#undef TEXT6
#undef TEXTb6
#undef TEXT7
#undef TEXTb7
#undef TEXT8
#undef TEXTb8
#undef TEXT9
#undef TEXTb9
#undef DATA
#undef DATAb
#undef HEAP

#define TEXT0(x)  (int)&_rom_text_block0[x]
#define TEXTb0(x) (int)&(((char*)_rom_text_block0)[x])
#define TEXT1(x)  (int)&_rom_text_block1[x]
#define TEXTb1(x) (int)&(((char*)_rom_text_block1)[x])
#define TEXT2(x)  (int)&_rom_text_block2[x]
#define TEXTb2(x) (int)&(((char*)_rom_text_block2)[x])
#define TEXT3(x)  (int)&_rom_text_block3[x]
#define TEXTb3(x) (int)&(((char*)_rom_text_block3)[x])
#define TEXT4(x)  (int)&_rom_text_block4[x]
#define TEXTb4(x) (int)&(((char*)_rom_text_block4)[x])
#define TEXT5(x)  (int)&_rom_text_block5[x]
#define TEXTb5(x) (int)&(((char*)_rom_text_block5)[x])
#define TEXT6(x)  (int)&_rom_text_block6[x]
#define TEXTb6(x) (int)&(((char*)_rom_text_block6)[x])
#define TEXT7(x)  (int)&_rom_text_block7[x]
#define TEXTb7(x) (int)&(((char*)_rom_text_block7)[x])
#define TEXT8(x)  (int)&_rom_text_block8[x]
#define TEXTb8(x) (int)&(((char*)_rom_text_block8)[x])
#define TEXT9(x)  (int)&_rom_text_block9[x]
#define TEXTb9(x) (int)&(((char*)_rom_text_block9)[x])
#define DATA(x)  (int)&_rom_data_block[x]
#define DATAb(x) (int)&(((char*)_rom_data_block)[x])
#define HEAP(x)  (int)&_rom_heap_block[x]


extern const int _rom_text_block0[];
extern const int _rom_text_block1[];
extern const int _rom_text_block2[];
extern const int _rom_text_block3[];
extern const int _rom_text_block4[];
extern const int _rom_text_block5[];
extern const int _rom_text_block6[];
extern const int _rom_text_block7[];
extern const int _rom_text_block8[];
extern const int _rom_text_block9[];

extern "C" void interpreter_method_entry();
extern "C" void interpreter_fast_method_entry_0();
extern "C" void interpreter_fast_method_entry_1();
extern "C" void interpreter_fast_method_entry_2();
extern "C" void interpreter_fast_method_entry_3();
extern "C" void interpreter_fast_method_entry_4();
extern "C" void fixed_interpreter_fast_method_entry_0();
extern "C" void fixed_interpreter_fast_method_entry_1();
extern "C" void fixed_interpreter_fast_method_entry_2();
extern "C" void fixed_interpreter_fast_method_entry_3();
extern "C" void fixed_interpreter_fast_method_entry_4();
extern "C" void quick_void_native_method_entry();
extern "C" void quick_int_native_method_entry();
extern "C" void quick_obj_native_method_entry();
extern "C" void shared_fast_getbyte_accessor();
extern "C" void shared_fast_getshort_accessor();
extern "C" void shared_fast_getchar_accessor();
extern "C" void shared_fast_getint_accessor();
extern "C" void shared_fast_getlong_accessor();
extern "C" void shared_fast_getbyte_static_accessor();
extern "C" void shared_fast_getshort_static_accessor();
extern "C" void shared_fast_getchar_static_accessor();
extern "C" void shared_fast_getint_static_accessor();
extern "C" void shared_fast_getlong_static_accessor();
extern "C" void shared_fast_getfloat_accessor();
extern "C" void shared_fast_getdouble_accessor();
extern "C" void shared_fast_getfloat_static_accessor();
extern "C" void shared_fast_getdouble_static_accessor();
extern "C" void fixed_interpreter_method_entry();
extern "C" void native_jvm_unchecked_byte_arraycopy_entry();
extern "C" void native_jvm_unchecked_char_arraycopy_entry();
extern "C" void native_jvm_unchecked_int_arraycopy_entry();
extern "C" void native_jvm_unchecked_long_arraycopy_entry();
extern "C" void native_jvm_unchecked_obj_arraycopy_entry();
extern "C" void native_integer_toString_entry();
extern "C" void native_math_ceil_entry();
extern "C" void native_math_cos_entry();
extern "C" void native_math_floor_entry();
extern "C" void native_math_sin_entry();
extern "C" void native_math_sqrt_entry();
extern "C" void native_math_tan_entry();
extern "C" void native_string_init_entry();
extern "C" void native_string_charAt_entry();
extern "C" void native_string_endsWith_entry();
extern "C" void native_string_equals_entry();
extern "C" void native_string_indexof0_entry();
extern "C" void native_string_indexof_entry();
extern "C" void native_string_indexof0_string_entry();
extern "C" void native_string_indexof_string_entry();
extern "C" void native_string_startsWith0_entry();
extern "C" void native_string_startsWith_entry();
extern "C" void native_string_substringI_entry();
extern "C" void native_string_substringII_entry();
extern "C" void native_integer_toString_entry();
extern "C" void native_stringbuffer_append_entry();
extern "C" void native_system_arraycopy_entry();
extern "C" void native_vector_addElement_entry();
extern "C" void native_vector_elementAt_entry();
extern "C" void Java_void_unimplemented();
extern "C" void Java_abstract_method_execution();
extern "C" void Java_illegal_method_execution();
extern "C" void Java_incompatible_method_execution();
extern "C" {extern unsigned char oopmap_Empty[];}
extern "C" {extern unsigned char oopmap_ConstantPool[];}
extern "C" {extern unsigned char oopmap_Method[];}
extern "C" {extern unsigned char oopmap_InstanceClass[];}
extern "C" {extern unsigned char oopmap_ArrayClass[];}
extern "C" {extern unsigned char oopmap_ObjNear[];}
extern "C" {extern unsigned char oopmap_FarClass[];}
extern "C" {extern unsigned char oopmap_EntryActivation[];}
extern "C" {extern unsigned char oopmap_ClassInfo[];}
extern "C" {extern unsigned char oopmap_StackmapList[];}
extern "C" {extern unsigned char oopmap_CompiledMethod[];}
extern "C" {extern unsigned char oopmap_Boundary[];}
extern "C" {extern unsigned char oopmap_TaskMirror[];}
extern "C" void Java_java_lang_System_quickNativeThrow();
extern "C" jint Java_java_lang_Object_hashCode();
extern "C" void Java_com_sun_cldchi_jvm_FileDescriptor_finalize();
extern "C" void Java_java_lang_Thread_start0();
extern "C" void Java_java_lang_Thread_setPriority0();
extern "C" void Java_java_lang_Thread_interrupt0();
extern "C" void Java_java_lang_Thread_internalExit();
extern "C" void Java_java_lang_Throwable_printStackTrace();
extern "C" void Java_java_lang_Throwable_fillInStackTrace();
extern "C" jint Java_java_lang_String_hashCode();
extern "C" jobject Java_com_sun_cldc_isolate_Isolate_currentIsolate0();
extern "C" jobject Java_com_sun_cldc_isolate_Isolate_getIsolates0();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_id0();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_usedMemory0();
extern "C" void Java_com_sun_cldc_isolate_Isolate_registerNewIsolate();
extern "C" void Java_com_sun_cldc_isolate_Isolate_stop();
extern "C" void Java_com_sun_cldc_isolate_Isolate_setPriority0();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_isSuspended0();
extern "C" void Java_com_sun_cldc_isolate_Isolate_suspend0();
extern "C" void Java_com_sun_cldc_isolate_Isolate_resume0();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_exitCode0();
extern "C" jboolean Java_com_sun_cldc_isolate_Isolate_isDebuggerConnected();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_getStatus();
extern "C" void Java_com_sun_cldc_isolate_Isolate_notifyStatus();
extern "C" void Java_com_sun_cldc_isolate_Isolate_waitStatus();
extern "C" void Java_com_sun_cldc_isolate_Isolate_nativeStart();
extern "C" void Java_com_sun_cldc_isolate_Isolate_setProfile();
extern "C" void Java_com_sun_cldc_isolate_Isolate_attachDebugger0();
extern "C" jobject Java_java_lang_Object_getClass();
extern "C" jobject Java_java_lang_Class_getName();
extern "C" void Java_java_lang_Object_wait();
extern "C" void Java_java_lang_System_arraycopy();
extern "C" jboolean Java_java_lang_Class_isInterface();
extern "C" jint Java_java_lang_String_lastIndexOf__I();
extern "C" jobject Java_java_lang_Thread_currentThread();
extern "C" void Java_java_lang_Class_invoke_1verify();
extern "C" jobject Java_java_lang_Class_getSuperclass();
extern "C" void Java_java_lang_Class_invoke_1clinit();
extern "C" void Java_java_lang_Class_init9();
extern "C" void Java_java_lang_Object_notifyAll();
extern "C" jboolean Java_java_lang_Thread_isAlive();
extern "C" void Java_java_lang_Runtime_exitInternal();
extern "C" jobject Java_java_lang_System_getProperty0();
extern "C" jint Java_java_lang_Float_floatToIntBits();
extern "C" jlong Java_java_lang_Double_doubleToLongBits();
extern "C" void Java_com_sun_cldchi_jvm_JVM_startAppImage();
extern "C" jboolean Java_com_sun_cldchi_jvm_JVM_createAppImage0();
extern "C" jint Java_com_sun_cldchi_jvm_JVM_verifyNextChunk();
extern "C" void Java_java_lang_Thread_yield();
extern "C" void Java_java_lang_ref_WeakReference_initializeWeakReference();
extern "C" jobject Java_com_sun_cldc_io_ResourceInputStream_open();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_readByte();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_bytesRemain();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_readBytes();
extern "C" jobject Java_com_sun_cldc_io_ResourceInputStream_clone();
extern "C" void Java_javax_microedition_lcdui_ImageData_getRGB();
extern "C" jboolean Java_javax_microedition_lcdui_Graphics_render();
extern "C" jint Java_javax_microedition_lcdui_Graphics_getPixel();
extern "C" jboolean Java_javax_microedition_lcdui_Graphics_renderRegion();
extern "C" void Java_javax_microedition_lcdui_Graphics_doCopyArea();
extern "C" jint Java_javax_microedition_lcdui_KeyConverter_getKeyCode();
extern "C" jobject Java_javax_microedition_lcdui_KeyConverter_getKeyName();
extern "C" jint Java_javax_microedition_lcdui_KeyConverter_getGameAction();
extern "C" jobject Java_java_lang_Class_forName();
extern "C" jobject Java_java_lang_Class_newInstance();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_getByteLength();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_byteToChar();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_sizeOfByteInUnicode();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_charToByte();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_sizeOfUnicodeInByte();
extern "C" jlong Java_java_lang_System_currentTimeMillis();
extern "C" jint Java_com_sun_j2mewp_media_AudioPlayer_nCreate();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nSetTime();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nStart();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nStop();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nClose();
extern "C" void Java_java_lang_Thread_sleep();
extern "C" jboolean Java_com_sun_j2mewp_media_AudioPlayer_nIsPlaying();
extern "C" jint Java_com_sun_j2mewp_media_AudioPlayer_nGetTime();
extern "C" jint Java_com_sun_j2mewp_media_AudioPlayer_nGetDuration();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nSetVolume();
extern "C" void Java_com_sun_j2mewp_media_DeviceHw_nVibrate();
extern "C" void Java_com_sun_j2mewp_media_DeviceHw_nBacklight();
extern "C" jint Java_com_sun_j2mewp_media_DeviceHw_nHasVibrator();
extern "C" jint Java_com_sun_midp_main_MIDletSuiteUtils_getAmsIsolateId();
extern "C" jint Java_com_sun_midp_main_MIDletSuiteUtils_getIsolateId();
extern "C" jint Java_com_sun_midp_main_MIDletSuiteUtils_getMaxIsolates();
extern "C" void Java_com_sun_midp_events_EventQueue_resetNativeEventQueue();
extern "C" void Java_com_sun_midp_events_EventQueue_sendShutdownEvent();
extern "C" void Java_com_sun_midp_events_EventQueue_handleFatalError();
extern "C" jint Java_com_sun_midp_events_EventQueue_getNativeEventQueueHandle();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_loadSuitesIcons0();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteImpl_lockMIDletSuite();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMIDletSuiteIcon0();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_loadCachedIcon0();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_nativeStoreSuite();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_remove0();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getNumberOfSuites();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSuiteList();
extern "C" void Java_com_sun_midp_midletsuite_SuiteSettings_load();
extern "C" void Java_com_sun_midp_midletsuite_InstallInfo_load();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteImpl_unlockMIDletSuite();
extern "C" void Java_javax_microedition_lcdui_Font_init();
extern "C" void Java_javax_microedition_lcdui_Display_drawTrustedIcon0();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSuiteID();
extern "C" void Java_java_lang_Object_notify();
extern "C" jint Java_javax_microedition_lcdui_Font_charWidth();
extern "C" jint Java_javax_microedition_lcdui_Font_charsWidth();
extern "C" jobject Java_com_sun_midp_midletsuite_SuiteProperties_load();
extern "C" void Java_com_sun_midp_midletsuite_SuiteSettings_save0();
extern "C" void Java_com_sun_midp_main_MIDletProxyList_notifyResumeAll0();
extern "C" void Java_com_sun_midp_main_MIDletProxyList_notifySuspendAll0();
extern "C" void Java_com_sun_midp_main_MIDletProxyList_resetForegroundInNativeState();
extern "C" void Java_com_sun_midp_main_MIDletProxyList_setForegroundInNativeState();
extern "C" jint Java_javax_microedition_lcdui_Font_stringWidth();
extern "C" jboolean Java_com_sun_midp_chameleon_layers_SoftButtonLayer_isNativeSoftButtonLayerSupported0();
extern "C" jobject Java_com_sun_midp_chameleon_input_InputModeFactory_getInputModeIds();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_beginReadingSkinFile();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readIntArray();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readStringArray();
extern "C" jint Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_finishReadingSkinFile();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readByteArray();
extern "C" jboolean Java_com_sun_midp_main_MIDletSuiteUtils_isAmsIsolate();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getSharedResourcePool();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getSharedSkinData();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_shareResourcePool();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_shareSkinData();
extern "C" jint Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getRomizedImageDataArrayPtr();
extern "C" jint Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getRomizedImageDataArrayLength();
extern "C" jboolean Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_ifLoadAllResources0();
extern "C" void Java_com_sun_midp_crypto_MD2_nativeUpdate();
extern "C" void Java_com_sun_midp_crypto_MD2_nativeFinal();
extern "C" void Java_com_sun_midp_crypto_MD5_nativeUpdate();
extern "C" void Java_com_sun_midp_crypto_MD5_nativeFinal();
extern "C" void Java_com_sun_midp_crypto_SHA_nativeUpdate();
extern "C" void Java_com_sun_midp_crypto_SHA_nativeFinal();
extern "C" jboolean Java_com_sun_midp_crypto_PRand_getRandomBytes();
extern "C" jint Java_com_sun_midp_events_NativeEventMonitor_waitForNativeEvent();
extern "C" jboolean Java_com_sun_midp_events_NativeEventMonitor_readNativeEvent();
extern "C" jobject Java_com_sun_midp_l10n_LocalizedStringsBase_getContent();
extern "C" jobject Java_com_sun_midp_io_j2me_storage_File_initStorageRoot();
extern "C" jobject Java_com_sun_midp_io_j2me_storage_File_initConfigRoot();
extern "C" jboolean Java_com_sun_midp_io_j2me_storage_File_storageExists();
extern "C" void Java_com_sun_midp_io_j2me_storage_File_deleteStorage();
extern "C" jlong Java_com_sun_midp_io_j2me_storage_File_availableStorage();
extern "C" jint Java_com_sun_midp_io_j2me_storage_RandomAccessStream_open();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_close();
extern "C" jint Java_com_sun_midp_io_j2me_storage_RandomAccessStream_read();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_write();
extern "C" jint Java_com_sun_midp_io_j2me_storage_RandomAccessStream_sizeOf();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteStorageId();
extern "C" void Java_com_sun_midp_installer_OtaNotifier_addInstallNotification();
extern "C" jboolean Java_com_sun_midp_installer_OtaNotifier_getInstallNotificationForRetry();
extern "C" void Java_com_sun_midp_installer_OtaNotifier_removeInstallNotification();
extern "C" void Java_com_sun_midp_installer_OtaNotifier_removeDeleteNotification();
extern "C" jint Java_com_sun_midp_installer_OtaNotifier_getNumberOfDeleteNotifications();
extern "C" void Java_com_sun_midp_installer_OtaNotifier_fillDeleteNotificationListForRetry();
extern "C" jfloat Java_java_lang_Float_intBitsToFloat();
extern "C" jdouble Java_java_lang_Double_longBitsToDouble();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_getIpNumber0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_open0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_close0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_notifyClosedInput0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_notifyClosedOutput0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_shutdownOutput0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_read0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_available0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_write0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_setSockOpt0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_getSockOpt0();
extern "C" jobject Java_com_sun_midp_io_j2me_socket_Protocol_getHost0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_getPort0();
extern "C" jobject Java_com_sun_midp_main_MIDletSuiteVerifier_getJarHash();
extern "C" void Java_com_sun_midp_io_NetworkConnectionBase_initializeInternal();
extern "C" jint Java_com_sun_midp_io_j2me_comm_Protocol_native_1openByName();
extern "C" void Java_com_sun_midp_io_j2me_comm_Protocol_native_1configurePort();
extern "C" void Java_com_sun_midp_io_j2me_comm_Protocol_native_1close();
extern "C" jint Java_com_sun_midp_io_j2me_comm_Protocol_native_1readBytes();
extern "C" jint Java_com_sun_midp_io_j2me_comm_Protocol_native_1writeBytes();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_getIpNumber();
extern "C" void Java_com_sun_midp_io_j2me_datagram_Protocol_open0();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_getMaximumLength0();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_getNominalLength0();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_send0();
extern "C" jlong Java_com_sun_midp_io_j2me_datagram_Protocol_receive0();
extern "C" jobject Java_com_sun_midp_io_j2me_datagram_Protocol_addrToString();
extern "C" void Java_com_sun_midp_io_j2me_datagram_Protocol_close0();
extern "C" jobject Java_com_sun_midp_io_j2me_datagram_Protocol_getHost0();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_getPort0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_poll0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_getMIDlet0();
extern "C" void Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByHandle0();
extern "C" void Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByMidlet0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_add0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_del0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByName0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_list0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_getEntry0();
extern "C" jlong Java_com_sun_midp_io_j2me_push_ConnectionRegistry_addAlarm0();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_suiteIdToString();
extern "C" jboolean Java_java_lang_Class_isAssignableFrom();
extern "C" void Java_com_sun_midp_io_j2me_push_ConnectionRegistry_delAllForSuite0();
extern "C" void Java_com_sun_midp_io_j2me_serversocket_Socket_open0();
extern "C" void Java_com_sun_midp_io_j2me_serversocket_Socket_accept0();
extern "C" jobject Java_com_sun_midp_io_j2me_serversocket_Socket_getLocalAddress0();
extern "C" jint Java_com_sun_midp_io_j2me_serversocket_Socket_getLocalPort0();
extern "C" void Java_com_sun_midp_io_j2me_serversocket_Socket_close0();
extern "C" jobject Java_com_sun_midp_jarutil_JarReader_readJarEntry0();
extern "C" jobject Java_com_sun_midp_lcdui_DisplayDevice_getDisplayName0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPrimary0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_isbuildInDisplay0();
extern "C" jint Java_com_sun_midp_lcdui_DisplayDevice_getDisplayCapabilities0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPenSupported0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPenMotionSupported0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_displayStateChanged0();
extern "C" jint Java_com_sun_midp_lcdui_DisplayDevice_getScreenWidth0();
extern "C" jint Java_com_sun_midp_lcdui_DisplayDevice_getScreenHeight0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_getReverseOrientation0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_reverseOrientation0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_clamshellHandling0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_refresh0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_setFullScreen0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_gainedForeground0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDeviceAccess_toggleBacklight0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDeviceAccess_isBacklightSupported0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDeviceAccess_vibrate0();
extern "C" jobject Java_com_sun_midp_lcdui_DisplayDeviceContainer_getDisplayDevicesIds0();
extern "C" void Java_javax_microedition_lcdui_game_GameCanvas_setSuppressKeyEvents();
extern "C" jint Java_javax_microedition_lcdui_Font_substringWidth();
extern "C" jint Java_com_sun_midp_log_Logging_getAllowedSeverity();
extern "C" void Java_com_sun_midp_log_Logging_report0();
extern "C" void Java_com_sun_midp_main_MIDletSuiteUtils_vmBeginStartUp();
extern "C" void Java_com_sun_midp_main_MIDletSuiteUtils_vmEndStartUp();
extern "C" jboolean Java_com_sun_midp_main_CldcPlatformRequest_dispatchPlatformRequest();
extern "C" void Java_com_sun_midp_main_CommandState_restoreCommandState();
extern "C" void Java_com_sun_midp_main_CommandState_saveCommandState();
extern "C" jobject Java_com_sun_midp_main_Configuration_getProperty0();
extern "C" void Java_com_sun_midp_main_MIDletProxyUtils_requestVMStop();
extern "C" void Java_com_sun_midp_main_MIDletSuiteUtils_registerAmsIsolateId();
extern "C" void Java_com_sun_midp_main_CommandState_exitInternal();
extern "C" jboolean Java_com_sun_midp_rms_RecordStoreFactory_suiteHasRmsData0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_getNumberOfStores();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_getRecordStoreList();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_removeRecordStores0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_spaceAvailableNewRecordStore0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_openRecordStoreFile();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_spaceAvailableRecordStore();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_setPosition();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_writeBytes();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_commitWrite();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_readBytes();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_closeFile();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_truncateFile();
extern "C" jint Java_com_sun_midp_rms_RecordStoreSharedDBHeader_getLookupId0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreSharedDBHeader_getHeaderRefCount0();
extern "C" void Java_com_sun_midp_rms_RecordStoreSharedDBHeader_cleanup0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreSharedDBHeader_updateCachedData0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreSharedDBHeader_shareCachedData0();
extern "C" jboolean Java_com_sun_midp_rms_RecordStoreUtil_exists();
extern "C" void Java_com_sun_midp_rms_RecordStoreUtil_deleteFile();
extern "C" jint Java_com_sun_midp_util_isolate_InterIsolateMutex_getID0();
extern "C" void Java_com_sun_midp_util_isolate_InterIsolateMutex_lock0();
extern "C" void Java_com_sun_midp_util_isolate_InterIsolateMutex_unlock0();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_startRecordStoreListening();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_stopRecordStoreListening();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_acknowledgeNotificationsDelivery();
extern "C" jobject Java_com_sun_midp_rms_RecordStoreRegistry_getRecordStoreListeners();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_resetNotificationCounter();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_sendRecordStoreChangeEvent();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_stopAllRecordStoreListeners();
extern "C" jbyte Java_com_sun_midp_security_Permissions_getDefaultValue();
extern "C" jbyte Java_com_sun_midp_security_Permissions_getMaxValue();
extern "C" jobject Java_com_sun_midp_security_Permissions_loadGroupList();
extern "C" jobject Java_com_sun_midp_security_Permissions_getGroupMessages();
extern "C" jobject Java_com_sun_midp_security_Permissions_loadGroupPermissions();
extern "C" jobject Java_com_sun_midp_security_Permissions_loadDomainList();
extern "C" void Java_com_sun_midp_security_Permissions_loadingFinished();
extern "C" jboolean Java_com_sun_midp_suspend_SuspendSystem_00024MIDPSystem_allMidletsKilled();
extern "C" void Java_com_sun_midp_suspend_SuspendSystem_00024MIDPSystem_suspended0();
extern "C" jboolean Java_com_sun_midp_suspend_SuspendSystem_isResumePending();
extern "C" jobject Java_com_sun_midp_util_ResourceHandler_loadRomizedResource0();
extern "C" void Java_javax_microedition_lcdui_ImageDataFactory_loadRegion();
extern "C" void Java_javax_microedition_lcdui_ImageDataFactory_loadRGB();
extern "C" jboolean Java_javax_microedition_lcdui_ImageDataFactory_loadRomizedImage();
extern "C" jboolean Java_javax_microedition_lcdui_ImageDataFactory_loadPNG();
extern "C" void Java_javax_microedition_lcdui_ImageDataFactory_loadJPEG();
extern "C" void Java_javax_microedition_lcdui_ImageDataFactory_loadRAW();
extern "C" jint Java_javax_microedition_lcdui_KeyConverter_getSystemKey();
extern "C" jboolean Java_javax_microedition_lcdui_SuiteImageCacheImpl_loadAndCreateImmutableImageDataFromCache0();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nTone();
extern "C" jlong Java_java_lang_Runtime_freeMemory();
extern "C" jlong Java_java_lang_Runtime_totalMemory();
extern "C" void Java_java_lang_Runtime_gc();
extern "C" jint Java_java_lang_System_identityHashCode();
extern "C" jint Java_com_sun_cldchi_jvm_JVM_getAppImageProgress();
extern "C" void Java_com_sun_cldchi_jvm_JVM_cancelImageCreation();
extern "C" void Java_com_sun_cldchi_jvm_JVM_createSysImage();
extern "C" void Java_com_sun_cldchi_jvm_JVM_loadLibrary();
extern "C" void Java_com_sun_cldchi_jvm_JVM_flushJarCaches();
extern "C" jint Java_java_lang_Thread_activeCount();
extern "C" jint Java_java_lang_String_lastIndexOf__II();
extern "C" jobject Java_java_lang_String_intern();
extern "C" jboolean Java_java_lang_Class_isInstance();
extern "C" jboolean Java_java_lang_Class_isArray();
extern "C" jobject Java_java_lang_ref_WeakReference_get();
extern "C" void Java_java_lang_ref_WeakReference_clear();
extern "C" void Java_java_lang_ref_WeakReference_finalize();
extern "C" void Java_com_sun_cldc_util_SemaphoreLock_acquire();
extern "C" void Java_com_sun_cldc_util_SemaphoreLock_release();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawLine();
extern "C" void Java_javax_microedition_lcdui_Graphics_fillRect();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawRect();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawRoundRect();
extern "C" void Java_javax_microedition_lcdui_Graphics_fillRoundRect();
extern "C" void Java_javax_microedition_lcdui_Graphics_fillArc();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawArc();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawString();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawSubstring();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawChar();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawChars();
extern "C" void Java_javax_microedition_lcdui_Graphics_fillTriangle();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawRGB();
extern "C" jint Java_javax_microedition_lcdui_Graphics_getDisplayColor();
extern "C" void Java_com_sun_cldchi_io_ConsoleOutputStream_write();
extern "C" void Java_com_sun_midp_events_EventQueue_sendNativeEventToIsolate();
extern "C" void Java_com_sun_midp_events_EventQueue_finalize();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMIDletSuiteInfoImpl0();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteAppImagePath();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteJarPath();
extern "C" jboolean Java_com_sun_midp_midletsuite_MIDletSuiteStorage_suiteExists();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_createSuiteID();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_storeSuiteVerifyHash();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_disable();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_enable();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_changeStorage();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_moveSuiteToFolder();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getStorageUsed();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSecureFilenameBase();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_checkSuitesIntegrity();
extern "C" void Java_com_sun_midp_chameleon_layers_SoftButtonLayer_setNativeSoftButtonLabel0();
extern "C" jint Java_com_sun_midp_chameleon_input_NativeInputMode_initialize();
extern "C" void Java_com_sun_midp_chameleon_input_NativeInputMode_finalize();
extern "C" jboolean Java_com_sun_midp_chameleon_input_NativeInputMode_supportsConstraints();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_getName();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_getCommandName();
extern "C" void Java_com_sun_midp_chameleon_input_NativeInputMode_beginInput0();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_processKey0();
extern "C" jchar Java_com_sun_midp_chameleon_input_NativeInputMode_getPendingChar();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_getNextMatch();
extern "C" jboolean Java_com_sun_midp_chameleon_input_NativeInputMode_hasMoreMatches();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_getMatchList();
extern "C" void Java_com_sun_midp_chameleon_input_NativeInputMode_endInput0();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_finalize();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_finalize();
extern "C" void Java_com_sun_midp_io_j2me_comm_Protocol_finalize();
extern "C" void Java_com_sun_midp_io_j2me_datagram_Protocol_finalize();
extern "C" void Java_com_sun_midp_io_j2me_serversocket_Socket_finalize();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_directFlush0();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_finalize();
extern "C" void Java_com_sun_midp_rms_RecordStoreSharedDBHeader_finalize();
extern "C" void Java_com_sun_midp_util_isolate_InterIsolateMutex_finalize();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteFolderId();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteImpl_finalize();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_finalize();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_LoadedSkinResources_finalize();
extern "C" jboolean Java_com_sun_midp_main_MIDletSuiteVerifier_checkJarHash();
#endif // ROMIZING
#endif // ROM_IMAGE_GENERATED_HEADER
