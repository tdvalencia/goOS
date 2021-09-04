kernel	:= bin/kernel.bin
boot	:= bin/boot_sect.bin
image	:= boot.iso

C_SRC		:= $(wildcard drivers/*.c kernel/*.c)
OBJ			:= $(C_SRC:.c=.o)

all: $(image) clean_obj

# kernel_entry.o: kernel/kernel_entry.asm
# 	nasm $< -f win64 -o $@

# kernel.o: kernel/kernel.c
# 	gcc -ffreestanding -c $^ -o $@

%.o: %.c
	gcc -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf64 -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

$(kernel): kernel/kernel_entry.o $(OBJ) # kernel.o	# linux: 
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

$(boot): boot/boot_sect.asm
	nasm $< -f bin -o $@

$(image): $(boot) $(kernel)
	cat $^ > $@

clean_obj:
	rm ./**/*.o

clean:
	rm *.iso
