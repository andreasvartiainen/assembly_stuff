# PURPOSE: chapter 5 coding examples: File system
#
# PROCESSING: 1) open the input file
#             2) open the output file
#             3) while we are not at the end of the input file
#               a) read part of the file into our memory buffer
#               b) go through each byte of memory
#                   if byte is a lower-case letter,
#                   convert it to uppercase
#               c) write the memory buffer to output file

.section .data
  #system call numbers
  .equ LINUX_SYSCALL, 0x80
  .equ SYS_OPEN, 5
  .equ SYS_WRITE, 4
  .equ SYS_READ, 3
  .equ SYS_CLOSE, 6
  .equ SYS_EXIT, 1

.section .bss
  .lcomm my_buffer, 500 # reserves 500 bytes

.section .text
.globl _start
_start:
