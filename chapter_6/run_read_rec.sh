as --32 read_record.asm -o read_record.o
as --32 count_chars.asm -o count_chars.o
as --32 write_newline.asm -o write_newline.o
as --32 read_records.asm -o read_records.o
ld -m elf_i386 read_records.o read_record.o write_newline.o count_chars.o -o read_records
./read_records
