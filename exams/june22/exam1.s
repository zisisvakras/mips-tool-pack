#  MESSAGES
.data
    ReadInt: .asciiz "Insert an integer : "
    ReadStringCharacters: .asciiz "Insert a string : "
    Result: .asciiz "The ascii product is : "
    ProgramEnd: .asciiz "\nEND OF PROGRAM\n"
    buffer:  .space 11
    onefloat: .float 1.0

.text
.globl main

main:
    la $a0, ReadInt
    jal print_string
    jal read_int
    move $s0, $v0
    move $a0, $v0
    jal print_int
    jal print_endl
    # beq $s0, $zero, exit # This should have been included in exercise
    la $a0, ReadStringCharacters
    jal print_string
    la $a0, buffer
    li $a1, 11
    jal read_string
    jal print_string
    jal print_endl

    la $s0, buffer # holds address for chars
    l.s $f3, onefloat # $f3 will hold ascii product
    loop:
    lbu $s1, 0($s0) # holds char
    beq $s1, $zero, endloop
    mtc1 $s1, $f0
    cvt.s.w $f0, $f0
    mul.s $f3, $f3, $f0
    addi $s0, $s0, 1
    j loop
    endloop:
    mov.s $f12, $f3
    la $a0, Result
    jal print_string
    jal print_float
    jal print_endl
    jal print_endl
    j main


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

#  Read string from input
#  $a0 will be buffer address and $a1 the length (including the space made for \0)
#  Remember that u can allocate space for a buffer in .data with .space (len)
read_string:
    li $v0, 8
    syscall
    jr $ra

# Exits the program
exit:
    la $a0, ProgramEnd
    jal print_string
    li $v0, 10
    syscall

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra