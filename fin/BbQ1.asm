    .data
source_file:   .asciiz   "source.txt"       #    src file,   
   destination_file: .asciiz "destination.txt"  # destion filee  
     
    buffer:      .space  512        # store read data  

 success_msg:  .asciiz "copied done!\n"
 error_msg:   .asciiz "open fail!!\n"

   .text
   main:
    
    #   srce file open    
     li $v0,13 
  la   $a0,  source_file    
  li    $a1,0   # mode = read
      li $a2,0  
     syscall   
bltz $v0, error_exit   
move  $s0,$v0   

     #   open dest file  
 li $v0, 13 
la    $a0,destination_file   
 li   $a1,1  #  mode = wrte  
 li $a2,0
syscall
bltz $v0, error_exit
 move $s1,$v0    

read_write_loop:
   
   #  read srce    
 li  $v0, 14  
move $a0, $s0    
     la  $a1,  buffer   
  li  $a2,  512    
 syscall   
blez $v0, close_files   
 move   $s2,$v0

   #  write dest    
 li $v0,  15 
  move  $a0,   $s1  
  la $a1,buffer    
move $a2, $s2
syscall    
 j read_write_loop  

 close_files:
   
   # srce close   
 li  $v0,16 
   move   $a0, $s0    
   syscall   

 #  close desitn  
 li   $v0, 16   
move   $a0, $s1  
 syscall  

   #  msg print   
 li $v0,4
  la  $a0,success_msg    
 syscall    

   #  exit   
 li $v0,10 
 syscall    

 error_exit:
  
  #  err print  
 li   $v0,  4  
 la   $a0,error_msg   
 syscall    
 j close_files   
