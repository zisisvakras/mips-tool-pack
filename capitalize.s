#  turns lower-case to upper-case and vice versa
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
    buffer: .asciiz "WasddgiioGGIA"

.text
.globl main

#s0 initial string
#t0 parser, t1 char

main:
    la $s0, buffer
    move $t0, $s0
    li $s1, 'a'
    li $s2, 'z'
    li $s3, 'A'
    li $s4, 'Z'
    sub $s5, $s1, $s3
loop:
    lb $t1, 0($t0)
    beqz $t1, done
    sle $t2, $t1, $s2
    sge $t3, $t1, $s1
    beq $t2, $t3, lower
    sle $t2, $t1, $s4
    sge $t3, $t1, $s3
    beq $t2, $t3, upper
store:
    sb $t1, 0($t0)
    addi $t0, $t0, 1
    j loop
done:
    move $a0, $s0
    jal print_string    
    j exit


lower:
    sub $t1, $t1, $s5
    j store
upper:
    add $t1, $t1, $s5
    j store

###
#  A collection of syscalls in mips-assembly
### 

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