#!/bin/bash

#Program: perimeter
#Author: Clemente Solorio

#Delete un-needed files
rm *.o
rm *.out

echo
echo "Assemble perimeter.asm"
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

echo
echo  "Compile rectangle.cpp"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17

echo
echo "Link the object files"
gcc -m64 -no-pie -o perimeterF.out -std=c++17 rectangle.o perimeter.o

echo
echo "Run the program Perimeter"
./perimeterF.out

echo
echo "The script file will terminate"
