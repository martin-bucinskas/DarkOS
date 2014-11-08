; Loads the kernel to memory 0x9000:0x0000
; Kernel needs to be in sector 3
loadKernel:
	MOV AH, 0x02
	MOV AL, 0x0F
	MOV CH, 0x00
	MOV CL, 0x04
	MOV DH, 0x00
	MOV DL, 0x00
	MOV BX, 0x9000
	MOV ES, BX
	MOV BX, 0x0000
	INT 0x13
	
	MOV SI, KERNEL_LOADED
	CALL print_new_line
	
	RET
	
KERNEL_LOADED	DB	"The kernel was loaded into 0x9000:0x0000", 0x00