.include "linux.asm" # include helpers
.include "record_def.asm"

.section .data
  filename:
    .ascii "file.dat\0"

  rec1:
    .ascii "Tomi\0"
    .rept 35
    .byte 0
    .endr
    
    .ascii "Vartiainen\0"
    .rept 29
    .byte 0
    .endr

    .ascii "This is not my address haha 02525 biibiboobo\0"
    .rept 187
    .byte 0
    .endr

    .long 27

.equ ARGV_1, 4
.equ ST_OUT_FILEDES, -4
.equ ST_COUNTER, -8
.section .text
.globl _start
_start:
  movl %esp, %ebp

  # make space for local variables
  subl $8, %esp

  # open file for writing
  movl $SYS_OPEN, %eax
  movl $filename, %ebx
  movl $O_CREAT_WRONLY_TRUNC, %ecx
  movl $0666, %edx
  int $LINUX_SYSCALL

  # save the file descriptor
  movl %eax, ST_OUT_FILEDES(%ebp)

  # set counter to 0
  movl $0, ST_COUNTER(%ebp)
loop:
  cmpl $30, ST_COUNTER(%ebp)
  je end

  # write to the file opened earlier
  movl $SYS_WRITE, %eax
  movl ST_OUT_FILEDES(%ebp), %ebx
  movl $rec1, %ecx
  movl $R_SIZE, %edx
  int $LINUX_SYSCALL

  # increment counter
  incl ST_COUNTER(%ebp)
  jmp loop

end:
  # close the file opened earlier
  movl $SYS_CLOSE, %eax
  movl ST_OUT_FILEDES(%ebp), %ebx
  int $LINUX_SYSCALL

  # restore stack pointer
  movl %ebp, %esp
  
  # exit
  movl $SYS_EXIT, %eax
  movl $0, %ebx
  int $LINUX_SYSCALL
