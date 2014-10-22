@echo off
echo Deleting current floppy image.
echo.
cd bin
del floppyImage.img
cd ../scripts
echo.
echo Creating a new floppy image.
echo.
call CreateFloppyImage.bat
echo.
echo Assembling the bootloader.
echo.
cd scripts
call AssembleBootloader.bat
echo.
echo Copying the bootloader to floppy.
echo.
cd ../scripts
call CopyToFloppy.bat
echo.
echo Done!
pause