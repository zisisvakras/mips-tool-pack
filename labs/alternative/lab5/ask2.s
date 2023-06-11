.text
 .globl __start
__start:
li $v0, 6
syscall
mov.s $f12, $f0
li $v0, 2
syscall

jal newl
mov.s $f0, $f12

li $v0, 6
syscall
mov.s $f12, $f0
li $v0, 2
syscall
jal newl


mov.s $f1, $f12

#lw $t0, inf
#mtc1

l.s $f1, inf

mul.s $f12, $f0, $f1
li $v0, 2
syscall
jal newl


li $v0,10 # exit
syscall

newl:
	la $a0, endl
	li $v0, 4
	syscall
	jr $ra

.data
zero: .word 0x0
nan: .word 0x7fe00000
inf: .word 0x7f800000
ninf: .word 0xff800000
n: .word 25
msg1: .asciiz "! is :"
endl: .asciiz "\n" 
