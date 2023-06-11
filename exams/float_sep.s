# exam problem where u have to print the mantissa and the exponent of a float in binary
# made using utilities from this tool-pack

.data
    endl: .asciiz "\n"
    value: .asciiz "Value is: "
    exponent: .asciiz "Exponent is: "
    frac: .asciiz "Frac is: "
    zerof: .float 0.0
    # buffer: .space 20
    # array: .word 20, 30, 40
.text
.globl main

main:
    lw $t0, zerof
     mtc1 $t0, $f1
loop:
    # read and print the input float
    jal read_float
    mov.s $f12, $f0
    la $a0, value
    jal print_string
    jal print_float
    la $a0, endl
    jal print_string


    #t0 will hold initial word

    mfc1 $t0, $f0

    #print exponent
    la $a0, exponent
    jal print_string
    srl $a0, $t0, 23
    li $a1, 8
    jal print_bin
    la $a0, endl
    jal print_string

    #print frac
    la $a0, frac
    jal print_string
    move $a0, $t0
    li $a1, 23
    jal print_bin
    la $a0, endl
    jal print_string

    c.eq.s $f0, $f1 
    bc1f loop
    j exit


# Exits the program
exit:
    li $v0, 10
    syscall


#  Read float from input
#  Float will be in $f0
read_float:
    li $v0, 6
    syscall
    jr $ra

#  Prints float given in $f12
#  Use "mov.s $f12, $???" to move float to reg
print_float:
    li $v0, 2
    syscall
    jr $ra

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

# print LSB bits of a number in binary
# $a0: the number $a1: digit count (give 32 for all)
print_bin:
    addi $sp, $sp, -8
    sw  $t0, 0($sp)
    sw  $a1, 4($sp)
    add $t0, $a0, $zero

  print_bin_loop:
    addi $a1, $a1, -1
    srlv $a0, $t0, $a1
    andi $a0, $a0, 1
    li $v0, 1
    syscall
    bne $a1, $zero, print_bin_loop

    add $a0, $t0, $zero
    lw  $a1, 4($sp)
    lw  $t0, 0($sp)
    jr $ra