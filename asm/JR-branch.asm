# MIPS assembly programn starts at 0x00003000

	addi $s0, $0, 0x3014 	# load 0x3014                     0x3000
	jr $s0 # jump to $s0                        	          0x3004
	addi $s1, $0, 1 		# not executed                    0x3008
	addi $s2, $0, 2 		# not executed                    0x300c
	addi $s3, $0, 3 		# not executed                    0x3010
	addi $s4, $0, 4 		# program cont                    0x3014
	sra $s1, $s1, 2 		# program cont                    0x3018
	lw $s3, 44($s1) 		# program cont                    0x301c

	li	$v0, 10				# system call code for exit = 10
	syscall
