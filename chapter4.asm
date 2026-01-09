.section .data
  exit_value: .long 42 # this is an address so we can't access it with $

.section .bss

.section .text
.globl _start
_start:
  pushl $3      # push 3 to the top of the stack second argument
  pushl $3      # push 2 to the top of the stack first argument
  call power    # call the function
  addl $8, %esp # roll back the stack pointer 2 * 4 (3, 2)

  #movl %eax, %ebx
  pushl %eax    # save the first answer before calling the next function

  pushl $2
  pushl $2
  call power
  addl $8, %esp

  #movl %eax, %ecx
  #popl %ebx     # get the first answer the second is now in eax
  pushl %eax

  pushl $3
  pushl $2
  call power
  addl $8, %esp

  #popl %edx     # put the last value in the ecx current is in eax
  pushl %eax

  addl 4(%esp), %ebx
  addl 8(%esp), %ebx
  addl 12(%esp), %ebx

  addl $12, %esp # remove all the local variables

  #addl %eax, %ebx # add the answers together
  #addl %ecx, %ebx # add the answers together

  # ebx will be the exit value
  movl $1, %eax
  int $0x80

  .type power, @function
power:
  pushl %ebp      # save old base pointer
  movl %esp, %ebp # make stack pointer the base pointer
  subl $4, %esp   # get room for our local storage

  movl 8(%ebp), %ebx  #put first argument in %eax
  movl 12(%ebp), %ecx #put second argument in %ecx

  movl %ebx, -4(%ebp) #store current result

power_loop_start:
  cmpl $1, %ecx       #if the power is 1, we are done
  je end_power
  movl -4(%ebp), %eax # move the current result into %eax
  imull %ebx, %eax    # multiply the current result by the base number

  movl %eax, -4(%ebp) #store the current result

  decl %ecx           #decrease the power
  jmp power_loop_start#jump to start of the loop

end_power:
  movl -4(%ebp), %eax # move the current result to the eax
  # movl %ebp, %esp   # restore the stack pointer by setting the base pointer to it
                      # which is the base of our current function
  addl $4, %esp       # restoring the stack pointer by adding 4 (the amount allocated)
  popl %ebp           # restore the old base pointer
  ret

# esp is the stack register
# every time whe use pushl the stack register
# gets subtracted by 4

# removing from the stack happens with popl
# it puts the top value in whatever register
# specified and adds 4 to the register

# esp can be accessed indirectly
# movl (%esp), %eax ; moves whatever is at the top of the stack to eax
# movl %esp, %eax   ; moves the pointer to the data that is at the top to eax
# parenthesis cause indirect addressing mode

# if we want to access the value directly below top we can do:
# movl 4(%esp), %eax ; base pointer addressing mode

# subl $8, %esp ; stack pointer can be moved with sub to reserve space

# returning from function
# movl %ebp, %esp ; move the base pointer to the top of the stack
# popl %ebp       ; assing the top of the stack to the base pointer
# ret             ; return
