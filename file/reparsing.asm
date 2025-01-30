#Write the following string in a file and then read it from the file and do the parsing.
#Name= Ahmed; department=Computer Science; University=DHA Suffa University.
.data
filename:       .asciiz "data.txt"  
input_string:   .asciiz "Name= Ahmed; department=Computer Science; University=DHA Suffa University."
buffer:         .space 256  
newline:        .asciiz "\n"
delimiter:      .asciiz "="  
semicolon:      .asciiz ";"  

.text
# open the file to write
 li $v0, 13                
 la $a0, filename          
 li $a1, 1                 
 li $a2, 0                 
 syscall                   
 move $s0, $v0             

 li $v0, 15                
 move $a0, $s0             
 la $a1, input_string      
 li $a2, 100               
 syscall                   

# close the file
 li $v0, 16                
 move $a0, $s0             
 syscall                   

 li $v0, 13                
 la $a0, filename          
 li $a1, 0                 
 li $a2, 0                 
 syscall                   
 move $s0, $v0             

 li $v0, 14                
 move $a0, $s0             
 la $a1, buffer            
 li $a2, 256               
 syscall                   

 li $v0, 16                
 move $a0, $s0             
 syscall                   

# extract values from buffer
 la $t0, buffer            
scan_loop:
 lb $t1, 0($t0)            
 beqz $t1, exit_program    
 beq $t1, 61, extract_data 
 addi $t0, $t0, 1          
 j scan_loop               

extract_data:
 addi $t0, $t0, 1          
print_data:
 lb $t1, 0($t0)            
 beq $t1, 59, newline_jump 
 beqz $t1, exit_program    
 li $v0, 11               
 move $a0, $t1            
 syscall                  
 addi $t0, $t0, 1         
 j print_data             

newline_jump:
 li $v0, 4               
 la $a0, newline         
 syscall                 
 addi $t0, $t0, 1        
 j scan_loop             

exit_program:
 li $v0, 10              
 syscall                 