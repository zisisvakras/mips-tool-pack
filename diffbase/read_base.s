.data
    wronginput: .asciiz "Wrong Input!"
.text

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

# $a0: number base (2..16)
# $v0: output, $v1: failed flag
# Characters should be in capital, stops at the first non complian char
read_num:
    li $v1, 0
    addi $sp, $sp, -12
    sw  $a0, 0($sp)
    sw  $s0, 4($sp)
    sw  $s1, 8($sp)
    add $s0, $zero, $zero
    add $s1, $zero, $a0
read_num_loop:
    li $v0, 12
    syscall
    addi $v0, $v0, -15
    bltz $v0, read_num_end
    addi $v0, $v0, -33
    bltz $v0, read_num_error
    slti $a0, $v0, 10
    bne $a0, $zero, read_num_check
    addi $v0, $v0, -17
    bltz $v0, read_num_error
    addi $v0, $v0, 10
    slt $a0, $v0, $s1
read_num_check:
    bne $a0, $zero, read_num_val
read_num_error:
    li $v1, 1
read_num_end:
    add $v0, $s0, $zero
    add $a0, $s1, $zero
    lw  $s1, 8($sp)
    lw  $s0, 4($sp)
    lw  $a0, 0($sp)
    addi $sp, $sp, 12
    jr $ra
read_num_val:
    mul $s0, $s0, $s1
    add $s0, $s0, $v0
    j read_num_loop

# $a0: number base (2..16), $a1: the string
# $v0: output, $v1: failed flag
# Characters should be in capital, stops at the first non complian char
str_num:
    li $v1, 0
    addi $sp, $sp, -16
    sw  $a0, 0($sp)
    sw  $s0, 4($sp)
    sw  $s1, 8($sp)
    sw  $a1, 12($sp)
    add $s0, $zero, $zero
    add $s1, $zero, $a0
str_num_loop:
    lb $v0, 0($a1)
    addi $a1, $a1, 1
    addi $v0, $v0, -15
    bltz $v0, str_num_end
    addi $v0, $v0, -33
    bltz $v0, str_num_error
    slti $a0, $v0, 10
    bne $a0, $zero, str_num_check
    addi $v0, $v0, -17
    bltz $v0, str_num_error
    addi $v0, $v0, 10
    slt $a0, $v0, $s1
str_num_check:
    bne $a0, $zero, str_num_val
str_num_error:
    li $v1, 1
str_num_end:
    add $v0, $s0, $zero
    lw  $a1, 12($sp)
    lw  $s1, 8($sp)
    lw  $s0, 4($sp)
    lw  $a0, 0($sp)
    addi $sp, $sp, 16
    jr $ra
str_num_val:
    mul $s0, $s0, $s1
    add $s0, $s0, $v0
    j str_num_loop
