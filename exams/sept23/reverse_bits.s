# MESSAGES
.data

name_prompt: .asciiz "Enter lastname and firstname as a string of 30 chars: "
name: .space 31		# 30 chars + null byte 

float_prompt: .asciiz "Enter a real number: "
zero_float: .float 0.0
result_msg: .asciiz "Reversing the bits of the real number: "

end_msg: .asciiz "End of Program"


.text
.globl __start												

__start:

###################  INTPUT  ###########################

Main_Loop: 

		la $a0, name_prompt
		jal print_string
		
		jal print_endl
		
		la $a0, name
		li $a1, 31
        jal read_string
		
        # $a0 already strores the address of the name
        jal print_string
		
		jal print_endl
		
		
		la $a0, float_prompt	
        jal print_string
		
		jal print_endl1
		
        # result in $f0
        jal read_float

		mov.s $f12, $f0 	# f12 stores the float
        jal print_float
		
		jal print_endl

		
		l.s $f8, zero_float		# checks if f12 is 0
		c.eq.s $f12, $f8 		# true: print end of program
		bc1t End				# false: continue

########################################################

################### REVERSE BITS #######################
		
		cvt.w.s $f12, $f12
		mfc1 $s0, $f12

		li $s1, 0 	# will store the reversed bits
		
        Reverse_Loop:

                beqz $s0, End_Reverse		
                
                andi $t0, $s0, 0x00000001
                srl $s0, $s0, 1 	# move next bit into position
                
                or $s1, $s1, $t0 
                sll $s1, $s1, 1 	# leave the right-most bit open

                j Reverse_Loop

        End_Reverse:

        la $a0, result_msg
        jal print_string
        
        jal print_endl
        
        mtc1 $s1, $f12
        cvt.s.w $f12, $f12		# print reversed float	
        jal print_float
		
		jal print_endl
		
		
########################################################

		
		j Main_Loop


Exit:	
        la $a0, end_msg
        jal print_string
	 
	    jal print_endl
		
        li $v0, 10
		syscall


###
#  A collection of syscalls in mips-assembly
### 

#  Prints float given in $f12
#  Use "mov.s $f12, $???" to move float to reg
print_float:
    li $v0, 2
    syscall
    jr $ra

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

#  Read float from input
#  Float will be in $f0
read_float:
    li $v0, 6
    syscall
    jr $ra

#  Read string from input
#  $a0 will be buffer address and $a1 the length (including the space made for \0)
#  Remember that u can allocate space for a buffer in .data with .space (len)
read_string:
    li $v0, 8
    syscall
    jr $ra

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra