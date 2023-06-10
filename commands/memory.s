
# This program demonstrates common memory access patterns in MIPS

.globl main
main: 

    # load int N into $s0
    la $a0, N # a. load address of N into $a0
    lw $s0, 0($a0) # b. load value at address $a0 into $s0

    # Store word
    sw $s0, 0($a0) # store value in $s0 into address $a0    

    # Store word into N
    la $a0, N # a. load address of N into $a0
    sw $s0, 0($a0) # store value in $s0 into address $a0


    li $v0, 10
    syscall


.data

    N: .word 69 