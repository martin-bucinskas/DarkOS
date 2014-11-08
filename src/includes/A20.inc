; Returns: 	0 in AX if A20 is disabled
; 			1 in AX if A20 is enabled
check_A20:
	PUSHF
	PUSH DS
	PUSH ES
	PUSH DI
	PUSH SI
	
	CLI
	
	XOR AX, AX
	MOV ES, AX
	
	NOT AX
	MOV DS, AX
	
	MOV DI, 0x0500
	MOV SI, 0x0510
	
	MOV AL, BYTE [ES:DI]
	PUSH AX
	
	MOV AL, BYTE [DS:SI]
	PUSH AX
	
	MOV BYTE [ES:DI], 0x00
	MOV BYTE [DS:SI], 0xFF
	
	CMP BYTE [ES:DI], 0xFF
	
	POP AX
	MOV BYTE [DS:SI], AL
	
	POP AX
	MOV BYTE [ES:DI], AL
	
	MOV AX, 0x00
	JE check_A20_exit
	
	MOV AX, 0x01
	
check_A20_exit:
	POP SI
	POP DI
	POP ES
	POP DS
	POPF
	
	RET
	
enable_A20:
	CLI
	
	CALL .a20Wait
	MOV AL, 0xAD
	OUT 0x64, AL
	
	CALL .a20Wait
	MOV AL, 0xD0
	OUT 0x64, AL
	
	CALL .a20Wait2
	IN AL, 0x60
	PUSH EAX
	
	CALL .a20Wait
	MOV AL, 0xD1
	OUT 0x64, AL
	
	CALL .a20Wait
	POP EAX
	OR AL, 0x02
	OUT 0x60, AL
	
	CALL .a20Wait
	MOV AL, 0xAE
	OUT 0x64, AL
	
	CALL .a20Wait
	STI
	RET
	
	.a20Wait:
		IN AL, 0x64
		TEST AL, 0x02
		JNZ .a20Wait
		RET
	
	.a20Wait2:
		IN AL, 0x64
		TEST AL, 0x01
		JZ .a20Wait2
		RET