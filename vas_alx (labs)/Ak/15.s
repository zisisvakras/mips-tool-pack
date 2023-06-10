.data
str1: .space 20
.text
	.globl __start

	__start:
li $v0, 5
syscall
move $a0, $v0

li $v0, 1
syscall

li $v0, 10
syscall