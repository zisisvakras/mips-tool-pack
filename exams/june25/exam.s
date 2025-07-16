# Διάβαζει 2 πραγματικούς από κονσόλα αν είναι ίσοι εμφανίζει μήνυμα και ολοκληρώνεται διαφορετικά  συνεχίζει.
# διαβαζει διαρκως ακέραιους αποθηκεύει 3 μετρητές στην μνήμη , ο 1ος μετρά τον μεγαλύτερο ακέραιο 
# 2ος  τον μικρότερο και ο τρίτος τα μηδενικά που έχουν εισαχθεί .
# Σταμάτα όταν εισαχθούν 3 μηδενικά . 
# Μεταβιβάζει τελικές τιμές μετρητών σε συνάρτηση που εκτυπώνει σχετικά 
# και μετά τη συνάρτηση ολοκληρώνει με Thank You


.data
ReadFloat: .asciiz "Insert a float: "
PrintExit: .asciiz "Floats are same"
ReadInt: .asciiz "Insert int: "
Zeros: .asciiz "Got 3 zeros ending.."
ThankYou: .asciiz "Thank you!\n"
Max: .asciiz "Largest integer: "
Min: .asciiz "Smallest integer: "
.text
.globl main

main:

    la $a0,ReadFloat
    jal print_string
    jal read_float

    mov.s $f1,$f0 # store first float in $f1

    la $a0,ReadFloat
    jal print_string
    jal read_float

    mov.s $f2,$f0 # store second float in $f2

    c.eq.s $f1,$f2 # compare floats
    bc1t float_exit # branch if equal

    li $s1,0 # zero counter
    li $s2,0 # curr max
    li $s3,0 # curr min
    li $s4,0 # non-zero flag
loop:
    la $a0,ReadInt
    jal print_string
    jal read_int
    move $s0,$v0

    beqz $s0,handle_zero # process zeros
    beqz $s4,first_nonzero # if non-zero
    
    j update_minmax

first_nonzero:
    move $s2,$s0 # set both max,min to first value
    move $s3,$s0
    li $s4,1 # flag that i read a num
    j loop

update_minmax:
    bgt $s0,$s2,update_max
    blt $s0,$s3,update_min
    j loop

update_min:
    move $s3,$s0
    j loop

update_max:
    move $s2,$s0
    j loop



handle_zero:
    addi $s1,$s1,1
    beq $s1,3,zero_exit
    j loop

read_int:
    li $v0,5
    syscall
    jr $ra

read_float:
    li $v0,6
    syscall
    jr $ra

print_int:
    li $v0,1
    syscall
    jr $ra

print_newl:
    li $a0,10
    li $v0,11
    syscall
    jr $ra


print_string:
    li $v0,4
    syscall
    jr $ra

float_exit:
    la $a0,PrintExit
    jal print_string
    jal print_newl 
    li $v0,10
    syscall

zero_exit:
    la $a0,Zeros
    jal print_string
    jal print_newl
    jal print_results
    la $a0,ThankYou
    jal print_string
    li $v0,10
    syscall

print_results:
    move $t0,$ra
    la $a0,Max
    jal print_string
    move $a0,$s2
    jal print_int
    jal print_newl
    la $a0,Min
    jal print_string
    move $a0,$s3
    jal print_int
    jal print_newl
    move $ra,$t0
    jr $ra
