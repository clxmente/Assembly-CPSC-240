//****************************************************************************************************************************
//Program name: "Sum of an Array".  This program implements hybrid programming techniques to calculate the sum of an array   *
//of float numbers. Copyright (C) 2020 Clemente Solorio                                                                      *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
//
//Author information
//  Author name: Clemente Solorio
//  Author email: clem@csu.fullerton.edu
//
//Program information
//  Program name: Sum of an Array
//  Programming languages: One module in C, Three modules in X86, One modules in C++
//  Date program began:     2021-Mar-05
//  Date program completed: 2020-Mar-10
//  Files in this program: main.c, control.asm, fill.asm, sum.asm, display.cpp
//
//This file
//   File name: main.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -fno-pie -no-pie -o main.o main.c
//   Link: gcc -m64 -no-pie -o sumF.out -std=c17 main.o control.o fill.o sum.o display.o    //Ref Jorgensen, page 226, "-no-pie"
//
//
//===================================================== BEGIN CODE AREA ======================================================

#include <stdio.h>

extern double control();

int main() {
    printf("Welcome to High Speed Array Summation by Clemente Solorio.\n");
    printf("Software Licensed by GNU GPL 3.0.\n");
    printf("Version 1.0 released on March 10, 2021\n");

    double sum = control();

    printf("The main has received this number %lf and will keep it\n", sum);
    printf("Thank you for using High Speed Array Software.\n");
    printf("For system support contact Clemente Solorio at clem@csu.fullerton.edu\n");
    printf("A zero will be returned to the operating system.\n");

    return 0;
}