.data
str0: .space 20
strx: .asciiz "     \n"
str1: .asciiz "     \n"
str2: .asciiz "     \n"
str3: .asciiz "     \n"
str4: .asciiz "     \n"

.text
	.globl __start

	__start:
li $v0, 8
la $a0, str0
li $a1, 20
syscall
li $v0, 4
la $a0, str0
syscall
sb $zero, str0+6
ori $t6, $zero, 10
sb $t6, str0+5
li $v0, 4
la $a0, str0
syscall


lb $t6, str0
sb $t6, strx 
li $v0, 4
la $a0, strx
syscall

lb $t6, str0+1
sb $t6, str1+1 
li $v0, 4
la $a0, str1
syscall

lb $t6, str0+2
sb $t6, str2+2 
li $v0, 4
la $a0, str2
syscall

lb $t6, str0+3
sb $t6, str3+3 
li $v0, 4
la $a0, str3
syscall

lb $t6, str0+4
sb $t6, str4+4 
li $v0, 4
la $a0, str4
syscall


li $v0, 10
syscall


