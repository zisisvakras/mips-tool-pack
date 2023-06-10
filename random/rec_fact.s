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
    N: .word 3


.text
.globl main

main:

    la $t0, N
    lw $a0, 0($t0)
    
    jal rec_fact

    move $a0, $v0
    jal print_int
    jal print_endl

    j exit


###
#  A collection of syscalls in mips-assembly
### 

# int fact(int n){
#    if(n < 1) return 1;
#    return n*fact(n-1);
# }


rec_fact: # int n ($a0)
    blt $a0, 2, return_1
    # else
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    addi $a0, $a0, -1
    jal rec_fact
    addi $a0, $a0, 1

    mul $v0, $v0, $a0


    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

    return_1:
        li $v0, 1
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
