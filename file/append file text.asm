#Write a Mips program that appends user input to an existing file.
.data
file_name:      .asciiz "output.txt"
input_buffer:   .space  1024
input_message: .asciiz "Enter text to add: "
success_message:.asciiz "Content appended successfully!"
error_message:  .asciiz "Error: Could not open file!"

.text
# open file in append mode
 li $v0, 13              
 la $a0, file_name       
 li $a1, 9               
 li $a2, 0               
 syscall                 
 bltz $v0, handle_error  
 move $s0, $v0           

# show input prompt
 li $v0, 4               
 la $a0, input_message  
 syscall                 

 li $v0, 8               
 la $a0, input_buffer    
 li $a1, 1024            
 syscall                 

 # determine input length
 la $t0, input_buffer    
 li $t1, 0               
count_length:
 lb $t2, 0($t0)
 beqz $t2, write_to_file 
 addi $t1, $t1, 1        
 addi $t0, $t0, 1        
 j count_length          

write_to_file:
# write input to file
 li $v0, 15              
 move $a0, $s0           
 la $a1, input_buffer    
 move $a2, $t1           
 syscall                 
 bltz $v0, handle_error  

 li $v0, 16              
 move $a0, $s0           
 syscall                 

# display success message
 li $v0, 4               
 la $a0, success_message 
 syscall                 

 li $v0, 10              
 syscall                 

handle_error:
 li $v0, 4               
 la $a0, error_message   
 syscall                 
# end program
 li $v0, 10              
 syscall 