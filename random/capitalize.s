.text
    .globl __start

__start:
    li $t0, 10
    li $t2, 123
    while:
        # read char in $a0
        li $v0, 12
        syscall
        or $a0, $v0, $zero
        
        slti $t1, $a0, 96
        bne $t1, $zero, print

        slt $t1, $t2, $a0 
        bne $t1, $zero, print

        sub $a0, $a0, 32
        # print char from $a0
        print:
        li $v0, 11
        syscall
        bne $a0, $t0, while

    
    
    # exit:
    li $v0, 10
    syscall
