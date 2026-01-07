#PURPOSE: Simple program that exits and returns a status code back to linux kernel
#

#INPUT:   none
#

#OUTPUT:  returns a status code
#

#VARIABLES:
#           %eax holds the system call number
#           %ebx holds the return status

.globl _start

.section .data
  values: .long 1, 2, 3, 1, 100, 0

  string: .ascii "this is my first at&t assembly program!\n"
  string_len = . - string

  STDIN = 0
  STDOUT = 1

.section .text
_start:
  movl $4, %eax
  movl $STDOUT, %ebx
  movl $string, %ecx
  movl $string_len, %edx
  int $0x80

  movl $0, %edi
  movl values(,%edi,4), %eax
  movl %eax, %ebx

  loop:
  cmpl $0, %eax
  je end
  incl %edi
  movl values(,%edi,4), %eax
  cmpl %ebx, %eax
  jle loop

  movl %eax, %ebx

  jmp loop

end:

  movl $1, %eax
  int $0x80

# questions
# what does it mean if a line starts with a "#" character
#     it means the line is a comment
# what is the difference between an assembly language file and an object code file
#     the object file is machine language, they are somewhat the same thing
# what does the linker do
#     combines compiled code and libraries to one executable file
# how do you check the result status code of the last program you ran?
#     > $?
# what is the difference between movl $1, %eax and movl 1, %eax
#     former puts one in the eax register
#     latter tries to put value in address 1 to the eax register
# which register holds the system call number
#     eax
# what are indexes used for
#     for accessing elements in memory
# why do indexes usually start at 0
#     because that is the programmer way idk
# If I issued the command movl data_items(,%edi,4), %eax and
# data_items was address 3634 and %edi held the value 13, what address would
# you be using to move into %eax?
#     movl data_items(,%edi,4), %eax
#     4 * 13
# List general purpose registers
  #eax
  #ebx
  #ecx
  #edx
  #esi
  #edi
  #ebp
  #esp
  #r8d - r15d
# what is the difference between movl and movb
#     movl moves 4 bytes
#     movb moves 1 byte
# what is flow control
#     jmp and stuff
# what does conditional jump do
#     it jumps conditionally
