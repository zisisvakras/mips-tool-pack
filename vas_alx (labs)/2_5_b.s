.text
    .globl __start

__start:

lw $s0, word64_1 # hi
lw $s1, word64_1 + 4 # lo
lw $s2, word64_2 # hi 
lw $s3, word64_2 + 4 # lo

addu $s4, $s1, $s3 # lo

srl $t1, $s1, 31 
srl $t2, $s3, 31
srl $t3, $s4, 31

nor $t3, $zero, $t3

and $t4, $t1, $t2
and $t5, $t2, $t3
and $t6, $t1, $t3

or $t7, $t4, $t5
or $t7, $t6, $t7
# t7 has the first carry

addu $s5, $s0, $s2 # hi 

srl $t1, $s0, 31 
srl $t2, $s2, 31
srl $t3, $s5, 31

nor $t3, $zero, $t3

and $t4, $t1, $t2
and $t5, $t2, $t3
and $t6, $t1, $t3

or $t8, $t4, $t5
or $t8, $t6, $t8
# t8 has the second carry

addu $t0, $s5, $t7

srl $t1, $s5, 31 
srl $t2, $t7, 31
srl $t3, $t0, 31

nor $t3, $zero, $t3

and $t4, $t1, $t2
and $t5, $t2, $t3
and $t6, $t1, $t3

or $t1, $t4, $t5
or $t1, $t6, $t1

or $t8, $t8, $t1


addu $t1, $s0, $s2 # hi 

li $v0, 10
syscall

.data
word64_1: .word 0xffffffff, 0xffffffff
word64_2: .word 0x00000a00, 0x00000002