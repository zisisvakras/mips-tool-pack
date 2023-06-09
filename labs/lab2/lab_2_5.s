.data
	w0:	.word 0xf2345678
	w1:	.word 0xff654321
.text
	.globl main

main:   
    # load
    lw   $s0, w0
    lw   $s1, w1
    addu $s2, $s1, $s0 # sum
    # si'ai + si'bi
    nor  $s2, $s2, $zero
    or   $s3, $s1, $s0
    and  $s3, $s3, $s2
    # + aibi
    and  $t0, $s1, $s0
    or   $s3, $s3, $t0
    # shift to leave 1 bit
    srl  $s3, $s3, 31
    # exit
    li   $v0, 10
    syscall
