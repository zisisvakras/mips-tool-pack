###################################################
#                                                 #
#             Lower Case to Upper Case            #
#              for a 20-letter string             #
#                                                 #
###################################################

.text
.globl __start

__start: 
    la $a0, buffer          # read string
    li $v0, 8
    syscall

    addi $t5, $zero, 0      # initialize $t5 with 0 
    addi $t3, $zero, 20     # initialize $t3 with 20

    loop:
        la $t1, buffer      # load every time the address of label "buffer" in $t1
        add $t1, $t1, $t5   # increase $t1 by the value of $t5, so we can load each time the next
                            # letter, that is stored in the address buffer + $t5
        lb $t0, 0($t1)      # load every time the byte in the address that is stored in $t1, in $t0

        addi $t5, $t5, 1    # increase $t5 by 1
         

        addi $t0, $t0, -32  # make Lower Case to Upper Case
        sb $t0, 0($t1)      # store the new character in the address of the byte we previousely loaded

        blt $t5, $t3, loop  # if $t5 < 20 we continuew the loop

    print_string:
        la $a0, buffer      # print string
        li $v0, 4
        syscall

    exit:
        li $v0, 10
        syscall

.data
buffer: .space 21
