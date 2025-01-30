.data
msg: .asciiz "enter a number: "
output: .asciiz "fibonacci result: "

.text
 li $v0, 4
 la $a0, msg
 syscall
 
 li $v0, 5
 syscall
 move $a0, $v0 
    
 jal fib
    
 li $v0, 4
 la $a0, output
 syscall
    
 move $a0, $v0
 li $v0, 1
 syscall
    
 li $v0, 10
 syscall

fib:
 li $t0, 0
 beq $a0, $t0, case_zero
 li $t0, 1
 beq $a0, $t0, case_one
    
 addi $sp, $sp, -12
 sw $ra, 0($sp)
 sw $a0, 4($sp)
    
 addi $a0, $a0, -1
 jal fib
 move $t1, $v0
    
 lw $a0, 4($sp)
 addi $a0, $a0, -2
 jal fib
    
 add $v0, $t1, $v0
    
 lw $ra, 0($sp)
 addi $sp, $sp, 12
 jr $ra

case_zero:
 li $v0, 0
 jr $ra

case_one:
 li $v0, 1
 jr $ra