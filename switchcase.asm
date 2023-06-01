#	High-Level C Code
#	switch (amount) {
#		case 20: fee = 2; 
#				 break;
#		case 50: fee = 3; 
#				 break;
#		case 100: fee = 5;
#				 break;
#		default: fee = 0;
#	}

# MIPS Assembly
# $s0 = amount, $s1 = fee
		li $s0, 21   
 
# ---------- CASE statement implementation BEGINS  -------------
case20:
		addi $t0, $0, 20 		# $t0 = 20
		bne $s0, $t0, case50 		# amount = = 20? if not,
						# skip to case50
		addi $s1, $0, 2 		# if so, fee = 2
		j done 				# and break out of case
case50:
		addi $t0, $0, 50 		# $t0 = 50
		bne $s0, $t0, case100 		# amount = = 50? if not,
						# skip to case100
		addi $s1, $0, 3 		# if so, fee = 3
		j done 				# and break out of case
case100:
		addi $t0, $0, 100 		# $t0 = 100
		bne $s0, $t0, default 		# amount = = 100? if not,
						# skip to default
		addi $s1, $0, 5 		# if so, fee = 5
		j done				# and break out of case
default:
		add $s1, $0, $0 		# fee = 0
done:           
		add $t5, $t0, $0                # dummy code
# ---------- CASE statement implementation ENDS  -------------

		li	$v0, 10					# system call code for exit = 10
		syscall
