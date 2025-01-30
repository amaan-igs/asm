.data
matrix:  .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
row_count:   .word 3
col_count:   .word 4
sums: .space 12
newline: .asciiz "\n"
space:   .asciiz " "

.text
la   $t0, row_count
lw   $t1, 0($t0)
la   $t0, col_count
lw   $t2, 0($t0)

la   $t3, matrix 
la   $t4, sums 
li   $t5, 0

iterate_rows:
bge  $t5, $t1, exit_program 
    
li   $t6, 0
li   $t7, 0

iterate_columns:
bge  $t6, $t2, save_sum 
mul  $t8, $t5, $t2
add  $t8, $t8, $t6
sll  $t8, $t8, 2
    
lw   $t9, 0($t3)
add  $t7, $t7, $t9
    
addi $t3, $t3, 4
addi $t6, $t6, 1
j iterate_columns

save_sum:
sw   $t7, 0($t4)
addi $t4, $t4, 4 

addi $t5, $t5, 1
j iterate_rows

exit_program:
li   $v0, 10
syscall
