.data
    w0:	.word 0xf2345678
    w1:	.word 0xff654321
.text
    .globl main

main:
    # load
    lw   $t1, w0
    lw   $t2, w1

    addu $s0, $t1, $t2
    xor $s1, $s0, $t1
    xor $s2, $s0, $t2

    or $s3, $s1, $s2
    srl $s3, $s3, 31
    # exit
    li   $v0, 10
    syscall
