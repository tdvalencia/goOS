
all: os-image.bin clean

kernel.bin: kernel_entry.o kernel.o
	ld -o $@ -Ttext 0x1000 $^ --oformat binary -e main

kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf64 -o $@

kernel.o: kernel/kernel.c
	gcc -ffreestanding -c $< -o $@

boot_sect.bin: asm/boot_sect.asm
	nasm $< -f bin -o $@

os-image.bin: boot_sect.bin kernel.bin
	cat $^ > $@

clean:
	rm *.o
