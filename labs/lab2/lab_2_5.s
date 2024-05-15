# Optimal solution for lab_2_5
# Refer to alternative for xergias sol

.data
    w1: .word 0xFFFFFFFF
    w2: .word 0x1

.text
.globl main

main:
    # Load
    lw $t1, w1
    lw $t2, w2

    # Result - Carry < W1, W2
    addu $s1, $t1, $t2
    sltu $s2, $s1, $t1

    # Exit
    li $v0, 10
    syscall

