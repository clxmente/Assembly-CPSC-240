#!/bin/bash
#Program: Sum of an Array
#Author: Clemente Solorio

#Delete un-needed files
rm *.o
rm *.out

echo
echo "Assemble control.asm"
nasm -f elf64 -l control.lis -o control.o control.asm

echo
echo "Assemble fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm

echo
echo "Assemble sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo
echo "Compile main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo
echo "Compile display.cpp"
gcc -c -m64 -Wall -fno-pie -no-pie -o display.o display.cpp -std=c++17

echo
echo "Link the object files"
gcc -m64 -no-pie -o sumF.out -std=c17 main.o control.o fill.o sum.o display.o

echo
echo "Run the program Sum of an Array"
./sumF.out

echo
echo "The script file will terminate"