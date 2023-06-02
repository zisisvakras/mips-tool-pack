# repeateadly reads characters, converts it to desired base and puts result in $v0

# will contain the hex value in $v0, expects characters in CAPS
read_hex:
    addi $sp, $sp, -8
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    add $s0, $zero, $zero
read_hex_loop:
    li $v0, 12
    syscall
    addi $v0, $v0, -48
    bltz $v0, read_hex_end
    slti $a0, $v0, 10
    bne $a0, $zero, read_hex_val
    addi $v0, $v0, -17
    bltz $v0, read_hex_end
    addi $v0, $v0, 10
    slti $a0, $v0, 16
    bne $a0, $zero, read_hex_val
read_hex_end:
    add $v0, $s0, $zero
    lw  $s0, 4($sp)
    lw  $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
read_hex_val:
    sll $s0, $s0, 4
    or $s0, $s0, $v0
    j read_hex_loop

# will contain the octal value in $v0, expects characters in CAPS
read_oct:
    addi $sp, $sp, -8
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    add $s0, $zero, $zero
read_oct_loop:
    li $v0, 12
    syscall
    addi $v0, $v0, -48
    bltz $v0, read_oct_end
    slti $a0, $v0, 8
    bne $a0, $zero, read_oct_val
read_oct_end:
    add $v0, $s0, $zero
    lw  $s0, 4($sp)
    lw  $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
read_oct_val:
    sll $s0, $s0, 3
    or $s0, $s0, $v0
    j read_oct_loop


# will contain the binary value in $v0
read_bin:
    addi $sp, $sp, -8
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    add $s0, $zero, $zero
read_bin_loop:
    li $v0, 12
    syscall
    addi $v0, $v0, -48
    bltz $v0, read_bin_end
    slti $a0, $v0, 2
    bne $a0, $zero, read_bin_val
read_bin_end:
    add $v0, $s0, $zero
    lw  $s0, 4($sp)
    lw  $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
read_bin_val:
    sll $s0, $s0, 1
    or $s0, $s0, $v0
    j read_bin_loop