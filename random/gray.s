.data
space: .asciiz " "
.text
.globl main

main:

li $s0, 0 # 0011

main_loop_gray_demo:
    move $a0, $s0
    jal print_int
    jal to_gray
    move $s1, $v0
    la $a0, space
    jal print_string
    move $a0, $s1
    li $a1, 6 
    jal print_bin

    jal print_endl


    addi $s0, $s0, 1
bne $s0, 16, main_loop_gray_demo

li $v0, 10
syscall


to_gray:    # value in $a0

    srl $t1, $a0, 1     # Shift value one bit to the right
    xor $v0, $a0, $t1   # XOR original value with shifted value

    jr   $ra            # return to the calling function
#

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

print_int:                  #  Prints integer given in $a0 
    li $v0, 1
    syscall
    jr $ra

#  

print_string:               #  Prints string given in $a0 
    li $v0, 4               #  Use "la $a0, label" to specify string address
    syscall
    jr $ra
#

print_endl:                 # prints '\n'
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    li $a0, 10
    li $v0, 11
    syscall
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    jr $ra
#