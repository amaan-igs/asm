.data
rows:   .word 3   # number of rows
cols:   .word 3   # number of columns
# 3x3 Matrix
data_matrix: .word 1, 2, 3
              .word 4, 5, 6
              .word 7, 8, 9
#Transposed Matrix
transposed_matrix: .space 36
newline:  .asciiz "\n"
space:    .asciiz " "

.text
# load matrix size
 lw $t0, rows  
 lw $t1, cols  
 la $t2, data_matrix  
 la $t3, transposed_matrix  
 li $t4, 0  # Row index

row_traverse:
 bge $t4, $t0, display_transposed  
 li $t5, 0  # Column index

col_traverse:
 bge $t5, $t1, next_row_step  

# real matrix index
 mul $t6, $t4, $t1  
 add $t6, $t6, $t5  
 sll $t6, $t6, 2    
 add $t7, $t2, $t6  
 lw $t8, 0($t7)     
# transposed matrix index
 mul $t9, $t5, $t0  
 add $t9, $t9, $t4  
 sll $t9, $t9, 2    
 add $s0, $t3, $t9  
 sw $t8, 0($s0)     
 addi $t5, $t5, 1  
 j col_traverse    

next_row_step:
 addi $t4, $t4, 1  
 j row_traverse    

display_transposed:
 li $t4, 0  

output_rows:
 bge $t4, $t1, end_program  
 li $t5, 0  

output_cols:
 bge $t5, $t0, newline_step  

 mul $t6, $t4, $t0
 add $t6, $t6, $t5
 sll $t6, $t6, 2
 add $t7, $t3, $t6
 lw $a0, 0($t7)  

 li $v0, 1
 syscall
 li $v0, 4
 la $a0, space
 syscall

 addi $t5, $t5, 1  
 j output_cols

newline_step:
 li $v0, 4
 la $a0, newline
 syscall

 addi $t4, $t4, 1  
 j output_rows

end_program:
 li $v0, 10  
 syscall