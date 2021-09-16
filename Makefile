kernel	:= bin/kernel.bin
boot	:= bin/boot_sect.bin
image	:= boot.iso

C_SRC	:= $(wildcard drivers/*.c kernel/*.c)
OBJ		:= $(C_SRC:.c=.o)

all: $(image)

%.o: %.c
	i686-elf-gcc -g -ffreestanding -c $^ -o $@

%.o: %.asm
	nasm $^ -f elf -o $@

%.bin: %.asm
	nasm $^ -f bin -o $@

$(kernel): kernel/kernel_entry.o $(OBJ) # kernel.o	# linux: 
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

$(boot): boot/boot_sect.asm
	nasm $^ -f bin -o $@

$(image): $(boot) $(kernel)
	cat $^ > $@

clean:
	rm ./**/*.bin
	rm ./**/*.o
	rm boot.iso
