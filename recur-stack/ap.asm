    .data
prompt_a:       .asciiz "Enter first term (a): "
prompt_d:       .asciiz "Enter common difference (d): "
prompt_n:       .asciiz "Enter number of terms (n): "
result_msg:     .asciiz "Sum of arithmetic progression (AP) is: "
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

    # Prompt for d (common difference)
    li $v0, 4              
    la $a0, prompt_d       
    syscall                

    # Read d (common difference)
    li $v0, 5              
    syscall                
    move $t1, $v0          # $t1 = d

    # Prompt for n (number of terms)
    li $v0, 4              
    la $a0, prompt_n       
    syscall                

    # Read n (number of terms)
    li $v0, 5              
    syscall                
    move $t2, $v0          # $t2 = n

    # Calculate AP Sum: Sn = (n/2) * (2a + (n-1) * d)

    # Step 1: Compute (n - 1)
    subi $t3, $t2, 1       # $t3 = (n - 1)

    # Step 2: Compute (n - 1) * d
    mul $t4, $t3, $t1      # $t4 = (n - 1) * d

    # Step 3: Compute (2 * a)
    sll $t5, $t0, 1        # $t5 = 2 * a

    # Step 4: Compute (2a + (n - 1) * d)
    add $t6, $t5, $t4      # $t6 = 2a + (n - 1) * d

    # Step 5: Compute n * (2a + (n - 1) * d)
    mul $t7, $t2, $t6      # $t7 = n * (2a + (n - 1) * d)

    # Step 6: Compute Final Sum = Sn = (n * (2a + (n - 1) * d)) / 2
    sra $t8, $t7, 1        # $t8 = Sn (integer division by 2)

    # Display result message
    li $v0, 4              
    la $a0, result_msg     
    syscall                

    # Print the sum
    li $v0, 1              
    move $a0, $t8          
    syscall                

    # Print newline
    li $v0, 4              
    la $a0, newline        
    syscall                

    # Exit program
    li $v0, 10             
    syscall                
