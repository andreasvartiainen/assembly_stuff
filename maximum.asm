.section .data
  array: .long 251, 150, 50, 220, 10, 100, 150, 250, 125, 30, 11, 255
  array_len = . - array

.section .bss
.section .text
.globl _start
_start:
  leal array, %ecx
  pushl $array_len
  pushl %ecx      # push the address of the array
  call max
  addl $4, %esp   # reset the stack

  movl %eax, %ebx
  
  movl $1, %eax
  int $0x80

# stores the max of an array in eax
.type max, @function
max:
  pushl %ebp
  movl %esp, %ebp     # push old ebp and make esp the new ebp
  subl $4, %esp       # make space for local variables 
  subl $4, %esp

  movl 8(%ebp), %eax  # move the argument to eax
  movl %eax, -4(%ebp) # move the argument to local variable

  movl 12(%ebp), %eax # move the length of the list to eax
  movl $0, %edx       # set edx to 0
  movl $4, %ecx       # set ecx to 4 as a divider

  divl %ecx           # divide edx:eax

  movl %eax, -8(%ebp) # index here I guess

  xor %eax, %eax      # empty eax
  movl -4(%ebp), %ebx # put array address here
  leal -8(%ebp), %ecx # put array length here
loop_start:
  cmpl $0, (%ecx)     # check if it is zero
  je loop_end         # jump if it is to the loop_end

  cmpl (%ebx), %eax   # compare the array item with highest (eax)
  jge next            # jump to next if eax is bigger

  movl (%ebx), %eax   # otherwise set current array item in eax

next:
  addl $4, %ebx       # jump forward in the array
  decl (%ecx)         # decrement index
  jmp loop_start      # go back to start of the loop

loop_end:

  movl %ebp, %esp # reset esp and pop the old esb
  popl %ebp
  ret
