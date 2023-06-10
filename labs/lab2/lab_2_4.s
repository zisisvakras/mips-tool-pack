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
    xor  $t0, $s2, $s0 # w0 ^ sum
    xor  $t1, $s2, $s1 # w1 ^ sum
    # calculate ovf in $t0
    and  $t0, $t1, $t0
    # exit
    li   $v0, 10
    syscall