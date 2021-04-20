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
;   File name: fill.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l fill.lis -o fill.o fill.asm
;
;
;===================================================== BEGIN CODE AREA ======================================================
extern scanf
extern printf

global fill

segment .data:
    prompt_one db "Please enter floating point numbers separated by ws.", 10, 0
    instructions db "When finished press enter followed by cntl+D.", 10, 0
    floatformat db "%lf", 0

segment .bss

segment .text

fill:

; Back up all registers and set stack pointer to base pointer
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

push qword -1                           ; Extra push to create even number of pushes

;-----------------------------INITIALIZE PARAMETERS-----------------------------------------

mov qword r15, rdi                 ; Address of array saved to r15.
mov qword r14, rsi                 ; Max number of elements allowed in array.
mov qword r13, 0                   ; set the counter of elements to 0

;-----------------------------INSTRUCTIONS DISPLAY------------------------------------------

;Block to display the prompt message
mov qword rax, 0
mov qword rdi, prompt_one          ; "Please enter floating point numbers separated by ws."
call printf

;Block to display the instructions
mov qword rax, 0
mov qword rdi, instructions        ; "When finished press enter followed by cntl+D."
call printf

;==================================================== START OF THE LOOP ======================================================

beginloop:

;Scanf block to get a number from user input.
push qword 0
mov qword rax, 0
mov qword rdi, floatformat
mov qword rsi, rsp
call scanf

cdqe                               ; cdqe occupies the full rax register to prevent junk in rax.

;CNTL+D CASE EXIT
cmp rax, -1                        ; scanf returns -1 for a cntl+D by the user.
je endloop                         ; if the user wants to exit, jump out of the loop

;----------------------------------COPY NUM INTO THE ARRAY----------------------------------

movsd xmm15, [rsp]                 ; inputted number is at the top of the stack (rsp) and placed in xmm15
pop rax
movsd [r15 + 8 * r13], xmm15         ; move the value into the next quadword of the array in memory.
inc r13                            ; keep count of how many values are in the array.

;----------------------------------CHECK COUNT AGAINST MAX----------------------------------

cmp r13, r14
je exit                            ; if count = max_array_size then jump to end

; if count != max_array_size then restart loop
jmp beginloop                      ; restart loop

endloop:
pop rax
jmp exit

;------------------------------------EXIT---------------------------------------------------
exit:

; Restore all backed up registers to their original state.
pop rax                                 
mov qword rax, r13                      ; Copies # of elements in r13 to rax.
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

