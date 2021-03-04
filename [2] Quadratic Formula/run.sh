#!/bin/bash

#Program: Root Calculator
#Author: Clemente Solorio

#Delete un-needed files
rm *.o
rm *.out

echo
echo "Assemble quadratic.asm"
nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm

echo
echo  "Compile second_degree.c"
gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c17

echo
echo "Compile quad_lib.cpp"
gcc -c -m64 -Wall -fno-pie -no-pie -o quad_lib.o quad_lib.cpp -std=c++17

echo
echo "Compile isfloat.cpp"
gcc -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17 -lstdc++

echo
echo "Link the object files"
gcc -m64 -no-pie -o quadraticF.out -std=c17 second_degree.o quadratic.o quad_lib.o isfloat.o

echo
echo "Run the program resistance"
./quadraticF.out

echo
echo "The script file will terminate"