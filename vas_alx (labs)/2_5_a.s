.text
    .globl __start

__start:

lw $s1, word1
lw $s2, word2

addu $s3, $s1, $s2

srl $t1, $s1, 31
srl $t2, $s2, 31
srl $t3, $s3, 31

nor $t3, $zero, $t3

and $t4, $t1, $t2
and $t5, $t2, $t3
and $t6, $t1, $t3

or $t0, $t4, $t5
or $s0, $t0, $t6


li $v0, 10
syscall

.data
word1: .word 0xffffffff
word2: .word 0x00000002