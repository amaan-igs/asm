    .data   
matrix:  
 .word  1,   2,   3,   4,    
         5,   6,   7,   8,   
         9,  10,  11,  12,   
        13,  14,  15,  16   

size:   .word  4    #   Matrix NxN (4x4)  
result: .asciiz  "Diagonal sum:  "   
newline: .asciiz  "\n"  

.text   
 main:  
    la $t0, size      
    lw $t1, 0($t0)      # N = size  
    li  $t2,  0        # sum  =  0   
    li  $t3,  0        # i  = 0   

diag_loop:    

  bge   $t3,  $t1, print_result    
  
  la   $t4,  matrix    
   mul  $t5,  $t3,  $t1     
  add  $t5,   $t5,  $t3    
  mul  $t5,   $t5,  4    
 add   $t4,   $t4,  $t5    

   lw   $t6,  0($t4)     # matrix[i][i]   
   add  $t2,  $t2,  $t6    
   addi $t3,  $t3,  1    
  j  diag_loop    

print_result:    
   
   li   $v0,  4    
   la   $a0,  result    
   syscall    

   li   $v0,  1    
   move $a0,  $t2     
   syscall    

   li   $v0,  4    
   la   $a0,  newline     
   syscall    

 exit:    
  li  $v0, 10    
 syscall  