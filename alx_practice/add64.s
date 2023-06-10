.text
.globl main
main:

li $a0, 0x00F00000
li $a1, 0xFFFFFFFF

li $a2, 0x100F0000
li $a3, 0x0000FFFF

jal add_64

move $s0, $v0
move $s1, $v1


li $v0, 10
syscall


add_64:
    addu $t0, $0, $0 # initialize overflow signal to 0
    addu $v0, $a0, $a2 # add the least significant words of the two numbers
    sltu $t1, $v0, $a0 # check if there was an overflow
    addu $v1, $a1, $a3 # add the most significant words of the two numbers
    sltu $t2, $v1, $a1 # check if there was an overflow
    addu $v0, $v0, $t2 # add the overflow from the most significant words to the least significant words
    addu $v1, $v1, $t1 # add the overflow from the least significant words to the most significant words
    or   $t0, $t1, $t2 # set overflow signal if there was an overflow in either addition

    jr   $ra # return to caller

