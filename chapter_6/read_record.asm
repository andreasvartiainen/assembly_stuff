.include "preample.asm"
.include "record_def.asm"

#PURPOSE: this function read a record from the file descriptor
#
#INPUT: the file descriptor and a buffer
#
#OUTPUT: this function writes the data to the buffer and returns a status code
.equ ST_READ_BUFFER, 8 # inputs to function declared before calling it
.equ ST_FILEDES, 12    # 
.section .text
.globl read_record
.type read_record, @function
read_record:
  ## save the basepointer and set new one
  pushl %ebp
  movl %esp, %ebp

  # saving ebx?
  pushl %ebx
  movl ST_FILEDES(%ebp), %ebx
  movl ST_READ_BUFFER(%ebp), %ecx
  movl $RECORD_SIZE, %edx
  movl $SYS_READ, %eax
  int $SYS_INT

  #NOTE: %eax will be the return value we give back to the caller
  #
  popl %ebx

  ## load the old base pointer and restore stack
  movl %ebp, %esp
  popl %ebp
  ret
