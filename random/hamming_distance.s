.text
.globl main 

main:

    li $a0, 0x000F0000
    li $a1, 0xFFFFFFFF

    jal h_distance

    move $a0, $v0
    li $v0, 1
    syscall


    li $v0, 10
    syscall



# $a0, $a1
# result in $v0
h_distance:

    xor $t0, $a0, $a1
    # Now we should count the number of 1s in $t0

    loop_h_dist:

        andi $t1, $t0, 1
        add $v0, $v0, $t1

    srl $t0, $t0, 1
    bne $t0, $zero, loop_h_dist 

    jr $ra
