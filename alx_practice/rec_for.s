.text
.globl main


main:

li $a0, 5
jal rec_for_rev

jal print_endl

li $a0, 6
jal rec_for

j exit

#li $a0, 7
#jal rec_for

#j exit

# void rec_for(int n){
#     if(n <= 0)
#         print(n);
#         return;
#     else{
#         print(n);
#         rec_for(n-1);
#     }
# }

# $a0 = n
rec_for_rev:
    bgtz $a0, else_r
    move $t7, $ra
    jal print_int
    move $ra, $t7
    jr $ra

    else_r:
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        
        jal print_int
        addi $a0, $a0, -1
        jal rec_for_rev
        addi $a0, $a0, 1
        lw $ra, 0($sp)
        addi $sp, $sp, 4

        jr $ra

rec_for:
    bgtz $a0, else_n
    move $t7, $ra
    jal print_int
    move $ra, $t7
    jr $ra

    else_n:
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        
        addi $a0, $a0, -1
        jal rec_for
        addi $a0, $a0, 1

        jal print_int # NOTE: print int before I restore $ra 

        lw $ra, 0($sp)
        addi $sp, $sp, 4

        jr $ra



print_int:
    li $v0, 1
    syscall
    jr $ra

print_endl:
    li $v0, 11
    li $a0, 10
    syscall
    jr $ra

exit: 
    li $v0, 10
    syscall