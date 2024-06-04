.text
    .globl __start
__start:

        li $t1, 0               # counter for string
        li $s0, 't'             # character to end copy
        lw $s1, n               # max characther count
        
while:  lbu $t0, string($t1)    # load a character
        
        sne  $t2, $s0, $t0      # $t2 = ($t0 != $s0)
        slt  $t3, $t1, $s1      # $t3 = (character counter < maximum number of characters)
        or   $t2, $t2, $t3      # $t2 |= $t3

        beq $t2, $zero, end     # If number of characters copied has exceeded the limit
                                # AND the character stored in $s1 has been found, then exit loop
        
        sb $t0, copy($t1)       # copy character
        addi $t1, $t1, 1        # increment counter
        
        j while                 # repeat while loop


end:
        sb $zero, copy($t1)       # append end character to copied string
        
        la $a0, copy            # display copy
        li $v0, 4
        syscall
        
        li $v0, 10 # exit
        syscall


.data
    string: .asciiz "Mary had a little lamb"
    copy:   .space 80
    n:      .word 0xE