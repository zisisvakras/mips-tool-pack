# MESSAGES
.data
	
endl:		.asciiz 	"\n"
buffer:		.space 		31
string1:	.asciiz		"Enter lastname and firstname as a string of 30 chars: "
string2:	.asciiz		"Enter a real number: "
string3: 	.asciiz		"Reversing the bits of real r: "
string4: 	.asciiz 	"End of program."

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
		jal reverse_bits_float
		jal print_endl1
		j mainloop
		

Exit:	la $a0, string4
		jal print_str
		li 		$v0, 10
		syscall
		
#FUNCS

reverse_bits_float:
					mfc1 $t0, $f0
					
					li $t1, 0
					li $t2, 0
				
					loop:
						move $t3, $t0 #loop to reverse digits
						srlv, $t3, $t0, $t1 #for i from 0 to 32, get the ith bit of t0 and add it to t2. also shift t2 left by 1 each time to "make room" for new bit.
						and $t3, $t3, 1
						sll $t2, $t2, 1
						add $t2, $t2, $t3
						addi $t1, $t1, 1
					li $t4, 32
					bne $t1, $t4, loop
					mtc1 $t2, $f2
					mov.s $f12, $f2
					li $v0, 2
					syscall
					
					jr $ra
					
print_endl1:		la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
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