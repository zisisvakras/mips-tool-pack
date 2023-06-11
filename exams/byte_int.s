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
    max:    .asciiz "Max is : " 
    min:    .asciiz "Min is : " 
    sum:    .asciiz "Sum is : " 
    mean:    .asciiz "Mean is : " 

.text
.globl main

main:
    jal read_int
    move $a0, $v0
    jal print_int
    move $t0, $a0
    la $a0, endl
    jal print_string

    li $t1, 0xFF # mask

    #byte 1
    and $a0, $t0, $t1
    sll $a0, $a0, 24
    sra $a0, $a0, 24

    #byte 2
    sll $t1, $t1, 8
    and $a1, $t0, $t1
    sll $a1, $a1, 16
    sra $a1, $a1, 24

    #byte 3
    sll $t1, $t1, 8
    and $a2, $t0, $t1
    sll $a2, $a2, 8
    sra $a2, $a2, 24

    #byte 3
    sll $t1, $t1, 8
    and $a3, $t0, $t1
    sra $a3, $a3, 24

    #t3 will hold the sum
    add $t3, $a0, $a1
    add $t3, $t3, $a2
    add $t3, $t3, $a3

    jal MinMax

    move $t0,$v1
    move $t1,$v0
    la $a0,max     
    li $v0,4 
    syscall      # display "Max is :" 
    move $a0,$t0     
    li $v0,1 
    syscall      # display max 
    la $a0,endl    
    li $v0,4 
    syscall      # display end of line 
    la $a0,min     
    li $v0,4 
    syscall      # display "Min is :" 
    move $a0,$t1     
    li $v0,1 
    syscall      # display min 
    la $a0,endl    
    li $v0,4 
    syscall      # display end of line   

   
    la $a0, sum
    jal print_string
    move $a0, $t3
    jal print_int
    la $a0, endl
    jal print_string
    
    li $t4, 4
    div $t3, $t4
    la $a0, mean
    jal print_string
    mflo $a0
    jal print_int
    la $a0, endl
    jal print_string

    j exit


###
#  A collection of syscalls in mips-assembly
### 

MinMax: 
    addi $sp, $sp , -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    blt $a0, $a1 , A1gret
    move $v1, $a0
    move $v0, $a1
    j done1
A1gret: 
    move $v1, $a1
    move $v0, $a0
done1:

    blt $a2, $a3 , A3gret
    move $s0, $a3
    move $s1, $a2
    j done2
A3gret: 
    move $s0, $a2
    move $s1, $a3
done2:


    blt $s0, $v0 , s0less
    j done3
s0less: 
    move $v0, $s0
done3:

    bgt $s1, $v1 , v1gret
    j done4
v1gret: 
    move $v1, $s1
done4:

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    addi $sp, $sp , 8
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