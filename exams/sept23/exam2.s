# MESSAGES
.data
	
endl:		.asciiz 	"\n"
buffer:		.space 		31
string1:	.asciiz		"Enter lastname and firstname as a string of 30 chars: "
string2:	.asciiz		"Enter a real number: "
string3: 	.asciiz		"Integer and power of 2 or ±inf!"
string4: 	.asciiz		"Not an integer and power of 2, not ±inf!"
string5: 	.asciiz 	"End of program."

.text
.globl __start	
											
__start:
		mainloop:
		
		la $a0, string1
		jal print_str
		jal print_endl1
		jal read_str
		jal print_str
		la $a0, string2
		jal print_str
		jal read_float
		mov.s $f12, $f0
		jal print_float_from_reg
		jal print_endl1
		li.s $f1, 0.0
		c.eq.s $f0, $f1
		bc1t Exit
		la $a0, string3
		jal check_pow2_or_inf
		jal print_endl1
		j mainloop
		

Exit:	la $a0, string5
		jal print_str
		li 		$v0, 10
		syscall
		
# FUNCS

check_pow2_or_inf:
					mfc1 $t0, $f0
				
					
					sll $t1, $t0, 9
					srl $t1, $t1, 9
					bnez $t1, return
     					sll $t1, $t0, 1
					srl $t1, $t1, 24
					addi $t1, $t1, -127
					bltz $t1, return
					la $a0, string3
					li $v0, 4
					syscall
					jr $ra
					
					
					
					return:
					la $a0, string4
					li $v0, 4
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
				
					
read_str:			li $v0, 8					# code to read a string
					la $a0, buffer				# ??? --> label with string
					li $a1, 31		# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall
					jr $ra

print_str:			li $v0, 4
					#la $a0, ???				# ??? --> label with string
					syscall
					jr $ra
					
read_float:			li $v0, 6					# $f0 <--- float
					syscall
					jr $ra

print_float_from_reg:	#mov.s	$f12, ???			# ???  --> FP register with float
						li $v0, 2
						syscall
						jr $ra
