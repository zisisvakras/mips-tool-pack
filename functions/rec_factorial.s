.text
.globl main

main: # brief usage example

    li $a0, 5
    jal rec_fact

    move $a0, $v0
    
    # print int
    li $v0, 1
    syscall

    # exit 
    li $v0, 10
    syscall

# int fact (int n)
# {
#    if (n < 1) return 1;
#    else return n * fact(n - 1);
# }

#  Returns $a0! in $v0
rec_fact: # Code taken from lectures with minor modifications
    addi $sp, $sp, -8   # adsjust stack for 2 items
    sw $ra, 4($sp)      # save return address 
    sw $a0, 0($sp)      # save argument

    bge $a0, 1, L1      # test if (n >= 1) go to L1
    # if (n < 1) --->
    addi $v0, $zero, 1  # if so result is 1 
    addi $sp, $sp, 8    # pop 2 items from stack
    jr $ra              # and return
L1:                     # else
    addi $a0, $a0, -1   # decrement n
    jal rec_fact        # recursive call  

    lw $a0, 0($sp)      # restoring oroginal n
    lw $ra, 4($sp)      # restoring return adress
    addi $sp, $sp, 8    # pop 2 items from stack
    mul $v0, $a0, $v0   # multiply to get result
    jr $ra              # and return