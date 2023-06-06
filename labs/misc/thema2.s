#	 String of Numbers in Octal System to		
#	  String of Numbers in Binary System        

.text
.globl     __start	
												
__start:

	loop:
		la $a0, buffer
		li $v0, 8	# read string
		syscall

		li $v0, 4
		syscall

		# load the ascii codes of numbers 0-7 in temporary registers
		la $t1, zero_oct
		lb $t1, 0($t1)
		la $t2, one_oct
		lb $t2, 0($t2)
		la $t3, two_oct
		lb $t3, 0($t3)
		la $t4, three_oct
		lb $t4, 0($t4)
		la $t5, four_oct
		lb $t5, 0($t5)
		la $t6, five_oct
		lb $t6, 0($t6)
		la $t7, six_oct
		lb $t7, 0($t7)
		la $t8, seven_oct
		lb $t8, 0($t8)

		addi $s4, $zero, 4	# store value 4 in $s4
		addi $s3, $zero, 0	# initialize #s3 with 0, which is a counter for the number of characters,
							# that represent 0
		la $s0, buffer		# load the address of the "buffer" label in $s0
	loop2:
		
		lb $t0, 0($s0)		# load the byte that is stored in the address that is
							# stored in $s0



		case01:			bne $t0, $t1, case02 	# this condition/case is not valid, check next case 	
		if_case01:		addi $s3, $s3, 1		# increases the counter of 0's by 1
						la $a0, zero_bin
						li $v0, 4		# print string, that is stored in "zero_bin" label
						syscall
						j next			# jump to next, so we can continue with the next character/number

		case02:			bne $t0, $t2, case03 	# this condition/case is not valid, check next case 	
		if_case02:		
						la $a0, one_bin
						li $v0, 4		# print string, that is stored in "one_bin" label
						syscall
						j next			# jump to next, so we can continue with the next character/number

		case03:			bne $t0, $t3, case04 	# this condition/case is not valid, check next case 	
		if_case03:		
						la $a0, two_bin
						li $v0, 4		# print string, that is stored in "two_bin" label
						syscall
						j next			# jump to next, so we can continue with the next character/number

		case04:			bne $t0, $t4, case05 	# this condition/case is not valid, check next case 	
		if_case04:		
						la $a0, three_bin
						li $v0, 4		# print string, that is stored in "three_bin" label
						syscall
						j next			# jump to next, so we can continue with the next character/number

		case05:			bne $t0, $t5, case06 	# this condition/case is not valid, check next case 	
		if_case05:		
						la $a0, four_bin
						li $v0, 4		# print string, that is stored in "four_bin" label
						syscall
						j next			# jump to next, so we can continue with the next character/number

		case06:			bne $t0, $t6, case07 	# this condition/case is not valid, check next case 	
		if_case06:		la $a0, five_bin
						li $v0, 4		# print string, that is stored in "five_bin" label
						syscall
						j next			# jump to next, so we can continue with the next character/number

		case07:			bne $t0, $t7, case08 	# this condition/case is not valid, check next case 	
		if_case07:		la $a0, six_bin
						li $v0, 4		# print string, that is stored in "six_bin" label
						syscall
						j next			# jump to next, so we can continue with the next character/number

		case08:			bne $t0, $t8, case09	# non of previous conditions/cases exit, exit 	
		if_case08:		la $a0, seven_bin
						li $v0, 4		# print string, that is stored in "seven_bin" label
						syscall
						j next			# jump to next, so we can continue with the next character/number

		case09:        	la $a0, error	#print string, in case that the number is not a digit of octal system
						li $v0, 4
						syscall
						j loop			# jump to the first loop, because the given
										# string was wrong, so we must read a different one

			
		beq $s3, $s4, exit		# if the counter's value is equal to 4, it means that the
								# string of numbers in octal system is "0000" and
								# the program ends

	next: 
		addi $s0, $s0, 1		# we increase the address that is stored in $s0, so
								# now it points in the next character
		j loop2					# jump to the beginning of the second loop


	Exit:				
		li 	$v0, 10
		syscall				#au revoir...

.data
endl: 					.asciiz 	"\n"
buffer: 				.space      5
error:                  .asciiz  "ERROR"
zero_oct:              .ascii       "0"
one_oct:               .ascii       "1"
two_oct:               .ascii		"2"
three_oct:             .ascii       "3"
four_oct:              .ascii       "4"
five_oct:              .ascii       "5"
six_oct:               .ascii		"6"
seven_oct:             .ascii       "7"
zero_bin:              .asciiz       "000 "
one_bin:               .asciiz       "001 "
two_bin:               .asciiz		 "010 "
three_bin:             .asciiz       "011 "
four_bin:              .asciiz       "100 "
five_bin:              .asciiz       "101 "
six_bin:               .asciiz		 "110 "
seven_bin:             .asciiz       "111 "

