# a0: str1
# a1: str2
# -> a0: str1 == str2
# overwrites: t0, t1, a0, a1
streq:
    lbu t0, 0(a0)
    lbu t1, 0(a1)
    bne t0, t1, streq1
    beqz t0, streq2
    addi a0, a0, 1
    addi a1, a1, 1
    j streq
    streq1:
    li a0, 0
    jr ra
    streq2:
    li a0, 1
    jr ra

#  Compares strings in $a0 and $a1
#  Returns 1 if not equal or 0 if they are, in $v0
strneq:
    addi $sp, $sp, -16   # make space in stack
    sw $t0, 12($sp)      # keep t0, t1, t2, t3 in stack
    sw $t1, 8($sp)
    sw $t2, 4($sp)
    sw $t3, 0($sp)
    add $t2, $a0, $zero # load byte 0 from the string in t2 (it will be our counter)
    add $t3, $a1, $zero # respectively for t3
    strneqloop:
    lb $t0, 0($t2)
    lb $t1, 0($t3)
    bne $t0, $t1, strneqexitno
    beq $t0, $zero, strneqexityes
    addi $t2, $t2, 1
    addi $t3, $t3, 1
    j strneqloop

    strneqexitno:
    li $v0, 1
    j strneqexit

    strneqexityes:
    li $v0, 0
    j strneqexit

    strneqexit:
    lw $t0, 12($sp)      # restore t0, t1, t2, t3 from stack
    lw $t1, 8($sp)
    lw $t2, 4($sp)
    lw $t3, 0($sp)
    addi $sp, $sp, 16
    jr $ra