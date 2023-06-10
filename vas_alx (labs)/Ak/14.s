.data
str1: .space 20
.text
	.globl __start

	__start:
li $v0, 8
la $a0, str1
li $a1, 20
syscall
li $v0, 4
la $a0, str1
syscall
sb $zero, str1+5
li $v0, 4
la $a0, str1
syscall
li $v0, 10
syscall