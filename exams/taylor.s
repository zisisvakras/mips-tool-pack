#possible exam problem
#calculates taylor series: x^n/n! 
#of the function: e^x 

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

.text
.globl main

#f0,12 x
#f1 end 
#f2 counter
#f3 result
#f4 x power
#f5 fac
#f6 temp
#f7 one-1 constant

main:
    la $a0, ReadFloating
    jal print_string
    jal print_endl
    jal read_float
    mov.s $f12, $f0
    c.eq.s $f12, $f13
    jal print_float
    jal print_endl

    #init one-1 constant
    li $s0, 1
    mtc1 $s0, $f7
    cvt.s.w $f7, $f7
    bc1t done

    #init end
    li $s0, 8
    mtc1 $s0, $f1
    cvt.s.w $f1, $f1


    #init fac and x power
    mov.s $f5, $f7
    mov.s $f4, $f7
loop:
    add.s $f2, $f2, $f7
    mul.s $f5, $f5, $f2
    mul.s $f4, $f4, $f0
    div.s $f6, $f4, $f5
    add.s $f3, $f3, $f6
    c.eq.s $f1, $f2
    bc1f loop
done:
    add.s $f12, $f3, $f7 
    jal print_float
    j exit
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