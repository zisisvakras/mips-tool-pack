.text 
.globl main

main:
    lw $t0, number
    lw $t1, number2
    xor $s0, $t0, $t1
    clo $s1, $s0

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 10
    syscall

   
.data
    number: .word 0xFFFFFFFF
    number2: .word 0x00000001
