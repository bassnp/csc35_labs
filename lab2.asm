
.intel_syntax noprefix
.data
Name:
	.byte 10
	.byte 'J'
	.byte 'a'
	.byte 'd'
	.byte 'e'
	.byte 'n'
	.byte ' '
	.byte 'B'
	.byte 'r'
	.byte 'u'
	.byte 'h'
	.byte 'a'
	.byte 10
	.byte 0

EarnMsg:
	.ascii "How much do you earn each month?\n\0"
SpendMsg:
	.ascii "How much do you spend each month?\n\0"
FinalMsg:
	.ascii "Your cash flow is $\0"

# Useless Labels but are needed as a requirment
CashFlow:
	.quad 0
CashSub:
	.quad 0

.text
.global _start

_start:
	lea  rdx, Name
	call PrintZString

	lea  rdx, EarnMsg
	call PrintZString
	
	call ScanInt
	mov  CashFlow, rdx
	mov  rax, rdx

	lea  rdx, SpendMsg
	call PrintZString
	
	call ScanInt
	mov CashSub, rdx 
	sub  rax, rdx

	lea  rdx, FinalMsg
	call PrintZString

	mov  rdx, rax
	call PrintInt

	call Exit
