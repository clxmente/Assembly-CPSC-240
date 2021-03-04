;****************************************************************************************************************************
;Program name: "Root Calculator".  This program implements hybrid programming techniques to calculate the roots of a        *
;a quadratic equation given user input for the coefficients.  Copyright (C) 2020 Clemente Solorio                           *
;                                                                                                                           *
;This file is part of the software program "Root Calculator".                                                               *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************
;
;========1=========2=========3=========4=========5=========6=========7=========8
;Program information
;  Program name: Root Calculator
;  Programming languages: Two modules in C++, one module in X86, one module in C
;  Date program began: 2021-Feb-22
;  Date of last update: 2021-Feb-26
;  Files in this program: isfloat.cpp, quad_lib.cpp, quadratic.asm, second_degree.c
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.
;
;This file
;   File name: quadratic.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm
;
;
;===== Begin code area =========================================================
extern printf
extern scanf
extern atof

extern isfloat
extern show_no_root
extern show_one_root
extern show_two_roots

global quadratic

segment .data:
expl db "This program will find the roots of any quadratic equation.", 10, 0
prompt db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by white spaces. Then press enter: ", 0
equation db "Thank you. The equation is %.6lfx^2 + %.6lfx + %.6lf = 0.0", 10, 0
end db "One of these roots will be returned to the caller function.", 10, 0
stringformat db "%s", 0
invalid_input db "Invalid input data detected. You may run this program again.", 10, 0
this_number db "This is the number: %lf", 10, 0

segment .bss

segment .text

quadratic:
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

;Welcome message
mov rax, 0
mov rdi, expl
call printf

sub rsp, 256 ; reserve space for a potentially longer string 

;============= Section to input the coefficients ================================
;Display Coefficient prompt
push qword 0
mov rax, 0
mov rdi, prompt
call printf
pop rax

;--------------------Section for coefficient a------------------------------------
;scanf block to get the first coefficient, a
mov rax, 0
mov rdi, stringformat
mov rsi, rsp
call scanf

;Block to validate the input
mov rdi, rsp
call isfloat
mov r15, rax ; isfloat returns a 0 or non zero. make a copy of the result to check for validity

cmp r15, 0 ; if isfloat returns 0, it is not a valid input, else it is valid.
je invalid_detected

;if rax is not 0, this code will execute
;block to convert a string to a floating point number using atof
mov rax, 0
mov rdi, rsp
call atof
movsd xmm15, xmm0 ; save the valid input into xmm15 (a)

; block to check if a = 0 
mov r11, 0
cvtsi2sd xmm8, r11
ucomisd xmm8, xmm15
je invalid_detected
add rsp, 256

;---------------------Section for coefficient b---------------------------------
;scanf block to get the second coefficient, b
sub rsp, 256
mov rax, 0
mov rdi, stringformat
mov rsi, rsp
call scanf

;Block to validate the input
mov rdi, rsp
call isfloat
mov r15, rax ; isfloat returns a 0 or non zero. make a copy of the result to check for validity

cmp r15, 0 ; if isfloat returns 0, it is not a valid input, else it is valid.
je invalid_detected

;if rax is not 0, this code will execute
;block to convert a string to a floating point number using atof
mov rax, 0
mov rdi, rsp
call atof
movsd xmm14, xmm0 ; save the valid input into xmm14 (b)
add rsp, 256

;---------------------Section for coefficient c---------------------------------
;scanf block to get the second coefficient, b
sub rsp, 256
mov rax, 0
mov rdi, stringformat
mov rsi, rsp
call scanf

;Block to validate the input
mov rdi, rsp
call isfloat
mov r15, rax ; isfloat returns a 0 or non zero. make a copy of the result to check for validity

cmp r15, 0 ; if isfloat returns 0, it is not a valid input, else it is valid.
je invalid_detected

;if rax is not 0, this code will execute
;block to convert a string to a floating point number using atof
mov rax, 0
mov rdi, rsp
call atof
movsd xmm13, xmm0 ; save the valid input into xmm13 (c)
add rsp, 256

;Display equation
mov rax, 3
mov rdi, equation
movsd xmm0, xmm15 ; a
movsd xmm1, xmm14 ; b
movsd xmm2, xmm13 ;c
call printf

;============= Section to calculate the roots ==================================
;-------------Section to calculate the discriminant ----------------------------
; b^2 - 4ac
movsd xmm10, xmm14 ; make a copy of b
mulsd xmm10, xmm10 ; b * b = b^2

movsd xmm12, xmm15 ; copy of a to be manipulated
mulsd xmm12, xmm13 ; a * c stored in xmm12

mov r15, 4
cvtsi2sd xmm11, r15 ; convert the 4 into a float and store it in xmm11
mulsd xmm11, xmm12 ; 4(ac) stored in xmm11

subsd xmm10, xmm11 ; (xmm10)[b^2] - [4ac](xmm11) stored in xmm10

;---------------Section to decide # of roots-------------------------------------
; d < 0 -> no roots
; d = 0 -> one root
; d > 0 -> two roots
push qword 0
movsd xmm11, [rsp] ; save the 0 to xmm11 for comparison
pop rax
ucomisd xmm10, xmm11 ; compare the disciminant to 0
jb noroots ; xmm10(d) < xmm11(0) jump to noroots:
je oneroot ; xmm10(d) = xmm11(0) jump to oneroot:

;===============================two roots========================================
;-------------------------numerator calculations--------------------------------
sqrtsd xmm12, xmm10 ; sqrt(xmm10) and save it in xmm12

; Block to calculate -b
mov r14, -1
cvtsi2sd xmm11, r14 ; convert -1 and save it to xmm11 to get -b later
mulsd xmm11, xmm14 ; -1 * b = -b and now xmm11 holds -b

movsd xmm10, xmm11 ; make a copy of -b for the second calculation
addsd xmm11, xmm12 ; -b + sqrt(d) saved in xmm11
subsd xmm10, xmm12 ; -b - sqrt(d) saved in xmm10

;-----------------------------denominator-----------------------------------------
mov r13, 2
cvtsi2sd xmm9, r13
mulsd xmm9, xmm15 ; 2*a

;final division
divsd xmm11, xmm9 ; [-b + sqrt(d)] / [2a] saved in xmm11
divsd xmm10, xmm9 ; [-b - sqrt(d)] / [2a] saved in xmm10

mov rax, 2
mov rdi, rsp
movsd xmm0, xmm11
movsd xmm1, xmm10
call show_two_roots
jmp endofcase

noroots:
mov rax, 0
mov rdi, rsp
call show_no_root
jmp endofcase

oneroot:
; -b / 2a = root
; Block to calculate -b
mov r14, -1
cvtsi2sd xmm11, r14 ; convert -1 and save it to xmm11 to get -b later
mulsd xmm11, xmm14 ; -1 * b = -b and now xmm11 holds -b

;denominator (2a)
mov r13, 2
cvtsi2sd xmm9, r13
mulsd xmm9, xmm15 ; 2*a

divsd xmm11, xmm9 ; -b/2a and xmm11 holds the root

mov rax, 1
mov rdi, rsp
movsd xmm0, xmm11
call show_one_root
jmp endofcase


invalid_detected:
add rsp, 256 ; if invalid input was detected we need to restore the stack.
mov rax, 0
mov rdi, invalid_input
call printf
jmp endofcase

endofcase:
movsd xmm0, xmm11
;===== Restore original values to integer registers ============================
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
