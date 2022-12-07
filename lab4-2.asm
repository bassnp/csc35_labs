# CSC 35

.intel_syntax noprefix
.data

Question1:
    .ascii "Did you study last night? (1=yes, 2=no)\n\0"
Question2:
    .ascii "Did you get enough sleep? (1=yes, 2=no)\n\0"
Question3:
    .ascii "Did you have breakfast? (1=yes, 2=no)\n\0"
Question4:
    .ascii "Did you have any caffine today? (1=yes, 2=no)\n\0"
Statement1:
    .ascii "You will likely PASS the exam!\n\0"
Statement2:
    .ascii "You will likely FAIL the exam!\n\0"

.text
.global _start

_start:
    lea  rdx, Question1
    call PrintZString
    call ScanInt

    cmp rdx, 2
    je Next1
    add rax, 30

Next1:   
    lea  rdx, Question2
    call PrintZString
    call ScanInt

    cmp rdx, 2
    je Next2
    add rax, 15

Next2:  
    lea  rdx, Question3
    call PrintZString
    call ScanInt

    cmp rdx, 2
    je Next3
    add rax, 15

Next3:  
    lea  rdx, Question4
    call PrintZString
    call ScanInt

    cmp rdx, 2
    je Next4
    add rax, 30

Next4:  
    cmp  rax, 45
    jl   Else

    lea  rdx, Statement1
    call PrintZString

    jmp  End

Else:
    lea  rdx, Statement2
    call PrintZString

End:
    call Exit
