;****************************************************************************************************************************
;Program name: "King of Assembly". Copyright (C) 2020 Clemente Solorio                                                      *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
;
;Author information
;  Author name: Clemente Solorio
;  Author email: clem@csu.fullerton.edu
;
;Program information
;  Program name: King of Assembly
;  Programming languages: One module in C++, One module in X86
;  Date program began:     2021-Apr-19
;  Date program completed: 2020-Apr-23
;  Files in this program: main.cpp, interview.asm
;
;This file
;   File name: interview.asm
;   Language: X86
;   Max page width: 132 columns
;   Compile: nasm -f elf64 -l interview.lis -o interview.o interview.asm
;   Link: gcc -m64 -no-pie -o final.out -std=c++17 main.o interview.o -lstdc++    //Ref Jorgensen, page 226, "-no-pie"
;
;
;===================================================== BEGIN CODE AREA ======================================================
extern printf
extern scanf

global interview

segment .data:
    greeting db "Hello %s. I am Ms. Fenster. The interview will begin now.", 10, 0
    sawyer   db "Wow! $%.2lf That's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?", 0
    goodbye  db 10,"Thank you. Please follow the exit signs to the front desk.", 10, 0

    ;formats
    y_n         db "%s", 0
    floatformat db "%lf", 0

    ;Resistance Prompts
    electricity    db 10,"Alright. Now we will work on your electricity.", 10, 0
    resistance_one db "Please enter the resistance of circuit #1 in ohms: ", 0
    resistance_two db 10,"What is the resistance of circuit #2 in ohms: ", 0
    total_res      db 10,"The total resistance is %.8lf Ohms.", 10, 0

    cs_major_q db "Were you a computer science major (y or n)?", 0

segment .bss

segment .text

interview: 
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

;Save the arguments passed (Name and Salary) into safe registers
mov   r15, rdi                ; store the name array
movsd xmm15, xmm0             ; store the salary

;Welcome message
push qword 0
mov  qword rax, 0
mov  qword rdi, greeting 
mov  qword rsi, r15
call printf                   ; "Hello {name}. I am Ms. Fenster. The interview will begin now."
pop rax


;Chris Sawyer Prompt
push qword 0
mov  qword rax, 1
mov  qword rdi, sawyer
movsd xmm0, xmm15
call printf                   ; "Wow! ${salary} That's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?"
pop rax

;Chris Sawyer Input
push qword 0
mov  qword rdi, y_n
mov  qword rsi, rsp
call scanf
pop rax

;compare the answer to 'y'
mov r13, 'y'
cmp rax, r13
je chris_sawyer               ; if user is Chris Sawyer, jump to chris_sawyer case.

;============================================== Section for RESISTANCE ==================================================

;explanation
push qword 0
mov  qword rax, 0
mov  qword rdi, electricity 
call printf                   ; "Alright. Now we will work on your electricity."
pop rax

;Resistance one prompt
push qword 0
mov  qword rax, 0
mov  qword rdi, resistance_one 
call printf                   ; "Please enter the resistance of circuit #1 in ohms:"
pop rax

;Resistance one input
push qword 0
mov  qword rdi, floatformat
mov  qword rsi, rsp
call scanf
movsd xmm14, [rsp]            ; inputted num is at the top of the stack (rsp) and saved in xmm14
pop rax

;Resistance two prompt
push qword 0
mov  qword rax, 0
mov  qword rdi, resistance_two
call printf                   ; "What is the resistance of circuit #2 in ohms: "
pop rax

;Resistance two input
push qword 0
mov  qword rdi, floatformat
mov  qword rsi, rsp
call scanf
movsd xmm13, [rsp]            ; inputted num is at the top of the stack (rsp) and saved in xmm13
pop rax

xorps xmm14, xmm13
xorps xmm13, xmm14
xorps xmm14, xmm13
; --------------------------- Calculate the resistance -------------------------

;(1/R) = (1.0/R1) + (1.0/R2) 
mov r8, 1
cvtsi2sd xmm12, r8 ; convert r8 and place it in xmm12
movsd xmm11, xmm12 ; backup of the 1.0

divsd xmm12, xmm14 ; divide 1 by R1
movsd xmm14, xmm12 ; move the result into xmm14

movsd xmm12, xmm11 ; restore xmm12 back to 1 for division
divsd xmm12, xmm13 ; divide 1 by R2
movsd xmm13, xmm12 ; move the result into xmm13

;add the results for R
addsd xmm14, xmm13 ; (1/R1) + (1/R2)


;calculate 1/R for the final answer
movsd xmm12, xmm11 ; restore xmm12 back to 1 for division
divsd xmm12, xmm14 ; divide 1 by R, final result will be in xmm12

;display this result
push qword 0
mov  qword rax, 1
mov  qword rdi, total_res
movsd xmm0, xmm12
call printf                   ; "The total resistance is {resistance} Ohms."
pop rax

; --------------------------- CS MAJOR PROMPT -------------------------
;CS Major Prompt
push qword 0
mov  qword rax, 1
mov  qword rdi, cs_major_q
movsd xmm0, xmm15
call printf                   ; "Wow! ${salary} That's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?"
pop rax

;CS Major Input
push qword 0
mov  qword rdi, y_n
mov  qword rsi, rsp
call scanf
pop rax

;compare the answer to 'y'
mov r13, 'y'
cmp rax, r13
je cs_major                   ; if user is a cs major, jump to cs_major case.

social_major:
mov rax, 0x4092C07AE147AE14   ; 0x4092C07AE147AE14 = 1,200.12 and we put it in rax.
movq xmm15, rax               ; xmm15 is the salary so we set our offer to 12,00.12
jmp exit

cs_major:
mov rax, 0x40F57C0E147AE148   ; 0x40F57C0E147AE148 = 88,000.88 and we put it in rax.
movq xmm15, rax               ; xmm15 is the salary so we set our offer to 88,000.88
jmp exit

chris_sawyer:
mov rax, 0x412E848000000000   ; 0x412E848000000000 = 1,000,000 and we put it in rax.
movq xmm15, rax               ; xmm15 is the salary so we set our offer to 1,000,000
jmp exit

exit:

;Goodbye message
push qword 0
mov  qword rax, 0
mov  qword rdi, goodbye
call printf                   ; "Thank you. Please follow the exit signs to the front desk."
pop rax

; Restore all registers to their original state.
pop rax
movsd xmm0, xmm15             ; value to be returned from control.asm to main.c will be in xmm0.                            
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