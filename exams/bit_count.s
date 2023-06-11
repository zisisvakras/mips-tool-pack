# exam problem where u count the number of set and unset bits
# made using streq from this tool-pack

.data
    buffer: .space 5
    zero_str: .asciiz "0000"
    set_count: .asciiz "Set bits: "
    unset_count: .asciiz "Unset bits: "

.text
.globl main

main:
    la $a0, buffer
    li $a1, 5
    jal read_string
    lw  $s0, 0($a0)
    jal print_string
    jal print_endl
    li $t0, 1
    move $s1, $zero
#s0 will hold the word, s1 will hold the count of 1, s2 of the $zero
loop:
    andi $t0, $s0, 1
    add $s1, $t0, $s1
    srl $s0, $s0, 1
    bne $s0, $zero, loop

    li $s2, 32
    sub $s2, $s2, $s1
    la $a0, set_count
    jal print_string
    move $a0, $s1
    jal print_int
    jal print_endl
    la $a0, unset_count
    jal print_string
    move $a0, $s2
    jal print_int
    jal print_endl
    la $a0, buffer
    la $a1, zero_str
    jal streq
    beq $v0, $zero, main
    j exit


###
#  A collection of syscalls in mips-assembly
### 

#  Compares strings in $a0 and $a1
#  Returns 1 if equal or 0 if not in $v0
streq:
    addi $sp, $sp, -16   # make space in stack
    sw $t0, 12($sp)      # keep t0, t1, t2, t3 in stack
    sw $t1, 8($sp)
    sw $t2, 4($sp)
    sw $t3, 0($sp)
    add $t2, $a0, $zero # load byte 0 from the string in t2 (it will be our counter)
    add $t3, $a1, $zero # respectively for t3
    streqloop:
    lb $t0, 0($t2)
    lb $t1, 0($t3)
    bne $t0, $t1, streqexitno
    beq $t0, $zero, streqexityes
    addi $t2, $t2, 1
    addi $t3, $t3, 1
    j streqloop

    streqexitno:
    li $v0, 0
    j streqexit

    streqexityes:
    li $v0, 1
    j streqexit

    streqexit:
    lw $t0, 12($sp)      # restore t0, t1, t2, t3 from stack
    lw $t1, 8($sp)
    lw $t2, 4($sp)
    lw $t3, 0($sp)
    addi $sp, $sp, 16
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

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
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
    ProgramEnd: .asciiz "\nEND OF PROGRAM\n"
    ErrorMessages: .asciiz "The character is not a number\n"
    EqualMessage: .asciiz "The strings are equal"
    NotEqualMessage: .asciiz "The strings are not equal"
    wronginput: .asciiz "Wrong Input!"