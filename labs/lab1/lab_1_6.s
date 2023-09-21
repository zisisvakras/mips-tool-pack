# Sum and Difference of 2 integers
.globl main

main:
    # read int
    li $v0, 5
    syscall
    # save int
    move $t0, $v0
    # print int
    move $a0, $v0
    li $v0, 1
    syscall
    jal print_endl # Use of functions (Maybe you will learn this later :)

    # repeat for 2nd int (same procedure)
    li $v0, 5
    syscall
    move $t1, $v0
    move $a0, $v0
    li $v0, 1
    syscall
    jal print_endl

    # calculate
    add $s0, $t0, $t1
    sub $s1, $t0, $t1

    # print sum (print int syscall)
    move $a0, $s0
    li $v0, 1
    syscall
    jal print_endl
    # print diff
    move $a0, $s1
    li $v0, 1
    syscall
    jal print_endl
    # exit
    li $v0, 10
    syscall

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra
