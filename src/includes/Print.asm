; Prints the contents of SI register
print:
	LODSB
	OR AL, AL
	JZ return
	MOV AH, 0x0E
	INT 0x10
	JMP print
	
; Prints the contents of SI register on a new line
print_new_line:
	CALL print
	MOV AL, 0x0
	STOSB
	MOV AH, 0x0E
	MOV AL, 0x0D
	INT 0x10
	MOV AL, 0x0A
	INT 0x10
	JMP return
	
print_err:
	; TODO add red bg and black fg
	
	CALL print_new_line
	CALL return
	
; Used as a return function
return:
	MOV AH, 0x03
	MOV BH, 0x01
	INT 0x10
	RET
	