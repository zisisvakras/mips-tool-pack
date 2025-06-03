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

# Reads a number from input for a desired base.
# Characters should be in capital, stops at the first non complian char
# This behavior mimics a limited version of scanf from C standard library.
# a0: base (2..16)
# -> a0: read number
# -> a1: failed flag
# overwrites: t0, t1, a0, a1, a7
readnum:
    li a1, 0               # Set failed flag to 0
    li t0, 0
    mv t1, a0              # Store base in t1
readnum1:
    li a7, 12              # Read a character
    ecall
    addi a0, a0, -15       # Check if input was control
    bltz a0, readnum4
    addi a0, a0, -33       # Check if input is at least a digit
    bltz a0, readnum3   
    blt  a0, 10, readnum2  # Is it a digit?
    addi a0, a0, -17       # Check >= 'A', for lower use -49
    bltz a0, readnum3
    addi a0, a0, 10        # Restore the value to 10..15
readnum2:              
    blt a0, t1, readnum5   # Is it a valid character for the base?
readnum3:
    li a1, 1
readnum4:
    mv a0, t0
    jr ra
readnum5:
    mul t0, t0, t1
    add t0, t0, a0
    j readnum1

# Reads a number from string and converts it to desired base and puts result in a0
# Characters should be in capital, stops at the first non complian char
# This behavior mimics strtoul() from C standard library.
# a0: base (2..16)
# a1: string to read
# -> a0: read number
# -> a1: failed flag
# overwrites: t0, t1, a0, a1
strnum:
    li a1, 0               # Set failed flag to 0
    li t0, 0
    mv t1, a0              # Store base in t1
strnum1:
    lbu a0, 0(a1)          # Read a character from string
    addi a1, a1, 1         # Move to the next character
    addi a0, a0, -15       # Check if input was control
    bltz a0, strnum4
    addi a0, a0, -33       # Check if input is at least a digit
    bltz a0, strnum3   
    blt  a0, 10, strnum2   # Is it a digit?
    addi a0, a0, -17       # Check >= 'A', for lower use -49
    bltz a0, strnum3
    addi a0, a0, 10        # Restore the value to 10..15
strnum2:              
    blt a0, t1, strnum5   # Is it a valid character for the base?
strnum3:
    li a1, 1
strnum4:
    mv a0, t0
    jr ra
strnum5:
    mul t0, t0, t1
    add t0, t0, a0
    j strnum1