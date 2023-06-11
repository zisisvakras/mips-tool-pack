.data
    power: .asciiz "*10^"


.text
.globl main

main:
    la $a0, Buffer
    jal read_string
    jal strlen
    addi $t0, $v0, -1  
    jal print_string
    move $s0, $a0
    li $a0, '='
    jal print_char
    li $t1, 1
loop:
    lb $a0, 0($s0)
    addi $s0, $s0, 1
    jal print_char
    la $a0, power
    jal print_string
    move $a0, $t0
    jal print_int
    li $a0, '+'
    jal print_char
    addi $t0, $t0, -1
    bne $t0, $t1, loop

    lb $a0, 0($s0)
    addi $s0, $s0, 1
    jal print_char
    la $a0, power
    jal print_string
    addi $a0, $t0, -1
    jal print_int

    j exit


###
#  A collection of syscalls in mips-assembly
### 

#  Calculate the length of string in $a0
#  Returns length in $v0 (without \0)
strlen:
    addi $sp, $sp, -4    # make space in stack
    sw $t0, 0($sp)       # keep t0 in stack
    addi $v0, $a0, -1
strlenloop:
    lb $t0, 1($v0)
    addi $v0, $v0, 1
    bne $t0, $zero, strlenloop
    sub $v0, $v0, $a0    # prepare return value
    lw $t0, 0($sp)       # restore t0 from stack
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
    Endl: .asciiz "\n"
    Buffer: .space 20
    ErrorMessages: .asciiz "The character is not a number\n"
    EqualMessage: .asciiz "The strings are equal"
    NotEqualMessage: .asciiz "The strings are not equal"