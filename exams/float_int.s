# exam problem where u have to find if given float is an integer or not
# made using utilities from this tool-pack

.data
    endl: .asciiz "\n"
    int: .asciiz "FOUND-INTEGER="
    nint: .asciiz "NOT-INTEGER\n"
    zerof: .float 0.0
    # buffer: .space 20
    # array: .word 20, 30, 40
.text
.globl main

main:
    lw $t0, zerof
    mtc1 $t0, $f1
loop:
    # read and print the input float
    jal read_float
    mov.s $f12, $f0
    cvt.w.s $f0, $f12
    cvt.s.w $f0, $f0
    c.eq.s $f12, $f0
    bc1t is_int
    la $a0, nint
    jal print_string
end:
    c.eq.s $f12, $f1 
    bc1f loop
    j exit

is_int:
    la $a0, int
    jal print_string
    jal print_float
    la $a0, endl
    jal print_string
    j end

# Exits the program
exit:
    li $v0, 10
    syscall


#  Read float from input
#  Float will be in $f0
read_float:
    li $v0, 6
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