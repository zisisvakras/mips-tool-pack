# MIPS assembly for J branch 

	addi $s0, $0, 4 # $s0 = 4
	addi $s1, $0, 1 # $s1 = 1
	j target # jump to target
	sra $s1, $s1, 2 # not executed
	addi $s1, $s1, 1 # not executed
	sub $s1, $s1, $s0 # not executed
target:
	add $s1, $s1, $s0 # $s1 = 1 + 4 = 5

	li	$v0, 10		# system call code for exit = 10
	syscall
