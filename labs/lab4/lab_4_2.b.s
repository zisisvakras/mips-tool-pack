#        Recursive Procedure with Stack  

.text
.globl __start
__start:
    # start of main program
    la $a0, prompt
    li $v0, 4
    syscall # display "Enter integer number: "

    li $v0, 5
    syscall # read integer

    move $a0, $v0       # move the integer that was given from the $v0 to $a0
    jal proc        # jump to procedure

    move $t0, $v0        # move the result of the procedure from $v0 to $t0

    la $a0, endl
    li $v0, 4
    syscall             # display end of line
    move $a0, $t0

    li $v0, 10
    syscall             # exit

# end of main program
# start of procedure

proc: # Arguement: $a0 - integer number
        addi $sp, $sp, -8       # store the value of $ra in stack
        sw $t0, 0($sp)
        sw $ra, 4($sp)

        li $v0, 1               # print $a0
        syscall

        sle $t0, $a0, $zero     # if $a0 <= 0, stop the procedure
                                # note: < is for case of $a0 being negative
        beq $t0, $zero, proc_rec    # if $a0 > 0, jump to proc_rec

        # Base case: $a0 <= 0
        addi $sp, $sp, 8
        jr $ra                  # return to the caller

proc_rec:
        move $t0, $a0           # move the value of $a0 to $t0
        la $a0, endl
        li $v0, 4
        syscall                 # display end of line
        move $a0, $t0

        addi $a0, $a0, -1       # decrease the value of $a0 by 1
        jal proc                # jump to procedure, so it is recursive

        lw $ra, 4($sp)          # retrieve the old value of $ra from stack
        lw $t0, 0($sp)          # retrieve the old value of $t0 from stack
        addi $sp, $sp, 8

        jr $ra                  # return to the caller

.data
prompt: .asciiz "Enter integer number:\n"
endl: .asciiz "\n"
