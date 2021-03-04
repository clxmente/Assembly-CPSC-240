//****************************************************************************************************************************
//Program name: "isfloat".  This is a single function distributed without accompanying software.  This function scans a      *
//char array seeking to confirm that all characters in the array are in the range of ascii characters '0' .. '9'.  Further-  *
//more, this function confirms that there is exactly one decimal point in the string.  IF both conditions are true then a    *
//boolean true is returned, otherwise a boolean false is returned.  Copyright (C) 2020 Floyd Holliday                        *
//                                                                                                                           *
//This is a library function distributed without accompanying software.                                                      *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public   *
//License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be   *
//useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.*
//See the GNU Lesser General Public License for more details.  A copy of the GNU Lesser General Public License 3.0 should    *
//have been distributed with this function.  If the LGPL does not accompany this software then it is available here:         *
//<https:;www.gnu.org/licenses/>.                                                                                            *
//****************************************************************************************************************************
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Floyd Holliday
//  Author email: unavailable
//
//This file
//  Program name: isfloat
//  File name: isfloat.cpp
//  Date development began: 2020-Dec-12
//  Date of last update:  2020-Dec-14
//  Comments reorganized: 2020-Dec-14
//  This is a library function.  It does not belong to any one specific application.  The function is available for inclusion 
//  in other applications.  If it is included in another application and there are no modifications made to the executing 
//  statements in this file then do not modify the license and do not modify any part of this file; use it as is.
//  Language: C++
//  Max page width: 132 columns
//  Optimal print specification: monospace, 132 columns, 8½x11 paper
//  Testing: This function was tested successfully on a Linux platform derived from Ubuntu.
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17
//  Classification: Library
//
//Purpose
//  Scan a contiguous segment of memory from the starting byte to the null character and determine if the string of chars is properly 
//  formatted for conversion to a valid float number.  This function, isfloat, does not perform the conversion itself.  That task is 
//  is done by a library function such as atof.
//
//Future project
//  Re-write this function in X86 assembly.
//
//How to call isfloat from an X86 function
//  == Declare isfloat to exist in another file: extern isfloat
//  == Obtain an address pointing to starting byte in memory.  Such an address can be a register like rsp.  Also, the address may
//     be provide by the name of an array.   For example, "mystuff resq 300" declares an array of 300 bytes,  The name "mystuff" may
//     be used as the start of block of memory.
//  == Do the setup block for isfloat:
//     == mov rax,0
//     == mov rdi, <a memory location>    such as mov rdi, rsp, or mystuff
//     == call isfloat
//     == The boolean result is returned in rax.  If rax holds exactly 0 then 'false' was returned, otherwise 'true' was returned.

//How to call isfloat from a C function
//  ==Place the prototype near the top of the calling function:  bool isinteger(char []);
//  ==Declare a bool variable:  bool outcome;
//  ==Create an array:  char wonder[200];
//  ==Fill the array with a null-terminate sequence of chars.  Usually this sequence comes from an input device like stdin (keyboard).
//  ==Call the function: outcome = isfloat(wonder)
//  ==Test outcome for true = "It is a float number" or false = "It is not a float number".

//How to call isfloat from a C++ function
//  ==Place the prototype near the top of the calling function:  extern "C" bool isinteger(char []);
//  ==Declare a bool variable:  bool outcome;
//  ==Create an array:  char wonder[200];
//  ==Fill the array with a null-terminate sequence of chars.  Usually this sequence comes from an input device like stdin (keyboard).
//  ==Call the function: outcome = isfloat(wonder)
//  ==Test outcome for true = "It is a float number" or false = "It is not a float number".


#include <stdio.h>
#include <ctype.h>

extern "C" bool isfloat(char [ ]);

bool isfloat(char w[ ])
{   bool result = true;
    bool onepoint = false;
    int start = 0;
    if (w[0] == '-' || w[0] == '+') start = 1;
    unsigned long int k = start;
    while (!(w[k] == '\0') && result )
    {    if (w[k] == '.' && !onepoint) 
               onepoint = true;
         else
               result = result && isdigit(w[k]) ; 
         k++;
     }
     return result && onepoint;
}