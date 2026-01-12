.section .data
  newline:
    .ascii "\n"
.section .text
.globl _start
.equ ARGC_0, 0
.equ ARGV_0, 4
.equ ARGV_1, 8
_start:
  movl %esp, %ebp
  
  # check if we have enough arguments
  cmpl $1, ARGC_0(%ebp)
  jle quit

  pushl ARGV_1(%ebp)
  call char_count
  addl $4, %esp

  # length of the argument string
  movl %eax, %edx 

  movl $4, %eax
  movl $1, %ebx
  movl ARGV_1(%ebp), %ecx
  int $0x80

  pushl $1 # file descriptor for stdout
  call print_newline
  addl $4, %esp
  
quit:
  movl $1, %eax
  movl $0, %ebx
  int $0x80

.type char_count, @function
char_count:
  pushl %ebp        #save base pointer
  movl %esp, %ebp   #set stack pointer as base pointer
  pushl %ebx        #-4(%ebp)

  movl 8(%ebp), %ebx# 4(%ebp) = address to base pointer --- 8(%ebp) = <argument>
  xor %eax, %eax
loop:
  movb (%ebx), %cl
  cmpb $0, %cl
  je end

  incl %ebx
  incl %eax
  jmp loop

end:
  popl %ebx
  popl %ebp
  ret

.equ FILE_DES, 8
.type print_newline, @function
print_newline:
  pushl %ebp
  movl %esp, %ebp

  movl $4, %eax
  movl FILE_DES(%ebp), %ebx
  movl $newline, %ecx
  movl $1, %edx
  int $0x80

  movl %ebp, %esp
  popl %ebp
  ret
