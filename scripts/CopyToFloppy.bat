@echo off
set bin=../bin
set bootloader=../bin/bootloader
echo Copying the bootloader to the floppy disk image.
cd ../lib
echo Writing the bootStage1.bin
dd if=%bootloader%/bootStage1.bin of=%bin%/floppyImage.img bs=512 count=1
echo Writing the bootStage2.bin
dd if=%bootloader%/bootStage2.bin of=%bin%/floppyImage.img bs=512 seek=1
echo Finished!