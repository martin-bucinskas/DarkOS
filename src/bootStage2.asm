[BITS 16]

_msg_ DB "...", 0x00
_msg2_ DB ">>> Works! <<<", 0x00

start:
	; Updates the segment registers
	CLI				; Disable interrupts
	MOV AX, CS
	MOV DS, AX
	MOV ES, AX
	MOV SS, AX
	STI				; Enable interrupts
	
	MOV SI, _msg_
	CALL println
	MOV SI, _msg2_
	CALL println
	JP hang
	
; >>> Methods <<<

print:
	LODSB
	OR AL, AL		; Clear AL register
	JZ generalRet
	MOV AH, 0x0E	; Write char in TTY mode
	INT 0x10		; Video services
	JMP print
	
generalRet:
	ret

println:
	CALL print
	MOV AL, 0x00	; Null terminator
	STOSB
	MOV AH, 0x0E
	MOV AL, 0x0D	; Read graphics pixel
	INT 0x10
	MOV AL, 0x0A	; Write char at cursor
	INT 0x10
	RET
	
hang:
	CLI				; Clear interrupts
	HLT				; Halt so the CPU doesn't get munched up