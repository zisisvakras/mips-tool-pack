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