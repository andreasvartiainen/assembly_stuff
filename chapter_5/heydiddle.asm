.section .data
  filename: 
   .ascii "heynow.txt\0"
  .equ filename_len, . - filename

  data: 
   .ascii "you're an all star, get your game on, go play!"
  .equ data_len, . - data

  .equ O_CREAT_WRONLY_TRUNC, 03101
  .equ SYS_EXIT, 1
  .equ SYS_WRITE, 4
  .equ SYS_OPEN, 5
  .equ SYS_CLOSE, 6

  .equ SYS_INT, 0x80

.section .bss
  .lcomm file_ptr, 4

.section .text
.globl _start
_start:
  ## open a file for writing ##
  movl $SYS_OPEN, %eax
  movl $filename, %ebx
  movl $O_CREAT_WRONLY_TRUNC, %ecx
  movl $0666, %edx
  int $SYS_INT

  movl %eax, file_ptr

  ## write stuff ##

  movl $SYS_WRITE, %eax
  movl file_ptr, %ebx
  movl $data, %ecx
  movl $data_len, %edx
  int $SYS_INT

end:
  movl $SYS_CLOSE, %eax
  movl file_ptr, %ebx
  int $SYS_INT

  movl $SYS_EXIT, %eax
  movl $69, %ebx
  int $SYS_INT
