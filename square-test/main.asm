.section .text
.globl _start
_start:
  pushl $6
  call square
  addl $4, %esp

  movl %eax, %ebx # set result as return code

  movl $1, %eax
  int $0x80
