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
  .equ SYS_OPEN, 5
  .equ SYS_WRITE, 4
  .equ SYS_READ, 3
  .equ SYS_CLOSE, 6
  .equ SYS_EXIT, 1

  #options for open (look at
  #/usr/include/asm/fcntl.h for
  #various values. You can combine them
  #by adding them or ORing them)
  #This is discussed at greater length
  #in "Counting Like a Computer"
  .equ O_RDONLY, 0
  .equ O_CREAT_WRONLY_TRUNC, 03101

  #standard file descriptors
  .equ STDIN, 0
  .equ STDOUT, 1
  .equ STDERR, 2

  #system call interrupt
  .equ LINUX_SYSCALL, 0x80

  .equ EOF, 0

  .equ NUMBER_OF_ARGUMENTS, 2

.section .bss
  .equ BUFFER_SIZE, 255
  .lcomm BUFFER_DATA, BUFFER_SIZE # reserves BUFFER_SIZE bytes

.section .text

  #stack positions
  .equ ST_SIZE_RESERVE, 8
  .equ ST_FD_IN, -4
  .equ ST_FD_OUT, -8
  .equ ST_ARGC, 0
  .equ ST_ARGV_0, 4
  .equ ST_ARGV_1, 8
  .equ ST_ARGV_2, 12

.globl _start
_start:
  movl %esp, %ebp

  subl $ST_SIZE_RESERVE, %esp # allocate space in stack all 8 in one go

open_files:
open_fd_in:
  movl $SYS_OPEN, %eax
  movl ST_ARGV_1(%ebp), %ebx
  movl $O_RDONLY, %ecx
  movl $0666, %edx
  int $LINUX_SYSCALL

store_fd_in:
  movl %eax, ST_FD_IN(%ebp) # move file number in allocated space

open_fd_out:
  movl $SYS_OPEN, %eax
  movl ST_ARGV_2(%ebp), %ebx
  movl $O_CREAT_WRONLY_TRUNC, %ecx
  movl $0666, %edx
  int $LINUX_SYSCALL

store_fd_out:
  movl %eax, ST_FD_OUT(%ebp)

## BEGIN MAIN LOOP ##
read_loop_begin:
  movl $SYS_READ, %eax
  movl $STDIN, %ebx
  movl $BUFFER_DATA, %ecx
  movl $BUFFER_SIZE, %edx
  int $LINUX_SYSCALL

  ## EXIT IF WE HAVE REACHED THE END ##
  cmpl $EOF, %eax # read syscall returns 0 if end of file is found
  #cmpl $'0', %ecx
  jle end_loop

continue_read_loop:
  pushl $BUFFER_DATA
  pushl %eax
  call convert_to_upper
  popl %eax
  addl $4, %esp

  ## write ##
  movl %eax, %edx
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  movl $BUFFER_DATA, %ecx
  int $LINUX_SYSCALL

  jmp read_loop_begin

end_loop:
  ## close the files ##
  movl $SYS_CLOSE, %eax
  movl $STDOUT, %ebx
  int $LINUX_SYSCALL

  movl $SYS_CLOSE, %eax
  movl $STDIN, %ebx
  int $LINUX_SYSCALL

  movl $SYS_EXIT, %eax
  movl $0, %ebx
  int $LINUX_SYSCALL

  ## CONSTANTS ##

  .equ LOWERCASE_A, 'a'
  .equ LOWERCASE_Z, 'z'
  .equ UPPER_CONVERSION, 'A' - 'a'

  ## STACK STUFF ##

  .equ ST_BUFFER_LEN, 8
  .equ ST_BUFFER, 12
convert_to_upper:
  pushl %ebp
  movl %esp, %ebp

  ## set up variables ##
  movl ST_BUFFER(%ebp), %eax
  movl ST_BUFFER_LEN(%ebp), %ebx
  movl $0, %edi

  # if buffer with zero len is give #
  cmpl $0, %ebx
  je end_convert_loop

convert_loop:
  # get current byte
  movb (%eax,%edi,1), %cl 

  cmpb $LOWERCASE_A, %cl
  jl next_byte
  cmpb $LOWERCASE_Z, %cl
  jg next_byte

  addb $UPPER_CONVERSION, %cl
  movb %cl, (%eax,%edi,1)
next_byte:
  incl %edi
  cmpl %edi, %ebx
  jne convert_loop

end_convert_loop:
  movl %ebp, %esp
  popl %ebp
  ret

