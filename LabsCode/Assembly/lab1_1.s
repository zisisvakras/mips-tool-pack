###################################################
# 						  #
# lab1_1.s 					  #
# Pseudoinstruction examples - System calls       #
# t0 - holds each byte from string in turn 	  #
# t1 - contains count of characters 		  #
# t2 - points to the string 			  #
# 						  #
###################################################
###################################################
# 	       					  #
# text segment 					  #
# 	       					  #
###################################################
 .text
 .globl __start
__start:
        la $t2,str # t2 points to the string
        li $t1,0 # t1 holds the count
    nextCh: 
        lb $t0,($t2) # get a byte from string
        beqz $t0,strEnd # zero means end of string
        add $t1,$t1,1 # increment count
        add $t2,1 # move pointer one character
        j nextCh # go round the loop again
    strEnd: 
        la $a0,ans # system call to print
        li $v0,4 # out a message
        syscall
    
        move $a0,$t1 # system call to print
        li $v0,1 # out the length worked out
        syscall
    
        la $a0,endl # system call to print
        li $v0,4 # out a newline
        syscall
    
        li $v0,10
        syscall # au revoir...
#################################################
# 						#
# data segment 					#
# 						#
#################################################
.data
str: .asciiz "hello world"
ans: .asciiz "Length is "
endl: .asciiz "\n"
#################################################
# 						#
# End of File 					#
# 						#
#################################################
