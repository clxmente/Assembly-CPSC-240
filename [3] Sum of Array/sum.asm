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
;   File name: sum.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l sum.lis -o sum.o sum.asm
;
;
;===================================================== BEGIN CODE AREA ======================================================
global sum

section .data

section .bss

section .text

sum:

; Back up all registers to stack and set stack pointer to base pointer
push rbp
mov rbp, rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf

push qword -1                      ; Extra push onto stack to make even # of pushes.

;-----------------------------INITIALIZE PARAMETERS-----------------------------------------

mov qword r15, rdi                 ; Address of array saved to r15.
mov qword r14, rsi                 ; Save the number of elements to r14.

mov qword r13, 0                   ; need to set xmm15 to 0 so that no previous number interrupts our sum
cvtsi2sd xmm15, r13                ; convert to a float and store in xmm15 where the sum will be held

mov qword r12, 0                   ; r12 will be the counter when iterating through array.

;==================================================== START OF THE LOOP ======================================================

beginloop:

; Compare the counter to the number of elements in the array. r12 is the count, r14 is the # of elements.
cmp r12, r14                        
jge endloop

;-------------------------------------- SUM INTO r13 ---------------------------------------

;add the element at index r12 into r13
addsd xmm15, [r15 + 8 * r12]
inc r12                            ; increment the count each time we iterate through it

;restart the loop to add the next number
jmp beginloop

endloop:

; Restores all backed up registers to their original state.
pop rax                                
movsd xmm0, xmm15              ; Our sum is stored in xmm15. Move this to xmm0 to return the value
popf                                                       
pop rbx                                                     
pop r15                                                     
pop r14                                                      
pop r13                                                      
pop r12                                                      
pop r11                                                     
pop r10                                                     
pop r9                                                      
pop r8                                                      
pop rcx                                                     
pop rdx                                                     
pop rsi                                                     
pop rdi                                                     
pop rbp

ret