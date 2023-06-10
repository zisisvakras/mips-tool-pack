## SINGLE PERCISION ###

# Assign a constant value to $f0

## Registers 

# Move int into float
mtc1 $t0, $f0 # Moves the value of $t0 into $f0  # NOTE: here destination is second
cvt.s.w $f0, $f0 # Converts the value of $f0 into a single precision value

# Move float into int
cvt.w.s $f0, $f0 # Converts the value of $f0 into a word
mfc1 $t0, $f0 # Moves the value of $f0 into $t0 # NOTE: here destination is first 

# Load Immediate
li.s $f0, 0.5 # Loads the value 0.5 into $f0

# Load Address
la $t0, pi_float # Loads the address of pi_float into $t0
l.s $f0, 0($t0) # Loads the value at the address stored in $t0 into $f0

# Store
s.s $f0, 0($t0) # Stores the value of $f0 into the address stored in $t0


## Arithmetic

# Add
add.s $f0, $f0, $f1 # Adds the value of $f0 and $f1 and stores it in $f0 
# Subtract
sub.s $f0, $f0, $f1 # Subtracts the value of $f1 from $f0 and stores it in $f0
# Multiply
mul.s $f0, $f0, $f1 # Multiplies the value of $f0 and $f1 and stores it in $f0
# Divide
div.s $f0, $f0, $f1 # Divides the value of $f0 by $f1 and stores it in $f0



### DOUBLE PERCISION ###

# Move int into double
mtc1 $t0, $f0 # Moves the value of $t0 into $f0  # NOTE: here destination is second
cvt.d.w $f0, $f0 # Converts the value of $f0 into a double precision value

# Move double into int
cvt.w.d $f0, $f0 # Converts the value of $f0 into a word
mfc1 $t0, $f0 # Moves the value of $f0 into $t0 # NOTE: here destination is first

# Load Immediate
li.d $f0, 0.5 # Loads the value 0.5 into $f0

# Load Address
la $t0, pi_double # Loads the address of pi_double into $t0
l.d $f0, 0($t0) # Loads the value at the address stored in $t0 into $f0

# Store
s.d $f0, 0($t0) # Stores the value of $f0 into the address stored in $t0


.data

    pi_float: .float 3.14159
    pi_double: .double 3.14159265359
    e_const: .float 2.71828
    e_double: .double 2.71828182845904

