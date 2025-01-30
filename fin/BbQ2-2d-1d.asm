     .data   
arr:  .word  1,  2,  3, 4,   
        5,   6,  7,   8,    
     9,   10,  11, 12    

 row:  .word 3    
 col:  .word 4   

    sums:   .space 16     
 newline:  .asciiz "\n"   

.text     
main:   
  
#  load row n col   
   la  $t0, row     
   lw  $t1, 0($t0)      # row   
  la   $t2, col    
 lw  $t3,  0($t2)    # col   

 #  set sum array zero   
 la   $t4, sums    
  li $t5,0    
sum_reset:   
bge $t5, $t3, loop_col  
sw $zero, 0($t4)    
addi $t4, $t4, 4   
   addi $t5, $t5, 1    
j sum_reset   

loop_col:   

    li $t6,  0   
bge $t6, $t3,print_result     
  
    li  $t7,  0     
 la $t8, sums      
  mul   $t9, $t6, 4   
add  $t8, $t8, $t9   

 loop_row:    

    bge  $t7,  $t1, next_col     
   
   la   $t9, arr    
   mul   $t10, $t7, $t3    
add $t10, $t10, $t6    
   mul  $t10, $t10, 4    
  add   $t9,  $t9, $t10     
  
   lw   $t11, 0($t9)      
    lw   $t12, 0($t8)     
 add  $t12, $t12, $t11     
   sw   $t12,  0($t8)      
  
  addi  $t7, $t7, 1    
   j   loop_row   

next_col:     
     addi  $t6, $t6, 1    
 j  loop_col    

print_result:    
   
     li  $t6,  0    

print_loop:    

bge  $t6, $t3, exit  
   la   $t8, sums    
  mul   $t9, $t6, 4    
 add   $t8, $t8, $t9    
 lw  $a0,  0($t8)   
   li $v0,1    
syscall    

la  $a0,newline    
 li $v0, 4     
syscall    

   addi   $t6,$t6,1    
j print_loop    

exit:    
  li $v0, 10    
 syscall    