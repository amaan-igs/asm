    .data
prompt: .asciiz "Enter a number (0 to stop): "  
newline: .asciiz "\n"  

    .text
    .globl main

main:
    # Prompt user
    li $v0, 4
    la $a0, prompt
    syscall

    # Read user input
    li $v0, 5
    syscall
    move $a0, $v0  # Store input in $a0

    # Check for termination (if 0, start popping)
    beqz $a0, pop_values  

    # Push value onto stack
    addi $sp, $sp, -4  
    sw $a0, 0($sp)  

    # Recursive call
    jal main  

pop_values:
    # Check if stack is empty
    li $t0, 0x7FFFFFFC  # Approximate top of stack limit
    beq $sp, $t0, exit  # If stack pointer reaches this, exit

    # Pop value from stack
    lw $a0, 0($sp)  
    addi $sp, $sp, 4  

    # Print value
    li $v0, 1
    syscall  

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Recursively pop remaining values
    j pop_values  

exit:
    li $v0, 10
    syscall  
