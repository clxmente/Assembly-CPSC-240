;========1=========2=========3=========4=========5=========6=========7=========8
;Program information
;  Program name: Perimeter of a Rectangle
;  Programming languages: One modules in C++ and one module in X86
;  Date of last update: 2021-Feb-10
;  Files in this program: rectangle.cpp, perimeter.asm
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.
;
;This file
;   File name: perimeter.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm


;===== Begin code area =========================================================
extern printf
extern scanf

global perimeter

segment .data:
expl db "This program will compute the perimeter and the average side length of a rectangle.", 10, 0
height_prompt db "Enter the height: ", 0
width_prompt db "Enter the width: ", 0
final_perim db "The perimeter is %.3lf", 10, 0
avg_side db "The length of the average side is %.3lf", 10, 0
enjoy db "I hope you enjoyed your rectangle.", 10, 0
goodbye db "The assembly program will send the perimeter to the main function", 10, 0
floatformat db "%lf", 0
;testformat db "Inputted number is %3.6lf", 10, 0

segment .bss

segment .text

perimeter:
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

;Display the purpose of the program
mov rax, 0
mov rdi, expl
call printf

;============= Section to input the height =====================================
;Display the height prompt
push qword 0
mov rax, 0
mov rdi, height_prompt
call printf
pop rax

;scanf block to get the height
push qword 0
mov rax, 0
mov rdi, floatformat
mov rsi, rsp
call scanf
movsd xmm15, [rsp] ;inputted number is at the top of the stack (rsp) and placed in xmm15

;display the number we just got
;mov rax, 1
;mov rdi, testformat
;movsd xmm0, xmm15
;call printf

pop rax ;reverse the push in the scanf block

;============= Section to input the width ======================================
;Display the width prompt
push qword 0
mov rax, 0
mov rdi, width_prompt
call printf
pop rax

;scanf block to get the width
push qword 0
mov rax, 0
mov rdi, floatformat
mov rsi, rsp
call scanf
movsd xmm14, [rsp] ;inputted number is at the top stack (rsp) and placed in xmm14

;display the width just entered
;mov rax, 1
;mov rdi, testformat
;movsd xmm0, xmm14
;call printf

pop rax ;reverse the push in the scanf block

;============= Section to calc the perimeter ===================================
;P = 2h + 2w
;find the perimeter
movsd xmm13, xmm15 ; move the height into xmm13
addsd xmm13, xmm15 ; 2 * h (h + h)
addsd xmm13, xmm14
addsd xmm13, xmm14 ; + 2*w and now xmm13 hold the perimeter

;display perimeter
push qword 0
mov rax, 1
mov rdi, final_perim
movsd xmm0, xmm13
call printf
pop rax

;============= Section to calc avg length ======================================
;calculate avg side
mov r8, 4
cvtsi2sd xmm12, r8 ; convert r8 and place it into xmm12
divsd xmm13, xmm12 ; divide the perimeter by xmm12
movsd xmm11, xmm13 ; move the answer into xmm11

;display avg length
push qword 0
mov rax, 1
mov rdi, avg_side
movsd xmm0, xmm11
call printf
pop rax

;Enjoy message
push qword 0
mov rax, 0
mov rdi, enjoy
call printf
pop rax

;goodbye message
push qword 0
mov rax, 0
mov rdi, goodbye
call printf
pop rax


;===== Restore original values to integer registers ============================
pop rax
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

movsd xmm0, xmm13 ; float functions return the value in xmm0
ret
