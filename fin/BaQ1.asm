       .data  
filename:    .asciiz "input.txt"      #    file name store   
   buffer:  .space 512                #  save data here  
  target:  .asciiz "MIPS"           # word  find    
newline:     .asciiz "\ncount of MIPS : "  

    .text   
main:
  
 #   open fle (sys  13)  
     li $v0,   13   
  la  $a0,filename   
   li $a1,0  
 li   $a2,0  
syscall    
   bltz $v0,exit     #  if not open, quit 
move  $s0,   $v0    

   #  read fil (sys14)  
li $v0, 14    
 move  $a0, $s0    
 la $a1,  buffer     
 li   $a2,  512    
syscall    
 move   $s1,$v0    

 #   close file   (sys16)  
 li  $v0,16   
 move  $a0,$s0    
syscall    

  #  find MIP count    
  li  $t0,0        # cntr   
   la  $a0,buffer     
 la $a1, target    
 li  $a2,4    
jal count_mips   

  #  print    result   
  li   $v0, 4  
 la   $a0, newline    
 syscall    

   li $v0,1    
move   $a0, $t0    
syscall    

exit:   
 li  $v0, 10    
  syscall    

  # fun:  find MIPS  
count_mips:
    
 move  $t1, $a0    
 li $t2, 0    
   li  $t3, 4    

search_loop:

 # end buf?  
bge  $t2,  $s1,end_count    

 # see if "MIPS" same   
  la  $t4, target    
 li $t5, 0    

compare:
   
  lb  $t6, 0($t1)   
   lb  $t7, 0($t4)    
 bne  $t6, $t7,next_char    
  addi  $t1, $t1,  1    
    addi $t4, $t4,1   
  addi $t5,  $t5,1    
blt  $t5,  $t3,compare    

 #  full match, count up  
  addi   $t0,$t0,1    

next_char:
   
  la $t4,  target   
 addi   $t1,   $t1, 1   
   addi  $t2, $t2, 1    
j  search_loop    

end_count:
  jr  $ra    
