# Float syscalls

.text
.globl main

main:
    jal read_float
    mov.s $f12, $f0
    jal print_float
    j exit


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

# Exits the program
exit:
    li $v0, 10
    syscall