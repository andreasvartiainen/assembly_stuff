.include "preample.asm"
.include "record_def.asm"

.section .data
  #Constant data of the records we want to write
  #Each text data item is padded to the proper
  #length with null (i.e. 0) bytes.
  #.rept is used to pad each item. .rept tells
  #the assembler to repeat the section between
  #.rept and .endr the number of times specified.
  #This is used in this program to add extra null
  #characters at the end of each field to fill
  #it up
  record1:
    .ascii "Fredrick\0"
    .rept 31 # padding to 40 bytes
    .byte 0  # what we will use to padd
    .endr    # end of padding segment ( .rept -> .endr )

    .ascii "Bartlett\0"
    .rept 31 # padding to 40 bytes
    .byte 0
    .endr

    .ascii "4242 S Prairie\nTulsa, OK 55555\0"
    .rept 209 # padding to 240 bytes
    .byte 0
    .endr
    .long 45

  record2:
    .ascii "Marilyn\0"
    .rept 32 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "Taylor\0"
    .rept 33 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "2224 S Johannan St\nChicago, IL 12345\0"
    .rept 203 #Padding to 240 bytes
    .byte 0
    .endr

    .long 29

  record3:
    .ascii "Derrick\0"
    .rept 32 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "McIntire\0"
    .rept 31 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "500 W Oakland\nSan Diego, CA 54321\0"
    .rept 206 #Padding to 240 bytes
    .byte 0
    .endr

    .long 36

  filename:
    .ascii "test.dat\0"
    .equ ST_FILE_DESCRIPTOR, -4
.globl _start
_start:
  movl  %esp, %ebp
  subl  $4, %esp # make space for a local variable

  #open the file
  movl  $SYS_OPEN, %eax
  movl  $filename, %ebx
  movl  $0101, %ecx # create if doesn't exit and open for writing
  movl  $0666, %edx
  int   $SYS_INT

  # store the file descriptor in local variable -4(%ebp)
  movl %eax, ST_FILE_DESCRIPTOR(%ebp)

  #write the first record
  pushl ST_FILE_DESCRIPTOR(%ebp)
  pushl $record1
  call write_record
  addl $8, %esp

  pushl ST_FILE_DESCRIPTOR(%ebp)
  pushl $record2
  call write_record
  addl $8, %esp

  #exit the program
  movl $SYS_EXIT, %eax
  movl $EXIT_VALUE, %ebx
  int $SYS_INT

