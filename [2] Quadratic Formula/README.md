# Quadratic Formula
This program is designed to calculate the solutions for quadratic equations using hybrid programming techniques. All of the math for this 
program is done in x86 assembly. The assembly file utilizes modules written in C++ to valid user input. Quadratic Formula takes user input for
coefficients and outputs the roots.

Examples of how to do the following:
- Input/Output float numbers in x86
- Assemble and Link C/C++/x86 files
- Call modules written in C/C++ inside of an x86 assembly file.
- Basic arithmetic on float numbers in x86 using `addsd`, `subsd`, `mulsd`, `divsd`.
- Converting strings to floating point numbers using `atof` in x86.
- Utilizing `jmp` to handle errors in user input in x86.
- Using comparison operators (`cmp` and `ucomisd`) and Conditional Control Instructions (`je`, `jb`, etc) in x86 to handle different outcomes. The equivalent of if/then statements in other programming languages.
- Returning a floating point value from an x86 file to a C/C++ driver file.
