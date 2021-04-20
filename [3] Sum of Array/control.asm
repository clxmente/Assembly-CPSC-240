;****************************************************************************************************************************
;Program name: "Sum of an Array".  This program implements hybrid programming techniques to calculate the sum of an array   *
;of float numbers. Copyright (C) 2020 Clemente Solorio                                                                      *
;                                                                                                                           *
;This file is part of the software program "Sum of an Array".                                                               *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=====
;
;Author information
;  Author name: Clemente Solorio
;  Author email: clem@csu.fullerton.edu
;
;Program information
;  Program name: Sum of an Array
;  Programming languages: One module in C, Three modules in X86, One modules in C++
;  Date program began: 2021-Mar-05
;  Date of last update: 2021-Mar-10
;  Files in this program: main.c, control.asm, fill.asm, sum.asm, display.cpp
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.
;
;This file
;   File name: control.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l control.lis -o control.o control.asm
;
;
;===================================================== BEGIN CODE AREA ======================================================
extern printf
extern scanf

extern fill
extern sum
extern display

max_array_size equ 10 ; maximum number of elements allowed to be inputted into the array

global control

segment .data:
    welcome db "Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Clemente S.", 10, 10, 0
    numbers db "The numbers you entered are these:", 10, 0
    sum_values db "The sum of these values is %.8lf .", 10, 0
    goodbye db "The control module will now return the sum to the caller module.", 10, 0

segment .bss
    floatArray resq 10

segment .text

control:
;Prolog ===== Insurance for any caller of this assembly module =================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backp rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf

;Registers rax, rip, and rsp are usually not backed up.
push qword 0


; ---------------------------Reserve space for parameters-------------------------

mov qword r14, 0                   ; r14 will be the number of elements in the array

mov qword r13, 0                   ; need to set xmm15 to 0 so that no previous number interrupts our sum
cvtsi2sd xmm15, r13                ; convert to a float and store in xmm15 where the sum will be held

;------------------------------ Welcome prompt -----------------------------------

;Welcome message block
push qword 0
mov qword rax, 0
mov qword rdi, welcome
call printf
pop rax

;=============================================== Section to call the FILL function ================================================

;Block to call the fill function from fill.asm
mov qword rax, 0
mov qword rdi, floatArray          ; Passes array into the rdi register.
mov qword rsi, max_array_size      ; passes the max array size into rsi
call fill
mov r14, rax                       ; function fill returns the number of elements into the array into rax. save into r14.

;============================================== Section to call the DISPLAY function ==============================================

;Print a statement before calling the display function from display.cpp
push qword 0
mov qword rax, 0
mov qword rdi, numbers
call printf
pop rax

;Block to call the display function
push qword 0
mov qword rdi, floatArray          ; rdi is the first parameter when calling. We set this to the array.
mov qword rsi, r14                 ; rsi is the second parameter in a function. We set this to the number of elements in the array.
mov qword rax, 0
call display
pop rax

;============================================== Section to call the SUM function ==================================================

;Block to call the sum function from sum.asm
mov qword rax, 0
mov qword rdi, floatArray          ; passes the floatArray to the sum function
mov qword rsi, r14                 ; passes the number of elements in the array to rsi for the sum function
call sum
movsd xmm15, xmm0                  ; sum returns the value to xmm0. We save this value in xmm15.

;------------------------------ DISPLAY THE SUM TO BE RETURNED TO MAIN -----------------------------------

;Block to display the sum of the array
push qword 0
mov qword rax, 1
mov qword rdi, sum_values
movsd xmm0, xmm15                  ; passes the sum of the values to print
call printf                        ; prints "The sum of these values is %.8lf."
pop rax

;Block to say this will be returned to main
mov qword rax, 0
mov qword rdi, goodbye
call printf

;============================================================ END =================================================================

; Restore all registers to their original state.
pop rax
movsd xmm0, xmm15                  ; value to be returned from control.asm to main.c will be in xmm0.                            
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret