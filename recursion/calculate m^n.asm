# calculate m^n
.data
msg_base: .asciiz "enter base: "
msg_exp: .asciiz "enter exponent: "
msg_result: .asciiz "result: "

.text
 li $v0, 4
 la $a0, msg_base
 syscall
    
 li $v0, 5
 syscall
 move $a0, $v0
    
 li $v0, 4
 la $a0, msg_exp
 syscall
    
 li $v0, 5
 syscall
 move $a1, $v0
    
 jal exponentiate
    
 li $v0, 4
 la $a0, msg_result
 syscall
    
 move $a0, $v0
 li $v0, 1
 syscall
    
 li $v0, 10
 syscall

exponentiate:
 beq $a1, $zero, return_one
    
 addi $sp, $sp, -8
 sw $ra, 0($sp)
 sw $a0, 4($sp)
    
 addi $a1, $a1, -1
 jal exponentiate
    
 lw $a0, 4($sp)
 mul $v0, $v0, $a0
    
 lw $ra, 0($sp)
 addi $sp, $sp, 8
 jr $ra
    
return_one:
 li $v0, 1
 jr $ra