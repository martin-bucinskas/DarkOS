#DarkOS

Custom operating system built from ground up.

Bootloader is a 2 stage boot process.
bootStage1 - Sets up the environment and the data tables for bootStage2.
bootStage2 - Sets the environment suitable for the kernel and loads the kernel into the memory.

##How does it work?
Currently, the scripts do not assemble everything. They only assemble bootStage1.asm and bootStage2.asm.
This will change.

Here is how everything brakes down.

|Directory |Explanation  |
|----------|-------------|
|src       |Contains all the source files.|
|bin       |Contains the assembled ASM files and the floppy image.|
|lib       |Contains the libraries and programs used for compiling and copying files.|
|scripts   |Contains all the scripts used for automation and building of the project.|

######Assemble.bat
Assemble.bat is a build tool which calls different scripts to build the project into a final floppy image which can be used for
testing and distribution.
This script calls other scripts in the ~scripts~ directory.

######Assemble.bat explanation
Firstly, it removes the current floppy disk image.
Then it navigates to the ~lib~ directory where it will call DD to create a new floppy disk image of size of 1440KB (1.44MB).
After that, using NASM, the ASM files are assembled into ~.bin~ files and placed in the ~bin~ directory.
Lastly, using DD, the bootStage1.bin is placed in the first sector of the floppy disk image and the bootStage2.bin is placed
in the second sector of the floppy disk image.

######References to the sectors
|Sector   |Explanation   |
|---------|--------------|
|0        |Holds bootStage1.bin file. The bootsector.|
|1        |Holds bootStage2.bin file. The second stage of the bootloader.|
|...      |Other sectors may be filled in later on with the second stage bootloader or the kernel.|

##Information about the build

This project is currently developed under Windows operating system. This means that external programs and libraries are used
to compile and assemble the project.

###DD
Allows flexible copying of data under win32 environment.

You can get DD at:

http://www.chrysocome.net/dd

###NASM
The famous Netwide Assembler.
Used to assemble asm files.

You can get NASM at:

http://www.nasm.us/pub/nasm/releasebuilds/?C=M;O=D
