DarkOS
======

Custom operating system built from ground up.

Bootloader is a 2 stage boot process.
bootStage1 - Sets up the environment and the data tables for bootStage2.
bootStage2 - Sets the environment suitable for the kernel and loads the kernel into the memory.

Information about the build
=====

This project is currently developed under Windows operating system. This means that external programs and libraries are used
to compile and assemble the project.

DD
==
Allows flexible copying of data under win32 environment.

You can get DD at:

http://www.chrysocome.net/dd

NASM
==
The famous Netwide Assembler.
Used to assemble asm files.

You can get NASM at:

http://www.nasm.us/pub/nasm/releasebuilds/?C=M;O=D
