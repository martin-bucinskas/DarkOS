@echo off
echo This will assemble the bootloader files into 2 binary files.
echo bootStage1.bin
echo bootStage2.bin
echo
cd ../lib
echo Attempting to assemble bootStage1...
nasm -f bin ../src/bootStage1.asm -o ../bin/bootloader/bootStage1.bin
echo Attempting to assemble bootStage2...
nasm -f bin ../src/bootStage2.asm -o ../bin/bootloader/bootStage2.bin
echo Check if the file size does not equal zero.
echo Should be done!