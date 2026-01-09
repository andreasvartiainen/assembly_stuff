# PURPOSE: Calculate factorial non-recursively

.section .data
.section .bss
.section .text
.globl _start
_start:
  pushl $5        # push argument
  call factorial
  addl $4, %esp   # reset stack pointer

  movl %eax, %ebx

  movl $1, %eax
  int $0x80

.type factorial, @function
factorial:
  pushl %ebp
  movl %esp, %ebp

  movl 8(%ebp), %eax

  cmpl $1, %eax
  je end

  xor %ebx, %ebx  # index
  xor %ecx, %ecx
  incl %ebx       # make ebx 1
  incl %ecx

loop_start:
  cmpl %eax, %ebx # if ebx is greater than eax jump to end
  jg end_loop

  imull %ebx, %ecx # multiply the last result
  incl %ebx

  jmp loop_start

end_loop:
  movl %ecx, %eax

end:
  movl %ebp, %esp
  popl %ebp
  ret
