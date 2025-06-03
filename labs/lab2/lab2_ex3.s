# Lab 2 - Exercise 3

.text
.globl __start

__start:
    la t0, Elements

    addi t2, t0, 0x38  # load 12's base item base address
    sw t2, 0x14(t0)    # rewrite 5's pointer to point to 12

    addi t1, x0, 0xc   # load 12
    sw t1, 0(t2)       # store 12 at its position
    

    addi t1, t0, 0x18  # load pointer to item after 12
    sw t1, 4(t2)       # write 12's pointer to point to 7

    lw s0, 0(t0) # 1
        
    lw t0, 4(t0)
    lw s0, 0(t0) # 3

    lw t0, 4(t0)
    lw s0, 0(t0) # 5

    lw t0, 4(t0)
    lw s0, 0(t0) # 12
    
    lw t0, 4(t0)
    lw s0, 0(t0) # 7

    lw t0, 4(t0)
    lw s0, 0(t0) # 9

    # exit system call
    li  a7, 10
    ecall

.data
Elements :
 .word 1, 0x10010020 , 9, 0
 .word 5, 0x10010018 , 7, 0x10010008
 .word 3, 0x10010010 , 0, 0