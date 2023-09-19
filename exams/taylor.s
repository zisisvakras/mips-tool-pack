# possible exam problem
# calculates Τaylor series: x^n/n! 
# of the function: e^x 

#  MESSAGES
.data
    ReadFloating: .asciiz "Insert a float :"

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

#  Read float from input
#  Float will be in $f0
read_float:
    li $v0, 6
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

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra