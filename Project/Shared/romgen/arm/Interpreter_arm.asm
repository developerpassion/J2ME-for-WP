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


	; ------------------------------------------------------
	; Generated assembly file -- do *not* edit
tos_val RN 0
tos_tag RN 1
tmp0    RN 2
tmp1    RN 3
bcode   RN 12
bcp     RN 14
gp      RN 5
locals  RN 7
tmp2    RN 4
tmp3    RN 9
	AREA |.text|, CODE
	ARM
	; ------------------------------------------------------
	; Start segment: Interpreter signature area


	; ------------------------------------------------------
	; Interpreter signature

	EXPORT	assembler_loop_type
assembler_loop_type
	DCD	0x41
	LTORG
	; End segment: Interpreter signature area


	; ------------------------------------------------------
	; Start segment: Interpreter method entry


	; ------------------------------------------------------
	; standard interpreter method entry

	EXPORT	fixed_interpreter_method_entry
fixed_interpreter_method_entry PROC
	nop

	ENDP

	EXPORT	interpreter_method_entry
interpreter_method_entry PROC
	; Save this interpreted method into interpretation log
	ldr	r3, [r5, #1240]          ; interpretation_log_idx 
	add	r2, r5, #0x400           ; slow add_gp_imm interpretation_log 1204
	add	r2, r2, #180
	str	r0, [r2, +r3]
	add	r3, r3, #4
	and	r3, r3, #31
	str	r3, [r5, #1240]          ; interpretation_log_idx 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	add	r7, r6, r2, lsl #2
	sub	r7, r7, #4
	; get maximum stack execution size
	ldrh	r3, [r0, #28]
	ldr	r1, [r5, #1024]          ; current_stack_limit 
	sub	r3, r6, r3, lsl #2
	sub	r3, r3, #28
	cmp	r3, r1
	adrlls	r1, L0
	bls	interpreter_grow_stack
L0
	; get number of locals
	ldrh	r3, [r0, #30]
	; pushing cleared locals
	sub	r3, r3, r2
	sub	r6, r6, r3, lsl #2
	; get constants pool
	ldrh	r8, [r0, #24]            ; get access flags
	tst	r8, #0x200               ; compressed header?
	ldrne	r8, [r5, #1260]          ; rom_constant_pool_fast 
	ldreq	r8, [r0, #4]             ; method constant pool
	; Reserve space on stack for frame
	sub	r6, r6, #28
	; Fill in fields of the frame
	add	r8, r8, #12
	str	r6, [r6, #24]
	str	r7, [r6, #8]
	str	r8, [r6, #12]
	str	r0, [r6, #16]
	str	fp, [r6, #20]
	str	lr, [r6]
	; Set the Frame pointer
	add	fp, r6, #20
	; set bcp
	add	lr, r0, #40
	; check if the method is synchronized
	ldrh	r2, [r0, #24]
	tst	r2, #32
	bne	L1
L2
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldrb	r12, [lr]                ; prefetch next bytecode
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]

	EXPORT	synchronize_interpreted_method
synchronize_interpreted_method
L1
	; synchronize method, register tmp0(r2) holds the access flags
	tst	r2, #8
	; CC = ne: Synchronize on current class
	; CC = eq: Synchronize on local 0
	ldrneh	r9, [r0, #26]
	ldrne	r4, [r5, #1196]          ; class_list_base 
	ldreq	r0, [r7]
	ldrne	r3, [r4, +r9, lsl #2]
	; save interpreter state
	str	lr, [fp, #-16]
	; if 'eq' then synchronizing on a local so skip all this mirror stuff
	beq	L4
	ldr	r4, [r5, #1200]          ; mirror_list_base 
	ldr	r4, [r4, +r9, lsl #2]
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmp	r4, r9
	bne	L4
L5
	; Class must be being initialized by the current thread then
	; Get the class to search the clinit list of current thread
	; get_mirror_from_clinit_list(mirror, klass, temp reg
	ldr	r9, [r5, #1796]          ; current_task 
	; clinit_list (task mirror) into tmp2
	ldr	r4, [r9, #56]
L6
	ldr	r9, [r4, #8]
	cmp	r3, r9
	beq	L7
	ldr	r4, [r4, #16]
	b	L6
L7
	ldr	r0, [r4, #4]
	b	L3
L4
	ldrne	r0, [r4, #4]
L3
	; object to lock is in r0
	bl	shared_lock_synchronized_method
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	b	L2
	LTORG

	ENDP
	; End segment: Interpreter method entry


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (0 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_0
fixed_interpreter_fast_method_entry_0 PROC
	nop

	ENDP

	EXPORT	interpreter_fast_method_entry_0
interpreter_fast_method_entry_0 PROC
	; Save this interpreted method into interpretation log
	ldr	r3, [r5, #1240]          ; interpretation_log_idx 
	add	r2, r5, #0x400           ; slow add_gp_imm interpretation_log 1204
	add	r2, r2, #180
	str	r0, [r2, +r3]
	add	r3, r3, #4
	and	r3, r3, #31
	str	r3, [r5, #1240]          ; interpretation_log_idx 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	add	r7, r6, r2, lsl #2
	sub	r7, r7, #4
	; get maximum stack execution size
	ldrh	r3, [r0, #28]
	ldr	r1, [r5, #1024]          ; current_stack_limit 
	sub	r3, r6, r3, lsl #2
	sub	r3, r3, #28
	cmp	r3, r1
	adrlls	r1, L8
	bls	interpreter_grow_stack
L8
	; get constants pool
	ldrh	r8, [r0, #24]            ; get access flags
	tst	r8, #0x200               ; compressed header?
	ldrne	r8, [r5, #1260]          ; rom_constant_pool_fast 
	ldreq	r8, [r0, #4]             ; method constant pool
	; Reserve space on stack for frame
	sub	r6, r6, #28
	; Fill in fields of the frame
	add	r8, r8, #12
	str	r6, [r6, #24]
	str	r7, [r6, #8]
	str	r8, [r6, #12]
	str	r0, [r6, #16]
	str	fp, [r6, #20]
	str	lr, [r6]
	; Set the Frame pointer
	add	fp, r6, #20
	; set bcp
	add	lr, r0, #40
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldrb	r12, [lr]                ; prefetch next bytecode
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (1 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_1
fixed_interpreter_fast_method_entry_1 PROC
	nop

	ENDP

	EXPORT	interpreter_fast_method_entry_1
interpreter_fast_method_entry_1 PROC
	; Save this interpreted method into interpretation log
	ldr	r3, [r5, #1240]          ; interpretation_log_idx 
	add	r2, r5, #0x400           ; slow add_gp_imm interpretation_log 1204
	add	r2, r2, #180
	str	r0, [r2, +r3]
	add	r3, r3, #4
	and	r3, r3, #31
	str	r3, [r5, #1240]          ; interpretation_log_idx 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	add	r7, r6, r2, lsl #2
	sub	r7, r7, #4
	; get maximum stack execution size
	ldrh	r3, [r0, #28]
	ldr	r1, [r5, #1024]          ; current_stack_limit 
	sub	r3, r6, r3, lsl #2
	sub	r3, r3, #28
	cmp	r3, r1
	adrlls	r1, L9
	bls	interpreter_grow_stack
L9
	; push cleared locals
	sub	r6, r6, #4
	; get constants pool
	ldrh	r8, [r0, #24]            ; get access flags
	tst	r8, #0x200               ; compressed header?
	ldrne	r8, [r5, #1260]          ; rom_constant_pool_fast 
	ldreq	r8, [r0, #4]             ; method constant pool
	; Reserve space on stack for frame
	sub	r6, r6, #28
	; Fill in fields of the frame
	add	r8, r8, #12
	str	r6, [r6, #24]
	str	r7, [r6, #8]
	str	r8, [r6, #12]
	str	r0, [r6, #16]
	str	fp, [r6, #20]
	str	lr, [r6]
	; Set the Frame pointer
	add	fp, r6, #20
	; set bcp
	add	lr, r0, #40
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldrb	r12, [lr]                ; prefetch next bytecode
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (2 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_2
fixed_interpreter_fast_method_entry_2 PROC
	nop

	ENDP

	EXPORT	interpreter_fast_method_entry_2
interpreter_fast_method_entry_2 PROC
	; Save this interpreted method into interpretation log
	ldr	r3, [r5, #1240]          ; interpretation_log_idx 
	add	r2, r5, #0x400           ; slow add_gp_imm interpretation_log 1204
	add	r2, r2, #180
	str	r0, [r2, +r3]
	add	r3, r3, #4
	and	r3, r3, #31
	str	r3, [r5, #1240]          ; interpretation_log_idx 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	add	r7, r6, r2, lsl #2
	sub	r7, r7, #4
	; get maximum stack execution size
	ldrh	r3, [r0, #28]
	ldr	r1, [r5, #1024]          ; current_stack_limit 
	sub	r3, r6, r3, lsl #2
	sub	r3, r3, #28
	cmp	r3, r1
	adrlls	r1, L10
	bls	interpreter_grow_stack
L10
	; push cleared locals
	sub	r6, r6, #8
	; get constants pool
	ldrh	r8, [r0, #24]            ; get access flags
	tst	r8, #0x200               ; compressed header?
	ldrne	r8, [r5, #1260]          ; rom_constant_pool_fast 
	ldreq	r8, [r0, #4]             ; method constant pool
	; Reserve space on stack for frame
	sub	r6, r6, #28
	; Fill in fields of the frame
	add	r8, r8, #12
	str	r6, [r6, #24]
	str	r7, [r6, #8]
	str	r8, [r6, #12]
	str	r0, [r6, #16]
	str	fp, [r6, #20]
	str	lr, [r6]
	; Set the Frame pointer
	add	fp, r6, #20
	; set bcp
	add	lr, r0, #40
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldrb	r12, [lr]                ; prefetch next bytecode
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (3 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_3
fixed_interpreter_fast_method_entry_3 PROC
	nop

	ENDP

	EXPORT	interpreter_fast_method_entry_3
interpreter_fast_method_entry_3 PROC
	; Save this interpreted method into interpretation log
	ldr	r3, [r5, #1240]          ; interpretation_log_idx 
	add	r2, r5, #0x400           ; slow add_gp_imm interpretation_log 1204
	add	r2, r2, #180
	str	r0, [r2, +r3]
	add	r3, r3, #4
	and	r3, r3, #31
	str	r3, [r5, #1240]          ; interpretation_log_idx 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	add	r7, r6, r2, lsl #2
	sub	r7, r7, #4
	; get maximum stack execution size
	ldrh	r3, [r0, #28]
	ldr	r1, [r5, #1024]          ; current_stack_limit 
	sub	r3, r6, r3, lsl #2
	sub	r3, r3, #28
	cmp	r3, r1
	adrlls	r1, L11
	bls	interpreter_grow_stack
L11
	; push cleared locals
	sub	r6, r6, #12
	; get constants pool
	ldrh	r8, [r0, #24]            ; get access flags
	tst	r8, #0x200               ; compressed header?
	ldrne	r8, [r5, #1260]          ; rom_constant_pool_fast 
	ldreq	r8, [r0, #4]             ; method constant pool
	; Reserve space on stack for frame
	sub	r6, r6, #28
	; Fill in fields of the frame
	add	r8, r8, #12
	str	r6, [r6, #24]
	str	r7, [r6, #8]
	str	r8, [r6, #12]
	str	r0, [r6, #16]
	str	fp, [r6, #20]
	str	lr, [r6]
	; Set the Frame pointer
	add	fp, r6, #20
	; set bcp
	add	lr, r0, #40
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldrb	r12, [lr]                ; prefetch next bytecode
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (4 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_4
fixed_interpreter_fast_method_entry_4 PROC
	nop

	ENDP

	EXPORT	interpreter_fast_method_entry_4
interpreter_fast_method_entry_4 PROC
	; Save this interpreted method into interpretation log
	ldr	r3, [r5, #1240]          ; interpretation_log_idx 
	add	r2, r5, #0x400           ; slow add_gp_imm interpretation_log 1204
	add	r2, r2, #180
	str	r0, [r2, +r3]
	add	r3, r3, #4
	and	r3, r3, #31
	str	r3, [r5, #1240]          ; interpretation_log_idx 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	add	r7, r6, r2, lsl #2
	sub	r7, r7, #4
	; get maximum stack execution size
	ldrh	r3, [r0, #28]
	ldr	r1, [r5, #1024]          ; current_stack_limit 
	sub	r3, r6, r3, lsl #2
	sub	r3, r3, #28
	cmp	r3, r1
	adrlls	r1, L12
	bls	interpreter_grow_stack
L12
	; push cleared locals
	sub	r6, r6, #16
	; get constants pool
	ldrh	r8, [r0, #24]            ; get access flags
	tst	r8, #0x200               ; compressed header?
	ldrne	r8, [r5, #1260]          ; rom_constant_pool_fast 
	ldreq	r8, [r0, #4]             ; method constant pool
	; Reserve space on stack for frame
	sub	r6, r6, #28
	; Fill in fields of the frame
	add	r8, r8, #12
	str	r6, [r6, #24]
	str	r7, [r6, #8]
	str	r8, [r6, #12]
	str	r0, [r6, #16]
	str	fp, [r6, #20]
	str	lr, [r6]
	; Set the Frame pointer
	add	fp, r6, #20
	; set bcp
	add	lr, r0, #40
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldrb	r12, [lr]                ; prefetch next bytecode
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Quick native method entry (void)

	EXPORT	quick_void_native_method_entry
quick_void_native_method_entry PROC
	mov	r3, #1
	str	r3, [r5, #1268]          ; jvm_in_quick_native_method 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	; get access flags
	ldrh	r4, [r0, #24]
	; get the address of quick native function
	ldr	r3, [r0, #28]
	; Calculate bottom of my parameters
	add	r6, r6, r2, lsl #2
	; Test method staticness and set KNI parameters properly
	tst	r4, #8
	subeq	r4, r6, #4               ; Non-static method
	addne	r4, r6, #0               ; Static method, KNI-style, so first parameter at index 1
	str	r4, [r5, #1256]          ; kni_parameter_base 
	mov	r7, lr                   ; save return address of caller
	mov	lr, pc                   ; save my return address
	bx	r3                       ; jump to native function
	; Tell VM we're out of quick native methods
	ldr	r3, [r5, #1272]          ; jvm_quick_native_exception 
	mov	r4, #0
	str	r4, [r5, #1268]          ; jvm_in_quick_native_method 
	cmp	r3, #0
	moveq	r2, #0
	bxeq	r7                       ; return back to caller if no exception
L13
	; Let the exception be thrown by System.quickNativeThrow()
	mov	lr, r7
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 240
	ldr	r0, [r0]
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Quick native method entry (int)

	EXPORT	quick_int_native_method_entry
quick_int_native_method_entry PROC
	mov	r3, #1
	str	r3, [r5, #1268]          ; jvm_in_quick_native_method 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	; get access flags
	ldrh	r4, [r0, #24]
	; get the address of quick native function
	ldr	r3, [r0, #28]
	; Calculate bottom of my parameters
	add	r6, r6, r2, lsl #2
	; Test method staticness and set KNI parameters properly
	tst	r4, #8
	subeq	r4, r6, #4               ; Non-static method
	addne	r4, r6, #0               ; Static method, KNI-style, so first parameter at index 1
	str	r4, [r5, #1256]          ; kni_parameter_base 
	mov	r7, lr                   ; save return address of caller
	mov	lr, pc                   ; save my return address
	bx	r3                       ; jump to native function
	; Tell VM we're out of quick native methods
	ldr	r3, [r5, #1272]          ; jvm_quick_native_exception 
	mov	r4, #0
	str	r4, [r5, #1268]          ; jvm_in_quick_native_method 
	cmp	r3, #0
	moveq	r2, #1
	bxeq	r7                       ; return back to caller if no exception
L14
	; Let the exception be thrown by System.quickNativeThrow()
	mov	lr, r7
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 240
	ldr	r0, [r0]
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Quick native method entry (obj)

	EXPORT	quick_obj_native_method_entry
quick_obj_native_method_entry PROC
	mov	r3, #1
	str	r3, [r5, #1268]          ; jvm_in_quick_native_method 
	; get parameter size in words
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	; get access flags
	ldrh	r4, [r0, #24]
	; get the address of quick native function
	ldr	r3, [r0, #28]
	; Calculate bottom of my parameters
	add	r6, r6, r2, lsl #2
	; Test method staticness and set KNI parameters properly
	tst	r4, #8
	subeq	r4, r6, #4               ; Non-static method
	addne	r4, r6, #0               ; Static method, KNI-style, so first parameter at index 1
	str	r4, [r5, #1256]          ; kni_parameter_base 
	mov	r7, lr                   ; save return address of caller
	mov	lr, pc                   ; save my return address
	bx	r3                       ; jump to native function
	; Tell VM we're out of quick native methods
	ldr	r3, [r5, #1272]          ; jvm_quick_native_exception 
	mov	r4, #0
	str	r4, [r5, #1268]          ; jvm_in_quick_native_method 
	cmp	r3, #0
	moveq	r2, #1
	bxeq	r7                       ; return back to caller if no exception
L15
	; Let the exception be thrown by System.quickNativeThrow()
	mov	lr, r7
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 240
	ldr	r0, [r0]
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment: Fast memory routines

	EXPORT	jvm_memcmp
jvm_memcmp PROC
	; for short areas use byte-by-byte comparision
	cmp	r2, #4
	ble	L16
	; check, if strings both aligned or misaligned on the same offset
	eor	r3, r0, r1
	tst	r3, #3
	; if no, go to the next check
	bne	L21
L20
	; align loop
	tst	r0, #3
	beq	L26
	ldrb	r3, [r0], #1
	ldrb	r12, [r1], #1
	cmp	r3, r12
	bne	L22
	sub	r2, r2, #1
	b	L20
L21
	; now test if we can be two bytes aligned
	tst	r3, #1
	; go to byte-by-byte, if no
	bne	L19
	tst	r0, #1
	beq	L28
	; 2-byte align
	ldrb	r3, [r0], #1
	ldrb	r12, [r1], #1
	cmp	r3, r12
	bne	L22
	sub	r2, r2, #1
L28
	; avoid additional cmp in loop
	sub	r2, r2, #1
L27
	ldrh	r3, [r0], #2
	ldrh	r12, [r1], #2
	cmp	r3, r12
	bne	L23
	subs	r2, r2, #2
	bgt	L27
	; compensate
	adds	r2, r2, #1
	moveq	r0, #0
	bxeq	lr
	b	L16
L26
	; avoid additional cmp in loop
	cmp	r2, #4
	blt	L16
	sub	r2, r2, #3
L25
	; loop to do 4-byte aligned comparision
	ldr	r3, [r0], #4
	ldr	r12, [r1], #4
	cmp	r3, r12
	bne	L24
	subs	r2, r2, #4
	bgt	L25
	; compensate
	add	r2, r2, #3
L16
	; we're here when data is heavily misaligned, or few bytes left
	cmp	r2, #0
	moveq	r0, #0
	bxeq	lr
L19
	tst	r2, #1
	addne	r2, r2, #1
	bne	L18
L17
	; unrolled x2 loop for byte at the time processing
	ldrb	r3, [r0], #1
	ldrb	r12, [r1], #1
	cmp	r3, r12
	bne	L22
L18
	ldrb	r3, [r0], #1
	ldrb	r12, [r1], #1
	cmp	r3, r12
	bne	L22
	subs	r2, r2, #2
	bne	L17
L22
	sub	r0, r3, r12
	bx	lr
L24
	; we found words not equal, find offender
L23
	and	r0, r3, #255
	and	r1, r12, #255
	subs	r0, r0, r1
	bxne	lr
	mov	r3, r3, lsr #8
	mov	r12, r12, lsr #8
	b	L24

	ENDP

	EXPORT	jvm_memcpy
jvm_memcpy PROC
	; Check to see if the length is 0.  Also check to see
	;  which direction we need to do the copying in: 
	cmp	r2, #0
	cmpne	r0, r1
	; Nothing to copy.  Return to caller. 
	bxeq	lr
	bhi	L40
L29
	;  Do forward copying:
	cmp	r2, #4
	blt	L37
	; Check if the r0 and r1 pointers are similarly aligned: 
	; Equal bits will become 0. 
	eor	r3, r1, r0
	;  Check if low 2 bits are equal 
	tst	r3, #3
	bne	L37
	;  Do aligned copying:  Check if already word aligned
	tst	r1, #3
	bne	L35
L30
	and	r12, r2, #3
	bic	r2, r2, #3
	subs	r2, r2, #4
	blt	L32
L31
	ldr	r3, [r1], #4
	subs	r2, r2, #4
	str	r3, [r0], #4
	bge	L31
L32
	;  Copy the trailing half word if necessary:
	tst	r12, #2
	beq	L33
	ldrh	r3, [r1], #2
	strh	r3, [r0], #2
L33
	;  Copy the trailing byte if necessary:
	tst	r12, #1
	beq	L34
	ldrb	r3, [r1]
	strb	r3, [r0]
L34
	;  Return to caller.
	bx	lr
L35
	;   Copy leading byte if necessary:
	tst	r1, #1
	beq	L36
	ldrb	r3, [r1], #1
	sub	r2, r2, #1
	strb	r3, [r0], #1
L36
	;    Copy the leading halfword if necessary:
	tst	r1, #2
	beq	L30
	ldrh	r3, [r1], #2
	sub	r2, r2, #2
	strh	r3, [r0], #2
	b	L30
L37
	subs	r2, r2, #1
	blt	L39
L38
	ldrb	r3, [r1], #1
	subs	r2, r2, #1
	strb	r3, [r0], #1
	bge	L38
L39
	;  Return to caller.
	bx	lr
L40
	; If (dest >= src + length), then we can do forward copying: 
	add	r12, r1, r2
	cmp	r0, r12
	bcs	L29
L41
	; Do backward copying:
	subs	r2, r2, #1
	add	r1, r1, r2
	add	r0, r0, r2
	blt	L43
L42
	ldrb	r3, [r1], #-1
	subs	r2, r2, #1
	strb	r3, [r0], #-1
	bge	L42
L43
	;  Return to caller.
	bx	lr
	LTORG

	ENDP
	; End segment: Fast memory routines


	; ------------------------------------------------------
	; Start segment: Interpreter grow stack

	EXPORT	interpreter_grow_stack
interpreter_grow_stack PROC
	; r0   contains the method
	; r1   contains the return address of the interpreter_xxx
	; lr   contains whoever called us
	; tmp1 contains the amount of stack we need
	; locals contains the current locals pointer
	; get constants pool
	ldrh	r8, [r0, #24]            ; get access flags
	tst	r8, #0x200               ; compressed header?
	ldrne	r8, [r5, #1260]          ; rom_constant_pool_fast 
	ldreq	r8, [r0, #4]             ; method constant pool
	; Reserve space on stack for frame
	sub	r6, r6, #28
	; Fill in fields of the frame
	add	r8, r8, #12
	str	r6, [r6, #24]
	str	r7, [r6, #8]
	str	r8, [r6, #12]
	str	r0, [r6, #16]
	str	fp, [r6, #20]
	str	lr, [r6]
	; Set the Frame pointer
	add	fp, r6, #20
	add	lr, r0, #40
	add	lr, lr, #0x20000000
	; save interpreter state
	str	lr, [fp, #-16]
	str	r1, [r6, #-4]!
	; stack_overflow(limit)
	mov	r1, r3
	IMPORT	stack_overflow
	ldr	r3, =stack_overflow
	bl	interpreter_call_vm
	; Get real return address
	ldr	r4, [r6]
	ldr	r0, [fp, #-4]
	ldr	r7, [fp, #-12]
	ldr	lr, [fp, #-20]
	mov	r6, fp
	ldr	fp, [r6], #8
	ldrh	r2, [r0, #32]
	mov	r2, r2, lsl #23
	mov	r2, r2, lsr #23          ; r2 = parameter size in words
	mov	pc, r4
	LTORG

	ENDP
	; End segment: Interpreter grow stack




	; ------------------------------------------------------
	; Interpreter bytecode templates
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_nop
bc_impl_nop

	EXPORT	bc_impl_nop_internal
bc_impl_nop_internal PROC
	; do nothing
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; aconst_null is a duplicate of iconst_0
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_m1
bc_impl_iconst_m1

	EXPORT	bc_impl_iconst_m1_internal
bc_impl_iconst_m1_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mvn	r0, #0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_0
bc_impl_iconst_0

	EXPORT	bc_impl_aconst_null
bc_impl_aconst_null PROC

	ENDP

	EXPORT	bc_impl_fconst_0
bc_impl_fconst_0 PROC

	ENDP

	EXPORT	bc_impl_iconst_0_internal
bc_impl_iconst_0_internal PROC

	ENDP

	EXPORT	bc_impl_aconst_null_internal
bc_impl_aconst_null_internal PROC

	ENDP

	EXPORT	bc_impl_fconst_0_internal
bc_impl_fconst_0_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_1
bc_impl_iconst_1

	EXPORT	bc_impl_iconst_1_internal
bc_impl_iconst_1_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #1
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_2
bc_impl_iconst_2

	EXPORT	bc_impl_iconst_2_internal
bc_impl_iconst_2_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #2
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_3
bc_impl_iconst_3

	EXPORT	bc_impl_iconst_3_internal
bc_impl_iconst_3_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #3
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_4
bc_impl_iconst_4

	EXPORT	bc_impl_iconst_4_internal
bc_impl_iconst_4_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_5
bc_impl_iconst_5

	EXPORT	bc_impl_iconst_5_internal
bc_impl_iconst_5_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #5
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lconst_0
bc_impl_lconst_0

	EXPORT	bc_impl_lconst_0_internal
bc_impl_lconst_0_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #0
	mov	r2, #0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lconst_1
bc_impl_lconst_1

	EXPORT	bc_impl_lconst_1_internal
bc_impl_lconst_1_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #1
	mov	r2, #0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; fconst_0 is a duplicate of iconst_0
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fconst_1
bc_impl_fconst_1

	EXPORT	bc_impl_fconst_1_internal
bc_impl_fconst_1_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #0x3f800000
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fconst_2
bc_impl_fconst_2

	EXPORT	bc_impl_fconst_2_internal
bc_impl_fconst_2_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	mov	r0, #0x40000000
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dconst_0
bc_impl_dconst_0

	EXPORT	bc_impl_dconst_0_internal
bc_impl_dconst_0_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	mov	r0, #0
	mov	r2, #0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dconst_1
bc_impl_dconst_1

	EXPORT	bc_impl_dconst_1_internal
bc_impl_dconst_1_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	mov	r0, #0
	mov	r2, #0xff00000
	add	r2, r2, #0x30000000
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_bipush
bc_impl_bipush

	EXPORT	bc_impl_bipush_internal
bc_impl_bipush_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	ldrsb	r0, [lr, #-1]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_sipush
bc_impl_sipush

	EXPORT	bc_impl_sipush_internal
bc_impl_sipush_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrsb	r3, [lr, #1]
	ldrb	r4, [lr, #2]
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	orr	r0, r4, r3, lsl #8
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ldc
bc_impl_ldc

	EXPORT	bc_impl_ldc_w
bc_impl_ldc_w PROC

	ENDP

	EXPORT	bc_impl_ldc2_w
bc_impl_ldc2_w PROC

	ENDP

	EXPORT	bc_impl_invokevirtual
bc_impl_invokevirtual PROC

	ENDP

	EXPORT	bc_impl_invokespecial
bc_impl_invokespecial PROC

	ENDP

	EXPORT	bc_impl_ldc_internal
bc_impl_ldc_internal PROC

	ENDP

	EXPORT	bc_impl_ldc_w_internal
bc_impl_ldc_w_internal PROC

	ENDP

	EXPORT	bc_impl_ldc2_w_internal
bc_impl_ldc2_w_internal PROC

	ENDP

	EXPORT	bc_impl_invokevirtual_internal
bc_impl_invokevirtual_internal PROC

	ENDP

	EXPORT	bc_impl_invokespecial_internal
bc_impl_invokespecial_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	quicken
	ldr	r3, =quicken
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr]                ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ldc_w is a duplicate of ldc
	; ldc2_w is a duplicate of ldc
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_wide_iload
bc_impl_wide_iload

	EXPORT	bc_impl_wide_fload
bc_impl_wide_fload PROC

	ENDP

	EXPORT	bc_impl_wide_aload
bc_impl_wide_aload PROC

	ENDP

	EXPORT	bc_impl_wide_iload_internal
bc_impl_wide_iload_internal PROC

	ENDP

	EXPORT	bc_impl_wide_fload_internal
bc_impl_wide_fload_internal PROC

	ENDP

	EXPORT	bc_impl_wide_aload_internal
bc_impl_wide_aload_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	; load unsigned 16bit word at bcp + 2
	ldrb	r9, [lr, #2]
	ldrb	r2, [lr, #3]
	ldrb	r12, [lr, #4]!           ; prefetch next bytecode
	orr	r9, r2, r9, lsl #8
	ldr	r0, [r7, -r9, lsl #2]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	; Data containing entry for wide bytecode
	DCD	bc_impl_wide_aload

	EXPORT	bc_impl_iload
bc_impl_iload

	ENDP

	EXPORT	bc_impl_fload
bc_impl_fload PROC

	ENDP

	EXPORT	bc_impl_aload
bc_impl_aload PROC

	ENDP

	EXPORT	bc_impl_iload_internal
bc_impl_iload_internal PROC

	ENDP

	EXPORT	bc_impl_fload_internal
bc_impl_fload_internal PROC

	ENDP

	EXPORT	bc_impl_aload_internal
bc_impl_aload_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	; load unsigned byte at bcp + 1
	ldrb	r9, [lr, #1]
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	ldr	r0, [r7, -r9, lsl #2]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_wide_lload
bc_impl_wide_lload

	EXPORT	bc_impl_wide_dload
bc_impl_wide_dload PROC

	ENDP

	EXPORT	bc_impl_wide_lload_internal
bc_impl_wide_lload_internal PROC

	ENDP

	EXPORT	bc_impl_wide_dload_internal
bc_impl_wide_dload_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	; load unsigned 16bit word at bcp + 2
	ldrb	r9, [lr, #2]
	ldrb	r2, [lr, #3]
	ldrb	r12, [lr, #4]!           ; prefetch next bytecode
	orr	r9, r2, r9, lsl #8
	sub	r4, r7, r9, lsl #2       ; address of local #r9
	ldr	r0, [r4, #-4]
	ldr	r2, [r4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	; Data containing entry for wide bytecode
	DCD	bc_impl_wide_dload

	EXPORT	bc_impl_lload
bc_impl_lload

	ENDP

	EXPORT	bc_impl_dload
bc_impl_dload PROC

	ENDP

	EXPORT	bc_impl_lload_internal
bc_impl_lload_internal PROC

	ENDP

	EXPORT	bc_impl_dload_internal
bc_impl_dload_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	; load unsigned byte at bcp + 1
	ldrb	r9, [lr, #1]
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	sub	r4, r7, r9, lsl #2       ; address of local #r9
	ldr	r0, [r4, #-4]
	ldr	r2, [r4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; fload is a duplicate of iload
	; dload is a duplicate of lload
	; aload is a duplicate of iload
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iload_0
bc_impl_iload_0

	EXPORT	bc_impl_fload_0
bc_impl_fload_0 PROC

	ENDP

	EXPORT	bc_impl_aload_0
bc_impl_aload_0 PROC

	ENDP

	EXPORT	bc_impl_iload_0_internal
bc_impl_iload_0_internal PROC

	ENDP

	EXPORT	bc_impl_fload_0_internal
bc_impl_fload_0_internal PROC

	ENDP

	EXPORT	bc_impl_aload_0_internal
bc_impl_aload_0_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r0, [r7]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iload_1
bc_impl_iload_1

	EXPORT	bc_impl_fload_1
bc_impl_fload_1 PROC

	ENDP

	EXPORT	bc_impl_aload_1
bc_impl_aload_1 PROC

	ENDP

	EXPORT	bc_impl_iload_1_internal
bc_impl_iload_1_internal PROC

	ENDP

	EXPORT	bc_impl_fload_1_internal
bc_impl_fload_1_internal PROC

	ENDP

	EXPORT	bc_impl_aload_1_internal
bc_impl_aload_1_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r0, [r7, #-4]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iload_2
bc_impl_iload_2

	EXPORT	bc_impl_fload_2
bc_impl_fload_2 PROC

	ENDP

	EXPORT	bc_impl_aload_2
bc_impl_aload_2 PROC

	ENDP

	EXPORT	bc_impl_iload_2_internal
bc_impl_iload_2_internal PROC

	ENDP

	EXPORT	bc_impl_fload_2_internal
bc_impl_fload_2_internal PROC

	ENDP

	EXPORT	bc_impl_aload_2_internal
bc_impl_aload_2_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r0, [r7, #-8]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iload_3
bc_impl_iload_3

	EXPORT	bc_impl_fload_3
bc_impl_fload_3 PROC

	ENDP

	EXPORT	bc_impl_aload_3
bc_impl_aload_3 PROC

	ENDP

	EXPORT	bc_impl_iload_3_internal
bc_impl_iload_3_internal PROC

	ENDP

	EXPORT	bc_impl_fload_3_internal
bc_impl_fload_3_internal PROC

	ENDP

	EXPORT	bc_impl_aload_3_internal
bc_impl_aload_3_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r0, [r7, #-12]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lload_0
bc_impl_lload_0

	EXPORT	bc_impl_dload_0
bc_impl_dload_0 PROC

	ENDP

	EXPORT	bc_impl_lload_0_internal
bc_impl_lload_0_internal PROC

	ENDP

	EXPORT	bc_impl_dload_0_internal
bc_impl_dload_0_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r2, [r7]
	ldr	r0, [r7, #-4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lload_1
bc_impl_lload_1

	EXPORT	bc_impl_dload_1
bc_impl_dload_1 PROC

	ENDP

	EXPORT	bc_impl_lload_1_internal
bc_impl_lload_1_internal PROC

	ENDP

	EXPORT	bc_impl_dload_1_internal
bc_impl_dload_1_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r2, [r7, #-4]
	ldr	r0, [r7, #-8]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lload_2
bc_impl_lload_2

	EXPORT	bc_impl_dload_2
bc_impl_dload_2 PROC

	ENDP

	EXPORT	bc_impl_lload_2_internal
bc_impl_lload_2_internal PROC

	ENDP

	EXPORT	bc_impl_dload_2_internal
bc_impl_dload_2_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r2, [r7, #-8]
	ldr	r0, [r7, #-12]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lload_3
bc_impl_lload_3

	EXPORT	bc_impl_dload_3
bc_impl_dload_3 PROC

	ENDP

	EXPORT	bc_impl_lload_3_internal
bc_impl_lload_3_internal PROC

	ENDP

	EXPORT	bc_impl_dload_3_internal
bc_impl_dload_3_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r2, [r7, #-12]
	ldr	r0, [r7, #-16]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


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
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iaload
bc_impl_iaload

	EXPORT	bc_impl_faload
bc_impl_faload PROC

	ENDP

	EXPORT	bc_impl_aaload
bc_impl_aaload PROC

	ENDP

	EXPORT	bc_impl_iaload_internal
bc_impl_iaload_internal PROC

	ENDP

	EXPORT	bc_impl_faload_internal
bc_impl_faload_internal PROC

	ENDP

	EXPORT	bc_impl_aaload_internal
bc_impl_aaload_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, #0
	ldrne	r3, [r2, #4]
	beq	L44
	cmp	r0, r3
	bcs	L45
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	add	r2, r2, r0, lsl #2       ; load array element
	ldr	r0, [r2, #8]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L44
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L45
	; Handle array index out of bounds exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_laload
bc_impl_laload

	EXPORT	bc_impl_daload
bc_impl_daload PROC

	ENDP

	EXPORT	bc_impl_laload_internal
bc_impl_laload_internal PROC

	ENDP

	EXPORT	bc_impl_daload_internal
bc_impl_daload_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, #0
	ldrne	r3, [r2, #4]
	beq	L46
	cmp	r0, r3
	bcs	L47
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	add	r2, r2, r0, lsl #3       ; load array element
	ldr	r0, [r2, #8]
	ldr	r2, [r2, #12]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
L46
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L47
	; Handle array index out of bounds exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
	LTORG

	ENDP
	; End segment: unnamed


	; faload is a duplicate of iaload
	; daload is a duplicate of laload
	; aaload is a duplicate of iaload
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_baload
bc_impl_baload

	EXPORT	bc_impl_baload_internal
bc_impl_baload_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, #0
	ldrne	r3, [r2, #4]
	beq	L48
	cmp	r0, r3
	bcs	L49
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	add	r2, r2, r0               ; load array element
	ldrsb	r0, [r2, #8]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L48
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L49
	; Handle array index out of bounds exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_caload
bc_impl_caload

	EXPORT	bc_impl_caload_internal
bc_impl_caload_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, #0
	ldrne	r3, [r2, #4]
	beq	L50
	cmp	r0, r3
	bcs	L51
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	add	r2, r2, r0, lsl #1       ; load array element
	ldrh	r0, [r2, #8]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L50
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L51
	; Handle array index out of bounds exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_saload
bc_impl_saload

	EXPORT	bc_impl_saload_internal
bc_impl_saload_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, #0
	ldrne	r3, [r2, #4]
	beq	L52
	cmp	r0, r3
	bcs	L53
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	add	r2, r2, r0, lsl #1       ; load array element
	ldrsh	r0, [r2, #8]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L52
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L53
	; Handle array index out of bounds exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_wide_istore
bc_impl_wide_istore

	EXPORT	bc_impl_wide_fstore
bc_impl_wide_fstore PROC

	ENDP

	EXPORT	bc_impl_wide_astore
bc_impl_wide_astore PROC

	ENDP

	EXPORT	bc_impl_wide_istore_internal
bc_impl_wide_istore_internal PROC

	ENDP

	EXPORT	bc_impl_wide_fstore_internal
bc_impl_wide_fstore_internal PROC

	ENDP

	EXPORT	bc_impl_wide_astore_internal
bc_impl_wide_astore_internal PROC
	; Entry: Count = 1
	; load unsigned 16bit word at bcp + 2
	ldrb	r9, [lr, #2]
	ldrb	r4, [lr, #3]
	ldrb	r12, [lr, #4]!           ; prefetch next bytecode
	orr	r9, r4, r9, lsl #8
	str	r0, [r7, -r9, lsl #2]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	; Data containing entry for wide bytecode
	DCD	bc_impl_wide_astore

	EXPORT	bc_impl_istore
bc_impl_istore

	ENDP

	EXPORT	bc_impl_fstore
bc_impl_fstore PROC

	ENDP

	EXPORT	bc_impl_astore
bc_impl_astore PROC

	ENDP

	EXPORT	bc_impl_istore_internal
bc_impl_istore_internal PROC

	ENDP

	EXPORT	bc_impl_fstore_internal
bc_impl_fstore_internal PROC

	ENDP

	EXPORT	bc_impl_astore_internal
bc_impl_astore_internal PROC
	; Entry: Count = 1
	; load unsigned byte at bcp + 1
	ldrb	r9, [lr, #1]
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	str	r0, [r7, -r9, lsl #2]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_wide_lstore
bc_impl_wide_lstore

	EXPORT	bc_impl_wide_dstore
bc_impl_wide_dstore PROC

	ENDP

	EXPORT	bc_impl_wide_lstore_internal
bc_impl_wide_lstore_internal PROC

	ENDP

	EXPORT	bc_impl_wide_dstore_internal
bc_impl_wide_dstore_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	; load unsigned 16bit word at bcp + 2
	ldrb	r9, [lr, #2]
	ldrb	r4, [lr, #3]
	ldrb	r12, [lr, #4]!           ; prefetch next bytecode
	orr	r9, r4, r9, lsl #8
	sub	r4, r7, r9, lsl #2       ; address of local #r9
	str	r0, [r4, #-4]
	str	r2, [r4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	; Data containing entry for wide bytecode
	DCD	bc_impl_wide_dstore

	EXPORT	bc_impl_lstore
bc_impl_lstore

	ENDP

	EXPORT	bc_impl_dstore
bc_impl_dstore PROC

	ENDP

	EXPORT	bc_impl_lstore_internal
bc_impl_lstore_internal PROC

	ENDP

	EXPORT	bc_impl_dstore_internal
bc_impl_dstore_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	; load unsigned byte at bcp + 1
	ldrb	r9, [lr, #1]
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	sub	r4, r7, r9, lsl #2       ; address of local #r9
	str	r0, [r4, #-4]
	str	r2, [r4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; fstore is a duplicate of istore
	; dstore is a duplicate of lstore
	; astore is a duplicate of istore
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_istore_0
bc_impl_istore_0

	EXPORT	bc_impl_fstore_0
bc_impl_fstore_0 PROC

	ENDP

	EXPORT	bc_impl_astore_0
bc_impl_astore_0 PROC

	ENDP

	EXPORT	bc_impl_istore_0_internal
bc_impl_istore_0_internal PROC

	ENDP

	EXPORT	bc_impl_fstore_0_internal
bc_impl_fstore_0_internal PROC

	ENDP

	EXPORT	bc_impl_astore_0_internal
bc_impl_astore_0_internal PROC
	; Entry: Count = 1
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	str	r0, [r7]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_istore_1
bc_impl_istore_1

	EXPORT	bc_impl_fstore_1
bc_impl_fstore_1 PROC

	ENDP

	EXPORT	bc_impl_astore_1
bc_impl_astore_1 PROC

	ENDP

	EXPORT	bc_impl_istore_1_internal
bc_impl_istore_1_internal PROC

	ENDP

	EXPORT	bc_impl_fstore_1_internal
bc_impl_fstore_1_internal PROC

	ENDP

	EXPORT	bc_impl_astore_1_internal
bc_impl_astore_1_internal PROC
	; Entry: Count = 1
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	str	r0, [r7, #-4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_istore_2
bc_impl_istore_2

	EXPORT	bc_impl_fstore_2
bc_impl_fstore_2 PROC

	ENDP

	EXPORT	bc_impl_astore_2
bc_impl_astore_2 PROC

	ENDP

	EXPORT	bc_impl_istore_2_internal
bc_impl_istore_2_internal PROC

	ENDP

	EXPORT	bc_impl_fstore_2_internal
bc_impl_fstore_2_internal PROC

	ENDP

	EXPORT	bc_impl_astore_2_internal
bc_impl_astore_2_internal PROC
	; Entry: Count = 1
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	str	r0, [r7, #-8]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_istore_3
bc_impl_istore_3

	EXPORT	bc_impl_fstore_3
bc_impl_fstore_3 PROC

	ENDP

	EXPORT	bc_impl_astore_3
bc_impl_astore_3 PROC

	ENDP

	EXPORT	bc_impl_istore_3_internal
bc_impl_istore_3_internal PROC

	ENDP

	EXPORT	bc_impl_fstore_3_internal
bc_impl_fstore_3_internal PROC

	ENDP

	EXPORT	bc_impl_astore_3_internal
bc_impl_astore_3_internal PROC
	; Entry: Count = 1
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	str	r0, [r7, #-12]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lstore_0
bc_impl_lstore_0

	EXPORT	bc_impl_dstore_0
bc_impl_dstore_0 PROC

	ENDP

	EXPORT	bc_impl_lstore_0_internal
bc_impl_lstore_0_internal PROC

	ENDP

	EXPORT	bc_impl_dstore_0_internal
bc_impl_dstore_0_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	str	r0, [r7, #-4]
	str	r2, [r7]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lstore_1
bc_impl_lstore_1

	EXPORT	bc_impl_dstore_1
bc_impl_dstore_1 PROC

	ENDP

	EXPORT	bc_impl_lstore_1_internal
bc_impl_lstore_1_internal PROC

	ENDP

	EXPORT	bc_impl_dstore_1_internal
bc_impl_dstore_1_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	str	r0, [r7, #-8]
	str	r2, [r7, #-4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lstore_2
bc_impl_lstore_2

	EXPORT	bc_impl_dstore_2
bc_impl_dstore_2 PROC

	ENDP

	EXPORT	bc_impl_lstore_2_internal
bc_impl_lstore_2_internal PROC

	ENDP

	EXPORT	bc_impl_dstore_2_internal
bc_impl_dstore_2_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	str	r0, [r7, #-12]
	str	r2, [r7, #-8]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lstore_3
bc_impl_lstore_3

	EXPORT	bc_impl_dstore_3
bc_impl_dstore_3 PROC

	ENDP

	EXPORT	bc_impl_lstore_3_internal
bc_impl_lstore_3_internal PROC

	ENDP

	EXPORT	bc_impl_dstore_3_internal
bc_impl_dstore_3_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	str	r0, [r7, #-16]
	str	r2, [r7, #-12]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


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
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iastore
bc_impl_iastore

	EXPORT	bc_impl_fastore
bc_impl_fastore PROC

	ENDP

	EXPORT	bc_impl_iastore_internal
bc_impl_iastore_internal PROC

	ENDP

	EXPORT	bc_impl_fastore_internal
bc_impl_fastore_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	cmp	r4, #0
	ldrne	r3, [r4, #4]
	beq	L54
	cmp	r2, r3
	bcs	L55
L57
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store array element
	add	r4, r4, r2, lsl #2
	str	r0, [r4, #8]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L54
	; Handle null pointer exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L55
	; Handle array index out of bounds exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
L56
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lastore
bc_impl_lastore

	EXPORT	bc_impl_dastore
bc_impl_dastore PROC

	ENDP

	EXPORT	bc_impl_lastore_internal
bc_impl_lastore_internal PROC

	ENDP

	EXPORT	bc_impl_dastore_internal
bc_impl_dastore_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	cmp	r10, #0
	ldrne	r3, [r10, #4]
	beq	L58
	cmp	r4, r3
	bcs	L59
L61
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store array element
	add	r10, r10, r4, lsl #3
	str	r0, [r10, #8]
	str	r2, [r10, #12]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L58
	; Handle null pointer exception
	str	r10, [r6, #-4]!
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L59
	; Handle array index out of bounds exception
	str	r10, [r6, #-4]!
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
L60
	LTORG

	ENDP
	; End segment: unnamed


	; fastore is a duplicate of iastore
	; dastore is a duplicate of lastore
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_aastore
bc_impl_aastore

	EXPORT	bc_impl_aastore_internal
bc_impl_aastore_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	cmp	r4, #0
	ldrne	r3, [r4, #4]
	beq	L62
	cmp	r2, r3
	bcs	L63
	cmp	r0, #0
	beq	L65
	ldr	r10, [r4]                ; array near
	ldr	r12, [r0]                ; object near
	ldr	r10, [r10]               ; array klass
	ldr	r12, [r12]               ; object klass
	ldr	r10, [r10, #36]          ; array element type
	ldr	r1, [r12, #20]           ; subtype cache 1
	ldr	r12, [r12, #24]          ; subtype cache 2
	cmp	r10, r1
	cmpne	r10, r12
	bne	L64
L65
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store array element
	add	r4, r4, r2, lsl #2
	str	r0, [r4, #8]!
	; oop_write_barrier
	ldr	r2, [r5, #1076]          ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r9, [r2, +r4, lsr #5]!
	mvn	r4, r4, lsr #2
	orr	r9, r9, r3, ror r4
	strb	r9, [r2]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L62
	; Handle null pointer exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L63
	; Handle array index out of bounds exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
L64
	; Handle slow type checking
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	array_store_type_check
	ldr	r3, =array_store_type_check
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	b	L65
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_bastore
bc_impl_bastore

	EXPORT	bc_impl_bastore_internal
bc_impl_bastore_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	cmp	r4, #0
	ldrne	r3, [r4, #4]
	beq	L66
	cmp	r2, r3
	bcs	L67
L69
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store array element
	add	r4, r4, r2
	strb	r0, [r4, #8]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L66
	; Handle null pointer exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L67
	; Handle array index out of bounds exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
L68
	LTORG

	ENDP
	; End segment: unnamed


	; castore is a duplicate of sastore
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_sastore
bc_impl_sastore

	EXPORT	bc_impl_castore
bc_impl_castore PROC

	ENDP

	EXPORT	bc_impl_sastore_internal
bc_impl_sastore_internal PROC

	ENDP

	EXPORT	bc_impl_castore_internal
bc_impl_castore_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	cmp	r4, #0
	ldrne	r3, [r4, #4]
	beq	L70
	cmp	r2, r3
	bcs	L71
L73
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store array element
	add	r4, r4, r2, lsl #1
	strh	r0, [r4, #8]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L70
	; Handle null pointer exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
L71
	; Handle array index out of bounds exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_ArrayIndexOutOfBoundsException
L72
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_pop
bc_impl_pop

	EXPORT	bc_impl_pop_internal
bc_impl_pop_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = -1
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_pop2
bc_impl_pop2

	EXPORT	bc_impl_pop2_internal
bc_impl_pop2_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = -2
	add	r6, r6, #4
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dup
bc_impl_dup

	EXPORT	bc_impl_dup_internal
bc_impl_dup_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 1
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r0, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dup_x1
bc_impl_dup_x1

	EXPORT	bc_impl_dup_x1_internal
bc_impl_dup_x1_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	; dup_x1 (...ba => ...aba)
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r0, [r6, #-4]!
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dup_x2
bc_impl_dup_x2

	EXPORT	bc_impl_dup_x2_internal
bc_impl_dup_x2_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	; dup_x2 (...cba => ...acba
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r0, [r6, #-4]!
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dup2
bc_impl_dup2

	EXPORT	bc_impl_dup2_internal
bc_impl_dup2_internal PROC
	; Entry: Count = 1
	ldr	r2, [r6]                 ; Grab second element without popping it
	; dup2 (...ba => ...baba
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r0, [r6, #-4]!
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dup2_x1
bc_impl_dup2_x1

	EXPORT	bc_impl_dup2_x1_internal
bc_impl_dup2_x1_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	; dup2_x1 (...cba => ...bacba)
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	str	r0, [r6, #-4]!
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dup2_x2
bc_impl_dup2_x2

	EXPORT	bc_impl_dup2_x2_internal
bc_impl_dup2_x2_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	; dup_x2 (...dcba => ...badcba)
	str	r2, [r6, #-4]!
	str	r0, [r6, #-4]!
	str	r10, [r6, #-4]!
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_swap
bc_impl_swap

	EXPORT	bc_impl_swap_internal
bc_impl_swap_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 2
	ldr	r2, [r6], #4
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r0, [r6, #-4]!
	mov	r0, r2
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iadd
bc_impl_iadd

	EXPORT	bc_impl_iadd_internal
bc_impl_iadd_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	add	r0, r2, r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ladd
bc_impl_ladd

	EXPORT	bc_impl_ladd_internal
bc_impl_ladd_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	adds	r0, r4, r0
	adc	r2, r10, r2
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fadd
bc_impl_fadd

	EXPORT	bc_impl_fadd_internal
bc_impl_fadd_internal PROC
	; load one argument
	; load other argument
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_fadd
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dadd
bc_impl_dadd

	EXPORT	bc_impl_dadd_internal
bc_impl_dadd_internal PROC
	; load one argument
	ldr	r1, [r6], #4
	; load other argument
	ldr	r2, [r6], #4
	ldr	r3, [r6], #4
	mov	r9, lr
	bl	jvm_dadd
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_isub
bc_impl_isub

	EXPORT	bc_impl_isub_internal
bc_impl_isub_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	sub	r0, r2, r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lsub
bc_impl_lsub

	EXPORT	bc_impl_lsub_internal
bc_impl_lsub_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	subs	r0, r4, r0
	sbc	r2, r10, r2
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fsub
bc_impl_fsub

	EXPORT	bc_impl_fsub_internal
bc_impl_fsub_internal PROC
	; load one argument
	mov	r1, r0
	; load other argument
	ldr	r0, [r6], #4
	mov	r9, lr
	bl	jvm_fsub
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dsub
bc_impl_dsub

	EXPORT	bc_impl_dsub_internal
bc_impl_dsub_internal PROC
	; load one argument
	mov	r2, r0
	ldr	r3, [r6], #4
	; load other argument
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_dsub
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_imul
bc_impl_imul

	EXPORT	bc_impl_imul_internal
bc_impl_imul_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	mul	r0, r2, r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lmul
bc_impl_lmul

	EXPORT	bc_impl_lmul_internal
bc_impl_lmul_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	umull	r3, r9, r0, r4
	mla	r9, r0, r10, r9
	mla	r9, r2, r4, r9
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r9, [r6, #-4]!
	mov	r0, r3
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fmul
bc_impl_fmul

	EXPORT	bc_impl_fmul_internal
bc_impl_fmul_internal PROC
	; load one argument
	; load other argument
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_fmul
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dmul
bc_impl_dmul

	EXPORT	bc_impl_dmul_internal
bc_impl_dmul_internal PROC
	; load one argument
	ldr	r1, [r6], #4
	; load other argument
	ldr	r2, [r6], #4
	ldr	r3, [r6], #4
	mov	r9, lr
	bl	jvm_dmul
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_idiv
bc_impl_idiv

	EXPORT	bc_impl_idiv_internal
bc_impl_idiv_internal PROC
	mov	r4, lr
	bl	interpreter_idiv_irem

	EXPORT	called_from_bc_idiv
called_from_bc_idiv
	mov	lr, r4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	mov	r0, r1
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ldiv
bc_impl_ldiv

	EXPORT	bc_impl_ldiv_internal
bc_impl_ldiv_internal PROC
	; load one argument
	mov	r2, r0
	ldr	r3, [r6], #4
	; load other argument
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	orrs	r4, r2, r3
	beq	long_divide_by_zero
	mov	r9, lr
	bl	jvm_ldiv
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]

	EXPORT	long_divide_by_zero
long_divide_by_zero
	str	r1, [r6, #-4]!
	str	r0, [r6, #-4]!
	str	r3, [r6, #-4]!
	mov	r0, r2
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	division_by_zero_exception
	ldr	r3, =division_by_zero_exception
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fdiv
bc_impl_fdiv

	EXPORT	bc_impl_fdiv_internal
bc_impl_fdiv_internal PROC
	; load one argument
	mov	r1, r0
	; load other argument
	ldr	r0, [r6], #4
	mov	r9, lr
	bl	jvm_fdiv
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ddiv
bc_impl_ddiv

	EXPORT	bc_impl_ddiv_internal
bc_impl_ddiv_internal PROC
	; load one argument
	mov	r2, r0
	ldr	r3, [r6], #4
	; load other argument
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_ddiv
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_irem
bc_impl_irem

	EXPORT	bc_impl_irem_internal
bc_impl_irem_internal PROC
	mov	r4, lr
	bl	interpreter_idiv_irem

	EXPORT	called_from_bc_irem
called_from_bc_irem
	mov	lr, r4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lrem
bc_impl_lrem

	EXPORT	bc_impl_lrem_internal
bc_impl_lrem_internal PROC
	; load one argument
	mov	r2, r0
	ldr	r3, [r6], #4
	; load other argument
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	orrs	r4, r2, r3
	beq	long_divide_by_zero
	mov	r9, lr
	bl	jvm_lrem
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_frem
bc_impl_frem

	EXPORT	bc_impl_frem_internal
bc_impl_frem_internal PROC
	; load one argument
	mov	r1, r0
	; load other argument
	ldr	r0, [r6], #4
	mov	r9, lr
	bl	jvm_frem
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_drem
bc_impl_drem

	EXPORT	bc_impl_drem_internal
bc_impl_drem_internal PROC
	; load one argument
	mov	r2, r0
	ldr	r3, [r6], #4
	; load other argument
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_drem
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ineg
bc_impl_ineg

	EXPORT	bc_impl_ineg_internal
bc_impl_ineg_internal PROC
	; Entry: Count = 1
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	rsb	r0, r0, #0               ; negate
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lneg
bc_impl_lneg

	EXPORT	bc_impl_lneg_internal
bc_impl_lneg_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	rsbs	r0, r0, #0               ; negate
	rsc	r2, r2, #0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fneg
bc_impl_fneg

	EXPORT	bc_impl_fneg_internal
bc_impl_fneg_internal PROC
	; Entry: Count = 1
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	eor	r0, r0, #0x80000000      ; flip sign bit
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dneg
bc_impl_dneg

	EXPORT	bc_impl_dneg_internal
bc_impl_dneg_internal PROC
	ldr	r2, [r6]                 ; get word containing sign bit
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	eor	r2, r2, #0x80000000      ; flip sign bit
	str	r2, [r6]                 ; and put it back
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ishl
bc_impl_ishl

	EXPORT	bc_impl_ishl_internal
bc_impl_ishl_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	and	r0, r0, #31
	mov	r0, r2, lsl r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lshl
bc_impl_lshl

	EXPORT	bc_impl_lshl_internal
bc_impl_lshl_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	; Normalize shift amount
	ands	r0, r0, #63
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	moveq	r9, r4
	moveq	r3, r2
	beq	L74
	; Get long argument from the stack
	; Calculate 32-shift
	rsbs	r1, r0, #32
	; condition code le means that shift is >= 32
	suble	r0, r0, #32
	movle	r9, r2, lsl r0
	movle	r3, #0
	; condition code gt means that shift is < 32
	movgt	r9, r4, lsl r0
	orrgt	r9, r9, r2, lsr r1
	movgt	r3, r2, lsl r0
L74
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r9, [r6, #-4]!
	mov	r0, r3
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ishr
bc_impl_ishr

	EXPORT	bc_impl_ishr_internal
bc_impl_ishr_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	and	r0, r0, #31
	mov	r0, r2, asr r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lshr
bc_impl_lshr

	EXPORT	bc_impl_lshr_internal
bc_impl_lshr_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	; Normalize shift amount
	ands	r0, r0, #63
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	moveq	r9, r4
	moveq	r3, r2
	beq	L75
	; Calculate 32-shift
	rsbs	r1, r0, #32
	; condition code le means that shift is >= 32
	suble	r0, r0, #32
	movle	r3, r4, asr r0
	movle	r9, r4, asr #31
	; condition code gt means that shift is < 32
	movgt	r3, r2, lsr r0
	orrgt	r3, r3, r4, lsl r1
	movgt	r9, r4, asr r0
L75
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r9, [r6, #-4]!
	mov	r0, r3
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iushr
bc_impl_iushr

	EXPORT	bc_impl_iushr_internal
bc_impl_iushr_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	and	r0, r0, #31
	mov	r0, r2, lsr r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lushr
bc_impl_lushr

	EXPORT	bc_impl_lushr_internal
bc_impl_lushr_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	; Normalize shift amount
	ands	r0, r0, #63
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	moveq	r9, r4
	moveq	r3, r2
	beq	L76
	; Calculate 32-shift
	rsbs	r1, r0, #32
	; condition code le means that shift is >= 32
	suble	r0, r0, #32
	movle	r3, r4, lsr r0
	movle	r9, #0
	; condition code gt means that shift is < 32
	movgt	r3, r2, lsr r0
	orrgt	r3, r3, r4, lsl r1
	movgt	r9, r4, lsr r0
L76
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r9, [r6, #-4]!
	mov	r0, r3
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iand
bc_impl_iand

	EXPORT	bc_impl_iand_internal
bc_impl_iand_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	and	r0, r2, r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_land
bc_impl_land

	EXPORT	bc_impl_land_internal
bc_impl_land_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	and	r0, r4, r0
	and	r2, r10, r2
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ior
bc_impl_ior

	EXPORT	bc_impl_ior_internal
bc_impl_ior_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	orr	r0, r2, r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lor
bc_impl_lor

	EXPORT	bc_impl_lor_internal
bc_impl_lor_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	orr	r0, r4, r0
	orr	r2, r10, r2
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ixor
bc_impl_ixor

	EXPORT	bc_impl_ixor_internal
bc_impl_ixor_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	eor	r0, r2, r0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lxor
bc_impl_lxor

	EXPORT	bc_impl_lxor_internal
bc_impl_lxor_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	eor	r0, r4, r0
	eor	r2, r10, r2
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_wide_iinc
bc_impl_wide_iinc

	EXPORT	bc_impl_wide_iinc_internal
bc_impl_wide_iinc_internal PROC
	ldrb	r2, [lr, #2]
	ldrb	r3, [lr, #3]
	ldrsb	r4, [lr, #4]
	ldrb	r9, [lr, #5]
	add	r2, r3, r2, lsl #8       ; register index
	ldr	r3, [r7, -r2, lsl #2]    ; get local
	ldrb	r12, [lr, #6]!           ; prefetch next bytecode
	add	r3, r3, r4, lsl #8       ; increment local
	add	r3, r3, r9
	str	r3, [r7, -r2, lsl #2]    ; store local
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	; Data containing entry for wide bytecode
	DCD	bc_impl_wide_iinc

	EXPORT	bc_impl_iinc
bc_impl_iinc

	ENDP

	EXPORT	bc_impl_iinc_internal
bc_impl_iinc_internal PROC
	ldrb	r2, [lr, #1]             ; register index
	ldrsb	r4, [lr, #2]             ; increment
	ldr	r3, [r7, -r2, lsl #2]    ; get local
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	add	r3, r3, r4               ; increment local
	str	r3, [r7, -r2, lsl #2]    ; store local
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2l
bc_impl_i2l

	EXPORT	bc_impl_i2l_internal
bc_impl_i2l_internal PROC
	; Entry: Count = 1
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	mov	r4, r0, asr #31
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r4, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2f
bc_impl_i2f

	EXPORT	bc_impl_i2f_internal
bc_impl_i2f_internal PROC
	; load one argument
	mov	r9, lr
	bl	jvm_i2f
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2d
bc_impl_i2d

	EXPORT	bc_impl_i2d_internal
bc_impl_i2d_internal PROC
	; load one argument
	mov	r9, lr
	bl	jvm_i2d
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_l2i
bc_impl_l2i

	EXPORT	bc_impl_l2i_internal
bc_impl_l2i_internal PROC
	; Entry: Count = 1
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	add	r6, r6, #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_l2f
bc_impl_l2f

	EXPORT	bc_impl_l2f_internal
bc_impl_l2f_internal PROC
	; load one argument
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_l2f
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_l2d
bc_impl_l2d

	EXPORT	bc_impl_l2d_internal
bc_impl_l2d_internal PROC
	; load one argument
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_l2d
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_f2i
bc_impl_f2i

	EXPORT	bc_impl_f2i_internal
bc_impl_f2i_internal PROC
	; load one argument
	mov	r9, lr
	bl	jvm_f2i
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_f2l
bc_impl_f2l

	EXPORT	bc_impl_f2l_internal
bc_impl_f2l_internal PROC
	; load one argument
	mov	r9, lr
	bl	jvm_f2l
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_f2d
bc_impl_f2d

	EXPORT	bc_impl_f2d_internal
bc_impl_f2d_internal PROC
	; load one argument
	mov	r9, lr
	bl	jvm_f2d
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_d2i
bc_impl_d2i

	EXPORT	bc_impl_d2i_internal
bc_impl_d2i_internal PROC
	; load one argument
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_d2i
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_d2l
bc_impl_d2l

	EXPORT	bc_impl_d2l_internal
bc_impl_d2l_internal PROC
	; load one argument
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_d2l
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_d2f
bc_impl_d2f

	EXPORT	bc_impl_d2f_internal
bc_impl_d2f_internal PROC
	; load one argument
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_d2f
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2b
bc_impl_i2b

	EXPORT	bc_impl_i2b_internal
bc_impl_i2b_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 1
	mov	r0, r0, lsl #24
	mov	r0, r0, asr #24
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2c
bc_impl_i2c

	EXPORT	bc_impl_i2c_internal
bc_impl_i2c_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 1
	mov	r0, r0, lsl #16
	mov	r0, r0, lsr #16
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2s
bc_impl_i2s

	EXPORT	bc_impl_i2s_internal
bc_impl_i2s_internal PROC
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; Entry: Count = 1
	mov	r0, r0, lsl #16
	mov	r0, r0, asr #16
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lcmp
bc_impl_lcmp

	EXPORT	bc_impl_lcmp_internal
bc_impl_lcmp_internal PROC
	; Entry: Count = 4
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r10, [r6], #4
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	subs	r4, r4, r0               ; subtract arguments
	sbcs	r10, r10, r2
	mvnlt	r0, #0                   ; handle *only* for < and >=
	movge	r0, #1
	orrs	r4, r4, r10              ; correction for ==
	moveq	r0, #0
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fcmpl
bc_impl_fcmpl

	EXPORT	bc_impl_fcmpl_internal
bc_impl_fcmpl_internal PROC
	; load one argument
	mov	r1, r0
	; load other argument
	ldr	r0, [r6], #4
	mov	r9, lr
	bl	jvm_fcmpl
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fcmpg
bc_impl_fcmpg

	EXPORT	bc_impl_fcmpg_internal
bc_impl_fcmpg_internal PROC
	; load one argument
	mov	r1, r0
	; load other argument
	ldr	r0, [r6], #4
	mov	r9, lr
	bl	jvm_fcmpg
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dcmpl
bc_impl_dcmpl

	EXPORT	bc_impl_dcmpl_internal
bc_impl_dcmpl_internal PROC
	; load one argument
	mov	r2, r0
	ldr	r3, [r6], #4
	; load other argument
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_dcmpl
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dcmpg
bc_impl_dcmpg

	EXPORT	bc_impl_dcmpg_internal
bc_impl_dcmpg_internal PROC
	; load one argument
	mov	r2, r0
	ldr	r3, [r6], #4
	; load other argument
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r9, lr
	bl	jvm_dcmpg
	mov	lr, r9
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; store result
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ifeq
bc_impl_ifeq

	EXPORT	bc_impl_ifnull
bc_impl_ifnull PROC

	ENDP

	EXPORT	bc_impl_ifeq_internal
bc_impl_ifeq_internal PROC

	ENDP

	EXPORT	bc_impl_ifnull_internal
bc_impl_ifnull_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 1
	cmp	r0, #0
	bne	L77
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L77
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ifne
bc_impl_ifne

	EXPORT	bc_impl_ifnonnull
bc_impl_ifnonnull PROC

	ENDP

	EXPORT	bc_impl_ifne_internal
bc_impl_ifne_internal PROC

	ENDP

	EXPORT	bc_impl_ifnonnull_internal
bc_impl_ifnonnull_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 1
	cmp	r0, #0
	beq	L78
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L78
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iflt
bc_impl_iflt

	EXPORT	bc_impl_iflt_internal
bc_impl_iflt_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 1
	cmp	r0, #0
	bge	L79
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L79
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ifge
bc_impl_ifge

	EXPORT	bc_impl_ifge_internal
bc_impl_ifge_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 1
	cmp	r0, #0
	blt	L80
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L80
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ifgt
bc_impl_ifgt

	EXPORT	bc_impl_ifgt_internal
bc_impl_ifgt_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 1
	cmp	r0, #0
	ble	L81
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L81
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ifle
bc_impl_ifle

	EXPORT	bc_impl_ifle_internal
bc_impl_ifle_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 1
	cmp	r0, #0
	bgt	L82
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L82
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmpeq
bc_impl_if_icmpeq

	EXPORT	bc_impl_if_acmpeq
bc_impl_if_acmpeq PROC

	ENDP

	EXPORT	bc_impl_if_icmpeq_internal
bc_impl_if_icmpeq_internal PROC

	ENDP

	EXPORT	bc_impl_if_acmpeq_internal
bc_impl_if_acmpeq_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, r0
	bne	L83
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L83
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmpne
bc_impl_if_icmpne

	EXPORT	bc_impl_if_acmpne
bc_impl_if_acmpne PROC

	ENDP

	EXPORT	bc_impl_if_icmpne_internal
bc_impl_if_icmpne_internal PROC

	ENDP

	EXPORT	bc_impl_if_acmpne_internal
bc_impl_if_acmpne_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, r0
	beq	L84
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L84
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmplt
bc_impl_if_icmplt

	EXPORT	bc_impl_if_icmplt_internal
bc_impl_if_icmplt_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, r0
	bge	L85
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L85
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmpge
bc_impl_if_icmpge

	EXPORT	bc_impl_if_icmpge_internal
bc_impl_if_icmpge_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, r0
	blt	L86
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L86
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmpgt
bc_impl_if_icmpgt

	EXPORT	bc_impl_if_icmpgt_internal
bc_impl_if_icmpgt_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, r0
	ble	L87
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L87
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmple
bc_impl_if_icmple

	EXPORT	bc_impl_if_icmple_internal
bc_impl_if_icmple_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 2
	ldr	r2, [r6], #4
	cmp	r2, r0
	bgt	L88
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L88
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; if_acmpeq is a duplicate of if_icmpeq
	; if_acmpne is a duplicate of if_icmpne
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_goto
bc_impl_goto

	EXPORT	bc_impl_goto_internal
bc_impl_goto_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrsb	r3, [lr, #1]
	ldrb	r2, [lr, #2]
	add	lr, lr, r3, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_tableswitch
bc_impl_tableswitch

	EXPORT	bc_impl_tableswitch_internal
bc_impl_tableswitch_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 1
	; Have tos_tag point to lower limit
	add	r1, lr, #8
	bic	r1, r1, #3
	; tmp2 gets the lower limit
	; tmp3 gets the upper limit
	; tos_tag is updated to point to the start of the offsets
	ldmia	r1!, {r4, r9}
	cmp	r9, r0
	subges	r0, r0, r4
	; Offset of branch target (swapped?) if value is in the table
	ldrge	r3, [r1, +r0, lsl #2]
	; Offset of branch target (swapped?) if value is outside of table
	ldrlt	r3, [r1, #-12]
	ldrb	r12, [lr, +r3]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lookupswitch
bc_impl_lookupswitch

	EXPORT	bc_impl_lookupswitch_internal
bc_impl_lookupswitch_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 1
	; compute aligned table ptr
	bic	r2, lr, #3
	; get number of table entries + 1
	ldr	r3, [r2, #8]
	add	r3, r3, #1
	; set table ptr to default entry
	add	r2, r2, #4
	; search the table
L89
	ldr	r4, [r2, #8]!
	subs	r3, r3, #1
	cmpne	r0, r4
	bne	L89
	; reset table ptr if not found
	cmp	r3, #0
	biceq	r2, lr, #3
	; get table entry or default offset
	ldr	r3, [r2, #4]
	; get bytecode at destination
	ldrb	r12, [lr, +r3]!
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ireturn
bc_impl_ireturn

	EXPORT	bc_impl_freturn
bc_impl_freturn PROC

	ENDP

	EXPORT	bc_impl_areturn
bc_impl_areturn PROC

	ENDP

	EXPORT	bc_impl_ireturn_internal
bc_impl_ireturn_internal PROC

	ENDP

	EXPORT	bc_impl_freturn_internal
bc_impl_freturn_internal PROC

	ENDP

	EXPORT	bc_impl_areturn_internal
bc_impl_areturn_internal PROC
	; unlock_activation
	; See if there are any locks on this frame
	ldr	r2, [fp, #4]             ; address of stack bottom pointer
	ldr	r4, [fp, #-4]            ; current method
	sub	r3, fp, #20              ; address of stack bottom pointer if no locks
	cmp	r2, r3
	beq	L90
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; save interpreter state
	str	lr, [fp, #-16]
	; Is this a synchronized method?
	ldrh	r4, [r4, #24]            ; access flags
	tst	r4, #32                  ; ACC_SYNCHRONIZED
	beq	L92
	bl	shared_unlock_synchronized_method
	ldr	r2, [fp, #4]
	b	L92
L91
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	bl	interpreter_call_vm
L92
	; Check that all stack locks have been unlocked.
	ldr	r3, [r2, #24]!
	sub	r4, fp, #24
L93
	cmp	r3, #0
	bne	L91
	cmp	r2, r4
	ldrne	r3, [r2, #28]!
	bne	L93
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldr	r7, [fp, #-12]
L90
	; load one argument
	ldr	lr, [fp, #-20]
	ldr	fp, [fp]
	add	r6, r7, #4
	mov	r2, #1
	bx	lr
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lreturn
bc_impl_lreturn

	EXPORT	bc_impl_dreturn
bc_impl_dreturn PROC

	ENDP

	EXPORT	bc_impl_lreturn_internal
bc_impl_lreturn_internal PROC

	ENDP

	EXPORT	bc_impl_dreturn_internal
bc_impl_dreturn_internal PROC
	; unlock_activation
	; See if there are any locks on this frame
	ldr	r2, [fp, #4]             ; address of stack bottom pointer
	ldr	r4, [fp, #-4]            ; current method
	sub	r3, fp, #20              ; address of stack bottom pointer if no locks
	cmp	r2, r3
	beq	L94
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; save interpreter state
	str	lr, [fp, #-16]
	; Is this a synchronized method?
	ldrh	r4, [r4, #24]            ; access flags
	tst	r4, #32                  ; ACC_SYNCHRONIZED
	beq	L96
	bl	shared_unlock_synchronized_method
	ldr	r2, [fp, #4]
	b	L96
L95
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	bl	interpreter_call_vm
L96
	; Check that all stack locks have been unlocked.
	ldr	r3, [r2, #24]!
	sub	r4, fp, #24
L97
	cmp	r3, #0
	bne	L95
	cmp	r2, r4
	ldrne	r3, [r2, #28]!
	bne	L97
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldr	r7, [fp, #-12]
L94
	; load one argument
	ldr	r1, [r6], #4
	ldr	lr, [fp, #-20]
	ldr	fp, [fp]
	add	r6, r7, #4
	mov	r2, #2
	bx	lr
	LTORG

	ENDP
	; End segment: unnamed


	; freturn is a duplicate of ireturn
	; dreturn is a duplicate of lreturn
	; areturn is a duplicate of ireturn
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_return
bc_impl_return

	EXPORT	bc_impl_return_internal
bc_impl_return_internal PROC
	; unlock_activation
	; See if there are any locks on this frame
	ldr	r2, [fp, #4]             ; address of stack bottom pointer
	ldr	r4, [fp, #-4]            ; current method
	sub	r3, fp, #20              ; address of stack bottom pointer if no locks
	cmp	r2, r3
	beq	L98
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; save interpreter state
	str	lr, [fp, #-16]
	; Is this a synchronized method?
	ldrh	r4, [r4, #24]            ; access flags
	tst	r4, #32                  ; ACC_SYNCHRONIZED
	beq	L100
	bl	shared_unlock_synchronized_method
	ldr	r2, [fp, #4]
	b	L100
L99
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	bl	interpreter_call_vm
L100
	; Check that all stack locks have been unlocked.
	ldr	r3, [r2, #24]!
	sub	r4, fp, #24
L101
	cmp	r3, #0
	bne	L99
	cmp	r2, r4
	ldrne	r3, [r2, #28]!
	bne	L101
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	ldr	r7, [fp, #-12]
L98
	ldr	lr, [fp, #-20]
	ldr	fp, [fp]
	add	r6, r7, #4
	mov	r2, #0
	bx	lr
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_getstatic
bc_impl_getstatic

	EXPORT	bc_impl_getstatic_internal
bc_impl_getstatic_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	getstatic
	ldr	r3, =getstatic
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldr	r12, [r5, +r0, lsl #2]
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	bx	r12
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_putstatic
bc_impl_putstatic

	EXPORT	bc_impl_putstatic_internal
bc_impl_putstatic_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	putstatic
	ldr	r3, =putstatic
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldr	r12, [r5, +r0, lsl #2]
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	bx	r12
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_getfield
bc_impl_getfield

	EXPORT	bc_impl_getfield_internal
bc_impl_getfield_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	getfield
	ldr	r3, =getfield
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr]                ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_putfield
bc_impl_putfield

	EXPORT	bc_impl_putfield_internal
bc_impl_putfield_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	putfield
	ldr	r3, =putfield
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr]                ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; invokevirtual is a duplicate of ldc
	; invokespecial is a duplicate of ldc
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_invokestatic
bc_impl_invokestatic

	EXPORT	bc_impl_invokestatic_internal
bc_impl_invokestatic_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	quicken_invokestatic
	ldr	r3, =quicken_invokestatic
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldr	r12, [r5, +r0, lsl #2]
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	bx	r12
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_invokeinterface
bc_impl_invokeinterface

	EXPORT	bc_impl_invokeinterface_internal
bc_impl_invokeinterface_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	quicken
	ldr	r3, =quicken
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr]                ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_new
bc_impl_new

	EXPORT	bc_impl_new_internal
bc_impl_new_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	newobject
	ldr	r3, =newobject
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_newarray
bc_impl_newarray

	EXPORT	bc_impl_newarray_internal
bc_impl_newarray_internal PROC
	; Entry: Count = 1
	mov	r2, r0
	; get array type
	; load unsigned byte at bcp + 1
	ldrb	r3, [lr, #1]
	; Handle slowly if length too large or negative
	cmp	r2, #0x100000
	bhi	L102
	; compute array size in words
	and	r1, r3, #3
	mov	r1, r2, lsl r1
	add	r1, r1, #11
	mov	r1, r1, lsr #2
	; get _inline_allocation_top
	ldr	r0, [r5, #1060]          ; inline_allocation_top 
	; get _inline_allocation_end, and check for overflow
	ldr	r9, [r5, #1064]          ; inline_allocation_end 
	adds	r4, r0, r1, lsl #2
	bcs	L102
	cmp	r4, r9
	bhi	L102
	IMPORT	persistent_handles
	ldr	r9, =persistent_handles + 48
	; allocation succeeded, set _inline_allocation_top
	str	r4, [r5, #1060]          ; inline_allocation_top 
	; Get array class
	ldr	r3, [r9, +r3, lsl #2]
	; set array length
	str	r2, [r0, #4]
	; Get array class near
	ldr	r3, [r3, #12]
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	; set prototypical near in array; no need for write barrier
	str	r3, [r0]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L102
	mov	r1, r3
	IMPORT	_newarray
	ldr	r3, =_newarray
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_anewarray
bc_impl_anewarray

	EXPORT	bc_impl_anewarray_internal
bc_impl_anewarray_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	anewarray
	ldr	r3, =anewarray
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	add	r6, r6, #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_arraylength
bc_impl_arraylength

	EXPORT	bc_impl_arraylength_internal
bc_impl_arraylength_internal PROC
	; Entry: Count = 1
	cmp	r0, #0
	beq	L103
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r0, [r0, #4]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L103
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_athrow
bc_impl_athrow

	EXPORT	bc_impl_athrow_internal
bc_impl_athrow_internal PROC
	; Change state to tos_in_regs
	; null check
	cmp	r0, #0                   ; is object zero?
	beq	interpreter_throw_NullPointerException_tos_cached
	; save interpreter state
	str	lr, [fp, #-16]
	mov	r1, r0
	bl	interpreter_call_vm_exception
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_checkcast
bc_impl_checkcast

	EXPORT	bc_impl_checkcast_internal
bc_impl_checkcast_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	checkcast
	ldr	r3, =checkcast
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_instanceof
bc_impl_instanceof

	EXPORT	bc_impl_instanceof_internal
bc_impl_instanceof_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	instanceof
	ldr	r3, =instanceof
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	add	r6, r6, #4
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	mov	r1, #2
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_monitorenter
bc_impl_monitorenter

	EXPORT	bc_impl_monitorenter_internal
bc_impl_monitorenter_internal PROC
	; Change state to tos_in_regs
	; null check
	cmp	r0, #0                   ; is object zero?
	beq	interpreter_throw_NullPointerException_tos_cached
	add	lr, lr, #1
	; save interpreter state
	str	lr, [fp, #-16]
	bl	shared_monitor_enter
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; Dispatch to the next bytecode
	ldrb	r12, [lr]                ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_monitorexit
bc_impl_monitorexit

	EXPORT	bc_impl_monitorexit_internal
bc_impl_monitorexit_internal PROC
	; Change state to tos_in_regs
	; null check
	cmp	r0, #0                   ; is object zero?
	beq	interpreter_throw_NullPointerException_tos_cached
	; save interpreter state
	str	lr, [fp, #-16]
	bl	shared_monitor_exit
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_wide
bc_impl_wide

	EXPORT	bc_impl_wide_internal
bc_impl_wide_internal PROC
	; load unsigned byte at bcp + 1
	ldrb	r12, [lr, #1]
	ldr	r3, [r5, +r12, lsl #2]
	ldr	r4, [r3, #-4]
	mov	pc, r4
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_multianewarray
bc_impl_multianewarray

	EXPORT	bc_impl_multianewarray_internal
bc_impl_multianewarray_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	multianewarray
	ldr	r3, =multianewarray
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; load unsigned byte at bcp + 3
	ldrb	r2, [lr, #3]
	ldrb	r12, [lr, #4]!           ; prefetch next bytecode
	add	r6, r6, r2, lsl #2
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ifnull is a duplicate of ifeq
	; ifnonnull is a duplicate of ifne
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_goto_w
bc_impl_goto_w

	EXPORT	bc_impl_goto_w_internal
bc_impl_goto_w_internal PROC
	ldr	r2, [r5, #1032]          ; rt_timer_ticks  ; Timer tick?
	cmp	r2, #0
	bne	interpreter_timer_tick
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldrb	r2, [lr, #1]
	ldrb	r3, [lr, #2]
	ldrb	r4, [lr, #3]
	ldrb	r9, [lr, #4]
	add	r2, r3, r2, lsl #8
	add	r2, r4, r2, lsl #8
	add	r2, r9, r2, lsl #8
	ldrb	r12, [lr, +r2]!          ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_breakpoint
bc_impl_breakpoint

	EXPORT	bc_impl_breakpoint_internal
bc_impl_breakpoint_internal PROC
	; unimplemented bytecode
	IMPORT	print_fatal
	svc	#0x9f0001
	adrl	r0, _D0
	bl	print_fatal
	LTORG
	; literals
_D0	DCB	"trying to execute unimplemented bytecode", 0, 0, 0, 0

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_1_ldc
bc_impl_fast_1_ldc

	EXPORT	bc_impl_fast_1_ldc_internal
bc_impl_fast_1_ldc_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	; Get byte of constant pool entry
	ldrb	r0, [lr, #1]
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	ldr	r0, [r8, +r0, lsl #2]    ; load constant pool entry
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_1_ldc_w
bc_impl_fast_1_ldc_w

	EXPORT	bc_impl_fast_1_ldc_w_internal
bc_impl_fast_1_ldc_w_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	; Get two bytes of constant pool entry
	ldrb	r2, [lr, #1]
	ldrb	r0, [lr, #2]
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	add	r2, r8, r2, lsl #10
	ldr	r0, [r2, +r0, lsl #2]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_2_ldc_w
bc_impl_fast_2_ldc_w

	EXPORT	bc_impl_fast_2_ldc_w_internal
bc_impl_fast_2_ldc_w_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	; Get two bytes of constant pool entry
	ldrb	r9, [lr, #1]
	ldrb	r0, [lr, #2]
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	add	r9, r8, r9, lsl #10
	ldr	r0, [r9, +r0, lsl #2]!
	ldr	r2, [r9, #4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_1_putstatic
bc_impl_fast_1_putstatic

	EXPORT	bc_impl_fast_1_putstatic_internal
bc_impl_fast_1_putstatic_internal PROC
	; Entry: Count = 1
L105
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L106
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 1
L106
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r1, +r3]            ; r1[r3] := r0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L104
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_2_putstatic
bc_impl_fast_2_putstatic

	EXPORT	bc_impl_fast_2_putstatic_internal
bc_impl_fast_2_putstatic_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
L108
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L109
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 2
	ldr	r2, [r6], #4
L109
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r1, +r3]!           ; r1[r3] := r0
	str	r2, [r1, #4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L107
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_a_putstatic
bc_impl_fast_a_putstatic

	EXPORT	bc_impl_fast_a_putstatic_internal
bc_impl_fast_a_putstatic_internal PROC
	; Entry: Count = 1
L111
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L112
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 1
L112
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r1, +r3]!           ; r1[r3] := r0
	; oop_write_barrier
	ldr	r0, [r5, #1076]          ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r9, [r0, +r1, lsr #5]!
	mvn	r1, r1, lsr #2
	orr	r9, r9, r3, ror r1
	strb	r9, [r0]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L110
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_1_getstatic
bc_impl_fast_1_getstatic

	EXPORT	bc_impl_fast_1_getstatic_internal
bc_impl_fast_1_getstatic_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
L114
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L115
	ldr	r0, [r6], #4
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 0
	str	r0, [r6, #-4]!
L115
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	ldr	r0, [r1, +r3]            ; r0 := r1[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L113
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_2_getstatic
bc_impl_fast_2_getstatic

	EXPORT	bc_impl_fast_2_getstatic_internal
bc_impl_fast_2_getstatic_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
L117
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L118
	ldr	r0, [r6], #4
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 0
	str	r0, [r6, #-4]!
L118
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	ldr	r0, [r1, +r3]!           ; r0 := r1[r3]
	ldr	r2, [r1, #4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
L116
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_bputfield
bc_impl_fast_bputfield

	EXPORT	bc_impl_fast_bputfield_internal
bc_impl_fast_bputfield_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r2, #0
	beq	L119
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	strb	r0, [r2, +r3]            ; r2[r3] := r0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L119
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_sputfield
bc_impl_fast_sputfield

	EXPORT	bc_impl_fast_sputfield_internal
bc_impl_fast_sputfield_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r2, #0
	beq	L120
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	strh	r0, [r2, +r3]            ; r2[r3] := r0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L120
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_iputfield
bc_impl_fast_iputfield

	EXPORT	bc_impl_fast_fputfield
bc_impl_fast_fputfield PROC

	ENDP

	EXPORT	bc_impl_fast_iputfield_internal
bc_impl_fast_iputfield_internal PROC

	ENDP

	EXPORT	bc_impl_fast_fputfield_internal
bc_impl_fast_fputfield_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r2, #0
	beq	L121
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r2, +r3, lsl #2]    ; r2[r3] := r0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L121
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_lputfield
bc_impl_fast_lputfield

	EXPORT	bc_impl_fast_dputfield
bc_impl_fast_dputfield PROC

	ENDP

	EXPORT	bc_impl_fast_lputfield_internal
bc_impl_fast_lputfield_internal PROC

	ENDP

	EXPORT	bc_impl_fast_dputfield_internal
bc_impl_fast_dputfield_internal PROC
	; Entry: Count = 3
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r4, #0
	beq	L122
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r4, +r3, lsl #2]!   ; r4[r3] := r0
	str	r2, [r4, #4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L122
	; Handle null pointer exception
	str	r4, [r6, #-4]!
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; fast_fputfield is a duplicate of fast_iputfield
	; fast_dputfield is a duplicate of fast_lputfield
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_aputfield
bc_impl_fast_aputfield

	EXPORT	bc_impl_fast_aputfield_internal
bc_impl_fast_aputfield_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r2, #0
	beq	L123
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r2, +r3, lsl #2]!   ; r2[r3] := r0
	; oop_write_barrier
	ldr	r0, [r5, #1076]          ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r9, [r0, +r2, lsr #5]!
	mvn	r2, r2, lsr #2
	orr	r9, r9, r3, ror r2
	strb	r9, [r0]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L123
	; Handle null pointer exception
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_bgetfield
bc_impl_fast_bgetfield

	EXPORT	bc_impl_fast_bgetfield_internal
bc_impl_fast_bgetfield_internal PROC
	; Entry: Count = 1
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r0, #0
	beq	L124
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	ldrsb	r0, [r0, +r3]            ; r0 := r0[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L124
	; Handle null pointer exception
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_sgetfield
bc_impl_fast_sgetfield

	EXPORT	bc_impl_fast_sgetfield_internal
bc_impl_fast_sgetfield_internal PROC
	; Entry: Count = 1
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r0, #0
	beq	L125
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	ldrsh	r0, [r0, +r3]            ; r0 := r0[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L125
	; Handle null pointer exception
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_igetfield
bc_impl_fast_igetfield

	EXPORT	bc_impl_fast_fgetfield
bc_impl_fast_fgetfield PROC

	ENDP

	EXPORT	bc_impl_fast_agetfield
bc_impl_fast_agetfield PROC

	ENDP

	EXPORT	bc_impl_fast_igetfield_internal
bc_impl_fast_igetfield_internal PROC

	ENDP

	EXPORT	bc_impl_fast_fgetfield_internal
bc_impl_fast_fgetfield_internal PROC

	ENDP

	EXPORT	bc_impl_fast_agetfield_internal
bc_impl_fast_agetfield_internal PROC
	; Entry: Count = 1
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r0, #0
	beq	L126
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	ldr	r0, [r0, +r3, lsl #2]    ; r0 := r0[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L126
	; Handle null pointer exception
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_lgetfield
bc_impl_fast_lgetfield

	EXPORT	bc_impl_fast_dgetfield
bc_impl_fast_dgetfield PROC

	ENDP

	EXPORT	bc_impl_fast_lgetfield_internal
bc_impl_fast_lgetfield_internal PROC

	ENDP

	EXPORT	bc_impl_fast_dgetfield_internal
bc_impl_fast_dgetfield_internal PROC
	; Entry: Count = 1
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r0, #0
	beq	L127
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	add	r3, r0, r3, lsl #2       ; r0 := r0[r3]
	ldr	r0, [r3]
	ldr	r2, [r3, #4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
L127
	; Handle null pointer exception
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; fast_fgetfield is a duplicate of fast_igetfield
	; fast_dgetfield is a duplicate of fast_lgetfield
	; fast_agetfield is a duplicate of fast_igetfield
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_cgetfield
bc_impl_fast_cgetfield

	EXPORT	bc_impl_fast_cgetfield_internal
bc_impl_fast_cgetfield_internal PROC
	; Entry: Count = 1
	ldrb	r9, [lr, #1]
	ldrb	r10, [lr, #2]
	cmp	r0, #0
	beq	L128
	orr	r3, r9, r10, lsl #8
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	ldrh	r0, [r0, +r3]            ; r0 := r0[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L128
	; Handle null pointer exception
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_invokevirtual
bc_impl_fast_invokevirtual

	EXPORT	bc_impl_fast_invokevirtual_internal
bc_impl_fast_invokevirtual_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; save interpreter state
	str	lr, [fp, #-16]
	; Get two bytes of constant pool entry
	ldrb	r3, [lr, #1]
	ldrb	r9, [lr, #2]
	ldr	r4, [r5, #1196]          ; class_list_base 
	add	r3, r8, r3, lsl #10
	ldr	r9, [r3, +r9, lsl #2]!
	mov	r10, r9, lsl #16         ; vtable index is low bits of cpool entry
	mov	r10, r10, lsr #16
	mov	r9, r9, asr #16          ; class id is high bits of cpool entry
	ldr	r9, [r4, +r9, lsl #2]
	; Get fixed method from vtable of the class
	ldr	r9, [r9, #16]
	add	r3, r9, r10, lsl #2
	ldr	r3, [r3, #40]
	; Get the number of parameters
	ldrh	r4, [r3, #32]
	mov	r4, r4, lsl #23
	mov	r4, r4, lsr #23          ; r4 = parameter size in words
	; Get receiver object
	add	r9, r6, r4, lsl #2       ; address of stack pointer just past receiver
	ldr	r9, [r9, #-4]            ; receiver
	; Check if it is null
	; null check
	cmp	r9, #0                   ; is object zero?
	beq	interpreter_throw_NullPointerException
	; Get java near
	ldr	r9, [r9]
	; Get classinfo of receiver object
	ldr	r9, [r9, #4]
	; Get method from vtable of the class
	add	r0, r9, r10, lsl #2
	ldr	r0, [r0, #40]
	; Call method
	ldr	r2, [r0, #20]
	ldr	r2, [r2]
	ldrh	r4, [r0, #32]
	mov	r4, r4, lsr #9           ; r4 = result type
	ldr	pc, [pc, +r4, lsl #2]
	nop
	DCD	L129
	DCD	L130
	DCD	L131
	DCD	L132
	DCD	L133
L129
	; invoke method with result type == 0
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; return type is void
	ldr	r0, [r6], #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L130
L131
	; invoke method with result type == 2
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L132
L133
	; invoke method with result type == 4
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0/r1
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_invokestatic
bc_impl_fast_invokestatic

	EXPORT	bc_impl_fast_invokestatic_internal
bc_impl_fast_invokestatic_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; save interpreter state
	str	lr, [fp, #-16]
L134
	; Get two bytes of constant pool entry
	ldrb	r2, [lr, #1]
	ldrb	r0, [lr, #2]
	add	r2, r8, r2, lsl #10
	ldr	r0, [r2, +r0, lsl #2]!
	; get holder of this method
	ldr	r3, [r5, #1196]          ; class_list_base 
	ldrh	r2, [r0, #26]
	ldr	r2, [r3, +r2, lsl #2]
	ldr	r3, [r5, #1200]          ; mirror_list_base 
	ldrh	r4, [r0, #26]
	ldr	r3, [r3, +r4, lsl #2]
	cmp	r3, #0
	; It will almost never be zero, so preload tmp2
	ldr	r4, [r5, #1800]          ; task_class_init_marker 
	cmpne	r3, r4
	bne	L135
	; move instanceclass obj into extra arg
	mov	r1, r2
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r2, [lr, #1]
	ldrb	r0, [lr, #2]
	add	r2, r8, r2, lsl #10
	ldr	r0, [r2, +r0, lsl #2]!
L135
	; Call method
	ldr	r2, [r0, #20]
	ldr	r2, [r2]
	ldrh	r4, [r0, #32]
	mov	r4, r4, lsr #9           ; r4 = result type
	ldr	pc, [pc, +r4, lsl #2]
	nop
	DCD	L136
	DCD	L137
	DCD	L138
	DCD	L139
	DCD	L140
L136
	; invoke method with result type == 0
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; return type is void
	ldr	r0, [r6], #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L137
L138
	; invoke method with result type == 2
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L139
L140
	; invoke method with result type == 4
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0/r1
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_invokeinterface
bc_impl_fast_invokeinterface

	EXPORT	bc_impl_fast_invokeinterface_internal
bc_impl_fast_invokeinterface_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; load unsigned 16bit word at bcp + 1
	ldrb	r2, [lr, #1]             ; get bytes of constant pool index
	ldrb	r9, [lr, #2]
	; load unsigned byte at bcp + 3
	ldrb	r3, [lr, #3]             ; get count
	orr	r2, r9, r2, lsl #8       ; combine bytes
	; save interpreter state
	str	lr, [fp, #-16]
	; Get the class id from resolved constant pool entry
	ldr	r4, [r8, +r2, lsl #2]
	; Get receiver object
	add	r0, r6, r3, lsl #2       ; address of stack pointer just past receiver
	ldr	r0, [r0, #-4]            ; receiver
	mov	r9, r4, lsr #16
	; null check
	cmp	r0, #0                   ; is object zero?
	beq	interpreter_throw_NullPointerException
	; Get class of receiver object
	ldr	r0, [r0]
	sub	r4, r4, r9, lsl #16
	ldr	r0, [r0]
	; Get ClassInfo of receiver class
	ldr	r0, [r0, #16]
	; Get the itable from the ClassInfo of the receiver object
	ldrh	r3, [r0, #6]
	ldrh	r2, [r0, #8]
	add	r1, r0, #32
	add	r1, r1, r3, lsl #2
	; Lookup interface method table by linear search
L141
	subs	r2, r2, #1
	ldrge	r10, [r1, #8]!
	blt	interpreter_throw_IncompatibleClassChangeError
	cmp	r9, r10
	bne	L141
	; Found the itable entry; now get the method table offset from there
	ldr	r3, [r1, #4]
	; Get the method from the method table
	add	r0, r0, r4, lsl #2
	ldr	r0, [r0, +r3]
	; Call method
	ldr	r2, [r0, #20]
	ldr	r2, [r2]
	ldrh	r4, [r0, #32]
	mov	r4, r4, lsr #9           ; r4 = result type
	ldr	pc, [pc, +r4, lsl #2]
	nop
	DCD	L142
	DCD	L143
	DCD	L144
	DCD	L145
	DCD	L146
L142
	; invoke method with result type == 0
	mov	lr, pc
	bx	r2

	EXPORT	invoke5_deoptimization_entry_0
invoke5_deoptimization_entry_0
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #5]!           ; prefetch next bytecode
	; return type is void
	ldr	r0, [r6], #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L143
L144
	; invoke method with result type == 2
	mov	lr, pc
	bx	r2

	EXPORT	invoke5_deoptimization_entry_1
invoke5_deoptimization_entry_1

	EXPORT	invoke5_deoptimization_entry_2
invoke5_deoptimization_entry_2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #5]!           ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L145
L146
	; invoke method with result type == 4
	mov	lr, pc
	bx	r2

	EXPORT	invoke5_deoptimization_entry_3
invoke5_deoptimization_entry_3

	EXPORT	invoke5_deoptimization_entry_4
invoke5_deoptimization_entry_4
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #5]!           ; prefetch next bytecode
	; result is in r0/r1
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_invokenative
bc_impl_fast_invokenative

	EXPORT	bc_impl_fast_invokenative_internal
bc_impl_fast_invokenative_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
L147
	; Get address of first paramater
	ldr	r2, [fp, #-4]            ; current method
	ldrh	r2, [r2, #24]
	mov	r3, r7
	; load unsigned byte at bcp + 1
	ldrb	r4, [lr, #1]
	; Set space for fake parameter for static method (KNI-ism)
	tst	r2, #8
	addne	r3, r3, #4
	; Point _kni_parameter_base to the first parameter
	str	r3, [r5, #1256]          ; kni_parameter_base 
	ldr	r3, [lr, #4]             ; get the pointer from the bytecode
	; call the native code
	; save interpreter state
	str	lr, [fp, #-16]
	cmp	r4, #12
	adrl	lr, L148
	beq	shared_call_vm_oop
	bne	shared_call_vm
L148
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldr	r3, [r5, #1036]          ; current_thread 
	ldr	r4, [r3, #76]
	; Clear Thread.async_redo so that we won't loop indefinitely
	mov	r9, #0
	str	r9, [r3, #76]
	; loop if need to redo the native method invocation
	cmp	r4, #0
	bne	L147
	; load unsigned byte at bcp + 1
	ldrb	r4, [lr, #1]             ; Get kind
	str	r9, [r3, #52]            ; Clear Thread.async_info
	sub	r4, r4, #7
	ldr	pc, [pc, +r4, lsl #2]
	DCD	L154
	DCD	L155
	DCD	L153
	DCD	L153
	DCD	L149
	DCD	L150
	DCD	L152
	DCD	L153
	DCD	L151
L149
	; store result
	b	bc_impl_ireturn_internal
L150
	; store result
	str	r1, [r6, #-4]!
	b	bc_impl_lreturn_internal
L152
	; store result
	b	bc_impl_areturn_internal
L151
	ldr	r0, [r6], #4
	b	bc_impl_return_internal
L154
	; store result
	b	bc_impl_freturn_internal
L155
	; store result
	str	r1, [r6, #-4]!
	b	bc_impl_dreturn_internal
L153
	svc	#0x9f0001
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_invokevirtual_final
bc_impl_fast_invokevirtual_final

	EXPORT	bc_impl_fast_invokevirtual_final_internal
bc_impl_fast_invokevirtual_final_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; save interpreter state
	str	lr, [fp, #-16]
L156
	; Get two bytes of constant pool entry
	ldrb	r2, [lr, #1]
	ldrb	r0, [lr, #2]
	add	r2, r8, r2, lsl #10
	ldr	r0, [r2, +r0, lsl #2]!
	ldrh	r4, [r0, #32]            ; number of parameters
	mov	r4, r4, lsl #23
	mov	r4, r4, lsr #23          ; r4 = parameter size in words
	add	r9, r6, r4, lsl #2       ; get receiver object
	ldr	r9, [r9, #-4]            ; receiver
	; null check
	cmp	r9, #0                   ; is object zero?
	beq	interpreter_throw_NullPointerException
	; Call method
	ldr	r2, [r0, #20]
	ldr	r2, [r2]
	ldrh	r4, [r0, #32]
	mov	r4, r4, lsr #9           ; r4 = result type
	ldr	pc, [pc, +r4, lsl #2]
	nop
	DCD	L157
	DCD	L158
	DCD	L159
	DCD	L160
	DCD	L161
L157
	; invoke method with result type == 0
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; return type is void
	ldr	r0, [r6], #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L158
L159
	; invoke method with result type == 2
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L160
L161
	; invoke method with result type == 4
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0/r1
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_invokespecial
bc_impl_fast_invokespecial

	EXPORT	bc_impl_fast_invokespecial_internal
bc_impl_fast_invokespecial_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; save interpreter state
	str	lr, [fp, #-16]
	; Get two bytes of constant pool entry
	ldrb	r3, [lr, #1]
	ldrb	r9, [lr, #2]
	ldr	r4, [r5, #1196]          ; class_list_base 
	add	r3, r8, r3, lsl #10
	ldr	r9, [r3, +r9, lsl #2]!
	mov	r10, r9, lsl #16         ; vtable index is low 16 bits of the cpool entry
	mov	r10, r10, lsr #16
	mov	r9, r9, asr #16          ; class id is high 16 bits of the cpool entry
	ldr	r9, [r4, +r9, lsl #2]
	; Get ClassInfo from class
	ldr	r9, [r9, #16]
	; Get method from vtable of the ClassInfo
	add	r0, r9, r10, lsl #2
	ldr	r0, [r0, #40]
	; Get the number of parameters
	ldrh	r4, [r0, #32]
	mov	r4, r4, lsl #23
	mov	r4, r4, lsr #23          ; r4 = parameter size in words
	; Get receiver object
	add	r9, r6, r4, lsl #2       ; address of stack pointer just past receiver
	ldr	r9, [r9, #-4]            ; receiver
	; null check
	cmp	r9, #0                   ; is object zero?
	beq	interpreter_throw_NullPointerException
	; Call method
	ldr	r2, [r0, #20]
	ldr	r2, [r2]
	ldrh	r4, [r0, #32]
	mov	r4, r4, lsr #9           ; r4 = result type
	ldr	pc, [pc, +r4, lsl #2]
	nop
	DCD	L162
	DCD	L163
	DCD	L164
	DCD	L165
	DCD	L166
L162
	; invoke method with result type == 0
	mov	lr, pc
	bx	r2

	EXPORT	invoke3_deoptimization_entry_0
invoke3_deoptimization_entry_0
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; return type is void
	ldr	r0, [r6], #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L163
L164
	; invoke method with result type == 2
	mov	lr, pc
	bx	r2

	EXPORT	invoke3_deoptimization_entry_1
invoke3_deoptimization_entry_1

	EXPORT	invoke3_deoptimization_entry_2
invoke3_deoptimization_entry_2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L165
L166
	; invoke method with result type == 4
	mov	lr, pc
	bx	r2

	EXPORT	invoke3_deoptimization_entry_3
invoke3_deoptimization_entry_3

	EXPORT	invoke3_deoptimization_entry_4
invoke3_deoptimization_entry_4
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0/r1
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_new
bc_impl_fast_new

	EXPORT	bc_impl_fast_new_internal
bc_impl_fast_new_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
L168
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r3, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	ldr	r2, [r3, +r1, lsl #2]
	ldr	r4, [r5, #1200]          ; mirror_list_base 
	ldr	r3, [r4, +r1, lsl #2]
	ldr	r4, [r5, #1800]          ; task_class_init_marker 
	cmp	r3, r4
	bne	L169
	; move instanceclass obj into extra arg
	mov	r1, r2
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r2, [lr, #2]
	ldr	r3, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r2, [r4, +r2, lsl #2]!
	ldr	r2, [r3, +r2, lsl #2]
L169
	; get _inline_allocation_top
	ldr	r0, [r5, #1060]          ; inline_allocation_top 
	; get instance size (in bytes) from class
	ldrsh	r1, [r2, #6]
	; get _inline_allocation_end, and check for overflow
	ldr	r9, [r5, #1064]          ; inline_allocation_end 
	adds	r4, r0, r1
	bcs	L167
	cmp	r4, r9
	bhi	L167
	; allocation succeeded, set _inline_allocation_top
	str	r4, [r5, #1060]          ; inline_allocation_top 
	; get prototypical near from class
	ldr	r2, [r2, #12]
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; set prototypical near in object; no need for write barrier
	str	r2, [r0]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L167
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	b	bc_impl_new_internal
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_anewarray
bc_impl_fast_anewarray

	EXPORT	bc_impl_fast_anewarray_internal
bc_impl_fast_anewarray_internal PROC
	; Entry: Count = 1
	mov	r2, r0
	; go slow case if array length is larger than maximum safe array length or below zero
	cmp	r2, #0x100000
	bhi	L170
	; compute array size in bytes
	mov	r1, r2, lsl #2
	add	r1, r1, #8
	; get _inline_allocation_top
	ldr	r0, [r5, #1060]          ; inline_allocation_top 
	; get _inline_allocation_end, and check for overflow
	ldr	r9, [r5, #1064]          ; inline_allocation_end 
	adds	r4, r0, r1
	bcs	L170
	cmp	r4, r9
	bhi	L170
	; allocation succeeded, set _inline_allocation_top
	str	r4, [r5, #1060]          ; inline_allocation_top 
	; get constant pool entry
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r3, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r3, [r4, +r3, lsl #2]!
	; If arrayclass pointer is non-zero we're done
	ldr	r9, [r5, #1196]          ; class_list_base 
	ldr	r4, [r9, +r3, lsl #2]
	ldr	r4, [r4, #28]
	cmp	r4, #0
	movne	r3, r4
	bne	L171
	; get task mirror
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r3, [r9, +r3, lsl #2]
	; get array class from class
	ldr	r3, [r3, #20]
	cmp	r3, #0
	beq	L170
L171
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; set array length
	str	r2, [r0, #4]
	; get prototypical near from array class
	ldr	r3, [r3, #12]
	; set prototypical near in array; no need for write barrier
	str	r3, [r0]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L170
	mov	r0, r2
	b	bc_impl_anewarray
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_checkcast
bc_impl_fast_checkcast

	EXPORT	bc_impl_fast_checkcast_internal
bc_impl_fast_checkcast_internal PROC
	; Entry: Count = 1
	; Check for NULL object
	cmp	r0, #0
	beq	L172
	; Get the class for the object, and the constant pool entry
	ldr	r2, [r0]
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r3, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r3, [r4, +r3, lsl #2]!
	ldr	r2, [r2]
	ldr	r3, [r9, +r3, lsl #2]
	; Compare the classes
	cmp	r3, r2
	; Check the subtype caches
	ldrne	r4, [r2, #20]
	ldrne	r9, [r2, #24]
	cmpne	r3, r4
	cmpne	r3, r9
	bne	L173
L172
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L173
	b	bc_impl_checkcast
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_instanceof
bc_impl_fast_instanceof

	EXPORT	bc_impl_fast_instanceof_internal
bc_impl_fast_instanceof_internal PROC
	; Entry: Count = 1
	; Get the object to check cast for
	; Check for NULL object
	cmp	r0, #0
	beq	L174
	; Get the class for the object, and the constant pool entry
	ldr	r2, [r0]
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r3, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r3, [r4, +r3, lsl #2]!
	ldr	r2, [r2]
	ldr	r3, [r9, +r3, lsl #2]
	; Compare the classes
	cmp	r3, r2
	; Check the subtype caches
	ldrne	r4, [r2, #20]
	ldrne	r9, [r2, #24]
	cmpne	r3, r4
	cmpne	r3, r9
	bne	L175
	; Set the result to 1
	mov	r0, #1
L174
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L175
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	mov	r1, r2
	mov	r2, r3
	IMPORT	_instanceof
	ldr	r3, =_instanceof
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	add	r6, r6, #4
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	mov	r1, #2
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_igetfield_1
bc_impl_fast_igetfield_1

	EXPORT	bc_impl_fast_agetfield_1
bc_impl_fast_agetfield_1 PROC

	ENDP

	EXPORT	bc_impl_fast_igetfield_1_internal
bc_impl_fast_igetfield_1_internal PROC

	ENDP

	EXPORT	bc_impl_fast_agetfield_1_internal
bc_impl_fast_agetfield_1_internal PROC
	; Entry: Count = 1
	ldrb	r3, [lr, #1]
	cmp	r0, #0
	beq	L176
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	ldr	r0, [r0, +r3, lsl #2]    ; r0 := r0[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L176
	; Handle null pointer exception
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; fast_agetfield_1 is a duplicate of fast_igetfield_1
	; aload_0_fast_agetfield_1 is a duplicate of aload_0_fast_igetfield_1
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_aload_0_fast_igetfield_1
bc_impl_aload_0_fast_igetfield_1

	EXPORT	bc_impl_aload_0_fast_agetfield_1
bc_impl_aload_0_fast_agetfield_1 PROC

	ENDP

	EXPORT	bc_impl_aload_0_fast_igetfield_1_internal
bc_impl_aload_0_fast_igetfield_1_internal PROC

	ENDP

	EXPORT	bc_impl_aload_0_fast_agetfield_1_internal
bc_impl_aload_0_fast_agetfield_1_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldr	r0, [r7]
	ldrb	r3, [lr, #1]
	cmp	r0, #0
	beq	L177
	ldrb	r12, [lr, #2]!           ; prefetch next bytecode
	ldr	r0, [r0, +r3, lsl #2]    ; r0 := r0[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L177
	; Handle null pointer exception
	ldr	r0, [r6], #4
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_pop_and_npe_if_null
bc_impl_pop_and_npe_if_null

	EXPORT	bc_impl_pop_and_npe_if_null_internal
bc_impl_pop_and_npe_if_null_internal PROC
	; Change state to tos_in_regs
	; null check
	cmp	r0, #0                   ; is object zero?
	beq	interpreter_throw_NullPointerException_tos_cached
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_init_static_array
bc_impl_init_static_array

	EXPORT	bc_impl_init_static_array_internal
bc_impl_init_static_array_internal PROC
	ldrb	r3, [lr, #1]!
	ldrb	r10, [lr, #1]!
	ldrb	r4, [lr, #1]!
	cmp	r0, #0
	beq	interpreter_throw_NullPointerException
	ldr	r9, [r0, #4]
	add	r2, r0, #8
	orr	r4, r10, r4, lsl #8
	cmp	r4, r9
	bgt	interpreter_throw_ArrayIndexOutOfBoundsException
	mov	r4, r4, lsl r3
	add	r4, r4, lr
L178
	ldrb	r3, [lr, #1]!
	strb	r3, [r2], #1
	cmp	r4, lr
	bgt	L178
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; aload_0_fast_agetfield_4 is a duplicate of aload_0_fast_igetfield_4
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_aload_0_fast_igetfield_4
bc_impl_aload_0_fast_igetfield_4

	EXPORT	bc_impl_aload_0_fast_agetfield_4
bc_impl_aload_0_fast_agetfield_4 PROC

	ENDP

	EXPORT	bc_impl_aload_0_fast_igetfield_4_internal
bc_impl_aload_0_fast_igetfield_4_internal PROC

	ENDP

	EXPORT	bc_impl_aload_0_fast_agetfield_4_internal
bc_impl_aload_0_fast_agetfield_4_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldr	r0, [r7]
	; Implicit offset = 4
	mov	r3, #1
	cmp	r0, #0
	beq	L179
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r0, [r0, +r3, lsl #2]    ; r0 := r0[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L179
	; Handle null pointer exception
	ldr	r0, [r6], #4
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; aload_0_fast_agetfield_8 is a duplicate of aload_0_fast_igetfield_8
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_aload_0_fast_igetfield_8
bc_impl_aload_0_fast_igetfield_8

	EXPORT	bc_impl_aload_0_fast_agetfield_8
bc_impl_aload_0_fast_agetfield_8 PROC

	ENDP

	EXPORT	bc_impl_aload_0_fast_igetfield_8_internal
bc_impl_aload_0_fast_igetfield_8_internal PROC

	ENDP

	EXPORT	bc_impl_aload_0_fast_agetfield_8_internal
bc_impl_aload_0_fast_agetfield_8_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
	ldr	r0, [r7]
	; Implicit offset = 8
	mov	r3, #2
	cmp	r0, #0
	beq	L180
	ldrb	r12, [lr, #1]!           ; prefetch next bytecode
	ldr	r0, [r0, +r3, lsl #2]    ; r0 := r0[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L180
	; Handle null pointer exception
	ldr	r0, [r6], #4
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_init_1_putstatic
bc_impl_fast_init_1_putstatic

	EXPORT	bc_impl_fast_init_1_putstatic_internal
bc_impl_fast_init_1_putstatic_internal PROC
	; Entry: Count = 1
L182
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L183
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 1
L183
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r1, +r3]            ; r1[r3] := r0
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L181
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_init_2_putstatic
bc_impl_fast_init_2_putstatic

	EXPORT	bc_impl_fast_init_2_putstatic_internal
bc_impl_fast_init_2_putstatic_internal PROC
	; Entry: Count = 2
	ldr	r2, [r6], #4
L185
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L186
	str	r2, [r6, #-4]!
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 2
	ldr	r2, [r6], #4
L186
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r1, +r3]!           ; r1[r3] := r0
	str	r2, [r1, #4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L184
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_init_a_putstatic
bc_impl_fast_init_a_putstatic

	EXPORT	bc_impl_fast_init_a_putstatic_internal
bc_impl_fast_init_a_putstatic_internal PROC
	; Entry: Count = 1
L188
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L189
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 1
L189
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	str	r0, [r1, +r3]!           ; r1[r3] := r0
	; oop_write_barrier
	ldr	r0, [r5, #1076]          ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r9, [r0, +r1, lsr #5]!
	mvn	r1, r1, lsr #2
	orr	r9, r9, r3, ror r1
	strb	r9, [r0]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	ldr	r0, [r6], #4
	mov	pc, r12                  ; go to next bytecode
L187
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_init_1_getstatic
bc_impl_fast_init_1_getstatic

	EXPORT	bc_impl_fast_init_1_getstatic_internal
bc_impl_fast_init_1_getstatic_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
L191
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L192
	ldr	r0, [r6], #4
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 0
	str	r0, [r6, #-4]!
L192
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	ldr	r0, [r1, +r3]            ; r0 := r1[r3]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L190
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_init_2_getstatic
bc_impl_fast_init_2_getstatic

	EXPORT	bc_impl_fast_init_2_getstatic_internal
bc_impl_fast_init_2_getstatic_internal PROC
	; Entry: Count = 0
	str	r0, [r6, #-4]!
L194
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r9, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; Get class_id from low sixteen bits of entry
	sub	r1, r1, r3, lsl #16
	ldr	r4, [r9, +r1, lsl #2]
	; Get TaskMirror from class_id
	ldr	r9, [r5, #1200]          ; mirror_list_base 
	ldr	r1, [r9, +r1, lsl #2]
	cmp	r1, #0
	; It will almost never be zero, so preload tmp3
	ldr	r9, [r5, #1800]          ; task_class_init_marker 
	cmpne	r1, r9
	bne	L195
	ldr	r0, [r6], #4
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r4
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	; Get field offset from high sixteen bits of entry
	mov	r3, r1, lsr #16
	; get pointer to task mirror into object
	mov	r1, r0
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; Entry: Count = 0
	str	r0, [r6, #-4]!
L195
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	ldr	r0, [r1, +r3]!           ; r0 := r1[r3]
	ldr	r2, [r1, #4]
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	str	r2, [r6, #-4]!
	mov	pc, r12                  ; go to next bytecode
L193
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_init_invokestatic
bc_impl_fast_init_invokestatic

	EXPORT	bc_impl_fast_init_invokestatic_internal
bc_impl_fast_init_invokestatic_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; save interpreter state
	str	lr, [fp, #-16]
L196
	; Get two bytes of constant pool entry
	ldrb	r2, [lr, #1]
	ldrb	r0, [lr, #2]
	add	r2, r8, r2, lsl #10
	ldr	r0, [r2, +r0, lsl #2]!
	; get holder of this method
	ldr	r3, [r5, #1196]          ; class_list_base 
	ldrh	r2, [r0, #26]
	ldr	r2, [r3, +r2, lsl #2]
	ldr	r3, [r5, #1200]          ; mirror_list_base 
	ldrh	r4, [r0, #26]
	ldr	r3, [r3, +r4, lsl #2]
	cmp	r3, #0
	; It will almost never be zero, so preload tmp2
	ldr	r4, [r5, #1800]          ; task_class_init_marker 
	cmpne	r3, r4
	bne	L197
	; move instanceclass obj into extra arg
	mov	r1, r2
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r2, [lr, #1]
	ldrb	r0, [lr, #2]
	add	r2, r8, r2, lsl #10
	ldr	r0, [r2, +r0, lsl #2]!
L197
	; Call method
	ldr	r2, [r0, #20]
	ldr	r2, [r2]
	ldrh	r4, [r0, #32]
	mov	r4, r4, lsr #9           ; r4 = result type
	ldr	pc, [pc, +r4, lsl #2]
	nop
	DCD	L198
	DCD	L199
	DCD	L200
	DCD	L201
	DCD	L202
L198
	; invoke method with result type == 0
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; return type is void
	ldr	r0, [r6], #4
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L199
L200
	; invoke method with result type == 2
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L201
L202
	; invoke method with result type == 4
	mov	lr, pc
	bx	r2
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; result is in r0/r1
	str	r1, [r6, #-4]!
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_init_new
bc_impl_fast_init_new

	EXPORT	bc_impl_fast_init_new_internal
bc_impl_fast_init_new_internal PROC
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
L204
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r1, [lr, #2]
	ldr	r3, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r1, [r4, +r1, lsl #2]!
	ldr	r2, [r3, +r1, lsl #2]
	ldr	r4, [r5, #1200]          ; mirror_list_base 
	ldr	r3, [r4, +r1, lsl #2]
	ldr	r4, [r5, #1800]          ; task_class_init_marker 
	cmp	r3, r4
	bne	L205
	; move instanceclass obj into extra arg
	mov	r1, r2
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb	r4, [lr, #1]
	ldrb	r2, [lr, #2]
	ldr	r3, [r5, #1196]          ; class_list_base 
	add	r4, r8, r4, lsl #10
	ldr	r2, [r4, +r2, lsl #2]!
	ldr	r2, [r3, +r2, lsl #2]
L205
	; get _inline_allocation_top
	ldr	r0, [r5, #1060]          ; inline_allocation_top 
	; get instance size (in bytes) from class
	ldrsh	r1, [r2, #6]
	; get _inline_allocation_end, and check for overflow
	ldr	r9, [r5, #1064]          ; inline_allocation_end 
	adds	r4, r0, r1
	bcs	L203
	cmp	r4, r9
	bhi	L203
	; allocation succeeded, set _inline_allocation_top
	str	r4, [r5, #1060]          ; inline_allocation_top 
	; get prototypical near from class
	ldr	r2, [r2, #12]
	ldrb	r12, [lr, #3]!           ; prefetch next bytecode
	; set prototypical near in object; no need for write barrier
	str	r2, [r0]
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
L203
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	b	bc_impl_new_internal
	LTORG

	ENDP
	; End segment: unnamed


	AREA |.data|, DATA
	; ------------------------------------------------------
	; Start segment: Interpreter bytecode counters table

	EXPORT	interpreter_bytecode_counters
interpreter_bytecode_counters
	; The bytecode counters table is intentionally left empty.
	; To use bytecode counters, turn on +PrintBytecodeHistogram
	; during interpreter loop generation.
	; End segment: Interpreter bytecode counters table


	; ------------------------------------------------------
	; Start segment: Interpreter pair counters table

	EXPORT	interpreter_pair_counters
interpreter_pair_counters
	; The pair counters table is intentionally left empty.
	; To use pair counters, turn on +PrintPairHistogram
	; during interpreter loop generation.
	; End segment: Interpreter pair counters table



	EXPORT	shared_entry_return_point
	AREA |.text|, CODE
	ARM
	; ------------------------------------------------------
	; Start segment: Shared entry

	EXPORT	shared_entry
shared_entry PROC
	; Get information
	ldr	r3, [r5, #1036]          ; current_thread 
	ldr	r10, [r5, #1040]         ; current_pending_exception 
	ldr	r4, [r3, #72]            ; Thread::last_java_fp
	ldr	r9, [r3, #68]            ; Thread::last_java_sp
	ldr	r12, =0xdeadbeef         ; EntryFrame::FakeReturnAddress
	sub	r6, r6, #36              ; make room on stack for EntryFrame
	add	fp, r6, #28              ; set the fp of the EntryFrame
	; Store information in the frame
	str	r10, [fp, #-24]          ; current pending exception
	str	r2, [fp, #4]             ; stored obj value
	str	r1, [fp, #-12]           ; stored int value #1
	str	r0, [fp, #-16]           ; stored int value #2
	str	r9, [fp, #-8]            ; stored_last_sp
	str	r4, [fp, #-4]            ; stored_last_fp
	str	lr, [fp]                 ; real_return_address
	str	r12, [fp, #-20]          ; fake_return_address
	; reset last java frame
	mov	r0, #0
	str	r0, [r3, #68]            ; last_java_sp
	str	r0, [r3, #72]            ; last_java_fp
	; get pending activation list
	ldr	r4, [r3, #36]
	; reset pending exception and activation
	str	r0, [r3, #36]
	str	r0, [r5, #1040]          ; current_pending_exception 
L206
	; Handle one activation
	ldr	r0, [r4, #12]            ; get next pending activation
	ldr	r10, [r4, #4]            ; argument length
	add	r9, r4, #16              ; pointer to first argument
	cmp	r10, #0
	str	r0, [fp, #-28]           ; save next pending activation
	; push parameter from entry activation
L207
	ldrgt	r0, [r9], #8
	strgt	r0, [r6, #-4]!
	subs	r10, r10, #1             ; Decrement the length and check for more parameters
	bgt	L207
	ldr	r0, [r4, #8]             ; method from entry activation
	ldr	r2, [r0, #20]            ; variable_part_offset
	ldr	r2, [r2]                 ; Code to call
	mov	lr, pc
	bx	r2
shared_entry_return_point
	ldr	r4, [fp, #-28]           ; restore the next pending activation
	ldr	r3, [fp, #-24]           ; speculatively restore pending exception
	cmp	r4, #0                   ; check for more pending activations
	bne	L206
	ldr	r2, [fp, #4]             ; restore return value(s)
	ldr	r1, [fp, #-12]
	ldr	r0, [fp, #-16]
	; restore pending exception
	str	r3, [r5, #1040]          ; current_pending_exception 

	EXPORT	shared_entry_return
shared_entry_return
	; Remove information from the entry frame
	ldr	r3, [r5, #1036]          ; current_thread 
	ldr	r9, [fp, #-8]            ; stored_last_fp
	ldr	r4, [fp, #-4]            ; stored_last_sp
	ldr	lr, [fp]                 ; real_return_address
	add	r6, fp, #8               ; pop entry frame
	mov	fp, r4                   ; restore fp
	str	r9, [r3, #68]            ; restore Thread::last_java_sp
	str	r4, [r3, #72]            ; restore Thread::last_java_fp
	bx	lr
	LTORG

	ENDP
	; End segment: Shared entry


	; ------------------------------------------------------
	; Start segment: Shared invoke compiler

	EXPORT	shared_invoke_compiler
shared_invoke_compiler PROC
	; Fake a clock tick
	ldr	r2, [r5, #1032]          ; rt_timer_ticks 
	add	r2, r2, #1
	str	r2, [r5, #1032]          ; rt_timer_ticks 
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: Shared invoke compiler


	; ------------------------------------------------------
	; Start segment: Shared fast accessors

	EXPORT	shared_fast_getbyte_accessor
shared_fast_getbyte_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	mov	r2, #1
	ldrsb	r0, [r4, +r9]            ; get field from 'this' object
	bx	lr

	ENDP

	EXPORT	shared_fast_getshort_accessor
shared_fast_getshort_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	mov	r2, #1
	ldrsh	r0, [r4, +r9]            ; get field from 'this' object
	bx	lr

	ENDP

	EXPORT	shared_fast_getchar_accessor
shared_fast_getchar_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	mov	r2, #1
	ldrh	r0, [r4, +r9]            ; get field from 'this' object
	bx	lr

	ENDP

	EXPORT	shared_fast_getfloat_accessor
shared_fast_getfloat_accessor PROC

	ENDP

	EXPORT	shared_fast_getint_accessor
shared_fast_getint_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	mov	r2, #1
	ldr	r0, [r4, +r9]            ; get field from 'this' object
	bx	lr

	ENDP

	EXPORT	shared_fast_getdouble_accessor
shared_fast_getdouble_accessor PROC

	ENDP

	EXPORT	shared_fast_getlong_accessor
shared_fast_getlong_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	mov	r2, #2
	ldr	r0, [r4, +r9]!           ; get field from 'this' object
	ldr	r1, [r4, #4]
	bx	lr

	ENDP

	EXPORT	shared_fast_getbyte_static_accessor
shared_fast_getbyte_static_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	cmp	r4, #0
	beq	L208
	mov	r2, #1
	ldrsb	r0, [r4, +r9]            ; get field from 'this' object
	bx	lr

	ENDP

	EXPORT	shared_fast_getshort_static_accessor
shared_fast_getshort_static_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	cmp	r4, #0
	beq	L208
	mov	r2, #1
	ldrsh	r0, [r4, +r9]            ; get field from 'this' object
	bx	lr

	ENDP

	EXPORT	shared_fast_getchar_static_accessor
shared_fast_getchar_static_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	cmp	r4, #0
	beq	L208
	mov	r2, #1
	ldrh	r0, [r4, +r9]            ; get field from 'this' object
	bx	lr

	ENDP

	EXPORT	shared_fast_getfloat_static_accessor
shared_fast_getfloat_static_accessor PROC

	ENDP

	EXPORT	shared_fast_getint_static_accessor
shared_fast_getint_static_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	cmp	r4, #0
	beq	L208
	mov	r2, #1
	ldr	r0, [r4, +r9]            ; get field from 'this' object
	bx	lr

	ENDP

	EXPORT	shared_fast_getdouble_static_accessor
shared_fast_getdouble_static_accessor PROC

	ENDP

	EXPORT	shared_fast_getlong_static_accessor
shared_fast_getlong_static_accessor PROC
	ldr	r4, [r6], #4             ; pop 'this'
	ldrh	r9, [r0, #30]            ; get field offset (is 2-byte aligned!)
	cmp	r4, #0
	beq	L208
	mov	r2, #2
	ldr	r0, [r4, +r9]!           ; get field from 'this' object
	ldr	r1, [r4, #4]
	bx	lr
L208
	; Restore stack state and continue with exception throwing
	str	r4, [r6, #-4]!
	b	interpreter_throw_NullPointerException
	LTORG

	ENDP
	; End segment: Shared fast accessors


	; ------------------------------------------------------
	; Start segment: Shared call VM

	EXPORT	interpreter_call_vm
interpreter_call_vm PROC

	ENDP

	EXPORT	shared_call_vm
shared_call_vm PROC
	; Save value of java stack pointer
	mov	r10, r6
	str	lr, [r6, #-4]!
	; Get the current thread
	ldr	r12, [r5, #1036]         ; current_thread 
	; LWT Switch stack to primordial thread
	adrl	r0, L209
	str	r0, [r6, #-4]!
	str	fp, [r6, #-4]!
	; Save last java stack pointer and last java frame pointer in thread
	str	r6, [r12, #100]
	str	fp, [r12, #72]
	str	r10, [r12, #68]
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	; call the native entry
	mov	lr, pc
	bx	r3
	; Save the return values in the thread
	ldr	r2, [r5, #1036]          ; current_thread 
	str	r0, [r2, #112]
	str	r1, [r2, #116]
	; check for pending entries and if so, check for enough stack space
	ldr	r0, [r2, #36]
	cmp	r0, #0
	beq	L212
	ldr	r3, [r0, #4]
	b	L211
L210
	; check parameter size
	ldr	r1, [r0, #4]
	cmp	r3, r1                   ; r3 = max(r3, r1)
	movlt	r3, r1
L211
	; get next activation
	ldr	r0, [r0, #12]
	cmp	r0, #0
	bne	L210
	; convert count to bytes plus a fudge factor
	mov	r3, r3, lsl #3
	; add in a stack lock for good measure
	add	r3, r3, #28
	ldr	r0, [r2, #100]
	sub	r3, r0, r3
	ldr	r0, [r5, #1024]          ; current_stack_limit 
	cmp	r3, r0
	bgt	L212
	; need more stack, call into the VM
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	mov	r1, r3
	bl	stack_overflow
L212
	; Call switch_thread(JVM_TRAPS)
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	IMPORT	switch_thread
	bl	switch_thread
	; Switch back to the java stack
	ldr	r2, [r5, #1036]          ; current_thread 
	ldr	r6, [r2, #100]
	ldr	fp, [r6], #4
	ldr	lr, [r6], #4
	cmp	lr, pc
	bxne	lr
L209
	ldr	r0, [r5, #1036]          ; current_thread 
	; Load pending offset activations here and check below
	ldr	r3, [r0, #36]
	; restore the return values in the thread
	ldr	r1, [r0, #116]
	ldr	r0, [r0, #112]
	mov	r2, #0
	cmp	r3, #0                   ; check for pending activations
	blne	shared_entry             ; invoke the pending activations
	; reset last java frame in thread
	ldr	r2, [r5, #1036]          ; current_thread 
	mov	r3, #0
	str	r3, [r2, #68]
	str	r3, [r2, #72]
	; Get pending exceptions
	ldr	r3, [r5, #1040]          ; current_pending_exception 
	ldr	lr, [r6], #4
	; check for pending exceptions
	cmp	r3, #0
	; return if no pending exceptions
	bxeq	lr
	; Call shared_call_vm_exception
	mov	r1, r3                   ; argument goes into r1
	mov	r3, #0                   ; clear pending exception
	str	r3, [r5, #1040]          ; current_pending_exception 
	b	shared_call_vm_exception
	LTORG

	ENDP
	; End segment: Shared call VM


	; ------------------------------------------------------
	; Start segment: Shared call VM

	EXPORT	interpreter_call_vm_oop
interpreter_call_vm_oop PROC

	ENDP

	EXPORT	shared_call_vm_oop
shared_call_vm_oop PROC
	; Save value of java stack pointer
	mov	r10, r6
	str	lr, [r6, #-4]!
	; Get the current thread
	ldr	r12, [r5, #1036]         ; current_thread 
	; LWT Switch stack to primordial thread
	adrl	r0, L213
	str	r0, [r6, #-4]!
	str	fp, [r6, #-4]!
	; Save last java stack pointer and last java frame pointer in thread
	str	r6, [r12, #100]
	str	fp, [r12, #72]
	str	r10, [r12, #68]
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	; call the native entry
	mov	lr, pc
	bx	r3
	; Save the return values in the thread
	ldr	r2, [r5, #1036]          ; current_thread 
	str	r0, [r2, #48]!
	; oop_write_barrier
	ldr	r0, [r5, #1076]          ; bitvector_base 
	ldr	r1, [r5, #1080]          ; bit_selector 
	ldrb	r3, [r0, +r2, lsr #5]!
	mvn	r2, r2, lsr #2
	orr	r3, r3, r1, ror r2
	strb	r3, [r0]
	ldr	r2, [r5, #1036]          ; current_thread 
	str	r0, [r2, #112]
	; check for pending entries and if so, check for enough stack space
	ldr	r0, [r2, #36]
	cmp	r0, #0
	beq	L216
	ldr	r3, [r0, #4]
	b	L215
L214
	; check parameter size
	ldr	r1, [r0, #4]
	cmp	r3, r1                   ; r3 = max(r3, r1)
	movlt	r3, r1
L215
	; get next activation
	ldr	r0, [r0, #12]
	cmp	r0, #0
	bne	L214
	; convert count to bytes plus a fudge factor
	mov	r3, r3, lsl #3
	; add in a stack lock for good measure
	add	r3, r3, #28
	ldr	r0, [r2, #100]
	sub	r3, r0, r3
	ldr	r0, [r5, #1024]          ; current_stack_limit 
	cmp	r3, r0
	bgt	L216
	; need more stack, call into the VM
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	mov	r1, r3
	bl	stack_overflow
L216
	; Call switch_thread(JVM_TRAPS)
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	bl	switch_thread
	; Switch back to the java stack
	ldr	r2, [r5, #1036]          ; current_thread 
	ldr	r6, [r2, #100]
	ldr	fp, [r6], #4
	ldr	lr, [r6], #4
	cmp	lr, pc
	bxne	lr
L213

	ENDP

	EXPORT	shared_call_vm_oop_return
shared_call_vm_oop_return PROC
	ldr	r0, [r5, #1036]          ; current_thread 
	; Load pending offset activations here and check below
	ldr	r3, [r0, #36]
	; restore the return values in the thread
	ldr	r2, [r0, #48]
	mov	r1, #0
	str	r1, [r0, #48]
	cmp	r3, #0                   ; check for pending activations
	blne	shared_entry             ; invoke the pending activations
	mov	r0, r2                   ; move oop return value to r0
	; reset last java frame in thread
	ldr	r2, [r5, #1036]          ; current_thread 
	mov	r3, #0
	str	r3, [r2, #68]
	str	r3, [r2, #72]
	; Get pending exceptions
	ldr	r3, [r5, #1040]          ; current_pending_exception 
	ldr	lr, [r6], #4
	; check for pending exceptions
	cmp	r3, #0
	; return if no pending exceptions
	bxeq	lr
	; Call shared_call_vm_exception
	mov	r1, r3                   ; argument goes into r1
	mov	r3, #0                   ; clear pending exception
	str	r3, [r5, #1040]          ; current_pending_exception 
	b	shared_call_vm_exception
	LTORG

	ENDP
	; End segment: Shared call VM


	; ------------------------------------------------------
	; Start segment: Shared call VM

	EXPORT	interpreter_call_vm_exception
interpreter_call_vm_exception PROC

	ENDP

	EXPORT	shared_call_vm_exception
shared_call_vm_exception PROC
	; Save value of java stack pointer
	mov	r10, r6
	str	lr, [r6, #-4]!
	sub	r6, r6, #4               ; Leave empty space on stack
	; Get the current thread
	ldr	r12, [r5, #1036]         ; current_thread 
	; LWT Switch stack to primordial thread
	adrl	r0, L217
	str	r0, [r6, #-4]!
	str	fp, [r6, #-4]!
	; Save last java stack pointer and last java frame pointer in thread
	str	r6, [r12, #100]
	str	fp, [r12, #72]
	str	r10, [r12, #68]
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	; call the native entry
	IMPORT	find_exception_frame
	bl	find_exception_frame
	; Save the return values in the thread
	ldr	r2, [r5, #1036]          ; current_thread 
	str	r0, [r2, #112]
	; check for pending entries and if so, check for enough stack space
	ldr	r0, [r2, #36]
	cmp	r0, #0
	beq	L220
	ldr	r3, [r0, #4]
	b	L219
L218
	; check parameter size
	ldr	r1, [r0, #4]
	cmp	r3, r1                   ; r3 = max(r3, r1)
	movlt	r3, r1
L219
	; get next activation
	ldr	r0, [r0, #12]
	cmp	r0, #0
	bne	L218
	; convert count to bytes plus a fudge factor
	mov	r3, r3, lsl #3
	; add in a stack lock for good measure
	add	r3, r3, #28
	ldr	r0, [r2, #100]
	sub	r3, r0, r3
	ldr	r0, [r5, #1024]          ; current_stack_limit 
	cmp	r3, r0
	bgt	L220
	; need more stack, call into the VM
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	mov	r1, r3
	bl	stack_overflow
L220
	; Call switch_thread(JVM_TRAPS)
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	bl	switch_thread
	; Switch back to the java stack
	ldr	r2, [r5, #1036]          ; current_thread 
	ldr	r6, [r2, #100]
	ldr	fp, [r6], #4
	ldr	lr, [r6], #4
	cmp	lr, pc
	bxne	lr
L217
	ldr	r0, [r5, #1036]          ; current_thread 
	ldr	fp, [r0, #72]
	ldr	r1, [r0, #68]
	sub	r6, r1, #4
	; Load pending offset activations here and check below
	ldr	r3, [r0, #36]
	; restore the return values in the thread
	ldr	r0, [r0, #112]
	mov	r2, #0
	cmp	r3, #0                   ; check for pending activations
	blne	shared_entry             ; invoke the pending activations
	cmp	r0, #0
	; reset last java frame in thread
	ldr	r2, [r5, #1036]          ; current_thread 
	mov	r3, #0
	str	r3, [r2, #68]
	str	r3, [r2, #72]
	; A return value of zero means the initial entry frame
	bne	L221
	ldr	r1, [fp, #-24]           ; exception is stored in frame
	ldr	lr, [fp]                 ; return address
	add	r6, fp, #8               ; pop entry frame off stack
	str	r1, [r5, #1040]          ; current_pending_exception 
	bx	lr
L221
	; Get pending exceptions
	ldr	r3, [r5, #1040]          ; current_pending_exception 
	ldr	lr, [r6], #4
	; check for pending exceptions
	cmp	r3, #0
	; return if no pending exceptions
	bxeq	lr
	; Call shared_call_vm_exception
	mov	r1, r3                   ; argument goes into r1
	mov	r3, #0                   ; clear pending exception
	str	r3, [r5, #1040]          ; current_pending_exception 
	b	shared_call_vm_exception
	LTORG

	ENDP
	; End segment: Shared call VM


	; ------------------------------------------------------
	; Start segment: Shared monitor enter

	EXPORT	shared_monitor_enter
shared_monitor_enter PROC
	; Are there any monitors at all?
	ldr	r2, [fp, #4]
	mov	r1, #0
	sub	r3, fp, #20
	cmp	r3, r2
	beq	L222
	; Search for empty lock
	; point at object field of stack lock
	add	r2, r2, #24
	; object field just before first lock
	add	r3, fp, #4
L224
	; Start the loop by checking if the current stack lock is empty
	ldr	r4, [r2], #28
	cmp	r4, #0
	subeq	r1, r2, #52              ; point at beginning of previous lock if empty
	; Current stack lock object equal to the object from the stack?
	cmp	r4, r0
	beq	L225
	; Go to next stack lock in monitor block
	cmp	r2, r3
	bne	L224
L225
	; Have we found an entry?
	cmp	r1, #0
	bne	L223
	beq	L222
L223
	; r0 contains the object to lock
	; r1 contains a stack lock in the monitor block
	ldr	r3, [r0]                 ; Get the near object
	str	r0, [r1, #24]            ; Store the object in the stack lock and lock it
	ldr	r4, [r5, #1788]          ; interned_string_near_addr  ; See if this is an interned string
	cmp	r4, r3
	moveq	r4, #0
	; If going the slow way, zero out real java near for GC 
	streq	r4, [r1, #4]
	beq	L227
	ldr	r4, [r3, #8]             ; object already locked?
	tst	r4, #1
	bne	L226
	; We have the fast case
	ldr	r2, [r5, #1036]          ; current_thread 
	orr	r4, r4, #1
	str	r4, [r1, #20]
	str	r3, [r1, #4]
	str	r2, [r1]
	; Clear waiters
	mov	r2, #0
	str	r2, [r1, #8]
	; Update the near pointer in the object
	add	r2, r1, #12
	str	r2, [r0]
	; Copy the locked near object to the stack and set lock bit
	; Copy the first two fields of the near
	ldmia	r3, {r2, r4}
	str	r2, [r1, #12]
	str	r4, [r1, #16]
	bx	lr
L226
	; maybe_slow_case
	ldr	r2, [r5, #1036]          ; current_thread 
	ldr	r3, [r3, #-12]           ; thread of object's lock
	mov	r4, #0                   ; set our own real java near field to nul
	str	r4, [r1, #4]
	cmp	r2, r3                   ; is this a recursive lock?
	bxeq	lr
L227
	; slow_case
	IMPORT	lock_stack_lock
	ldr	r3, =lock_stack_lock
	b	shared_call_vm
L222
	; Allocate a stack lock in the monitor block
	; Set lock to old expression stack bottom
	ldr	r1, [fp, #4]
	; Move expression stack top and bottom
	sub	r6, r6, #28
	sub	r1, r1, #28
	str	r1, [fp, #4]
	; Move the expression stack contents
	mov	r2, r6
	b	L228
L229
	ldr	r3, [r2, #28]
	str	r3, [r2], #4
L228
	; Check if bottom is reached
	cmp	r2, r1
	bne	L229
	b	L223
	LTORG

	ENDP
	; End segment: Shared monitor enter


	; ------------------------------------------------------
	; Start segment: Shared monitor exit

	EXPORT	shared_monitor_exit
shared_monitor_exit PROC
	ldr	r3, [r0]                 ; Get the near object
	ldr	r4, [r5, #1788]          ; interned_string_near_addr  ; See if this is an interned string
	cmp	r4, r3
	bne	L232
	mov	r1, r0
	IMPORT	unlock_special_stack_lock
	ldr	r3, =unlock_special_stack_lock
	b	shared_call_vm
L232
	; Find matching slot in monitor block
	ldr	r1, [fp, #4]             ; end of locks
	sub	r3, fp, #20              ; address of lock just beyond the first
	cmp	r1, r3
	beq	L231
L233
	; Is monitor pointed at by lock the right one?
	ldr	r2, [r1, #24]            ; get object field
	cmp	r0, r2                   ; is this the right object?
	beq	L230
	add	r1, r1, #28              ; Go to next lock
	cmp	r1, r3                   ; at the end of the monitor block?
	bne	L233
L231
	; Throw an IllegalMonitorStateException
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	b	shared_call_vm
L230
	; r0 contains the object that is being unlocked
	; r1 contains the stack lock

	; Get the real java near pointer from the stack lock
	ldr	r3, [r1, #4]
	; Zero out the object field so that lock is free
	mov	r2, #0
	str	r2, [r1, #24]
	; Is this the reentrant case?
	cmp	r3, #0
	bxeq	lr
	; Set the object near pointer
	str	r3, [r0]
	cmp	r3, r0
	ldrcc	r2, [r1, #20]
	bcc	L234
	; oop_write_barrier
	ldr	r2, [r5, #1052]          ; heap_start 
	ldr	r3, [r5, #1248]          ; old_generation_end 
	cmp	r0, r2
	cmpcs	r3, r0
	ldrcs	r2, [r5, #1076]          ; bitvector_base 
	ldrcs	r3, [r5, #1080]          ; bit_selector 
	ldrcsb	r4, [r2, +r0, lsr #5]!
	mvncs	r0, r0, lsr #2
	orrcs	r4, r4, r3, ror r0
	strcsb	r4, [r2]
	ldr	r2, [r1, #20]
L234
	tst	r2, #2
	bxeq	lr
	; Call the runtime system to signal the waiters
	IMPORT	signal_waiters
	ldr	r3, =signal_waiters
	b	shared_call_vm
	LTORG

	ENDP
	; End segment: Shared monitor exit


	; ------------------------------------------------------
	; Start segment: Invoke pending entries

	EXPORT	invoke_pending_entries
invoke_pending_entries PROC
	; Get current thread (may not have gp yet)
	ldr	r0, =_current_thread
	ldr	r0, [r0]
	; Check if there's pending entries at all
	ldr	r1, [r0, #36]
	cmp	r1, #0
	bxeq	lr
	; Save permanent registers
	sub	fp, fp, r6
	stmfd	r6!, {r4, r5, r7 - r12, lr}
	; Invoke the pending entries
	mov	r2, #0
	bl	shared_entry
	; Restore permanent registers, frame pointer and link register
	ldmfd	r6!, {r4, r5, r7 - r12, lr}
	add	fp, fp, r6
	bx	lr
	LTORG

	ENDP
	; End segment: Invoke pending entries


	; ------------------------------------------------------
	; Start segment: Call on primoridal stack

	EXPORT	call_on_primordial_stack
call_on_primordial_stack PROC
	; Get target method
	mov	r2, r0
	ldr	r1, [r5, #1036]          ; current_thread 
	; Save return address and fp on java stack
	str	lr, [r6, #-4]!
	str	fp, [r6, #-4]!
	str	r6, [r1, #100]
	; Call r2(THREAD)
	add	r0, r5, #0x400           ; slow add_gp_imm current_thread 1036
	add	r0, r0, #12
	mov	lr, pc
	bx	r2
	; When we return, we may be on a different thread
	ldr	r1, [r5, #1036]          ; current_thread 
	ldr	r6, [r1, #100]
	ldr	lr, [r6, #4]
	ldr	fp, [r6], #8
	bx	lr
	LTORG

	ENDP
	; End segment: Call on primoridal stack


	; ------------------------------------------------------
	; Start segment: Clears a large range of memory

	EXPORT	fast_memclear
fast_memclear PROC
	stmfd	sp!, {r4 - r7, lr}
	subs	r1, r1, #0x400
	mov	r2, #0
	mov	r3, #0
	mov	r4, #0
	mov	r5, #0
	mov	r6, #0
	mov	r7, #0
	mov	r12, #0
	mov	lr, #0
	bcc	L236
L235
	subs	r1, r1, #0x400
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	bcs	L235
L236
	tst	r1, #0x200
	beq	L237
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
L237
	tst	r1, #0x100
	beq	L238
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
L238
	tst	r1, #128
	beq	L239
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
	stmia	r0!, {r2 - r7, r12, lr}
L239
	tst	r1, #64
	stmneia	r0!, {r2 - r7, r12, lr}
	stmneia	r0!, {r2 - r7, r12, lr}
	tst	r1, #32
	stmneia	r0!, {r2 - r7, r12, lr}
	tst	r1, #16
	stmneia	r0!, {r4 - r7}
	movs	r1, r1, lsl #29
	stmcsia	r0!, {r2, r3}
	strne	r2, [r0]
	ldmfd	sp!, {r4 - r7, pc}
	LTORG

	ENDP
	; End segment: Clears a large range of memory


	; ------------------------------------------------------
	; Start segment: Brute force icache flushing

	EXPORT	linux_arm_flush_icache_unused
linux_arm_flush_icache_unused PROC
	mrs	r2, cpsr
	add	r1, r0, r1
	bic	r0, r0, #63
	add	r1, r1, #63
	bic	r1, r1, #63
	; Are we in user mode?
	tst	r2, #15
	bne	non_user_mode_flush

	EXPORT	user_mode_flush
user_mode_flush
	mov	r2, #0
	svc	#0x9f0002
	bx	lr
L240
	mcr	p15, 0, r0, c7, c10, 1   ; clean data cache line
	mcr	p15, 0, r0, c7, c5, 1    ; invalidate instruction line cache
	add	r0, r0, #32
	mcr	p15, 0, r0, c7, c14, 1   ; clean and invalidate data line cache
	mcr	p15, 0, r0, c7, c5, 1    ; invalidate instruction line cache
	add	r0, r0, #32

	EXPORT	non_user_mode_flush
non_user_mode_flush
	cmp	r0, r1
	bcc	L240
	mov	r0, #0
	mcr	p15, 0, r0, c7, c10, 4   ; drain write buffer
	mcr	p15, 0, r0, c7, c5, 6    ; flush branch target cache (ARMv6 or higher)
	; CPUWAIT
	mrc	p15, 0, r0, c2, c0, 0    ; wait until p15 completes operation
	mov	r0, r0
	sub	pc, pc, #4
	bx	lr
	LTORG

	ENDP
	; End segment: Brute force icache flushing


	AREA |.text|, CODE
	ARM
	; ------------------------------------------------------
	; Start segment: Interpreter exception throwers

	EXPORT	interpreter_throw_ArrayIndexOutOfBoundsException
interpreter_throw_ArrayIndexOutOfBoundsException PROC
	IMPORT	array_index_out_of_bounds_exception
	ldr	r3, =array_index_out_of_bounds_exception
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm

	ENDP

	EXPORT	interpreter_throw_NullPointerException_tos_cached
interpreter_throw_NullPointerException_tos_cached PROC
	str	r0, [r6, #-4]!

	ENDP

	EXPORT	interpreter_throw_NullPointerException
interpreter_throw_NullPointerException PROC
	IMPORT	null_pointer_exception
	ldr	r3, =null_pointer_exception
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm

	ENDP

	EXPORT	interpreter_throw_IncompatibleClassChangeError
interpreter_throw_IncompatibleClassChangeError PROC
	IMPORT	incompatible_class_change_error
	ldr	r3, =incompatible_class_change_error
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	LTORG

	ENDP
	; End segment: Interpreter exception throwers


	; ------------------------------------------------------
	; Start segment: Interpreter deoptimization entry

	EXPORT	interpreter_deoptimization_entry
interpreter_deoptimization_entry
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr]                ; prefetch next bytecode
	; dispatch
	ldr	r12, [r5, +r12, lsl #2]  ; get implementation of bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	mov	pc, r12                  ; go to next bytecode
	LTORG
	; End segment: Interpreter deoptimization entry


	; ------------------------------------------------------
	; Start segment: Interpreter call timer_tick

	EXPORT	interpreter_timer_tick
interpreter_timer_tick
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str	lr, [fp, #-16]
	bl	interpreter_call_vm
	; restore interpreter state
	ldr	r7, [fp, #-12]           ; restore locals
	ldr	r8, [fp, #-8]            ; restore cpool
	ldr	lr, [fp, #-16]           ; restore bcp
	ldrb	r12, [lr]                ; prefetch next bytecode
	; Restore stack state from tos_on_stack
	ldr	r0, [r6], #4             ; cache topmost element of stack
	; dispatch
	ldr	pc, [r5, +r12, lsl #2]
	LTORG
	; End segment: Interpreter call timer_tick


	; ------------------------------------------------------
	; Start segment: Primordial to current thread

	EXPORT	primordial_to_current_thread
primordial_to_current_thread PROC
	; save permanent registers (including return address)
	stmfd	sp!, {r3 - fp}
	str	lr, [sp, #-4]!
	; Set up global pointer
	ldr	r5, =gp_base_label
	; Get current thread
	ldr	r1, [r5, #1036]          ; current_thread 
	; Save primordial stack pointer
	str	sp, [r5, #1244]          ; primordial_sp 
	; Get new stack pointer
	ldr	r6, [r1, #100]
	; Go to code
	ldr	lr, [r6, #4]
	ldr	fp, [r6], #8
	bx	lr

	ENDP

	EXPORT	start_lightweight_thread_asm
start_lightweight_thread_asm PROC
	; Set up global pointer
	ldr	r5, =gp_base_label
	; Invoke pending entries unless the thread is being terminated
	ldr	r0, [r5, #1036]          ; current_thread 
	; r1 = THREAD->status();
	ldr	r1, [r0, #104]
	mov	r2, #0
	; if ((r1 & THREAD_TERMINATING) != 0) {
	tst	r1, #0x40000000
	;   THREAD->pending_entries = NULL;
	strne	r2, [r0, #36]
	; } else {
	;   invoke_pending_entries(THREAD)
	bleq	invoke_pending_entries
	; }
	; if (!TestCompiler) {
	ldr	r0, [r6, #16]
	ldr	r1, [r5, #1040]          ; current_pending_exception 
	cmp	r0, #0
	bne	L241
	;   if (Thread::current_has_pending_exception()) {
	;     call_on_primordial_stack(lightweight_thread_uncaught_exception);
	;   }
	cmp	r1, #0
	ldrne	r0, [r6, #4]
	blne	call_on_primordial_stack
	;   call_on_primordial_stack(finish);
	ldr	r0, [r6, #8]
	bl	call_on_primordial_stack
	;   invoke_pending_entries(THREAD);
	ldr	r0, [r5, #1036]          ; current_thread 
	bl	invoke_pending_entries
	;   force_terminated()
	ldr	r0, [r6, #12]
	bl	call_on_primordial_stack
	; }
	; Terminate the task if no other threads on it
	IMPORT	thread_task_cleanup
	ldr	r0, =thread_task_cleanup
	bl	call_on_primordial_stack
	;   invoke_pending_entries(THREAD);
	ldr	r0, [r5, #1036]          ; current_thread 
	bl	invoke_pending_entries

	ENDP
L241 PROC
	; call_on_primordial_stack(lightweight_thread_exit);
	ldr	r0, [r6]
	bl	call_on_primordial_stack
	; GUARANTEE(Scheduler::_next_runnable_thread == NULL
	IMPORT	_next_runnable_thread
	ldr	r0, =_next_runnable_thread
	ldr	r0, [r0]
	cmp	r0, #0
	swine	0x9f0001
	; current_thread_to_primordial();
	bl	current_thread_to_primordial_fast
	svc	#0x9f0001
	LTORG

	ENDP
	; End segment: Primordial to current thread


	; ------------------------------------------------------
	; Start segment: Current thread to primordial

	EXPORT	current_thread_to_primordial
current_thread_to_primordial PROC
	; Set up global pointer, as we can be called from C code
	ldr	r5, =gp_base_label

	ENDP

	EXPORT	current_thread_to_primordial_fast
current_thread_to_primordial_fast PROC
	ldr	sp, [r5, #1244]          ; primordial_sp 
	; restore permanent registers (including return address)
	ldr	lr, [sp], #4
	ldmfd	sp!, {r3 - fp}
	bx	lr
	LTORG

	ENDP
	; End segment: Current thread to primordial


	AREA |.text|, CODE
	ARM
	; ------------------------------------------------------
	; Start segment: Compiler new obj array

	EXPORT	compiler_new_obj_array
compiler_new_obj_array PROC
	; r0 contains the prototypical near of the object
	; r1 contains the array length
	; Get array length
	mov	r4, r0
	; Get _inline_allocation_top, _inline_allocation_end
	ldr	r0, [r5, #1060]          ; inline_allocation_top 
	ldr	r2, [r5, #1064]          ; inline_allocation_end 
	; Check for array lengths larger than maximum safe array length or below zero
	cmp	r1, #0x100000
	bhi	L242
	; Compute new top
	add	r3, r0, #8
	adds	r3, r3, r1, lsl #2
	bcs	L242
	; Compare against _inline_allocation_end
	cmp	r3, r2
	bhi	L242
	; Allocation succeeded
	; set _inline_allocation_top
	str	r3, [r5, #1060]          ; inline_allocation_top 
	; Set the prototypical near and length
	str	r4, [r0]
	str	r1, [r0, #4]
	; The newly allocated array is in register r0
	bx	lr
L242
	; Slow case - call the VM runtime system
	; _anewarray(THREAD, raw_base_klass, length)
	mov	r2, r1
	ldr	r1, [r4]
	IMPORT	_anewarray
	ldr	r3, =_anewarray
	ldr	r1, [r1, #36]
	b	shared_call_vm_oop
	LTORG

	ENDP
	; End segment: Compiler new obj array


	; ------------------------------------------------------
	; Start segment: Compiler new type array

	EXPORT	compiler_new_type_array
compiler_new_type_array PROC
	; r1 = klass, r2 = length
	ldr	r1, [r1, #16]
	IMPORT	_newarray
	ldr	r3, =_newarray
	ldr	r1, [r1, #20]
	b	shared_call_vm_oop
	LTORG

	ENDP
	; End segment: Compiler new type array


	; ------------------------------------------------------
	; Start segment: Compiler exceptions

	EXPORT	compiler_throw_NullPointerException
compiler_throw_NullPointerException PROC
	; r0 = method->max_locals()
	; Restore caller return address
	ldr	lr, [fp, #-20]
	mov	r1, #8
	add	r0, r1, r0, lsl #2
	mov	r6, fp
	ldr	fp, [r6], +r0
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 232
	ldr	r0, [r0]
	b	interpreter_method_entry
	; method->max_locals() = 0

	ENDP

	EXPORT	compiler_throw_NullPointerException_0
compiler_throw_NullPointerException_0 PROC
	mov	r0, #0
	b	compiler_throw_NullPointerException
	; method->max_locals() = 1

	ENDP

	EXPORT	compiler_throw_NullPointerException_1
compiler_throw_NullPointerException_1 PROC
	mov	r0, #1
	b	compiler_throw_NullPointerException
	; method->max_locals() = 2

	ENDP

	EXPORT	compiler_throw_NullPointerException_2
compiler_throw_NullPointerException_2 PROC
	mov	r0, #2
	b	compiler_throw_NullPointerException
	; method->max_locals() = 3

	ENDP

	EXPORT	compiler_throw_NullPointerException_3
compiler_throw_NullPointerException_3 PROC
	mov	r0, #3
	b	compiler_throw_NullPointerException
	; method->max_locals() = 4

	ENDP

	EXPORT	compiler_throw_NullPointerException_4
compiler_throw_NullPointerException_4 PROC
	mov	r0, #4
	b	compiler_throw_NullPointerException
	; method->max_locals() = 5

	ENDP

	EXPORT	compiler_throw_NullPointerException_5
compiler_throw_NullPointerException_5 PROC
	mov	r0, #5
	b	compiler_throw_NullPointerException
	; method->max_locals() = 6

	ENDP

	EXPORT	compiler_throw_NullPointerException_6
compiler_throw_NullPointerException_6 PROC
	mov	r0, #6
	b	compiler_throw_NullPointerException
	; method->max_locals() = 7

	ENDP

	EXPORT	compiler_throw_NullPointerException_7
compiler_throw_NullPointerException_7 PROC
	mov	r0, #7
	b	compiler_throw_NullPointerException
	; method->max_locals() = 8

	ENDP

	EXPORT	compiler_throw_NullPointerException_8
compiler_throw_NullPointerException_8 PROC
	mov	r0, #8
	b	compiler_throw_NullPointerException
	; method->max_locals() = 9

	ENDP

	EXPORT	compiler_throw_NullPointerException_9
compiler_throw_NullPointerException_9 PROC
	mov	r0, #9
	b	compiler_throw_NullPointerException

	ENDP

	EXPORT	compiler_throw_NullPointerException_10
compiler_throw_NullPointerException_10 PROC
	; r0 = parameter offset
	; Restore caller return address
	add	r6, r6, r0
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 232
	ldr	r0, [r0]
	b	interpreter_method_entry

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException
compiler_throw_ArrayIndexOutOfBoundsException PROC
	; r0 = method->max_locals()
	; Restore caller return address
	ldr	lr, [fp, #-20]
	mov	r1, #8
	add	r0, r1, r0, lsl #2
	mov	r6, fp
	ldr	fp, [r6], +r0
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 236
	ldr	r0, [r0]
	b	interpreter_method_entry
	; method->max_locals() = 0

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_0
compiler_throw_ArrayIndexOutOfBoundsException_0 PROC
	mov	r0, #0
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 1

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_1
compiler_throw_ArrayIndexOutOfBoundsException_1 PROC
	mov	r0, #1
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 2

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_2
compiler_throw_ArrayIndexOutOfBoundsException_2 PROC
	mov	r0, #2
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 3

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_3
compiler_throw_ArrayIndexOutOfBoundsException_3 PROC
	mov	r0, #3
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 4

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_4
compiler_throw_ArrayIndexOutOfBoundsException_4 PROC
	mov	r0, #4
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 5

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_5
compiler_throw_ArrayIndexOutOfBoundsException_5 PROC
	mov	r0, #5
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 6

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_6
compiler_throw_ArrayIndexOutOfBoundsException_6 PROC
	mov	r0, #6
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 7

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_7
compiler_throw_ArrayIndexOutOfBoundsException_7 PROC
	mov	r0, #7
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 8

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_8
compiler_throw_ArrayIndexOutOfBoundsException_8 PROC
	mov	r0, #8
	b	compiler_throw_ArrayIndexOutOfBoundsException
	; method->max_locals() = 9

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_9
compiler_throw_ArrayIndexOutOfBoundsException_9 PROC
	mov	r0, #9
	b	compiler_throw_ArrayIndexOutOfBoundsException

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_10
compiler_throw_ArrayIndexOutOfBoundsException_10 PROC
	; r0 = parameter offset
	; Restore caller return address
	add	r6, r6, r0
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 236
	ldr	r0, [r0]
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: Compiler exceptions


	; ------------------------------------------------------
	; Start segment: Compiler timer tick

	EXPORT	compiler_timer_tick
compiler_timer_tick PROC
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	b	shared_call_vm
	LTORG

	ENDP
	; End segment: Compiler timer tick


	; ------------------------------------------------------
	; Start segment: Compiler checkcast

	EXPORT	compiler_checkcast
compiler_checkcast PROC
	; r2   = class_id
	; [r6] = object
	; check if object is castable to Universe::class_from_id(class_id)
	ldr	r3, [r6]                 ; r3 = object
	ldr	r4, [r5, #1196]          ; class_list_base 
	ldr	r3, [r3]                 ; r3 = near
	ldr	r2, [r4, +r2, lsl #2]    ; r2 = target_class
	ldr	r3, [r3]                 ; r3 = class
	mov	r4, r3                   ; r4 = class (copy)
L243
	cmp	r3, r2
	beq	L244
	ldr	r3, [r3, #32]            ; r3 = class.super
	cmp	r3, #0
	bne	L243
	IMPORT	checkcast
	ldr	r3, =checkcast
	b	shared_call_vm
L244
	ldr	r3, [r4, #20]            ; r3 = class.subtype_cache_1
	str	r2, [r4, #20]            ; class.subtype_cache_1 = target_class (r2)
	str	r3, [r4, #24]            ; class.subtype_cache_2 = old class.subtype_cache_1
	; no need for write barrier if we're pointing to a lower address
	cmp	r3, r4
	cmpcc	r2, r4
	bxcc	lr                       ; return if r3 < r4 && r2 < r4
	add	r12, r4, #20
	; oop_write_barrier
	ldr	r2, [r5, #1052]          ; heap_start 
	ldr	r3, [r5, #1248]          ; old_generation_end 
	cmp	r12, r2
	cmpcs	r3, r12
	ldrcs	r2, [r5, #1076]          ; bitvector_base 
	ldrcs	r3, [r5, #1080]          ; bit_selector 
	ldrcsb	r9, [r2, +r12, lsr #5]!
	mvncs	r12, r12, lsr #2
	orrcs	r9, r9, r3, ror r12
	strcsb	r9, [r2]
	add	r12, r4, #24
	; oop_write_barrier
	ldr	r2, [r5, #1052]          ; heap_start 
	ldr	r3, [r5, #1248]          ; old_generation_end 
	cmp	r12, r2
	cmpcs	r3, r12
	ldrcs	r2, [r5, #1076]          ; bitvector_base 
	ldrcs	r3, [r5, #1080]          ; bit_selector 
	ldrcsb	r9, [r2, +r12, lsr #5]!
	mvncs	r12, r12, lsr #2
	orrcs	r9, r9, r3, ror r12
	strcsb	r9, [r2]
	bx	lr
	LTORG

	ENDP
	; End segment: Compiler checkcast


	; ------------------------------------------------------
	; Start segment: Compiler instanceof

	EXPORT	compiler_instanceof
compiler_instanceof PROC
	; r0   = class_id
	; [r6] = object
	; check if object is instance of Universe::class_from_id(class_id)
	ldr	r1, [r6]                 ; r1 = object
	ldr	r2, [r5, #1196]          ; class_list_base 
	ldr	r1, [r1]                 ; r1 = near
	ldr	r2, [r2, +r0, lsl #2]    ; r2 = target_class
	ldr	r1, [r1]                 ; r1 = object_class
	IMPORT	_instanceof
	ldr	r3, =_instanceof
	b	shared_call_vm
	LTORG

	ENDP
	; End segment: Compiler instanceof


	; ------------------------------------------------------
	; Start segment: Compiler idiv irem

	EXPORT	interpreter_idiv_irem
interpreter_idiv_irem PROC
	; load one argument
	mov	r1, r0
	; load other argument
	ldr	r0, [r6], #4
	; Register r0 holds the dividend, r1 the divisor

	ENDP

	EXPORT	compiler_idiv_irem
compiler_idiv_irem PROC
	; Copy Divisor to another register and free r1
	; This instruction also resets V flag, which is used below by BLE
	adds	r12, r1, #0
	; Check for special cases: Dividend < 0 or Divisor <= 0
	orrs	r3, r12, r0, asr #32
	ble	L280
L279
	; Approximate the mamximum order of the Quotient
	clz	r3, r0
	clz	r1, r12
	subs	r3, r1, r3
	mov	r1, #0
	; Jump to the appropriate place in the unrolled loop below
	ldrpl	pc, [pc, +r3, lsl #2]
	; If Divisor is greater than Dividend, return immediately
	bx	lr
	; Offset table
	DCD	L245
	DCD	L246
	DCD	L247
	DCD	L248
	DCD	L249
	DCD	L250
	DCD	L251
	DCD	L252
	DCD	L253
	DCD	L254
	DCD	L255
	DCD	L256
	DCD	L257
	DCD	L258
	DCD	L259
	DCD	L260
	DCD	L261
	DCD	L262
	DCD	L263
	DCD	L264
	DCD	L265
	DCD	L266
	DCD	L267
	DCD	L268
	DCD	L269
	DCD	L270
	DCD	L271
	DCD	L272
	DCD	L273
	DCD	L274
	DCD	L275
	DCD	L276
	; Unrolled loop of 32 division steps
L276
	cmp	r0, r12, lsl #31
	subcs	r0, r0, r12, lsl #31
	addcs	r1, r1, #0x80000000
L275
	cmp	r0, r12, lsl #30
	subcs	r0, r0, r12, lsl #30
	addcs	r1, r1, #0x40000000
L274
	cmp	r0, r12, lsl #29
	subcs	r0, r0, r12, lsl #29
	addcs	r1, r1, #0x20000000
L273
	cmp	r0, r12, lsl #28
	subcs	r0, r0, r12, lsl #28
	addcs	r1, r1, #0x10000000
L272
	cmp	r0, r12, lsl #27
	subcs	r0, r0, r12, lsl #27
	addcs	r1, r1, #0x8000000
L271
	cmp	r0, r12, lsl #26
	subcs	r0, r0, r12, lsl #26
	addcs	r1, r1, #0x4000000
L270
	cmp	r0, r12, lsl #25
	subcs	r0, r0, r12, lsl #25
	addcs	r1, r1, #0x2000000
L269
	cmp	r0, r12, lsl #24
	subcs	r0, r0, r12, lsl #24
	addcs	r1, r1, #0x1000000
L268
	cmp	r0, r12, lsl #23
	subcs	r0, r0, r12, lsl #23
	addcs	r1, r1, #0x800000
L267
	cmp	r0, r12, lsl #22
	subcs	r0, r0, r12, lsl #22
	addcs	r1, r1, #0x400000
L266
	cmp	r0, r12, lsl #21
	subcs	r0, r0, r12, lsl #21
	addcs	r1, r1, #0x200000
L265
	cmp	r0, r12, lsl #20
	subcs	r0, r0, r12, lsl #20
	addcs	r1, r1, #0x100000
L264
	cmp	r0, r12, lsl #19
	subcs	r0, r0, r12, lsl #19
	addcs	r1, r1, #0x80000
L263
	cmp	r0, r12, lsl #18
	subcs	r0, r0, r12, lsl #18
	addcs	r1, r1, #0x40000
L262
	cmp	r0, r12, lsl #17
	subcs	r0, r0, r12, lsl #17
	addcs	r1, r1, #0x20000
L261
	cmp	r0, r12, lsl #16
	subcs	r0, r0, r12, lsl #16
	addcs	r1, r1, #0x10000
L260
	cmp	r0, r12, lsl #15
	subcs	r0, r0, r12, lsl #15
	addcs	r1, r1, #0x8000
L259
	cmp	r0, r12, lsl #14
	subcs	r0, r0, r12, lsl #14
	addcs	r1, r1, #0x4000
L258
	cmp	r0, r12, lsl #13
	subcs	r0, r0, r12, lsl #13
	addcs	r1, r1, #0x2000
L257
	cmp	r0, r12, lsl #12
	subcs	r0, r0, r12, lsl #12
	addcs	r1, r1, #0x1000
L256
	cmp	r0, r12, lsl #11
	subcs	r0, r0, r12, lsl #11
	addcs	r1, r1, #0x800
L255
	cmp	r0, r12, lsl #10
	subcs	r0, r0, r12, lsl #10
	addcs	r1, r1, #0x400
L254
	cmp	r0, r12, lsl #9
	subcs	r0, r0, r12, lsl #9
	addcs	r1, r1, #0x200
L253
	cmp	r0, r12, lsl #8
	subcs	r0, r0, r12, lsl #8
	addcs	r1, r1, #0x100
L252
	cmp	r0, r12, lsl #7
	subcs	r0, r0, r12, lsl #7
	addcs	r1, r1, #128
L251
	cmp	r0, r12, lsl #6
	subcs	r0, r0, r12, lsl #6
	addcs	r1, r1, #64
L250
	cmp	r0, r12, lsl #5
	subcs	r0, r0, r12, lsl #5
	addcs	r1, r1, #32
L249
	cmp	r0, r12, lsl #4
	subcs	r0, r0, r12, lsl #4
	addcs	r1, r1, #16
L248
	cmp	r0, r12, lsl #3
	subcs	r0, r0, r12, lsl #3
	addcs	r1, r1, #8
L247
	cmp	r0, r12, lsl #2
	subcs	r0, r0, r12, lsl #2
	addcs	r1, r1, #4
L246
	cmp	r0, r12, lsl #1
	subcs	r0, r0, r12, lsl #1
	addcs	r1, r1, #2
L245
	cmp	r0, r12
	subcs	r0, r0, r12
	addcs	r1, r1, #1
	bx	lr
L280
	; set bit 0 of temp register if Divisor < 0
	cmp	r12, #0
	beq	L277
	mov	r3, r12, lsr #31
	rsblt	r12, r12, #0
	; set bit 1 of temp register if Dividend < 0
	cmp	r0, #0
	orrlt	r3, r3, #2
	rsblt	r0, r0, #0
	; Save the original return address and adjust lr to point to
	; the appropriate sign-correction routine
	mov	r2, lr
	add	lr, pc, r3, lsl #4
	b	L279
	; Should not reach here - for alignment purpose only
	svc	#0x9f0001
	svc	#0x9f0001
	svc	#0x9f0001
	svc	#0x9f0001
	; Divisor < 0 return point
	rsb	r1, r1, #0
	bx	r2
	nop
	nop
	; Dividend < 0 return point
	rsb	r0, r0, #0
	rsb	r1, r1, #0
	bx	r2
	nop
	; Dividend < 0 && Divisor < 0 return point
	rsb	r0, r0, #0
	bx	r2
	nop
	nop
L277
	; We must check here if we were called from interpreter
	ldr	r2, =called_from_bc_idiv
	ldr	r3, =called_from_bc_irem
	cmp	lr, r2
	cmpne	lr, r3
	bne	L278
	; Put the arguments back on the stack
	str	r12, [r6, #-4]!
	str	r4, [fp, #-16]           ; store bcp in frame
	; Change state to tos_on_stack
	str	r0, [r6, #-4]!           ; uncache topmost element of stack
	; Fall through to compiler code
L278
	; Division by zero from the compiler
	IMPORT	division_by_zero_exception
	ldr	r3, =division_by_zero_exception
	b	shared_call_vm
	LTORG

	ENDP
	; End segment: Compiler idiv irem


	AREA |.text|, CODE
	ARM
	; ------------------------------------------------------
	; Start segment: Native entry points for math functions
	IMPORT	jvm_sin
	IMPORT	jvm_cos
	IMPORT	jvm_tan
	IMPORT	jvm_sqrt
	IMPORT	jvm_floor
	IMPORT	jvm_ceil

	EXPORT	native_math_sin_entry
native_math_sin_entry PROC
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r7, lr
	bl	jvm_sin
	mov	r2, #2
	bx	r7

	ENDP

	EXPORT	native_math_cos_entry
native_math_cos_entry PROC
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r7, lr
	bl	jvm_cos
	mov	r2, #2
	bx	r7

	ENDP

	EXPORT	native_math_tan_entry
native_math_tan_entry PROC
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r7, lr
	bl	jvm_tan
	mov	r2, #2
	bx	r7

	ENDP

	EXPORT	native_math_sqrt_entry
native_math_sqrt_entry PROC
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r7, lr
	bl	jvm_sqrt
	mov	r2, #2
	bx	r7

	ENDP

	EXPORT	native_math_ceil_entry
native_math_ceil_entry PROC
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r7, lr
	bl	jvm_ceil
	mov	r2, #2
	bx	r7

	ENDP

	EXPORT	native_math_floor_entry
native_math_floor_entry PROC
	ldr	r0, [r6], #4
	ldr	r1, [r6], #4
	mov	r7, lr
	bl	jvm_floor
	mov	r2, #2
	bx	r7
	LTORG

	ENDP
	; End segment: Native entry points for math functions


	; ------------------------------------------------------
	; Start segment: java.lang.String.charAt

	EXPORT	native_string_charAt_entry
native_string_charAt_entry PROC
	; r2 = string
	ldr	r2, [r6, #4]
	; r3 = index
	ldr	r3, [r6]
	; r4 = count
	ldr	r4, [r2, #12]
	; r9 = array
	ldr	r9, [r2, #4]
	; r10 = offset
	ldr	r10, [r2, #8]
	; if ((unsigned int) index >= (unsigned int) count) goto bailout;
	cmp	r3, r4
	bcs	L281
	; return: r0 = array[index + offset]
	add	r3, r3, r10
	add	r9, r9, r3, lsl #1
	ldrh	r0, [r9, #8]
	mov	r2, #1
	; remove arguments from the stack
	add	r6, r6, #8
	bx	lr
L281
	; Bail out to the general charAt() implementation
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: java.lang.String.charAt


	; ------------------------------------------------------
	; Start segment: java.lang.String(java.lang.StringBuffer)

	EXPORT	native_string_init_entry
native_string_init_entry PROC
	; Get string, buffer from stack
	ldmfd	r6!, {r1, r2}
	; Receiver or str are null?
	tst	r2, r1
	beq	L282
	ldmia	r1, {r3, r4, r10}
	ldr	r9, [r3, #8]
	mov	r12, #1
	; Check the buffer lock bit.
	ands	r9, r9, #1
	bne	L282
	; Note: r9 is zero at this point
	strb	r12, [r1, #12]
	stmib	r2, {r4, r9, r10}
	mov	r2, #0
	bx	lr
L282
	; Bail out to the general <init>() implementation
	stmfd	r6!, {r1, r2}
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: java.lang.String(java.lang.StringBuffer)


	; ------------------------------------------------------
	; Start segment: java.lang.String.equals(java.lang.Object)

	EXPORT	native_string_equals_entry
native_string_equals_entry PROC
	; get strings to compare
	ldr	r4, [r6], #4
	ldr	r2, [r6], #4
	; Null receiver?
	cmp	r2, #0
	beq	L288
	; Identity?
	cmp	r2, r4
	beq	L289
	; Null argument?
	cmp	r4, #0
	; Get str0.class, str1.class
	ldrne	r10, [r2]
	ldrne	r12, [r4]
	beq	L290
	cmp	r10, r12
	; Get str0.blueprint, str1.blueprint
	ldrne	r10, [r10]
	ldrne	r12, [r12]
	; Different classes?
	cmpne	r10, r12
	; Get str0.count, str1.count
	ldreq	r10, [r2, #12]
	ldreq	r12, [r4, #12]
	; Different length?
	cmpeq	r10, r12
	bne	L290
	; Get str0.value[], str1.value[]
	ldr	r3, [r2, #4]
	ldr	r9, [r4, #4]
	; Get str0.offset, str1.offset
	ldr	r2, [r2, #8]
	ldr	r4, [r4, #8]
	; Compute start of character data
	add	r3, r3, #8
	add	r9, r9, #8
	add	r3, r3, r2, lsl #1
	add	r9, r9, r4, lsl #1
	; Small string?
	cmp	r10, #2
	ble	L287
	; Both strings are aligned?
	orr	r12, r3, r9
	tst	r12, #3
	; Unaligned strings are uncommon - go out of the fast path ASAP
	bne	L286
L285
	; Get number of words
	movs	r10, r10, lsr #1
	; Count word-aligned?
	ldrcc	r2, [r3], #4
	ldrcc	r4, [r9], #4
	bcc	L283
	; Get offset of the last char
	mov	r12, r10, lsl #2
	; Compare last char
	ldrh	r2, [r3, +r12]
	ldrh	r4, [r9, +r12]
	cmp	r2, r4
	ldreq	r2, [r3], #4
	ldreq	r4, [r9], #4
	bne	L290
L283
	cmp	r2, r4
	bne	L290
	subs	r10, r10, #1
	ldrne	r2, [r3], #4
	ldrne	r4, [r9], #4
	beq	L289
	cmp	r2, r4
	bne	L290
	subs	r10, r10, #1
	ldrne	r2, [r3], #4
	ldrne	r4, [r9], #4
	bne	L283
L289
	; Return true
	mov	r0, #1
	mov	r2, #1
	; continue in caller
	bx	lr
L286
	; Check relative alignment
	eor	r12, r3, r9
	tst	r12, #3
	bne	L284
	; Strings are both unaligned
	; Compare first char and become word-aligned
	ldrh	r2, [r3], #2
	ldrh	r4, [r9], #2
	cmp	r2, r4
	subeq	r10, r10, #1
	beq	L285
L290
	; Return false
	mov	r0, #0
	mov	r2, #1
	; continue in caller
	bx	lr
L287
	; Empty string?
	cmp	r10, #0
	beq	L289
L284
	; Char-aligned loop
	ldrh	r2, [r3], #2
	ldrh	r4, [r9], #2
	cmp	r2, r4
	bne	L290
	subs	r10, r10, #1
	bne	L284
	; Return true
	mov	r0, #1
	mov	r2, #1
	; continue in caller
	bx	lr
L288
	; We have some sort of error
	str	r2, [r6, #-4]!
	str	r4, [r6, #-4]!
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: java.lang.String.equals(java.lang.Object)


	; ------------------------------------------------------
	; Start segment: java.lang.String.indexOf(java.lang.String)

	EXPORT	native_string_indexof0_string_entry
native_string_indexof0_string_entry PROC
	; Get receiver, str from stack
	ldmfd	r6!, {r2, r3}
	; Set fromIndex to zero
	mov	r1, #0
	; Neither receiver nor str are null?
	tst	r3, r2
	bne	L291
	; Bailout to interpreter
	stmfd	r6!, {r2, r3}
	b	interpreter_method_entry

	ENDP

	EXPORT	native_string_indexof_string_entry
native_string_indexof_string_entry PROC
	; Get receiver, str, fromIndex from stack
	ldmfd	r6!, {r1 - r3}
	; if (fromIndex < 0) { fromIndex = 0; }
	cmp	r1, #0
	movlt	r1, #0
	; Receiver or str are null?
	tst	r3, r2
	beq	L292
L291
	; Get this.count, str.count
	ldr	r4, [r3, #12]
	ldr	r9, [r2, #12]
	; fromIndex >= this.count ? - uncommon case
	cmp	r1, r4
	bge	L293
	; if (str.count <= 0) { return fromIndex; }
	cmp	r9, #0
	beq	L294
	; Get this.value[], str.value[]
	ldr	r10, [r3, #4]
	ldr	r12, [r2, #4]
	; Get this.offset, str.offset
	ldr	r3, [r3, #8]
	ldr	r2, [r2, #8]
	; Compute start of character data
	add	r10, r10, #8
	add	r12, r12, #8
	add	r10, r10, r3, lsl #1
	add	r12, r12, r2, lsl #1
	; Compute max pointer to start of a substring = 
	;     = this.value + this.offset + this.count - str.count
	sub	r0, r4, r9
	add	r0, r10, r0, lsl #1
	; Compute start of a substring = 
	;     = this.value + this.offset + fromIndex
	add	r1, r10, r1, lsl #1
	; Compute pointer after the end of substring = 
	;     = str.value + str.offset + str.count * 2
	add	r9, r12, r9, lsl #1
	; Load first character of a substring
	;  and increment pointer to substring start
	ldrh	r4, [r12], #2
	stmfd	sp!, {r5 - r7, lr}
	b	L295
L293
	; if (fromIndex >= count) {
	;     if (count == 0 && fromIndex == 0 && str.count == 0) {
	;         return 0;
	;     }
	;     return -1;
	; }
	orrs	r1, r1, r9
	mvnne	r1, #0
L294
	; Subtring found at fromIndex
	mov	r0, r1
	mov	r2, #1
	; continue in caller
	bx	lr
L296
	ldrh	r5, [r1], #2
	cmp	r5, r4
	beq	L297
L295
	cmp	r1, r0
	ble	L296
	; Substring not found - return -1;
	mvn	r0, #0
	mov	r2, #1
	; continue in caller
	ldmfd	sp!, {r5 - r7, pc}
L297
	mov	r7, r1
	mov	lr, r12
	b	L298
L299
	ldrh	r5, [r7], #2
	ldrh	r6, [lr], #2
	cmp	r5, r6
	bne	L295
L298
	cmp	lr, r9
	blt	L299
	; Substring found - return index;
	sub	r0, r1, r10
	sub	r0, r0, #2
	mov	r0, r0, lsr #1
	mov	r2, #1
	; continue in caller
	ldmfd	sp!, {r5 - r7, pc}
L292
	; Bailout to interpreter
	stmfd	r6!, {r1 - r3}
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: java.lang.String.indexOf(java.lang.String)


	; ------------------------------------------------------
	; Start segment: java.lang.String.indexOf

	EXPORT	native_string_indexof_entry
native_string_indexof_entry PROC
	; [[[Hand coded method from java.lang.String]]]
	;     public int indexOf(int ch) {
	;         return indexOf(ch, 0);
	;     }
	; return address is in lr
	ldr	r0, [r6], #4
	cmp	r0, #0
	movlt	r0, #0
	b	L300

	ENDP

	EXPORT	native_string_indexof0_entry
native_string_indexof0_entry PROC
	; [[[Hand coded method from java.lang.String]]]
	;     public int indexOf(int ch, int fromIndex) {
	;         int max = offset + count;
	;         char v[] = value;

	;         if (fromIndex < 0) {
	;             fromIndex = 0;
	;         } else if (fromIndex >= count) {
	;             // Note: fromIndex might be near -1>>>1.
	;             return -1;
	;         }
	;         for (int i = offset + fromIndex ; i < max ; i++) {
	;             if (v[i] == ch) {
	;                 return i - offset;
	;             }
	;         }
	;         return -1;
	;     }
	; return address is in lr
	; Get fromIndex, ch, string
	mov	r0, #0
L300
	ldr	r2, [r6], #4
	ldr	r3, [r6], #4
	ldr	r10, [r3, #12]
	ldr	r1, [r3, #4]
	ldr	r4, [r3, #8]
	cmp	r0, r10
	bge	L303
	add	r1, r1, #8
	add	r1, r1, r4, lsl #1
	add	r4, r1, r10, lsl #1
	mov	r10, r1
	add	r1, r1, r0, lsl #1
L301
	ldrh	r0, [r1]
	add	r1, r1, #2
	cmp	r0, r2
	beq	L304
L302
	cmp	r1, r4
	blt	L301
L303
	; return -1;
	mvn	r0, #0
	mov	r2, #1
	; continue in caller
	bx	lr
L304
	; return i - offset;
	sub	r0, r1, r10
	mov	r0, r0, lsr #1
	sub	r0, r0, #1
	mov	r2, #1
	; continue in caller
	bx	lr
	LTORG

	ENDP
	; End segment: java.lang.String.indexOf


	; ------------------------------------------------------
	; Start segment: java.lang.String.compareTo

	EXPORT	native_string_compareTo_entry
native_string_compareTo_entry PROC
	; get strings to compare
	ldr	r4, [r6], #4
	ldr	r2, [r6], #4
	cmp	r4, #0
	beq	L307
	; Get str0.value[], str1.value[]
	ldr	r3, [r2, #4]
	ldr	r9, [r4, #4]
	; Get str0.offset[], str1.offset[]
	ldr	r10, [r2, #8]
	ldr	r12, [r4, #8]
	; Get str0.count[], str1.count[]
	ldr	r2, [r2, #12]
	ldr	r4, [r4, #12]
	; Compute start of character data
	add	r3, r3, #8
	add	r9, r9, #8
	add	r3, r3, r10, lsl #1
	add	r9, r9, r12, lsl #1
	; Compute min(str0_count, str1_count)
	subs	r0, r2, r4
	movlt	r1, r2
	movge	r1, r4
	; Is at least one string empty?
	cmp	r1, #0
	beq	L306
L305
	ldrh	r10, [r3], #2
	ldrh	r12, [r9], #2
	subs	r0, r10, r12
	bne	L306
	subs	r1, r1, #1
	bne	L305
	sub	r0, r2, r4
L306
	mov	r2, #1
	; continue in caller
	bx	lr
L307
	; We have some sort of error. Redo in Java version of compareTo()
	str	r2, [r6, #-4]!
	str	r4, [r6, #-4]!
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: java.lang.String.compareTo


	; ------------------------------------------------------
	; Start segment: java.lang.String.{starts,ends}With

	EXPORT	native_string_endsWith_entry
native_string_endsWith_entry PROC
	; [[[Hand coded method from java.lang.String]]]
	;     public boolean endsWith(String suffix) {
	;         return startsWith(suffix, count - suffix.count);
	;     }
	; return address is in lr
	; get suffix and this String
	ldr	r4, [r6], #4
	ldr	r3, [r6], #4
	cmp	r4, #0
	beq	L309
	; Get this.count[], suffix.count[]
	ldr	r9, [r3, #12]
	ldr	r2, [r4, #12]
	; Preserve return address
	mov	r10, lr
	; Calculate (this.count - suffix.count) for toffset
	sub	r12, r9, r2
	b	L308
L309
	; Bail out to the general endsWith implementation
	str	r3, [r6, #-4]!
	str	r4, [r6, #-4]!
	b	interpreter_method_entry

	ENDP

	EXPORT	native_string_startsWith0_entry
native_string_startsWith0_entry PROC
	; [[[Hand coded method from java.lang.String]]]
	;     public boolean startsWith(String prefix) {
	;         return startsWith(prefix, 0);
	;     }
	; return address is in lr
	; get prefix and this String
	ldr	r4, [r6], #4
	ldr	r3, [r6], #4
	cmp	r4, #0
	; zero for toffset
	movne	r12, #0
	bne	L310
	; Bail out to the general startsWith implementation
	str	r3, [r6, #-4]!
	str	r4, [r6, #-4]!
	b	interpreter_method_entry

	ENDP

	EXPORT	native_string_startsWith_entry
native_string_startsWith_entry PROC
	; get toffset, prefix, this String
	ldr	r12, [r6], #4
	ldr	r4, [r6], #4
	ldr	r3, [r6], #4
	cmp	r4, #0
	beq	L311
L310
	; Get this.count[], prefix.count[]
	ldr	r9, [r3, #12]
	ldr	r2, [r4, #12]
	; Preserve return address
	mov	r10, lr
	; if (toffset > this.count - prefix.count) return false;
	sub	r9, r9, r2
	cmp	r9, r12
	blt	L312
L308
	cmp	r12, #0
	blt	L312
	; Get this.value[], prefix.value[]
	ldr	r0, [r3, #4]
	ldr	r1, [r4, #4]
	; Get this.offset[], prefix.offset[]
	ldr	r9, [r3, #8]
	ldr	lr, [r4, #8]
	; Compute start of character data
	add	r0, r0, #8
	add	r1, r1, #8
	add	r0, r0, r9, lsl #1
	add	r1, r1, lr, lsl #1
	; Add toffset
	add	r0, r0, r12, lsl #1
	; Compute the number of bytes to compare
	mov	r2, r2, lsl #1
	bl	jvm_memcmp
	cmp	r0, #0
	moveq	r0, #1
L312
	movne	r0, #0
	mov	r2, #1
	; continue in caller
	bx	r10
L311
	; Bail out to the general startsWith implementation
	str	r3, [r6, #-4]!
	str	r4, [r6, #-4]!
	str	r12, [r6, #-4]!
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: java.lang.String.{starts,ends}With


	; ------------------------------------------------------
	; Start segment: other java.lang.String entries

	EXPORT	native_string_substringI_entry
native_string_substringI_entry PROC
	ldr	r2, [r6, #4]             ; r2 = string
	ldr	r3, [r6]                 ; r3 = beginIndex
	ldr	r4, [r2, #12]            ; r4 = endIndex
	ldr	r9, [r2, #12]            ; r9 = count
	; if (beginIndex < 0)          goto bailout;
	; if (endIndex   < beginIndex) goto bailout;
	; if (count      < endIndex)   goto bailout;
	cmp	r3, #0
	cmpge	r4, r3
	cmpge	r9, r4
	blt	L313
	ldr	r10, [r5, #1060]         ; inline_allocation_top 
	ldr	r12, [r5, #1064]         ; inline_allocation_end 
	cmp	r3, #0
	cmpeq	r4, r9
	beq	L314
	subs	r12, r12, #16
	bmi	L313
	cmp	r12, r10
	ldr	r7, [r2]                 ; r7 = string.near()
	ldr	r12, [r2, #8]            ; r12 = string.offset
	bcc	L313
	ldr	r7, [r7]                 ; r7 = string class
	sub	r4, r4, r3
	str	r4, [r10, #12]           ; result.count = endIndex - beginIndex
	ldr	r7, [r7, #12]            ; r7 = string proto near
	ldr	r4, [r2, #4]             ; r4 = string.value
	add	r12, r12, r3
	str	r12, [r10, #8]           ; result.offset = offset + beginIndex
	str	r7, [r10]                ; result.klass = String proto near
	str	r4, [r10, #4]            ; result.value = string.value
	mov	r0, r10                  ; return new string in r0
	add	r10, r10, #16
	str	r10, [r5, #1060]         ; inline_allocation_top 
	mov	r2, #1
	; remove arguments from the stack
	add	r6, r6, #8
	bx	lr
L314
	; return <this>
	mov	r0, r2
	mov	r2, #1
	; remove arguments from the stack
	add	r6, r6, #8
	bx	lr
L313
	; Bail out to the general startsWith implementation
	b	interpreter_method_entry

	ENDP

	EXPORT	native_string_substringII_entry
native_string_substringII_entry PROC
	ldr	r2, [r6, #8]             ; r2 = string
	ldr	r3, [r6, #4]             ; r3 = beginIndex
	ldr	r4, [r6]                 ; r4 = endIndex
	ldr	r9, [r2, #12]            ; r9 = count
	; if (beginIndex < 0)          goto bailout;
	; if (endIndex   < beginIndex) goto bailout;
	; if (count      < endIndex)   goto bailout;
	cmp	r3, #0
	cmpge	r4, r3
	cmpge	r9, r4
	blt	L315
	ldr	r10, [r5, #1060]         ; inline_allocation_top 
	ldr	r12, [r5, #1064]         ; inline_allocation_end 
	cmp	r3, #0
	cmpeq	r4, r9
	beq	L316
	subs	r12, r12, #16
	bmi	L315
	cmp	r12, r10
	ldr	r7, [r2]                 ; r7 = string.near()
	ldr	r12, [r2, #8]            ; r12 = string.offset
	bcc	L315
	ldr	r7, [r7]                 ; r7 = string class
	sub	r4, r4, r3
	str	r4, [r10, #12]           ; result.count = endIndex - beginIndex
	ldr	r7, [r7, #12]            ; r7 = string proto near
	ldr	r4, [r2, #4]             ; r4 = string.value
	add	r12, r12, r3
	str	r12, [r10, #8]           ; result.offset = offset + beginIndex
	str	r7, [r10]                ; result.klass = String proto near
	str	r4, [r10, #4]            ; result.value = string.value
	mov	r0, r10                  ; return new string in r0
	add	r10, r10, #16
	str	r10, [r5, #1060]         ; inline_allocation_top 
	mov	r2, #1
	; remove arguments from the stack
	add	r6, r6, #12
	bx	lr
L316
	; return <this>
	mov	r0, r2
	mov	r2, #1
	; remove arguments from the stack
	add	r6, r6, #12
	bx	lr
L315
	; Bail out to the general startsWith implementation
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: other java.lang.String entries


	; ------------------------------------------------------
	; Start segment: Native entry points for system functions

	EXPORT	native_system_arraycopy_entry
native_system_arraycopy_entry PROC
	; load arguments to registers
	; r1 = src
	ldr	r1, [r6, #16]
	; r7 = dst
	ldr	r7, [r6, #8]
	; r2 = length
	ldr	r2, [r6]
	; r4 = dst_pos
	ldr	r4, [r6, #4]
	; r3 = src_pos
	ldr	r3, [r6, #12]
	; if (src == NULL || dst == NULL) goto bailout;
	cmp	r1, #0
	cmpne	r7, #0
	beq	L317
	; Get src.klass() and dst.klass()
	ldr	r9, [r1]
	ldr	r10, [r7]
	ldr	r9, [r9]
	ldr	r10, [r10]
	; if (length < 0 || src_pos < 0 || dst_pos < 0) goto bailout;
	orr	r12, r2, r3
	orrs	r12, r12, r4
	bmi	L317
	; if (src.klass() != dst.klass()) goto bailout;
	cmp	r9, r10
	bne	L317
	; Make sure we really have an array.
	; Java objects have an instance size >= 0
	ldrsh	r12, [r9, #6]
	cmp	r12, #0
	bge	L317
	; if ((unsigned int) src.length < (unsigned int) src_pos + (unsigned int) length) goto bailout;
	ldr	r9, [r1, #4]
	add	r10, r3, r2
	cmp	r9, r10
	bcc	L317
	; if ((unsigned int) dst.length < (unsigned int) dst_pos + (unsigned int) length) goto bailout;
	ldr	r9, [r7, #4]
	add	r10, r4, r2
	cmp	r9, r10
	bcc	L317
	; remove arguments from the stack
	add	r6, r6, #20
	; Point at actual data
	add	r1, r1, #8
	add	r7, r7, #8
	; Jump to appropriate copy routine if length > 0
	subs	r2, r2, #1
	; Length > 0.  Jump to appropriate routine;
	ldrge	pc, [pc, -r12, lsl #2]
	; Length == 0.  Just return
	blt	L319
	DCD	L326
	DCD	L324
	DCD	L320
	DCD	L321
	DCD	L322
	DCD	L323
	; No fallthrough
	svc	#0x9f0001

	ENDP

	EXPORT	native_jvm_unchecked_byte_arraycopy_entry
native_jvm_unchecked_byte_arraycopy_entry PROC
	; Pop arguments from stack
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r7, [r6], #4
	ldr	r3, [r6], #4
	ldr	r1, [r6], #4
	subs	r2, r2, #1
	; Length == 0.  Just return
	blt	L319
	; Point at actual data
	add	r7, r7, #8
	add	r1, r1, #8
L320
	; Each element of the array is 1 byte(s)
	add	r0, r7, r4
	add	r1, r1, r3
	add	r2, r2, #1
	mov	r7, lr
	bl	jvm_memcpy
	; fill the top of stack cache and return
	mov	r2, #0
	bx	r7
	; No fallthrough
	svc	#0x9f0001

	ENDP

	EXPORT	native_jvm_unchecked_char_arraycopy_entry
native_jvm_unchecked_char_arraycopy_entry PROC
	; Pop arguments from stack
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r7, [r6], #4
	ldr	r3, [r6], #4
	ldr	r1, [r6], #4
	subs	r2, r2, #1
	; Length == 0.  Just return
	blt	L319
	; Point at actual data
	add	r7, r7, #8
	add	r1, r1, #8
L321
	; Each element of the array is 2 byte(s)
	add	r0, r7, r4, lsl #1
	add	r1, r1, r3, lsl #1
	add	r2, r2, #1
	mov	r2, r2, lsl #1
	mov	r7, lr
	bl	jvm_memcpy
	; fill the top of stack cache and return
	mov	r2, #0
	bx	r7
	; No fallthrough
	svc	#0x9f0001

	ENDP

	EXPORT	native_jvm_unchecked_int_arraycopy_entry
native_jvm_unchecked_int_arraycopy_entry PROC
	; Pop arguments from stack
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r7, [r6], #4
	ldr	r3, [r6], #4
	ldr	r1, [r6], #4
	subs	r2, r2, #1
	; Length == 0.  Just return
	blt	L319
	; Point at actual data
	add	r7, r7, #8
	add	r1, r1, #8
L325
L322
	; Each element of the array is 4 byte(s)
	add	r0, r7, r4, lsl #2
	add	r1, r1, r3, lsl #2
	add	r2, r2, #1
	mov	r2, r2, lsl #2
	mov	r7, lr
	bl	jvm_memcpy
	; fill the top of stack cache and return
	mov	r2, #0
	bx	r7
	; No fallthrough
	svc	#0x9f0001

	ENDP

	EXPORT	native_jvm_unchecked_long_arraycopy_entry
native_jvm_unchecked_long_arraycopy_entry PROC
	; Pop arguments from stack
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r7, [r6], #4
	ldr	r3, [r6], #4
	ldr	r1, [r6], #4
	subs	r2, r2, #1
	; Length == 0.  Just return
	blt	L319
	; Point at actual data
	add	r7, r7, #8
	add	r1, r1, #8
L323
	; Each element of the array is 8 byte(s)
	add	r0, r7, r4, lsl #3
	add	r1, r1, r3, lsl #3
	add	r2, r2, #1
	mov	r2, r2, lsl #3
	mov	r7, lr
	bl	jvm_memcpy
	; fill the top of stack cache and return
	mov	r2, #0
	bx	r7
	; No fallthrough
	svc	#0x9f0001

	ENDP

	EXPORT	native_jvm_unchecked_obj_arraycopy_entry
native_jvm_unchecked_obj_arraycopy_entry PROC
	; Pop arguments from stack
	ldr	r2, [r6], #4
	ldr	r4, [r6], #4
	ldr	r7, [r6], #4
	ldr	r3, [r6], #4
	ldr	r1, [r6], #4
	subs	r2, r2, #1
	; Length == 0.  Just return
	blt	L319
	; Point at actual data
	add	r7, r7, #8
	add	r1, r1, #8
L324
	; If dst is in new space, there's no need to set bitvector
	ldr	r12, [r5, #1248]         ; old_generation_end 
	cmp	r7, r12
	bge	L325
	; if (src == dst) && (src_pos < dst_pos) goto copy_downwards;
	cmp	r1, r7
	bne	L328
	cmp	r3, r4
	blt	L327
L328
	; Copy the elements starting from low address upwards
	; Point to the (inclusive) low-end of elements to copy
	add	r1, r1, r3, lsl #2
	add	r7, r7, r4, lsl #2
L329
	; r2 is one less than the number of elements still to copy
	; Are we copying at least eight elements?
	cmp	r2, #7
	blt	L332
	; Is the destination aligned?
	tst	r7, #28
	bne	L331
	; We have at least 8 words to copy, and the dst is aligned
	ldr	r12, [r5, #1076]         ; bitvector_base 
	mvn	r0, #0
	; The main copy loop copies 32 elements each iteration.
	; If don't have (n*32 + {0..7}) elements, jump to the
	; middle of the array
	add	r10, r2, #1
	and	r10, r10, #24
	cmp	r10, #8
	beq	L335
	cmp	r10, #16
	beq	L334
	cmp	r10, #24
	beq	L333
L330
	strb	r0, [r12, +r7, lsr #5]
	ldmia	r1!, {r3, r4, r9, r10}
	stmia	r7!, {r3, r4, r9, r10}
	ldmia	r1!, {r3, r4, r9, r10}
	stmia	r7!, {r3, r4, r9, r10}
	sub	r2, r2, #8
L333
	strb	r0, [r12, +r7, lsr #5]
	ldmia	r1!, {r3, r4, r9, r10}
	stmia	r7!, {r3, r4, r9, r10}
	ldmia	r1!, {r3, r4, r9, r10}
	stmia	r7!, {r3, r4, r9, r10}
	sub	r2, r2, #8
L334
	strb	r0, [r12, +r7, lsr #5]
	ldmia	r1!, {r3, r4, r9, r10}
	stmia	r7!, {r3, r4, r9, r10}
	ldmia	r1!, {r3, r4, r9, r10}
	stmia	r7!, {r3, r4, r9, r10}
	sub	r2, r2, #8
L335
	strb	r0, [r12, +r7, lsr #5]
	ldmia	r1!, {r3, r4, r9, r10}
	stmia	r7!, {r3, r4, r9, r10}
	ldmia	r1!, {r3, r4, r9, r10}
	stmia	r7!, {r3, r4, r9, r10}
	subs	r2, r2, #8
	blt	L319
	cmp	r2, #7
	bge	L330
L332
	; Copying less than 8 elements
	ldr	r10, [r1], #4
	mov	r9, r7
	str	r10, [r7], #4
	; oop_write_barrier
	ldr	r10, [r5, #1076]         ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r4, [r10, +r9, lsr #5]!
	mvn	r9, r9, lsr #2
	orr	r4, r4, r3, ror r9
	strb	r4, [r10]
	subs	r2, r2, #1
	bge	L332
	mov	r2, #0
	bx	lr
L331
	; length >= 8, but dst not aligned
	ldr	r10, [r1], #4
	mov	r9, r7
	str	r10, [r7], #4
	; oop_write_barrier
	ldr	r10, [r5, #1076]         ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r4, [r10, +r9, lsr #5]!
	mvn	r9, r9, lsr #2
	orr	r4, r4, r3, ror r9
	strb	r4, [r10]
	sub	r2, r2, #1
	b	L329
	; Copy the elements starting from high address downwards
L327
	; Point to the (inclusive) low-end of elements to copy
	add	r1, r1, r3, lsl #2
	add	r7, r7, r4, lsl #2
	; Point to the (exclusive) high-end of elements
	; r2 is one less than the number of elements still to copy
	add	r1, r1, r2, lsl #2
	add	r7, r7, r2, lsl #2
	add	r1, r1, #4
	add	r7, r7, #4
L336
	; r2 is one less than the number of elements still to copy
	; Are we copying at least eight elements?
	cmp	r2, #7
	blt	L339
	; Is the destination aligned?
	tst	r7, #28
	bne	L338
	; We have at least 8 words to copy, and the dst is aligned
	ldr	r12, [r5, #1076]         ; bitvector_base 
	mvn	r0, #0
	; The main copy loop copies 32 elements each iteration.
	; If don't have (n*32 + {0..7}) elements, jump to the
	; middle of the array
	add	r10, r2, #1
	and	r10, r10, #24
	cmp	r10, #8
	beq	L342
	cmp	r10, #16
	beq	L341
	cmp	r10, #24
	beq	L340
L337
	ldmdb	r1!, {r3, r4, r9, r10}
	stmdb	r7!, {r3, r4, r9, r10}
	ldmdb	r1!, {r3, r4, r9, r10}
	stmdb	r7!, {r3, r4, r9, r10}
	strb	r0, [r12, +r7, lsr #5]
	sub	r2, r2, #8
L340
	ldmdb	r1!, {r3, r4, r9, r10}
	stmdb	r7!, {r3, r4, r9, r10}
	ldmdb	r1!, {r3, r4, r9, r10}
	stmdb	r7!, {r3, r4, r9, r10}
	strb	r0, [r12, +r7, lsr #5]
	sub	r2, r2, #8
L341
	ldmdb	r1!, {r3, r4, r9, r10}
	stmdb	r7!, {r3, r4, r9, r10}
	ldmdb	r1!, {r3, r4, r9, r10}
	stmdb	r7!, {r3, r4, r9, r10}
	strb	r0, [r12, +r7, lsr #5]
	sub	r2, r2, #8
L342
	ldmdb	r1!, {r3, r4, r9, r10}
	stmdb	r7!, {r3, r4, r9, r10}
	ldmdb	r1!, {r3, r4, r9, r10}
	stmdb	r7!, {r3, r4, r9, r10}
	strb	r0, [r12, +r7, lsr #5]
	subs	r2, r2, #8
	blt	L319
	cmp	r2, #7
	bge	L337
L339
	; Copying less than 8 elements
	ldr	r10, [r1, #-4]!
	str	r10, [r7, #-4]!
	mov	r9, r7
	; oop_write_barrier
	ldr	r10, [r5, #1076]         ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r4, [r10, +r9, lsr #5]!
	mvn	r9, r9, lsr #2
	orr	r4, r4, r3, ror r9
	strb	r4, [r10]
	subs	r2, r2, #1
	bge	L339
	mov	r2, #0
	bx	lr
L338
	; length >= 8, but dst not aligned
	ldr	r10, [r1, #-4]!
	str	r10, [r7, #-4]!
	mov	r9, r7
	; oop_write_barrier
	ldr	r10, [r5, #1076]         ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r4, [r10, +r9, lsr #5]!
	mvn	r9, r9, lsr #2
	orr	r4, r4, r3, ror r9
	strb	r4, [r10]
	sub	r2, r2, #1
	b	L336
L319
	mov	r2, #0
	bx	lr
L326
	; Shouldn't call this
	svc	#0x9f0001
L318
	; Recover original parameters
	sub	r6, r6, #20
	sub	r1, r1, #8
	sub	r7, r7, #8
	add	r2, r2, #1
L317
	; Bail out to the general arraycopy implementation
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: Native entry points for system functions


	; ------------------------------------------------------
	; Start segment: StringBuffer.append

	EXPORT	native_stringbuffer_append_entry
native_stringbuffer_append_entry PROC
	; Get the object.
	ldr	r2, [r6, #4]
	; Get the near.
	ldr	r3, [r2]
	ldr	r9, [r2, #4]
	ldr	r3, [r3, #8]
	ldr	r4, [r2, #8]
	; Check the lock bit.
	tst	r3, #1
	bne	interpreter_method_entry
	; Check for insufficient capacity of the stringbuffer.
	ldr	r3, [r9, #4]
	add	r9, r9, r4, lsl #1
	cmp	r4, r3
	bge	interpreter_method_entry
	; Increment the count, append the char.
	ldr	r3, [r6]
	add	r4, r4, #1
	str	r4, [r2, #8]
	strh	r3, [r9, #8]
	; Return the object.
	mov	r0, r2
	mov	r2, #1
	add	r6, r6, #8
	bx	lr
	LTORG

	ENDP
	; End segment: StringBuffer.append


	; ------------------------------------------------------
	; Start segment: Integer.toString

	EXPORT	native_integer_toString_entry
native_integer_toString_entry PROC
	; Find the size of inline allocation area to see if it is large
	; enough to create new String object with associated char[] array
	ldr	r4, [r5, #1060]          ; inline_allocation_top 
	ldr	r12, [r5, #1064]         ; inline_allocation_end 
	add	r9, r4, #48
	cmp	r9, r12
	bhi	interpreter_method_entry
	; Get JavaNear prototype for String and char[] from persistent handles
	IMPORT	persistent_handles
	ldr	r12, =persistent_handles
	str	r9, [r5, #1060]          ; inline_allocation_top 
	ldr	r2, [r12, #176]
	ldr	r3, [r12, #68]
	ldr	r2, [r2, #12]
	ldr	r3, [r3, #12]
	; Fill in all the fields we know
	str	r2, [r4], #16            ; set String JavaNear
	str	r3, [r4]                 ; set char[] JavaNear
	str	r4, [r4, #-12]           ; set String.value to be our char[]
	mov	r12, #12                 ; set length field of char[] array
	str	r12, [r4, #4]
	; Get the argument from Java stack
	ldr	r0, [r6], #4
	; Remember the position of the last digit
	mov	r10, r9, lsr #1
	; Load the magic constant for integer divsion by 10
	ldr	r12, L344
	; Make the argument non-negative
	ands	r1, r0, #0x80000000
	rsbmi	r0, r0, #0
	; Perform integer division by 10 in the loop
	; and store digits in char[] array from right to left.
	; Dividend is in r0, remainder is in r2
L343
	umull	r2, r3, r0, r12
	add	r2, r0, #48
	movs	r0, r3, lsr #3
	sub	r2, r2, r0, lsl #3
	sub	r2, r2, r0, lsl #1
	strh	r2, [r9, #-2]!
	bne	L343
	; Add '-' sign if the original number was negative
	orrs	r1, r1, #45
	strmih	r1, [r9, #-2]!
	; Fill in remained fields
	sub	r0, r4, #16              ; pointer to result string
	sub	r9, r10, r9, lsr #1      ; set String.count
	str	r9, [r0, #12]
	rsb	r9, r9, #12              ; set String.offset
	str	r9, [r0, #8]
	; Return to caller
	mov	r2, #1
	bx	lr
L344
	DCD	0xcccccccd
	LTORG

	ENDP
	; End segment: Integer.toString


	; ------------------------------------------------------
	; Start segment: Native entry points for miscellaneous functions

	EXPORT	native_vector_elementAt_entry
native_vector_elementAt_entry PROC
	ldr	r2, [r6, #4]
	ldr	r3, [r6]
	; Get the near object.
	ldr	r4, [r2]
	ldr	r9, [r2, #8]
	ldr	r4, [r4, #8]
	; Check for out of range index.
	cmp	r3, r9
	bcs	interpreter_method_entry
	; Check the lock bit.
	tst	r4, #1
	ldreq	r9, [r2, #4]
	bne	interpreter_method_entry
	; Get the object and return.
	add	r0, r9, r3, lsl #2
	ldr	r0, [r0, #8]
	mov	r2, #1
	; continue in caller
	add	r6, r6, #8
	bx	lr

	ENDP

	EXPORT	native_vector_addElement_entry
native_vector_addElement_entry PROC
	IMPORT	memset
	; Get this Vector object
	ldr	r2, [r6, #4]
	; Load r3 = Near, r4 = elementData and r9 = elementCount
	ldmia	r2, {r3, r4, r9}
	; Check if the object is locked
	ldr	r3, [r3, #8]
	ldr	r12, [r4, #4]
	tst	r3, #1
	bne	interpreter_method_entry
	; Check if elementCount < elementData.length
	cmp	r9, r12
	bcs	L345
	; Usual case: put new element in existing elementData array
	ldr	r10, [r6]
	add	r4, r4, r9, lsl #2
	str	r10, [r4, #8]!
	; oop_write_barrier
	ldr	r10, [r5, #1076]         ; bitvector_base 
	ldr	r3, [r5, #1080]          ; bit_selector 
	ldrb	r12, [r10, +r4, lsr #5]!
	mvn	r4, r4, lsr #2
	orr	r12, r12, r3, ror r4
	strb	r12, [r10]
	add	r9, r9, #1
	str	r9, [r2, #8]
	; Return to caller
	mov	r2, #0
	add	r6, r6, #8
	bx	lr
L345
	; Need to increase Vector capacity
	ldr	r3, [r2, #12]
	ldr	r1, [r5, #1060]          ; inline_allocation_top 
	cmp	r3, #0
	addgt	r3, r3, r12
	addles	r3, r12, r12
	addeq	r3, r9, #1
	; Check if we have enough space in inline allocation area
	ldr	r10, [r5, #1064]         ; inline_allocation_end 
	add	r12, r1, #8
	add	r12, r12, r3, lsl #2
	cmp	r10, r12
	bcc	interpreter_method_entry
	; Create a new ObjArray with increased length
	str	r12, [r5, #1060]         ; inline_allocation_top 
	ldr	r10, [r4]
	str	r3, [r1, #4]
	str	r10, [r1]
	; Update fields of this Vector object
	add	r10, r9, #1
	str	r10, [r2, #8]
	str	r1, [r2, #4]!
	; oop_write_barrier
	ldr	r0, [r5, #1076]          ; bitvector_base 
	ldr	r10, [r5, #1080]         ; bit_selector 
	ldrb	r12, [r0, +r2, lsr #5]!
	mvn	r2, r2, lsr #2
	orr	r12, r12, r10, ror r2
	strb	r12, [r0]
	; Copy old Vector data - prepare registers for jvm_memcpy
	add	r0, r1, #8
	add	r1, r4, #8
	mov	r2, r9, lsl #2
	adds	r4, lr, #0
	sbc	r9, r3, r9
	add	r10, r0, r2
	bl	jvm_memcpy
	; Put new element into the Vector
	ldr	r1, [r6]
	add	r6, r6, #8
	str	r1, [r10]
	; Return to caller
	mov	r2, #0
	bx	r4
	LTORG

	ENDP
	; End segment: Native entry points for miscellaneous functions


	AREA |.text|, CODE
	ARM
	; ------------------------------------------------------
	; Start segment: Floating point routines

	EXPORT	jvm_fadd
jvm_fadd PROC
	stmfd	sp!, {r4 - r7}
	mov	r12, #255
	; Extract exponent1
	and	r4, r12, r0, lsr #23
	; Extract exponent2
	and	r5, r12, r1, lsr #23
	mvn	r12, #0xc0000000
	; Extract mantissa1
	and	r6, r12, r0, lsl #7
	; Extract mantissa2
	and	r7, r12, r1, lsl #7
	; Check if float1 or float2 is NaN or infinity:
	cmp	r4, #255
	cmpne	r5, #255
	beq	L346
	; Check for zeroes or denormalized numbers
	cmp	r4, #0
	beq	L349
	; Else, set implied high bit
	orr	r6, r6, #0x40000000
L352
	cmp	r5, #0
	beq	L350
	; Else, set implied high bit
	orr	r7, r7, #0x40000000
L353
	; Make sure the magnitude of float1 is larger than the magnitude of 
	; float2.  If not, then swap the two
	; Compare exponents
	cmp	r4, r5
	; Compare mantissas
	cmpeq	r6, r7
	blt	L355
L354
	; r12 = order of magnitude difference
	sub	r12, r4, r5
	cmp	r12, #7
	; At this point, EXP2 is free to be used as a scratch
	; Adjust float2 to the same order of magnitude as float1 if OK 
	; to do so
	movle	r7, r7, lsr r12
	ble	L356
	; Save the excess bits shifted out from MANT2. 
	; All we care about is whether they are 0 or not
	cmp	r12, #32
	rsblt	r3, r12, #32
	movlt	r3, r7, lsl r3
	movge	r3, r7
	; Adjust float2 to the same order of magnitude as float1
	mov	r7, r7, lsr r12
	cmp	r3, #0
	; Adjust for rounding later
	orrne	r7, r7, #16
L356
	; Set the result sign in r0
	; Set r0 = result sign
	and	r0, r0, #0x80000000
	; We now move the implied binary point to between bit 31 and 30 
	; (i.e. left by one).  We need to compensate for this by 
	; incrementing the exponent
	add	r4, r4, #1
	; Check if the signs are the same
	; @ Check if the sign bit is the same
	eors	r12, r0, r1
	; High bit will not be set if same
	bpl	L357
L358
	; Subtract and set condition codes
	subs	r6, r6, r7
	; If zero, then go return zero
	beq	L359
L361
	; If we get here, then we know MANT1 is not zero.  It's OK to keep 
	; shifting until we find a bit because there is bound to be 1 within 
	; the 32 bits of MANT1
L362
	; Else, normalized if necessary
	cmp	r4, #1
	; Cannot normalize, go wrap-up
	beq	_floatRoundResult
	; Shift left by 1
	adds	r6, r6, r6
	sub	r4, r4, #1
	; If implied high bit is not found
	bpl	L362
	; continue looking
	; then go do rounding
	b	_floatRoundResult
L357
	; If we get here, the signs are the same.  We can just add both 
	; numbers as if they are positive numbers, and then reapply the 
	; original when we're done 
	; Add and set condition codes
	adds	r6, r6, r7
	; If high bit is not set, go normalize
	bpl	L361
	; Go round result
	b	_floatRoundResult
L355
	; Swap the values in { float1, exponent1, mantissa1 } with the values 
	; in { float2, exponent2, mantissa2 }
	mov	r12, r4
	mov	r4, r5
	mov	r5, r12
	mov	r12, r6
	mov	r6, r7
	mov	r7, r12
	mov	r12, r0
	mov	r0, r1
	mov	r1, r12
	b	L354
L349
	; Check if float1 is zero
	cmp	r6, #0
	; float1 is zero
	beq	L351
	mov	r4, #1
	; float1 is not zero
	b	L352
L351
	; Check if float2 is also zero
	cmp	r5, #0
	; float2 not zero.  Return float2
	bne	L360
	cmp	r7, #0
	; float2 not zero.  Return float2
	bne	L360
	; Fall through to returnZero
L359
	; Massage the signs
	and	r0, r0, r1
	; Else return 0 with sign of the larger number (magnitude-wise)
	and	r0, r0, #0x80000000
	ldmfd	sp!, {r4 - r7}
	bx	lr
L350
	; check to see if float2 is zero
	cmp	r7, #0
	; If 0, return float1 in r0
	ldmeqfd	sp!, {r4 - r7}
	bxeq	lr
	; Else, not zero.  Adjust EXP2 because it is implied to be 1
	mov	r5, #1
	b	L353
L346
	; Check if float1 is NaN or infinity
	; Check for infinity or nan
	cmp	r4, #255
	beq	L347
	; Else, float2 is NaN or infinity
L348
	; If we get here, then we know that float1 is finite.  The result 
	; will be what ever is in float2 (i.e. infinity or NaN)
L360
	; result = float2
	mov	r0, r1
	; Return the result
	ldmfd	sp!, {r4 - r7}
	bx	lr
L347
	; Check if float1 is an infinity
	cmp	r6, #0
	; If not an infinity, then must be a NaN: 
	; The return value in r0 is a NaN already because r0 contains the 
	; value of float1 which is a Nan

	; result = NaN + ? => NaN
	ldmnefd	sp!, {r4 - r7}
	bxne	lr
	; If we get here, than float1 is an infinity.  We must return check 
	; if float2 is a NaN or an infinity or finite
	cmp	r5, #255
	; If is finite (i.e. not NaN or infinity), then just return the 
	; infinity value in float1 which is already in r0
	ldmnefd	sp!, {r4 - r7}
	bxne	lr
	; Check if float2 is an infinity
	cmp	r7, #0
	; If not an infinity, then must be a NaN
	; Return the NaN in float2
	movne	r0, r1
	ldmnefd	sp!, {r4 - r7}
	bxne	lr
	; We have 2 infinities
	; NOTE: MMASK<r12> is no longer needed.
	; Check if the sign bit is the same.
	eors	r12, r0, r1
	; If the sign bit is the same, both are +Inf or both are -Inf.
	; Just return float1. I.e., Inf+Inf = Inf; -Inf-Inf = -Inf.
	; Otherwise, return NaN
	movmi	r0, #0x3fc00000
	addmi	r0, r0, #0x40000000
	ldmfd	sp!, {r4 - r7}
	bx	lr

	EXPORT	_floatRoundResult
_floatRoundResult
	; NOTE: floatRoundResult expects the sign in r0, the exponent in 
	; EXP1 (i.e. r2), and the normalized mantissa in MANT1 
	; with the binary point between bit 31 and 30
	; round the mantissa using IEEE 754 round to nearest mode
	; Extract the low 8 bits for rounding
	and	r12, r6, #255
	cmp	r12, #128
	; Round down.  Nothing to do
	blt	L363
	; Go round up
	bgt	L364
	; Else round to the nearest 0 in the LSBit in the result mantissa
	; Check LSBit of result mantissa
	tst	r6, #0x100
	; If already 0, then done rounding, else, round up
	beq	L363
L364
	adds	r6, r6, #128
	; After rounding, we have to re-check if we're normalized, and 
	; re-normalize if we're not
	bcc	L363
	; If we get here, then the high bit was in the carry.  Move the 
	; carry back into the high bit and adjust the exponent accordingly
	mov	r6, r6, lsr #1
	orr	r6, r6, #0x80000000
	add	r4, r4, #1
	; Fall through to floatRoundingDone
L363
	; Now check for overflow to infinities
	cmp	r4, #255
	bge	_floatReturnInfinity
	; Check to see if the result is a denormalized number
	tst	r6, #0x80000000
	; If the number is denormalized, mark it as so
	; Indicate denormalized
	moveq	r4, #0
	; Only do the following 2 inst if result is normalized
	; Clear the top bit
	bicne	r6, r6, #0x80000000
	; Set the exponent
	orrne	r0, r0, r4, lsl #23
	; Set the mantissa
	mov	r6, r6, lsr #8
	orr	r0, r0, r6
	; Fall through to _floatReturnToCaller

	EXPORT	_floatReturnToCaller
_floatReturnToCaller
	; Restore the saved registers
	ldmfd	sp!, {r4 - r7}
	bx	lr

	EXPORT	_floatReturnInfinity
_floatReturnInfinity
	mov	r1, #255
	; result = sign | infinity
	orr	r0, r0, r1, lsl #23
	ldmfd	sp!, {r4 - r7}
	bx	lr

	EXPORT	_floatReturnNaN
_floatReturnNaN
	; result = nan
	mov	r0, #0x3fc00000
	add	r0, r0, #0x40000000

	EXPORT	_floatDone
_floatDone
	ldmfd	sp!, {r4 - r7}
	bx	lr

	ENDP

	EXPORT	jvm_fsub
jvm_fsub PROC
	; invert sign of arg 2
	eor	r1, r1, #0x80000000
	; and call fadd
	b	jvm_fadd

	ENDP

	EXPORT	jvm_fmul
jvm_fmul PROC
	stmfd	sp!, {r4 - r7}
	mov	r12, #255
	; Extract exponent1
	and	r4, r12, r0, lsr #23
	; Extract exponent2
	and	r5, r12, r1, lsr #23
	mvn	r12, #0x80000000
	; Extract mantissa1
	and	r6, r12, r0, lsl #8
	; Extract mantissa2
	and	r7, r12, r1, lsl #8
	; NOTE: r12 is free now because MMASK is no longer needed. 
	; Set the sign bit in r0 and free up r1: 
	; Positive if same, else negative.
	eor	r0, r0, r1
	; Zero out the other bits.
	and	r0, r0, #0x80000000
	; Check if float1 or float2 is NaN or infinity:
	cmp	r4, #255
	cmpne	r5, #255
	beq	L365
	; Check for zeroes or denormalized numbers
	cmp	r4, #0
	beq	L367
	; Else, set implied high bit
	orr	r6, r6, #0x80000000
L369
	cmp	r5, #0
	beq	L368
	; Else, set implied high bit
	orr	r7, r7, #0x80000000
L370
	; Now we're ready to do the multiplication.
	; First add the exponents together and store
	; the result in EXP1. EXP2 is free after that.
	; exp1 -= 127 (i.e. the bias) + 1
	sub	r4, r4, #126
	; exp1 = exp1 + exp2
	add	r4, r4, r5
	; After the multiplication, the resultant binary point will be 2
	; digits from the high end of the 64 bit number as follows:
	; result = [xx.xx xxxx xxxx xxxx xxxx xxxx 0000 0000]
	; But we want the binary point to be 1 from the high end. 
	; To do this we divide the number by 2 and add 1 to the exponent.
	; Well, we don't actually have to divide the number by 2.  We just
	; know that the binary point is now 1 from the left.
	; EXP1 is already incremented above.  See how the bias is being 
	; subtracted from it.
	; {hi<r1>,lo<r3>} = MANT1 * MANT2
	umull	r3, r1, r6, r7
	; NOTE: r6, r7, and r12 are now free again: 
	; Normalize the resultant mantissa if necessary: 
	; Put the mantissa in { r6, r3 }
	mov	r6, r1
	; Normalize the result, if < 1
	cmp	r4, #1
	blt	_doGradualUnderflow
	cmp	r6, #0
	; If high bit is set and exponent is OK (i.e. already normalized), then move on.
	blt	L366
L371
	; See if exponent is down to 1
	cmp	r4, #1
	; Cannot normalize.  Go wrap-up.
	beq	L366
	; Shift the 64bit number left by 1:
	; Shift low-order word left by 1.
	movs	r3, r3, lsl #1
	; exponent--
	sub	r4, r4, #1
	; Shift high-order word left by 1.
	adcs	r6, r6, r6
	; If high bit not set, continue.
	bpl	L371
	; Fall through to checkForStickyBit.
L366
	; Is already normalized.  Check the sticky bit for rounding:
	cmp	r3, #0
	; Set the sticky bit if necessary.
	orrne	r6, r6, #32
	; Go round the result and exit.
	b	_floatRoundResult

	EXPORT	_doGradualUnderflow
_doGradualUnderflow
	; Compute the number of bits we have to shift right by in order to
	; bring EXP1 up to 1:
	rsb	r7, r4, #1
	cmp	r7, #31
	; If we have to shift 31 or more bits, then the result must be an
	; underflow to zero:
	; result = sign | 0
	ldmgefd	sp!, {r4 - r7}
	bxge	lr
	mov	r4, #1
	; Compute the sticky bit.
	orr	r3, r3, r6, lsl r7
	; Shift right be said bits.
	mov	r6, r6, lsr r7
	b	L366
L367
	; If we get here, then float1 and float2 are finite:
	; Check for 0
	cmp	r6, #0
	; result = sign | 0. Return to caller.
	ldmeqfd	sp!, {r4 - r7}
	bxeq	lr
	; Adjust exponent for denormalized #
	mov	r4, #1
	b	L369
L368
	; If we get here, then float1 and float2 are finite:
	; Check for 0
	cmp	r7, #0
	; result = sign | 0. Return to caller.
	ldmeqfd	sp!, {r4 - r7}
	bxeq	lr
	; Adjust exponent for denormalized #
	mov	r5, #1
	b	L370
L365
	; Check if float1 is NaN or infinity:
	cmp	r4, #255
	beq	L372
	; Else, float2 is NaN or infinity:
L373
	; If we get here, then float1 is not nan nor infinity:
	; Check for infinity
	cmp	r7, #0
	; finite * nan => nan
	bne	_floatReturnNaN
	; Else, float2 is an infinity.  Check float1 for 0:
	; Check for 0.
	orrs	r12, r4, r6
	; 0 * inf => nan.
	beq	_floatReturnNaN
	; finite * inf => inf
	b	_floatReturnInfinity
L372
	; Check for infinity
	cmp	r6, #0
	; nan * ? => nan.
	bne	_floatReturnNaN
	; Else, float1 is an infinity.  Check float2 for nan or infinity:
	cmp	r5, #255
	bne	L374
	; Check for infinity.
	cmp	r7, #0
	; inf * nan => nan.
	bne	_floatReturnNaN
	; inf * inf => inf.
	b	_floatReturnInfinity
L374
	; Check for 0.
	orrs	r12, r5, r7
	; inf * 0 => nan.
	beq	_floatReturnNaN
	; inf * finite => inf.
	b	_floatReturnInfinity

	ENDP

	EXPORT	jvm_fdiv
jvm_fdiv PROC
	stmfd	sp!, {r4 - r7}
	mov	r12, #255
	; Extract exponent1
	and	r4, r12, r0, lsr #23
	; Extract exponent2
	and	r5, r12, r1, lsr #23
	orr	r12, r12, #0x100
	; Extract mantissa1
	bic	r6, r0, r12, lsl #23
	; Extract mantissa2
	bic	r7, r1, r12, lsl #23
	; Set the sign bit in r0 and free up r1:
	; Positive if same, else negative.
	eor	r0, r0, r1
	; Zero out the other bits.
	and	r0, r0, #0x80000000
	; Check if float1 or float2 is NaN or infinity:
	cmp	r4, #255
	cmpne	r5, #255
	beq	L375
	; Check float1 for 0 or denormalized number:
	cmp	r4, #0
	beq	L378
	; Set the implied high bit.
	orr	r6, r6, #0x800000
L376
	cmp	r5, #0
	beq	L379
	; Set the implied high bit.
	orr	r7, r7, #0x800000
L377
	; Now we're ready to do the division. First subtract the exponents
	; and store the result in EXP1.  EXP2 is free after that.
	; Ensure that the first digit of the quotient will be a '1'
	; by shifting MANT1 if necessary. Decrease exponent accordingly.
	; Do the division as 25 successive divide steps
	; of MANT1 by MANT2, developing the quotient in QUOT.
	; exp1 = exp1 - exp2.
	sub	r4, r4, r5
	; exp1 += 127 (i.e. the bias)
	add	r4, r4, #127
	cmp	r6, r7
	movlt	r6, r6, lsl #1
	sublt	r4, r4, #1
	mov	r3, #25
	mov	r12, #0
	; loop unrolled by a factor of 5
L380
	cmp	r6, r7
	subcs	r6, r6, r7
	adc	r12, r12, r12
	mov	r6, r6, lsl #1
	cmp	r6, r7
	subcs	r6, r6, r7
	adc	r12, r12, r12
	mov	r6, r6, lsl #1
	cmp	r6, r7
	subcs	r6, r6, r7
	adc	r12, r12, r12
	mov	r6, r6, lsl #1
	cmp	r6, r7
	subcs	r6, r6, r7
	adc	r12, r12, r12
	mov	r6, r6, lsl #1
	cmp	r6, r7
	subcs	r6, r6, r7
	adc	r12, r12, r12
	mov	r6, r6, lsl #1
	subs	r3, r3, #5
	bgt	L380
	; In order to share rounding and packing code with fmul, 
	; move QUOT to MANT1, shifting left s.t. the high-order bit is set.
	; Also insert the sticky bit.
	cmp	r6, #0
	mov	r6, r12, lsl #7
	orrne	r6, r6, #20
	cmp	r4, #1
	bge	_floatRoundResult
	b	_doGradualUnderflow
L375
	; Check if float1 is NaN or infinity:
	cmp	r4, #255
	beq	L383
	; Else, float2 is NaN or infinity:
L384
	; If we get here, then float1 is not nan nor infinity:
	; Check for infinity.
	cmp	r7, #0
	bne	_floatReturnNaN
	; Else, float2 is an infinity.  Result is 0
	ldmfd	sp!, {r4 - r7}
	bx	lr
L383
	; Check for infinity.
	cmp	r6, #0
	; nan / ? => nan.
	bne	_floatReturnNaN
	; Else, float1 is an infinity.  Check float2 for nan or infinity: 
	cmp	r5, #255
	; inf / finite => inf
	bne	_floatReturnInfinity
	; inf / {nan or inf} => nan.
	b	_floatReturnNaN
L378
	; If we get here, then float1 and float2 are finite:
	cmp	r6, #0
	beq	L385
	mov	r4, #1
L381
	mov	r6, r6, lsl #1
	sub	r4, r4, #1
	cmp	r6, #0x800000
	blt	L381
	b	L376
L385
	cmp	r5, #0
	cmpeq	r7, #0
	; result = sign | 0. Return to caller.
	ldmnefd	sp!, {r4 - r7}
	bxne	lr
	; 0 / 0 => NaN
	b	_floatReturnNaN
L379
	; If we get here, then float1 is finite and non-zero:
	cmp	r7, #0
	beq	_floatReturnInfinity
	mov	r5, #1
L382
	mov	r7, r7, lsl #1
	sub	r5, r5, #1
	cmp	r7, #0x800000
	blt	L382
	b	L377
	IMPORT	jvm_frem

	ENDP

	EXPORT	jvm_dcmpg
jvm_dcmpg PROC
	; Is first argument NaN?
	mov	r12, r1, lsl #1
	cmn	r12, #0x200000
	cmpeq	r0, #1
	bcs	L390
	; Is second argument NaN?
	mov	r12, r3, lsl #1
	cmn	r12, #0x200000
	cmpeq	r2, #1
	bcc	L389
L390
	mov	r0, #1
	bx	lr
L391
	mvn	r0, #0
	bx	lr

	EXPORT	jvm_dcmpl
jvm_dcmpl
	; Is first argument NaN?
	mov	r12, r1, lsl #1
	cmn	r12, #0x200000
	cmpeq	r0, #1
	bcs	L391
	; Is second argument NaN?
	mov	r12, r3, lsl #1
	cmn	r12, #0x200000
	cmpeq	r2, #1
	bcs	L391
L389
	; Set N bit if arguments have opposite signs
	; Set C bit to sign of first argument
	teq	r3, r1, asr #32
	bmi	L386
	; Arguments have the same sign.  C bit indicates their sign
	bcs	L388
L387
	cmp	r1, r3
	subeqs	r0, r0, r2
	movhi	r0, #1
	mvncc	r0, #0
	bx	lr
L388
	cmp	r1, r3
	subeqs	r0, r0, r2
	movcc	r0, #1
	mvnhi	r0, #0
	bx	lr
L386
	; Arguments have opposite signs
	; First, special check for comparing +0 against -0
	orrs	r12, r0, r2
	orreq	r12, r1, r3
	cmpeq	r12, #0x80000000
	moveq	r3, r1
	mov	r3, r3, lsr #31
	sub	r0, r3, r1, lsr #31
	bx	lr

	ENDP

	EXPORT	jvm_fcmpg
jvm_fcmpg PROC
	mov	r2, r0, lsl #1
	cmp	r2, #0xff000000
	movls	r2, r1, lsl #1
	cmpls	r2, #0xff000000
	bls	L393
	mov	r0, #1
	bx	lr

	EXPORT	jvm_fcmpl
jvm_fcmpl
	mov	r2, r0, lsl #1
	cmp	r2, #0xff000000
	movls	r2, r1, lsl #1
	cmpls	r2, #0xff000000
	bls	L393
	mvn	r0, #0
	bx	lr
L393
	; Set N bit if arguments have opposite signs
	; Set C bit to sign of first argument
	teq	r1, r0, asr #32
	bmi	L392
	; Arguments have the same sign.  C bit indicates their sign
	mvncs	r0, r0
	mvncs	r1, r1
	subs	r0, r0, r1
	movgt	r0, #1
	mvnlt	r0, #0
	bx	lr
L392
	; Arguments have opposite signs
	orr	r2, r0, r1
	cmp	r2, #0x80000000
	moveq	r1, r0
	mov	r1, r1, lsr #31
	sub	r0, r1, r0, lsr #31
	bx	lr

	ENDP

	EXPORT	jvm_dadd
jvm_dadd PROC

	ENDP

	EXPORT	jvm_dadd_software
jvm_dadd_software PROC
	stmfd	sp!, {r4 - r9, lr}
	; capture signs of operands
	; because ANEGFLAG is SIGN
	and	lr, r1, #0x80000000
	cmp	r3, #0
	orrmi	lr, lr, #0x40000000
	; no thinking here
	bic	r1, r1, #0x80000000
	; no thinking here
	bic	r3, r3, #0x80000000
	; arrange for the larger summand to be in A
	cmp	r1, r3
	cmpeq	r0, r2
	bcs	L394
	mov	r6, r1
	mov	r1, r3
	mov	r3, r6
	mov	r6, r0
	mov	r0, r2
	mov	r2, r6
	; exchange sign flags, too
	movs	lr, lr, lsl #1
	; (may not matter)
	orrcs	lr, lr, #0x40000000
L394
	; exponent mask
	mov	r7, #255
	add	r7, r7, #0x700
	ands	r4, r7, r1, lsr #20
	bic	r1, r1, r7, lsl #20
	beq	L407
	cmp	r4, r7
	beq	L409
	orr	r1, r1, #0x100000
L396
	ands	r5, r7, r3, lsr #20
	bic	r3, r3, r7, lsl #20
	beq	L408
	cmp	r5, r7
	beq	L410
	orr	r3, r3, #0x100000
L397
	tst	lr, #30
	bne	L411
	; Scale B by (EXPA-EXPB) in preparation of addition.
	; Recall that EXPA >= EXPB.
	; RESULTX will hold shifted-out bits. Its high-order
	; bit is the guard bit, and any bits shifted out have
	; to be treated as sticky.
	subs	r5, r4, r5
	mov	r6, #0
	; It can happen.
	beq	L399
	cmp	r5, #54
	; B would scale to nothingness
	bgt	L398
	cmp	r5, #32
	blt	L400
	; scale a whole 32 bits worth
	mov	r6, r2
	mov	r2, r3
	mov	r3, #0
	sub	r5, r5, #32
L400
	rsb	r8, r5, #32
	; capture any sticky bits we are about to shift out
	mov	r9, r6, lsl #8
	; shift bits down
	mov	r6, r6, lsr r5
	orr	r6, r6, r2, lsl r8
	mov	r2, r2, lsr r5
	orr	r2, r2, r3, lsl r8
	mov	r3, r3, lsr r5
	; reinsert sticky bits
	cmp	r9, #0
	orrne	r6, r6, #1
L399
	; If signs the same, we do addition.
	; If signs differ, we do subtraction.
	teq	lr, lr, lsl #1
	bmi	L402
	adds	r0, r0, r2
	adc	r1, r1, r3
	; shift, if necessary, so HOB is the implicit bit.
	cmp	r1, #0x200000
	blt	L395
	; there was a carry out and we downshift accordingly
	movs	r1, r1, lsr #1
	movs	r0, r0, rrx
	movs	r6, r6, rrx
	; this is why we call it sticky
	orrcs	r6, r6, #1
	add	r4, r4, #1
	b	_double_check_guard
L395
	; the only way to have a denorm here is from the sum of
	; two denorms.
	cmp	r4, #1
	bgt	_double_check_guard
	; The exponent is == 1. This is the result of the sum
	; or difference of two denormalized numbers.
	; If the fraction is all zero, return +0
	; Else we jam in the sign and return. No rounding necessary here.
L401
	orrs	r9, r1, r0
	cmpne	lr, #0
	orrmi	r1, r1, #0x80000000
	ldmfd	sp!, {r4 - r9, lr}
	bx	lr
	; Here we are taking the sum of numbers with different signs.
	; This could lead to cancellation so we're a little careful.
L402
	; negate the guard word, with carry then subtract
	rsbs	r6, r6, #0
	sbcs	r0, r0, r2
	sbc	r1, r1, r3
	; find a-priori denorms immediately.
	cmp	r4, #1
	ble	L401
	cmp	r1, #0x100000
	; could get lucky
	bge	_double_check_guard
	; The most significant bit of the result might be anywhere.
	; The result may be denormalized.
	; It might be zero.
	; If it is zero, we must deliver +0 as a result.

	; We're going to have to shift it. We want to shift LEFT
	; until we can normalize. However, we might not be able to 
	; deliver a normalized result.  We shift until either normalized
	; or the EXPA decrements to 1, which we then treat as denormalized.

	; If the EXPA is great enough, try to do 16- or 32-bit at a time
	; shifts.
	cmp	r1, #0
	bne	L406
	cmp	r4, #32
	ble	L404
	cmp	r0, #0x8000
	bhi	L403
	orrs	r9, r0, r6, lsr #31
	beq	_double_deliver_positive_zero
	mov	r1, r0
	mov	r0, r6
	mov	r6, #0
	sub	r4, r4, #32
	b	L406
L403
	mov	r1, r0, lsr #16
	mov	r0, r0, lsl #16
	orr	r0, r0, r6, lsr #16
	mov	r6, r6, lsl #16
	sub	r4, r4, #16
	b	L406
L404
	orr	r9, r1, r0
	orrs	r9, r9, r6, lsr #31
	bne	L406
	b	_double_deliver_positive_zero
	; Here we try to normalize the result for
	; the subtraction of normalized values.
	; We know that the result is non-zero, but it may
	; underflow to a signed zero result.
	; A1 < (1<<EXPSHIFT) and A1|A2|RESULTX != 0 and EXPA > 1
L405
	adds	r6, r6, r6
	adcs	r0, r0, r0
	adc	r1, r1, r1
	sub	r4, r4, #1
L406
	cmp	r1, #0x100000
	bcs	_double_check_guard
	cmp	r4, #1
	bgt	L405
	b	_double_denorm_check_guard
L407
	cmp	r1, #0
	cmpeq	r0, #0
	orreq	lr, lr, #8
	beq	L396
	mov	r4, #1
	b	L396
L408
	cmp	r3, #0
	cmpeq	r2, #0
	orreq	lr, lr, #16
	beq	L397
	mov	r5, #1
	b	L397
L409
	cmp	r1, #0
	cmpeq	r0, #0
	bne	_double_deliver_NaN
	orr	lr, lr, #2
	b	L396
L410
	cmp	r3, #0
	cmpeq	r2, #0
	bne	_double_deliver_NaN
	orr	lr, lr, #4
	b	L397
L411
	tst	lr, #6
	bne	L412
	; one or more zeros. No Infinities or NaNs here.
	tst	lr, #8
	; @ A != 0 so B == 0 so result is A
	beq	L398
	; here A is certainly zero.
	; but since we arranged for abs(A) >= abs(B), B must be zero, too.
	; So the result has to be zero.
	; sign of result is AND of signs of operands
	and	r1, lr, lr, lsl #1
	and	r1, r1, #0x80000000
	mov	r0, #0
	ldmfd	sp!, {r4 - r9, lr}
	bx	lr
L398
	; if EXPA is "1", then treat it as a denorm
	cmp	r4, #1
	bne	_double_done_rounding
	b	_double_denorm_done_rounding
	; One or more Infinities. No NaNs.
L412
	tst	lr, #4
	; A is, but B is not
	beq	_double_done_rounding
	; have two infinities:
	teq	lr, lr, lsl #1
	; signs differ, deliver NaN
	bmi	_double_deliver_NaN
	b	_double_deliver_Infinity

	ENDP

	EXPORT	jvm_dsub
jvm_dsub PROC
	; invert sign of arg 2
	eor	r3, r3, #0x80000000
	; and call dadd
	b	jvm_dadd_software

	ENDP

	EXPORT	jvm_dmul
jvm_dmul PROC
	stmfd	sp!, {r4 - r9, lr}
	; capture sign of result
	eors	lr, r1, r3
	; no thinking here
	bic	r1, r1, #0x80000000
	; no thinking here
	bic	r3, r3, #0x80000000
	; clear other flags
	and	lr, lr, #0x80000000
	; exponent mask
	mov	r7, #255
	add	r7, r7, #0x700
L417
	ands	r4, r7, r1, lsr #20
	bic	r1, r1, r7, lsl #20
	beq	L413
	cmp	r4, r7
	beq	L415
	orr	r1, r1, #0x100000
L418
	ands	r5, r7, r3, lsr #20
	bic	r3, r3, r7, lsl #20
	beq	L414
	cmp	r5, r7
	beq	L416
	orr	r3, r3, #0x100000
L419
	tst	lr, #3
	bne	L420
	; Here we have a couple of normalized operands and
	; will perform the multiply.
	; Too bad the carry out of umlal is not trustworthy, 
	; because we really need it for carry propagation! 
	; Start low-end and work up to cut down on carries.
	add	r4, r4, r5
	; @ subtract extra bias
	sub	r4, r4, r7, lsr #1
	umull	r6, r9, r0, r2
	mov	r8, #0
	umlal	r9, r8, r1, r2
	; now done with B2 so can use it for scratch.
	mov	r2, #0
	umlal	r9, r2, r0, r3
	adds	r8, r8, r2
	mov	r2, #0
	; B2 gets carry out of above addition
	adc	r2, r2, #0
	umlal	r8, r2, r1, r3
	; now have result in B2/PROD2/PROD3/RESULTX
	; Now have a full 106 bits of result. The very highest order bit
	; of the result may or may not be set. At most one shift will be
	; necessary to set it (since we were normalized coming into this
	; calculation
	cmp	r2, #0x200
	addge	r4, r4, #1
	bge	L421
	adds	r6, r6, r6
	adcs	r9, r9, r9
	adcs	r8, r8, r8
	adc	r2, r2, r2
L421
	; Arrange the bits of our result to conform to the
	; expected output.

	; We have:
	; 10 bits in B2. The highest order is set and will
	;      be the implicit bit of a normalized result.
	; 32 bits in PROD2
	; 32 bits in PROD3
	; some more junk in RESULTX. We only care whether this is ==0
	; or not.
	mov	r1, r2, lsl #11
	orr	r1, r1, r8, lsr #21
	mov	r0, r8, lsl #11
	orr	r0, r0, r9, lsr #21
	cmp	r6, #0
	orrne	r9, r9, #1
	mov	r6, r9, lsl #11
	cmp	r4, #0
	ble	_dmult_denorm_result

	EXPORT	_double_check_guard
_double_check_guard
	; Look at the guard and sticky bits of our result.
	; Round accordingly.
	; the Guard bit is now the sign of RESULTX
	cmp	r6, #0x80000000
	bcc	_double_done_rounding
	bhi	_double_round_up
	; Round to even.
	adds	r0, r0, #1
	bic	r0, r0, #1
	b	_double_rounding

	EXPORT	_double_round_up
_double_round_up
	adds	r0, r0, #1

	EXPORT	_double_rounding
_double_rounding
	adc	r1, r1, #0
	; Now, if the result is 'too big', we carried all the way up.
	; In theory we could shift back down, but we know that all the
	; lower order bits have to be zero, so just jam them in.
	cmp	r1, #0x200000
	blt	_double_done_rounding
	add	r4, r4, #1
	mov	r1, #0x100000
	mov	r0, #0

	EXPORT	_double_done_rounding
_double_done_rounding
	; Test for exponent too big.
	cmp	r4, r7
	bge	_double_deliver_Infinity
	; Clear the implicit bit, if present
	bic	r1, r1, #0x100000
	; Assemble the result.
	orr	r1, r1, r4, lsl #20

	EXPORT	_double_deliver_signed_result
_double_deliver_signed_result
	cmp	lr, #0
	orrmi	r1, r1, #0x80000000
	ldmfd	sp!, {r4 - r9, lr}
	bx	lr

	EXPORT	_double_deliver_NaN
_double_deliver_NaN
	mov	r1, #0x3f80000
	add	r1, r1, #0x7c000000
	mov	r0, #0
	ldmfd	sp!, {r4 - r9, lr}
	bx	lr
L413
	cmp	r1, #0
	cmpeq	r0, #0
	orreq	lr, lr, #2
	beq	L418
L424
	adds	r0, r0, r0
	adc	r1, r1, r1
	cmp	r1, #0x100000
	sublt	r4, r4, #1
	blt	L424
	b	L418
L414
	cmp	r3, #0
	cmpeq	r2, #0
	orreq	lr, lr, #2
	beq	L419
L425
	adds	r2, r2, r2
	adc	r3, r3, r3
	cmp	r3, #0x100000
	sublt	r5, r5, #1
	blt	L425
	b	L419
L415
	cmp	r1, #0
	cmpeq	r0, #0
	bne	_double_deliver_NaN
	orr	lr, lr, #1
	b	L418
L416
	cmp	r3, #0
	cmpeq	r2, #0
	bne	_double_deliver_NaN
	orr	lr, lr, #1
	b	L419
	; If here, we have some combination of zeros and infinities.
	; Act accordingly.
L420
	tst	lr, #1
	bne	L423

	EXPORT	_double_deliver_signed_zero
_double_deliver_signed_zero
	; result is zero
	mov	r1, #0
	mov	r0, #0
	b	_double_deliver_signed_result

	EXPORT	_double_deliver_positive_zero
_double_deliver_positive_zero
	; result is +zero
	mov	r1, #0
	mov	r0, #0
	ldmfd	sp!, {r4 - r9, lr}
	bx	lr
L423
	tst	lr, #2
	bne	_double_deliver_NaN
	; else fall thru and deliver infinity

	EXPORT	_double_deliver_Infinity
_double_deliver_Infinity
	mov	r1, r7, lsl #20
	mov	r0, #0
	b	_double_deliver_signed_result

	EXPORT	_dmult_denorm_result
_dmult_denorm_result
	; The exponent is <= 0. This is really too bad.
	; If it is really small ( <-52 ) I  believe we're safe to
	; return a zero. Else we very carefully right shift until
	; the exponent becomes zero, then go round and pack the result.
	; Note that the fraction part is normalized, so we must shift it
	; at least once to denormalize.
	cmn	r4, #52
	blt	_double_deliver_signed_zero
	; we always have to shift once even for EXPA of 0
	; to achieve the denormalized form, then shift until EXPA
	; turns to zero
	; this accounts for the funny mov at the end of this loop
L422
	movs	r1, r1, lsr #1
	movs	r0, r0, rrx
	movs	r6, r6, rrx
	; this is why we call it sticky
	orrcs	r6, r6, #1
	adds	r4, r4, #1
	ble	L422
	; if EXPA was 0 we just incremented it,
	; so reset it back before continuing
	mov	r4, #0

	EXPORT	_double_denorm_check_guard
_double_denorm_check_guard
	; Look at the guard and sticky bits of our result.
	; Round accordingly.
	; See if we became normalized, and adjust exponent if so.
	; This is very similar to _double_check_guard above
	; except for the post-rounding tests.
	; the Guard bit is now the sign of RESULTX
	cmp	r6, #0x80000000
	bcc	_double_denorm_done_rounding
	bhi	_double_denorm_round_up
	; Round to even.
	adds	r0, r0, #1
	bic	r0, r0, #1
	b	_double_denorm_rounding

	EXPORT	_double_denorm_round_up
_double_denorm_round_up
	adds	r0, r0, #1

	EXPORT	_double_denorm_rounding
_double_denorm_rounding
	adc	r1, r1, #0
	; If the result is now normalized, we carried all the way up.
	; But that's ok, because we just won't clear it out
	; of the assembled result
	; Put the sign on and go.

	EXPORT	_double_denorm_done_rounding
_double_denorm_done_rounding
	cmp	lr, #0
	orrmi	r1, r1, #0x80000000
	ldmfd	sp!, {r4 - r9, lr}
	bx	lr

	ENDP

	EXPORT	jvm_ddiv
jvm_ddiv PROC
	; In addition to the above conventions, working register are:
	; QUOT1 for first quotient word (after done with EXPB)
	; QUOT2 for second quotient word
	; ITER  for the loop counter
	stmfd	sp!, {r4 - r9, lr}
	; capture sign of result
	eors	lr, r1, r3
	; no thinking here
	bic	r1, r1, #0x80000000
	; no thinking here
	bic	r3, r3, #0x80000000
	; clear other flags
	and	lr, lr, #0x80000000
	; exponent mask
	mov	r7, #255
	add	r7, r7, #0x700
	ands	r4, r7, r1, lsr #20
	bic	r1, r1, r7, lsl #20
	beq	L428
	cmp	r4, r7
	beq	L430
	orr	r1, r1, #0x100000
L426
	ands	r5, r7, r3, lsr #20
	bic	r3, r3, r7, lsl #20
	beq	L429
	cmp	r5, r7
	beq	L431
	orr	r3, r3, #0x100000
L427
	tst	lr, #30
	bne	L432
	; Here we have a couple of normalized operands and
	; will perform the division.
	sub	r4, r4, r5
	; add extra bias
	add	r4, r4, r7, lsr #1
	; Make sure the first digit is a '1' by increasing A if
	; necessary
	cmp	r1, r3
	cmpeq	r0, r2
	bcs	L436
	adds	r0, r0, r0
	adc	r1, r1, r1
	sub	r4, r4, #1
L436
	; Develop the high-order 21 quotient bits in QUOT1.
	; Develop the lower-order 32 quotient bits in QUOT2
	; Develop the lowest-order 1 quotient bit in RESULTX

	; Try non-restoring divide here. It appears easier, maybe.
	mov	r8, #0
	mov	r5, #0
	mov	r9, #21
	b	L434
L433
	adds	r0, r0, r0
	adcs	r1, r1, r1
	blt	L437
L434
	subs	r0, r0, r2
	sbcs	r1, r1, r3
	b	L438
L437
	adds	r0, r0, r2
	adcs	r1, r1, r3
L438
	adc	r5, r5, r5
	subs	r9, r9, #1
	bgt	L433
	; second 32 bits of quotient into QUOT2
	mov	r9, #32
L435
	adds	r0, r0, r0
	adcs	r1, r1, r1
	blt	L439
	subs	r0, r0, r2
	sbcs	r1, r1, r3
	b	L440
L439
	adds	r0, r0, r2
	adcs	r1, r1, r3
L440
	adc	r8, r8, r8
	subs	r9, r9, #1
	bgt	L435
	; compute guard bit into high-order bit of RESULTX
	; we know ITER is 0 at this point.
	adds	r0, r0, r0
	adcs	r1, r1, r1
	blt	L441
	subs	r0, r0, r2
	sbcs	r1, r1, r3
	b	L442
L441
	adds	r0, r0, r2
	adcs	r1, r1, r3
L442
	mov	r6, r9, rrx
	; adjust remainder
	cmp	r1, #0
	bge	L443
	adds	r2, r0, r2
	adc	r3, r1, r3
L443
	; Result is now in QUOT1 | QUOT2 | RESULTX and EXPA
	; The remainder is in B1 | B2
	; Put result in the form that is expected by
	; the shared rounding and packing code.
	mov	r1, r5
	mov	r0, r8
	orrs	r3, r3, r2
	; sticky bit
	orrne	r6, r6, #0x40000000
	cmp	r4, #0
	bgt	_double_check_guard
	b	_dmult_denorm_result
L428
	cmp	r1, #0
	cmpeq	r0, #0
	orreq	lr, lr, #8
	beq	L426
L444
	adds	r0, r0, r0
	adc	r1, r1, r1
	cmp	r1, #0x100000
	sublt	r4, r4, #1
	blt	L444
	b	L426
L429
	cmp	r3, #0
	cmpeq	r2, #0
	orreq	lr, lr, #16
	beq	L427
L445
	adds	r2, r2, r2
	adc	r3, r3, r3
	cmp	r3, #0x100000
	sublt	r5, r5, #1
	blt	L445
	b	L427
L430
	cmp	r1, #0
	cmpeq	r0, #0
	bne	_double_deliver_NaN
	orr	lr, lr, #2
	b	L426
L431
	cmp	r3, #0
	cmpeq	r2, #0
	bne	_double_deliver_NaN
	orr	lr, lr, #4
	b	L427
	; If here, we have some combination of zeros and infinities.
	; Act accordingly.
L432
	; disregard sign
	bic	r6, lr, #0x80000000
	teq	r6, #6
	; Inf / Inf => NaN
	beq	_double_deliver_NaN
	teq	r6, #24
	; 0 / 0 => NaN
	beq	_double_deliver_NaN
	tst	r6, #18
	; Inf / non-Inf == non-0 / 0 => Inf
	bne	_double_deliver_Infinity
	; resulting cases are:
	; non-Inf / Inf => 0
	; 0 / non-0     => 0
	b	_double_deliver_signed_zero
	IMPORT	jvm_drem

	ENDP

	EXPORT	jvm_i2d
jvm_i2d PROC
	; Get absolute value in r2.  Short circuit on zero
	movs	r2, r0
	moveq	r1, #0
	bxeq	lr
	rsbmi	r2, r0, #0
	; Exponent of 0x80000000, minus one
	mov	r3, #29
	add	r3, r3, #0x4, 24	; #0x400
	; Shift by 16 if necessary
	cmp	r2, #0x10000
	movcc	r2, r2, lsl #16
	subcc	r3, r3, #16
	; Shift by 8 if necessary
	cmp	r2, #0x1000000
	movcc	r2, r2, lsl #8
	subcc	r3, r3, #8
	; Shift by 4 if necessary
	cmp	r2, #0x10000000
	movcc	r2, r2, lsl #4
	subcc	r3, r3, #4
	; Shift by 2 if necessary
	cmp	r2, #0x40000000
	movcc	r2, r2, lsl #2
	subcc	r3, r3, #2
	; Shift by 1 if necessary
	cmp	r2, #0x80000000
	movcc	r2, r2, lsl #1
	subcc	r3, r3, #1
	; Integer shifted so top bit is in bit 31
	; Combine the sign, exponent, and mantissa
	and	r1, r0, #0x80000000
	add	r1, r1, r3, lsl #20
	add	r1, r1, r2, lsr #11
	mov	r0, r2, lsl #21
	bx	lr

	ENDP

	EXPORT	jvm_i2f
jvm_i2f PROC
	; Get absolute value in r1.  Short circuit on zero
	movs	r1, r0
	bxeq	lr
	rsbmi	r1, r0, #0
	; Exponent of 0x80000000, minus one
	mov	r2, #157
	; Shift by 16 if necessary
	cmp	r1, #0x10000
	movcc	r1, r1, lsl #16
	subcc	r2, r2, #16
	; Shift by 8 if necessary
	cmp	r1, #0x1000000
	movcc	r1, r1, lsl #8
	subcc	r2, r2, #8
	; Shift by 4 if necessary
	cmp	r1, #0x10000000
	movcc	r1, r1, lsl #4
	subcc	r2, r2, #4
	; Shift by 2 if necessary
	cmp	r1, #0x40000000
	movcc	r1, r1, lsl #2
	subcc	r2, r2, #2
	; Shift by 1 if necessary
	cmp	r1, #0x80000000
	movcc	r1, r1, lsl #1
	subcc	r2, r2, #1
	; Integer shifted so top bit is in bit 31
	; Combine the sign, exponent, and mantissa
	and	r0, r0, #0x80000000
	add	r0, r0, r2, lsl #23
	add	r0, r0, r1, lsr #8
	; Perform rounding, if necessary
	ands	r1, r1, #255
	bxeq	lr
	cmp	r1, #128
	addcs	r0, r0, #1
	biceq	r0, r0, #1
	bx	lr
	IMPORT	jvm_l2f
	IMPORT	jvm_l2d

	ENDP

	EXPORT	jvm_f2i
jvm_f2i PROC
	; Strip sign
	bic	r1, r0, #0x80000000
	; De-bias exponent
	subs	r2, r1, #0x3f800000
	blt	L446
	cmp	r2, #0xf800000
	bcs	L447
	; Shift fraction so that high bit is bit 30
	mov	r1, r1, lsl #8
	; Set implicit high order bit
	orr	r1, r1, #0x80000000
	; Get the exponent
	mov	r2, r2, lsr #23
	; Shift F right by 31 - exponent
	rsb	r2, r2, #31
	mov	r1, r1, lsr r2
	; Apply the sign and return
	cmp	r0, #0
	movge	r0, r1
	rsblt	r0, r1, #0
	bx	lr
L447
	; If nan, result is 0.  Otherwise big integer
	cmp	r2, #0x40000000
	bhi	L446
	; Return appropriately signed largest integer
	cmp	r0, #0
	mvnge	r0, #0x80000000
	movlt	r0, #0x80000000
	bx	lr
L446
	mov	r0, #0
	bx	lr
	IMPORT	jvm_f2l

	EXPORT	jvm_f2d
jvm_f2d
	IMPORT	jvm_f2d_internal
	ldr	pc, =jvm_f2d_internal
	LTORG

	ENDP

	EXPORT	jvm_d2i
jvm_d2i PROC
	; Strip sign
	bic	r2, r1, #0x80000000
	; De-bias exponent
	sub	r3, r2, #0x3f000000
	subs	r3, r3, #0xf00000
	blt	L448
	cmp	r3, #0x1f00000
	bcs	L449
	; Shift fraction so that high bit is bit 30
	mov	r2, r2, lsl #11
	orr	r2, r2, r0, lsr #21
	; Set implicit high order bit
	orr	r2, r2, #0x80000000
	; Get the exponent
	mov	r3, r3, lsr #20
	; Shift F right by 31 - exponent
	rsb	r3, r3, #31
	mov	r2, r2, lsr r3
	; Apply the sign and return
	cmp	r1, #0
	movge	r0, r2
	rsblt	r0, r2, #0
	bx	lr
L449
	; If nan, result is 0.  Otherwise big integer
	cmp	r3, #0x40000000
	cmpeq	r0, #0
	bhi	L448
	; Return appropriately signed largest integer
	cmp	r1, #0
	mvnge	r0, #0x80000000
	movlt	r0, #0x80000000
	bx	lr
L448
	mov	r0, #0
	bx	lr
	IMPORT	jvm_d2l

	EXPORT	jvm_d2f
jvm_d2f
	IMPORT	jvm_d2f_internal
	ldr	pc, =jvm_d2f_internal
	LTORG
	LTORG

	ENDP
	; End segment: Floating point routines


	; ------------------------------------------------------
	; Start segment: Compiler glue code

	EXPORT	compiler_glue_code_start
compiler_glue_code_start PROC
	LTORG

	ENDP
	; End segment: Compiler glue code


	; ------------------------------------------------------
	; Start segment: Compiler new object

	EXPORT	compiler_new_object
compiler_new_object PROC
	IMPORT	_newobject
	ldr	r3, =_newobject
	ldr	pc, =shared_call_vm_oop
	LTORG

	ENDP
	; End segment: Compiler new object


	AREA |.text|, CODE
	ARM
	; ------------------------------------------------------
	; Start segment: Shared monitor enter

	EXPORT	shared_lock_synchronized_method
shared_lock_synchronized_method PROC
	sub	r6, r6, #28
	str	r6, [fp, #4]
	add	r1, r6, #0
L451
	; r0 contains the object to lock
	; r1 contains a stack lock in the monitor block
	ldr	r3, [r0]                 ; Get the near object
	str	r0, [r1, #24]            ; Store the object in the stack lock and lock it
	ldr	r4, [r3, #8]             ; object already locked?
	tst	r4, #1
	bne	L452
	; We have the fast case
	ldr	r2, [r5, #1036]          ; current_thread 
	orr	r4, r4, #1
	str	r4, [r1, #20]
	str	r3, [r1, #4]
	str	r2, [r1]
	; Clear waiters
	mov	r2, #0
	str	r2, [r1, #8]
	; Update the near pointer in the object
	add	r2, r1, #12
	str	r2, [r0]
	; Copy the locked near object to the stack and set lock bit
	; Copy the first two fields of the near
	ldmia	r3, {r2, r4}
	str	r2, [r1, #12]
	str	r4, [r1, #16]
	bx	lr
L452
	; maybe_slow_case
	ldr	r2, [r5, #1036]          ; current_thread 
	ldr	r3, [r3, #-12]           ; thread of object's lock
	mov	r4, #0                   ; set our own real java near field to nul
	str	r4, [r1, #4]
	cmp	r2, r3                   ; is this a recursive lock?
	bxeq	lr
L453
	; slow_case
	IMPORT	lock_stack_lock
	ldr	r3, =lock_stack_lock
	ldr	pc, =shared_call_vm
L450
	; Allocate a stack lock in the monitor block
	; Set lock to old expression stack bottom
	ldr	r1, [fp, #4]
	; Move expression stack top and bottom
	sub	r6, r6, #28
	sub	r1, r1, #28
	str	r1, [fp, #4]
	; Move the expression stack contents
	mov	r2, r6
	b	L454
L455
	ldr	r3, [r2, #28]
	str	r3, [r2], #4
L454
	; Check if bottom is reached
	cmp	r2, r1
	bne	L455
	b	L451
	LTORG

	ENDP
	; End segment: Shared monitor enter


	; ------------------------------------------------------
	; Start segment: Shared monitor exit
L457
	; Throw an IllegalMonitorStateException
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	ldr	pc, =shared_call_vm

	EXPORT	shared_unlock_synchronized_method
shared_unlock_synchronized_method PROC
	; get object field of last lock
	ldr	r0, [fp, #-24]
	; get address of last lock
	sub	r1, fp, #48
	; lock better be locked
	cmp	r0, #0
	beq	L457
L456
	; r0 contains the object that is being unlocked
	; r1 contains the stack lock

	; Get the real java near pointer from the stack lock
	ldr	r3, [r1, #4]
	; Zero out the object field so that lock is free
	mov	r2, #0
	str	r2, [r1, #24]
	; Is this the reentrant case?
	cmp	r3, #0
	bxeq	lr
	; Set the object near pointer
	str	r3, [r0]
	cmp	r3, r0
	ldrcc	r2, [r1, #20]
	bcc	L458
	; oop_write_barrier
	ldr	r2, [r5, #1052]          ; heap_start 
	ldr	r3, [r5, #1248]          ; old_generation_end 
	cmp	r0, r2
	cmpcs	r3, r0
	ldrcs	r2, [r5, #1076]          ; bitvector_base 
	ldrcs	r3, [r5, #1080]          ; bit_selector 
	ldrcsb	r4, [r2, +r0, lsr #5]!
	mvncs	r0, r0, lsr #2
	orrcs	r4, r4, r3, ror r0
	strcsb	r4, [r2]
	ldr	r2, [r1, #20]
L458
	tst	r2, #2
	bxeq	lr
	; Call the runtime system to signal the waiters
	IMPORT	signal_waiters
	ldr	r3, =signal_waiters
	ldr	pc, =shared_call_vm
	LTORG

	ENDP
	; End segment: Shared monitor exit


	; ------------------------------------------------------
	; Start segment: Compiler glue code

	EXPORT	compiler_glue_code_end
compiler_glue_code_end PROC
	LTORG

	ENDP
	; End segment: Compiler glue code


	AREA |.data|, DATA
	; ------------------------------------------------------
	; Start segment: Global pool

	EXPORT	gp_base_label
gp_base_label
	DCD	bc_impl_nop                            ; 0x0 ; offset=0 (0x0)
	DCD	bc_impl_aconst_null                    ; 0x1 ; offset=4 (0x4)
	DCD	bc_impl_iconst_m1                      ; 0x2 ; offset=8 (0x8)
	DCD	bc_impl_iconst_0                       ; 0x3 ; offset=12 (0xc)
	DCD	bc_impl_iconst_1                       ; 0x4 ; offset=16 (0x10)
	DCD	bc_impl_iconst_2                       ; 0x5 ; offset=20 (0x14)
	DCD	bc_impl_iconst_3                       ; 0x6 ; offset=24 (0x18)
	DCD	bc_impl_iconst_4                       ; 0x7 ; offset=28 (0x1c)
	DCD	bc_impl_iconst_5                       ; 0x8 ; offset=32 (0x20)
	DCD	bc_impl_lconst_0                       ; 0x9 ; offset=36 (0x24)
	DCD	bc_impl_lconst_1                       ; 0xa ; offset=40 (0x28)
	DCD	bc_impl_fconst_0                       ; 0xb ; offset=44 (0x2c)
	DCD	bc_impl_fconst_1                       ; 0xc ; offset=48 (0x30)
	DCD	bc_impl_fconst_2                       ; 0xd ; offset=52 (0x34)
	DCD	bc_impl_dconst_0                       ; 0xe ; offset=56 (0x38)
	DCD	bc_impl_dconst_1                       ; 0xf ; offset=60 (0x3c)
	DCD	bc_impl_bipush                         ; 0x10 ; offset=64 (0x40)
	DCD	bc_impl_sipush                         ; 0x11 ; offset=68 (0x44)
	DCD	bc_impl_ldc                            ; 0x12 ; offset=72 (0x48)
	DCD	bc_impl_ldc_w                          ; 0x13 ; offset=76 (0x4c)
	DCD	bc_impl_ldc2_w                         ; 0x14 ; offset=80 (0x50)
	DCD	bc_impl_iload                          ; 0x15 ; offset=84 (0x54)
	DCD	bc_impl_lload                          ; 0x16 ; offset=88 (0x58)
	DCD	bc_impl_fload                          ; 0x17 ; offset=92 (0x5c)
	DCD	bc_impl_dload                          ; 0x18 ; offset=96 (0x60)
	DCD	bc_impl_aload                          ; 0x19 ; offset=100 (0x64)
	DCD	bc_impl_iload_0                        ; 0x1a ; offset=104 (0x68)
	DCD	bc_impl_iload_1                        ; 0x1b ; offset=108 (0x6c)
	DCD	bc_impl_iload_2                        ; 0x1c ; offset=112 (0x70)
	DCD	bc_impl_iload_3                        ; 0x1d ; offset=116 (0x74)
	DCD	bc_impl_lload_0                        ; 0x1e ; offset=120 (0x78)
	DCD	bc_impl_lload_1                        ; 0x1f ; offset=124 (0x7c)
	DCD	bc_impl_lload_2                        ; 0x20 ; offset=128 (0x80)
	DCD	bc_impl_lload_3                        ; 0x21 ; offset=132 (0x84)
	DCD	bc_impl_fload_0                        ; 0x22 ; offset=136 (0x88)
	DCD	bc_impl_fload_1                        ; 0x23 ; offset=140 (0x8c)
	DCD	bc_impl_fload_2                        ; 0x24 ; offset=144 (0x90)
	DCD	bc_impl_fload_3                        ; 0x25 ; offset=148 (0x94)
	DCD	bc_impl_dload_0                        ; 0x26 ; offset=152 (0x98)
	DCD	bc_impl_dload_1                        ; 0x27 ; offset=156 (0x9c)
	DCD	bc_impl_dload_2                        ; 0x28 ; offset=160 (0xa0)
	DCD	bc_impl_dload_3                        ; 0x29 ; offset=164 (0xa4)
	DCD	bc_impl_aload_0                        ; 0x2a ; offset=168 (0xa8)
	DCD	bc_impl_aload_1                        ; 0x2b ; offset=172 (0xac)
	DCD	bc_impl_aload_2                        ; 0x2c ; offset=176 (0xb0)
	DCD	bc_impl_aload_3                        ; 0x2d ; offset=180 (0xb4)
	DCD	bc_impl_iaload                         ; 0x2e ; offset=184 (0xb8)
	DCD	bc_impl_laload                         ; 0x2f ; offset=188 (0xbc)
	DCD	bc_impl_faload                         ; 0x30 ; offset=192 (0xc0)
	DCD	bc_impl_daload                         ; 0x31 ; offset=196 (0xc4)
	DCD	bc_impl_aaload                         ; 0x32 ; offset=200 (0xc8)
	DCD	bc_impl_baload                         ; 0x33 ; offset=204 (0xcc)
	DCD	bc_impl_caload                         ; 0x34 ; offset=208 (0xd0)
	DCD	bc_impl_saload                         ; 0x35 ; offset=212 (0xd4)
	DCD	bc_impl_istore                         ; 0x36 ; offset=216 (0xd8)
	DCD	bc_impl_lstore                         ; 0x37 ; offset=220 (0xdc)
	DCD	bc_impl_fstore                         ; 0x38 ; offset=224 (0xe0)
	DCD	bc_impl_dstore                         ; 0x39 ; offset=228 (0xe4)
	DCD	bc_impl_astore                         ; 0x3a ; offset=232 (0xe8)
	DCD	bc_impl_istore_0                       ; 0x3b ; offset=236 (0xec)
	DCD	bc_impl_istore_1                       ; 0x3c ; offset=240 (0xf0)
	DCD	bc_impl_istore_2                       ; 0x3d ; offset=244 (0xf4)
	DCD	bc_impl_istore_3                       ; 0x3e ; offset=248 (0xf8)
	DCD	bc_impl_lstore_0                       ; 0x3f ; offset=252 (0xfc)
	DCD	bc_impl_lstore_1                       ; 0x40 ; offset=256 (0x100)
	DCD	bc_impl_lstore_2                       ; 0x41 ; offset=260 (0x104)
	DCD	bc_impl_lstore_3                       ; 0x42 ; offset=264 (0x108)
	DCD	bc_impl_fstore_0                       ; 0x43 ; offset=268 (0x10c)
	DCD	bc_impl_fstore_1                       ; 0x44 ; offset=272 (0x110)
	DCD	bc_impl_fstore_2                       ; 0x45 ; offset=276 (0x114)
	DCD	bc_impl_fstore_3                       ; 0x46 ; offset=280 (0x118)
	DCD	bc_impl_dstore_0                       ; 0x47 ; offset=284 (0x11c)
	DCD	bc_impl_dstore_1                       ; 0x48 ; offset=288 (0x120)
	DCD	bc_impl_dstore_2                       ; 0x49 ; offset=292 (0x124)
	DCD	bc_impl_dstore_3                       ; 0x4a ; offset=296 (0x128)
	DCD	bc_impl_astore_0                       ; 0x4b ; offset=300 (0x12c)
	DCD	bc_impl_astore_1                       ; 0x4c ; offset=304 (0x130)
	DCD	bc_impl_astore_2                       ; 0x4d ; offset=308 (0x134)
	DCD	bc_impl_astore_3                       ; 0x4e ; offset=312 (0x138)
	DCD	bc_impl_iastore                        ; 0x4f ; offset=316 (0x13c)
	DCD	bc_impl_lastore                        ; 0x50 ; offset=320 (0x140)
	DCD	bc_impl_fastore                        ; 0x51 ; offset=324 (0x144)
	DCD	bc_impl_dastore                        ; 0x52 ; offset=328 (0x148)
	DCD	bc_impl_aastore                        ; 0x53 ; offset=332 (0x14c)
	DCD	bc_impl_bastore                        ; 0x54 ; offset=336 (0x150)
	DCD	bc_impl_castore                        ; 0x55 ; offset=340 (0x154)
	DCD	bc_impl_sastore                        ; 0x56 ; offset=344 (0x158)
	DCD	bc_impl_pop                            ; 0x57 ; offset=348 (0x15c)
	DCD	bc_impl_pop2                           ; 0x58 ; offset=352 (0x160)
	DCD	bc_impl_dup                            ; 0x59 ; offset=356 (0x164)
	DCD	bc_impl_dup_x1                         ; 0x5a ; offset=360 (0x168)
	DCD	bc_impl_dup_x2                         ; 0x5b ; offset=364 (0x16c)
	DCD	bc_impl_dup2                           ; 0x5c ; offset=368 (0x170)
	DCD	bc_impl_dup2_x1                        ; 0x5d ; offset=372 (0x174)
	DCD	bc_impl_dup2_x2                        ; 0x5e ; offset=376 (0x178)
	DCD	bc_impl_swap                           ; 0x5f ; offset=380 (0x17c)
	DCD	bc_impl_iadd                           ; 0x60 ; offset=384 (0x180)
	DCD	bc_impl_ladd                           ; 0x61 ; offset=388 (0x184)
	DCD	bc_impl_fadd                           ; 0x62 ; offset=392 (0x188)
	DCD	bc_impl_dadd                           ; 0x63 ; offset=396 (0x18c)
	DCD	bc_impl_isub                           ; 0x64 ; offset=400 (0x190)
	DCD	bc_impl_lsub                           ; 0x65 ; offset=404 (0x194)
	DCD	bc_impl_fsub                           ; 0x66 ; offset=408 (0x198)
	DCD	bc_impl_dsub                           ; 0x67 ; offset=412 (0x19c)
	DCD	bc_impl_imul                           ; 0x68 ; offset=416 (0x1a0)
	DCD	bc_impl_lmul                           ; 0x69 ; offset=420 (0x1a4)
	DCD	bc_impl_fmul                           ; 0x6a ; offset=424 (0x1a8)
	DCD	bc_impl_dmul                           ; 0x6b ; offset=428 (0x1ac)
	DCD	bc_impl_idiv                           ; 0x6c ; offset=432 (0x1b0)
	DCD	bc_impl_ldiv                           ; 0x6d ; offset=436 (0x1b4)
	DCD	bc_impl_fdiv                           ; 0x6e ; offset=440 (0x1b8)
	DCD	bc_impl_ddiv                           ; 0x6f ; offset=444 (0x1bc)
	DCD	bc_impl_irem                           ; 0x70 ; offset=448 (0x1c0)
	DCD	bc_impl_lrem                           ; 0x71 ; offset=452 (0x1c4)
	DCD	bc_impl_frem                           ; 0x72 ; offset=456 (0x1c8)
	DCD	bc_impl_drem                           ; 0x73 ; offset=460 (0x1cc)
	DCD	bc_impl_ineg                           ; 0x74 ; offset=464 (0x1d0)
	DCD	bc_impl_lneg                           ; 0x75 ; offset=468 (0x1d4)
	DCD	bc_impl_fneg                           ; 0x76 ; offset=472 (0x1d8)
	DCD	bc_impl_dneg                           ; 0x77 ; offset=476 (0x1dc)
	DCD	bc_impl_ishl                           ; 0x78 ; offset=480 (0x1e0)
	DCD	bc_impl_lshl                           ; 0x79 ; offset=484 (0x1e4)
	DCD	bc_impl_ishr                           ; 0x7a ; offset=488 (0x1e8)
	DCD	bc_impl_lshr                           ; 0x7b ; offset=492 (0x1ec)
	DCD	bc_impl_iushr                          ; 0x7c ; offset=496 (0x1f0)
	DCD	bc_impl_lushr                          ; 0x7d ; offset=500 (0x1f4)
	DCD	bc_impl_iand                           ; 0x7e ; offset=504 (0x1f8)
	DCD	bc_impl_land                           ; 0x7f ; offset=508 (0x1fc)
	DCD	bc_impl_ior                            ; 0x80 ; offset=512 (0x200)
	DCD	bc_impl_lor                            ; 0x81 ; offset=516 (0x204)
	DCD	bc_impl_ixor                           ; 0x82 ; offset=520 (0x208)
	DCD	bc_impl_lxor                           ; 0x83 ; offset=524 (0x20c)
	DCD	bc_impl_iinc                           ; 0x84 ; offset=528 (0x210)
	DCD	bc_impl_i2l                            ; 0x85 ; offset=532 (0x214)
	DCD	bc_impl_i2f                            ; 0x86 ; offset=536 (0x218)
	DCD	bc_impl_i2d                            ; 0x87 ; offset=540 (0x21c)
	DCD	bc_impl_l2i                            ; 0x88 ; offset=544 (0x220)
	DCD	bc_impl_l2f                            ; 0x89 ; offset=548 (0x224)
	DCD	bc_impl_l2d                            ; 0x8a ; offset=552 (0x228)
	DCD	bc_impl_f2i                            ; 0x8b ; offset=556 (0x22c)
	DCD	bc_impl_f2l                            ; 0x8c ; offset=560 (0x230)
	DCD	bc_impl_f2d                            ; 0x8d ; offset=564 (0x234)
	DCD	bc_impl_d2i                            ; 0x8e ; offset=568 (0x238)
	DCD	bc_impl_d2l                            ; 0x8f ; offset=572 (0x23c)
	DCD	bc_impl_d2f                            ; 0x90 ; offset=576 (0x240)
	DCD	bc_impl_i2b                            ; 0x91 ; offset=580 (0x244)
	DCD	bc_impl_i2c                            ; 0x92 ; offset=584 (0x248)
	DCD	bc_impl_i2s                            ; 0x93 ; offset=588 (0x24c)
	DCD	bc_impl_lcmp                           ; 0x94 ; offset=592 (0x250)
	DCD	bc_impl_fcmpl                          ; 0x95 ; offset=596 (0x254)
	DCD	bc_impl_fcmpg                          ; 0x96 ; offset=600 (0x258)
	DCD	bc_impl_dcmpl                          ; 0x97 ; offset=604 (0x25c)
	DCD	bc_impl_dcmpg                          ; 0x98 ; offset=608 (0x260)
	DCD	bc_impl_ifeq                           ; 0x99 ; offset=612 (0x264)
	DCD	bc_impl_ifne                           ; 0x9a ; offset=616 (0x268)
	DCD	bc_impl_iflt                           ; 0x9b ; offset=620 (0x26c)
	DCD	bc_impl_ifge                           ; 0x9c ; offset=624 (0x270)
	DCD	bc_impl_ifgt                           ; 0x9d ; offset=628 (0x274)
	DCD	bc_impl_ifle                           ; 0x9e ; offset=632 (0x278)
	DCD	bc_impl_if_icmpeq                      ; 0x9f ; offset=636 (0x27c)
	DCD	bc_impl_if_icmpne                      ; 0xa0 ; offset=640 (0x280)
	DCD	bc_impl_if_icmplt                      ; 0xa1 ; offset=644 (0x284)
	DCD	bc_impl_if_icmpge                      ; 0xa2 ; offset=648 (0x288)
	DCD	bc_impl_if_icmpgt                      ; 0xa3 ; offset=652 (0x28c)
	DCD	bc_impl_if_icmple                      ; 0xa4 ; offset=656 (0x290)
	DCD	bc_impl_if_acmpeq                      ; 0xa5 ; offset=660 (0x294)
	DCD	bc_impl_if_acmpne                      ; 0xa6 ; offset=664 (0x298)
	DCD	bc_impl_goto                           ; 0xa7 ; offset=668 (0x29c)
	DCD	0x0                      ; undefined bytecode 0xa8 offset=672 (0x2a0)
	DCD	0x0                      ; undefined bytecode 0xa9 offset=676 (0x2a4)
	DCD	bc_impl_tableswitch                    ; 0xaa ; offset=680 (0x2a8)
	DCD	bc_impl_lookupswitch                   ; 0xab ; offset=684 (0x2ac)
	DCD	bc_impl_ireturn                        ; 0xac ; offset=688 (0x2b0)
	DCD	bc_impl_lreturn                        ; 0xad ; offset=692 (0x2b4)
	DCD	bc_impl_freturn                        ; 0xae ; offset=696 (0x2b8)
	DCD	bc_impl_dreturn                        ; 0xaf ; offset=700 (0x2bc)
	DCD	bc_impl_areturn                        ; 0xb0 ; offset=704 (0x2c0)
	DCD	bc_impl_return                         ; 0xb1 ; offset=708 (0x2c4)
	DCD	bc_impl_getstatic                      ; 0xb2 ; offset=712 (0x2c8)
	DCD	bc_impl_putstatic                      ; 0xb3 ; offset=716 (0x2cc)
	DCD	bc_impl_getfield                       ; 0xb4 ; offset=720 (0x2d0)
	DCD	bc_impl_putfield                       ; 0xb5 ; offset=724 (0x2d4)
	DCD	bc_impl_invokevirtual                  ; 0xb6 ; offset=728 (0x2d8)
	DCD	bc_impl_invokespecial                  ; 0xb7 ; offset=732 (0x2dc)
	DCD	bc_impl_invokestatic                   ; 0xb8 ; offset=736 (0x2e0)
	DCD	bc_impl_invokeinterface                ; 0xb9 ; offset=740 (0x2e4)
	DCD	0x0                      ; undefined bytecode 0xba offset=744 (0x2e8)
	DCD	bc_impl_new                            ; 0xbb ; offset=748 (0x2ec)
	DCD	bc_impl_newarray                       ; 0xbc ; offset=752 (0x2f0)
	DCD	bc_impl_anewarray                      ; 0xbd ; offset=756 (0x2f4)
	DCD	bc_impl_arraylength                    ; 0xbe ; offset=760 (0x2f8)
	DCD	bc_impl_athrow                         ; 0xbf ; offset=764 (0x2fc)
	DCD	bc_impl_checkcast                      ; 0xc0 ; offset=768 (0x300)
	DCD	bc_impl_instanceof                     ; 0xc1 ; offset=772 (0x304)
	DCD	bc_impl_monitorenter                   ; 0xc2 ; offset=776 (0x308)
	DCD	bc_impl_monitorexit                    ; 0xc3 ; offset=780 (0x30c)
	DCD	bc_impl_wide                           ; 0xc4 ; offset=784 (0x310)
	DCD	bc_impl_multianewarray                 ; 0xc5 ; offset=788 (0x314)
	DCD	bc_impl_ifnull                         ; 0xc6 ; offset=792 (0x318)
	DCD	bc_impl_ifnonnull                      ; 0xc7 ; offset=796 (0x31c)
	DCD	bc_impl_goto_w                         ; 0xc8 ; offset=800 (0x320)
	DCD	0x0                      ; undefined bytecode 0xc9 offset=804 (0x324)
	DCD	bc_impl_breakpoint                     ; 0xca ; offset=808 (0x328)
	DCD	bc_impl_fast_1_ldc                     ; 0xcb ; offset=812 (0x32c)
	DCD	bc_impl_fast_1_ldc_w                   ; 0xcc ; offset=816 (0x330)
	DCD	bc_impl_fast_2_ldc_w                   ; 0xcd ; offset=820 (0x334)
	DCD	bc_impl_fast_1_putstatic               ; 0xce ; offset=824 (0x338)
	DCD	bc_impl_fast_2_putstatic               ; 0xcf ; offset=828 (0x33c)
	DCD	bc_impl_fast_a_putstatic               ; 0xd0 ; offset=832 (0x340)
	DCD	bc_impl_fast_1_getstatic               ; 0xd1 ; offset=836 (0x344)
	DCD	bc_impl_fast_2_getstatic               ; 0xd2 ; offset=840 (0x348)
	DCD	bc_impl_fast_bputfield                 ; 0xd3 ; offset=844 (0x34c)
	DCD	bc_impl_fast_sputfield                 ; 0xd4 ; offset=848 (0x350)
	DCD	bc_impl_fast_iputfield                 ; 0xd5 ; offset=852 (0x354)
	DCD	bc_impl_fast_lputfield                 ; 0xd6 ; offset=856 (0x358)
	DCD	bc_impl_fast_fputfield                 ; 0xd7 ; offset=860 (0x35c)
	DCD	bc_impl_fast_dputfield                 ; 0xd8 ; offset=864 (0x360)
	DCD	bc_impl_fast_aputfield                 ; 0xd9 ; offset=868 (0x364)
	DCD	bc_impl_fast_bgetfield                 ; 0xda ; offset=872 (0x368)
	DCD	bc_impl_fast_sgetfield                 ; 0xdb ; offset=876 (0x36c)
	DCD	bc_impl_fast_igetfield                 ; 0xdc ; offset=880 (0x370)
	DCD	bc_impl_fast_lgetfield                 ; 0xdd ; offset=884 (0x374)
	DCD	bc_impl_fast_fgetfield                 ; 0xde ; offset=888 (0x378)
	DCD	bc_impl_fast_dgetfield                 ; 0xdf ; offset=892 (0x37c)
	DCD	bc_impl_fast_agetfield                 ; 0xe0 ; offset=896 (0x380)
	DCD	bc_impl_fast_cgetfield                 ; 0xe1 ; offset=900 (0x384)
	DCD	bc_impl_fast_invokevirtual             ; 0xe2 ; offset=904 (0x388)
	DCD	bc_impl_fast_invokestatic              ; 0xe3 ; offset=908 (0x38c)
	DCD	bc_impl_fast_invokeinterface           ; 0xe4 ; offset=912 (0x390)
	DCD	bc_impl_fast_invokenative              ; 0xe5 ; offset=916 (0x394)
	DCD	bc_impl_fast_invokevirtual_final       ; 0xe6 ; offset=920 (0x398)
	DCD	bc_impl_fast_invokespecial             ; 0xe7 ; offset=924 (0x39c)
	DCD	bc_impl_fast_new                       ; 0xe8 ; offset=928 (0x3a0)
	DCD	bc_impl_fast_anewarray                 ; 0xe9 ; offset=932 (0x3a4)
	DCD	bc_impl_fast_checkcast                 ; 0xea ; offset=936 (0x3a8)
	DCD	bc_impl_fast_instanceof                ; 0xeb ; offset=940 (0x3ac)
	DCD	bc_impl_fast_igetfield_1               ; 0xec ; offset=944 (0x3b0)
	DCD	bc_impl_fast_agetfield_1               ; 0xed ; offset=948 (0x3b4)
	DCD	bc_impl_aload_0_fast_agetfield_1       ; 0xee ; offset=952 (0x3b8)
	DCD	bc_impl_aload_0_fast_igetfield_1       ; 0xef ; offset=956 (0x3bc)
	DCD	bc_impl_pop_and_npe_if_null            ; 0xf0 ; offset=960 (0x3c0)
	DCD	bc_impl_init_static_array              ; 0xf1 ; offset=964 (0x3c4)
	DCD	bc_impl_aload_0_fast_agetfield_4       ; 0xf2 ; offset=968 (0x3c8)
	DCD	bc_impl_aload_0_fast_igetfield_4       ; 0xf3 ; offset=972 (0x3cc)
	DCD	bc_impl_aload_0_fast_agetfield_8       ; 0xf4 ; offset=976 (0x3d0)
	DCD	bc_impl_aload_0_fast_igetfield_8       ; 0xf5 ; offset=980 (0x3d4)
	DCD	bc_impl_fast_init_1_putstatic          ; 0xf6 ; offset=984 (0x3d8)
	DCD	bc_impl_fast_init_2_putstatic          ; 0xf7 ; offset=988 (0x3dc)
	DCD	bc_impl_fast_init_a_putstatic          ; 0xf8 ; offset=992 (0x3e0)
	DCD	bc_impl_fast_init_1_getstatic          ; 0xf9 ; offset=996 (0x3e4)
	DCD	bc_impl_fast_init_2_getstatic          ; 0xfa ; offset=1000 (0x3e8)
	DCD	bc_impl_fast_init_invokestatic         ; 0xfb ; offset=1004 (0x3ec)
	DCD	bc_impl_fast_init_new                  ; 0xfc ; offset=1008 (0x3f0)
	DCD	0x0                      ; undefined bytecode 0xfd offset=1012 (0x3f4)
	DCD	0x0                      ; offset=1016 (0x3f8)
	DCD	0x0                      ; offset=1020 (0x3fc)

	EXPORT	gp_constants
gp_constants

	EXPORT	_current_stack_limit
_current_stack_limit
	%	4                        ; offset=1024 (0x400)

	EXPORT	_compiler_stack_limit
_compiler_stack_limit
	%	4                        ; offset=1028 (0x404)

	EXPORT	_rt_timer_ticks
_rt_timer_ticks
	%	4                        ; offset=1032 (0x408)

	EXPORT	jvm_fast_globals
jvm_fast_globals

	EXPORT	_current_thread
_current_thread
	%	4                        ; offset=1036 (0x40c)

	EXPORT	_current_pending_exception
_current_pending_exception
	%	4                        ; offset=1040 (0x410)

	EXPORT	_last_handle
_last_handle
	%	4                        ; offset=1044 (0x414)

	EXPORT	_collection_area_start
_collection_area_start
	%	4                        ; offset=1048 (0x418)

	EXPORT	_heap_start
_heap_start
	%	4                        ; offset=1052 (0x41c)

	EXPORT	_heap_top
_heap_top
	%	4                        ; offset=1056 (0x420)

	EXPORT	_inline_allocation_top
_inline_allocation_top
	%	4                        ; offset=1060 (0x424)

	EXPORT	_inline_allocation_end
_inline_allocation_end
	%	4                        ; offset=1064 (0x428)

	EXPORT	_heap_limit
_heap_limit
	%	4                        ; offset=1068 (0x42c)

	EXPORT	_heap_end
_heap_end
	%	4                        ; offset=1072 (0x430)

	EXPORT	_bitvector_base
_bitvector_base
	%	4                        ; offset=1076 (0x434)

	EXPORT	_bit_selector
_bit_selector
	DCD	0x80808080               ; offset=1080 (0x438)

	EXPORT	_young_generation_start
_young_generation_start
	%	4                        ; offset=1084 (0x43c)

	EXPORT	_collection_area_end
_collection_area_end
	%	4                        ; offset=1088 (0x440)

	EXPORT	_young_generation_target_size
_young_generation_target_size
	%	4                        ; offset=1092 (0x444)

	EXPORT	_end_fixed_objects
_end_fixed_objects
	%	4                        ; offset=1096 (0x448)

	EXPORT	_marking_stack_start
_marking_stack_start
	%	4                        ; offset=1100 (0x44c)

	EXPORT	_marking_stack_top
_marking_stack_top
	%	4                        ; offset=1104 (0x450)

	EXPORT	_marking_stack_end
_marking_stack_end
	%	4                        ; offset=1108 (0x454)

	EXPORT	_marking_stack_overflow
_marking_stack_overflow
	%	4                        ; offset=1112 (0x458)

	EXPORT	_slices_start
_slices_start
	%	4                        ; offset=1116 (0x45c)

	EXPORT	_slice_shift
_slice_shift
	%	4                        ; offset=1120 (0x460)

	EXPORT	_slice_offset_bits
_slice_offset_bits
	%	4                        ; offset=1124 (0x464)

	EXPORT	_slice_size
_slice_size
	%	4                        ; offset=1128 (0x468)

	EXPORT	_near_mask
_near_mask
	%	4                        ; offset=1132 (0x46c)

	EXPORT	_slice_offset_mask
_slice_offset_mask
	%	4                        ; offset=1136 (0x470)

	EXPORT	_nof_slices
_nof_slices
	%	4                        ; offset=1140 (0x474)

	EXPORT	_compaction_start
_compaction_start
	%	4                        ; offset=1144 (0x478)

	EXPORT	_compaction_top
_compaction_top
	%	4                        ; offset=1148 (0x47c)

	EXPORT	_heap_min
_heap_min
	%	4                        ; offset=1152 (0x480)

	EXPORT	_heap_capacity
_heap_capacity
	%	4                        ; offset=1156 (0x484)

	EXPORT	_heap_size
_heap_size
	%	4                        ; offset=1160 (0x488)

	EXPORT	_compiler_area_start
_compiler_area_start
	%	4                        ; offset=1164 (0x48c)

	EXPORT	_compiler_area_top
_compiler_area_top
	%	4                        ; offset=1168 (0x490)

	EXPORT	_large_object_area_bottom
_large_object_area_bottom
	%	4                        ; offset=1172 (0x494)

	EXPORT	_compiler_area_temp_top
_compiler_area_temp_top
	%	4                        ; offset=1176 (0x498)

	EXPORT	_compiler_area_temp_bottom
_compiler_area_temp_bottom
	%	4                        ; offset=1180 (0x49c)

	EXPORT	_compiler_state
_compiler_state
	%	4                        ; offset=1184 (0x4a0)

	EXPORT	_current_compiler
_current_compiler
	%	4                        ; offset=1188 (0x4a4)

	EXPORT	_num_stack_lock_words
_num_stack_lock_words
	%	4                        ; offset=1192 (0x4a8)

	EXPORT	_class_list_base
_class_list_base
	%	4                        ; offset=1196 (0x4ac)

	EXPORT	_mirror_list_base
_mirror_list_base
	%	4                        ; offset=1200 (0x4b0)

	EXPORT	_interpretation_log
_interpretation_log
	%	36                       ; offset=1204 (0x4b4)

	EXPORT	_interpretation_log_idx
_interpretation_log_idx
	%	4                        ; offset=1240 (0x4d8)

	EXPORT	_primordial_sp
_primordial_sp
	%	4                        ; offset=1244 (0x4dc)

	EXPORT	_old_generation_end
_old_generation_end
	%	4                        ; offset=1248 (0x4e0)

	EXPORT	_bytecode_counter
_bytecode_counter
	%	4                        ; offset=1252 (0x4e4)

	EXPORT	_kni_parameter_base
_kni_parameter_base
	%	4                        ; offset=1256 (0x4e8)

	EXPORT	_rom_constant_pool_fast
_rom_constant_pool_fast
	%	4                        ; offset=1260 (0x4ec)

	EXPORT	_gp_bytecode_counter
_gp_bytecode_counter
	%	4                        ; offset=1264 (0x4f0)

	EXPORT	_jvm_in_quick_native_method
_jvm_in_quick_native_method
	%	4                        ; offset=1268 (0x4f4)

	EXPORT	_jvm_quick_native_exception
_jvm_quick_native_exception
	%	4                        ; offset=1272 (0x4f8)

	EXPORT	_method_execution_sensor
_method_execution_sensor
	%	512                      ; offset=1276 (0x4fc)

	EXPORT	_interned_string_near_addr
_interned_string_near_addr
	%	4                        ; offset=1788 (0x6fc)

	EXPORT	_persistent_handles_addr
_persistent_handles_addr
	%	4                        ; offset=1792 (0x700)

	EXPORT	_current_task
_current_task
	%	4                        ; offset=1796 (0x704)

	EXPORT	_task_class_init_marker
_task_class_init_marker
	%	4                        ; offset=1800 (0x708)

	EXPORT	gp_compiler_new_object_ptr
gp_compiler_new_object_ptr
	DCD	compiler_new_object      ; offset=1804 (0x70c)

	EXPORT	gp_compiler_new_type_array_ptr
gp_compiler_new_type_array_ptr
	DCD	compiler_new_type_array  ; offset=1808 (0x710)

	EXPORT	gp_compiler_timer_tick_ptr
gp_compiler_timer_tick_ptr
	DCD	compiler_timer_tick      ; offset=1812 (0x714)

	EXPORT	gp_shared_monitor_enter_ptr
gp_shared_monitor_enter_ptr
	DCD	shared_monitor_enter     ; offset=1816 (0x718)

	EXPORT	gp_shared_monitor_exit_ptr
gp_shared_monitor_exit_ptr
	DCD	shared_monitor_exit      ; offset=1820 (0x71c)

	EXPORT	gp_shared_lock_synchronized_method_ptr
gp_shared_lock_synchronized_method_ptr
	DCD	shared_lock_synchronized_method ; offset=1824 (0x720)

	EXPORT	gp_shared_unlock_synchronized_method_ptr
gp_shared_unlock_synchronized_method_ptr
	DCD	shared_unlock_synchronized_method ; offset=1828 (0x724)

	EXPORT	gp_shared_call_vm_oop_ptr
gp_shared_call_vm_oop_ptr
	DCD	shared_call_vm_oop       ; offset=1832 (0x728)

	EXPORT	gp_shared_call_vm_exception_ptr
gp_shared_call_vm_exception_ptr
	DCD	shared_call_vm_exception ; offset=1836 (0x72c)

	EXPORT	gp_shared_call_vm_ptr
gp_shared_call_vm_ptr
	DCD	shared_call_vm           ; offset=1840 (0x730)

	EXPORT	gp_interpreter_method_entry_ptr
gp_interpreter_method_entry_ptr
	DCD	interpreter_method_entry ; offset=1844 (0x734)

	EXPORT	gp_compiler_new_obj_array_ptr
gp_compiler_new_obj_array_ptr
	DCD	compiler_new_obj_array   ; offset=1848 (0x738)

	EXPORT	gp_compiler_idiv_irem_ptr
gp_compiler_idiv_irem_ptr
	DCD	compiler_idiv_irem       ; offset=1852 (0x73c)

	EXPORT	gp_compiler_checkcast_ptr
gp_compiler_checkcast_ptr
	DCD	compiler_checkcast       ; offset=1856 (0x740)

	EXPORT	gp_compiler_instanceof_ptr
gp_compiler_instanceof_ptr
	DCD	compiler_instanceof      ; offset=1860 (0x744)

	EXPORT	gp_compiler_throw_NullPointerException_ptr
gp_compiler_throw_NullPointerException_ptr
	DCD	compiler_throw_NullPointerException ; offset=1864 (0x748)

	EXPORT	gp_compiler_throw_NullPointerException_0_ptr
gp_compiler_throw_NullPointerException_0_ptr
	DCD	compiler_throw_NullPointerException_0 ; offset=1868 (0x74c)

	EXPORT	gp_compiler_throw_NullPointerException_1_ptr
gp_compiler_throw_NullPointerException_1_ptr
	DCD	compiler_throw_NullPointerException_1 ; offset=1872 (0x750)

	EXPORT	gp_compiler_throw_NullPointerException_2_ptr
gp_compiler_throw_NullPointerException_2_ptr
	DCD	compiler_throw_NullPointerException_2 ; offset=1876 (0x754)

	EXPORT	gp_compiler_throw_NullPointerException_3_ptr
gp_compiler_throw_NullPointerException_3_ptr
	DCD	compiler_throw_NullPointerException_3 ; offset=1880 (0x758)

	EXPORT	gp_compiler_throw_NullPointerException_4_ptr
gp_compiler_throw_NullPointerException_4_ptr
	DCD	compiler_throw_NullPointerException_4 ; offset=1884 (0x75c)

	EXPORT	gp_compiler_throw_NullPointerException_5_ptr
gp_compiler_throw_NullPointerException_5_ptr
	DCD	compiler_throw_NullPointerException_5 ; offset=1888 (0x760)

	EXPORT	gp_compiler_throw_NullPointerException_6_ptr
gp_compiler_throw_NullPointerException_6_ptr
	DCD	compiler_throw_NullPointerException_6 ; offset=1892 (0x764)

	EXPORT	gp_compiler_throw_NullPointerException_7_ptr
gp_compiler_throw_NullPointerException_7_ptr
	DCD	compiler_throw_NullPointerException_7 ; offset=1896 (0x768)

	EXPORT	gp_compiler_throw_NullPointerException_8_ptr
gp_compiler_throw_NullPointerException_8_ptr
	DCD	compiler_throw_NullPointerException_8 ; offset=1900 (0x76c)

	EXPORT	gp_compiler_throw_NullPointerException_9_ptr
gp_compiler_throw_NullPointerException_9_ptr
	DCD	compiler_throw_NullPointerException_9 ; offset=1904 (0x770)

	EXPORT	gp_compiler_throw_NullPointerException_10_ptr
gp_compiler_throw_NullPointerException_10_ptr
	DCD	compiler_throw_NullPointerException_10 ; offset=1908 (0x774)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException ; offset=1912 (0x778)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_0_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_0_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_0 ; offset=1916 (0x77c)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_1_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_1_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_1 ; offset=1920 (0x780)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_2_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_2_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_2 ; offset=1924 (0x784)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_3_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_3_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_3 ; offset=1928 (0x788)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_4_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_4_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_4 ; offset=1932 (0x78c)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_5_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_5_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_5 ; offset=1936 (0x790)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_6_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_6_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_6 ; offset=1940 (0x794)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_7_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_7_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_7 ; offset=1944 (0x798)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_8_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_8_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_8 ; offset=1948 (0x79c)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_9_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_9_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_9 ; offset=1952 (0x7a0)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_10_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_10_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_10 ; offset=1956 (0x7a4)

	EXPORT	gp_stack_overflow_ptr
gp_stack_overflow_ptr
	IMPORT	stack_overflow
	DCD	stack_overflow           ; offset=1960 (0x7a8)

	EXPORT	gp_timer_tick_ptr
gp_timer_tick_ptr
	IMPORT	timer_tick
	DCD	timer_tick               ; offset=1964 (0x7ac)

	EXPORT	gp_lock_stack_lock_ptr
gp_lock_stack_lock_ptr
	IMPORT	lock_stack_lock
	DCD	lock_stack_lock          ; offset=1968 (0x7b0)

	EXPORT	gp_signal_waiters_ptr
gp_signal_waiters_ptr
	IMPORT	signal_waiters
	DCD	signal_waiters           ; offset=1972 (0x7b4)

	EXPORT	gp_array_index_out_of_bounds_exception_ptr
gp_array_index_out_of_bounds_exception_ptr
	IMPORT	array_index_out_of_bounds_exception
	DCD	array_index_out_of_bounds_exception ; offset=1976 (0x7b8)

	EXPORT	gp_get_array_index_out_of_bounds_exception_ptr
gp_get_array_index_out_of_bounds_exception_ptr
	IMPORT	get_array_index_out_of_bounds_exception
	DCD	get_array_index_out_of_bounds_exception ; offset=1980 (0x7bc)

	EXPORT	gp_null_pointer_exception_ptr
gp_null_pointer_exception_ptr
	IMPORT	null_pointer_exception
	DCD	null_pointer_exception   ; offset=1984 (0x7c0)

	EXPORT	gp_get_null_pointer_exception_ptr
gp_get_null_pointer_exception_ptr
	IMPORT	get_null_pointer_exception
	DCD	get_null_pointer_exception ; offset=1988 (0x7c4)

	EXPORT	gp_illegal_monitor_state_exception_ptr
gp_illegal_monitor_state_exception_ptr
	IMPORT	illegal_monitor_state_exception
	DCD	illegal_monitor_state_exception ; offset=1992 (0x7c8)

	EXPORT	gp_get_illegal_monitor_state_exception_ptr
gp_get_illegal_monitor_state_exception_ptr
	IMPORT	get_illegal_monitor_state_exception
	DCD	get_illegal_monitor_state_exception ; offset=1996 (0x7cc)

	EXPORT	gp_division_by_zero_exception_ptr
gp_division_by_zero_exception_ptr
	IMPORT	division_by_zero_exception
	DCD	division_by_zero_exception ; offset=2000 (0x7d0)

	EXPORT	gp_get_division_by_zero_exception_ptr
gp_get_division_by_zero_exception_ptr
	IMPORT	get_division_by_zero_exception
	DCD	get_division_by_zero_exception ; offset=2004 (0x7d4)

	EXPORT	gp_get_incompatible_class_change_error_ptr
gp_get_incompatible_class_change_error_ptr
	IMPORT	get_incompatible_class_change_error
	DCD	get_incompatible_class_change_error ; offset=2008 (0x7d8)

	EXPORT	gp_multianewarray_ptr
gp_multianewarray_ptr
	IMPORT	multianewarray
	DCD	multianewarray           ; offset=2012 (0x7dc)

	EXPORT	gp_instanceof_ptr
gp_instanceof_ptr
	IMPORT	instanceof
	DCD	instanceof               ; offset=2016 (0x7e0)

	EXPORT	gp__instanceof_ptr
gp__instanceof_ptr
	IMPORT	_instanceof
	DCD	_instanceof              ; offset=2020 (0x7e4)

	EXPORT	gp_checkcast_ptr
gp_checkcast_ptr
	IMPORT	checkcast
	DCD	checkcast                ; offset=2024 (0x7e8)

	EXPORT	gp_array_store_type_check_ptr
gp_array_store_type_check_ptr
	IMPORT	array_store_type_check
	DCD	array_store_type_check   ; offset=2028 (0x7ec)

	EXPORT	gp_compiled_code_task_barrier_ptr
gp_compiled_code_task_barrier_ptr
	IMPORT	compiled_code_task_barrier
	DCD	compiled_code_task_barrier ; offset=2032 (0x7f0)

	EXPORT	gp_jvm_ldiv_ptr
gp_jvm_ldiv_ptr
	IMPORT	jvm_ldiv
	DCD	jvm_ldiv                 ; offset=2036 (0x7f4)

	EXPORT	gp_jvm_lrem_ptr
gp_jvm_lrem_ptr
	IMPORT	jvm_lrem
	DCD	jvm_lrem                 ; offset=2040 (0x7f8)

	EXPORT	gp_jvm_memcpy_ptr
gp_jvm_memcpy_ptr
	DCD	jvm_memcpy               ; offset=2044 (0x7fc)

	EXPORT	gp_deoptimize_ptr
gp_deoptimize_ptr
	IMPORT	deoptimize
	DCD	deoptimize               ; offset=2048 (0x800)

	EXPORT	gp_uncommon_trap_ptr
gp_uncommon_trap_ptr
	IMPORT	uncommon_trap
	DCD	uncommon_trap            ; offset=2052 (0x804)

	EXPORT	gp_get_method_ptr
gp_get_method_ptr
	IMPORT	get_method
	DCD	get_method               ; offset=2056 (0x808)

	EXPORT	gp_trace_bytecode_ptr
gp_trace_bytecode_ptr
	IMPORT	trace_bytecode
	DCD	trace_bytecode           ; offset=2060 (0x80c)

	EXPORT	gp_native_system_arraycopy_entry_ptr
gp_native_system_arraycopy_entry_ptr
	DCD	native_system_arraycopy_entry ; offset=2064 (0x810)

	EXPORT	gp_native_jvm_unchecked_byte_arraycopy_entry_ptr
gp_native_jvm_unchecked_byte_arraycopy_entry_ptr
	DCD	native_jvm_unchecked_byte_arraycopy_entry ; offset=2068 (0x814)

	EXPORT	gp_native_jvm_unchecked_char_arraycopy_entry_ptr
gp_native_jvm_unchecked_char_arraycopy_entry_ptr
	DCD	native_jvm_unchecked_char_arraycopy_entry ; offset=2072 (0x818)

	EXPORT	gp_native_jvm_unchecked_int_arraycopy_entry_ptr
gp_native_jvm_unchecked_int_arraycopy_entry_ptr
	DCD	native_jvm_unchecked_int_arraycopy_entry ; offset=2076 (0x81c)

	EXPORT	gp_native_jvm_unchecked_obj_arraycopy_entry_ptr
gp_native_jvm_unchecked_obj_arraycopy_entry_ptr
	DCD	native_jvm_unchecked_obj_arraycopy_entry ; offset=2080 (0x820)

	EXPORT	gp_native_string_indexof_entry_ptr
gp_native_string_indexof_entry_ptr
	DCD	native_string_indexof_entry ; offset=2084 (0x824)

	EXPORT	gp_native_string_indexof0_entry_ptr
gp_native_string_indexof0_entry_ptr
	DCD	native_string_indexof0_entry ; offset=2088 (0x828)

	EXPORT	gp_jvm_fadd_ptr
gp_jvm_fadd_ptr
	DCD	jvm_fadd                 ; offset=2092 (0x82c)

	EXPORT	gp_jvm_fsub_ptr
gp_jvm_fsub_ptr
	DCD	jvm_fsub                 ; offset=2096 (0x830)

	EXPORT	gp_jvm_fmul_ptr
gp_jvm_fmul_ptr
	DCD	jvm_fmul                 ; offset=2100 (0x834)

	EXPORT	gp_jvm_fdiv_ptr
gp_jvm_fdiv_ptr
	DCD	jvm_fdiv                 ; offset=2104 (0x838)

	EXPORT	gp_jvm_frem_ptr
gp_jvm_frem_ptr
	DCD	jvm_frem                 ; offset=2108 (0x83c)

	EXPORT	gp_jvm_dadd_ptr
gp_jvm_dadd_ptr
	DCD	jvm_dadd                 ; offset=2112 (0x840)

	EXPORT	gp_jvm_dsub_ptr
gp_jvm_dsub_ptr
	DCD	jvm_dsub                 ; offset=2116 (0x844)

	EXPORT	gp_jvm_dmul_ptr
gp_jvm_dmul_ptr
	DCD	jvm_dmul                 ; offset=2120 (0x848)

	EXPORT	gp_jvm_ddiv_ptr
gp_jvm_ddiv_ptr
	DCD	jvm_ddiv                 ; offset=2124 (0x84c)

	EXPORT	gp_jvm_drem_ptr
gp_jvm_drem_ptr
	DCD	jvm_drem                 ; offset=2128 (0x850)

	EXPORT	gp_jvm_fcmpl_ptr
gp_jvm_fcmpl_ptr
	DCD	jvm_fcmpl                ; offset=2132 (0x854)

	EXPORT	gp_jvm_fcmpg_ptr
gp_jvm_fcmpg_ptr
	DCD	jvm_fcmpg                ; offset=2136 (0x858)

	EXPORT	gp_jvm_dcmpl_ptr
gp_jvm_dcmpl_ptr
	DCD	jvm_dcmpl                ; offset=2140 (0x85c)

	EXPORT	gp_jvm_dcmpg_ptr
gp_jvm_dcmpg_ptr
	DCD	jvm_dcmpg                ; offset=2144 (0x860)

	EXPORT	gp_jvm_i2d_ptr
gp_jvm_i2d_ptr
	DCD	jvm_i2d                  ; offset=2148 (0x864)

	EXPORT	gp_jvm_i2f_ptr
gp_jvm_i2f_ptr
	DCD	jvm_i2f                  ; offset=2152 (0x868)

	EXPORT	gp_jvm_l2d_ptr
gp_jvm_l2d_ptr
	DCD	jvm_l2d                  ; offset=2156 (0x86c)

	EXPORT	gp_jvm_l2f_ptr
gp_jvm_l2f_ptr
	DCD	jvm_l2f                  ; offset=2160 (0x870)

	EXPORT	gp_jvm_f2i_ptr
gp_jvm_f2i_ptr
	DCD	jvm_f2i                  ; offset=2164 (0x874)

	EXPORT	gp_jvm_f2l_ptr
gp_jvm_f2l_ptr
	DCD	jvm_f2l                  ; offset=2168 (0x878)

	EXPORT	gp_jvm_f2d_ptr
gp_jvm_f2d_ptr
	DCD	jvm_f2d                  ; offset=2172 (0x87c)

	EXPORT	gp_jvm_d2i_ptr
gp_jvm_d2i_ptr
	DCD	jvm_d2i                  ; offset=2176 (0x880)

	EXPORT	gp_jvm_d2l_ptr
gp_jvm_d2l_ptr
	DCD	jvm_d2l                  ; offset=2180 (0x884)

	EXPORT	gp_jvm_d2f_ptr
gp_jvm_d2f_ptr
	DCD	jvm_d2f                  ; offset=2184 (0x888)

	EXPORT	gp_fixed_interpreter_method_entry_ptr
gp_fixed_interpreter_method_entry_ptr
	DCD	fixed_interpreter_method_entry ; offset=2188 (0x88c)

	EXPORT	gp_fixed_interpreter_fast_method_entry_0_ptr
gp_fixed_interpreter_fast_method_entry_0_ptr
	DCD	fixed_interpreter_fast_method_entry_0 ; offset=2192 (0x890)

	EXPORT	gp_fixed_interpreter_fast_method_entry_1_ptr
gp_fixed_interpreter_fast_method_entry_1_ptr
	DCD	fixed_interpreter_fast_method_entry_1 ; offset=2196 (0x894)

	EXPORT	gp_fixed_interpreter_fast_method_entry_2_ptr
gp_fixed_interpreter_fast_method_entry_2_ptr
	DCD	fixed_interpreter_fast_method_entry_2 ; offset=2200 (0x898)

	EXPORT	gp_fixed_interpreter_fast_method_entry_3_ptr
gp_fixed_interpreter_fast_method_entry_3_ptr
	DCD	fixed_interpreter_fast_method_entry_3 ; offset=2204 (0x89c)

	EXPORT	gp_fixed_interpreter_fast_method_entry_4_ptr
gp_fixed_interpreter_fast_method_entry_4_ptr
	DCD	fixed_interpreter_fast_method_entry_4 ; offset=2208 (0x8a0)

	EXPORT	gp__newobject_ptr
gp__newobject_ptr
	DCD	_newobject               ; offset=2212 (0x8a4)

	EXPORT	gp_interpreter_throw_NullPointerException_ptr
gp_interpreter_throw_NullPointerException_ptr
	DCD	interpreter_throw_NullPointerException ; offset=2216 (0x8a8)

	EXPORT	gp_interpreter_throw_NullPointerException_tos_cached_ptr
gp_interpreter_throw_NullPointerException_tos_cached_ptr
	DCD	interpreter_throw_NullPointerException_tos_cached ; offset=2220 (0x8ac)

	EXPORT	gp_interpreter_throw_IncompatibleClassChangeError_ptr
gp_interpreter_throw_IncompatibleClassChangeError_ptr
	DCD	interpreter_throw_IncompatibleClassChangeError ; offset=2224 (0x8b0)

	EXPORT	gp_interpreter_grow_stack_ptr
gp_interpreter_grow_stack_ptr
	DCD	interpreter_grow_stack   ; offset=2228 (0x8b4)

	EXPORT	gp_interpreter_throw_ArrayIndexOutOfBoundsException_ptr
gp_interpreter_throw_ArrayIndexOutOfBoundsException_ptr
	DCD	interpreter_throw_ArrayIndexOutOfBoundsException ; offset=2232 (0x8b8)
	IMPORT	_rom_linkcheck_hle_true
	DCD	_rom_linkcheck_hle_true  ; offset=2236 (0x8bc)
	IMPORT	_rom_linkcheck_mffd_false
	DCD	_rom_linkcheck_mffd_false ; offset=2240 (0x8c0)
	IMPORT	_rom_linkcheck_mffl_false
	DCD	_rom_linkcheck_mffl_false ; offset=2244 (0x8c4)

	EXPORT	gp_constants_end
gp_constants_end
	; End segment: Global pool


	END
