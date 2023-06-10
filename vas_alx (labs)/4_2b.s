.text
.globl __start

__start:
# start of main program
    la $a0,prompt
    li $v0,4
    syscall # display "Enter integer number :"
    li $v0,5
    syscall # read integer
    move $t0,$v0
    la $a0,endl
    li $v0,4
    syscall # display end of line
    move $a0,$t0
    
    jal vas_alx

    li $v0,10
    syscall # exit
# end of main program



# start of procedure

vas_alx:
    
    addi $sp, $sp, -4
    sw $ra, 0 ($sp)
    move $a0,$t0
    li $v0, 1
    syscall
    move $t0, $a0
    la $a0,endl
    li $v0,4

    beq $a0, $zero, return
        addi $a0, $a0, -1
        jal vas_alx
    return:

    
        syscall # display end of line

        lw $ra, 0 ($sp)
        addi $sp, $sp, 4
        
        jr $ra


# end of procedure


 .data
prompt: .asciiz "Enter integer number :"
endl: .asciiz "\n"


