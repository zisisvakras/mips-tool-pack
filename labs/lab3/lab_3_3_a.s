.text
    .globl __start
__start:

        li $t1, 0               # counter for string
        li $s0, 't'             # character to end copy
        lw $s1, n               # max characther count
        
while:  lbu $t0, string($t1)    # load a character
        
        beq  $t0, $s0, end      # If character to end, copy then exit loop
        slt  $t2, $t1, $s1      # $t2 = (character counter < maximum number of characters)
        beqz $t2, end           # If number of characters copied has exceeded the limit, exit loop
        
        bne $t3, $zero, end     # if both conditions are false, copy then exit loop
        
        sb $t0, copy($t1)       # copy character
        addi $t1, $t1, 1        # increment counter
        
        j while                 # repeat while loop


end:    li $t2, 0
        sb $t2, copy($t1)       # append end character to copied string
        
        la $a0, copy            # display copy
        li $v0, 4
        syscall
        
        li $v0, 10 # exit
        syscall


.data
    string: .asciiz "Mary had a little lamb"
    copy:   .space 80
    n:      .word 0x5