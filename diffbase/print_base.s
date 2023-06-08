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

# print an number in a given base
# $a0: base 
# $a1: the number to print
# returns $v0: the number of chars printed
print_val:
    addi $sp, $sp, -52  # 4 regs + 33byte string + alignment
    sw  $t0, 0($sp)     # save used regs to the stack
    sw  $t1, 4($sp)
    sw  $t2, 8($sp)
    sw  $a1, 12($sp)

    addi $t2, $sp, 51   # initialize and
    sb $zero, 0($t2)    # null terminate the string

print_val_loop:
    addi $t2, $t2, -1   # fill string in reverse
    divu $a1, $a0
    mfhi $t0
    mflo $a1
    addi $t0, $t0, 48   # add '0' to get the ascii
    slti $t1, $t0, 58   # if result is past 9
    bne $t1, $zero, print_val_num
    addi $t0, $t0, 7    # add an other 7 to get to 'A'
print_val_num:
    addi $v0, $v0, 1    # character counter
    sb $t0, 0($t2)      # store the character in the string
    bne $a1, $zero, print_val_loop
    
    add $t0, $a0, $zero # save regs before syscall
    add $t1, $v0, $zero
    li $v0, 4           # print string
    add $a0, $t2, $zero
    syscall  
    add $a0, $t0, $zero # restore saved regs
    add $v0, $t1, $zero
    lw  $a1, 12($sp)    # pop the stack
    lw  $t2, 8($sp)
    lw  $t1, 4($sp)
    lw  $t0, 0($sp)
    addi $sp, $sp, 52
    jr $ra