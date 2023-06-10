    .text
	.globl     __start	
												#read first int and move it to a temp reg
__start:

li $v0, 6
syscall

mov.s $f12, $f0

li $v0, 2
syscall


li $v0, 10
syscall #au revoir