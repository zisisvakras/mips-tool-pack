# MESSAGES
.data
	
endl:		.asciiz 	"\n"
string1:	.asciiz		"Give geographic coordinates as a string of 11 chars (e.g. 3827N02308E): "
string2:	.asciiz		"You have given: "
string3:	.asciiz		"Latitude "
string4:	.asciiz		"Longitude "
buffer:		.asciiz 	"3827N02308E"

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
		syscall
		
# FUNCS

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
					
					li $v0, 2 # number is ready, print it
					syscall
					
					la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
					
					# for the longitude, do the same thing but make the number as such: num0*100 num1*10 + num2 + num3*0.1 + num4*0.01 to account for bigger range
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
					
					li $v0, 2 # number is ready, print it
					syscall
					
					la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
				
				
				
				
					jr $ra

print_endl1:		la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
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
					

read_float:			li $v0, 6					# $f0 <--- float
					syscall
					jr $ra