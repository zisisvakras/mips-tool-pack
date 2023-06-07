# Switch Case with Break
# The exact same program with lab5_3.1.a.s but with breaks in the end of every case
# so only the first divisor if there is one, is printed

.text
.globl __start

__start: 

    li $v0, 5            # read int
    syscall

    move $t2, $v0
    addi $t5, $zero, 0

    addi $t0, $zero, 2
    div $t2, $t0

    mfhi $t1
    bne $t1, $zero, u1   # if number mod 2 isn't 0 it jumps to exit, else it prints the string in "two" label
    addi $t5, $t5, 1
    la $a0, even
    li $v0, 4
    syscall
    j exit               # break

u1:
    addi $t0, $zero, 3
    div $t2, $t0

    mfhi $t1
    bne $t1, $zero, u2   # if number mod 3 isn't 0 it jumps to u2, else it prints the string in "three" label
    addi $t5, $t5, 1
    la $a0, three
    li $v0, 4
    syscall
    j exit               # break

u2:
    addi $t0, $zero, 5
    div $t2, $t0
    mfhi $t1
    bne $t1, $zero, u3   # if number mod 5 isn't 0 it jumps to exit, else it prints the string in "five" label
    addi $t5, $t5, 1
    la $a0, five
    li $v0, 4
    syscall
    j exit               # break

u3:    
    bne $t5, $zero, exit # if the counter isn't 0 it jumps to exit, else it prints the string in "none" label.
    la $a0, none
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
