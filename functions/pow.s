# a0: base
# a1: exp
# -> a0: base^exp
# overwrites t0, t1, a0
pow:
    mv t0, a0
    mv t1, a1
    bnez a0, pow1
    li a0, 0            # 0^a
    j pow3
    pow1:
    bnez a1, pow2
    li a0, 1            # a^0
    j pow3
    pow2:
    addi t1, t1, -1
    beqz t1, pow3
    mul a0, a0, t1
    j pow2
    pow3:
    jr ra