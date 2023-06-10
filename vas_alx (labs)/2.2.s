.text
    .globl __start

__start:
# let $s0 have the word
li $s0, 0x12345678
sll $t0, $s0, 24

srl $t1, $s0, 8
sll $t1, $t1, 24
srl $t1, $t1, 8

srl $t2, $s0, 16
sll $t2, $t2, 24 
srl $t2, $t2, 16


srl $t3, $s0, 24

# let $s1 have the result

or $s1, $zero, $t0
or $s1, $s1, $t1
or $s1, $s1, $t2
or $s1, $s1, $t3


li $v0, 10
syscall





