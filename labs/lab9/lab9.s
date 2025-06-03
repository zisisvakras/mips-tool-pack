    .org 0x200
    .text
    .globl _start

_start:
    la s0, vector0
    la s1, vector1
    li s2, 30               # size
    li s3, 0                # index
    li s4, 0                # sum
loop:
    slli t0, s3, 2          #index*4    
    add t1, s0, t0
    lw s5, 0(t1)
    add t2, t1, s0
    lw s6, 0(t2)
    mul s7, s5, s6
    add s4, s4, s7
    addi s3, s3, 1
    bne s3, s2, loop
exit:
    ebreak




    .org 0x400
    .data
vector0:    .word    1, 0, 1, 0, 1, 0, 1, 0, 1, 0
            .word    1, 0, 1, 0, 1, 0, 1, 0, 1, 0
            .word    1, 0, 1, 0, 1, 0, 1, 0, 1, 0
vector1:    .word    0, 1, 0, 1, 0, 1, 0, 1, 0, 1
            .word    0, 1, 0, 1, 0, 1, 0, 1, 0, 1
            .word    0, 1, 0, 1, 0, 1, 0, 1, 0, 1