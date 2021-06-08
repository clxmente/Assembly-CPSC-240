#!/bin/bash
#Program: King of Assembly
#Author: Clemente Solorio

#Delete un-needed files
rm *.o
rm *.out

echo
echo "Assemble interview.asm"
nasm -f elf64 -l interview.lis -o interview.o interview.asm

echo
echo "Compile main.cpp"
gcc -c -Wall -m64 -fno-pie -no-pie -o main.o main.cpp -std=c++17 -lstdc++

echo
echo "Link the object files"
gcc -m64 -no-pie -o final.out -std=c++17 main.o interview.o -lstdc++

echo
echo "Run the program King of Assembly"
./final.out < chris.txt
./final.out < csmajor.txt
./final.out < social.txt

echo
echo "The script file will terminate"