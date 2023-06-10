.text
.globl main

main:
    la $a0, msg2 # "Give N"
    jal print_string 

    jal read_int # read N
    move $a0, $v0
    move $s0, $v0 # int n($s0) = N
    jal print_int # print N 

    la $a0, msg3 # "give elements of the array"
    jal print_string

    la $a0, empty_array
    move $a1, $s0 # n = N
    jal read_arr

    la $a0, msg4 # "array is"
    jal print_string
    la $a0, empty_array # now it is not empty
    move $a1, $s0 # $a1 = N
    jal print_arr 

    la $a0, msg5
    jal print_string # "another array is"
    la $a0, myArray
    li $a1, 10

    jal print_arr

j exit


## Functions

exit:
    li $v0, 10
    syscall

# $a0 has the adress of the array
# $a1 has the N (length of the array)
# $tx and $v0 regesters are NOT maintainted 
print_arr: # print_arr(int *arr, int n)
    addi $sp, $sp, -4
    sw $s0, 0($sp)

    # int i = 0 ($s0)
    li $s0, 0 
    for_print_arr:

        move $t2, $a0

        move $a0, $s0
        li $v0, 1
        syscall
        la $a0, msg1
        li $v0, 4
        syscall

        move $a0, $t2

        sll $t0, $s0, 2 # $t0 = 4 * $s0 (i)
        add $t0, $t0, $a0 # $t0 = $t0 + $a0 (address of array)
        # so now $t0 has the adress of a[i]

        lw $t1, 0($t0)
        move $t2, $a0 # save $a0 to a tmp variable
        move $a0, $t1

        # print_int
        li $v0, 1
        syscall
        # print endl
        li $v0, 11
        li $a0, 10
        syscall

        move $a0, $t2 # restore $a0


    addi $s0, $s0, 1 # ++i
    blt $s0, $a1, for_print_arr # if (i < n) proceed to one more iteration

    lw $s0, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# a0 has the address of the array
# a1 has the N (length of the array)
# $tx and $v0 registers are NOT maintainted
read_arr: # read_arr(int *arr, int n)
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    # int i = 0 ($s0)
    li $s0, 0 
    for_read_arr:

        # read integer (saved in $v0)
        li $v0, 5
        syscall

        # int input; ($s1)
        # read_int(intput) 
        move $s1, $v0

        # copy $a0 (address of array)
        move $t2, $a0

        # print integer so that we can see what we typed
        li $v0, 1
        move $a0, $s1
        syscall

        move $a0, $t2 # restore $a0

        sll $t0, $s0, 2 # $t0 = 4 * $s0 (i)
        add $t0, $t0, $a0 # $t0 = $t0 + $a0 (address of array)
        # so now $t0 has the adress of a[i]

        sw $s1, 0($t0)

        # print endl
        li $v0, 11
        li $a0, 10
        syscall

        move $a0, $t2 # restore $a0

    addi $s0, $s0, 1 # ++i
    blt $s0, $a1, for_read_arr # if (i < n) proceed to one more iteration

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 4
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

print_int:
    li $v0, 1
    syscall
    jr $ra


.data
empty_array: .space 400 # 400 bytes = 100 * 4 => 100 integers 
myArray: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 69

msg1: .asciiz ": "
msg2: .asciiz "Give the N: (up to 100)\n"
msg3: .asciiz "\nGive the elements of the array\n"
msg4: .asciiz "The array you gave is:\n"
msg5: .asciiz "The other array is:\n"
