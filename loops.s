#  for (int i = smth1 ; i < smth2 ; ++i) 
specificforexample:
    addi $sp, $sp, -8    # make space in stack
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    li $t0, 1            # change 1 to your initilized value (smth1)
    li $t1, 2            # change 2 to your initilized value (smth2)
    specificforexampleloop:
    # Condition
    beq $t0, $t1, specificforexampleexit

    ######################
    # Main loop body
    ######################

    # Iteration end
    addi $t0, $t0, 1
    j specificforexampleloop
    specificforexampleexit:
    lw $t0, 0($sp)
    lw $t1, 4($sp)
    addi $sp, $sp, 8
    # return
    # jr $ra 
    # j exit

#  While loop
whileloopexample:
    # Condition
    # beq $s0, $zero, whileloopexampleexit
    ######################
    # Main loop body
    ######################
    j whileloopexample
    whileloopexampleexit:
    # do stuff and return
    # jr $ra 
    # j exit

#  For loop
forexample:
    # Initialization
    # do stuff
    forexampleloop:
    # Condition
    # beq $s0, $zero, forexampleexit
    ######################
    # Main loop body
    ######################
    # do stuff before next iteration
    j forexampleloop
    forexampleexit:
    # do stuff and return
    # jr $ra 
    # j exit

#  Do while loop
dowhileexampleloop:
    ######################
    # Main loop body
    ######################
    # Condition
    # beq $s0, $zero, dowhileexampleloopexit
    j dowhileexampleloop
    dowhileexampleloopexit:
    # do stuff and return
    # jr $ra 
    # j exit

