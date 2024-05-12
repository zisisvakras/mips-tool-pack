.data
    W1: .word 0x6b9877d5
.text
    .globl main

####################
main:   la $s0, W1
        lw $t0, 0($s0)
        addi $t3, $zero, 32
loop:   sll $t1, $t1, 1
        andi $t2, $t0, 1
        or $t1, $t1, $t2
        srl $t0, $t0, 1
        addi $t3, $t3, -1
        bne $t3, $zero, loop
        sw $t1, 0($s0)
####################
exit:   li $v0, 10
        syscall