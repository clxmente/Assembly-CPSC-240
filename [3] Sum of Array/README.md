# Sum of an Array
This program is designed to calculate the sum of an array declared inside of an X86 assembly module. The array is filled in a separate X86
module and then passed to a third module that computes the sum of the array that was given.

Examples of how to do the following:
- Input/Output float numbers in x86 assembly.
- Assemble and Link C/C++/x86 files.
- Call modules written in C/C++ inside of an x86 assembly file.
- Call modules written in X86 assembly inside of another x86 assembly file.
- Basic arithmetic on float numbers in x86 assembly using `addsd`, `subsd`, `mulsd`, `divsd`.
- Using comparison operators (`cmp` and `ucomisd`) and Conditional Control Instructions (`je`, `jb`, etc) in x86 to handle different outcomes. The equivalent of if/then statements in other programming languages.
- Returning a floating point value from an x86 file to a C/C++ driver file.
- Iterate through an array in X86 assembly.

## Files in this program
One module in C, Three modules in X86 assembly, and One module in C++
### main.c (C)
- Purpose: Main driver module which calls the **control** module.
- Calls: **control**.
- Compile: `gcc -c -Wall -m64 -fno-pie -no-pie -o main.o main.c`
### control.asm (X86 assembly)
- Purpose: Initialize the array, call the other X86 modules, and return the final sum from within this module.
- Calls: [fill](https://github.com/clxmente/Assembly-CPSC-240/tree/main/%5B3%5D%20Sum%20of%20Array#fillasm-x86-assembly), sum, **display**.
- Prototype: `double control();`
- Returns: a float number representing the sum.
- Assemble: `nasm -f elf64 -l control.lis -o control.o control.asm`
### fill.asm (X86 assembly)
- Purpose: Fill the array initialized in **control** with float numbers from user input. Return the array back to **control**.
- Prototype: `int fill(double array[], long max_size);`
- Returns: an int representing the number the number of elements in the array.
- Assemble: `nasm -f elf64 -l fill.lis -o fill.o fill.asm`
### sum.asm (X86 assembly)
- Purpose: Takes the array of floats and compute the sum of all the elements.
- Prototype: `double sum(double array[]);`
- Returns: a float number representing the sum
- Assemble: `nasm -f elf64 -l control.lis -o control.o control.asm`
### display.cpp (C++)
- Purpose: Display all the elements in the array
- Prototype: `void display(double array[], long size);`
- Compile: `gcc -c -m64 -Wall -fno-pie -no-pie -o display.o display.cpp -std=c++17`

link all the files `gcc -m64 -no-pie -o sumF.out -std=c17 main.o control.o fill.o sum.o display.o`

### Running the program
This program was tested inside of Windows Subsystem for Linux (WSL).  
It can be run by executing the bash file using `sh script.sh`
