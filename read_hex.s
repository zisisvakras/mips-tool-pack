# reads a string of characters, converts it to hex and puts result in $v0

.data
    endl: .asciiz "\n"
    buffer: .space 20

.text
 .globl main
main:
    la $a0, buffer
    li $a1, 9
    jal read_string
    jal print_string
    jal read_hex   
    move $s1, $v0
    j exit


# Exits the program
exit:
    li $v0, 10
    syscall


# will contain the hex value in $v0, expects characters in CAPS
read_hex:
    # $v0 will hold result
    addi $sp, $sp, -16
    sw  $t0, 0($sp) # holds char
    sw  $t1, 4($sp) # loop counter
    sw  $t2, 8($sp) # holds the pos of A
    sw  $t3, 12($sp) # tmp for shift

    move $v0, $zero
    la $a0, buffer
    li $t1, 7
    li $t2, 65
    

read_hex_loop:
    lb $t0, 0($a0)
    addi $a0, $a0, 1 
    bge $t0, $t2, read_hex_letter
    addi $t0, $t0, -48

read_hex_eval:
    sll $t3, $t1, 2

    sllv $t0, $t0, $t3
    or $v0, $v0, $t0
    addi $t1, $t1, -1
    bge $t1, $zero, read_hex_loop


    lw  $t0, 0($sp) # holds char
    lw  $t1, 4($sp) # loop counter
    lw  $t2, 8($sp) # holds the pos of A
    lw  $t3, 12($sp) # tmp for shift
    addi $sp, $sp, 16 
    jr $ra

read_hex_letter:
    addi $t0, $t0, -65
    addi $t0, $t0, 10
    j read_hex_eval


# helper functs
read_string:
    li $v0, 8
    syscall
    jr $ra
print_string:
    li $v0, 4
    syscall
    jr $ra