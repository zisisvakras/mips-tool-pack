# NOTE: This excercise is out of the scope of the course, but it is a good way to practice
# I calculated for x = 1 => e^x = e^1 = e

#  MESSAGES
.data
    ReadInt: .asciiz "Insert an integer :"
    ReadFloating: .asciiz "Insert a float :"
    ReadDoubleNum: .asciiz "Insert a double :"
    ReadStringCharacters: .asciiz "Insert a string :"
    Result: .asciiz "The result is :"
    Final: .asciiz "The final <type> is: "
    Difference: .asciiz "The difference is :"
    Quotient: .asciiz "The Quotient is :"
    Remainder: .asciiz "The Remainder is :"
    Factorial: .asciiz "The factorial of the number "
    General_Start: .asciiz "The "
    Power: .asciiz " th power of the number "
    General_End: .asciiz " is: "
    StringMessage: .asciiz "The final string is: "
    Converted1: .asciiz "The converted float is: "
    Converted2: .asciiz " from: "
    ProgramEnd: .asciiz "\nEND OF PROGRAM\n"
    ErrorMessages: .asciiz "The character is not a number\n"
    EqualMessage: .asciiz "The strings are equal"
    NotEqualMessage: .asciiz "The strings are not equal"
    wronginput: .asciiz "Wrong Input!"
    endl: .asciiz "\n"

.text
.globl main

main:

    # int k; ($s0)
    # read k
    jal read_int
    move $s0, $v0

    # print k
    move $a0, $s0
    jal print_int

    beq $s0, $zero, exit # if k==0 exit

    # for i($s1) in range [0, k-1] do
    addi $s1, $zero, 0
    for_every_k_loop:

        # int b ($s2) = fact(i)
        move $a0, $s1 # copy i to $a0
        jal factorial
        move $s2, $v0 # copy i! to $s2

        # single precision float: cur ($f0) = 1 / b (k!) 
        mtc1 $s2, $f2
        cvt.s.w $f2, $f2

        li.s $f4, 1.0
        div.s $f0, $f4, $f2
        # now $f0 has the current term

        add.s $f12, $f12, $f0

        mov.s $f8, $f12
        mov.s $f12, $f0
        # jal print_float
        mov.s $f12, $f8

    addi $s1, $s1, 1
    bne $s1, $s0, for_every_k_loop # i!=k

    # endl
    jal print_endl
    # print_f $f12
    jal print_float

    j exit
   

###
#  A collection of syscalls in mips-assembly
### 

#  Returns $a0^$a1 in $v0

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

#  Prints integer given in $a0
print_int:
    li $v0, 1
    syscall
    jr $ra

#  Prints float given in $f12
#  Use "mov.s $f12, $???" to move float to reg
print_float:
    li $v0, 2
    syscall
    jr $ra

#  Prints double given in $f12
#  Use "mov.d $f12, $???" to move double to reg
#  Remember that double uses 2 registers (pair of even-odd)
print_double:
    li $v0, 3
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

#  Read float from input
#  Float will be in $f0
read_float:
    li $v0, 6
    syscall
    jr $ra

#  Read double from input
#  Double will be in $f0 (and $f1)
#  Remember that double uses 2 registers (pair of even-odd)
read_double:
    li $v0, 7
    syscall
    jr $ra

#  Read string from input
#  $a0 will be buffer address and $a1 the length (including the space made for \0)
#  Remember that u can allocate space for a buffer in .data with .space (len)
read_string:
    li $v0, 8
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

#  Read char from input
#  Char will be in $v0
read_char:
    li $v0, 12
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