# checks if num in $a0 is prime
# returns true/false in $v0
prime_check:
    addi $sp, $sp, -8
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    li $t0, 2
    ble $a0, $t0, prime_check_true
prime_check_loop:
    div $a0, $t0
    mfhi $t1
    beqz $t1, prime_check_false
    addi $t0, $t0, 1
    bgt $a0, $t0, prime_check_loop  


prime_check_true:
    li $v0, 1
    j prime_check_exit
prime_check_false:
    li $v0, 0

prime_check_exit:
    lw $t0, 0($sp)
    lw $t1, 4($sp)
    addi $sp, $sp, 12
    jr $ra