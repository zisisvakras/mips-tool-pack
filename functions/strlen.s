#  Calculate the length of string in $a0
#  Returns length in $v0 (without \0)
strlen:
    addi $sp, $sp, -8    # make space in stack
    sw $t0, 4($sp)       # keep t0, t1 in stack
    sw $t1, 0($sp)
    li $t1, 0            # load 0 in t1 (it will be our counter)
    strlenloop:
    lb $t0, $t1($a0)
    beq $t0, $zero, strlenexit
    addi $t1, $t1, 1
    j strlenloop

    strlenexit:
    move $v0, $t1
    lw $t0, 4($sp)       # restore t0, t1, t2 from stack
    lw $t1, 0($sp)
    addi $sp, $sp, 8
    jr $ra