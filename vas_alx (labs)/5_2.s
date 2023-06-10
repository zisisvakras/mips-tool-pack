.text
.globl     __start	

lwc1 $f0, zer_f
lwc1 $f1, m_inf
lwc1 $f2, p_inf
lwc1 $f3, not_xergias
lwc1 $f4, x
lwc1 $f5, y

#xy
mul.s $f6, $f4, $f5
#x(-inf)
mul.s $f7, $f4, $f1
#y/0
div.s $f8, $f5, $f0
#0/0
div.s $f9, $f0, $f0
#0(+inf)
mul.s $f10, $f0, $f2
#+inf/-inf
div.s $f11, $f2, $f1
#inf-inf
add.s $f12, $f2, $f1
#x+NaN
add.s $f14, $f4, $f3



li $v0, 10
syscall #au revoir

.data
zer_f:          .float  0.0
m_inf:          .word   0xff800000
p_inf:          .word   0x7f800000
not_xergias:    .word   0x7fe00000
x:              .float  55.0
y:              .float -55.0

