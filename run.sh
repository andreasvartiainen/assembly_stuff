#!/bin/bash

# nasm -felf32 -g -F dwarf $1.asm && ld -m elf_i386 $1.o -o $1.out && ./$1.out
as $1.asm -o $1.o && ld $1.o -o $1.out && ./$1.out
echo $?
