    .text
        .globl __start
__start:
    flw ft0, n, t0            # t0 = n
    flw ft1, one, t0          # t1 contains i!
    flw ft2, one, t0          # t2 index i=1..n

loop:
    fmul.s ft1, ft1, ft2

    fmv.s fa0, ft2
    li a7, 2
    ecall                   # display i

    la a0, msg1
    li a7, 4
    ecall                   # display "! is :"

    fmv.s fa0, ft1
    li a7, 2
    ecall                   # display i!

    la a0, endl
    li a7, 4
    ecall                   # print end of line
    
    flw ft3, one, t0
    fadd.s ft2, ft2, ft3    # i=i+1

    fle.s t0, ft2, ft0      # repeat if i<=n
    bnez t0, loop

    li a7, 10               # exit
    ecall

    .data
n:      .float  25.0
msg1:   .asciz "! is :"
endl:   .asciz "\n"


one:    .float 1.0