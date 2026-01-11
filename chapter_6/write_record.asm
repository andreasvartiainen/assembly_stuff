.include "preample.asm"
.include "record_def.asm"

#PURPOSE: this function read a record from the file descriptor
#
#INPUT: the file descriptor and a buffer
#
#OUTPUT: this function writes the data to the buffer and returns a status code
.equ    ST_READ_BUFFER, 8   # inputs to function declared before calling it
.equ    ST_FILEDES,     12  # 
.section .text
.globl  write_record
.type   write_record, @function
write_record:
  pushl %ebp
  movl  %esp, %ebp

  pushl %ebx
  movl  $SYS_WRITE, %eax
  movl  ST_FILEDES(%ebp), %ebx
  movl  ST_READ_BUFFER(%ebp), %ecx
  movl  $RECORD_SIZE, %edx
  int   $SYS_INT

  popl  %ebx
  
  movl  %ebp, %esp
  popl  %ebp
  ret
