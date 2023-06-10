#  MESSAGES
.data
    ReadInt: .asciiz "Insert a number:"
    ReadString: .asciiz "Insert a string :"
    equal: .asciiz " = "
    msg_is: .asciiz " is: "
    is_int: .asciiz "\nFOUND-INTEGER= "
    not_int: .asciiz "\nNOT-INTEGER\n"
    bye: .asciiz "\nEnd of Program...\n"
    wronginput: .asciiz "Wrong Input!"
    endl: .asciiz "\n"

.text
.globl main

main:
    li.s $f1, 0.0
    li.s $f10, 0.00001
    loop_main:
        jal read_float
        mov.s $f12, $f0
        jal print_float

        cvt.w.s $f4, $f0
        cvt.s.w $f4, $f4

        sub.s $f8, $f0, $f4

        c.lt.s $f8, $f10
        bc1t num_is_int 
        j num_is_not_int

        num_is_int:
            la $a0, is_int
            jal print_string
            cvt.w.s $f4, $f4 
            mfc1 $a0, $f4
            jal print_int
            jal print_endl
            j continue_float

        num_is_not_int:
            la $a0, not_int
            jal print_string

        continue_float:

    c.eq.s $f0, $f1
    bc1f loop_main 

    j exit
## FUNCTIONS ## (Call with: jal function_name)


exit:                       # Exits the program 
    la $a0, bye
    jal print_string
    li $v0, 10
    syscall
#  

read_int:                   #  Read integer from input 
    li $v0, 5               #  Integer will be in $v0 
    syscall
    jr $ra

print_int:                  #  Prints integer given in $a0 
    li $v0, 1
    syscall
    jr $ra

#  

read_float:                 #  Read float from input 
    li $v0, 6               #  Float will be in $f0 
    syscall
    jr $ra

print_float:                #  Prints float given in $f12                
    li $v0, 2               #  Use "mov.s $f12, $???" to move float to reg 
    syscall
    jr $ra
#  

read_double:                #  Read double from input 
    li $v0, 7               #  Double will be in $f0/$f1
    syscall                 #  !NOTE: that double uses 2 registers (pair of even-odd)
    jr $ra

print_double:               #  Prints double given in $f12/$f13
    li $v0, 3               #  Use "mov.d $f12, $???" to move double to reg
    syscall                 #  !NOTE: that double uses 2 registers (pair of even-odd) 
    jr $ra
#

read_string:                #  Read string from input 
    li $v0, 8               #  $a0 will be buffer address and $a1 the length (including the space made for \0) 
    syscall                 #  Remember that u can allocate space for a buffer in .data with .space (len)
    jr $ra

print_string:               #  Prints string given in $a0 
    li $v0, 4               #  Use "la $a0, label" to specify string address
    syscall
    jr $ra
#

read_char:                  #  Read char from input 
    li $v0, 12              #  Char will be in $v0 
    syscall
    jr $ra

print_char:                 #  Prints char given in $a0 
    li $v0, 11
    syscall
    jr $ra
#

print_endl:                 # prints '\n'
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    li $a0, 10
    li $v0, 11
    syscall
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    jr $ra
#