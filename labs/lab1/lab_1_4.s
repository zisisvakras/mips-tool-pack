# Read String and Decrease its Length to 5

.data
buffer: .space 21   # pilot said to read up to 20 chars (extra space for null byte)
newl: .asciiz "\n"  # asciiz adds a NULL byte after the string

.text

.globl main

main:

li $v0, 8       # read string
li $a1, 21      # specify length to read
la $a0, buffer  # store read string in buffer
syscall		

la $a0, buffer  # not needed, a0 already holds the address of buffer
li $v0, 4       # print string
syscall

la $a0, newl    # print new line
li $v0, 4       # print string, not necessary, v0 is already 4
syscall

sb $zero, buffer + 5    # add null byte after 5th char
			            # to only print the first 5 characthers
			            # (MIPS prints whats in memory until it reaches
			            # a NULL byte (\0) so by placing one we tell it stop)

la $a0, buffer  # print buffer	
li $v0, 4       # didnt actually need this, v0 is already 4
syscall         # print string

la $a0, newl	# print new line
li $v0, 4	    # print string
syscall

li $v0, 10	# exit
syscall
