#DarkOS

Custom operating system built from ground up.

Bootloader is a 2 stage boot process.
bootStage1 - Sets up the environment and the data tables for bootStage2.
bootStage2 - Sets the environment suitable for the kernel and loads the kernel into the memory.

##Why make it public?
There are a lot of explanations and tutorials on the internet on how to create the bootloaders and the kernels and the operating systems. However most of them do not explain the building part of the project on a Windows platform. Most of the programs used to assemble and compile are *NIX based. Therefore, I am releasing this as a project and also as a tool/guide on how to actually assemble the project on windows platforms.

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
This script calls other scripts in the _scripts_ directory.

######Assemble.bat explanation
Firstly, it removes the current floppy disk image.
Then it navigates to the _lib_ directory where it will call DD to create a new floppy disk image of size of 1440KB (1.44MB).
After that, using NASM, the ASM files are assembled into _.bin_ files and placed in the _bin_ directory.
Lastly, using DD, the bootStage1.bin is placed in the first sector of the floppy disk image and the bootStage2.bin is placed
in the second sector of the floppy disk image.

######References to the sectors
|Sector   |Explanation   |
|---------|--------------|
|0        |Holds bootStage1.bin file. The bootsector.|
|1        |Holds bootStage2.bin file. The second stage of the bootloader.|
|...      |Other sectors may be filled in later on with the second stage bootloader or the kernel.|

##TODO
 - Use python for the scripts to automate the build. Python is available for most platforms and is easy to install, write and use.
 - Create a better directory system.
 - Make the bootStage2 load the kernel in protected mode.
 - Create a kernel in C.
 - Create a shell to go with the kernel.

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

###Notice
Bear in mind that I am not the best or most skilled programmer. I am a beginner in assembly and C. However, I do know some higher level languages such as Java, Visual Basic .NET and parts of C# and C/C++. Therefore I do realise that the code I produce may not be up to the _industry_ standards.
