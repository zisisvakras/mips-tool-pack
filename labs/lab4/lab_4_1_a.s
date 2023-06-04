#################################################
#                                               #
#                Stack Exercise                 #
#                                               #
#################################################

.text
.globl __start
__start:
    # start of main program
    # li $a0,-10 # Initialize variables
    # li $a1,-30 #
    # li $a2,120 #
    # li $a3,200 #

    lw $a0, a0  # Initialize values from data segment
    lw $a1, a1
    lw $a2, a2
    lw $a3, a3

    jal MinMax    # jump to the function MinMax and store to $ra, the address 
                  # of the next line of code in this procedure

    move $t0,$v0  # move the results of the MinMax function in temporary registers 
    move $t1,$v1

    la $a0,max      
    li $v0,4
    syscall       # display "Max is :"

    move $a0,$t1
    li $v0,1
    syscall       # display max

    la $a0,endl
    li $v0,4
    syscall       # display end of line

    la $a0,min
    li $v0,4
    syscall       # display "Min is :"

    move $a0,$t0
    li $v0,1
    syscall       # display min

    la $a0,endl
    li $v0,4
    syscall       # display end of line

    li $v0,10
    syscall       # exit
# end of main program
# start of procedure
#
    MinMax:
    #we store in the stack the previous values of $s0, $s1, $s2, $s3, $s7 so we dont lose them
    addi $sp, $sp, -4
    sw $s0, 0($sp)
    addi $sp, $sp, -4
    sw $s1, 0($sp)
    addi $sp, $sp, -4
    sw $s2, 0($sp)
    addi $sp, $sp, -4
    sw $s3, 0($sp)
    addi $sp, $sp, -4
    sw $s7, 0($sp)

    ori $s3, $zero, 1 #set value of s3, equal to 1 so we can compare it with other registers in beq

    # basically bubble sort
    slt $s0, $a2, $a3   # if the value of $a2 < value of $a3, $s0 will be 1
    beq $s0, $s3, swap  # if $s0 is 1 we jump to "swap" label and swap the two numbers

    next:               
    slt $s0, $a1, $a2
    beq $s0, $s3, swap2

    next2:
    slt $s0, $a0, $a1
    beq $s0, $s3, swap3

    next3:
    slt $s0, $a2, $a3
    beq $s0, $s3, swap4

    next4:
    slt $s0, $a1, $a2
    beq $s0, $s3, swap5

    next5:
    slt $s0, $a2, $a3
    beq $s0, $s3, swap6

    continue:
    # we load from the stack the previous values of $s0, $s1, $s2, $s3, $s7 so we dont lose them
    lw $s7, 0($sp)
    addi $sp, $sp, 4
    lw $s3, 0($sp)
    addi $sp, $sp, 4
    lw $s3, 0($sp)
    addi $sp, $sp, 4
    lw $s2, 0($sp) 
    addi $sp, $sp, 4
    lw $s1, 0($sp)
    addi $sp, $sp, 4
    sw $s0, 0($sp)
    
   
    move $v0, $a3   # move the results in the $v0, $v1 registers that exist for that reason
    move $v1, $a0   # min in $v0 and max in $v1
    jr $ra          # we return to the address that is stored in $ra, which is the address
                    # that was stored from the "jal MinMax" instruction

   
    swap: # swapping values of $a2 and $a3 using for temp $s2
    ori $s2, $a2, 0
    ori $a2, $a3, 0
    ori $a3, $s2, 0
    j next  # jump to next comparison

    swap2: # swapping values of $a1 and $a2 using for temp $s2
    ori $s2, $a1, 0
    ori $a1, $a2, 0
    ori $a2, $s2, 0
    j next2 # jump to next comparison

    swap3: # swapping values of $a0 and $a1 using for temp $s2
    ori $s2, $a0, 0
    ori $a0, $a1, 0
    ori $a1, $s2, 0
    j next3 # jump to next comparison

    swap4: # swapping values of $a2 and $a3 using for temp $s2
    ori $s2, $a2, 0
    ori $a2, $a3, 0
    ori $a3, $s2, 0
    j next4 # jump to next comparison

    swap5: # swapping values of a1 and a2 using for temp s2
    ori $s2, $a1, 0
    ori $a1, $a2, 0
    ori $a2, $s2, 0
    j next5 # jump to next comparison

    swap6: # swapping values of a2 and a3 using for temp s2
    ori $s2, $a2, 0
    ori $a2, $a3, 0
    ori $a3, $s2, 0
    j continue  # jump to the end of bubble sort 

# end of procedure

.data
a0: .word -2534
a1: .word 3439043
a2: .word 484355
a3: .word 243
max: .asciiz "Max is : "
min: .asciiz "Min is : "
endl: .asciiz "\n"