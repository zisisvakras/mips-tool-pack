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