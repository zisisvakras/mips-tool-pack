#  Compares strings in $a0 and $a1
#  Returns 1 if equal or 0 if not in $v0
streq:
    addi $sp, $sp, -12   # make space in stack
    sw $t0, 8($sp)       # keep t0, t1, t2 in stack
    sw $t1, 4($sp)
    sw $t2, 0($sp)
    li $t2, 0            # load 0 in t2 (it will be our counter)
    streqloop:
    lb $t0, $t2($a0)
    lb $t1, $t2($a1)
    bne $t0, $t1, streqexitno
    beq $t0, $zero, streqexityes
    addi $t2, $t2, 1
    j streqloop

    streqexitno:
    li $v0, 0
    j streqexit

    streqexityes:
    li $v0, 1
    j streqexit

    streqexit:
    lw $t0, 8($sp)       # restore t0, t1, t2 from stack
    lw $t1, 4($sp)
    lw $t2, 0($sp)
    addi $sp, $sp, 12
    jr $ra

#  Compares strings in $a0 and $a1
#  Returns 1 if not equal or 0 if they are, in $v0
strneq:
    addi $sp, $sp, -12   # make space in stack
    sw $t0, 8($sp)       # keep t0, t1, t2 in stack
    sw $t1, 4($sp)
    sw $t2, 0($sp)
    li $t2, 0            # load 0 in t2 (it will be our counter)
    strneqloop:
    lb $t0, $t2($a0)
    lb $t1, $t2($a1)
    bne $t0, $t1, strneqexitno
    beq $t0, $zero, strneqexityes
    addi $t2, $t2, 1
    j strneqloop

    strneqexitno:
    li $v0, 1
    j strneqexit

    strneqexityes:
    li $v0, 0
    j strneqexit

    strneqexit:
    lw $t0, 8($sp)       # restore t0, t1, t2 from stack
    lw $t1, 4($sp)
    lw $t2, 0($sp)
    addi $sp, $sp, 12
    jr $ra