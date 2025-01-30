    .data
prompt: .asciiz "Enter a number: "  
result: .asciiz "Factorial: "  
newline: .asciiz "\n"  

    .text
    .globl main

main:
    # Prompt user to enter a number
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer input
    li $v0, 5
    syscall
    move $a0, $v0   # Store input in $a0

    # Call factorial function
    jal factorial

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $v0   # Output factorial result
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall

# Recursive Factorial Function
factorial:
    addi $sp, $sp, -8  # Allocate stack space
    sw $ra, 4($sp)     # Save return address
    sw $a0, 0($sp)     # Save argument

    # Base case: if (n == 0), return 1
    li $v0, 1
    beq $a0, $zero, return

    # Recursive case: n * fact(n-1)
    subi $a0, $a0, 1   # n-1
    jal factorial      # Recursively call factorial(n-1)

    # Retrieve original n
    lw $a0, 0($sp)
    mul $v0, $a0, $v0  # Multiply n * fact(n-1)

return:
    lw $ra, 4($sp)     # Restore return address
    addi $sp, $sp, 8   # Restore stack
    jr $ra             # Return
