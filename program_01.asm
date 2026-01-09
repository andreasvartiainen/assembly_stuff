.section .data
  exit_code: .long 69

.section .bss

.section .text
.globl _start
_start:
  pushl $1      # 2nd argument
  pushl $14     # 1st argument
  call add
  addl $8, %esp # rewind stack pointer

  movl %eax, %ebx

  movl $1, %eax
  # movl exit_code, %ebx
  int $0x80

  .type add, @function
add:
  pushl %ebp        # save the base pointer
  movl %esp, %ebp   # set stack pointer as base pointer
  xor %eax, %eax    # zero the eax

  addl 8(%ebp), %eax
  addl 12(%ebp), %eax

  movl %ebp, %esp
  popl %ebp
  ret
