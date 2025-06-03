# print LSB bits of a number in hex
# $a0: the number $a1: digit count (give 8 for all)
print_hex:
    addi $sp, $sp, -8
    sw  $t0, 0($sp)
    sw  $a1, 4($sp)
    sll $a1, $a1, 2
    add $t0, $a0, $zero

print_hex_loop:
    addi $a1, $a1, -4
    srlv $a0, $t0, $a1
    andi $a0, $a0, 15
    slti $v0, $a0, 10
    bne $v0, $zero, print_hex_num
    li $v0, 11
    addi $a0, $a0, 55
print_hex_num:
    syscall
    bne $a1, $zero, print_hex_loop

    add $a0, $t0, $zero
    lw  $a1, 4($sp)
    lw  $t0, 0($sp)
    jr $ra

# print LSB bits of a number in octal
# $a0: the number $a1: digit count (give 11 for all)
print_oct:
    addi $sp, $sp, -8
    sw  $t0, 0($sp)
    sw  $a1, 4($sp)
    li $t0, 3
    mul $a1, $a1, $t0
    add $t0, $a0, $zero

  print_oct_loop:
    addi $a1, $a1, -3
    srlv $a0, $t0, $a1
    andi $a0, $a0, 7
    li $v0, 1
    syscall
    bne $a1, $zero, print_oct_loop

    add $a0, $t0, $zero
    lw  $a1, 4($sp)
    lw  $t0, 0($sp)
    jr $ra

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

# Prints a number in a given base
# This behavior mimics a limited version of printf from C standard library.
# a0: base (2..16)
# a1: the number to print
# -> a0: the number of chars printed
# overwrites: t0, t1, t2, a0, a1, a7
printnum:
    addi sp, sp, -36
    addi t2, sp, 35
    sb zero, 0(t2)
printnum2:
    addi t2, t2, -1
    divu t0, a1, a0
    remu a1, a1, a0
    addi t0, t0, 48
    slti t1, t0, 58
    bnez t1, printnum3
    addi t0, t0, 7
printnum3:
    sb t0, 0(t2)
    bnez a1, printnum2
    li a7, 4
    mv a0, t2
    ecall
    addi sp, sp, 36
    sub a0, sp, a0
    jr ra