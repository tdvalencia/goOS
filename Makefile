kernel	:= bin/kernel.bin
boot	:= bin/boot_sect.bin
image	:= boot.iso

DRIVERS	:= $(wildcard kernel/*.c)
OBJ		:= $(pathsubst src/%.c, %.o, $(C_SRC))

all: $(image) clean_obj

kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf64 -o $@

kernel.o: kernel/kernel.c
	gcc -ffreestanding -c $< -o $@

low_level.o: drivers/low_level.c
	gcc -ffreestanding -c $^ -o $@

$(kernel): kernel_entry.o kernel.o low_level.o 	# linux 
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

# windows:

# ld -T NUL -o kernel.tmp -Ttext 0x1000 $^
# objcopy -O binary -j .text  kernel.tmp $@
# rm kernel.tmp

$(boot): boot/boot_sect.asm
	nasm $< -f bin -o $@

$(image): $(boot) $(kernel)
	cat $^ > $@

clean_obj:
	rm *.o

clean:
	rm *.iso
