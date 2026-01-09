# PURPOSE
# this program calculates squares of a given number and returns
# it as a return value

.section .data
.section .text
.globl square
.type square, @function
square:
  pushl %ebp
  movl %esp, %ebp   # set stack pointer to be the new base pointer

  movl 8(%ebp), %eax # move the argument to eax
  imull 8(%ebp)      # multiply argument with eax to square it

  movl %ebp, %esp   # set old base pointer to be the new stack pointer
  popl %ebp         # get the old base pointer and
  ret               # return
