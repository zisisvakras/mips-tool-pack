#  Returns $a0! in $v0
factorial:
    addi $sp, $sp, -4    # make space in stack
    sw $t0, 0($sp)
    move $v0, $a0
	move $t0, $a0
    bne $v0, $zero, factorialloop
    li $v0, 1            # case of 0!
    j factorialexit
    factorialloop:
    addi $t0, $t0, -1
    beq $t0, $zero, factorialexit
    mult $v0, $t0
    mflo $v0
    j factorialloop
    factorialexit:
    lw $t0, 0($sp)
    addi $sp, $sp, 4
    jr $ra