# Read Integer and Print Integer

.text
.globl main

main:
    # read integer syscall
    li $v0, 5
    syscall
    # move read int as arg for print
    move $a0, $v0
    # print integer syscall
    li $v0, 1
    syscall
    # exit
    li $v0, 10
    syscall
