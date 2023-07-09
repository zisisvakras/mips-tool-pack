.data
U1: .word 0x00000001, 0x00000002, 0x00000003, 0x00000004
    .word 0x00000005, 0x00000006, 0x00000007, 0x00000008
    .word 0x00000009

.text
    .globl main

main:   la $t0, U1
####################
        addi $t2, $zero, 4    # neg for odd, pos for even
        addi $t1, $t0, 36     # final address
loop:   lw $t3, 0($t0)
        andi $t3, $t3, 1
        sub $t2, $t2, $t3
        addi $t0, $t0, 4
        bne $t1, $t0, loop
        sra $s5, $t2, 31      # setting s5
####################
exit:   li $v0, 10
        syscall