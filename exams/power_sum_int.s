.data
    l1: .asciiz "*10^"
    plus: .asciiz " + "
    sum: .asciiz "POWERS-SUM="
    input: .asciiz "Input: "

.text 
.globl main

main:
    li $t0, 10
    big_loop:
    jal read_int
    beq $v0, $zero, exit
    move $a0, $v0
    move $s0, $v0 # value
    jal digit_len
    move $s1, $v0 # digits
    la $a0, sum
    jal print_string
    loop:
    addi $s1, $s1, -1
    move $a0, $t0
    move $a1, $s1
    jal pow
    move $t2, $v0
    div $s0, $t2
    mfhi $s0 # remainder
    mflo $a0 # quotient
    jal print_int
    la $a0, l1
    jal print_string
    move $a0, $s1
    jal print_int
    beq $s1, $zero, back
    la $a0, plus
    jal print_string
    j loop
    back:
    jal print_endl
    j big_loop
#  Prints integer given in $a0
print_int:
    li $v0, 1
    syscall
    jr $ra

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

#  Read integer from input
#  Integer will be in $v0
read_int:
    li $v0, 5
    syscall
    jr $ra

# Exits the program
exit:
    li $v0, 10
    syscall

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra

#  Returns the digit length in $v0
digit_len:
    li $v0, 0
    li $t0, 10
    digit_len_loop:
    div $a0, $t0
    mflo $a0
    addi $v0, $v0, 1
    bne $a0, $zero, digit_len_loop
    jr $ra

#  Returns $a0^$a1 in $v0
pow:
    addi $sp, $sp, -4    # make space in stack
    sw $t0, 0($sp)
    move $v0, $a0
	move $t0, $a1
    bne $v0, $zero, next
    li $v0, 0            # 0^a
    j powexit
    next:
    bne $t0, $zero, powloop
    li $v0, 1            # a^0
    j powexit
    powloop:
    addi $t0, $t0, -1
    beq $t0, $zero, powexit
    mult $v0, $a0
    mflo $v0
    j powloop
    powexit:
    lw $t0, 0($sp)
    addi $sp, $sp, 4
    jr $ra