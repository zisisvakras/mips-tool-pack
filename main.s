.data
    endl: .asciiz "\n"
    # buffer: .space 20
    # array: .word 20, 30, 40
.text
.globl main

main:
    j exit


# Exits the program
exit:
    li $v0, 10
    syscall