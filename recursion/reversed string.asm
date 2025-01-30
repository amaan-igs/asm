.data
msg_input: .asciiz "enter a string: "
msg_output: .asciiz "the reversed string is: "
buffer: .space 100

.text
 li $v0, 4
 la $a0, msg_input
 syscall
    
 li $v0, 8
 la $a0, buffer
 li $a1, 100
 syscall
    
 la $a0, buffer
 jal get_length
 move $a1, $v0
    
 la $a0, buffer
 addi $a1, $a1, -1
 jal reverse
    
 li $v0, 4
 la $a0, msg_output
 syscall
    
 li $v0, 4
 la $a0, buffer
 syscall
    
 li $v0, 10
 syscall

get_length:
 li $v0, 0
    
loop_length:
 lb $t0, 0($a0)
 beq $t0, $zero, length_done
 addi $a0, $a0, 1
 addi $v0, $v0, 1
 j loop_length
    
length_done:
 jr $ra

reverse:
 blt $a1, 1, done_reverse
    
 add $t0, $a0, $a1
 lb $t1, 0($a0)
 lb $t2, 0($t0)
 sb $t2, 0($a0)
 sb $t1, 0($t0)

 addi $a0, $a0, 1
 addi $a1, $a1, -2
 jal reverse
    
done_reverse:
 jr $ra