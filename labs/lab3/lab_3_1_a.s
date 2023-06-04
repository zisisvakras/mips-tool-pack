###################################################
#                                                 #
#           Switch Case without Break             #
#                                                 #
###################################################

.text
.globl __start

__start: 

    li $v0, 5             # read int
    syscall

    move $t2, $v0         # we move the read integer in $t2
    addi $t5, $zero, 0    # we initialize a counter for the case that the integer is divided by neither 2,3,5

    addi $t0, $zero, 2    # we load 2 in $t0
    div $t2, $t0          # division between the given integer and 2

    mfhi $t1              # the remainder part of the division is stored in $t1 from the hi register
    bne $t1, $zero, u1    # if number mod 2 isn't 0 it jumps to exit, else it prints the string in "two" label
    addi $t5, $t5, 1      # we increase the counter
    la $a0, even          # print message for perfect division with 2 
    li $v0, 4
    syscall

u1:
    addi $t0, $zero, 3    # the same we did with 2 but for 3
    div $t2, $t0

    mfhi $t1
    bne $t1, $zero, u2    # if number mod 3 isn't 0 it jumps to u2, else it prints the string in "three" label
    addi $t5, $t5, 1
    la $a0, three         # print message for perfect division with 3
    li $v0, 4
    syscall

u2:
    addi $t0, $zero, 5    # the same for 5
    div $t2, $t0
    mfhi $t1
    bne $t1, $zero, u3    # if number mod 5 isn't 0 it jumps to exit, else it prints the string in "five" label
    addi $t5, $t5, 1
    la $a0, five          # print message for perfect division with 5
    li $v0, 4
    syscall

u3:    
    bne $t5, $zero, exit  # if the counter isn't 0 it jumps to exit, else it prints the string in "none" label.
    la $a0, none          # print message for perfect division with none           
    li $v0, 4
    syscall

exit:
    li $v0, 10
    syscall

.data

even:  .asciiz "The number is divided by 2.\n"
three: .asciiz "The number is divided by 3.\n"
five:  .asciiz "The number is divided by 5.\n"
none:  .asciiz "The number is divided by none.\n"
