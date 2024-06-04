.data
    endl: .asciiz "\n"
    buf: .space 11
.text
.globl main

main:
    # Prepare range
    addi $t0, $zero, 'a'
    addi $t1, $zero, 'z'
    # Get string
    la $a0, buf
    li $a1, 11
    li $v0, 8
    syscall
    # Print read string
    la $a0, buf
    li $v0, 4
    syscall
    addi $s0, $a0, -1 # buf address for loop
read:
    addi $s0, $s0, 1
    lb $t2, 0($s0)
    beq $t2, $zero, exit # exit on '\0'
    blt $t2, $t0, read   # checking if char is in range 'a'-'z'
    bgt $t2, $t1, read
    addi $t2, $t2, -32
    sb $t2, 0($s0)
    j read
exit:
    # Print newline
    la $a0, endl
    li $v0, 4
    syscall
    # Print modded string
    la $a0, buf
    li $v0, 4
    syscall
    # Exit
    li $v0,10
    syscall