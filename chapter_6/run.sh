as --32 write_records.asm -o write_records.o && as --32 write_record.asm -o write_record.o && ld -m elf_i386 write_records.o write_record.o -o write_records && ./write_records
