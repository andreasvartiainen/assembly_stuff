## system calls for useful stuff ##
.equ SYS_OPEN, 5
.equ SYS_WRITE, 4
.equ SYS_READ, 3
.equ SYS_CLOSE, 6
.equ SYS_EXIT, 1

## file read write flags ##
.equ O_RDONLY, 0
.equ O_CREAT_WRONLY_TRUNC, 03101

## file descriptors for standard in/out
.equ STDIN, 0
.equ STDOUT, 1
.equ STDERR, 2
.equ EOF, 0 ## end of file marker ##

## interrupts ##
.equ LINUX_SYSCALL, 0x80
