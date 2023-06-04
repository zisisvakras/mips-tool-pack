###################################################
#                                                 #
#           Read INteger and Print Integer        #
#                                                 #
###################################################

.text
.globl __start

__start: 

    li $v0, 5       # read integer
    syscall

    move $a0, $v0   # the read integer is stored in $v0 by the syscall, so we move
                    # it in $a0, so we can print it

    li $v0, 1       # print integer
    syscall 



    li $v0, 10      # exit
    syscall
