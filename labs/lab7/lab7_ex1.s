.text
.globl __start

__start:
    jal ReadFloat
    jal PrintFloat
    j Exit


PrintFloat:
    li a7, 2
    ecall
    jr ra

ReadFloat:
    li a7, 6
    ecall
    jr ra

Exit:
    li  a7, 10
    ecall

.data
