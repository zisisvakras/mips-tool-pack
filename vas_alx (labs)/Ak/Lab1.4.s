.text
.globl __start
__start:
li $v0, 8
la $a0, str
addi $a1,21
li $v0, 4       
la $a0, str           
syscall      	
li $v0,10
syscall

#################################################
# #
# data segment #
# #
#################################################

.data
str: .asciiz "qwertyuiopasdfghjklz"

#################################################
# #
# End of File #
# #
#################################################
