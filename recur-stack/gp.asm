    .data
prompt_a:       .asciiz "Enter first term (a): "
prompt_r:       .asciiz "Enter common ratio (r): "
prompt_n:       .asciiz "Enter number of terms (n): "
result_msg:     .asciiz "Sum of geometric progression (GP) is: "
newline:        .asciiz "\n"

    .text
    .globl main

main:
    # Prompt for a (first term)
    li $v0, 4               
    la $a0, prompt_a       
    syscall                

    # Read a (first term)
    li $v0, 5              
    syscall                
    move $t0, $v0          # $t0 = a

    # Prompt for r (common ratio)
    li $v0, 4              
    la $a0, prompt_r       
    syscall                

    # Read r (common ratio)
    li $v0, 5              
    syscall                
    move $t1, $v0          # $t1 = r

    # Prompt for n (number of terms)
    li $v0, 4              
    la $a0, prompt_n       
    syscall                

    # Read n (number of terms)
    li $v0, 5              
    syscall                
    move $t2, $v0          # $t2 = n

    # Compute r^n (power calculation)
    li $t3, 1              # $t3 = r^0 = 1
    li $t4, 0              # Counter i = 0

power_loop:
    beq $t4, $t2, gp_sum   # If i == n, break
    mul $t3, $t3, $t1      # r^i *= r
    addi $t4, $t4, 1       # i++
    j power_loop

gp_sum:
    # Compute (1 - r^n)
    li $t5, 1              # $t5 = 1
    sub $t6, $t5, $t3      # $t6 = 1 - r^n

    # Compute (1 - r)
    li $t5, 1              # $t5 = 1
    sub $t7, $t5, $t1      # $t7 = 1 - r

    # Divide (1 - r^n) / (1 - r)
    div $t6, $t7           # HI/LO = (1 - r^n) / (1 - r)
    mflo $t8               # Get quotient

    # Compute S_n = a * ((1 - r^n) / (1 - r))
    mul $t9, $t0, $t8      # $t9 = a * result

    # Display result message
    li $v0, 4              
    la $a0, result_msg     
    syscall                

    # Print the sum
    li $v0, 1              
    move $a0, $t9          
    syscall                

    # Print newline
    li $v0, 4              
    la $a0, newline        
    syscall                

    # Exit program
    li $v0, 10             
    syscall                
