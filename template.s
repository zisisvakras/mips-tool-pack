# a0: n
# -> a0: digit count
# overwrites t0, t1, a0
digit_count:
    li t0, 0
    li t1, 10
  digit_count_loop:
    div a0, a0, t1
    addi t0, t0, 1
    bne a0, zero, digit_count_loop
    mv a0, t0
    jr ra

# a0: n
# -> a0: n!
# overwrites t0, a0
factorial:
    mv t0, a0
    bne a0, zero, factorialloop
    li a0, 1
    j factorialexit
    factorialloop:
    addi t0, t0, -1
    beq t0, zero, factorialexit
    mul a0, t0, a0
    j factorialloop
    factorialexit:
    jr ra

# a0: base
# a1: exp
# -> a0: base^exp
# overwrites t0, t1, a0
pow:
    mv t0, a0
    mv t1, a1
    bne a0, zero, pownext
    li a0, 0            # 0^a
    j powexit
    pownext:
    bne a1, zero, powloop
    li a0, 1            # a^0
    j powexit
    powloop:
    addi t1, t1, -1
    beq t1, zero, powexit
    mul a0, a0, t1
    j powloop
    powexit:
    jr ra

# a0: str1
# a1: str2
# -> a0: str1 == str2
# overwrites: t0, t1, a0, a1
streq:
    lbu t0, 0(a0)
    lbu t1, 0(a1)
    bne t0, t1, streqexitno
    beq t0, zero, streqexityes
    addi a0, a0, 1
    addi a1, a1, 1
    j streq
    streqexitno:
    li a0, 0
    j streqexit
    streqexityes:
    li a0, 1
    streqexit:
    jr ra

# a0: str
# -> a0: strlen
# overwrites: t0, t1, a0
strlen:
    addi t1, a0, -1
strlenloop:
    lb t0, 1(t1)
    addi t1, t1, 1
    bne t0, zero, strlenloop
    sub a0, t1, a0    # prepare return value
    jr ra

# print an number in a given base
# a0: base 
# a1: the number to print
# -> a0: the number of chars printed
print_num:
    addi sp, sp, -36  # 33byte string + alignment
    addi t2, sp, 35   # initialize end
    sb zero, 0(t2)    # null terminate the string
print_num_loop:
    addi t2, t2, -1   # fill string in reverse
    divu t0, a1, a0
    remu a1, a1, a0
    addi t0, t0, 48   # add '0' to get the ascii
    slti t1, t0, 58   # if result is past 9
    bne t1, zero, print_num_num
    addi t0, t0, 7    # add an other 7 to get to 'A'
print_num_num:
    sb t0, 0(t2)      # store the character in the string
    bne a1, zero, print_num_loop
    li a7, 4          # print string
    mv a0, t2
    ecall
    addi sp, sp, 36
    sub a0, sp, a0
    jr ra

# repeateadly reads characters, converts it to desired base and puts result in $v0
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
