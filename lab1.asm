.intel_syntax noprefix
.data

Greeting:
    .ascii "Wassup world.\n\0"
Name:
    .ascii "My name is Jaden Bruha\n\0"
Quote:
    .ascii "DO SOMETHING FUN THIS WEEKEND! - Devin Cook\n\0"
Year:
    .ascii "In the year 2022, I wrote this program.\n\0"

.text
.global _start

_start:
    lea  rdx, Greeting
    call PrintZString
    
    lea  rdx, Name
    call PrintZString

    lea  rdx, Quote
    call PrintZString

    lea  rdx, Year
    call PrintZString
    
    call Exit
