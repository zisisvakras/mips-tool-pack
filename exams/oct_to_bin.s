# exam problem where u have to read a 4-digit octal num (as a string) and print it in binary
# made using utilities from this tool-pack

.data
    endl: .asciiz "\n"
    int: .asciiz "INVALID CHAR"
    buffer: .space 20
    # array: .word 20, 30, 40
.text
.globl main

main:
    la $a0, buffer
    li $a1, 5
    jal read_string
    
    la $a1, buffer
    li $a0, 8
    jal str_num

    move $a0, $v0
    li $a1, 32  
    jal print_bin 

loop:

end:
    c.eq.s $f12, $f1 
    bc1f loop
    j exit

# Exits the program
exit:
    li $v0, 10
    syscall

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

#  Read string from input
#  $a0 will be buffer address and $a1 the length (including the space made for \0)
#  Remember that u can allocate space for a buffer in .data with .space (len)
read_string:
    li $v0, 8
    syscall
    jr $ra

# $a0: number base (2..16), $a1: the string
# $v0: output
# Characters should be in capital, stops at the first non complian char
str_num:
    addi $sp, $sp, -16
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    sw  $s1, 8($sp)
    sw  $a1, 12($sp)
    add $s0, $zero, $zero
    add $s1, $zero, $a0
str_num_loop:
    lb $v0, 0($a1)
    addi $a1, $a1, 1
    addi $v0, $v0, -48
    bltz $v0, str_num_end
    slti $a0, $v0, 10
    bne $a0, $zero, str_num_check
    addi $v0, $v0, -17
    bltz $v0, str_num_end
    addi $v0, $v0, 10
    slt $a0, $v0, $s1
str_num_check:
    bne $a0, $zero, str_num_val
str_num_end:
    add $v0, $s0, $zero
    lw  $a1, 12($sp)
    lw  $s1, 8($sp)
    lw  $s0, 4($sp)
    lw  $ra, 0($sp)
    addi $sp, $sp, 16
    jr $ra
str_num_val:
    mul $s0, $s0, $s1
    or $s0, $s0, $v0
    j str_num_loop

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