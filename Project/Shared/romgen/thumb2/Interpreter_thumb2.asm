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
	THUMB
	AREA |.text|, CODE
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
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Quick native method entry (void)

	EXPORT	quick_void_native_method_entry
quick_void_native_method_entry PROC
	; get parameter size in words
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	; get access flags
	ldrh.w	r10, [r0, #24]            ; 0xf8b0 0xa018
	; get the address of quick native function
	ldr	r3, [r0, #28]             ; 0x69c3
	; Calculate bottom of my parameters
	add.w	r6, r6, r2, lsl #2        ; 0xeb06 0x0682
	; Test method staticness and set KNI parameters properly
	tst.w	r10, #8                   ; 0xf01a 0x0f08
	DCW 0xbf0c ; ITE eq               ; 0xbf0c ; Non-static method
	sub.w	r10, r6, #4               ; 0xf1a6 0x0a04
	add.w	r10, r6, #0               ; 0xf106 0x0a00 ; Static method, KNI-style, so first parameter at index 1
	str.w	r10, [r5, #472]           ; 0xf8c5 0xa1d8
	mov	r8, lr                    ; 0x46f0 ; save return address of caller
	orr.w	r8, r8, #1                ; 0xf048 0x0801
	blx	r3                        ; 0x4798
	mov	pc, r8                    ; 0x46c7 ; return back to caller
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Quick native method entry (int)

	EXPORT	quick_int_native_method_entry
quick_int_native_method_entry PROC
	; get parameter size in words
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	; get access flags
	ldrh.w	r10, [r0, #24]            ; 0xf8b0 0xa018
	; get the address of quick native function
	ldr	r3, [r0, #28]             ; 0x69c3
	; Calculate bottom of my parameters
	add.w	r6, r6, r2, lsl #2        ; 0xeb06 0x0682
	; Test method staticness and set KNI parameters properly
	tst.w	r10, #8                   ; 0xf01a 0x0f08
	DCW 0xbf0c ; ITE eq               ; 0xbf0c ; Non-static method
	sub.w	r10, r6, #4               ; 0xf1a6 0x0a04
	add.w	r10, r6, #0               ; 0xf106 0x0a00 ; Static method, KNI-style, so first parameter at index 1
	str.w	r10, [r5, #472]           ; 0xf8c5 0xa1d8
	mov	r8, lr                    ; 0x46f0 ; save return address of caller
	orr.w	r8, r8, #1                ; 0xf048 0x0801
	blx	r3                        ; 0x4798
	mov	pc, r8                    ; 0x46c7 ; return back to caller
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Quick native method entry (obj)

	EXPORT	quick_obj_native_method_entry
quick_obj_native_method_entry PROC
	; get parameter size in words
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	; get access flags
	ldrh.w	r10, [r0, #24]            ; 0xf8b0 0xa018
	; get the address of quick native function
	ldr	r3, [r0, #28]             ; 0x69c3
	; Calculate bottom of my parameters
	add.w	r6, r6, r2, lsl #2        ; 0xeb06 0x0682
	; Test method staticness and set KNI parameters properly
	tst.w	r10, #8                   ; 0xf01a 0x0f08
	DCW 0xbf0c ; ITE eq               ; 0xbf0c ; Non-static method
	sub.w	r10, r6, #4               ; 0xf1a6 0x0a04
	add.w	r10, r6, #0               ; 0xf106 0x0a00 ; Static method, KNI-style, so first parameter at index 1
	str.w	r10, [r5, #472]           ; 0xf8c5 0xa1d8
	mov	r8, lr                    ; 0x46f0 ; save return address of caller
	orr.w	r8, r8, #1                ; 0xf048 0x0801
	blx	r3                        ; 0x4798
	mov	pc, r8                    ; 0x46c7 ; return back to caller
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (0 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_0
fixed_interpreter_fast_method_entry_0 PROC
	nop                               ; 0xbf00

	ENDP

	EXPORT	interpreter_fast_method_entry_0
interpreter_fast_method_entry_0 PROC
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	add.w	r8, r6, r2, lsl #2        ; 0xeb06 0x0882
	sub.w	r8, r8, #4                ; 0xf1a8 0x0804
	; get maximum stack execution size
	ldrh	r3, [r0, #28]             ; 0x8b83
	ldr	r1, [r5, #84]; = current_stack_limit  ; 0x6d69
	sub.w	r3, r6, r3, lsl #2        ; 0xeba6 0x0383
	sub.w	r3, r3, #28               ; 0xf1a3 0x031c
	cmp	r3, r1                    ; 0x428b
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr	r1, =L0
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr.w	pc, [r5, #1212]; = interpreter_grow_stack  ; 0xf8d5 0xf4bc
L0
	; get constants pool
	ldrh.w	r9, [r0, #24]             ; 0xf8b0 0x9018 ; get access flags
	tst.w	r9, #512                  ; 0xf419 0x7f00 ; compressed header?
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r9, [r5, #476]; = rom_constant_pool_fast  ; 0xf8d5 0x91dc
	DCW 0xbf08 ; IT eq                ; 0xbf08 ; method constant pool
	ldr.w	r9, [r0, #4]              ; 0xf8d0 0x9004
	; Reserve space on stack for frame
	sub.w	r6, r6, #28               ; 0xf1a6 0x061c
	; Fill in fields of the frame
	add.w	r9, r9, #12               ; 0xf109 0x090c
	str.w	r6, [r6, #24]             ; 0xf8c6 0x6018
	str.w	r8, [r6, #8]              ; 0xf8c6 0x8008
	str.w	r9, [r6, #12]             ; 0xf8c6 0x900c
	str.w	r0, [r6, #16]             ; 0xf8c6 0x0010
	str.w	r4, [r6, #20]             ; 0xf8c6 0x4014
	str.w	lr, [r6, #0]              ; 0xf8c6 0xe000
	; Set the Frame pointer
	add.w	r4, r6, #20               ; 0xf106 0x0414
	; set bcp
	add.w	lr, r0, #40               ; 0xf100 0x0e28
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L1
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
L1
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (1 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_1
fixed_interpreter_fast_method_entry_1 PROC
	nop                               ; 0xbf00

	ENDP

	EXPORT	interpreter_fast_method_entry_1
interpreter_fast_method_entry_1 PROC
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	add.w	r8, r6, r2, lsl #2        ; 0xeb06 0x0882
	sub.w	r8, r8, #4                ; 0xf1a8 0x0804
	; get maximum stack execution size
	ldrh	r3, [r0, #28]             ; 0x8b83
	ldr	r1, [r5, #84]; = current_stack_limit  ; 0x6d69
	sub.w	r3, r6, r3, lsl #2        ; 0xeba6 0x0383
	sub.w	r3, r3, #28               ; 0xf1a3 0x031c
	cmp	r3, r1                    ; 0x428b
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr	r1, =L2
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr.w	pc, [r5, #1212]; = interpreter_grow_stack  ; 0xf8d5 0xf4bc
L2
	; push cleared locals
	sub.w	r6, r6, #4                ; 0xf1a6 0x0604
	; get constants pool
	ldrh.w	r9, [r0, #24]             ; 0xf8b0 0x9018 ; get access flags
	tst.w	r9, #512                  ; 0xf419 0x7f00 ; compressed header?
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r9, [r5, #476]; = rom_constant_pool_fast  ; 0xf8d5 0x91dc
	DCW 0xbf08 ; IT eq                ; 0xbf08 ; method constant pool
	ldr.w	r9, [r0, #4]              ; 0xf8d0 0x9004
	; Reserve space on stack for frame
	sub.w	r6, r6, #28               ; 0xf1a6 0x061c
	; Fill in fields of the frame
	add.w	r9, r9, #12               ; 0xf109 0x090c
	str.w	r6, [r6, #24]             ; 0xf8c6 0x6018
	str.w	r8, [r6, #8]              ; 0xf8c6 0x8008
	str.w	r9, [r6, #12]             ; 0xf8c6 0x900c
	str.w	r0, [r6, #16]             ; 0xf8c6 0x0010
	str.w	r4, [r6, #20]             ; 0xf8c6 0x4014
	str.w	lr, [r6, #0]              ; 0xf8c6 0xe000
	; Set the Frame pointer
	add.w	r4, r6, #20               ; 0xf106 0x0414
	; set bcp
	add.w	lr, r0, #40               ; 0xf100 0x0e28
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L3
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
L3
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (2 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_2
fixed_interpreter_fast_method_entry_2 PROC
	nop                               ; 0xbf00

	ENDP

	EXPORT	interpreter_fast_method_entry_2
interpreter_fast_method_entry_2 PROC
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	add.w	r8, r6, r2, lsl #2        ; 0xeb06 0x0882
	sub.w	r8, r8, #4                ; 0xf1a8 0x0804
	; get maximum stack execution size
	ldrh	r3, [r0, #28]             ; 0x8b83
	ldr	r1, [r5, #84]; = current_stack_limit  ; 0x6d69
	sub.w	r3, r6, r3, lsl #2        ; 0xeba6 0x0383
	sub.w	r3, r3, #28               ; 0xf1a3 0x031c
	cmp	r3, r1                    ; 0x428b
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr	r1, =L4
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr.w	pc, [r5, #1212]; = interpreter_grow_stack  ; 0xf8d5 0xf4bc
L4
	; push cleared locals
	sub.w	r6, r6, #8                ; 0xf1a6 0x0608
	; get constants pool
	ldrh.w	r9, [r0, #24]             ; 0xf8b0 0x9018 ; get access flags
	tst.w	r9, #512                  ; 0xf419 0x7f00 ; compressed header?
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r9, [r5, #476]; = rom_constant_pool_fast  ; 0xf8d5 0x91dc
	DCW 0xbf08 ; IT eq                ; 0xbf08 ; method constant pool
	ldr.w	r9, [r0, #4]              ; 0xf8d0 0x9004
	; Reserve space on stack for frame
	sub.w	r6, r6, #28               ; 0xf1a6 0x061c
	; Fill in fields of the frame
	add.w	r9, r9, #12               ; 0xf109 0x090c
	str.w	r6, [r6, #24]             ; 0xf8c6 0x6018
	str.w	r8, [r6, #8]              ; 0xf8c6 0x8008
	str.w	r9, [r6, #12]             ; 0xf8c6 0x900c
	str.w	r0, [r6, #16]             ; 0xf8c6 0x0010
	str.w	r4, [r6, #20]             ; 0xf8c6 0x4014
	str.w	lr, [r6, #0]              ; 0xf8c6 0xe000
	; Set the Frame pointer
	add.w	r4, r6, #20               ; 0xf106 0x0414
	; set bcp
	add.w	lr, r0, #40               ; 0xf100 0x0e28
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L5
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
L5
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (3 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_3
fixed_interpreter_fast_method_entry_3 PROC
	nop                               ; 0xbf00

	ENDP

	EXPORT	interpreter_fast_method_entry_3
interpreter_fast_method_entry_3 PROC
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	add.w	r8, r6, r2, lsl #2        ; 0xeb06 0x0882
	sub.w	r8, r8, #4                ; 0xf1a8 0x0804
	; get maximum stack execution size
	ldrh	r3, [r0, #28]             ; 0x8b83
	ldr	r1, [r5, #84]; = current_stack_limit  ; 0x6d69
	sub.w	r3, r6, r3, lsl #2        ; 0xeba6 0x0383
	sub.w	r3, r3, #28               ; 0xf1a3 0x031c
	cmp	r3, r1                    ; 0x428b
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr	r1, =L6
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr.w	pc, [r5, #1212]; = interpreter_grow_stack  ; 0xf8d5 0xf4bc
L6
	; push cleared locals
	sub.w	r6, r6, #12               ; 0xf1a6 0x060c
	; get constants pool
	ldrh.w	r9, [r0, #24]             ; 0xf8b0 0x9018 ; get access flags
	tst.w	r9, #512                  ; 0xf419 0x7f00 ; compressed header?
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r9, [r5, #476]; = rom_constant_pool_fast  ; 0xf8d5 0x91dc
	DCW 0xbf08 ; IT eq                ; 0xbf08 ; method constant pool
	ldr.w	r9, [r0, #4]              ; 0xf8d0 0x9004
	; Reserve space on stack for frame
	sub.w	r6, r6, #28               ; 0xf1a6 0x061c
	; Fill in fields of the frame
	add.w	r9, r9, #12               ; 0xf109 0x090c
	str.w	r6, [r6, #24]             ; 0xf8c6 0x6018
	str.w	r8, [r6, #8]              ; 0xf8c6 0x8008
	str.w	r9, [r6, #12]             ; 0xf8c6 0x900c
	str.w	r0, [r6, #16]             ; 0xf8c6 0x0010
	str.w	r4, [r6, #20]             ; 0xf8c6 0x4014
	str.w	lr, [r6, #0]              ; 0xf8c6 0xe000
	; Set the Frame pointer
	add.w	r4, r6, #20               ; 0xf106 0x0414
	; set bcp
	add.w	lr, r0, #40               ; 0xf100 0x0e28
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L7
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
L7
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed


	; ------------------------------------------------------
	; Fast interpreter method entry (4 extra locals)

	EXPORT	fixed_interpreter_fast_method_entry_4
fixed_interpreter_fast_method_entry_4 PROC
	nop                               ; 0xbf00

	ENDP

	EXPORT	interpreter_fast_method_entry_4
interpreter_fast_method_entry_4 PROC
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	add.w	r8, r6, r2, lsl #2        ; 0xeb06 0x0882
	sub.w	r8, r8, #4                ; 0xf1a8 0x0804
	; get maximum stack execution size
	ldrh	r3, [r0, #28]             ; 0x8b83
	ldr	r1, [r5, #84]; = current_stack_limit  ; 0x6d69
	sub.w	r3, r6, r3, lsl #2        ; 0xeba6 0x0383
	sub.w	r3, r3, #28               ; 0xf1a3 0x031c
	cmp	r3, r1                    ; 0x428b
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr	r1, =L8
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr.w	pc, [r5, #1212]; = interpreter_grow_stack  ; 0xf8d5 0xf4bc
L8
	; push cleared locals
	sub.w	r6, r6, #16               ; 0xf1a6 0x0610
	; get constants pool
	ldrh.w	r9, [r0, #24]             ; 0xf8b0 0x9018 ; get access flags
	tst.w	r9, #512                  ; 0xf419 0x7f00 ; compressed header?
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r9, [r5, #476]; = rom_constant_pool_fast  ; 0xf8d5 0x91dc
	DCW 0xbf08 ; IT eq                ; 0xbf08 ; method constant pool
	ldr.w	r9, [r0, #4]              ; 0xf8d0 0x9004
	; Reserve space on stack for frame
	sub.w	r6, r6, #28               ; 0xf1a6 0x061c
	; Fill in fields of the frame
	add.w	r9, r9, #12               ; 0xf109 0x090c
	str.w	r6, [r6, #24]             ; 0xf8c6 0x6018
	str.w	r8, [r6, #8]              ; 0xf8c6 0x8008
	str.w	r9, [r6, #12]             ; 0xf8c6 0x900c
	str.w	r0, [r6, #16]             ; 0xf8c6 0x0010
	str.w	r4, [r6, #20]             ; 0xf8c6 0x4014
	str.w	lr, [r6, #0]              ; 0xf8c6 0xe000
	; Set the Frame pointer
	add.w	r4, r6, #20               ; 0xf106 0x0414
	; set bcp
	add.w	lr, r0, #40               ; 0xf100 0x0e28
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L9
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
L9
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed




	; ------------------------------------------------------
	; Interpreter bytecode templates
	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_nop
bc_impl_nop

	EXPORT	bc_impl_nop_internal
bc_impl_nop_internal PROC
	; do nothing
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #1                    ; 0x2001
	negs	r0, r0                    ; 0x4240
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #0                    ; 0x2000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_1
bc_impl_iconst_1

	EXPORT	bc_impl_iconst_1_internal
bc_impl_iconst_1_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #1                    ; 0x2001
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_2
bc_impl_iconst_2

	EXPORT	bc_impl_iconst_2_internal
bc_impl_iconst_2_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #2                    ; 0x2002
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_3
bc_impl_iconst_3

	EXPORT	bc_impl_iconst_3_internal
bc_impl_iconst_3_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #3                    ; 0x2003
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_4
bc_impl_iconst_4

	EXPORT	bc_impl_iconst_4_internal
bc_impl_iconst_4_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #4                    ; 0x2004
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iconst_5
bc_impl_iconst_5

	EXPORT	bc_impl_iconst_5_internal
bc_impl_iconst_5_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #5                    ; 0x2005
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lconst_0
bc_impl_lconst_0

	EXPORT	bc_impl_lconst_0_internal
bc_impl_lconst_0_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #0                    ; 0x2000
	movs	r2, #0                    ; 0x2200
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lconst_1
bc_impl_lconst_1

	EXPORT	bc_impl_lconst_1_internal
bc_impl_lconst_1_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	movs	r0, #1                    ; 0x2001
	movs	r2, #0                    ; 0x2200
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	mov.w	r0, #1065353216           ; 0xf04f 0x507e
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fconst_2
bc_impl_fconst_2

	EXPORT	bc_impl_fconst_2_internal
bc_impl_fconst_2_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	mov.w	r0, #1073741824           ; 0xf04f 0x4080
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	movs	r0, #0                    ; 0x2000
	movs	r2, #0                    ; 0x2200
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	movs	r0, #0                    ; 0x2000
	ldr	r2, =0x3ff00000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	ldrsb.w	r0, [lr, #-1]             ; 0xf91e 0x0c01
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r10, [lr, #2]             ; 0xf89e 0xa002
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	orr.w	r0, r10, r3, lsl #8       ; 0xea4a 0x2003
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	quicken
	ldr	r3, =quicken
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; load unsigned 16bit word at bcp + 2
	ldrb.w	r11, [lr, #2]             ; 0xf89e 0xb002
	ldrb.w	r2, [lr, #3]              ; 0xf89e 0x2003
	ldrb.w	r7, [lr, #4]!             ; 0xf81e 0x7f04 ; prefetch next bytecode
	orr.w	r11, r2, r11, lsl #8      ; 0xea42 0x2b0b
	sub.w	r10, r8, r11, lsl #2      ; 0xeba8 0x0a8b ; address of local #r11
	ldr.w	r0, [r10, #0]             ; 0xf8da 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; load unsigned byte at bcp + 1
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	sub.w	r10, r8, r11, lsl #2      ; 0xeba8 0x0a8b ; address of local #r11
	ldr.w	r0, [r10, #0]             ; 0xf8da 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; load unsigned 16bit word at bcp + 2
	ldrb.w	r11, [lr, #2]             ; 0xf89e 0xb002
	ldrb.w	r2, [lr, #3]              ; 0xf89e 0x2003
	ldrb.w	r7, [lr, #4]!             ; 0xf81e 0x7f04 ; prefetch next bytecode
	orr.w	r11, r2, r11, lsl #8      ; 0xea42 0x2b0b
	sub.w	r10, r8, r11, lsl #2      ; 0xeba8 0x0a8b ; address of local #r11
	ldr.w	r0, [r10, #-4]            ; 0xf85a 0x0c04
	ldr.w	r2, [r10, #0]             ; 0xf8da 0x2000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; load unsigned byte at bcp + 1
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	sub.w	r10, r8, r11, lsl #2      ; 0xeba8 0x0a8b ; address of local #r11
	ldr.w	r0, [r10, #-4]            ; 0xf85a 0x0c04
	ldr.w	r2, [r10, #0]             ; 0xf8da 0x2000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr.w	r0, [r8, #0]              ; 0xf8d8 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr.w	r0, [r8, #-4]             ; 0xf858 0x0c04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr.w	r0, [r8, #-8]             ; 0xf858 0x0c08
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr.w	r0, [r8, #-12]            ; 0xf858 0x0c0c
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr.w	r2, [r8, #0]              ; 0xf8d8 0x2000
	ldr.w	r0, [r8, #-4]             ; 0xf858 0x0c04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr.w	r2, [r8, #-4]             ; 0xf858 0x2c04
	ldr.w	r0, [r8, #-8]             ; 0xf858 0x0c08
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr.w	r2, [r8, #-8]             ; 0xf858 0x2c08
	ldr.w	r0, [r8, #-12]            ; 0xf858 0x0c0c
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr.w	r2, [r8, #-12]            ; 0xf858 0x2c0c
	ldr.w	r0, [r8, #-16]            ; 0xf858 0x0c10
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr	r3, [r2, #4]              ; 0x6853
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L10
	cmp	r0, r3                    ; 0x4298
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L11
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	add.w	r2, r2, r0, lsl #2        ; 0xeb02 0x0280 ; load array element
	ldr	r0, [r2, #8]              ; 0x6890
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L10
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L11
	; Handle array index out of bounds exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr	r3, [r2, #4]              ; 0x6853
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L12
	cmp	r0, r3                    ; 0x4298
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L13
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	add.w	r2, r2, r0, lsl #3        ; 0xeb02 0x02c0 ; load array element
	ldr	r0, [r2, #8]              ; 0x6890
	ldr	r2, [r2, #12]             ; 0x68d2
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L12
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L13
	; Handle array index out of bounds exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr	r3, [r2, #4]              ; 0x6853
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L14
	cmp	r0, r3                    ; 0x4298
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L15
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	adds	r2, r2, r0                ; 0x1812 ; load array element
	ldrsb.w	r0, [r2, #8]              ; 0xf992 0x0008
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L14
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L15
	; Handle array index out of bounds exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr	r3, [r2, #4]              ; 0x6853
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L16
	cmp	r0, r3                    ; 0x4298
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L17
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	add.w	r2, r2, r0, lsl #1        ; 0xeb02 0x0240 ; load array element
	ldrh.w	r0, [r2, #8]              ; 0xf8b2 0x0008
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L16
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L17
	; Handle array index out of bounds exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr	r3, [r2, #4]              ; 0x6853
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L18
	cmp	r0, r3                    ; 0x4298
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L19
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	add.w	r2, r2, r0, lsl #1        ; 0xeb02 0x0240 ; load array element
	ldrsh.w	r0, [r2, #8]              ; 0xf9b2 0x0008
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L18
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L19
	; Handle array index out of bounds exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
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
	ldrb.w	r11, [lr, #2]             ; 0xf89e 0xb002
	ldrb.w	r10, [lr, #3]             ; 0xf89e 0xa003
	ldrb.w	r7, [lr, #4]!             ; 0xf81e 0x7f04 ; prefetch next bytecode
	orr.w	r11, r10, r11, lsl #8     ; 0xea4a 0x2b0b
	sub.w	r10, r8, r11, lsl #2      ; 0xeba8 0x0a8b ; address of local #r11
	str.w	r0, [r10, #0]             ; 0xf8ca 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	sub.w	r10, r8, r11, lsl #2      ; 0xeba8 0x0a8b ; address of local #r11
	str.w	r0, [r10, #0]             ; 0xf8ca 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	; load unsigned 16bit word at bcp + 2
	ldrb.w	r11, [lr, #2]             ; 0xf89e 0xb002
	ldrb.w	r10, [lr, #3]             ; 0xf89e 0xa003
	ldrb.w	r7, [lr, #4]!             ; 0xf81e 0x7f04 ; prefetch next bytecode
	orr.w	r11, r10, r11, lsl #8     ; 0xea4a 0x2b0b
	sub.w	r10, r8, r11, lsl #2      ; 0xeba8 0x0a8b ; address of local #r11
	str.w	r0, [r10, #-4]            ; 0xf84a 0x0c04
	str.w	r2, [r10, #0]             ; 0xf8ca 0x2000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	; load unsigned byte at bcp + 1
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	sub.w	r10, r8, r11, lsl #2      ; 0xeba8 0x0a8b ; address of local #r11
	str.w	r0, [r10, #-4]            ; 0xf84a 0x0c04
	str.w	r2, [r10, #0]             ; 0xf8ca 0x2000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	str.w	r0, [r8, #0]              ; 0xf8c8 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	str.w	r0, [r8, #-4]             ; 0xf848 0x0c04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	str.w	r0, [r8, #-8]             ; 0xf848 0x0c08
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	str.w	r0, [r8, #-12]            ; 0xf848 0x0c0c
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	str.w	r0, [r8, #-4]             ; 0xf848 0x0c04
	str.w	r2, [r8, #0]              ; 0xf8c8 0x2000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	str.w	r0, [r8, #-8]             ; 0xf848 0x0c08
	str.w	r2, [r8, #-4]             ; 0xf848 0x2c04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	str.w	r0, [r8, #-12]            ; 0xf848 0x0c0c
	str.w	r2, [r8, #-8]             ; 0xf848 0x2c08
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	str.w	r0, [r8, #-16]            ; 0xf848 0x0c10
	str.w	r2, [r8, #-12]            ; 0xf848 0x2c0c
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r3, [r10, #4]             ; 0xf8da 0x3004
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L20
	cmp	r2, r3                    ; 0x429a
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L21
L23
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store array element
	add.w	r10, r10, r2, lsl #2      ; 0xeb0a 0x0a82
	str.w	r0, [r10, #8]             ; 0xf8ca 0x0008
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L20
	; Handle null pointer exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L21
	; Handle array index out of bounds exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
L22
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	cmp.w	r12, #0                   ; 0xf1bc 0x0f00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r3, [r12, #4]             ; 0xf8dc 0x3004
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L24
	cmp	r10, r3                   ; 0x459a
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L25
L27
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store array element
	add.w	r12, r12, r10, lsl #3     ; 0xeb0c 0x0cca
	str.w	r0, [r12, #8]             ; 0xf8cc 0x0008
	str.w	r2, [r12, #12]            ; 0xf8cc 0x200c
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L24
	; Handle null pointer exception
	; Exit: Count = 4
	str.w	r12, [r6, #-4]!           ; 0xf846 0xcd04
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L25
	; Handle array index out of bounds exception
	; Exit: Count = 4
	str.w	r12, [r6, #-4]!           ; 0xf846 0xcd04
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
L26
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r3, [r10, #4]             ; 0xf8da 0x3004
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L28
	cmp	r2, r3                    ; 0x429a
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L29
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L31
	ldr.w	r12, [r10, #0]            ; 0xf8da 0xc000 ; array near
	ldr	r7, [r0]                  ; 0x6807 ; object near
	ldr.w	r12, [r12, #0]            ; 0xf8dc 0xc000 ; array klass
	ldr	r7, [r7]                  ; 0x683f ; object klass
	ldr.w	r12, [r12, #36]           ; 0xf8dc 0xc024 ; array element type
	ldr	r1, [r7, #20]             ; 0x6979 ; subtype cache 1
	ldr	r7, [r7, #24]             ; 0x69bf ; subtype cache 2
	cmp	r12, r1                   ; 0x458c
	DCW 0xbf18 ; IT ne                ; 0xbf18
	cmp	r12, r7                   ; 0x45bc
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L30
L31
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store array element
	add.w	r10, r10, r2, lsl #2      ; 0xeb0a 0x0a82
	str.w	r0, [r10, #8]!            ; 0xf84a 0x0f08
	; oop_write_barrier
	ldr.w	r2, [r5, #292]; = bitvector_base  ; 0xf8d5 0x2124
	mov.w	r10, r10, lsr #2          ; 0xea4f 0x0a9a
	add.w	r2, r2, r10, lsr #3       ; 0xeb02 0x02da
	ldrb.w	r3, [r2, #0]              ; 0xf892 0x3000
	mov.w	r11, #1                   ; 0xf04f 0x0b01
	and.w	r10, r10, #7              ; 0xf00a 0x0a07
	lsl.w	r11, r11, r10             ; 0xfa0b 0xfb0a
	orr.w	r3, r3, r11               ; 0xea43 0x030b
	strb.w	r3, [r2, #0]              ; 0xf882 0x3000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L28
	; Handle null pointer exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L29
	; Handle array index out of bounds exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
L30
	; Handle slow type checking
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	array_store_type_check
	ldr	r3, =array_store_type_check
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 3
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	b	L31
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r3, [r10, #4]             ; 0xf8da 0x3004
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L32
	cmp	r2, r3                    ; 0x429a
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L33
L35
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store array element
	add.w	r10, r10, r2              ; 0xeb0a 0x0a02
	strb.w	r0, [r10, #8]             ; 0xf88a 0x0008
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L32
	; Handle null pointer exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L33
	; Handle array index out of bounds exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
L34
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r3, [r10, #4]             ; 0xf8da 0x3004
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L36
	cmp	r2, r3                    ; 0x429a
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L37
L39
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store array element
	add.w	r10, r10, r2, lsl #1      ; 0xeb0a 0x0a42
	strh.w	r0, [r10, #8]             ; 0xf8aa 0x0008
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L36
	; Handle null pointer exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
L37
	; Handle array index out of bounds exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
L38
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_pop
bc_impl_pop

	EXPORT	bc_impl_pop_internal
bc_impl_pop_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = -1
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_pop2
bc_impl_pop2

	EXPORT	bc_impl_pop2_internal
bc_impl_pop2_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = -2
	add.w	r6, r6, #4                ; 0xf106 0x0604
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dup
bc_impl_dup

	EXPORT	bc_impl_dup_internal
bc_impl_dup_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 1
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	; dup_x1 (...ba => ...aba)
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 3
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	; dup_x2 (...cba => ...acba
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 4
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6, #0]              ; 0xf8d6 0x2000 ; Grab second element without popping it
	; dup2 (...ba => ...baba
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 3
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	; dup2_x1 (...cba => ...bacba)
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 5
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	; dup_x2 (...dcba => ...badcba)
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r12, [r6, #-4]!           ; 0xf846 0xcd04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_swap
bc_impl_swap

	EXPORT	bc_impl_swap_internal
bc_impl_swap_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	adds	r0, r2, #0                ; 0x1c10
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	adds	r0, r2, r0                ; 0x1810
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	adds.w	r0, r10, r0               ; 0xeb1a 0x0000
	adc.w	r2, r12, r2               ; 0xeb4c 0x0202
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	; load other argument
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_fadd
	mov	r10, lr                   ; 0x46f2
	bl	jvm_fadd
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	; load other argument
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	IMPORT	jvm_dadd
	mov	r10, lr                   ; 0x46f2
	bl	jvm_dadd
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	subs	r0, r2, r0                ; 0x1a10
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	subs.w	r0, r10, r0               ; 0xebba 0x0000
	sbc.w	r2, r12, r2               ; 0xeb6c 0x0202
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r1, r0, #0                ; 0x1c01
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	IMPORT	jvm_fsub
	mov	r10, lr                   ; 0x46f2
	bl	jvm_fsub
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r2, r0, #0                ; 0x1c02
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_dsub
	mov	r10, lr                   ; 0x46f2
	bl	jvm_dsub
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	mul.w	r0, r2, r0                ; 0xfb02 0xf000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	umull.w	r3, r11, r0, r10          ; 0xfba0 0x3b0a
	mla.w	r11, r0, r12, r11         ; 0xfb00 0xbb0c
	mla.w	r11, r2, r10, r11         ; 0xfb02 0xbb0a
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r11, [r6, #-4]!           ; 0xf846 0xbd04
	adds	r0, r3, #0                ; 0x1c18
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	; load other argument
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_fmul
	mov	r10, lr                   ; 0x46f2
	bl	jvm_fmul
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	; load other argument
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	IMPORT	jvm_dmul
	mov	r10, lr                   ; 0x46f2
	bl	jvm_dmul
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_idiv
bc_impl_idiv

	EXPORT	bc_impl_idiv_internal
bc_impl_idiv_internal PROC
	mov	r10, lr                   ; 0x46f2
	bl	interpreter_idiv_irem

	EXPORT	called_from_bc_idiv
called_from_bc_idiv
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	adds	r0, r1, #0                ; 0x1c08
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r2, r0, #0                ; 0x1c02
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	orrs.w	r10, r2, r3               ; 0xea52 0x0a03
	beq.w	long_divide_by_zero      ; J2MEWP: was IT eq + svc (ldiv/lrem by zero fell into the C division)
	IMPORT	jvm_ldiv
	mov	r10, lr                   ; 0x46f2
	bl	jvm_ldiv
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode

	EXPORT	long_divide_by_zero
long_divide_by_zero
	; Exit: Count = 4
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r3, [r6, #-4]!            ; 0xf846 0x3d04
	adds	r0, r2, #0                ; 0x1c10
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	division_by_zero_exception
	ldr	r3, =division_by_zero_exception
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
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
	adds	r1, r0, #0                ; 0x1c01
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	IMPORT	jvm_fdiv
	mov	r10, lr                   ; 0x46f2
	bl	jvm_fdiv
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r2, r0, #0                ; 0x1c02
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_ddiv
	mov	r10, lr                   ; 0x46f2
	bl	jvm_ddiv
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_irem
bc_impl_irem

	EXPORT	bc_impl_irem_internal
bc_impl_irem_internal PROC
	mov	r10, lr                   ; 0x46f2
	bl	interpreter_idiv_irem

	EXPORT	called_from_bc_irem
called_from_bc_irem
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r2, r0, #0                ; 0x1c02
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	orrs.w	r10, r2, r3               ; 0xea52 0x0a03
	beq.w	long_divide_by_zero      ; J2MEWP: was IT eq + svc (ldiv/lrem by zero fell into the C division)
	IMPORT	jvm_lrem
	mov	r10, lr                   ; 0x46f2
	bl	jvm_lrem
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r1, r0, #0                ; 0x1c01
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	IMPORT	jvm_frem
	mov	r10, lr                   ; 0x46f2
	bl	jvm_frem
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r2, r0, #0                ; 0x1c02
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_drem
	mov	r10, lr                   ; 0x46f2
	bl	jvm_drem
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	rsb.w	r0, r0, #0                ; 0xf1c0 0x0000 ; negate
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	movs	r3, #0                    ; 0x2300 ; negate
	subs.w	r0, r3, r0                ; 0xebb3 0x0000
	sbc.w	r2, r3, r2                ; 0xeb63 0x0202
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	eor.w	r0, r0, #-2147483648      ; 0xf080 0x4000 ; flip sign bit
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_dneg
bc_impl_dneg

	EXPORT	bc_impl_dneg_internal
bc_impl_dneg_internal PROC
	ldr	r2, [r6]                  ; 0x6832 ; get word containing sign bit
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	eor.w	r2, r2, #-2147483648      ; 0xf082 0x4200 ; flip sign bit
	str	r2, [r6]                  ; 0x6032 ; and put it back
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	and.w	r3, r0, #31               ; 0xf000 0x031f
	lsls	r2, r3                    ; 0x409a
	adds	r0, r2, #0                ; 0x1c10
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	; Normalize shift amount
	ands.w	r0, r0, #63               ; 0xf010 0x003f
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	DCW 0xbf02 ; ITTT eq              ; 0xbf02
	mov	r11, r10                  ; 0x46d3
	adds	r3, r2, #0                ; 0x1c13
	b	L40
	; Get long argument from the stack
	; Calculate 32-shift
	rsbs.w	r1, r0, #32               ; 0xf1d0 0x0120
	; condition code le means that shift is >= 32
	DCW 0xbfde ; ITTT le              ; 0xbfde
	subs	r0, #32                   ; 0x3820
	lsl.w	r11, r2, r0               ; 0xfa02 0xfb00
	movs	r3, #0                    ; 0x2300
	; condition code gt means that shift is < 32
	DCW 0xbfc1 ; ITTTT gt             ; 0xbfc1
	lsl.w	r11, r10, r0              ; 0xfa0a 0xfb00
	lsl.w	r3, r2, r0                ; 0xfa02 0xf300
	lsrs	r2, r1                    ; 0x40ca
	orr.w	r11, r11, r2              ; 0xea4b 0x0b02
L40
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r11, [r6, #-4]!           ; 0xf846 0xbd04
	adds	r0, r3, #0                ; 0x1c18
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	and.w	r3, r0, #31               ; 0xf000 0x031f
	asrs	r2, r3                    ; 0x411a
	adds	r0, r2, #0                ; 0x1c10
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	; Normalize shift amount
	ands.w	r0, r0, #63               ; 0xf010 0x003f
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	DCW 0xbf02 ; ITTT eq              ; 0xbf02
	mov	r11, r10                  ; 0x46d3
	adds	r3, r2, #0                ; 0x1c13
	b	L41
	; Calculate 32-shift
	rsbs.w	r1, r0, #32               ; 0xf1d0 0x0120
	; condition code le means that shift is >= 32
	DCW 0xbfde ; ITTT le              ; 0xbfde
	subs	r0, #32                   ; 0x3820
	asr.w	r3, r10, r0               ; 0xfa4a 0xf300
	mov.w	r11, r10, asr #31         ; 0xea4f 0x7bea
	; condition code gt means that shift is < 32
	DCW 0xbfc1 ; ITTTT gt             ; 0xbfc1
	lsr.w	r3, r2, r0                ; 0xfa22 0xf300
	lsl.w	r1, r10, r1               ; 0xfa0a 0xf101
	orrs	r3, r1                    ; 0x430b
	asr.w	r11, r10, r0              ; 0xfa4a 0xfb00
L41
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r11, [r6, #-4]!           ; 0xf846 0xbd04
	adds	r0, r3, #0                ; 0x1c18
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	and.w	r3, r0, #31               ; 0xf000 0x031f
	lsrs	r2, r3                    ; 0x40da
	adds	r0, r2, #0                ; 0x1c10
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	; Normalize shift amount
	ands.w	r0, r0, #63               ; 0xf010 0x003f
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	DCW 0xbf02 ; ITTT eq              ; 0xbf02
	mov	r11, r10                  ; 0x46d3
	adds	r3, r2, #0                ; 0x1c13
	b	L42
	; Calculate 32-shift
	rsbs.w	r1, r0, #32               ; 0xf1d0 0x0120
	; condition code le means that shift is >= 32
	DCW 0xbfde ; ITTT le              ; 0xbfde
	subs	r0, #32                   ; 0x3820
	lsr.w	r3, r10, r0               ; 0xfa2a 0xf300
	mov.w	r11, #0                   ; 0xf04f 0x0b00
	; condition code gt means that shift is < 32
	DCW 0xbfc1 ; ITTTT gt             ; 0xbfc1
	lsr.w	r3, r2, r0                ; 0xfa22 0xf300
	lsl.w	r1, r10, r1               ; 0xfa0a 0xf101
	orrs	r3, r1                    ; 0x430b
	lsr.w	r11, r10, r0              ; 0xfa2a 0xfb00
L42
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r11, [r6, #-4]!           ; 0xf846 0xbd04
	adds	r0, r3, #0                ; 0x1c18
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	and.w	r0, r2, r0                ; 0xea02 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	and.w	r0, r10, r0               ; 0xea0a 0x0000
	and.w	r2, r12, r2               ; 0xea0c 0x0202
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	orr.w	r0, r2, r0                ; 0xea42 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	orr.w	r0, r10, r0               ; 0xea4a 0x0000
	orr.w	r2, r12, r2               ; 0xea4c 0x0202
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	eor.w	r0, r2, r0                ; 0xea82 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	eor.w	r0, r10, r0               ; 0xea8a 0x0000
	eor.w	r2, r12, r2               ; 0xea8c 0x0202
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_wide_iinc
bc_impl_wide_iinc

	EXPORT	bc_impl_wide_iinc_internal
bc_impl_wide_iinc_internal PROC
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	ldrb.w	r3, [lr, #3]              ; 0xf89e 0x3003
	ldrsb.w	r10, [lr, #4]             ; 0xf99e 0xa004
	ldrb.w	r11, [lr, #5]             ; 0xf89e 0xb005
	add.w	r2, r3, r2, lsl #8        ; 0xeb03 0x2202 ; register index
	sub.w	r12, r8, r2, lsl #2       ; 0xeba8 0x0c82 ; get local
	ldr.w	r3, [r12, #0]             ; 0xf8dc 0x3000
	ldrb.w	r7, [lr, #6]!             ; 0xf81e 0x7f06 ; prefetch next bytecode
	add.w	r3, r3, r10, lsl #8       ; 0xeb03 0x230a ; increment local
	add.w	r3, r3, r11               ; 0xeb03 0x030b
	sub.w	r12, r8, r2, lsl #2       ; 0xeba8 0x0c82 ; store local
	str.w	r3, [r12, #0]             ; 0xf8cc 0x3000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	; Data containing entry for wide bytecode
	DCD	bc_impl_wide_iinc

	EXPORT	bc_impl_iinc
bc_impl_iinc

	ENDP

	EXPORT	bc_impl_iinc_internal
bc_impl_iinc_internal PROC
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001 ; register index
	ldrsb.w	r10, [lr, #2]             ; 0xf99e 0xa002 ; increment
	sub.w	r12, r8, r2, lsl #2       ; 0xeba8 0x0c82 ; get local
	ldr.w	r3, [r12, #0]             ; 0xf8dc 0x3000
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	add.w	r3, r3, r10               ; 0xeb03 0x030a ; increment local
	sub.w	r12, r8, r2, lsl #2       ; 0xeba8 0x0c82 ; store local
	str.w	r3, [r12, #0]             ; 0xf8cc 0x3000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	mov.w	r10, r0, asr #31          ; 0xea4f 0x7ae0
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	IMPORT	jvm_i2f
	mov	r10, lr                   ; 0x46f2
	bl	jvm_i2f
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	IMPORT	jvm_i2d
	mov	r10, lr                   ; 0x46f2
	bl	jvm_i2d
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	adds	r6, #4                    ; 0x3604
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_l2f
	mov	r10, lr                   ; 0x46f2
	bl	jvm_l2f
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_l2d
	mov	r10, lr                   ; 0x46f2
	bl	jvm_l2d
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	IMPORT	jvm_f2i
	mov	r10, lr                   ; 0x46f2
	bl	jvm_f2i
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	IMPORT	jvm_f2l
	mov	r10, lr                   ; 0x46f2
	bl	jvm_f2l
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	IMPORT	jvm_f2d
	mov	r10, lr                   ; 0x46f2
	bl	jvm_f2d
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_d2i
	mov	r10, lr                   ; 0x46f2
	bl	jvm_d2i
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_d2l
	mov	r10, lr                   ; 0x46f2
	bl	jvm_d2l
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_d2f
	mov	r10, lr                   ; 0x46f2
	bl	jvm_d2f
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2b
bc_impl_i2b

	EXPORT	bc_impl_i2b_internal
bc_impl_i2b_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 1
	mov.w	r0, r0, lsl #24           ; 0xea4f 0x6000
	mov.w	r0, r0, asr #24           ; 0xea4f 0x6020
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2c
bc_impl_i2c

	EXPORT	bc_impl_i2c_internal
bc_impl_i2c_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 1
	mov.w	r0, r0, lsl #16           ; 0xea4f 0x4000
	mov.w	r0, r0, lsr #16           ; 0xea4f 0x4010
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_i2s
bc_impl_i2s

	EXPORT	bc_impl_i2s_internal
bc_impl_i2s_internal PROC
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; Entry: Count = 1
	mov.w	r0, r0, lsl #16           ; 0xea4f 0x4000
	mov.w	r0, r0, asr #16           ; 0xea4f 0x4020
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	subs.w	r10, r10, r0              ; 0xebba 0x0a00 ; subtract arguments
	sbcs.w	r12, r12, r2              ; 0xeb7c 0x0c02
	DCW 0xbfb8 ; IT lt                ; 0xbfb8 ; handle *only* for < and >=
	mvn.w	r0, #0                    ; 0xf06f 0x0000
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	movs	r0, #1                    ; 0x2001
	orrs.w	r10, r10, r12             ; 0xea5a 0x0a0c ; correction for ==
	DCW 0xbf08 ; IT eq                ; 0xbf08
	movs	r0, #0                    ; 0x2000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r1, r0, #0                ; 0x1c01
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	IMPORT	jvm_fcmpl
	mov	r10, lr                   ; 0x46f2
	bl	jvm_fcmpl
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r1, r0, #0                ; 0x1c01
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	IMPORT	jvm_fcmpg
	mov	r10, lr                   ; 0x46f2
	bl	jvm_fcmpg
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r2, r0, #0                ; 0x1c02
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_dcmpl
	mov	r10, lr                   ; 0x46f2
	bl	jvm_dcmpl
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r2, r0, #0                ; 0x1c02
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	IMPORT	jvm_dcmpg
	mov	r10, lr                   ; 0x46f2
	bl	jvm_dcmpg
	mov	lr, r10                   ; 0x46d6
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; store result
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L43
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L43
	; Entry: Count = 1
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L44
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L44
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L45
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L45
	; Entry: Count = 1
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L46
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L46
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_iflt
bc_impl_iflt

	EXPORT	bc_impl_iflt_internal
bc_impl_iflt_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L47
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L47
	; Entry: Count = 1
	cmp	r0, #0                    ; 0x2800
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L48
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L48
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ifge
bc_impl_ifge

	EXPORT	bc_impl_ifge_internal
bc_impl_ifge_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L49
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L49
	; Entry: Count = 1
	cmp	r0, #0                    ; 0x2800
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	b	L50
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L50
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ifgt
bc_impl_ifgt

	EXPORT	bc_impl_ifgt_internal
bc_impl_ifgt_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L51
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L51
	; Entry: Count = 1
	cmp	r0, #0                    ; 0x2800
	DCW 0xbfd8 ; IT le                ; 0xbfd8
	b	L52
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L52
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_ifle
bc_impl_ifle

	EXPORT	bc_impl_ifle_internal
bc_impl_ifle_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L53
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L53
	; Entry: Count = 1
	cmp	r0, #0                    ; 0x2800
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	b	L54
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L54
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L55
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L55
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, r0                    ; 0x4282
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L56
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L56
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L57
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L57
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, r0                    ; 0x4282
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L58
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L58
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmplt
bc_impl_if_icmplt

	EXPORT	bc_impl_if_icmplt_internal
bc_impl_if_icmplt_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L59
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L59
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, r0                    ; 0x4282
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L60
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L60
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmpge
bc_impl_if_icmpge

	EXPORT	bc_impl_if_icmpge_internal
bc_impl_if_icmpge_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L61
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L61
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, r0                    ; 0x4282
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	b	L62
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L62
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmpgt
bc_impl_if_icmpgt

	EXPORT	bc_impl_if_icmpgt_internal
bc_impl_if_icmpgt_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L63
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L63
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, r0                    ; 0x4282
	DCW 0xbfd8 ; IT le                ; 0xbfd8
	b	L64
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L64
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_if_icmple
bc_impl_if_icmple

	EXPORT	bc_impl_if_icmple_internal
bc_impl_if_icmple_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L65
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L65
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	cmp	r2, r0                    ; 0x4282
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	b	L66
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L66
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L67
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L67
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrsb.w	r3, [lr, #1]              ; 0xf99e 0x3001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	add.w	lr, lr, r3, lsl #8        ; 0xeb0e 0x2e03
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_tableswitch
bc_impl_tableswitch

	EXPORT	bc_impl_tableswitch_internal
bc_impl_tableswitch_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L68
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L68
	; Entry: Count = 1
	; Have tos_tag point to lower limit
	add.w	r1, lr, #8                ; 0xf10e 0x0108
	bic.w	r1, r1, #3                ; 0xf021 0x0103
	; tmp2 gets the lower limit
	; tmp3 gets the upper limit
	; tos_tag is updated to point to the start of the offsets
	ldr.w	r10, [r1], #4             ; 0xf851 0xab04
	ldr.w	r11, [r1], #4             ; 0xf851 0xbb04
	cmp	r11, r0                   ; 0x4583
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	subs.w	r0, r0, r10               ; 0xebb0 0x000a
	; Offset of branch target (swapped?) if value is in the table
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	ldr.w	r3, [r1, r0, lsl #2]      ; 0xf851 0x3020
	; Offset of branch target (swapped?) if value is outside of table
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	ldr.w	r3, [r1, #-12]            ; 0xf851 0x3c0c
	add.w	lr, lr, r3                ; 0xeb0e 0x0e03 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_lookupswitch
bc_impl_lookupswitch

	EXPORT	bc_impl_lookupswitch_internal
bc_impl_lookupswitch_internal PROC
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L69
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L69
	; Entry: Count = 1
	; compute aligned table ptr
	bic.w	r2, lr, #3                ; 0xf02e 0x0203
	; get number of table entries + 1
	ldr	r3, [r2, #8]              ; 0x6893
	adds	r3, #1                    ; 0x3301
	; set table ptr to default entry
	adds	r2, #4                    ; 0x3204
	; search the table
L70
	ldr.w	r10, [r2, #8]!            ; 0xf852 0xaf08
	subs	r3, #1                    ; 0x3b01
	DCW 0xbf18 ; IT ne                ; 0xbf18
	cmp	r0, r10                   ; 0x4550
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L70
	; reset table ptr if not found
	cmp	r3, #0                    ; 0x2b00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	bic.w	r2, lr, #3                ; 0xf02e 0x0203
	; get table entry or default offset
	ldr	r3, [r2, #4]              ; 0x6853
	; get bytecode at destination
	add.w	lr, lr, r3                ; 0xeb0e 0x0e03
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr	r2, [r4, #4]              ; 0x6862 ; address of stack bottom pointer
	ldr.w	r10, [r4, #-4]            ; 0xf854 0xac04 ; current method
	sub.w	r3, r4, #20               ; 0xf1a4 0x0314 ; address of stack bottom pointer if no locks
	cmp	r2, r3                    ; 0x429a
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L71
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Is this a synchronized method?
	ldrh.w	r10, [r10, #24]           ; 0xf8ba 0xa018 ; access flags
	tst.w	r10, #32                  ; 0xf01a 0x0f20 ; ACC_SYNCHRONIZED
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L73
	ldr.w	r12, [r5, #120]; = shared_unlock_synchronized_method  ; 0xf8d5 0xc078
	blx	r12                       ; 0x47e0
	ldr	r2, [r4, #4]              ; 0x6862
	b	L73
L72
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	bl	interpreter_call_vm
L73
	; Check that all stack locks have been unlocked.
	ldr.w	r3, [r2, #24]!            ; 0xf852 0x3f18
	sub.w	r10, r4, #24              ; 0xf1a4 0x0a18
L74
	cmp	r3, #0                    ; 0x2b00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L72
	cmp	r2, r10                   ; 0x4552
	DCW 0xbf1c ; ITT ne               ; 0xbf1c
	ldr.w	r3, [r2, #28]!            ; 0xf852 0x3f1c
	b	L74
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c
L71
	; load one argument
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	lr, [r4, #-20]            ; 0xf854 0xec14
	ldr	r4, [r4]                  ; 0x6824
	add.w	r6, r8, #4                ; 0xf108 0x0604
	bx	lr                        ; 0x4770
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
	ldr	r2, [r4, #4]              ; 0x6862 ; address of stack bottom pointer
	ldr.w	r10, [r4, #-4]            ; 0xf854 0xac04 ; current method
	sub.w	r3, r4, #20               ; 0xf1a4 0x0314 ; address of stack bottom pointer if no locks
	cmp	r2, r3                    ; 0x429a
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L75
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Is this a synchronized method?
	ldrh.w	r10, [r10, #24]           ; 0xf8ba 0xa018 ; access flags
	tst.w	r10, #32                  ; 0xf01a 0x0f20 ; ACC_SYNCHRONIZED
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L77
	ldr.w	r12, [r5, #120]; = shared_unlock_synchronized_method  ; 0xf8d5 0xc078
	blx	r12                       ; 0x47e0
	ldr	r2, [r4, #4]              ; 0x6862
	b	L77
L76
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	bl	interpreter_call_vm
L77
	; Check that all stack locks have been unlocked.
	ldr.w	r3, [r2, #24]!            ; 0xf852 0x3f18
	sub.w	r10, r4, #24              ; 0xf1a4 0x0a18
L78
	cmp	r3, #0                    ; 0x2b00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L76
	cmp	r2, r10                   ; 0x4552
	DCW 0xbf1c ; ITT ne               ; 0xbf1c
	ldr.w	r3, [r2, #28]!            ; 0xf852 0x3f1c
	b	L78
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c
L75
	; load one argument
	adds	r0, r0, #0                ; 0x1c00
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	ldr.w	lr, [r4, #-20]            ; 0xf854 0xec14
	ldr	r4, [r4]                  ; 0x6824
	add.w	r6, r8, #4                ; 0xf108 0x0604
	bx	lr                        ; 0x4770
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
	ldr	r2, [r4, #4]              ; 0x6862 ; address of stack bottom pointer
	ldr.w	r10, [r4, #-4]            ; 0xf854 0xac04 ; current method
	sub.w	r3, r4, #20               ; 0xf1a4 0x0314 ; address of stack bottom pointer if no locks
	cmp	r2, r3                    ; 0x429a
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L79
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Is this a synchronized method?
	ldrh.w	r10, [r10, #24]           ; 0xf8ba 0xa018 ; access flags
	tst.w	r10, #32                  ; 0xf01a 0x0f20 ; ACC_SYNCHRONIZED
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L81
	ldr.w	r12, [r5, #120]; = shared_unlock_synchronized_method  ; 0xf8d5 0xc078
	blx	r12                       ; 0x47e0
	ldr	r2, [r4, #4]              ; 0x6862
	b	L81
L80
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	bl	interpreter_call_vm
L81
	; Check that all stack locks have been unlocked.
	ldr.w	r3, [r2, #24]!            ; 0xf852 0x3f18
	sub.w	r10, r4, #24              ; 0xf1a4 0x0a18
L82
	cmp	r3, #0                    ; 0x2b00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L80
	cmp	r2, r10                   ; 0x4552
	DCW 0xbf1c ; ITT ne               ; 0xbf1c
	ldr.w	r3, [r2, #28]!            ; 0xf852 0x3f1c
	b	L82
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c
L79
	ldr.w	lr, [r4, #-20]            ; 0xf854 0xec14
	ldr	r4, [r4]                  ; 0x6824
	add.w	r6, r8, #4                ; 0xf108 0x0604
	bx	lr                        ; 0x4770
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	getstatic
	ldr	r3, =getstatic
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	sub.w	r7, r5, r0, lsl #2        ; 0xeba5 0x0780
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	putstatic
	ldr	r3, =putstatic
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	sub.w	r7, r5, r0, lsl #2        ; 0xeba5 0x0780
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	getfield
	ldr	r3, =getfield
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	putfield
	ldr	r3, =putfield
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	quicken_invokestatic
	ldr	r3, =quicken_invokestatic
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	sub.w	r7, r5, r0, lsl #2        ; 0xeba5 0x0780
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	quicken
	ldr	r3, =quicken
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	newobject
	ldr	r3, =newobject
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	adds	r2, r0, #0                ; 0x1c02
	; get array type
	; load unsigned byte at bcp + 1
	ldrb.w	r3, [lr, #1]              ; 0xf89e 0x3001
	; Handle slowly if length too large or negative
	cmp.w	r2, #1048576              ; 0xf5b2 0x1f80
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L83
	; compute array size in words
	and.w	r1, r3, #3                ; 0xf003 0x0103
	lsl.w	r1, r2, r1                ; 0xfa02 0xf101
	adds	r1, #11                   ; 0x310b
	lsrs	r1, r1, #2                ; 0x0889
	; get _inline_allocation_top
	ldr.w	r0, [r5, #276]; = inline_allocation_top  ; 0xf8d5 0x0114
	; get _inline_allocation_end, and check for overflow
	ldr.w	r11, [r5, #280]; = inline_allocation_end  ; 0xf8d5 0xb118
	adds.w	r10, r0, r1, lsl #2       ; 0xeb10 0x0a81
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L83
	cmp.w	r10, r11                  ; 0xebba 0x0f0b
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L83
	ldr.w	r11, [r5, #1008]; = persistent_handles_addr  ; 0xf8d5 0xb3f0
	add.w	r11, r11, #48             ; 0xf10b 0x0b30
	; allocation succeeded, set _inline_allocation_top
	str.w	r10, [r5, #276]           ; 0xf8c5 0xa114
	; Get array class
	add.w	r3, r11, r3, lsl #2       ; 0xeb0b 0x0383
	ldr.w	r3, [r3, #0]              ; 0xf8d3 0x3000
	; set array length
	str.w	r2, [r0, #4]              ; 0xf8c0 0x2004
	; Get array class near
	ldr.w	r3, [r3, #12]             ; 0xf8d3 0x300c
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	; initialize array elements to zero
	add.w	r10, r0, #8               ; 0xf100 0x0a08
	sub.w	r11, r11, r11             ; 0xebab 0x0b0b
	subs	r1, #3                    ; 0x3903
L84
	; r10 = the next word to zero
	; r11 = 0
	; r1 = the_number_of_words_still_to_zero - 1
	; condition codes reflect the (signed) value in r1
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	str.w	r11, [r10], #4            ; 0xf84a 0xbb04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r11, [r10], #4            ; 0xf84a 0xbb04
	subs	r1, #2                    ; 0x3902
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L84
	; set prototypical near in array; no need for write barrier
	str.w	r3, [r0, #0]              ; 0xf8c0 0x3000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L83
	mov.w	r1, r3                    ; 0xea4f 0x0103
	mov.w	r2, r2                    ; 0xea4f 0x0202
	IMPORT	_newarray
	ldr	r3, =_newarray
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	anewarray
	ldr	r3, =anewarray
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r6, #4                    ; 0x3604
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L85
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	ldr	r0, [r0, #4]              ; 0x6840
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L85
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	cmp	r0, #0                    ; 0x2800 ; is object zero?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1204]; = interpreter_throw_NullPointerException_tos_cached  ; 0xf8d5 0xf4b4
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	adds	r1, r0, #0                ; 0x1c01
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	checkcast
	ldr	r3, =checkcast
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	instanceof
	ldr	r3, =instanceof
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	adds	r6, #4                    ; 0x3604
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	movs	r1, #2                    ; 0x2102
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	cmp	r0, #0                    ; 0x2800 ; is object zero?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1204]; = interpreter_throw_NullPointerException_tos_cached  ; 0xf8d5 0xf4b4
	add.w	lr, lr, #1                ; 0xf10e 0x0e01
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	shared_monitor_enter
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Dispatch to the next bytecode
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	cmp	r0, #0                    ; 0x2800 ; is object zero?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1204]; = interpreter_throw_NullPointerException_tos_cached  ; 0xf8d5 0xf4b4
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	shared_monitor_exit
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_wide
bc_impl_wide

	EXPORT	bc_impl_wide_internal
bc_impl_wide_internal PROC
	; J2MEWP: wide -> jump to the wide entry stored just before the impl of bcp[1]
	ldrb.w	r7, [lr, #1]
	sub.w	r12, r5, r7, lsl #2
	ldr.w	r12, [r12, #0]
	bic	r12, r12, #1
	ldr.w	r12, [r12, #-4]
	mov	pc, r12
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	multianewarray
	ldr	r3, =multianewarray
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; load unsigned byte at bcp + 3
	ldrb.w	r2, [lr, #3]              ; 0xf89e 0x2003
	ldrb.w	r7, [lr, #4]!             ; 0xf81e 0x7f04 ; prefetch next bytecode
	add.w	r6, r6, r2, lsl #2        ; 0xeb06 0x0682
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L86
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
L86
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001
	ldrb.w	r3, [lr, #2]              ; 0xf89e 0x3002
	ldrb.w	r10, [lr, #3]             ; 0xf89e 0xa003
	ldrb.w	r11, [lr, #4]             ; 0xf89e 0xb004
	add.w	r2, r3, r2, lsl #8        ; 0xeb03 0x2202
	add.w	r2, r10, r2, lsl #8       ; 0xeb0a 0x2202
	add.w	r2, r11, r2, lsl #8       ; 0xeb0b 0x2202
	add.w	lr, lr, r2                ; 0xeb0e 0x0e02 ; prefetch next bytecode
	ldrb.w	r7, [lr, #0]              ; 0xf89e 0x7000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	svc	#0x0000ff                  ; 0xdfff
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_fast_1_ldc
bc_impl_fast_1_ldc

	EXPORT	bc_impl_fast_1_ldc_internal
bc_impl_fast_1_ldc_internal PROC
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; Get byte of constant pool entry
	ldrb.w	r0, [lr, #1]              ; 0xf89e 0x0001
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	add.w	r0, r9, r0, lsl #2        ; 0xeb09 0x0080 ; load constant pool entry
	ldr.w	r0, [r0, #0]              ; 0xf8d0 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; Get two bytes of constant pool entry
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001
	ldrb.w	r0, [lr, #2]              ; 0xf89e 0x0002
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	add.w	r2, r9, r2, lsl #10       ; 0xeb09 0x2282
	add.w	r2, r2, r0, lsl #2        ; 0xeb02 0x0280
	ldr.w	r0, [r2, #0]              ; 0xf8d2 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; Get two bytes of constant pool entry
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r0, [lr, #2]              ; 0xf89e 0x0002
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	add.w	r11, r9, r11, lsl #10     ; 0xeb09 0x2b8b
	add.w	r11, r11, r0, lsl #2      ; 0xeb0b 0x0b80
	ldr.w	r0, [r11, #0]             ; 0xf8db 0x0000
	ldr.w	r2, [r11, #4]             ; 0xf8db 0x2004
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L89
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L88
L89
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 1
L88
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r1[r3] := r0
	str.w	r0, [r1, #0]              ; 0xf8c1 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L87
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L92
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L91
L92
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
L91
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r1[r3] := r0
	str.w	r0, [r1, #0]              ; 0xf8c1 0x0000
	str.w	r2, [r1, #4]              ; 0xf8c1 0x2004
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L90
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
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L95
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L94
L95
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 1
L94
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r1[r3] := r0
	str.w	r0, [r1, #0]              ; 0xf8c1 0x0000
	; oop_write_barrier
	ldr.w	r0, [r5, #292]; = bitvector_base  ; 0xf8d5 0x0124
	mov.w	r1, r1, lsr #2            ; 0xea4f 0x0191
	add.w	r0, r0, r1, lsr #3        ; 0xeb00 0x00d1
	ldrb.w	r3, [r0, #0]              ; 0xf890 0x3000
	mov.w	r11, #1                   ; 0xf04f 0x0b01
	and.w	r1, r1, #7                ; 0xf001 0x0107
	lsl.w	r11, r11, r1              ; 0xfa0b 0xfb01
	orr.w	r3, r3, r11               ; 0xea43 0x030b
	strb.w	r3, [r0, #0]              ; 0xf880 0x3000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L93
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L98
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L97
L98
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
L97
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r0 := r1[r3]
	ldr.w	r0, [r1, #0]              ; 0xf8d1 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L96
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L101
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L100
L101
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
L100
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r0 := r1[r3]
	ldr.w	r0, [r1, #0]              ; 0xf8d1 0x0000
	ldr.w	r2, [r1, #4]              ; 0xf8d1 0x2004
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L99
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L102
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	strb.w	r0, [r2, r3]              ; 0xf802 0x0003 ; r2[r3] := r0
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L102
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L103
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	strh.w	r0, [r2, r3]              ; 0xf822 0x0003 ; r2[r3] := r0
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L103
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L104
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	add.w	r2, r2, r3, lsl #2        ; 0xeb02 0x0283 ; r2[r3] := r0
	str.w	r0, [r2, #0]              ; 0xf8c2 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L104
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L105
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	add.w	r10, r10, r3, lsl #2      ; 0xeb0a 0x0a83 ; r10[r3] := r0
	str.w	r0, [r10, #0]             ; 0xf8ca 0x0000
	str.w	r2, [r10, #4]             ; 0xf8ca 0x2004
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L105
	; Handle null pointer exception
	; Exit: Count = 3
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L106
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	add.w	r2, r2, r3, lsl #2        ; 0xeb02 0x0283 ; r2[r3] := r0
	str.w	r0, [r2, #0]              ; 0xf8c2 0x0000
	; oop_write_barrier
	ldr.w	r0, [r5, #292]; = bitvector_base  ; 0xf8d5 0x0124
	mov.w	r2, r2, lsr #2            ; 0xea4f 0x0292
	add.w	r0, r0, r2, lsr #3        ; 0xeb00 0x00d2
	ldrb.w	r3, [r0, #0]              ; 0xf890 0x3000
	mov.w	r11, #1                   ; 0xf04f 0x0b01
	and.w	r2, r2, #7                ; 0xf002 0x0207
	lsl.w	r11, r11, r2              ; 0xfa0b 0xfb02
	orr.w	r3, r3, r11               ; 0xea43 0x030b
	strb.w	r3, [r0, #0]              ; 0xf880 0x3000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L106
	; Handle null pointer exception
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L107
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	ldrsb.w	r0, [r0, r3]              ; 0xf910 0x0003 ; r0 := r0[r3]
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L107
	; Handle null pointer exception
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L108
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	ldrsh.w	r0, [r0, r3]              ; 0xf930 0x0003 ; r0 := r0[r3]
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L108
	; Handle null pointer exception
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L109
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	add.w	r0, r0, r3, lsl #2        ; 0xeb00 0x0083 ; r0 := r0[r3]
	ldr.w	r0, [r0, #0]              ; 0xf8d0 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L109
	; Handle null pointer exception
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L110
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	add.w	r3, r0, r3, lsl #2        ; 0xeb00 0x0383 ; r0 := r0[r3]
	ldr.w	r0, [r3, #0]              ; 0xf8d3 0x0000
	ldr.w	r2, [r3, #4]              ; 0xf8d3 0x2004
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L110
	; Handle null pointer exception
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	ldrb.w	r11, [lr, #1]             ; 0xf89e 0xb001
	ldrb.w	r12, [lr, #2]             ; 0xf89e 0xc002
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L111
	orr.w	r3, r11, r12, lsl #8      ; 0xea4b 0x230c
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	ldrh.w	r0, [r0, r3]              ; 0xf830 0x0003 ; r0 := r0[r3]
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L111
	; Handle null pointer exception
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Get two bytes of constant pool entry
	ldrb.w	r3, [lr, #1]              ; 0xf89e 0x3001
	ldrb.w	r11, [lr, #2]             ; 0xf89e 0xb002
	ldr.w	r10, [r5, #412]; = class_list_base  ; 0xf8d5 0xa19c
	add.w	r3, r9, r3, lsl #10       ; 0xeb09 0x2383
	add.w	r3, r3, r11, lsl #2       ; 0xeb03 0x038b
	ldr.w	r11, [r3, #0]             ; 0xf8d3 0xb000
	mov.w	r12, r11, lsl #16         ; 0xea4f 0x4c0b ; vtable index is low bits of cpool entry
	mov.w	r12, r12, lsr #16         ; 0xea4f 0x4c1c
	mov.w	r11, r11, asr #16         ; 0xea4f 0x4b2b ; class id is high bits of cpool entry
	ldr.w	r11, [r10, r11, lsl #2]   ; 0xf85a 0xb02b
	; Get fixed method from vtable of the class
	ldr.w	r11, [r11, #16]           ; 0xf8db 0xb010
	add.w	r3, r11, r12, lsl #2      ; 0xeb0b 0x038c
	ldr	r3, [r3, #40]             ; 0x6a9b
	; Get the number of parameters
	; get parameter size in words
	ldrh.w	r10, [r3, #32]            ; 0xf8b3 0xa020
	mov.w	r10, r10, lsl #23         ; 0xea4f 0x5aca ; mask off the return type bits
	mov.w	r10, r10, lsr #23         ; 0xea4f 0x5ada ; r10 = parameter size in words
	; Get receiver object
	add.w	r11, r6, r10, lsl #2      ; 0xeb06 0x0b8a ; address of stack pointer just past receiver
	ldr.w	r11, [r11, #-4]           ; 0xf85b 0xbc04 ; receiver
	; Check if it is null
	; null check
	cmp.w	r11, #0                   ; 0xf1bb 0x0f00 ; is object zero?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
	; Get java near
	ldr.w	r11, [r11, #0]            ; 0xf8db 0xb000
	; Get classinfo of receiver object
	ldr.w	r11, [r11, #4]            ; 0xf8db 0xb004
	; Get method from vtable of the class
	add.w	r0, r11, r12, lsl #2      ; 0xeb0b 0x008c
	ldr	r0, [r0, #40]             ; 0x6a80
	; Call method
	ldr	r2, [r0, #20]             ; 0x6942
	ldr	r2, [r2]                  ; 0x6812
	ldrh.w	r10, [r0, #32]            ; 0xf8b0 0xa020
	mov.w	r10, r10, lsr #9          ; 0xea4f 0x2a5a ; r10 = size of return type in words
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L112
	cmp.w	r10, #1                   ; 0xf1ba 0x0f01
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L113
	cmp.w	r10, #2                   ; 0xf1ba 0x0f02
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L114
	cmp.w	r10, #3                   ; 0xf1ba 0x0f03
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L115
	b	L116
L112
	; invoke method with result type == 0
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; return type is void
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L113
L114
	; invoke method with result type == 2
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L115
L116
	; invoke method with result type == 4
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0/r1
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Get two bytes of constant pool entry
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001
	ldrb.w	r0, [lr, #2]              ; 0xf89e 0x0002
	add.w	r2, r9, r2, lsl #10       ; 0xeb09 0x2282
	add.w	r2, r2, r0, lsl #2        ; 0xeb02 0x0280
	ldr.w	r0, [r2, #0]              ; 0xf8d2 0x0000
	; get holder of this method
	ldr.w	r3, [r5, #412]; = class_list_base  ; 0xf8d5 0x319c
	ldrh	r2, [r0, #26]             ; 0x8b42
	ldr.w	r2, [r3, r2, lsl #2]      ; 0xf853 0x2022
	ldr.w	r3, [r5, #416]; = mirror_list_base  ; 0xf8d5 0x31a0
	ldrh.w	r10, [r0, #26]            ; 0xf8b0 0xa01a
	ldr.w	r3, [r3, r10, lsl #2]     ; 0xf853 0x302a
	cmp	r3, #0                    ; 0x2b00
	; It will almost never be zero, so preload tmp2
	ldr.w	r10, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xa3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L118
	cmp	r3, r10                   ; 0x4553
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L117
L118
	; move instanceclass obj into extra arg
	adds	r1, r2, #0                ; 0x1c11
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001
	ldrb.w	r0, [lr, #2]              ; 0xf89e 0x0002
	add.w	r2, r9, r2, lsl #10       ; 0xeb09 0x2282
	add.w	r2, r2, r0, lsl #2        ; 0xeb02 0x0280
	ldr.w	r0, [r2, #0]              ; 0xf8d2 0x0000
L117
	; Call method
	ldr	r2, [r0, #20]             ; 0x6942
	ldr	r2, [r2]                  ; 0x6812
	ldrh.w	r10, [r0, #32]            ; 0xf8b0 0xa020
	mov.w	r10, r10, lsr #9          ; 0xea4f 0x2a5a ; r10 = size of return type in words
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L119
	cmp.w	r10, #1                   ; 0xf1ba 0x0f01
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L120
	cmp.w	r10, #2                   ; 0xf1ba 0x0f02
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L121
	cmp.w	r10, #3                   ; 0xf1ba 0x0f03
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L122
	b	L123
L119
	; invoke method with result type == 0
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; return type is void
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L120
L121
	; invoke method with result type == 2
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L122
L123
	; invoke method with result type == 4
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0/r1
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; load unsigned 16bit word at bcp + 1
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001 ; get bytes of constant pool index
	ldrb.w	r11, [lr, #2]             ; 0xf89e 0xb002
	; load unsigned byte at bcp + 3
	ldrb.w	r3, [lr, #3]              ; 0xf89e 0x3003 ; get count
	orr.w	r2, r11, r2, lsl #8       ; 0xea4b 0x2202 ; combine bytes
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Get the class id from resolved constant pool entry
	ldr.w	r10, [r9, r2, lsl #2]     ; 0xf859 0xa022
	; Get receiver object
	add.w	r0, r6, r3, lsl #2        ; 0xeb06 0x0083 ; address of stack pointer just past receiver
	ldr.w	r0, [r0, #-4]             ; 0xf850 0x0c04 ; receiver
	mov.w	r11, r10, lsr #16         ; 0xea4f 0x4b1a
	; null check
	cmp	r0, #0                    ; 0x2800 ; is object zero?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
	; Get class of receiver object
	ldr	r0, [r0]                  ; 0x6800
	sub.w	r10, r10, r11, lsl #16    ; 0xebaa 0x4a0b
	ldr	r0, [r0]                  ; 0x6800
	; Get ClassInfo of receiver class
	ldr	r0, [r0, #16]             ; 0x6900
	; Get the itable from the ClassInfo of the receiver object
	ldrh.w	r3, [r0, #6]              ; 0xf8b0 0x3006
	ldrh.w	r2, [r0, #8]              ; 0xf8b0 0x2008
	add.w	r1, r0, #32               ; 0xf100 0x0120
	add.w	r1, r1, r3, lsl #2        ; 0xeb01 0x0183
	; Lookup interface method table by linear search
L124
	subs	r2, #1                    ; 0x3a01
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	ldr.w	r12, [r1, #8]!            ; 0xf851 0xcf08
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	ldr.w	pc, [r5, #1208]; = interpreter_throw_IncompatibleClassChangeError  ; 0xf8d5 0xf4b8
	cmp	r11, r12                  ; 0x45e3
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L124
	; Found the itable entry; now get the method table offset from there
	ldr	r3, [r1, #4]              ; 0x684b
	; Get the method from the method table
	add.w	r0, r0, r10, lsl #2       ; 0xeb00 0x008a
	ldr.w	r0, [r0, r3]              ; 0xf850 0x0003
	; Call method
	ldr	r2, [r0, #20]             ; 0x6942
	ldr	r2, [r2]                  ; 0x6812
	ldrh.w	r10, [r0, #32]            ; 0xf8b0 0xa020
	mov.w	r10, r10, lsr #9          ; 0xea4f 0x2a5a ; r10 = size of return type in words
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L125
	cmp.w	r10, #1                   ; 0xf1ba 0x0f01
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L126
	cmp.w	r10, #2                   ; 0xf1ba 0x0f02
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L127
	cmp.w	r10, #3                   ; 0xf1ba 0x0f03
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L128
	b	L129
L125
	; invoke method with result type == 0
	blx	r2                        ; 0x4790

	EXPORT	invoke5_deoptimization_entry_0
invoke5_deoptimization_entry_0
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #5]!             ; 0xf81e 0x7f05 ; prefetch next bytecode
	; return type is void
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L126
L127
	; invoke method with result type == 2
	blx	r2                        ; 0x4790

	EXPORT	invoke5_deoptimization_entry_1
invoke5_deoptimization_entry_1

	EXPORT	invoke5_deoptimization_entry_2
invoke5_deoptimization_entry_2
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #5]!             ; 0xf81e 0x7f05 ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L128
L129
	; invoke method with result type == 4
	blx	r2                        ; 0x4790

	EXPORT	invoke5_deoptimization_entry_3
invoke5_deoptimization_entry_3

	EXPORT	invoke5_deoptimization_entry_4
invoke5_deoptimization_entry_4
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #5]!             ; 0xf81e 0x7f05 ; prefetch next bytecode
	; result is in r0/r1
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
L130
	; Get address of first paramater
	ldr.w	r2, [r4, #-4]             ; 0xf854 0x2c04 ; current method
	ldrh.w	r2, [r2, #24]             ; 0xf8b2 0x2018
	mov	r3, r8                    ; 0x4643
	; load unsigned byte at bcp + 1
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	; Set space for fake parameter for static method (KNI-ism)
	tst.w	r2, #8                    ; 0xf012 0x0f08
	DCW 0xbf18 ; IT ne                ; 0xbf18
	adds	r3, #4                    ; 0x3304
	; Point _kni_parameter_base to the first parameter
	str.w	r3, [r5, #472]            ; 0xf8c5 0x31d8
	ldr.w	r3, [lr, #4]              ; 0xf8de 0x3004 ; get the pointer from the bytecode
	; call the native code
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	cmp.w	r10, #12                  ; 0xf1ba 0x0f0c
	DCW 0xbf0c ; ITE eq               ; 0xbf0c
	ldr.w	r10, [r5, #124]; = shared_call_vm_oop  ; 0xf8d5 0xa07c
	ldr.w	r10, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xa084
	blx	r10                       ; 0x47d0
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldr.w	r3, [r5, #252]; = current_thread  ; 0xf8d5 0x30fc
	ldr.w	r10, [r3, #76]            ; 0xf8d3 0xa04c
	; Clear Thread.async_redo so that we won't loop indefinitely
	mov.w	r11, #0                   ; 0xf04f 0x0b00
	str.w	r11, [r3, #76]            ; 0xf8c3 0xb04c
	; loop if need to redo the native method invocation
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L130
	; load unsigned byte at bcp + 1
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001 ; Get kind
	str.w	r11, [r3, #52]            ; 0xf8c3 0xb034 ; Clear Thread.async_info
	; IMPL_NOTE: change this to a proper table switch
	cmp.w	r10, #10                  ; 0xf1ba 0x0f0a
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L131
	cmp.w	r10, #11                  ; 0xf1ba 0x0f0b
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L132
	cmp.w	r10, #14                  ; 0xf1ba 0x0f0e
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L133
	cmp.w	r10, #12                  ; 0xf1ba 0x0f0c
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L134
	cmp.w	r10, #6                   ; 0xf1ba 0x0f06
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L136
	cmp.w	r10, #7                   ; 0xf1ba 0x0f07
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L137
	svc	#0x0000ff                  ; 0xdfff
L131
	; store result
	adds	r0, r0, #0                ; 0x1c00
	ldr	r2, =bc_impl_ireturn_internal
	mov	pc, r2                    ; J2MEWP: was missing (fell into lreturn)
L132
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	ldr	r2, =bc_impl_lreturn_internal
	mov	pc, r2                    ; 0x4697
L134
	; store result
	adds	r0, r0, #0                ; 0x1c00
	ldr	r2, =bc_impl_areturn_internal
	mov	pc, r2                    ; 0x4697
L133
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr	r2, =bc_impl_return_internal
	mov	pc, r2                    ; 0x4697
L136
	; store result
	adds	r0, r0, #0                ; 0x1c00
	ldr	r2, =bc_impl_freturn_internal
	mov	pc, r2                    ; 0x4697
L137
	; store result
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	ldr	r2, =bc_impl_dreturn_internal
	mov	pc, r2                    ; 0x4697
L135
	svc	#0x0000ff                  ; 0xdfff
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Get two bytes of constant pool entry
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001
	ldrb.w	r0, [lr, #2]              ; 0xf89e 0x0002
	add.w	r2, r9, r2, lsl #10       ; 0xeb09 0x2282
	add.w	r2, r2, r0, lsl #2        ; 0xeb02 0x0280
	ldr.w	r0, [r2, #0]              ; 0xf8d2 0x0000
	; get parameter size in words
	ldrh.w	r10, [r0, #32]            ; 0xf8b0 0xa020 ; number of parameters
	mov.w	r10, r10, lsl #23         ; 0xea4f 0x5aca ; mask off the return type bits
	mov.w	r10, r10, lsr #23         ; 0xea4f 0x5ada ; r10 = parameter size in words
	add.w	r11, r6, r10, lsl #2      ; 0xeb06 0x0b8a ; get receiver object
	ldr.w	r11, [r11, #-4]           ; 0xf85b 0xbc04 ; receiver
	; null check
	cmp.w	r11, #0                   ; 0xf1bb 0x0f00 ; is object zero?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
	; Call method
	ldr	r2, [r0, #20]             ; 0x6942
	ldr	r2, [r2]                  ; 0x6812
	ldrh.w	r10, [r0, #32]            ; 0xf8b0 0xa020
	mov.w	r10, r10, lsr #9          ; 0xea4f 0x2a5a ; r10 = size of return type in words
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L138
	cmp.w	r10, #1                   ; 0xf1ba 0x0f01
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L139
	cmp.w	r10, #2                   ; 0xf1ba 0x0f02
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L140
	cmp.w	r10, #3                   ; 0xf1ba 0x0f03
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L141
	b	L142
L138
	; invoke method with result type == 0
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; return type is void
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L139
L140
	; invoke method with result type == 2
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L141
L142
	; invoke method with result type == 4
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0/r1
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Get two bytes of constant pool entry
	ldrb.w	r3, [lr, #1]              ; 0xf89e 0x3001
	ldrb.w	r11, [lr, #2]             ; 0xf89e 0xb002
	ldr.w	r10, [r5, #412]; = class_list_base  ; 0xf8d5 0xa19c
	add.w	r3, r9, r3, lsl #10       ; 0xeb09 0x2383
	add.w	r3, r3, r11, lsl #2       ; 0xeb03 0x038b
	ldr.w	r11, [r3, #0]             ; 0xf8d3 0xb000
	mov.w	r12, r11, lsl #16         ; 0xea4f 0x4c0b ; vtable index is low 16 bits of the cpool entry
	mov.w	r12, r12, lsr #16         ; 0xea4f 0x4c1c
	mov.w	r11, r11, asr #16         ; 0xea4f 0x4b2b ; class id is high 16 bits of the cpool entry
	ldr.w	r11, [r10, r11, lsl #2]   ; 0xf85a 0xb02b
	; Get ClassInfo from class
	ldr.w	r11, [r11, #16]           ; 0xf8db 0xb010
	; Get method from vtable of the ClassInfo
	add.w	r0, r11, r12, lsl #2      ; 0xeb0b 0x008c
	ldr	r0, [r0, #40]             ; 0x6a80
	; Get the number of parameters
	; get parameter size in words
	ldrh.w	r10, [r0, #32]            ; 0xf8b0 0xa020
	mov.w	r10, r10, lsl #23         ; 0xea4f 0x5aca ; mask off the return type bits
	mov.w	r10, r10, lsr #23         ; 0xea4f 0x5ada ; r10 = parameter size in words
	; Get receiver object
	add.w	r11, r6, r10, lsl #2      ; 0xeb06 0x0b8a ; address of stack pointer just past receiver
	ldr.w	r11, [r11, #-4]           ; 0xf85b 0xbc04 ; receiver
	; null check
	cmp.w	r11, #0                   ; 0xf1bb 0x0f00 ; is object zero?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
	; Call method
	ldr	r2, [r0, #20]             ; 0x6942
	ldr	r2, [r2]                  ; 0x6812
	ldrh.w	r10, [r0, #32]            ; 0xf8b0 0xa020
	mov.w	r10, r10, lsr #9          ; 0xea4f 0x2a5a ; r10 = size of return type in words
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L143
	cmp.w	r10, #1                   ; 0xf1ba 0x0f01
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L144
	cmp.w	r10, #2                   ; 0xf1ba 0x0f02
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L145
	cmp.w	r10, #3                   ; 0xf1ba 0x0f03
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L146
	b	L147
L143
	; invoke method with result type == 0
	blx	r2                        ; 0x4790

	EXPORT	invoke3_deoptimization_entry_0
invoke3_deoptimization_entry_0
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; return type is void
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L144
L145
	; invoke method with result type == 2
	blx	r2                        ; 0x4790

	EXPORT	invoke3_deoptimization_entry_1
invoke3_deoptimization_entry_1

	EXPORT	invoke3_deoptimization_entry_2
invoke3_deoptimization_entry_2
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L146
L147
	; invoke method with result type == 4
	blx	r2                        ; 0x4790

	EXPORT	invoke3_deoptimization_entry_3
invoke3_deoptimization_entry_3

	EXPORT	invoke3_deoptimization_entry_4
invoke3_deoptimization_entry_4
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0/r1
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r3, [r5, #412]; = class_list_base  ; 0xf8d5 0x319c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	ldr.w	r2, [r3, r1, lsl #2]      ; 0xf853 0x2021
	ldr.w	r10, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xa1a0
	ldr.w	r3, [r10, r1, lsl #2]     ; 0xf85a 0x3021
	ldr.w	r10, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xa3f8
	cmp	r3, r10                   ; 0x4553
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L149
L150
	; move instanceclass obj into extra arg
	adds	r1, r2, #0                ; 0x1c11
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	ldr.w	r3, [r5, #412]; = class_list_base  ; 0xf8d5 0x319c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r2, lsl #2      ; 0xeb0a 0x0a82
	ldr.w	r2, [r10, #0]             ; 0xf8da 0x2000
	ldr.w	r2, [r3, r2, lsl #2]      ; 0xf853 0x2022
L149
	; get _inline_allocation_top
	ldr.w	r0, [r5, #276]; = inline_allocation_top  ; 0xf8d5 0x0114
	; get instance size (in bytes) from class
	ldrsh.w	r1, [r2, #6]              ; 0xf9b2 0x1006
	; get _inline_allocation_end, and check for overflow
	ldr.w	r11, [r5, #280]; = inline_allocation_end  ; 0xf8d5 0xb118
	adds.w	r10, r0, r1               ; 0xeb10 0x0a01
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L148
	cmp	r10, r11                  ; 0x45da
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L148
	; allocation succeeded, set _inline_allocation_top
	str.w	r10, [r5, #276]           ; 0xf8c5 0xa114
	; get prototypical near from class
	ldr	r2, [r2, #12]             ; 0x68d2
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; set prototypical near in object; no need for write barrier
	str	r2, [r0]                  ; 0x6002
	; initialize object fields to zero
	add.w	r10, r0, #4               ; 0xf100 0x0a04
	sub.w	r11, r11, r11             ; 0xebab 0x0b0b
	subs	r1, #8                    ; 0x3908
L151
	; r10 = the next word to zero
	; r11 = 0
	; r1 = the_number_of_bytes_still_to_zero - 4
	; condition codes reflect the (signed) value in r1
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	str.w	r11, [r10], #4            ; 0xf84a 0xbb04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r11, [r10], #4            ; 0xf84a 0xbb04
	subs	r1, #8                    ; 0x3908
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L151
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L148
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	ldr	r3, =bc_impl_new_internal
	bx	r3                        ; 0x4718
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
	adds	r2, r0, #0                ; 0x1c02
	; go slow case if array length is larger than maximum safe array length or below zero
	cmp.w	r2, #1048576              ; 0xf5b2 0x1f80
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L152
	; compute array size in bytes
	mov.w	r1, r2, lsl #2            ; 0xea4f 0x0182
	adds	r1, #8                    ; 0x3108
	; get _inline_allocation_top
	ldr.w	r0, [r5, #276]; = inline_allocation_top  ; 0xf8d5 0x0114
	; get _inline_allocation_end, and check for overflow
	ldr.w	r11, [r5, #280]; = inline_allocation_end  ; 0xf8d5 0xb118
	adds.w	r10, r0, r1               ; 0xeb10 0x0a01
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L152
	cmp	r10, r11                  ; 0x45da
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L152
	; allocation succeeded, set _inline_allocation_top
	str.w	r10, [r5, #276]           ; 0xf8c5 0xa114
	; get constant pool entry
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r3, [lr, #2]              ; 0xf89e 0x3002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r3, lsl #2      ; 0xeb0a 0x0a83
	ldr.w	r3, [r10, #0]             ; 0xf8da 0x3000
	; If arrayclass pointer is non-zero we're done
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	ldr.w	r10, [r11, r3, lsl #2]    ; 0xf85b 0xa023
	ldr.w	r10, [r10, #28]           ; 0xf8da 0xa01c
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	mov	r3, r10                   ; 0x4653
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L153
	; get task mirror
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r3, [r11, r3, lsl #2]     ; 0xf85b 0x3023
	; get array class from class
	ldr	r3, [r3, #20]             ; 0x695b
	cmp	r3, #0                    ; 0x2b00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L152
L153
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; set array length
	str	r2, [r0, #4]              ; 0x6042
	; get prototypical near from array class
	ldr	r3, [r3, #12]             ; 0x68db
	; initialize array elements to zero
	add.w	r10, r0, #8               ; 0xf100 0x0a08
	sub.w	r11, r11, r11             ; 0xebab 0x0b0b
	subs	r2, #1                    ; 0x3a01
L154
	; r10 = the next word to zero
	; r11 = 0
	; r2 = the_number_of_words_still_to_zero - 1
	; condition codes reflect the (signed) value in r2
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	str.w	r11, [r10], #4            ; 0xf84a 0xbb04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r11, [r10], #4            ; 0xf84a 0xbb04
	subs	r2, #2                    ; 0x3a02
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L154
	; set prototypical near in array; no need for write barrier
	str	r3, [r0]                  ; 0x6003
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L152
	adds	r0, r2, #0                ; 0x1c10
	; Exit: Count = 1
	ldr	r3, =bc_impl_anewarray_internal
	bx	r3                        ; 0x4718
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
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L155
	; Get the class for the object, and the constant pool entry
	ldr	r2, [r0]                  ; 0x6802
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r3, [lr, #2]              ; 0xf89e 0x3002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r3, lsl #2      ; 0xeb0a 0x0a83
	ldr.w	r3, [r10, #0]             ; 0xf8da 0x3000
	ldr	r2, [r2]                  ; 0x6812
	ldr.w	r3, [r11, r3, lsl #2]     ; 0xf85b 0x3023
	; Compare the classes
	cmp	r3, r2                    ; 0x4293
	; Check the subtype caches
	DCW 0xbf1f ; ITTTT ne             ; 0xbf1f
	ldr.w	r10, [r2, #20]            ; 0xf8d2 0xa014
	ldr.w	r11, [r2, #24]            ; 0xf8d2 0xb018
	cmp	r3, r10                   ; 0x4553
	cmp	r3, r11                   ; 0x455b
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L156
L155
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L156
	; Exit: Count = 1
	ldr	r3, =bc_impl_checkcast
	bx	r3                        ; 0x4718
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
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L157
	; Get the class for the object, and the constant pool entry
	ldr	r2, [r0]                  ; 0x6802
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r3, [lr, #2]              ; 0xf89e 0x3002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r3, lsl #2      ; 0xeb0a 0x0a83
	ldr.w	r3, [r10, #0]             ; 0xf8da 0x3000
	ldr	r2, [r2]                  ; 0x6812
	ldr.w	r3, [r11, r3, lsl #2]     ; 0xf85b 0x3023
	; Compare the classes
	cmp	r3, r2                    ; 0x4293
	; Check the subtype caches
	DCW 0xbf1f ; ITTTT ne             ; 0xbf1f
	ldr.w	r10, [r2, #20]            ; 0xf8d2 0xa014
	ldr.w	r11, [r2, #24]            ; 0xf8d2 0xb018
	cmp	r3, r10                   ; 0x4553
	cmp	r3, r11                   ; 0x455b
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L158
	; Set the result to 1
	movs	r0, #1                    ; 0x2001
L157
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L158
	; Exit: Count = 1
	ldr	r3, =bc_impl_instanceof
	bx	r3                        ; 0x4718
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
	ldrb.w	r3, [lr, #1]              ; 0xf89e 0x3001
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L159
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	add.w	r0, r0, r3, lsl #2        ; 0xeb00 0x0083 ; r0 := r0[r3]
	ldr.w	r0, [r0, #0]              ; 0xf8d0 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L159
	; Handle null pointer exception
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldr.w	r0, [r8, #0]              ; 0xf8d8 0x0000
	ldrb.w	r3, [lr, #1]              ; 0xf89e 0x3001
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L160
	ldrb.w	r7, [lr, #2]!             ; 0xf81e 0x7f02 ; prefetch next bytecode
	add.w	r0, r0, r3, lsl #2        ; 0xeb00 0x0083 ; r0 := r0[r3]
	ldr.w	r0, [r0, #0]              ; 0xf8d0 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L160
	; Handle null pointer exception
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	cmp	r0, #0                    ; 0x2800 ; is object zero?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1204]; = interpreter_throw_NullPointerException_tos_cached  ; 0xf8d5 0xf4b4
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG

	ENDP
	; End segment: unnamed


	; ------------------------------------------------------
	; Start segment:  unnamed

	EXPORT	bc_impl_init_static_array
bc_impl_init_static_array

	EXPORT	bc_impl_init_static_array_internal
bc_impl_init_static_array_internal PROC
	ldrb.w	r3, [lr, #1]!             ; 0xf81e 0x3f01
	ldrb.w	r12, [lr, #1]!            ; 0xf81e 0xcf01
	ldrb.w	r10, [lr, #1]!            ; 0xf81e 0xaf01
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
	ldr.w	r11, [r0, #4]             ; 0xf8d0 0xb004
	add.w	r2, r0, #8                ; 0xf100 0x0208
	orr.w	r10, r12, r10, lsl #8     ; 0xea4c 0x2a0a
	cmp	r10, r11                  ; 0x45da
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	ldr.w	pc, [r5, #1216]; = interpreter_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf4c0
	lsl.w	r10, r10, r3              ; 0xfa0a 0xfa03
	add.w	r10, r10, lr              ; 0xeb0a 0x0a0e
L161
	ldrb.w	r3, [lr, #1]!             ; 0xf81e 0x3f01
	strb.w	r3, [r2], #1              ; 0xf802 0x3b01
	cmp	r10, lr                   ; 0x45f2
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	b	L161
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldr.w	r0, [r8, #0]              ; 0xf8d8 0x0000
	; Implicit offset = 4
	movs	r3, #1                    ; 0x2301
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L162
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	add.w	r0, r0, r3, lsl #2        ; 0xeb00 0x0083 ; r0 := r0[r3]
	ldr.w	r0, [r0, #0]              ; 0xf8d0 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L162
	; Handle null pointer exception
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	ldr.w	r0, [r8, #0]              ; 0xf8d8 0x0000
	; Implicit offset = 8
	movs	r3, #2                    ; 0x2302
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L163
	ldrb.w	r7, [lr, #1]!             ; 0xf81e 0x7f01 ; prefetch next bytecode
	add.w	r0, r0, r3, lsl #2        ; 0xeb00 0x0083 ; r0 := r0[r3]
	ldr.w	r0, [r0, #0]              ; 0xf8d0 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L163
	; Handle null pointer exception
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
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
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L166
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L165
L166
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 1
L165
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r1[r3] := r0
	str.w	r0, [r1, #0]              ; 0xf8c1 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L164
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
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L169
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L168
L169
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 2
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
L168
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r1[r3] := r0
	str.w	r0, [r1, #0]              ; 0xf8c1 0x0000
	str.w	r2, [r1, #4]              ; 0xf8c1 0x2004
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L167
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
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L172
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L171
L172
	; Exit: Count = 1
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 1
L171
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r1[r3] := r0
	str.w	r0, [r1, #0]              ; 0xf8c1 0x0000
	; oop_write_barrier
	ldr.w	r0, [r5, #292]; = bitvector_base  ; 0xf8d5 0x0124
	mov.w	r1, r1, lsr #2            ; 0xea4f 0x0191
	add.w	r0, r0, r1, lsr #3        ; 0xeb00 0x00d1
	ldrb.w	r3, [r0, #0]              ; 0xf890 0x3000
	mov.w	r11, #1                   ; 0xf04f 0x0b01
	and.w	r1, r1, #7                ; 0xf001 0x0107
	lsl.w	r11, r11, r1              ; 0xfa0b 0xfb01
	orr.w	r3, r3, r11               ; 0xea43 0x030b
	strb.w	r3, [r0, #0]              ; 0xf880 0x3000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L170
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L175
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L174
L175
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
L174
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r0 := r1[r3]
	ldr.w	r0, [r1, #0]              ; 0xf8d1 0x0000
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 1
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L173
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r11, [r5, #412]; = class_list_base  ; 0xf8d5 0xb19c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	mov.w	r3, r1, lsr #16           ; 0xea4f 0x4311
	; Get class_id from low sixteen bits of entry
	sub.w	r1, r1, r3, lsl #16       ; 0xeba1 0x4103
	ldr.w	r10, [r11, r1, lsl #2]    ; 0xf85b 0xa021
	; Get TaskMirror from class_id
	ldr.w	r11, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xb1a0
	ldr.w	r1, [r11, r1, lsl #2]     ; 0xf85b 0x1021
	cmp	r1, #0                    ; 0x2900
	; It will almost never be zero, so preload tmp3
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L178
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L177
L178
	; Exit: Count = 0
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; move instanceclass obj into extra arg
	mov	r1, r10                   ; 0x4651
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	; Get field offset from high sixteen bits of entry
	lsrs	r3, r1, #16               ; 0x0c0b
	; get pointer to task mirror into object
	adds	r1, r0, #0                ; 0x1c01
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	; Entry: Count = 0
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
L177
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	adds	r1, r1, r3                ; 0x18c9 ; r0 := r1[r3]
	ldr.w	r0, [r1, #0]              ; 0xf8d1 0x0000
	ldr.w	r2, [r1, #4]              ; 0xf8d1 0x2004
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L176
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; Get two bytes of constant pool entry
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001
	ldrb.w	r0, [lr, #2]              ; 0xf89e 0x0002
	add.w	r2, r9, r2, lsl #10       ; 0xeb09 0x2282
	add.w	r2, r2, r0, lsl #2        ; 0xeb02 0x0280
	ldr.w	r0, [r2, #0]              ; 0xf8d2 0x0000
	; get holder of this method
	ldr.w	r3, [r5, #412]; = class_list_base  ; 0xf8d5 0x319c
	ldrh	r2, [r0, #26]             ; 0x8b42
	ldr.w	r2, [r3, r2, lsl #2]      ; 0xf853 0x2022
	ldr.w	r3, [r5, #416]; = mirror_list_base  ; 0xf8d5 0x31a0
	ldrh.w	r10, [r0, #26]            ; 0xf8b0 0xa01a
	ldr.w	r3, [r3, r10, lsl #2]     ; 0xf853 0x302a
	cmp	r3, #0                    ; 0x2b00
	; It will almost never be zero, so preload tmp2
	ldr.w	r10, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xa3f8
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L180
	cmp	r3, r10                   ; 0x4553
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L179
L180
	; move instanceclass obj into extra arg
	adds	r1, r2, #0                ; 0x1c11
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r2, [lr, #1]              ; 0xf89e 0x2001
	ldrb.w	r0, [lr, #2]              ; 0xf89e 0x0002
	add.w	r2, r9, r2, lsl #10       ; 0xeb09 0x2282
	add.w	r2, r2, r0, lsl #2        ; 0xeb02 0x0280
	ldr.w	r0, [r2, #0]              ; 0xf8d2 0x0000
L179
	; Call method
	ldr	r2, [r0, #20]             ; 0x6942
	ldr	r2, [r2]                  ; 0x6812
	ldrh.w	r10, [r0, #32]            ; 0xf8b0 0xa020
	mov.w	r10, r10, lsr #9          ; 0xea4f 0x2a5a ; r10 = size of return type in words
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L181
	cmp.w	r10, #1                   ; 0xf1ba 0x0f01
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L182
	cmp.w	r10, #2                   ; 0xf1ba 0x0f02
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L183
	cmp.w	r10, #3                   ; 0xf1ba 0x0f03
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L184
	b	L185
L181
	; invoke method with result type == 0
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; return type is void
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L182
L183
	; invoke method with result type == 2
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0: do nothing
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L184
L185
	; invoke method with result type == 4
	blx	r2                        ; 0x4790
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; result is in r0/r1
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	adds	r0, r0, #0                ; 0x1c00
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
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
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r1, [lr, #2]              ; 0xf89e 0x1002
	ldr.w	r3, [r5, #412]; = class_list_base  ; 0xf8d5 0x319c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r1, lsl #2      ; 0xeb0a 0x0a81
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	ldr.w	r2, [r3, r1, lsl #2]      ; 0xf853 0x2021
	ldr.w	r10, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xa1a0
	ldr.w	r3, [r10, r1, lsl #2]     ; 0xf85a 0x3021
	ldr.w	r10, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xa3f8
	cmp	r3, r10                   ; 0x4553
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L187
L188
	; move instanceclass obj into extra arg
	adds	r1, r2, #0                ; 0x1c11
	IMPORT	task_barrier
	ldr	r3, =task_barrier
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm_oop
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	; reload registers
	; Get two bytes of constant pool entry
	ldrb.w	r10, [lr, #1]             ; 0xf89e 0xa001
	ldrb.w	r2, [lr, #2]              ; 0xf89e 0x2002
	ldr.w	r3, [r5, #412]; = class_list_base  ; 0xf8d5 0x319c
	add.w	r10, r9, r10, lsl #10     ; 0xeb09 0x2a8a
	add.w	r10, r10, r2, lsl #2      ; 0xeb0a 0x0a82
	ldr.w	r2, [r10, #0]             ; 0xf8da 0x2000
	ldr.w	r2, [r3, r2, lsl #2]      ; 0xf853 0x2022
L187
	; get _inline_allocation_top
	ldr.w	r0, [r5, #276]; = inline_allocation_top  ; 0xf8d5 0x0114
	; get instance size (in bytes) from class
	ldrsh.w	r1, [r2, #6]              ; 0xf9b2 0x1006
	; get _inline_allocation_end, and check for overflow
	ldr.w	r11, [r5, #280]; = inline_allocation_end  ; 0xf8d5 0xb118
	adds.w	r10, r0, r1               ; 0xeb10 0x0a01
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L186
	cmp	r10, r11                  ; 0x45da
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L186
	; allocation succeeded, set _inline_allocation_top
	str.w	r10, [r5, #276]           ; 0xf8c5 0xa114
	; get prototypical near from class
	ldr	r2, [r2, #12]             ; 0x68d2
	ldrb.w	r7, [lr, #3]!             ; 0xf81e 0x7f03 ; prefetch next bytecode
	; set prototypical near in object; no need for write barrier
	str	r2, [r0]                  ; 0x6002
	; initialize object fields to zero
	add.w	r10, r0, #4               ; 0xf100 0x0a04
	sub.w	r11, r11, r11             ; 0xebab 0x0b0b
	subs	r1, #8                    ; 0x3908
L189
	; r10 = the next word to zero
	; r11 = 0
	; r1 = the_number_of_bytes_still_to_zero - 4
	; condition codes reflect the (signed) value in r1
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	str.w	r11, [r10], #4            ; 0xf84a 0xbb04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r11, [r10], #4            ; 0xf84a 0xbb04
	subs	r1, #8                    ; 0x3908
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L189
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack stack from tos_in_regs
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
L186
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	ldr	r3, =bc_impl_new_internal
	bx	r3                        ; 0x4718
	LTORG

	ENDP
	; End segment: unnamed


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
	ldrh.w	r9, [r0, #24]             ; 0xf8b0 0x9018 ; get access flags
	tst.w	r9, #512                  ; 0xf419 0x7f00 ; compressed header?
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r9, [r5, #476]; = rom_constant_pool_fast  ; 0xf8d5 0x91dc
	DCW 0xbf08 ; IT eq                ; 0xbf08 ; method constant pool
	ldr.w	r9, [r0, #4]              ; 0xf8d0 0x9004
	; Reserve space on stack for frame
	sub.w	r6, r6, #28               ; 0xf1a6 0x061c
	; Fill in fields of the frame
	add.w	r9, r9, #12               ; 0xf109 0x090c
	str	r6, [r6, #24]             ; 0x61b6
	str.w	r8, [r6, #8]              ; 0xf8c6 0x8008
	str.w	r9, [r6, #12]             ; 0xf8c6 0x900c
	str	r0, [r6, #16]             ; 0x6130
	str	r4, [r6, #20]             ; 0x6174
	str.w	lr, [r6, #0]              ; 0xf8c6 0xe000
	; Set the Frame pointer
	add.w	r4, r6, #20               ; 0xf106 0x0414
	add.w	lr, r0, #40               ; 0xf100 0x0e28
	add.w	lr, lr, #536870912        ; 0xf10e 0x5e00
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	str.w	r1, [r6, #-4]!            ; 0xf846 0x1d04
	; stack_overflow(limit)
	adds	r1, r3, #0                ; 0x1c19
	IMPORT	stack_overflow
	ldr	r3, =stack_overflow
	bl	interpreter_call_vm
	; Get real return address
	ldr.w	r10, [r6, #0]             ; 0xf8d6 0xa000
	ldr.w	r0, [r4, #-4]             ; 0xf854 0x0c04
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c
	ldr.w	lr, [r4, #-20]            ; 0xf854 0xec14
	adds	r6, r4, #0                ; 0x1c26
	ldr.w	r4, [r6], #8              ; 0xf856 0x4b08
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	mov	pc, r10                   ; 0x46d7
	LTORG

	ENDP
	; End segment: Interpreter grow stack


	THUMB
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


	THUMB
	AREA |.text|, CODE
	; ------------------------------------------------------
	; Start segment: Interpreter method entry


	; ------------------------------------------------------
	; standard interpreter method entry

	EXPORT	fixed_interpreter_method_entry
fixed_interpreter_method_entry PROC
	nop                               ; 0xbf00

	ENDP

	EXPORT	interpreter_method_entry
interpreter_method_entry PROC
	nop                               ; 0xbf00
	; get parameter size in words
	ldrh	r2, [r0, #32]             ; 0x8c02
	mov.w	r2, r2, lsl #23           ; 0xea4f 0x52c2 ; mask off the return type bits
	mov.w	r2, r2, lsr #23           ; 0xea4f 0x52d2 ; r2 = parameter size in words
	add.w	r8, r6, r2, lsl #2        ; 0xeb06 0x0882
	sub.w	r8, r8, #4                ; 0xf1a8 0x0804
	; get maximum stack execution size
	ldrh	r3, [r0, #28]             ; 0x8b83
	ldr	r1, [r5, #84]; = current_stack_limit  ; 0x6d69
	sub.w	r3, r6, r3, lsl #2        ; 0xeba6 0x0383
	sub.w	r3, r3, #28               ; 0xf1a3 0x031c
	cmp	r3, r1                    ; 0x428b
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr	r1, =L190
	DCW 0xbf98 ; IT ls                ; 0xbf98
	ldr.w	pc, [r5, #1212]; = interpreter_grow_stack  ; 0xf8d5 0xf4bc
L190
	; get number of locals
	ldrh	r3, [r0, #30]             ; 0x8bc3
	; pushing cleared locals
	subs	r3, r3, r2                ; 0x1a9b
	sub.w	r6, r6, r3, lsl #2        ; 0xeba6 0x0683
	; get constants pool
	ldrh.w	r9, [r0, #24]             ; 0xf8b0 0x9018 ; get access flags
	tst.w	r9, #512                  ; 0xf419 0x7f00 ; compressed header?
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r9, [r5, #476]; = rom_constant_pool_fast  ; 0xf8d5 0x91dc
	DCW 0xbf08 ; IT eq                ; 0xbf08 ; method constant pool
	ldr.w	r9, [r0, #4]              ; 0xf8d0 0x9004
	; Reserve space on stack for frame
	sub.w	r6, r6, #28               ; 0xf1a6 0x061c
	; Fill in fields of the frame
	add.w	r9, r9, #12               ; 0xf109 0x090c
	str	r6, [r6, #24]             ; 0x61b6
	str.w	r8, [r6, #8]              ; 0xf8c6 0x8008
	str.w	r9, [r6, #12]             ; 0xf8c6 0x900c
	str	r0, [r6, #16]             ; 0x6130
	str	r4, [r6, #20]             ; 0x6174
	str.w	lr, [r6, #0]              ; 0xf8c6 0xe000
	; Set the Frame pointer
	add.w	r4, r6, #20               ; 0xf106 0x0414
	; set bcp
	add.w	lr, r0, #40               ; 0xf100 0x0e28
	; check if the method is synchronized
	ldrh	r2, [r0, #24]             ; 0x8b02
	tst.w	r2, #32                   ; 0xf012 0x0f20
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L191
L192
	ldr	r7, [r5, #92]; = rt_timer_ticks  ; 0x6def ; Timer tick?
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L193
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
L193
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode

	EXPORT	synchronize_interpreted_method
synchronize_interpreted_method
L191
	; synchronize method, register tmp0(r2) holds the access flags
	tst.w	r2, #8                    ; 0xf012 0x0f08
	; CC = ne: Synchronize on current class
	; CC = eq: Synchronize on local 0
	DCW 0xbf1c ; ITT ne               ; 0xbf1c
	ldrh.w	r11, [r0, #26]            ; 0xf8b0 0xb01a
	ldr.w	r10, [r5, #412]; = class_list_base  ; 0xf8d5 0xa19c
	DCW 0xbf0c ; ITE eq               ; 0xbf0c
	ldr.w	r0, [r8, #0]              ; 0xf8d8 0x0000
	ldr.w	r3, [r10, r11, lsl #2]    ; 0xf85a 0x302b
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	; if 'eq' then synchronizing on a local so skip all this mirror stuff
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L195
	ldr.w	r10, [r5, #416]; = mirror_list_base  ; 0xf8d5 0xa1a0
	ldr.w	r10, [r10, r11, lsl #2]   ; 0xf85a 0xa02b
	ldr.w	r11, [r5, #1016]; = task_class_init_marker  ; 0xf8d5 0xb3f8
	cmp	r10, r11                  ; 0x45da
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L195
L196
	; Class must be being initialized by the current thread then
	; Get the class to search the clinit list of current thread
	; get_mirror_from_clinit_list(mirror, klass, temp reg
	; J2MEWP: was svc (never ported) -> locked a garbage object. Walk the clinit list
	; of the current task for the TaskMirror of klass (r3), as cpu/arm does.
	ldr.w	r11, [r5, #1012]          ; current_task
	ldr.w	r10, [r11, #52]           ; Task::clinit_list (52: thumb2 cfg has ENABLE_INLINE=0, no _direct_callers)
J2MEWP_clinit_find
	ldr.w	r11, [r10, #8]            ; TaskMirror::containing_class
	cmp	r3, r11
	beq	J2MEWP_clinit_found
	ldr.w	r10, [r10, #16]           ; TaskMirror::next_in_clinit_list
	b	J2MEWP_clinit_find
J2MEWP_clinit_found
	ldr.w	r0, [r10, #4]             ; 0xf8da 0x0004
	b	L194
L195
	DCW 0xbf18 ; IT ne                ; 0xbf18
	ldr.w	r0, [r10, #4]             ; 0xf8da 0x0004
L194
	; object to lock is in r0
	bl	shared_lock_synchronized_method
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	b	L192
	LTORG

	ENDP
	; End segment: Interpreter method entry



	EXPORT	shared_entry_return_point
	THUMB
	AREA |.text|, CODE
	; ------------------------------------------------------
	; Start segment: Shared call VM

	EXPORT	interpreter_call_vm
interpreter_call_vm PROC

	ENDP

	EXPORT	shared_call_vm
shared_call_vm PROC
	; Save value of java stack pointer
	mov	r12, r6                   ; 0x46b4
	str.w	lr, [r6, #-4]!            ; 0xf846 0xed04
	; Get the current thread
	ldr.w	r7, [r5, #252]; = current_thread  ; 0xf8d5 0x70fc
	; LWT Switch stack to primordial thread
	ldr	r0, =L197
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r4, [r6, #-4]!            ; 0xf846 0x4d04
	; Save last java stack pointer and last java frame pointer in thread
	str	r6, [r7, #100]            ; 0x667e
	str	r4, [r7, #72]             ; 0x64bc
	str.w	r12, [r7, #68]            ; 0xf8c7 0xc044
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	; call the native entry
	blx	r3                        ; 0x4798
	; Save the return values in the thread
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	str	r0, [r2, #112]            ; 0x6710
	str	r1, [r2, #116]            ; 0x6751
	; check for pending entries and if so, check for enough stack space
	ldr	r0, [r2, #36]             ; 0x6a50
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L200
	ldr	r3, [r0, #4]              ; 0x6843
	b	L199
L198
	; check parameter size
	ldr	r1, [r0, #4]              ; 0x6841
	cmp	r3, r1                    ; 0x428b ; r3 = max(r3, r1)
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	adds	r3, r1, #0                ; 0x1c0b
L199
	; get next activation
	ldr	r0, [r0, #12]             ; 0x68c0
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L198
	; convert count to bytes plus a fudge factor
	mov.w	r3, r3, lsl #3            ; 0xea4f 0x03c3
	; add in a stack lock for good measure
	add.w	r3, r3, #28               ; 0xf103 0x031c
	ldr	r0, [r2, #100]            ; 0x6e50
	subs	r3, r0, r3                ; 0x1ac3
	ldr	r0, [r5, #84]; = current_stack_limit  ; 0x6d68
	cmp	r3, r0                    ; 0x4283
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	b	L200
	; need more stack, call into the VM
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	adds	r1, r3, #0                ; 0x1c19
	bl	stack_overflow
L200
	; Call switch_thread(JVM_TRAPS)
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	IMPORT	switch_thread
	bl	switch_thread
	; Switch back to the java stack
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	ldr	r6, [r2, #100]            ; 0x6e56
	ldr.w	r4, [r6], #4              ; 0xf856 0x4b04
	ldr.w	lr, [r6], #4              ; 0xf856 0xeb04
	mov	pc, lr                    ; 0x46f7
	ALIGN	4
L197
	ldr.w	r0, [r5, #252]; = current_thread  ; 0xf8d5 0x00fc
	; Load pending offset activations here and check below
	ldr	r3, [r0, #36]             ; 0x6a43
	; restore the return values in the thread
	ldr	r1, [r0, #116]            ; 0x6f41
	ldr	r0, [r0, #112]            ; 0x6f00
	movs	r2, #0                    ; 0x2200
	cmp	r3, #0                    ; 0x2b00 ; check for pending activations
	DCW 0xbf18 ; IT ne                ; 0xbf18 ; invoke the pending activations
	bl	shared_entry
	; reset last java frame in thread
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	movs	r3, #0                    ; 0x2300
	str	r3, [r2, #68]             ; 0x6453
	str	r3, [r2, #72]             ; 0x6493
	; Get pending exceptions
	ldr.w	r3, [r5, #256]; = current_pending_exception  ; 0xf8d5 0x3100
	ldr.w	lr, [r6], #4              ; 0xf856 0xeb04
	; check for pending exceptions
	cmp	r3, #0                    ; 0x2b00
	; return if no pending exceptions
	DCW 0xbf04 ; ITT eq               ; 0xbf04
	orr.w	lr, lr, #1                ; 0xf04e 0x0e01
	bx	lr                        ; 0x4770
	; Call shared_call_vm_exception
	adds	r1, r3, #0                ; 0x1c19 ; argument goes into r1
	movs	r3, #0                    ; 0x2300 ; clear pending exception
	str.w	r3, [r5, #256]            ; 0xf8c5 0x3100
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
	mov	r12, r6                   ; 0x46b4
	str.w	lr, [r6, #-4]!            ; 0xf846 0xed04
	; Get the current thread
	ldr.w	r7, [r5, #252]; = current_thread  ; 0xf8d5 0x70fc
	; LWT Switch stack to primordial thread
	ldr	r0, =L201
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r4, [r6, #-4]!            ; 0xf846 0x4d04
	; Save last java stack pointer and last java frame pointer in thread
	str	r6, [r7, #100]            ; 0x667e
	str	r4, [r7, #72]             ; 0x64bc
	str.w	r12, [r7, #68]            ; 0xf8c7 0xc044
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	; call the native entry
	blx	r3                        ; 0x4798
	; Save the return values in the thread
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	str.w	r0, [r2, #48]!            ; 0xf842 0x0f30
	; oop_write_barrier
	ldr.w	r0, [r5, #292]; = bitvector_base  ; 0xf8d5 0x0124
	mov.w	r2, r2, lsr #2            ; 0xea4f 0x0292
	add.w	r0, r0, r2, lsr #3        ; 0xeb00 0x00d2
	ldrb.w	r1, [r0, #0]              ; 0xf890 0x1000
	movs	r3, #1                    ; 0x2301
	and.w	r2, r2, #7                ; 0xf002 0x0207
	lsl.w	r3, r3, r2                ; 0xfa03 0xf302
	orr.w	r1, r1, r3                ; 0xea41 0x0103
	strb.w	r1, [r0, #0]              ; 0xf880 0x1000
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	str	r0, [r2, #112]            ; 0x6710
	; check for pending entries and if so, check for enough stack space
	ldr	r0, [r2, #36]             ; 0x6a50
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L204
	ldr	r3, [r0, #4]              ; 0x6843
	b	L203
L202
	; check parameter size
	ldr	r1, [r0, #4]              ; 0x6841
	cmp	r3, r1                    ; 0x428b ; r3 = max(r3, r1)
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	adds	r3, r1, #0                ; 0x1c0b
L203
	; get next activation
	ldr	r0, [r0, #12]             ; 0x68c0
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L202
	; convert count to bytes plus a fudge factor
	mov.w	r3, r3, lsl #3            ; 0xea4f 0x03c3
	; add in a stack lock for good measure
	add.w	r3, r3, #28               ; 0xf103 0x031c
	ldr	r0, [r2, #100]            ; 0x6e50
	subs	r3, r0, r3                ; 0x1ac3
	ldr	r0, [r5, #84]; = current_stack_limit  ; 0x6d68
	cmp	r3, r0                    ; 0x4283
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	b	L204
	; need more stack, call into the VM
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	adds	r1, r3, #0                ; 0x1c19
	bl	stack_overflow
L204
	; Call switch_thread(JVM_TRAPS)
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	bl	switch_thread
	; Switch back to the java stack
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	ldr	r6, [r2, #100]            ; 0x6e56
	ldr.w	r4, [r6], #4              ; 0xf856 0x4b04
	ldr.w	lr, [r6], #4              ; 0xf856 0xeb04
	mov	pc, lr                    ; 0x46f7
	ALIGN	4
L201

	ENDP

	EXPORT	shared_call_vm_oop_return
shared_call_vm_oop_return PROC
	ldr.w	r0, [r5, #252]; = current_thread  ; 0xf8d5 0x00fc
	; Load pending offset activations here and check below
	ldr	r3, [r0, #36]             ; 0x6a43
	; restore the return values in the thread
	ldr	r2, [r0, #48]             ; 0x6b02
	movs	r1, #0                    ; 0x2100
	str	r1, [r0, #48]             ; 0x6301
	cmp	r3, #0                    ; 0x2b00 ; check for pending activations
	DCW 0xbf18 ; IT ne                ; 0xbf18 ; invoke the pending activations
	bl	shared_entry
	adds	r0, r2, #0                ; 0x1c10 ; move oop return value to r0
	; reset last java frame in thread
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	movs	r3, #0                    ; 0x2300
	str	r3, [r2, #68]             ; 0x6453
	str	r3, [r2, #72]             ; 0x6493
	; Get pending exceptions
	ldr.w	r3, [r5, #256]; = current_pending_exception  ; 0xf8d5 0x3100
	ldr.w	lr, [r6], #4              ; 0xf856 0xeb04
	; check for pending exceptions
	cmp	r3, #0                    ; 0x2b00
	; return if no pending exceptions
	DCW 0xbf04 ; ITT eq               ; 0xbf04
	orr.w	lr, lr, #1                ; 0xf04e 0x0e01
	bx	lr                        ; 0x4770
	; Call shared_call_vm_exception
	adds	r1, r3, #0                ; 0x1c19 ; argument goes into r1
	movs	r3, #0                    ; 0x2300 ; clear pending exception
	str.w	r3, [r5, #256]            ; 0xf8c5 0x3100
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
	mov	r12, r6                   ; 0x46b4
	str.w	lr, [r6, #-4]!            ; 0xf846 0xed04
	sub.w	r6, r6, #4                ; 0xf1a6 0x0604 ; Leave empty space on stack
	; Get the current thread
	ldr.w	r7, [r5, #252]; = current_thread  ; 0xf8d5 0x70fc
	; LWT Switch stack to primordial thread
	ldr	r0, =L205
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	str.w	r4, [r6, #-4]!            ; 0xf846 0x4d04
	; Save last java stack pointer and last java frame pointer in thread
	str	r6, [r7, #100]            ; 0x667e
	str	r4, [r7, #72]             ; 0x64bc
	str.w	r12, [r7, #68]            ; 0xf8c7 0xc044
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	; call the native entry
	IMPORT	find_exception_frame
	bl	find_exception_frame
	; Save the return values in the thread
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	str	r0, [r2, #112]            ; 0x6710
	; check for pending entries and if so, check for enough stack space
	ldr	r0, [r2, #36]             ; 0x6a50
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L208
	ldr	r3, [r0, #4]              ; 0x6843
	b	L207
L206
	; check parameter size
	ldr	r1, [r0, #4]              ; 0x6841
	cmp	r3, r1                    ; 0x428b ; r3 = max(r3, r1)
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	adds	r3, r1, #0                ; 0x1c0b
L207
	; get next activation
	ldr	r0, [r0, #12]             ; 0x68c0
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L206
	; convert count to bytes plus a fudge factor
	mov.w	r3, r3, lsl #3            ; 0xea4f 0x03c3
	; add in a stack lock for good measure
	add.w	r3, r3, #28               ; 0xf103 0x031c
	ldr	r0, [r2, #100]            ; 0x6e50
	subs	r3, r0, r3                ; 0x1ac3
	ldr	r0, [r5, #84]; = current_stack_limit  ; 0x6d68
	cmp	r3, r0                    ; 0x4283
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	b	L208
	; need more stack, call into the VM
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	adds	r1, r3, #0                ; 0x1c19
	bl	stack_overflow
L208
	; Call switch_thread(JVM_TRAPS)
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	bl	switch_thread
	; Switch back to the java stack
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	ldr	r6, [r2, #100]            ; 0x6e56
	ldr.w	r4, [r6], #4              ; 0xf856 0x4b04
	ldr.w	lr, [r6], #4              ; 0xf856 0xeb04
	mov	pc, lr                    ; 0x46f7
	ALIGN	4
L205
	ldr.w	r0, [r5, #252]; = current_thread  ; 0xf8d5 0x00fc
	ldr	r4, [r0, #72]             ; 0x6c84
	ldr	r1, [r0, #68]             ; 0x6c41
	sub.w	r6, r1, #4                ; 0xf1a1 0x0604
	; Load pending offset activations here and check below
	ldr	r3, [r0, #36]             ; 0x6a43
	; restore the return values in the thread
	ldr	r0, [r0, #112]            ; 0x6f00
	movs	r2, #0                    ; 0x2200
	cmp	r3, #0                    ; 0x2b00 ; check for pending activations
	DCW 0xbf18 ; IT ne                ; 0xbf18 ; invoke the pending activations
	bl	shared_entry
	; reset last java frame in thread
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	movs	r3, #0                    ; 0x2300
	str	r3, [r2, #68]             ; 0x6453
	str	r3, [r2, #72]             ; 0x6493
	cmp	r0, #0                    ; 0x2800
	; A return value of zero means the initial entry frame
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L209
	ldr.w	r1, [r4, #-24]            ; 0xf854 0x1c18 ; exception is stored in frame
	ldr.w	lr, [r4, #0]              ; 0xf8d4 0xe000 ; return address
	add.w	r6, r4, #8                ; 0xf104 0x0608 ; pop entry frame off stack
	str.w	r1, [r5, #256]            ; 0xf8c5 0x1100
	orr.w	lr, lr, #1                ; 0xf04e 0x0e01
	bx	lr                        ; 0x4770
L209
	; Get pending exceptions
	ldr.w	r3, [r5, #256]; = current_pending_exception  ; 0xf8d5 0x3100
	ldr.w	lr, [r6], #4              ; 0xf856 0xeb04
	; check for pending exceptions
	cmp	r3, #0                    ; 0x2b00
	; return if no pending exceptions
	DCW 0xbf04 ; ITT eq               ; 0xbf04
	orr.w	lr, lr, #1                ; 0xf04e 0x0e01
	bx	lr                        ; 0x4770
	; Call shared_call_vm_exception
	adds	r1, r3, #0                ; 0x1c19 ; argument goes into r1
	movs	r3, #0                    ; 0x2300 ; clear pending exception
	str.w	r3, [r5, #256]            ; 0xf8c5 0x3100
	b	shared_call_vm_exception
	LTORG

	ENDP
	; End segment: Shared call VM


	; ------------------------------------------------------
	; Start segment: Shared entry

	EXPORT	shared_entry
shared_entry PROC
	; Get information
	ldr.w	r3, [r5, #252]; = current_thread  ; 0xf8d5 0x30fc
	ldr.w	r12, [r5, #256]; = current_pending_exception  ; 0xf8d5 0xc100
	ldr.w	r10, [r3, #72]            ; 0xf8d3 0xa048 ; Thread::last_java_fp
	ldr.w	r11, [r3, #68]            ; 0xf8d3 0xb044 ; Thread::last_java_sp
	ldr	r7, =0xdeadbeef          ; EntryFrame::FakeReturnAddress
	subs	r6, #36                   ; 0x3e24 ; make room on stack for EntryFrame
	add.w	r4, r6, #28               ; 0xf106 0x041c ; set the fp of the EntryFrame
	; Store information in the frame
	str.w	r12, [r4, #-24]           ; 0xf844 0xcc18 ; current pending exception
	str	r2, [r4, #4]              ; 0x6062 ; stored obj value
	str.w	r1, [r4, #-12]            ; 0xf844 0x1c0c ; stored int value #1
	str.w	r0, [r4, #-16]            ; 0xf844 0x0c10 ; stored int value #2
	str.w	r11, [r4, #-8]            ; 0xf844 0xbc08 ; stored_last_sp
	str.w	r10, [r4, #-4]            ; 0xf844 0xac04 ; stored_last_fp
	str.w	lr, [r4, #0]              ; 0xf8c4 0xe000 ; real_return_address
	str.w	r7, [r4, #-20]            ; 0xf844 0x7c14 ; fake_return_address
	; reset last java frame
	movs	r0, #0                    ; 0x2000
	str	r0, [r3, #68]             ; 0x6458 ; last_java_sp
	str	r0, [r3, #72]             ; 0x6498 ; last_java_fp
	; get pending activation list
	ldr.w	r10, [r3, #36]            ; 0xf8d3 0xa024
	; reset pending exception and activation
	str	r0, [r3, #36]             ; 0x6258
	str.w	r0, [r5, #256]            ; 0xf8c5 0x0100
L210
	; Handle one activation
	ldr.w	r0, [r10, #12]            ; 0xf8da 0x000c ; get next pending activation
	ldr.w	r12, [r10, #4]            ; 0xf8da 0xc004 ; argument length
	add.w	r11, r10, #16             ; 0xf10a 0x0b10 ; pointer to first argument
	cmp.w	r12, #0                   ; 0xf1bc 0x0f00
	str.w	r0, [r4, #-28]            ; 0xf844 0x0c1c ; save next pending activation
	; push parameter from entry activation
L211
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	ldr.w	r0, [r11], #8             ; 0xf85b 0x0b08
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04
	subs.w	r12, r12, #1              ; 0xf1bc 0x0c01 ; Decrement the length and check for more parameters
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	b	L211
	ldr.w	r0, [r10, #8]             ; 0xf8da 0x0008 ; method from entry activation
	ldr	r2, [r0, #20]             ; 0x6942 ; variable_part_offset
	ldr	r2, [r2]                  ; 0x6812 ; Code to call
	blx	r2                        ; 0x4790
shared_entry_return_point
	ldr.w	r10, [r4, #-28]           ; 0xf854 0xac1c ; restore the next pending activation
	ldr.w	r3, [r4, #-24]            ; 0xf854 0x3c18 ; speculatively restore pending exception
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00 ; check for more pending activations
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L210
	ldr	r2, [r4, #4]              ; 0x6862 ; restore return value(s)
	ldr.w	r1, [r4, #-12]            ; 0xf854 0x1c0c
	ldr.w	r0, [r4, #-16]            ; 0xf854 0x0c10
	; restore pending exception
	str.w	r3, [r5, #256]            ; 0xf8c5 0x3100

	EXPORT	shared_entry_return
shared_entry_return
	; Remove information from the entry frame
	ldr.w	r3, [r5, #252]; = current_thread  ; 0xf8d5 0x30fc
	ldr.w	r11, [r4, #-8]            ; 0xf854 0xbc08 ; stored_last_fp
	ldr.w	r10, [r4, #-4]            ; 0xf854 0xac04 ; stored_last_sp
	ldr.w	lr, [r4, #0]              ; 0xf8d4 0xe000 ; real_return_address
	add.w	r6, r4, #8                ; 0xf104 0x0608 ; pop entry frame
	mov	r4, r10                   ; 0x4654 ; restore fp
	str.w	r11, [r3, #68]            ; 0xf8c3 0xb044 ; restore Thread::last_java_sp
	str.w	r10, [r3, #72]            ; 0xf8c3 0xa048 ; restore Thread::last_java_fp
	mov	pc, lr                    ; 0x46f7
	LTORG

	ENDP
	; End segment: Shared entry


	; ------------------------------------------------------
	; Start segment: Shared invoke compiler

	EXPORT	shared_invoke_compiler
shared_invoke_compiler PROC
	; Fake a clock tick
	ldr	r2, [r5, #92]; = rt_timer_ticks  ; 0x6dea
	adds	r2, #1                    ; 0x3201
	str	r2, [r5, #92]; = rt_timer_ticks  ; 0x65ea
	b	interpreter_method_entry
	LTORG

	ENDP
	; End segment: Shared invoke compiler


	; ------------------------------------------------------
	; Start segment: Shared fast accessors

	EXPORT	shared_fast_getbyte_accessor
shared_fast_getbyte_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	ldrsb.w	r0, [r10, r11]            ; 0xf91a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getshort_accessor
shared_fast_getshort_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	ldrsh.w	r0, [r10, r11]            ; 0xf93a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getchar_accessor
shared_fast_getchar_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	ldrh.w	r0, [r10, r11]            ; 0xf83a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getint_accessor
shared_fast_getint_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	ldr.w	r0, [r10, r11]            ; 0xf85a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getfloat_accessor
shared_fast_getfloat_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	ldr.w	r0, [r10, r11]            ; 0xf85a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getdouble_accessor
shared_fast_getdouble_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	ldr.w	r0, [r10, r11]            ; 0xf85a 0x000b ; get field from 'this' object
	add.w	r10, r10, r11             ; 0xeb0a 0x0a0b
	ldr.w	r1, [r10, #4]             ; 0xf8da 0x1004
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getlong_accessor
shared_fast_getlong_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	ldr.w	r0, [r10, r11]            ; 0xf85a 0x000b ; get field from 'this' object
	add.w	r10, r10, r11             ; 0xeb0a 0x0a0b
	ldr.w	r1, [r10, #4]             ; 0xf8da 0x1004
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getbyte_static_accessor
shared_fast_getbyte_static_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L212
	ldrsb.w	r0, [r10, r11]            ; 0xf91a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getshort_static_accessor
shared_fast_getshort_static_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L212
	ldrsh.w	r0, [r10, r11]            ; 0xf93a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getchar_static_accessor
shared_fast_getchar_static_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L212
	ldrh.w	r0, [r10, r11]            ; 0xf83a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getint_static_accessor
shared_fast_getint_static_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L212
	ldr.w	r0, [r10, r11]            ; 0xf85a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getfloat_static_accessor
shared_fast_getfloat_static_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L212
	ldr.w	r0, [r10, r11]            ; 0xf85a 0x000b ; get field from 'this' object
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getdouble_static_accessor
shared_fast_getdouble_static_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L212
	ldr.w	r0, [r10, r11]            ; 0xf85a 0x000b ; get field from 'this' object
	add.w	r10, r10, r11             ; 0xeb0a 0x0a0b
	ldr.w	r1, [r10, #4]             ; 0xf8da 0x1004
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	shared_fast_getlong_static_accessor
shared_fast_getlong_static_accessor PROC
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04 ; pop 'this'
	ldrh.w	r11, [r0, #30]            ; 0xf8b0 0xb01e ; get field offset (is 2-byte aligned!)
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L212
	ldr.w	r0, [r10, r11]            ; 0xf85a 0x000b ; get field from 'this' object
	add.w	r10, r10, r11             ; 0xeb0a 0x0a0b
	ldr.w	r1, [r10, #4]             ; 0xf8da 0x1004
	mov	pc, lr                    ; 0x46f7
L212
	; Restore stack state and continue with exception throwing
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	ldr.w	pc, [r5, #1200]; = interpreter_throw_NullPointerException  ; 0xf8d5 0xf4b0
	LTORG

	ENDP
	; End segment: Shared fast accessors


	; ------------------------------------------------------
	; Start segment: Shared monitor enter

	EXPORT	shared_monitor_enter
shared_monitor_enter PROC
	; Are there any monitors at all?
	ldr	r2, [r4, #4]              ; 0x6862
	movs	r1, #0                    ; 0x2100
	sub.w	r3, r4, #20               ; 0xf1a4 0x0314
	cmp	r3, r2                    ; 0x4293
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L215
	; Search for empty lock
	; point at object field of stack lock
	adds	r2, #24                   ; 0x3218
	; object field just before first lock
	adds	r3, r4, #4                ; 0x1d23
L213
	; Start the loop by checking if the current stack lock is empty
	ldr.w	r10, [r2], #28            ; 0xf852 0xab1c
	cmp.w	r10, #0                   ; 0xf1ba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08 ; point at beginning of previous lock if empty
	sub.w	r1, r2, #52               ; 0xf1a2 0x0134
	; Current stack lock object equal to the object from the stack?
	cmp.w	r10, r0                   ; 0xebba 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L214
	; Go to next stack lock in monitor block
	cmp.w	r2, r3                    ; 0xebb2 0x0f03
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L213
L214
	; Have we found an entry?
	cmp	r1, #0                    ; 0x2900
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L216
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L215

	ENDP

	EXPORT	shared_lock_synchronized_method
shared_lock_synchronized_method PROC
	subs	r6, #28                   ; 0x3e1c
	str	r6, [r4, #4]              ; 0x6066
	adds	r1, r6, #0                ; 0x1c31
L216
	; r0 contains the object to lock
	; r1 contains a stack lock in the monitor block
	ldr	r3, [r0]                  ; 0x6803 ; Get the near object
	str	r0, [r1, #24]             ; 0x6188 ; Store the object in the stack lock and lock it
	ldr.w	r10, [r5, #1004]; = interned_string_near_addr  ; 0xf8d5 0xa3ec ; See if this is an interned string
	cmp	r10, r3                   ; 0x459a
	DCW 0xbf02 ; ITTT eq              ; 0xbf02
	; If going the slow way, zero out real java near for GC 
	mov.w	r10, #0                   ; 0xf04f 0x0a00
	str.w	r10, [r1, #4]             ; 0xf8c1 0xa004
	b	L218
	ldr.w	r10, [r3, #8]             ; 0xf8d3 0xa008 ; object already locked?
	tst.w	r10, #1                   ; 0xf01a 0x0f01
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L217
	; We have the fast case
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	orr.w	r10, r10, #1              ; 0xf04a 0x0a01
	str.w	r10, [r1, #20]            ; 0xf8c1 0xa014
	str	r3, [r1, #4]              ; 0x604b
	str	r2, [r1]                  ; 0x600a
	; Clear waiters
	movs	r2, #0                    ; 0x2200
	str	r2, [r1, #8]              ; 0x608a
	; Update the near pointer in the object
	add.w	r2, r1, #12               ; 0xf101 0x020c
	str	r2, [r0]                  ; 0x6002
	; Copy the locked near object to the stack and set lock bit
	; Copy the first two fields of the near
	ldr	r2, [r3]                  ; 0x681a
	ldr.w	r10, [r3, #4]             ; 0xf8d3 0xa004
	str	r2, [r1, #12]             ; 0x60ca
	str.w	r10, [r1, #16]            ; 0xf8c1 0xa010
	mov	pc, lr                    ; 0x46f7
L217
	ldr.w	r2, [r5, #252]; = current_thread  ; 0xf8d5 0x20fc
	ldr.w	r3, [r3, #-12]            ; 0xf853 0x3c0c ; thread of object's lock
	mov.w	r10, #0                   ; 0xf04f 0x0a00 ; set our own real java near field to nul
	str.w	r10, [r1, #4]             ; 0xf8c1 0xa004
	cmp	r2, r3                    ; 0x429a ; is this a recursive lock?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	mov	pc, lr                    ; 0x46f7
L218
	IMPORT	lock_stack_lock
	ldr	r3, =lock_stack_lock
	ldr.w	pc, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xf084
L215
	; Allocate a stack lock in the monitor block
	; Set lock to old expression stack bottom
	ldr	r1, [r4, #4]              ; 0x6861
	; Move expression stack top and bottom
	sub.w	r6, r6, #28               ; 0xf1a6 0x061c
	sub.w	r1, r1, #28               ; 0xf1a1 0x011c
	str	r1, [r4, #4]              ; 0x6061
	; Move the expression stack contents
	adds	r2, r6, #0                ; 0x1c32
	b	L219
L220
	ldr	r3, [r2, #28]             ; 0x69d3
	str.w	r3, [r2], #4              ; 0xf842 0x3b04
L219
	; Check if bottom is reached
	cmp	r2, r1                    ; 0x428a
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L220
	b	L216
	LTORG

	ENDP
	; End segment: Shared monitor enter


	; ------------------------------------------------------
	; Start segment: Shared monitor exit

	EXPORT	shared_monitor_exit
shared_monitor_exit PROC
	ldr	r3, [r0]                  ; 0x6803 ; Get the near object
	ldr.w	r10, [r5, #1004]; = interned_string_near_addr  ; 0xf8d5 0xa3ec ; See if this is an interned string
	cmp	r10, r3                   ; 0x459a
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L221
	adds	r1, r0, #0                ; 0x1c01
	IMPORT	unlock_special_stack_lock
	ldr	r3, =unlock_special_stack_lock
	ldr.w	pc, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xf084
L221
	; Find matching slot in monitor block
	ldr	r1, [r4, #4]              ; 0x6861 ; end of locks
	sub.w	r3, r4, #20               ; 0xf1a4 0x0314 ; address of lock just beyond the first
	cmp.w	r1, r3                    ; 0xebb1 0x0f03
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L224
L222
	; Is monitor pointed at by lock the right one?
	ldr	r2, [r1, #24]             ; 0x698a ; get object field
	cmp	r0, r2                    ; 0x4290 ; is this the right object?
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L223
	add.w	r1, r1, #28               ; 0xf101 0x011c ; Go to next lock
	cmp	r1, r3                    ; 0x4299 ; at the end of the monitor block?
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L222
L224
	; Throw an IllegalMonitorStateException
	IMPORT	illegal_monitor_state_exception
	ldr	r3, =illegal_monitor_state_exception
	ldr.w	pc, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xf084

	ENDP

	EXPORT	shared_unlock_synchronized_method
shared_unlock_synchronized_method PROC
	; get object field of last lock
	ldr.w	r0, [r4, #-24]            ; 0xf854 0x0c18
	; get address of last lock
	sub.w	r1, r4, #48               ; 0xf1a4 0x0130
	; lock better be locked
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L224
L223
	; r0 contains the object that is being unlocked
	; r1 contains the stack lock

	; Get the real java near pointer from the stack lock
	ldr	r3, [r1, #4]              ; 0x684b
	; Zero out the object field so that lock is free
	movs	r2, #0                    ; 0x2200
	str	r2, [r1, #24]             ; 0x618a
	; Is this the reentrant case?
	cmp	r3, #0                    ; 0x2b00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	mov	pc, lr                    ; 0x46f7
	; Set the object near pointer
	str	r3, [r0]                  ; 0x6003
	cmp	r3, r0                    ; 0x4283
	DCW 0xbf3c ; ITT cc               ; 0xbf3c
	ldr	r2, [r1, #20]             ; 0x694a
	b	L225
	; oop_write_barrier
	ldr.w	r2, [r5, #268]; = heap_start  ; 0xf8d5 0x210c
	ldr.w	r3, [r5, #464]; = old_generation_end  ; 0xf8d5 0x31d0
	cmp	r0, r2                    ; 0x4290
	DCW 0xbf21 ; ITTTT cs             ; 0xbf21
	adds	r3, #1                    ; 0x3301
	cmp	r3, r0                    ; 0x4283
	ldr.w	r2, [r5, #292]; = bitvector_base  ; 0xf8d5 0x2124
	mov.w	r0, r0, lsr #2            ; 0xea4f 0x0090
	DCW 0xbf21 ; ITTTT cs             ; 0xbf21
	add.w	r2, r2, r0, lsr #3        ; 0xeb02 0x02d0
	ldrb.w	r3, [r2, #0]              ; 0xf892 0x3000
	mov.w	r10, #1                   ; 0xf04f 0x0a01
	and.w	r0, r0, #7                ; 0xf000 0x0007
	DCW 0xbf22 ; ITTT cs              ; 0xbf22
	lsl.w	r10, r10, r0              ; 0xfa0a 0xfa00
	orr.w	r3, r3, r10               ; 0xea43 0x030a
	strb.w	r3, [r2, #0]              ; 0xf882 0x3000
	ldr	r2, [r1, #20]             ; 0x694a
L225
	tst.w	r2, #2                    ; 0xf012 0x0f02
	DCW 0xbf08 ; IT eq                ; 0xbf08
	mov	pc, lr                    ; 0x46f7
	; Call the runtime system to signal the waiters
	IMPORT	signal_waiters
	ldr	r3, =signal_waiters
	ldr.w	pc, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xf084
	LTORG

	ENDP
	; End segment: Shared monitor exit


	; ------------------------------------------------------
	; Start segment: Invoke pending entries

	EXPORT	invoke_pending_entries
invoke_pending_entries PROC
	; Get current thread (may not have gp yet)
	ldr	r0, =_current_thread
	ldr	r0, [r0]                  ; 0x6800
	; Check if there's pending entries at all
	ldr	r1, [r0, #36]             ; 0x6a41
	cmp	r1, #0                    ; 0x2900
	DCW 0xbf08 ; IT eq                ; 0xbf08
	bx	lr                        ; 0x4770
	; Save permanent registers
	subs	r4, r4, r6                ; 0x1ba4
	str.w	r4, [r6, #-4]!            ; 0xf846 0x4d04
	str.w	r5, [r6, #-4]!            ; 0xf846 0x5d04
	str.w	r7, [r6, #-4]!            ; 0xf846 0x7d04
	str.w	r8, [r6, #-4]!            ; 0xf846 0x8d04
	str.w	r9, [r6, #-4]!            ; 0xf846 0x9d04
	str.w	r10, [r6, #-4]!           ; 0xf846 0xad04
	str.w	r11, [r6, #-4]!           ; 0xf846 0xbd04
	str.w	r12, [r6, #-4]!           ; 0xf846 0xcd04
	str.w	lr, [r6, #-4]!            ; 0xf846 0xed04
	; Invoke the pending entries
	movs	r2, #0                    ; 0x2200
	bl	shared_entry
	; Restore permanent registers, frame pointer and link register
	ldr.w	lr, [r6], #4              ; 0xf856 0xeb04
	ldr.w	r12, [r6], #4             ; 0xf856 0xcb04
	ldr.w	r11, [r6], #4             ; 0xf856 0xbb04
	ldr.w	r10, [r6], #4             ; 0xf856 0xab04
	ldr.w	r9, [r6], #4              ; 0xf856 0x9b04
	ldr.w	r8, [r6], #4              ; 0xf856 0x8b04
	ldr.w	r7, [r6], #4              ; 0xf856 0x7b04
	ldr.w	r5, [r6], #4              ; 0xf856 0x5b04
	ldr.w	r4, [r6], #4              ; 0xf856 0x4b04
	adds	r4, r4, r6                ; 0x19a4
	bx	lr                        ; 0x4770
	LTORG

	ENDP
	; End segment: Invoke pending entries


	; ------------------------------------------------------
	; Start segment: Call on primoridal stack

	EXPORT	call_on_primordial_stack
call_on_primordial_stack PROC
	; Get target method
	adds	r2, r0, #0                ; 0x1c02
	ldr.w	r1, [r5, #252]; = current_thread  ; 0xf8d5 0x10fc
	; Save return address and fp on java stack
	str.w	lr, [r6, #-4]!            ; 0xf846 0xed04
	str.w	r4, [r6, #-4]!            ; 0xf846 0x4d04
	str	r6, [r1, #100]            ; 0x664e
	; Call r2(THREAD)
	addw.w	r0, r5, #252              ; 0xf205 0x00fc ; slow add_gp_imm current_thread 252
	blx	r2                        ; 0x4790
	; When we return, we may be on a different thread
	ldr.w	r1, [r5, #252]; = current_thread  ; 0xf8d5 0x10fc
	ldr	r6, [r1, #100]            ; 0x6e4e
	ldr.w	lr, [r6, #4]              ; 0xf8d6 0xe004
	ldr.w	r4, [r6], #8              ; 0xf856 0x4b08
	mov	pc, lr                    ; 0x46f7
	LTORG

	ENDP
	; End segment: Call on primoridal stack


	; ------------------------------------------------------
	; Start segment: Brute force icache flushing

	EXPORT	linux_arm_flush_icache_unused
linux_arm_flush_icache_unused PROC
	adds	r1, r0, r1                ; 0x1841
	bic.w	r0, r0, #63               ; 0xf020 0x003f
	adds	r1, #63                   ; 0x313f
	bic.w	r1, r1, #63               ; 0xf021 0x013f
	cmp	r0, r1                    ; 0x4288
	DCW 0xbf28 ; IT cs                ; 0xbf28
	bx	lr                        ; 0x4770

	EXPORT	user_mode_flush
user_mode_flush
	mov	r3, pc                    ; 0x467b
	bx	r3                        ; 0x4718

	EXPORT	inlined_arm_flush_icache
inlined_arm_flush_icache
	DCW	0x2000
	DCW	0xe3a0
	DCW	0x0002
	DCW	0xef9f
	DCW	0xff1e
	DCW	0xe12f
L226
	mcr.w	p15, 0, r0, c7, c10, 1    ; 0xee07 0x0f3a ; clean data cache line
	mcr.w	p15, 0, r0, c7, c5, 1     ; 0xee07 0x0f35 ; invalidate instruction line cache
	adds	r0, #32                   ; 0x3020
	mcr.w	p15, 0, r0, c7, c14, 1    ; 0xee07 0x0f3e ; clean and invalidate data line cache
	mcr.w	p15, 0, r0, c7, c5, 1     ; 0xee07 0x0f35 ; invalidate instruction line cache
	adds	r0, #32                   ; 0x3020

	EXPORT	non_user_mode_flush
non_user_mode_flush
	cmp	r0, r1                    ; 0x4288
	DCW 0xbf38 ; IT cc                ; 0xbf38
	b	L226
	movs	r0, #0                    ; 0x2000
	mcr.w	p15, 0, r0, c7, c10, 4    ; 0xee07 0x0f9a ; drain write buffer
	mcr.w	p15, 0, r0, c7, c5, 6     ; 0xee07 0x0fd5 ; flush branch target cache
	; CPUWAIT
	mrc.w	p15, 0, r0, c2, c0, 0     ; 0xee12 0x0f10 ; wait until p15 completes operation
	adds	r0, r0, #0                ; 0x1c00
	bx	lr                        ; 0x4770
	LTORG

	ENDP
	; End segment: Brute force icache flushing


	THUMB
	AREA |.text|, CODE
	; ------------------------------------------------------
	; Start segment: Interpreter exception throwers

	EXPORT	interpreter_throw_ArrayIndexOutOfBoundsException
interpreter_throw_ArrayIndexOutOfBoundsException PROC
	IMPORT	array_index_out_of_bounds_exception
	ldr	r3, =array_index_out_of_bounds_exception
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm

	ENDP

	EXPORT	interpreter_throw_NullPointerException_tos_cached
interpreter_throw_NullPointerException_tos_cached PROC
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04

	ENDP

	EXPORT	interpreter_throw_NullPointerException
interpreter_throw_NullPointerException PROC
	IMPORT	null_pointer_exception
	ldr	r3, =null_pointer_exception
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm

	ENDP

	EXPORT	interpreter_throw_IncompatibleClassChangeError
interpreter_throw_IncompatibleClassChangeError PROC
	IMPORT	incompatible_class_change_error
	ldr	r3, =incompatible_class_change_error
	; save interpreter state
	str.w	lr, [r4, #-16]            ; 0xf844 0xec10
	bl	interpreter_call_vm
	LTORG

	ENDP
	; End segment: Interpreter exception throwers


	; ------------------------------------------------------
	; Start segment: Interpreter deoptimization entry

	EXPORT	interpreter_deoptimization_entry
interpreter_deoptimization_entry
	; restore interpreter state
	ldr.w	r8, [r4, #-12]            ; 0xf854 0x8c0c ; restore locals
	ldr.w	r9, [r4, #-8]             ; 0xf854 0x9c08 ; restore cpool
	ldr.w	lr, [r4, #-16]            ; 0xf854 0xec10 ; restore bcp
	ldrb.w	r7, [lr, #0]!             ; 0xf81e 0x7f00 ; prefetch next bytecode
	; dispatch
	sub.w	r7, r5, r7, lsl #2        ; 0xeba5 0x0787 ; get implementation of bytecode
	ldr	r7, [r7]                  ; 0x683f
	; Restore stack state from tos_on_stack
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04 ; cache topmost element of stack
	mov	pc, r7                    ; 0x46bf ; go to next bytecode
	LTORG
	; End segment: Interpreter deoptimization entry


	; ------------------------------------------------------
	; Start segment: Primordial to current thread

	EXPORT	primordial_to_current_thread
primordial_to_current_thread PROC
	; save permanent registers (including return address)
	stmdb.w	sp!, {r3 - r7}            ; 0xe92d 0x0ff8
	str.w	lr, [sp, #-4]!            ; 0xf84d 0xed04
	; Set up global pointer
	ldr	r5, =gp_base_label
	IMPORT	persistent_handles
	ldr	r3, =persistent_handles
	str.w	r3, [r5, #1008]           ; 0xf8c5 0x33f0
	; Get current thread
	ldr.w	r1, [r5, #252]; = current_thread  ; 0xf8d5 0x10fc
	; Save primordial stack pointer
	mov	r3, sp                    ; 0x466b
	str.w	r3, [r5, #460]            ; 0xf8c5 0x31cc
	; Get new stack pointer
	ldr	r6, [r1, #100]            ; 0x6e4e
	; Go to code
	ldr.w	lr, [r6, #4]              ; 0xf8d6 0xe004
	ldr.w	r4, [r6], #8              ; 0xf856 0x4b08
	bx	lr                        ; 0x4770

	ENDP

	EXPORT	start_lightweight_thread_asm
start_lightweight_thread_asm PROC
	; Set up global pointer
	ldr	r5, =gp_base_label
	; Invoke pending entries unless the thread is being terminated
	ldr.w	r0, [r5, #252]; = current_thread  ; 0xf8d5 0x00fc
	; r1 = THREAD->status();
	ldr	r1, [r0, #104]            ; 0x6e81
	movs	r2, #0                    ; 0x2200
	; if ((r1 & THREAD_TERMINATING) != 0) {
	tst.w	r1, #1073741824           ; 0xf011 0x4f80
	;   THREAD->pending_entries = NULL;
	DCW 0xbf14 ; ITE ne               ; 0xbf14
	str	r2, [r0, #36]             ; 0x6242
	; } else {
	;   invoke_pending_entries(THREAD)
	bl	invoke_pending_entries
	; }
	; if (!TestCompiler) {
	ldr	r0, [r6, #16]             ; 0x6930
	ldr.w	r1, [r5, #256]; = current_pending_exception  ; 0xf8d5 0x1100
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L227
	;   if (Thread::current_has_pending_exception()) {
	;     call_on_primordial_stack(lightweight_thread_uncaught_exception);
	;   }
	cmp	r1, #0                    ; 0x2900
	DCW 0xbf1c ; ITT ne               ; 0xbf1c
	ldr	r0, [r6, #4]              ; 0x6870
	bl	call_on_primordial_stack
	;   call_on_primordial_stack(finish);
	ldr	r0, [r6, #8]              ; 0x68b0
	bl	call_on_primordial_stack
	;   invoke_pending_entries(THREAD);
	ldr.w	r0, [r5, #252]; = current_thread  ; 0xf8d5 0x00fc
	bl	invoke_pending_entries
	;   force_terminated()
	ldr	r0, [r6, #12]             ; 0x68f0
	bl	call_on_primordial_stack
	; }
	; Terminate the task if no other threads on it
	IMPORT	thread_task_cleanup
	ldr	r0, =thread_task_cleanup
	bl	call_on_primordial_stack
	;   invoke_pending_entries(THREAD);
	ldr.w	r0, [r5, #252]; = current_thread  ; 0xf8d5 0x00fc
	bl	invoke_pending_entries

	ENDP
L227 PROC
	; call_on_primordial_stack(lightweight_thread_exit);
	ldr	r0, [r6]                  ; 0x6830
	bl	call_on_primordial_stack
	; GUARANTEE(Scheduler::_next_runnable_thread == NULL
	IMPORT	_next_runnable_thread
	ldr	r0, =_next_runnable_thread
	ldr	r0, [r0]                  ; 0x6800
	cmp	r0, #0                    ; 0x2800
	DCW 0xbf18 ; IT ne                ; 0xbf18
	svc	#0x0000ff                  ; 0xdfff
	; current_thread_to_primordial();
	bl	current_thread_to_primordial_fast
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
	ldr.w	r3, [r5, #460]; = primordial_sp  ; 0xf8d5 0x31cc
	mov	sp, r3                    ; 0x469d
	; restore permanent registers (including return address)
	ldr.w	lr, [sp], #4              ; 0xf85d 0xeb04
	ldmia.w	sp!, {r3 - r7}            ; 0xe8bd 0x0ff8
	bx	lr                        ; 0x4770
	LTORG

	ENDP
	; End segment: Current thread to primordial


	THUMB
	AREA |.text|, CODE
	; ------------------------------------------------------
	; Start segment: Compiler new object

	EXPORT	compiler_new_object
compiler_new_object PROC
	; r0 contains the klass of the object
	mov	r12, r0                   ; 0x4684
	; Get size
	ldrsh.w	r2, [r12, #6]             ; 0xf9bc 0x2006
	; Get allocation start and end
	ldr.w	r0, [r5, #276]; = inline_allocation_top  ; 0xf8d5 0x0114
	ldr.w	r3, [r5, #280]; = inline_allocation_end  ; 0xf8d5 0x3118
	; Get prototypical near
	ldr.w	r11, [r12, #12]           ; 0xf8dc 0xb00c
	; Compute new allocation start
	add.w	r10, r0, r2               ; 0xeb00 0x0a02
	; Compare against _inline_allocation_end
	cmp	r10, r3                   ; 0x459a
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L228
	; Allocation succeeded.
	; Set _inline_allocation_top and prototypical near
	str.w	r10, [r5, #276]           ; 0xf8c5 0xa114
	str.w	r11, [r0, #0]             ; 0xf8c0 0xb000
	; Zero object fields
	add.w	r3, r0, #4                ; 0xf100 0x0304
	sub.w	r10, r10, r10             ; 0xebaa 0x0a0a
	subs	r2, #8                    ; 0x3a08
L229
	; r3 = the next word to zero
	; r10 = 0
	; r2 = the_number_of_bytes_still_to_zero - 4
	; condition codes reflect the (signed) value in r2
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	str.w	r10, [r3], #4             ; 0xf843 0xab04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r10, [r3], #4             ; 0xf843 0xab04
	subs	r2, #8                    ; 0x3a08
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L229
	; The newly allocated object is in register r0
	; Don't use BX here. We always return to thumb code.
	; bit-0 of lr is not set
	mov	pc, lr                    ; 0x46f7
	; Slow case - call the VM runtime system
L228
	IMPORT	_newobject
	ldr	r3, =_newobject
	mov	r1, r12                   ; 0x4661
	ldr.w	pc, [r5, #124]; = shared_call_vm_oop  ; 0xf8d5 0xf07c
	LTORG

	ENDP
	; End segment: Compiler new object


	; ------------------------------------------------------
	; Start segment: Compiler new obj array

	EXPORT	compiler_new_obj_array
compiler_new_obj_array PROC
	; r0 contains the prototypical near of the object
	; r1 contains the array length
	; Get array length
	mov	r10, r0                   ; 0x4682
	; Get _inline_allocation_top, _inline_allocation_end
	ldr.w	r0, [r5, #276]; = inline_allocation_top  ; 0xf8d5 0x0114
	ldr.w	r2, [r5, #280]; = inline_allocation_end  ; 0xf8d5 0x2118
	; Check for array lengths larger than maximum safe array length or below zero
	movw.w	r11, #0                   ; 0xf240 0x0b00
	movt.w	r11, #16                  ; 0xf2c0 0x0b10
	cmp	r1, r11                   ; 0x4559
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L230
	; Compute new top
	add.w	r3, r0, #8                ; 0xf100 0x0308
	adds.w	r3, r3, r1, lsl #2        ; 0xeb13 0x0381
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L230
	; Compare against _inline_allocation_end
	cmp	r3, r2                    ; 0x4293
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L230
	; Allocation succeeded
	; set _inline_allocation_top
	str.w	r3, [r5, #276]            ; 0xf8c5 0x3114
	; Set the prototypical near and length
	str.w	r10, [r0, #0]             ; 0xf8c0 0xa000
	str	r1, [r0, #4]              ; 0x6041
	; Zero array elements
	add.w	r2, r0, #8                ; 0xf100 0x0208
	subs	r3, r3, r3                ; 0x1adb
	subs	r1, #1                    ; 0x3901
L231
	; r2 = the next word to zero
	; r3 = 0
	; r1 = the_number_of_words_still_to_zero - 1
	; condition codes reflect the (signed) value in r1
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	str.w	r3, [r2], #4              ; 0xf842 0x3b04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r3, [r2], #4              ; 0xf842 0x3b04
	subs	r1, #2                    ; 0x3902
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L231
	; The newly allocated array is in register r0
	mov	pc, lr                    ; 0x46f7
L230
	; Slow case - call the VM runtime system
	; _anewarray(THREAD, raw_base_klass, length)
	adds	r2, r1, #0                ; 0x1c0a
	ldr.w	r1, [r10, #0]             ; 0xf8da 0x1000
	IMPORT	_anewarray
	ldr	r3, =_anewarray
	ldr	r1, [r1, #36]             ; 0x6a49
	ldr.w	pc, [r5, #124]; = shared_call_vm_oop  ; 0xf8d5 0xf07c
	LTORG

	ENDP
	; End segment: Compiler new obj array


	; ------------------------------------------------------
	; Start segment: Compiler new type array

	EXPORT	compiler_new_type_array
compiler_new_type_array PROC
	; Move argument out of the way
	mov	r11, r0                   ; 0x4683
	; Get _inline_allocation_top, _inline_allocation_end
	ldr.w	r0, [r5, #276]; = inline_allocation_top  ; 0xf8d5 0x0114
	ldr.w	r3, [r5, #280]; = inline_allocation_end  ; 0xf8d5 0x3118
	; Check for array lengths larger than maximum safe array length or below zero
	cmp.w	r1, #1048576              ; 0xf5b1 0x1f80
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L232
	; Compute new top and check for overflow
	adds.w	r10, r0, r2               ; 0xeb10 0x0a02
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L232
	; Compare against _inline_allocation_end
	cmp	r10, r3                   ; 0x459a
	DCW 0xbf88 ; IT hi                ; 0xbf88
	b	L232
	str.w	r10, [r5, #276]           ; 0xf8c5 0xa114
	; Set prototypical near and length
	str.w	r11, [r0, #0]             ; 0xf8c0 0xb000
	str	r1, [r0, #4]              ; 0x6041
	; Zero typed array fields
	add.w	r3, r0, #8                ; 0xf100 0x0308
	sub.w	r10, r10, r10             ; 0xebaa 0x0a0a
	subs	r2, #12                   ; 0x3a0c
L233
	; r3 = the next word to zero
	; r10 = 0
	; r2 = the_number_of_bytes_still_to_zero - 4
	; condition codes reflect the (signed) value in r2
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	str.w	r10, [r3], #4             ; 0xf843 0xab04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r10, [r3], #4             ; 0xf843 0xab04
	subs	r2, #8                    ; 0x3a08
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L233
	mov	pc, lr                    ; 0x46f7
	; Slow case - call the VM runtime system
L232
	ldr.w	r11, [r11, #0]            ; 0xf8db 0xb000
	adds	r2, r1, #0                ; 0x1c0a
	ldr.w	r11, [r11, #16]           ; 0xf8db 0xb010
	IMPORT	_newarray
	ldr	r3, =_newarray
	ldr.w	r1, [r11, #20]            ; 0xf8db 0x1014
	ldr.w	pc, [r5, #124]; = shared_call_vm_oop  ; 0xf8d5 0xf07c
	LTORG

	ENDP
	; End segment: Compiler new type array


	; ------------------------------------------------------
	; Start segment: Compiler exceptions

	EXPORT	compiler_throw_NullPointerException
compiler_throw_NullPointerException PROC
	; r0 = method->max_locals()
	; Restore caller return address
	ldr.w	lr, [r4, #-20]            ; 0xf854 0xec14
	movs	r1, #8                    ; 0x2108
	add.w	r0, r1, r0, lsl #2        ; 0xeb01 0x0080
	adds	r6, r4, #0                ; 0x1c26
	ldr	r4, [r6]                  ; 0x6834
	adds	r6, r6, r0                ; 0x1836
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 232
	ldr	r0, [r0]                  ; 0x6800
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088
	; method->max_locals() = 0

	ENDP

	EXPORT	compiler_throw_NullPointerException_0
compiler_throw_NullPointerException_0 PROC
	movs	r0, #0                    ; 0x2000
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 1

	ENDP

	EXPORT	compiler_throw_NullPointerException_1
compiler_throw_NullPointerException_1 PROC
	movs	r0, #1                    ; 0x2001
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 2

	ENDP

	EXPORT	compiler_throw_NullPointerException_2
compiler_throw_NullPointerException_2 PROC
	movs	r0, #2                    ; 0x2002
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 3

	ENDP

	EXPORT	compiler_throw_NullPointerException_3
compiler_throw_NullPointerException_3 PROC
	movs	r0, #3                    ; 0x2003
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 4

	ENDP

	EXPORT	compiler_throw_NullPointerException_4
compiler_throw_NullPointerException_4 PROC
	movs	r0, #4                    ; 0x2004
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 5

	ENDP

	EXPORT	compiler_throw_NullPointerException_5
compiler_throw_NullPointerException_5 PROC
	movs	r0, #5                    ; 0x2005
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 6

	ENDP

	EXPORT	compiler_throw_NullPointerException_6
compiler_throw_NullPointerException_6 PROC
	movs	r0, #6                    ; 0x2006
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 7

	ENDP

	EXPORT	compiler_throw_NullPointerException_7
compiler_throw_NullPointerException_7 PROC
	movs	r0, #7                    ; 0x2007
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 8

	ENDP

	EXPORT	compiler_throw_NullPointerException_8
compiler_throw_NullPointerException_8 PROC
	movs	r0, #8                    ; 0x2008
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c
	; method->max_locals() = 9

	ENDP

	EXPORT	compiler_throw_NullPointerException_9
compiler_throw_NullPointerException_9 PROC
	movs	r0, #9                    ; 0x2009
	ldr.w	pc, [r5, #156]; = compiler_throw_NullPointerException  ; 0xf8d5 0xf09c

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException
compiler_throw_ArrayIndexOutOfBoundsException PROC
	; r0 = method->max_locals()
	; Restore caller return address
	ldr.w	lr, [r4, #-20]            ; 0xf854 0xec14
	movs	r1, #8                    ; 0x2108
	add.w	r0, r1, r0, lsl #2        ; 0xeb01 0x0080
	adds	r6, r4, #0                ; 0x1c26
	ldr	r4, [r6]                  ; 0x6834
	adds	r6, r6, r0                ; 0x1836
	IMPORT	persistent_handles
	ldr	r0, =persistent_handles + 236
	ldr	r0, [r0]                  ; 0x6800
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088
	; method->max_locals() = 0

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_0
compiler_throw_ArrayIndexOutOfBoundsException_0 PROC
	movs	r0, #0                    ; 0x2000
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 1

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_1
compiler_throw_ArrayIndexOutOfBoundsException_1 PROC
	movs	r0, #1                    ; 0x2001
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 2

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_2
compiler_throw_ArrayIndexOutOfBoundsException_2 PROC
	movs	r0, #2                    ; 0x2002
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 3

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_3
compiler_throw_ArrayIndexOutOfBoundsException_3 PROC
	movs	r0, #3                    ; 0x2003
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 4

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_4
compiler_throw_ArrayIndexOutOfBoundsException_4 PROC
	movs	r0, #4                    ; 0x2004
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 5

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_5
compiler_throw_ArrayIndexOutOfBoundsException_5 PROC
	movs	r0, #5                    ; 0x2005
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 6

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_6
compiler_throw_ArrayIndexOutOfBoundsException_6 PROC
	movs	r0, #6                    ; 0x2006
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 7

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_7
compiler_throw_ArrayIndexOutOfBoundsException_7 PROC
	movs	r0, #7                    ; 0x2007
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 8

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_8
compiler_throw_ArrayIndexOutOfBoundsException_8 PROC
	movs	r0, #8                    ; 0x2008
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	; method->max_locals() = 9

	ENDP

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_9
compiler_throw_ArrayIndexOutOfBoundsException_9 PROC
	movs	r0, #9                    ; 0x2009
	ldr.w	pc, [r5, #204]; = compiler_throw_ArrayIndexOutOfBoundsException  ; 0xf8d5 0xf0cc
	LTORG

	ENDP
	; End segment: Compiler exceptions


	; ------------------------------------------------------
	; Start segment: Compiler timer tick

	EXPORT	compiler_timer_tick
compiler_timer_tick PROC
	IMPORT	timer_tick
	ldr	r3, =timer_tick
	ldr.w	pc, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xf084
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
	ldr	r3, [r6]                  ; 0x6833 ; r3 = object
	ldr.w	r10, [r5, #412]; = class_list_base  ; 0xf8d5 0xa19c
	ldr	r3, [r3]                  ; 0x681b ; r3 = near
	ldr.w	r2, [r10, r2, lsl #2]     ; 0xf85a 0x2022 ; r2 = target_class
	ldr	r3, [r3]                  ; 0x681b ; r3 = class
	mov	r10, r3                   ; 0x469a ; r10 = class (copy)
L234
	cmp	r3, r2                    ; 0x4293
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L235
	ldr	r3, [r3, #32]             ; 0x6a1b ; r3 = class.super
	cmp	r3, #0                    ; 0x2b00
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L234
	IMPORT	checkcast
	ldr	r3, =checkcast
	ldr.w	pc, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xf084
L235
	ldr.w	r3, [r10, #20]            ; 0xf8da 0x3014 ; r3 = class.subtype_cache_1
	str.w	r2, [r10, #20]            ; 0xf8ca 0x2014 ; class.subtype_cache_1 = target_class (r2)
	str.w	r3, [r10, #24]            ; 0xf8ca 0x3018 ; class.subtype_cache_2 = old class.subtype_cache_1
	; no need for write barrier if we're pointing to a lower address
	cmp	r3, r10                   ; 0x4553
	DCW 0xbf38 ; IT cc                ; 0xbf38
	cmp	r2, r10                   ; 0x4552
	DCW 0xbf38 ; IT cc                ; 0xbf38 ; return if r3 < r10 && r2 < r10
	mov	pc, lr                    ; 0x46f7
	add.w	r7, r10, #20              ; 0xf10a 0x0714
	; oop_write_barrier
	ldr.w	r2, [r5, #268]; = heap_start  ; 0xf8d5 0x210c
	ldr.w	r3, [r5, #464]; = old_generation_end  ; 0xf8d5 0x31d0
	cmp	r7, r2                    ; 0x4297
	DCW 0xbf21 ; ITTTT cs             ; 0xbf21
	adds	r3, #1                    ; 0x3301
	cmp	r3, r7                    ; 0x42bb
	ldr.w	r2, [r5, #292]; = bitvector_base  ; 0xf8d5 0x2124
	mov.w	r7, r7, lsr #2            ; 0xea4f 0x0797
	DCW 0xbf21 ; ITTTT cs             ; 0xbf21
	add.w	r2, r2, r7, lsr #3        ; 0xeb02 0x02d7
	ldrb.w	r3, [r2, #0]              ; 0xf892 0x3000
	mov.w	r11, #1                   ; 0xf04f 0x0b01
	and.w	r7, r7, #7                ; 0xf007 0x0707
	DCW 0xbf22 ; ITTT cs              ; 0xbf22
	lsl.w	r11, r11, r7              ; 0xfa0b 0xfb07
	orr.w	r3, r3, r11               ; 0xea43 0x030b
	strb.w	r3, [r2, #0]              ; 0xf882 0x3000
	add.w	r7, r10, #24              ; 0xf10a 0x0718
	; oop_write_barrier
	ldr.w	r2, [r5, #268]; = heap_start  ; 0xf8d5 0x210c
	ldr.w	r3, [r5, #464]; = old_generation_end  ; 0xf8d5 0x31d0
	cmp	r7, r2                    ; 0x4297
	DCW 0xbf21 ; ITTTT cs             ; 0xbf21
	adds	r3, #1                    ; 0x3301
	cmp	r3, r7                    ; 0x42bb
	ldr.w	r2, [r5, #292]; = bitvector_base  ; 0xf8d5 0x2124
	mov.w	r7, r7, lsr #2            ; 0xea4f 0x0797
	DCW 0xbf21 ; ITTTT cs             ; 0xbf21
	add.w	r2, r2, r7, lsr #3        ; 0xeb02 0x02d7
	ldrb.w	r3, [r2, #0]              ; 0xf892 0x3000
	mov.w	r11, #1                   ; 0xf04f 0x0b01
	and.w	r7, r7, #7                ; 0xf007 0x0707
	DCW 0xbf22 ; ITTT cs              ; 0xbf22
	lsl.w	r11, r11, r7              ; 0xfa0b 0xfb07
	orr.w	r3, r3, r11               ; 0xea43 0x030b
	strb.w	r3, [r2, #0]              ; 0xf882 0x3000
	mov	pc, lr                    ; 0x46f7
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
	ldr	r1, [r6]                  ; 0x6831 ; r1 = object
	ldr.w	r2, [r5, #412]; = class_list_base  ; 0xf8d5 0x219c
	ldr	r1, [r1]                  ; 0x6809 ; r1 = near
	ldr.w	r2, [r2, r0, lsl #2]      ; 0xf852 0x2020 ; r2 = target_class
	ldr	r1, [r1]                  ; 0x6809 ; r1 = object_class
	IMPORT	_instanceof
	ldr	r3, =_instanceof
	ldr.w	pc, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xf084
	LTORG

	ENDP
	; End segment: Compiler instanceof


	; ------------------------------------------------------
	; Start segment: Compiler idiv irem

	EXPORT	interpreter_idiv_irem
interpreter_idiv_irem PROC
	; load one argument
	adds	r1, r0, #0                ; 0x1c01
	; load other argument
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	; Register r0 holds the dividend, r1 the divisor

	ENDP

	EXPORT	compiler_idiv_irem
compiler_idiv_irem PROC
	; Copy Divisor to another register and free r1
	; This instruction also resets V flag, which is used below by BLE
	adds	r2, r1, #0                ; 0x1c0a
	; Check for special cases: Dividend < 0 or Divisor <= 0
	orrs.w	r3, r2, r0, asr #32       ; 0xea52 0x0320
	DCW 0xbfd8 ; IT le                ; 0xbfd8
	b	L271
L270
	; Approximate the mamximum order of the Quotient
	clz.w	r3, r0                    ; 0xfab0 0xf380
	clz.w	r1, r2                    ; 0xfab2 0xf182
	subs	r3, r1, r3                ; 0x1acb
	mov.w	r1, #0                    ; 0xf04f 0x0100
	; If Divisor is greater than Dividend, return immediately
	DCW 0xbf48 ; IT mi                ; 0xbf48
	bx	lr                        ; 0x4770
	; Jump to the appropriate place in the unrolled loop below
	tbh.w	[pc, r3, lsl #1]          ; 0xe8df 0xf013
	; Offset table
	DCW	0xf9
	DCW	0xf2
	DCW	0xeb
	DCW	0xe4
	DCW	0xdd
	DCW	0xd6
	DCW	0xcf
	DCW	0xc8
	DCW	0xc1
	DCW	0xba
	DCW	0xb3
	DCW	0xac
	DCW	0xa5
	DCW	0x9e
	DCW	0x97
	DCW	0x90
	DCW	0x89
	DCW	0x82
	DCW	0x7b
	DCW	0x74
	DCW	0x6d
	DCW	0x66
	DCW	0x5f
	DCW	0x58
	DCW	0x51
	DCW	0x4a
	DCW	0x43
	DCW	0x3c
	DCW	0x35
	DCW	0x2e
	DCW	0x27
	DCW	0x20
	; Unrolled loop of 32 division steps
L267
	cmp.w	r0, r2, lsl #31           ; 0xebb0 0x7fc2
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #31       ; 0xeba0 0x70c2
	sub.w	r1, r1, #-2147483648      ; 0xf1a1 0x4100
L266
	cmp.w	r0, r2, lsl #30           ; 0xebb0 0x7f82
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #30       ; 0xeba0 0x7082
	add.w	r1, r1, #1073741824       ; 0xf101 0x4180
L265
	cmp.w	r0, r2, lsl #29           ; 0xebb0 0x7f42
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #29       ; 0xeba0 0x7042
	add.w	r1, r1, #536870912        ; 0xf101 0x5100
L264
	cmp.w	r0, r2, lsl #28           ; 0xebb0 0x7f02
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #28       ; 0xeba0 0x7002
	add.w	r1, r1, #268435456        ; 0xf101 0x5180
L263
	cmp.w	r0, r2, lsl #27           ; 0xebb0 0x6fc2
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #27       ; 0xeba0 0x60c2
	add.w	r1, r1, #134217728        ; 0xf101 0x6100
L262
	cmp.w	r0, r2, lsl #26           ; 0xebb0 0x6f82
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #26       ; 0xeba0 0x6082
	add.w	r1, r1, #67108864         ; 0xf101 0x6180
L261
	cmp.w	r0, r2, lsl #25           ; 0xebb0 0x6f42
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #25       ; 0xeba0 0x6042
	add.w	r1, r1, #33554432         ; 0xf101 0x7100
L260
	cmp.w	r0, r2, lsl #24           ; 0xebb0 0x6f02
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #24       ; 0xeba0 0x6002
	add.w	r1, r1, #16777216         ; 0xf101 0x7180
L259
	cmp.w	r0, r2, lsl #23           ; 0xebb0 0x5fc2
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #23       ; 0xeba0 0x50c2
	add.w	r1, r1, #8388608          ; 0xf501 0x0100
L258
	cmp.w	r0, r2, lsl #22           ; 0xebb0 0x5f82
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #22       ; 0xeba0 0x5082
	add.w	r1, r1, #4194304          ; 0xf501 0x0180
L257
	cmp.w	r0, r2, lsl #21           ; 0xebb0 0x5f42
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #21       ; 0xeba0 0x5042
	add.w	r1, r1, #2097152          ; 0xf501 0x1100
L256
	cmp.w	r0, r2, lsl #20           ; 0xebb0 0x5f02
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #20       ; 0xeba0 0x5002
	add.w	r1, r1, #1048576          ; 0xf501 0x1180
L255
	cmp.w	r0, r2, lsl #19           ; 0xebb0 0x4fc2
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #19       ; 0xeba0 0x40c2
	add.w	r1, r1, #524288           ; 0xf501 0x2100
L254
	cmp.w	r0, r2, lsl #18           ; 0xebb0 0x4f82
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #18       ; 0xeba0 0x4082
	add.w	r1, r1, #262144           ; 0xf501 0x2180
L253
	cmp.w	r0, r2, lsl #17           ; 0xebb0 0x4f42
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #17       ; 0xeba0 0x4042
	add.w	r1, r1, #131072           ; 0xf501 0x3100
L252
	cmp.w	r0, r2, lsl #16           ; 0xebb0 0x4f02
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #16       ; 0xeba0 0x4002
	add.w	r1, r1, #65536            ; 0xf501 0x3180
L251
	cmp.w	r0, r2, lsl #15           ; 0xebb0 0x3fc2
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #15       ; 0xeba0 0x30c2
	add.w	r1, r1, #32768            ; 0xf501 0x4100
L250
	cmp.w	r0, r2, lsl #14           ; 0xebb0 0x3f82
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #14       ; 0xeba0 0x3082
	add.w	r1, r1, #16384            ; 0xf501 0x4180
L249
	cmp.w	r0, r2, lsl #13           ; 0xebb0 0x3f42
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #13       ; 0xeba0 0x3042
	add.w	r1, r1, #8192             ; 0xf501 0x5100
L248
	cmp.w	r0, r2, lsl #12           ; 0xebb0 0x3f02
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #12       ; 0xeba0 0x3002
	add.w	r1, r1, #4096             ; 0xf501 0x5180
L247
	cmp.w	r0, r2, lsl #11           ; 0xebb0 0x2fc2
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #11       ; 0xeba0 0x20c2
	add.w	r1, r1, #2048             ; 0xf501 0x6100
L246
	cmp.w	r0, r2, lsl #10           ; 0xebb0 0x2f82
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #10       ; 0xeba0 0x2082
	add.w	r1, r1, #1024             ; 0xf501 0x6180
L245
	cmp.w	r0, r2, lsl #9            ; 0xebb0 0x2f42
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #9        ; 0xeba0 0x2042
	add.w	r1, r1, #512              ; 0xf501 0x7100
L244
	cmp.w	r0, r2, lsl #8            ; 0xebb0 0x2f02
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #8        ; 0xeba0 0x2002
	add.w	r1, r1, #256              ; 0xf501 0x7180
L243
	cmp.w	r0, r2, lsl #7            ; 0xebb0 0x1fc2
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #7        ; 0xeba0 0x10c2
	add.w	r1, r1, #128              ; 0xf101 0x0180
L242
	cmp.w	r0, r2, lsl #6            ; 0xebb0 0x1f82
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #6        ; 0xeba0 0x1082
	add.w	r1, r1, #64               ; 0xf101 0x0140
L241
	cmp.w	r0, r2, lsl #5            ; 0xebb0 0x1f42
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #5        ; 0xeba0 0x1042
	add.w	r1, r1, #32               ; 0xf101 0x0120
L240
	cmp.w	r0, r2, lsl #4            ; 0xebb0 0x1f02
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #4        ; 0xeba0 0x1002
	add.w	r1, r1, #16               ; 0xf101 0x0110
L239
	cmp.w	r0, r2, lsl #3            ; 0xebb0 0x0fc2
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #3        ; 0xeba0 0x00c2
	add.w	r1, r1, #8                ; 0xf101 0x0108
L238
	cmp.w	r0, r2, lsl #2            ; 0xebb0 0x0f82
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #2        ; 0xeba0 0x0082
	add.w	r1, r1, #4                ; 0xf101 0x0104
L237
	cmp.w	r0, r2, lsl #1            ; 0xebb0 0x0f42
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2, lsl #1        ; 0xeba0 0x0042
	add.w	r1, r1, #2                ; 0xf101 0x0102
L236
	cmp.w	r0, r2                    ; 0xebb0 0x0f02
	DCW 0xbf24 ; ITT cs               ; 0xbf24
	sub.w	r0, r0, r2                ; 0xeba0 0x0002
	add.w	r1, r1, #1                ; 0xf101 0x0101
	bx	lr                        ; 0x4770
L271
	cmp	r2, #0                    ; 0x2a00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L268
	mov	r12, lr                   ; 0x46f4
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	b	L272
	negs	r2, r2                    ; 0x4252
	cmp	r0, #0                    ; 0x2800
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	b	L273
	bl	L270
	; Divisor < 0 return point
	negs	r1, r1                    ; 0x4249
	bx	r12                       ; 0x4760
L272
	negs	r0, r0                    ; 0x4240
	bl	L270
	; Dividend < 0 return point
	negs	r0, r0                    ; 0x4240
	negs	r1, r1                    ; 0x4249
	bx	r12                       ; 0x4760
L273
	negs	r0, r0                    ; 0x4240
	bl	L270
	; Divisor < 0 && Dividend < 0 return point
	negs	r0, r0                    ; 0x4240
	bx	r12                       ; 0x4760
L268
	; We must check here if we were called from interpreter
	ldr	r2, =called_from_bc_idiv
	ldr	r3, =called_from_bc_irem
	cmp	lr, r2                    ; 0x4596
	DCW 0xbf18 ; IT ne                ; 0xbf18
	cmp	lr, r3                    ; 0x459e
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L269
	; Put the arguments back on the stack
	; Exit: Count = 2
	str.w	r2, [r6, #-4]!            ; 0xf846 0x2d04
	str.w	r10, [r4, #-16]           ; 0xf844 0xac10 ; store bcp in frame
	; Change state to tos_on_stack
	str.w	r0, [r6, #-4]!            ; 0xf846 0x0d04 ; uncache topmost element of stack
	; Fall through to compiler code
L269
	; Division by zero from the compiler
	IMPORT	division_by_zero_exception
	ldr	r3, =division_by_zero_exception
	ldr.w	pc, [r5, #132]; = shared_call_vm  ; 0xf8d5 0xf084
	LTORG

	ENDP
	; End segment: Compiler idiv irem


	THUMB
	AREA |.text|, CODE
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
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	mov	r7, lr                    ; 0x4677
	bl	jvm_sin
	bx	r7                        ; 0x4738

	ENDP

	EXPORT	native_math_cos_entry
native_math_cos_entry PROC
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	mov	r7, lr                    ; 0x4677
	bl	jvm_cos
	bx	r7                        ; 0x4738

	ENDP

	EXPORT	native_math_tan_entry
native_math_tan_entry PROC
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	mov	r7, lr                    ; 0x4677
	bl	jvm_tan
	bx	r7                        ; 0x4738

	ENDP

	EXPORT	native_math_sqrt_entry
native_math_sqrt_entry PROC
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	mov	r7, lr                    ; 0x4677
	bl	jvm_sqrt
	bx	r7                        ; 0x4738

	ENDP

	EXPORT	native_math_ceil_entry
native_math_ceil_entry PROC
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	mov	r7, lr                    ; 0x4677
	bl	jvm_ceil
	bx	r7                        ; 0x4738

	ENDP

	EXPORT	native_math_floor_entry
native_math_floor_entry PROC
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	ldr.w	r1, [r6], #4              ; 0xf856 0x1b04
	mov	r7, lr                    ; 0x4677
	bl	jvm_floor
	bx	r7                        ; 0x4738
	LTORG

	ENDP
	; End segment: Native entry points for math functions


	; ------------------------------------------------------
	; Start segment: Native entry points for string functions

	EXPORT	native_string_charAt_entry
native_string_charAt_entry PROC
	; r2 = string
	ldr	r2, [r6, #4]              ; 0x6872
	; r3 = index
	ldr	r3, [r6]                  ; 0x6833
	; r10 = count
	ldr.w	r10, [r2, #12]            ; 0xf8d2 0xa00c
	; r11 = array
	ldr.w	r11, [r2, #4]             ; 0xf8d2 0xb004
	; r12 = offset
	ldr.w	r12, [r2, #8]             ; 0xf8d2 0xc008
	; if ((unsigned int) index >= (unsigned int) count) goto bailout;
	cmp	r3, r10                   ; 0x4553
	DCW 0xbf28 ; IT cs                ; 0xbf28
	b	L274
	; return: r0 = array[index + offset]
	add.w	r3, r3, r12               ; 0xeb03 0x030c
	add.w	r11, r11, r3, lsl #1      ; 0xeb0b 0x0b43
	ldrh.w	r0, [r11, #8]             ; 0xf8bb 0x0008
	; remove arguments from the stack
	add.w	r6, r6, #8                ; 0xf106 0x0608
	mov	pc, lr                    ; 0x46f7
L274
	; Bail out to the general startsWith implementation
	ldr.w	r10, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xa088
	mov	pc, r10                   ; 0x46d7

	ENDP

	EXPORT	native_string_init_entry
native_string_init_entry PROC
	; Bail out to the general implementation
	ldr.w	r10, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xa088
	mov	pc, r10                   ; 0x46d7

	ENDP

	EXPORT	native_string_equals_entry
native_string_equals_entry PROC
	; Bail out to the general implementation
	ldr.w	r10, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xa088
	mov	pc, r10                   ; 0x46d7

	ENDP

	EXPORT	native_string_indexof0_string_entry
native_string_indexof0_string_entry PROC
	; Bail out to the general indexOf implementation
	ldr.w	r10, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xa088
	mov	pc, r10                   ; 0x46d7

	ENDP

	EXPORT	native_string_indexof_string_entry
native_string_indexof_string_entry PROC
	; Bail out to the general indexOf implementation
	ldr.w	r10, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xa088
	mov	pc, r10                   ; 0x46d7

	ENDP

	EXPORT	native_string_indexof_entry
native_string_indexof_entry PROC
	; [[[Hand coded method from java.lang.String]]]
	;     public int indexOf(int ch) {
	;         return indexOf(ch, 0);
	;     }
	; return address is in lr
	ldr.w	r0, [r6], #4              ; 0xf856 0x0b04
	cmp	r0, #0                    ; 0x2800
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	movs	r0, #0                    ; 0x2000
	b	L275

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
	movs	r0, #0                    ; 0x2000
L275
	ldr.w	r2, [r6], #4              ; 0xf856 0x2b04
	ldr.w	r3, [r6], #4              ; 0xf856 0x3b04
	ldr.w	r12, [r3, #12]            ; 0xf8d3 0xc00c
	ldr	r1, [r3, #4]              ; 0x6859
	ldr.w	r10, [r3, #8]             ; 0xf8d3 0xa008
	cmp	r0, r12                   ; 0x4560
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L278
	add.w	r1, r1, #8                ; 0xf101 0x0108
	add.w	r1, r1, r10, lsl #1       ; 0xeb01 0x014a
	add.w	r10, r1, r12, lsl #1      ; 0xeb01 0x0a4c
	mov	r12, r1                   ; 0x468c
	add.w	r1, r1, r0, lsl #1        ; 0xeb01 0x0140
L276
	ldrh	r0, [r1]                  ; 0x8808
	adds	r1, #2                    ; 0x3102
	cmp	r0, r2                    ; 0x4290
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L279
L277
	cmp	r1, r10                   ; 0x4551
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	b	L276
L278
	; return -1;
	movs	r0, #1                    ; 0x2001
	negs	r0, r0                    ; 0x4240
	; continue in caller
	mov	pc, lr                    ; 0x46f7
L279
	; return i - offset;
	sub.w	r0, r1, r12               ; 0xeba1 0x000c
	mov.w	r0, r0, lsr #1            ; 0xea4f 0x0050
	subs	r0, #1                    ; 0x3801
	; continue in caller
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	native_string_endsWith_entry
native_string_endsWith_entry PROC
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088

	ENDP

	EXPORT	native_string_startsWith0_entry
native_string_startsWith0_entry PROC
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088

	ENDP

	EXPORT	native_string_startsWith_entry
native_string_startsWith_entry PROC
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088
	LTORG

	ENDP
	; End segment: Native entry points for string functions


	; ------------------------------------------------------
	; Start segment: Native entry points for system functions

	EXPORT	native_jvm_unchecked_byte_arraycopy_entry
native_jvm_unchecked_byte_arraycopy_entry PROC

	ENDP

	EXPORT	native_jvm_unchecked_char_arraycopy_entry
native_jvm_unchecked_char_arraycopy_entry PROC

	ENDP

	EXPORT	native_jvm_unchecked_int_arraycopy_entry
native_jvm_unchecked_int_arraycopy_entry PROC

	ENDP

	EXPORT	native_jvm_unchecked_long_arraycopy_entry
native_jvm_unchecked_long_arraycopy_entry PROC

	ENDP

	EXPORT	native_jvm_unchecked_obj_arraycopy_entry
native_jvm_unchecked_obj_arraycopy_entry PROC

	ENDP

	EXPORT	native_system_arraycopy_entry
native_system_arraycopy_entry PROC
	; load arguments to registers
	; r2 = length
	ldr	r2, [r6]                  ; 0x6832
	; r10 = dst_pos
	ldr.w	r10, [r6, #4]             ; 0xf8d6 0xa004
	; r8 = dst
	ldr.w	r8, [r6, #8]              ; 0xf8d6 0x8008
	; r3 = src_pos
	ldr	r3, [r6, #12]             ; 0x68f3
	; r1 = src
	ldr	r1, [r6, #16]             ; 0x6931
	; if (src == NULL || dst == NULL) goto bailout;
	cmp	r1, #0                    ; 0x2900
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L283
	cmp.w	r8, #0                    ; 0xf1b8 0x0f00
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L283
	; if (src == dst) && (src_pos < dst_pos) goto bailout;
	cmp	r1, r8                    ; 0x4541
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L285
	cmp	r3, r10                   ; 0x4553
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	b	L283
L285
	; Get src.klass() and dst.klass()
	ldr.w	r11, [r1, #0]             ; 0xf8d1 0xb000
	ldr.w	r12, [r8, #0]             ; 0xf8d8 0xc000
	ldr.w	r11, [r11, #0]            ; 0xf8db 0xb000
	ldr.w	r12, [r12, #0]            ; 0xf8dc 0xc000
	; if (length < 0 || src_pos < 0 || dst_pos < 0) goto bailout;
	orr.w	r7, r2, r3                ; 0xea42 0x0703
	orrs.w	r7, r7, r10               ; 0xea57 0x070a
	DCW 0xbf48 ; IT mi                ; 0xbf48
	b	L283
	; if (src.klass() != dst.klass()) goto bailout;
	cmp	r11, r12                  ; 0x45e3
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L283
	; Make sure we really have an array.
	; Java objects have an instance size >= 0
	ldrsh.w	r7, [r11, #6]             ; 0xf9bb 0x7006
	cmp	r7, #0                    ; 0x2f00
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L283
	; if ((unsigned int) src.length < (unsigned int) src_pos + (unsigned int) length) goto bailout;
	ldr.w	r11, [r1, #4]             ; 0xf8d1 0xb004
	add.w	r12, r3, r2               ; 0xeb03 0x0c02
	cmp.w	r11, r12                  ; 0xebbb 0x0f0c
	DCW 0xbf38 ; IT cc                ; 0xbf38
	b	L283
	; if ((unsigned int) dst.length < (unsigned int) dst_pos + (unsigned int) length) goto bailout;
	ldr.w	r11, [r8, #4]             ; 0xf8d8 0xb004
	add.w	r12, r10, r2              ; 0xeb0a 0x0c02
	cmp.w	r11, r12                  ; 0xebbb 0x0f0c
	DCW 0xbf38 ; IT cc                ; 0xbf38
	b	L283
	; remove arguments from the stack
	add.w	r6, r6, #20               ; 0xf106 0x0614
	; Point at actual data
	add.w	r1, r1, #8                ; 0xf101 0x0108
	add.w	r8, r8, #8                ; 0xf108 0x0808
	; Jump to appropriate copy routine if length > 0
	subs.w	r2, r2, #1                ; 0xf1b2 0x0201
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	b	L284
	; Length > 0.  Jump to appropriate routine;
	cmn.w	r7, #1                    ; 0xf117 0x0f01
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L290
	cmn.w	r7, #2                    ; 0xf117 0x0f02
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L286
	cmn.w	r7, #3                    ; 0xf117 0x0f03
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L287
	cmn.w	r7, #4                    ; 0xf117 0x0f04
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L288
	cmn.w	r7, #5                    ; 0xf117 0x0f05
	DCW 0xbf08 ; IT eq                ; 0xbf08
	b	L289
	b	L292
L286
	; Each element of the array is 1 byte(s)
	cmp	r2, #0                    ; 0x2a00
	add.w	r1, r1, r3                ; J2MEWP: was 16-bit adds (set flags -> copied 1 byte too many)
	add.w	r8, r8, r10               ; 0xeb08 0x080a
L293
	ldrb.w	r11, [r1], #1             ; 0xf811 0xbb01
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	ldrb.w	r12, [r1], #1             ; 0xf811 0xcb01
	strb.w	r11, [r8], #1             ; 0xf808 0xbb01
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	strb.w	r12, [r8], #1             ; 0xf808 0xcb01
	subs.w	r2, r2, #2                ; 0xf1b2 0x0202
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L293
	; fill the top of stack cache and return
	bx	lr                        ; 0x4770
L287
	; Each element of the array is 2 byte(s)
	cmp	r2, #0                    ; 0x2a00
	add.w	r1, r1, r3, lsl #1        ; 0xeb01 0x0143
	add.w	r8, r8, r10, lsl #1       ; 0xeb08 0x084a
L294
	ldrh.w	r11, [r1], #2             ; 0xf831 0xbb02
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	ldrh.w	r12, [r1], #2             ; 0xf831 0xcb02
	strh.w	r11, [r8], #2             ; 0xf828 0xbb02
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	strh.w	r12, [r8], #2             ; 0xf828 0xcb02
	subs.w	r2, r2, #2                ; 0xf1b2 0x0202
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L294
	; fill the top of stack cache and return
	bx	lr                        ; 0x4770
L288
	; Each element of the array is 4 byte(s)
	cmp	r2, #0                    ; 0x2a00
	add.w	r1, r1, r3, lsl #2        ; 0xeb01 0x0183
	add.w	r8, r8, r10, lsl #2       ; 0xeb08 0x088a
L295
	ldr.w	r11, [r1], #4             ; 0xf851 0xbb04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	ldr.w	r12, [r1], #4             ; 0xf851 0xcb04
	str.w	r11, [r8], #4             ; 0xf848 0xbb04
	DCW 0xbfc8 ; IT gt                ; 0xbfc8
	str.w	r12, [r8], #4             ; 0xf848 0xcb04
	subs.w	r2, r2, #2                ; 0xf1b2 0x0202
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L295
	; fill the top of stack cache and return
	bx	lr                        ; 0x4770
L289
	; Each element of the array is 8 byte(s)
	cmp	r2, #0                    ; 0x2a00
	add.w	r1, r1, r3, lsl #3        ; 0xeb01 0x01c3
	add.w	r8, r8, r10, lsl #3       ; 0xeb08 0x08ca
L296
	ldr.w	r11, [r1], #4             ; 0xf851 0xbb04
	ldr.w	r12, [r1], #4             ; 0xf851 0xcb04
	DCW 0xbfc4 ; ITT gt               ; 0xbfc4
	ldr.w	r3, [r1], #4              ; 0xf851 0x3b04
	ldr.w	r10, [r1], #4             ; 0xf851 0xab04
	str.w	r11, [r8], #4             ; 0xf848 0xbb04
	str.w	r12, [r8], #4             ; 0xf848 0xcb04
	DCW 0xbfc4 ; ITT gt               ; 0xbfc4
	str.w	r3, [r8], #4              ; 0xf848 0x3b04
	str.w	r10, [r8], #4             ; 0xf848 0xab04
	subs.w	r2, r2, #2                ; 0xf1b2 0x0202
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L296
	; fill the top of stack cache and return
	bx	lr                        ; 0x4770
L290
	; Check whether dst is in old space
	ldr.w	r7, [r5, #464]; = old_generation_end  ; 0xf8d5 0x71d0
	cmp.w	r8, r7                    ; 0xebb8 0x0f07
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L288
	; Copy elements of an object array
	add.w	r1, r1, r3, lsl #2        ; 0xeb01 0x0183
	add.w	r8, r8, r10, lsl #2       ; 0xeb08 0x088a
L297
	; r2 is one less than the number of elements still to copy
	; Are we copying at least eight elements?
	cmp	r2, #7                    ; 0x2a07
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	b	L300
	; Is the destination aligned?
	tst.w	r8, #28                   ; 0xf018 0x0f1c
	DCW 0xbf18 ; IT ne                ; 0xbf18
	b	L299
	; We have at least 8 words to copy, and the dst is aligned
	ldr.w	r7, [r5, #292]; = bitvector_base  ; 0xf8d5 0x7124
	movs	r0, #1                    ; 0x2001
	negs	r0, r0                    ; 0x4240
L298
	add.w	r11, r7, r8, lsr #5       ; 0xeb07 0x1b58
	strb.w	r0, [r11, #0]             ; 0xf88b 0x0000
	ldr.w	r3, [r1], #4              ; 0xf851 0x3b04
	ldr.w	r10, [r1], #4             ; 0xf851 0xab04
	ldr.w	r11, [r1], #4             ; 0xf851 0xbb04
	ldr.w	r12, [r1], #4             ; 0xf851 0xcb04
	str.w	r3, [r8], #4              ; 0xf848 0x3b04
	str.w	r10, [r8], #4             ; 0xf848 0xab04
	str.w	r11, [r8], #4             ; 0xf848 0xbb04
	str.w	r12, [r8], #4             ; 0xf848 0xcb04
	ldr.w	r3, [r1], #4              ; 0xf851 0x3b04
	ldr.w	r10, [r1], #4             ; 0xf851 0xab04
	ldr.w	r11, [r1], #4             ; 0xf851 0xbb04
	ldr.w	r12, [r1], #4             ; 0xf851 0xcb04
	str.w	r3, [r8], #4              ; 0xf848 0x3b04
	str.w	r10, [r8], #4             ; 0xf848 0xab04
	str.w	r11, [r8], #4             ; 0xf848 0xbb04
	str.w	r12, [r8], #4             ; 0xf848 0xcb04
	subs.w	r2, r2, #8                ; 0xf1b2 0x0208
	DCW 0xbfb8 ; IT lt                ; 0xbfb8
	b	L284
	cmp	r2, #7                    ; 0x2a07
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L298
L300
	; Copying less than 8 elements
	ldr.w	r12, [r1], #4             ; 0xf851 0xcb04
	mov	r11, r8                   ; 0x46c3
	str.w	r12, [r8], #4             ; 0xf848 0xcb04
	; oop_write_barrier
	ldr.w	r12, [r5, #292]; = bitvector_base  ; 0xf8d5 0xc124
	mov.w	r11, r11, lsr #2          ; 0xea4f 0x0b9b
	add.w	r12, r12, r11, lsr #3     ; 0xeb0c 0x0cdb
	ldrb.w	r3, [r12, #0]             ; 0xf89c 0x3000
	mov.w	r10, #1                   ; 0xf04f 0x0a01
	and.w	r11, r11, #7              ; 0xf00b 0x0b07
	lsl.w	r10, r10, r11             ; 0xfa0a 0xfa0b
	orr.w	r3, r3, r10               ; 0xea43 0x030a
	strb.w	r3, [r12, #0]             ; 0xf88c 0x3000
	subs.w	r2, r2, #1                ; 0xf1b2 0x0201
	DCW 0xbfa8 ; IT ge                ; 0xbfa8
	b	L300
L284
	bx	lr                        ; 0x4770
L299
	; length >= 8, but dst not aligned
	ldr.w	r12, [r1], #4             ; 0xf851 0xcb04
	mov	r11, r8                   ; 0x46c3
	str.w	r12, [r8], #4             ; 0xf848 0xcb04
	; oop_write_barrier
	ldr.w	r12, [r5, #292]; = bitvector_base  ; 0xf8d5 0xc124
	mov.w	r11, r11, lsr #2          ; 0xea4f 0x0b9b
	add.w	r12, r12, r11, lsr #3     ; 0xeb0c 0x0cdb
	ldrb.w	r3, [r12, #0]             ; 0xf89c 0x3000
	mov.w	r10, #1                   ; 0xf04f 0x0a01
	and.w	r11, r11, #7              ; 0xf00b 0x0b07
	lsl.w	r10, r10, r11             ; 0xfa0a 0xfa0b
	orr.w	r3, r3, r10               ; 0xea43 0x030a
	strb.w	r3, [r12, #0]             ; 0xf88c 0x3000
	subs	r2, #1                    ; 0x3a01
	b	L297
L292
	; Shouldn't call this
	svc	#0x0000ff                  ; 0xdfff
L283
	; Bail out to the general arraycopy implementation
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088
	LTORG

	ENDP
	; End segment: Native entry points for system functions


	; ------------------------------------------------------
	; Start segment: Native entry points for miscellaneous functions

	EXPORT	native_stringbuffer_append_entry
native_stringbuffer_append_entry PROC
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088

	ENDP

	EXPORT	native_vector_elementAt_entry
native_vector_elementAt_entry PROC
	ldr	r2, [r6, #4]              ; 0x6872
	ldr	r3, [r6]                  ; 0x6833
	; Get the near object.
	ldr.w	r10, [r2, #0]             ; 0xf8d2 0xa000
	ldr.w	r11, [r2, #8]             ; 0xf8d2 0xb008
	ldr.w	r10, [r10, #8]            ; 0xf8da 0xa008
	; Check for out of range index.
	cmp	r3, r11                   ; 0x455b
	DCW 0xbf28 ; IT cs                ; 0xbf28
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088
	; Check the lock bit.
	tst.w	r10, #1                   ; 0xf01a 0x0f01
	DCW 0xbf0c ; ITE eq               ; 0xbf0c
	ldr.w	r11, [r2, #4]             ; 0xf8d2 0xb004
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088
	; Get the object and return.
	add.w	r0, r11, r3, lsl #2       ; 0xeb0b 0x0083
	ldr	r0, [r0, #8]              ; 0x6880
	; continue in caller
	add.w	r6, r6, #8                ; 0xf106 0x0608
	mov	pc, lr                    ; 0x46f7

	ENDP

	EXPORT	native_string_substringI_entry
native_string_substringI_entry PROC
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088

	ENDP

	EXPORT	native_string_substringII_entry
native_string_substringII_entry PROC
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088

	ENDP

	EXPORT	native_vector_addElement_entry
native_vector_addElement_entry PROC
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088

	ENDP

	EXPORT	native_integer_toString_entry
native_integer_toString_entry PROC
	ldr.w	pc, [r5, #136]; = interpreter_method_entry  ; 0xf8d5 0xf088
	LTORG

	ENDP
	; End segment: Native entry points for miscellaneous functions


	THUMB
	AREA |.text|, CODE
	; ------------------------------------------------------
	; Start segment: Floating point routines
	LTORG
	; End segment: Floating point routines


	; ------------------------------------------------------
	; Start segment: Compiler glue code

	EXPORT	compiler_glue_code_start
compiler_glue_code_start PROC
	LTORG

	ENDP
	; End segment: Compiler glue code


	; ------------------------------------------------------
	; Start segment: Compiler glue code

	EXPORT	compiler_glue_code_end
compiler_glue_code_end PROC
	LTORG

	ENDP
	; End segment: Compiler glue code


	THUMB
	AREA |.text|, CODE
	; ------------------------------------------------------
	; Start segment: Code dummies

	EXPORT	indirect_execution_sensor_update
indirect_execution_sensor_update
	svc	#0x0000ff                  ; 0xdfff

	EXPORT	compiler_throw_NullPointerException_10
compiler_throw_NullPointerException_10
	svc	#0x0000ff                  ; 0xdfff

	EXPORT	compiler_throw_ArrayIndexOutOfBoundsException_10
compiler_throw_ArrayIndexOutOfBoundsException_10
	svc	#0x0000ff                  ; 0xdfff
	LTORG
	; End segment: Code dummies


	THUMB
	AREA |.data|, DATA
	; ------------------------------------------------------
	; Start segment: Global pool
	DCD	0x0
	DCD	0x0
	DCD	0x0
	DCD	bc_impl_fast_init_new                  ; 0xfc
	DCD	bc_impl_fast_init_invokestatic         ; 0xfb
	DCD	bc_impl_fast_init_2_getstatic          ; 0xfa
	DCD	bc_impl_fast_init_1_getstatic          ; 0xf9
	DCD	bc_impl_fast_init_a_putstatic          ; 0xf8
	DCD	bc_impl_fast_init_2_putstatic          ; 0xf7
	DCD	bc_impl_fast_init_1_putstatic          ; 0xf6
	DCD	bc_impl_aload_0_fast_igetfield_8       ; 0xf5
	DCD	bc_impl_aload_0_fast_agetfield_8       ; 0xf4
	DCD	bc_impl_aload_0_fast_igetfield_4       ; 0xf3
	DCD	bc_impl_aload_0_fast_agetfield_4       ; 0xf2
	DCD	bc_impl_init_static_array              ; 0xf1
	DCD	bc_impl_pop_and_npe_if_null            ; 0xf0
	DCD	bc_impl_aload_0_fast_igetfield_1       ; 0xef
	DCD	bc_impl_aload_0_fast_agetfield_1       ; 0xee
	DCD	bc_impl_fast_agetfield_1               ; 0xed
	DCD	bc_impl_fast_igetfield_1               ; 0xec
	DCD	bc_impl_fast_instanceof                ; 0xeb
	DCD	bc_impl_fast_checkcast                 ; 0xea
	DCD	bc_impl_fast_anewarray                 ; 0xe9
	DCD	bc_impl_fast_new                       ; 0xe8
	DCD	bc_impl_fast_invokespecial             ; 0xe7
	DCD	bc_impl_fast_invokevirtual_final       ; 0xe6
	DCD	bc_impl_fast_invokenative              ; 0xe5
	DCD	bc_impl_fast_invokeinterface           ; 0xe4
	DCD	bc_impl_fast_invokestatic              ; 0xe3
	DCD	bc_impl_fast_invokevirtual             ; 0xe2
	DCD	bc_impl_fast_cgetfield                 ; 0xe1
	DCD	bc_impl_fast_agetfield                 ; 0xe0
	DCD	bc_impl_fast_dgetfield                 ; 0xdf
	DCD	bc_impl_fast_fgetfield                 ; 0xde
	DCD	bc_impl_fast_lgetfield                 ; 0xdd
	DCD	bc_impl_fast_igetfield                 ; 0xdc
	DCD	bc_impl_fast_sgetfield                 ; 0xdb
	DCD	bc_impl_fast_bgetfield                 ; 0xda
	DCD	bc_impl_fast_aputfield                 ; 0xd9
	DCD	bc_impl_fast_dputfield                 ; 0xd8
	DCD	bc_impl_fast_fputfield                 ; 0xd7
	DCD	bc_impl_fast_lputfield                 ; 0xd6
	DCD	bc_impl_fast_iputfield                 ; 0xd5
	DCD	bc_impl_fast_sputfield                 ; 0xd4
	DCD	bc_impl_fast_bputfield                 ; 0xd3
	DCD	bc_impl_fast_2_getstatic               ; 0xd2
	DCD	bc_impl_fast_1_getstatic               ; 0xd1
	DCD	bc_impl_fast_a_putstatic               ; 0xd0
	DCD	bc_impl_fast_2_putstatic               ; 0xcf
	DCD	bc_impl_fast_1_putstatic               ; 0xce
	DCD	bc_impl_fast_2_ldc_w                   ; 0xcd
	DCD	bc_impl_fast_1_ldc_w                   ; 0xcc
	DCD	bc_impl_fast_1_ldc                     ; 0xcb
	DCD	bc_impl_breakpoint                     ; 0xca
	DCD	0x0
	DCD	bc_impl_goto_w                         ; 0xc8
	DCD	bc_impl_ifnonnull                      ; 0xc7
	DCD	bc_impl_ifnull                         ; 0xc6
	DCD	bc_impl_multianewarray                 ; 0xc5
	DCD	bc_impl_wide                           ; 0xc4
	DCD	bc_impl_monitorexit                    ; 0xc3
	DCD	bc_impl_monitorenter                   ; 0xc2
	DCD	bc_impl_instanceof                     ; 0xc1
	DCD	bc_impl_checkcast                      ; 0xc0
	DCD	bc_impl_athrow                         ; 0xbf
	DCD	bc_impl_arraylength                    ; 0xbe
	DCD	bc_impl_anewarray                      ; 0xbd
	DCD	bc_impl_newarray                       ; 0xbc
	DCD	bc_impl_new                            ; 0xbb
	DCD	0x0
	DCD	bc_impl_invokeinterface                ; 0xb9
	DCD	bc_impl_invokestatic                   ; 0xb8
	DCD	bc_impl_invokespecial                  ; 0xb7
	DCD	bc_impl_invokevirtual                  ; 0xb6
	DCD	bc_impl_putfield                       ; 0xb5
	DCD	bc_impl_getfield                       ; 0xb4
	DCD	bc_impl_putstatic                      ; 0xb3
	DCD	bc_impl_getstatic                      ; 0xb2
	DCD	bc_impl_return                         ; 0xb1
	DCD	bc_impl_areturn                        ; 0xb0
	DCD	bc_impl_dreturn                        ; 0xaf
	DCD	bc_impl_freturn                        ; 0xae
	DCD	bc_impl_lreturn                        ; 0xad
	DCD	bc_impl_ireturn                        ; 0xac
	DCD	bc_impl_lookupswitch                   ; 0xab
	DCD	bc_impl_tableswitch                    ; 0xaa
	DCD	0x0
	DCD	0x0
	DCD	bc_impl_goto                           ; 0xa7
	DCD	bc_impl_if_acmpne                      ; 0xa6
	DCD	bc_impl_if_acmpeq                      ; 0xa5
	DCD	bc_impl_if_icmple                      ; 0xa4
	DCD	bc_impl_if_icmpgt                      ; 0xa3
	DCD	bc_impl_if_icmpge                      ; 0xa2
	DCD	bc_impl_if_icmplt                      ; 0xa1
	DCD	bc_impl_if_icmpne                      ; 0xa0
	DCD	bc_impl_if_icmpeq                      ; 0x9f
	DCD	bc_impl_ifle                           ; 0x9e
	DCD	bc_impl_ifgt                           ; 0x9d
	DCD	bc_impl_ifge                           ; 0x9c
	DCD	bc_impl_iflt                           ; 0x9b
	DCD	bc_impl_ifne                           ; 0x9a
	DCD	bc_impl_ifeq                           ; 0x99
	DCD	bc_impl_dcmpg                          ; 0x98
	DCD	bc_impl_dcmpl                          ; 0x97
	DCD	bc_impl_fcmpg                          ; 0x96
	DCD	bc_impl_fcmpl                          ; 0x95
	DCD	bc_impl_lcmp                           ; 0x94
	DCD	bc_impl_i2s                            ; 0x93
	DCD	bc_impl_i2c                            ; 0x92
	DCD	bc_impl_i2b                            ; 0x91
	DCD	bc_impl_d2f                            ; 0x90
	DCD	bc_impl_d2l                            ; 0x8f
	DCD	bc_impl_d2i                            ; 0x8e
	DCD	bc_impl_f2d                            ; 0x8d
	DCD	bc_impl_f2l                            ; 0x8c
	DCD	bc_impl_f2i                            ; 0x8b
	DCD	bc_impl_l2d                            ; 0x8a
	DCD	bc_impl_l2f                            ; 0x89
	DCD	bc_impl_l2i                            ; 0x88
	DCD	bc_impl_i2d                            ; 0x87
	DCD	bc_impl_i2f                            ; 0x86
	DCD	bc_impl_i2l                            ; 0x85
	DCD	bc_impl_iinc                           ; 0x84
	DCD	bc_impl_lxor                           ; 0x83
	DCD	bc_impl_ixor                           ; 0x82
	DCD	bc_impl_lor                            ; 0x81
	DCD	bc_impl_ior                            ; 0x80
	DCD	bc_impl_land                           ; 0x7f
	DCD	bc_impl_iand                           ; 0x7e
	DCD	bc_impl_lushr                          ; 0x7d
	DCD	bc_impl_iushr                          ; 0x7c
	DCD	bc_impl_lshr                           ; 0x7b
	DCD	bc_impl_ishr                           ; 0x7a
	DCD	bc_impl_lshl                           ; 0x79
	DCD	bc_impl_ishl                           ; 0x78
	DCD	bc_impl_dneg                           ; 0x77
	DCD	bc_impl_fneg                           ; 0x76
	DCD	bc_impl_lneg                           ; 0x75
	DCD	bc_impl_ineg                           ; 0x74
	DCD	bc_impl_drem                           ; 0x73
	DCD	bc_impl_frem                           ; 0x72
	DCD	bc_impl_lrem                           ; 0x71
	DCD	bc_impl_irem                           ; 0x70
	DCD	bc_impl_ddiv                           ; 0x6f
	DCD	bc_impl_fdiv                           ; 0x6e
	DCD	bc_impl_ldiv                           ; 0x6d
	DCD	bc_impl_idiv                           ; 0x6c
	DCD	bc_impl_dmul                           ; 0x6b
	DCD	bc_impl_fmul                           ; 0x6a
	DCD	bc_impl_lmul                           ; 0x69
	DCD	bc_impl_imul                           ; 0x68
	DCD	bc_impl_dsub                           ; 0x67
	DCD	bc_impl_fsub                           ; 0x66
	DCD	bc_impl_lsub                           ; 0x65
	DCD	bc_impl_isub                           ; 0x64
	DCD	bc_impl_dadd                           ; 0x63
	DCD	bc_impl_fadd                           ; 0x62
	DCD	bc_impl_ladd                           ; 0x61
	DCD	bc_impl_iadd                           ; 0x60
	DCD	bc_impl_swap                           ; 0x5f
	DCD	bc_impl_dup2_x2                        ; 0x5e
	DCD	bc_impl_dup2_x1                        ; 0x5d
	DCD	bc_impl_dup2                           ; 0x5c
	DCD	bc_impl_dup_x2                         ; 0x5b
	DCD	bc_impl_dup_x1                         ; 0x5a
	DCD	bc_impl_dup                            ; 0x59
	DCD	bc_impl_pop2                           ; 0x58
	DCD	bc_impl_pop                            ; 0x57
	DCD	bc_impl_sastore                        ; 0x56
	DCD	bc_impl_castore                        ; 0x55
	DCD	bc_impl_bastore                        ; 0x54
	DCD	bc_impl_aastore                        ; 0x53
	DCD	bc_impl_dastore                        ; 0x52
	DCD	bc_impl_fastore                        ; 0x51
	DCD	bc_impl_lastore                        ; 0x50
	DCD	bc_impl_iastore                        ; 0x4f
	DCD	bc_impl_astore_3                       ; 0x4e
	DCD	bc_impl_astore_2                       ; 0x4d
	DCD	bc_impl_astore_1                       ; 0x4c
	DCD	bc_impl_astore_0                       ; 0x4b
	DCD	bc_impl_dstore_3                       ; 0x4a
	DCD	bc_impl_dstore_2                       ; 0x49
	DCD	bc_impl_dstore_1                       ; 0x48
	DCD	bc_impl_dstore_0                       ; 0x47
	DCD	bc_impl_fstore_3                       ; 0x46
	DCD	bc_impl_fstore_2                       ; 0x45
	DCD	bc_impl_fstore_1                       ; 0x44
	DCD	bc_impl_fstore_0                       ; 0x43
	DCD	bc_impl_lstore_3                       ; 0x42
	DCD	bc_impl_lstore_2                       ; 0x41
	DCD	bc_impl_lstore_1                       ; 0x40
	DCD	bc_impl_lstore_0                       ; 0x3f
	DCD	bc_impl_istore_3                       ; 0x3e
	DCD	bc_impl_istore_2                       ; 0x3d
	DCD	bc_impl_istore_1                       ; 0x3c
	DCD	bc_impl_istore_0                       ; 0x3b
	DCD	bc_impl_astore                         ; 0x3a
	DCD	bc_impl_dstore                         ; 0x39
	DCD	bc_impl_fstore                         ; 0x38
	DCD	bc_impl_lstore                         ; 0x37
	DCD	bc_impl_istore                         ; 0x36
	DCD	bc_impl_saload                         ; 0x35
	DCD	bc_impl_caload                         ; 0x34
	DCD	bc_impl_baload                         ; 0x33
	DCD	bc_impl_aaload                         ; 0x32
	DCD	bc_impl_daload                         ; 0x31
	DCD	bc_impl_faload                         ; 0x30
	DCD	bc_impl_laload                         ; 0x2f
	DCD	bc_impl_iaload                         ; 0x2e
	DCD	bc_impl_aload_3                        ; 0x2d
	DCD	bc_impl_aload_2                        ; 0x2c
	DCD	bc_impl_aload_1                        ; 0x2b
	DCD	bc_impl_aload_0                        ; 0x2a
	DCD	bc_impl_dload_3                        ; 0x29
	DCD	bc_impl_dload_2                        ; 0x28
	DCD	bc_impl_dload_1                        ; 0x27
	DCD	bc_impl_dload_0                        ; 0x26
	DCD	bc_impl_fload_3                        ; 0x25
	DCD	bc_impl_fload_2                        ; 0x24
	DCD	bc_impl_fload_1                        ; 0x23
	DCD	bc_impl_fload_0                        ; 0x22
	DCD	bc_impl_lload_3                        ; 0x21
	DCD	bc_impl_lload_2                        ; 0x20
	DCD	bc_impl_lload_1                        ; 0x1f
	DCD	bc_impl_lload_0                        ; 0x1e
	DCD	bc_impl_iload_3                        ; 0x1d
	DCD	bc_impl_iload_2                        ; 0x1c
	DCD	bc_impl_iload_1                        ; 0x1b
	DCD	bc_impl_iload_0                        ; 0x1a
	DCD	bc_impl_aload                          ; 0x19
	DCD	bc_impl_dload                          ; 0x18
	DCD	bc_impl_fload                          ; 0x17
	DCD	bc_impl_lload                          ; 0x16
	DCD	bc_impl_iload                          ; 0x15
	DCD	bc_impl_ldc2_w                         ; 0x14
	DCD	bc_impl_ldc_w                          ; 0x13
	DCD	bc_impl_ldc                            ; 0x12
	DCD	bc_impl_sipush                         ; 0x11
	DCD	bc_impl_bipush                         ; 0x10
	DCD	bc_impl_dconst_1                       ; 0xf
	DCD	bc_impl_dconst_0                       ; 0xe
	DCD	bc_impl_fconst_2                       ; 0xd
	DCD	bc_impl_fconst_1                       ; 0xc
	DCD	bc_impl_fconst_0                       ; 0xb
	DCD	bc_impl_lconst_1                       ; 0xa
	DCD	bc_impl_lconst_0                       ; 0x9
	DCD	bc_impl_iconst_5                       ; 0x8
	DCD	bc_impl_iconst_4                       ; 0x7
	DCD	bc_impl_iconst_3                       ; 0x6
	DCD	bc_impl_iconst_2                       ; 0x5
	DCD	bc_impl_iconst_1                       ; 0x4
	DCD	bc_impl_iconst_0                       ; 0x3
	DCD	bc_impl_iconst_m1                      ; 0x2
	DCD	bc_impl_aconst_null                    ; 0x1

	EXPORT	gp_base_label
gp_base_label
	DCD	bc_impl_nop                            ; 0x0 ; offset=0 (0x0)

	EXPORT	gp_constants
gp_constants

	EXPORT	gp_indirect_execution_sensor_update_ptr
gp_indirect_execution_sensor_update_ptr
	DCD	indirect_execution_sensor_update ; offset=4 (0x4)

	EXPORT	gp_stack_overflow_ptr
gp_stack_overflow_ptr
	IMPORT	stack_overflow
	DCD	stack_overflow           ; offset=8 (0x8)

	EXPORT	gp_timer_tick_ptr
gp_timer_tick_ptr
	IMPORT	timer_tick
	DCD	timer_tick               ; offset=12 (0xc)

	EXPORT	gp_lock_stack_lock_ptr
gp_lock_stack_lock_ptr
	IMPORT	lock_stack_lock
	DCD	lock_stack_lock          ; offset=16 (0x10)

	EXPORT	gp_signal_waiters_ptr
gp_signal_waiters_ptr
	IMPORT	signal_waiters
	DCD	signal_waiters           ; offset=20 (0x14)

	EXPORT	gp_array_index_out_of_bounds_exception_ptr
gp_array_index_out_of_bounds_exception_ptr
	IMPORT	array_index_out_of_bounds_exception
	DCD	array_index_out_of_bounds_exception ; offset=24 (0x18)

	EXPORT	gp_get_array_index_out_of_bounds_exception_ptr
gp_get_array_index_out_of_bounds_exception_ptr
	IMPORT	get_array_index_out_of_bounds_exception
	DCD	get_array_index_out_of_bounds_exception ; offset=28 (0x1c)

	EXPORT	gp_null_pointer_exception_ptr
gp_null_pointer_exception_ptr
	IMPORT	null_pointer_exception
	DCD	null_pointer_exception   ; offset=32 (0x20)

	EXPORT	gp_get_null_pointer_exception_ptr
gp_get_null_pointer_exception_ptr
	IMPORT	get_null_pointer_exception
	DCD	get_null_pointer_exception ; offset=36 (0x24)

	EXPORT	gp_illegal_monitor_state_exception_ptr
gp_illegal_monitor_state_exception_ptr
	IMPORT	illegal_monitor_state_exception
	DCD	illegal_monitor_state_exception ; offset=40 (0x28)

	EXPORT	gp_get_illegal_monitor_state_exception_ptr
gp_get_illegal_monitor_state_exception_ptr
	IMPORT	get_illegal_monitor_state_exception
	DCD	get_illegal_monitor_state_exception ; offset=44 (0x2c)

	EXPORT	gp_division_by_zero_exception_ptr
gp_division_by_zero_exception_ptr
	IMPORT	division_by_zero_exception
	DCD	division_by_zero_exception ; offset=48 (0x30)

	EXPORT	gp_get_division_by_zero_exception_ptr
gp_get_division_by_zero_exception_ptr
	IMPORT	get_division_by_zero_exception
	DCD	get_division_by_zero_exception ; offset=52 (0x34)

	EXPORT	gp_get_incompatible_class_change_error_ptr
gp_get_incompatible_class_change_error_ptr
	IMPORT	get_incompatible_class_change_error
	DCD	get_incompatible_class_change_error ; offset=56 (0x38)

	EXPORT	gp_multianewarray_ptr
gp_multianewarray_ptr
	IMPORT	multianewarray
	DCD	multianewarray           ; offset=60 (0x3c)

	EXPORT	gp_instanceof_ptr
gp_instanceof_ptr
	IMPORT	instanceof
	DCD	instanceof               ; offset=64 (0x40)

	EXPORT	gp__instanceof_ptr
gp__instanceof_ptr
	IMPORT	_instanceof
	DCD	_instanceof              ; offset=68 (0x44)

	EXPORT	gp_checkcast_ptr
gp_checkcast_ptr
	IMPORT	checkcast
	DCD	checkcast                ; offset=72 (0x48)

	EXPORT	gp_array_store_type_check_ptr
gp_array_store_type_check_ptr
	IMPORT	array_store_type_check
	DCD	array_store_type_check   ; offset=76 (0x4c)

	EXPORT	gp_compiled_code_task_barrier_ptr
gp_compiled_code_task_barrier_ptr
	IMPORT	compiled_code_task_barrier
	DCD	compiled_code_task_barrier ; offset=80 (0x50)

	EXPORT	_current_stack_limit
_current_stack_limit
	%	4                        ; offset=84 (0x54)

	EXPORT	_compiler_stack_limit
_compiler_stack_limit
	%	4                        ; offset=88 (0x58)

	EXPORT	_rt_timer_ticks
_rt_timer_ticks
	%	4                        ; offset=92 (0x5c)

	EXPORT	gp_compiler_new_object_ptr
gp_compiler_new_object_ptr
	DCD	compiler_new_object      ; offset=96 (0x60)

	EXPORT	gp_compiler_new_type_array_ptr
gp_compiler_new_type_array_ptr
	DCD	compiler_new_type_array  ; offset=100 (0x64)

	EXPORT	gp_compiler_timer_tick_ptr
gp_compiler_timer_tick_ptr
	DCD	compiler_timer_tick      ; offset=104 (0x68)

	EXPORT	gp_shared_monitor_enter_ptr
gp_shared_monitor_enter_ptr
	DCD	shared_monitor_enter     ; offset=108 (0x6c)

	EXPORT	gp_shared_monitor_exit_ptr
gp_shared_monitor_exit_ptr
	DCD	shared_monitor_exit      ; offset=112 (0x70)

	EXPORT	gp_shared_lock_synchronized_method_ptr
gp_shared_lock_synchronized_method_ptr
	DCD	shared_lock_synchronized_method ; offset=116 (0x74)

	EXPORT	gp_shared_unlock_synchronized_method_ptr
gp_shared_unlock_synchronized_method_ptr
	DCD	shared_unlock_synchronized_method ; offset=120 (0x78)

	EXPORT	gp_shared_call_vm_oop_ptr
gp_shared_call_vm_oop_ptr
	DCD	shared_call_vm_oop       ; offset=124 (0x7c)

	EXPORT	gp_shared_call_vm_exception_ptr
gp_shared_call_vm_exception_ptr
	DCD	shared_call_vm_exception ; offset=128 (0x80)

	EXPORT	gp_shared_call_vm_ptr
gp_shared_call_vm_ptr
	DCD	shared_call_vm           ; offset=132 (0x84)

	EXPORT	gp_interpreter_method_entry_ptr
gp_interpreter_method_entry_ptr
	DCD	interpreter_method_entry ; offset=136 (0x88)

	EXPORT	gp_compiler_new_obj_array_ptr
gp_compiler_new_obj_array_ptr
	DCD	compiler_new_obj_array   ; offset=140 (0x8c)

	EXPORT	gp_compiler_idiv_irem_ptr
gp_compiler_idiv_irem_ptr
	DCD	compiler_idiv_irem       ; offset=144 (0x90)

	EXPORT	gp_compiler_checkcast_ptr
gp_compiler_checkcast_ptr
	DCD	compiler_checkcast       ; offset=148 (0x94)

	EXPORT	gp_compiler_instanceof_ptr
gp_compiler_instanceof_ptr
	DCD	compiler_instanceof      ; offset=152 (0x98)

	EXPORT	gp_compiler_throw_NullPointerException_ptr
gp_compiler_throw_NullPointerException_ptr
	DCD	compiler_throw_NullPointerException ; offset=156 (0x9c)

	EXPORT	gp_compiler_throw_NullPointerException_0_ptr
gp_compiler_throw_NullPointerException_0_ptr
	DCD	compiler_throw_NullPointerException_0 ; offset=160 (0xa0)

	EXPORT	gp_compiler_throw_NullPointerException_1_ptr
gp_compiler_throw_NullPointerException_1_ptr
	DCD	compiler_throw_NullPointerException_1 ; offset=164 (0xa4)

	EXPORT	gp_compiler_throw_NullPointerException_2_ptr
gp_compiler_throw_NullPointerException_2_ptr
	DCD	compiler_throw_NullPointerException_2 ; offset=168 (0xa8)

	EXPORT	gp_compiler_throw_NullPointerException_3_ptr
gp_compiler_throw_NullPointerException_3_ptr
	DCD	compiler_throw_NullPointerException_3 ; offset=172 (0xac)

	EXPORT	gp_compiler_throw_NullPointerException_4_ptr
gp_compiler_throw_NullPointerException_4_ptr
	DCD	compiler_throw_NullPointerException_4 ; offset=176 (0xb0)

	EXPORT	gp_compiler_throw_NullPointerException_5_ptr
gp_compiler_throw_NullPointerException_5_ptr
	DCD	compiler_throw_NullPointerException_5 ; offset=180 (0xb4)

	EXPORT	gp_compiler_throw_NullPointerException_6_ptr
gp_compiler_throw_NullPointerException_6_ptr
	DCD	compiler_throw_NullPointerException_6 ; offset=184 (0xb8)

	EXPORT	gp_compiler_throw_NullPointerException_7_ptr
gp_compiler_throw_NullPointerException_7_ptr
	DCD	compiler_throw_NullPointerException_7 ; offset=188 (0xbc)

	EXPORT	gp_compiler_throw_NullPointerException_8_ptr
gp_compiler_throw_NullPointerException_8_ptr
	DCD	compiler_throw_NullPointerException_8 ; offset=192 (0xc0)

	EXPORT	gp_compiler_throw_NullPointerException_9_ptr
gp_compiler_throw_NullPointerException_9_ptr
	DCD	compiler_throw_NullPointerException_9 ; offset=196 (0xc4)

	EXPORT	gp_compiler_throw_NullPointerException_10_ptr
gp_compiler_throw_NullPointerException_10_ptr
	DCD	compiler_throw_NullPointerException_10 ; offset=200 (0xc8)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException ; offset=204 (0xcc)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_0_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_0_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_0 ; offset=208 (0xd0)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_1_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_1_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_1 ; offset=212 (0xd4)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_2_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_2_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_2 ; offset=216 (0xd8)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_3_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_3_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_3 ; offset=220 (0xdc)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_4_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_4_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_4 ; offset=224 (0xe0)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_5_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_5_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_5 ; offset=228 (0xe4)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_6_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_6_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_6 ; offset=232 (0xe8)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_7_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_7_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_7 ; offset=236 (0xec)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_8_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_8_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_8 ; offset=240 (0xf0)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_9_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_9_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_9 ; offset=244 (0xf4)

	EXPORT	gp_compiler_throw_ArrayIndexOutOfBoundsException_10_ptr
gp_compiler_throw_ArrayIndexOutOfBoundsException_10_ptr
	DCD	compiler_throw_ArrayIndexOutOfBoundsException_10 ; offset=248 (0xf8)

	EXPORT	jvm_fast_globals
jvm_fast_globals

	EXPORT	_current_thread
_current_thread
	%	4                        ; offset=252 (0xfc)

	EXPORT	_current_pending_exception
_current_pending_exception
	%	4                        ; offset=256 (0x100)

	EXPORT	_last_handle
_last_handle
	%	4                        ; offset=260 (0x104)

	EXPORT	_collection_area_start
_collection_area_start
	%	4                        ; offset=264 (0x108)

	EXPORT	_heap_start
_heap_start
	%	4                        ; offset=268 (0x10c)

	EXPORT	_heap_top
_heap_top
	%	4                        ; offset=272 (0x110)

	EXPORT	_inline_allocation_top
_inline_allocation_top
	%	4                        ; offset=276 (0x114)

	EXPORT	_inline_allocation_end
_inline_allocation_end
	%	4                        ; offset=280 (0x118)

	EXPORT	_heap_limit
_heap_limit
	%	4                        ; offset=284 (0x11c)

	EXPORT	_heap_end
_heap_end
	%	4                        ; offset=288 (0x120)

	EXPORT	_bitvector_base
_bitvector_base
	%	4                        ; offset=292 (0x124)

	EXPORT	_bit_selector
_bit_selector
	%	4                        ; offset=296 (0x128)

	EXPORT	_young_generation_start
_young_generation_start
	%	4                        ; offset=300 (0x12c)

	EXPORT	_collection_area_end
_collection_area_end
	%	4                        ; offset=304 (0x130)

	EXPORT	_young_generation_target_size
_young_generation_target_size
	%	4                        ; offset=308 (0x134)

	EXPORT	_end_fixed_objects
_end_fixed_objects
	%	4                        ; offset=312 (0x138)

	EXPORT	_marking_stack_start
_marking_stack_start
	%	4                        ; offset=316 (0x13c)

	EXPORT	_marking_stack_top
_marking_stack_top
	%	4                        ; offset=320 (0x140)

	EXPORT	_marking_stack_end
_marking_stack_end
	%	4                        ; offset=324 (0x144)

	EXPORT	_marking_stack_overflow
_marking_stack_overflow
	%	4                        ; offset=328 (0x148)

	EXPORT	_slices_start
_slices_start
	%	4                        ; offset=332 (0x14c)

	EXPORT	_slice_shift
_slice_shift
	%	4                        ; offset=336 (0x150)

	EXPORT	_slice_offset_bits
_slice_offset_bits
	%	4                        ; offset=340 (0x154)

	EXPORT	_slice_size
_slice_size
	%	4                        ; offset=344 (0x158)

	EXPORT	_near_mask
_near_mask
	%	4                        ; offset=348 (0x15c)

	EXPORT	_slice_offset_mask
_slice_offset_mask
	%	4                        ; offset=352 (0x160)

	EXPORT	_nof_slices
_nof_slices
	%	4                        ; offset=356 (0x164)

	EXPORT	_compaction_start
_compaction_start
	%	4                        ; offset=360 (0x168)

	EXPORT	_compaction_top
_compaction_top
	%	4                        ; offset=364 (0x16c)

	EXPORT	_heap_min
_heap_min
	%	4                        ; offset=368 (0x170)

	EXPORT	_heap_capacity
_heap_capacity
	%	4                        ; offset=372 (0x174)

	EXPORT	_heap_size
_heap_size
	%	4                        ; offset=376 (0x178)

	EXPORT	_compiler_area_start
_compiler_area_start
	%	4                        ; offset=380 (0x17c)

	EXPORT	_compiler_area_top
_compiler_area_top
	%	4                        ; offset=384 (0x180)

	EXPORT	_large_object_area_bottom
_large_object_area_bottom
	%	4                        ; offset=388 (0x184)

	EXPORT	_compiler_area_temp_top
_compiler_area_temp_top
	%	4                        ; offset=392 (0x188)

	EXPORT	_compiler_area_temp_bottom
_compiler_area_temp_bottom
	%	4                        ; offset=396 (0x18c)

	EXPORT	_compiler_state
_compiler_state
	%	4                        ; offset=400 (0x190)

	EXPORT	_current_compiler
_current_compiler
	%	4                        ; offset=404 (0x194)

	EXPORT	_num_stack_lock_words
_num_stack_lock_words
	%	4                        ; offset=408 (0x198)

	EXPORT	_class_list_base
_class_list_base
	%	4                        ; offset=412 (0x19c)

	EXPORT	_mirror_list_base
_mirror_list_base
	%	4                        ; offset=416 (0x1a0)

	EXPORT	_interpretation_log
_interpretation_log
	%	36                       ; offset=420 (0x1a4)

	EXPORT	_interpretation_log_idx
_interpretation_log_idx
	%	4                        ; offset=456 (0x1c8)

	EXPORT	_primordial_sp
_primordial_sp
	%	4                        ; offset=460 (0x1cc)

	EXPORT	_old_generation_end
_old_generation_end
	%	4                        ; offset=464 (0x1d0)

	EXPORT	_bytecode_counter
_bytecode_counter
	%	4                        ; offset=468 (0x1d4)

	EXPORT	_kni_parameter_base
_kni_parameter_base
	%	4                        ; offset=472 (0x1d8)

	EXPORT	_rom_constant_pool_fast
_rom_constant_pool_fast
	%	4                        ; offset=476 (0x1dc)

	EXPORT	_gp_bytecode_counter
_gp_bytecode_counter
	%	4                        ; offset=480 (0x1e0)

	EXPORT	_jvm_in_quick_native_method
_jvm_in_quick_native_method
	%	4                        ; offset=484 (0x1e4)

	EXPORT	_jvm_quick_native_exception
_jvm_quick_native_exception
	%	4                        ; offset=488 (0x1e8)

	EXPORT	_method_execution_sensor
_method_execution_sensor
	%	512                      ; offset=492 (0x1ec)

	EXPORT	_interned_string_near_addr
_interned_string_near_addr
	%	4                        ; offset=1004 (0x3ec)

	EXPORT	_persistent_handles_addr
_persistent_handles_addr
	%	4                        ; offset=1008 (0x3f0)

	EXPORT	_current_task
_current_task
	%	4                        ; offset=1012 (0x3f4)

	EXPORT	_task_class_init_marker
_task_class_init_marker
	%	4                        ; offset=1016 (0x3f8)

	EXPORT	gp_jvm_ldiv_ptr
gp_jvm_ldiv_ptr
	IMPORT	jvm_ldiv
	DCD	jvm_ldiv                 ; offset=1020 (0x3fc)

	EXPORT	gp_jvm_lrem_ptr
gp_jvm_lrem_ptr
	IMPORT	jvm_lrem
	DCD	jvm_lrem                 ; offset=1024 (0x400)

	EXPORT	gp_memcpy_ptr
gp_memcpy_ptr
	IMPORT	memcpy
	DCD	memcpy                   ; offset=1028 (0x404)

	EXPORT	gp_deoptimize_ptr
gp_deoptimize_ptr
	IMPORT	deoptimize
	DCD	deoptimize               ; offset=1032 (0x408)

	EXPORT	gp_uncommon_trap_ptr
gp_uncommon_trap_ptr
	IMPORT	uncommon_trap
	DCD	uncommon_trap            ; offset=1036 (0x40c)

	EXPORT	gp_get_method_ptr
gp_get_method_ptr
	IMPORT	get_method
	DCD	get_method               ; offset=1040 (0x410)

	EXPORT	gp_trace_bytecode_ptr
gp_trace_bytecode_ptr
	IMPORT	trace_bytecode
	DCD	trace_bytecode           ; offset=1044 (0x414)

	EXPORT	gp_native_system_arraycopy_entry_ptr
gp_native_system_arraycopy_entry_ptr
	DCD	native_system_arraycopy_entry ; offset=1048 (0x418)

	EXPORT	gp_native_jvm_unchecked_byte_arraycopy_entry_ptr
gp_native_jvm_unchecked_byte_arraycopy_entry_ptr
	DCD	native_jvm_unchecked_byte_arraycopy_entry ; offset=1052 (0x41c)

	EXPORT	gp_native_jvm_unchecked_char_arraycopy_entry_ptr
gp_native_jvm_unchecked_char_arraycopy_entry_ptr
	DCD	native_jvm_unchecked_char_arraycopy_entry ; offset=1056 (0x420)

	EXPORT	gp_native_jvm_unchecked_int_arraycopy_entry_ptr
gp_native_jvm_unchecked_int_arraycopy_entry_ptr
	DCD	native_jvm_unchecked_int_arraycopy_entry ; offset=1060 (0x424)

	EXPORT	gp_native_jvm_unchecked_obj_arraycopy_entry_ptr
gp_native_jvm_unchecked_obj_arraycopy_entry_ptr
	DCD	native_jvm_unchecked_obj_arraycopy_entry ; offset=1064 (0x428)

	EXPORT	gp_native_string_indexof_entry_ptr
gp_native_string_indexof_entry_ptr
	DCD	native_string_indexof_entry ; offset=1068 (0x42c)

	EXPORT	gp_native_string_indexof0_entry_ptr
gp_native_string_indexof0_entry_ptr
	DCD	native_string_indexof0_entry ; offset=1072 (0x430)

	EXPORT	gp_jvm_fadd_ptr
gp_jvm_fadd_ptr
	DCD	jvm_fadd                 ; offset=1076 (0x434)

	EXPORT	gp_jvm_fsub_ptr
gp_jvm_fsub_ptr
	DCD	jvm_fsub                 ; offset=1080 (0x438)

	EXPORT	gp_jvm_fmul_ptr
gp_jvm_fmul_ptr
	DCD	jvm_fmul                 ; offset=1084 (0x43c)

	EXPORT	gp_jvm_fdiv_ptr
gp_jvm_fdiv_ptr
	DCD	jvm_fdiv                 ; offset=1088 (0x440)

	EXPORT	gp_jvm_frem_ptr
gp_jvm_frem_ptr
	DCD	jvm_frem                 ; offset=1092 (0x444)

	EXPORT	gp_jvm_dadd_ptr
gp_jvm_dadd_ptr
	DCD	jvm_dadd                 ; offset=1096 (0x448)

	EXPORT	gp_jvm_dsub_ptr
gp_jvm_dsub_ptr
	DCD	jvm_dsub                 ; offset=1100 (0x44c)

	EXPORT	gp_jvm_dmul_ptr
gp_jvm_dmul_ptr
	DCD	jvm_dmul                 ; offset=1104 (0x450)

	EXPORT	gp_jvm_ddiv_ptr
gp_jvm_ddiv_ptr
	DCD	jvm_ddiv                 ; offset=1108 (0x454)

	EXPORT	gp_jvm_drem_ptr
gp_jvm_drem_ptr
	DCD	jvm_drem                 ; offset=1112 (0x458)

	EXPORT	gp_jvm_fcmpl_ptr
gp_jvm_fcmpl_ptr
	DCD	jvm_fcmpl                ; offset=1116 (0x45c)

	EXPORT	gp_jvm_fcmpg_ptr
gp_jvm_fcmpg_ptr
	DCD	jvm_fcmpg                ; offset=1120 (0x460)

	EXPORT	gp_jvm_dcmpl_ptr
gp_jvm_dcmpl_ptr
	DCD	jvm_dcmpl                ; offset=1124 (0x464)

	EXPORT	gp_jvm_dcmpg_ptr
gp_jvm_dcmpg_ptr
	DCD	jvm_dcmpg                ; offset=1128 (0x468)

	EXPORT	gp_jvm_i2d_ptr
gp_jvm_i2d_ptr
	DCD	jvm_i2d                  ; offset=1132 (0x46c)

	EXPORT	gp_jvm_i2f_ptr
gp_jvm_i2f_ptr
	DCD	jvm_i2f                  ; offset=1136 (0x470)

	EXPORT	gp_jvm_l2d_ptr
gp_jvm_l2d_ptr
	DCD	jvm_l2d                  ; offset=1140 (0x474)

	EXPORT	gp_jvm_l2f_ptr
gp_jvm_l2f_ptr
	DCD	jvm_l2f                  ; offset=1144 (0x478)

	EXPORT	gp_jvm_f2i_ptr
gp_jvm_f2i_ptr
	DCD	jvm_f2i                  ; offset=1148 (0x47c)

	EXPORT	gp_jvm_f2l_ptr
gp_jvm_f2l_ptr
	DCD	jvm_f2l                  ; offset=1152 (0x480)

	EXPORT	gp_jvm_f2d_ptr
gp_jvm_f2d_ptr
	DCD	jvm_f2d                  ; offset=1156 (0x484)

	EXPORT	gp_jvm_d2i_ptr
gp_jvm_d2i_ptr
	DCD	jvm_d2i                  ; offset=1160 (0x488)

	EXPORT	gp_jvm_d2l_ptr
gp_jvm_d2l_ptr
	DCD	jvm_d2l                  ; offset=1164 (0x48c)

	EXPORT	gp_jvm_d2f_ptr
gp_jvm_d2f_ptr
	DCD	jvm_d2f                  ; offset=1168 (0x490)

	EXPORT	gp_fixed_interpreter_method_entry_ptr
gp_fixed_interpreter_method_entry_ptr
	DCD	fixed_interpreter_method_entry ; offset=1172 (0x494)

	EXPORT	gp_fixed_interpreter_fast_method_entry_0_ptr
gp_fixed_interpreter_fast_method_entry_0_ptr
	DCD	fixed_interpreter_fast_method_entry_0 ; offset=1176 (0x498)

	EXPORT	gp_fixed_interpreter_fast_method_entry_1_ptr
gp_fixed_interpreter_fast_method_entry_1_ptr
	DCD	fixed_interpreter_fast_method_entry_1 ; offset=1180 (0x49c)

	EXPORT	gp_fixed_interpreter_fast_method_entry_2_ptr
gp_fixed_interpreter_fast_method_entry_2_ptr
	DCD	fixed_interpreter_fast_method_entry_2 ; offset=1184 (0x4a0)

	EXPORT	gp_fixed_interpreter_fast_method_entry_3_ptr
gp_fixed_interpreter_fast_method_entry_3_ptr
	DCD	fixed_interpreter_fast_method_entry_3 ; offset=1188 (0x4a4)

	EXPORT	gp_fixed_interpreter_fast_method_entry_4_ptr
gp_fixed_interpreter_fast_method_entry_4_ptr
	DCD	fixed_interpreter_fast_method_entry_4 ; offset=1192 (0x4a8)

	EXPORT	gp__newobject_ptr
gp__newobject_ptr
	DCD	_newobject               ; offset=1196 (0x4ac)

	EXPORT	gp_interpreter_throw_NullPointerException_ptr
gp_interpreter_throw_NullPointerException_ptr
	DCD	interpreter_throw_NullPointerException ; offset=1200 (0x4b0)

	EXPORT	gp_interpreter_throw_NullPointerException_tos_cached_ptr
gp_interpreter_throw_NullPointerException_tos_cached_ptr
	DCD	interpreter_throw_NullPointerException_tos_cached ; offset=1204 (0x4b4)

	EXPORT	gp_interpreter_throw_IncompatibleClassChangeError_ptr
gp_interpreter_throw_IncompatibleClassChangeError_ptr
	DCD	interpreter_throw_IncompatibleClassChangeError ; offset=1208 (0x4b8)

	EXPORT	gp_interpreter_grow_stack_ptr
gp_interpreter_grow_stack_ptr
	DCD	interpreter_grow_stack   ; offset=1212 (0x4bc)

	EXPORT	gp_interpreter_throw_ArrayIndexOutOfBoundsException_ptr
gp_interpreter_throw_ArrayIndexOutOfBoundsException_ptr
	DCD	interpreter_throw_ArrayIndexOutOfBoundsException ; offset=1216 (0x4c0)
	IMPORT	_rom_linkcheck_hle_true
	DCD	_rom_linkcheck_hle_true  ; offset=1220 (0x4c4)
	IMPORT	_rom_linkcheck_mffd_false
	DCD	_rom_linkcheck_mffd_false ; offset=1224 (0x4c8)
	IMPORT	_rom_linkcheck_mffl_false
	DCD	_rom_linkcheck_mffl_false ; offset=1228 (0x4cc)

	EXPORT	gp_constants_end
gp_constants_end
	; End segment: Global pool


	END
