# Lab 2 - Exercise 1

.text
.globl __start

__start:
    lw s0, A
    lw s1, B
    add s2, s0, s1
    la t0, sum
    sw s2, (t0)

    # exit system call
    li  a7, 10
    ecall

.data
A:   .word 2
B:   .word 3
sum: .word 0