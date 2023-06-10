
.text
	.globl __start

	__start:
li $v0, 5
syscall
move $a0, $v0
#ori $t0, $a0, $zero
add $t0, $a0, $zero

li $v0, 1
syscall
li $v0, 11
li $a0, 10
syscall

li $v0, 5
syscall
move $a0, $v0
add $t1, $a0, $zero
 
li $v0, 1
syscall
li $v0, 11
li $a0, 10
syscall
add $t2, $t0, $t1
sub $t3, $t0, $t1

li $v0, 1
move $a0, $t2
syscall 
li $v0, 11
li $a0, 10
syscall
li $v0, 1
move $a0, $t3
syscall
li $v0, 11
li $a0, 10
syscall

li $v0, 10
syscall