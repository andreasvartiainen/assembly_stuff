.section .bss
  .lcomm data, 4
  .lcomm str, 6
  .equ str_len, . - str

.section .text
.globl _start
_start:
  xor %edx, %edx
  movl $str, %eax
  movl $'h', (%eax, %edx, 1)
  incl %edx
  movl $'e', (%eax, %edx, 1)
  incl %edx
  movl $'l', (%eax, %edx, 1)
  incl %edx
  movl $'l', (%eax, %edx, 1)
  incl %edx
  movl $'o', (%eax, %edx, 1)
  incl %edx
  movl $'\n', (%eax, %edx, 1)

  movl $4, %eax
  movl $1, %ebx
  movl $str, %ecx
  movl $str_len, %edx
  int $0x80

  movl $69, %ecx
  movl %ecx, data
  movl data, %ebx
  # movl $data, %ebx # this would load the actuall addres to the ebx

  movl $1, %eax
  int $0x80
