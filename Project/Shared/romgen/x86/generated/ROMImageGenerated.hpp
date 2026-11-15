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
extern "C" void Java_com_sun_cldc_util_SemaphoreLock_acquire();
extern "C" void Java_com_sun_cldc_util_SemaphoreLock_release();
extern "C" void Java_java_lang_Runtime_exitInternal();
extern "C" jlong Java_java_lang_Runtime_freeMemory();
extern "C" jlong Java_java_lang_Runtime_totalMemory();
extern "C" void Java_java_lang_Runtime_gc();
extern "C" jobject Java_java_lang_Object_getClass();
extern "C" void Java_java_lang_Object_notify();
extern "C" void Java_java_lang_Object_notifyAll();
extern "C" void Java_java_lang_Object_wait();
extern "C" jobject Java_java_lang_Class_getName();
extern "C" void Java_java_lang_System_arraycopy();
extern "C" jboolean Java_java_lang_Class_isInterface();
extern "C" jint Java_java_lang_String_lastIndexOf__I();
extern "C" jobject Java_java_lang_Thread_currentThread();
extern "C" void Java_java_lang_Class_invoke_1verify();
extern "C" jobject Java_java_lang_Class_getSuperclass();
extern "C" void Java_java_lang_Class_invoke_1clinit();
extern "C" void Java_java_lang_Class_init9();
extern "C" jboolean Java_java_lang_Thread_isAlive();
extern "C" jobject Java_java_lang_System_getProperty0();
extern "C" jint Java_java_lang_Float_floatToIntBits();
extern "C" jlong Java_java_lang_Double_doubleToLongBits();
extern "C" void Java_com_sun_cldchi_jvm_JVM_startAppImage();
extern "C" jboolean Java_com_sun_cldchi_jvm_JVM_createAppImage0();
extern "C" void Java_java_lang_ref_WeakReference_initializeWeakReference();
extern "C" jobject Java_com_sun_cldc_io_ResourceInputStream_open();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_readByte();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_bytesRemain();
extern "C" jint Java_com_sun_cldc_io_ResourceInputStream_readBytes();
extern "C" jobject Java_com_sun_cldc_io_ResourceInputStream_clone();
extern "C" jobject Java_java_lang_Class_forName();
extern "C" jobject Java_java_lang_Class_newInstance();
extern "C" jint Java_com_sun_cldc_io_j2me_socket_Protocol_open0();
extern "C" void Java_com_sun_cldc_io_j2me_socket_Protocol_close0();
extern "C" jint Java_com_sun_cldc_io_j2me_socket_Protocol_readByte();
extern "C" jint Java_com_sun_cldc_io_j2me_socket_Protocol_readBuf();
extern "C" jint Java_com_sun_cldc_io_j2me_socket_Protocol_available0();
extern "C" jint Java_com_sun_cldc_io_j2me_socket_Protocol_writeByte();
extern "C" jint Java_com_sun_cldc_io_j2me_socket_Protocol_writeBuf();
extern "C" jfloat Java_java_lang_Float_intBitsToFloat();
extern "C" jdouble Java_java_lang_Double_longBitsToDouble();
extern "C" jlong Java_java_lang_System_currentTimeMillis();
extern "C" jint Java_java_lang_System_identityHashCode();
extern "C" jint Java_com_sun_cldchi_jvm_JVM_getAppImageProgress();
extern "C" void Java_com_sun_cldchi_jvm_JVM_cancelImageCreation();
extern "C" void Java_com_sun_cldchi_jvm_JVM_createSysImage();
extern "C" void Java_com_sun_cldchi_jvm_JVM_loadLibrary();
extern "C" jint Java_com_sun_cldchi_jvm_JVM_verifyNextChunk();
extern "C" void Java_com_sun_cldchi_jvm_JVM_flushJarCaches();
extern "C" void Java_java_lang_Thread_yield();
extern "C" void Java_java_lang_Thread_sleep();
extern "C" jint Java_java_lang_Thread_activeCount();
extern "C" jint Java_java_lang_String_lastIndexOf__II();
extern "C" jobject Java_java_lang_String_intern();
extern "C" jboolean Java_java_lang_Class_isInstance();
extern "C" jboolean Java_java_lang_Class_isAssignableFrom();
extern "C" jboolean Java_java_lang_Class_isArray();
extern "C" jobject Java_java_lang_ref_WeakReference_get();
extern "C" void Java_java_lang_ref_WeakReference_clear();
extern "C" void Java_java_lang_ref_WeakReference_finalize();
extern "C" void Java_com_sun_cldchi_io_ConsoleOutputStream_write();
#endif // ROMIZING
#endif // ROM_IMAGE_GENERATED_HEADER
