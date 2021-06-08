//****************************************************************************************************************************
//Program name: "King of Assembly". Copyright (C) 2020 Clemente Solorio                                                      *
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
//  Program name: King of Assembly
//  Programming languages: One module in C++, One module in X86
//  Date program began:     2021-Apr-19
//  Date program completed: 2020-Apr-23
//  Files in this program: main.cpp, interview.asm
//
//This file
//   File name: main.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -fno-pie -no-pie -o main.o main.cpp -std=c++17 -lstdc++
//   Link: gcc -m64 -no-pie -o final.out -std=c++17 main.o interview.o -lstdc++         //Ref Jorgensen, page 226, "-no-pie"
//
//
//===================================================== BEGIN CODE AREA ======================================================

#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" double interview(char name[], double exp_salary);

int main() {
    
    char Name[100];
    double Salary;

    printf("Welcome to Software Analysis by Paramount Programmers, Inc.\n");
    
    // Ask the user to input their name and store it in the variable "Name"
    cout << "Please enter your first and last names and press enter: ";
    cin.getline(Name, sizeof(Name)); // Get the input with a space, and store it in Name

    cout << "\nThank you " << Name << ". Our records show that you applied for employment here with our agency a week ago." << endl;

    // Ask the user to input their expected salary and store it in the variable "Salary"
    cout << "Please enter your expected annual salary when employed at Paramount: ";
    cin >> Salary; // get the input and store it in Salary.
    printf("\nYour interview with Ms. Linda Fenster, Personnel Manager, will begin shortly.\n\n");

    // Call the interview module and pass in as arguments the name and expected salary of the user.
    // Store the returned value from the interview module into the "Salary" variable.
    Salary = interview(Name, Salary);

    //----------------------------------------- Compare the returned value to determine who we're interviewing ------------------------------------------
    if (Salary == 88000.88) { // CS MAJOR CASE
        cout << "\nHello " << Name << ", I am the receptionist." << endl;
        printf("This envelope contains your job offer with starting salary $%.2lf. Please check back on Monday morning at 8am.\nBye.\n", Salary);
    }
    else if (Salary == 1000000) { // CHRIS SAWYER CASE
        printf("\nHello Mr. Sawyer. I am the receptionist.\nThis envelope has your job offer starting at 1 million annual. ");
        printf("Please start any time you like. In the middle time our CTO wishes to have dinner with you. ");
        printf("Have a very nice evening Mr. Sawyer.\n");
    }
    else if (Salary == 1200.12) { // SOCIAL SCIENCE MAJOR CASE
        cout << "\nHello " << Name << ", I am the receptionist." << endl;
        printf("We have an opening for you in the company cafeteria for $%.2lf annually.\nTake your time to let us know your decision.\nBye.\n", Salary);
    }

    return 0;
}