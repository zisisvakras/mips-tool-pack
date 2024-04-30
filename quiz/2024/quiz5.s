.data
    W1: .word 0x6b9877d5
.text
    .globl main

####################
main:   la $s0, W1
        lw $t0, 0($s0)
        add $t1, $zero, $zero
loop:   sll $t1, $t1, 1
        andi $t2, $t0, 1
        or $t1, $t1, $t2
        srl $t0, $t0, 1
        bne $t0, $zero, loop
        sw $t1, 0($s0)
####################
exit:   li $v0, 10
        syscall