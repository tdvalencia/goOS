image	:= bin/os-image.bin
kernel	:= bin/kernel.bin
boot	:= bin/boot_sect.bin

all: $(image) clean

kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf64 -o $@

kernel.o: kernel/kernel.c
	gcc -ffreestanding -c $< -o $@

$(kernel): kernel_entry.o kernel.o
	ld -o $@ -Ttext 0x1000 $^ --oformat binary -e main

$(boot): asm/boot_sect.asm
	nasm $< -f bin -o $@

$(image): $(boot) $(kernel)
	cat $^ > $@

clean:
	rm *.o
