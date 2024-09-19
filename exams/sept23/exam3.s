#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
	
endl:		.asciiz 	"\n"
string1:	.asciiz		"Give geographic coordinates as a string of 11 chars (e.g. 3827N02308E): "
string2:	.asciiz		"You have given: "
string3:	.asciiz		"Latitude "
string4:	.asciiz		"Longitude "
buffer:		.asciiz 	"3827N02308E"
#str: 		.asciiz		""			# between "" put ascii chars. Each char uses 1 byte of memory!
#bytes: 	.byte xb, yb, ..., zb	# table of bytes: 8 bits of whatever: either [0, 255] or [-128, 127], or value of 1 ascii char, or a char in '', e.g. 'a', '\n'
#halfs: 	.half xh, yh, ..., zh	# table of half words: 16 bits of whatever: either [0, 65535] or [-32768, 32767], or values of 2 ascii chars
#words: 	.word xw, yw, ..., zw	# table of half words: 32 bits of whatever: either [0, 4294967295] or [-2147483648, 2147483647], or values of 4 ascii chars
#emptyMem:	.space xx 				# number of empty bytes
#minus_inf_simple:		.word 0xff800000
#plus_inf_simple:		.word 0x7f800000
#plus_nan_simple:		.word 0x7fffffff
#minus_nan_1_simple:	 .word 0xff900000
#minus_nan_2_simple:	 .word 0xffa00000
#minus_nan_3_simple:	 .word 0xffb00000
#not_defined_simple:	 .word 0xffc00000
#minus_nan_4_simple:	 .word 0xffd00000
#minus_nan_5_simple:	 .word 0xffe00000
#minus_nan_6_simple:	 .word 0xfff00000
# I_can_have_simple:	 .word 0xfff00000, 1, 2

#minus_inf_double:		.word 0x00000000, 0xfff00000
#plus_inf_double:		.word 0x00000000, 0x7ff00000
#plus_nan_double:		.word 0x00000000, 0x7ff80000
#minus_nan_double:		.word 0x00000000, 0xff800000

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start												
__start:
		mainloop:
		la $a0, string1
		jal print_str
		jal read_str
		move $a1, $a0
		lb $t0, 0($a0)
		li $t1, 10
		beq $t0, $t1, Exit
		jal print_str
		jal print_endl1
		la $a0, string2
		jal print_str
		jal process_string
		j mainloop
		
Exit:	li 		$v0, 10
		syscall				#au revoir...


#################################################
#			 									#
#     	 	Usefull code						#
#												#
#################################################

process_string: #a1 has the string

					# for the latitude, get each number and make the number as such: num0*10 + num1 + num2*0.1 + num2*0.01
					
					li.s $f12, 0.0
					
					lb $t1, 0($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					li.s $f1, 10.0
					mul.s $f0, $f0, $f1
					add.s $f12, $f12, $f0

				
					lb $t1, 1($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					add.s $f12, $f12, $f0
					
					lb $t1, 2($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					li.s $f1, 0.1
					mul.s $f0, $f0, $f1
					add.s $f12, $f12, $f0
					
					lb $t1, 3($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					li.s $f1, 0.01
					mul.s $f0, $f0, $f1
					add.s $f12, $f12, $f0
					
					lb $t0, 4($a1) 
					li $t1, 78
					beq $t0, $t1, positive #check if 5th byte is N, if it is it means we keep the number as positive
					li.s $f0, -1.0 # else we need to make it negative as it's south
					mul.s $f12, $f12, $f0
					
					positive: 
					la $a0, string3
					li $v0, 4
					syscall
					
					li $v0, 2
					syscall
					
					la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
					
					# for the longitude, do the same thing but make the number as such: num0*10 num1*10 + num2 + num3*0.1 + num4*0.01
					# where num0-4 is numbers converted from bytes 5-9
					

					li.s $f12, 0.0
					
					lb $t1, 5($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					li.s $f1, 100.0
					mul.s $f0, $f0, $f1
					add.s $f12, $f12, $f0
					
					lb $t1, 6($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					li.s $f1, 10.0
					mul.s $f0, $f0, $f1
					add.s $f12, $f12, $f0


				
					lb $t1, 7($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					add.s $f12, $f12, $f0
					
					lb $t1, 8($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					li.s $f1, 0.1
					mul.s $f0, $f0, $f1
					add.s $f12, $f12, $f0
					
					lb $t1, 9($a1)
					addi $t1, $t1, -48
					mtc1 $t1, $f0
					cvt.s.w $f0, $f0
					li.s $f1, 0.01
					mul.s $f0, $f0, $f1
					add.s $f12, $f12, $f0
					
					lb $t0, 10($a1) 
					li $t1, 87
					beq $t0, $t1, positive2 #check if 5th byte is W, if it is it means we keep the number as positive
					li.s $f0, -1.0 # else we need to make it negative as it's east
					mul.s $f12, $f12, $f0
					
					positive2: 
					la $a0, string4
					li $v0, 4
					syscall
					
					li $v0, 2
					syscall
					
					la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
				
				
				
				
					jr $ra

print_endl1:		la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
					jr $ra

print_endl2:		li		$a0, 10				# char of newline
					li		$v0, 11 			# system call to print
					syscall
					jr $ra
					
read_print_str:		li $v0, 8					# code to read a string
					#la $a0, ???				# ??? --> label with string
					#li $a1, ?n?				# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall
					li $v0, 4
					syscall
					jr $ra
					
read_str:			li $v0, 8					# code to read a string
					la $a0, buffer				# ??? --> label with string
					li $a1, 12				# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall
					jr $ra

print_str:			li $v0, 4
					#la $a0, ???				# ??? --> label with string
					syscall
					jr $ra
					

read_print_int:		li $v0, 5					# $v0 <--- integer
					syscall
					move $a0, $v0
					li $v0, 1
					syscall
					jr $ra

read_int:			li $v0, 5					# $v0 <--- integer
					syscall
					jr $ra

print_int_from_reg:	li $v0, 1
					#move	$a0, ???			# ???  --> register with integer
					syscall
					jr $ra

print_immidiate:	li $v0, 1
					#li $a0, ???					# ???  --> immediate
					syscall
					jr $ra

read_float:			li $v0, 6					# $f0 <--- float
					syscall
					jr $ra

print_float_from_reg:	#mov.s	$f12, ???			# ???  --> FP register with float
						li $v0, 2
						syscall
						jr $ra
					
read_print_float:	addi $sp, $sp, -4
					sw $ra, 0 ($sp)					
					jal read_float
					mov.s	$f12, $f0
					jal print_float_from_reg
					lw $ra, 0 ($sp)
					addi $sp, $sp, 4
					jr $ra					

print_float_immidiate:	li $v0, 2
#					li.s $f12, ???					# ???  --> immediate, e.g -1.2345678
					syscall
					jr $ra

read_double:		li $v0, 7				# $f0 <--- double
					syscall
					jr $ra

print_double_from_reg:	# mov.d	$f12, ???			# ???  --> FP register with double (even)
					li $v0, 3
					syscall
					jr $ra
					
read_print_double:	addi $sp, $sp, -4
					sw $ra, 0 ($sp)
					jal read_double
					mov.d	$f12, $f0
					jal print_double_from_reg
					lw $ra, 0 ($sp)
					addi $sp, $sp, 4
					jr $ra	

print_double_immidiate:	li $v0, 3
#					li.d $f12, ???					# ???  --> immediate, e.g -1.2345678
					syscall
					jr $ra
					
move_bits_from_gen_reg_to_fp_reg: # mtc1 $GR??, $FP??   # $GR?? = general purpose register, $FP?? = floating point register
									jr $ra
					
move_bits_from_fp_reg_to_gen_reg: # mfc1 $GR??, $FP??   # $GR?? = general purpose register, $FP?? = floating point register
									jr $ra
									
convert_float_to_int_in_C1:		# cvt.w.s $FP1??, $FP2??	# $FP1??, $FP2?? = floating point registers
								jr $ra
																
convert_double_to_int_in_C1:	# cvt.w.d $FP1??, $FP2??	# $FP1??, $FP2?? = floating point registers (both even)
								jr $ra
									
convert_int_to_float_in_C1:		# cvt.s.w $FP1??, $FP2??	# $FP1??, $FP2?? = floating point registers
								jr $ra
																
convert_int_to_double_in_C1:	# cvt.d.w $FP1??, $FP2??	# $FP1??, $FP2?? = floating point registers (both even)
								jr $ra
									
convert_float_to_int_and_print: 	addi $sp, $sp, -4
									sw $ra, 0 ($sp)
									jal convert_float_to_int_in_C1
									jal move_bits_from_fp_reg_to_gen_reg
									jal print_int_from_reg
									lw $ra, 0 ($sp)
									addi $sp, $sp, 4									
									jr $ra
									
convert_double_to_int_and_print: 	addi $sp, $sp, -4
									sw $ra, 0 ($sp)
									jal convert_double_to_int_in_C1
									jal move_bits_from_fp_reg_to_gen_reg
									jal print_int_from_reg
									lw $ra, 0 ($sp)
									addi $sp, $sp, 4									
									jr $ra
									
convert_int_to_float_and_print: 	addi $sp, $sp, -4
									sw $ra, 0 ($sp)
									jal move_bits_from_gen_reg_to_fp_reg
									jal convert_int_to_float_in_C1
									jal print_float_from_reg
									lw $ra, 0 ($sp)
									addi $sp, $sp, 4									
									jr $ra
									
convert_int_to_double_and_print: 	addi $sp, $sp, -4
									sw $ra, 0 ($sp)
									jal move_bits_from_gen_reg_to_fp_reg  # fp reg --> even only
									jal convert_int_to_double_in_C1
									jal print_double_from_reg
									lw $ra, 0 ($sp)
									addi $sp, $sp, 4									
									jr $ra
									
branch_in_simple_precision:	# c.XY.s $FP1??, $FP2??		# $FP1??, $FP2?? = floating point registers
							# XY can be {e, lt, le}
							# bc1t to_label
							# or
							# bc1f to_label
									
branch_in_double_precision:	# c.XY.d $FP1??, $FP2??		# $FP1??, $FP2?? = floating point registers (both even)
							# XY can be {e, lt, le}
							# bc1t to_label
							# or
							# bc1f to_label
									
# -----  Procedures / Functions ---------------------------------------------------------------

simplest_leaf_procedure_not_using_stack:  	
										# ...........
										jr $ra

simplest_leaf_function_not_using_stack_no_arguments:  	
										# ...........  	
										# return something to $v0	
										# ...........	
										# return something to $v1	
										# ...........
										jr $ra

leaf_procedure_non_using_stack_4_arguments:  	
										# ...........
										# do something with $a0	
										# ...........
										# do something with $a1	
										# ...........
										# do something with $a2
										# ...........	
										# do something with $a3
										# ...........
										jr $ra

leaf_function_not_using_stack_4_arguments:  	
										# ...........
										# do something with $a0	
										# ...........
										# do something with $a1	
										# ...........
										# do something with $a2
										# ...........	
										# do something with $a3 	
										# ...........  	
										# return something to $v0	
										# ...........	
										# return something to $v1	
										# ...........
										jr $ra
					
leaf_procedure_using_stack_no_arguments:  		
								# .....
					     		addi $sp, $sp, -16 # 4 words
								# ...........
								# sw $x1, 0 ($sp)
								# ...........
								# sw $x2, 4 ($sp)
								# ...........
								# sw $x3, 8 ($sp)
								# ...........
								# sw $x4, 12 ($sp)
								# ...........
								# ...........
								# lw $x1, 0 ($sp)
								# ...........
								# lw $x2, 4 ($sp)
								# ...........
								# lw $x3, 8 ($sp)
								# ...........
								# lw $x4, 12 ($sp)
								# ...........
								addi $sp, $sp, 16
								#...........
								jr $ra
					
leaf_function_using_stack_no_arguments:  		
								# ...........
					     		addi $sp, $sp, -16 # 4 words
								# ...........
								# sw $x1, 0 ($sp)
								# ...........
								# sw $x2, 4 ($sp)
								# ...........
								# sw $x3, 8 ($sp)
								# ...........
								# sw $x4, 12 ($sp)
								# ...........	
								# ...........  	
								# return something with $v0	
								# ...........	
								# return something with $v1
								# ...........
								# lw $x1, 0 ($sp)
								# ...........
								# lw $x2, 4 ($sp)
								# ...........
								# lw $x3, 8 ($sp)
								# ...........
								# lw $x4, 12 ($sp)
								# ...........
								addi $sp, $sp, 16
								# ...........
								jr $ra
					
leaf_function_using_stack_4_arguments:  		
								# ...........
					     		addi $sp, $sp, -16 # 4 words
								# ...........
								# sw $x1, 0 ($sp)
								# ...........
								# sw $x2, 4 ($sp)
								# ...........
								# sw $x3, 8 ($sp)
								# ...........
								# sw $x4, 12 ($sp) 	
								# ...........
								# do something with $a0	
								# ...........
								# do something with $a1	
								# ...........
								# do something with $a2
								# ...........	
								# do something with $a3 
								# ...........	
								# ...........  	
								# return something with $v0	
								# ...........	
								# return something with $v1
								# ...........
								# lw $x1, 0 ($sp)
								# ...........
								# lw $x2, 4 ($sp)
								# ...........
								# lw $x3, 8 ($sp)
								# ...........
								# lw $x4, 12 ($sp)
								# ...........
								addi $sp, $sp, 16
								# ...........
								jr $ra
					
leaf_procedure_using_stack_4_arguments:  		
								# .....
					     		addi $sp, $sp, -16 # 4 words
								# ...........
								# sw $x1, 0 ($sp)
								# ...........
								# sw $x2, 4 ($sp)
								# ...........
								# sw $x3, 8 ($sp)
								# ...........
								# sw $x4, 12 ($sp)  	
								#...........
								# do something with $a0	
								#...........
								# do something with $a1	
								#...........
								# do something with $a2
								#...........	
								# do something with $a3 
								# ...........
								# ...........
								# lw $x1, 0 ($sp)
								# ...........
								# lw $x2, 4 ($sp)
								# ...........
								# lw $x3, 8 ($sp)
								# ...........
								# lw $x4, 12 ($sp)
								# ...........
								addi $sp, $sp, 16
								#...........
								jr $ra
						
node_procedure_using_stack_no_arguments:
								# ...........
					     		addi $sp, $sp, -16 # 4 words
								# ...........
								sw $ra, 12 ($sp)
								# ...........
								# sw $x3, 8 ($sp)
								# ...........
								# sw $x2, 4 ($sp)
								# ...........
								# sw $x1, 0 ($sp)
								# ...........
								# ...........
								jal any_procedure
								# ...........
								# ...........
								# lw $x1, 0 ($sp)
								# ...........
								# lw $x2, 4 ($sp)
								# ...........
								# lw $x3, 8 ($sp)
								# ...........
								lw $ra, 12 ($sp)
								# ...........
								addi $sp, $sp, 16
								#...........
								jr $ra
						
node_function_using_stack_no_arguments:		
								# ...........
					     		addi $sp, $sp, -16 # 4 words
								# ...........
								sw $ra, 12 ($sp)
								# ...........
								# sw $x3, 8 ($sp)
								# ...........
								# sw $x2, 4 ($sp)
								# ...........
								# sw $x1, 0 ($sp)
								# ...........
								# ...........
								jal any_procedure
								# ...........
								# ........... 	
								# return something with $v0	
								# ...........	
								# return something with $v1
								# ...........
								# lw $x1, 0 ($sp)
								# ...........
								# lw $x2, 4 ($sp)
								# ...........
								# lw $x3, 8 ($sp)
								# ...........
								lw $ra, 12 ($sp)
								# ...........
								addi $sp, $sp, 16
								#...........
								jr $ra
						
node_procedure_using_stack_4_arguments:
								# ...........
					     		addi $sp, $sp, -16 # 4 words
								# ...........
								sw $ra, 12 ($sp)
								# ...........
								# sw $x3, 8 ($sp)
								# ...........
								# sw $x2, 4 ($sp)
								# ...........
								# sw $x1, 0 ($sp)  	
								#...........
								# do something with $a0	
								#...........
								# do something with $a1	
								#...........
								# do something with $a2
								#...........	
								# do something with $a3
								# ...........
								# ...........
								jal any_procedure
								# ...........
								# ...........
								# lw $x1, 0 ($sp)
								# ...........
								# lw $x2, 4 ($sp)
								# ...........
								# lw $x3, 8 ($sp)
								# ...........
								lw $ra, 12 ($sp)
								# ...........
								addi $sp, $sp, 16
								#...........
								jr $ra
						
node_function_using_stack_4_arguments:		
								# ...........
					     		addi $sp, $sp, -16 # 4 words
								# ...........
								sw $ra, 12 ($sp)
								# ...........
								# sw $x3, 8 ($sp)
								# ...........
								# sw $x2, 4 ($sp)
								# ...........
								# sw $x1, 0 ($sp)  	
								#...........
								# do something with $a0	
								#...........
								# do something with $a1	
								#...........
								# do something with $a2
								#...........	
								# do something with $a3
								# ...........
								# ...........
								jal any_procedure
								# ...........
								# ........... 	
								# return something with $v0	
								# ...........	
								# return something with $v1
								# ...........
								# lw $x1, 0 ($sp)
								# ...........
								# lw $x2, 4 ($sp)
								# ...........
								# lw $x3, 8 ($sp)
								# ...........
								lw $ra, 12 ($sp)
								# ...........
								addi $sp, $sp, 16
								#...........
								jr $ra
						
switch_case_no_break:   #...........
						#move $XY, $zero     	# initialize flag register $XY
		case01:			#bXX $YY,$ZZ, case02 	# this condition/case is not valid, check next case 	
		if_case01:		#...........
						#addi $XY, $XY, 1
						
		case02:			#bXX $YY,$ZZ, case?? 	# this condition/case is not valid, check next case 	
		if_case02:		#...........
						#addi $XY, $XY, 1						

						#...........
						
		case0n:			#bXX $YY,$ZZ, case03 	# this condition/case is not valid, check next case 	
		if_case0n:		#...........
						#addi $XY, $XY, 1
						
		else_case:		#bne $XY,$zero, Exit	# non of previous conditions/cases exit, exit 	
		if_non_case:	#...........
						
switch_case_with_break: #...........
		case001:		#bXX $YY,$ZZ, case02 	# this condition/case is not valid, check next case 	
		if_case001:		#...........
						#j Exit_switch_case
						
		case002:		#bXX $YY,$ZZ, case?? 	# this condition/case is not valid, check next case 	
		if_case002:		#...........
						#j Exit_switch_case						

						#...........
						
		case00n:		#bXX $YY,$ZZ, else_case 	# this condition/case is not valid, check next case 	
		if_case00n:		#...........
						#j Exit_switch_case
						
		else_case_:		#...........	 		# non of previous conditions/cases exit 	
		if_non_case_:	#...........
		
while_do_1_condition_Direct:   	# ...........
		if_condition_do:		# bXX $YY,$ZZ, do_1_condition_Direct        #if
								# j Exit_while_do_1_condition_Direct        #else
		do_1_condition_Direct:	# ...........
								# addi #counter, #counter, 1  #possible approach
						
								j while_do_1_condition
		
		
while_do_1_condition_Indirect:	# ...........									# stop if not,  { !(condition) }
		if_not_condition_exit:	# bXX $YY,$ZZ, Exit_while_do_1_condition_Indirect		# if not condition exit loop

								# ...........
								# addi #counter, #counter, 1  #possible approach
						
								j while_do_1_condition_Indirect
		
do_while_1_condition_Direct:  	# ...........
								# addi #counter, #counter, 1  #possible approach
								# ...........
								
		if_condition_Direct_do:	# bXX $YY,$ZZ, do_while_1_condition_Direct		
		
do_while_1_condition_Indirect:  	# ...........
									# addi #counter, #counter, 1  #possible approach
									# ...........
								
		if_not_conditionInd_exit:	# bXX $YY,$ZZ, Exit_do_while_1_condition_Indirect
		
									# ...........
									j do_while_1_condition_Indirect
						
while_a_AND_b_do_Direct:	#...........						# direct approach
	if_a_Check_if_b:		#bXX $RR,$ZZ, if_b_Do_a_AND_b		# if a is valid check b
							#j exit_while
						
	if_b_Do_a_AND_b:		#bYY $WW,$TT, do_a_AND_b			# if b is valid do
							#j exit_while
												
	do_a_AND_b: 			#...........
							#addi #counter, #counter, 1  		#possible approach
						
							j while_a_AND_b_do_Direct
						
while_a_AND_b_do_Indirect:	#...........						# stop if !a OR !b,  { !(!a OR !b) <=> a AND B }
	if_not_a_exit_while:	#bXX $RR,$ZZ, Exit_while			# if a is not valid exit while
	if_not_b_exit_while:	#bYY $WW,$TT, Exit_while			# if b is not valid exit while
												
	else_do_a_AND_b:		#...........
							#addi #counter, #counter, 1			#possible approach
						
							j while_a_AND_b_do_Indirect

while_not_a_AND_not_b_do_Direct:	#e.g.:  3.3a:            
									#...........				{!(do when a!=x AND b<=n) <=> stop if (a=x OR b>n)}
	if_not_a_Check_if_not_b:		#bXX $RR,$ZZ, if_not_b_Do_not_a_AND_not_b    # if a is not valid check if b is also not valid
									#j exit_while
						
	if_not_b_Do_not_a_AND_not_b:	#bYY $WW,$TT, do_not_a_AND_not_b
									#j exit_while
												
	do_not_a_AND_not_b: 			#...........
									#addi #counter, #counter, 1			#possible approach
						
									j while_not_a_AND_not_b_do_Direct

while_not_a_AND_not_b_do_Indirect:	#e.g.:  3.3a:            
									#...........				{!(do when a!=x AND b<=n) <=> stop if (a=x OR b>n)}
	if_a_exit_while:				#bXX $RR,$ZZ, exit_while    		# if a is valid exit while
	if_b_exit_while:				#bYY $WW,$TT, exit_while    		# if b is valid exit while

	else_do_not_a_AND_not_b:		#...........
									#addi #counter, #counter, 1			#possible approach
						
									j while_not_a_AND_not_b_do_Indirect
		
while_a_OR_b_do_Direct:   	#...........				
	if_a_Do_a_OR_b:			#bXX $RR,$ZZ, do_a_OR_b				# if a is valid do
	if_b_Do_a_OR_b:			#bYY $WW,$TT, do_a_OR_b				# if !b is not valid exit while
							#j Exit_while						# else
	do_a_OR_b: 				#...........
					 		#addi #counter, #counter, 1			#possible approach
						
							j while_a_OR_b_do_Direct		
		
while_a_OR_b_do_Indirect:		#...........							# stop if !a AND !b { !(a OR b) <=> !a AND !b }
	if_not_a_Check_if_not_b2:	#bXX $RR,$ZZ, if_not_b_Exit_while 		# if a is not valid check if b is not valid

	do_a_OR_b_do_Indirect:		#...........
								#addi #counter, #counter, 1  #possible approach							
						
								j while_a_OR_b_do_Indirect
	
	if_not_b_Exit_while:		#bYY $WW,$TT, Exit_while			# if b is not valid exit while
								j do_a_OR_b_do_Indirect				# else

#-------------------------------------------------------							
IS_PRIME_function:	# input: positive integer (not zero) at $a0
					# output: 0 or 1 at $v1

			li $t1, 0 # create count variable
			li $t2, 1 # i : 
	IS_PRIME_LOOP:

			rem $t3, $t0, $t2
			beq $t3, 0, INCREASE_COUNT
			j INCREASE_I

	INCREASE_COUNT:
			addi $t1, $t1, 1

	INCREASE_I:
			addi $t2, $t2, 1
			slt $t4, $t0, $t2 # check if i > number, store boolean value in $t4
			beq $t4, 0, IS_PRIME_LOOP

	# loop end
			
			beq $t1, 2, PRIME_TRUE
			j PRIME_FALSE

	PRIME_TRUE:
			li $v1, 1
			jr $ra

	PRIME_FALSE:
	  		li $v1, 0
			jr $ra	
			
# End of IS_PRIME					
