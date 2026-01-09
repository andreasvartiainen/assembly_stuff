#PURPOSE - Given a number, this program computes the
# factorial. For example, the factorial of
# 3 is 3 * 2 * 1, or 6. The factorial of
# 4 is 4 * 3 * 2 * 1, or 24, and so on.
#
#This program shows how to call a function recursively.

.section .data

.section .bss

.section .text
.globl _start
.globl factorial
_start:
  pushl $4        # push argument

  call factorial
  addl $4, %esp   # roll back stack pointer

  movl %eax, %ebx # move result to ebx

  movl $1, %eax   # return code is in ebx
  int $0x80       # interrupt to exit

  .type factorial, @function
factorial:
  pushl %ebp      # save the base pointer
  movl %esp, %ebp # base pointer is now same as stack pointer

  movl 8(%ebp), %eax  # move the argument to eax

  cmpl $1, %eax       # if the argument is 1 return
  je end_factorial
  decl %eax           # decrease eax
  pushl %eax          # push eax to be the argument to factorial
  call factorial      # call factorial
  movl 8(%ebp), %ebx  # get the previous value to ebx

  imull %ebx, %eax    # multiply stuff

end_factorial:
  movl %ebp, %esp
  popl %ebp       # restore base pointer
  ret
