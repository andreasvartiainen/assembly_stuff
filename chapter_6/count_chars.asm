#PURPOSE: Count the characters until a null byte is reached.
#
#INPUT: The address of the character string
#
#OUTPUT: Returns the count in %eax
#
#PROCESS:
# Registers used:
# %ecx - character count
# %al - current character
# %edx - current character address

.type count_chars, @function
.globl count_chars
.equ ST_STRING_START_ADDRESS, 8 # value set before the function call
count_chars:
  pushl %ebp
  movl %esp, %ebp

  # counter from 0
  movl $0, %ecx

  # starting address of data
  movl ST_STRING_START_ADDRESS(%ebp), %edx

count_loop_begin:
  movb (%edx), %al  # get the current character and but it in 8bit register
  cmpb $0, %al      # check if it is a null
  je count_loop_end # if it is, we jump to end

  incl %ecx         # increment the index counter
  incl %edx         # increment the pointer to char array

  jmp count_loop_begin

count_loop_end:
  movl %ecx, %eax   # move the counter to eax since we want to return it to caller

  popl %ebp         # recover the base pointer
  ret
