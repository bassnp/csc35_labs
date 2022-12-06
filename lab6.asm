# Jaden Bruha - CSC 35 - Lab 6

.intel_syntax noprefix
.data

StartStatement:
    .ascii "\nA number between 1-100 has been chosen, guess it!\n\0"
LessThan:
    .ascii "Your guess is less than the chosen number!\n\0"
GreaterThan:
    .ascii "Your guess is greater than the chosen number!\n\0"
FoundIt1:
    .ascii "\nCongrats! You have guessed the number!\nIt took you a total of \0"
FoundIt2:
    .ascii " guesses!\n\n\0"
Guess:
    .ascii "\nGuess: \0"

.text
.global _start

_start:
    lea rdx, StartStatement
    call PrintZString

    mov  rdx, 100
    call Random
    add  rdx, 1
    mov  rax, rdx

GuessLoop:
    add rsi, 1
    lea  rdx, Guess
    call PrintZString
    
    call ScanInt
    
    cmp rdx, rax
    je Equal

    cmp rdx, rax
    jl Less

#Greater
    lea  rdx, GreaterThan
    call PrintZString
    jmp GuessLoop 

Less:
    lea  rdx, LessThan
    call PrintZString
    jmp GuessLoop 

Equal:
    lea  rdx, FoundIt1
    call PrintZString
    
    mov  rdx, rsi
    call PrintInt
    
    lea  rdx, FoundIt2
    call PrintZString

    call Exit
