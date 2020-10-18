AS=nasm
LD=ld

ASFLAGS=-f elf32 -I"./include"
LDFLAGS=-m elf_i386

all: assembly linking

assembly: main.asm src/io.asm
	$(AS) $(ASFLAGS) main.asm
	$(AS) $(ASFLAGS) src/io.asm

linking: main.o src/io.o src/strlen.o
	$(LD) $(LDFLAGS) main.o src/io.o -o main

clean:
	rm -f main.o src/io.o