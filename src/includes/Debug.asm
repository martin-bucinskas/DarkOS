out_str		RESB 5
hex_table	DB "0123456789ABCDEF", 0x0
hex_prefix	DB "0x", 0x0

print_hex:
	MOV DI, out_str
	MOV AX, [SI]
	MOV SI, hex_table
	MOV CX, 0x04
	
.hex:
	ROL AX, 0x04
	MOV BX, AX
	AND BX, 0x0F
	MOV BL, [SI + BX]
	MOV [DI], BL
	
	INC DI
	DEC CX
	JNZ .hex
	
	MOV [out_str + 0x04], DWORD 0x0
	MOV SI, hex_prefix
	CALL print
	MOV AH, 0x02
	MOV BH, 0x01
	MOV DH, DH
	ADD DL, 0x02
	INT 0x10
	MOV SI, out_str
	CALL print_new_line
	RET
	