#----------   C code ------------
#
#	// determines the power
#	// of x such that 2x = 128
#	int pow = 1;
#	int x = 0;
#	while (pow != 128) {
#	pow = pow * 2;
#	x = x + 1;
#	}

# MIPS Assembly 
# $s0 = pow, $s1 = x
	addi $s0, $0, 1
	add $s1, $0, $0
	addi $t0, $0, 128
# ---------- WHILE statement implementation BEGIN  -------------
while:  beq $s0, $t0, done
	sll $s0, $s0, 1
	addi $s1, $s1, 1
	j while	
done:   add $t5, $t0, $0
# ---------- WHILE statement implementation ENDS  -------------

 	li	$v0, 10		# system call code for exit = 10
	syscall