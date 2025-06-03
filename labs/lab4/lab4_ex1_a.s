.text
.globl __start

__start:
    call ReadInt
    mv t0, a0
    
    li t1, -129
    bgt t0, t2, msg1
    li t1, 128
    blt t0, t1, msg1
    
    li t1, -32769
    bgt t0, t1, msg2
    li t1, 32768
    blt t0, t1, msg2

    j msg3

  msg1:
    la a0, MSG1
    call PrintString

  msg2:
    la a0, MSG2
    call PrintString

  msg3:
    la a0, MSG4
    call PrintString

  done:
    j Exit

ReadInt:
    li a7, 5
    ecall
    jr ra
    
PrintString:
    li a7, 4
    ecall
    jr ra

Exit:
    li a7, 10
    ecall

.data
MSG1: .asciz "The number fits in one byte\n"
MSG2: .asciz "The number fits in two bytes\n"
MSG4: .asciz "The number fits in four bytes\n"


