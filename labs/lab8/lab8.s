    .org 0x200
    .text
    .globl _start

_start:
    la s0, array
    addi s1, s0, 40
    addi s2, zero, 0
loop:
    lw s3, 0(s0)
    add s2, s2, s3
    addi s0, s0, 4
    bne s0, s1, loop
exit:
    sw s2, 0(s0)    
    ebreak


    .org 0x400
    .data
array:  .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10