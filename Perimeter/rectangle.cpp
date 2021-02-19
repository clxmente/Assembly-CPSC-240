//****************************************************************************************************************************
//Program name: "Perimeter".  This program calculates the perimeter and average side of a rectangle using user inputted      *
//float numbers. Copyright (C) 2021 Clemente Solorio                                                                         *
//                                                                                                                           *
//This file is part of the software program "Perimeter".                                                                     *
//Perimeter is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License     *
//version 3 as published by the Free Software Foundation.                                                                    *
//Perimeter is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied            *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//This file
//   File name: rectangle.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17
//   Link: gcc -m64 -no-pie -o perimeterF.out -std=c++17 rectangle.o perimeter.o
#include <stdio.h>

extern "C" double perimeter();

int main() {
  printf("Welcome to a friendly assembly program by Clemente Solorio.\n");
  double ret_perimeter = perimeter();
  printf("The main function received this number %3.6lf and has decided to keep it.\n", ret_perimeter);
  printf("A 0 will be returned to the operating system.\nHave a nice day.\n");

  return 0;
}
