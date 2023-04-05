kernel	:= bin/kernel.bin
boot	:= bin/boot_sect.bin
image	:= boot.iso

C_SRC	:= $(wildcard drivers/*.c kernel/*.c cpu/*.c)
OBJ		:= $(C_SRC:.c=.o cpu/interrupt.o)

all: $(image)

%.o: %.c
	i686-elf-gcc -g -ffreestanding -c $^ -o $@

%.o: %.asm
	nasm $^ -f elf -o $@

%.bin: %.asm
	nasm $^ -f bin -o $@

$(kernel): kernel/kernel_entry.o $(OBJ) # kernel.o	# linux: 
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat=binary

$(boot): boot/boot_sect.asm
	nasm $^ -f bin -o $@ -Ttext 0x7C00 $^ --oformat=binary

$(image): $(boot) $(kernel)
	# cat $^ > $@
	dd if=/dev/zero of=boot.iso bs=512 count=2880
	dd if=./$(boot) of=boot.iso conv=notrunc bs=512 seek=0 count=1
	dd if=./$(kernel) of=boot.iso conv=notrunc bs=512 seek=1 count=128

clean:
	rm ./**/*.bin
	rm ./**/*.o
	rm boot.iso
