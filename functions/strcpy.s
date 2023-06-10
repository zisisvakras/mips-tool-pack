.text
.globl main

main: # brief demo of strcpy

    # Print the source string
    li $v0, 4                # Print string syscall
    la $a0, source           # Load the address of the source string
    syscall

    # Copy the source string to target
    la $a0, target 
    la $a1, source 
    jal strcpy               # Call the strcpy function

    # Print the target string
    li $v0, 4                # Print string syscall
    la $a0, target           # Load the address of the target string
    syscall

    # Exit the program
    li $v0, 10               # Exit syscall
    syscall

## END OF MAIN

# destination : $a0, source $a1
# strcpy(dest, src)
strcpy: # code is taken from lectures without modifications
    addi $sp, $sp, -4           # adjust stack for 1 item
    sw $s0, 0($sp)              # save $s0

    add $s0, $zero, $zero       # i = 0  
L1:
    add $t1, $s0, $a1           # address of y[i] in $t1
    lbu $t2, 0($t1)             # $t2 = y[i]

    add $t3, $s0, $a0           # address of x[i] in $t3
    sb $t2, 0($t3)              # x[i] = y[i]

    beq $t2, $zero, L2          # exit loop if y[i] == 0
    addi $s0, $s0, 1            # i++
    j L1                        # next iteration of loop
L2: 
    lw $s0, 0($sp)              # restore saved $s0
    addi $sp, $sp, 4            # pop 1 item from stack
    jr $ra                      # return


.data
source: .asciiz "Hello, world!\n"       # Source string
target: .space 20                       # Target string with ENOUGH space