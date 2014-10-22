@echo off
echo Creating a floppy image of size 1440K.
cd ../lib
dd if=/dev/zero of="../bin/floppyImage.img" bs=1440k count=1
cd ../
echo Image was saved in bin folder.