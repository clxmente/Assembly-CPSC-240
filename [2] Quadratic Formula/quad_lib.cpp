//****************************************************************************************************************************
//Program name: "Root Calculator".  This program implements hybrid programming techniques to calculate the roots of a        *
//a quadratic equation given user input for the coefficients.  Copyright (C) 2020 Clemente Solorio                           *
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
//  Program name: Root Calculator
//  Programming languages: One module in C, one module in X86, 2 modules in C++
//  Date program began:     2021-Feb-22
//  Date program completed: 2020-Feb-27
//  Files in this program: second_degree.c, quadratic.asm, quad_lib.cpp, isfloat.cpp
//
//This file
//   File name: quad_lib.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -o quad_lib.o quad_lib.cpp -std=c++17
//   Link: gcc -m64 -no-pie -o quadraticF.out -std=c17 second_degree.o quadratic.o quad_lib.o isfloat.o    //Ref Jorgensen, page 226, "-no-pie"
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>

extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_roots(double root1, double root2);

void show_no_root() {
    printf("There are no roots for this equation\n");
}

void show_one_root(double root) {
    printf("The root is %lf \n", root);
}

void show_two_roots(double root1, double root2){
    printf("The roots are %lf and %lf \n", root1, root2);
}