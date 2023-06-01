.data
    NL: .asciiz " "
 .text 
     main:
       li $a1, 11	
       jal SN
       
       li $a1, 11
       jal CBZ
       
       move $a1, $v0
       jal SN
       
       li $v0, 10
       syscall 	
 
# Mostrar Numero
SN: 
   li $v0, 4
   la $a0, NL
   syscall
   
   li $v0, 1
   move $a0, $a1
   syscall
   
   jr $ra

 #Limpiar bit zero
 CBZ:
    #Mask sera $s0
    addi $sp, $sp, -4 #Tamaño de bits de sp
    sw $s0, 0($sp)    #Guarda el valor de s0  en sp
    
    #Mask
    li $s0, -1        #1111111111111111 Two's Complement
    sll $s0, $s0, 1   #1111111111111110 <---Shif Left
    and $v0, $a1, $s0  #And entre $a1 y $s0 este valor se guarda en $v0
    
    lw $s0, 0($sp)
    addi $sp, $sp, 4
    
    jr $ra
            