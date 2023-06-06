#        Recursive Procedure with Stack  

.text
.globl __start
__start:
    # start of main program
    la $a0,prompt
    li $v0,4
    syscall # display "Enter integer number :"

    li $v0,5
    syscall # read integer

    addi $sp, $sp, -4   # store the value of $a0 in the stack so it isnt lost
    sw $a0, 0($sp)

    move $a0, $v0       # move the integer that was given from the $v0 to $a0
    j proc              # jump to procedure
    next:

    lw $a0, 0($sp)
    addi $sp, $sp, 4

    move $t0,$v0        # move the result of the procedure from $v0 to $t0

    la $a0,endl
    li $v0,4
    syscall             # display end of line
    move $a0,$t0

    li $v0,10
    syscall             # exit
# end of main program
# start of procedure
#
    proc:
        beq $a0, $zero, next    # if the value of the $a0, which represent
                                # the given number of the procedure is equual to 0 the procedure stops
        li $v0, 1
        syscall

        addi $sp, $sp, -4       # store the value of $a0 in stack
        sw $a0, 0($sp)

        la $a0,endl
        li $v0,4
        syscall                 # display end of line

        lw $a0, 0($sp)          # retrieve the old value of $a0 from stack
        addi $sp, $sp, 4

        addi $a0, $a0, -1       # decrease the value of $a0 by 1
        move $v0, $a0           # move the new decreased number to $v0, which holds the result of a procedure   
        j proc                  # jump to precdure, so it is recursive
# end of procedure

.data
prompt: .asciiz "Enter integer number :"
endl: .asciiz "\n"
