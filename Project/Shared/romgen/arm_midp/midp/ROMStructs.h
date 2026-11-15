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



#ifndef _ROM_STRUCTS_H_
#define _ROM_STRUCTS_H_

#ifdef __cplusplus
extern "C" {
#endif
#define _ROM_STRUCTS_VERSION_ "internal"

/* Define JVM_LIMIT_OBJECT_FIELD_WRITES=0 if your C
   compiler does not allow the 'const' modifier
   in the ROM structs */
#ifndef JVM_LIMIT_OBJECT_FIELD_WRITES
#define JVM_LIMIT_OBJECT_FIELD_WRITES 0 /* IMPL_NOTE: TMP */
#endif
#if !JVM_LIMIT_OBJECT_FIELD_WRITES
#define JVM_FIELD_CONST
#else
#define JVM_FIELD_CONST const
#endif

typedef struct {
    void * dummy;
    int length;
    jboolean elements[1];
} jboolean_array;
typedef struct {
    void * dummy;
    int length;
    jchar elements[1];
} jchar_array;
typedef struct {
    void * dummy;
    int length;
    jbyte elements[1];
} jbyte_array;
typedef struct {
    void * dummy;
    int length;
    jshort elements[1];
} jshort_array;
typedef struct {
    void * dummy;
    int length;
    jint elements[1];
} jint_array;
typedef struct {
    void * dummy;
    int length;
    jlong elements[1];
} jlong_array;
typedef struct {
    void * dummy;
    int length;
    struct Java_java_lang_Object * JVM_FIELD_CONST elements[1];
} jobject_array;
typedef struct {
    void * dummy;
    int length;
    jfloat elements[1];
} jfloat_array;
typedef struct {
    void * dummy;
    int length;
    jdouble elements[1];
} jdouble_array;

struct Java_java_lang_Object {
    /* java/lang/Object */
	void * __do_not_use__;
};

struct Java_java_lang_String {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/String */
    /*  @4 */	jchar_array * JVM_FIELD_CONST value;
    /*  @8 */	jint offset;
    /* @12 */	jint count;
};

struct Java_java_lang_Class {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Class */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST vmClass;
    /*  @8 */	jint status;
    /* @12 */	struct Java_java_lang_Thread * JVM_FIELD_CONST thread;
};

struct Java_java_lang_StringBuffer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/StringBuffer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST value;
    /*  @8 */	jint count;
    /* @12 */	jboolean shared;
    /* @13 */	jbyte ___pad1;
    /* @14 */	jbyte ___pad2;
    /* @15 */	jbyte ___pad3;
};

struct Java_java_lang_Thread {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Thread */
    /*  @4 */	jint priority;
    /*  @8 */	struct Java_java_lang_Runnable * JVM_FIELD_CONST target;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST vm_thread;
    /* @16 */	jint is_terminated;
    /* @20 */	jint is_stillborn;
    /* @24 */	jchar_array * JVM_FIELD_CONST name;
};

struct Java_java_lang_Throwable {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
};

struct Java_java_lang_Error {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Error */
};

struct Java_java_io_InputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/InputStream */
};

struct Java_java_lang_Runtime {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Runtime */
};

struct Java_java_io_OutputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/OutputStream */
};

struct Java_java_io_PrintStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/OutputStream */
    /* java/io/PrintStream */
    /*  @4 */	struct Java_java_io_OutputStreamWriter * JVM_FIELD_CONST charOut;
    /*  @8 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST byteOut;
    /* @12 */	jboolean trouble;
    /* @13 */	jboolean closing;
    /* @14 */	jbyte ___pad4;
    /* @15 */	jbyte ___pad5;
};

struct Java_java_lang_System {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/System */
};

struct Java_java_lang_Math {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Math */
};

struct Java_com_sun_cldchi_jvm_JVM {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldchi/jvm/JVM */
};

struct Java_com_sun_cldchi_jvm_FileDescriptor {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldchi/jvm/FileDescriptor */
    /*  @4 */	jint handle;
    /*  @8 */	jint valid;
};

struct Java_java_lang_ref_Reference {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/ref/Reference */
};

struct Java_java_lang_ref_WeakReference {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/ref/Reference */
    /* java/lang/ref/WeakReference */
    /*  @4 */	jint referent_index;
};

struct Java_java_lang_VirtualMachineError {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Error */
    /* java/lang/VirtualMachineError */
};

struct Java_java_lang_OutOfMemoryError {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Error */
    /* java/lang/VirtualMachineError */
    /* java/lang/OutOfMemoryError */
};

struct Java_java_lang_Runnable {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Runnable */
};

struct Java_java_lang_Exception {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
};

struct Java_java_lang_RuntimeException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
};

struct Java_java_lang_NullPointerException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/NullPointerException */
};

struct Java_java_lang_IndexOutOfBoundsException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/IndexOutOfBoundsException */
};

struct Java_java_lang_ArrayIndexOutOfBoundsException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/IndexOutOfBoundsException */
    /* java/lang/ArrayIndexOutOfBoundsException */
};

struct Java_java_lang_IllegalMonitorStateException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/IllegalMonitorStateException */
};

struct Java_java_lang_ArithmeticException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/ArithmeticException */
};

struct Java_com_sun_cldc_isolate_Isolate {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/isolate/Isolate */
    /*  @4 */	jint _priority;
    /*  @8 */	struct Java_com_sun_cldc_isolate_Isolate * JVM_FIELD_CONST _next;
    /* @12 */	jlong _uniqueId;
    /* @20 */	jint _terminated;
    /* @24 */	jint _saved_exit_code;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST _mainClass;
    /* @32 */	jobject_array * JVM_FIELD_CONST _mainArgs;
    /* @36 */	jobject_array * JVM_FIELD_CONST _app_classpath;
    /* @40 */	jobject_array * JVM_FIELD_CONST _sys_classpath;
    /* @44 */	jobject_array * JVM_FIELD_CONST _hidden_packages;
    /* @48 */	jobject_array * JVM_FIELD_CONST _restricted_packages;
    /* @52 */	jint _memoryReserve;
    /* @56 */	jint _memoryLimit;
    /* @60 */	jint _APIAccess;
    /* @64 */	jint _ConnectDebugger;
    /* @68 */	jint _UseVerifier;
    /* @72 */	jint _profileId;
    /* @76 */	jint _UseProfiler;
};

struct Java_java_lang_IllegalArgumentException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/IllegalArgumentException */
};

struct Java_java_io_IOException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
};

struct Java_com_sun_cldc_io_ResourceInputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/InputStream */
    /* com/sun/cldc/io/ResourceInputStream */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST fileDecoder;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST savedDecoder;
};

struct Java_java_lang_InterruptedException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/InterruptedException */
};

struct Java_java_lang_NoClassDefFoundError {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Error */
    /* java/lang/NoClassDefFoundError */
};

struct Java_com_sun_cldc_isolate_IsolateResourceError {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Error */
    /* com/sun/cldc/isolate/IsolateResourceError */
};

struct Java_com_sun_cldc_isolate_IsolateStartupException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/cldc/isolate/IsolateStartupException */
};

struct Java_java_lang_SecurityException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/SecurityException */
};

struct Java_com_sun_cldc_isolate_IllegalIsolateStateException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* com/sun/cldc/isolate/IllegalIsolateStateException */
};

struct Java_java_lang_StringIndexOutOfBoundsException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/IndexOutOfBoundsException */
    /* java/lang/StringIndexOutOfBoundsException */
};

struct Java_com_sun_cldc_util_SemaphoreLock {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/util/SemaphoreLock */
    /*  @4 */	jint permits;
};

struct Java_com_sun_cldc_util_Semaphore {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/util/Semaphore */
    /*  @4 */	struct Java_com_sun_cldc_util_SemaphoreLock * JVM_FIELD_CONST lock;
};

struct Java_com_motorola_multimedia_Lighting {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/motorola/multimedia/Lighting */
};

struct Java_com_motorola_multimedia_Vibrator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/motorola/multimedia/Vibrator */
};

struct Java_com_nokia_mid_sound_SoundListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/sound/SoundListener */
};

struct Java_com_nokia_mid_sound_Sound {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/sound/Sound */
    /*  @4 */	struct Java_com_nokia_mid_sound_SoundListener * JVM_FIELD_CONST listener;
    /*  @8 */	jint state;
    /* @12 */	jint gain;
};

struct Java_com_nokia_mid_ui_DeviceControl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/ui/DeviceControl */
};

struct Java_javax_microedition_lcdui_Image {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Image */
    /*  @4 */	jint width;
    /*  @8 */	jint height;
    /* @12 */	struct Java_javax_microedition_lcdui_ImageData * JVM_FIELD_CONST imageData;
};

struct Java_com_nokia_mid_ui_DirectGraphics {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/ui/DirectGraphics */
};

struct Java_javax_microedition_lcdui_Graphics {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Graphics */
    /*  @4 */	jint transX;
    /*  @8 */	jint transY;
    /* @12 */	jint ax;
    /* @16 */	jint ay;
    /* @20 */	jint rgbColor;
    /* @24 */	jint gray;
    /* @28 */	jint pixel;
    /* @32 */	jint style;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST currentFont;
    /* @40 */	jint displayId;
    /* @44 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST img;
    /* @48 */	struct Java_java_lang_Object * JVM_FIELD_CONST creator;
    /* @52 */	jshort clipX1;
    /* @54 */	jshort clipY1;
    /* @56 */	jshort clipX2;
    /* @58 */	jshort clipY2;
    /* @60 */	jshort systemClipX1;
    /* @62 */	jshort systemClipY1;
    /* @64 */	jshort systemClipX2;
    /* @66 */	jshort systemClipY2;
    /* @68 */	jshort maxWidth;
    /* @70 */	jshort maxHeight;
    /* @72 */	jboolean clipped;
    /* @73 */	jboolean runtimeClipEnforce;
    /* @74 */	jbyte ___pad6;
    /* @75 */	jbyte ___pad7;
};

struct Java_com_nokia_mid_ui_DirectUtils {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/ui/DirectUtils */
};

struct Java_com_sun_j2mewp_nokia_DirectGraphicsImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2mewp/nokia/DirectGraphicsImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Graphics * JVM_FIELD_CONST g;
    /*  @8 */	jint alpha;
};

struct Java_javax_microedition_lcdui_LFFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/LFFactory */
};

struct Java_javax_microedition_lcdui_Canvas {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad8;
    /* @31 */	jbyte ___pad9;
    /* javax/microedition/lcdui/Canvas */
    /* @32 */	struct Java_javax_microedition_lcdui_CanvasLF * JVM_FIELD_CONST canvasLF;
    /* @36 */	jboolean suppressKeyEvents;
    /* @37 */	jbyte ___pad10;
    /* @38 */	jbyte ___pad11;
    /* @39 */	jbyte ___pad12;
};

struct Java_javax_microedition_lcdui_CanvasLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/CanvasLF */
};

struct Java_javax_microedition_lcdui_DisplayableLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/DisplayableLF */
};

struct Java_javax_microedition_lcdui_Ticker {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Ticker */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST message;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST displayedMessage;
    /* @12 */	struct Java_javax_microedition_lcdui_TickerLF * JVM_FIELD_CONST tickerLF;
};

struct Java_javax_microedition_lcdui_Command {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Command */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST shortLabel;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST longLabel;
    /* @12 */	jint commandType;
    /* @16 */	jint priority;
    /* @20 */	jint id;
};

struct Java_javax_microedition_lcdui_CommandListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/CommandListener */
};

struct Java_javax_microedition_lcdui_Item {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
};

struct Java_javax_microedition_lcdui_Displayable {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad13;
    /* @31 */	jbyte ___pad14;
};

struct Java_com_nokia_mid_ui_FullCanvas {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad15;
    /* @31 */	jbyte ___pad16;
    /* javax/microedition/lcdui/Canvas */
    /* @32 */	struct Java_javax_microedition_lcdui_CanvasLF * JVM_FIELD_CONST canvasLF;
    /* @36 */	jboolean suppressKeyEvents;
    /* @37 */	jbyte ___pad17;
    /* @38 */	jbyte ___pad18;
    /* @39 */	jbyte ___pad19;
    /* com/nokia/mid/ui/FullCanvas */
};

struct Java_java_lang_IllegalStateException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/IllegalStateException */
};

struct Java_com_nokia_mid_ui_KeyboardVisibilityListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/ui/KeyboardVisibilityListener */
};

struct Java_com_nokia_mid_ui_VirtualKeyboard {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/ui/VirtualKeyboard */
};

struct Java_com_nokia_mid_ui_orientation_Orientation_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad20;
    /* @31 */	jbyte ___pad21;
    /* javax/microedition/lcdui/Canvas */
    /* @32 */	struct Java_javax_microedition_lcdui_CanvasLF * JVM_FIELD_CONST canvasLF;
    /* @36 */	jboolean suppressKeyEvents;
    /* @37 */	jbyte ___pad22;
    /* @38 */	jbyte ___pad23;
    /* @39 */	jbyte ___pad24;
    /* com/nokia/mid/ui/orientation/Orientation$1 */
};

struct Java_com_nokia_mid_ui_orientation_OrientationListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/ui/orientation/OrientationListener */
};

struct Java_com_nokia_mid_ui_orientation_Orientation {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/nokia/mid/ui/orientation/Orientation */
};

struct Java_javax_microedition_media_Player {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/media/Player */
};

struct Java_javax_microedition_media_Control {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/media/Control */
};

struct Java_com_samsung_util_AudioClip {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/samsung/util/AudioClip */
    /*  @4 */	struct Java_javax_microedition_media_Player * JVM_FIELD_CONST player;
};

struct Java_java_io_ByteArrayInputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/InputStream */
    /* java/io/ByteArrayInputStream */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST buf;
    /*  @8 */	jint pos;
    /* @12 */	jint mark;
    /* @16 */	jint count;
};

struct Java_javax_microedition_media_control_VolumeControl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/media/control/VolumeControl */
};

struct Java_com_samsung_util_LCDLight {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/samsung/util/LCDLight */
};

struct Java_com_samsung_util_Vibration {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/samsung/util/Vibration */
};

struct Java_com_siemens_mp_game_Light {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/siemens/mp/game/Light */
};

struct Java_com_siemens_mp_game_Sound {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/siemens/mp/game/Sound */
};

struct Java_com_siemens_mp_game_Vibrator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/siemens/mp/game/Vibrator */
};

struct Java_java_io_Reader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
};

struct Java_com_sun_cldc_i18n_StreamReader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
    /* com/sun/cldc/i18n/StreamReader */
    /* @12 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
};

struct Java_java_io_Writer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
};

struct Java_com_sun_cldc_i18n_StreamWriter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /* com/sun/cldc/i18n/StreamWriter */
    /* @16 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST out;
};

struct Java_com_sun_cldc_i18n_Helper {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/i18n/Helper */
};

struct Java_java_io_UnsupportedEncodingException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* java/io/UnsupportedEncodingException */
};

struct Java_java_lang_ClassCastException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/ClassCastException */
};

struct Java_java_lang_ClassNotFoundException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/ClassNotFoundException */
};

struct Java_java_lang_InstantiationException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/InstantiationException */
};

struct Java_java_lang_IllegalAccessException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/IllegalAccessException */
};

struct Java_java_io_ByteArrayOutputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/OutputStream */
    /* java/io/ByteArrayOutputStream */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST buf;
    /*  @8 */	jint count;
    /* @12 */	jboolean isClosed;
    /* @13 */	jbyte ___pad25;
    /* @14 */	jbyte ___pad26;
    /* @15 */	jbyte ___pad27;
};

struct Java_com_sun_cldc_i18n_j2me_Conv {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/i18n/j2me/Conv */
};

struct Java_com_sun_cldc_i18n_j2me_Gen_1Reader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
    /* com/sun/cldc/i18n/StreamReader */
    /* @12 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
    /* com/sun/cldc/i18n/j2me/Gen_Reader */
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST enc;
    /* @20 */	jint id;
    /* @24 */	jbyte_array * JVM_FIELD_CONST buf;
    /* @28 */	jint maxByteLen;
    /* @32 */	jbyte_array * JVM_FIELD_CONST tmp;
    /* @36 */	jint pos;
};

struct Java_com_sun_cldc_i18n_j2me_Gen_1Writer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /* com/sun/cldc/i18n/StreamWriter */
    /* @16 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST out;
    /* com/sun/cldc/i18n/j2me/Gen_Writer */
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST enc;
    /* @24 */	jint id;
    /* @28 */	jbyte_array * JVM_FIELD_CONST buf;
    /* @32 */	jint maxByteLen;
};

struct Java_com_sun_cldc_i18n_j2me_ISO8859_11_1Reader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
    /* com/sun/cldc/i18n/StreamReader */
    /* @12 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
    /* com/sun/cldc/i18n/j2me/ISO8859_1_Reader */
};

struct Java_com_sun_cldc_i18n_j2me_ISO8859_11_1Writer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /* com/sun/cldc/i18n/StreamWriter */
    /* @16 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST out;
    /* com/sun/cldc/i18n/j2me/ISO8859_1_Writer */
};

struct Java_com_sun_cldc_i18n_j2me_UTF_116_1Reader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
    /* com/sun/cldc/i18n/StreamReader */
    /* @12 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
    /* com/sun/cldc/i18n/j2me/UTF_16_Reader */
    /* @16 */	jint firstByte;
    /* @20 */	jint byteOrder;
    /* @24 */	jint markFirstByte;
    /* @28 */	jint markByteOrder;
    /* @32 */	jint bytesForBOM;
    /* @36 */	jboolean markIsSet;
    /* @37 */	jbyte ___pad28;
    /* @38 */	jbyte ___pad29;
    /* @39 */	jbyte ___pad30;
};

struct Java_com_sun_cldc_i18n_j2me_UTF_116BE_1Reader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
    /* com/sun/cldc/i18n/StreamReader */
    /* @12 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
    /* com/sun/cldc/i18n/j2me/UTF_16_Reader */
    /* @16 */	jint firstByte;
    /* @20 */	jint byteOrder;
    /* @24 */	jint markFirstByte;
    /* @28 */	jint markByteOrder;
    /* @32 */	jint bytesForBOM;
    /* @36 */	jboolean markIsSet;
    /* @37 */	jbyte ___pad31;
    /* @38 */	jbyte ___pad32;
    /* @39 */	jbyte ___pad33;
    /* com/sun/cldc/i18n/j2me/UTF_16BE_Reader */
};

struct Java_com_sun_cldc_i18n_j2me_UTF_116BE_1Writer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /* com/sun/cldc/i18n/StreamWriter */
    /* @16 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST out;
    /* com/sun/cldc/i18n/j2me/UTF_16BE_Writer */
};

struct Java_com_sun_cldc_i18n_j2me_UTF_116LE_1Reader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
    /* com/sun/cldc/i18n/StreamReader */
    /* @12 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
    /* com/sun/cldc/i18n/j2me/UTF_16_Reader */
    /* @16 */	jint firstByte;
    /* @20 */	jint byteOrder;
    /* @24 */	jint markFirstByte;
    /* @28 */	jint markByteOrder;
    /* @32 */	jint bytesForBOM;
    /* @36 */	jboolean markIsSet;
    /* @37 */	jbyte ___pad34;
    /* @38 */	jbyte ___pad35;
    /* @39 */	jbyte ___pad36;
    /* com/sun/cldc/i18n/j2me/UTF_16LE_Reader */
};

struct Java_com_sun_cldc_i18n_j2me_UTF_116LE_1Writer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /* com/sun/cldc/i18n/StreamWriter */
    /* @16 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST out;
    /* com/sun/cldc/i18n/j2me/UTF_16BE_Writer */
    /* com/sun/cldc/i18n/j2me/UTF_16LE_Writer */
};

struct Java_com_sun_cldc_i18n_j2me_UTF_116_1Writer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /* com/sun/cldc/i18n/StreamWriter */
    /* @16 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST out;
    /* com/sun/cldc/i18n/j2me/UTF_16BE_Writer */
    /* com/sun/cldc/i18n/j2me/UTF_16_Writer */
    /* @20 */	jboolean addedBOM;
    /* @21 */	jbyte ___pad37;
    /* @22 */	jbyte ___pad38;
    /* @23 */	jbyte ___pad39;
};

struct Java_com_sun_cldc_i18n_j2me_UTF_18_1Reader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
    /* com/sun/cldc/i18n/StreamReader */
    /* @12 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
    /* com/sun/cldc/i18n/j2me/UTF_8_Reader */
    /* @16 */	jint_array * JVM_FIELD_CONST readAhead;
    /* @20 */	jint pendingSurrogate;
    /* @24 */	struct Java_com_sun_cldc_i18n_j2me_UTF_18_1Reader_00024MarkInfo * JVM_FIELD_CONST markInfo;
    /* @28 */	jboolean markIsSet;
    /* @29 */	jbyte ___pad40;
    /* @30 */	jbyte ___pad41;
    /* @31 */	jbyte ___pad42;
};

struct Java_com_sun_cldc_i18n_j2me_UTF_18_1Reader_00024MarkInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/i18n/j2me/UTF_8_Reader$MarkInfo */
    /*  @4 */	jint_array * JVM_FIELD_CONST readAhead;
    /*  @8 */	jint pendingSurrogate;
    /* @12 */	struct Java_com_sun_cldc_i18n_j2me_UTF_18_1Reader * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_cldc_i18n_j2me_UTF_18_1Writer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /* com/sun/cldc/i18n/StreamWriter */
    /* @16 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST out;
    /* com/sun/cldc/i18n/j2me/UTF_8_Writer */
    /* @20 */	jint pendingSurrogate;
};

struct Java_com_sun_cldc_i18n_uclc_DefaultCaseConverter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/i18n/uclc/DefaultCaseConverter */
};

struct Java_javax_microedition_io_Connection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/Connection */
};

struct Java_com_sun_cldc_io_ConnectionBaseInterface {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/io/ConnectionBaseInterface */
};

struct Java_com_sun_cldc_isolate_Util {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/isolate/Util */
};

struct Java_com_sun_cldc_isolate_Verifier {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/cldc/isolate/Verifier */
};

struct Java_java_util_TimeZone {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimeZone */
};

struct Java_java_util_Date {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Date */
    /*  @4 */	struct Java_java_util_Calendar * JVM_FIELD_CONST calendar;
    /*  @8 */	jlong fastTime;
};

struct Java_java_util_Calendar {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Calendar */
    /*  @4 */	jint_array * JVM_FIELD_CONST fields;
    /*  @8 */	jboolean_array * JVM_FIELD_CONST isSet;
    /* @12 */	jlong time;
    /* @20 */	struct Java_java_util_TimeZone * JVM_FIELD_CONST zone;
    /* @24 */	struct Java_java_util_Date * JVM_FIELD_CONST dateObj;
    /* @28 */	jboolean isTimeSet;
    /* @29 */	jbyte ___pad43;
    /* @30 */	jbyte ___pad44;
    /* @31 */	jbyte ___pad45;
};

struct Java_com_sun_cldc_util_j2me_CalendarImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Calendar */
    /*  @4 */	jint_array * JVM_FIELD_CONST fields;
    /*  @8 */	jboolean_array * JVM_FIELD_CONST isSet;
    /* @12 */	jlong time;
    /* @20 */	struct Java_java_util_TimeZone * JVM_FIELD_CONST zone;
    /* @24 */	struct Java_java_util_Date * JVM_FIELD_CONST dateObj;
    /* @28 */	jboolean isTimeSet;
    /* @29 */	jbyte ___pad46;
    /* @30 */	jbyte ___pad47;
    /* @31 */	jbyte ___pad48;
    /* com/sun/cldc/util/j2me/CalendarImpl */
};

struct Java_com_sun_cldc_util_j2me_TimeZoneImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimeZone */
    /* com/sun/cldc/util/j2me/TimeZoneImpl */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST ID;
    /*  @8 */	jint startMonth;
    /* @12 */	jint startDay;
    /* @16 */	jint startDayOfWeek;
    /* @20 */	jint startTime;
    /* @24 */	jint endMonth;
    /* @28 */	jint endDay;
    /* @32 */	jint endDayOfWeek;
    /* @36 */	jint endTime;
    /* @40 */	jint startYear;
    /* @44 */	jint rawOffset;
    /* @48 */	jint startMode;
    /* @52 */	jint endMode;
    /* @56 */	jint dstSavings;
    /* @60 */	jboolean isCustom;
    /* @61 */	jboolean useDaylight;
    /* @62 */	jbyte ___pad49;
    /* @63 */	jbyte ___pad50;
};

struct Java_com_sun_cldchi_io_ConsoleOutputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/OutputStream */
    /* com/sun/cldchi/io/ConsoleOutputStream */
};

struct Java_com_sun_j2me_security_AccessControlContext {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2me/security/AccessControlContext */
};

struct Java_com_sun_j2me_security_AccessControlContextAdapter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2me/security/AccessControlContextAdapter */
};

struct Java_com_sun_j2me_security_InterruptedSecurityException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/SecurityException */
    /* com/sun/j2me/security/InterruptedSecurityException */
};

struct Java_com_sun_j2me_security_AccessController {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2me/security/AccessController */
};

struct Java_java_util_Vector {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Vector */
    /*  @4 */	jobject_array * JVM_FIELD_CONST elementData;
    /*  @8 */	jint elementCount;
    /* @12 */	jint capacityIncrement;
};

struct Java_javax_microedition_media_Controllable {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/media/Controllable */
};

struct Java_javax_microedition_media_PlayerListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/media/PlayerListener */
};

struct Java_com_sun_j2mewp_media_AudioPlayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2mewp/media/AudioPlayer */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST data;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST type;
    /* @12 */	jint kind;
    /* @16 */	jint state;
    /* @20 */	jint handle;
    /* @24 */	jint loopCount;
    /* @28 */	jint level;
    /* @32 */	jlong pendingTime;
    /* @40 */	struct Java_java_util_Vector * JVM_FIELD_CONST listeners;
    /* @44 */	struct Java_java_lang_Thread * JVM_FIELD_CONST watcher;
    /* @48 */	jint runId;
    /* @52 */	jint watchId;
    /* @56 */	jboolean muted;
    /* @57 */	jbyte ___pad51;
    /* @58 */	jbyte ___pad52;
    /* @59 */	jbyte ___pad53;
};

struct Java_javax_microedition_media_MediaException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* javax/microedition/media/MediaException */
};

struct Java_com_sun_j2mewp_media_DeviceHw {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2mewp/media/DeviceHw */
};

struct Java_javax_wireless_messaging_Message {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/wireless/messaging/Message */
};

struct Java_javax_wireless_messaging_BinaryMessage {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/wireless/messaging/BinaryMessage */
};

struct Java_javax_wireless_messaging_TextMessage {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/wireless/messaging/TextMessage */
};

struct Java_com_sun_j2mewp_messaging_StubMessage {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2mewp/messaging/StubMessage */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST address;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST text;
    /* @12 */	jbyte_array * JVM_FIELD_CONST data;
};

struct Java_javax_wireless_messaging_MessageListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/wireless/messaging/MessageListener */
};

struct Java_javax_wireless_messaging_MessageConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/wireless/messaging/MessageConnection */
};

struct Java_com_sun_j2mewp_messaging_StubMessageConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2mewp/messaging/StubMessageConnection */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /*  @8 */	jboolean closed;
    /* @9 */	jbyte ___pad54;
    /* @10 */	jbyte ___pad55;
    /* @11 */	jbyte ___pad56;
};

struct Java_java_io_InterruptedIOException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* java/io/InterruptedIOException */
    /* @12 */	jint bytesTransferred;
};

struct Java_com_sun_midp_ams_VMUtils {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/ams/VMUtils */
};

struct Java_com_sun_midp_amsservices_ComponentInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/amsservices/ComponentInfo */
};

struct Java_com_sun_midp_amsservices_AMSServices {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/amsservices/AMSServices */
};

struct Java_com_sun_midp_appmanager_AMSServicesEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/AMSServicesEventConsumer */
};

struct Java_com_sun_midp_events_Event {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/Event */
    /*  @4 */	jint type;
    /*  @8 */	struct Java_com_sun_midp_events_Event * JVM_FIELD_CONST next;
};

struct Java_com_sun_midp_events_EventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/EventListener */
};

struct Java_com_sun_midp_events_EventQueue {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/EventQueue */
    /*  @4 */	struct Java_java_lang_Thread * JVM_FIELD_CONST eventQueueThread;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST eventQueueLock;
    /* @12 */	struct Java_com_sun_midp_events_Event * JVM_FIELD_CONST nextEvent;
    /* @16 */	struct Java_com_sun_midp_events_Event * JVM_FIELD_CONST lastEvent;
    /* @20 */	jobject_array * JVM_FIELD_CONST dispatchTable;
    /* @24 */	jint numEvents;
    /* @28 */	struct Java_java_lang_Thread * JVM_FIELD_CONST eventMonitorThread;
    /* @32 */	struct Java_com_sun_midp_events_NativeEventPool * JVM_FIELD_CONST pool;
    /* @36 */	jint nativeEventQueueHandle;
    /* @40 */	jboolean alive;
    /* @41 */	jbyte ___pad57;
    /* @42 */	jbyte ___pad58;
    /* @43 */	jbyte ___pad59;
};

struct Java_com_sun_midp_appmanager_AMSServicesEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/AMSServicesEventListener */
};

struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/MIDletSuiteStorage */
};

struct Java_com_sun_midp_midletsuite_MIDletSuiteImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/MIDletSuiteImpl */
    /*  @4 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /*  @8 */	struct Java_com_sun_midp_security_SecurityHandler * JVM_FIELD_CONST securityHandler;
    /* @12 */	struct Java_com_sun_midp_midletsuite_SuiteProperties * JVM_FIELD_CONST suiteProperties;
    /* @16 */	struct Java_com_sun_midp_midletsuite_SuiteSettings * JVM_FIELD_CONST suiteSettings;
    /* @20 */	struct Java_com_sun_midp_midletsuite_InstallInfo * JVM_FIELD_CONST installInfo;
    /* @24 */	jint id;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST midlet_1_name;
    /* @32 */	struct Java_java_lang_String * JVM_FIELD_CONST midlet_1_class;
    /* @36 */	jint numberOfMidlets;
    /* @40 */	jboolean locked;
    /* @41 */	jbyte ___pad60;
    /* @42 */	jbyte ___pad61;
    /* @43 */	jbyte ___pad62;
};

struct Java_com_sun_midp_midletsuite_InstallInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/InstallInfo */
    /*  @4 */	jint componentId;
    /*  @8 */	jint id;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST jadUrl;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST jarUrl;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST jarFilename;
    /* @24 */	jint expectedJarSize;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST suiteName;
    /* @32 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST suiteVendor;
    /* @40 */	struct Java_java_lang_String * JVM_FIELD_CONST suiteVersion;
    /* @44 */	struct Java_java_lang_String * JVM_FIELD_CONST description;
    /* @48 */	jobject_array * JVM_FIELD_CONST authPath;
    /* @52 */	struct Java_java_lang_String * JVM_FIELD_CONST domain;
    /* @56 */	jbyte_array * JVM_FIELD_CONST verifyHash;
    /* @60 */	jboolean isSuiteComponent;
    /* @61 */	jboolean trusted;
    /* @62 */	jboolean temporary;
    /* @63 */	jbyte ___pad63;
};

struct Java_javax_microedition_lcdui_Screen {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad64;
    /* @31 */	jbyte ___pad65;
    /* javax/microedition/lcdui/Screen */
};

struct Java_javax_microedition_lcdui_Form {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad66;
    /* @31 */	jbyte ___pad67;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Form */
    /* @32 */	jobject_array * JVM_FIELD_CONST items;
    /* @36 */	jint numOfItems;
    /* @40 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST formLF;
    /* @44 */	struct Java_javax_microedition_lcdui_ItemStateListener * JVM_FIELD_CONST itemStateListener;
};

struct Java_javax_microedition_lcdui_FormLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/FormLF */
};

struct Java_javax_microedition_lcdui_ItemStateListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemStateListener */
};

struct Java_com_sun_midp_appmanager_ApplicationManager {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/ApplicationManager */
};

struct Java_com_sun_midp_appmanager_AppInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad68;
    /* @31 */	jbyte ___pad69;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Form */
    /* @32 */	jobject_array * JVM_FIELD_CONST items;
    /* @36 */	jint numOfItems;
    /* @40 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST formLF;
    /* @44 */	struct Java_javax_microedition_lcdui_ItemStateListener * JVM_FIELD_CONST itemStateListener;
    /* com/sun/midp/appmanager/AppInfo */
    /* @48 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST suiteIcon;
    /* @52 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST singleSuiteIcon;
    /* @56 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST icon;
    /* @60 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /* @64 */	struct Java_com_sun_midp_appmanager_ApplicationManager * JVM_FIELD_CONST manager;
    /* @68 */	struct Java_com_sun_midp_midletsuite_InstallInfo * JVM_FIELD_CONST installInfo;
    /* @72 */	jint numberOfMidlets;
    /* @76 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
};

struct Java_javax_microedition_lcdui_ImageItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/ImageItem */
    /* @52 */	struct Java_javax_microedition_lcdui_ImageItemLF * JVM_FIELD_CONST imageItemLF;
    /* @56 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST immutableImg;
    /* @60 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST mutableImg;
    /* @64 */	struct Java_java_lang_String * JVM_FIELD_CONST altText;
    /* @68 */	jint appearanceMode;
};

struct Java_javax_microedition_lcdui_ImageItemLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ImageItemLF */
};

struct Java_javax_microedition_lcdui_ItemLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLF */
};

struct Java_javax_microedition_lcdui_ItemCommandListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemCommandListener */
};

struct Java_javax_microedition_lcdui_StringItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/StringItem */
    /* @52 */	struct Java_javax_microedition_lcdui_StringItemLF * JVM_FIELD_CONST stringItemLF;
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST str;
    /* @60 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST font;
    /* @64 */	jint appearanceMode;
};

struct Java_javax_microedition_lcdui_StringItemLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/StringItemLF */
};

struct Java_javax_microedition_lcdui_Font {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Font */
    /*  @4 */	jint face;
    /*  @8 */	jint style;
    /* @12 */	jint size;
    /* @16 */	jint baseline;
    /* @20 */	jint height;
};

struct Java_com_sun_midp_appmanager_AppManagerPeer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/AppManagerPeer */
    /*  @4 */	struct Java_com_sun_midp_appmanager_AppManagerUI * JVM_FIELD_CONST appManagerUI;
    /*  @8 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /* @12 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @16 */	struct Java_com_sun_midp_appmanager_RunningMIDletSuiteInfo * JVM_FIELD_CONST removeMsi;
    /* @20 */	struct Java_java_util_Vector * JVM_FIELD_CONST msiVector;
    /* @24 */	struct Java_com_sun_midp_appmanager_DisplayError * JVM_FIELD_CONST displayError;
    /* @28 */	struct Java_com_sun_midp_appmanager_ApplicationManager * JVM_FIELD_CONST manager;
    /* @32 */	struct Java_com_sun_midp_main_MIDletProxy * JVM_FIELD_CONST appManagerMidlet;
    /* @36 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST enableOddYesCmd;
    /* @40 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST enableOddNoCmd;
    /* @44 */	jboolean caManagerIncluded;
    /* @45 */	jboolean compManagerIncluded;
    /* @46 */	jboolean foldersOn;
    /* @47 */	jbyte ___pad70;
};

struct Java_com_sun_midp_main_MIDletProxy {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletProxy */
    /*  @4 */	jint externalId;
    /*  @8 */	jint isolateId;
    /* @12 */	jint_array * JVM_FIELD_CONST displayIds;
    /* @16 */	jint numOfDisplays;
    /* @20 */	jint suiteId;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST className;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
    /* @32 */	jint midletState;
    /* @36 */	struct Java_com_sun_midp_main_MIDletProxy * JVM_FIELD_CONST preempting;
    /* @40 */	struct Java_com_sun_midp_main_MIDletProxy * JVM_FIELD_CONST preempted;
    /* @44 */	struct Java_java_util_Timer * JVM_FIELD_CONST proxyTimer;
    /* @48 */	struct Java_com_sun_midp_main_MIDletProxyList * JVM_FIELD_CONST parent;
    /* @52 */	jboolean wasNotActive;
    /* @53 */	jboolean wantsForegroundState;
    /* @54 */	jboolean requestedForeground;
    /* @55 */	jboolean alertWaiting;
    /* @56 */	jbyte extendedAttributes;
    /* @57 */	jbyte ___pad71;
    /* @58 */	jbyte ___pad72;
    /* @59 */	jbyte ___pad73;
};

struct Java_com_sun_midp_midlet_MIDletSuite {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletSuite */
};

struct Java_com_sun_midp_midletsuite_MIDletSuiteInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/MIDletSuiteInfo */
    /*  @4 */	jint suiteId;
    /*  @8 */	jint storageId;
    /* @12 */	jint folderId;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST midletToRun;
    /* @24 */	jint numberOfMidlets;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST iconName;
    /* @32 */	jboolean enabled;
    /* @33 */	jboolean trusted;
    /* @34 */	jboolean temporary;
    /* @35 */	jboolean preinstalled;
};

struct Java_com_sun_midp_appmanager_RunningMIDletSuiteInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/MIDletSuiteInfo */
    /*  @4 */	jint suiteId;
    /*  @8 */	jint storageId;
    /* @12 */	jint folderId;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST midletToRun;
    /* @24 */	jint numberOfMidlets;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST iconName;
    /* @32 */	jboolean enabled;
    /* @33 */	jboolean trusted;
    /* @34 */	jboolean temporary;
    /* @35 */	jboolean preinstalled;
    /* com/sun/midp/appmanager/RunningMIDletSuiteInfo */
    /* @36 */	struct Java_java_util_Vector * JVM_FIELD_CONST proxies;
    /* @40 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST icon;
    /* @44 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST msi;
    /* @48 */	jboolean isDebugMode;
    /* @49 */	jboolean locked;
    /* @50 */	jboolean hasMainMidlet;
    /* @51 */	jbyte ___pad74;
};

struct Java_com_sun_midp_appmanager_AppManagerPeer_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/MIDletSuiteInfo */
    /*  @4 */	jint suiteId;
    /*  @8 */	jint storageId;
    /* @12 */	jint folderId;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST midletToRun;
    /* @24 */	jint numberOfMidlets;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST iconName;
    /* @32 */	jboolean enabled;
    /* @33 */	jboolean trusted;
    /* @34 */	jboolean temporary;
    /* @35 */	jboolean preinstalled;
    /* com/sun/midp/appmanager/RunningMIDletSuiteInfo */
    /* @36 */	struct Java_java_util_Vector * JVM_FIELD_CONST proxies;
    /* @40 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST icon;
    /* @44 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST msi;
    /* @48 */	jboolean isDebugMode;
    /* @49 */	jboolean locked;
    /* @50 */	jboolean hasMainMidlet;
    /* @51 */	jbyte ___pad75;
    /* com/sun/midp/appmanager/AppManagerPeer$1 */
    /* @52 */	struct Java_com_sun_midp_appmanager_AppManagerPeer * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_appmanager_DisplayError {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/DisplayError */
    /*  @4 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
};

struct Java_javax_microedition_lcdui_Display {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Display */
    /*  @4 */	jint width;
    /*  @8 */	jint height;
    /* @12 */	jint displayId;
    /* @16 */	struct Java_java_lang_Object * JVM_FIELD_CONST owner;
    /* @20 */	struct Java_javax_microedition_lcdui_Display_00024DisplayAccessImpl * JVM_FIELD_CONST accessor;
    /* @24 */	struct Java_com_sun_midp_lcdui_DisplayDevice * JVM_FIELD_CONST displayDevice;
    /* @28 */	struct Java_javax_microedition_lcdui_Display_00024DisplayEventConsumerImpl * JVM_FIELD_CONST consumer;
    /* @32 */	struct Java_javax_microedition_lcdui_Display_00024ForegroundEventConsumerImpl * JVM_FIELD_CONST foregroundConsumer;
    /* @36 */	struct Java_com_sun_midp_chameleon_ChamDisplayTunnel * JVM_FIELD_CONST cham_tunnel;
    /* @40 */	jint_array * JVM_FIELD_CONST region;
    /* @44 */	struct Java_com_sun_midp_chameleon_input_TextInputSession * JVM_FIELD_CONST inputSession;
    /* @48 */	struct Java_com_sun_midp_chameleon_layers_PTILayer * JVM_FIELD_CONST pt_popup;
    /* @52 */	struct Java_com_sun_midp_chameleon_layers_VirtualKeyboardLayer * JVM_FIELD_CONST keyboardLayer;
    /* @56 */	struct Java_com_sun_midp_lcdui_ForegroundController * JVM_FIELD_CONST foregroundController;
    /* @60 */	struct Java_javax_microedition_lcdui_Graphics * JVM_FIELD_CONST screenGraphics;
    /* @64 */	jint wantsForeground;
    /* @68 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST initialDisplayable;
    /* @72 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST current;
    /* @76 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST transitionCurrent;
    /* @80 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST pendingCurrent;
    /* @84 */	struct Java_com_sun_midp_chameleon_MIDPWindow * JVM_FIELD_CONST window;
    /* @88 */	struct Java_com_sun_midp_chameleon_CGraphicsQ * JVM_FIELD_CONST graphicsQ;
    /* @92 */	jboolean screenModeKnown;
    /* @93 */	jboolean isRotatedKnown;
    /* @94 */	jboolean wantRotation;
    /* @95 */	jboolean lastFullScnMode;
    /* @96 */	jboolean hasForeground;
    /* @97 */	jboolean disabledForeground;
    /* @98 */	jboolean paintSuspended;
    /* @99 */	jbyte ___pad76;
};

struct Java_com_sun_midp_appmanager_AppManagerUI {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/AppManagerUI */
};

struct Java_javax_microedition_lcdui_AlertType {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/AlertType */
    /*  @4 */	jint type;
};

struct Java_javax_microedition_rms_RecordStore {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/rms/RecordStore */
    /*  @4 */	struct Java_com_sun_midp_rms_RecordStoreImpl * JVM_FIELD_CONST peer;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST recordStoreName;
    /* @12 */	jint suiteId;
    /* @16 */	jint opencount;
    /* @20 */	struct Java_java_util_Vector * JVM_FIELD_CONST recordListeners;
};

struct Java_com_sun_midp_appmanager_AppManagerUIImpl_00024AppManagerMIDletCustomItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST __dup1__owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST __dup1__defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/CustomItem */
    /* @52 */	struct Java_javax_microedition_lcdui_CustomItemLF * JVM_FIELD_CONST customItemLF;
    /* com/sun/midp/appmanager/MIDletCustomItem */
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST locale;
    /* @60 */	jint textOrientation;
    /* @64 */	struct Java_java_util_Timer * JVM_FIELD_CONST textScrollTimer;
    /* @68 */	struct Java_com_sun_midp_appmanager_MIDletCustomItem_00024TextScrollPainter * JVM_FIELD_CONST textScrollPainter;
    /* @72 */	jint scrollWidth;
    /* @76 */	jint xScrollOffset;
    /* @80 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST owner;
    /* @84 */	jint width;
    /* @88 */	jint height;
    /* @92 */	jint truncWidth;
    /* @96 */	jchar_array * JVM_FIELD_CONST text;
    /* @100 */	jint textLen;
    /* @104 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST icon;
    /* @108 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @112 */	jboolean rtlDirection;
    /* @113 */	jboolean truncated;
    /* @114 */	jboolean hasFocus;
    /* @115 */	jbyte ___pad77;
    /* com/sun/midp/appmanager/AppManagerUIImpl$AppManagerMIDletCustomItem */
    /* @116 */	struct Java_com_sun_midp_appmanager_RunningMIDletSuiteInfo * JVM_FIELD_CONST msi;
    /* @120 */	struct Java_com_sun_midp_appmanager_AppManagerUIImpl * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_appmanager_FolderList {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad78;
    /* @31 */	jbyte ___pad79;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/List */
    /* @32 */	struct Java_javax_microedition_lcdui_ChoiceGroup * JVM_FIELD_CONST cg;
    /* @36 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST selectCommand;
    /* @40 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST listLF;
    /* com/sun/midp/appmanager/FolderList */
    /* @44 */	struct Java_java_util_Vector * JVM_FIELD_CONST folders;
};

struct Java_com_sun_midp_appmanager_MIDletSwitcher {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad80;
    /* @31 */	jbyte ___pad81;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Form */
    /* @32 */	jobject_array * JVM_FIELD_CONST items;
    /* @36 */	jint numOfItems;
    /* @40 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST formLF;
    /* @44 */	struct Java_javax_microedition_lcdui_ItemStateListener * JVM_FIELD_CONST itemStateListener;
    /* com/sun/midp/appmanager/MIDletSwitcher */
    /* @48 */	jint mcount;
    /* @52 */	jobject_array * JVM_FIELD_CONST minfo;
    /* @56 */	jint pitch;
    /* @60 */	struct Java_com_sun_midp_appmanager_ApplicationManager * JVM_FIELD_CONST manager;
    /* @64 */	struct Java_com_sun_midp_appmanager_AppManagerUI * JVM_FIELD_CONST managerUI;
    /* @68 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @72 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST fgCmd;
};

struct Java_com_sun_midp_appmanager_MIDletSelector {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/MIDletSelector */
    /*  @4 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST mform;
    /*  @8 */	struct Java_com_sun_midp_appmanager_RunningMIDletSuiteInfo * JVM_FIELD_CONST suiteInfo;
    /* @12 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @16 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST parentDisplayable;
    /* @20 */	struct Java_com_sun_midp_appmanager_ApplicationManager * JVM_FIELD_CONST manager;
    /* @24 */	jint mcount;
    /* @28 */	jobject_array * JVM_FIELD_CONST minfo;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST backCmd;
    /* @36 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST launchCmd;
    /* @40 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST endCmd;
};

struct Java_com_sun_midp_appmanager_Folder {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/Folder */
};

struct Java_com_sun_midp_appmanager_AppManagerUIImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad82;
    /* @31 */	jbyte ___pad83;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Form */
    /* @32 */	jobject_array * JVM_FIELD_CONST items;
    /* @36 */	jint numOfItems;
    /* @40 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST formLF;
    /* @44 */	struct Java_javax_microedition_lcdui_ItemStateListener * JVM_FIELD_CONST itemStateListener;
    /* com/sun/midp/appmanager/AppManagerUIImpl */
    /* @48 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST exitCmd;
    /* @52 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST launchInstallCmd;
    /* @56 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST launchCaManagerCmd;
    /* @60 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST launchCompManagerCmd;
    /* @64 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST launchODTAgentCmd;
    /* @68 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST openCmd;
    /* @72 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST infoCmd;
    /* @76 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST removeCmd;
    /* @80 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST updateCmd;
    /* @84 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST appSettingsCmd;
    /* @88 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST moveToInternalStorageCmd;
    /* @92 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST viewCompCmd;
    /* @96 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST cancelCmd;
    /* @100 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST removeOkCmd;
    /* @104 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST backCmd;
    /* @108 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST fgCmd;
    /* @112 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST endCmd;
    /* @116 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST runYesCmd;
    /* @120 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST runNoCmd;
    /* @124 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST selectFolderCmd;
    /* @128 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST selectItemFolderCmd;
    /* @132 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST changeFolderCmd;
    /* @136 */	struct Java_com_sun_midp_appmanager_ApplicationManager * JVM_FIELD_CONST manager;
    /* @140 */	struct Java_com_sun_midp_appmanager_AppManagerPeer * JVM_FIELD_CONST appManager;
    /* @144 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /* @148 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @152 */	jlong lastDisplayChange;
    /* @160 */	struct Java_com_sun_midp_appmanager_RunningMIDletSuiteInfo * JVM_FIELD_CONST removeMsi;
    /* @164 */	struct Java_com_sun_midp_appmanager_RunningMIDletSuiteInfo * JVM_FIELD_CONST lastSelectedMsi;
    /* @168 */	struct Java_java_util_Vector * JVM_FIELD_CONST mciVector;
    /* @172 */	struct Java_com_sun_midp_appmanager_DisplayError * JVM_FIELD_CONST displayError;
    /* @176 */	struct Java_com_sun_midp_appmanager_MIDletSwitcher * JVM_FIELD_CONST midletSwitcher;
    /* @180 */	struct Java_com_sun_midp_appmanager_FolderList * JVM_FIELD_CONST folderList;
    /* @184 */	jint currentFolderId;
    /* @188 */	struct Java_com_sun_midp_appmanager_AppManagerUIImpl_00024AppManagerMIDletCustomItem * JVM_FIELD_CONST mciToChangeFolder;
    /* @192 */	struct Java_java_util_Vector * JVM_FIELD_CONST midletSelectors;
    /* @196 */	jint exitingMidletSuiteId;
    /* @200 */	struct Java_java_lang_String * JVM_FIELD_CONST exitingMidletClassName;
    /* @204 */	jboolean foldersOn;
    /* @205 */	jbyte ___pad84;
    /* @206 */	jbyte ___pad85;
    /* @207 */	jbyte ___pad86;
};

struct Java_javax_microedition_lcdui_Alert {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad87;
    /* @31 */	jbyte ___pad88;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Alert */
    /* @32 */	struct Java_javax_microedition_lcdui_AlertType * JVM_FIELD_CONST type;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST text;
    /* @40 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST image;
    /* @44 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST mutableImage;
    /* @48 */	struct Java_javax_microedition_lcdui_Gauge * JVM_FIELD_CONST indicator;
    /* @52 */	jint time;
    /* @56 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST returnScreen;
    /* @60 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST userCommandListener;
    /* @64 */	struct Java_javax_microedition_lcdui_AlertLF * JVM_FIELD_CONST alertLF;
    /* @68 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST implicitListener;
};

struct Java_javax_microedition_lcdui_AlertLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/AlertLF */
};

struct Java_javax_microedition_lcdui_Gauge {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/Gauge */
    /* @52 */	struct Java_javax_microedition_lcdui_GaugeLF * JVM_FIELD_CONST gaugeLF;
    /* @56 */	jint value;
    /* @60 */	jint maxValue;
    /* @64 */	jboolean interactive;
    /* @65 */	jbyte ___pad89;
    /* @66 */	jbyte ___pad90;
    /* @67 */	jbyte ___pad91;
};

struct Java_javax_microedition_rms_RecordStoreException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* javax/microedition/rms/RecordStoreException */
};

struct Java_java_util_Timer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Timer */
    /*  @4 */	struct Java_java_util_TaskQueue * JVM_FIELD_CONST queue;
    /*  @8 */	struct Java_java_util_TimerThread * JVM_FIELD_CONST thread;
};

struct Java_com_sun_midp_appmanager_MIDletCustomItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST __dup1__owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST __dup1__defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/CustomItem */
    /* @52 */	struct Java_javax_microedition_lcdui_CustomItemLF * JVM_FIELD_CONST customItemLF;
    /* com/sun/midp/appmanager/MIDletCustomItem */
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST locale;
    /* @60 */	jint textOrientation;
    /* @64 */	struct Java_java_util_Timer * JVM_FIELD_CONST textScrollTimer;
    /* @68 */	struct Java_com_sun_midp_appmanager_MIDletCustomItem_00024TextScrollPainter * JVM_FIELD_CONST textScrollPainter;
    /* @72 */	jint scrollWidth;
    /* @76 */	jint xScrollOffset;
    /* @80 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST owner;
    /* @84 */	jint width;
    /* @88 */	jint height;
    /* @92 */	jint truncWidth;
    /* @96 */	jchar_array * JVM_FIELD_CONST text;
    /* @100 */	jint textLen;
    /* @104 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST icon;
    /* @108 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @112 */	jboolean rtlDirection;
    /* @113 */	jboolean truncated;
    /* @114 */	jboolean hasFocus;
    /* @115 */	jbyte ___pad92;
};

struct Java_com_sun_midp_appmanager_MIDletCustomItem_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/MIDletCustomItem$1 */
};

struct Java_com_sun_midp_appmanager_MIDletCustomItem_00024TextScrollPainter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/appmanager/MIDletCustomItem$TextScrollPainter */
    /* @28 */	struct Java_com_sun_midp_appmanager_MIDletCustomItem * JVM_FIELD_CONST this_0440;
};

struct Java_java_util_TimerTask {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
};

struct Java_javax_microedition_lcdui_CustomItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/CustomItem */
    /* @52 */	struct Java_javax_microedition_lcdui_CustomItemLF * JVM_FIELD_CONST customItemLF;
};

struct Java_javax_microedition_lcdui_CustomItemLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/CustomItemLF */
};

struct Java_javax_microedition_lcdui_ChoiceGroup {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/ChoiceGroup */
    /* @52 */	struct Java_javax_microedition_lcdui_ChoiceGroupLF * JVM_FIELD_CONST choiceGroupLF;
    /* @56 */	jint choiceType;
    /* @60 */	jint fitPolicy;
    /* @64 */	jint numOfEls;
    /* @68 */	jobject_array * JVM_FIELD_CONST cgElements;
};

struct Java_javax_microedition_lcdui_List {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad93;
    /* @31 */	jbyte ___pad94;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/List */
    /* @32 */	struct Java_javax_microedition_lcdui_ChoiceGroup * JVM_FIELD_CONST cg;
    /* @36 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST selectCommand;
    /* @40 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST listLF;
};

struct Java_javax_microedition_lcdui_Choice {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Choice */
};

struct Java_com_sun_midp_appmanager_SplashScreen {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad95;
    /* @31 */	jbyte ___pad96;
    /* javax/microedition/lcdui/Canvas */
    /* @32 */	struct Java_javax_microedition_lcdui_CanvasLF * JVM_FIELD_CONST canvasLF;
    /* @36 */	jboolean suppressKeyEvents;
    /* @37 */	jbyte ___pad97;
    /* @38 */	jbyte ___pad98;
    /* @39 */	jbyte ___pad99;
    /* com/sun/midp/appmanager/SplashScreen */
    /* @40 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST splashScreen;
    /* @44 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST nextScreen;
    /* @48 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @52 */	struct Java_java_util_TimerTask * JVM_FIELD_CONST timerTask;
    /* @56 */	struct Java_java_util_Timer * JVM_FIELD_CONST timeoutTimer;
};

struct Java_com_sun_midp_appmanager_MIDletSwitcher_00024MidletListEntry {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/MIDletSwitcher$MidletListEntry */
    /*  @4 */	struct Java_com_sun_midp_appmanager_RunningMIDletSuiteInfo * JVM_FIELD_CONST suite;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST className;
    /* @12 */	struct Java_com_sun_midp_appmanager_MIDletSwitcher * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_appmanager_ValueChoice {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/ValueChoice */
};

struct Java_com_sun_midp_appmanager_AppSettings {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/AppSettings */
};

struct Java_com_sun_midp_appmanager_AppSettingsUI {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/AppSettingsUI */
};

struct Java_com_sun_midp_appmanager_ValueChoiceImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/ValueChoiceImpl */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /*  @8 */	struct Java_java_util_Vector * JVM_FIELD_CONST ids;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST labels;
    /* @16 */	jint selectedID;
    /* @20 */	struct Java_com_sun_midp_security_PermissionGroup * JVM_FIELD_CONST permissionGroup;
    /* @24 */	jint permissionGroupID;
};

struct Java_com_sun_midp_security_PermissionGroup {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/PermissionGroup */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST name;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST nativeName;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST settingsQuestion;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST disableSettingChoice;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST runtimeDialogTitle;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST runtimeQuestion;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST runtimeOneshotQuestion;
};

struct Java_com_sun_midp_appmanager_AppSettingsImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/AppSettingsImpl */
    /*  @4 */	struct Java_com_sun_midp_appmanager_AppSettingsUI * JVM_FIELD_CONST settingsUI;
    /*  @8 */	struct Java_com_sun_midp_appmanager_ValueChoiceImpl * JVM_FIELD_CONST groupChoice;
    /* @12 */	struct Java_com_sun_midp_appmanager_ValueChoiceImpl * JVM_FIELD_CONST interruptChoice;
    /* @16 */	jint prevValueID;
    /* @20 */	jint curChoiceID;
    /* @24 */	jobject_array * JVM_FIELD_CONST groupSettings;
    /* @28 */	jint numberOfSettings;
    /* @32 */	struct Java_com_sun_midp_appmanager_ValueChoiceImpl * JVM_FIELD_CONST initialSetting;
    /* @36 */	jbyte_array * JVM_FIELD_CONST maxLevels;
    /* @40 */	jbyte_array * JVM_FIELD_CONST curLevels;
    /* @44 */	jbyte_array * JVM_FIELD_CONST tmpLevels;
    /* @48 */	jbyte_array * JVM_FIELD_CONST prevTmpLevels;
    /* @52 */	jint PUSH_ID;
    /* @56 */	jint pushOptions;
    /* @60 */	jobject_array * JVM_FIELD_CONST groups;
    /* @64 */	jobject_array * JVM_FIELD_CONST groupsInConflict;
    /* @68 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /* @72 */	struct Java_com_sun_midp_appmanager_DisplayError * JVM_FIELD_CONST displayError;
    /* @76 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST nextScreen;
    /* @80 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @84 */	struct Java_java_lang_String * JVM_FIELD_CONST suiteDisplayName;
    /* @88 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteImpl * JVM_FIELD_CONST midletSuite;
    /* @92 */	struct Java_com_sun_midp_midletsuite_InstallInfo * JVM_FIELD_CONST installInfo;
    /* @96 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST okChoiceSelectionCmd;
    /* @100 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST cancelChoiceSelectionCmd;
    /* @104 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST okExclusiveChoiceSelectionCmd;
    /* @108 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST noExclusiveChoiceSelectionCmd;
    /* @112 */	jbyte pushInterruptSetting;
    /* @113 */	jbyte tmpPushInterruptSetting;
    /* @114 */	jbyte ___pad100;
    /* @115 */	jbyte ___pad101;
};

struct Java_com_sun_midp_appmanager_RadioButtonSet {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/ChoiceGroup */
    /* @52 */	struct Java_javax_microedition_lcdui_ChoiceGroupLF * JVM_FIELD_CONST choiceGroupLF;
    /* @56 */	jint choiceType;
    /* @60 */	jint fitPolicy;
    /* @64 */	jint numOfEls;
    /* @68 */	jobject_array * JVM_FIELD_CONST cgElements;
    /* com/sun/midp/appmanager/RadioButtonSet */
    /* @72 */	jint_array * JVM_FIELD_CONST ids;
};

struct Java_com_sun_midp_appmanager_AppSettingsUIImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad102;
    /* @31 */	jbyte ___pad103;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Form */
    /* @32 */	jobject_array * JVM_FIELD_CONST items;
    /* @36 */	jint numOfItems;
    /* @40 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST formLF;
    /* @44 */	struct Java_javax_microedition_lcdui_ItemStateListener * JVM_FIELD_CONST itemStateListener;
    /* com/sun/midp/appmanager/AppSettingsUIImpl */
    /* @48 */	struct Java_com_sun_midp_appmanager_AppSettings * JVM_FIELD_CONST appSettings;
    /* @52 */	jint lastGroupChoiceID;
    /* @56 */	jint lastGroupChoiceIndex;
    /* @60 */	struct Java_com_sun_midp_appmanager_RadioButtonSet * JVM_FIELD_CONST groupChoice;
    /* @64 */	jobject_array * JVM_FIELD_CONST groupSettings;
    /* @68 */	jint displayedSettingID;
    /* @72 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST saveAppSettingsCmd;
    /* @76 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST cancelCmd;
};

struct Java_javax_microedition_lcdui_ChoiceGroup_00024CGElement {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ChoiceGroup$CGElement */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST stringEl;
    /*  @8 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST imageEl;
    /* @12 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST mutableImageEl;
    /* @16 */	struct Java_javax_microedition_lcdui_ImageData * JVM_FIELD_CONST imageDataEl;
    /* @20 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST fontEl;
    /* @24 */	struct Java_javax_microedition_lcdui_ChoiceGroup * JVM_FIELD_CONST this_0440;
    /* @28 */	jboolean selected;
    /* @29 */	jbyte ___pad104;
    /* @30 */	jbyte ___pad105;
    /* @31 */	jbyte ___pad106;
};

struct Java_javax_microedition_lcdui_ChoiceGroupLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ChoiceGroupLF */
};

struct Java_com_sun_midp_appmanager_Ca {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/Ca */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST name;
    /*  @8 */	jboolean enabled;
    /*  @9 */	jboolean willBeEnabled;
    /* @10 */	jbyte ___pad107;
    /* @11 */	jbyte ___pad108;
};

struct Java_com_sun_midp_appmanager_CaManager {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/appmanager/CaManager */
};

struct Java_com_sun_midp_publickeystore_WebPublicKeyStore {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/PublicKeyStore */
    /*  @4 */	struct Java_java_util_Vector * JVM_FIELD_CONST keyList;
    /* com/sun/midp/publickeystore/WebPublicKeyStore */
};

struct Java_com_sun_midp_publickeystore_PublicKeyInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/PublicKeyInfo */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST owner;
    /*  @8 */	jlong notBefore;
    /* @16 */	jlong notAfter;
    /* @24 */	jbyte_array * JVM_FIELD_CONST modulus;
    /* @28 */	jbyte_array * JVM_FIELD_CONST exponent;
    /* @32 */	struct Java_java_lang_String * JVM_FIELD_CONST domain;
    /* @36 */	jboolean enabled;
    /* @37 */	jbyte ___pad109;
    /* @38 */	jbyte ___pad110;
    /* @39 */	jbyte ___pad111;
};

struct Java_com_sun_midp_appmanager_CaForm {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad112;
    /* @31 */	jbyte ___pad113;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Form */
    /* @32 */	jobject_array * JVM_FIELD_CONST items;
    /* @36 */	jint numOfItems;
    /* @40 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST formLF;
    /* @44 */	struct Java_javax_microedition_lcdui_ItemStateListener * JVM_FIELD_CONST itemStateListener;
    /* com/sun/midp/appmanager/CaForm */
    /* @48 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST suiteStorage;
    /* @52 */	struct Java_java_util_Vector * JVM_FIELD_CONST disableSuites;
    /* @56 */	struct Java_java_util_Vector * JVM_FIELD_CONST enableSuites;
    /* @60 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST confirmCmd;
    /* @64 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST exitCmd;
    /* @68 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST saveCmd;
    /* @72 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST cancelCmd;
    /* @76 */	struct Java_java_util_Vector * JVM_FIELD_CONST caList;
    /* @80 */	struct Java_com_sun_midp_appmanager_CaManager * JVM_FIELD_CONST parent;
    /* @84 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @88 */	struct Java_javax_microedition_lcdui_ChoiceGroup * JVM_FIELD_CONST choices;
    /* @92 */	jint firstIndex;
};

struct Java_com_sun_midp_security_SecurityToken {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/SecurityToken */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST permissions;
};

struct Java_com_sun_midp_midletsuite_SuiteProperties {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/SuiteProperties */
    /*  @4 */	struct Java_com_sun_midp_util_Properties * JVM_FIELD_CONST properties;
    /*  @8 */	jint suiteId;
};

struct Java_com_sun_midp_midletsuite_SuiteSettings {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/SuiteSettings */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST permissions;
    /*  @8 */	jint pushOptions;
    /* @12 */	jint suiteId;
    /* @16 */	jbyte pushInterruptSetting;
    /* @17 */	jboolean enabled;
    /* @18 */	jbyte ___pad114;
    /* @19 */	jbyte ___pad115;
};

struct Java_com_sun_midp_security_SecurityHandler {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/SecurityHandler */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST permissions;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST sessionValues;
    /* @12 */	jbyte_array * JVM_FIELD_CONST maxPermissionLevels;
    /* @16 */	jboolean trusted;
    /* @17 */	jbyte ___pad116;
    /* @18 */	jbyte ___pad117;
    /* @19 */	jbyte ___pad118;
};

struct Java_com_sun_midp_midlet_MIDletStateHandler {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletStateHandler */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST midletSuite;
    /*  @8 */	struct Java_com_sun_midp_midlet_MIDletLoader * JVM_FIELD_CONST midletLoader;
    /* @12 */	jobject_array * JVM_FIELD_CONST midlets;
    /* @16 */	jint nmidlets;
    /* @20 */	jint scanIndex;
    /* @24 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST underConstructionPeer;
};

struct Java_javax_microedition_midlet_MIDlet {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
};

struct Java_com_sun_midp_midlet_MIDletPeer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletPeer */
    /*  @4 */	jint state;
    /*  @8 */	struct Java_javax_microedition_midlet_MIDlet * JVM_FIELD_CONST midlet;
};

struct Java_javax_microedition_midlet_MIDlet_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet$1 */
};

struct Java_com_sun_midp_security_ImplicitlyTrustedClass {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/ImplicitlyTrustedClass */
};

struct Java_com_sun_midp_midlet_MIDletTunnel {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletTunnel */
};

struct Java_com_sun_midp_appmanager_ComponentManagerLauncher {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/ComponentManagerLauncher */
};

struct Java_com_sun_midp_appmanager_FolderManager {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/FolderManager */
};

struct Java_com_sun_midp_appmanager_InstallerEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/InstallerEventConsumer */
};

struct Java_com_sun_midp_appmanager_InstallerEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/InstallerEventListener */
    /*  @4 */	struct Java_com_sun_midp_appmanager_InstallerEventConsumer * JVM_FIELD_CONST eventConsumer;
};

struct Java_com_sun_midp_appmanager_MIDletSelector_00024SelectorMIDletCustomItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST __dup1__owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST __dup1__defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/CustomItem */
    /* @52 */	struct Java_javax_microedition_lcdui_CustomItemLF * JVM_FIELD_CONST customItemLF;
    /* com/sun/midp/appmanager/MIDletCustomItem */
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST locale;
    /* @60 */	jint textOrientation;
    /* @64 */	struct Java_java_util_Timer * JVM_FIELD_CONST textScrollTimer;
    /* @68 */	struct Java_com_sun_midp_appmanager_MIDletCustomItem_00024TextScrollPainter * JVM_FIELD_CONST textScrollPainter;
    /* @72 */	jint scrollWidth;
    /* @76 */	jint xScrollOffset;
    /* @80 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST owner;
    /* @84 */	jint width;
    /* @88 */	jint height;
    /* @92 */	jint truncWidth;
    /* @96 */	jchar_array * JVM_FIELD_CONST text;
    /* @100 */	jint textLen;
    /* @104 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST icon;
    /* @108 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @112 */	jboolean rtlDirection;
    /* @113 */	jboolean truncated;
    /* @114 */	jboolean hasFocus;
    /* @115 */	jbyte ___pad119;
    /* com/sun/midp/appmanager/MIDletSelector$SelectorMIDletCustomItem */
    /* @116 */	jint index;
    /* @120 */	struct Java_com_sun_midp_appmanager_MIDletSelector * JVM_FIELD_CONST this_0440;
    /* @124 */	jboolean isActive;
    /* @125 */	jbyte ___pad120;
    /* @126 */	jbyte ___pad121;
    /* @127 */	jbyte ___pad122;
};

struct Java_com_sun_midp_midletsuite_MIDletInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/MIDletInfo */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST name;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST icon;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST classname;
};

struct Java_com_sun_midp_main_MIDletProxyList {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletProxyList */
    /*  @4 */	struct Java_java_util_Vector * JVM_FIELD_CONST listeners;
    /*  @8 */	struct Java_java_util_Vector * JVM_FIELD_CONST midletProxies;
    /* @12 */	struct Java_com_sun_midp_main_MIDletProxy * JVM_FIELD_CONST foregroundMidlet;
    /* @16 */	struct Java_com_sun_midp_main_DisplayController * JVM_FIELD_CONST displayController;
    /* @20 */	struct Java_com_sun_midp_main_MIDletProxy * JVM_FIELD_CONST amsProxy;
    /* @24 */	jboolean allPaused;
    /* @25 */	jbyte ___pad123;
    /* @26 */	jbyte ___pad124;
    /* @27 */	jbyte ___pad125;
};

struct Java_com_sun_midp_appmanager_MIDletSuiteLauncher {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/appmanager/MIDletSuiteLauncher */
    /*  @8 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /* @12 */	struct Java_com_sun_midp_appmanager_DisplayError * JVM_FIELD_CONST displayError;
    /* @16 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
};

struct Java_com_sun_midp_appmanager_MIDletSwitcher_00024SwitcherMIDletCustomItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST __dup1__owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST __dup1__defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/CustomItem */
    /* @52 */	struct Java_javax_microedition_lcdui_CustomItemLF * JVM_FIELD_CONST customItemLF;
    /* com/sun/midp/appmanager/MIDletCustomItem */
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST locale;
    /* @60 */	jint textOrientation;
    /* @64 */	struct Java_java_util_Timer * JVM_FIELD_CONST textScrollTimer;
    /* @68 */	struct Java_com_sun_midp_appmanager_MIDletCustomItem_00024TextScrollPainter * JVM_FIELD_CONST textScrollPainter;
    /* @72 */	jint scrollWidth;
    /* @76 */	jint xScrollOffset;
    /* @80 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST owner;
    /* @84 */	jint width;
    /* @88 */	jint height;
    /* @92 */	jint truncWidth;
    /* @96 */	jchar_array * JVM_FIELD_CONST text;
    /* @100 */	jint textLen;
    /* @104 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST icon;
    /* @108 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @112 */	jboolean rtlDirection;
    /* @113 */	jboolean truncated;
    /* @114 */	jboolean hasFocus;
    /* @115 */	jbyte ___pad126;
    /* com/sun/midp/appmanager/MIDletSwitcher$SwitcherMIDletCustomItem */
    /* @116 */	struct Java_com_sun_midp_appmanager_MIDletSwitcher_00024MidletListEntry * JVM_FIELD_CONST mle;
    /* @120 */	struct Java_com_sun_midp_appmanager_MIDletSwitcher * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_appmanager_ODTControllerEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/ODTControllerEventConsumer */
};

struct Java_com_sun_midp_appmanager_Manager {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/appmanager/Manager */
    /*  @8 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /* @12 */	struct Java_com_sun_midp_appmanager_DisplayError * JVM_FIELD_CONST displayError;
    /* @16 */	struct Java_com_sun_midp_appmanager_AppManagerPeer * JVM_FIELD_CONST appManager;
};

struct Java_java_lang_NumberFormatException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/IllegalArgumentException */
    /* java/lang/NumberFormatException */
};

struct Java_com_sun_midp_appmanager_ODTControllerEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/appmanager/ODTControllerEventListener */
};

struct Java_com_sun_midp_lcdui_ForegroundEventProducer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/ForegroundEventProducer */
    /*  @4 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
};

struct Java_com_sun_midp_midlet_MIDletEventProducer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletEventProducer */
    /*  @4 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
};

struct Java_com_sun_midp_suspend_SuspendDependency {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/SuspendDependency */
};

struct Java_com_sun_midp_appmanager_SelectorBase {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/appmanager/SelectorBase */
    /*  @8 */	struct Java_javax_microedition_lcdui_List * JVM_FIELD_CONST mlist;
    /* @12 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @16 */	jint mcount;
    /* @20 */	jobject_array * JVM_FIELD_CONST minfo;
    /* @24 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST exitCmd;
    /* @28 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST launchCmd;
    /* @32 */	jint selectedMidlet;
};

struct Java_com_sun_midp_appmanager_Selector {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/appmanager/SelectorBase */
    /*  @8 */	struct Java_javax_microedition_lcdui_List * JVM_FIELD_CONST mlist;
    /* @12 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @16 */	jint mcount;
    /* @20 */	jobject_array * JVM_FIELD_CONST minfo;
    /* @24 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST exitCmd;
    /* @28 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST launchCmd;
    /* @32 */	jint selectedMidlet;
    /* com/sun/midp/appmanager/Selector */
};

struct Java_com_sun_midp_appmanager_SplashScreen_00024TimeoutTask {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/appmanager/SplashScreen$TimeoutTask */
    /* @28 */	struct Java_com_sun_midp_appmanager_SplashScreen * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_main_MIDletControllerEventProducer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletControllerEventProducer */
    /*  @4 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
    /*  @8 */	jint amsIsolateId;
    /* @12 */	jint currentIsolateId;
    /* @16 */	struct Java_com_sun_midp_events_NativeEvent * JVM_FIELD_CONST startErrorEvent;
    /* @20 */	struct Java_com_sun_midp_events_NativeEvent * JVM_FIELD_CONST midletCreatedEvent;
    /* @24 */	struct Java_com_sun_midp_events_NativeEvent * JVM_FIELD_CONST midletActiveEvent;
    /* @28 */	struct Java_com_sun_midp_events_NativeEvent * JVM_FIELD_CONST midletPausedEvent;
    /* @32 */	struct Java_com_sun_midp_events_NativeEvent * JVM_FIELD_CONST midletDestroyedEvent;
    /* @36 */	struct Java_com_sun_midp_events_NativeEvent * JVM_FIELD_CONST midletRsPausedEvent;
};

struct Java_com_sun_midp_automation_AutomationInitializer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/automation/AutomationInitializer */
};

struct Java_com_sun_midp_chameleon_CGraphicsQ {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CGraphicsQ */
    /*  @4 */	struct Java_java_util_Vector * JVM_FIELD_CONST refreshQ;
};

struct Java_com_sun_midp_chameleon_CGraphicsUtil {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CGraphicsUtil */
};

struct Java_com_sun_midp_chameleon_CWindow {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CWindow */
    /*  @4 */	jint_array * JVM_FIELD_CONST bounds;
    /*  @8 */	struct Java_com_sun_midp_chameleon_CLayerList * JVM_FIELD_CONST layers;
    /* @12 */	jint dirtyCount;
    /* @16 */	jint dirtyMaxCount;
    /* @20 */	jobject_array * JVM_FIELD_CONST dirtyLayers;
    /* @24 */	struct Java_com_sun_midp_chameleon_layers_BackgroundLayer * JVM_FIELD_CONST bgLayer;
    /* @28 */	jint cX;
    /* @32 */	jint cY;
    /* @36 */	jint cW;
    /* @40 */	jint cH;
    /* @44 */	jint tranX;
    /* @48 */	jint tranY;
    /* @52 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST font;
    /* @56 */	jint color;
    /* @60 */	jboolean dirty;
    /* @61 */	jbyte ___pad127;
    /* @62 */	jbyte ___pad128;
    /* @63 */	jbyte ___pad129;
};

struct Java_com_sun_midp_chameleon_CLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad130;
    /* @47 */	jbyte ___pad131;
};

struct Java_com_sun_midp_chameleon_CLayerElement {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayerElement */
    /*  @4 */	struct Java_com_sun_midp_chameleon_CLayer * JVM_FIELD_CONST layer;
    /*  @8 */	struct Java_com_sun_midp_chameleon_CLayerElement * JVM_FIELD_CONST upper;
    /* @12 */	struct Java_com_sun_midp_chameleon_CLayerElement * JVM_FIELD_CONST lower;
};

struct Java_com_sun_midp_chameleon_CLayerList {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayerList */
    /*  @4 */	struct Java_com_sun_midp_chameleon_CLayerElement * JVM_FIELD_CONST top;
    /*  @8 */	struct Java_com_sun_midp_chameleon_CLayerElement * JVM_FIELD_CONST bottom;
    /* @12 */	jint count;
};

struct Java_com_sun_midp_chameleon_layers_BackgroundLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad132;
    /* @47 */	jbyte ___pad133;
    /* com/sun/midp/chameleon/layers/BackgroundLayer */
};

struct Java_com_sun_midp_chameleon_ChamDisplayTunnel {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/ChamDisplayTunnel */
};

struct Java_com_sun_midp_chameleon_layers_TitleLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad134;
    /* @47 */	jbyte ___pad135;
    /* com/sun/midp/chameleon/layers/TitleLayer */
    /* @48 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @52 */	jint titlex;
    /* @56 */	jint titley;
    /* @60 */	jint titlew;
    /* @64 */	jint titleh;
};

struct Java_com_sun_midp_chameleon_layers_TickerLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad136;
    /* @47 */	jbyte ___pad137;
    /* com/sun/midp/chameleon/layers/TickerLayer */
    /* @48 */	struct Java_java_lang_String * JVM_FIELD_CONST text;
    /* @52 */	jint textLoc;
    /* @56 */	jint textLen;
    /* @60 */	struct Java_java_util_Timer * JVM_FIELD_CONST tickerTimer;
    /* @64 */	struct Java_com_sun_midp_chameleon_layers_TickerLayer_00024TickerPainter * JVM_FIELD_CONST tickerPainter;
};

struct Java_com_sun_midp_chameleon_layers_BodyLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad138;
    /* @47 */	jbyte ___pad139;
    /* com/sun/midp/chameleon/layers/BodyLayer */
    /* @48 */	struct Java_com_sun_midp_chameleon_layers_ScrollIndLayer * JVM_FIELD_CONST scrollInd;
    /* @52 */	struct Java_com_sun_midp_chameleon_ChamDisplayTunnel * JVM_FIELD_CONST tunnel;
};

struct Java_com_sun_midp_chameleon_layers_SoftButtonLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad140;
    /* @47 */	jbyte ___pad141;
    /* com/sun/midp/chameleon/layers/SoftButtonLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST labels;
    /* @52 */	jobject_array * JVM_FIELD_CONST scrCmds;
    /* @56 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST scrListener;
    /* @60 */	jobject_array * JVM_FIELD_CONST itmCmds;
    /* @64 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST itemListener;
    /* @68 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST soft1;
    /* @72 */	jobject_array * JVM_FIELD_CONST soft2;
    /* @76 */	struct Java_com_sun_midp_chameleon_SubMenuCommand * JVM_FIELD_CONST subMenu;
    /* @80 */	jint_array * JVM_FIELD_CONST cached_button_anchor_x;
    /* @84 */	struct Java_com_sun_midp_chameleon_layers_MenuLayer * JVM_FIELD_CONST menuLayer;
    /* @88 */	struct Java_com_sun_midp_chameleon_ChamDisplayTunnel * JVM_FIELD_CONST tunnel;
    /* @92 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST swap;
    /* @96 */	jint typeX;
    /* @100 */	jint typeY;
    /* @104 */	jint buttonx;
    /* @108 */	jint buttony;
    /* @112 */	jint buttonw;
    /* @116 */	jint buttonh;
    /* @120 */	jboolean menuUP;
    /* @121 */	jboolean alertUP;
    /* @122 */	jboolean isInteractive;
    /* @123 */	jboolean isNativeLayer;
};

struct Java_com_sun_midp_chameleon_layers_AlertLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad142;
    /* @47 */	jbyte ___pad143;
    /* com/sun/midp/chameleon/layers/BodyLayer */
    /* @48 */	struct Java_com_sun_midp_chameleon_layers_ScrollIndLayer * JVM_FIELD_CONST scrollInd;
    /* @52 */	struct Java_com_sun_midp_chameleon_ChamDisplayTunnel * JVM_FIELD_CONST tunnel;
    /* com/sun/midp/chameleon/layers/AlertLayer */
    /* @56 */	struct Java_javax_microedition_lcdui_Alert * JVM_FIELD_CONST alert;
};

struct Java_com_sun_midp_chameleon_layers_PTILayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad144;
    /* @47 */	jbyte ___pad145;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* com/sun/midp/chameleon/layers/PTILayer */
    /* @56 */	jobject_array * JVM_FIELD_CONST list;
    /* @60 */	jint selId;
    /* @64 */	struct Java_com_sun_midp_chameleon_input_TextInputSession * JVM_FIELD_CONST iSession;
    /* @68 */	jint widthMax;
    /* @72 */	jboolean checkReleased;
    /* @73 */	jbyte ___pad146;
    /* @74 */	jbyte ___pad147;
    /* @75 */	jbyte ___pad148;
};

struct Java_com_sun_midp_chameleon_layers_VirtualKeyboardLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad149;
    /* @47 */	jbyte ___pad150;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST __dup1__listener;
    /* com/sun/midp/chameleon/layers/VirtualKeyboardLayer */
    /* @56 */	struct Java_com_sun_midp_chameleon_layers_VirtualKeyListener * JVM_FIELD_CONST listener;
    /* @60 */	jint defaultWidth;
    /* @64 */	jboolean virtualKeyboardVisible;
    /* @65 */	jboolean open;
    /* @66 */	jbyte ___pad151;
    /* @67 */	jbyte ___pad152;
};

struct Java_com_sun_midp_chameleon_layers_PopupLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad153;
    /* @47 */	jbyte ___pad154;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
};

struct Java_com_sun_midp_chameleon_layers_WashLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad155;
    /* @47 */	jbyte ___pad156;
    /* com/sun/midp/chameleon/layers/WashLayer */
};

struct Java_com_sun_midp_chameleon_MIDPWindow {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CWindow */
    /*  @4 */	jint_array * JVM_FIELD_CONST bounds;
    /*  @8 */	struct Java_com_sun_midp_chameleon_CLayerList * JVM_FIELD_CONST layers;
    /* @12 */	jint dirtyCount;
    /* @16 */	jint dirtyMaxCount;
    /* @20 */	jobject_array * JVM_FIELD_CONST dirtyLayers;
    /* @24 */	struct Java_com_sun_midp_chameleon_layers_BackgroundLayer * JVM_FIELD_CONST bgLayer;
    /* @28 */	jint cX;
    /* @32 */	jint cY;
    /* @36 */	jint cW;
    /* @40 */	jint cH;
    /* @44 */	jint tranX;
    /* @48 */	jint tranY;
    /* @52 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST font;
    /* @56 */	jint color;
    /* @60 */	jboolean dirty;
    /* @61 */	jbyte ___pad157;
    /* @62 */	jbyte ___pad158;
    /* @63 */	jbyte ___pad159;
    /* com/sun/midp/chameleon/MIDPWindow */
    /* @64 */	struct Java_com_sun_midp_chameleon_ChamDisplayTunnel * JVM_FIELD_CONST tunnel;
    /* @68 */	struct Java_com_sun_midp_chameleon_layers_WashLayer * JVM_FIELD_CONST washLayer;
    /* @72 */	struct Java_com_sun_midp_chameleon_layers_WashLayer * JVM_FIELD_CONST alertWashLayer;
    /* @76 */	struct Java_com_sun_midp_chameleon_layers_AlertLayer * JVM_FIELD_CONST alertLayer;
    /* @80 */	struct Java_com_sun_midp_chameleon_layers_TitleLayer * JVM_FIELD_CONST titleLayer;
    /* @84 */	struct Java_com_sun_midp_chameleon_layers_TickerLayer * JVM_FIELD_CONST tickerLayer;
    /* @88 */	struct Java_com_sun_midp_chameleon_layers_SoftButtonLayer * JVM_FIELD_CONST buttonLayer;
    /* @92 */	struct Java_com_sun_midp_chameleon_layers_PTILayer * JVM_FIELD_CONST ptiLayer;
    /* @96 */	struct Java_com_sun_midp_chameleon_layers_VirtualKeyboardLayer * JVM_FIELD_CONST keyboardLayer;
    /* @100 */	struct Java_com_sun_midp_chameleon_layers_BodyLayer * JVM_FIELD_CONST bodyLayer;
    /* @104 */	jint screenMode;
    /* @108 */	jobject_array * JVM_FIELD_CONST scrCmdCache;
    /* @112 */	jint scrCmdCount;
    /* @116 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST scrCmdListener;
    /* @120 */	jobject_array * JVM_FIELD_CONST itemCmdCache;
    /* @124 */	jint itemCmdCount;
    /* @128 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST itemCmdListener;
    /* @132 */	jobject_array * JVM_FIELD_CONST mainLayers;
    /* @136 */	jboolean sizeChangedOccured;
    /* @137 */	jboolean bodyChecked;
    /* @138 */	jboolean bodyOverlapped;
    /* @139 */	jbyte ___pad160;
};

struct Java_com_sun_midp_chameleon_layers_ScrollIndLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad161;
    /* @47 */	jbyte ___pad162;
    /* com/sun/midp/chameleon/layers/ScrollIndLayer */
    /* @48 */	struct Java_com_sun_midp_chameleon_CLayer * JVM_FIELD_CONST scrollable;
    /* @52 */	struct Java_com_sun_midp_chameleon_ScrollListener * JVM_FIELD_CONST listener;
    /* @56 */	jboolean alertMode;
    /* @57 */	jbyte ___pad163;
    /* @58 */	jbyte ___pad164;
    /* @59 */	jbyte ___pad165;
};

struct Java_com_sun_midp_chameleon_ScrollListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/ScrollListener */
};

struct Java_com_sun_midp_chameleon_layers_TickerLayer_00024TickerPainter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/chameleon/layers/TickerLayer$TickerPainter */
    /* @28 */	struct Java_com_sun_midp_chameleon_layers_TickerLayer * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_chameleon_layers_TickerLayer_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/layers/TickerLayer$1 */
};

struct Java_com_sun_midp_chameleon_layers_MenuLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad166;
    /* @47 */	jbyte ___pad167;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* com/sun/midp/chameleon/layers/ScrollablePopupLayer */
    /* @56 */	struct Java_com_sun_midp_chameleon_layers_ScrollIndLayer * JVM_FIELD_CONST scrollInd;
    /* com/sun/midp/chameleon/layers/MenuLayer */
    /* @60 */	jobject_array * JVM_FIELD_CONST menuCmds;
    /* @64 */	jint selI;
    /* @68 */	jint scrollIndex;
    /* @72 */	struct Java_com_sun_midp_chameleon_layers_SoftButtonLayer * JVM_FIELD_CONST btnLayer;
    /* @76 */	struct Java_com_sun_midp_chameleon_layers_CascadeMenuLayer * JVM_FIELD_CONST cascadeMenu;
    /* @80 */	jint itemIndexWhenPressed;
    /* @84 */	jboolean cascadeMenuUp;
    /* @85 */	jbyte ___pad168;
    /* @86 */	jbyte ___pad169;
    /* @87 */	jbyte ___pad170;
};

struct Java_com_sun_midp_chameleon_SubMenuCommand {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Command */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST shortLabel;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST longLabel;
    /* @12 */	jint commandType;
    /* @16 */	jint priority;
    /* @20 */	jint id;
    /* com/sun/midp/chameleon/SubMenuCommand */
    /* @24 */	jobject_array * JVM_FIELD_CONST subCommands;
    /* @28 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
};

struct Java_com_sun_midp_chameleon_layers_CascadeMenuLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad171;
    /* @47 */	jbyte ___pad172;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* com/sun/midp/chameleon/layers/ScrollablePopupLayer */
    /* @56 */	struct Java_com_sun_midp_chameleon_layers_ScrollIndLayer * JVM_FIELD_CONST scrollInd;
    /* com/sun/midp/chameleon/layers/CascadeMenuLayer */
    /* @60 */	jobject_array * JVM_FIELD_CONST menuCmds;
    /* @64 */	jint selI;
    /* @68 */	jint scrollIndex;
    /* @72 */	struct Java_com_sun_midp_chameleon_layers_MenuLayer * JVM_FIELD_CONST menuLayer;
    /* @76 */	jint itemIndexWhenPressed;
};

struct Java_com_sun_midp_chameleon_input_InputModeMediator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/InputModeMediator */
};

struct Java_com_sun_midp_chameleon_input_InputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/InputMode */
};

struct Java_com_sun_midp_chameleon_input_BasicInputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/BasicInputMode */
    /*  @4 */	jint constraints;
    /*  @8 */	jint modifiers;
    /* @12 */	jint lastKey;
    /* @16 */	struct Java_com_sun_midp_chameleon_input_InputModeMediator * JVM_FIELD_CONST mediator;
    /* @20 */	jint clickCount;
    /* @24 */	jint pendingChar;
    /* @28 */	jboolean commitChar;
    /* @29 */	jboolean hasMoreMatches;
    /* @30 */	jboolean sessionIsLive;
    /* @31 */	jbyte ___pad173;
};

struct Java_com_sun_midp_chameleon_input_AlphaNumericInputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/BasicInputMode */
    /*  @4 */	jint constraints;
    /*  @8 */	jint modifiers;
    /* @12 */	jint lastKey;
    /* @16 */	struct Java_com_sun_midp_chameleon_input_InputModeMediator * JVM_FIELD_CONST mediator;
    /* @20 */	jint clickCount;
    /* @24 */	jint pendingChar;
    /* @28 */	jboolean commitChar;
    /* @29 */	jboolean hasMoreMatches;
    /* @30 */	jboolean sessionIsLive;
    /* @31 */	jbyte ___pad174;
    /* com/sun/midp/chameleon/input/AlphaNumericInputMode */
    /* @32 */	jint capsModePointer;
};

struct Java_com_sun_midp_chameleon_input_TextInputComponent {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/TextInputComponent */
};

struct Java_com_sun_midp_chameleon_input_TextInputSession {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/TextInputSession */
};

struct Java_com_sun_midp_chameleon_input_BasicTextInputSession {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/BasicTextInputSession */
    /*  @4 */	struct Java_com_sun_midp_chameleon_input_InputMode * JVM_FIELD_CONST currentMode;
    /*  @8 */	jobject_array * JVM_FIELD_CONST inputModeSet;
    /* @12 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST currentDisplay;
    /* @16 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST previousScreen;
    /* @20 */	struct Java_com_sun_midp_chameleon_input_InputMode * JVM_FIELD_CONST stickyMode;
    /* @24 */	struct Java_com_sun_midp_chameleon_input_TextInputComponent * JVM_FIELD_CONST textComponent;
};

struct Java_com_sun_midp_chameleon_input_InputModeFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/InputModeFactory */
};

struct Java_com_sun_midp_chameleon_input_NativeInputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/NativeInputMode */
    /*  @4 */	jint STATE_CALLBACK_RES;
    /*  @8 */	jint STATE_FUNC_TOKEN;
    /* @12 */	jint STATE_NEXT_STATE;
    /* @16 */	jint STATE_INT_ARG;
    /* @20 */	jint STATE_FINAL_RES;
    /* @24 */	jint STATE_INTERNAL;
    /* @28 */	jint STATE_INTERNAL_EXT;
    /* @32 */	jint STATE_DATA_ARRAY_SIZE;
    /* @36 */	jint MEDIATOR_NOOP;
    /* @40 */	jint MEDIATOR_COMMIT;
    /* @44 */	jint MEDIATOR_CLEAR;
    /* @48 */	jint MEDIATOR_SUBINPUTMODECHANGED;
    /* @52 */	jint MEDIATOR_INPUTMODECOMPLETED;
    /* @56 */	jint MEDIATOR_ISCLEARKEY;
    /* @60 */	jint MEDIATOR_GETAVAILABLESIZE;
    /* @64 */	jint id;
    /* @68 */	jint instanceData;
    /* @72 */	struct Java_com_sun_midp_chameleon_input_InputModeMediator * JVM_FIELD_CONST mediator;
    /* @76 */	jobject_array * JVM_FIELD_CONST isMap;
};

struct Java_com_sun_midp_chameleon_input_KeyboardInputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/KeyboardInputMode */
    /*  @4 */	jint lastKey;
    /*  @8 */	struct Java_com_sun_midp_chameleon_input_InputModeMediator * JVM_FIELD_CONST mediator;
};

struct Java_com_sun_midp_chameleon_input_NumericInputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/BasicInputMode */
    /*  @4 */	jint constraints;
    /*  @8 */	jint modifiers;
    /* @12 */	jint lastKey;
    /* @16 */	struct Java_com_sun_midp_chameleon_input_InputModeMediator * JVM_FIELD_CONST mediator;
    /* @20 */	jint clickCount;
    /* @24 */	jint pendingChar;
    /* @28 */	jboolean commitChar;
    /* @29 */	jboolean hasMoreMatches;
    /* @30 */	jboolean sessionIsLive;
    /* @31 */	jbyte ___pad175;
    /* com/sun/midp/chameleon/input/NumericInputMode */
    /* @32 */	jobject_array * JVM_FIELD_CONST numericKeyMap;
    /* @36 */	jobject_array * JVM_FIELD_CONST decimalKeyMap;
    /* @40 */	jobject_array * JVM_FIELD_CONST phoneNumericKeyMap;
    /* @44 */	jobject_array * JVM_FIELD_CONST anyKeyMap;
};

struct Java_com_sun_midp_chameleon_input_PTIterator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/PTIterator */
};

struct Java_com_sun_midp_chameleon_input_PTDictionary {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/PTDictionary */
};

struct Java_java_util_Hashtable {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Hashtable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST table;
    /*  @8 */	jint count;
    /* @12 */	jint threshold;
};

struct Java_com_sun_midp_chameleon_input_PTDictionaryFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/PTDictionaryFactory */
};

struct Java_com_sun_midp_chameleon_input_PTDictionaryImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/PTDictionaryImpl */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST language;
    /*  @8 */	struct Java_com_sun_midp_chameleon_input_PTIterator * JVM_FIELD_CONST iterator;
};

struct Java_com_sun_midp_chameleon_input_PTIteratorImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/PTIteratorImpl */
    /*  @4 */	struct Java_java_lang_StringBuffer * JVM_FIELD_CONST buffer;
    /*  @8 */	jint selected;
    /* @12 */	jobject_array * JVM_FIELD_CONST keyMap;
    /* @16 */	jobject_array * JVM_FIELD_CONST list;
    /* @20 */	struct Java_java_util_Vector * JVM_FIELD_CONST states;
};

struct Java_com_sun_midp_chameleon_input_PredictiveTextInputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/PredictiveTextInputMode */
    /*  @4 */	struct Java_com_sun_midp_chameleon_input_InputModeMediator * JVM_FIELD_CONST mediator;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST part;
    /* @12 */	struct Java_com_sun_midp_chameleon_input_PTIterator * JVM_FIELD_CONST iterator;
    /* @16 */	struct Java_com_sun_midp_chameleon_input_PredictiveTextInputMode_00024StringDiff * JVM_FIELD_CONST diff;
    /* @20 */	jint capsMode;
};

struct Java_com_sun_midp_chameleon_input_PredictiveTextInputMode_00024StringDiff {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/PredictiveTextInputMode$StringDiff */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST state;
    /*  @8 */	struct Java_com_sun_midp_chameleon_input_PredictiveTextInputMode * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_chameleon_input_SymbolInputMode_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/SymbolInputMode$1 */
};

struct Java_com_sun_midp_chameleon_input_SymbolInputMode_00024SymbolTable {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad176;
    /* @31 */	jbyte ___pad177;
    /* javax/microedition/lcdui/Canvas */
    /* @32 */	struct Java_javax_microedition_lcdui_CanvasLF * JVM_FIELD_CONST canvasLF;
    /* @36 */	jboolean suppressKeyEvents;
    /* @37 */	jbyte ___pad178;
    /* @38 */	jbyte ___pad179;
    /* @39 */	jbyte ___pad180;
    /* com/sun/midp/chameleon/input/SymbolInputMode$SymbolTable */
    /* @40 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST okCmd;
    /* @44 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST backCmd;
    /* @48 */	jint cellSize;
    /* @52 */	jint hmargin;
    /* @56 */	jint wmargin;
    /* @60 */	jint margin;
    /* @64 */	jint wx;
    /* @68 */	jint wy;
    /* @72 */	jint ww;
    /* @76 */	jint wh;
    /* @80 */	jint cols;
    /* @84 */	jint rows;
    /* @88 */	jint pos;
    /* @92 */	jint newpos;
    /* @96 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST font;
    /* @100 */	jint x_cursor_coord;
    /* @104 */	jint y_cursor_coord;
    /* @108 */	jint defaultSymbolCursorPos;
    /* @112 */	struct Java_java_lang_Runnable * JVM_FIELD_CONST accept;
    /* @116 */	struct Java_java_lang_Runnable * JVM_FIELD_CONST reject;
    /* @120 */	struct Java_com_sun_midp_chameleon_input_SymbolInputMode * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_chameleon_input_SymbolInputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/SymbolInputMode */
    /*  @4 */	jint lastKey;
    /*  @8 */	struct Java_com_sun_midp_chameleon_input_InputModeMediator * JVM_FIELD_CONST mediator;
    /* @12 */	struct Java_com_sun_midp_chameleon_input_SymbolInputMode_00024SymbolTable * JVM_FIELD_CONST st;
};

struct Java_com_sun_midp_chameleon_input_SymbolInputMode_00024SymbolTable_00024Accept {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/SymbolInputMode$SymbolTable$Accept */
    /*  @4 */	struct Java_com_sun_midp_chameleon_input_SymbolInputMode_00024SymbolTable * JVM_FIELD_CONST this_0441;
};

struct Java_com_sun_midp_chameleon_input_SymbolInputMode_00024SymbolTable_00024Reject {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/SymbolInputMode$SymbolTable$Reject */
    /*  @4 */	struct Java_com_sun_midp_chameleon_input_SymbolInputMode_00024SymbolTable * JVM_FIELD_CONST this_0441;
};

struct Java_com_sun_midp_chameleon_input_VirtualKeyboardInputMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/input/KeyboardInputMode */
    /*  @4 */	jint lastKey;
    /*  @8 */	struct Java_com_sun_midp_chameleon_input_InputModeMediator * JVM_FIELD_CONST mediator;
    /* com/sun/midp/chameleon/input/VirtualKeyboardInputMode */
};

struct Java_com_sun_midp_lcdui_Key {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/Key */
    /*  @4 */	jint key;
    /*  @8 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST keyImage;
    /* @12 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST keyImageSelected;
    /* @16 */	jint keyType;
    /* @20 */	jint x;
    /* @24 */	jint y;
    /* @28 */	jint width;
    /* @32 */	jint height;
    /* @36 */	jint startX;
    /* @40 */	jint startY;
};

struct Java_com_sun_midp_chameleon_keyboards_Keyboards {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/keyboards/Keyboards */
};

struct Java_com_sun_midp_chameleon_layers_ScrollablePopupLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad181;
    /* @47 */	jbyte ___pad182;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* com/sun/midp/chameleon/layers/ScrollablePopupLayer */
    /* @56 */	struct Java_com_sun_midp_chameleon_layers_ScrollIndLayer * JVM_FIELD_CONST scrollInd;
};

struct Java_com_sun_midp_chameleon_layers_InputModeLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad183;
    /* @47 */	jbyte ___pad184;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* com/sun/midp/chameleon/layers/InputModeLayer */
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST mode;
    /* @60 */	jint stringWidth;
    /* @64 */	jint stringHeight;
    /* @68 */	jint_array * JVM_FIELD_CONST anchor;
};

struct Java_com_sun_midp_chameleon_layers_ScrollArrowLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad185;
    /* @47 */	jbyte ___pad186;
    /* com/sun/midp/chameleon/layers/ScrollIndLayer */
    /* @48 */	struct Java_com_sun_midp_chameleon_CLayer * JVM_FIELD_CONST scrollable;
    /* @52 */	struct Java_com_sun_midp_chameleon_ScrollListener * JVM_FIELD_CONST listener;
    /* @56 */	jboolean alertMode;
    /* @57 */	jbyte ___pad187;
    /* @58 */	jbyte ___pad188;
    /* @59 */	jbyte ___pad189;
    /* com/sun/midp/chameleon/layers/ScrollArrowLayer */
    /* @60 */	jboolean upViz;
    /* @61 */	jboolean downViz;
    /* @62 */	jbyte ___pad190;
    /* @63 */	jbyte ___pad191;
};

struct Java_com_sun_midp_chameleon_layers_ScrollBarLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad192;
    /* @47 */	jbyte ___pad193;
    /* com/sun/midp/chameleon/layers/ScrollIndLayer */
    /* @48 */	struct Java_com_sun_midp_chameleon_CLayer * JVM_FIELD_CONST scrollable;
    /* @52 */	struct Java_com_sun_midp_chameleon_ScrollListener * JVM_FIELD_CONST listener;
    /* @56 */	jboolean alertMode;
    /* @57 */	jbyte ___pad194;
    /* @58 */	jbyte ___pad195;
    /* @59 */	jbyte ___pad196;
    /* com/sun/midp/chameleon/layers/ScrollBarLayer */
    /* @60 */	jint lastx;
    /* @64 */	jint lasty;
    /* @68 */	jint gap;
    /* @72 */	jint scrollType;
    /* @76 */	jint proportion;
    /* @80 */	jint position;
    /* @84 */	jint thumbY;
    /* @88 */	jint thumbHeight;
    /* @92 */	jint barHeight;
    /* @96 */	struct Java_java_util_Timer * JVM_FIELD_CONST aT;
};

struct Java_com_sun_midp_chameleon_layers_ScrollBarLayer_00024ArrowTimerTask {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/chameleon/layers/ScrollBarLayer$ArrowTimerTask */
    /* @28 */	struct Java_com_sun_midp_chameleon_layers_ScrollBarLayer * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_chameleon_layers_VirtualKeyListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/layers/VirtualKeyListener */
};

struct Java_com_sun_midp_lcdui_VirtualKeyboard {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/VirtualKeyboard */
    /*  @4 */	struct Java_com_sun_midp_lcdui_VirtualKeyboardListener * JVM_FIELD_CONST vkl;
    /*  @8 */	struct Java_java_util_Hashtable * JVM_FIELD_CONST keyboardsMap;
    /* @12 */	jint line;
    /* @16 */	jint column;
    /* @20 */	struct Java_com_sun_midp_lcdui_Key * JVM_FIELD_CONST currentKey;
    /* @24 */	jobject_array * JVM_FIELD_CONST currentKeyboard;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST currentKeyboardType;
    /* @32 */	jdouble shrinkX;
    /* @40 */	jdouble shrinkY;
};

struct Java_com_sun_midp_lcdui_VirtualKeyboardListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/VirtualKeyboardListener */
};

struct Java_com_sun_midp_chameleon_skins_AlertSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/AlertSkin */
};

struct Java_com_sun_midp_chameleon_skins_BusyCursorSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/BusyCursorSkin */
};

struct Java_com_sun_midp_chameleon_skins_ChoiceGroupSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/ChoiceGroupSkin */
};

struct Java_com_sun_midp_chameleon_skins_DateEditorSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/DateEditorSkin */
};

struct Java_com_sun_midp_chameleon_skins_DateFieldSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/DateFieldSkin */
};

struct Java_com_sun_midp_chameleon_skins_GaugeSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/GaugeSkin */
};

struct Java_com_sun_midp_chameleon_skins_ImageItemSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/ImageItemSkin */
};

struct Java_com_sun_midp_chameleon_skins_InputModeSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/InputModeSkin */
};

struct Java_com_sun_midp_chameleon_skins_MenuSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/MenuSkin */
};

struct Java_com_sun_midp_chameleon_skins_PTISkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/PTISkin */
};

struct Java_com_sun_midp_chameleon_skins_ProgressBarSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/ProgressBarSkin */
};

struct Java_com_sun_midp_chameleon_skins_ScreenSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/ScreenSkin */
};

struct Java_com_sun_midp_chameleon_skins_ScrollIndSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/ScrollIndSkin */
};

struct Java_com_sun_midp_chameleon_skins_SkinPropertiesIDs {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/SkinPropertiesIDs */
};

struct Java_com_sun_midp_chameleon_skins_SoftButtonSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/SoftButtonSkin */
};

struct Java_com_sun_midp_chameleon_skins_StringItemSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/StringItemSkin */
};

struct Java_com_sun_midp_chameleon_skins_TextFieldSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/TextFieldSkin */
};

struct Java_com_sun_midp_chameleon_skins_TickerSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/TickerSkin */
};

struct Java_com_sun_midp_chameleon_skins_TitleSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/TitleSkin */
};

struct Java_com_sun_midp_chameleon_skins_UpdateBarSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/UpdateBarSkin */
};

struct Java_com_sun_midp_chameleon_skins_VirtualKeyboardSkin {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/VirtualKeyboardSkin */
};

struct Java_com_sun_midp_chameleon_skins_resources_AlertResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/AlertResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_BusyCursorResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/BusyCursorResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_ChoiceGroupResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/ChoiceGroupResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_DateEditorResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/DateEditorResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_DateFieldResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/DateFieldResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_FontResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/FontResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_FontResourcesConstants {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/FontResourcesConstants */
};

struct Java_com_sun_midp_chameleon_skins_resources_GaugeResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/GaugeResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_ImageItemResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/ImageItemResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_InputModeResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/InputModeResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_LoadedSkinData {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/LoadedSkinData */
    /*  @4 */	jint_array * JVM_FIELD_CONST properties;
    /*  @8 */	jint_array * JVM_FIELD_CONST intSeqValues;
    /* @12 */	jobject_array * JVM_FIELD_CONST stringValues;
    /* @16 */	jint_array * JVM_FIELD_CONST fontValues;
    /* @20 */	jobject_array * JVM_FIELD_CONST imageValues;
    /* @24 */	jint_array * JVM_FIELD_CONST romizedImageIndexes;
};

struct Java_com_sun_midp_chameleon_skins_resources_LoadedSkinResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/LoadedSkinResources */
    /*  @4 */	jobject_array * JVM_FIELD_CONST fonts;
    /*  @8 */	jobject_array * JVM_FIELD_CONST images;
};

struct Java_com_sun_midp_chameleon_skins_resources_MenuResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/MenuResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_PTIResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/PTIResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_ProgressBarResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/ProgressBarResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_ScreenResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/ScreenResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_ScrollIndResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/ScrollIndResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_ScrollIndResourcesConstants {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/ScrollIndResourcesConstants */
};

struct Java_com_sun_midp_chameleon_skins_resources_SkinResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/SkinResources */
    /*  @4 */	struct Java_com_sun_midp_lcdui_GraphicsAccess * JVM_FIELD_CONST graphicsAccess;
};

struct Java_com_sun_midp_lcdui_GraphicsAccess {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/GraphicsAccess */
};

struct Java_com_sun_midp_chameleon_skins_resources_SkinLoader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/SkinLoader */
};

struct Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/SkinResourcesImpl$1 */
};

struct Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/SkinResources */
    /*  @4 */	struct Java_com_sun_midp_lcdui_GraphicsAccess * JVM_FIELD_CONST graphicsAccess;
    /* com/sun/midp/chameleon/skins/resources/SkinResourcesImpl */
};

struct Java_com_sun_midp_chameleon_skins_resources_SkinResourcesConstants {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/SkinResourcesConstants */
};

struct Java_com_sun_midp_chameleon_skins_resources_SkinResourcesImpl_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/SkinResourcesImpl$SecurityTrusted */
};

struct Java_com_sun_midp_chameleon_skins_resources_SoftButtonResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/SoftButtonResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_StringItemResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/StringItemResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_TextFieldResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/TextFieldResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_TickerResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/TickerResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_TitleResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/TitleResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_UpdateBarResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/UpdateBarResources */
};

struct Java_com_sun_midp_chameleon_skins_resources_VirtualKeyboardResources {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/skins/resources/VirtualKeyboardResources */
};

struct Java_com_sun_midp_configurator_AlertTypeConstants {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/configurator/AlertTypeConstants */
};

struct Java_com_sun_midp_configurator_Constants {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/configurator/Constants */
};

struct Java_com_sun_midp_content_CHManager {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/content/CHManager */
};

struct Java_com_sun_midp_installer_Installer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/Installer */
    /*  @4 */	struct Java_com_sun_midp_installer_Verifier * JVM_FIELD_CONST verifier;
    /*  @8 */	struct Java_com_sun_midp_installer_InstallStateImpl * JVM_FIELD_CONST state;
    /* @12 */	struct Java_com_sun_j2me_security_AccessControlContext * JVM_FIELD_CONST accessControlContext;
    /* @16 */	struct Java_com_sun_midp_midletsuite_InstallInfo * JVM_FIELD_CONST info;
    /* @20 */	struct Java_com_sun_midp_midletsuite_SuiteSettings * JVM_FIELD_CONST settings;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST cldcConfig;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST cldcRuntimeEnv;
    /* @32 */	struct Java_java_util_Vector * JVM_FIELD_CONST supportedProfiles;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST unsignedSecurityDomain;
    /* @40 */	struct Java_java_lang_String * JVM_FIELD_CONST additionalPermissions;
};

struct Java_com_sun_midp_installer_InstallState {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/InstallState */
};

struct Java_com_sun_midp_crypto_GeneralSecurityException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
};

struct Java_com_sun_midp_crypto_BadPaddingException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/BadPaddingException */
};

struct Java_com_sun_midp_crypto_Key {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/Key */
};

struct Java_com_sun_midp_crypto_CryptoParameter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/CryptoParameter */
};

struct Java_com_sun_midp_crypto_Cipher {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/Cipher */
};

struct Java_com_sun_midp_crypto_NoSuchAlgorithmException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/NoSuchAlgorithmException */
};

struct Java_com_sun_midp_crypto_InvalidAlgorithmParameterException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/InvalidAlgorithmParameterException */
};

struct Java_com_sun_midp_crypto_InvalidKeyException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/InvalidKeyException */
};

struct Java_com_sun_midp_crypto_RSAKey {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/RSAKey */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST exp;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST mod;
};

struct Java_com_sun_midp_crypto_DEREncoder {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/DEREncoder */
};

struct Java_com_sun_midp_crypto_DigestException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/DigestException */
};

struct Java_com_sun_midp_crypto_IllegalBlockSizeException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/IllegalBlockSizeException */
};

struct Java_com_sun_midp_crypto_InvalidKeySpecException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/InvalidKeySpecException */
};

struct Java_com_sun_midp_crypto_IvParameter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/IvParameter */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST IV;
};

struct Java_com_sun_midp_crypto_MessageDigest {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/MessageDigest */
};

struct Java_com_sun_midp_crypto_MD2 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/MessageDigest */
    /* com/sun/midp/crypto/MD2 */
    /*  @4 */	jint_array * JVM_FIELD_CONST num;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST data;
    /* @12 */	jint_array * JVM_FIELD_CONST cksm;
    /* @16 */	jint_array * JVM_FIELD_CONST state;
};

struct Java_com_sun_midp_crypto_MD5 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/MessageDigest */
    /* com/sun/midp/crypto/MD5 */
    /*  @4 */	jint_array * JVM_FIELD_CONST state;
    /*  @8 */	jint_array * JVM_FIELD_CONST num;
    /* @12 */	jint_array * JVM_FIELD_CONST count;
    /* @16 */	jint_array * JVM_FIELD_CONST data;
};

struct Java_com_sun_midp_crypto_SHA {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/MessageDigest */
    /* com/sun/midp/crypto/SHA */
    /*  @4 */	jint_array * JVM_FIELD_CONST state;
    /*  @8 */	jint_array * JVM_FIELD_CONST num;
    /* @12 */	jint_array * JVM_FIELD_CONST count;
    /* @16 */	jint_array * JVM_FIELD_CONST data;
};

struct Java_com_sun_midp_crypto_NoSuchPaddingException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/NoSuchPaddingException */
};

struct Java_com_sun_midp_crypto_Padder {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/Padder */
};

struct Java_com_sun_midp_crypto_PKCS5Padding {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/PKCS5Padding */
    /*  @4 */	jint blockSize;
};

struct Java_com_sun_midp_crypto_SecureRandom {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/SecureRandom */
};

struct Java_com_sun_midp_crypto_PRand {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/SecureRandom */
    /* com/sun/midp/crypto/PRand */
};

struct Java_com_sun_midp_crypto_PrivateKey {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/PrivateKey */
};

struct Java_com_sun_midp_crypto_PublicKey {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/PublicKey */
};

struct Java_com_sun_midp_crypto_RSAPrivateKey {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/RSAKey */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST exp;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST mod;
    /* com/sun/midp/crypto/RSAPrivateKey */
};

struct Java_com_sun_midp_crypto_RSAPublicKey {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/RSAKey */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST exp;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST mod;
    /* com/sun/midp/crypto/RSAPublicKey */
};

struct Java_com_sun_midp_crypto_SecretKey {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/SecretKey */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST alg;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST secret;
};

struct Java_com_sun_midp_crypto_ShortBufferException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/ShortBufferException */
};

struct Java_com_sun_midp_crypto_Signature {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/Signature */
};

struct Java_com_sun_midp_crypto_SignatureException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/crypto/GeneralSecurityException */
    /* com/sun/midp/crypto/SignatureException */
};

struct Java_com_sun_midp_crypto_Util {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/crypto/Util */
};

struct Java_com_sun_midp_events_DispatchData {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/DispatchData */
    /*  @4 */	struct Java_com_sun_midp_events_EventListener * JVM_FIELD_CONST listener;
    /*  @8 */	struct Java_com_sun_midp_events_Event * JVM_FIELD_CONST waitingEvent;
};

struct Java_com_sun_midp_events_NativeEventPool {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/NativeEventPool */
    /*  @4 */	jobject_array * JVM_FIELD_CONST eventStack;
    /*  @8 */	jint eventsInPool;
};

struct Java_com_sun_midp_events_NativeEvent {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/Event */
    /*  @4 */	jint type;
    /*  @8 */	struct Java_com_sun_midp_events_Event * JVM_FIELD_CONST next;
    /* com/sun/midp/events/NativeEvent */
    /* @12 */	jint intParam1;
    /* @16 */	jint intParam2;
    /* @20 */	jint intParam3;
    /* @24 */	jint intParam4;
    /* @28 */	jint intParam5;
    /* @32 */	jint intParam6;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST stringParam1;
    /* @40 */	struct Java_java_lang_String * JVM_FIELD_CONST stringParam2;
    /* @44 */	struct Java_java_lang_String * JVM_FIELD_CONST stringParam3;
    /* @48 */	struct Java_java_lang_String * JVM_FIELD_CONST stringParam4;
    /* @52 */	struct Java_java_lang_String * JVM_FIELD_CONST stringParam5;
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST stringParam6;
};

struct Java_com_sun_midp_events_NativeEventMonitor {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/NativeEventMonitor */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST eventQueueLock;
    /*  @8 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
    /* @12 */	struct Java_com_sun_midp_events_NativeEventPool * JVM_FIELD_CONST pool;
};

struct Java_com_sun_midp_events_EventTypes {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/EventTypes */
};

struct Java_com_sun_midp_i18n_ResourceBundle {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/i18n/ResourceBundle */
};

struct Java_com_sun_midp_i18n_Resource {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/i18n/Resource */
};

struct Java_com_sun_midp_l10n_LocalizedStringsBase {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/l10n/LocalizedStringsBase */
};

struct Java_com_sun_midp_l10n_LocalizedStrings {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/l10n/LocalizedStringsBase */
    /* com/sun/midp/l10n/LocalizedStrings */
};

struct Java_com_sun_midp_i18n_ResourceConstants {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/i18n/ResourceConstants */
};

struct Java_com_sun_midp_installer_AccessControl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2me/security/AccessControlContextAdapter */
    /* com/sun/midp/installer/AccessControl */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST suite;
};

struct Java_com_sun_midp_installer_AutoTesterHelper {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/AutoTesterHelperBase */
    /*  @4 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /*  @8 */	struct Java_com_sun_midp_installer_Installer * JVM_FIELD_CONST installer;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST domain;
    /* @20 */	jint loopCount;
    /* com/sun/midp/installer/AutoTesterHelper */
    /* @24 */	jint suiteId;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST midletClassName;
};

struct Java_javax_microedition_lcdui_TextField {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/TextField */
    /* @52 */	struct Java_javax_microedition_lcdui_TextFieldLF * JVM_FIELD_CONST textFieldLF;
    /* @56 */	struct Java_com_sun_midp_lcdui_DynamicCharacterArray * JVM_FIELD_CONST buffer;
    /* @60 */	jint constraints;
    /* @64 */	struct Java_java_lang_String * JVM_FIELD_CONST initialInputMode;
};

struct Java_com_sun_midp_installer_AutoTesterBase {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/installer/AutoTesterBase */
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST domain;
    /* @16 */	jint loopCount;
    /* @20 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @24 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST parameterForm;
    /* @28 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST urlTextField;
    /* @32 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST domainTextField;
    /* @36 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST endCmd;
    /* @40 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST testCmd;
};

struct Java_com_sun_midp_installer_AutoTester {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/installer/AutoTesterBase */
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST domain;
    /* @16 */	jint loopCount;
    /* @20 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @24 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST parameterForm;
    /* @28 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST urlTextField;
    /* @32 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST domainTextField;
    /* @36 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST endCmd;
    /* @40 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST testCmd;
    /* com/sun/midp/installer/AutoTester */
    /* @44 */	struct Java_com_sun_midp_installer_AutoTesterHelper * JVM_FIELD_CONST helper;
};

struct Java_com_sun_midp_lcdui_DynamicCharacterArray {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DynamicCharacterArray */
    /*  @4 */	jchar_array * JVM_FIELD_CONST buffer;
    /*  @8 */	jint length;
};

struct Java_javax_microedition_lcdui_TextFieldLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/TextFieldLF */
};

struct Java_com_sun_midp_installer_InstallListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/InstallListener */
};

struct Java_com_sun_midp_installer_InvalidJadException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* com/sun/midp/installer/InvalidJadException */
    /* @12 */	jint reason;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST extraData;
};

struct Java_com_sun_midp_installer_AutoTesterHelperBase {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/AutoTesterHelperBase */
    /*  @4 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /*  @8 */	struct Java_com_sun_midp_installer_Installer * JVM_FIELD_CONST installer;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST domain;
    /* @20 */	jint loopCount;
};

struct Java_javax_microedition_rms_RecordStoreNotFoundException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* javax/microedition/rms/RecordStoreException */
    /* javax/microedition/rms/RecordStoreNotFoundException */
};

struct Java_com_sun_midp_installer_InstallStateImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/InstallStateImpl */
    /*  @4 */	struct Java_com_sun_midp_midletsuite_InstallInfo * JVM_FIELD_CONST installInfo;
    /*  @8 */	struct Java_com_sun_midp_midletsuite_SuiteSettings * JVM_FIELD_CONST suiteSettings;
    /* @12 */	jint storageId;
    /* @16 */	struct Java_com_sun_midp_installer_InstallListener * JVM_FIELD_CONST listener;
    /* @20 */	jlong startTime;
    /* @28 */	jint nextStep;
    /* @32 */	struct Java_com_sun_midp_installer_InvalidJadException * JVM_FIELD_CONST exception;
    /* @36 */	jbyte_array * JVM_FIELD_CONST jad;
    /* @40 */	struct Java_java_lang_String * JVM_FIELD_CONST jadEncoding;
    /* @44 */	struct Java_com_sun_midp_installer_JadProperties * JVM_FIELD_CONST jadProps;
    /* @48 */	struct Java_com_sun_midp_installer_ManifestProperties * JVM_FIELD_CONST jarProps;
    /* @52 */	struct Java_com_sun_midp_io_j2me_storage_File * JVM_FIELD_CONST file;
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST username;
    /* @60 */	struct Java_java_lang_String * JVM_FIELD_CONST password;
    /* @64 */	struct Java_java_lang_String * JVM_FIELD_CONST proxyUsername;
    /* @68 */	struct Java_java_lang_String * JVM_FIELD_CONST proxyPassword;
    /* @72 */	jint beginTransferDataStatus;
    /* @76 */	jint transferStatus;
    /* @80 */	struct Java_com_sun_midp_security_SecurityHandler * JVM_FIELD_CONST securityHandler;
    /* @84 */	jbyte_array * JVM_FIELD_CONST manifest;
    /* @88 */	struct Java_com_sun_midp_io_j2me_storage_RandomAccessStream * JVM_FIELD_CONST storage;
    /* @92 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST midletSuiteStorage;
    /* @96 */	struct Java_java_lang_String * JVM_FIELD_CONST storageRoot;
    /* @100 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteImpl * JVM_FIELD_CONST previousSuite;
    /* @104 */	struct Java_com_sun_midp_midletsuite_InstallInfo * JVM_FIELD_CONST previousInstallInfo;
    /* @108 */	struct Java_com_sun_midp_content_CHManager * JVM_FIELD_CONST chmanager;
    /* @112 */	jboolean stopInstallation;
    /* @113 */	jboolean ignoreCancel;
    /* @114 */	jboolean force;
    /* @115 */	jboolean removeRMS;
    /* @116 */	jboolean isPreviousVersion;
    /* @117 */	jbyte ___pad197;
    /* @118 */	jbyte ___pad198;
    /* @119 */	jbyte ___pad199;
};

struct Java_javax_microedition_io_HttpConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/HttpConnection */
};

struct Java_com_sun_midp_installer_Verifier {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/Verifier */
};

struct Java_com_sun_midp_io_j2me_storage_File {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/storage/File */
};

struct Java_com_sun_midp_installer_JadProperties {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/util/Properties */
    /*  @4 */	jobject_array * JVM_FIELD_CONST initProps;
    /*  @8 */	struct Java_java_util_Vector * JVM_FIELD_CONST keys;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST vals;
    /* com/sun/midp/installer/JadProperties */
    /* @16 */	jchar_array * JVM_FIELD_CONST lineBuffer;
};

struct Java_com_sun_midp_io_j2me_storage_RandomAccessStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/ConnectionBaseAdapter */
    /*  @4 */	jint iStreams;
    /*  @8 */	jint maxIStreams;
    /* @12 */	jint oStreams;
    /* @16 */	jint maxOStreams;
    /* @20 */	jboolean connectionOpen;
    /* @21 */	jbyte ___pad200;
    /* @22 */	jbyte ___pad201;
    /* @23 */	jbyte ___pad202;
    /* com/sun/midp/io/j2me/storage/RandomAccessStream */
    /* @24 */	jint handle;
};

struct Java_com_sun_midp_installer_ManifestProperties {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/util/Properties */
    /*  @4 */	jobject_array * JVM_FIELD_CONST initProps;
    /*  @8 */	struct Java_java_util_Vector * JVM_FIELD_CONST keys;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST vals;
    /* com/sun/midp/installer/JadProperties */
    /* @16 */	jchar_array * JVM_FIELD_CONST lineBuffer;
    /* com/sun/midp/installer/ManifestProperties */
    /* @20 */	jint remainder;
};

struct Java_com_sun_midp_util_Properties {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/util/Properties */
    /*  @4 */	jobject_array * JVM_FIELD_CONST initProps;
    /*  @8 */	struct Java_java_util_Vector * JVM_FIELD_CONST keys;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST vals;
};

struct Java_com_sun_midp_installer_HttpInstaller {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/Installer */
    /*  @4 */	struct Java_com_sun_midp_installer_Verifier * JVM_FIELD_CONST verifier;
    /*  @8 */	struct Java_com_sun_midp_installer_InstallStateImpl * JVM_FIELD_CONST state;
    /* @12 */	struct Java_com_sun_j2me_security_AccessControlContext * JVM_FIELD_CONST accessControlContext;
    /* @16 */	struct Java_com_sun_midp_midletsuite_InstallInfo * JVM_FIELD_CONST info;
    /* @20 */	struct Java_com_sun_midp_midletsuite_SuiteSettings * JVM_FIELD_CONST settings;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST cldcConfig;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST cldcRuntimeEnv;
    /* @32 */	struct Java_java_util_Vector * JVM_FIELD_CONST supportedProfiles;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST unsignedSecurityDomain;
    /* @40 */	struct Java_java_lang_String * JVM_FIELD_CONST additionalPermissions;
    /* com/sun/midp/installer/HttpInstaller */
    /* @44 */	struct Java_javax_microedition_io_HttpConnection * JVM_FIELD_CONST httpConnection;
    /* @48 */	struct Java_java_io_InputStream * JVM_FIELD_CONST httpInputStream;
};

struct Java_com_sun_midp_installer_AutoTesterServiceInitializer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/AutoTesterServiceInitializer */
};

struct Java_com_sun_midp_installer_DiscoveryApp_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/DiscoveryApp$1 */
};

struct Java_com_sun_midp_installer_DiscoveryApp {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/installer/DiscoveryApp */
    /*  @8 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST defaultInstallListUrl;
    /* @16 */	struct Java_javax_microedition_lcdui_TextBox * JVM_FIELD_CONST urlTextBox;
    /* @20 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST progressForm;
    /* @24 */	jint progressGaugeIndex;
    /* @28 */	jint progressUrlIndex;
    /* @32 */	jlong lastDisplayChange;
    /* @40 */	struct Java_javax_microedition_lcdui_List * JVM_FIELD_CONST installListBox;
    /* @44 */	struct Java_java_util_Vector * JVM_FIELD_CONST installList;
    /* @48 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST discoverCmd;
    /* @52 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST installCmd;
    /* @56 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST backCmd;
    /* @60 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST saveCmd;
    /* @64 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST endCmd;
    /* @68 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST fileStorage;
    /* @72 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST httpStorage;
    /* @76 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST installFromFileStorage;
    /* @80 */	jint lastTypeOfInstall;
    /* @84 */	jint typeOfInstall;
};

struct Java_java_io_InputStreamReader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Reader */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jchar_array * JVM_FIELD_CONST skipBuffer;
    /* java/io/InputStreamReader */
    /* @12 */	struct Java_java_io_Reader * JVM_FIELD_CONST in;
};

struct Java_javax_microedition_lcdui_TextBox {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad203;
    /* @31 */	jbyte ___pad204;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/TextBox */
    /* @32 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST textField;
    /* @36 */	struct Java_javax_microedition_lcdui_FormLF * JVM_FIELD_CONST textBoxLF;
};

struct Java_com_sun_midp_installer_DiscoveryApp_00024BackgroundInstallListGetter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/DiscoveryApp$BackgroundInstallListGetter */
    /*  @4 */	struct Java_com_sun_midp_installer_DiscoveryApp * JVM_FIELD_CONST parent;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /* @12 */	struct Java_com_sun_midp_installer_DiscoveryApp * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_installer_SuiteDownloadInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/SuiteDownloadInfo */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
};

struct Java_javax_microedition_lcdui_GaugeLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/GaugeLF */
};

struct Java_com_sun_midp_installer_FileInstaller {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/Installer */
    /*  @4 */	struct Java_com_sun_midp_installer_Verifier * JVM_FIELD_CONST verifier;
    /*  @8 */	struct Java_com_sun_midp_installer_InstallStateImpl * JVM_FIELD_CONST state;
    /* @12 */	struct Java_com_sun_j2me_security_AccessControlContext * JVM_FIELD_CONST accessControlContext;
    /* @16 */	struct Java_com_sun_midp_midletsuite_InstallInfo * JVM_FIELD_CONST info;
    /* @20 */	struct Java_com_sun_midp_midletsuite_SuiteSettings * JVM_FIELD_CONST settings;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST cldcConfig;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST cldcRuntimeEnv;
    /* @32 */	struct Java_java_util_Vector * JVM_FIELD_CONST supportedProfiles;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST unsignedSecurityDomain;
    /* @40 */	struct Java_java_lang_String * JVM_FIELD_CONST additionalPermissions;
    /* com/sun/midp/installer/FileInstaller */
};

struct Java_com_sun_midp_installer_GraphicalInstaller {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/installer/GraphicalInstaller */
    /*  @8 */	struct Java_com_sun_midp_installer_Installer * JVM_FIELD_CONST installer;
    /* @12 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @16 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST passwordForm;
    /* @20 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST usernameField;
    /* @24 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST passwordField;
    /* @28 */	struct Java_com_sun_midp_installer_GraphicalInstaller_00024BackgroundInstaller * JVM_FIELD_CONST backgroundInstaller;
    /* @32 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST progressForm;
    /* @36 */	jint progressGaugeIndex;
    /* @40 */	jint progressUrlIndex;
    /* @44 */	jlong lastDisplayChange;
    /* @52 */	struct Java_java_lang_String * JVM_FIELD_CONST cancelledMessage;
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST finishingMessage;
    /* @60 */	struct Java_javax_microedition_lcdui_List * JVM_FIELD_CONST storageListBox;
    /* @64 */	jint storageId;
    /* @68 */	struct Java_com_sun_midp_content_CHManager * JVM_FIELD_CONST chmanager;
    /* @72 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST stopCmd;
    /* @76 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST cancelCmd;
    /* @80 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST continueCmd;
    /* @84 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST storeSelectCmd;
    /* @88 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST nextCmd;
    /* @92 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST okCmd;
    /* @96 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST keepRMSCmd;
    /* @100 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST removeRMSCmd;
    /* @104 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @108 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /* @112 */	jboolean forceUpdate;
    /* @113 */	jboolean noConfirmation;
    /* @114 */	jboolean killRunningMIDletIfUpdate;
    /* @115 */	jbyte ___pad205;
};

struct Java_com_sun_midp_installer_GraphicalInstaller_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/GraphicalInstaller$1 */
    /*  @4 */	struct Java_com_sun_midp_installer_GraphicalInstaller * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_installer_GraphicalInstaller_00024BackgroundInstaller {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/GraphicalInstaller$BackgroundInstaller */
    /*  @4 */	struct Java_com_sun_midp_installer_GraphicalInstaller * JVM_FIELD_CONST parent;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST name;
    /* @16 */	jint storageId;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST successMessage;
    /* @24 */	struct Java_com_sun_midp_installer_InstallState * JVM_FIELD_CONST installState;
    /* @28 */	struct Java_com_sun_midp_installer_GraphicalInstaller * JVM_FIELD_CONST this_0440;
    /* @32 */	jboolean update;
    /* @33 */	jboolean noConfirmation;
    /* @34 */	jboolean continueInstall;
    /* @35 */	jboolean jarOnly;
    /* @36 */	jboolean proxyAuth;
    /* @37 */	jbyte ___pad206;
    /* @38 */	jbyte ___pad207;
    /* @39 */	jbyte ___pad208;
};

struct Java_com_sun_midp_installer_GraphicalInstaller_00024BackgroundInstaller_000241KilledNotificationListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/GraphicalInstaller$BackgroundInstaller$1KilledNotificationListener */
    /*  @4 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST val_044eq;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST val_044waitUntilKilled;
    /* @12 */	jboolean_array * JVM_FIELD_CONST val_044midletKilled;
    /* @16 */	struct Java_com_sun_midp_installer_GraphicalInstaller_00024BackgroundInstaller * JVM_FIELD_CONST this_0441;
};

struct Java_com_sun_midp_midletsuite_MIDletSuiteLockedException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/midletsuite/MIDletSuiteLockedException */
};

struct Java_com_sun_midp_midletsuite_MIDletSuiteCorruptedException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/midletsuite/MIDletSuiteCorruptedException */
};

struct Java_javax_microedition_io_ConnectionNotFoundException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* javax/microedition/io/ConnectionNotFoundException */
};

struct Java_com_sun_midp_installer_InstallRetryHandler {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/InstallRetryHandler */
    /*  @4 */	struct Java_com_sun_midp_security_SecurityToken * JVM_FIELD_CONST token;
    /*  @8 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST suite;
};

struct Java_com_sun_midp_installer_VerifierImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/VerifierImpl */
};

struct Java_com_sun_midp_installer_InstallerResource {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/InstallerResource */
};

struct Java_com_sun_midp_installer_InternalMIDletSuiteImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/InternalMIDletSuiteImpl */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
    /*  @8 */	jint id;
    /* @12 */	jbyte_array * JVM_FIELD_CONST permissions;
    /* @16 */	struct Java_com_sun_midp_util_Properties * JVM_FIELD_CONST properties;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST initialMIDletClassName;
    /* @24 */	jboolean trusted;
    /* @25 */	jbyte ___pad209;
    /* @26 */	jbyte ___pad210;
    /* @27 */	jbyte ___pad211;
};

struct Java_com_sun_midp_installer_PendingNotification {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/PendingNotification */
    /*  @4 */	jint retries;
    /*  @8 */	jint suiteId;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
};

struct Java_com_sun_midp_installer_OtaNotifier {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/OtaNotifier */
};

struct Java_com_sun_midp_io_HttpUrl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/HttpUrl */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST scheme;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST authority;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST path;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST query;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST fragment;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST host;
    /* @28 */	jint port;
    /* @32 */	struct Java_java_lang_String * JVM_FIELD_CONST machine;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST domain;
};

struct Java_java_io_DataInputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/InputStream */
    /* java/io/DataInputStream */
    /*  @4 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
};

struct Java_javax_microedition_io_StreamConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/StreamConnection */
};

struct Java_com_sun_midp_io_j2me_http_StreamConnectionPool {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/http/StreamConnectionPool */
    /*  @4 */	jlong m_connectionLingerTime;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST m_connections;
    /* @16 */	jint m_max_connections;
};

struct Java_com_sun_midp_io_j2me_http_StreamConnectionElement {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/http/StreamConnectionElement */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST m_protocol;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST m_host;
    /* @12 */	jint m_port;
    /* @16 */	struct Java_javax_microedition_io_StreamConnection * JVM_FIELD_CONST m_stream;
    /* @20 */	struct Java_java_io_DataInputStream * JVM_FIELD_CONST m_data_input_stream;
    /* @24 */	struct Java_java_io_DataOutputStream * JVM_FIELD_CONST m_data_output_stream;
    /* @28 */	jlong m_time;
    /* @36 */	jboolean m_in_use;
    /* @37 */	jboolean m_removed;
    /* @38 */	jbyte ___pad212;
    /* @39 */	jbyte ___pad213;
};

struct Java_java_io_DataOutputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/OutputStream */
    /* java/io/DataOutputStream */
    /*  @4 */	struct Java_java_io_OutputStream * JVM_FIELD_CONST out;
};

struct Java_com_sun_midp_io_j2me_socket_Protocol {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/ConnectionBaseAdapter */
    /*  @4 */	jint iStreams;
    /*  @8 */	jint maxIStreams;
    /* @12 */	jint oStreams;
    /* @16 */	jint maxOStreams;
    /* @20 */	jboolean connectionOpen;
    /* @21 */	jbyte ___pad214;
    /* @22 */	jbyte ___pad215;
    /* @23 */	jbyte ___pad216;
    /* com/sun/midp/io/BufferedConnectionAdapter */
    /* @24 */	jbyte_array * JVM_FIELD_CONST buf;
    /* @28 */	jint count;
    /* @32 */	jint pos;
    /* @36 */	jboolean eof;
    /* @37 */	jbyte ___pad217;
    /* @38 */	jbyte ___pad218;
    /* @39 */	jbyte ___pad219;
    /* com/sun/midp/io/NetworkConnectionBase */
    /* com/sun/midp/io/j2me/socket/Protocol */
    /* @40 */	jint handle;
    /* @44 */	struct Java_java_lang_Object * JVM_FIELD_CONST readerLock;
    /* @48 */	struct Java_java_lang_Object * JVM_FIELD_CONST writerLock;
    /* @52 */	struct Java_java_lang_String * JVM_FIELD_CONST host;
    /* @56 */	jint port;
    /* @60 */	jbyte_array * JVM_FIELD_CONST ipBytes;
    /* @64 */	jboolean outputShutdown;
    /* @65 */	jboolean ownerTrusted;
    /* @66 */	jbyte ___pad220;
    /* @67 */	jbyte ___pad221;
};

struct Java_com_sun_midp_io_j2me_http_Protocol_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/http/Protocol$1 */
};

struct Java_javax_microedition_io_OutputConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/OutputConnection */
};

struct Java_javax_microedition_io_InputConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/InputConnection */
};

struct Java_javax_microedition_io_ContentConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/ContentConnection */
};

struct Java_com_sun_midp_io_ConnectionBaseAdapter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/ConnectionBaseAdapter */
    /*  @4 */	jint iStreams;
    /*  @8 */	jint maxIStreams;
    /* @12 */	jint oStreams;
    /* @16 */	jint maxOStreams;
    /* @20 */	jboolean connectionOpen;
    /* @21 */	jbyte ___pad222;
    /* @22 */	jbyte ___pad223;
    /* @23 */	jbyte ___pad224;
};

struct Java_com_sun_midp_io_j2me_http_Protocol {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/ConnectionBaseAdapter */
    /*  @4 */	jint iStreams;
    /*  @8 */	jint maxIStreams;
    /* @12 */	jint oStreams;
    /* @16 */	jint maxOStreams;
    /* @20 */	jboolean connectionOpen;
    /* @21 */	jbyte ___pad225;
    /* @22 */	jbyte ___pad226;
    /* @23 */	jbyte ___pad227;
    /* com/sun/midp/io/j2me/http/Protocol */
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST protocol;
    /* @28 */	jint default_port;
    /* @32 */	struct Java_com_sun_midp_io_HttpUrl * JVM_FIELD_CONST url;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST hostAndPort;
    /* @40 */	jint responseCode;
    /* @44 */	struct Java_java_lang_String * JVM_FIELD_CONST responseMsg;
    /* @48 */	struct Java_com_sun_midp_util_Properties * JVM_FIELD_CONST reqProperties;
    /* @52 */	struct Java_com_sun_midp_util_Properties * JVM_FIELD_CONST headerFields;
    /* @56 */	struct Java_java_lang_String * JVM_FIELD_CONST method;
    /* @60 */	struct Java_javax_microedition_io_StreamConnection * JVM_FIELD_CONST streamConnection;
    /* @64 */	struct Java_java_io_DataOutputStream * JVM_FIELD_CONST streamOutput;
    /* @68 */	struct Java_java_io_DataInputStream * JVM_FIELD_CONST streamInput;
    /* @72 */	struct Java_java_lang_StringBuffer * JVM_FIELD_CONST stringbuffer;
    /* @76 */	struct Java_java_lang_String * JVM_FIELD_CONST httpVer;
    /* @80 */	jint contentLength;
    /* @84 */	jint chunksize;
    /* @88 */	jint totalbytesread;
    /* @92 */	jbyte_array * JVM_FIELD_CONST readbuf;
    /* @96 */	jint bytesleft;
    /* @100 */	jint bytesread;
    /* @104 */	jbyte_array * JVM_FIELD_CONST writebuf;
    /* @108 */	jint bytesToWrite;
    /* @112 */	struct Java_com_sun_midp_util_Properties * JVM_FIELD_CONST proxyHeaders;
    /* @116 */	jboolean permissionChecked;
    /* @117 */	jboolean ownerTrusted;
    /* @118 */	jboolean ConnectionCloseFlag;
    /* @119 */	jboolean chunkedIn;
    /* @120 */	jboolean chunkedOut;
    /* @121 */	jboolean firstChunkSent;
    /* @122 */	jboolean sendingRequest;
    /* @123 */	jboolean requestFinished;
    /* @124 */	jboolean eof;
    /* @125 */	jbyte handshakeError;
    /* @126 */	jboolean readInProgress;
    /* @127 */	jbyte ___pad228;
};

struct Java_com_sun_midp_installer_SuiteVerifier {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/installer/SuiteVerifier */
    /*  @8 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @12 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST backCommand;
    /* @16 */	struct Java_javax_microedition_lcdui_Form * JVM_FIELD_CONST progressForm;
    /* @20 */	jint progressGaugeIndex;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST jarPath;
    /* @28 */	jint suiteId;
    /* @32 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST suiteStorage;
};

struct Java_com_sun_midp_installer_SuiteVerifier_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/SuiteVerifier$1 */
    /*  @4 */	struct Java_com_sun_midp_installer_SuiteVerifier * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_installer_SuiteVerifier_00024BackgroundVerifier {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/installer/SuiteVerifier$BackgroundVerifier */
    /*  @4 */	struct Java_com_sun_midp_installer_SuiteVerifier * JVM_FIELD_CONST parent;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST jarPath;
    /* @12 */	struct Java_com_sun_midp_installer_SuiteVerifier * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_io_Base64 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/Base64 */
};

struct Java_com_sun_midp_io_BaseInputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/InputStream */
    /* com/sun/midp/io/BaseInputStream */
    /*  @4 */	struct Java_com_sun_midp_io_ConnectionBaseAdapter * JVM_FIELD_CONST parent;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST buf;
    /* @12 */	jbyte_array * JVM_FIELD_CONST markBuf;
    /* @16 */	jint markSize;
    /* @20 */	jint markPos;
    /* @24 */	jboolean isReadFromBuffer;
    /* @25 */	jbyte ___pad229;
    /* @26 */	jbyte ___pad230;
    /* @27 */	jbyte ___pad231;
};

struct Java_com_sun_midp_io_BaseOutputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/OutputStream */
    /* com/sun/midp/io/BaseOutputStream */
    /*  @4 */	struct Java_com_sun_midp_io_ConnectionBaseAdapter * JVM_FIELD_CONST parent;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST buf;
};

struct Java_com_sun_midp_io_BufferedConnectionAdapter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/ConnectionBaseAdapter */
    /*  @4 */	jint iStreams;
    /*  @8 */	jint maxIStreams;
    /* @12 */	jint oStreams;
    /* @16 */	jint maxOStreams;
    /* @20 */	jboolean connectionOpen;
    /* @21 */	jbyte ___pad232;
    /* @22 */	jbyte ___pad233;
    /* @23 */	jbyte ___pad234;
    /* com/sun/midp/io/BufferedConnectionAdapter */
    /* @24 */	jbyte_array * JVM_FIELD_CONST buf;
    /* @28 */	jint count;
    /* @32 */	jint pos;
    /* @36 */	jboolean eof;
    /* @37 */	jbyte ___pad235;
    /* @38 */	jbyte ___pad236;
    /* @39 */	jbyte ___pad237;
};

struct Java_com_sun_midp_io_FilterInputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/InputStream */
    /* com/sun/midp/io/FilterInputStream */
    /*  @4 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
};

struct Java_com_sun_midp_io_BufferedInputStream {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/InputStream */
    /* com/sun/midp/io/FilterInputStream */
    /*  @4 */	struct Java_java_io_InputStream * JVM_FIELD_CONST in;
    /* com/sun/midp/io/BufferedInputStream */
    /*  @8 */	jbyte_array * JVM_FIELD_CONST buf;
    /* @12 */	jint count;
    /* @16 */	jint pos;
    /* @20 */	jint markpos;
    /* @24 */	jint marklimit;
};

struct Java_com_sun_midp_io_FileUrl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/FileUrl */
};

struct Java_com_sun_midp_io_NetworkConnectionBase {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/ConnectionBaseAdapter */
    /*  @4 */	jint iStreams;
    /*  @8 */	jint maxIStreams;
    /* @12 */	jint oStreams;
    /* @16 */	jint maxOStreams;
    /* @20 */	jboolean connectionOpen;
    /* @21 */	jbyte ___pad238;
    /* @22 */	jbyte ___pad239;
    /* @23 */	jbyte ___pad240;
    /* com/sun/midp/io/BufferedConnectionAdapter */
    /* @24 */	jbyte_array * JVM_FIELD_CONST buf;
    /* @28 */	jint count;
    /* @32 */	jint pos;
    /* @36 */	jboolean eof;
    /* @37 */	jbyte ___pad241;
    /* @38 */	jbyte ___pad242;
    /* @39 */	jbyte ___pad243;
    /* com/sun/midp/io/NetworkConnectionBase */
};

struct Java_com_sun_midp_io_Util {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/Util */
};

struct Java_com_sun_midp_io_j2me_cbs_Protocol {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/cbs/Protocol */
};

struct Java_javax_microedition_io_CommConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/CommConnection */
};

struct Java_com_sun_midp_io_j2me_comm_Protocol {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/ConnectionBaseAdapter */
    /*  @4 */	jint iStreams;
    /*  @8 */	jint maxIStreams;
    /* @12 */	jint oStreams;
    /* @16 */	jint maxOStreams;
    /* @20 */	jboolean connectionOpen;
    /* @21 */	jbyte ___pad244;
    /* @22 */	jbyte ___pad245;
    /* @23 */	jbyte ___pad246;
    /* com/sun/midp/io/BufferedConnectionAdapter */
    /* @24 */	jbyte_array * JVM_FIELD_CONST buf;
    /* @28 */	jint count;
    /* @32 */	jint pos;
    /* @36 */	jboolean eof;
    /* @37 */	jbyte ___pad247;
    /* @38 */	jbyte ___pad248;
    /* @39 */	jbyte ___pad249;
    /* com/sun/midp/io/j2me/comm/Protocol */
    /* @40 */	jint handle;
    /* @44 */	jint bbc;
    /* @48 */	jint stop;
    /* @52 */	jint parity;
    /* @56 */	jint rts;
    /* @60 */	jint cts;
    /* @64 */	jint baud;
    /* @68 */	jboolean blocking;
    /* @69 */	jbyte ___pad250;
    /* @70 */	jbyte ___pad251;
    /* @71 */	jbyte ___pad252;
};

struct Java_java_io_DataInput {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/DataInput */
};

struct Java_java_io_DataOutput {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/DataOutput */
};

struct Java_javax_microedition_io_Datagram {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/Datagram */
};

struct Java_com_sun_midp_io_j2me_datagram_DatagramObject {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/datagram/DatagramObject */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST buffer;
    /*  @8 */	jint offset;
    /* @12 */	jint length;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST address;
    /* @20 */	jint ipNumber;
    /* @24 */	jint port;
    /* @28 */	jint readWritePosition;
};

struct Java_java_io_UTFDataFormatException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* java/io/UTFDataFormatException */
};

struct Java_java_io_EOFException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* java/io/EOFException */
};

struct Java_com_sun_midp_io_j2me_datagram_Protocol_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/datagram/Protocol$1 */
};

struct Java_com_sun_midp_io_j2me_datagram_Protocol_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/datagram/Protocol$SecurityTrusted */
};

struct Java_javax_microedition_io_DatagramConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/DatagramConnection */
};

struct Java_javax_microedition_io_UDPDatagramConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/UDPDatagramConnection */
};

struct Java_com_sun_midp_io_j2me_datagram_Protocol {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/datagram/Protocol */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST readerLock;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST writerLock;
    /* @12 */	jint nativeHandle;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST host;
    /* @20 */	jint port;
    /* @24 */	jboolean open;
    /* @25 */	jboolean ownerTrusted;
    /* @26 */	jbyte ___pad253;
    /* @27 */	jbyte ___pad254;
};

struct Java_com_sun_midp_io_j2me_datagram_ProtocolPushImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/push/ProtocolPush */
    /* com/sun/midp/io/j2me/datagram/ProtocolPushImpl */
    /*  @4 */	struct Java_com_sun_midp_io_j2me_datagram_ProtocolPushImpl * JVM_FIELD_CONST pushInstance;
};

struct Java_com_sun_midp_io_j2me_push_ProtocolPush {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/push/ProtocolPush */
};

struct Java_com_sun_midp_io_j2me_http_Protocol_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/http/Protocol$SecurityTrusted */
};

struct Java_com_sun_midp_suspend_NetworkSubsystem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/AbstractSubsystem */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST subsystems;
    /* @16 */	struct Java_java_util_Vector * JVM_FIELD_CONST dependencies;
    /* com/sun/midp/suspend/NetworkSubsystem */
};

struct Java_com_sun_midp_suspend_Subsystem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/Subsystem */
};

struct Java_com_sun_midp_io_j2me_socket_Protocol_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/socket/Protocol$1 */
};

struct Java_javax_microedition_io_SocketConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/SocketConnection */
};

struct Java_java_util_Enumeration {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Enumeration */
};

struct Java_com_sun_midp_io_j2me_pipe_Protocol {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/pipe/Protocol */
};

struct Java_com_sun_midp_io_j2me_push_Connection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/push/Connection */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST protocol;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST target;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST params;
};

struct Java_com_sun_midp_main_MIDletProxyListListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletProxyListListener */
};

struct Java_com_sun_midp_io_j2me_push_ConnectionRegistry {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/push/ConnectionRegistry */
    /*  @4 */	struct Java_com_sun_midp_main_MIDletProxyList * JVM_FIELD_CONST midletProxyList;
};

struct Java_com_sun_midp_io_j2me_push_PushRegistryImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/push/PushRegistryImpl */
};

struct Java_com_sun_midp_io_j2me_push_PushRegistryInternal {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/push/PushRegistryInternal */
};

struct Java_com_sun_midp_io_j2me_socket_ServerSocket {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/socket/ServerSocket */
};

struct Java_javax_microedition_io_StreamConnectionNotifier {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/StreamConnectionNotifier */
};

struct Java_javax_microedition_io_ServerSocketConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/ServerSocketConnection */
};

struct Java_com_sun_midp_io_j2me_serversocket_Socket {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/serversocket/Socket */
    /*  @4 */	jint nativeHandle;
    /*  @8 */	struct Java_com_sun_midp_security_SecurityToken * JVM_FIELD_CONST privilegedSecurityToken;
    /* @12 */	jboolean connectionOpen;
    /* @13 */	jbyte ___pad255;
    /* @14 */	jbyte ___pad256;
    /* @15 */	jbyte ___pad257;
};

struct Java_com_sun_midp_io_j2me_sms_Protocol {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/sms/Protocol */
};

struct Java_com_sun_midp_io_j2me_socket_Protocol_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/socket/Protocol$SecurityTrusted */
};

struct Java_com_sun_midp_io_j2me_socket_ProtocolPushImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/j2me/push/ProtocolPush */
    /* com/sun/midp/io/j2me/socket/ProtocolPushImpl */
    /*  @4 */	struct Java_com_sun_midp_io_j2me_socket_ProtocolPushImpl * JVM_FIELD_CONST pushInstance;
};

struct Java_com_sun_midp_io_pipe_PipeConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/pipe/PipeConnection */
};

struct Java_com_sun_midp_io_pipe_PipeServerConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/io/pipe/PipeServerConnection */
};

struct Java_com_sun_midp_jarutil_JarReader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/jarutil/JarReader */
};

struct Java_com_sun_midp_jsr_JSRInitializer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/jsr/JSRInitializer */
};

struct Java_com_sun_midp_jsr075_FileConnectionCleanup {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/jsr075/FileConnectionCleanup */
};

struct Java_com_sun_midp_lcdui_CommandAccess {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/CommandAccess */
};

struct Java_com_sun_midp_lcdui_DisplayDevice {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayDevice */
    /*  @4 */	jint hardwareId;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
    /* @12 */	jint capabilities;
    /* @16 */	jint state;
    /* @20 */	jboolean isPrimary;
    /* @21 */	jboolean buildInDisp;
    /* @22 */	jboolean isPenSupported;
    /* @23 */	jboolean isPenMotionSupported;
};

struct Java_com_sun_midp_lcdui_DisplayEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayEventConsumer */
};

struct Java_com_sun_midp_lcdui_ForegroundEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/ForegroundEventConsumer */
};

struct Java_com_sun_midp_lcdui_DisplayAccess {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayAccess */
};

struct Java_com_sun_midp_lcdui_DisplayContainer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayContainer */
    /*  @4 */	jint isolateId;
    /*  @8 */	jint lastLocalDisplayId;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST displays;
};

struct Java_com_sun_midp_lcdui_DisplayDeviceAccess {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayDeviceAccess */
    /*  @4 */	struct Java_java_util_TimerTask * JVM_FIELD_CONST task;
    /*  @8 */	struct Java_java_util_TimerTask * JVM_FIELD_CONST vibrateTask;
    /* @12 */	jint flashCount;
    /* @16 */	jboolean isLit;
    /* @17 */	jbyte ___pad258;
    /* @18 */	jbyte ___pad259;
    /* @19 */	jbyte ___pad260;
};

struct Java_com_sun_midp_lcdui_DisplayDeviceAccess_00024TimerClient {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/lcdui/DisplayDeviceAccess$TimerClient */
    /* @28 */	jint displayId;
    /* @32 */	struct Java_com_sun_midp_lcdui_DisplayDeviceAccess * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_lcdui_DisplayDeviceAccess_00024VibrateTimerClient {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/lcdui/DisplayDeviceAccess$VibrateTimerClient */
    /* @28 */	jint displayId;
    /* @32 */	struct Java_com_sun_midp_lcdui_DisplayDeviceAccess * JVM_FIELD_CONST this_0440;
};

struct Java_com_sun_midp_lcdui_DisplayDeviceContainer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayDeviceContainer */
    /*  @4 */	struct Java_java_util_Vector * JVM_FIELD_CONST displayList;
};

struct Java_com_sun_midp_lcdui_DisplayEventProducer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayEventProducer */
    /*  @4 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
};

struct Java_com_sun_midp_lcdui_ForegroundController {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/ForegroundController */
};

struct Java_com_sun_midp_lcdui_RepaintEventProducer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/RepaintEventProducer */
    /*  @4 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
    /*  @8 */	struct Java_com_sun_midp_lcdui_RepaintEvent * JVM_FIELD_CONST pooledEvent1;
    /* @12 */	struct Java_com_sun_midp_lcdui_RepaintEvent * JVM_FIELD_CONST pooledEvent2;
    /* @16 */	struct Java_com_sun_midp_lcdui_RepaintEvent * JVM_FIELD_CONST pooledEvent3;
    /* @20 */	struct Java_com_sun_midp_lcdui_RepaintEvent * JVM_FIELD_CONST queuedEvent;
    /* @24 */	struct Java_com_sun_midp_lcdui_RepaintEvent * JVM_FIELD_CONST eventInProcess;
};

struct Java_com_sun_midp_lcdui_DisplayEventHandler {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayEventHandler */
};

struct Java_com_sun_midp_lcdui_DisplayEventHandlerFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayEventHandlerFactory */
};

struct Java_com_sun_midp_lcdui_DisplayEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayEventListener */
    /*  @4 */	struct Java_com_sun_midp_lcdui_DisplayContainer * JVM_FIELD_CONST displayContainer;
    /*  @8 */	struct Java_com_sun_midp_lcdui_DisplayDeviceContainer * JVM_FIELD_CONST displayDeviceContainer;
    /* @12 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
};

struct Java_com_sun_midp_lcdui_LCDUIEvent {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/Event */
    /*  @4 */	jint type;
    /*  @8 */	struct Java_com_sun_midp_events_Event * JVM_FIELD_CONST next;
    /* com/sun/midp/lcdui/LCDUIEvent */
    /* @12 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST changedItem;
    /* @16 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST nextScreen;
    /* @20 */	struct Java_com_sun_midp_lcdui_DisplayEventConsumer * JVM_FIELD_CONST display;
    /* @24 */	jint minorCode;
    /* @28 */	jboolean hasForeground;
    /* @29 */	jbyte ___pad261;
    /* @30 */	jbyte ___pad262;
    /* @31 */	jbyte ___pad263;
};

struct Java_com_sun_midp_lcdui_DisplayStaticAccess {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayStaticAccess */
};

struct Java_com_sun_midp_lcdui_DisplayFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/DisplayFactory */
};

struct Java_com_sun_midp_lcdui_EventConstants {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/EventConstants */
};

struct Java_com_sun_midp_lcdui_ForegroundEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/ForegroundEventListener */
    /*  @4 */	struct Java_com_sun_midp_lcdui_DisplayContainer * JVM_FIELD_CONST displayContainer;
    /*  @8 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
};

struct Java_javax_microedition_lcdui_game_GameCanvas {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad264;
    /* @31 */	jbyte ___pad265;
    /* javax/microedition/lcdui/Canvas */
    /* @32 */	struct Java_javax_microedition_lcdui_CanvasLF * JVM_FIELD_CONST canvasLF;
    /* @36 */	jboolean suppressKeyEvents;
    /* @37 */	jbyte ___pad266;
    /* @38 */	jbyte ___pad267;
    /* @39 */	jbyte ___pad268;
    /* javax/microedition/lcdui/game/GameCanvas */
    /* @40 */	struct Java_com_sun_midp_lcdui_GameCanvasLFImpl * JVM_FIELD_CONST gameCanvasLF;
};

struct Java_com_sun_midp_lcdui_GameCanvasLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/GameCanvasLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_game_GameCanvas * JVM_FIELD_CONST owner;
    /*  @8 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST offscreenBuffer;
    /* @12 */	struct Java_com_sun_midp_lcdui_GraphicsAccess * JVM_FIELD_CONST graphicsAccess;
    /* @16 */	struct Java_java_util_Vector * JVM_FIELD_CONST gVector;
};

struct Java_com_sun_midp_lcdui_GameAccess {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/GameAccess */
};

struct Java_com_sun_midp_lcdui_GameMap {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/GameMap */
};

struct Java_com_sun_midp_lcdui_ItemEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/ItemEventConsumer */
};

struct Java_com_sun_midp_lcdui_LCDUIEnvironment {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/LCDUIEnvironment */
    /*  @4 */	struct Java_com_sun_midp_lcdui_DisplayContainer * JVM_FIELD_CONST displayContainer;
    /*  @8 */	struct Java_com_sun_midp_lcdui_DisplayEventHandler * JVM_FIELD_CONST displayEventHandler;
};

struct Java_com_sun_midp_lcdui_LCDUIEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/LCDUIEventListener */
    /*  @4 */	struct Java_com_sun_midp_lcdui_ItemEventConsumer * JVM_FIELD_CONST itemEventConsumer;
    /*  @8 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
};

struct Java_com_sun_midp_lcdui_PhoneDial {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/PhoneDial */
};

struct Java_com_sun_midp_lcdui_RepaintEvent {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/events/Event */
    /*  @4 */	jint type;
    /*  @8 */	struct Java_com_sun_midp_events_Event * JVM_FIELD_CONST next;
    /* com/sun/midp/lcdui/RepaintEvent */
    /* @12 */	jint paintX1;
    /* @16 */	jint paintY1;
    /* @20 */	jint paintX2;
    /* @24 */	jint paintY2;
    /* @28 */	struct Java_java_lang_Object * JVM_FIELD_CONST paintTarget;
    /* @32 */	jint perUseID;
    /* @36 */	struct Java_com_sun_midp_lcdui_DisplayEventConsumer * JVM_FIELD_CONST display;
};

struct Java_com_sun_midp_lcdui_SystemAlert {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad269;
    /* @31 */	jbyte ___pad270;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Alert */
    /* @32 */	struct Java_javax_microedition_lcdui_AlertType * JVM_FIELD_CONST type;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST text;
    /* @40 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST image;
    /* @44 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST mutableImage;
    /* @48 */	struct Java_javax_microedition_lcdui_Gauge * JVM_FIELD_CONST indicator;
    /* @52 */	jint time;
    /* @56 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST returnScreen;
    /* @60 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST userCommandListener;
    /* @64 */	struct Java_javax_microedition_lcdui_AlertLF * JVM_FIELD_CONST alertLF;
    /* @68 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST implicitListener;
    /* com/sun/midp/lcdui/SystemAlert */
    /* @72 */	struct Java_java_lang_Object * JVM_FIELD_CONST preemptToken;
    /* @76 */	struct Java_com_sun_midp_lcdui_DisplayEventHandler * JVM_FIELD_CONST displayEventHandler;
    /* @80 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST explicitListener;
    /* @84 */	struct Java_java_lang_Object * JVM_FIELD_CONST listenerLock;
    /* @88 */	jboolean shown;
    /* @89 */	jbyte ___pad271;
    /* @90 */	jbyte ___pad272;
    /* @91 */	jbyte ___pad273;
};

struct Java_com_sun_midp_lcdui_TextCursor {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/TextCursor */
    /*  @4 */	jint x;
    /*  @8 */	jint y;
    /* @12 */	jint width;
    /* @16 */	jint height;
    /* @20 */	jint index;
    /* @24 */	jint option;
    /* @28 */	jint preferredX;
    /* @32 */	jint yOffset;
    /* @36 */	jboolean visible;
    /* @37 */	jbyte ___pad274;
    /* @38 */	jbyte ___pad275;
    /* @39 */	jbyte ___pad276;
};

struct Java_com_sun_midp_lcdui_TextInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/TextInfo */
    /*  @4 */	jint numLines;
    /*  @8 */	jint visLines;
    /* @12 */	jint topVis;
    /* @16 */	jint cursorLine;
    /* @20 */	jint_array * JVM_FIELD_CONST lineStart;
    /* @24 */	jint_array * JVM_FIELD_CONST lineEnd;
    /* @28 */	jint height;
    /* @32 */	jboolean isModified;
    /* @33 */	jboolean scrollY;
    /* @34 */	jboolean scrollX;
    /* @35 */	jbyte ___pad277;
};

struct Java_com_sun_midp_lcdui_Text {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/Text */
};

struct Java_com_sun_midp_lcdui_TextPolicy {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/lcdui/TextPolicy */
};

struct Java_com_sun_midp_log_LogChannels {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/log/LogChannels */
};

struct Java_com_sun_midp_log_LoggingBase {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/log/LoggingBase */
};

struct Java_com_sun_midp_log_Logging {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/log/LoggingBase */
    /* com/sun/midp/log/Logging */
};

struct Java_com_sun_midp_main_AbstractMIDletSuiteLoader_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/AbstractMIDletSuiteLoader$1 */
};

struct Java_com_sun_midp_main_AbstractMIDletSuiteLoader_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/AbstractMIDletSuiteLoader$SecurityTrusted */
};

struct Java_com_sun_midp_midlet_MIDletSuiteExceptionListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletSuiteExceptionListener */
};

struct Java_com_sun_midp_main_AbstractMIDletSuiteLoader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/AbstractMIDletSuiteLoader */
    /*  @4 */	jint isolateId;
    /*  @8 */	jint amsIsolateId;
    /* @12 */	jint suiteId;
    /* @16 */	jint externalAppId;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST midletClassName;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST midletDisplayName;
    /* @28 */	jobject_array * JVM_FIELD_CONST args;
    /* @32 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
    /* @36 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST midletSuite;
    /* @40 */	struct Java_com_sun_midp_lcdui_ForegroundController * JVM_FIELD_CONST foregroundController;
    /* @44 */	struct Java_com_sun_midp_lcdui_DisplayContainer * JVM_FIELD_CONST displayContainer;
    /* @48 */	struct Java_com_sun_midp_lcdui_LCDUIEnvironment * JVM_FIELD_CONST lcduiEnvironment;
    /* @52 */	struct Java_com_sun_midp_midlet_MIDletStateHandler * JVM_FIELD_CONST midletStateHandler;
};

struct Java_com_sun_midp_main_AmsUtil {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/AmsUtil */
};

struct Java_com_sun_midp_main_CldcAccessControlContext {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/j2me/security/AccessControlContextAdapter */
    /* com/sun/midp/main/CldcAccessControlContext */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST midletSuite;
};

struct Java_com_sun_midp_main_CldcForegroundController {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/CldcForegroundController */
    /*  @4 */	struct Java_com_sun_midp_main_MIDletControllerEventProducer * JVM_FIELD_CONST midletControllerEventProducer;
};

struct Java_com_sun_midp_main_HeadlessAlert {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad278;
    /* @31 */	jbyte ___pad279;
    /* javax/microedition/lcdui/Screen */
    /* javax/microedition/lcdui/Alert */
    /* @32 */	struct Java_javax_microedition_lcdui_AlertType * JVM_FIELD_CONST type;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST text;
    /* @40 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST image;
    /* @44 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST mutableImage;
    /* @48 */	struct Java_javax_microedition_lcdui_Gauge * JVM_FIELD_CONST indicator;
    /* @52 */	jint time;
    /* @56 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST returnScreen;
    /* @60 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST userCommandListener;
    /* @64 */	struct Java_javax_microedition_lcdui_AlertLF * JVM_FIELD_CONST alertLF;
    /* @68 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST implicitListener;
    /* com/sun/midp/main/HeadlessAlert */
    /* @72 */	struct Java_com_sun_midp_main_MIDletControllerEventProducer * JVM_FIELD_CONST midletControllerEventProducer;
    /* @76 */	jint displayId;
    /* @80 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST backgroundCommand;
    /* @84 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST exitCommand;
};

struct Java_com_sun_midp_midlet_MIDletLoader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletLoader */
};

struct Java_com_sun_midp_main_CldcMIDletLoader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/CldcMIDletLoader */
    /*  @4 */	struct Java_com_sun_midp_security_SecurityToken * JVM_FIELD_CONST classSecurityToken;
};

struct Java_com_sun_midp_suspend_SuspendSystem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/AbstractSubsystem */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST subsystems;
    /* @16 */	struct Java_java_util_Vector * JVM_FIELD_CONST dependencies;
    /* com/sun/midp/suspend/SuspendSystem */
    /* @20 */	struct Java_java_util_Vector * JVM_FIELD_CONST listeners;
};

struct Java_com_sun_midp_midlet_MIDletStateListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletStateListener */
};

struct Java_com_sun_midp_main_CldcMIDletStateListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/CldcMIDletStateListener */
    /*  @4 */	struct Java_com_sun_midp_security_SecurityToken * JVM_FIELD_CONST classSecurityToken;
    /*  @8 */	struct Java_com_sun_midp_lcdui_DisplayContainer * JVM_FIELD_CONST displayContainer;
    /* @12 */	struct Java_com_sun_midp_main_MIDletControllerEventProducer * JVM_FIELD_CONST midletControllerEventProducer;
    /* @16 */	jboolean vmInMidletStartMode;
    /* @17 */	jboolean previouslyActive;
    /* @18 */	jbyte ___pad280;
    /* @19 */	jbyte ___pad281;
};

struct Java_com_sun_midp_midlet_PlatformRequest {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/PlatformRequest */
};

struct Java_com_sun_midp_midlet_MIDletEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletEventListener */
    /*  @4 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
    /*  @8 */	struct Java_com_sun_midp_midlet_MIDletStateHandler * JVM_FIELD_CONST midletStateHandler;
};

struct Java_com_sun_midp_rms_SuiteContainer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/SuiteContainer */
};

struct Java_com_sun_midp_main_CldcMIDletSuiteLoader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/AbstractMIDletSuiteLoader */
    /*  @4 */	jint isolateId;
    /*  @8 */	jint amsIsolateId;
    /* @12 */	jint suiteId;
    /* @16 */	jint externalAppId;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST midletClassName;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST midletDisplayName;
    /* @28 */	jobject_array * JVM_FIELD_CONST args;
    /* @32 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
    /* @36 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST midletSuite;
    /* @40 */	struct Java_com_sun_midp_lcdui_ForegroundController * JVM_FIELD_CONST foregroundController;
    /* @44 */	struct Java_com_sun_midp_lcdui_DisplayContainer * JVM_FIELD_CONST displayContainer;
    /* @48 */	struct Java_com_sun_midp_lcdui_LCDUIEnvironment * JVM_FIELD_CONST lcduiEnvironment;
    /* @52 */	struct Java_com_sun_midp_midlet_MIDletStateHandler * JVM_FIELD_CONST midletStateHandler;
    /* com/sun/midp/main/CldcMIDletSuiteLoader */
    /* @56 */	struct Java_com_sun_midp_main_MIDletControllerEventProducer * JVM_FIELD_CONST midletControllerEventProducer;
    /* @60 */	struct Java_com_sun_midp_midlet_MIDletEventListener * JVM_FIELD_CONST midletEventListener;
    /* @64 */	struct Java_com_sun_midp_lcdui_ForegroundEventListener * JVM_FIELD_CONST foregroundEventListener;
};

struct Java_com_sun_midp_main_CldcPlatformRequest {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/CldcPlatformRequest */
    /*  @4 */	struct Java_com_sun_midp_security_SecurityToken * JVM_FIELD_CONST securityToken;
};

struct Java_com_sun_midp_midletsuite_SuiteContainerAdapter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/SuiteContainerAdapter */
    /*  @4 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST suiteStorage;
};

struct Java_com_sun_midp_main_MidletSuiteContainer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/SuiteContainerAdapter */
    /*  @4 */	struct Java_com_sun_midp_midletsuite_MIDletSuiteStorage * JVM_FIELD_CONST suiteStorage;
    /* com/sun/midp/main/MidletSuiteContainer */
};

struct Java_com_sun_midp_main_CommandState {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/CommandState */
    /*  @4 */	jint status;
    /*  @8 */	jint suiteId;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST midletClassName;
    /* @16 */	jint lastSuiteId;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST lastMidletClassName;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST lastArg0;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST lastArg1;
    /* @32 */	struct Java_java_lang_String * JVM_FIELD_CONST arg0;
    /* @36 */	struct Java_java_lang_String * JVM_FIELD_CONST arg1;
    /* @40 */	struct Java_java_lang_String * JVM_FIELD_CONST arg2;
    /* @44 */	struct Java_com_sun_midp_main_RuntimeInfo * JVM_FIELD_CONST runtimeInfo;
    /* @48 */	jboolean logoDisplayed;
    /* @49 */	jboolean isDebugMode;
    /* @50 */	jbyte ___pad282;
    /* @51 */	jbyte ___pad283;
};

struct Java_com_sun_midp_main_RuntimeInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/RuntimeInfo */
    /*  @4 */	jint memoryReserved;
    /*  @8 */	jint memoryTotal;
    /* @12 */	jint usedMemory;
    /* @16 */	jint priority;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST profileName;
};

struct Java_com_sun_midp_main_Configuration {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/Configuration */
};

struct Java_com_sun_midp_main_DebugUtil {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/DebugUtil */
};

struct Java_com_sun_midp_main_DisplayControllerListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/DisplayControllerListener */
};

struct Java_com_sun_midp_main_DisplayController {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/DisplayController */
    /*  @4 */	struct Java_com_sun_midp_main_MIDletProxy * JVM_FIELD_CONST lastMidletCreated;
    /*  @8 */	struct Java_com_sun_midp_main_MIDletProxyList * JVM_FIELD_CONST midletProxyList;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST listeners;
};

struct Java_com_sun_midp_main_ExecuteMIDletEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/ExecuteMIDletEventListener */
    /*  @4 */	jint externalAppId;
    /*  @8 */	jint id;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST midlet;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST displayName;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST arg0;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST arg1;
    /* @28 */	struct Java_java_lang_String * JVM_FIELD_CONST arg2;
};

struct Java_com_sun_midp_main_MIDletAppImageGenerator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletAppImageGenerator */
};

struct Java_com_sun_midp_main_MIDletAppImageGeneratorBase {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletAppImageGeneratorBase */
};

struct Java_com_sun_midp_main_MIDletControllerEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletControllerEventConsumer */
};

struct Java_com_sun_midp_main_MIDletControllerEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletControllerEventListener */
    /*  @4 */	struct Java_com_sun_midp_main_MIDletControllerEventConsumer * JVM_FIELD_CONST midletControllerEventConsumer;
};

struct Java_com_sun_midp_main_MIDletDestroyTimer_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/main/MIDletDestroyTimer$1 */
    /* @28 */	struct Java_com_sun_midp_main_MIDletProxy * JVM_FIELD_CONST val_044mp;
    /* @32 */	struct Java_com_sun_midp_main_MIDletProxyList * JVM_FIELD_CONST val_044mpl;
};

struct Java_com_sun_midp_main_MIDletDestroyTimer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletDestroyTimer */
};

struct Java_com_sun_midp_main_MIDletProxyList_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletProxyList$1 */
};

struct Java_com_sun_midp_main_MIDletProxyList_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletProxyList$SecurityTrusted */
};

struct Java_com_sun_midp_suspend_SuspendSystemListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/SuspendSystemListener */
};

struct Java_com_sun_midp_main_MIDletProxyUtils {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletProxyUtils */
};

struct Java_com_sun_midp_main_MIDletSuiteLoader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/AbstractMIDletSuiteLoader */
    /*  @4 */	jint isolateId;
    /*  @8 */	jint amsIsolateId;
    /* @12 */	jint suiteId;
    /* @16 */	jint externalAppId;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST midletClassName;
    /* @24 */	struct Java_java_lang_String * JVM_FIELD_CONST midletDisplayName;
    /* @28 */	jobject_array * JVM_FIELD_CONST args;
    /* @32 */	struct Java_com_sun_midp_events_EventQueue * JVM_FIELD_CONST eventQueue;
    /* @36 */	struct Java_com_sun_midp_midlet_MIDletSuite * JVM_FIELD_CONST midletSuite;
    /* @40 */	struct Java_com_sun_midp_lcdui_ForegroundController * JVM_FIELD_CONST foregroundController;
    /* @44 */	struct Java_com_sun_midp_lcdui_DisplayContainer * JVM_FIELD_CONST displayContainer;
    /* @48 */	struct Java_com_sun_midp_lcdui_LCDUIEnvironment * JVM_FIELD_CONST lcduiEnvironment;
    /* @52 */	struct Java_com_sun_midp_midlet_MIDletStateHandler * JVM_FIELD_CONST midletStateHandler;
    /* com/sun/midp/main/CldcMIDletSuiteLoader */
    /* @56 */	struct Java_com_sun_midp_main_MIDletControllerEventProducer * JVM_FIELD_CONST midletControllerEventProducer;
    /* @60 */	struct Java_com_sun_midp_midlet_MIDletEventListener * JVM_FIELD_CONST midletEventListener;
    /* @64 */	struct Java_com_sun_midp_lcdui_ForegroundEventListener * JVM_FIELD_CONST foregroundEventListener;
    /* com/sun/midp/main/MIDletSuiteLoader */
    /* @68 */	struct Java_com_sun_midp_main_CommandState * JVM_FIELD_CONST state;
    /* @72 */	jint disableAlerts;
    /* @76 */	struct Java_com_sun_midp_midlet_MIDletEventProducer * JVM_FIELD_CONST midletEventProducer;
    /* @80 */	struct Java_com_sun_midp_main_MIDletProxyList * JVM_FIELD_CONST midletProxyList;
};

struct Java_com_sun_midp_main_MIDletSuiteUtils {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletSuiteUtils */
};

struct Java_com_sun_midp_main_MIDletSuiteVerifier {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/MIDletSuiteVerifier */
};

struct Java_com_sun_midp_main_TrustedMIDletIcon_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/TrustedMIDletIcon$1 */
};

struct Java_com_sun_midp_main_TrustedMIDletIcon_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/TrustedMIDletIcon$SecurityTrusted */
};

struct Java_com_sun_midp_main_TrustedMIDletIcon {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/main/TrustedMIDletIcon */
};

struct Java_com_sun_midp_midlet_MIDletEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/MIDletEventConsumer */
};

struct Java_javax_microedition_midlet_MIDletStateChangeException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* javax/microedition/midlet/MIDletStateChangeException */
};

struct Java_com_sun_midp_midlet_Scheduler {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midlet/Scheduler */
};

struct Java_com_sun_midp_midletsuite_DynamicComponentStorage {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/midletsuite/DynamicComponentStorage */
};

struct Java_com_sun_midp_payment_PAPICleanUp {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/payment/PAPICleanUp */
};

struct Java_com_sun_midp_pki_AuthorityInfoAccessEntry {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/pki/AuthorityInfoAccessEntry */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST accessMethod;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST accessLocation;
};

struct Java_com_sun_midp_pki_X509Certificate {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/pki/X509Certificate */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST fp;
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST serialNumber;
    /* @12 */	jbyte_array * JVM_FIELD_CONST serialNumberBytes;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST subject;
    /* @20 */	struct Java_java_lang_String * JVM_FIELD_CONST issuer;
    /* @24 */	jlong from;
    /* @32 */	jlong until;
    /* @40 */	struct Java_com_sun_midp_crypto_RSAPublicKey * JVM_FIELD_CONST pubKey;
    /* @44 */	jint idx;
    /* @48 */	jbyte_array * JVM_FIELD_CONST enc;
    /* @52 */	jint TBSStart;
    /* @56 */	jint TBSLen;
    /* @60 */	jbyte_array * JVM_FIELD_CONST signature;
    /* @64 */	jbyte_array * JVM_FIELD_CONST TBSCertHash;
    /* @68 */	struct Java_java_util_Vector * JVM_FIELD_CONST subjectAltNames;
    /* @72 */	jint pLenConstr;
    /* @76 */	jint keyUsage;
    /* @80 */	jint extKeyUsage;
    /* @84 */	struct Java_java_util_Vector * JVM_FIELD_CONST authInfoAccess;
    /* @88 */	jboolean selfSigned;
    /* @89 */	jbyte version;
    /* @90 */	jbyte sigAlg;
    /* @91 */	jboolean badExt;
    /* @92 */	jboolean hasBC;
    /* @93 */	jboolean isCA;
    /* @94 */	jbyte ___pad284;
    /* @95 */	jbyte ___pad285;
};

struct Java_com_sun_midp_pki_CertStore {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/pki/CertStore */
};

struct Java_com_sun_midp_pki_SubjectAlternativeName {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/pki/SubjectAlternativeName */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST subjAltName;
    /*  @8 */	jbyte subjAltNameType;
    /* @9 */	jbyte ___pad286;
    /* @10 */	jbyte ___pad287;
    /* @11 */	jbyte ___pad288;
};

struct Java_com_sun_midp_pki_Utils {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/pki/Utils */
};

struct Java_javax_microedition_pki_Certificate {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/pki/Certificate */
};

struct Java_javax_microedition_pki_CertificateException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* javax/microedition/pki/CertificateException */
    /* @12 */	struct Java_javax_microedition_pki_Certificate * JVM_FIELD_CONST cert;
    /* @16 */	jbyte reason;
    /* @17 */	jbyte ___pad289;
    /* @18 */	jbyte ___pad290;
    /* @19 */	jbyte ___pad291;
};

struct Java_com_sun_midp_pki_ocsp_CertStatus {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/pki/ocsp/CertStatus */
};

struct Java_com_sun_midp_pki_ocsp_OCSPException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* com/sun/midp/pki/ocsp/OCSPException */
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST errorMessage;
    /* @16 */	jbyte reason;
    /* @17 */	jbyte ___pad292;
    /* @18 */	jbyte ___pad293;
    /* @19 */	jbyte ___pad294;
};

struct Java_com_sun_midp_pki_ocsp_OCSPValidator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/pki/ocsp/OCSPValidator */
};

struct Java_com_sun_midp_pki_ocsp_OCSPValidatorImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/pki/ocsp/OCSPValidatorImpl */
};

struct Java_com_sun_midp_publickeystore_Storage {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/Storage */
};

struct Java_com_sun_midp_publickeystore_InputStorage {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/Storage */
    /* com/sun/midp/publickeystore/InputStorage */
    /*  @4 */	struct Java_java_io_DataInputStream * JVM_FIELD_CONST in;
};

struct Java_com_sun_midp_publickeystore_OutputStorage {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/Storage */
    /* com/sun/midp/publickeystore/OutputStorage */
    /*  @4 */	struct Java_java_io_DataOutputStream * JVM_FIELD_CONST out;
};

struct Java_com_sun_midp_publickeystore_PublicKeyStore {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/PublicKeyStore */
    /*  @4 */	struct Java_java_util_Vector * JVM_FIELD_CONST keyList;
};

struct Java_com_sun_midp_publickeystore_PublicKeyStoreBuilderBase {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/PublicKeyStore */
    /*  @4 */	struct Java_java_util_Vector * JVM_FIELD_CONST __dup1__keyList;
    /* com/sun/midp/publickeystore/PublicKeyStoreBuilderBase */
    /*  @8 */	struct Java_java_util_Vector * JVM_FIELD_CONST keyList;
};

struct Java_com_sun_midp_publickeystore_WebPublicKeyStore_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/WebPublicKeyStore$1 */
};

struct Java_com_sun_midp_publickeystore_WebPublicKeyStore_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/publickeystore/WebPublicKeyStore$SecurityTrusted */
};

struct Java_com_sun_midp_rms_AbstractRecordStoreFile {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/AbstractRecordStoreFile */
};

struct Java_com_sun_midp_rms_AbstractRecordStoreImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/AbstractRecordStoreImpl */
};

struct Java_com_sun_midp_rms_AbstractRecordStoreLock {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/AbstractRecordStoreLock */
};

struct Java_com_sun_midp_rms_IntToIntMapper {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/IntToIntMapper */
    /*  @4 */	jint_array * JVM_FIELD_CONST elementData;
    /*  @8 */	jint_array * JVM_FIELD_CONST elementKey;
    /* @12 */	jint elementCount;
    /* @16 */	jint capacityIncrement;
    /* @20 */	jint defaultValue;
};

struct Java_com_sun_midp_rms_OffsetCache {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/IntToIntMapper */
    /*  @4 */	jint_array * JVM_FIELD_CONST elementData;
    /*  @8 */	jint_array * JVM_FIELD_CONST elementKey;
    /* @12 */	jint elementCount;
    /* @16 */	jint capacityIncrement;
    /* @20 */	jint defaultValue;
    /* com/sun/midp/rms/OffsetCache */
    /* @24 */	jint LastSeenOffset;
};

struct Java_com_sun_midp_rms_RMSConfig {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RMSConfig */
};

struct Java_com_sun_midp_rms_RecordStoreEventConsumer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreEventConsumer */
};

struct Java_com_sun_midp_rms_RecordStoreEventListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreEventListener */
    /*  @4 */	struct Java_com_sun_midp_security_SecurityToken * JVM_FIELD_CONST securityToken;
    /*  @8 */	struct Java_com_sun_midp_rms_RecordStoreEventConsumer * JVM_FIELD_CONST recordStoreEventConsumer;
};

struct Java_com_sun_midp_rms_RecordStoreFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreFactory */
};

struct Java_com_sun_midp_rms_RecordStoreFile {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreFile */
    /*  @4 */	jint handle;
};

struct Java_com_sun_midp_rms_RecordStoreSharedDBHeader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreSharedDBHeader */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST cachedHeaderData;
    /*  @8 */	jint cachedHeaderVersion;
    /* @12 */	jint lookupId;
    /* @16 */	jboolean isRecordStoreLocked;
    /* @17 */	jboolean isExclusiveUse;
    /* @18 */	jbyte ___pad295;
    /* @19 */	jbyte ___pad296;
};

struct Java_com_sun_midp_rms_RecordStoreIndex {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreIndex */
    /*  @4 */	struct Java_com_sun_midp_rms_AbstractRecordStoreImpl * JVM_FIELD_CONST recordStore;
    /*  @8 */	struct Java_com_sun_midp_rms_AbstractRecordStoreFile * JVM_FIELD_CONST dbFile;
    /* @12 */	struct Java_com_sun_midp_rms_OffsetCache * JVM_FIELD_CONST recordIdOffsets;
    /* @16 */	jint indexVersion;
};

struct Java_com_sun_midp_rms_RecordStoreImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreImpl */
    /*  @4 */	jbyte_array * JVM_FIELD_CONST compactBuffer;
    /*  @8 */	jint suiteId;
    /* @12 */	struct Java_com_sun_midp_rms_AbstractRecordStoreLock * JVM_FIELD_CONST recordStoreLock;
    /* @16 */	struct Java_com_sun_midp_rms_RecordStoreSharedDBHeader * JVM_FIELD_CONST dbHeader;
    /* @20 */	struct Java_com_sun_midp_rms_RecordStoreIndex * JVM_FIELD_CONST dbIndex;
    /* @24 */	struct Java_com_sun_midp_rms_RecordStoreFile * JVM_FIELD_CONST dbFile;
};

struct Java_javax_microedition_rms_RecordStoreFullException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* javax/microedition/rms/RecordStoreException */
    /* javax/microedition/rms/RecordStoreFullException */
};

struct Java_javax_microedition_rms_InvalidRecordIDException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* javax/microedition/rms/RecordStoreException */
    /* javax/microedition/rms/InvalidRecordIDException */
};

struct Java_com_sun_midp_util_isolate_InterIsolateMutex {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/util/isolate/InterIsolateMutex */
    /*  @4 */	jint mutexID;
};

struct Java_com_sun_midp_rms_RecordStoreLock {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreLock */
    /*  @4 */	struct Java_com_sun_midp_util_isolate_InterIsolateMutex * JVM_FIELD_CONST mutex;
};

struct Java_com_sun_midp_rms_RecordStoreLockFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreLockFactory */
};

struct Java_com_sun_midp_rms_RecordStoreRegistry {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreRegistry */
};

struct Java_com_sun_midp_rms_RecordStoreUtil {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RecordStoreUtil */
};

struct Java_com_sun_midp_rms_RmsEnvironment {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/rms/RmsEnvironment */
};

struct Java_com_sun_midp_scriptutil_CommandLineInstaller {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/scriptutil/CommandLineInstaller */
};

struct Java_com_sun_midp_scriptutil_HttpJadInstaller {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/scriptutil/HttpJadInstaller */
    /*  @8 */	struct Java_java_lang_String * JVM_FIELD_CONST url;
    /* @12 */	struct Java_com_sun_midp_installer_HttpInstaller * JVM_FIELD_CONST installer;
};

struct Java_com_sun_midp_scriptutil_SuiteLister {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/scriptutil/SuiteLister */
};

struct Java_com_sun_midp_scriptutil_SuiteRemover {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet */
    /*  @4 */	struct Java_com_sun_midp_midlet_MIDletPeer * JVM_FIELD_CONST peer;
    /* com/sun/midp/scriptutil/SuiteRemover */
    /*  @8 */	jint suiteId;
};

struct Java_com_sun_midp_security_PermissionSpec {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/PermissionSpec */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST name;
    /*  @8 */	struct Java_com_sun_midp_security_PermissionGroup * JVM_FIELD_CONST group;
};

struct Java_com_sun_midp_security_DomainPolicy {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/DomainPolicy */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST name;
    /*  @8 */	jbyte_array * JVM_FIELD_CONST defValues;
    /* @12 */	jbyte_array * JVM_FIELD_CONST maxValues;
    /* @16 */	jboolean isTrusted;
    /* @17 */	jbyte ___pad297;
    /* @18 */	jbyte ___pad298;
    /* @19 */	jbyte ___pad299;
};

struct Java_com_sun_midp_security_PermissionDialog {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/PermissionDialog */
    /*  @4 */	struct Java_com_sun_midp_lcdui_DisplayEventHandler * JVM_FIELD_CONST displayEventHandler;
    /*  @8 */	struct Java_javax_microedition_lcdui_Alert * JVM_FIELD_CONST alert;
    /* @12 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST yesCmd;
    /* @16 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST noCmd;
    /* @20 */	struct Java_java_lang_Object * JVM_FIELD_CONST preemptToken;
    /* @24 */	jboolean answer;
    /* @25 */	jbyte ___pad300;
    /* @26 */	jbyte ___pad301;
    /* @27 */	jbyte ___pad302;
};

struct Java_com_sun_midp_security_Permissions {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/Permissions */
};

struct Java_com_sun_midp_security_PermissionsStrings {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/PermissionsStrings */
};

struct Java_com_sun_midp_security_SecurityInitializerImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/SecurityInitializerImpl */
    /*  @4 */	struct Java_com_sun_midp_security_SecurityToken * JVM_FIELD_CONST internalSecurityToken;
    /*  @8 */	struct Java_java_util_Hashtable * JVM_FIELD_CONST trustedClasses;
};

struct Java_com_sun_midp_security_SecurityInitializer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/security/SecurityInitializer */
};

struct Java_com_sun_midp_suspend_AbstractSubsystem_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/AbstractSubsystem$1 */
};

struct Java_com_sun_midp_suspend_AbstractSubsystem_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/AbstractSubsystem$SecurityTrusted */
};

struct Java_com_sun_midp_suspend_AbstractSubsystem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/AbstractSubsystem */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST subsystems;
    /* @16 */	struct Java_java_util_Vector * JVM_FIELD_CONST dependencies;
};

struct Java_com_sun_midp_suspend_AlertTimer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Timer */
    /*  @4 */	struct Java_java_util_TaskQueue * JVM_FIELD_CONST queue;
    /*  @8 */	struct Java_java_util_TimerThread * JVM_FIELD_CONST thread;
    /* com/sun/midp/suspend/AlertTimer */
};

struct Java_com_sun_midp_suspend_AlertTimer_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/suspend/AlertTimer$1 */
    /* @28 */	struct Java_com_sun_midp_suspend_AlertTimer * JVM_FIELD_CONST val_044timer;
};

struct Java_java_util_TaskQueue {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TaskQueue */
    /*  @4 */	jobject_array * JVM_FIELD_CONST queue;
    /*  @8 */	jint size;
    /* @12 */	jboolean newTasksMayBeScheduled;
    /* @13 */	jbyte ___pad303;
    /* @14 */	jbyte ___pad304;
    /* @15 */	jbyte ___pad305;
};

struct Java_java_util_TimerThread {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Thread */
    /*  @4 */	jint priority;
    /*  @8 */	struct Java_java_lang_Runnable * JVM_FIELD_CONST target;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST vm_thread;
    /* @16 */	jint is_terminated;
    /* @20 */	jint is_stillborn;
    /* @24 */	jchar_array * JVM_FIELD_CONST name;
    /* java/util/TimerThread */
    /* @28 */	struct Java_java_util_TaskQueue * JVM_FIELD_CONST queue;
};

struct Java_com_sun_midp_suspend_StateTransitionException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* com/sun/midp/suspend/StateTransitionException */
};

struct Java_com_sun_midp_suspend_SuspendResumeUI_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/SuspendResumeUI$1 */
};

struct Java_com_sun_midp_suspend_SuspendResumeUI {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/SuspendResumeUI */
};

struct Java_com_sun_midp_suspend_SuspendSystem_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/SuspendSystem$1 */
};

struct Java_com_sun_midp_suspend_SuspendSystem_00024MIDPSystem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/suspend/AbstractSubsystem */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	struct Java_java_util_Vector * JVM_FIELD_CONST subsystems;
    /* @16 */	struct Java_java_util_Vector * JVM_FIELD_CONST dependencies;
    /* com/sun/midp/suspend/SuspendSystem */
    /* @20 */	struct Java_java_util_Vector * JVM_FIELD_CONST listeners;
    /* com/sun/midp/suspend/SuspendSystem$MIDPSystem */
    /* @24 */	struct Java_com_sun_midp_main_MIDletProxy * JVM_FIELD_CONST lastForeground;
    /* @28 */	struct Java_com_sun_midp_main_MIDletProxyList * JVM_FIELD_CONST mpl;
    /* @32 */	jboolean midletKilled;
    /* @33 */	jboolean midletPaused;
    /* @34 */	jbyte ___pad306;
    /* @35 */	jbyte ___pad307;
};

struct Java_com_sun_midp_suspend_SuspendTimer_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* com/sun/midp/suspend/SuspendTimer$1 */
    /* @28 */	struct Java_com_sun_midp_main_MIDletProxyList * JVM_FIELD_CONST val_044midletList;
};

struct Java_com_sun_midp_suspend_SuspendTimer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Timer */
    /*  @4 */	struct Java_java_util_TaskQueue * JVM_FIELD_CONST queue;
    /*  @8 */	struct Java_java_util_TimerThread * JVM_FIELD_CONST thread;
    /* com/sun/midp/suspend/SuspendTimer */
};

struct Java_com_sun_midp_util_DateParser {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/util/DateParser */
    /*  @4 */	jint year;
    /*  @8 */	jint month;
    /* @12 */	jint day;
    /* @16 */	jint hour;
    /* @20 */	jint minute;
    /* @24 */	jint second;
    /* @28 */	jint milli;
    /* @32 */	jint tzoffset;
    /* @36 */	jint_array * JVM_FIELD_CONST days_in_month;
    /* @40 */	jobject_array * JVM_FIELD_CONST month_shorts;
    /* @44 */	jobject_array * JVM_FIELD_CONST weekday_shorts;
};

struct Java_com_sun_midp_util_ResourceHandler {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/util/ResourceHandler */
};

struct Java_com_sun_midp_wma_WMACleanupMonitor {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/wma/WMACleanupMonitor */
};

struct Java_com_sun_mmedia_DirectVideoItemImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/mmedia/DirectVideoItemImpl */
};

struct Java_com_sun_mmedia_DirectVideoItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/CustomItem */
    /* @52 */	struct Java_javax_microedition_lcdui_CustomItemLF * JVM_FIELD_CONST customItemLF;
    /* com/sun/mmedia/DirectVideoItem */
    /* @56 */	struct Java_com_sun_mmedia_DirectVideoItemImpl * JVM_FIELD_CONST _impl;
};

struct Java_com_sun_mmedia_MIDPVideoPainter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/mmedia/MIDPVideoPainter */
};

struct Java_com_sun_mmedia_MMEventHandler_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/mmedia/MMEventHandler$1 */
};

struct Java_com_sun_mmedia_MMEventHandler_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/mmedia/MMEventHandler$SecurityTrusted */
};

struct Java_com_sun_mmedia_MMEventHandler {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/mmedia/MMEventHandler */
};

struct Java_com_sun_mmedia_MMHelper {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/mmedia/MMHelper */
};

struct Java_com_sun_mmedia_MMVideoItem {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/CustomItem */
    /* @52 */	struct Java_javax_microedition_lcdui_CustomItemLF * JVM_FIELD_CONST customItemLF;
    /* com/sun/mmedia/MMVideoItem */
    /* @56 */	struct Java_com_sun_mmedia_MMVideoItemImpl * JVM_FIELD_CONST _impl;
    /* @60 */	struct Java_javax_microedition_lcdui_Canvas * JVM_FIELD_CONST fullScreen;
    /* @64 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST display;
    /* @68 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST oldDisplayable;
    /* @72 */	jboolean _isFullScreen;
    /* @73 */	jbyte ___pad308;
    /* @74 */	jbyte ___pad309;
    /* @75 */	jbyte ___pad310;
};

struct Java_com_sun_mmedia_MMVideoItemImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/mmedia/MMVideoItemImpl */
};

struct Java_com_sun_mmedia_MMVideoItem_00024FullScreenCanvas {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Displayable */
    /*  @4 */	jobject_array * JVM_FIELD_CONST commands;
    /*  @8 */	jint numCommands;
    /* @12 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* @16 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @20 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
    /* @24 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST displayableLF;
    /* @28 */	jboolean isInFullScreenMode;
    /* @29 */	jboolean isRotated;
    /* @30 */	jbyte ___pad311;
    /* @31 */	jbyte ___pad312;
    /* javax/microedition/lcdui/Canvas */
    /* @32 */	struct Java_javax_microedition_lcdui_CanvasLF * JVM_FIELD_CONST canvasLF;
    /* @36 */	jboolean suppressKeyEvents;
    /* @37 */	jbyte ___pad313;
    /* @38 */	jbyte ___pad314;
    /* @39 */	jbyte ___pad315;
    /* com/sun/mmedia/MMVideoItem$FullScreenCanvas */
    /* @40 */	struct Java_com_sun_mmedia_MMVideoItem * JVM_FIELD_CONST this_0440;
};

struct Java_java_io_OutputStreamWriter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/io/Writer */
    /*  @4 */	jchar_array * JVM_FIELD_CONST writeBuffer;
    /*  @8 */	jint writeBufferSize;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /* java/io/OutputStreamWriter */
    /* @16 */	struct Java_java_io_Writer * JVM_FIELD_CONST out;
};

struct Java_java_lang_ArrayStoreException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/ArrayStoreException */
};

struct Java_java_lang_Boolean {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Boolean */
    /*  @4 */	jboolean value;
    /* @5 */	jbyte ___pad316;
    /* @6 */	jbyte ___pad317;
    /* @7 */	jbyte ___pad318;
};

struct Java_java_lang_Byte {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Byte */
    /*  @4 */	jbyte value;
    /* @5 */	jbyte ___pad319;
    /* @6 */	jbyte ___pad320;
    /* @7 */	jbyte ___pad321;
};

struct Java_java_lang_Character {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Character */
    /*  @4 */	jchar value;
    /* @5 */	jbyte ___pad322;
    /* @6 */	jbyte ___pad323;
};

struct Java_java_lang_FloatingDecimal {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/FloatingDecimal */
    /*  @4 */	jint decExponent;
    /*  @8 */	jchar_array * JVM_FIELD_CONST digits;
    /* @12 */	jint nDigits;
    /* @16 */	jint bigIntExp;
    /* @20 */	jint bigIntNBits;
    /* @24 */	jint roundDir;
    /* @28 */	jboolean isExceptional;
    /* @29 */	jboolean isNegative;
    /* @30 */	jboolean mustSetRoundDir;
    /* @31 */	jbyte ___pad324;
};

struct Java_java_lang_Double {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Double */
    /*  @4 */	jdouble value;
};

struct Java_java_lang_FDBigInt {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/FDBigInt */
    /*  @4 */	jint nWords;
    /*  @8 */	jint_array * JVM_FIELD_CONST data;
};

struct Java_java_lang_Float {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Float */
    /*  @4 */	jfloat value;
};

struct Java_java_lang_IllegalThreadStateException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/IllegalArgumentException */
    /* java/lang/IllegalThreadStateException */
};

struct Java_java_lang_Integer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Integer */
    /*  @4 */	jint value;
};

struct Java_java_lang_Long {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Long */
    /*  @4 */	jlong value;
};

struct Java_java_lang_NegativeArraySizeException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/lang/NegativeArraySizeException */
};

struct Java_java_lang_Short {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Short */
    /*  @4 */	jshort value;
    /* @5 */	jbyte ___pad325;
    /* @6 */	jbyte ___pad326;
};

struct Java_java_lang_StringBuilder {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/StringBuilder */
    /*  @4 */	struct Java_java_lang_StringBuffer * JVM_FIELD_CONST sb;
};

struct Java_java_util_EmptyStackException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/util/EmptyStackException */
};

struct Java_java_util_HashtableEntry {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/HashtableEntry */
    /*  @4 */	jint hash;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST key;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST value;
    /* @16 */	struct Java_java_util_HashtableEntry * JVM_FIELD_CONST next;
};

struct Java_java_util_Hashtable_00024HashtableEnumerator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Hashtable$HashtableEnumerator */
    /*  @4 */	jint index;
    /*  @8 */	jobject_array * JVM_FIELD_CONST table;
    /* @12 */	struct Java_java_util_HashtableEntry * JVM_FIELD_CONST entry;
    /* @16 */	struct Java_java_util_Hashtable * JVM_FIELD_CONST this_0440;
    /* @20 */	jboolean keys;
    /* @21 */	jbyte ___pad327;
    /* @22 */	jbyte ___pad328;
    /* @23 */	jbyte ___pad329;
};

struct Java_java_util_NoSuchElementException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* java/util/NoSuchElementException */
};

struct Java_java_util_Random {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Random */
    /*  @4 */	jlong seed;
};

struct Java_java_util_Stack {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/Vector */
    /*  @4 */	jobject_array * JVM_FIELD_CONST elementData;
    /*  @8 */	jint elementCount;
    /* @12 */	jint capacityIncrement;
    /* java/util/Stack */
};

struct Java_java_util_VectorEnumerator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/VectorEnumerator */
    /*  @4 */	struct Java_java_util_Vector * JVM_FIELD_CONST vector;
    /*  @8 */	jint count;
};

struct Java_javax_bluetooth_BluetoothConnectionException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* javax/bluetooth/BluetoothConnectionException */
    /* @12 */	jint error;
};

struct Java_javax_bluetooth_BluetoothStateException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* javax/bluetooth/BluetoothStateException */
};

struct Java_javax_bluetooth_DataElement {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/DataElement */
    /*  @4 */	jint type;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST value;
    /* @12 */	jlong lvalue;
    /* @20 */	struct Java_java_util_Vector * JVM_FIELD_CONST seq;
    /* @24 */	jboolean bvalue;
    /* @25 */	jbyte ___pad330;
    /* @26 */	jbyte ___pad331;
    /* @27 */	jbyte ___pad332;
};

struct Java_javax_bluetooth_DeviceClass {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/DeviceClass */
    /*  @4 */	jint record;
};

struct Java_javax_bluetooth_RemoteDevice {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/RemoteDevice */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST address;
};

struct Java_javax_bluetooth_DiscoveryListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/DiscoveryListener */
};

struct Java_javax_bluetooth_UUID {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/UUID */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST hex;
};

struct Java_javax_bluetooth_DiscoveryAgent {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/DiscoveryAgent */
};

struct Java_javax_bluetooth_ServiceRecord {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/ServiceRecord */
};

struct Java_javax_bluetooth_L2CAPConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/L2CAPConnection */
};

struct Java_javax_bluetooth_L2CAPConnectionNotifier {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/L2CAPConnectionNotifier */
};

struct Java_javax_bluetooth_LocalDevice {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/bluetooth/LocalDevice */
};

struct Java_javax_bluetooth_ServiceRegistrationException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/io/IOException */
    /* javax/bluetooth/ServiceRegistrationException */
};

struct Java_javax_microedition_io_Connector {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/Connector */
};

struct Java_javax_microedition_io_SecurityInfo {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/SecurityInfo */
};

struct Java_javax_microedition_io_HttpsConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/HttpsConnection */
};

struct Java_javax_microedition_io_PushRegistry {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/PushRegistry */
};

struct Java_javax_microedition_io_SecureConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/SecureConnection */
};

struct Java_javax_microedition_io_file_ConnectionClosedException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* javax/microedition/io/file/ConnectionClosedException */
};

struct Java_javax_microedition_io_file_FileConnection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/file/FileConnection */
};

struct Java_javax_microedition_io_file_FileSystemListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/file/FileSystemListener */
};

struct Java_javax_microedition_io_file_FileSystemRegistry {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/io/file/FileSystemRegistry */
};

struct Java_javax_microedition_io_file_IllegalModeException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* java/lang/RuntimeException */
    /* javax/microedition/io/file/IllegalModeException */
};

struct Java_javax_microedition_lcdui_AbstractImageData {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/AbstractImageData */
};

struct Java_javax_microedition_lcdui_ImageData {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ImageData */
    /*  @4 */	jint width;
    /*  @8 */	jint height;
    /* @12 */	jbyte_array * JVM_FIELD_CONST pixelData;
    /* @16 */	jbyte_array * JVM_FIELD_CONST alphaData;
    /* @20 */	jint nativePixelData;
    /* @24 */	jint nativeAlphaData;
    /* @28 */	jboolean isMutable;
    /* @29 */	jbyte ___pad333;
    /* @30 */	jbyte ___pad334;
    /* @31 */	jbyte ___pad335;
};

struct Java_javax_microedition_lcdui_AbstractImageDataFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/AbstractImageDataFactory */
};

struct Java_javax_microedition_lcdui_Alert_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Alert$1 */
    /*  @4 */	struct Java_javax_microedition_lcdui_Alert * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_AlertLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/DisplayableLFImpl */
    /*  @4 */	jlong lastTimeInvalidate;
    /* @12 */	struct Java_javax_microedition_lcdui_LFTimer * JVM_FIELD_CONST invalidateTimer;
    /* @16 */	jint INVALIDATE_REQUESTS_PERIOD;
    /* @20 */	jint INVALIDATE_REQUESTS_GRACE;
    /* @24 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST currentDisplay;
    /* @28 */	jint_array * JVM_FIELD_CONST viewport;
    /* @32 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST owner;
    /* @36 */	jint state;
    /* @40 */	jint stickyKeyMask;
    /* @44 */	jint currentKeyMask;
    /* @48 */	jboolean invalidScroll;
    /* @49 */	jboolean defferedSizeChange;
    /* @50 */	jboolean sawPointerPress;
    /* @51 */	jboolean sawKeyPress;
    /* @52 */	jboolean pendingInvalidate;
    /* @53 */	jbyte ___pad336;
    /* @54 */	jbyte ___pad337;
    /* @55 */	jbyte ___pad338;
    /* javax/microedition/lcdui/ScreenLFImpl */
    /* @56 */	jint_array * JVM_FIELD_CONST viewable;
    /* @60 */	jint vScrollPosition;
    /* @64 */	jint vScrollProportion;
    /* @68 */	jint lastScrollPosition;
    /* @72 */	jint lastScrollSize;
    /* @76 */	jboolean resetToTop;
    /* @77 */	jbyte ___pad339;
    /* @78 */	jbyte ___pad340;
    /* @79 */	jbyte ___pad341;
    /* javax/microedition/lcdui/AlertLFImpl */
    /* @80 */	jint clipx;
    /* @84 */	jint clipy;
    /* @88 */	jint clipw;
    /* @92 */	jint cliph;
    /* @96 */	jint maxScroll;
    /* @100 */	jint totalHeight;
    /* @104 */	struct Java_javax_microedition_lcdui_Alert * JVM_FIELD_CONST alert;
    /* @108 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST icon;
    /* @112 */	struct Java_java_util_TimerTask * JVM_FIELD_CONST timerTask;
    /* @116 */	jint titlex;
    /* @120 */	jint titley;
    /* @124 */	jint titlew;
    /* @128 */	jint titleh;
    /* @132 */	jint icony;
    /* @136 */	jint iconw;
    /* @140 */	jint iconh;
    /* @144 */	struct Java_java_lang_String * JVM_FIELD_CONST title;
    /* @148 */	jboolean isLayoutValid;
    /* @149 */	jbyte ___pad342;
    /* @150 */	jbyte ___pad343;
    /* @151 */	jbyte ___pad344;
};

struct Java_javax_microedition_lcdui_AlertLFImpl_00024TimeoutTask {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* javax/microedition/lcdui/AlertLFImpl$TimeoutTask */
    /* @28 */	struct Java_javax_microedition_lcdui_AlertLFImpl * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_DisplayableLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/DisplayableLFImpl */
    /*  @4 */	jlong lastTimeInvalidate;
    /* @12 */	struct Java_javax_microedition_lcdui_LFTimer * JVM_FIELD_CONST invalidateTimer;
    /* @16 */	jint INVALIDATE_REQUESTS_PERIOD;
    /* @20 */	jint INVALIDATE_REQUESTS_GRACE;
    /* @24 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST currentDisplay;
    /* @28 */	jint_array * JVM_FIELD_CONST viewport;
    /* @32 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST owner;
    /* @36 */	jint state;
    /* @40 */	jint stickyKeyMask;
    /* @44 */	jint currentKeyMask;
    /* @48 */	jboolean invalidScroll;
    /* @49 */	jboolean defferedSizeChange;
    /* @50 */	jboolean sawPointerPress;
    /* @51 */	jboolean sawKeyPress;
    /* @52 */	jboolean pendingInvalidate;
    /* @53 */	jbyte ___pad345;
    /* @54 */	jbyte ___pad346;
    /* @55 */	jbyte ___pad347;
};

struct Java_javax_microedition_lcdui_LFTimer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/LFTimer */
    /*  @4 */	jlong state;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST monitor;
};

struct Java_javax_microedition_lcdui_TickerLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/TickerLF */
};

struct Java_javax_microedition_lcdui_Display_00024DisplayAccessImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Display$DisplayAccessImpl */
    /*  @4 */	jlong lastFlushTime;
    /* @12 */	struct Java_javax_microedition_lcdui_Display_00024DisplayAccessImpl_00024FlushTimer * JVM_FIELD_CONST flushTimer;
    /* @16 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_ScreenLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/DisplayableLFImpl */
    /*  @4 */	jlong lastTimeInvalidate;
    /* @12 */	struct Java_javax_microedition_lcdui_LFTimer * JVM_FIELD_CONST invalidateTimer;
    /* @16 */	jint INVALIDATE_REQUESTS_PERIOD;
    /* @20 */	jint INVALIDATE_REQUESTS_GRACE;
    /* @24 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST currentDisplay;
    /* @28 */	jint_array * JVM_FIELD_CONST viewport;
    /* @32 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST owner;
    /* @36 */	jint state;
    /* @40 */	jint stickyKeyMask;
    /* @44 */	jint currentKeyMask;
    /* @48 */	jboolean invalidScroll;
    /* @49 */	jboolean defferedSizeChange;
    /* @50 */	jboolean sawPointerPress;
    /* @51 */	jboolean sawKeyPress;
    /* @52 */	jboolean pendingInvalidate;
    /* @53 */	jbyte ___pad348;
    /* @54 */	jbyte ___pad349;
    /* @55 */	jbyte ___pad350;
    /* javax/microedition/lcdui/ScreenLFImpl */
    /* @56 */	jint_array * JVM_FIELD_CONST viewable;
    /* @60 */	jint vScrollPosition;
    /* @64 */	jint vScrollProportion;
    /* @68 */	jint lastScrollPosition;
    /* @72 */	jint lastScrollSize;
    /* @76 */	jboolean resetToTop;
    /* @77 */	jbyte ___pad351;
    /* @78 */	jbyte ___pad352;
    /* @79 */	jbyte ___pad353;
};

struct Java_javax_microedition_lcdui_MMHelperImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/mmedia/MMHelper */
    /* javax/microedition/lcdui/MMHelperImpl */
};

struct Java_javax_microedition_lcdui_CanvasLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/DisplayableLFImpl */
    /*  @4 */	jlong lastTimeInvalidate;
    /* @12 */	struct Java_javax_microedition_lcdui_LFTimer * JVM_FIELD_CONST invalidateTimer;
    /* @16 */	jint INVALIDATE_REQUESTS_PERIOD;
    /* @20 */	jint INVALIDATE_REQUESTS_GRACE;
    /* @24 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST currentDisplay;
    /* @28 */	jint_array * JVM_FIELD_CONST viewport;
    /* @32 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST owner;
    /* @36 */	jint state;
    /* @40 */	jint stickyKeyMask;
    /* @44 */	jint currentKeyMask;
    /* @48 */	jboolean invalidScroll;
    /* @49 */	jboolean defferedSizeChange;
    /* @50 */	jboolean sawPointerPress;
    /* @51 */	jboolean sawKeyPress;
    /* @52 */	jboolean pendingInvalidate;
    /* @53 */	jbyte ___pad354;
    /* @54 */	jbyte ___pad355;
    /* @55 */	jbyte ___pad356;
    /* javax/microedition/lcdui/CanvasLFImpl */
    /* @56 */	struct Java_javax_microedition_lcdui_Canvas * JVM_FIELD_CONST canvas;
    /* @60 */	struct Java_java_util_Vector * JVM_FIELD_CONST embeddedVideos;
    /* @64 */	jboolean needRepaintBackground;
    /* @65 */	jboolean isDisplayRotated;
    /* @66 */	jbyte ___pad357;
    /* @67 */	jbyte ___pad358;
};

struct Java_javax_microedition_lcdui_ItemLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
};

struct Java_javax_microedition_lcdui_ChoiceGroupLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/ChoiceGroupLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_ChoiceGroup * JVM_FIELD_CONST cg;
    /* @48 */	jint selectedIndex;
    /* @52 */	jint hilightedIndex;
    /* @56 */	jint pendingIndex;
    /* @60 */	jint contentX;
    /* @64 */	jint_array * JVM_FIELD_CONST elHeights;
    /* @68 */	jboolean traversedIn;
    /* @69 */	jboolean hasFocusWhenPressed;
    /* @70 */	jbyte ___pad359;
    /* @71 */	jbyte ___pad360;
};

struct Java_javax_microedition_lcdui_ChoiceGroupPopupLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/ChoiceGroupLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_ChoiceGroup * JVM_FIELD_CONST cg;
    /* @48 */	jint selectedIndex;
    /* @52 */	jint hilightedIndex;
    /* @56 */	jint pendingIndex;
    /* @60 */	jint contentX;
    /* @64 */	jint_array * JVM_FIELD_CONST elHeights;
    /* @68 */	jboolean traversedIn;
    /* @69 */	jboolean hasFocusWhenPressed;
    /* @70 */	jbyte ___pad361;
    /* @71 */	jbyte ___pad362;
    /* javax/microedition/lcdui/ChoiceGroupPopupLFImpl */
    /* @72 */	struct Java_javax_microedition_lcdui_ChoiceGroupPopupLFImpl_00024CGPopupLayer * JVM_FIELD_CONST popupLayer;
    /* @76 */	jint_array * JVM_FIELD_CONST viewable;
    /* @80 */	jboolean itemSelectedWhenPressed;
    /* @81 */	jbyte ___pad363;
    /* @82 */	jbyte ___pad364;
    /* @83 */	jbyte ___pad365;
};

struct Java_javax_microedition_lcdui_ChoiceGroupPopupLFImpl_00024CGPopupLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad366;
    /* @47 */	jbyte ___pad367;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* com/sun/midp/chameleon/layers/ScrollablePopupLayer */
    /* @56 */	struct Java_com_sun_midp_chameleon_layers_ScrollIndLayer * JVM_FIELD_CONST scrollInd;
    /* javax/microedition/lcdui/ChoiceGroupPopupLFImpl$CGPopupLayer */
    /* @60 */	struct Java_javax_microedition_lcdui_ChoiceGroupPopupLFImpl * JVM_FIELD_CONST lf;
    /* @64 */	jint_array * JVM_FIELD_CONST viewport;
    /* @68 */	struct Java_javax_microedition_lcdui_ChoiceGroupPopupLFImpl * JVM_FIELD_CONST this_0440;
    /* @72 */	jboolean popupDrawnDown;
    /* @73 */	jboolean sbVisible;
    /* @74 */	jboolean sizeChanged;
    /* @75 */	jboolean popUpOpen;
};

struct Java_javax_microedition_lcdui_CustomItemLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/CustomItemLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_CustomItem * JVM_FIELD_CONST customItem;
    /* @48 */	jint preferredHeight;
    /* @52 */	jint preferredWidth;
    /* @56 */	jint minimumHeight;
    /* @60 */	jint minimumWidth;
};

struct Java_javax_microedition_lcdui_DateEditor {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad368;
    /* @47 */	jbyte ___pad369;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST __dup1__commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* javax/microedition/lcdui/DateEditor */
    /* @56 */	struct Java_javax_microedition_lcdui_DateFieldLFImpl * JVM_FIELD_CONST lf;
    /* @60 */	struct Java_java_util_Calendar * JVM_FIELD_CONST editDate;
    /* @64 */	jint mode;
    /* @68 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST cancel;
    /* @72 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST set;
    /* @76 */	jobject_array * JVM_FIELD_CONST commands;
    /* @80 */	jint nextX;
    /* @84 */	jint nextY;
    /* @88 */	jint lastDay;
    /* @92 */	jint dayOffset;
    /* @96 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST monthPopup;
    /* @100 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST yearPopup;
    /* @104 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST hoursPopup;
    /* @108 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST minutesPopup;
    /* @112 */	jint focusOn;
    /* @116 */	jint hilightedDate;
    /* @120 */	jint selectedDate;
    /* @124 */	jint popupWidth;
    /* @128 */	jint popupHeight;
    /* @132 */	jint elementWidth;
    /* @136 */	jint elementHeight;
    /* @140 */	jint timeComponentsOffset;
    /* @144 */	jint calendarTopLimit;
    /* @148 */	jint calendarBottomLimit;
    /* @152 */	jint calendarRightLimit;
    /* @156 */	jint dateHilightX;
    /* @160 */	jint dateHilightY;
    /* @164 */	jint PRESS_OUT_OF_BOUNDS;
    /* @168 */	jint itemIndexWhenPressed;
    /* @172 */	jint_array * JVM_FIELD_CONST month_bounds;
    /* @176 */	jint_array * JVM_FIELD_CONST year_bounds;
    /* @180 */	jint_array * JVM_FIELD_CONST hours_bounds;
    /* @184 */	jint_array * JVM_FIELD_CONST minutes_bounds;
    /* @188 */	jint_array * JVM_FIELD_CONST calendar_bounds;
    /* @192 */	jint_array * JVM_FIELD_CONST ampm_bounds;
    /* @196 */	jint pressedDate;
    /* @200 */	jboolean initialized;
    /* @201 */	jboolean amSelected;
    /* @202 */	jboolean amHilighted;
    /* @203 */	jboolean popUpOpen;
    /* @204 */	jboolean sizeChanged;
    /* @205 */	jboolean isIitialized;
    /* @206 */	jbyte ___pad370;
    /* @207 */	jbyte ___pad371;
};

struct Java_javax_microedition_lcdui_DEPopupLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad372;
    /* @47 */	jbyte ___pad373;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* com/sun/midp/chameleon/layers/ScrollablePopupLayer */
    /* @56 */	struct Java_com_sun_midp_chameleon_layers_ScrollIndLayer * JVM_FIELD_CONST scrollInd;
    /* javax/microedition/lcdui/DEPopupLayer */
    /* @60 */	struct Java_javax_microedition_lcdui_DateEditor * JVM_FIELD_CONST editor;
    /* @64 */	jint_array * JVM_FIELD_CONST viewport;
    /* @68 */	jint numElements;
    /* @72 */	jobject_array * JVM_FIELD_CONST elements;
    /* @76 */	jint elementWidth;
    /* @80 */	jint elementHeight;
    /* @84 */	jint elementsToFit;
    /* @88 */	jint startIndex;
    /* @92 */	jint endIndex;
    /* @96 */	jint hilightedIndex;
    /* @100 */	jint selectedIndex;
    /* @104 */	struct Java_javax_microedition_lcdui_ScreenLFImpl * JVM_FIELD_CONST sLF;
    /* @108 */	jint itemIndexWhenPressed;
    /* @112 */	jboolean open;
    /* @113 */	jboolean sbVisible;
    /* @114 */	jboolean circularTraversal;
    /* @115 */	jbyte ___pad374;
};

struct Java_javax_microedition_lcdui_DateFieldLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/DateFieldLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_DateField * JVM_FIELD_CONST df;
    /* @48 */	struct Java_java_util_Calendar * JVM_FIELD_CONST currentDate;
    /* @52 */	jint mode;
    /* @56 */	struct Java_javax_microedition_lcdui_DateEditor * JVM_FIELD_CONST editor;
    /* @60 */	jboolean traversedIn;
    /* @61 */	jbyte ___pad375;
    /* @62 */	jbyte ___pad376;
    /* @63 */	jbyte ___pad377;
};

struct Java_javax_microedition_lcdui_DateField {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/DateField */
    /* @52 */	struct Java_javax_microedition_lcdui_DateFieldLF * JVM_FIELD_CONST dateFieldLF;
    /* @56 */	jint mode;
    /* @60 */	struct Java_java_util_Calendar * JVM_FIELD_CONST currentDate;
    /* @64 */	jboolean initialized;
    /* @65 */	jbyte ___pad378;
    /* @66 */	jbyte ___pad379;
    /* @67 */	jbyte ___pad380;
};

struct Java_javax_microedition_lcdui_DateFieldLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/DateFieldLF */
};

struct Java_javax_microedition_lcdui_Display_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Display$1 */
};

struct Java_javax_microedition_lcdui_Display_00024ChameleonTunnel {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Display$ChameleonTunnel */
    /*  @4 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_Display_00024DisplayAccessImpl_00024FlushTimer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/LFTimer */
    /*  @4 */	jlong state;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST monitor;
    /* javax/microedition/lcdui/Display$DisplayAccessImpl$FlushTimer */
    /* @16 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST d;
    /* @20 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST offscreenBuffer;
    /* @24 */	jint x;
    /* @28 */	jint y;
    /* @32 */	jint width;
    /* @36 */	jint height;
    /* @40 */	struct Java_javax_microedition_lcdui_Display_00024DisplayAccessImpl * JVM_FIELD_CONST this_0441;
};

struct Java_javax_microedition_lcdui_Display_00024DisplayEventConsumerImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Display$DisplayEventConsumerImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_Display_00024ForegroundEventConsumerImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Display$ForegroundEventConsumerImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_DisplayEventHandlerImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/DisplayEventHandlerImpl */
    /*  @4 */	struct Java_com_sun_midp_lcdui_DisplayContainer * JVM_FIELD_CONST displayContainer;
    /*  @8 */	struct Java_com_sun_midp_lcdui_ForegroundController * JVM_FIELD_CONST foregroundController;
    /* @12 */	struct Java_com_sun_midp_lcdui_DisplayAccess * JVM_FIELD_CONST preemptingDisplay;
    /* @16 */	jboolean preemptionDoneCalled;
    /* @17 */	jbyte ___pad381;
    /* @18 */	jbyte ___pad382;
    /* @19 */	jbyte ___pad383;
};

struct Java_javax_microedition_lcdui_Display_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Display$SecurityTrusted */
};

struct Java_javax_microedition_lcdui_GraphicsAccessImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/GraphicsAccessImpl */
};

struct Java_javax_microedition_lcdui_DisplayableLFImpl_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/LFTimer */
    /*  @4 */	jlong state;
    /* @12 */	struct Java_java_lang_Object * JVM_FIELD_CONST monitor;
    /* javax/microedition/lcdui/DisplayableLFImpl$1 */
    /* @16 */	struct Java_javax_microedition_lcdui_DisplayableLFImpl * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_LayoutManager {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/LayoutManager */
    /*  @4 */	jint_array * JVM_FIELD_CONST sizingBox;
    /*  @8 */	jint viewportWidth;
    /* @12 */	jint viewportHeight;
    /* @16 */	jboolean rl_direction;
    /* @17 */	jbyte ___pad384;
    /* @18 */	jbyte ___pad385;
    /* @19 */	jbyte ___pad386;
};

struct Java_javax_microedition_lcdui_FormLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/DisplayableLFImpl */
    /*  @4 */	jlong lastTimeInvalidate;
    /* @12 */	struct Java_javax_microedition_lcdui_LFTimer * JVM_FIELD_CONST invalidateTimer;
    /* @16 */	jint INVALIDATE_REQUESTS_PERIOD;
    /* @20 */	jint INVALIDATE_REQUESTS_GRACE;
    /* @24 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST currentDisplay;
    /* @28 */	jint_array * JVM_FIELD_CONST viewport;
    /* @32 */	struct Java_javax_microedition_lcdui_Displayable * JVM_FIELD_CONST owner;
    /* @36 */	jint state;
    /* @40 */	jint stickyKeyMask;
    /* @44 */	jint currentKeyMask;
    /* @48 */	jboolean invalidScroll;
    /* @49 */	jboolean defferedSizeChange;
    /* @50 */	jboolean sawPointerPress;
    /* @51 */	jboolean sawKeyPress;
    /* @52 */	jboolean pendingInvalidate;
    /* @53 */	jbyte ___pad387;
    /* @54 */	jbyte ___pad388;
    /* @55 */	jbyte ___pad389;
    /* javax/microedition/lcdui/ScreenLFImpl */
    /* @56 */	jint_array * JVM_FIELD_CONST viewable;
    /* @60 */	jint vScrollPosition;
    /* @64 */	jint vScrollProportion;
    /* @68 */	jint lastScrollPosition;
    /* @72 */	jint lastScrollSize;
    /* @76 */	jboolean resetToTop;
    /* @77 */	jbyte ___pad390;
    /* @78 */	jbyte ___pad391;
    /* @79 */	jbyte ___pad392;
    /* javax/microedition/lcdui/FormLFImpl */
    /* @80 */	jint traverseIndex;
    /* @84 */	struct Java_javax_microedition_lcdui_ItemLFImpl * JVM_FIELD_CONST lastTraverseItem;
    /* @88 */	jint_array * JVM_FIELD_CONST visRect;
    /* @92 */	jobject_array * JVM_FIELD_CONST itemLFs;
    /* @96 */	jint numOfLFs;
    /* @100 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST pendingCurrentItem;
    /* @104 */	jint pointerX;
    /* @108 */	jint pointerY;
    /* @112 */	jboolean itemTraverse;
    /* @113 */	jboolean itemsModified;
    /* @114 */	jboolean pointerPressed;
    /* @115 */	jboolean scrollInitialized;
    /* @116 */	jboolean firstShown;
    /* @117 */	jboolean keepFocusOnTheScreen;
    /* @118 */	jboolean pointerIndicator;
    /* @119 */	jbyte ___pad393;
};

struct Java_javax_microedition_lcdui_GaugeLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/GaugeLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_Gauge * JVM_FIELD_CONST gauge;
    /* @48 */	struct Java_javax_microedition_lcdui_GaugeLFImpl_00024GaugeUpdateTask * JVM_FIELD_CONST updateHelper;
    /* @52 */	jint percentWidth;
    /* @56 */	jint percentHeight;
    /* @60 */	jint focusBtn;
    /* @64 */	jint_array * JVM_FIELD_CONST percentLoc;
    /* @68 */	jint nextFrame;
    /* @72 */	jint pointerArea;
    /* @76 */	jboolean initialTraverse;
    /* @77 */	jboolean intTraverse;
    /* @78 */	jbyte ___pad394;
    /* @79 */	jbyte ___pad395;
};

struct Java_javax_microedition_lcdui_GaugeLFImpl_00024GaugeUpdateTask {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* javax/microedition/lcdui/GaugeLFImpl$GaugeUpdateTask */
    /* @28 */	struct Java_javax_microedition_lcdui_GaugeLFImpl * JVM_FIELD_CONST myGaugeLF;
    /* @32 */	struct Java_javax_microedition_lcdui_GaugeLFImpl * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_SuiteImageCache {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/SuiteImageCache */
};

struct Java_javax_microedition_lcdui_ImageDataFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ImageDataFactory */
    /*  @4 */	struct Java_javax_microedition_lcdui_SuiteImageCache * JVM_FIELD_CONST imageCache;
};

struct Java_javax_microedition_lcdui_ImageItemLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/ImageItemLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_ImageItem * JVM_FIELD_CONST imgItem;
    /* @48 */	jint appearanceMode;
};

struct Java_javax_microedition_lcdui_KeyConverter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/KeyConverter */
};

struct Java_javax_microedition_lcdui_Spacer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/Item */
    /*  @4 */	struct Java_javax_microedition_lcdui_ItemLF * JVM_FIELD_CONST itemLF;
    /*  @8 */	struct Java_javax_microedition_lcdui_ItemCommandListener * JVM_FIELD_CONST commandListener;
    /* @12 */	struct Java_java_lang_String * JVM_FIELD_CONST label;
    /* @16 */	struct Java_javax_microedition_lcdui_Screen * JVM_FIELD_CONST owner;
    /* @20 */	jint layout;
    /* @24 */	jobject_array * JVM_FIELD_CONST commands;
    /* @28 */	jint numCommands;
    /* @32 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST defaultCommand;
    /* @36 */	jint lockedWidth;
    /* @40 */	jint userPreferredWidth;
    /* @44 */	jint lockedHeight;
    /* @48 */	jint userPreferredHeight;
    /* javax/microedition/lcdui/Spacer */
    /* @52 */	struct Java_javax_microedition_lcdui_SpacerLF * JVM_FIELD_CONST spacerLF;
    /* @56 */	jint width;
    /* @60 */	jint height;
};

struct Java_javax_microedition_lcdui_SpacerLF {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/SpacerLF */
};

struct Java_javax_microedition_lcdui_LFFactoryImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/LFFactory */
    /* javax/microedition/lcdui/LFFactoryImpl */
};

struct Java_javax_microedition_lcdui_StringItemLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/StringItemLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_StringItem * JVM_FIELD_CONST strItem;
    /* @48 */	jint appearanceMode;
    /* @52 */	jboolean skipTraverse;
    /* @53 */	jbyte ___pad396;
    /* @54 */	jbyte ___pad397;
    /* @55 */	jbyte ___pad398;
};

struct Java_javax_microedition_lcdui_SpacerLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/SpacerLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_Spacer * JVM_FIELD_CONST spacer;
};

struct Java_javax_microedition_lcdui_TextFieldLFImpl_00024TextScrollPainter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* javax/microedition/lcdui/TextFieldLFImpl$TextScrollPainter */
    /* @28 */	struct Java_javax_microedition_lcdui_TextFieldLFImpl * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_TextFieldLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/TextFieldLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST tf;
    /* @48 */	struct Java_com_sun_midp_lcdui_TextCursor * JVM_FIELD_CONST cursor;
    /* @52 */	struct Java_java_lang_String * JVM_FIELD_CONST initialInputMode;
    /* @56 */	struct Java_com_sun_midp_chameleon_input_InputMode * JVM_FIELD_CONST interruptedIM;
    /* @60 */	struct Java_com_sun_midp_chameleon_input_TextInputSession * JVM_FIELD_CONST cachedInputSession;
    /* @64 */	struct Java_com_sun_midp_chameleon_SubMenuCommand * JVM_FIELD_CONST inputMenu;
    /* @68 */	jobject_array * JVM_FIELD_CONST inputModes;
    /* @72 */	struct Java_com_sun_midp_chameleon_layers_InputModeLayer * JVM_FIELD_CONST inputModeIndicator;
    /* @76 */	jobject_array * JVM_FIELD_CONST pt_matches;
    /* @80 */	jint_array * JVM_FIELD_CONST inputModeAnchor;
    /* @84 */	jint xScrollOffset;
    /* @88 */	jint textWidth;
    /* @92 */	jint scrollWidth;
    /* @96 */	struct Java_javax_microedition_lcdui_TextFieldLFImpl_00024TextScrollPainter * JVM_FIELD_CONST textScrollPainter;
    /* @100 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST oldDisplay;
    /* @104 */	struct Java_java_util_Vector * JVM_FIELD_CONST timers;
    /* @108 */	struct Java_java_util_Timer * JVM_FIELD_CONST timerService;
    /* @112 */	jboolean editable;
    /* @113 */	jboolean firstTimeInTraverse;
    /* @114 */	jboolean pt_popupOpen;
    /* @115 */	jboolean vkb_popupOpen;
    /* @116 */	jboolean showIMPopup;
    /* @117 */	jboolean usePreferredX;
    /* @118 */	jboolean pressedIn;
    /* @119 */	jbyte ___pad399;
};

struct Java_javax_microedition_lcdui_TextFieldLFImpl_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/TextFieldLFImpl$1 */
};

struct Java_javax_microedition_lcdui_TextBoxLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/ItemLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_Item * JVM_FIELD_CONST item;
    /*  @8 */	jint_array * JVM_FIELD_CONST bounds;
    /* @12 */	jboolean_array * JVM_FIELD_CONST actualBoundsInvalid;
    /* @16 */	jint rowHeight;
    /* @20 */	jint_array * JVM_FIELD_CONST target;
    /* @24 */	jint cachedWidth;
    /* @28 */	jint_array * JVM_FIELD_CONST labelBounds;
    /* @32 */	jint_array * JVM_FIELD_CONST contentBounds;
    /* @36 */	jboolean hasFocus;
    /* @37 */	jboolean sizeChanged;
    /* @38 */	jboolean visible;
    /* @39 */	jboolean isNewLine;
    /* @40 */	jboolean drawsTraversalIndicator;
    /* @41 */	jboolean layoutDone;
    /* @42 */	jboolean itemWasPressed;
    /* @43 */	jboolean isInternalCycle;
    /* javax/microedition/lcdui/TextFieldLFImpl */
    /* @44 */	struct Java_javax_microedition_lcdui_TextField * JVM_FIELD_CONST tf;
    /* @48 */	struct Java_com_sun_midp_lcdui_TextCursor * JVM_FIELD_CONST cursor;
    /* @52 */	struct Java_java_lang_String * JVM_FIELD_CONST initialInputMode;
    /* @56 */	struct Java_com_sun_midp_chameleon_input_InputMode * JVM_FIELD_CONST interruptedIM;
    /* @60 */	struct Java_com_sun_midp_chameleon_input_TextInputSession * JVM_FIELD_CONST cachedInputSession;
    /* @64 */	struct Java_com_sun_midp_chameleon_SubMenuCommand * JVM_FIELD_CONST inputMenu;
    /* @68 */	jobject_array * JVM_FIELD_CONST inputModes;
    /* @72 */	struct Java_com_sun_midp_chameleon_layers_InputModeLayer * JVM_FIELD_CONST inputModeIndicator;
    /* @76 */	jobject_array * JVM_FIELD_CONST pt_matches;
    /* @80 */	jint_array * JVM_FIELD_CONST inputModeAnchor;
    /* @84 */	jint xScrollOffset;
    /* @88 */	jint textWidth;
    /* @92 */	jint scrollWidth;
    /* @96 */	struct Java_javax_microedition_lcdui_TextFieldLFImpl_00024TextScrollPainter * JVM_FIELD_CONST textScrollPainter;
    /* @100 */	struct Java_javax_microedition_lcdui_Display * JVM_FIELD_CONST oldDisplay;
    /* @104 */	struct Java_java_util_Vector * JVM_FIELD_CONST timers;
    /* @108 */	struct Java_java_util_Timer * JVM_FIELD_CONST timerService;
    /* @112 */	jboolean editable;
    /* @113 */	jboolean firstTimeInTraverse;
    /* @114 */	jboolean pt_popupOpen;
    /* @115 */	jboolean vkb_popupOpen;
    /* @116 */	jboolean showIMPopup;
    /* @117 */	jboolean usePreferredX;
    /* @118 */	jboolean pressedIn;
    /* @119 */	jbyte ___pad400;
    /* javax/microedition/lcdui/TextBoxLFImpl */
    /* @120 */	struct Java_com_sun_midp_lcdui_TextInfo * JVM_FIELD_CONST myInfo;
    /* @124 */	jboolean scrollInitialized;
    /* @125 */	jbyte ___pad401;
    /* @126 */	jbyte ___pad402;
    /* @127 */	jbyte ___pad403;
};

struct Java_javax_microedition_lcdui_TickerLFImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/TickerLFImpl */
    /*  @4 */	struct Java_javax_microedition_lcdui_DisplayableLF * JVM_FIELD_CONST owner;
    /*  @8 */	struct Java_javax_microedition_lcdui_Ticker * JVM_FIELD_CONST ticker;
};

struct Java_javax_microedition_lcdui_MiniDateEditor {
    /* java/lang/Object */
	void * __do_not_use__;
    /* com/sun/midp/chameleon/CLayer */
    /*  @4 */	jint_array * JVM_FIELD_CONST dirtyBounds;
    /*  @8 */	jint_array * JVM_FIELD_CONST boundsCopy;
    /* @12 */	jint_array * JVM_FIELD_CONST dirtyBoundsCopy;
    /* @16 */	jint bgColor;
    /* @20 */	jobject_array * JVM_FIELD_CONST bgImage;
    /* @24 */	struct Java_com_sun_midp_chameleon_CWindow * JVM_FIELD_CONST owner;
    /* @28 */	jint_array * JVM_FIELD_CONST bounds;
    /* @32 */	jint graphicsColor;
    /* @36 */	struct Java_javax_microedition_lcdui_Font * JVM_FIELD_CONST graphicsFont;
    /* @40 */	jboolean dirty;
    /* @41 */	jboolean transparent;
    /* @42 */	jboolean visible;
    /* @43 */	jboolean supportsInput;
    /* @44 */	jboolean opaque;
    /* @45 */	jboolean tileBG;
    /* @46 */	jbyte ___pad404;
    /* @47 */	jbyte ___pad405;
    /* com/sun/midp/chameleon/layers/PopupLayer */
    /* @48 */	jobject_array * JVM_FIELD_CONST __dup1__commands;
    /* @52 */	struct Java_javax_microedition_lcdui_CommandListener * JVM_FIELD_CONST listener;
    /* javax/microedition/lcdui/DateEditor */
    /* @56 */	struct Java_javax_microedition_lcdui_DateFieldLFImpl * JVM_FIELD_CONST lf;
    /* @60 */	struct Java_java_util_Calendar * JVM_FIELD_CONST editDate;
    /* @64 */	jint mode;
    /* @68 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST cancel;
    /* @72 */	struct Java_javax_microedition_lcdui_Command * JVM_FIELD_CONST set;
    /* @76 */	jobject_array * JVM_FIELD_CONST commands;
    /* @80 */	jint nextX;
    /* @84 */	jint nextY;
    /* @88 */	jint lastDay;
    /* @92 */	jint dayOffset;
    /* @96 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST monthPopup;
    /* @100 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST yearPopup;
    /* @104 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST hoursPopup;
    /* @108 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST minutesPopup;
    /* @112 */	jint focusOn;
    /* @116 */	jint hilightedDate;
    /* @120 */	jint selectedDate;
    /* @124 */	jint popupWidth;
    /* @128 */	jint popupHeight;
    /* @132 */	jint elementWidth;
    /* @136 */	jint elementHeight;
    /* @140 */	jint timeComponentsOffset;
    /* @144 */	jint calendarTopLimit;
    /* @148 */	jint calendarBottomLimit;
    /* @152 */	jint calendarRightLimit;
    /* @156 */	jint dateHilightX;
    /* @160 */	jint dateHilightY;
    /* @164 */	jint PRESS_OUT_OF_BOUNDS;
    /* @168 */	jint itemIndexWhenPressed;
    /* @172 */	jint_array * JVM_FIELD_CONST month_bounds;
    /* @176 */	jint_array * JVM_FIELD_CONST year_bounds;
    /* @180 */	jint_array * JVM_FIELD_CONST hours_bounds;
    /* @184 */	jint_array * JVM_FIELD_CONST minutes_bounds;
    /* @188 */	jint_array * JVM_FIELD_CONST calendar_bounds;
    /* @192 */	jint_array * JVM_FIELD_CONST ampm_bounds;
    /* @196 */	jint pressedDate;
    /* @200 */	jboolean initialized;
    /* @201 */	jboolean amSelected;
    /* @202 */	jboolean amHilighted;
    /* @203 */	jboolean popUpOpen;
    /* @204 */	jboolean sizeChanged;
    /* @205 */	jboolean isIitialized;
    /* @206 */	jbyte ___pad406;
    /* @207 */	jbyte ___pad407;
    /* javax/microedition/lcdui/MiniDateEditor */
    /* @208 */	struct Java_javax_microedition_lcdui_DEPopupLayer * JVM_FIELD_CONST dayPopup;
};

struct Java_javax_microedition_lcdui_SuiteImageCacheFactory {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/SuiteImageCacheFactory */
};

struct Java_javax_microedition_lcdui_SuiteImageCacheImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/SuiteImageCacheImpl */
};

struct Java_javax_microedition_lcdui_SuiteImageCacheStub {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/SuiteImageCacheStub */
};

struct Java_javax_microedition_lcdui_TextFieldLFImpl_00024TimerKey {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/util/TimerTask */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST lock;
    /*  @8 */	jint state;
    /* @12 */	jlong nextExecutionTime;
    /* @20 */	jlong period;
    /* javax/microedition/lcdui/TextFieldLFImpl$TimerKey */
    /* @28 */	jint key;
    /* @32 */	struct Java_javax_microedition_lcdui_TextFieldLFImpl * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_lcdui_game_GameAccessImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/game/GameAccessImpl */
};

struct Java_javax_microedition_lcdui_game_Layer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/game/Layer */
    /*  @4 */	jint x;
    /*  @8 */	jint y;
    /* @12 */	jint width;
    /* @16 */	jint height;
    /* @20 */	jboolean visible;
    /* @21 */	jbyte ___pad408;
    /* @22 */	jbyte ___pad409;
    /* @23 */	jbyte ___pad410;
};

struct Java_javax_microedition_lcdui_game_LayerManager {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/game/LayerManager */
    /*  @4 */	jint nlayers;
    /*  @8 */	jobject_array * JVM_FIELD_CONST component;
    /* @12 */	jint viewX;
    /* @16 */	jint viewY;
    /* @20 */	jint viewWidth;
    /* @24 */	jint viewHeight;
};

struct Java_javax_microedition_lcdui_game_Sprite {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/game/Layer */
    /*  @4 */	jint x;
    /*  @8 */	jint y;
    /* @12 */	jint width;
    /* @16 */	jint height;
    /* @20 */	jboolean visible;
    /* @21 */	jbyte ___pad411;
    /* @22 */	jbyte ___pad412;
    /* @23 */	jbyte ___pad413;
    /* javax/microedition/lcdui/game/Sprite */
    /* @24 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST sourceImage;
    /* @28 */	jint numberFrames;
    /* @32 */	jint_array * JVM_FIELD_CONST frameCoordsX;
    /* @36 */	jint_array * JVM_FIELD_CONST frameCoordsY;
    /* @40 */	jint srcFrameWidth;
    /* @44 */	jint srcFrameHeight;
    /* @48 */	jint_array * JVM_FIELD_CONST frameSequence;
    /* @52 */	jint sequenceIndex;
    /* @56 */	jint dRefX;
    /* @60 */	jint dRefY;
    /* @64 */	jint collisionRectX;
    /* @68 */	jint collisionRectY;
    /* @72 */	jint collisionRectWidth;
    /* @76 */	jint collisionRectHeight;
    /* @80 */	jint t_currentTransformation;
    /* @84 */	jint t_collisionRectX;
    /* @88 */	jint t_collisionRectY;
    /* @92 */	jint t_collisionRectWidth;
    /* @96 */	jint t_collisionRectHeight;
    /* @100 */	jboolean customSequenceDefined;
    /* @101 */	jbyte ___pad414;
    /* @102 */	jbyte ___pad415;
    /* @103 */	jbyte ___pad416;
};

struct Java_javax_microedition_lcdui_game_TiledLayer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/lcdui/game/Layer */
    /*  @4 */	jint x;
    /*  @8 */	jint y;
    /* @12 */	jint width;
    /* @16 */	jint height;
    /* @20 */	jboolean visible;
    /* @21 */	jbyte ___pad417;
    /* @22 */	jbyte ___pad418;
    /* @23 */	jbyte ___pad419;
    /* javax/microedition/lcdui/game/TiledLayer */
    /* @24 */	jint cellHeight;
    /* @28 */	jint cellWidth;
    /* @32 */	jint rows;
    /* @36 */	jint columns;
    /* @40 */	jobject_array * JVM_FIELD_CONST cellMatrix;
    /* @44 */	struct Java_javax_microedition_lcdui_Image * JVM_FIELD_CONST sourceImage;
    /* @48 */	jint numberOfTiles;
    /* @52 */	jint_array * JVM_FIELD_CONST tileSetX;
    /* @56 */	jint_array * JVM_FIELD_CONST tileSetY;
    /* @60 */	jint_array * JVM_FIELD_CONST anim_to_static;
    /* @64 */	jint numOfAnimTiles;
};

struct Java_javax_microedition_m3g_AnimationTrack {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/AnimationTrack */
    /* @16 */	struct Java_javax_microedition_m3g_KeyframeSequence * JVM_FIELD_CONST sequence;
    /* @20 */	struct Java_javax_microedition_m3g_AnimationController * JVM_FIELD_CONST controller;
    /* @24 */	jint property;
};

struct Java_javax_microedition_m3g_Object3D {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
};

struct Java_javax_microedition_m3g_AnimationController {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/AnimationController */
    /* @16 */	jfloat speed;
    /* @20 */	jfloat weight;
    /* @24 */	jint start;
    /* @28 */	jint end;
};

struct Java_javax_microedition_m3g_KeyframeSequence {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/KeyframeSequence */
    /* @16 */	jint keyframes;
    /* @20 */	jint components;
    /* @24 */	jint interpolation;
    /* @28 */	jint duration;
    /* @32 */	jint repeat;
    /* @36 */	jint first;
    /* @40 */	jint last;
};

struct Java_javax_microedition_m3g_Texture2D {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Texture2D */
    /* @28 */	struct Java_javax_microedition_m3g_Image2D * JVM_FIELD_CONST image;
    /* @32 */	jint blending;
    /* @36 */	jint blendColor;
    /* @40 */	jint wrapS;
    /* @44 */	jint wrapT;
    /* @48 */	jint levelFilter;
    /* @52 */	jint imageFilter;
};

struct Java_javax_microedition_m3g_Fog {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Fog */
    /* @16 */	jint mode;
    /* @20 */	jint color;
    /* @24 */	jfloat density;
    /* @28 */	jfloat near;
    /* @32 */	jfloat far;
};

struct Java_javax_microedition_m3g_PolygonMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/PolygonMode */
    /* @16 */	jint culling;
    /* @20 */	jint shading;
    /* @24 */	jint winding;
    /* @28 */	jboolean twoSided;
    /* @29 */	jboolean localCamera;
    /* @30 */	jboolean perspective;
    /* @31 */	jbyte ___pad420;
};

struct Java_javax_microedition_m3g_CompositingMode {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/CompositingMode */
    /* @16 */	jint blending;
    /* @20 */	jfloat alphaThreshold;
    /* @24 */	jfloat factor;
    /* @28 */	jfloat units;
    /* @32 */	jboolean depthTest;
    /* @33 */	jboolean depthWrite;
    /* @34 */	jboolean colorWrite;
    /* @35 */	jboolean alphaWrite;
};

struct Java_javax_microedition_m3g_Material {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Material */
    /* @16 */	jint ambient;
    /* @20 */	jint diffuse;
    /* @24 */	jint emissive;
    /* @28 */	jint specular;
    /* @32 */	jfloat shininess;
    /* @36 */	jboolean vertexColorTracking;
    /* @37 */	jbyte ___pad421;
    /* @38 */	jbyte ___pad422;
    /* @39 */	jbyte ___pad423;
};

struct Java_javax_microedition_m3g_Appearance {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Appearance */
    /* @16 */	jint layer;
    /* @20 */	struct Java_javax_microedition_m3g_CompositingMode * JVM_FIELD_CONST compositing;
    /* @24 */	struct Java_javax_microedition_m3g_Fog * JVM_FIELD_CONST fog;
    /* @28 */	struct Java_javax_microedition_m3g_PolygonMode * JVM_FIELD_CONST polygon;
    /* @32 */	struct Java_javax_microedition_m3g_Material * JVM_FIELD_CONST material;
    /* @36 */	jobject_array * JVM_FIELD_CONST textures;
};

struct Java_javax_microedition_m3g_Image2D {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Image2D */
    /* @16 */	jint format;
    /* @20 */	jint width;
    /* @24 */	jint height;
    /* @28 */	jboolean __reserved__mutable;
    /* @29 */	jbyte ___pad424;
    /* @30 */	jbyte ___pad425;
    /* @31 */	jbyte ___pad426;
};

struct Java_javax_microedition_m3g_Background {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Background */
    /* @16 */	jint color;
    /* @20 */	jint mx;
    /* @24 */	jint my;
    /* @28 */	jint cx;
    /* @32 */	jint cy;
    /* @36 */	jint cw;
    /* @40 */	jint ch;
    /* @44 */	struct Java_javax_microedition_m3g_Image2D * JVM_FIELD_CONST image;
    /* @48 */	jboolean colorClear;
    /* @49 */	jboolean depthClear;
    /* @50 */	jbyte ___pad427;
    /* @51 */	jbyte ___pad428;
};

struct Java_javax_microedition_m3g_Node {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad429;
    /* @43 */	jbyte ___pad430;
};

struct Java_javax_microedition_m3g_Transform {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Transform */
    /*  @4 */	jfloat_array * JVM_FIELD_CONST m;
};

struct Java_javax_microedition_m3g_Transformable {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
};

struct Java_javax_microedition_m3g_Camera {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad431;
    /* @43 */	jbyte ___pad432;
    /* javax/microedition/m3g/Camera */
    /* @44 */	jint type;
    /* @48 */	jfloat_array * JVM_FIELD_CONST p;
};

struct Java_javax_microedition_m3g_Graphics3D {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Graphics3D */
    /*  @4 */	struct Java_java_lang_Object * JVM_FIELD_CONST target;
    /*  @8 */	struct Java_javax_microedition_m3g_Camera * JVM_FIELD_CONST camera;
    /* @12 */	jint vx;
    /* @16 */	jint vy;
    /* @20 */	jint vw;
    /* @24 */	jint vh;
    /* @28 */	jint hints;
    /* @32 */	jfloat near;
    /* @36 */	jfloat far;
    /* @40 */	struct Java_java_util_Vector * JVM_FIELD_CONST lights;
    /* @44 */	jboolean depthBuffer;
    /* @45 */	jbyte ___pad433;
    /* @46 */	jbyte ___pad434;
    /* @47 */	jbyte ___pad435;
};

struct Java_javax_microedition_m3g_World {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad436;
    /* @43 */	jbyte ___pad437;
    /* javax/microedition/m3g/Group */
    /* @44 */	struct Java_java_util_Vector * JVM_FIELD_CONST children;
    /* javax/microedition/m3g/World */
    /* @48 */	struct Java_javax_microedition_m3g_Camera * JVM_FIELD_CONST camera;
    /* @52 */	struct Java_javax_microedition_m3g_Background * JVM_FIELD_CONST background;
};

struct Java_javax_microedition_m3g_VertexBuffer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/VertexBuffer */
    /* @16 */	struct Java_javax_microedition_m3g_VertexArray * JVM_FIELD_CONST positions;
    /* @20 */	struct Java_javax_microedition_m3g_VertexArray * JVM_FIELD_CONST normals;
    /* @24 */	struct Java_javax_microedition_m3g_VertexArray * JVM_FIELD_CONST colors;
    /* @28 */	jobject_array * JVM_FIELD_CONST texCoords;
    /* @32 */	jfloat_array * JVM_FIELD_CONST posBias;
    /* @36 */	jfloat posScale;
    /* @40 */	jint defaultColor;
};

struct Java_javax_microedition_m3g_IndexBuffer {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/IndexBuffer */
};

struct Java_javax_microedition_m3g_Light {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad438;
    /* @43 */	jbyte ___pad439;
    /* javax/microedition/m3g/Light */
    /* @44 */	jint mode;
    /* @48 */	jint color;
    /* @52 */	jfloat intensity;
    /* @56 */	jfloat c;
    /* @60 */	jfloat l;
    /* @64 */	jfloat q;
    /* @68 */	jfloat angle;
    /* @72 */	jfloat exponent;
};

struct Java_javax_microedition_m3g_RayIntersection {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/RayIntersection */
};

struct Java_javax_microedition_m3g_Group {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad440;
    /* @43 */	jbyte ___pad441;
    /* javax/microedition/m3g/Group */
    /* @44 */	struct Java_java_util_Vector * JVM_FIELD_CONST children;
};

struct Java_javax_microedition_m3g_Loader {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Loader */
};

struct Java_javax_microedition_m3g_Mesh {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad442;
    /* @43 */	jbyte ___pad443;
    /* javax/microedition/m3g/Mesh */
    /* @44 */	struct Java_javax_microedition_m3g_VertexBuffer * JVM_FIELD_CONST vertices;
    /* @48 */	jobject_array * JVM_FIELD_CONST submeshes;
    /* @52 */	jobject_array * JVM_FIELD_CONST appearances;
};

struct Java_javax_microedition_m3g_MorphingMesh {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad444;
    /* @43 */	jbyte ___pad445;
    /* javax/microedition/m3g/Mesh */
    /* @44 */	struct Java_javax_microedition_m3g_VertexBuffer * JVM_FIELD_CONST vertices;
    /* @48 */	jobject_array * JVM_FIELD_CONST submeshes;
    /* @52 */	jobject_array * JVM_FIELD_CONST appearances;
    /* javax/microedition/m3g/MorphingMesh */
    /* @56 */	jobject_array * JVM_FIELD_CONST targets;
    /* @60 */	jfloat_array * JVM_FIELD_CONST weights;
};

struct Java_javax_microedition_m3g_SkinnedMesh {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad446;
    /* @43 */	jbyte ___pad447;
    /* javax/microedition/m3g/Mesh */
    /* @44 */	struct Java_javax_microedition_m3g_VertexBuffer * JVM_FIELD_CONST vertices;
    /* @48 */	jobject_array * JVM_FIELD_CONST submeshes;
    /* @52 */	jobject_array * JVM_FIELD_CONST appearances;
    /* javax/microedition/m3g/SkinnedMesh */
    /* @56 */	struct Java_javax_microedition_m3g_Group * JVM_FIELD_CONST skeleton;
};

struct Java_javax_microedition_m3g_Sprite3D {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/Transformable */
    /* @16 */	jfloat_array * JVM_FIELD_CONST t;
    /* @20 */	jfloat_array * JVM_FIELD_CONST s;
    /* @24 */	jfloat_array * JVM_FIELD_CONST o;
    /* javax/microedition/m3g/Node */
    /* @28 */	struct Java_javax_microedition_m3g_Node * JVM_FIELD_CONST parent;
    /* @32 */	jfloat alpha;
    /* @36 */	jint scope;
    /* @40 */	jboolean rendering;
    /* @41 */	jboolean picking;
    /* @42 */	jbyte ___pad448;
    /* @43 */	jbyte ___pad449;
    /* javax/microedition/m3g/Sprite3D */
    /* @44 */	struct Java_javax_microedition_m3g_Appearance * JVM_FIELD_CONST appearance;
    /* @48 */	struct Java_javax_microedition_m3g_Image2D * JVM_FIELD_CONST image;
    /* @52 */	jint cx;
    /* @56 */	jint cy;
    /* @60 */	jint cw;
    /* @64 */	jint ch;
    /* @68 */	jboolean scaled;
    /* @69 */	jbyte ___pad450;
    /* @70 */	jbyte ___pad451;
    /* @71 */	jbyte ___pad452;
};

struct Java_javax_microedition_m3g_VertexArray {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/VertexArray */
    /* @16 */	jint count;
    /* @20 */	jint comps;
    /* @24 */	jint size;
};

struct Java_javax_microedition_m3g_TriangleStripArray {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/m3g/Object3D */
    /*  @4 */	jint userID;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST userObject;
    /* @12 */	jobject_array * JVM_FIELD_CONST tracks;
    /* javax/microedition/m3g/IndexBuffer */
    /* javax/microedition/m3g/TriangleStripArray */
    /* @16 */	jint count;
};

struct Java_javax_microedition_media_Manager {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/media/Manager */
};

struct Java_javax_microedition_media_control_ToneControl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/media/control/ToneControl */
};

struct Java_javax_microedition_midlet_MIDlet_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDlet$SecurityTrusted */
};

struct Java_javax_microedition_midlet_MIDletTunnelImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/midlet/MIDletTunnelImpl */
};

struct Java_javax_microedition_rms_RecordComparator {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/rms/RecordComparator */
};

struct Java_javax_microedition_rms_RecordEnumeration {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/rms/RecordEnumeration */
};

struct Java_javax_microedition_rms_RecordFilter {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/rms/RecordFilter */
};

struct Java_javax_microedition_rms_RecordListener {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/rms/RecordListener */
};

struct Java_javax_microedition_rms_RecordEnumerationImpl {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/rms/RecordEnumerationImpl */
    /*  @4 */	struct Java_javax_microedition_rms_RecordStore * JVM_FIELD_CONST recordStore;
    /*  @8 */	struct Java_javax_microedition_rms_RecordFilter * JVM_FIELD_CONST filter;
    /* @12 */	struct Java_javax_microedition_rms_RecordComparator * JVM_FIELD_CONST comparator;
    /* @16 */	jint index;
    /* @20 */	jint_array * JVM_FIELD_CONST records;
    /* @24 */	jboolean keepEnumUpdated;
    /* @25 */	jbyte ___pad453;
    /* @26 */	jbyte ___pad454;
    /* @27 */	jbyte ___pad455;
};

struct Java_javax_microedition_rms_RecordStore_000241 {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/rms/RecordStore$1 */
    /*  @4 */	struct Java_javax_microedition_rms_RecordStore * JVM_FIELD_CONST this_0440;
};

struct Java_javax_microedition_rms_RecordStore_00024SecurityTrusted {
    /* java/lang/Object */
	void * __do_not_use__;
    /* javax/microedition/rms/RecordStore$SecurityTrusted */
};

struct Java_javax_microedition_rms_RecordStoreNotOpenException {
    /* java/lang/Object */
	void * __do_not_use__;
    /* java/lang/Throwable */
    /*  @4 */	struct Java_java_lang_String * JVM_FIELD_CONST detailMessage;
    /*  @8 */	struct Java_java_lang_Object * JVM_FIELD_CONST backtrace;
    /* java/lang/Exception */
    /* javax/microedition/rms/RecordStoreException */
    /* javax/microedition/rms/RecordStoreNotOpenException */
};

#ifdef __cplusplus
}
#endif

#endif /*_ROM_STRUCTS_H_*/
