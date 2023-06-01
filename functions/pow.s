#  Returns $a0^$a1 in $v0
pow:
    addi $sp, $sp, -4    # make space in stack
    sw $t0, 0($sp)
    move $v0, $a0
	move $t0, $a1
    bne $v0, $zero, next
    li $v0, 0            # 0^a
    j powexit
    next:
    bne $t0, $zero, powloop
    li $v0, 1            # a^0
    j powexit
    powloop:
    addi $t0, $t0, -1
    beq $t0, $zero, powexit
    mult $v0, $a0
    mflo $v0
    j powloop
    powexit:
    lw $t0, 0($sp)
    addi $sp, $sp, 4
    jr $ra