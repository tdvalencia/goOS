
all: clean boot_sect.bin

boot_sect.bin:
	nasm asm/boot_sect.asm -f bin -o $@

clean:
	rm boot_sect.bin