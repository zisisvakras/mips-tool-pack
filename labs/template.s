    # Name and general description of the program

#---------------------- text segment ---------------------#

    .text              # Program code goes in this section
    .globl __start

__start:               # Execution starts here



    # Your program code goes here...
		


    
    li  a7, 10         # Done, terminate program
    ecall              # au revoir...

   

#---------------------- data segment ---------------------#

    .data   # Data declarations go in this section.




#----------------------- End of File ---------------------#
