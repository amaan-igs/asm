# matrix multiplication in 2D array
.data
matrixa:  .word 1, 2, 3, 4, 5, 6
matrixb:  .word 7, 8, 9, 10, 11, 12
result:   .space 16
rowA:     .word 2
colA_rowB:.word 3
colB:     .word 2
newline:  .asciiz "\n"

.text
la   $t0, rowA
lw   $t1, 0($t0)
la   $t0, colA_rowB
lw   $t2, 0($t0)
la   $t0, colB
lw   $t3, 0($t0)

la   $t4, matrixa
la   $t5, matrixb
la   $t6, result
li   $t7, 0

row_loop:
bge  $t7, $t1, exit
li   $t8, 0

col_loop:
bge  $t8, $t3, next_row
li   $t9, 0
li   $s0, 0

mul_loop:
bge  $s0, $t2, store
mul  $s1, $t7, $t2
add  $s1, $s1, $s0
sll  $s1, $s1, 2
lw   $s2, 0($t4)
mul  $s3, $s0, $t3
add  $s3, $s3, $t8
sll  $s3, $s3, 2
lw   $s4, 0($t5)
mul  $s5, $s2, $s4
add  $t9, $t9, $s5
addi $t4, $t4, 4
addi $t5, $t5, 4
addi $s0, $s0, 1
j mul_loop

store:
sw   $t9, 0($t6)
addi $t6, $t6, 4
addi $t8, $t8, 1
j col_loop

next_row:
addi $t7, $t7, 1
j row_loop

exit:
li   $v0, 10
syscall