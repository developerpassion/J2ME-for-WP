/* This is a generated file.  Do not modify.
 * Generated on Sat Nov 14 08:14:49 ICT 2026
 */

/*
 *
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

#include "jvmconfig.h"
#if !defined(ROMIZING) || !defined(PRODUCT) || \
    ENABLE_TTY_TRACE
#include "NativesTable.hpp"
#include "kni.h"


extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_byteToChar();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_charToByte();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_getByteLength();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_getHandler();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_getMaxByteLength();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_sizeOfByteInUnicode();
extern "C" jint Java_com_sun_cldc_i18n_j2me_Conv_sizeOfUnicodeInByte();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_bytesRemain();
extern "C" jobject Java_com_sun_cldc_io_ResourceInputStream_clone();
extern "C" jobject Java_com_sun_cldc_io_ResourceInputStream_open();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_readByte();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_readBytes();
extern "C" void Java_com_sun_cldc_isolate_Isolate_attachDebugger0();
extern "C" jobject Java_com_sun_cldc_isolate_Isolate_currentIsolate0();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_exitCode0();
extern "C" jobject Java_com_sun_cldc_isolate_Isolate_getIsolates0();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_getStatus();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_id0();
extern "C" jboolean Java_com_sun_cldc_isolate_Isolate_isDebuggerConnected();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_isSuspended0();
extern "C" void Java_com_sun_cldc_isolate_Isolate_nativeStart();
extern "C" void Java_com_sun_cldc_isolate_Isolate_notifyStatus();
extern "C" void Java_com_sun_cldc_isolate_Isolate_registerNewIsolate();
extern "C" void Java_com_sun_cldc_isolate_Isolate_resume0();
extern "C" void Java_com_sun_cldc_isolate_Isolate_setPriority0();
extern "C" void Java_com_sun_cldc_isolate_Isolate_setProfile();
extern "C" void Java_com_sun_cldc_isolate_Isolate_stop();
extern "C" void Java_com_sun_cldc_isolate_Isolate_suspend0();
extern "C" jint Java_com_sun_cldc_isolate_Isolate_usedMemory0();
extern "C" void Java_com_sun_cldc_isolate_Isolate_waitStatus();
extern "C" void Java_com_sun_cldc_util_SemaphoreLock_acquire();
extern "C" void Java_com_sun_cldc_util_SemaphoreLock_release();
extern "C" void Java_com_sun_cldchi_io_ConsoleOutputStream_write();
extern "C" void Java_com_sun_cldchi_jvm_FileDescriptor_finalize();
extern "C" void Java_com_sun_cldchi_jvm_JVM_cancelImageCreation();
extern "C" jboolean Java_com_sun_cldchi_jvm_JVM_createAppImage0();
extern "C" void Java_com_sun_cldchi_jvm_JVM_createSysImage();
extern "C" void Java_com_sun_cldchi_jvm_JVM_flushJarCaches();
extern "C" jint Java_com_sun_cldchi_jvm_JVM_getAppImageProgress();
extern "C" void Java_com_sun_cldchi_jvm_JVM_loadLibrary();
extern "C" void Java_com_sun_cldchi_jvm_JVM_startAppImage();
extern "C" void native_jvm_unchecked_byte_arraycopy_entry();
extern "C" void native_jvm_unchecked_char_arraycopy_entry();
extern "C" void native_jvm_unchecked_int_arraycopy_entry();
extern "C" void native_jvm_unchecked_long_arraycopy_entry();
extern "C" void native_jvm_unchecked_obj_arraycopy_entry();
extern "C" jint Java_com_sun_cldchi_jvm_JVM_verifyNextChunk();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nClose();
extern "C" jint Java_com_sun_j2mewp_media_AudioPlayer_nCreate();
extern "C" jint Java_com_sun_j2mewp_media_AudioPlayer_nGetDuration();
extern "C" jint Java_com_sun_j2mewp_media_AudioPlayer_nGetTime();
extern "C" jboolean Java_com_sun_j2mewp_media_AudioPlayer_nIsPlaying();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nSetTime();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nSetVolume();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nStart();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nStop();
extern "C" void Java_com_sun_j2mewp_media_AudioPlayer_nTone();
extern "C" void Java_com_sun_j2mewp_media_DeviceHw_nBacklight();
extern "C" jint Java_com_sun_j2mewp_media_DeviceHw_nHasVibrator();
extern "C" void Java_com_sun_j2mewp_media_DeviceHw_nVibrate();
extern "C" jobject Java_com_sun_midp_chameleon_input_InputModeFactory_getInputModeIds();
extern "C" void Java_com_sun_midp_chameleon_input_NativeInputMode_beginInput0();
extern "C" void Java_com_sun_midp_chameleon_input_NativeInputMode_endInput0();
extern "C" void Java_com_sun_midp_chameleon_input_NativeInputMode_finalize();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_getCommandName();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_getMatchList();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_getName();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_getNextMatch();
extern "C" jchar Java_com_sun_midp_chameleon_input_NativeInputMode_getPendingChar();
extern "C" jboolean Java_com_sun_midp_chameleon_input_NativeInputMode_hasMoreMatches();
extern "C" jint Java_com_sun_midp_chameleon_input_NativeInputMode_initialize();
extern "C" jobject Java_com_sun_midp_chameleon_input_NativeInputMode_processKey0();
extern "C" jboolean Java_com_sun_midp_chameleon_input_NativeInputMode_supportsConstraints();
extern "C" jboolean Java_com_sun_midp_chameleon_layers_SoftButtonLayer_isNativeSoftButtonLayerSupported0();
extern "C" void Java_com_sun_midp_chameleon_layers_SoftButtonLayer_setNativeSoftButtonLabel0();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_beginReadingSkinFile();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_finalize();
extern "C" jint Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_finishReadingSkinFile();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readByteArray();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readIntArray();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readStringArray();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_LoadedSkinResources_finalize();
extern "C" jint Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getRomizedImageDataArrayLength();
extern "C" jint Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getRomizedImageDataArrayPtr();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getSharedResourcePool();
extern "C" jobject Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getSharedSkinData();
extern "C" jboolean Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_ifLoadAllResources0();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_shareResourcePool();
extern "C" void Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_shareSkinData();
extern "C" void Java_com_sun_midp_crypto_MD2_nativeFinal();
extern "C" void Java_com_sun_midp_crypto_MD2_nativeUpdate();
extern "C" void Java_com_sun_midp_crypto_MD5_nativeFinal();
extern "C" void Java_com_sun_midp_crypto_MD5_nativeUpdate();
extern "C" jboolean Java_com_sun_midp_crypto_PRand_getRandomBytes();
extern "C" void Java_com_sun_midp_crypto_SHA_nativeFinal();
extern "C" void Java_com_sun_midp_crypto_SHA_nativeUpdate();
extern "C" void Java_com_sun_midp_events_EventQueue_finalize();
extern "C" jint Java_com_sun_midp_events_EventQueue_getNativeEventQueueHandle();
extern "C" void Java_com_sun_midp_events_EventQueue_handleFatalError();
extern "C" void Java_com_sun_midp_events_EventQueue_resetNativeEventQueue();
extern "C" void Java_com_sun_midp_events_EventQueue_sendNativeEventToIsolate();
extern "C" void Java_com_sun_midp_events_EventQueue_sendShutdownEvent();
extern "C" jboolean Java_com_sun_midp_events_NativeEventMonitor_readNativeEvent();
extern "C" jint Java_com_sun_midp_events_NativeEventMonitor_waitForNativeEvent();
extern "C" void Java_com_sun_midp_installer_OtaNotifier_addInstallNotification();
extern "C" void Java_com_sun_midp_installer_OtaNotifier_fillDeleteNotificationListForRetry();
extern "C" jboolean Java_com_sun_midp_installer_OtaNotifier_getInstallNotificationForRetry();
extern "C" jint Java_com_sun_midp_installer_OtaNotifier_getNumberOfDeleteNotifications();
extern "C" void Java_com_sun_midp_installer_OtaNotifier_removeDeleteNotification();
extern "C" void Java_com_sun_midp_installer_OtaNotifier_removeInstallNotification();
extern "C" void Java_com_sun_midp_io_NetworkConnectionBase_initializeInternal();
extern "C" void Java_com_sun_midp_io_j2me_comm_Protocol_finalize();
extern "C" void Java_com_sun_midp_io_j2me_comm_Protocol_native_1close();
extern "C" void Java_com_sun_midp_io_j2me_comm_Protocol_native_1configurePort();
extern "C" jint Java_com_sun_midp_io_j2me_comm_Protocol_native_1openByName();
extern "C" jint Java_com_sun_midp_io_j2me_comm_Protocol_native_1readBytes();
extern "C" jint Java_com_sun_midp_io_j2me_comm_Protocol_native_1writeBytes();
extern "C" jobject Java_com_sun_midp_io_j2me_datagram_Protocol_addrToString();
extern "C" void Java_com_sun_midp_io_j2me_datagram_Protocol_close0();
extern "C" void Java_com_sun_midp_io_j2me_datagram_Protocol_finalize();
extern "C" jobject Java_com_sun_midp_io_j2me_datagram_Protocol_getHost0();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_getIpNumber();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_getMaximumLength0();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_getNominalLength0();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_getPort0();
extern "C" void Java_com_sun_midp_io_j2me_datagram_Protocol_open0();
extern "C" jlong Java_com_sun_midp_io_j2me_datagram_Protocol_receive0();
extern "C" jint Java_com_sun_midp_io_j2me_datagram_Protocol_send0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_add0();
extern "C" jlong Java_com_sun_midp_io_j2me_push_ConnectionRegistry_addAlarm0();
extern "C" void Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByHandle0();
extern "C" void Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByMidlet0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByName0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_del0();
extern "C" void Java_com_sun_midp_io_j2me_push_ConnectionRegistry_delAllForSuite0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_getEntry0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_getMIDlet0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_list0();
extern "C" jint Java_com_sun_midp_io_j2me_push_ConnectionRegistry_poll0();
extern "C" void Java_com_sun_midp_io_j2me_serversocket_Socket_accept0();
extern "C" void Java_com_sun_midp_io_j2me_serversocket_Socket_close0();
extern "C" void Java_com_sun_midp_io_j2me_serversocket_Socket_finalize();
extern "C" jobject Java_com_sun_midp_io_j2me_serversocket_Socket_getLocalAddress0();
extern "C" jint Java_com_sun_midp_io_j2me_serversocket_Socket_getLocalPort0();
extern "C" void Java_com_sun_midp_io_j2me_serversocket_Socket_open0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_available0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_close0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_finalize();
extern "C" jobject Java_com_sun_midp_io_j2me_socket_Protocol_getHost0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_getIpNumber0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_getPort0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_getSockOpt0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_notifyClosedInput0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_notifyClosedOutput0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_open0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_read0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_setSockOpt0();
extern "C" void Java_com_sun_midp_io_j2me_socket_Protocol_shutdownOutput0();
extern "C" jint Java_com_sun_midp_io_j2me_socket_Protocol_write0();
extern "C" jlong Java_com_sun_midp_io_j2me_storage_File_availableStorage();
extern "C" void Java_com_sun_midp_io_j2me_storage_File_deleteStorage();
extern "C" jobject Java_com_sun_midp_io_j2me_storage_File_initConfigRoot();
extern "C" jobject Java_com_sun_midp_io_j2me_storage_File_initStorageRoot();
extern "C" void Java_com_sun_midp_io_j2me_storage_File_renameStorage();
extern "C" jboolean Java_com_sun_midp_io_j2me_storage_File_storageExists();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_close();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_commitWrite();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_finalize();
extern "C" jint Java_com_sun_midp_io_j2me_storage_RandomAccessStream_open();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_position();
extern "C" jint Java_com_sun_midp_io_j2me_storage_RandomAccessStream_read();
extern "C" jint Java_com_sun_midp_io_j2me_storage_RandomAccessStream_sizeOf();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_truncateStream();
extern "C" void Java_com_sun_midp_io_j2me_storage_RandomAccessStream_write();
extern "C" jobject Java_com_sun_midp_jarutil_JarReader_readJarEntry0();
extern "C" jobject Java_com_sun_midp_l10n_LocalizedStringsBase_getContent();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_clamshellHandling0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_directFlush0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_displayStateChanged0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_gainedForeground0();
extern "C" jint Java_com_sun_midp_lcdui_DisplayDevice_getDisplayCapabilities0();
extern "C" jobject Java_com_sun_midp_lcdui_DisplayDevice_getDisplayName0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_getReverseOrientation0();
extern "C" jint Java_com_sun_midp_lcdui_DisplayDevice_getScreenHeight0();
extern "C" jint Java_com_sun_midp_lcdui_DisplayDevice_getScreenWidth0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPenMotionSupported0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPenSupported0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPrimary0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_isbuildInDisplay0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_refresh0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDevice_reverseOrientation0();
extern "C" void Java_com_sun_midp_lcdui_DisplayDevice_setFullScreen0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDeviceAccess_isBacklightSupported0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDeviceAccess_toggleBacklight0();
extern "C" jboolean Java_com_sun_midp_lcdui_DisplayDeviceAccess_vibrate0();
extern "C" jobject Java_com_sun_midp_lcdui_DisplayDeviceContainer_getDisplayDevicesIds0();
extern "C" jint Java_com_sun_midp_log_Logging_getAllowedSeverity();
extern "C" void Java_com_sun_midp_log_Logging_report0();
extern "C" void Java_com_sun_midp_log_LoggingBase_report();
extern "C" jboolean Java_com_sun_midp_main_CldcPlatformRequest_dispatchPlatformRequest();
extern "C" void Java_com_sun_midp_main_CommandState_exitInternal();
extern "C" void Java_com_sun_midp_main_CommandState_restoreCommandState();
extern "C" void Java_com_sun_midp_main_CommandState_saveCommandState();
extern "C" jobject Java_com_sun_midp_main_Configuration_getProperty0();
extern "C" jboolean Java_com_sun_midp_main_MIDletAppImageGenerator_removeAppImage();
extern "C" void Java_com_sun_midp_main_MIDletProxyList_notifyResumeAll0();
extern "C" void Java_com_sun_midp_main_MIDletProxyList_notifySuspendAll0();
extern "C" void Java_com_sun_midp_main_MIDletProxyList_resetForegroundInNativeState();
extern "C" void Java_com_sun_midp_main_MIDletProxyList_setForegroundInNativeState();
extern "C" void Java_com_sun_midp_main_MIDletProxyUtils_requestVMStop();
extern "C" jint Java_com_sun_midp_main_MIDletSuiteUtils_getAmsIsolateId();
extern "C" jint Java_com_sun_midp_main_MIDletSuiteUtils_getIsolateId();
extern "C" jint Java_com_sun_midp_main_MIDletSuiteUtils_getMaxIsolates();
extern "C" jboolean Java_com_sun_midp_main_MIDletSuiteUtils_isAmsIsolate();
extern "C" void Java_com_sun_midp_main_MIDletSuiteUtils_registerAmsIsolateId();
extern "C" void Java_com_sun_midp_main_MIDletSuiteUtils_vmBeginStartUp();
extern "C" void Java_com_sun_midp_main_MIDletSuiteUtils_vmEndStartUp();
extern "C" jboolean Java_com_sun_midp_main_MIDletSuiteVerifier_checkJarHash();
extern "C" jobject Java_com_sun_midp_main_MIDletSuiteVerifier_getJarHash();
extern "C" void Java_com_sun_midp_main_MIDletSuiteVerifier_useClassVerifier();
extern "C" void Java_com_sun_midp_midletsuite_InstallInfo_load();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteImpl_finalize();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteImpl_lockMIDletSuite();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteImpl_unlockMIDletSuite();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_changeStorage();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_checkSuitesIntegrity();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_createSuiteID();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_disable();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_enable();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMIDletSuiteIcon0();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMIDletSuiteInfoImpl0();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteAppImagePath();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteFolderId();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteJarPath();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteStorageId();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getNumberOfSuites();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSecureFilenameBase();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getStorageUsed();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSuiteID();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSuiteList();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_loadCachedIcon0();
extern "C" jint Java_com_sun_midp_midletsuite_MIDletSuiteStorage_loadSuitesIcons0();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_moveSuiteToFolder();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_nativeStoreSuite();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_remove0();
extern "C" void Java_com_sun_midp_midletsuite_MIDletSuiteStorage_storeSuiteVerifyHash();
extern "C" jboolean Java_com_sun_midp_midletsuite_MIDletSuiteStorage_suiteExists();
extern "C" jobject Java_com_sun_midp_midletsuite_MIDletSuiteStorage_suiteIdToString();
extern "C" jobject Java_com_sun_midp_midletsuite_SuiteProperties_load();
extern "C" void Java_com_sun_midp_midletsuite_SuiteSettings_load();
extern "C" void Java_com_sun_midp_midletsuite_SuiteSettings_save0();
extern "C" jboolean Java_com_sun_midp_rms_RecordStoreFactory_suiteHasRmsData0();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_closeFile();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_commitWrite();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_finalize();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_getNumberOfStores();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_getRecordStoreList();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_openRecordStoreFile();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_readBytes();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_removeRecordStores0();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_setPosition();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_spaceAvailableNewRecordStore0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreFile_spaceAvailableRecordStore();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_truncateFile();
extern "C" void Java_com_sun_midp_rms_RecordStoreFile_writeBytes();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_acknowledgeNotificationsDelivery();
extern "C" jobject Java_com_sun_midp_rms_RecordStoreRegistry_getRecordStoreListeners();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_resetNotificationCounter();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_sendRecordStoreChangeEvent();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_startRecordStoreListening();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_stopAllRecordStoreListeners();
extern "C" void Java_com_sun_midp_rms_RecordStoreRegistry_stopRecordStoreListening();
extern "C" void Java_com_sun_midp_rms_RecordStoreSharedDBHeader_cleanup0();
extern "C" void Java_com_sun_midp_rms_RecordStoreSharedDBHeader_finalize();
extern "C" jint Java_com_sun_midp_rms_RecordStoreSharedDBHeader_getHeaderRefCount0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreSharedDBHeader_getLookupId0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreSharedDBHeader_shareCachedData0();
extern "C" jint Java_com_sun_midp_rms_RecordStoreSharedDBHeader_updateCachedData0();
extern "C" void Java_com_sun_midp_rms_RecordStoreUtil_deleteFile();
extern "C" jboolean Java_com_sun_midp_rms_RecordStoreUtil_exists();
extern "C" jbyte Java_com_sun_midp_security_Permissions_getDefaultValue();
extern "C" jobject Java_com_sun_midp_security_Permissions_getGroupMessages();
extern "C" jbyte Java_com_sun_midp_security_Permissions_getMaxValue();
extern "C" jobject Java_com_sun_midp_security_Permissions_loadDomainList();
extern "C" jobject Java_com_sun_midp_security_Permissions_loadGroupList();
extern "C" jobject Java_com_sun_midp_security_Permissions_loadGroupPermissions();
extern "C" void Java_com_sun_midp_security_Permissions_loadingFinished();
extern "C" jboolean Java_com_sun_midp_suspend_SuspendSystem_isResumePending();
extern "C" jboolean Java_com_sun_midp_suspend_SuspendSystem_00024MIDPSystem_allMidletsKilled();
extern "C" void Java_com_sun_midp_suspend_SuspendSystem_00024MIDPSystem_suspended0();
extern "C" jobject Java_com_sun_midp_util_ResourceHandler_loadRomizedResource0();
extern "C" void Java_com_sun_midp_util_isolate_InterIsolateMutex_finalize();
extern "C" jint Java_com_sun_midp_util_isolate_InterIsolateMutex_getID0();
extern "C" void Java_com_sun_midp_util_isolate_InterIsolateMutex_lock0();
extern "C" void Java_com_sun_midp_util_isolate_InterIsolateMutex_unlock0();
extern "C" jobject Java_java_lang_Class_forName();
extern "C" jobject Java_java_lang_Class_getName();
extern "C" jobject Java_java_lang_Class_getSuperclass();
extern "C" void Java_java_lang_Class_init9();
extern "C" void Java_java_lang_Class_invoke_1clinit();
extern "C" void Java_java_lang_Class_invoke_1verify();
extern "C" jboolean Java_java_lang_Class_isArray();
extern "C" jboolean Java_java_lang_Class_isAssignableFrom();
extern "C" jboolean Java_java_lang_Class_isInstance();
extern "C" jboolean Java_java_lang_Class_isInterface();
extern "C" jobject Java_java_lang_Class_newInstance();
extern "C" jlong Java_java_lang_Double_doubleToLongBits();
extern "C" jdouble Java_java_lang_Double_longBitsToDouble();
extern "C" jint Java_java_lang_Float_floatToIntBits();
extern "C" jfloat Java_java_lang_Float_intBitsToFloat();
extern "C" void native_integer_toString_entry();
extern "C" void native_math_ceil_entry();
extern "C" void native_math_cos_entry();
extern "C" void native_math_floor_entry();
extern "C" void native_math_sin_entry();
extern "C" void native_math_sqrt_entry();
extern "C" void native_math_tan_entry();
extern "C" jobject Java_java_lang_Object_getClass();
extern "C" jint Java_java_lang_Object_hashCode();
extern "C" void Java_java_lang_Object_notify();
extern "C" void Java_java_lang_Object_notifyAll();
extern "C" void Java_java_lang_Object_wait();
extern "C" void Java_java_lang_Runtime_exitInternal();
extern "C" jlong Java_java_lang_Runtime_freeMemory();
extern "C" void Java_java_lang_Runtime_gc();
extern "C" jlong Java_java_lang_Runtime_totalMemory();
extern "C" void native_string_init_entry();
extern "C" void native_string_charAt_entry();
extern "C" void native_string_endsWith_entry();
extern "C" void native_string_equals_entry();
extern "C" jint Java_java_lang_String_hashCode();
extern "C" void native_string_indexof0_entry();
extern "C" void native_string_indexof_entry();
extern "C" void native_string_indexof0_string_entry();
extern "C" void native_string_indexof_string_entry();
extern "C" jobject Java_java_lang_String_intern();
extern "C" jint Java_java_lang_String_lastIndexOf__I();
extern "C" jint Java_java_lang_String_lastIndexOf__II();
extern "C" void native_string_startsWith0_entry();
extern "C" void native_string_startsWith_entry();
extern "C" void native_string_substringI_entry();
extern "C" void native_string_substringII_entry();
extern "C" void native_integer_toString_entry();
extern "C" void native_stringbuffer_append_entry();
extern "C" void Java_java_lang_System_arraycopy();
extern "C" void native_system_arraycopy_entry();
extern "C" jlong Java_java_lang_System_currentTimeMillis();
extern "C" jobject Java_java_lang_System_getProperty0();
extern "C" jint Java_java_lang_System_identityHashCode();
extern "C" void Java_java_lang_System_quickNativeThrow();
extern "C" jint Java_java_lang_Thread_activeCount();
extern "C" jobject Java_java_lang_Thread_currentThread();
extern "C" void Java_java_lang_Thread_internalExit();
extern "C" void Java_java_lang_Thread_interrupt0();
extern "C" jboolean Java_java_lang_Thread_isAlive();
extern "C" void Java_java_lang_Thread_setPriority0();
extern "C" void Java_java_lang_Thread_sleep();
extern "C" void Java_java_lang_Thread_start0();
extern "C" void Java_java_lang_Thread_yield();
extern "C" void Java_java_lang_Throwable_fillInStackTrace();
extern "C" void Java_java_lang_Throwable_printStackTrace();
extern "C" void Java_java_lang_ref_WeakReference_clear();
extern "C" void Java_java_lang_ref_WeakReference_finalize();
extern "C" jobject Java_java_lang_ref_WeakReference_get();
extern "C" void Java_java_lang_ref_WeakReference_initializeWeakReference();
extern "C" void native_vector_addElement_entry();
extern "C" void native_vector_elementAt_entry();
extern "C" void Java_javax_microedition_lcdui_Display_drawTrustedIcon0();
extern "C" jint Java_javax_microedition_lcdui_Font_charWidth();
extern "C" jint Java_javax_microedition_lcdui_Font_charsWidth();
extern "C" void Java_javax_microedition_lcdui_Font_init();
extern "C" jint Java_javax_microedition_lcdui_Font_stringWidth();
extern "C" jint Java_javax_microedition_lcdui_Font_substringWidth();
extern "C" void Java_javax_microedition_lcdui_Graphics_doCopyArea();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawArc();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawChar();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawChars();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawLine();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawRGB();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawRect();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawRoundRect();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawString();
extern "C" void Java_javax_microedition_lcdui_Graphics_drawSubstring();
extern "C" void Java_javax_microedition_lcdui_Graphics_fillArc();
extern "C" void Java_javax_microedition_lcdui_Graphics_fillRect();
extern "C" void Java_javax_microedition_lcdui_Graphics_fillRoundRect();
extern "C" void Java_javax_microedition_lcdui_Graphics_fillTriangle();
extern "C" jint Java_javax_microedition_lcdui_Graphics_getDisplayColor();
extern "C" jint Java_javax_microedition_lcdui_Graphics_getPixel();
extern "C" jboolean Java_javax_microedition_lcdui_Graphics_render();
extern "C" jboolean Java_javax_microedition_lcdui_Graphics_renderRegion();
extern "C" void Java_javax_microedition_lcdui_ImageData_getRGB();
extern "C" void Java_javax_microedition_lcdui_ImageDataFactory_loadJPEG();
extern "C" jboolean Java_javax_microedition_lcdui_ImageDataFactory_loadPNG();
extern "C" void Java_javax_microedition_lcdui_ImageDataFactory_loadRAW();
extern "C" void Java_javax_microedition_lcdui_ImageDataFactory_loadRGB();
extern "C" void Java_javax_microedition_lcdui_ImageDataFactory_loadRegion();
extern "C" jboolean Java_javax_microedition_lcdui_ImageDataFactory_loadRomizedImage();
extern "C" jint Java_javax_microedition_lcdui_KeyConverter_getGameAction();
extern "C" jint Java_javax_microedition_lcdui_KeyConverter_getKeyCode();
extern "C" jobject Java_javax_microedition_lcdui_KeyConverter_getKeyName();
extern "C" jint Java_javax_microedition_lcdui_KeyConverter_getSystemKey();
extern "C" jboolean Java_javax_microedition_lcdui_SuiteImageCacheImpl_loadAndCreateImmutableImageDataFromCache0();
extern "C" void Java_javax_microedition_lcdui_game_GameCanvas_setSuppressKeyEvents();


static const JvmNativeFunction com_sun_cldc_i18n_j2me_Conv_natives[] = {
  JVM_NATIVE("byteToChar",    "(I[BII[CII)I",          Java_com_sun_cldc_i18n_j2me_Conv_byteToChar),
  JVM_NATIVE("charToByte",    "(I[CII[BII)I",          Java_com_sun_cldc_i18n_j2me_Conv_charToByte),
  JVM_NATIVE("getByteLength", "(I[BII)I",              Java_com_sun_cldc_i18n_j2me_Conv_getByteLength),
  JVM_NATIVE("getHandler",    "(Ljava/lang/String;)I", Java_com_sun_cldc_i18n_j2me_Conv_getHandler),
  JVM_NATIVE("getMaxByteLength","(I)I",                  Java_com_sun_cldc_i18n_j2me_Conv_getMaxByteLength),
  JVM_NATIVE("sizeOfByteInUnicode","(I[BII)I",              Java_com_sun_cldc_i18n_j2me_Conv_sizeOfByteInUnicode),
  JVM_NATIVE("sizeOfUnicodeInByte","(I[CII)I",              Java_com_sun_cldc_i18n_j2me_Conv_sizeOfUnicodeInByte),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_cldc_io_ResourceInputStream_natives[] = {
  JVM_NATIVE("bytesRemain",   "(Ljava/lang/Object;)I", Java_com_sun_cldc_io_ResourceInputStream_bytesRemain),
  JVM_NATIVE("clone",         "(Ljava/lang/Object;)Ljava/lang/Object;", Java_com_sun_cldc_io_ResourceInputStream_clone),
  JVM_NATIVE("open",          "(Ljava/lang/String;)Ljava/lang/Object;", Java_com_sun_cldc_io_ResourceInputStream_open),
  JVM_NATIVE("readByte",      "(Ljava/lang/Object;)I", Java_com_sun_cldc_io_ResourceInputStream_readByte),
  JVM_NATIVE("readBytes",     "(Ljava/lang/Object;[BII)I", Java_com_sun_cldc_io_ResourceInputStream_readBytes),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_cldc_isolate_Isolate_natives[] = {
  JVM_NATIVE("attachDebugger0","(Lcom/sun/cldc/isolate/Isolate;)V", Java_com_sun_cldc_isolate_Isolate_attachDebugger0),
  JVM_NATIVE("currentIsolate0","()Lcom/sun/cldc/isolate/Isolate;", Java_com_sun_cldc_isolate_Isolate_currentIsolate0),
  JVM_NATIVE("exitCode0",     "()I",                   Java_com_sun_cldc_isolate_Isolate_exitCode0),
  JVM_NATIVE("getIsolates0",  "()[Lcom/sun/cldc/isolate/Isolate;", Java_com_sun_cldc_isolate_Isolate_getIsolates0),
  JVM_NATIVE("getStatus",     "()I",                   Java_com_sun_cldc_isolate_Isolate_getStatus),
  JVM_NATIVE("id0",           "()I",                   Java_com_sun_cldc_isolate_Isolate_id0),
  JVM_NATIVE("isDebuggerConnected","()Z",                   Java_com_sun_cldc_isolate_Isolate_isDebuggerConnected),
  JVM_NATIVE("isSuspended0",  "()I",                   Java_com_sun_cldc_isolate_Isolate_isSuspended0),
  JVM_NATIVE("nativeStart",   "()V",                   Java_com_sun_cldc_isolate_Isolate_nativeStart),
  JVM_NATIVE("notifyStatus",  "()V",                   Java_com_sun_cldc_isolate_Isolate_notifyStatus),
  JVM_NATIVE("registerNewIsolate","()V",                   Java_com_sun_cldc_isolate_Isolate_registerNewIsolate),
  JVM_NATIVE("resume0",       "()V",                   Java_com_sun_cldc_isolate_Isolate_resume0),
  JVM_NATIVE("setPriority0",  "(I)V",                  Java_com_sun_cldc_isolate_Isolate_setPriority0),
  JVM_NATIVE("setProfile",    "(Ljava/lang/String;)V", Java_com_sun_cldc_isolate_Isolate_setProfile),
  JVM_NATIVE("stop",          "(II)V",                 Java_com_sun_cldc_isolate_Isolate_stop),
  JVM_NATIVE("suspend0",      "()V",                   Java_com_sun_cldc_isolate_Isolate_suspend0),
  JVM_NATIVE("usedMemory0",   "()I",                   Java_com_sun_cldc_isolate_Isolate_usedMemory0),
  JVM_NATIVE("waitStatus",    "(I)V",                  Java_com_sun_cldc_isolate_Isolate_waitStatus),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_cldc_util_SemaphoreLock_natives[] = {
  JVM_NATIVE("acquire",       "()V",                   Java_com_sun_cldc_util_SemaphoreLock_acquire),
  JVM_NATIVE("release",       "()V",                   Java_com_sun_cldc_util_SemaphoreLock_release),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_cldchi_io_ConsoleOutputStream_natives[] = {
  JVM_NATIVE("write",         "(I)V",                  Java_com_sun_cldchi_io_ConsoleOutputStream_write),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_cldchi_jvm_FileDescriptor_natives[] = {
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_cldchi_jvm_FileDescriptor_finalize),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_cldchi_jvm_JVM_natives[] = {
  JVM_NATIVE("cancelImageCreation","()V",                   Java_com_sun_cldchi_jvm_JVM_cancelImageCreation),
  JVM_NATIVE("createAppImage0","()Z",                   Java_com_sun_cldchi_jvm_JVM_createAppImage0),
  JVM_NATIVE("createSysImage","()V",                   Java_com_sun_cldchi_jvm_JVM_createSysImage),
  JVM_NATIVE("flushJarCaches","()V",                   Java_com_sun_cldchi_jvm_JVM_flushJarCaches),
  JVM_NATIVE("getAppImageProgress","()I",                   Java_com_sun_cldchi_jvm_JVM_getAppImageProgress),
  JVM_NATIVE("loadLibrary",   "(Ljava/lang/String;)V", Java_com_sun_cldchi_jvm_JVM_loadLibrary),
  JVM_NATIVE("startAppImage", "([C[CI)V",              Java_com_sun_cldchi_jvm_JVM_startAppImage),
  JVM_NATIVE("verifyNextChunk","(Ljava/lang/String;II)I", Java_com_sun_cldchi_jvm_JVM_verifyNextChunk),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_cldchi_jvm_JVM_entries[] = {
  JVM_ENTRY("unchecked_byte_arraycopy", "([BI[BII)V", native_jvm_unchecked_byte_arraycopy_entry),
  JVM_ENTRY("unchecked_char_arraycopy", "([CI[CII)V", native_jvm_unchecked_char_arraycopy_entry),
  JVM_ENTRY("unchecked_int_arraycopy", "([II[III)V", native_jvm_unchecked_int_arraycopy_entry),
  JVM_ENTRY("unchecked_long_arraycopy", "([JI[JII)V", native_jvm_unchecked_long_arraycopy_entry),
  JVM_ENTRY("unchecked_obj_arraycopy", "([Ljava/lang/Object;I[Ljava/lang/Object;II)V", native_jvm_unchecked_obj_arraycopy_entry),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_j2mewp_media_AudioPlayer_natives[] = {
  JVM_NATIVE("nClose",        "(I)V",                  Java_com_sun_j2mewp_media_AudioPlayer_nClose),
  JVM_NATIVE("nCreate",       "([BI)I",                Java_com_sun_j2mewp_media_AudioPlayer_nCreate),
  JVM_NATIVE("nGetDuration",  "(I)I",                  Java_com_sun_j2mewp_media_AudioPlayer_nGetDuration),
  JVM_NATIVE("nGetTime",      "(I)I",                  Java_com_sun_j2mewp_media_AudioPlayer_nGetTime),
  JVM_NATIVE("nIsPlaying",    "(I)Z",                  Java_com_sun_j2mewp_media_AudioPlayer_nIsPlaying),
  JVM_NATIVE("nSetTime",      "(II)V",                 Java_com_sun_j2mewp_media_AudioPlayer_nSetTime),
  JVM_NATIVE("nSetVolume",    "(II)V",                 Java_com_sun_j2mewp_media_AudioPlayer_nSetVolume),
  JVM_NATIVE("nStart",        "(II)V",                 Java_com_sun_j2mewp_media_AudioPlayer_nStart),
  JVM_NATIVE("nStop",         "(I)V",                  Java_com_sun_j2mewp_media_AudioPlayer_nStop),
  JVM_NATIVE("nTone",         "(III)V",                Java_com_sun_j2mewp_media_AudioPlayer_nTone),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_j2mewp_media_DeviceHw_natives[] = {
  JVM_NATIVE("nBacklight",    "(I)V",                  Java_com_sun_j2mewp_media_DeviceHw_nBacklight),
  JVM_NATIVE("nHasVibrator",  "()I",                   Java_com_sun_j2mewp_media_DeviceHw_nHasVibrator),
  JVM_NATIVE("nVibrate",      "(I)V",                  Java_com_sun_j2mewp_media_DeviceHw_nVibrate),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_chameleon_input_InputModeFactory_natives[] = {
  JVM_NATIVE("getInputModeIds","()[I",                  Java_com_sun_midp_chameleon_input_InputModeFactory_getInputModeIds),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_chameleon_input_NativeInputMode_natives[] = {
  JVM_NATIVE("beginInput0",   "(Lcom/sun/midp/chameleon/input/InputModeMediator;Ljava/lang/String;I)V", Java_com_sun_midp_chameleon_input_NativeInputMode_beginInput0),
  JVM_NATIVE("endInput0",     "()V",                   Java_com_sun_midp_chameleon_input_NativeInputMode_endInput0),
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_chameleon_input_NativeInputMode_finalize),
  JVM_NATIVE("getCommandName","()Ljava/lang/String;",  Java_com_sun_midp_chameleon_input_NativeInputMode_getCommandName),
  JVM_NATIVE("getMatchList",  "()[Ljava/lang/String;", Java_com_sun_midp_chameleon_input_NativeInputMode_getMatchList),
  JVM_NATIVE("getName",       "()Ljava/lang/String;",  Java_com_sun_midp_chameleon_input_NativeInputMode_getName),
  JVM_NATIVE("getNextMatch",  "()Ljava/lang/String;",  Java_com_sun_midp_chameleon_input_NativeInputMode_getNextMatch),
  JVM_NATIVE("getPendingChar","()C",                   Java_com_sun_midp_chameleon_input_NativeInputMode_getPendingChar),
  JVM_NATIVE("hasMoreMatches","()Z",                   Java_com_sun_midp_chameleon_input_NativeInputMode_hasMoreMatches),
  JVM_NATIVE("initialize",    "(I)I",                  Java_com_sun_midp_chameleon_input_NativeInputMode_initialize),
  JVM_NATIVE("processKey0",   "(IZI[I)Ljava/lang/String;", Java_com_sun_midp_chameleon_input_NativeInputMode_processKey0),
  JVM_NATIVE("supportsConstraints","(I)Z",                  Java_com_sun_midp_chameleon_input_NativeInputMode_supportsConstraints),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_chameleon_layers_SoftButtonLayer_natives[] = {
  JVM_NATIVE("isNativeSoftButtonLayerSupported0","()Z",                   Java_com_sun_midp_chameleon_layers_SoftButtonLayer_isNativeSoftButtonLayerSupported0),
  JVM_NATIVE("setNativeSoftButtonLabel0","(Ljava/lang/String;I)V", Java_com_sun_midp_chameleon_layers_SoftButtonLayer_setNativeSoftButtonLabel0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_chameleon_skins_resources_LoadedSkinData_natives[] = {
  JVM_NATIVE("beginReadingSkinFile","(Ljava/lang/String;)V", Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_beginReadingSkinFile),
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_finalize),
  JVM_NATIVE("finishReadingSkinFile","()I",                   Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_finishReadingSkinFile),
  JVM_NATIVE("readByteArray", "(I)[B",                 Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readByteArray),
  JVM_NATIVE("readIntArray",  "()[I",                  Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readIntArray),
  JVM_NATIVE("readStringArray","()[Ljava/lang/String;", Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData_readStringArray),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_chameleon_skins_resources_LoadedSkinResources_natives[] = {
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_chameleon_skins_resources_LoadedSkinResources_finalize),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_natives[] = {
  JVM_NATIVE("getRomizedImageDataArrayLength","(I)I",                  Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getRomizedImageDataArrayLength),
  JVM_NATIVE("getRomizedImageDataArrayPtr","(I)I",                  Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getRomizedImageDataArrayPtr),
  JVM_NATIVE("getSharedResourcePool","()Ljava/lang/Object;",  Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getSharedResourcePool),
  JVM_NATIVE("getSharedSkinData","()Ljava/lang/Object;",  Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_getSharedSkinData),
  JVM_NATIVE("ifLoadAllResources0","()Z",                   Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_ifLoadAllResources0),
  JVM_NATIVE("shareResourcePool","(Ljava/lang/Object;)V", Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_shareResourcePool),
  JVM_NATIVE("shareSkinData", "(Ljava/lang/Object;)V", Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_shareSkinData),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_crypto_MD2_natives[] = {
  JVM_NATIVE("nativeFinal",   "([BII[BI[I[I[I[B)V",    Java_com_sun_midp_crypto_MD2_nativeFinal),
  JVM_NATIVE("nativeUpdate",  "([BII[I[I[I[B)V",       Java_com_sun_midp_crypto_MD2_nativeUpdate),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_crypto_MD5_natives[] = {
  JVM_NATIVE("nativeFinal",   "([BII[BI[I[I[I[I)V",    Java_com_sun_midp_crypto_MD5_nativeFinal),
  JVM_NATIVE("nativeUpdate",  "([BII[I[I[I[I)V",       Java_com_sun_midp_crypto_MD5_nativeUpdate),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_crypto_PRand_natives[] = {
  JVM_NATIVE("getRandomBytes","([BI)Z",                Java_com_sun_midp_crypto_PRand_getRandomBytes),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_crypto_SHA_natives[] = {
  JVM_NATIVE("nativeFinal",   "([BII[BI[I[I[I[I)V",    Java_com_sun_midp_crypto_SHA_nativeFinal),
  JVM_NATIVE("nativeUpdate",  "([BII[I[I[I[I)V",       Java_com_sun_midp_crypto_SHA_nativeUpdate),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_events_EventQueue_natives[] = {
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_events_EventQueue_finalize),
  JVM_NATIVE("getNativeEventQueueHandle","()I",                   Java_com_sun_midp_events_EventQueue_getNativeEventQueueHandle),
  JVM_NATIVE("handleFatalError","(Ljava/lang/Throwable;)V", Java_com_sun_midp_events_EventQueue_handleFatalError),
  JVM_NATIVE("resetNativeEventQueue","()V",                   Java_com_sun_midp_events_EventQueue_resetNativeEventQueue),
  JVM_NATIVE("sendNativeEventToIsolate","(Lcom/sun/midp/events/NativeEvent;I)V", Java_com_sun_midp_events_EventQueue_sendNativeEventToIsolate),
  JVM_NATIVE("sendShutdownEvent","()V",                   Java_com_sun_midp_events_EventQueue_sendShutdownEvent),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_events_NativeEventMonitor_natives[] = {
  JVM_NATIVE("readNativeEvent","(Lcom/sun/midp/events/NativeEvent;)Z", Java_com_sun_midp_events_NativeEventMonitor_readNativeEvent),
  JVM_NATIVE("waitForNativeEvent","(Lcom/sun/midp/events/NativeEvent;)I", Java_com_sun_midp_events_NativeEventMonitor_waitForNativeEvent),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_installer_OtaNotifier_natives[] = {
  JVM_NATIVE("addInstallNotification","(ILjava/lang/String;)V", Java_com_sun_midp_installer_OtaNotifier_addInstallNotification),
  JVM_NATIVE("fillDeleteNotificationListForRetry","([Lcom/sun/midp/installer/PendingNotification;)V", Java_com_sun_midp_installer_OtaNotifier_fillDeleteNotificationListForRetry),
  JVM_NATIVE("getInstallNotificationForRetry","(ILcom/sun/midp/installer/PendingNotification;)Z", Java_com_sun_midp_installer_OtaNotifier_getInstallNotificationForRetry),
  JVM_NATIVE("getNumberOfDeleteNotifications","()I",                   Java_com_sun_midp_installer_OtaNotifier_getNumberOfDeleteNotifications),
  JVM_NATIVE("removeDeleteNotification","(I)V",                  Java_com_sun_midp_installer_OtaNotifier_removeDeleteNotification),
  JVM_NATIVE("removeInstallNotification","(I)V",                  Java_com_sun_midp_installer_OtaNotifier_removeInstallNotification),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_io_NetworkConnectionBase_natives[] = {
  JVM_NATIVE("initializeInternal","()V",                   Java_com_sun_midp_io_NetworkConnectionBase_initializeInternal),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_io_j2me_comm_Protocol_natives[] = {
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_io_j2me_comm_Protocol_finalize),
  JVM_NATIVE("native_close",  "(I)V",                  Java_com_sun_midp_io_j2me_comm_Protocol_native_1close),
  JVM_NATIVE("native_configurePort","(III)V",                Java_com_sun_midp_io_j2me_comm_Protocol_native_1configurePort),
  JVM_NATIVE("native_openByName","(Ljava/lang/String;II)I", Java_com_sun_midp_io_j2me_comm_Protocol_native_1openByName),
  JVM_NATIVE("native_readBytes","(I[BII)I",              Java_com_sun_midp_io_j2me_comm_Protocol_native_1readBytes),
  JVM_NATIVE("native_writeBytes","(I[BII)I",              Java_com_sun_midp_io_j2me_comm_Protocol_native_1writeBytes),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_io_j2me_datagram_Protocol_natives[] = {
  JVM_NATIVE("addrToString",  "(I)Ljava/lang/String;", Java_com_sun_midp_io_j2me_datagram_Protocol_addrToString),
  JVM_NATIVE("close0",        "()V",                   Java_com_sun_midp_io_j2me_datagram_Protocol_close0),
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_io_j2me_datagram_Protocol_finalize),
  JVM_NATIVE("getHost0",      "()Ljava/lang/String;",  Java_com_sun_midp_io_j2me_datagram_Protocol_getHost0),
  JVM_NATIVE("getIpNumber",   "(Ljava/lang/String;)I", Java_com_sun_midp_io_j2me_datagram_Protocol_getIpNumber),
  JVM_NATIVE("getMaximumLength0","()I",                   Java_com_sun_midp_io_j2me_datagram_Protocol_getMaximumLength0),
  JVM_NATIVE("getNominalLength0","()I",                   Java_com_sun_midp_io_j2me_datagram_Protocol_getNominalLength0),
  JVM_NATIVE("getPort0",      "()I",                   Java_com_sun_midp_io_j2me_datagram_Protocol_getPort0),
  JVM_NATIVE("open0",         "(II)V",                 Java_com_sun_midp_io_j2me_datagram_Protocol_open0),
  JVM_NATIVE("receive0",      "([BII)J",               Java_com_sun_midp_io_j2me_datagram_Protocol_receive0),
  JVM_NATIVE("send0",         "(II[BII)I",             Java_com_sun_midp_io_j2me_datagram_Protocol_send0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_io_j2me_push_ConnectionRegistry_natives[] = {
  JVM_NATIVE("add0",          "(Ljava/lang/String;)I", Java_com_sun_midp_io_j2me_push_ConnectionRegistry_add0),
  JVM_NATIVE("addAlarm0",     "([BJ)J",                Java_com_sun_midp_io_j2me_push_ConnectionRegistry_addAlarm0),
  JVM_NATIVE("checkInByHandle0","(I)V",                  Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByHandle0),
  JVM_NATIVE("checkInByMidlet0","(ILjava/lang/String;)V", Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByMidlet0),
  JVM_NATIVE("checkInByName0","([B)I",                 Java_com_sun_midp_io_j2me_push_ConnectionRegistry_checkInByName0),
  JVM_NATIVE("del0",          "(Ljava/lang/String;Ljava/lang/String;)I", Java_com_sun_midp_io_j2me_push_ConnectionRegistry_del0),
  JVM_NATIVE("delAllForSuite0","(I)V",                  Java_com_sun_midp_io_j2me_push_ConnectionRegistry_delAllForSuite0),
  JVM_NATIVE("getEntry0",     "([B[BI)I",              Java_com_sun_midp_io_j2me_push_ConnectionRegistry_getEntry0),
  JVM_NATIVE("getMIDlet0",    "(I[BI)I",               Java_com_sun_midp_io_j2me_push_ConnectionRegistry_getMIDlet0),
  JVM_NATIVE("list0",         "([BZ[BI)I",             Java_com_sun_midp_io_j2me_push_ConnectionRegistry_list0),
  JVM_NATIVE("poll0",         "(J)I",                  Java_com_sun_midp_io_j2me_push_ConnectionRegistry_poll0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_io_j2me_serversocket_Socket_natives[] = {
  JVM_NATIVE("accept0",       "(Lcom/sun/midp/io/j2me/socket/Protocol;)V", Java_com_sun_midp_io_j2me_serversocket_Socket_accept0),
  JVM_NATIVE("close0",        "()V",                   Java_com_sun_midp_io_j2me_serversocket_Socket_close0),
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_io_j2me_serversocket_Socket_finalize),
  JVM_NATIVE("getLocalAddress0","()Ljava/lang/String;",  Java_com_sun_midp_io_j2me_serversocket_Socket_getLocalAddress0),
  JVM_NATIVE("getLocalPort0", "()I",                   Java_com_sun_midp_io_j2me_serversocket_Socket_getLocalPort0),
  JVM_NATIVE("open0",         "(II)V",                 Java_com_sun_midp_io_j2me_serversocket_Socket_open0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_io_j2me_socket_Protocol_natives[] = {
  JVM_NATIVE("available0",    "()I",                   Java_com_sun_midp_io_j2me_socket_Protocol_available0),
  JVM_NATIVE("close0",        "()V",                   Java_com_sun_midp_io_j2me_socket_Protocol_close0),
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_io_j2me_socket_Protocol_finalize),
  JVM_NATIVE("getHost0",      "(Z)Ljava/lang/String;", Java_com_sun_midp_io_j2me_socket_Protocol_getHost0),
  JVM_NATIVE("getIpNumber0",  "(Ljava/lang/String;[B)I", Java_com_sun_midp_io_j2me_socket_Protocol_getIpNumber0),
  JVM_NATIVE("getPort0",      "(Z)I",                  Java_com_sun_midp_io_j2me_socket_Protocol_getPort0),
  JVM_NATIVE("getSockOpt0",   "(I)I",                  Java_com_sun_midp_io_j2me_socket_Protocol_getSockOpt0),
  JVM_NATIVE("notifyClosedInput0","()V",                   Java_com_sun_midp_io_j2me_socket_Protocol_notifyClosedInput0),
  JVM_NATIVE("notifyClosedOutput0","()V",                   Java_com_sun_midp_io_j2me_socket_Protocol_notifyClosedOutput0),
  JVM_NATIVE("open0",         "([BI)V",                Java_com_sun_midp_io_j2me_socket_Protocol_open0),
  JVM_NATIVE("read0",         "([BII)I",               Java_com_sun_midp_io_j2me_socket_Protocol_read0),
  JVM_NATIVE("setSockOpt0",   "(II)V",                 Java_com_sun_midp_io_j2me_socket_Protocol_setSockOpt0),
  JVM_NATIVE("shutdownOutput0","()V",                   Java_com_sun_midp_io_j2me_socket_Protocol_shutdownOutput0),
  JVM_NATIVE("write0",        "([BII)I",               Java_com_sun_midp_io_j2me_socket_Protocol_write0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_io_j2me_storage_File_natives[] = {
  JVM_NATIVE("availableStorage","(I)J",                  Java_com_sun_midp_io_j2me_storage_File_availableStorage),
  JVM_NATIVE("deleteStorage", "(Ljava/lang/String;)V", Java_com_sun_midp_io_j2me_storage_File_deleteStorage),
  JVM_NATIVE("initConfigRoot","(I)Ljava/lang/String;", Java_com_sun_midp_io_j2me_storage_File_initConfigRoot),
  JVM_NATIVE("initStorageRoot","(I)Ljava/lang/String;", Java_com_sun_midp_io_j2me_storage_File_initStorageRoot),
  JVM_NATIVE("renameStorage", "(Ljava/lang/String;Ljava/lang/String;)V", Java_com_sun_midp_io_j2me_storage_File_renameStorage),
  JVM_NATIVE("storageExists", "(Ljava/lang/String;)Z", Java_com_sun_midp_io_j2me_storage_File_storageExists),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_io_j2me_storage_RandomAccessStream_natives[] = {
  JVM_NATIVE("close",         "(I)V",                  Java_com_sun_midp_io_j2me_storage_RandomAccessStream_close),
  JVM_NATIVE("commitWrite",   "(I)V",                  Java_com_sun_midp_io_j2me_storage_RandomAccessStream_commitWrite),
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_io_j2me_storage_RandomAccessStream_finalize),
  JVM_NATIVE("open",          "(Ljava/lang/String;I)I", Java_com_sun_midp_io_j2me_storage_RandomAccessStream_open),
  JVM_NATIVE("position",      "(II)V",                 Java_com_sun_midp_io_j2me_storage_RandomAccessStream_position),
  JVM_NATIVE("read",          "(I[BII)I",              Java_com_sun_midp_io_j2me_storage_RandomAccessStream_read),
  JVM_NATIVE("sizeOf",        "(I)I",                  Java_com_sun_midp_io_j2me_storage_RandomAccessStream_sizeOf),
  JVM_NATIVE("truncateStream","(II)V",                 Java_com_sun_midp_io_j2me_storage_RandomAccessStream_truncateStream),
  JVM_NATIVE("write",         "(I[BII)V",              Java_com_sun_midp_io_j2me_storage_RandomAccessStream_write),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_jarutil_JarReader_natives[] = {
  JVM_NATIVE("readJarEntry0", "(Ljava/lang/String;Ljava/lang/String;)[B", Java_com_sun_midp_jarutil_JarReader_readJarEntry0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_l10n_LocalizedStringsBase_natives[] = {
  JVM_NATIVE("getContent",    "(I)Ljava/lang/String;", Java_com_sun_midp_l10n_LocalizedStringsBase_getContent),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_lcdui_DisplayDevice_natives[] = {
  JVM_NATIVE("clamshellHandling0","()V",                   Java_com_sun_midp_lcdui_DisplayDevice_clamshellHandling0),
  JVM_NATIVE("directFlush0",  "(ILjavax/microedition/lcdui/Graphics;Ljavax/microedition/lcdui/Image;I)Z", Java_com_sun_midp_lcdui_DisplayDevice_directFlush0),
  JVM_NATIVE("displayStateChanged0","(II)V",                 Java_com_sun_midp_lcdui_DisplayDevice_displayStateChanged0),
  JVM_NATIVE("gainedForeground0","(II)V",                 Java_com_sun_midp_lcdui_DisplayDevice_gainedForeground0),
  JVM_NATIVE("getDisplayCapabilities0","(I)I",                  Java_com_sun_midp_lcdui_DisplayDevice_getDisplayCapabilities0),
  JVM_NATIVE("getDisplayName0","(I)Ljava/lang/String;", Java_com_sun_midp_lcdui_DisplayDevice_getDisplayName0),
  JVM_NATIVE("getReverseOrientation0","(I)Z",                  Java_com_sun_midp_lcdui_DisplayDevice_getReverseOrientation0),
  JVM_NATIVE("getScreenHeight0","(I)I",                  Java_com_sun_midp_lcdui_DisplayDevice_getScreenHeight0),
  JVM_NATIVE("getScreenWidth0","(I)I",                  Java_com_sun_midp_lcdui_DisplayDevice_getScreenWidth0),
  JVM_NATIVE("isDisplayPenMotionSupported0","(I)Z",                  Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPenMotionSupported0),
  JVM_NATIVE("isDisplayPenSupported0","(I)Z",                  Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPenSupported0),
  JVM_NATIVE("isDisplayPrimary0","(I)Z",                  Java_com_sun_midp_lcdui_DisplayDevice_isDisplayPrimary0),
  JVM_NATIVE("isbuildInDisplay0","(I)Z",                  Java_com_sun_midp_lcdui_DisplayDevice_isbuildInDisplay0),
  JVM_NATIVE("refresh0",      "(IIIIII)V",             Java_com_sun_midp_lcdui_DisplayDevice_refresh0),
  JVM_NATIVE("reverseOrientation0","(I)Z",                  Java_com_sun_midp_lcdui_DisplayDevice_reverseOrientation0),
  JVM_NATIVE("setFullScreen0","(IIZ)V",                Java_com_sun_midp_lcdui_DisplayDevice_setFullScreen0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_lcdui_DisplayDeviceAccess_natives[] = {
  JVM_NATIVE("isBacklightSupported0","(I)Z",                  Java_com_sun_midp_lcdui_DisplayDeviceAccess_isBacklightSupported0),
  JVM_NATIVE("toggleBacklight0","(I)Z",                  Java_com_sun_midp_lcdui_DisplayDeviceAccess_toggleBacklight0),
  JVM_NATIVE("vibrate0",      "(IZ)Z",                 Java_com_sun_midp_lcdui_DisplayDeviceAccess_vibrate0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_lcdui_DisplayDeviceContainer_natives[] = {
  JVM_NATIVE("getDisplayDevicesIds0","()[I",                  Java_com_sun_midp_lcdui_DisplayDeviceContainer_getDisplayDevicesIds0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_log_Logging_natives[] = {
  JVM_NATIVE("getAllowedSeverity","(I)I",                  Java_com_sun_midp_log_Logging_getAllowedSeverity),
  JVM_NATIVE("report0",       "(IILjava/lang/String;)V", Java_com_sun_midp_log_Logging_report0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_log_LoggingBase_natives[] = {
  JVM_NATIVE("report",        "(IILjava/lang/String;)V", Java_com_sun_midp_log_LoggingBase_report),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_main_CldcPlatformRequest_natives[] = {
  JVM_NATIVE("dispatchPlatformRequest","(Ljava/lang/String;)Z", Java_com_sun_midp_main_CldcPlatformRequest_dispatchPlatformRequest),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_main_CommandState_natives[] = {
  JVM_NATIVE("exitInternal",  "(I)V",                  Java_com_sun_midp_main_CommandState_exitInternal),
  JVM_NATIVE("restoreCommandState","(Lcom/sun/midp/main/CommandState;)V", Java_com_sun_midp_main_CommandState_restoreCommandState),
  JVM_NATIVE("saveCommandState","(Lcom/sun/midp/main/CommandState;)V", Java_com_sun_midp_main_CommandState_saveCommandState),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_main_Configuration_natives[] = {
  JVM_NATIVE("getProperty0",  "(Ljava/lang/String;)Ljava/lang/String;", Java_com_sun_midp_main_Configuration_getProperty0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_main_MIDletAppImageGenerator_natives[] = {
  JVM_NATIVE("removeAppImage","(Ljava/lang/String;)Z", Java_com_sun_midp_main_MIDletAppImageGenerator_removeAppImage),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_main_MIDletProxyList_natives[] = {
  JVM_NATIVE("notifyResumeAll0","()V",                   Java_com_sun_midp_main_MIDletProxyList_notifyResumeAll0),
  JVM_NATIVE("notifySuspendAll0","()V",                   Java_com_sun_midp_main_MIDletProxyList_notifySuspendAll0),
  JVM_NATIVE("resetForegroundInNativeState","()V",                   Java_com_sun_midp_main_MIDletProxyList_resetForegroundInNativeState),
  JVM_NATIVE("setForegroundInNativeState","(II)V",                 Java_com_sun_midp_main_MIDletProxyList_setForegroundInNativeState),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_main_MIDletProxyUtils_natives[] = {
  JVM_NATIVE("requestVMStop", "()V",                   Java_com_sun_midp_main_MIDletProxyUtils_requestVMStop),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_main_MIDletSuiteUtils_natives[] = {
  JVM_NATIVE("getAmsIsolateId","()I",                   Java_com_sun_midp_main_MIDletSuiteUtils_getAmsIsolateId),
  JVM_NATIVE("getIsolateId",  "()I",                   Java_com_sun_midp_main_MIDletSuiteUtils_getIsolateId),
  JVM_NATIVE("getMaxIsolates","()I",                   Java_com_sun_midp_main_MIDletSuiteUtils_getMaxIsolates),
  JVM_NATIVE("isAmsIsolate",  "()Z",                   Java_com_sun_midp_main_MIDletSuiteUtils_isAmsIsolate),
  JVM_NATIVE("registerAmsIsolateId","()V",                   Java_com_sun_midp_main_MIDletSuiteUtils_registerAmsIsolateId),
  JVM_NATIVE("vmBeginStartUp","(I)V",                  Java_com_sun_midp_main_MIDletSuiteUtils_vmBeginStartUp),
  JVM_NATIVE("vmEndStartUp",  "(I)V",                  Java_com_sun_midp_main_MIDletSuiteUtils_vmEndStartUp),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_main_MIDletSuiteVerifier_natives[] = {
  JVM_NATIVE("checkJarHash",  "(Ljava/lang/String;[B)Z", Java_com_sun_midp_main_MIDletSuiteVerifier_checkJarHash),
  JVM_NATIVE("getJarHash",    "(Ljava/lang/String;)[B", Java_com_sun_midp_main_MIDletSuiteVerifier_getJarHash),
  JVM_NATIVE("useClassVerifier","(Z)V",                  Java_com_sun_midp_main_MIDletSuiteVerifier_useClassVerifier),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_midletsuite_InstallInfo_natives[] = {
  JVM_NATIVE("load",          "()V",                   Java_com_sun_midp_midletsuite_InstallInfo_load),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_midletsuite_MIDletSuiteImpl_natives[] = {
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_midletsuite_MIDletSuiteImpl_finalize),
  JVM_NATIVE("lockMIDletSuite","(IZ)V",                 Java_com_sun_midp_midletsuite_MIDletSuiteImpl_lockMIDletSuite),
  JVM_NATIVE("unlockMIDletSuite","(I)V",                  Java_com_sun_midp_midletsuite_MIDletSuiteImpl_unlockMIDletSuite),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_midletsuite_MIDletSuiteStorage_natives[] = {
  JVM_NATIVE("changeStorage", "(II)V",                 Java_com_sun_midp_midletsuite_MIDletSuiteStorage_changeStorage),
  JVM_NATIVE("checkSuitesIntegrity","(ZZ)I",                 Java_com_sun_midp_midletsuite_MIDletSuiteStorage_checkSuitesIntegrity),
  JVM_NATIVE("createSuiteID", "()I",                   Java_com_sun_midp_midletsuite_MIDletSuiteStorage_createSuiteID),
  JVM_NATIVE("disable",       "(I)V",                  Java_com_sun_midp_midletsuite_MIDletSuiteStorage_disable),
  JVM_NATIVE("enable",        "(I)V",                  Java_com_sun_midp_midletsuite_MIDletSuiteStorage_enable),
  JVM_NATIVE("getMIDletSuiteIcon0","(ILjava/lang/String;)[B", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMIDletSuiteIcon0),
  JVM_NATIVE("getMIDletSuiteInfoImpl0","(ILcom/sun/midp/midletsuite/MIDletSuiteInfo;)V", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMIDletSuiteInfoImpl0),
  JVM_NATIVE("getMidletSuiteAppImagePath","(I)Ljava/lang/String;", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteAppImagePath),
  JVM_NATIVE("getMidletSuiteFolderId","(I)I",                  Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteFolderId),
  JVM_NATIVE("getMidletSuiteJarPath","(I)Ljava/lang/String;", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteJarPath),
  JVM_NATIVE("getMidletSuiteStorageId","(I)I",                  Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getMidletSuiteStorageId),
  JVM_NATIVE("getNumberOfSuites","()I",                   Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getNumberOfSuites),
  JVM_NATIVE("getSecureFilenameBase","(I)Ljava/lang/String;", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSecureFilenameBase),
  JVM_NATIVE("getStorageUsed","(I)I",                  Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getStorageUsed),
  JVM_NATIVE("getSuiteID",    "(Ljava/lang/String;Ljava/lang/String;)I", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSuiteID),
  JVM_NATIVE("getSuiteList",  "([I)V",                 Java_com_sun_midp_midletsuite_MIDletSuiteStorage_getSuiteList),
  JVM_NATIVE("loadCachedIcon0","(ILjava/lang/String;)[B", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_loadCachedIcon0),
  JVM_NATIVE("loadSuitesIcons0","()I",                   Java_com_sun_midp_midletsuite_MIDletSuiteStorage_loadSuitesIcons0),
  JVM_NATIVE("moveSuiteToFolder","(II)V",                 Java_com_sun_midp_midletsuite_MIDletSuiteStorage_moveSuiteToFolder),
  JVM_NATIVE("nativeStoreSuite","(Lcom/sun/midp/midletsuite/InstallInfo;Lcom/sun/midp/midletsuite/SuiteSettings;Lcom/sun/midp/midletsuite/MIDletSuiteInfo;Ljava/lang/Object;[Ljava/lang/String;[Ljava/lang/String;)V", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_nativeStoreSuite),
  JVM_NATIVE("remove0",       "(I)V",                  Java_com_sun_midp_midletsuite_MIDletSuiteStorage_remove0),
  JVM_NATIVE("storeSuiteVerifyHash","(I[B)V",                Java_com_sun_midp_midletsuite_MIDletSuiteStorage_storeSuiteVerifyHash),
  JVM_NATIVE("suiteExists",   "(I)Z",                  Java_com_sun_midp_midletsuite_MIDletSuiteStorage_suiteExists),
  JVM_NATIVE("suiteIdToString","(I)Ljava/lang/String;", Java_com_sun_midp_midletsuite_MIDletSuiteStorage_suiteIdToString),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_midletsuite_SuiteProperties_natives[] = {
  JVM_NATIVE("load",          "()[Ljava/lang/String;", Java_com_sun_midp_midletsuite_SuiteProperties_load),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_midletsuite_SuiteSettings_natives[] = {
  JVM_NATIVE("load",          "()V",                   Java_com_sun_midp_midletsuite_SuiteSettings_load),
  JVM_NATIVE("save0",         "(IBI[B)V",              Java_com_sun_midp_midletsuite_SuiteSettings_save0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_rms_RecordStoreFactory_natives[] = {
  JVM_NATIVE("suiteHasRmsData0","(Ljava/lang/String;)Z", Java_com_sun_midp_rms_RecordStoreFactory_suiteHasRmsData0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_rms_RecordStoreFile_natives[] = {
  JVM_NATIVE("closeFile",     "(I)V",                  Java_com_sun_midp_rms_RecordStoreFile_closeFile),
  JVM_NATIVE("commitWrite",   "(I)V",                  Java_com_sun_midp_rms_RecordStoreFile_commitWrite),
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_rms_RecordStoreFile_finalize),
  JVM_NATIVE("getNumberOfStores","(Ljava/lang/String;)I", Java_com_sun_midp_rms_RecordStoreFile_getNumberOfStores),
  JVM_NATIVE("getRecordStoreList","(Ljava/lang/String;[Ljava/lang/String;)V", Java_com_sun_midp_rms_RecordStoreFile_getRecordStoreList),
  JVM_NATIVE("openRecordStoreFile","(Ljava/lang/String;Ljava/lang/String;I)I", Java_com_sun_midp_rms_RecordStoreFile_openRecordStoreFile),
  JVM_NATIVE("readBytes",     "(I[BII)I",              Java_com_sun_midp_rms_RecordStoreFile_readBytes),
  JVM_NATIVE("removeRecordStores0","(Ljava/lang/String;)V", Java_com_sun_midp_rms_RecordStoreFile_removeRecordStores0),
  JVM_NATIVE("setPosition",   "(II)V",                 Java_com_sun_midp_rms_RecordStoreFile_setPosition),
  JVM_NATIVE("spaceAvailableNewRecordStore0","(Ljava/lang/String;I)I", Java_com_sun_midp_rms_RecordStoreFile_spaceAvailableNewRecordStore0),
  JVM_NATIVE("spaceAvailableRecordStore","(ILjava/lang/String;I)I", Java_com_sun_midp_rms_RecordStoreFile_spaceAvailableRecordStore),
  JVM_NATIVE("truncateFile",  "(II)V",                 Java_com_sun_midp_rms_RecordStoreFile_truncateFile),
  JVM_NATIVE("writeBytes",    "(I[BII)V",              Java_com_sun_midp_rms_RecordStoreFile_writeBytes),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_rms_RecordStoreRegistry_natives[] = {
  JVM_NATIVE("acknowledgeNotificationsDelivery","(I)V",                  Java_com_sun_midp_rms_RecordStoreRegistry_acknowledgeNotificationsDelivery),
  JVM_NATIVE("getRecordStoreListeners","(ILjava/lang/String;)[I", Java_com_sun_midp_rms_RecordStoreRegistry_getRecordStoreListeners),
  JVM_NATIVE("resetNotificationCounter","(I)V",                  Java_com_sun_midp_rms_RecordStoreRegistry_resetNotificationCounter),
  JVM_NATIVE("sendRecordStoreChangeEvent","(ILjava/lang/String;II)V", Java_com_sun_midp_rms_RecordStoreRegistry_sendRecordStoreChangeEvent),
  JVM_NATIVE("startRecordStoreListening","(ILjava/lang/String;)V", Java_com_sun_midp_rms_RecordStoreRegistry_startRecordStoreListening),
  JVM_NATIVE("stopAllRecordStoreListeners","(I)V",                  Java_com_sun_midp_rms_RecordStoreRegistry_stopAllRecordStoreListeners),
  JVM_NATIVE("stopRecordStoreListening","(ILjava/lang/String;)V", Java_com_sun_midp_rms_RecordStoreRegistry_stopRecordStoreListening),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_rms_RecordStoreSharedDBHeader_natives[] = {
  JVM_NATIVE("cleanup0",      "()V",                   Java_com_sun_midp_rms_RecordStoreSharedDBHeader_cleanup0),
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_rms_RecordStoreSharedDBHeader_finalize),
  JVM_NATIVE("getHeaderRefCount0","(I)I",                  Java_com_sun_midp_rms_RecordStoreSharedDBHeader_getHeaderRefCount0),
  JVM_NATIVE("getLookupId0",  "(ILjava/lang/String;I)I", Java_com_sun_midp_rms_RecordStoreSharedDBHeader_getLookupId0),
  JVM_NATIVE("shareCachedData0","(I[BI)I",               Java_com_sun_midp_rms_RecordStoreSharedDBHeader_shareCachedData0),
  JVM_NATIVE("updateCachedData0","(I[BII)I",              Java_com_sun_midp_rms_RecordStoreSharedDBHeader_updateCachedData0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_rms_RecordStoreUtil_natives[] = {
  JVM_NATIVE("deleteFile",    "(Ljava/lang/String;Ljava/lang/String;I)V", Java_com_sun_midp_rms_RecordStoreUtil_deleteFile),
  JVM_NATIVE("exists",        "(Ljava/lang/String;Ljava/lang/String;I)Z", Java_com_sun_midp_rms_RecordStoreUtil_exists),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_security_Permissions_natives[] = {
  JVM_NATIVE("getDefaultValue","(Ljava/lang/String;Ljava/lang/String;)B", Java_com_sun_midp_security_Permissions_getDefaultValue),
  JVM_NATIVE("getGroupMessages","(Ljava/lang/String;)[Ljava/lang/String;", Java_com_sun_midp_security_Permissions_getGroupMessages),
  JVM_NATIVE("getMaxValue",   "(Ljava/lang/String;Ljava/lang/String;)B", Java_com_sun_midp_security_Permissions_getMaxValue),
  JVM_NATIVE("loadDomainList","()[Ljava/lang/String;", Java_com_sun_midp_security_Permissions_loadDomainList),
  JVM_NATIVE("loadGroupList", "()[Ljava/lang/String;", Java_com_sun_midp_security_Permissions_loadGroupList),
  JVM_NATIVE("loadGroupPermissions","(Ljava/lang/String;)[Ljava/lang/String;", Java_com_sun_midp_security_Permissions_loadGroupPermissions),
  JVM_NATIVE("loadingFinished","()V",                   Java_com_sun_midp_security_Permissions_loadingFinished),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_suspend_SuspendSystem_natives[] = {
  JVM_NATIVE("isResumePending","()Z",                   Java_com_sun_midp_suspend_SuspendSystem_isResumePending),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_suspend_SuspendSystem_MIDPSystem_natives[] = {
  JVM_NATIVE("allMidletsKilled","()Z",                   Java_com_sun_midp_suspend_SuspendSystem_00024MIDPSystem_allMidletsKilled),
  JVM_NATIVE("suspended0",    "(Z)V",                  Java_com_sun_midp_suspend_SuspendSystem_00024MIDPSystem_suspended0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_util_ResourceHandler_natives[] = {
  JVM_NATIVE("loadRomizedResource0","(Ljava/lang/String;)[B", Java_com_sun_midp_util_ResourceHandler_loadRomizedResource0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction com_sun_midp_util_isolate_InterIsolateMutex_natives[] = {
  JVM_NATIVE("finalize",      "()V",                   Java_com_sun_midp_util_isolate_InterIsolateMutex_finalize),
  JVM_NATIVE("getID0",        "(Ljava/lang/String;)I", Java_com_sun_midp_util_isolate_InterIsolateMutex_getID0),
  JVM_NATIVE("lock0",         "(I)V",                  Java_com_sun_midp_util_isolate_InterIsolateMutex_lock0),
  JVM_NATIVE("unlock0",       "(I)V",                  Java_com_sun_midp_util_isolate_InterIsolateMutex_unlock0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Class_natives[] = {
  JVM_NATIVE("forName",       "(Ljava/lang/String;)Ljava/lang/Class;", Java_java_lang_Class_forName),
  JVM_NATIVE("getName",       "()Ljava/lang/String;",  Java_java_lang_Class_getName),
  JVM_NATIVE("getSuperclass", "()Ljava/lang/Class;",   Java_java_lang_Class_getSuperclass),
  JVM_NATIVE("init9",         "()V",                   Java_java_lang_Class_init9),
  JVM_NATIVE("invoke_clinit", "()V",                   Java_java_lang_Class_invoke_1clinit),
  JVM_NATIVE("invoke_verify", "()V",                   Java_java_lang_Class_invoke_1verify),
  JVM_NATIVE("isArray",       "()Z",                   Java_java_lang_Class_isArray),
  JVM_NATIVE("isAssignableFrom","(Ljava/lang/Class;)Z",  Java_java_lang_Class_isAssignableFrom),
  JVM_NATIVE("isInstance",    "(Ljava/lang/Object;)Z", Java_java_lang_Class_isInstance),
  JVM_NATIVE("isInterface",   "()Z",                   Java_java_lang_Class_isInterface),
  JVM_NATIVE("newInstance",   "()Ljava/lang/Object;",  Java_java_lang_Class_newInstance),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Double_natives[] = {
  JVM_NATIVE("doubleToLongBits","(D)J",                  Java_java_lang_Double_doubleToLongBits),
  JVM_NATIVE("longBitsToDouble","(J)D",                  Java_java_lang_Double_longBitsToDouble),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Float_natives[] = {
  JVM_NATIVE("floatToIntBits","(F)I",                  Java_java_lang_Float_floatToIntBits),
  JVM_NATIVE("intBitsToFloat","(I)F",                  Java_java_lang_Float_intBitsToFloat),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Integer_entries[] = {
  JVM_ENTRY("toString",            "(I)Ljava/lang/String;", native_integer_toString_entry),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Math_entries[] = {
  JVM_ENTRY("ceil",                "(D)D", native_math_ceil_entry),
  JVM_ENTRY("cos",                 "(D)D", native_math_cos_entry),
  JVM_ENTRY("floor",               "(D)D", native_math_floor_entry),
  JVM_ENTRY("sin",                 "(D)D", native_math_sin_entry),
  JVM_ENTRY("sqrt",                "(D)D", native_math_sqrt_entry),
  JVM_ENTRY("tan",                 "(D)D", native_math_tan_entry),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Object_natives[] = {
  JVM_NATIVE("getClass",      "()Ljava/lang/Class;",   Java_java_lang_Object_getClass),
  JVM_NATIVE("hashCode",      "()I",                   Java_java_lang_Object_hashCode),
  JVM_NATIVE("notify",        "()V",                   Java_java_lang_Object_notify),
  JVM_NATIVE("notifyAll",     "()V",                   Java_java_lang_Object_notifyAll),
  JVM_NATIVE("wait",          "(J)V",                  Java_java_lang_Object_wait),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Runtime_natives[] = {
  JVM_NATIVE("exitInternal",  "(I)V",                  Java_java_lang_Runtime_exitInternal),
  JVM_NATIVE("freeMemory",    "()J",                   Java_java_lang_Runtime_freeMemory),
  JVM_NATIVE("gc",            "()V",                   Java_java_lang_Runtime_gc),
  JVM_NATIVE("totalMemory",   "()J",                   Java_java_lang_Runtime_totalMemory),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_String_natives[] = {
  JVM_NATIVE("hashCode",      "()I",                   Java_java_lang_String_hashCode),
  JVM_NATIVE("intern",        "()Ljava/lang/String;",  Java_java_lang_String_intern),
  JVM_NATIVE("lastIndexOf",   "(I)I",                  Java_java_lang_String_lastIndexOf__I),
  JVM_NATIVE("lastIndexOf",   "(II)I",                 Java_java_lang_String_lastIndexOf__II),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_String_entries[] = {
  JVM_ENTRY("<init>",              "(Ljava/lang/StringBuffer;)V", native_string_init_entry),
  JVM_ENTRY("charAt",              "(I)C", native_string_charAt_entry),
  JVM_ENTRY("endsWith",            "(Ljava/lang/String;)Z", native_string_endsWith_entry),
  JVM_ENTRY("equals",              "(Ljava/lang/Object;)Z", native_string_equals_entry),
  JVM_ENTRY("indexOf",             "(I)I", native_string_indexof0_entry),
  JVM_ENTRY("indexOf",             "(II)I", native_string_indexof_entry),
  JVM_ENTRY("indexOf",             "(Ljava/lang/String;)I", native_string_indexof0_string_entry),
  JVM_ENTRY("indexOf",             "(Ljava/lang/String;I)I", native_string_indexof_string_entry),
  JVM_ENTRY("startsWith",          "(Ljava/lang/String;)Z", native_string_startsWith0_entry),
  JVM_ENTRY("startsWith",          "(Ljava/lang/String;I)Z", native_string_startsWith_entry),
  JVM_ENTRY("substring",           "(I)Ljava/lang/String;", native_string_substringI_entry),
  JVM_ENTRY("substring",           "(II)Ljava/lang/String;", native_string_substringII_entry),
  JVM_ENTRY("valueOf",             "(I)Ljava/lang/String;", native_integer_toString_entry),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_StringBuffer_entries[] = {
  JVM_ENTRY("append",              "(C)Ljava/lang/StringBuffer;", native_stringbuffer_append_entry),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_System_natives[] = {
  JVM_NATIVE("arraycopy",     "(Ljava/lang/Object;ILjava/lang/Object;II)V", Java_java_lang_System_arraycopy),
  JVM_NATIVE("currentTimeMillis","()J",                   Java_java_lang_System_currentTimeMillis),
  JVM_NATIVE("getProperty0",  "(Ljava/lang/String;)Ljava/lang/String;", Java_java_lang_System_getProperty0),
  JVM_NATIVE("identityHashCode","(Ljava/lang/Object;)I", Java_java_lang_System_identityHashCode),
  JVM_NATIVE("quickNativeThrow","()V",                   Java_java_lang_System_quickNativeThrow),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_System_entries[] = {
  JVM_ENTRY("arraycopy",           "(Ljava/lang/Object;ILjava/lang/Object;II)V", native_system_arraycopy_entry),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Thread_natives[] = {
  JVM_NATIVE("activeCount",   "()I",                   Java_java_lang_Thread_activeCount),
  JVM_NATIVE("currentThread", "()Ljava/lang/Thread;",  Java_java_lang_Thread_currentThread),
  JVM_NATIVE("internalExit",  "()V",                   Java_java_lang_Thread_internalExit),
  JVM_NATIVE("interrupt0",    "()V",                   Java_java_lang_Thread_interrupt0),
  JVM_NATIVE("isAlive",       "()Z",                   Java_java_lang_Thread_isAlive),
  JVM_NATIVE("setPriority0",  "(II)V",                 Java_java_lang_Thread_setPriority0),
  JVM_NATIVE("sleep",         "(J)V",                  Java_java_lang_Thread_sleep),
  JVM_NATIVE("start0",        "()V",                   Java_java_lang_Thread_start0),
  JVM_NATIVE("yield",         "()V",                   Java_java_lang_Thread_yield),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_Throwable_natives[] = {
  JVM_NATIVE("fillInStackTrace","()V",                   Java_java_lang_Throwable_fillInStackTrace),
  JVM_NATIVE("printStackTrace","()V",                   Java_java_lang_Throwable_printStackTrace),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_lang_ref_WeakReference_natives[] = {
  JVM_NATIVE("clear",         "()V",                   Java_java_lang_ref_WeakReference_clear),
  JVM_NATIVE("finalize",      "()V",                   Java_java_lang_ref_WeakReference_finalize),
  JVM_NATIVE("get",           "()Ljava/lang/Object;",  Java_java_lang_ref_WeakReference_get),
  JVM_NATIVE("initializeWeakReference","(Ljava/lang/Object;)V", Java_java_lang_ref_WeakReference_initializeWeakReference),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction java_util_Vector_entries[] = {
  JVM_ENTRY("addElement",          "(Ljava/lang/Object;)V", native_vector_addElement_entry),
  JVM_ENTRY("elementAt",           "(I)Ljava/lang/Object;", native_vector_elementAt_entry),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction javax_microedition_lcdui_Display_natives[] = {
  JVM_NATIVE("drawTrustedIcon0","(IZ)V",                 Java_javax_microedition_lcdui_Display_drawTrustedIcon0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction javax_microedition_lcdui_Font_natives[] = {
  JVM_NATIVE("charWidth",     "(C)I",                  Java_javax_microedition_lcdui_Font_charWidth),
  JVM_NATIVE("charsWidth",    "([CII)I",               Java_javax_microedition_lcdui_Font_charsWidth),
  JVM_NATIVE("init",          "(III)V",                Java_javax_microedition_lcdui_Font_init),
  JVM_NATIVE("stringWidth",   "(Ljava/lang/String;)I", Java_javax_microedition_lcdui_Font_stringWidth),
  JVM_NATIVE("substringWidth","(Ljava/lang/String;II)I", Java_javax_microedition_lcdui_Font_substringWidth),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction javax_microedition_lcdui_Graphics_natives[] = {
  JVM_NATIVE("doCopyArea",    "(IIIIIII)V",            Java_javax_microedition_lcdui_Graphics_doCopyArea),
  JVM_NATIVE("drawArc",       "(IIIIII)V",             Java_javax_microedition_lcdui_Graphics_drawArc),
  JVM_NATIVE("drawChar",      "(CIII)V",               Java_javax_microedition_lcdui_Graphics_drawChar),
  JVM_NATIVE("drawChars",     "([CIIIII)V",            Java_javax_microedition_lcdui_Graphics_drawChars),
  JVM_NATIVE("drawLine",      "(IIII)V",               Java_javax_microedition_lcdui_Graphics_drawLine),
  JVM_NATIVE("drawRGB",       "([IIIIIIIZ)V",          Java_javax_microedition_lcdui_Graphics_drawRGB),
  JVM_NATIVE("drawRect",      "(IIII)V",               Java_javax_microedition_lcdui_Graphics_drawRect),
  JVM_NATIVE("drawRoundRect", "(IIIIII)V",             Java_javax_microedition_lcdui_Graphics_drawRoundRect),
  JVM_NATIVE("drawString",    "(Ljava/lang/String;III)V", Java_javax_microedition_lcdui_Graphics_drawString),
  JVM_NATIVE("drawSubstring", "(Ljava/lang/String;IIIII)V", Java_javax_microedition_lcdui_Graphics_drawSubstring),
  JVM_NATIVE("fillArc",       "(IIIIII)V",             Java_javax_microedition_lcdui_Graphics_fillArc),
  JVM_NATIVE("fillRect",      "(IIII)V",               Java_javax_microedition_lcdui_Graphics_fillRect),
  JVM_NATIVE("fillRoundRect", "(IIIIII)V",             Java_javax_microedition_lcdui_Graphics_fillRoundRect),
  JVM_NATIVE("fillTriangle",  "(IIIIII)V",             Java_javax_microedition_lcdui_Graphics_fillTriangle),
  JVM_NATIVE("getDisplayColor","(I)I",                  Java_javax_microedition_lcdui_Graphics_getDisplayColor),
  JVM_NATIVE("getPixel",      "(IIZ)I",                Java_javax_microedition_lcdui_Graphics_getPixel),
  JVM_NATIVE("render",        "(Ljavax/microedition/lcdui/Image;III)Z", Java_javax_microedition_lcdui_Graphics_render),
  JVM_NATIVE("renderRegion",  "(Ljavax/microedition/lcdui/Image;IIIIIIII)Z", Java_javax_microedition_lcdui_Graphics_renderRegion),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction javax_microedition_lcdui_ImageData_natives[] = {
  JVM_NATIVE("getRGB",        "([IIIIIII)V",           Java_javax_microedition_lcdui_ImageData_getRGB),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction javax_microedition_lcdui_ImageDataFactory_natives[] = {
  JVM_NATIVE("loadJPEG",      "(Ljavax/microedition/lcdui/ImageData;[BII)V", Java_javax_microedition_lcdui_ImageDataFactory_loadJPEG),
  JVM_NATIVE("loadPNG",       "(Ljavax/microedition/lcdui/ImageData;[BII)Z", Java_javax_microedition_lcdui_ImageDataFactory_loadPNG),
  JVM_NATIVE("loadRAW",       "(Ljavax/microedition/lcdui/ImageData;[BII)V", Java_javax_microedition_lcdui_ImageDataFactory_loadRAW),
  JVM_NATIVE("loadRGB",       "(Ljavax/microedition/lcdui/ImageData;[I)V", Java_javax_microedition_lcdui_ImageDataFactory_loadRGB),
  JVM_NATIVE("loadRegion",    "(Ljavax/microedition/lcdui/ImageData;Ljavax/microedition/lcdui/ImageData;IIIII)V", Java_javax_microedition_lcdui_ImageDataFactory_loadRegion),
  JVM_NATIVE("loadRomizedImage","(Ljavax/microedition/lcdui/ImageData;II)Z", Java_javax_microedition_lcdui_ImageDataFactory_loadRomizedImage),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction javax_microedition_lcdui_KeyConverter_natives[] = {
  JVM_NATIVE("getGameAction", "(I)I",                  Java_javax_microedition_lcdui_KeyConverter_getGameAction),
  JVM_NATIVE("getKeyCode",    "(I)I",                  Java_javax_microedition_lcdui_KeyConverter_getKeyCode),
  JVM_NATIVE("getKeyName",    "(I)Ljava/lang/String;", Java_javax_microedition_lcdui_KeyConverter_getKeyName),
  JVM_NATIVE("getSystemKey",  "(I)I",                  Java_javax_microedition_lcdui_KeyConverter_getSystemKey),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction javax_microedition_lcdui_SuiteImageCacheImpl_natives[] = {
  JVM_NATIVE("loadAndCreateImmutableImageDataFromCache0","(Ljavax/microedition/lcdui/ImageData;ILjava/lang/String;)Z", Java_javax_microedition_lcdui_SuiteImageCacheImpl_loadAndCreateImmutableImageDataFromCache0),
  {(char*)0, (char*)0, (void*)0}
};

static const JvmNativeFunction javax_microedition_lcdui_game_GameCanvas_natives[] = {
  JVM_NATIVE("setSuppressKeyEvents","(Ljavax/microedition/lcdui/Canvas;Z)V", Java_javax_microedition_lcdui_game_GameCanvas_setSuppressKeyEvents),
  {(char*)0, (char*)0, (void*)0}
};

const JvmNativesTable jvm_natives_table[] = {
  JVM_TABLE("com/sun/cldc/i18n/j2me/Conv",
                                        com_sun_cldc_i18n_j2me_Conv_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/cldc/io/ResourceInputStream",
                                        com_sun_cldc_io_ResourceInputStream_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/cldc/isolate/Isolate",
                                        com_sun_cldc_isolate_Isolate_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/cldc/util/SemaphoreLock",
                                        com_sun_cldc_util_SemaphoreLock_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/cldchi/io/ConsoleOutputStream",
                                        com_sun_cldchi_io_ConsoleOutputStream_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/cldchi/jvm/FileDescriptor",
                                        com_sun_cldchi_jvm_FileDescriptor_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/cldchi/jvm/JVM",
                                        com_sun_cldchi_jvm_JVM_natives,
                                        com_sun_cldchi_jvm_JVM_entries),
  JVM_TABLE("com/sun/j2mewp/media/AudioPlayer",
                                        com_sun_j2mewp_media_AudioPlayer_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/j2mewp/media/DeviceHw",
                                        com_sun_j2mewp_media_DeviceHw_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/chameleon/input/InputModeFactory",
                                        com_sun_midp_chameleon_input_InputModeFactory_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/chameleon/input/NativeInputMode",
                                        com_sun_midp_chameleon_input_NativeInputMode_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/chameleon/layers/SoftButtonLayer",
                                        com_sun_midp_chameleon_layers_SoftButtonLayer_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/chameleon/skins/resources/LoadedSkinData",
                                        com_sun_midp_chameleon_skins_resources_LoadedSkinData_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/chameleon/skins/resources/LoadedSkinResources",
                                        com_sun_midp_chameleon_skins_resources_LoadedSkinResources_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/chameleon/skins/resources/SkinResourcesImpl",
                                        com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/crypto/MD2",
                                        com_sun_midp_crypto_MD2_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/crypto/MD5",
                                        com_sun_midp_crypto_MD5_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/crypto/PRand",
                                        com_sun_midp_crypto_PRand_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/crypto/SHA",
                                        com_sun_midp_crypto_SHA_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/events/EventQueue",
                                        com_sun_midp_events_EventQueue_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/events/NativeEventMonitor",
                                        com_sun_midp_events_NativeEventMonitor_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/installer/OtaNotifier",
                                        com_sun_midp_installer_OtaNotifier_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/io/NetworkConnectionBase",
                                        com_sun_midp_io_NetworkConnectionBase_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/io/j2me/comm/Protocol",
                                        com_sun_midp_io_j2me_comm_Protocol_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/io/j2me/datagram/Protocol",
                                        com_sun_midp_io_j2me_datagram_Protocol_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/io/j2me/push/ConnectionRegistry",
                                        com_sun_midp_io_j2me_push_ConnectionRegistry_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/io/j2me/serversocket/Socket",
                                        com_sun_midp_io_j2me_serversocket_Socket_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/io/j2me/socket/Protocol",
                                        com_sun_midp_io_j2me_socket_Protocol_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/io/j2me/storage/File",
                                        com_sun_midp_io_j2me_storage_File_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/io/j2me/storage/RandomAccessStream",
                                        com_sun_midp_io_j2me_storage_RandomAccessStream_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/jarutil/JarReader",
                                        com_sun_midp_jarutil_JarReader_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/l10n/LocalizedStringsBase",
                                        com_sun_midp_l10n_LocalizedStringsBase_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/lcdui/DisplayDevice",
                                        com_sun_midp_lcdui_DisplayDevice_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/lcdui/DisplayDeviceAccess",
                                        com_sun_midp_lcdui_DisplayDeviceAccess_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/lcdui/DisplayDeviceContainer",
                                        com_sun_midp_lcdui_DisplayDeviceContainer_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/log/Logging",
                                        com_sun_midp_log_Logging_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/log/LoggingBase",
                                        com_sun_midp_log_LoggingBase_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/main/CldcPlatformRequest",
                                        com_sun_midp_main_CldcPlatformRequest_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/main/CommandState",
                                        com_sun_midp_main_CommandState_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/main/Configuration",
                                        com_sun_midp_main_Configuration_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/main/MIDletAppImageGenerator",
                                        com_sun_midp_main_MIDletAppImageGenerator_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/main/MIDletProxyList",
                                        com_sun_midp_main_MIDletProxyList_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/main/MIDletProxyUtils",
                                        com_sun_midp_main_MIDletProxyUtils_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/main/MIDletSuiteUtils",
                                        com_sun_midp_main_MIDletSuiteUtils_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/main/MIDletSuiteVerifier",
                                        com_sun_midp_main_MIDletSuiteVerifier_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/midletsuite/InstallInfo",
                                        com_sun_midp_midletsuite_InstallInfo_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/midletsuite/MIDletSuiteImpl",
                                        com_sun_midp_midletsuite_MIDletSuiteImpl_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/midletsuite/MIDletSuiteStorage",
                                        com_sun_midp_midletsuite_MIDletSuiteStorage_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/midletsuite/SuiteProperties",
                                        com_sun_midp_midletsuite_SuiteProperties_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/midletsuite/SuiteSettings",
                                        com_sun_midp_midletsuite_SuiteSettings_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/rms/RecordStoreFactory",
                                        com_sun_midp_rms_RecordStoreFactory_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/rms/RecordStoreFile",
                                        com_sun_midp_rms_RecordStoreFile_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/rms/RecordStoreRegistry",
                                        com_sun_midp_rms_RecordStoreRegistry_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/rms/RecordStoreSharedDBHeader",
                                        com_sun_midp_rms_RecordStoreSharedDBHeader_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/rms/RecordStoreUtil",
                                        com_sun_midp_rms_RecordStoreUtil_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/security/Permissions",
                                        com_sun_midp_security_Permissions_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/suspend/SuspendSystem",
                                        com_sun_midp_suspend_SuspendSystem_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/suspend/SuspendSystem$MIDPSystem",
                                        com_sun_midp_suspend_SuspendSystem_MIDPSystem_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/util/ResourceHandler",
                                        com_sun_midp_util_ResourceHandler_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("com/sun/midp/util/isolate/InterIsolateMutex",
                                        com_sun_midp_util_isolate_InterIsolateMutex_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/lang/Class",
                                        java_lang_Class_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/lang/Double",
                                        java_lang_Double_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/lang/Float",
                                        java_lang_Float_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/lang/Integer",
                                        (JvmNativeFunction*)0,
                                        java_lang_Integer_entries),
  JVM_TABLE("java/lang/Math",
                                        (JvmNativeFunction*)0,
                                        java_lang_Math_entries),
  JVM_TABLE("java/lang/Object",
                                        java_lang_Object_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/lang/Runtime",
                                        java_lang_Runtime_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/lang/String",
                                        java_lang_String_natives,
                                        java_lang_String_entries),
  JVM_TABLE("java/lang/StringBuffer",
                                        (JvmNativeFunction*)0,
                                        java_lang_StringBuffer_entries),
  JVM_TABLE("java/lang/System",
                                        java_lang_System_natives,
                                        java_lang_System_entries),
  JVM_TABLE("java/lang/Thread",
                                        java_lang_Thread_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/lang/Throwable",
                                        java_lang_Throwable_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/lang/ref/WeakReference",
                                        java_lang_ref_WeakReference_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("java/util/Vector",
                                        (JvmNativeFunction*)0,
                                        java_util_Vector_entries),
  JVM_TABLE("javax/microedition/lcdui/Display",
                                        javax_microedition_lcdui_Display_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("javax/microedition/lcdui/Font",
                                        javax_microedition_lcdui_Font_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("javax/microedition/lcdui/Graphics",
                                        javax_microedition_lcdui_Graphics_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("javax/microedition/lcdui/ImageData",
                                        javax_microedition_lcdui_ImageData_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("javax/microedition/lcdui/ImageDataFactory",
                                        javax_microedition_lcdui_ImageDataFactory_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("javax/microedition/lcdui/KeyConverter",
                                        javax_microedition_lcdui_KeyConverter_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("javax/microedition/lcdui/SuiteImageCacheImpl",
                                        javax_microedition_lcdui_SuiteImageCacheImpl_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE("javax/microedition/lcdui/game/GameCanvas",
                                        javax_microedition_lcdui_game_GameCanvas_natives,
                                        (JvmNativeFunction*)0),
  JVM_TABLE((char*)0, (JvmNativeFunction*)0, (JvmNativeFunction*)0)
};
const JvmExecutionEntry jvm_api_entries[] = {
{(unsigned char*)&native_jvm_unchecked_byte_arraycopy_entry,
(char*)"native_jvm_unchecked_byte_arraycopy_entry"},
{(unsigned char*)&native_jvm_unchecked_char_arraycopy_entry,
(char*)"native_jvm_unchecked_char_arraycopy_entry"},
{(unsigned char*)&native_jvm_unchecked_int_arraycopy_entry,
(char*)"native_jvm_unchecked_int_arraycopy_entry"},
{(unsigned char*)&native_jvm_unchecked_long_arraycopy_entry,
(char*)"native_jvm_unchecked_long_arraycopy_entry"},
{(unsigned char*)&native_jvm_unchecked_obj_arraycopy_entry,
(char*)"native_jvm_unchecked_obj_arraycopy_entry"},
{(unsigned char*)&native_integer_toString_entry,
(char*)"native_integer_toString_entry"},
{(unsigned char*)&native_math_ceil_entry,
(char*)"native_math_ceil_entry"},
{(unsigned char*)&native_math_cos_entry,
(char*)"native_math_cos_entry"},
{(unsigned char*)&native_math_floor_entry,
(char*)"native_math_floor_entry"},
{(unsigned char*)&native_math_sin_entry,
(char*)"native_math_sin_entry"},
{(unsigned char*)&native_math_sqrt_entry,
(char*)"native_math_sqrt_entry"},
{(unsigned char*)&native_math_tan_entry,
(char*)"native_math_tan_entry"},
{(unsigned char*)&native_string_init_entry,
(char*)"native_string_init_entry"},
{(unsigned char*)&native_string_charAt_entry,
(char*)"native_string_charAt_entry"},
{(unsigned char*)&native_string_endsWith_entry,
(char*)"native_string_endsWith_entry"},
{(unsigned char*)&native_string_equals_entry,
(char*)"native_string_equals_entry"},
{(unsigned char*)&native_string_indexof0_entry,
(char*)"native_string_indexof0_entry"},
{(unsigned char*)&native_string_indexof_entry,
(char*)"native_string_indexof_entry"},
{(unsigned char*)&native_string_indexof0_string_entry,
(char*)"native_string_indexof0_string_entry"},
{(unsigned char*)&native_string_indexof_string_entry,
(char*)"native_string_indexof_string_entry"},
{(unsigned char*)&native_string_startsWith0_entry,
(char*)"native_string_startsWith0_entry"},
{(unsigned char*)&native_string_startsWith_entry,
(char*)"native_string_startsWith_entry"},
{(unsigned char*)&native_string_substringI_entry,
(char*)"native_string_substringI_entry"},
{(unsigned char*)&native_string_substringII_entry,
(char*)"native_string_substringII_entry"},
{(unsigned char*)&native_integer_toString_entry,
(char*)"native_integer_toString_entry"},
{(unsigned char*)&native_stringbuffer_append_entry,
(char*)"native_stringbuffer_append_entry"},
{(unsigned char*)&native_system_arraycopy_entry,
(char*)"native_system_arraycopy_entry"},
{(unsigned char*)&native_vector_addElement_entry,
(char*)"native_vector_addElement_entry"},
{(unsigned char*)&native_vector_elementAt_entry,
(char*)"native_vector_elementAt_entry"},
{(unsigned char*)0, (char*)0}};

#endif
