# prints out $a0 in the desired base, LITTLE ENDIAN

print_bin:
    add $t0, $a0, $zero
    andi $a0, $a0, 1
    li $v0, 1
    syscall
    srl $a0, $t0, 1
    bne $a0, $zero, print_bin
    jr $ra

print_oct:
    add $t0, $a0, $zero
    andi $a0, $a0, 7
    li $v0, 1
    syscall
    srl $a0, $t0, 3
    bne $a0, $zero, print_oct
    jr $ra

print_hex:
    add $t0, $a0, $zero
    andi $a0, $a0, 15
    slti $v0, $a0, 10
    bne $v0, $zero, print_hex_num
    li $v0, 11
    addi $a0, $a0, 55
print_hex_num:
    syscall
    srl $a0, $t0, 4
    bne $a0, $zero, print_hex
    jr $ra