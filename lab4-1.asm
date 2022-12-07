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

Questions:
	.quad Question1
	.quad Question2
	.quad Question3
	.quad Question4

Weight:
	.quad 30
	.quad 15
	.quad 15
	.quad 30

Readiness:
    .ascii "Your readiness score is: \0"
Statement1:
    .ascii "\nYou will likely PASS the exam!\n\0"
Statement2:
    .ascii "\nYou will likely FAIL the exam!\n\0"

.text
.global _start

_start:
LoopQ:
    mov  rdx, [Questions + rsi * 8]
	call PrintZString
    call ScanInt

    cmp rdx, 2
    je  Else
    add  rax, [Weight + rsi * 8]

Else:
    add  rsi, 1
    cmp  rsi, 4
    jl   LoopQ

    lea  rdx, Readiness
    call PrintZString
    mov  rdx, rax
    call PrintInt

    cmp  rax, 45
    jl   Fail

    lea  rdx, Statement1
    call PrintZString
    jmp End

Fail:
    lea  rdx, Statement2
    call PrintZString

End:
    call Exit
