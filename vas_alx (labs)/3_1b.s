.text
    .globl __start

__start:

    li $v0, 5
    syscall

    or $s0, $v0, $zero
    
    or $a0, $v0, $zero
    li $v0, 1
    syscall
    
    li $t1, 2
    li $t2, 3
    li $t3, 5
    #li $t4, 0
    la $t6, exit
    li $v0, 11
    li $a0, 10
    syscall

    div $s0, $t1
    mfhi $t0

    bne $t0, $zero, not2

        li $a0, 2
        #li $t4, 1
        li $v0, 1
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        jr $t6

    not2:

    div $s0, $t2
    mfhi $t0

    bne $t0, $zero, not3

        li $a0, 3
        #li $t4, 1
        li $v0, 1
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        jr $t6

    not3:

    div $s0, $t3
    mfhi $t0

    bne $t0, $zero, not5

        li $a0, 5
        #li $t4, 1
        li $v0, 1
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        jr $t6

    not5:

    #bne $t4, 0, exit

        la $a0, tzimani
        li $v0, 4
        syscall

    exit:

    li $v0, 10
    syscall

.data
    tzimani: .asciiz "Eisai tzimani\n"
