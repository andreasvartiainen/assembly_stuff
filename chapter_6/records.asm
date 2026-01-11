.include "preample.asm"   ## syscalls and stuff
.include "record_def.asm" ## record definitions and offsets

#PURPOSE: this function read a record from the file descriptor
#
#INPUT: the file descriptor and a buffer
#
#OUTPUT: this function writes the data to the buffer and returns a status code

.equ ST_READ_BUFFER, 8
.equ ST_FILEDES, 12
.section .text
.globl _start
_start:
  movl $SYS_EXIT, %eax
  movl $EXIT_VALUE, %ebx
  int $SYS_INT
  
