#	High-Level Code
#	int sum = 0;
#	for (i = 0; i != 10; i = i + 1) {
#	sum = sum + i ;
#	}
#	// equivalent to the following while loop
#	int sum = 0;
#	int i = 0;
#	while (i != 10) {
#	sum = sum + i;
#	i = i + 1;
#	}

# MIPS Assembly

# $s0 = i, $s1 = sum

		add $s1, $0, $0 			# sum = 0
		addi $s0, $0, 0 			# i = 0
		addi $t0, $0, 10 			# $t0 = 10
# ---------- FOR statement implementation BEGINS  -------------
for:
		beq $s0, $t0, done 			# if i = = 10, branch to done
		add $s1, $s1, $s0 			# sum = sum + i
		addi $s0, $s0, 1 			# increment i
		j for
done:	        add $t5, $t0, $0
# ---------- FOR statement implementation ENDS  -------------

		li	$v0, 10					# system call code for exit = 10
		syscall

