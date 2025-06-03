# Calculate the number of digits in a number
# a0: n
# -> a0: digit count
# overwrites t0, t1, a0
digc:
    li t0, 0
    li t1, 10
  digc1:
    div a0, a0, t1
    addi t0, t0, 1
    bnez a0, digc1
    mv a0, t0
    jr ra

# Calculate the factorial of a number
# a0: n
# -> a0: n!
# overwrites t0, a0
fac:
    mv t0, a0
    bnez a0, fac1
    li a0, 1
    j fac2
    fac1:
    addi t0, t0, -1
    beqz t0, fac2
    mul a0, t0, a0
    j fac1
    fac2:
    jr ra

# a0: base
# a1: exp
# -> a0: base^exp
# overwrites t0, t1, a0
pow:
    mv t0, a0
    mv t1, a1
    bnez a0, pow1
    li a0, 0
    j pow3
    pow1:
    bnez a1, pow2
    li a0, 1
    j pow3
    pow2:
    addi t1, t1, -1
    beqz t1, pow3
    mul a0, a0, t1
    j pow2
    pow3:
    jr ra

# a0: str1
# a1: str2
# -> a0: str1 == str2
# overwrites: t0, t1, a0, a1
streq:
    lbu t0, 0(a0)
    lbu t1, 0(a1)
    bne t0, t1, streq1
    beqz t0, streq2
    addi a0, a0, 1
    addi a1, a1, 1
    j streq
    streq1:
    li a0, 0
    j streq3
    streq2:
    li a0, 1
    streq3:
    jr ra

# a0: str
# -> a0: strlen
# overwrites: t0, t1, a0
strlen:
    addi t1, a0, -1
strlen1:
    lb t0, 1(t1)
    addi t1, t1, 1
    bnez t0, strlen1
    sub a0, t1, a0
    jr ra

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

# Reads a number from input for a desired base.
# Characters should be in capital, stops at the first non complian char
# This behavior mimics a limited version of scanf from C standard library.
# a0: base (2..16)
# -> a0: read number
# -> a1: failed flag
# overwrites: t0, t1, a0, a1, a7
readnum:
    li a1, 0
    li t0, 0
    mv t1, a0
readnum1:
    li a7, 12
    ecall
    addi a0, a0, -15
    bltz a0, readnum4
    addi a0, a0, -33
    bltz a0, readnum3
    blt  a0, 10, readnum2
    addi a0, a0, -17        # For lowercase use -49
    bltz a0, readnum3
    addi a0, a0, 10
readnum2:
    blt a0, t1, readnum5
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
    li a1, 0
    li t0, 0
    mv t1, a0
strnum1:
    lbu a0, 0(a1)
    addi a1, a1, 1
    addi a0, a0, -15
    bltz a0, strnum4
    addi a0, a0, -33
    bltz a0, strnum3
    blt  a0, 10, strnum2
    addi a0, a0, -17        # For lowercase use -49
    bltz a0, strnum3
    addi a0, a0, 10
strnum2:
    blt a0, t1, strnum5
strnum3:
    li a1, 1
strnum4:
    mv a0, t0
    jr ra
strnum5:
    mul t0, t0, t1
    add t0, t0, a0
    j strnum1