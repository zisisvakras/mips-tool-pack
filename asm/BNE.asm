# MIPS assembly
	addi $s0, $0, 4 # $s0 = 0 + 4 = 4
	addi $s1, $0, 1 # $s1 = 0 + 1 = 1
	sll $s1, $s1, 2 # $s1 = 1 << 2 = 4
	bne $s0, $s1, target # branch not taken
	addi $s1, $s1, 1 # $s1 = 4 + 1 = 5
	sub $s1, $s1, $s0 # $s1 = 5 – 4 = 1
target:
	add $s1, $s1, $s0 # $s1 = 1 + 4 = 5

	li	$v0, 10		# system call code for exit = 10
	syscall
