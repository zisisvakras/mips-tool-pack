# NOTE: This implementation is more complex because I wanted to print 
# the result in descending order of the powers of 10 without using an array
# The prompt is not very clear about this, but in the example the order is descending
# The implementation with the powers of 10 in ascending order is much simpler

.text
.globl main

main:
    loop_main:
        la $a0, ReadInt
        jal print_string

        jal read_int
        move $s0, $v0

        move $a0, $s0
        jal print_int

        beqz $s0, break_loop 

        la $a0, equal
        jal print_string
        
        li $s3, 9 # i = 9
        li $t4, 10 # const 10
        move $t7, $s0 # t7 = s0
        li $t8, 1000000000 # t8 = 10^9
        li $t9, 0 # flag_plus = 0
        loop_in:

          
            div $s0, $t8 # s0 = s0 / 10 
            mfhi $s0 # s0 = s0 % 10^..
            mflo $s1 # s1 = s0 / 10^..
            
            add $t6, $s1, $t9
            beqz $t6, skip_print
            li $t9, 1
            addi $t0, $s1, 48 # s1 = s1 + '0'

            move $a0, $t0
            jal print_char

            la $a0, form
            jal print_string

            addi $t0, $s3, 48 # s3 = s3 + '0'
            move $a0, $t0
            jal print_char

            beq $s3, 0, skip_print
            la $a0, plus
            jal print_string

            skip_print:
            addi $s3, $s3, -1 # --i
            div $t8, $t4 # t8 = t8 / 10
            mflo $t8 # t8 = t8 / 10

        bnez $t8, loop_in
        la $a0, endl
        jal print_string
        move $s0, $t7 # s0 = t7


    j loop_main 
    break_loop:

    la $a0, endofprogram
    jal print_string

    j exit

#  Prints integer given in $a0
print_int:
    li $v0, 1
    syscall
    jr $ra

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

#  Read integer from input
#  Integer will be in $v0
read_int:
    li $v0, 5
    syscall
    jr $ra


# Exits the program
exit:
    li $v0, 10
    syscall

#  Prints char given in $a0
print_char:
    li $v0, 11
    syscall
    jr $ra

print_endl:
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    li $a0, 10
    li $v0, 11
    syscall
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    jr $ra
#  MESSAGES
.data
    ReadInt: .asciiz "Insert an integer :"
    form: .asciiz "*10^"
    plus: .asciiz " + "
    space: .asciiz " "
    endl: .asciiz "\n"
    equal: .asciiz " = "
    endofprogram: .asciiz " ... \nEnd of program\n"
