.data
    test1: .word 0xFFFFFFFF
    test2: .word 0x1
    
.text
.globl main

main: 

    lw $t1, test1 
    lw $t2, test2

    addu $s1, $t1, $t2
    sltu $s2, $s1, $t1

    li $v0, 10
    syscall #exit

