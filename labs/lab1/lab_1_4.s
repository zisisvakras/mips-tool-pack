###################################################
#                                                 #
#    Read String and Decrease its Length to 5     #
#                                                 #
###################################################

.text
.globl __start

__start: 

    li $v0, 8           # read string
    la $a0, buffer      # we load the address of label "buffer" in $a0, 
    syscall             # so the string that is read is stored there

    la $a0, buffer      # we load the address of label "buffer" in $a0, so now the string can be printed    
    li $v0, 4           # print string
    syscall 

    la $a0, endl        # we load the address of "endl" label in $a0, so the new line character "\n" is printed     
    li $v0, 4           # print string "\n"
    syscall 

    addi $t0, $zero, 0  # we store the value 0 in $t0

    sb $t0, buffer + 5  # store byte qual to 0 in address of label "buffer" + 5
                        # so the string is changed and the "\n" character is in 6th place
                        # tricking MIPS its length decreased

    la $a0, buffer      # we load the address of "buffer" in $a0, so the new string is printed
    li $v0, 4           # print string        
    syscall 

    la $a0, endl        # we load the address of "endl" in $a0, so the new line character "\n" is printed   
    li $v0, 4           # print string "\n"
    syscall 

    li $v0, 10          # exit
    syscall

.data

buffer: .space 21
endl: .asciiz "\n"
