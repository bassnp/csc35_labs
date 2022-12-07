# CSC 35

.intel_syntax noprefix
.data

# Question labels
Get_s:
	.ascii "\nEnter your selection:\n\0"
Prnt_s:
	.ascii "\nYou selected item:\n\0"
Get_m:
	.ascii "\nHow many bottlecaps are you inserting?\n\0"
Prnt_c1:
	.ascii "\nYour change is \0"
Prnt_c2:
	.ascii " bottlecaps.\n\n\0"

# Labels of items in menu
Pickaxe:
	.ascii "1. Diamond Pickaxe (200 bottlecaps) \n\0"
Power:
	.ascii "2. Power armor     (150 bottlecaps) \n\0"
Shoes:
	.ascii "3. Yeezys          (100 bottlecaps) \n\0"
Cancel:
	.ascii "4. Cancel your order (0 bottlecaps) \n\0"

# Table of menu items
Table:
	.quad Pickaxe
	.quad Power
	.quad Shoes
	.quad Cancel

# Costs of menu items
Costs:
	.quad 200
	.quad 150
	.quad 100
	.quad 0

.text
.global _start

_start:
	# Part 1: Print the Menu
	lea  rdx, Pickaxe
	call PrintZString
	lea  rdx, Power
	call PrintZString
	lea  rdx, Shoes
	call PrintZString
	lea  rdx, Cancel
	call PrintZString

	# Part 2: Get item selection
	lea  rdx, Get_s
	call PrintZString

	call ScanInt
	mov  rsi, rdx
	sub  rsi, 1	
	
	# Part 3: Print Selection
	lea  rdx, Prnt_s
	call PrintZString

	mov  rdx, [Table + rsi * 8]
	call PrintZString
	
	# Part 4: Get money
	lea  rdx, Get_m
	call PrintZString

	call ScanInt
	mov  rax, rdx	 
	sub  rax, [Costs + rsi * 8]
	
	# Part 5: Print Change
	lea  rdx, Prnt_c1
	call PrintZString

	mov  rdx, rax
	call PrintInt

	lea  rdx, Prnt_c2
	call PrintZString

	call Exit
