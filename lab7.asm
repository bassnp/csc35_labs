# Jaden Bruha - CSC 35 - Lab 6

.intel_syntax noprefix
.data

question_1:
    .ascii "How much was the bill?\n\0"
question_2:
    .ascii "How many people are splitting the bill?\n\0"
statement_1:
    .ascii "Each person has to pay $\0"
statement_2:
    .ascii ".\n\0"

.text
.global _start
    
_start:

bill_loop:
    lea  rdx, question_1
    call PrintZString
    call ScanInt
    
    cmp rdx, 0
    jl  bill_loop

    mov rax, rdx # Numerator

split_loop:
    lea  rdx, question_2
    call PrintZString
    call ScanInt

    cmp rdx, 0
    jle split_loop

    mov rcx, rdx # Denominator

    CQO
    idiv rcx 

    lea  rdx, statement_1
    call PrintZString

    mov  rdx, rax
    call PrintInt

    lea  rdx, statement_2
    call PrintZString

    call Exit
