as --32 modify.asm -o modify.o
as --32 count_chars.asm -o count_chars.o
as --32 write_record.asm -o write_record.o
as --32 write_newline.asm -o write_newline.o
as --32 read_records.asm -o read_records.o
ld -m elf_i386 modify.o read_record.o write_newline.o write_record.o count_chars.o -o modify
./modify
