# a0: base
# a1: exp
# -> a0: base^exp
# overwrites t0, a0, a1
pow:
    mv t0, a0
    bnez a0, pow1
    li a0, 0
    j pow3
    pow1:
    bnez a1, pow2
    li a0, 1
    j pow3
    pow2:
    addi a1, a1, -1
    beqz a1, pow3
    mul a0, a0, t0
    j pow2
    pow3:
    jr ra