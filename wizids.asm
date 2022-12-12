# Jaden Bruha - CSC 35 - Wizid-Game Project
# Took about 3 nights in total to do, i would guess for a total of 15 hours

.intel_syntax noprefix
.data

temp_str: # goofy 3 byte unicode char w/ 0term.
    .byte 0
    .byte 0
    .byte 0
    .byte 0

title:
    .ascii "\n\n██╗    ██╗██╗███████╗██╗██████╗ ███████╗\n██║    ██║██║╚══███╔╝██║██╔══██╗██╔════╝\n██║ █╗ ██║██║  ███╔╝ ██║██║  ██║███████╗\n██║███╗██║██║ ███╔╝  ██║██║  ██║╚════██║\n╚███╔███╔╝██║███████╗██║██████╔╝███████║\n ╚══╝╚══╝ ╚═╝╚══════╝╚═╝╚═════╝ ╚══════╝\n\0" 

ascii_gap:
    .ascii " \0"

tombstone_1:
    .ascii "    ______\n  /`/     `\\\n | |        \\\n \\ \\  R I P  \\\n  \\ \\ \0"
tombstone_2:
    .ascii "\\\n --\\ \\         \\\n--==\\ \\  .....''''  \n   ''''''\n\0"
   
trophy_1:
    .ascii "  _____________\n '._===_==_==_.'\n .-\\         /-.\n| (| \0"
trophy_2:
    .ascii " |) |\n '-|.        |-'\n   \\::.      /\n    ':::.  .'\n      \\   /\n       | |\n    _./___\\._\n\n\0"

credits:
    .ascii "         Written by Jaden Bruha\n\0"
init_question:
    .ascii "\nHow many players are there? (2-10): \0"

game_ended:
    .ascii "The game has concluded!\n\0"
game_champ:
    .ascii "\nAnd the champion is...\n\0"

scoreboard_1:
    .ascii "\nThe current players are ...\0"
scoreboard_2:
    .ascii "\n    Wizid #\0"
scoreboard_3:
    .ascii " - \0"
scoreboard_4:
    .ascii " / 100 health\0"

# each ascii is 8 bytes so i can scale it like a quad 
# good cuz dont another table to store the addresses
possible_names:
    .ascii "Harrie\0\0"
    .ascii "Rohn\0\0\0\0"
    .ascii "Hermeye\0" 
    .ascii "Draeko\0\0"
    .ascii "Hagid\0\0\0"
    .ascii "Snaepe\0\0"
    .ascii "Volmort\0"
    .ascii "Searius\0"
    .ascii "Dahbee\0\0"
    .ascii "Dumdore\0"

# i can usually eat a sandwich with this many bites
given_names:
    .byte 10
    .byte 10
    .byte 10
    .byte 10
    .byte 10
    .byte 10
    .byte 10
    .byte 10
    .byte 10
    .byte 10

# now maybe even TWO sandwiches 0_0
player_health:
    .byte 100
    .byte 100
    .byte 100
    .byte 100
    .byte 100
    .byte 100
    .byte 100
    .byte 100
    .byte 100
    .byte 100

round_start_1: 
    .ascii "\n\nRound #\0"                              
round_start_2: # round => r12
    .ascii " is starting!\nThere is a total of \0"
round_start_3: # alive => r14
    .ascii " players alive, and \0"                
round_start_4: # dead => r13
    .ascii " players dead!\n\n\0"
round_ended:
    .ascii "This round has concluded! Press enter to continue...\0"

player_turn_1:
    .ascii "It is now \0"
player_turn_2: # player's turn => rsi
    .ascii "'s turn!\nPick an alive Wizid to target (1-\0"
player_turn_3: # target => r8
    .ascii "): \0"
player_turn_4: # spell => r9
    .ascii "\nWhat spell would you like to cast at \0"
player_turn_5:
    .ascii "? (1-4):\n\0"
player_turn_6:
    .ascii "Cast spell #\0"

# damage => r10
action_1:
    .ascii "    1. Heal   [65%  chance, 20 health]\n\0"
action_2:
    .ascii "    2. Zap    [80%  chance, 20 damage]\n\0"
action_3:
    .ascii "    3. Blast  [40%  chance, 40 damage]\n\0"
action_4:
    .ascii "    4. Dare   [100% chance, Can heal or damage...]\n\0"

damages:
    .byte 20
    .byte 20
    .byte 40 
    .byte 0

chances:
    .byte 65
    .byte 80 
    .byte 40
    .byte 100

result_start:
    .ascii "\nThe spell cast was \0"
result_miss:
    .ascii "unsuccesful\0"

result_hit:
    .ascii "succesful\0"
result_hit_damage_1:
    .ascii " dealt \0" 
result_hit_damage_2:
    .ascii " damage to \0" 

result_hit_heal_1:
    .ascii " healed \0" 
result_hit_heal_2:
    .ascii " for \0" 
result_hit_heal_3:
    .ascii " points\0" 

result_mark:
    .ascii "!\n\0" 
result_gap:
    .ascii "\n\0" 

result_finish:
    .ascii "As a result, \0"
result_finish_alive_1:
    .ascii " has \0"
result_finish_alive_2:
    .ascii " health remaining!\n\n\0"
result_finish_dead:
    .ascii " has died!\n\0"

.text
.global _start

# ======= GOO =======

_start:
    mov  rdx, 6
    call Random
    add  rdx, 1
    mov  rbx, rdx
    call do_title

get_players:
    mov  rdx, 2
    call SetForeColor 

    lea  rdx, init_question
	call PrintZString

    mov  rdx, 3
    call SetForeColor 

    call ScanInt
    cmp  rdx, 2
    jl   get_players
    cmp  rdx, 10
    jg   get_players

    mov  r15, rdx    # initial player count
    mov  r14, rdx    # alive player count

    call acquire_names
    call do_title

game_loop: # main game loop
    cmp  r12, 1
    jl   skip_re_title

    mov  rdx, 3
    call SetForeColor 
    lea  rdx, round_ended
    call PrintZString
    call ScanInt

    call do_title

skip_re_title:
    mov  rdx, 6
    call SetForeColor 
    
    lea  rdx, scoreboard_1
    call PrintZString

    mov  rdx, 7
    call SetForeColor 

    mov  rcx, 1
    mov  rsi, 1 # set to first player

print_scoreboard:

    mov  rdx, 7
    call SetForeColor 

    mov  rax, 0
    mov  al, [player_health + (rcx - 1)]
    mov  rdx, rax
    cmp  rdx, 0
    jg   is_alive 
        
    mov  rdx, 1
    call SetForeColor 

is_alive:
    lea  rdx, scoreboard_2
    call PrintZString

    mov  rdx, rcx
    call PrintInt

    lea  rdx, scoreboard_3
    call PrintZString

    mov  rax, 0
    movb al, [given_names + (rcx - 1)]

    lea  rdx, [possible_names + rax * 8]
    call PrintZString

    lea  rdx, scoreboard_3
    call PrintZString

    mov  al, [player_health + (rcx - 1)]
    mov  rdx, rax
    call PrintInt

    lea  rdx, scoreboard_4
    call PrintZString

    add  rcx, 1
    cmp  rcx, r15
    jle  print_scoreboard

    call print_round_start

ask_for_target:
    mov  dl, 0
    cmp  [player_health + (rsi - 1)], dl
    je   asked_dead_player

    mov  rdx, 2
    call SetForeColor

    lea  rdx, player_turn_1 # ask for target
    call PrintZString

    call print_rsi_name

    lea  rdx, player_turn_2
    call PrintZString

    mov  rdx, r15 # print number of targets
    call PrintInt
    lea  rdx, player_turn_3
    call PrintZString

    mov  rdx, 3
    call SetForeColor
    call ScanInt # get their target
    
    cmp  rdx, 1
    jl   ask_for_target
    cmp  rdx, r15
    jg   ask_for_target

    mov  al, 0
    cmp  [player_health + (rdx - 1)], al
    je   ask_for_target

    mov  r8, rdx # chosen target index

ask_for_action:
    mov  rdx, 2
    call SetForeColor

    lea  rdx, player_turn_4 # ask for action
    call PrintZString

    mov  rax, 0
    mov  al, [given_names + (r8 - 1)]
    lea  rdx, [possible_names + rax * 8]
    call PrintZString

    lea  rdx, player_turn_5
    call PrintZString

    mov  rdx, 7
    call SetForeColor

    lea  rdx, action_1
    call PrintZString
    lea  rdx, action_2
    call PrintZString
    lea  rdx, action_3
    call PrintZString
    lea  rdx, action_4
    call PrintZString

    mov  rdx, 2
    call SetForeColor

    lea  rdx, player_turn_6
    call PrintZString

    mov  rdx, 3
    call SetForeColor
    call ScanInt # get their action

    cmp  rdx, 1
    jl   ask_for_action
    cmp  rdx, 4
    jg   ask_for_action

    mov  r9, rdx # chosen spell index

    call apply_action

asked_dead_player:
    add  rsi, 1

    cmp  r14, 1
    je   to_end

    cmp  rsi, r15
    jg   game_loop
    jmp  ask_for_target

# GAME LOOP HAS ENDED
to_end:
    call find_winner

    mov  rdx, 1
    call SetForeColor
    lea  rdx, game_ended
    call PrintZString

    mov  rdx, 5
    call SetForeColor
    lea  rdx, game_champ
    call PrintZString

    mov  rdx, 3
    call SetForeColor
    lea  rdx, trophy_1
    call PrintZString

# full length name skip first gap
    mov  rax, 0
    mov  al, [given_names + (rsi - 1)]
    lea  rdx, [possible_names + rax * 8]
    
    call LengthZString
    cmp  rdx, 6
    jge  trophy_name

    lea  rdx, ascii_gap
    call PrintZString

trophy_name:
    mov  rdx, 7
    call SetForeColor
    mov  al, [given_names + (rsi - 1)]
    lea  rdx, [possible_names + rax * 8]
    call PrintZString

    call LengthZString 
    cmp  rdx, 7
    je   skip_gap

    mov  rax, 6
    sub  rax, rdx
    lea  rdx, ascii_gap

add_tgap:
    call PrintZString
    sub  rax, 1
    cmp  rax, 0
    jg   add_tgap

skip_gap:
    mov  rdx, 3
    call SetForeColor
    lea  rdx, trophy_2
    call PrintZString

# ======= END =======

    mov  rdx, 7
    call SetForeColor 
    call Exit

# ======= \/\/ =======

# Suhbierooteaneies; 
# Noun;
# Defintion; nickname for subroutines
# Pronunciation; subby - routine - ees

# ======= \/\/ =======

find_winner:
    mov  rsi, 0
looking:
    add  rsi, 1
    mov  rax, 0
    mov  al, [player_health + (rsi - 1)]
    mov  rdx, rax
    cmp  rdx, 0
    je   looking
    ret

# ----

apply_action:
    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_start
    call PrintZString

    mov  rdx, 100
    call Random
    add  rdx, 1 # qol

    cmp  dl, [chances + (r9 - 1)]
    jg   missed

# hit:
    mov  r10b, [damages + (r9 - 1)]

    mov  rdx, 2
    call SetForeColor
    lea  rdx, result_hit
    call PrintZString

    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_mark
    call PrintZString

    mov  rdx, 2
    call SetForeColor
    call print_rsi_name

    cmp  r9, 4
    jne  normal_spell

# funny random damage, range (-20, 40), magnitude of 60 
    mov  rdx, 60
    call Random
    add  rdx, 1 # qol

    cmp  rdx, 20
    jge  do_damage

# do_heal:
    mov  r10b, dl # 0-20 healing
    jmp healed

do_damage:
    sub  rdx,  20
    mov  r10b, dl  # 0-40 damage
    jmp damaged

normal_spell:
    cmp  r9, 1
    jne  damaged

healed:
    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_hit_heal_1
    call PrintZString

    mov  rdx, 2
    call SetForeColor
    mov  al, [given_names + (r8 - 1)]
    lea  rdx, [possible_names + rax * 8]
    call PrintZString

    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_hit_heal_2
    call PrintZString

    mov  rdx, 2
    call SetForeColor
    mov  dl, r10b
    call PrintInt
    
    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_hit_heal_3
    call PrintZString

    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_mark
    call PrintZString

    # heal target

    add  [player_health + (r8 - 1)], r10b
    mov  rcx, 0
    mov  cl, [player_health + (r8 - 1)]
    mov  rdx, rcx
    cmp  rdx, 100
    jle  less_than_100
# exceeded 100, clamp
    movb [player_health + (r8 - 1)], 100
    movb cl, 100
less_than_100:
    jmp  action_result

damaged:
    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_hit_damage_1
    call PrintZString

    mov  rdx, 2
    call SetForeColor
    mov  dl, r10b
    call PrintInt

    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_hit_damage_2
    call PrintZString

    mov  rdx, 2
    call SetForeColor
    mov  al, [given_names + (r8 - 1)]
    lea  rdx, [possible_names + rax * 8]
    call PrintZString

    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_mark
    call PrintZString

    # damage target
    mov  cl, [player_health + (r8 - 1)]
    cmp  cl, r10b
    jg   wont_die
# will die from attack
    movb [player_health + (r8 - 1)], 0
wont_die:
    sub   cl, r10b
    movb [player_health + (r8 - 1)], cl
    
action_result:
    lea  rdx, result_finish
    call PrintZString

    mov  rdx, 2
    call SetForeColor
    mov  al, [given_names + (r8 - 1)]
    lea  rdx, [possible_names + rax * 8]
    call PrintZString

    cmp  cl, 0
    jg   alive_result
# dead result
    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_finish_dead
    call PrintZString

    mov  rdx, 7
    call SetForeColor
    lea  rdx, tombstone_1
    call PrintZString

# full length name skip first gap
    mov  al, [given_names + (r8 - 1)]
    lea  rdx, [possible_names + rax * 8]
    
    call LengthZString
    cmp  rdx, 7
    je   stone_name

    lea  rdx, ascii_gap
    call PrintZString

stone_name:
    mov  rdx, 1
    call SetForeColor
    mov  al, [given_names + (r8 - 1)]
    lea  rdx, [possible_names + rax * 8]
    call PrintZString

    mov  rax, 7
    call LengthZString
    sub  rax, rdx
    lea  rdx, ascii_gap

add_gap:
    call PrintZString
    sub  rax, 1
    cmp  rax, 0
    jg   add_gap


    mov  rdx, 7
    call SetForeColor
    lea  rdx, tombstone_2
    call PrintZString

    sub  r14, 1

    ret
alive_result:
    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_finish_alive_1
    call PrintZString

    mov  rdx, 2
    call SetForeColor
    mov  rdx, rcx
    call PrintInt

    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_finish_alive_2
    call PrintZString

    ret

missed:
    mov  rdx, 1
    call SetForeColor
    lea  rdx, result_miss
    call PrintZString

    mov  rdx, 6
    call SetForeColor
    lea  rdx, result_mark
    call PrintZString
    lea  rdx, result_gap
    call PrintZString
    ret

# ---- 

print_rsi_name:
    mov  al, [given_names + (rsi - 1)]
    lea  rdx, [possible_names + rax * 8]
    call PrintZString
    ret

# ----

acquire_names:
    mov  rsi, 0 # player index to give name to
loop_names:
    mov  rdx, 10 
    call Random  
    mov  rax, 0
check_exists: # iterate through playercount to check if it exsits
    cmp  [given_names + rax], dl
    je   loop_names # get new name
    add  al, 1
    cmp  rax, r15
    jl   check_exists
# fall outa loop
    mov  [given_names + rsi], dl
    add  rsi, 1
    cmp  rsi, r15
    jl   loop_names

    mov  rsi, 0

    ret

# ---- 

print_round_start:
    mov  rdx, 6
    call SetForeColor 

    lea  rdx, round_start_1
	call PrintZString

    add  r12, 1
    mov  rdx, r12
    call PrintInt

    lea  rdx, round_start_2
	call PrintZString
    mov  rdx, r14
    call PrintInt

    mov  r13, r15
    sub  r13, r14 # amount dead

    lea  rdx, round_start_3
	call PrintZString
    mov  rdx, r13
    call PrintInt

    lea  rdx, round_start_4
	call PrintZString

    ret

# ----

do_title:
    call ClearScreen
    call ClearScreen
    call print_clr_title

    mov  rdx, 7
    call SetForeColor 

    lea  rdx, credits
	call PrintZString

    ret

# ----

print_clr_title:
    lea  rdx, title
    call LengthZString

    mov  rax, rdx 
    mov  rsi, 0
    
# unicode characters are 3 bytes long, so gotta do some detection
loop_string: 
    movb r9b,  [title + rsi]
    movb r10b, [title + rsi + 1]
    movb r11b, [title + rsi + 2]

    movb [temp_str], r9b
    cmp  r9b,  226
    jne  invalid
    
    movb [temp_str + 1], r10b
    cmp  r10b, 150
    jne  invalid
    
    movb [temp_str + 2], r11b
    cmp  r11b, 136
    je   valid

invalid: # print the invalid character
    lea  rdx, temp_str
    call LengthZString
    sub  rdx, 1
    add  rsi, rdx

    lea  rdx, temp_str
    call PrintZString

    jmp bounce

valid:   # print the valid character ( █ )
    mov  rdx, rbx
    call SetForeColor 
    
    lea  rdx, temp_str
    call PrintZString
    
    mov  rdx, 7
    call SetForeColor 
    add  rsi, 2
bounce:
    call reset_temp_str

    add rsi, 1
    cmp rsi, rax
    jl  loop_string

    mov r9,  0
    mov r10, 0
    mov r11, 0

    ret

# ----

reset_temp_str:
    movb [temp_str], 0
    movb [temp_str + 1], 0
    movb [temp_str + 2], 0
    ret
