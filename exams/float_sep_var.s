# exam problem where u have to print the mantissa and the exponent of a float in binary
# made using utilities from this tool-pack
# seperates components of float in IEEE-754


.data
ReadMsg: .asciiz "Give real number:\n"
ResMsg: .asciiz "\n\nNumber in scientific notation is:\n"
NumMsg: .asciiz " x 2^"
OneMsg: .asciiz "1."

.text
.globl main

main:
   la $a0, ReadMsg
   jal print_string

   jal read_float

   mov.s $f12, $f0
   jal print_float

   li.s $f1, 0.0

   c.eq.s $f1, $f0
   bc1t exit

   la $a0, ResMsg
   jal print_string

   mfc1 $t0, $f0

   srl $t1, $t0, 31
   beq $t1, $zero, no_sign

   li $a0,'-'
   jal print_char
no_sign:

   la $a0, OneMsg
   jal print_string

   sll $t1, $t0, 9

next_digit:
   srl $a0, $t1, 31
   jal print_int
   sll $t1, $t1, 1
   bne $t1, $zero, next_digit

   la $a0, NumMsg
   jal print_string

   sra $t1, $t0, 23
   andi $t1, $t1, 0xFF
   addi $a0, $t1, -127
   jal print_int

   li $a0,'\n'
   jal print_char

   j main
#########################################
exit:
    li $v0, 10
    syscall

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

#  Prints float given in $f12
#  Use "mov.s $f12, $???" to move float to reg
print_float:
    li $v0, 2
    syscall
    jr $ra

#  Read float from input
#  Float will be in $f0
read_float:
    li $v0, 6
    syscall
    jr $ra

#  Prints char given in $a0
print_char:
    li $v0, 11
    syscall
    jr $ra

#  Prints integer given in $a0
print_int:
    li $v0, 1
    syscall
    jr $ra