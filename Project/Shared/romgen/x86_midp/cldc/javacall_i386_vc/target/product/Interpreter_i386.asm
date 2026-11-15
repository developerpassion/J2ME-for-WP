	; Copyright  1990-2009 Sun Microsystems, Inc. All Rights Reserved.
	; DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
	; This program is free software; you can redistribute it and/or
	; modify it under the terms of the GNU General Public License version
	; 2 only, as published by the Free Software Foundation.
	; This program is distributed in the hope that it will be useful, but
	; WITHOUT ANY WARRANTY; without even the implied warranty of
	; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
	; General Public License version 2 for more details (a copy is
	; included at /legal/license.txt).
	; You should have received a copy of the GNU General Public License
	; version 2 along with this work; if not, write to the Free Software
	; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
	; 02110-1301 USA
	; Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa
	; Clara, CA 95054 or visit www.sun.com if you need additional
	; information or have any questions.


	; ----------------------------------------------------------
	; Generated assembly file -- do *not* edit
	; ----------------------------------------------------------

	.486P
	.MODEL flat, C

CodeSegment segment  para  public   'CODE'

CodeSegment ends
DataSegment segment  para  public   'DATA'
	; Definition of jvm_fast_globals

	ALIGN 16
	PUBLIC jvm_fast_globals
jvm_fast_globals:

	PUBLIC _current_thread
_current_thread 	dd 	0

	PUBLIC _current_pending_exception
_current_pending_exception 	dd 	0

	PUBLIC _last_handle
_last_handle 	dd 	0

	PUBLIC _collection_area_start
_collection_area_start 	dd 	0

	PUBLIC _heap_start
_heap_start 	dd 	0

	PUBLIC _heap_top
_heap_top 	dd 	0

	PUBLIC _inline_allocation_top
_inline_allocation_top 	dd 	0

	PUBLIC _inline_allocation_end
_inline_allocation_end 	dd 	0

	PUBLIC _heap_limit
_heap_limit 	dd 	0

	PUBLIC _heap_end
_heap_end 	dd 	0

	PUBLIC _bitvector_base
_bitvector_base 	dd 	0

	PUBLIC _bit_selector
_bit_selector 	dd 	0

	PUBLIC _young_generation_start
_young_generation_start 	dd 	0

	PUBLIC _collection_area_end
_collection_area_end 	dd 	0

	PUBLIC _young_generation_target_size
_young_generation_target_size 	dd 	0

	PUBLIC _end_fixed_objects
_end_fixed_objects 	dd 	0

	PUBLIC _marking_stack_start
_marking_stack_start 	dd 	0

	PUBLIC _marking_stack_top
_marking_stack_top 	dd 	0

	PUBLIC _marking_stack_end
_marking_stack_end 	dd 	0

	PUBLIC _marking_stack_overflow
_marking_stack_overflow 	dd 	0

	PUBLIC _slices_start
_slices_start 	dd 	0

	PUBLIC _slice_shift
_slice_shift 	dd 	0

	PUBLIC _slice_offset_bits
_slice_offset_bits 	dd 	0

	PUBLIC _slice_size
_slice_size 	dd 	0

	PUBLIC _near_mask
_near_mask 	dd 	0

	PUBLIC _slice_offset_mask
_slice_offset_mask 	dd 	0

	PUBLIC _nof_slices
_nof_slices 	dd 	0

	PUBLIC _compaction_start
_compaction_start 	dd 	0

	PUBLIC _compaction_top
_compaction_top 	dd 	0

	PUBLIC _heap_min
_heap_min 	dd 	0

	PUBLIC _heap_capacity
_heap_capacity 	dd 	0

	PUBLIC _heap_size
_heap_size 	dd 	0

	PUBLIC _compiler_area_start
_compiler_area_start 	dd 	0

	PUBLIC _compiler_area_top
_compiler_area_top 	dd 	0

	PUBLIC _large_object_area_bottom
_large_object_area_bottom 	dd 	0

	PUBLIC _compiler_area_temp_top
_compiler_area_temp_top 	dd 	0

	PUBLIC _compiler_area_temp_bottom
_compiler_area_temp_bottom 	dd 	0

	PUBLIC _compiler_state
_compiler_state 	dd 	0

	PUBLIC _current_compiler
_current_compiler 	dd 	0

	PUBLIC _num_stack_lock_words
_num_stack_lock_words 	dd 	0

	PUBLIC _class_list_base
_class_list_base 	dd 	0

	PUBLIC _mirror_list_base
_mirror_list_base 	dd 	0
	; End definition of struct jvm_fast_globals

DataSegment ends
CodeSegment segment  para  public   'CODE'

	; ----------------------------------------------------------
	; Interpreter signature
	; ----------------------------------------------------------

	PUBLIC assembler_loop_type
assembler_loop_type 	dd 	65

	; ----------------------------------------------------------
	; Interpreter grow stack
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC interpreter_grow_stack
interpreter_grow_stack:

	; slow case, re-allocate the stack then re-try this method entry

	; first make the stack look correct for the call into the VM

	; on entry, ebx = method ptr, edi = locals, esi = bcp

	; get local return address; leave method return address on stack
	pop edx

	; Setup frame pointer
	push ebp
	mov ebp, esp

	; Store the method pointer on the stack
	push ebx

	; Store the constant pool pointer on the stack
	movzx esi, word ptr [ebx + 24]
	test esi, 512
	je L43

	; load ROM constants pool
	EXTERNDEF _rom_constant_pool:DWORD
	mov esi, dword ptr [_rom_constant_pool]
	jmp L44
L43:

	; load method specific constants pool
	mov esi, dword ptr [ebx + 4]
L44:
	add esi, 12
	push esi

	; Save the current locals pointer (edi)
	push edi

	; Put a bytecode pointer in the byte code pointer store (bci == 0)
	lea esi, dword ptr [ebx + 536870952]
	push esi

	; Setup pointer to expression stack bottom
	push ebp
	mov dword ptr [ebp + -20], esp

	; Save local return address as an integer on the stack
	push edx

	; get derived stack pointer value into extra argument
	mov edx, ecx

	; Setup the pointer to the vm routine
	EXTERNDEF stack_overflow:DWORD
	mov eax, offset stack_overflow

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; get method return address back
	pop edx

	; restore method pointer
	mov ebx, dword ptr [ebp + -4]

	; restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; clean up the stack
	add esp, 20

	; get frame pointer back
	pop ebp

	; get original return address on the stack
	pop eax
	push edx

	; restore count of parameters
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Get the size of the locals
	movzx edx, word ptr [ebx + 30]

	; Regenerate bytecode pointer
	lea esi, dword ptr [ebx + 40]
	ret

	; ----------------------------------------------------------
	; Interpreter method entry (method in ebx)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC fixed_interpreter_method_entry
fixed_interpreter_method_entry:
	EXTERNDEF interpreter_method_entry:PROC
	jmp interpreter_method_entry

	ALIGN 16
	PUBLIC interpreter_method_entry
interpreter_method_entry:

	; Save this interpreted method into interpretation log
	EXTERNDEF _interpretation_log_idx:DWORD
	mov eax, dword ptr [_interpretation_log_idx]
	EXTERNDEF _interpretation_log:DWORD
	mov dword ptr [eax + _interpretation_log], ebx
	lea eax, dword ptr [eax + 4]
	and eax, 31
	EXTERNDEF _interpretation_log_idx:DWORD
	mov dword ptr [_interpretation_log_idx], eax

	; Get the method parameter size
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Get the return address
	pop eax

	; Compute the start of the parameters - the locals pointer
	lea edi, dword ptr [esp + ecx * 4 + -4]

	; Put a bytecode pointer in the byte code pointer store (bci == 0)
	lea esi, dword ptr [ebx + 40]

	; Get the size of the locals
	movzx edx, word ptr [ebx + 30]

	; Setup and clear the locals
	sub edx, ecx

	; First, let's see if we have enough stack available
	movzx ecx, word ptr [ebx + 28]
	shl ecx, 2
	add ecx, 28
	neg ecx
	add ecx, esp

	; get lowest stack value in ecx
	EXTERNDEF _current_stack_limit:DWORD
	cmp ecx, dword ptr [_current_stack_limit]
	ja L77
	push eax
	EXTERNDEF interpreter_grow_stack:PROC
	call interpreter_grow_stack
	sub edx, ecx
L77:
	shl edx, 2
	sub esp, edx

	; Push the return address
	push eax

	; Setup frame pointer
	push ebp
	mov ebp, esp

	; Store the method pointer on the stack
	push ebx

	; Save the constant pool pointer on the stack
	movzx eax, word ptr [ebx + 24]
	test eax, 512
	je L84

	; load ROM constants pool
	EXTERNDEF _rom_constant_pool:DWORD
	mov eax, dword ptr [_rom_constant_pool]
	jmp L85
L84:

	; load method specific constants pool
	mov eax, dword ptr [ebx + 4]
L85:
	add eax, 12
	push eax

	; Save the current locals pointer (edi)
	push edi

	; Put a bytecode pointer in the byte code pointer store (bci == 0)
	push esi

	; Setup pointer to expression stack bottom
	push ebp
	mov dword ptr [ebp + -20], esp

	; Check if the method is synchronized
	movzx eax, word ptr [ebx + 24]
	test eax, 32
	jne L92
L93:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L92:

	; Synchronized method - register eax holds the access flags
	test eax, 8
	jne L102

	; Instance method - get receiver from parameter 1
	mov eax, dword ptr [edi + 0]
L101:

	; Object to synchronize on is in register eax
	sub esp, 28

	; Correct the stack bottom pointer
	mov dword ptr [ebp + -20], esp

	; Lock the stack lock
	mov dword ptr [ebp + -16], esi
	EXTERNDEF shared_lock_synchronized_method:PROC
	call shared_lock_synchronized_method

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
	jmp L93
L102:

	; Static method - synchronize on the mirror of the holder of constant pool of current method
	movzx eax, word ptr [ebx + 26]

	; load task mirror from class list in eax
	EXTERNDEF _mirror_list_base:DWORD
	mov ecx, dword ptr [_mirror_list_base]
	mov eax, dword ptr [ecx + eax * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp eax, dword ptr [_task_class_init_marker]
	jne L111
L115:

	; Class must be being initialized by the current thread then

	; Get the class to search the clinit list of current thread
	movzx ecx, word ptr [ebx + 26]
	EXTERNDEF _class_list_base:DWORD
	mov eax, dword ptr [_class_list_base]
	mov ecx, dword ptr [eax + ecx * 4 + 0]
	EXTERNDEF _current_task:DWORD
	mov eax, dword ptr [_current_task]
	mov eax, dword ptr [eax + 56]
L121:
	cmp ecx, dword ptr [eax + 8]
	je L120
	mov eax, dword ptr [eax + 16]
	jmp L121
L120:
L111:
	mov eax, dword ptr [eax + 4]
	jmp L101

	; ----------------------------------------------------------
	; Fast interpreter method entry (0 extra locals)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC fixed_interpreter_fast_method_entry_0
fixed_interpreter_fast_method_entry_0:
	EXTERNDEF interpreter_fast_method_entry_0:PROC
	jmp interpreter_fast_method_entry_0

	ALIGN 16
	PUBLIC interpreter_fast_method_entry_0
interpreter_fast_method_entry_0:

	; Save this interpreted method into interpretation log
	EXTERNDEF _interpretation_log_idx:DWORD
	mov eax, dword ptr [_interpretation_log_idx]
	EXTERNDEF _interpretation_log:DWORD
	mov dword ptr [eax + _interpretation_log], ebx
	lea eax, dword ptr [eax + 4]
	and eax, 31
	EXTERNDEF _interpretation_log_idx:DWORD
	mov dword ptr [_interpretation_log_idx], eax

	; Get the size of the parameters
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Pop the return address
	pop eax

	; Get the bytecode pointer from the method
	lea esi, dword ptr [ebx + 40]

	; Compute the start of the parameters - the locals pointer
	lea edi, dword ptr [esp + ecx * 4 + -4]

	; First, let's see if we have enough stack available
	movzx ecx, word ptr [ebx + 28]
	shl ecx, 2
	add ecx, 28
	neg ecx
	add ecx, esp

	; get lowest stack value in ecx
	EXTERNDEF _current_stack_limit:DWORD
	cmp ecx, dword ptr [_current_stack_limit]
	ja L137
	push eax
	EXTERNDEF interpreter_grow_stack:PROC
	call interpreter_grow_stack
	sub edx, ecx
L137:
	sub esp, 0

	; Push the return address
	push eax

	; Setup frame pointer
	push ebp
	mov ebp, esp

	; Push the method onto the stack
	push ebx

	; Push constants pool on stack
	movzx ecx, word ptr [ebx + 24]
	test ecx, 512
	je L144

	; load ROM constants pool
	EXTERNDEF _rom_constant_pool:DWORD
	mov ecx, dword ptr [_rom_constant_pool]
	jmp L145
L144:

	; load method specific constants pool
	mov ecx, dword ptr [ebx + 4]
L145:
	add ecx, 12
	push ecx

	; Push the locals pointer onto the stack
	push edi

	; Push the bytecode pointer onto the stack
	push esi

	; Setup the stack bottom pointer
	push ebp
	mov dword ptr [ebp + -20], esp

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Fast interpreter method entry (1 extra local)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC fixed_interpreter_fast_method_entry_1
fixed_interpreter_fast_method_entry_1:
	EXTERNDEF interpreter_fast_method_entry_1:PROC
	jmp interpreter_fast_method_entry_1

	ALIGN 16
	PUBLIC interpreter_fast_method_entry_1
interpreter_fast_method_entry_1:

	; Save this interpreted method into interpretation log
	EXTERNDEF _interpretation_log_idx:DWORD
	mov eax, dword ptr [_interpretation_log_idx]
	EXTERNDEF _interpretation_log:DWORD
	mov dword ptr [eax + _interpretation_log], ebx
	lea eax, dword ptr [eax + 4]
	and eax, 31
	EXTERNDEF _interpretation_log_idx:DWORD
	mov dword ptr [_interpretation_log_idx], eax

	; Get the size of the parameters
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Pop the return address
	pop eax

	; Get the bytecode pointer from the method
	lea esi, dword ptr [ebx + 40]

	; Compute the start of the parameters - the locals pointer
	lea edi, dword ptr [esp + ecx * 4 + -4]

	; Push cleared locals

	; First, let's see if we have enough stack available
	movzx ecx, word ptr [ebx + 28]
	shl ecx, 2
	add ecx, 28
	neg ecx
	add ecx, esp

	; get lowest stack value in ecx
	EXTERNDEF _current_stack_limit:DWORD
	cmp ecx, dword ptr [_current_stack_limit]
	ja L167
	push eax
	EXTERNDEF interpreter_grow_stack:PROC
	call interpreter_grow_stack
	sub edx, ecx
L167:
	sub esp, 4

	; Push the return address
	push eax

	; Setup frame pointer
	push ebp
	mov ebp, esp

	; Push the method onto the stack
	push ebx

	; Push constants pool on stack
	movzx ecx, word ptr [ebx + 24]
	test ecx, 512
	je L174

	; load ROM constants pool
	EXTERNDEF _rom_constant_pool:DWORD
	mov ecx, dword ptr [_rom_constant_pool]
	jmp L175
L174:

	; load method specific constants pool
	mov ecx, dword ptr [ebx + 4]
L175:
	add ecx, 12
	push ecx

	; Push the locals pointer onto the stack
	push edi

	; Push the bytecode pointer onto the stack
	push esi

	; Setup the stack bottom pointer
	push ebp
	mov dword ptr [ebp + -20], esp

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Fast interpreter method entry (2 extra locals)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC fixed_interpreter_fast_method_entry_2
fixed_interpreter_fast_method_entry_2:
	EXTERNDEF interpreter_fast_method_entry_2:PROC
	jmp interpreter_fast_method_entry_2

	ALIGN 16
	PUBLIC interpreter_fast_method_entry_2
interpreter_fast_method_entry_2:

	; Save this interpreted method into interpretation log
	EXTERNDEF _interpretation_log_idx:DWORD
	mov eax, dword ptr [_interpretation_log_idx]
	EXTERNDEF _interpretation_log:DWORD
	mov dword ptr [eax + _interpretation_log], ebx
	lea eax, dword ptr [eax + 4]
	and eax, 31
	EXTERNDEF _interpretation_log_idx:DWORD
	mov dword ptr [_interpretation_log_idx], eax

	; Get the size of the parameters
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Pop the return address
	pop eax

	; Get the bytecode pointer from the method
	lea esi, dword ptr [ebx + 40]

	; Compute the start of the parameters - the locals pointer
	lea edi, dword ptr [esp + ecx * 4 + -4]

	; Push cleared locals

	; First, let's see if we have enough stack available
	movzx ecx, word ptr [ebx + 28]
	shl ecx, 2
	add ecx, 28
	neg ecx
	add ecx, esp

	; get lowest stack value in ecx
	EXTERNDEF _current_stack_limit:DWORD
	cmp ecx, dword ptr [_current_stack_limit]
	ja L197
	push eax
	EXTERNDEF interpreter_grow_stack:PROC
	call interpreter_grow_stack
	sub edx, ecx
L197:
	sub esp, 8

	; Push the return address
	push eax

	; Setup frame pointer
	push ebp
	mov ebp, esp

	; Push the method onto the stack
	push ebx

	; Push constants pool on stack
	movzx ecx, word ptr [ebx + 24]
	test ecx, 512
	je L204

	; load ROM constants pool
	EXTERNDEF _rom_constant_pool:DWORD
	mov ecx, dword ptr [_rom_constant_pool]
	jmp L205
L204:

	; load method specific constants pool
	mov ecx, dword ptr [ebx + 4]
L205:
	add ecx, 12
	push ecx

	; Push the locals pointer onto the stack
	push edi

	; Push the bytecode pointer onto the stack
	push esi

	; Setup the stack bottom pointer
	push ebp
	mov dword ptr [ebp + -20], esp

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Fast interpreter method entry (3 extra locals)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC fixed_interpreter_fast_method_entry_3
fixed_interpreter_fast_method_entry_3:
	EXTERNDEF interpreter_fast_method_entry_3:PROC
	jmp interpreter_fast_method_entry_3

	ALIGN 16
	PUBLIC interpreter_fast_method_entry_3
interpreter_fast_method_entry_3:

	; Save this interpreted method into interpretation log
	EXTERNDEF _interpretation_log_idx:DWORD
	mov eax, dword ptr [_interpretation_log_idx]
	EXTERNDEF _interpretation_log:DWORD
	mov dword ptr [eax + _interpretation_log], ebx
	lea eax, dword ptr [eax + 4]
	and eax, 31
	EXTERNDEF _interpretation_log_idx:DWORD
	mov dword ptr [_interpretation_log_idx], eax

	; Get the size of the parameters
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Pop the return address
	pop eax

	; Get the bytecode pointer from the method
	lea esi, dword ptr [ebx + 40]

	; Compute the start of the parameters - the locals pointer
	lea edi, dword ptr [esp + ecx * 4 + -4]

	; Push cleared locals

	; First, let's see if we have enough stack available
	movzx ecx, word ptr [ebx + 28]
	shl ecx, 2
	add ecx, 28
	neg ecx
	add ecx, esp

	; get lowest stack value in ecx
	EXTERNDEF _current_stack_limit:DWORD
	cmp ecx, dword ptr [_current_stack_limit]
	ja L227
	push eax
	EXTERNDEF interpreter_grow_stack:PROC
	call interpreter_grow_stack
	sub edx, ecx
L227:
	sub esp, 12

	; Push the return address
	push eax

	; Setup frame pointer
	push ebp
	mov ebp, esp

	; Push the method onto the stack
	push ebx

	; Push constants pool on stack
	movzx ecx, word ptr [ebx + 24]
	test ecx, 512
	je L234

	; load ROM constants pool
	EXTERNDEF _rom_constant_pool:DWORD
	mov ecx, dword ptr [_rom_constant_pool]
	jmp L235
L234:

	; load method specific constants pool
	mov ecx, dword ptr [ebx + 4]
L235:
	add ecx, 12
	push ecx

	; Push the locals pointer onto the stack
	push edi

	; Push the bytecode pointer onto the stack
	push esi

	; Setup the stack bottom pointer
	push ebp
	mov dword ptr [ebp + -20], esp

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Fast interpreter method entry (4 extra locals)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC fixed_interpreter_fast_method_entry_4
fixed_interpreter_fast_method_entry_4:
	EXTERNDEF interpreter_fast_method_entry_4:PROC
	jmp interpreter_fast_method_entry_4

	ALIGN 16
	PUBLIC interpreter_fast_method_entry_4
interpreter_fast_method_entry_4:

	; Save this interpreted method into interpretation log
	EXTERNDEF _interpretation_log_idx:DWORD
	mov eax, dword ptr [_interpretation_log_idx]
	EXTERNDEF _interpretation_log:DWORD
	mov dword ptr [eax + _interpretation_log], ebx
	lea eax, dword ptr [eax + 4]
	and eax, 31
	EXTERNDEF _interpretation_log_idx:DWORD
	mov dword ptr [_interpretation_log_idx], eax

	; Get the size of the parameters
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Pop the return address
	pop eax

	; Get the bytecode pointer from the method
	lea esi, dword ptr [ebx + 40]

	; Compute the start of the parameters - the locals pointer
	lea edi, dword ptr [esp + ecx * 4 + -4]

	; Push cleared locals

	; First, let's see if we have enough stack available
	movzx ecx, word ptr [ebx + 28]
	shl ecx, 2
	add ecx, 28
	neg ecx
	add ecx, esp

	; get lowest stack value in ecx
	EXTERNDEF _current_stack_limit:DWORD
	cmp ecx, dword ptr [_current_stack_limit]
	ja L257
	push eax
	EXTERNDEF interpreter_grow_stack:PROC
	call interpreter_grow_stack
	sub edx, ecx
L257:
	sub esp, 16

	; Push the return address
	push eax

	; Setup frame pointer
	push ebp
	mov ebp, esp

	; Push the method onto the stack
	push ebx

	; Push constants pool on stack
	movzx ecx, word ptr [ebx + 24]
	test ecx, 512
	je L264

	; load ROM constants pool
	EXTERNDEF _rom_constant_pool:DWORD
	mov ecx, dword ptr [_rom_constant_pool]
	jmp L265
L264:

	; load method specific constants pool
	mov ecx, dword ptr [ebx + 4]
L265:
	add ecx, 12
	push ecx

	; Push the locals pointer onto the stack
	push edi

	; Push the bytecode pointer onto the stack
	push esi

	; Setup the stack bottom pointer
	push ebp
	mov dword ptr [ebp + -20], esp

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Quick native method entry (void)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC quick_void_native_method_entry
quick_void_native_method_entry:

	; Get the method parameter size
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; As we're called using "call" one more argument on stack is return address
	lea ecx, dword ptr [esp + ecx * 4 + 0]

	; Set space for fake parameter for static method (KNI-ism)
	movzx eax, word ptr [ebx + 24]
	and eax, 8
	cmp eax, 8
	jne L283
	add ecx, 4
L283:

	; Point _kni_parameter_base to the first parameter
	EXTERNDEF _kni_parameter_base:DWORD
	mov dword ptr [_kni_parameter_base], ecx

	; Get the quick native function entry and call it
	mov eax, dword ptr [ebx + 28]

	; Tell VM we're in quick native methods
	EXTERNDEF _jvm_in_quick_native_method:DWORD
	mov dword ptr [_jvm_in_quick_native_method], 1
	push ebx
	push eax
	EXTERNDEF call_on_primordial_stack:PROC
	call call_on_primordial_stack

	; clear junk from stack
	pop ebx

	; restore ebx
	pop ebx

	; Get the return address to my caller
	pop esi

	; Get the number of my parameters and pop them
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511
	lea esp, dword ptr [esp + ecx * 4 + 0]
	EXTERNDEF _jvm_in_quick_native_method:DWORD
	mov dword ptr [_jvm_in_quick_native_method], 0

	; Check if native method has generated exception
	EXTERNDEF _jvm_quick_native_exception:DWORD
	cmp dword ptr [_jvm_quick_native_exception], 0
	je L284

	; Push return address of my caller
	push esi

	; Let the exception be thrown by System.quickNativeThrow()
	EXTERNDEF persistent_handles:DWORD
	mov ebx, dword ptr [persistent_handles + 240]
	jmp  interpreter_method_entry
L284:

	; Jump to return address
	jmp esi

	; ----------------------------------------------------------
	; Quick native method entry (int)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC quick_int_native_method_entry
quick_int_native_method_entry:

	; Get the method parameter size
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; As we're called using "call" one more argument on stack is return address
	lea ecx, dword ptr [esp + ecx * 4 + 0]

	; Set space for fake parameter for static method (KNI-ism)
	movzx eax, word ptr [ebx + 24]
	and eax, 8
	cmp eax, 8
	jne L305
	add ecx, 4
L305:

	; Point _kni_parameter_base to the first parameter
	EXTERNDEF _kni_parameter_base:DWORD
	mov dword ptr [_kni_parameter_base], ecx

	; Get the quick native function entry and call it
	mov eax, dword ptr [ebx + 28]

	; Tell VM we're in quick native methods
	EXTERNDEF _jvm_in_quick_native_method:DWORD
	mov dword ptr [_jvm_in_quick_native_method], 1
	push ebx
	push eax
	EXTERNDEF call_on_primordial_stack:PROC
	call call_on_primordial_stack

	; return value is in eax

	; clear junk from stack
	pop ebx

	; restore ebx
	pop ebx

	; Get the return address to my caller
	pop esi

	; Get the number of my parameters and pop them
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511
	lea esp, dword ptr [esp + ecx * 4 + 0]

	; Push return value (1 word)
	push eax
	EXTERNDEF _jvm_in_quick_native_method:DWORD
	mov dword ptr [_jvm_in_quick_native_method], 0

	; Check if native method has generated exception
	EXTERNDEF _jvm_quick_native_exception:DWORD
	cmp dword ptr [_jvm_quick_native_exception], 0
	je L306

	; Push return address of my caller
	push esi

	; Let the exception be thrown by System.quickNativeThrow()
	EXTERNDEF persistent_handles:DWORD
	mov ebx, dword ptr [persistent_handles + 240]
	jmp  interpreter_method_entry
L306:

	; Jump to return address
	jmp esi

	; ----------------------------------------------------------
	; Quick native method entry (obj)
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC quick_obj_native_method_entry
quick_obj_native_method_entry:

	; Get the method parameter size
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; As we're called using "call" one more argument on stack is return address
	lea ecx, dword ptr [esp + ecx * 4 + 0]

	; Set space for fake parameter for static method (KNI-ism)
	movzx eax, word ptr [ebx + 24]
	and eax, 8
	cmp eax, 8
	jne L327
	add ecx, 4
L327:

	; Point _kni_parameter_base to the first parameter
	EXTERNDEF _kni_parameter_base:DWORD
	mov dword ptr [_kni_parameter_base], ecx

	; Get the quick native function entry and call it
	mov eax, dword ptr [ebx + 28]

	; Tell VM we're in quick native methods
	EXTERNDEF _jvm_in_quick_native_method:DWORD
	mov dword ptr [_jvm_in_quick_native_method], 1
	push ebx
	push eax
	EXTERNDEF call_on_primordial_stack:PROC
	call call_on_primordial_stack

	; return value is in eax

	; clear junk from stack
	pop ebx

	; restore ebx
	pop ebx

	; Get the return address to my caller
	pop esi

	; Get the number of my parameters and pop them
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511
	lea esp, dword ptr [esp + ecx * 4 + 0]

	; Push return value (1 word)
	push eax
	EXTERNDEF _jvm_in_quick_native_method:DWORD
	mov dword ptr [_jvm_in_quick_native_method], 0

	; Check if native method has generated exception
	EXTERNDEF _jvm_quick_native_exception:DWORD
	cmp dword ptr [_jvm_quick_native_exception], 0
	je L328

	; Push return address of my caller
	push esi

	; Let the exception be thrown by System.quickNativeThrow()
	EXTERNDEF persistent_handles:DWORD
	mov ebx, dword ptr [persistent_handles + 240]
	jmp  interpreter_method_entry
L328:

	; Jump to return address
	jmp esi

	; ----------------------------------------------------------
	; Interpreter bytecode templates
	; ----------------------------------------------------------

	PUBLIC bc_nop
bc_nop:

	PUBLIC bc_nop_internal
bc_nop_internal:

	; Do nothing

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; aconst_null is a duplicate of iconst_0

	PUBLIC bc_iconst_m1
bc_iconst_m1:

	PUBLIC bc_iconst_m1_internal
bc_iconst_m1_internal:
	push -1

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iconst_0
bc_iconst_0:

	PUBLIC bc_aconst_null
bc_aconst_null:

	PUBLIC bc_fconst_0
bc_fconst_0:

	PUBLIC bc_iconst_0_internal
bc_iconst_0_internal:

	PUBLIC bc_aconst_null_internal
bc_aconst_null_internal:

	PUBLIC bc_fconst_0_internal
bc_fconst_0_internal:
	push 0

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iconst_1
bc_iconst_1:

	PUBLIC bc_iconst_1_internal
bc_iconst_1_internal:
	push 1

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iconst_2
bc_iconst_2:

	PUBLIC bc_iconst_2_internal
bc_iconst_2_internal:
	push 2

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iconst_3
bc_iconst_3:

	PUBLIC bc_iconst_3_internal
bc_iconst_3_internal:
	push 3

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iconst_4
bc_iconst_4:

	PUBLIC bc_iconst_4_internal
bc_iconst_4_internal:
	push 4

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iconst_5
bc_iconst_5:

	PUBLIC bc_iconst_5_internal
bc_iconst_5_internal:
	push 5

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lconst_0
bc_lconst_0:

	PUBLIC bc_lconst_0_internal
bc_lconst_0_internal:
	push 0
	push 0

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lconst_1
bc_lconst_1:

	PUBLIC bc_lconst_1_internal
bc_lconst_1_internal:
	push 0
	push 1

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fconst_0 is a duplicate of iconst_0

	PUBLIC bc_fconst_1
bc_fconst_1:

	PUBLIC bc_fconst_1_internal
bc_fconst_1_internal:
	push 1065353216

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fconst_2
bc_fconst_2:

	PUBLIC bc_fconst_2_internal
bc_fconst_2_internal:
	push 1073741824

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dconst_0
bc_dconst_0:

	PUBLIC bc_dconst_0_internal
bc_dconst_0_internal:
	push 0
	push 0

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dconst_1
bc_dconst_1:

	PUBLIC bc_dconst_1_internal
bc_dconst_1_internal:
	push 1072693248
	push 0

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_bipush
bc_bipush:

	PUBLIC bc_bipush_internal
bc_bipush_internal:
	movsx eax, byte ptr [esi + 1]
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_sipush
bc_sipush:

	PUBLIC bc_sipush_internal
bc_sipush_internal:
	movzx eax, word ptr [esi + 1]
	bswap eax
	sar eax, 16
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ldc
bc_ldc:

	PUBLIC bc_ldc_w
bc_ldc_w:

	PUBLIC bc_ldc2_w
bc_ldc2_w:

	PUBLIC bc_invokevirtual
bc_invokevirtual:

	PUBLIC bc_invokespecial
bc_invokespecial:

	PUBLIC bc_ldc_internal
bc_ldc_internal:

	PUBLIC bc_ldc_w_internal
bc_ldc_w_internal:

	PUBLIC bc_ldc2_w_internal
bc_ldc2_w_internal:

	PUBLIC bc_invokevirtual_internal
bc_invokevirtual_internal:

	PUBLIC bc_invokespecial_internal
bc_invokespecial_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF quicken:DWORD
	mov eax, offset quicken

	; Notice the use of jump here
	EXTERNDEF interpreter_call_vm_redo:PROC
	jmp interpreter_call_vm_redo

	; ldc_w is a duplicate of ldc

	; ldc2_w is a duplicate of ldc

	; WIDE BYTECODE: iload

	; WIDE BYTECODE: fload

	; WIDE BYTECODE: aload
L399:

	PUBLIC bc_wide_iload_internal
bc_wide_iload_internal:

	PUBLIC bc_wide_fload_internal
bc_wide_fload_internal:

	PUBLIC bc_wide_aload_internal
bc_wide_aload_internal:
	movzx eax, word ptr [esi + 2]
	xchg ah, al
	neg eax
	push dword ptr [edi + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 4]

	; Advance bytecode pointer
	add esi, 4

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; Data containing entry for wide bytecode
	dd 	L399

	PUBLIC bc_iload
bc_iload:

	PUBLIC bc_fload
bc_fload:

	PUBLIC bc_aload
bc_aload:

	PUBLIC bc_iload_internal
bc_iload_internal:

	PUBLIC bc_fload_internal
bc_fload_internal:

	PUBLIC bc_aload_internal
bc_aload_internal:
	movzx eax, byte ptr [esi + 1]
	neg eax
	push dword ptr [edi + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; WIDE BYTECODE: lload

	; WIDE BYTECODE: dload
L410:

	PUBLIC bc_wide_lload_internal
bc_wide_lload_internal:

	PUBLIC bc_wide_dload_internal
bc_wide_dload_internal:
	movzx eax, word ptr [esi + 2]
	xchg ah, al
	neg eax
	push dword ptr [edi + eax * 4 + 0]
	push dword ptr [edi + eax * 4 + -4]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 4]

	; Advance bytecode pointer
	add esi, 4

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; Data containing entry for wide bytecode
	dd 	L410

	PUBLIC bc_lload
bc_lload:

	PUBLIC bc_dload
bc_dload:

	PUBLIC bc_lload_internal
bc_lload_internal:

	PUBLIC bc_dload_internal
bc_dload_internal:
	movzx eax, byte ptr [esi + 1]
	neg eax
	push dword ptr [edi + eax * 4 + 0]
	push dword ptr [edi + eax * 4 + -4]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fload is a duplicate of iload

	; dload is a duplicate of lload

	; aload is a duplicate of iload

	PUBLIC bc_iload_0
bc_iload_0:

	PUBLIC bc_fload_0
bc_fload_0:

	PUBLIC bc_aload_0
bc_aload_0:

	PUBLIC bc_iload_0_internal
bc_iload_0_internal:

	PUBLIC bc_fload_0_internal
bc_fload_0_internal:

	PUBLIC bc_aload_0_internal
bc_aload_0_internal:
	push dword ptr [edi + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iload_1
bc_iload_1:

	PUBLIC bc_fload_1
bc_fload_1:

	PUBLIC bc_aload_1
bc_aload_1:

	PUBLIC bc_iload_1_internal
bc_iload_1_internal:

	PUBLIC bc_fload_1_internal
bc_fload_1_internal:

	PUBLIC bc_aload_1_internal
bc_aload_1_internal:
	push dword ptr [edi + -4]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iload_2
bc_iload_2:

	PUBLIC bc_fload_2
bc_fload_2:

	PUBLIC bc_aload_2
bc_aload_2:

	PUBLIC bc_iload_2_internal
bc_iload_2_internal:

	PUBLIC bc_fload_2_internal
bc_fload_2_internal:

	PUBLIC bc_aload_2_internal
bc_aload_2_internal:
	push dword ptr [edi + -8]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iload_3
bc_iload_3:

	PUBLIC bc_fload_3
bc_fload_3:

	PUBLIC bc_aload_3
bc_aload_3:

	PUBLIC bc_iload_3_internal
bc_iload_3_internal:

	PUBLIC bc_fload_3_internal
bc_fload_3_internal:

	PUBLIC bc_aload_3_internal
bc_aload_3_internal:
	push dword ptr [edi + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lload_0
bc_lload_0:

	PUBLIC bc_dload_0
bc_dload_0:

	PUBLIC bc_lload_0_internal
bc_lload_0_internal:

	PUBLIC bc_dload_0_internal
bc_dload_0_internal:
	push dword ptr [edi + 0]
	push dword ptr [edi + -4]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lload_1
bc_lload_1:

	PUBLIC bc_dload_1
bc_dload_1:

	PUBLIC bc_lload_1_internal
bc_lload_1_internal:

	PUBLIC bc_dload_1_internal
bc_dload_1_internal:
	push dword ptr [edi + -4]
	push dword ptr [edi + -8]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lload_2
bc_lload_2:

	PUBLIC bc_dload_2
bc_dload_2:

	PUBLIC bc_lload_2_internal
bc_lload_2_internal:

	PUBLIC bc_dload_2_internal
bc_dload_2_internal:
	push dword ptr [edi + -8]
	push dword ptr [edi + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lload_3
bc_lload_3:

	PUBLIC bc_dload_3
bc_dload_3:

	PUBLIC bc_lload_3_internal
bc_lload_3_internal:

	PUBLIC bc_dload_3_internal
bc_dload_3_internal:
	push dword ptr [edi + -12]
	push dword ptr [edi + -16]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fload_0 is a duplicate of iload_0

	; fload_1 is a duplicate of iload_1

	; fload_2 is a duplicate of iload_2

	; fload_3 is a duplicate of iload_3

	; dload_0 is a duplicate of lload_0

	; dload_1 is a duplicate of lload_1

	; dload_2 is a duplicate of lload_2

	; dload_3 is a duplicate of lload_3

	; aload_0 is a duplicate of iload_0

	; aload_1 is a duplicate of iload_1

	; aload_2 is a duplicate of iload_2

	; aload_3 is a duplicate of iload_3

	PUBLIC bc_iaload
bc_iaload:

	PUBLIC bc_faload
bc_faload:

	PUBLIC bc_aaload
bc_aaload:

	PUBLIC bc_iaload_internal
bc_iaload_internal:

	PUBLIC bc_faload_internal
bc_faload_internal:

	PUBLIC bc_aaload_internal
bc_aaload_internal:

	; Load the array from the stack
	mov ecx, dword ptr [esp + 4]

	; Get array index
	pop edx

	; Null check
	test ecx, ecx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp edx, dword ptr [ecx + 4]
	jb L454
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L454:

	; Get the next bytecode
	movzx ebx, byte ptr [esi + 1]

	; Load array element
	mov eax, dword ptr [ecx + edx * 4 + 8]

	; Update the bytecode pointer
	inc esi

	; Load the array element
	mov dword ptr [esp + 0], eax

	; Dispatch to the next bytecode
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_laload
bc_laload:

	PUBLIC bc_daload
bc_daload:

	PUBLIC bc_laload_internal
bc_laload_internal:

	PUBLIC bc_daload_internal
bc_daload_internal:

	; Load the array from the stack
	mov ecx, dword ptr [esp + 4]

	; Get array index
	pop edx

	; Null check
	test ecx, ecx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp edx, dword ptr [ecx + 4]
	jb L463
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L463:

	; Get the next bytecode
	movzx ebx, byte ptr [esi + 1]

	; Load array element
	add esp, 4

	; Update the bytecode pointer
	inc esi

	; Load the array element
	push dword ptr [ecx + edx * 8 + 12]
	push dword ptr [ecx + edx * 8 + 8]

	; Dispatch to the next bytecode
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; faload is a duplicate of iaload

	; daload is a duplicate of laload

	; aaload is a duplicate of iaload

	PUBLIC bc_baload
bc_baload:

	PUBLIC bc_baload_internal
bc_baload_internal:

	; Load the array from the stack
	mov ecx, dword ptr [esp + 4]

	; Get array index
	pop edx

	; Null check
	test ecx, ecx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp edx, dword ptr [ecx + 4]
	jb L473
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L473:

	; Get the next bytecode
	movzx ebx, byte ptr [esi + 1]

	; Load array element
	movsx eax, byte ptr [ecx + edx * 1 + 8]

	; Update the bytecode pointer
	inc esi

	; Load the array element
	mov dword ptr [esp + 0], eax

	; Dispatch to the next bytecode
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_caload
bc_caload:

	PUBLIC bc_caload_internal
bc_caload_internal:

	; Load the array from the stack
	mov ecx, dword ptr [esp + 4]

	; Get array index
	pop edx

	; Null check
	test ecx, ecx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp edx, dword ptr [ecx + 4]
	jb L482
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L482:

	; Get the next bytecode
	movzx ebx, byte ptr [esi + 1]

	; Load array element
	movzx eax, word ptr [ecx + edx * 2 + 8]

	; Update the bytecode pointer
	inc esi

	; Load the array element
	mov dword ptr [esp + 0], eax

	; Dispatch to the next bytecode
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_saload
bc_saload:

	PUBLIC bc_saload_internal
bc_saload_internal:

	; Load the array from the stack
	mov ecx, dword ptr [esp + 4]

	; Get array index
	pop edx

	; Null check
	test ecx, ecx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp edx, dword ptr [ecx + 4]
	jb L491
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L491:

	; Get the next bytecode
	movzx ebx, byte ptr [esi + 1]

	; Load array element
	movsx eax, word ptr [ecx + edx * 2 + 8]

	; Update the bytecode pointer
	inc esi

	; Load the array element
	mov dword ptr [esp + 0], eax

	; Dispatch to the next bytecode
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; WIDE BYTECODE: istore

	; WIDE BYTECODE: fstore

	; WIDE BYTECODE: astore
L497:

	PUBLIC bc_wide_istore_internal
bc_wide_istore_internal:

	PUBLIC bc_wide_fstore_internal
bc_wide_fstore_internal:

	PUBLIC bc_wide_astore_internal
bc_wide_astore_internal:
	movzx eax, word ptr [esi + 2]
	xchg ah, al
	neg eax
	pop dword ptr [edi + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 4]

	; Advance bytecode pointer
	add esi, 4

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; Data containing entry for wide bytecode
	dd 	L497

	PUBLIC bc_istore
bc_istore:

	PUBLIC bc_fstore
bc_fstore:

	PUBLIC bc_astore
bc_astore:

	PUBLIC bc_istore_internal
bc_istore_internal:

	PUBLIC bc_fstore_internal
bc_fstore_internal:

	PUBLIC bc_astore_internal
bc_astore_internal:
	movzx eax, byte ptr [esi + 1]
	neg eax
	pop dword ptr [edi + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; WIDE BYTECODE: lstore

	; WIDE BYTECODE: dstore
L508:

	PUBLIC bc_wide_lstore_internal
bc_wide_lstore_internal:

	PUBLIC bc_wide_dstore_internal
bc_wide_dstore_internal:
	movzx eax, word ptr [esi + 2]
	xchg ah, al
	neg eax
	pop dword ptr [edi + eax * 4 + -4]
	pop dword ptr [edi + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 4]

	; Advance bytecode pointer
	add esi, 4

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; Data containing entry for wide bytecode
	dd 	L508

	PUBLIC bc_lstore
bc_lstore:

	PUBLIC bc_dstore
bc_dstore:

	PUBLIC bc_lstore_internal
bc_lstore_internal:

	PUBLIC bc_dstore_internal
bc_dstore_internal:
	movzx eax, byte ptr [esi + 1]
	neg eax
	pop dword ptr [edi + eax * 4 + -4]
	pop dword ptr [edi + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fstore is a duplicate of istore

	; dstore is a duplicate of lstore

	; astore is a duplicate of istore

	PUBLIC bc_istore_0
bc_istore_0:

	PUBLIC bc_fstore_0
bc_fstore_0:

	PUBLIC bc_astore_0
bc_astore_0:

	PUBLIC bc_istore_0_internal
bc_istore_0_internal:

	PUBLIC bc_fstore_0_internal
bc_fstore_0_internal:

	PUBLIC bc_astore_0_internal
bc_astore_0_internal:
	pop dword ptr [edi + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_istore_1
bc_istore_1:

	PUBLIC bc_fstore_1
bc_fstore_1:

	PUBLIC bc_astore_1
bc_astore_1:

	PUBLIC bc_istore_1_internal
bc_istore_1_internal:

	PUBLIC bc_fstore_1_internal
bc_fstore_1_internal:

	PUBLIC bc_astore_1_internal
bc_astore_1_internal:
	pop dword ptr [edi + -4]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_istore_2
bc_istore_2:

	PUBLIC bc_fstore_2
bc_fstore_2:

	PUBLIC bc_astore_2
bc_astore_2:

	PUBLIC bc_istore_2_internal
bc_istore_2_internal:

	PUBLIC bc_fstore_2_internal
bc_fstore_2_internal:

	PUBLIC bc_astore_2_internal
bc_astore_2_internal:
	pop dword ptr [edi + -8]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_istore_3
bc_istore_3:

	PUBLIC bc_fstore_3
bc_fstore_3:

	PUBLIC bc_astore_3
bc_astore_3:

	PUBLIC bc_istore_3_internal
bc_istore_3_internal:

	PUBLIC bc_fstore_3_internal
bc_fstore_3_internal:

	PUBLIC bc_astore_3_internal
bc_astore_3_internal:
	pop dword ptr [edi + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lstore_0
bc_lstore_0:

	PUBLIC bc_dstore_0
bc_dstore_0:

	PUBLIC bc_lstore_0_internal
bc_lstore_0_internal:

	PUBLIC bc_dstore_0_internal
bc_dstore_0_internal:
	pop dword ptr [edi + -4]
	pop dword ptr [edi + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lstore_1
bc_lstore_1:

	PUBLIC bc_dstore_1
bc_dstore_1:

	PUBLIC bc_lstore_1_internal
bc_lstore_1_internal:

	PUBLIC bc_dstore_1_internal
bc_dstore_1_internal:
	pop dword ptr [edi + -8]
	pop dword ptr [edi + -4]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lstore_2
bc_lstore_2:

	PUBLIC bc_dstore_2
bc_dstore_2:

	PUBLIC bc_lstore_2_internal
bc_lstore_2_internal:

	PUBLIC bc_dstore_2_internal
bc_dstore_2_internal:
	pop dword ptr [edi + -12]
	pop dword ptr [edi + -8]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lstore_3
bc_lstore_3:

	PUBLIC bc_dstore_3
bc_dstore_3:

	PUBLIC bc_lstore_3_internal
bc_lstore_3_internal:

	PUBLIC bc_dstore_3_internal
bc_dstore_3_internal:
	pop dword ptr [edi + -16]
	pop dword ptr [edi + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fstore_0 is a duplicate of istore_0

	; fstore_1 is a duplicate of istore_1

	; fstore_2 is a duplicate of istore_2

	; fstore_3 is a duplicate of istore_3

	; dstore_0 is a duplicate of lstore_0

	; dstore_1 is a duplicate of lstore_1

	; dstore_2 is a duplicate of lstore_2

	; dstore_3 is a duplicate of lstore_3

	; astore_0 is a duplicate of istore_0

	; astore_1 is a duplicate of istore_1

	; astore_2 is a duplicate of istore_2

	; astore_3 is a duplicate of istore_3

	PUBLIC bc_iastore
bc_iastore:

	PUBLIC bc_fastore
bc_fastore:

	PUBLIC bc_iastore_internal
bc_iastore_internal:

	PUBLIC bc_fastore_internal
bc_fastore_internal:

	; Get new element value
	pop eax

	; Get array index
	pop ecx

	; Get array pointer
	pop ebx

	; Null check
	test ebx, ebx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp ecx, dword ptr [ebx + 4]
	jb L551
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L551:

	; Store array element
	mov dword ptr [ebx + ecx * 4 + 8], eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lastore
bc_lastore:

	PUBLIC bc_dastore
bc_dastore:

	PUBLIC bc_lastore_internal
bc_lastore_internal:

	PUBLIC bc_dastore_internal
bc_dastore_internal:

	; Get new element value
	pop eax
	pop edx

	; Get array index
	pop ecx

	; Get array pointer
	pop ebx

	; Null check
	test ebx, ebx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp ecx, dword ptr [ebx + 4]
	jb L558
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L558:

	; Store array element
	mov dword ptr [ebx + ecx * 8 + 8], eax
	mov dword ptr [ebx + ecx * 8 + 12], edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fastore is a duplicate of iastore

	; dastore is a duplicate of lastore

	PUBLIC bc_aastore
bc_aastore:

	PUBLIC bc_aastore_internal
bc_aastore_internal:

	; Get new element value
	pop eax

	; Get array index
	pop ecx

	; Get array pointer
	pop ebx

	; Null check
	test ebx, ebx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp ecx, dword ptr [ebx + 4]
	jb L566
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L566:

	; Array store type check
	test eax, eax
	je L568
	mov edx, dword ptr [eax + 0]
	mov edx, dword ptr [edx + 0]
	mov edi, dword ptr [ebx + 0]
	mov edi, dword ptr [edi + 0]
	mov edi, dword ptr [edi + 36]
	cmp edi, dword ptr [edx + 20]
	je L569
	cmp edi, dword ptr [edx + 24]
	je L569
	push ebx
	push ecx
	push eax

	; Setup the pointer to the vm routine
	EXTERNDEF array_store_type_check:DWORD
	mov eax, offset array_store_type_check

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
	pop eax
	pop ecx
	pop ebx
L569:
	mov edi, dword ptr [ebp + -12]
L568:

	; Store array element
	lea ebx, dword ptr [ebx + ecx * 4 + 8]
	mov dword ptr [ebx + 0], eax

	; Oop write barrier (destination must be in heap)
	EXTERNDEF _bitvector_base:DWORD
	mov ecx, dword ptr [_bitvector_base]
	shr ebx, 2
	bts dword ptr [ecx + 0], ebx
L585:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_bastore
bc_bastore:

	PUBLIC bc_bastore_internal
bc_bastore_internal:

	; Get new element value
	pop eax

	; Get array index
	pop ecx

	; Get array pointer
	pop ebx

	; Null check
	test ebx, ebx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp ecx, dword ptr [ebx + 4]
	jb L593
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L593:

	; Store array element
	mov byte ptr [ebx + ecx * 1 + 8], al

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; castore is a duplicate of sastore

	PUBLIC bc_sastore
bc_sastore:

	PUBLIC bc_castore
bc_castore:

	PUBLIC bc_sastore_internal
bc_sastore_internal:

	PUBLIC bc_castore_internal
bc_castore_internal:

	; Get new element value
	pop eax

	; Get array index
	pop ecx

	; Get array pointer
	pop ebx

	; Null check
	test ebx, ebx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp ecx, dword ptr [ebx + 4]
	jb L600
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L600:

	; Store array element
	mov word ptr [ebx + ecx * 2 + 8], ax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_pop
bc_pop:

	PUBLIC bc_pop_internal
bc_pop_internal:
	add esp, 4

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_pop2
bc_pop2:

	PUBLIC bc_pop2_internal
bc_pop2_internal:
	add esp, 8

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dup
bc_dup:

	PUBLIC bc_dup_internal
bc_dup_internal:
	push dword ptr [esp + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dup_x1
bc_dup_x1:

	PUBLIC bc_dup_x1_internal
bc_dup_x1_internal:
	pop eax
	pop ebx
	push eax
	push ebx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dup_x2
bc_dup_x2:

	PUBLIC bc_dup_x2_internal
bc_dup_x2_internal:
	pop eax
	pop ebx
	pop ecx
	push eax
	push ecx
	push ebx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dup2
bc_dup2:

	PUBLIC bc_dup2_internal
bc_dup2_internal:

	; Duplicate long/double stack top (including tags)
	push dword ptr [esp + 4]
	push dword ptr [esp + 4]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dup2_x1
bc_dup2_x1:

	PUBLIC bc_dup2_x1_internal
bc_dup2_x1_internal:
	pop eax
	pop ebx
	pop ecx
	push ebx
	push eax
	push ecx
	push ebx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dup2_x2
bc_dup2_x2:

	PUBLIC bc_dup2_x2_internal
bc_dup2_x2_internal:
	pop eax
	pop ebx
	pop ecx
	pop edx
	push ebx
	push eax
	push edx
	push ecx
	push ebx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_swap
bc_swap:

	PUBLIC bc_swap_internal
bc_swap_internal:
	pop eax
	pop ebx
	push eax
	push ebx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iadd
bc_iadd:

	PUBLIC bc_iadd_internal
bc_iadd_internal:
	pop eax
	add dword ptr [esp + 0], eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ladd
bc_ladd:

	PUBLIC bc_ladd_internal
bc_ladd_internal:
	pop eax
	pop edx
	pop ebx
	pop ecx
	add eax, ebx
	adc edx, ecx
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fadd
bc_fadd:

	PUBLIC bc_fadd_internal
bc_fadd_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld dword ptr [esp + 4]
	fld dword ptr [esp + 0]
	fadd
	add esp, 4
	fstp dword ptr [esp + 0]
	sub esp, 4
	fstp dword ptr [esp + 0]
	add esp, 4
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dadd
bc_dadd:

	PUBLIC bc_dadd_internal
bc_dadd_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld qword ptr [esp + 8]
	fld qword ptr [esp + 0]
	fadd
	add esp, 8
	fstp qword ptr [esp + 0]
	sub esp, 8
	fstp qword ptr [esp + 0]
	add esp, 8
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_isub
bc_isub:

	PUBLIC bc_isub_internal
bc_isub_internal:
	pop eax
	sub dword ptr [esp + 0], eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lsub
bc_lsub:

	PUBLIC bc_lsub_internal
bc_lsub_internal:
	pop eax
	pop edx
	pop ebx
	pop ecx
	sub ebx, eax
	sbb ecx, edx
	mov eax, ebx
	mov edx, ecx
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fsub
bc_fsub:

	PUBLIC bc_fsub_internal
bc_fsub_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld dword ptr [esp + 4]
	fld dword ptr [esp + 0]
	fsub
	add esp, 4
	fstp dword ptr [esp + 0]
	sub esp, 4
	fstp dword ptr [esp + 0]
	add esp, 4
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dsub
bc_dsub:

	PUBLIC bc_dsub_internal
bc_dsub_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld qword ptr [esp + 8]
	fld qword ptr [esp + 0]
	fsub
	add esp, 8
	fstp qword ptr [esp + 0]
	sub esp, 8
	fstp qword ptr [esp + 0]
	add esp, 8
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_imul
bc_imul:

	PUBLIC bc_imul_internal
bc_imul_internal:
	pop eax
	imul eax, dword ptr [esp + 0]
	mov dword ptr [esp + 0], eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lmul
bc_lmul:

	PUBLIC bc_lmul_internal
bc_lmul_internal:
	pop ebx
	pop ecx
	pop eax
	pop edx
	push ecx
	push ebx
	push edx
	push eax
	EXTERNDEF jvm_lmul:PROC
	call jvm_lmul
	add esp, 16
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fmul
bc_fmul:

	PUBLIC bc_fmul_internal
bc_fmul_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld dword ptr [esp + 4]
	fld dword ptr [esp + 0]
	fmul
	add esp, 4
	fstp dword ptr [esp + 0]
	sub esp, 4
	fstp dword ptr [esp + 0]
	add esp, 4
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dmul
bc_dmul:

	PUBLIC bc_dmul_internal
bc_dmul_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]

	; DMUL

	; poping multiplicand
	fld qword ptr [esp + 0]

	; Loading 2^-15360
	fld tbyte ptr [L722]

	; scale: multiplier * 2^-15360
	fmul

	; poping multiplier
	fld qword ptr [esp + 8]

	; multiply: product * multiplicand
	fmul

	; Loading 2^15360
	fld tbyte ptr [L721]

	; rescale: product and 2^15360
	fmul

	; pushing results
	add esp, 8
	fstp qword ptr [esp + 0]
	sub esp, 8
	fstp qword ptr [esp + 0]
	add esp, 8
	jmp L723
L722:
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 128	
	db 255	
	db 3	
L721:
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 128	
	db 255	
	db 123	
L723:
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_idiv
bc_idiv:

	PUBLIC bc_idiv_internal
bc_idiv_internal:
	pop ecx
	pop eax
	test ecx, ecx
	EXTERNDEF interpreter_throw_ArithmeticException:PROC
	je interpreter_throw_ArithmeticException

	; Sign extend 32-bit value in eax to 64-bit value in eax:edx
	cdq

	; Do the division and push the quotient on the stack
	cmp eax, -2147483648
	jne L760
	xor edx, edx
	cmp ecx, -1
	je L761
L760:
	cdq
	idiv ecx
L761:
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ldiv
bc_ldiv:

	PUBLIC bc_ldiv_internal
bc_ldiv_internal:
	pop ebx
	pop ecx
	mov eax, ebx
	or eax, ecx
	EXTERNDEF interpreter_throw_ArithmeticException:PROC
	je interpreter_throw_ArithmeticException
	pop eax
	pop edx
	push ecx
	push ebx
	push edx
	push eax
	EXTERNDEF jvm_ldiv:PROC
	call jvm_ldiv
	add esp, 16
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fdiv
bc_fdiv:

	PUBLIC bc_fdiv_internal
bc_fdiv_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld dword ptr [esp + 4]
	fld dword ptr [esp + 0]
	fdiv
	add esp, 4
	fstp dword ptr [esp + 0]
	sub esp, 4
	fstp dword ptr [esp + 0]
	add esp, 4
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ddiv
bc_ddiv:

	PUBLIC bc_ddiv_internal
bc_ddiv_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]

	; DDIV

	; poping divisor
	fld qword ptr [esp + 0]

	; poping dividend
	fld qword ptr [esp + 8]

	; Loading 2^-15360
	fld tbyte ptr [L787]

	; scale: dividend * 2^-15360
	fmul

	; Swap dividend and divisor on the stack
	fxch

	; divide: dividend / divisor
	fdiv

	; Loading 2^15360
	fld tbyte ptr [L786]

	; rescale: quotient and 2^15360
	fmul

	; pushing results
	add esp, 8
	fstp qword ptr [esp + 0]
	sub esp, 8
	fstp qword ptr [esp + 0]
	add esp, 8
	jmp L788
L787:
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 128	
	db 255	
	db 3	
L786:
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 0	
	db 128	
	db 255	
	db 123	
L788:
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_irem
bc_irem:

	PUBLIC bc_irem_internal
bc_irem_internal:
	pop ecx
	pop eax
	test ecx, ecx
	EXTERNDEF interpreter_throw_ArithmeticException:PROC
	je interpreter_throw_ArithmeticException
	xor edx, edx

	; Sign extend 32-bit value in eax to 64-bit value in eax:edx
	cdq

	; Do the division and push the remainder on the stack
	cmp eax, -2147483648
	jne L825
	xor edx, edx
	cmp ecx, -1
	je L826
L825:
	cdq
	idiv ecx
L826:
	push edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lrem
bc_lrem:

	PUBLIC bc_lrem_internal
bc_lrem_internal:
	pop ebx
	pop ecx
	mov eax, ebx
	or eax, ecx
	EXTERNDEF interpreter_throw_ArithmeticException:PROC
	je interpreter_throw_ArithmeticException
	pop eax
	pop edx
	push ecx
	push ebx
	push edx
	push eax
	EXTERNDEF jvm_lrem:PROC
	call jvm_lrem
	add esp, 16
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_frem
bc_frem:

	PUBLIC bc_frem_internal
bc_frem_internal:

	; FREM checking for Infinity
	mov eax, dword ptr [esp + 0]
	mov edx, dword ptr [esp + 4]
	cmp eax, 2139095040
	je L836
	cmp eax, -8388608
	jne L837
L836:
	mov ecx, edx
	and ecx, 2147483647
	cmp ecx, 2139095040
	jge L837
	pop eax
	pop edx
	push edx
	jmp L838

	; FREM calculation
L837:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld dword ptr [esp + 4]
	fld dword ptr [esp + 0]
	fxch
L852:
	fprem
	fwait
	fnstsw ax
	sahf
	jp L852
	add esp, 4
	fstp dword ptr [esp + 0]
	sub esp, 4
	fstp dword ptr [esp + 0]
	add esp, 4

	; Results equals the sign of the dividend

	; Retrieve the sign bit
	and edx, -2147483648
	cmp edx, -2147483648
	jne L838
	mov edx, dword ptr [esp + 0]
	and edx, -2147483648
	cmp edx, -2147483648
	je L838

	; Change the sign bit
	fld dword ptr [esp + 0]
	fchs
	fstp dword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]
L838:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_drem
bc_drem:

	PUBLIC bc_drem_internal
bc_drem_internal:

	; DREM checking for Infinity
	mov eax, dword ptr [esp + 0]
	mov edx, dword ptr [esp + 4]
	mov ebx, dword ptr [esp + 8]
	mov ecx, dword ptr [esp + 12]
	cmp eax, 0
	jne L868
	cmp edx, 2146435072
	je L869
L868:
	cmp eax, 0
	jne L871
	cmp edx, -16777216
	jne L871
L869:
	mov edx, ecx
	and edx, 2147483647
	cmp edx, 2146435072
	jg L871
	jl L870
	cmp ebx, 0
	jae L871
L870:
	pop eax
	pop edx
	pop ebx
	pop ecx
	push ecx
	push ebx
	jmp L873

	; DREM calculation
L871:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld qword ptr [esp + 8]
	fld qword ptr [esp + 0]
	fxch
L892:
	fprem
	fwait
	fnstsw ax
	sahf
	jp L892
	add esp, 8
	fstp qword ptr [esp + 0]
	sub esp, 8
	fstp qword ptr [esp + 0]
	add esp, 8

	; Results equals the sign of the dividend

	; Retrieve the sign bit
	and ebx, 0
	and ecx, -2147483648
	cmp ebx, 0
	jne L873
	cmp ecx, -2147483648
	jne L873
	mov eax, dword ptr [esp + 0]
	mov edx, dword ptr [esp + 4]
	and eax, 0
	and edx, -2147483648
	cmp eax, 0
	jne L872
	cmp edx, -2147483648
	je L873
L872:

	; Change the sign bit
	fld qword ptr [esp + 0]
	fchs
	fstp qword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]
L873:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ineg
bc_ineg:

	PUBLIC bc_ineg_internal
bc_ineg_internal:
	pop eax
	neg eax
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lneg
bc_lneg:

	PUBLIC bc_lneg_internal
bc_lneg_internal:
	pop eax
	pop edx
	neg eax
	adc edx, 0
	neg edx
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fneg
bc_fneg:

	PUBLIC bc_fneg_internal
bc_fneg_internal:
	xor dword ptr [esp + 0], -2147483648

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dneg
bc_dneg:

	PUBLIC bc_dneg_internal
bc_dneg_internal:
	xor dword ptr [esp + 4], -2147483648

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ishl
bc_ishl:

	PUBLIC bc_ishl_internal
bc_ishl_internal:
	pop ecx
	shl dword ptr [esp + 0], cl

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lshl
bc_lshl:

	PUBLIC bc_lshl_internal
bc_lshl_internal:
	pop ecx
	pop eax
	pop edx
	and ecx, 63
	cmp ecx, 32
	jl L929
	mov edx, eax
	xor eax, eax
L929:
	shld edx, eax, cl
	shl eax, cl
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ishr
bc_ishr:

	PUBLIC bc_ishr_internal
bc_ishr_internal:
	pop ecx
	sar dword ptr [esp + 0], cl

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lshr
bc_lshr:

	PUBLIC bc_lshr_internal
bc_lshr_internal:
	pop ecx
	pop eax
	pop edx
	and ecx, 63
	cmp ecx, 32
	jl L937
	mov eax, edx
	sar edx, 31
L937:
	shrd eax, edx, cl
	sar edx, cl
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iushr
bc_iushr:

	PUBLIC bc_iushr_internal
bc_iushr_internal:
	pop ecx
	shr dword ptr [esp + 0], cl

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lushr
bc_lushr:

	PUBLIC bc_lushr_internal
bc_lushr_internal:
	pop ecx
	pop eax
	pop edx
	and ecx, 63
	cmp ecx, 32
	jl L946
	mov eax, edx
	xor edx, edx
L946:
	shrd eax, edx, cl
	shr edx, cl
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iand
bc_iand:

	PUBLIC bc_iand_internal
bc_iand_internal:
	pop eax
	and dword ptr [esp + 0], eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_land
bc_land:

	PUBLIC bc_land_internal
bc_land_internal:
	pop eax
	pop edx
	pop ebx
	pop ecx
	and eax, ebx
	and edx, ecx
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ior
bc_ior:

	PUBLIC bc_ior_internal
bc_ior_internal:
	pop eax
	or dword ptr [esp + 0], eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lor
bc_lor:

	PUBLIC bc_lor_internal
bc_lor_internal:
	pop eax
	pop edx
	pop ebx
	pop ecx
	or eax, ebx
	or edx, ecx
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ixor
bc_ixor:

	PUBLIC bc_ixor_internal
bc_ixor_internal:
	pop eax
	xor dword ptr [esp + 0], eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lxor
bc_lxor:

	PUBLIC bc_lxor_internal
bc_lxor_internal:
	pop eax
	pop edx
	pop ebx
	pop ecx
	xor eax, ebx
	xor edx, ecx
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; WIDE BYTECODE: iinc
L966:

	PUBLIC bc_wide_iinc_internal
bc_wide_iinc_internal:

	; Get local index
	movzx ebx, word ptr [esi + 2]
	xchg bh, bl

	; Get constant
	movzx edx, word ptr [esi + 4]
	xchg dh, dl
	movsx edx, dx

	; Do the addition
	neg ebx
	add dword ptr [edi + ebx * 4 + 0], edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 6]

	; Advance bytecode pointer
	add esi, 6

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; Data containing entry for wide bytecode
	dd 	L966

	PUBLIC bc_iinc
bc_iinc:

	PUBLIC bc_iinc_internal
bc_iinc_internal:

	; Get local index
	movzx ebx, byte ptr [esi + 1]

	; Get constant
	movsx edx, byte ptr [esi + 2]

	; Do the addition
	neg ebx
	add dword ptr [edi + ebx * 4 + 0], edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_i2l
bc_i2l:

	PUBLIC bc_i2l_internal
bc_i2l_internal:
	pop eax
	xor edx, edx
	cdq
	push edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_i2f
bc_i2f:

	PUBLIC bc_i2f_internal
bc_i2f_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fild dword ptr [esp + 0]
	fstp dword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_i2d
bc_i2d:

	PUBLIC bc_i2d_internal
bc_i2d_internal:
	fild dword ptr [esp + 0]
	sub esp, 4
	fstp qword ptr [esp + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_l2i
bc_l2i:

	PUBLIC bc_l2i_internal
bc_l2i_internal:
	pop eax
	pop edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_l2f
bc_l2f:

	PUBLIC bc_l2f_internal
bc_l2f_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fild qword ptr [esp + 0]
	add esp, 4
	fstp dword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_l2d
bc_l2d:

	PUBLIC bc_l2d_internal
bc_l2d_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fild qword ptr [esp + 0]
	fstp qword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_f2i
bc_f2i:

	PUBLIC bc_f2i_internal
bc_f2i_internal:

	; F2I Checking for NaNs and Infinity
	mov eax, dword ptr [esp + 0]
	and eax, 2147483647
	cmp eax, 1325400064
	jl L1024

	; Check for NaNs
	pop eax
	cmp eax, 2139095041
	jl L1020
	cmp eax, 2147483647
	jle L1019
L1020:
	cmp eax, -8388607
	jb L1021
	cmp eax, -1
	ja L1021

	; NaN
L1019:
	mov eax, 0
	jmp L1023

	; Positive Infinity
L1021:
	cmp eax, 0
	jle L1022
	mov eax, 2147483647
	jmp L1023

	; Negative Infinity
L1022:
	cmp eax, 0
	jge L1023
	mov eax, -2147483648
L1023:
	push eax
	jmp L1025

	; F2I conversion
L1024:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 3711
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld dword ptr [esp + 0]
	fistp dword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]
L1025:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_f2l
bc_f2l:

	PUBLIC bc_f2l_internal
bc_f2l_internal:

	; F2L Checking for NaNs and Infinity
	mov eax, dword ptr [esp + 0]
	and eax, 2147483647
	cmp eax, 1593835520
	jl L1053

	; Check for NaNs
	pop eax
	cmp eax, 2139095041
	jl L1049
	cmp eax, 2147483647
	jle L1048
L1049:
	cmp eax, -8388607
	jb L1050
	cmp eax, -1
	ja L1050

	; NaN
L1048:
	mov edx, 0
	mov eax, 0
	jmp L1052

	; Positive Infinity
L1050:
	cmp eax, 0
	jle L1051
	mov edx, 2147483647
	mov eax, -1
	jmp L1052

	; Negative Infinity
L1051:
	cmp eax, 0
	jge L1052
	mov edx, -2147483648
	mov eax, 0
L1052:
	push edx
	push eax
	jmp L1054

	; F2L conversion
L1053:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 3711
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld dword ptr [esp + 0]
	sub esp, 4
	fistp qword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]
L1054:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_f2d
bc_f2d:

	PUBLIC bc_f2d_internal
bc_f2d_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld dword ptr [esp + 0]
	sub esp, 4
	fstp qword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_d2i
bc_d2i:

	PUBLIC bc_d2i_internal
bc_d2i_internal:

	; D2I Checking for NaNs and Infinity
	mov eax, dword ptr [esp + 0]
	mov edx, dword ptr [esp + 4]
	and edx, 2147483647
	cmp edx, 1105199104
	jl L1102
	jg L1092
	cmp eax, 0
	jb L1102

	; Check for NaNs
L1092:
	pop eax
	pop edx
	cmp edx, 2146435072
	jl L1095
	jg L1094
	cmp eax, 1
	jb L1095
L1094:
	cmp edx, 2147483647
	jl L1093
	jg L1095
	cmp eax, -1
	jbe L1093
L1095:
	cmp edx, -1048576
	jb L1097
	ja L1096
	cmp eax, 1
	jb L1097
L1096:
	cmp edx, -1
	ja L1097
	jb L1093
	cmp eax, -1
	ja L1097

	; NaN
L1093:
	mov eax, 0
	jmp L1101

	; Positive Infinity
L1097:
	cmp edx, 0
	jl L1099
	jg L1098
	cmp eax, 0
	jbe L1099
L1098:
	mov eax, 2147483647
	jmp L1101

	; Negative Infinity
L1099:
	cmp edx, 0
	jg L1101
	jl L1100
	cmp eax, 0
	jae L1101
L1100:
	mov eax, -2147483648
L1101:
	push eax
	jmp L1103

	; D2I conversion
L1102:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 3711
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld qword ptr [esp + 0]
	add esp, 4
	fistp dword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]
L1103:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_d2l
bc_d2l:

	PUBLIC bc_d2l_internal
bc_d2l_internal:

	; D2L Checking for NaNs and Infinity
	mov eax, dword ptr [esp + 0]
	mov edx, dword ptr [esp + 4]
	and edx, 2147483647
	cmp edx, 1138753536
	jl L1145
	jg L1135
	cmp eax, 0
	jb L1145

	; Check for NaNs
L1135:
	pop eax
	pop edx
	cmp edx, 2146435072
	jl L1138
	jg L1137
	cmp eax, 1
	jb L1138
L1137:
	cmp edx, 2147483647
	jl L1136
	jg L1138
	cmp eax, -1
	jbe L1136
L1138:
	cmp edx, -1048576
	jb L1140
	ja L1139
	cmp eax, 1
	jb L1140
L1139:
	cmp edx, -1
	ja L1140
	jb L1136
	cmp eax, -1
	ja L1140

	; NaN
L1136:
	mov edx, 0
	mov eax, 0
	jmp L1144

	; Positive Infinity
L1140:
	cmp edx, 0
	jl L1142
	jg L1141
	cmp eax, 0
	jbe L1142
L1141:
	mov edx, 2147483647
	mov eax, -1
	jmp L1144

	; Negative Infinity
L1142:
	cmp edx, 0
	jg L1144
	jl L1143
	cmp eax, 0
	jae L1144
L1143:
	mov edx, -2147483648
	mov eax, 0
L1144:
	push edx
	push eax
	jmp L1146

	; D2L conversion
L1145:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 3711
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld qword ptr [esp + 0]
	fistp qword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]
L1146:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_d2f
bc_d2f:

	PUBLIC bc_d2f_internal
bc_d2f_internal:
	EXTERNDEF local_saved_cw:DWORD
	fstcw word ptr [local_saved_cw]
	EXTERNDEF local_masked_cw:DWORD
	fstcw word ptr [local_masked_cw]
	EXTERNDEF local_masked_cw:DWORD
	mov dword ptr [local_masked_cw], 639
	EXTERNDEF local_masked_cw:DWORD
	fldcw word ptr [local_masked_cw]
	fld qword ptr [esp + 0]
	add esp, 4
	fstp dword ptr [esp + 0]
	EXTERNDEF local_saved_cw:DWORD
	fldcw word ptr [local_saved_cw]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_i2b
bc_i2b:

	PUBLIC bc_i2b_internal
bc_i2b_internal:
	pop ecx
	movsx eax, cl
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_i2c
bc_i2c:

	PUBLIC bc_i2c_internal
bc_i2c_internal:
	pop ecx
	movzx eax, cx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_i2s
bc_i2s:

	PUBLIC bc_i2s_internal
bc_i2s_internal:
	pop ecx
	movsx eax, cx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_lcmp
bc_lcmp:

	PUBLIC bc_lcmp_internal
bc_lcmp_internal:
	pop eax
	pop edx
	pop ebx
	pop ecx
	sub ebx, eax
	sbb ecx, edx
	jno L1197

	; If underflow happened then invert the result
	not ecx
L1197:
	or ebx, ecx
	je L1198
	sar ecx, 30
	and ecx, -2
	inc ecx
L1198:
	push ecx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fcmpl
bc_fcmpl:

	PUBLIC bc_fcmpl_internal
bc_fcmpl_internal:
	fld dword ptr [esp + 0]
	fld dword ptr [esp + 4]
	add esp, 8
	fcompp

	; Convert FPU condition into eflags condition via eax
	fwait
	fnstsw ax
	sahf
	mov ecx, -1
	jp L1206
	jb L1206
	mov ecx, 0
	je L1206
	inc ecx
L1206:
	push ecx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fcmpg
bc_fcmpg:

	PUBLIC bc_fcmpg_internal
bc_fcmpg_internal:
	fld dword ptr [esp + 0]
	fld dword ptr [esp + 4]
	add esp, 8
	fcompp

	; Convert FPU condition into eflags condition via eax
	fwait
	fnstsw ax
	sahf
	mov ecx, 1
	jp L1214
	ja L1214
	mov ecx, 0
	je L1214
	dec ecx
L1214:
	push ecx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dcmpl
bc_dcmpl:

	PUBLIC bc_dcmpl_internal
bc_dcmpl_internal:
	fld qword ptr [esp + 0]
	fld qword ptr [esp + 8]
	add esp, 16
	fcompp

	; Convert FPU condition into eflags condition via eax
	fwait
	fnstsw ax
	sahf
	mov ecx, -1
	jp L1222
	jb L1222
	mov ecx, 0
	je L1222
	inc ecx
L1222:
	push ecx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_dcmpg
bc_dcmpg:

	PUBLIC bc_dcmpg_internal
bc_dcmpg_internal:
	fld qword ptr [esp + 0]
	fld qword ptr [esp + 8]
	add esp, 16
	fcompp

	; Convert FPU condition into eflags condition via eax
	fwait
	fnstsw ax
	sahf
	mov ecx, 1
	jp L1230
	ja L1230
	mov ecx, 0
	je L1230
	dec ecx
L1230:
	push ecx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ifeq
bc_ifeq:

	PUBLIC bc_ifnull
bc_ifnull:

	PUBLIC bc_ifeq_internal
bc_ifeq_internal:

	PUBLIC bc_ifnull_internal
bc_ifnull_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	test eax, eax
	jne L1238

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1238:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ifne
bc_ifne:

	PUBLIC bc_ifnonnull
bc_ifnonnull:

	PUBLIC bc_ifne_internal
bc_ifne_internal:

	PUBLIC bc_ifnonnull_internal
bc_ifnonnull_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	test eax, eax
	je L1248

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1248:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_iflt
bc_iflt:

	PUBLIC bc_iflt_internal
bc_iflt_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	test eax, eax
	jge L1258

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1258:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ifge
bc_ifge:

	PUBLIC bc_ifge_internal
bc_ifge_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	test eax, eax
	jl L1268

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1268:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ifgt
bc_ifgt:

	PUBLIC bc_ifgt_internal
bc_ifgt_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	test eax, eax
	jle L1278

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1278:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ifle
bc_ifle:

	PUBLIC bc_ifle_internal
bc_ifle_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	test eax, eax
	jg L1288

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1288:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_if_icmpeq
bc_if_icmpeq:

	PUBLIC bc_if_acmpeq
bc_if_acmpeq:

	PUBLIC bc_if_icmpeq_internal
bc_if_icmpeq_internal:

	PUBLIC bc_if_acmpeq_internal
bc_if_acmpeq_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	pop edx
	cmp edx, eax
	jne L1298

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1298:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_if_icmpne
bc_if_icmpne:

	PUBLIC bc_if_acmpne
bc_if_acmpne:

	PUBLIC bc_if_icmpne_internal
bc_if_icmpne_internal:

	PUBLIC bc_if_acmpne_internal
bc_if_acmpne_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	pop edx
	cmp edx, eax
	je L1308

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1308:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_if_icmplt
bc_if_icmplt:

	PUBLIC bc_if_icmplt_internal
bc_if_icmplt_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	pop edx
	cmp edx, eax
	jge L1318

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1318:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_if_icmpge
bc_if_icmpge:

	PUBLIC bc_if_icmpge_internal
bc_if_icmpge_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	pop edx
	cmp edx, eax
	jl L1328

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1328:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_if_icmpgt
bc_if_icmpgt:

	PUBLIC bc_if_icmpgt_internal
bc_if_icmpgt_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	pop edx
	cmp edx, eax
	jle L1338

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1338:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_if_icmple
bc_if_icmple:

	PUBLIC bc_if_icmple_internal
bc_if_icmple_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick
	pop eax
	pop edx
	cmp edx, eax
	jg L1348

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]
L1348:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; if_acmpeq is a duplicate of if_icmpeq

	; if_acmpne is a duplicate of if_icmpne

	PUBLIC bc_goto
bc_goto:

	PUBLIC bc_goto_internal
bc_goto_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Load jump offset in edx and update esi to point to destination
	movzx edx, word ptr [esi + 1]
	xchg dh, dl
	movsx edx, dx
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_tableswitch
bc_tableswitch:

	PUBLIC bc_tableswitch_internal
bc_tableswitch_internal:

	; Check for timer tick as we can have negative offsets in the table

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Get the lookup key
	pop eax

	; Get an aligned version of the bytecode pointer
	lea ebx, dword ptr [esi + 4]
	and ebx, -4

	; Load the low and high limits
	mov ecx, dword ptr [ebx + 4]
	mov edx, dword ptr [ebx + 8]

	; Check against the low and high limits
	cmp eax, ecx
	jl L1361
	cmp eax, edx
	jg L1361

	; Lookup dispatch offset
	sub eax, ecx
	mov edx, dword ptr [ebx + eax * 4 + 12]

	; Continue execution
L1362:
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; Handle default case
L1361:
	mov edx, dword ptr [ebx + 0]
	jmp L1362

	PUBLIC bc_lookupswitch
bc_lookupswitch:

	PUBLIC bc_lookupswitch_internal
bc_lookupswitch_internal:

	; Check for timer tick as we can have negative offsets in the table

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Get the lookup key
	pop eax

	; Get an aligned version of the bytecode pointer
	lea ebx, dword ptr [esi + 4]
	and ebx, -4

	; Get the number of elements in the table
	mov ecx, dword ptr [ebx + 4]
	jmp L1374

	; Search the table
L1375:
	cmp eax, dword ptr [ebx + ecx * 8 + 8]
	je L1376
L1374:
	dec ecx
	jge L1375

	; Default case
	mov edx, dword ptr [ebx + 0]
	jmp L1377

	; Entry found - get the offset
L1376:
	mov edx, dword ptr [ebx + ecx * 8 + 12]

	; Continue the execution
L1377:
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_ireturn
bc_ireturn:

	PUBLIC bc_freturn
bc_freturn:

	PUBLIC bc_areturn
bc_areturn:

	PUBLIC bc_ireturn_internal
bc_ireturn_internal:

	PUBLIC bc_freturn_internal
bc_freturn_internal:

	PUBLIC bc_areturn_internal
bc_areturn_internal:

	; See if there are any stack locks
	lea eax, dword ptr [ebp + -20]
	cmp dword ptr [eax + 0], eax
	je L1394
	mov dword ptr [ebp + -16], esi
	mov ebx, dword ptr [ebp + -4]
	movzx ecx, word ptr [ebx + 24]
	test ecx, 32
	je L1390
	EXTERNDEF shared_unlock_synchronized_method:PROC
	call shared_unlock_synchronized_method
	jmp L1390
L1392:

	; Found locked monitor that shouldn't have been
	EXTERNDEF illegal_monitor_state_exception:DWORD
	mov eax, offset illegal_monitor_state_exception
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm
L1393:
L1390:
	mov ecx, dword ptr [ebp + -20]
	lea ebx, dword ptr [ebp + -20]
L1405:
	cmp dword ptr [ecx + 24], 0
	jne L1392
	add ecx, 28
	cmp ecx, ebx
	jne L1405
L1389:

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
L1394:

	; Get the return value
	mov eax, dword ptr [esp + 0]

	; Remove activation and store return address in esi
	mov esp, ebp
	pop ebp
	pop esi
	lea esp, dword ptr [edi + 4]

	; Push the return value onto the stack
	push eax

	; Jump to return address
	jmp esi

	PUBLIC bc_lreturn
bc_lreturn:

	PUBLIC bc_dreturn
bc_dreturn:

	PUBLIC bc_lreturn_internal
bc_lreturn_internal:

	PUBLIC bc_dreturn_internal
bc_dreturn_internal:

	; See if there are any stack locks
	lea eax, dword ptr [ebp + -20]
	cmp dword ptr [eax + 0], eax
	je L1420
	mov dword ptr [ebp + -16], esi
	mov ebx, dword ptr [ebp + -4]
	movzx ecx, word ptr [ebx + 24]
	test ecx, 32
	je L1416
	EXTERNDEF shared_unlock_synchronized_method:PROC
	call shared_unlock_synchronized_method
	jmp L1416
L1418:

	; Found locked monitor that shouldn't have been
	EXTERNDEF illegal_monitor_state_exception:DWORD
	mov eax, offset illegal_monitor_state_exception
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm
L1419:
L1416:
	mov ecx, dword ptr [ebp + -20]
	lea ebx, dword ptr [ebp + -20]
L1431:
	cmp dword ptr [ecx + 24], 0
	jne L1418
	add ecx, 28
	cmp ecx, ebx
	jne L1431
L1415:

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
L1420:

	; Get the return value
	mov eax, dword ptr [esp + 0]
	mov edx, dword ptr [esp + 4]

	; Remove activation and store return address in esi
	mov esp, ebp
	pop ebp
	pop esi
	lea esp, dword ptr [edi + 4]

	; Push the return value onto the stack
	push edx
	push eax

	; Jump to return address
	jmp esi

	; freturn is a duplicate of ireturn

	; dreturn is a duplicate of lreturn

	; areturn is a duplicate of ireturn

	PUBLIC bc_return
bc_return:

	PUBLIC bc_return_internal
bc_return_internal:

	; See if there are any stack locks
	lea eax, dword ptr [ebp + -20]
	cmp dword ptr [eax + 0], eax
	je L1447
	mov dword ptr [ebp + -16], esi
	mov ebx, dword ptr [ebp + -4]
	movzx ecx, word ptr [ebx + 24]
	test ecx, 32
	je L1443
	EXTERNDEF shared_unlock_synchronized_method:PROC
	call shared_unlock_synchronized_method
	jmp L1443
L1445:

	; Found locked monitor that shouldn't have been
	EXTERNDEF illegal_monitor_state_exception:DWORD
	mov eax, offset illegal_monitor_state_exception
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm
L1446:
L1443:
	mov ecx, dword ptr [ebp + -20]
	lea ebx, dword ptr [ebp + -20]
L1458:
	cmp dword ptr [ecx + 24], 0
	jne L1445
	add ecx, 28
	cmp ecx, ebx
	jne L1458
L1442:

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
L1447:

	; Remove activation and store return address in esi
	mov esp, ebp
	pop ebp
	pop esi
	lea esp, dword ptr [edi + 4]

	; Jump to return address
	jmp esi

	PUBLIC bc_getstatic
bc_getstatic:

	PUBLIC bc_getstatic_internal
bc_getstatic_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF getstatic:DWORD
	mov eax, offset getstatic

	; Notice the use of jump here
	EXTERNDEF interpreter_call_vm_dispatch:PROC
	jmp interpreter_call_vm_dispatch

	PUBLIC bc_putstatic
bc_putstatic:

	PUBLIC bc_putstatic_internal
bc_putstatic_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF putstatic:DWORD
	mov eax, offset putstatic

	; Notice the use of jump here
	EXTERNDEF interpreter_call_vm_dispatch:PROC
	jmp interpreter_call_vm_dispatch

	PUBLIC bc_getfield
bc_getfield:

	PUBLIC bc_getfield_internal
bc_getfield_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF getfield:DWORD
	mov eax, offset getfield

	; Notice the use of jump here
	EXTERNDEF interpreter_call_vm_redo:PROC
	jmp interpreter_call_vm_redo

	PUBLIC bc_putfield
bc_putfield:

	PUBLIC bc_putfield_internal
bc_putfield_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF putfield:DWORD
	mov eax, offset putfield

	; Notice the use of jump here
	EXTERNDEF interpreter_call_vm_redo:PROC
	jmp interpreter_call_vm_redo

	; invokevirtual is a duplicate of ldc

	; invokespecial is a duplicate of ldc

	PUBLIC bc_invokestatic
bc_invokestatic:

	PUBLIC bc_invokestatic_internal
bc_invokestatic_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF quicken_invokestatic:DWORD
	mov eax, offset quicken_invokestatic

	; Notice the use of jump here
	EXTERNDEF interpreter_call_vm_dispatch:PROC
	jmp interpreter_call_vm_dispatch

	PUBLIC bc_invokeinterface
bc_invokeinterface:

	PUBLIC bc_invokeinterface_internal
bc_invokeinterface_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF quicken:DWORD
	mov eax, offset quicken

	; Notice the use of jump here
	EXTERNDEF interpreter_call_vm_redo:PROC
	jmp interpreter_call_vm_redo

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 5]

	; Advance bytecode pointer
	add esi, 5

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_new
bc_new:

	PUBLIC bc_new_internal
bc_new_internal:

	; Call runtime routine

	; Setup the pointer to the vm routine
	EXTERNDEF newobject:DWORD
	mov eax, offset newobject

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_newarray
bc_newarray:

	PUBLIC bc_newarray_internal
bc_newarray_internal:

	; Get the array type
	movzx eax, byte ptr [esi + 1]

	; Compute size of array
	mov ebx, dword ptr [esp + 0]
	cmp ebx, 1048575
	ja L1490
	mov ecx, eax
	and ecx, 3
	shl ebx, cl
	add ebx, 11
	shr ebx, 2

	; Get the array class
	EXTERNDEF persistent_handles:DWORD
	mov ecx, dword ptr [eax * 4 + persistent_handles + 48]

	; Get _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov eax, dword ptr [_inline_allocation_top]

	; Compute new top
	lea edx, dword ptr [eax + ebx * 4 + 0]

	; Check for overflow
	cmp edx, eax
	jb L1490

	; Compare against _inline_allocation_end
	EXTERNDEF _inline_allocation_end:DWORD
	cmp edx, dword ptr [_inline_allocation_end]
	ja L1490

	; Allocation succeeded, set _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov dword ptr [_inline_allocation_top], edx

	; Get prototypical near from far class
	mov ecx, dword ptr [ecx + 12]

	; Clear fields
	xor edx, edx
	cmp ebx, 0
	je L1504
L1505:
	mov dword ptr [eax + ebx * 4 + -4], edx
	dec ebx
	jne L1505

	; Set prototypical near in array
L1504:
	mov dword ptr [eax + 0], ecx

	; Set length in array
	pop ebx
	mov dword ptr [eax + 4], ebx
	jmp L1491
L1490:

	; Setup the pointer to the vm routine
	EXTERNDEF newarray:DWORD
	mov eax, offset newarray

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
	pop edx
L1491:

	; Push result onto stack
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_anewarray
bc_anewarray:

	PUBLIC bc_anewarray_internal
bc_anewarray_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF anewarray:DWORD
	mov eax, offset anewarray

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
	pop ebx

	; Push the result on the stack
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_arraylength
bc_arraylength:

	PUBLIC bc_arraylength_internal
bc_arraylength_internal:
	pop eax

	; Null check
	test eax, eax
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException
	mov eax, dword ptr [eax + 4]
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_athrow
bc_athrow:

	PUBLIC bc_athrow_internal
bc_athrow_internal:
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi
	EXTERNDEF shared_call_vm_exception:PROC
	call shared_call_vm_exception

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_checkcast
bc_checkcast:

	PUBLIC bc_checkcast_internal
bc_checkcast_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF checkcast:DWORD
	mov eax, offset checkcast

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_instanceof
bc_instanceof:

	PUBLIC bc_instanceof_internal
bc_instanceof_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF instanceof:DWORD
	mov eax, offset instanceof

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
	pop edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_monitorenter
bc_monitorenter:

	PUBLIC bc_monitorenter_internal
bc_monitorenter_internal:

	; Get the object to lock from the stack
	pop eax

	; Null check
	test eax, eax
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Increment the bytecode pointer before locking to make asynchronous exceptions work
	inc esi
	mov dword ptr [ebp + -16], esi
	EXTERNDEF shared_monitor_enter:PROC
	call shared_monitor_enter

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_monitorexit
bc_monitorexit:

	PUBLIC bc_monitorexit_internal
bc_monitorexit_internal:

	; Get the object to lock from the stack
	pop eax

	; Null check
	test eax, eax
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException
	mov dword ptr [ebp + -16], esi
	EXTERNDEF shared_monitor_exit:PROC
	call shared_monitor_exit

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_wide
bc_wide:

	PUBLIC bc_wide_internal
bc_wide_internal:
	movzx ebx, byte ptr [esi + 1]
	EXTERNDEF interpreter_dispatch_table:DWORD
	mov ebx, dword ptr [ebx * 4 + interpreter_dispatch_table]
	jmp dword ptr [ebx + -4]

	PUBLIC bc_multianewarray
bc_multianewarray:

	PUBLIC bc_multianewarray_internal
bc_multianewarray_internal:

	; Setup the pointer to the vm routine
	EXTERNDEF multianewarray:DWORD
	mov eax, offset multianewarray

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Remove arguments from the stack
	movzx ecx, byte ptr [esi + 3]
	lea esp, dword ptr [esp + ecx * 4 + 0]

	; Push array on the stack
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 4]

	; Advance bytecode pointer
	add esi, 4

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ifnull is a duplicate of ifeq

	; ifnonnull is a duplicate of ifne

	PUBLIC bc_goto_w
bc_goto_w:

	PUBLIC bc_goto_w_internal
bc_goto_w_internal:

	; Check timer tick
	EXTERNDEF _rt_timer_ticks:DWORD
	cmp dword ptr [_rt_timer_ticks], 0
	EXTERNDEF interpreter_timer_tick:PROC
	jne interpreter_timer_tick

	; Load jump offset in edx and update esi to point to destination
	mov edx, dword ptr [esi + 1]

	; Begin - i386 has no bswap instruction
	xchg dh, dl
	ror edx, 16
	xchg dh, dl

	; End - i386 has no bswap instruction
	add esi, edx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 5]

	; Advance bytecode pointer
	add esi, 5

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_breakpoint
bc_breakpoint:

	PUBLIC bc_breakpoint_internal
bc_breakpoint_internal:

	; Unimplemented bytecode
	int 3

	PUBLIC bc_fast_1_ldc
bc_fast_1_ldc:

	PUBLIC bc_fast_1_ldc_internal
bc_fast_1_ldc_internal:

	; Get constant pool index
	movzx eax, byte ptr [esi + 1]

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Push value on the stack
	push dword ptr [ecx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_1_ldc_w
bc_fast_1_ldc_w:

	PUBLIC bc_fast_1_ldc_w_internal
bc_fast_1_ldc_w_internal:

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Push value on the stack
	push dword ptr [ecx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_2_ldc_w
bc_fast_2_ldc_w:

	PUBLIC bc_fast_2_ldc_w_internal
bc_fast_2_ldc_w_internal:

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Push value on the stack
	push dword ptr [ecx + eax * 4 + 4]
	push dword ptr [ecx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_1_putstatic
bc_fast_1_putstatic:

	PUBLIC bc_fast_1_putstatic_internal
bc_fast_1_putstatic_internal:
L1607:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L1612
L1615:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L1612:

	; Get value from the stack
	pop ebx

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	mov dword ptr [edx + eax * 1 + 0], ebx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_2_putstatic
bc_fast_2_putstatic:

	PUBLIC bc_fast_2_putstatic_internal
bc_fast_2_putstatic_internal:
L1631:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L1636
L1639:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L1636:

	; Get value from the stack
	pop ebx
	pop ecx

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	mov dword ptr [edx + eax * 1 + 0], ebx
	mov dword ptr [edx + eax * 1 + 4], ecx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_a_putstatic
bc_fast_a_putstatic:

	PUBLIC bc_fast_a_putstatic_internal
bc_fast_a_putstatic_internal:
L1656:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L1661
L1664:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L1661:

	; Get value from the stack
	pop ebx

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	lea eax, dword ptr [edx + eax * 1 + 0]
	mov dword ptr [eax + 0], ebx

	; Oop write barrier (destination must be in heap)
	EXTERNDEF _bitvector_base:DWORD
	mov ecx, dword ptr [_bitvector_base]
	shr eax, 2
	bts dword ptr [ecx + 0], eax
L1678:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_1_getstatic
bc_fast_1_getstatic:

	PUBLIC bc_fast_1_getstatic_internal
bc_fast_1_getstatic_internal:
L1685:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L1690
L1693:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L1690:

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 1 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_2_getstatic
bc_fast_2_getstatic:

	PUBLIC bc_fast_2_getstatic_internal
bc_fast_2_getstatic_internal:
L1709:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L1714
L1717:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L1714:

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 1 + 4]
	push dword ptr [edx + eax * 1 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_bputfield
bc_fast_bputfield:

	PUBLIC bc_fast_bputfield_internal
bc_fast_bputfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get value from the stack
	pop ebx

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	mov byte ptr [edx + eax * 1 + 0], bl

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_sputfield
bc_fast_sputfield:

	PUBLIC bc_fast_sputfield_internal
bc_fast_sputfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get value from the stack
	pop ebx

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	mov word ptr [edx + eax * 1 + 0], bx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_iputfield
bc_fast_iputfield:

	PUBLIC bc_fast_fputfield
bc_fast_fputfield:

	PUBLIC bc_fast_iputfield_internal
bc_fast_iputfield_internal:

	PUBLIC bc_fast_fputfield_internal
bc_fast_fputfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get value from the stack
	pop ebx

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	mov dword ptr [edx + eax * 4 + 0], ebx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_lputfield
bc_fast_lputfield:

	PUBLIC bc_fast_dputfield
bc_fast_dputfield:

	PUBLIC bc_fast_lputfield_internal
bc_fast_lputfield_internal:

	PUBLIC bc_fast_dputfield_internal
bc_fast_dputfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get value from the stack
	pop ebx
	pop ecx

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	mov dword ptr [edx + eax * 4 + 0], ebx
	mov dword ptr [edx + eax * 4 + 4], ecx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fast_fputfield is a duplicate of fast_iputfield

	; fast_dputfield is a duplicate of fast_lputfield

	PUBLIC bc_fast_aputfield
bc_fast_aputfield:

	PUBLIC bc_fast_aputfield_internal
bc_fast_aputfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get value from the stack
	pop ebx

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	lea eax, dword ptr [edx + eax * 4 + 0]
	mov dword ptr [eax + 0], ebx

	; Oop write barrier (destination must be in heap)
	EXTERNDEF _bitvector_base:DWORD
	mov ecx, dword ptr [_bitvector_base]
	shr eax, 2
	bts dword ptr [ecx + 0], eax
L1763:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_bgetfield
bc_fast_bgetfield:

	PUBLIC bc_fast_bgetfield_internal
bc_fast_bgetfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	movsx eax, byte ptr [edx + eax * 1 + 0]
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_sgetfield
bc_fast_sgetfield:

	PUBLIC bc_fast_sgetfield_internal
bc_fast_sgetfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	movsx eax, word ptr [edx + eax * 1 + 0]
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_igetfield
bc_fast_igetfield:

	PUBLIC bc_fast_fgetfield
bc_fast_fgetfield:

	PUBLIC bc_fast_agetfield
bc_fast_agetfield:

	PUBLIC bc_fast_igetfield_internal
bc_fast_igetfield_internal:

	PUBLIC bc_fast_fgetfield_internal
bc_fast_fgetfield_internal:

	PUBLIC bc_fast_agetfield_internal
bc_fast_agetfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_lgetfield
bc_fast_lgetfield:

	PUBLIC bc_fast_dgetfield
bc_fast_dgetfield:

	PUBLIC bc_fast_lgetfield_internal
bc_fast_lgetfield_internal:

	PUBLIC bc_fast_dgetfield_internal
bc_fast_dgetfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 4 + 4]
	push dword ptr [edx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fast_fgetfield is a duplicate of fast_igetfield

	; fast_dgetfield is a duplicate of fast_lgetfield

	; fast_agetfield is a duplicate of fast_igetfield

	PUBLIC bc_fast_cgetfield
bc_fast_cgetfield:

	PUBLIC bc_fast_cgetfield_internal
bc_fast_cgetfield_internal:

	; Get the field offset
	movzx eax, word ptr [esi + 1]

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	movzx eax, word ptr [edx + eax * 1 + 0]
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_invokevirtual
bc_fast_invokevirtual:

	PUBLIC bc_fast_invokevirtual_internal
bc_fast_invokevirtual_internal:
L1801:

	; Get current method
	mov edx, dword ptr [ebp + -4]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov edx, dword ptr [ebp + -8]

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Get vtable index from constant pool entry
	movzx ebx, word ptr [edx + eax * 4 + 0]

	; Get the class from constant pool entry
	movzx edx, word ptr [edx + eax * 4 + 2]
	EXTERNDEF _class_list_base:DWORD
	mov eax, dword ptr [_class_list_base]
	mov edx, dword ptr [eax + edx * 4 + 0]

	; Get the ClassInfo
	mov edx, dword ptr [edx + 16]

	; Get the method
	mov edx, dword ptr [edx + ebx * 4 + 40]

	; Get the number of parameters from method
	movzx ecx, word ptr [edx + 32]
	and ecx, 511

	; Get receiver object
	mov edx, dword ptr [esp + ecx * 4 + -4]

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get prototype of receiver object
	mov edx, dword ptr [edx + 0]

	; Get method from vtable of the class
	mov edx, dword ptr [edx + 4]
	mov ebx, dword ptr [edx + ebx * 4 + 40]

	; Call method
	mov esi, dword ptr [ebx + 20]
	mov esi, dword ptr [esi + 0]
	add esi, 0
	call esi

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_invokestatic
bc_fast_invokestatic:

	PUBLIC bc_fast_invokestatic_internal
bc_fast_invokestatic_internal:
L1827:

	; Get current method
	mov edx, dword ptr [ebp + -4]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov edx, dword ptr [ebp + -8]

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Get method from resolved constant pool entry
	mov ebx, dword ptr [edx + eax * 4 + 0]

	; Class initialization barrier (static method invocation)

	; load method holder's index
	movzx edx, word ptr [ebx + 26]

	; load task mirror from class list in eax
	EXTERNDEF _mirror_list_base:DWORD
	mov ecx, dword ptr [_mirror_list_base]
	mov eax, dword ptr [ecx + edx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp eax, dword ptr [_task_class_init_marker]
	jne L1833
L1837:

	; load JavaClass object to pass in parameter to the barrier handler

	; edx still holds class_id
	EXTERNDEF _class_list_base:DWORD
	mov ecx, dword ptr [_class_list_base]
	mov edx, dword ptr [ecx + edx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Restore state
	mov edx, dword ptr [ebp + -4]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov edx, dword ptr [ebp + -8]

	; Get method from resolved constant pool entry
	mov ebx, dword ptr [edx + eax * 4 + 0]
L1833:

	; Call method
	mov esi, dword ptr [ebx + 20]
	mov esi, dword ptr [esi + 0]
	add esi, 0
	call esi

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_invokeinterface
bc_fast_invokeinterface:

	PUBLIC bc_fast_invokeinterface_internal
bc_fast_invokeinterface_internal:

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get number of parameters
	movzx ecx, byte ptr [esi + 3]

	; Get receiver object
	mov edx, dword ptr [esp + ecx * 4 + -4]

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Save bytecode pointer to allow usage of esi in implementation of fast_invokeinterface
	mov dword ptr [ebp + -16], esi

	; Get constant pool of current method
	mov esi, dword ptr [ebp + -8]

	; Get constant pool entry for class id and itable index
	movzx ebx, word ptr [esi + eax * 4 + 2]
	movzx esi, word ptr [esi + eax * 4 + 0]

	; Get class of receiver object
	mov edx, dword ptr [edx + 0]
	mov edx, dword ptr [edx + 0]

	; Get the itable from the class of the receiver object
	mov ecx, dword ptr [edx + 16]
	movzx edi, word ptr [ecx + 6]
	movzx eax, word ptr [ecx + 8]
	lea edi, dword ptr [ecx + edi * 4 + 40]

	; Lookup interface method table by linear search
L1872:
	sub eax, 1
	jge L1874

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]
	EXTERNDEF interpreter_throw_IncompatibleClassChangeError:PROC
	jmp interpreter_throw_IncompatibleClassChangeError
L1874:
	cmp ebx, dword ptr [edi + 0]
	je L1873
	add edi, 8
	jmp L1872
L1873:

	; Found the itable entry - now get the method table offset from there
	mov ebx, dword ptr [edi + 4]
	lea ebx, dword ptr [ecx + ebx * 1 + 0]

	; Get the method from the method table
	mov ebx, dword ptr [ebx + esi * 4 + 0]

	; Call method
	mov esi, dword ptr [ebx + 20]
	mov esi, dword ptr [esi + 0]
	call esi

	; FALLTHROUGH

	ALIGN 1
	PUBLIC invoke5_deoptimization_entry
invoke5_deoptimization_entry:

	ALIGN 1
	PUBLIC invoke5_deoptimization_entry_0
invoke5_deoptimization_entry_0:

	ALIGN 1
	PUBLIC invoke5_deoptimization_entry_1
invoke5_deoptimization_entry_1:

	ALIGN 1
	PUBLIC invoke5_deoptimization_entry_2
invoke5_deoptimization_entry_2:

	ALIGN 1
	PUBLIC invoke5_deoptimization_entry_3
invoke5_deoptimization_entry_3:

	ALIGN 1
	PUBLIC invoke5_deoptimization_entry_4
invoke5_deoptimization_entry_4:

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 5]

	; Advance bytecode pointer
	add esi, 5

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_invokenative
bc_fast_invokenative:

	PUBLIC bc_fast_invokenative_internal
bc_fast_invokenative_internal:
L1891:

	; Get address of first paramater
	mov eax, dword ptr [ebp + -4]
	mov ebx, edi

	; Set space for fake parameter for static method (KNI-ism)
	movzx eax, word ptr [eax + 24]
	and eax, 8
	cmp eax, 8
	jne L1890
	add ebx, 4
L1890:

	; Point _kni_parameter_base to the first parameter
	EXTERNDEF _kni_parameter_base:DWORD
	mov dword ptr [_kni_parameter_base], ebx

	; Get the pointer from the bytecode
	movzx ebx, byte ptr [esi + 1]
	mov eax, dword ptr [esi + 4]
	cmp ebx, 12

	; Call the native code
	jne L1901

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
	jmp L1902
L1901:

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]
L1902:
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
	mov ecx, dword ptr [ebx + 76]
	test ecx, ecx
	je L1892

	; Need to redo the native method invocation
	mov ecx, 0
	mov dword ptr [ebx + 76], ecx
	jmp L1891
L1892:
	mov dword ptr [ebx + 52], ecx
	movzx ecx, byte ptr [esi + 1]
	EXTERNDEF _bc_fast_invokenative_returns:DWORD
	jmp dword ptr [ecx * 4 + _bc_fast_invokenative_returns + -24]

	ALIGN 16
	PUBLIC _bc_fast_invokenative_return_int
_bc_fast_invokenative_return_int:
	push eax
	EXTERNDEF bc_ireturn_internal:PROC
	jmp bc_ireturn_internal

	ALIGN 16
	PUBLIC _bc_fast_invokenative_return_long
_bc_fast_invokenative_return_long:
	push edx
	push eax
	EXTERNDEF bc_lreturn_internal:PROC
	jmp bc_lreturn_internal

	ALIGN 16
	PUBLIC _bc_fast_invokenative_return_object
_bc_fast_invokenative_return_object:
	push eax
	EXTERNDEF bc_areturn_internal:PROC
	jmp bc_areturn_internal

	ALIGN 16
	PUBLIC _bc_fast_invokenative_return_void
_bc_fast_invokenative_return_void:
	EXTERNDEF bc_return_internal:PROC
	jmp bc_return_internal

	ALIGN 16
	PUBLIC _bc_fast_invokenative_return_float
_bc_fast_invokenative_return_float:
	sub esp, 4
	fstp dword ptr [esp + 0]
	EXTERNDEF bc_freturn_internal:PROC
	jmp bc_freturn_internal

	ALIGN 16
	PUBLIC _bc_fast_invokenative_return_double
_bc_fast_invokenative_return_double:
	sub esp, 8
	fstp qword ptr [esp + 0]
	EXTERNDEF bc_dreturn_internal:PROC
	jmp bc_dreturn_internal

	ALIGN 16
	PUBLIC _bc_fast_invokenative_return_illegal
_bc_fast_invokenative_return_illegal:
	int 3

	PUBLIC _bc_fast_invokenative_returns
_bc_fast_invokenative_returns 	dd 	_bc_fast_invokenative_return_float
	dd 	_bc_fast_invokenative_return_double
	dd 	_bc_fast_invokenative_return_illegal
	dd 	_bc_fast_invokenative_return_illegal
	dd 	_bc_fast_invokenative_return_int
	dd 	_bc_fast_invokenative_return_long
	dd 	_bc_fast_invokenative_return_object
	dd 	_bc_fast_invokenative_return_illegal
	dd 	_bc_fast_invokenative_return_void

	PUBLIC bc_fast_invokevirtual_final
bc_fast_invokevirtual_final:

	PUBLIC bc_fast_invokevirtual_final_internal
bc_fast_invokevirtual_final_internal:
L1938:

	; Get current method
	mov edx, dword ptr [ebp + -4]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov edx, dword ptr [ebp + -8]

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Get method from resolved constant pool entry
	mov ebx, dword ptr [edx + eax * 4 + 0]

	; Get the number of parameters from the method
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Get receiver object
	mov edx, dword ptr [esp + ecx * 4 + -4]

	; Get prototype of receiver object

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Call method
	mov esi, dword ptr [ebx + 20]
	mov esi, dword ptr [esi + 0]
	add esi, 0
	call esi

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_invokespecial
bc_fast_invokespecial:

	PUBLIC bc_fast_invokespecial_internal
bc_fast_invokespecial_internal:

	; Get current method
	mov edx, dword ptr [ebp + -4]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov edx, dword ptr [ebp + -8]

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Get vtable index from constant pool entry
	movzx ebx, word ptr [edx + eax * 4 + 0]

	; Get the class from constant pool entry
	movzx edx, word ptr [edx + eax * 4 + 2]
	EXTERNDEF _class_list_base:DWORD
	mov eax, dword ptr [_class_list_base]
	mov edx, dword ptr [eax + edx * 4 + 0]

	; Get the ClassInfo
	mov edx, dword ptr [edx + 16]

	; Get method from vtable of the ClassInfo
	mov ebx, dword ptr [edx + ebx * 4 + 40]

	; Get the number of parameters from method
	movzx ecx, word ptr [ebx + 32]
	and ecx, 511

	; Get receiver object and perform the null check
	mov ecx, dword ptr [esp + ecx * 4 + -4]

	; Null check
	test ecx, ecx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Call method
	mov esi, dword ptr [ebx + 20]
	mov esi, dword ptr [esi + 0]
	call esi

	; FALLTHROUGH

	ALIGN 1
	PUBLIC invoke3_deoptimization_entry
invoke3_deoptimization_entry:

	ALIGN 1
	PUBLIC invoke3_deoptimization_entry_0
invoke3_deoptimization_entry_0:

	ALIGN 1
	PUBLIC invoke3_deoptimization_entry_1
invoke3_deoptimization_entry_1:

	ALIGN 1
	PUBLIC invoke3_deoptimization_entry_2
invoke3_deoptimization_entry_2:

	ALIGN 1
	PUBLIC invoke3_deoptimization_entry_3
invoke3_deoptimization_entry_3:

	ALIGN 1
	PUBLIC invoke3_deoptimization_entry_4
invoke3_deoptimization_entry_4:

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_new
bc_fast_new:

	PUBLIC bc_fast_new_internal
bc_fast_new_internal:
L1977:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class from resolved constant pool entry
	mov eax, dword ptr [ecx + eax * 4 + 0]
	EXTERNDEF _class_list_base:DWORD
	mov ebx, dword ptr [_class_list_base]
	mov edx, dword ptr [ebx + eax * 4 + 0]

	; load task mirror from class list in eax
	EXTERNDEF _mirror_list_base:DWORD
	mov ebx, dword ptr [_mirror_list_base]
	mov ebx, dword ptr [ebx + eax * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp ebx, dword ptr [_task_class_init_marker]
	jne L1983
L1986:

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class from resolved constant pool entry
	mov edx, dword ptr [ecx + eax * 4 + 0]
	EXTERNDEF _class_list_base:DWORD
	mov ebx, dword ptr [_class_list_base]
	mov edx, dword ptr [ebx + edx * 4 + 0]
L1983:

	; Get instance size from class
	movsx ebx, word ptr [edx + 6]

	; Get _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov eax, dword ptr [_inline_allocation_top]

	; Compute new top
	lea ecx, dword ptr [eax + ebx * 1 + 0]

	; Compare against _inline_allocation_end
	EXTERNDEF _inline_allocation_end:DWORD
	cmp ecx, dword ptr [_inline_allocation_end]
	EXTERNDEF bc_new:PROC
	ja bc_new

	; Allocation succeeded, set _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov dword ptr [_inline_allocation_top], ecx

	; Get prototypical near from far class
	mov edx, dword ptr [edx + 12]

	; Set prototypical near in object
	mov dword ptr [eax + 0], edx

	; Compute remaining size
	sub ebx, 4

	; One-word object?
	je L2007

	; Zero object fields
	mov edx, eax
	xor ecx, ecx
L2008:
	add edx, 4
	mov dword ptr [edx + 0], ecx
	sub ebx, 4
	jne L2008
L2007:

	; Push result onto stack
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_anewarray
bc_fast_anewarray:

	PUBLIC bc_fast_anewarray_internal
bc_fast_anewarray_internal:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class from resolved constant pool entry
	mov ecx, dword ptr [ecx + eax * 4 + 0]

	; Save class index
	mov edx, ecx
	EXTERNDEF _class_list_base:DWORD
	mov ebx, dword ptr [_class_list_base]
	mov ecx, dword ptr [ebx + ecx * 4 + 0]
	mov ecx, dword ptr [ecx + 28]
	or ecx, ecx
	jne L2018
	mov ecx, edx

	; Get array class from class
	EXTERNDEF _mirror_list_base:DWORD
	mov ebx, dword ptr [_mirror_list_base]
	mov ecx, dword ptr [ebx + ecx * 4 + 0]
	mov ecx, dword ptr [ecx + 20]

	; May have _task_class_init_marker here, check for null array class
	test ecx, ecx
	EXTERNDEF bc_anewarray:PROC
	je bc_anewarray
L2018:

	; Compute size of array
	mov ebx, dword ptr [esp + 0]
	cmp ebx, 1048575
	EXTERNDEF bc_anewarray:PROC
	ja bc_anewarray
	shl ebx, 2
	add ebx, 8

	; Get _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov eax, dword ptr [_inline_allocation_top]

	; Compute new top
	lea edx, dword ptr [eax + ebx * 1 + 0]

	; Check for overflow
	cmp edx, eax
	EXTERNDEF bc_anewarray:PROC
	jb bc_anewarray

	; Compare against _inline_allocation_end
	EXTERNDEF _inline_allocation_end:DWORD
	cmp edx, dword ptr [_inline_allocation_end]
	EXTERNDEF bc_anewarray:PROC
	ja bc_anewarray

	; Allocation succeeded, set _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov dword ptr [_inline_allocation_top], edx

	; Get prototypical near from far class
	mov ecx, dword ptr [ecx + 12]

	; Set prototypical near in array
	mov dword ptr [eax + 0], ecx

	; Set length in array
	pop ebx
	mov dword ptr [eax + 4], ebx

	; Compute remaining size
	cmp ebx, 0

	; Empty array?
	je L2041

	; Zero object fields
	xor ecx, ecx
L2042:
	mov dword ptr [eax + ebx * 4 + 4], ecx
	dec ebx
	jne L2042
L2041:

	; Push result onto stack
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_checkcast
bc_fast_checkcast:

	PUBLIC bc_fast_checkcast_internal
bc_fast_checkcast_internal:

	; Get the object to check cast for - ignore tag
	mov eax, dword ptr [esp + 0]

	; Check for NULL object
	test eax, eax
	je L2047

	; Get the class for the object
	mov edx, dword ptr [eax + 0]
	mov edx, dword ptr [edx + 0]

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class from resolved constant pool entry
	mov ecx, dword ptr [ecx + eax * 4 + 0]
	EXTERNDEF _class_list_base:DWORD
	mov ebx, dword ptr [_class_list_base]
	mov ecx, dword ptr [ebx + ecx * 4 + 0]

	; Check the subtype caches
	cmp ecx, dword ptr [edx + 20]
	je L2047
	cmp ecx, dword ptr [edx + 24]
	je L2047
	EXTERNDEF bc_checkcast:PROC
	jmp bc_checkcast
L2047:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_instanceof
bc_fast_instanceof:

	PUBLIC bc_fast_instanceof_internal
bc_fast_instanceof_internal:

	; Get the object to check cast for - ignore tag
	mov eax, dword ptr [esp + 0]

	; Check for NULL object
	test eax, eax
	je L2062

	; Get the class for the object
	mov edx, dword ptr [eax + 0]
	mov edx, dword ptr [edx + 0]

	; Set the (possible) result to 1
	xor eax, eax
	inc eax

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx ebx, word ptr [esi + 1]
	xchg bh, bl

	; Get class from resolved constant pool entry
	mov ecx, dword ptr [ecx + ebx * 4 + 0]
	EXTERNDEF _class_list_base:DWORD
	mov ebx, dword ptr [_class_list_base]
	mov ecx, dword ptr [ebx + ecx * 4 + 0]

	; Check the subtype caches
	cmp ecx, dword ptr [edx + 20]
	je L2062
	cmp ecx, dword ptr [edx + 24]
	je L2062
	EXTERNDEF bc_instanceof:PROC
	jmp bc_instanceof
L2062:
	pop edx
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_igetfield_1
bc_fast_igetfield_1:

	PUBLIC bc_fast_agetfield_1
bc_fast_agetfield_1:

	PUBLIC bc_fast_igetfield_1_internal
bc_fast_igetfield_1_internal:

	PUBLIC bc_fast_agetfield_1_internal
bc_fast_agetfield_1_internal:

	; Get the field offset
	movzx eax, byte ptr [esi + 1]

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; fast_agetfield_1 is a duplicate of fast_igetfield_1

	; aload_0_fast_agetfield_1 is a duplicate of aload_0_fast_igetfield_1

	PUBLIC bc_aload_0_fast_igetfield_1
bc_aload_0_fast_igetfield_1:

	PUBLIC bc_aload_0_fast_agetfield_1
bc_aload_0_fast_agetfield_1:

	PUBLIC bc_aload_0_fast_igetfield_1_internal
bc_aload_0_fast_igetfield_1_internal:

	PUBLIC bc_aload_0_fast_agetfield_1_internal
bc_aload_0_fast_agetfield_1_internal:
	push dword ptr [edi + 0]

	; Get the field offset
	movzx eax, byte ptr [esi + 1]

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 2]

	; Advance bytecode pointer
	add esi, 2

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_pop_and_npe_if_null
bc_pop_and_npe_if_null:

	PUBLIC bc_pop_and_npe_if_null_internal
bc_pop_and_npe_if_null_internal:
	pop eax

	; Null check
	test eax, eax
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_init_static_array
bc_init_static_array:

	PUBLIC bc_init_static_array_internal
bc_init_static_array_internal:
	mov eax, dword ptr [esp + 0]
	movzx ecx, byte ptr [esi + 1]
	movzx ebx, word ptr [esi + 2]
	sub ebx, 1

	; Null check
	test eax, eax
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Check array index out of bounds
	cmp ebx, dword ptr [eax + 4]
	jb L2099
	EXTERNDEF interpreter_throw_ArrayIndexOutOfBoundsException:PROC
	jae interpreter_throw_ArrayIndexOutOfBoundsException
L2099:
	add ebx, 1
	shld ebx, ecx, cl
	add esi, 4
	add eax, 8
	mov edx, 0
L2105:
	mov ecx, dword ptr [esi + edx * 1 + 0]
	mov dword ptr [eax + edx * 1 + 0], ecx
	add edx, 4
	cmp edx, ebx
	jl L2105
L2106:
	add esi, ebx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; aload_0_fast_agetfield_4 is a duplicate of aload_0_fast_igetfield_4

	PUBLIC bc_aload_0_fast_igetfield_4
bc_aload_0_fast_igetfield_4:

	PUBLIC bc_aload_0_fast_agetfield_4
bc_aload_0_fast_agetfield_4:

	PUBLIC bc_aload_0_fast_igetfield_4_internal
bc_aload_0_fast_igetfield_4_internal:

	PUBLIC bc_aload_0_fast_agetfield_4_internal
bc_aload_0_fast_agetfield_4_internal:
	push dword ptr [edi + 0]

	; Implicit offset = 4
	mov eax, 1

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; aload_0_fast_agetfield_8 is a duplicate of aload_0_fast_igetfield_8

	PUBLIC bc_aload_0_fast_igetfield_8
bc_aload_0_fast_igetfield_8:

	PUBLIC bc_aload_0_fast_agetfield_8
bc_aload_0_fast_agetfield_8:

	PUBLIC bc_aload_0_fast_igetfield_8_internal
bc_aload_0_fast_igetfield_8_internal:

	PUBLIC bc_aload_0_fast_agetfield_8_internal
bc_aload_0_fast_agetfield_8_internal:
	push dword ptr [edi + 0]

	; Implicit offset = 8
	mov eax, 2

	; Get object from stack
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 4 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 1]

	; Advance bytecode pointer
	inc esi

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_init_1_putstatic
bc_fast_init_1_putstatic:

	PUBLIC bc_fast_init_1_putstatic_internal
bc_fast_init_1_putstatic_internal:
L2124:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L2129
L2132:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L2129:

	; Get value from the stack
	pop ebx

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	mov dword ptr [edx + eax * 1 + 0], ebx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_init_2_putstatic
bc_fast_init_2_putstatic:

	PUBLIC bc_fast_init_2_putstatic_internal
bc_fast_init_2_putstatic_internal:
L2148:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L2153
L2156:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L2153:

	; Get value from the stack
	pop ebx
	pop ecx

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	mov dword ptr [edx + eax * 1 + 0], ebx
	mov dword ptr [edx + eax * 1 + 4], ecx

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_init_a_putstatic
bc_fast_init_a_putstatic:

	PUBLIC bc_fast_init_a_putstatic_internal
bc_fast_init_a_putstatic_internal:
L2173:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L2178
L2181:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L2178:

	; Get value from the stack
	pop ebx

	; Put value into field

	; Value is in ebx:ecx, object stored into is in edx, field offset is in eax
	lea eax, dword ptr [edx + eax * 1 + 0]
	mov dword ptr [eax + 0], ebx

	; Oop write barrier (destination must be in heap)
	EXTERNDEF _bitvector_base:DWORD
	mov ecx, dword ptr [_bitvector_base]
	shr eax, 2
	bts dword ptr [ecx + 0], eax
L2195:

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_init_1_getstatic
bc_fast_init_1_getstatic:

	PUBLIC bc_fast_init_1_getstatic_internal
bc_fast_init_1_getstatic_internal:
L2202:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L2207
L2210:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L2207:

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 1 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_init_2_getstatic
bc_fast_init_2_getstatic:

	PUBLIC bc_fast_init_2_getstatic_internal
bc_fast_init_2_getstatic_internal:
L2226:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class_id from constant pool
	movzx ebx, word ptr [ecx + eax * 4 + 0]

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Get TaskMirror from class_id
	EXTERNDEF _mirror_list_base:DWORD
	mov edx, dword ptr [_mirror_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp edx, dword ptr [_task_class_init_marker]
	jne L2231
L2234:
	EXTERNDEF _class_list_base:DWORD
	mov edx, dword ptr [_class_list_base]
	mov edx, dword ptr [edx + ebx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Task mirror should be available now
	mov edx, eax

	; restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get the field offset from constant pool entry
	movzx eax, word ptr [ecx + eax * 4 + 2]

	; Need more freakin' registers!
L2231:

	; Get the value from the field

	; Object read from is in edx, field offset is in eax
	push dword ptr [edx + eax * 1 + 4]
	push dword ptr [edx + eax * 1 + 0]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_init_invokestatic
bc_fast_init_invokestatic:

	PUBLIC bc_fast_init_invokestatic_internal
bc_fast_init_invokestatic_internal:
L2251:

	; Get current method
	mov edx, dword ptr [ebp + -4]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov edx, dword ptr [ebp + -8]

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Get method from resolved constant pool entry
	mov ebx, dword ptr [edx + eax * 4 + 0]

	; Class initialization barrier (static method invocation)

	; load method holder's index
	movzx edx, word ptr [ebx + 26]

	; load task mirror from class list in eax
	EXTERNDEF _mirror_list_base:DWORD
	mov ecx, dword ptr [_mirror_list_base]
	mov eax, dword ptr [ecx + edx * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp eax, dword ptr [_task_class_init_marker]
	jne L2257
L2261:

	; load JavaClass object to pass in parameter to the barrier handler

	; edx still holds class_id
	EXTERNDEF _class_list_base:DWORD
	mov ecx, dword ptr [_class_list_base]
	mov edx, dword ptr [ecx + edx * 4 + 0]

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Restore state
	mov edx, dword ptr [ebp + -4]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get constant pool of current method
	mov edx, dword ptr [ebp + -8]

	; Get method from resolved constant pool entry
	mov ebx, dword ptr [edx + eax * 4 + 0]
L2257:

	; Call method
	mov esi, dword ptr [ebx + 20]
	mov esi, dword ptr [esi + 0]
	add esi, 0
	call esi

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	PUBLIC bc_fast_init_new
bc_fast_init_new:

	PUBLIC bc_fast_init_new_internal
bc_fast_init_new_internal:
L2282:

	; Get constant pool of current method
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class from resolved constant pool entry
	mov eax, dword ptr [ecx + eax * 4 + 0]
	EXTERNDEF _class_list_base:DWORD
	mov ebx, dword ptr [_class_list_base]
	mov edx, dword ptr [ebx + eax * 4 + 0]

	; load task mirror from class list in eax
	EXTERNDEF _mirror_list_base:DWORD
	mov ebx, dword ptr [_mirror_list_base]
	mov ebx, dword ptr [ebx + eax * 4 + 0]

	; class initialization barrier
	EXTERNDEF _task_class_init_marker:DWORD
	cmp ebx, dword ptr [_task_class_init_marker]
	jne L2288
L2291:

	; Setup the pointer to the vm routine
	EXTERNDEF task_barrier:DWORD
	mov eax, offset task_barrier

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm_oop:PROC
	call shared_call_vm_oop

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Restore state
	mov ecx, dword ptr [ebp + -8]

	; Get constant pool index
	movzx eax, word ptr [esi + 1]
	xchg ah, al

	; Get class from resolved constant pool entry
	mov edx, dword ptr [ecx + eax * 4 + 0]
	EXTERNDEF _class_list_base:DWORD
	mov ebx, dword ptr [_class_list_base]
	mov edx, dword ptr [ebx + edx * 4 + 0]
L2288:

	; Get instance size from class
	movsx ebx, word ptr [edx + 6]

	; Get _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov eax, dword ptr [_inline_allocation_top]

	; Compute new top
	lea ecx, dword ptr [eax + ebx * 1 + 0]

	; Compare against _inline_allocation_end
	EXTERNDEF _inline_allocation_end:DWORD
	cmp ecx, dword ptr [_inline_allocation_end]
	EXTERNDEF bc_new:PROC
	ja bc_new

	; Allocation succeeded, set _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov dword ptr [_inline_allocation_top], ecx

	; Get prototypical near from far class
	mov edx, dword ptr [edx + 12]

	; Set prototypical near in object
	mov dword ptr [eax + 0], edx

	; Compute remaining size
	sub ebx, 4

	; One-word object?
	je L2312

	; Zero object fields
	mov edx, eax
	xor ecx, ecx
L2313:
	add edx, 4
	mov dword ptr [edx + 0], ecx
	sub ebx, 4
	jne L2313
L2312:

	; Push result onto stack
	push eax

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 3]

	; Advance bytecode pointer
	add esi, 3

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Interpreter dispatch table
	; ----------------------------------------------------------

	PUBLIC interpreter_dispatch_table
interpreter_dispatch_table 	dd 	bc_nop
	dd 	bc_aconst_null
	dd 	bc_iconst_m1
	dd 	bc_iconst_0
	dd 	bc_iconst_1
	dd 	bc_iconst_2
	dd 	bc_iconst_3
	dd 	bc_iconst_4
	dd 	bc_iconst_5
	dd 	bc_lconst_0
	dd 	bc_lconst_1
	dd 	bc_fconst_0
	dd 	bc_fconst_1
	dd 	bc_fconst_2
	dd 	bc_dconst_0
	dd 	bc_dconst_1
	dd 	bc_bipush
	dd 	bc_sipush
	dd 	bc_ldc
	dd 	bc_ldc_w
	dd 	bc_ldc2_w
	dd 	bc_iload
	dd 	bc_lload
	dd 	bc_fload
	dd 	bc_dload
	dd 	bc_aload
	dd 	bc_iload_0
	dd 	bc_iload_1
	dd 	bc_iload_2
	dd 	bc_iload_3
	dd 	bc_lload_0
	dd 	bc_lload_1
	dd 	bc_lload_2
	dd 	bc_lload_3
	dd 	bc_fload_0
	dd 	bc_fload_1
	dd 	bc_fload_2
	dd 	bc_fload_3
	dd 	bc_dload_0
	dd 	bc_dload_1
	dd 	bc_dload_2
	dd 	bc_dload_3
	dd 	bc_aload_0
	dd 	bc_aload_1
	dd 	bc_aload_2
	dd 	bc_aload_3
	dd 	bc_iaload
	dd 	bc_laload
	dd 	bc_faload
	dd 	bc_daload
	dd 	bc_aaload
	dd 	bc_baload
	dd 	bc_caload
	dd 	bc_saload
	dd 	bc_istore
	dd 	bc_lstore
	dd 	bc_fstore
	dd 	bc_dstore
	dd 	bc_astore
	dd 	bc_istore_0
	dd 	bc_istore_1
	dd 	bc_istore_2
	dd 	bc_istore_3
	dd 	bc_lstore_0
	dd 	bc_lstore_1
	dd 	bc_lstore_2
	dd 	bc_lstore_3
	dd 	bc_fstore_0
	dd 	bc_fstore_1
	dd 	bc_fstore_2
	dd 	bc_fstore_3
	dd 	bc_dstore_0
	dd 	bc_dstore_1
	dd 	bc_dstore_2
	dd 	bc_dstore_3
	dd 	bc_astore_0
	dd 	bc_astore_1
	dd 	bc_astore_2
	dd 	bc_astore_3
	dd 	bc_iastore
	dd 	bc_lastore
	dd 	bc_fastore
	dd 	bc_dastore
	dd 	bc_aastore
	dd 	bc_bastore
	dd 	bc_castore
	dd 	bc_sastore
	dd 	bc_pop
	dd 	bc_pop2
	dd 	bc_dup
	dd 	bc_dup_x1
	dd 	bc_dup_x2
	dd 	bc_dup2
	dd 	bc_dup2_x1
	dd 	bc_dup2_x2
	dd 	bc_swap
	dd 	bc_iadd
	dd 	bc_ladd
	dd 	bc_fadd
	dd 	bc_dadd
	dd 	bc_isub
	dd 	bc_lsub
	dd 	bc_fsub
	dd 	bc_dsub
	dd 	bc_imul
	dd 	bc_lmul
	dd 	bc_fmul
	dd 	bc_dmul
	dd 	bc_idiv
	dd 	bc_ldiv
	dd 	bc_fdiv
	dd 	bc_ddiv
	dd 	bc_irem
	dd 	bc_lrem
	dd 	bc_frem
	dd 	bc_drem
	dd 	bc_ineg
	dd 	bc_lneg
	dd 	bc_fneg
	dd 	bc_dneg
	dd 	bc_ishl
	dd 	bc_lshl
	dd 	bc_ishr
	dd 	bc_lshr
	dd 	bc_iushr
	dd 	bc_lushr
	dd 	bc_iand
	dd 	bc_land
	dd 	bc_ior
	dd 	bc_lor
	dd 	bc_ixor
	dd 	bc_lxor
	dd 	bc_iinc
	dd 	bc_i2l
	dd 	bc_i2f
	dd 	bc_i2d
	dd 	bc_l2i
	dd 	bc_l2f
	dd 	bc_l2d
	dd 	bc_f2i
	dd 	bc_f2l
	dd 	bc_f2d
	dd 	bc_d2i
	dd 	bc_d2l
	dd 	bc_d2f
	dd 	bc_i2b
	dd 	bc_i2c
	dd 	bc_i2s
	dd 	bc_lcmp
	dd 	bc_fcmpl
	dd 	bc_fcmpg
	dd 	bc_dcmpl
	dd 	bc_dcmpg
	dd 	bc_ifeq
	dd 	bc_ifne
	dd 	bc_iflt
	dd 	bc_ifge
	dd 	bc_ifgt
	dd 	bc_ifle
	dd 	bc_if_icmpeq
	dd 	bc_if_icmpne
	dd 	bc_if_icmplt
	dd 	bc_if_icmpge
	dd 	bc_if_icmpgt
	dd 	bc_if_icmple
	dd 	bc_if_acmpeq
	dd 	bc_if_acmpne
	dd 	bc_goto
	dd 	0
	dd 	0
	dd 	bc_tableswitch
	dd 	bc_lookupswitch
	dd 	bc_ireturn
	dd 	bc_lreturn
	dd 	bc_freturn
	dd 	bc_dreturn
	dd 	bc_areturn
	dd 	bc_return
	dd 	bc_getstatic
	dd 	bc_putstatic
	dd 	bc_getfield
	dd 	bc_putfield
	dd 	bc_invokevirtual
	dd 	bc_invokespecial
	dd 	bc_invokestatic
	dd 	bc_invokeinterface
	dd 	0
	dd 	bc_new
	dd 	bc_newarray
	dd 	bc_anewarray
	dd 	bc_arraylength
	dd 	bc_athrow
	dd 	bc_checkcast
	dd 	bc_instanceof
	dd 	bc_monitorenter
	dd 	bc_monitorexit
	dd 	bc_wide
	dd 	bc_multianewarray
	dd 	bc_ifnull
	dd 	bc_ifnonnull
	dd 	bc_goto_w
	dd 	0
	dd 	bc_breakpoint
	dd 	bc_fast_1_ldc
	dd 	bc_fast_1_ldc_w
	dd 	bc_fast_2_ldc_w
	dd 	bc_fast_1_putstatic
	dd 	bc_fast_2_putstatic
	dd 	bc_fast_a_putstatic
	dd 	bc_fast_1_getstatic
	dd 	bc_fast_2_getstatic
	dd 	bc_fast_bputfield
	dd 	bc_fast_sputfield
	dd 	bc_fast_iputfield
	dd 	bc_fast_lputfield
	dd 	bc_fast_fputfield
	dd 	bc_fast_dputfield
	dd 	bc_fast_aputfield
	dd 	bc_fast_bgetfield
	dd 	bc_fast_sgetfield
	dd 	bc_fast_igetfield
	dd 	bc_fast_lgetfield
	dd 	bc_fast_fgetfield
	dd 	bc_fast_dgetfield
	dd 	bc_fast_agetfield
	dd 	bc_fast_cgetfield
	dd 	bc_fast_invokevirtual
	dd 	bc_fast_invokestatic
	dd 	bc_fast_invokeinterface
	dd 	bc_fast_invokenative
	dd 	bc_fast_invokevirtual_final
	dd 	bc_fast_invokespecial
	dd 	bc_fast_new
	dd 	bc_fast_anewarray
	dd 	bc_fast_checkcast
	dd 	bc_fast_instanceof
	dd 	bc_fast_igetfield_1
	dd 	bc_fast_agetfield_1
	dd 	bc_aload_0_fast_agetfield_1
	dd 	bc_aload_0_fast_igetfield_1
	dd 	bc_pop_and_npe_if_null
	dd 	bc_init_static_array
	dd 	bc_aload_0_fast_agetfield_4
	dd 	bc_aload_0_fast_igetfield_4
	dd 	bc_aload_0_fast_agetfield_8
	dd 	bc_aload_0_fast_igetfield_8
	dd 	bc_fast_init_1_putstatic
	dd 	bc_fast_init_2_putstatic
	dd 	bc_fast_init_a_putstatic
	dd 	bc_fast_init_1_getstatic
	dd 	bc_fast_init_2_getstatic
	dd 	bc_fast_init_invokestatic
	dd 	bc_fast_init_new
	dd 	0
	dd 	0
	dd 	0

CodeSegment ends
DataSegment segment  para  public   'DATA'

	; ----------------------------------------------------------
	; Interpreter bytecode counters table
	; ----------------------------------------------------------

	PUBLIC _bytecode_counter
_bytecode_counter 	dd 	20000

	PUBLIC interpreter_bytecode_counters
interpreter_bytecode_counters 	dd 	0

	; The bytecode counters table is intentionally left empty.

	; To use bytecode counters, turn on +PrintBytecodeHistogram

	; during interpreter loop generation.

	; ----------------------------------------------------------
	; Interpreter pair counters table
	; ----------------------------------------------------------

	PUBLIC interpreter_pair_counters
interpreter_pair_counters 	dd 	0

	; The pair counters table is intentionally left empty.

	; To use pair counters, turn on +PrintPairHistogram

	; during interpreter loop generation.

	PUBLIC local_saved_cw
local_saved_cw 	dd 	0

	PUBLIC local_masked_cw
local_masked_cw 	dd 	0

	PUBLIC native_saved_cw
native_saved_cw 	dw 	0

	PUBLIC native_masked_cw
native_masked_cw 	dw 	0

DataSegment ends
CodeSegment segment  para  public   'CODE'

	; ----------------------------------------------------------
	; Shared invoke compiler
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC shared_invoke_compiler
shared_invoke_compiler:
	EXTERNDEF _rt_timer_ticks:DWORD
	inc dword ptr [_rt_timer_ticks]
	jmp  interpreter_method_entry

	; ----------------------------------------------------------
	; Shared fast accessors
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC shared_fast_getbyte_accessor
shared_fast_getbyte_accessor:

	; Get this
	mov edx, dword ptr [esp + 4]

	; Get the byte field from the 'this' object
	movzx eax, word ptr [ebx + 30]
	movsx eax, byte ptr [edx + eax * 1 + 0]
	mov dword ptr [esp + 4], eax
	ret

	ALIGN 16
	PUBLIC shared_fast_getshort_accessor
shared_fast_getshort_accessor:

	; Get this
	mov edx, dword ptr [esp + 4]

	; Get the short field from the 'this' object
	movzx eax, word ptr [ebx + 30]
	movsx eax, word ptr [edx + eax * 1 + 0]
	mov dword ptr [esp + 4], eax
	ret

	ALIGN 16
	PUBLIC shared_fast_getchar_accessor
shared_fast_getchar_accessor:

	; Get this
	mov edx, dword ptr [esp + 4]

	; Get the char field from the 'this' object
	movzx eax, word ptr [ebx + 30]
	movzx eax, word ptr [edx + eax * 1 + 0]
	mov dword ptr [esp + 4], eax
	ret

	ALIGN 16
	PUBLIC shared_fast_getfloat_accessor
shared_fast_getfloat_accessor:
	EXTERNDEF shared_fast_getint_accessor:PROC
	jmp shared_fast_getint_accessor

	ALIGN 16
	PUBLIC shared_fast_getint_accessor
shared_fast_getint_accessor:

	; Get this
	mov edx, dword ptr [esp + 4]

	; Get the int field from the 'this' object
	movzx eax, word ptr [ebx + 30]
	mov eax, dword ptr [edx + eax * 1 + 0]
	mov dword ptr [esp + 4], eax
	ret

	ALIGN 16
	PUBLIC shared_fast_getdouble_accessor
shared_fast_getdouble_accessor:
	EXTERNDEF shared_fast_getlong_accessor:PROC
	jmp shared_fast_getlong_accessor

	ALIGN 16
	PUBLIC shared_fast_getlong_accessor
shared_fast_getlong_accessor:
	pop esi
	pop edx

	; Push the long field from the 'this' object onto the stack
	movzx eax, word ptr [ebx + 30]
	push dword ptr [edx + eax * 1 + 4]
	push dword ptr [edx + eax * 1 + 0]
	jmp esi

	ALIGN 16
	PUBLIC shared_fast_getbyte_static_accessor
shared_fast_getbyte_static_accessor:

	; Get this
	mov edx, dword ptr [esp + 4]

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the byte field from the 'this' object
	movzx eax, word ptr [ebx + 30]
	movsx eax, byte ptr [edx + eax * 1 + 0]
	mov dword ptr [esp + 4], eax
	ret

	ALIGN 16
	PUBLIC shared_fast_getshort_static_accessor
shared_fast_getshort_static_accessor:

	; Get this
	mov edx, dword ptr [esp + 4]

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the short field from the 'this' object
	movzx eax, word ptr [ebx + 30]
	movsx eax, word ptr [edx + eax * 1 + 0]
	mov dword ptr [esp + 4], eax
	ret

	ALIGN 16
	PUBLIC shared_fast_getchar_static_accessor
shared_fast_getchar_static_accessor:

	; Get this
	mov edx, dword ptr [esp + 4]

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the char field from the 'this' object
	movzx eax, word ptr [ebx + 30]
	movzx eax, word ptr [edx + eax * 1 + 0]
	mov dword ptr [esp + 4], eax
	ret

	ALIGN 16
	PUBLIC shared_fast_getfloat_static_accessor
shared_fast_getfloat_static_accessor:
	EXTERNDEF shared_fast_getint_static_accessor:PROC
	jmp shared_fast_getint_static_accessor

	ALIGN 16
	PUBLIC shared_fast_getint_static_accessor
shared_fast_getint_static_accessor:

	; Get this
	mov edx, dword ptr [esp + 4]

	; Null check
	test edx, edx
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	je interpreter_throw_NullPointerException

	; Get the int field from the 'this' object
	movzx eax, word ptr [ebx + 30]
	mov eax, dword ptr [edx + eax * 1 + 0]
	mov dword ptr [esp + 4], eax
	ret

	ALIGN 16
	PUBLIC shared_fast_getdouble_static_accessor
shared_fast_getdouble_static_accessor:
	EXTERNDEF shared_fast_getlong_static_accessor:PROC
	jmp shared_fast_getlong_static_accessor

	ALIGN 16
	PUBLIC shared_fast_getlong_static_accessor
shared_fast_getlong_static_accessor:
	pop esi
	pop edx

	; Null check
	test edx, edx
	EXTERNDEF null_receiver:PROC
	je null_receiver

	; Push the long field from the 'this' object onto the stack
	movzx eax, word ptr [ebx + 30]
	push dword ptr [edx + eax * 1 + 4]
	push dword ptr [edx + eax * 1 + 0]
	jmp esi

	ALIGN 16
	PUBLIC null_receiver
null_receiver:

	; Restore stack state and continue with exception throwing
	push edx
	push esi
	EXTERNDEF interpreter_throw_NullPointerException:PROC
	jmp interpreter_throw_NullPointerException

	; ----------------------------------------------------------
	; Call on C stack
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC call_on_primordial_stack
call_on_primordial_stack:

	; Get address of function
	mov eax, dword ptr [esp + 4]
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]
	push ebp
	mov dword ptr [ecx + 100], esp
	EXTERNDEF _primordial_sp:DWORD
	mov esp, dword ptr [_primordial_sp]
	mov ebp, dword ptr [esp + 0]
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx
	call eax
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]
	mov esp, dword ptr [ecx + 100]
	pop ebp
	ret

	; ----------------------------------------------------------
	; Shared call VM for 
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC shared_call_vm
shared_call_vm:

	; Calculate the last java stack pointer
	lea esi, dword ptr [esp + 4]

	; Get the current thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]

	; LWT Switch stack to primordial thread
	EXTERNDEF shared_call_vm_return:PROC
	push offset shared_call_vm_return
	push ebp

	; Save last java stack pointer and last java frame pointer in thread
	mov dword ptr [ecx + 100], esp
	mov dword ptr [ecx + 72], ebp
	mov dword ptr [ecx + 68], esi
	EXTERNDEF _primordial_sp:DWORD
	mov esp, dword ptr [_primordial_sp]
	mov ebp, dword ptr [esp + 0]

	; Push optional argument
	push edx

	; Push the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx

	; Call the native entry
	call eax

	; Remove the thread and the optional argument from the stack
	add esp, 8

	; save the return values in the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]
	mov dword ptr [ecx + 112], eax
	mov dword ptr [ecx + 116], edx

	; Check for pending activations and exceptions

	; check for pending entries and if so, check for enough stack space
	cmp dword ptr [ecx + 36], 0
	je L2656
	mov esi, dword ptr [ecx + 36]

	; get parameter size
	mov eax, dword ptr [esi + 4]

	; go to next activation if present
	jmp L2655
L2654:

	; check parameter size
	cmp eax, dword ptr [esi + 4]
	ja L2655

	; store the maximum size into eax
	mov eax, dword ptr [esi + 4]

	; get the next activation
L2655:
	mov esi, dword ptr [esi + 12]
	test esi, esi
	jne L2654

	; convert number of params to bytes plus a fudge factor
	shl eax, 2

	; don't bother checking, add in stack lock size
	add eax, 24
	mov esi, dword ptr [ecx + 68]

	; see if there's enough stack
	sub esi, eax
	EXTERNDEF _current_stack_limit:DWORD
	cmp esi, dword ptr [_current_stack_limit]
	jae L2656

	; would run out of stack, so we must expand it before calling the entry

	; Push optional argument
	push esi

	; Push the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx

	; Call the native entry
	EXTERNDEF stack_overflow:DWORD
	mov eax, offset stack_overflow
	call eax

	; Remove the thread and the optional argument from the stack
	add esp, 8
L2656:

	; Call switch_thread(JVM_TRAPS)
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx
	EXTERNDEF switch_thread:PROC
	call switch_thread
	add esp, 4

	; Switch back to the java stack
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
	mov esp, dword ptr [ebx + 100]
	pop ebp
	ret

	ALIGN 16
	PUBLIC shared_call_vm_return
shared_call_vm_return:
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]

	; restore the return values in the thread
	mov eax, dword ptr [ebx + 112]
	mov edx, dword ptr [ebx + 116]

	; Check for pending activations
	cmp dword ptr [ebx + 36], 0
	je L2679

	; Invoke the pending activations
	xor ecx, ecx
	EXTERNDEF shared_entry:PROC
	call shared_entry

	; Restore the thread
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
L2679:

	; Reset last java stack pointer and last java frame pointer in thread
	xor ecx, ecx
	mov dword ptr [ebx + 68], ecx
	mov dword ptr [ebx + 72], ecx

	; Check for pending exceptions
	EXTERNDEF _current_pending_exception:DWORD
	cmp dword ptr [_current_pending_exception], 0
	EXTERNDEF shared_call_vm_forward_exception:PROC
	jne shared_call_vm_forward_exception

	; Return to the caller
	ret

	; ----------------------------------------------------------
	; Shared call VM for 
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC shared_call_vm_oop
shared_call_vm_oop:

	; Calculate the last java stack pointer
	lea esi, dword ptr [esp + 4]

	; Get the current thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]

	; LWT Switch stack to primordial thread
	EXTERNDEF shared_call_vm_oop_return:PROC
	push offset shared_call_vm_oop_return
	push ebp

	; Save last java stack pointer and last java frame pointer in thread
	mov dword ptr [ecx + 100], esp
	mov dword ptr [ecx + 72], ebp
	mov dword ptr [ecx + 68], esi
	EXTERNDEF _primordial_sp:DWORD
	mov esp, dword ptr [_primordial_sp]
	mov ebp, dword ptr [esp + 0]

	; Push optional argument
	push edx

	; Push the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx

	; Call the native entry
	call eax

	; Remove the thread and the optional argument from the stack
	add esp, 8

	; save the return values in the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]
	lea edx, dword ptr [ecx + 48]
	mov dword ptr [edx + 0], eax

	; Oop write barrier (destination must be in heap)
	EXTERNDEF _bitvector_base:DWORD
	mov eax, dword ptr [_bitvector_base]
	shr edx, 2
	bts dword ptr [eax + 0], edx
L2702:

	; Check for pending activations and exceptions

	; check for pending entries and if so, check for enough stack space
	cmp dword ptr [ecx + 36], 0
	je L2708
	mov esi, dword ptr [ecx + 36]

	; get parameter size
	mov eax, dword ptr [esi + 4]

	; go to next activation if present
	jmp L2707
L2706:

	; check parameter size
	cmp eax, dword ptr [esi + 4]
	ja L2707

	; store the maximum size into eax
	mov eax, dword ptr [esi + 4]

	; get the next activation
L2707:
	mov esi, dword ptr [esi + 12]
	test esi, esi
	jne L2706

	; convert number of params to bytes plus a fudge factor
	shl eax, 2

	; don't bother checking, add in stack lock size
	add eax, 24
	mov esi, dword ptr [ecx + 68]

	; see if there's enough stack
	sub esi, eax
	EXTERNDEF _current_stack_limit:DWORD
	cmp esi, dword ptr [_current_stack_limit]
	jae L2708

	; would run out of stack, so we must expand it before calling the entry

	; Push optional argument
	push esi

	; Push the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx

	; Call the native entry
	EXTERNDEF stack_overflow:DWORD
	mov eax, offset stack_overflow
	call eax

	; Remove the thread and the optional argument from the stack
	add esp, 8
L2708:

	; Call switch_thread(JVM_TRAPS)
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx
	EXTERNDEF switch_thread:PROC
	call switch_thread
	add esp, 4

	; Switch back to the java stack
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
	mov esp, dword ptr [ebx + 100]
	pop ebp
	ret

	ALIGN 16
	PUBLIC shared_call_vm_oop_return
shared_call_vm_oop_return:
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]

	; restore the return values in the thread
	mov ecx, dword ptr [ebx + 48]
	mov dword ptr [ebx + 48], 0

	; Check for pending activations
	cmp dword ptr [ebx + 36], 0
	je L2732

	; Invoke the pending activations
	EXTERNDEF shared_entry:PROC
	call shared_entry

	; Restore the thread
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
L2732:
	mov eax, ecx

	; Reset last java stack pointer and last java frame pointer in thread
	xor ecx, ecx
	mov dword ptr [ebx + 68], ecx
	mov dword ptr [ebx + 72], ecx

	; Check for pending exceptions
	EXTERNDEF _current_pending_exception:DWORD
	cmp dword ptr [_current_pending_exception], 0
	EXTERNDEF shared_call_vm_forward_exception:PROC
	jne shared_call_vm_forward_exception

	; Return to the caller
	ret

	; ----------------------------------------------------------
	; Shared call VM for 
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC shared_call_vm_exception
shared_call_vm_exception:

	; Calculate the last java stack pointer
	lea esi, dword ptr [esp + 4]

	; Leave space to expand stack, if necessary
	push 0

	; Get the current thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]

	; LWT Switch stack to primordial thread
	EXTERNDEF shared_call_vm_exception_return:PROC
	push offset shared_call_vm_exception_return
	push ebp

	; Save last java stack pointer and last java frame pointer in thread
	mov dword ptr [ecx + 100], esp
	mov dword ptr [ecx + 72], ebp
	mov dword ptr [ecx + 68], esi
	EXTERNDEF _primordial_sp:DWORD
	mov esp, dword ptr [_primordial_sp]
	mov ebp, dword ptr [esp + 0]

	; Push optional argument
	push edx

	; Push the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx

	; Call the native entry
	EXTERNDEF find_exception_frame:PROC
	call find_exception_frame

	; Remove the thread and the optional argument from the stack
	add esp, 8

	; save the return values in the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]
	mov dword ptr [ecx + 112], eax

	; Check for pending activations and exceptions

	; check for pending entries and if so, check for enough stack space
	cmp dword ptr [ecx + 36], 0
	je L2758
	mov esi, dword ptr [ecx + 36]

	; get parameter size
	mov eax, dword ptr [esi + 4]

	; go to next activation if present
	jmp L2757
L2756:

	; check parameter size
	cmp eax, dword ptr [esi + 4]
	ja L2757

	; store the maximum size into eax
	mov eax, dword ptr [esi + 4]

	; get the next activation
L2757:
	mov esi, dword ptr [esi + 12]
	test esi, esi
	jne L2756

	; convert number of params to bytes plus a fudge factor
	shl eax, 2

	; don't bother checking, add in stack lock size
	add eax, 24
	mov esi, dword ptr [ecx + 68]

	; see if there's enough stack
	sub esi, eax
	EXTERNDEF _current_stack_limit:DWORD
	cmp esi, dword ptr [_current_stack_limit]
	jae L2758

	; would run out of stack, so we must expand it before calling the entry

	; Push optional argument
	push esi

	; Push the thread
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx

	; Call the native entry
	EXTERNDEF stack_overflow:DWORD
	mov eax, offset stack_overflow
	call eax

	; Remove the thread and the optional argument from the stack
	add esp, 8
L2758:

	; Call switch_thread(JVM_TRAPS)
	EXTERNDEF _current_thread:DWORD
	mov ecx, offset _current_thread
	push ecx
	EXTERNDEF switch_thread:PROC
	call switch_thread
	add esp, 4

	; Switch back to the java stack
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
	mov esp, dword ptr [ebx + 100]
	pop ebp
	ret

	ALIGN 16
	PUBLIC shared_call_vm_exception_return
shared_call_vm_exception_return:
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
	mov ebp, dword ptr [ebx + 72]
	mov ecx, dword ptr [ebx + 68]
	lea esp, dword ptr [ecx + -4]

	; restore the return values in the thread
	mov eax, dword ptr [ebx + 112]

	; Check for pending activations
	cmp dword ptr [ebx + 36], 0
	je L2783

	; Invoke the pending activations
	xor ecx, ecx
	EXTERNDEF shared_entry:PROC
	call shared_entry

	; Restore the thread
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
L2783:

	; Reset last java stack pointer and last java frame pointer in thread
	xor ecx, ecx
	mov dword ptr [ebx + 68], ecx
	mov dword ptr [ebx + 72], ecx

	; A return value of zero means the original entry frame
	test eax, eax
	jne L2790
	mov eax, dword ptr [ebp + -24]
	lea esp, dword ptr [ebp + -4]
	EXTERNDEF _current_pending_exception:DWORD
	mov dword ptr [_current_pending_exception], eax
	pop ebp
	ret 4
L2790:

	; Check for pending exceptions
	EXTERNDEF _current_pending_exception:DWORD
	cmp dword ptr [_current_pending_exception], 0
	EXTERNDEF shared_call_vm_forward_exception:PROC
	jne shared_call_vm_forward_exception

	; Return to the caller
	ret

	; ----------------------------------------------------------
	; Invoke pending entries
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC invoke_pending_entries
invoke_pending_entries:

	; Setup frame pointer
	push ebp
	mov ebp, esp

	; Push padding (if necessary) onto stack to make double cells 8-byte aligned
	test esp, 7
	je L2798
	push -1091576147
L2798:

	; Preserve all registers -- this must be done because this function

	; is called by C code. VC++'s code generator expects the callee to

	; preserve non-temporary registers

	; save original sp
	mov ecx, esp
	pushad

	; Check if there's pending entries at all
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
	cmp dword ptr [ebx + 36], 0
	je L2801

	; Invoke the pending entries
	xor ecx, ecx
	EXTERNDEF shared_entry:PROC
	call shared_entry
L2801:

	; Restore all registers
	popad

	; relocate ebp
	sub ecx, esp
	sub ebp, ecx

	; Restore frame pointer and return
	mov esp, ebp
	pop ebp
	sub ebp, ecx
	ret

	; ----------------------------------------------------------
	; Shared entry
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC shared_entry
shared_entry:

	; Push faked entry frame return address
	pop ebx
	push -559038737
	push ebx

	; Get the current thread
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]
	mov ebp, esp

	; Push previous frame pointer and stack pointer from thread
	push dword ptr [ebx + 72]
	push dword ptr [ebx + 68]

	; Reset the last frame pointer and last stack pointer
	xor edi, edi
	mov dword ptr [ebx + 72], edi
	mov dword ptr [ebx + 68], edi

	; Save values
	push edx
	push eax
	push ecx

	; Save the pending exception onto the stack
	EXTERNDEF _current_pending_exception:DWORD
	push dword ptr [_current_pending_exception]

	; Get the pending activation
	mov edi, dword ptr [ebx + 36]

	; Clear the pending exception and the pending activations in the thread
	xor eax, eax
	mov dword ptr [ebx + 36], eax
	EXTERNDEF _current_pending_exception:DWORD
	mov dword ptr [_current_pending_exception], eax
	EXTERNDEF pending_activations_loop:PROC
	jmp pending_activations_loop

	ALIGN 16
	PUBLIC pending_activations_loop
pending_activations_loop:

	; edi contains the current pending activation
	push dword ptr [edi + 12]

	; Get the length of the parameters and a pointer to the first parameter
	mov ecx, dword ptr [edi + 4]
	lea edx, dword ptr [edi + 16]
	jmp L2818

	; Push the next parameter onto the stack
L2819:
	push dword ptr [edx + 0]

	; Increment the parameters pointer and decrement the parameter length
	add edx, 8
	dec ecx

	; Check if there are more parameters
L2818:
	test ecx, ecx
	jne L2819

	; Get the method from the pending activation
	mov ebx, dword ptr [edi + 8]

	; Get the execution entry
	mov esi, dword ptr [ebx + 20]
	mov esi, dword ptr [esi + 0]
	call esi

	; Make the next pending activation the current one
	pop edi

	; Check if there are more pending activations
	test edi, edi
	EXTERNDEF pending_activations_loop:PROC
	jne pending_activations_loop

	; Get the current thread
	EXTERNDEF _current_thread:DWORD
	mov ebx, dword ptr [_current_thread]

	; Pop pending exception
	EXTERNDEF _current_pending_exception:DWORD
	pop dword ptr [_current_pending_exception]

	; Get stored values
	pop ecx
	pop eax
	pop edx

	; Restore the original frame pointer and the last java sp/fp
	pop dword ptr [ebx + 68]
	pop ebp
	mov dword ptr [ebx + 72], ebp

	; Remove fake frame pointer and return
	ret 4

	; ----------------------------------------------------------
	; Shared forward exception
	; ----------------------------------------------------------

	PUBLIC shared_call_vm_forward_exception
shared_call_vm_forward_exception:
	xor eax, eax
	EXTERNDEF _current_pending_exception:DWORD
	mov edx, dword ptr [_current_pending_exception]
	EXTERNDEF _current_pending_exception:DWORD
	mov dword ptr [_current_pending_exception], eax
	EXTERNDEF shared_call_vm_exception:PROC
	jmp shared_call_vm_exception

	; ----------------------------------------------------------
	; Shared monitor enter stub
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC shared_lock_synchronized_method
shared_lock_synchronized_method:

	; The object to lock on is already in eax

	; The stack lock is just below the return address
	lea edx, dword ptr [esp + 4]
	EXTERNDEF _shared_lock_allocated_monitor:PROC
	jmp _shared_lock_allocated_monitor

	ALIGN 16
	PUBLIC shared_monitor_enter
shared_monitor_enter:

	; Initialize stack lock pointer
	xor edx, edx

	; Find free slot in monitor block
	mov ecx, dword ptr [ebp + -20]
	lea ebx, dword ptr [ebp + -20]
	jmp L2839
L2840:

	; Start the loop by checking if the current stack lock is empty
	cmp dword ptr [ecx + 24], 0
	jne L2844
	mov edx, ecx
L2844:

	; Check to see if the object in the current stack lock is equal to the object from the stack
	cmp eax, dword ptr [ecx + 24]
	je L2841

	; Go to next stack lock in monitor block
	add ecx, 28
L2839:

	; Check to see whether or not we're at the end of the monitor block
	cmp ecx, ebx
	jne L2840
L2841:

	; Check if we've found an entry
	test edx, edx
	EXTERNDEF _shared_lock_allocate:PROC
	je _shared_lock_allocate

	; FALLTHROUGH

	ALIGN 16
	PUBLIC _shared_lock_allocated_monitor
_shared_lock_allocated_monitor:

	; We now have a stack lock (pointed to by register edx) in the monitor block

	; Store the object in the stack lock and lock it
	mov dword ptr [edx + 24], eax

	; Get the near object
	mov ebx, dword ptr [eax + 0]

	; see if it's an interned string
	EXTERNDEF _interned_string_near_addr:DWORD
	mov ecx, dword ptr [_interned_string_near_addr]
	cmp ebx, ecx
	je L2851

	; Check the lock bit
	test dword ptr [ebx + 8], 1
	jne L2850

	; Put the real java near pointer in the stack lock
	mov dword ptr [edx + 4], ebx

	; Put thread in the stack lock
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]
	mov dword ptr [edx + 0], ecx

	; Clear waiters
	xor ecx, ecx
	mov dword ptr [edx + 8], ecx

	; Update the near pointer in the object
	lea ecx, dword ptr [edx + 12]
	mov dword ptr [eax + 0], ecx

	; Copy the locked near object to the stack
	mov eax, dword ptr [ebx + 0]
	mov ecx, dword ptr [ebx + 4]
	mov dword ptr [edx + 12], eax
	mov dword ptr [edx + 16], ecx
	mov eax, dword ptr [ebx + 8]
	or eax, 1
	mov dword ptr [edx + 20], eax
	jmp L2852
L2850:
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]
	cmp dword ptr [ebx + -12], ecx
	jne L2851
	mov dword ptr [edx + 4], 0
	jmp L2852
L2851:

	; Call runtime system to lock the stack lock
	mov dword ptr [edx + 4], 0
	EXTERNDEF lock_stack_lock:DWORD
	lea eax, dword ptr [lock_stack_lock]
	EXTERNDEF shared_call_vm:PROC
	jmp shared_call_vm
L2852:

	; Return to the compiled code
	ret

	ALIGN 16
	PUBLIC _shared_lock_allocate
_shared_lock_allocate:

	; Allocate a stack lock in the monitor block

	; Set edx to old expression stack bottom
	mov edx, dword ptr [ebp + -20]

	; Move expression stack top and bottom
	sub esp, 28
	sub edx, 28
	mov dword ptr [ebp + -20], edx

	; Move the expression stack contents
	mov ecx, esp
	jmp L2879
L2880:

	; Copy one word at a time
	mov ebx, dword ptr [ecx + 28]
	mov dword ptr [ecx + 0], ebx
	add ecx, 4
L2879:

	; Check if bottom is reached
	cmp ecx, edx
	jne L2880
	EXTERNDEF _shared_lock_allocated_monitor:PROC
	jmp _shared_lock_allocated_monitor

	; ----------------------------------------------------------
	; Shared monitor exit stub
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC shared_monitor_exit
shared_monitor_exit:

	; Find matching slot in monitor block
	mov ecx, dword ptr [ebp + -20]
	lea ebx, dword ptr [ebp + -20]

	; Get near object
	mov edx, dword ptr [eax + 0]
	EXTERNDEF _interned_string_near_addr:DWORD
	cmp edx, dword ptr [_interned_string_near_addr]
	jne L2889
	mov edx, eax
	EXTERNDEF unlock_special_stack_lock:DWORD
	lea eax, dword ptr [unlock_special_stack_lock]
	EXTERNDEF shared_call_vm:PROC
	jmp shared_call_vm
L2890:

	; Check to see if the object in the current stack lock is equal to the object from the stack
	cmp eax, dword ptr [ecx + 24]
	EXTERNDEF _shared_do_unlock:PROC
	je _shared_do_unlock

	; Go to next stack lock in monitor block
	add ecx, 28
L2889:

	; Check to see whether or not we're at the end of the monitor block
	cmp ecx, ebx
	jne L2890

	; Throw an IllegalMonitorStateException
	EXTERNDEF illegal_monitor_state_exception:DWORD
	lea eax, dword ptr [illegal_monitor_state_exception]
	EXTERNDEF shared_call_vm:PROC
	jmp shared_call_vm

	ALIGN 16
	PUBLIC shared_unlock_synchronized_method
shared_unlock_synchronized_method:
	lea ecx, dword ptr [ebp + -48]
	mov eax, dword ptr [ecx + 24]
	test eax, eax
	EXTERNDEF _shared_do_unlock:PROC
	jne _shared_do_unlock

	; Throw an IllegalMonitorStateException
	EXTERNDEF illegal_monitor_state_exception:DWORD
	lea eax, dword ptr [illegal_monitor_state_exception]
	EXTERNDEF shared_call_vm:PROC
	jmp shared_call_vm

	ALIGN 16
	PUBLIC _shared_do_unlock
_shared_do_unlock:

	; eax contains the object

	; ecx contains the stack lock

	; Found monitor to unlock - now get/reset the object
	mov dword ptr [ecx + 24], 0

	; Get the real java near pointer from the stack lock
	mov edx, dword ptr [ecx + 4]

	; Check if zero (reentrant case)
	test edx, edx
	je L2910

	; Set the object near pointer
	mov dword ptr [eax + 0], edx

	; Oop write barrier (with heap limit checks)
	EXTERNDEF _heap_start:DWORD
	cmp eax, dword ptr [_heap_start]
	jb L2912
	EXTERNDEF _old_generation_end:DWORD
	cmp eax, dword ptr [_old_generation_end]
	jae L2912
	EXTERNDEF _bitvector_base:DWORD
	mov edx, dword ptr [_bitvector_base]
	shr eax, 2
	bts dword ptr [edx + 0], eax
L2912:

	; Check for waiters
	test dword ptr [ecx + 20], 2
	je L2910

	; Save argument to vm call in edx and do the call
	mov edx, ecx

	; Call the runtime system to signal the waiters
	EXTERNDEF signal_waiters:DWORD
	lea eax, dword ptr [signal_waiters]
	EXTERNDEF shared_call_vm:PROC
	jmp shared_call_vm
L2910:
	ret

	; ----------------------------------------------------------
	; Interpreter call VM - and repeat current bytecode upon termination
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC interpreter_call_vm_redo
interpreter_call_vm_redo:

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm and disregard any return value
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Interpreter call VM - and dispatch to the bytecode returned by the VM upon termination
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC interpreter_call_vm_dispatch
interpreter_call_vm_dispatch:

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm and disregard any return value
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [eax * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Interpreter exception throwers
	; ----------------------------------------------------------

	PUBLIC interpreter_throw_ArrayIndexOutOfBoundsException
interpreter_throw_ArrayIndexOutOfBoundsException:

	; Setup the pointer to the vm routine
	EXTERNDEF array_index_out_of_bounds_exception:DWORD
	mov eax, offset array_index_out_of_bounds_exception

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	PUBLIC interpreter_throw_NullPointerException
interpreter_throw_NullPointerException:

	; Setup the pointer to the vm routine
	EXTERNDEF null_pointer_exception:DWORD
	mov eax, offset null_pointer_exception

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	PUBLIC interpreter_throw_IllegalMonitorStateException
interpreter_throw_IllegalMonitorStateException:

	; Setup the pointer to the vm routine
	EXTERNDEF illegal_monitor_state_exception:DWORD
	mov eax, offset illegal_monitor_state_exception

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	PUBLIC interpreter_throw_ArithmeticException
interpreter_throw_ArithmeticException:

	; Setup the pointer to the vm routine
	EXTERNDEF arithmetic_exception:DWORD
	mov eax, offset arithmetic_exception

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	PUBLIC interpreter_throw_IncompatibleClassChangeError
interpreter_throw_IncompatibleClassChangeError:

	; Setup the pointer to the vm routine
	EXTERNDEF incompatible_class_change_error:DWORD
	mov eax, offset incompatible_class_change_error

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; ----------------------------------------------------------
	; Interpreter deoptimization entry
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC interpreter_deoptimization_entry
interpreter_deoptimization_entry:

	; Restore bytecode and locals pointers
	mov esi, dword ptr [ebp + -16]
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	; ----------------------------------------------------------
	; Interpreter call timer_tick
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC interpreter_timer_tick
interpreter_timer_tick:

	; Setup the pointer to the vm routine
	EXTERNDEF timer_tick:DWORD
	mov eax, offset timer_tick

	; Save bytecode pointer
	mov dword ptr [ebp + -16], esi

	; Call the shared call vm
	EXTERNDEF shared_call_vm:PROC
	call shared_call_vm

	; Restore bytecode pointer
	mov esi, dword ptr [ebp + -16]

	; Restore locals pointer
	mov edi, dword ptr [ebp + -12]

	; Load next bytecode (load before advancing esi to prevent AGI)
	movzx ebx, byte ptr [esi + 0]

	; Dispatch to next byte code
	EXTERNDEF interpreter_dispatch_table:DWORD
	jmp dword ptr [ebx * 4 + interpreter_dispatch_table]

	ALIGN 16
	PUBLIC primordial_to_current_thread
primordial_to_current_thread:
	pushad
	push ebp
	EXTERNDEF _primordial_sp:DWORD
	mov dword ptr [_primordial_sp], esp
	EXTERNDEF _current_thread:DWORD
	mov ecx, dword ptr [_current_thread]
	mov esp, dword ptr [ecx + 100]
	pop ebp
	ret

	ALIGN 16
	PUBLIC start_lightweight_thread_asm
start_lightweight_thread_asm:
	int 3

	ALIGN 16
	PUBLIC current_thread_to_primordial
current_thread_to_primordial:
	EXTERNDEF _primordial_sp:DWORD
	mov esp, dword ptr [_primordial_sp]
	pop ebp
	popad
	ret

	; ----------------------------------------------------------
	; Compiler new object (any size)
	; ----------------------------------------------------------

	; Register edx holds the instance size, register ebx holds the prototypical near of the instance class

	ALIGN 16
	PUBLIC compiler_new_object
compiler_new_object:

	; Get _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov eax, dword ptr [_inline_allocation_top]

	; Compute new top
	lea ecx, dword ptr [eax + edx * 1 + 0]

	; Compare against _inline_allocation_end
	EXTERNDEF _inline_allocation_end:DWORD
	cmp ecx, dword ptr [_inline_allocation_end]
	ja L2973

	; Allocation succeeded, set _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov dword ptr [_inline_allocation_top], ecx

	; Set prototypical near in object; no need for write barrier
	mov dword ptr [eax + 0], ebx

	; Compute remaining size
	sub edx, 4

	; One-word object?
	je L2980

	; Zero object fields
	xor ecx, ecx
L2981:
	mov dword ptr [eax + edx * 1 + 0], ecx
	sub edx, 4
	jne L2981
L2980:

	; The newly allocated object is in register eax
	ret

	; Slow case - call the VM runtime system
L2973:
	EXTERNDEF newobject:DWORD
	lea eax, dword ptr [newobject]
	EXTERNDEF shared_call_vm_oop:PROC
	jmp shared_call_vm_oop

	; ----------------------------------------------------------
	; Compiler stub: new object array
	; ----------------------------------------------------------

	; - ebx holds the prototypical near of the array class

	ALIGN 16
	PUBLIC compiler_new_obj_array
compiler_new_obj_array:

	; Get array length
	mov edx, dword ptr [esp + 4]

	; Check if the array length is too large or negative
	cmp edx, 1048575
	ja L2987

	; Get _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov eax, dword ptr [_inline_allocation_top]

	; Compute new top
	lea ecx, dword ptr [eax + edx * 4 + 8]

	; Check for overflow
	cmp ecx, eax
	jb L2987

	; Compare against _inline_allocation_end
	EXTERNDEF _inline_allocation_end:DWORD
	cmp ecx, dword ptr [_inline_allocation_end]
	ja L2987

	; Allocation succeeded, set _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov dword ptr [_inline_allocation_top], ecx

	; Set prototypical near in object; no need for write barrier
	mov dword ptr [eax + 0], ebx

	; Set the length
	mov dword ptr [eax + 4], edx

	; Compute remaining size
	test edx, edx

	; Empty array?
	je L2995

	; Zero array elements
	xor ecx, ecx
L2996:
	mov dword ptr [eax + edx * 4 + 4], ecx
	dec edx
	jne L2996
L2995:

	; The newly allocated array is in register eax
	ret

	; Slow case - call the VM runtime system
L2987:
	EXTERNDEF anewarray:DWORD
	lea eax, dword ptr [anewarray]
	EXTERNDEF shared_call_vm_oop:PROC
	jmp shared_call_vm_oop

	; ----------------------------------------------------------
	; Compiler stub: new type array
	; ----------------------------------------------------------

	; - ecx holds the array size

	; - ebx holds the prototypical near of the array class

	ALIGN 16
	PUBLIC compiler_new_type_array
compiler_new_type_array:

	; Get array length
	mov edx, dword ptr [esp + 4]

	; Check if the array length is too large or negative
	cmp edx, 1048575
	ja L3001

	; Get _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov eax, dword ptr [_inline_allocation_top]

	; Compute new top and check for overflow
	add ecx, eax
	jb L3001

	; Compare against _inline_allocation_end
	EXTERNDEF _inline_allocation_end:DWORD
	cmp ecx, dword ptr [_inline_allocation_end]
	ja L3001

	; Allocation succeeded, set _inline_allocation_top
	EXTERNDEF _inline_allocation_top:DWORD
	mov dword ptr [_inline_allocation_top], ecx

	; Set prototypical near in object; no need for write barrier
	mov dword ptr [eax + 0], ebx

	; Set the length
	mov dword ptr [eax + 4], edx

	; Compute remaining size
	sub ecx, eax
	sub ecx, 8

	; One-word object?
	je L3009

	; Zero object fields
	xor edx, edx
L3010:
	mov dword ptr [eax + ecx * 1 + 4], edx
	sub ecx, 4
	jne L3010
L3009:

	; The newly allocated array is in register eax
	ret

	; Slow case - call the VM runtime system
L3001:
	EXTERNDEF newarray:DWORD
	lea eax, dword ptr [newarray]
	EXTERNDEF shared_call_vm_oop:PROC
	jmp shared_call_vm_oop

	; ----------------------------------------------------------
	; Compiler integer divide and remainder
	; ----------------------------------------------------------

	; Register eax holds the dividend, register ebx holds the divisor

	ALIGN 16
	PUBLIC compiler_idiv_irem
compiler_idiv_irem:
	test ebx, ebx
	je L3017
	cmp eax, -2147483648
	jne L3015
	xor edx, edx
	cmp ebx, -1
	je L3016
L3015:
	cdq
	idiv ebx
L3016:
	ret
L3017:

	; Throw a DivisionByZeroException
	EXTERNDEF division_by_zero_exception:DWORD
	lea eax, dword ptr [division_by_zero_exception]
	EXTERNDEF shared_call_vm:PROC
	jmp shared_call_vm

	; ----------------------------------------------------------
	; Native entry points for math functions
	; ----------------------------------------------------------

CodeSegment ends
DataSegment segment  para  public   'DATA'

DataSegment ends
CodeSegment segment  para  public   'CODE'

	ALIGN 16
	PUBLIC native_math_sin_entry
native_math_sin_entry:

	; store return address
	pop edi
	pop eax
	pop ecx
	push ecx
	push eax
	EXTERNDEF jvm_sin:PROC
	call jvm_sin
	add esp, 8
	sub esp, 8
	fstp qword ptr [esp + 0]
	jmp edi

	ALIGN 16
	PUBLIC native_math_cos_entry
native_math_cos_entry:

	; store return address
	pop edi
	pop eax
	pop ecx
	push ecx
	push eax
	EXTERNDEF jvm_cos:PROC
	call jvm_cos
	add esp, 8
	sub esp, 8
	fstp qword ptr [esp + 0]
	jmp edi

	ALIGN 16
	PUBLIC native_math_tan_entry
native_math_tan_entry:

	; store return address
	pop edi
	pop eax
	pop ecx
	push ecx
	push eax
	EXTERNDEF jvm_tan:PROC
	call jvm_tan
	add esp, 8
	sub esp, 8
	fstp qword ptr [esp + 0]
	jmp edi

	ALIGN 16
	PUBLIC native_math_sqrt_entry
native_math_sqrt_entry:

	; store return address
	pop edi
	pop eax
	pop ecx
	push ecx
	push eax
	EXTERNDEF jvm_sqrt:PROC
	call jvm_sqrt
	add esp, 8
	sub esp, 8
	fstp qword ptr [esp + 0]
	jmp edi

	ALIGN 16
	PUBLIC native_math_ceil_entry
native_math_ceil_entry:

	; store return address
	pop edi
	pop eax
	pop ecx
	push ecx
	push eax
	EXTERNDEF jvm_ceil:PROC
	call jvm_ceil
	add esp, 8
	sub esp, 8
	fstp qword ptr [esp + 0]
	jmp edi

	ALIGN 16
	PUBLIC native_math_floor_entry
native_math_floor_entry:

	; store return address
	pop edi
	pop eax
	pop ecx
	push ecx
	push eax
	EXTERNDEF jvm_floor:PROC
	call jvm_floor
	add esp, 8
	sub esp, 8
	fstp qword ptr [esp + 0]
	jmp edi

	; ----------------------------------------------------------
	; Native entry points for string functions
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC native_string_indexof0_entry
native_string_indexof0_entry:

	; Pop the return address
	pop edi

	; Push zero for fromIndex
	push 0

	; Push back the return address
	push edi
	EXTERNDEF native_string_indexof_entry:PROC
	jmp native_string_indexof_entry

	ALIGN 16
	PUBLIC native_string_indexof_entry
native_string_indexof_entry:

	; Pop the return address
	pop edi

	; Pop the argument: fromIndex
	pop eax

	; Pop the argument: ch
	pop ebx

	; Pop the receiver
	pop ecx
	cmp ebx, 65535
	jg L3051
	cmp eax, 0
	jge L3048
	mov eax, 0
L3048:
	mov esi, dword ptr [ecx + 12]

	; if (fromIndex >= count) { return -1; }
	cmp eax, esi
	jge L3051
	mov edx, dword ptr [ecx + 8]
	add eax, edx
	add edx, esi
	mov esi, dword ptr [ecx + 4]
	jmp L3050
L3049:
	cmp word ptr [esi + eax * 2 + 8], bx
	je L3052
	inc eax
L3050:
	cmp eax, edx
	jl L3049

	; Return -1 by pushing the value and jumping to the return address
L3051:
	push -1
	jmp edi

	; Return i - offset by pushing the value and jumping to the return address
L3052:
	mov esi, dword ptr [ecx + 8]
	sub eax, esi
	push eax
	jmp edi

	ALIGN 16
	PUBLIC native_string_charAt_entry
native_string_charAt_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_init_entry
native_string_init_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_equals_entry
native_string_equals_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_indexof0_string_entry
native_string_indexof0_string_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_indexof_string_entry
native_string_indexof_string_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_compareTo_entry
native_string_compareTo_entry:

	; preserve method
	push ebx

	; load arguments to registers
	mov ecx, dword ptr [esp + 8]
	mov eax, dword ptr [esp + 12]

	; Null check
	test ecx, ecx
	je L3064

	; get str0.value[]
	mov esi, dword ptr [eax + 4]

	; get str0.offset
	mov ebx, dword ptr [eax + 8]

	; compute start of character data
	lea esi, dword ptr [esi + ebx * 2 + 8]

	; get str0.count
	mov eax, dword ptr [eax + 12]

	; get str1.value[]
	mov edi, dword ptr [ecx + 4]

	; get str1.offset
	mov ebx, dword ptr [ecx + 8]

	; compute start of character data
	lea edi, dword ptr [edi + ebx * 2 + 8]

	; get str1.count
	mov ebx, dword ptr [ecx + 12]
	sub eax, ebx
	jge L3073
	add ebx, eax
L3073:
	push eax
	xor ecx, ecx
L3074:
	cmp ecx, ebx
	jae L3075
	movzx eax, word ptr [esi + ecx * 2 + 0]
	movzx edx, word ptr [edi + ecx * 2 + 0]
	sub eax, edx
	jne L3076
	inc ecx
	jmp L3074
L3075:
	mov eax, dword ptr [esp + 0]
L3076:
	pop ebx
	pop ebx
	pop edi
	add esp, 8
	push eax
	jmp edi

	; Bail out to the general compareTo implementation
L3064:

	; pop method
	pop ebx
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_endsWith_entry
native_string_endsWith_entry:

	; load arguments to registers
	mov eax, dword ptr [esp + 4]
	cmp eax, 0
	je L3081
	mov ecx, dword ptr [esp + 8]

	; Pop the return address
	pop edi
	mov edx, dword ptr [ecx + 12]
	sub edx, dword ptr [eax + 12]

	; Push (this.count - suffix.count) for toffset
	push edx

	; Push back the return address
	push edi
	EXTERNDEF native_string_startsWith_entry:PROC
	jmp native_string_startsWith_entry

	; Bail out to the general startsWith implementation
L3081:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_startsWith0_entry
native_string_startsWith0_entry:

	; Check if prefix is null
	cmp dword ptr [esp + 4], 0
	je L3088

	; Pop the return address
	pop edi

	; Push zero for toffset
	push 0

	; Push back the return address
	push edi
	EXTERNDEF native_string_startsWith_entry:PROC
	jmp native_string_startsWith_entry

	; Bail out to the general startsWith implementation
L3088:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_startsWith_entry
native_string_startsWith_entry:

	; Check if prefix is null
	cmp dword ptr [esp + 8], 0
	je L3093

	; Pop the return address
	pop edi

	; Pop the argument: toffset
	pop edx

	; Pop the argument: prefix
	pop eax

	; Pop the receiver
	pop ecx

	; Preserve the return address
	push edi
	cmp edx, 0
	jl L3094

	; if (toffset > this.count - prefix.count) return false;
	mov ebx, dword ptr [ecx + 12]
	sub ebx, dword ptr [eax + 12]
	cmp edx, ebx
	jg L3094

	; get this.value[]
	mov esi, dword ptr [ecx + 4]

	; get this.offset
	mov ebx, dword ptr [ecx + 8]

	; add toffset
	add ebx, edx

	; compute start of character data
	lea esi, dword ptr [esi + ebx * 2 + 8]

	; get prefix.value[]
	mov edi, dword ptr [eax + 4]

	; get prefix.offset
	mov ebx, dword ptr [eax + 8]

	; compute start of character data
	lea edi, dword ptr [edi + ebx * 2 + 8]

	; get prefix.count
	mov ecx, dword ptr [eax + 12]

	; get the number of bytes to compare
	shl ecx, 1

	; memcmp(edi, esi, ecx);
	push ecx
	push esi
	push edi
	EXTERNDEF memcmp:PROC
	call memcmp
	add esp, 12
	cmp eax, 0
	jne L3094
	pop edi
	push 1
	jmp edi
L3094:
	pop edi
	push 0
	jmp edi

	; Bail out to the general startsWith implementation
L3093:
	jmp  interpreter_method_entry

	; ----------------------------------------------------------
	; Native entry points for system functions
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC native_jvm_unchecked_byte_arraycopy_entry
native_jvm_unchecked_byte_arraycopy_entry:
	EXTERNDEF native_system_arraycopy_entry:PROC
	jmp native_system_arraycopy_entry

	ALIGN 16
	PUBLIC native_jvm_unchecked_char_arraycopy_entry
native_jvm_unchecked_char_arraycopy_entry:
	EXTERNDEF native_system_arraycopy_entry:PROC
	jmp native_system_arraycopy_entry

	ALIGN 16
	PUBLIC native_jvm_unchecked_int_arraycopy_entry
native_jvm_unchecked_int_arraycopy_entry:
	EXTERNDEF native_system_arraycopy_entry:PROC
	jmp native_system_arraycopy_entry

	ALIGN 16
	PUBLIC native_jvm_unchecked_long_arraycopy_entry
native_jvm_unchecked_long_arraycopy_entry:
	EXTERNDEF native_system_arraycopy_entry:PROC
	jmp native_system_arraycopy_entry

	ALIGN 16
	PUBLIC native_jvm_unchecked_obj_arraycopy_entry
native_jvm_unchecked_obj_arraycopy_entry:
	EXTERNDEF native_system_arraycopy_entry:PROC
	jmp native_system_arraycopy_entry

	ALIGN 16
	PUBLIC native_system_arraycopy_entry
native_system_arraycopy_entry:

	; preserve method
	push ebx

	; load arguments to registers
	mov ecx, dword ptr [esp + 8]
	mov edi, dword ptr [esp + 12]
	mov edx, dword ptr [esp + 16]
	mov esi, dword ptr [esp + 20]
	mov eax, dword ptr [esp + 24]

	; if (src == NULL) goto bailout;
	test eax, eax
	je L3118

	; if (dst == NULL) goto bailout;
	test edx, edx
	je L3118

	; if (length < 0 || src_pos < 0 || dst_pos < 0) goto bailout;
	mov ebx, ecx
	or ebx, esi
	or ebx, edi
	js L3118

	; if ((unsigned int) dst.length < (unsigned int) dst_pos + (unsigned int) length) goto bailout;
	mov ebx, ecx
	add ebx, edi
	cmp dword ptr [edx + 4], ebx
	jb L3118

	; if ((unsigned int) src.length < (unsigned int) src_pos + (unsigned int) length) goto bailout;
	mov ebx, ecx
	add ebx, esi
	cmp dword ptr [eax + 4], ebx
	jb L3118

	; Same near test

	; if (src.near != dst.near) goto bailout;
	mov ebx, dword ptr [eax + 0]
	cmp ebx, dword ptr [edx + 0]
	jne L3118

	; load the instance_size
	mov ebx, dword ptr [ebx + 0]
	movsx ebx, word ptr [ebx + 6]

	; if (instance_size != size_type_array_1()) goto try_2_byte
	cmp ebx, -2
	jne L3120
	lea esi, dword ptr [eax + esi * 1 + 8]
	lea edi, dword ptr [edx + edi * 1 + 8]
	jmp L3119
L3120:

	; if (instance_size != size_type_array_2()) goto try_4_byte
	cmp ebx, -3
	jne L3121
	lea esi, dword ptr [eax + esi * 2 + 8]
	lea edi, dword ptr [edx + edi * 2 + 8]
	shl ecx, 1
	jmp L3119
L3121:

	; if (instance_size == size_type_array_4()) goto do_4_byte
	cmp ebx, -4
	je L3123

	; if (instance_size != size_obj_array()) goto bailout
	cmp ebx, -1
	jne L3118

	; if (dst < old_generation_end) goto bailout
	EXTERNDEF _old_generation_end:DWORD
	cmp edx, dword ptr [_old_generation_end]
	jb L3118
L3123:
	lea esi, dword ptr [eax + esi * 4 + 8]
	lea edi, dword ptr [edx + edi * 4 + 8]
	shl ecx, 2
L3119:

	; memmove(edi, esi, ecx);
	push ecx
	push esi
	push edi
	EXTERNDEF memmove:PROC
	call memmove
	add esp, 16
	ret 20

	; Bail out to the general arraycopy implementation
L3118:

	; pop method
	pop ebx
	jmp  interpreter_method_entry

	; ----------------------------------------------------------
	; Native entry points for thread functions
	; ----------------------------------------------------------

	ALIGN 16
	PUBLIC native_vector_elementAt_entry
native_vector_elementAt_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_vector_addElement_entry
native_vector_addElement_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_stringbuffer_append_entry
native_stringbuffer_append_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_substringI_entry
native_string_substringI_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_string_substringII_entry
native_string_substringII_entry:
	jmp  interpreter_method_entry

	ALIGN 16
	PUBLIC native_integer_toString_entry
native_integer_toString_entry:
	jmp  interpreter_method_entry

CodeSegment ends

	END
