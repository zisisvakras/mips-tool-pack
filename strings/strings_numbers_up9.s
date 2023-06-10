.text
.globl main
main:
    la $a0, str1
    jal are_digits


    beqz $v0, false
    # true
    la $a0, msg1
    jal print_string
    jal print_endl

    li $a1, 2 # base
    la $a0, str1
    jal convert_string_to_value
    move $a0, $v0
    jal print_int



    j exit

    false:
    la $a0, msg2
    jal print_string




    j exit


### STRING FUNCTIONS ###

# Checks if a string containts only digits
# $a0 = string address
# $v0 = 1 if true, 0 if false
are_digits:
    are_digits_loop:
        lb $t0, 0($a0) # Load byte from string
        beqz $t0, are_digits_end # If byte is 0, end of string
        #beq $t0, 10, are_digits_end # If byte is 10, end of string
        blt $t0, 48, are_digits_false # If byte is less than 48, false
        bgt $t0, 57, are_digits_false # If byte is greater than 57, false
        addi $a0, $a0, 1 # Increment string address
        j are_digits_loop # Loop
    are_digits_false:
        li $v0, 0 # False
        jr $ra
    are_digits_end:
        li $v0, 1 # True
        jr $ra

# Convert string to value
# $a0: string address
# $a1: base
# $v0: resulting value

convert_string_to_value:
    addiu $sp, $sp, -4         # Reserve space on the stack
    sw $ra, 0($sp)             # Save the return address

    li $t0, 0                  # Initialize $t0 to store the result
    li $t1, 1                  # Initialize $t1 as a base multiplier
    move $t2, $a0              # Move the string address to $t2

loop:
    lbu $t3, 0($t2)            # Load a character from the string
    beqz $t3, done             # If the character is null, exit the loop

    sub $t3, $t3, 48           # Convert the ASCII digit to its numeric value
    bge $t3, $a1, done         # If the digit is greater or equal to the base, exit the loop
    
    mul $t0, $t0, $a1          # Multiply the result by the base
    addu $t0, $t0, $t3         # Add the digit to the result

    addiu $t2, $t2, 1          # Move to the next character in the string
    mul $t1, $t1, $a1          # Multiply the base by itself

    j loop                     # Jump back to the start of the loop

done:
    lw $ra, 0($sp)             # Restore the return address
    addiu $sp, $sp, 4          # Free the space on the stack

    move $v0, $t0              # Move the result to $v0
    jr $ra                     # Return from the function



print_string:
    li $v0, 4
    syscall
    jr $ra

print_endl:
    li $v0, 11 
    la $a0, 10 
    syscall
    jr $ra

print_int:
    li $v0, 1
    syscall
    jr $ra

exit:
    li $v0, 10
    syscall    

.data
str1: .asciiz "1111111"
str2: .asciiz "123a"
msg1: .asciiz "\n"
msg2: .asciiz "This is not a number\n"