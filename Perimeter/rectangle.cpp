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
