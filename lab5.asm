# Jaden Bruha - CSC 35 - Lab 5

.intel_syntax noprefix
.data
Statement:
    .ascii "\nWelcome to Overwatch 2 character selector!\n\0"

Question_1:
    .ascii "Do you like dealing lots of damage? (y/n)\n\0"
Question_1a:
    .ascii "Do you prefer to be nimble instead of tanky? (y/n)\n\0"
Question_1b:
    .ascii "Do you like to heal teammates? (y/n)\n\0"

Label_A:
    .ascii "You should play as Tracer! \n\n\0"
Label_B:
    .ascii "You should play as Roadhog! \n\n\0"
Label_C:
    .ascii "You should play as Kirko! \n\n\0"
Label_D:
    .ascii "You should play as Lucio! \n\n\0"

.text
.global _start

_start:
# Question 1
    lea  rdx, Statement
    call PrintZString

    lea  rdx, Question_1
    call PrintZString
    call ScanChar

    cmp dl, 110
    je Else

# Question 1a
    lea  rdx, Question_1a
    call PrintZString
    call ScanChar

    cmp dl, 110
    je Result_B

#Result_A
    lea  rdx, Label_A
    call PrintZString
    jmp End

Result_B:
    lea  rdx, Label_B
    call PrintZString
    jmp End

# Question 1b
Else:
    lea  rdx, Question_1b
    call PrintZString
    call ScanChar

    cmp dl, 110
    je Result_D

#Result_C
    lea  rdx, Label_C
    call PrintZString
    jmp End

Result_D:
    lea  rdx, Label_D
    call PrintZString
    jmp End

End:
    call Exit
