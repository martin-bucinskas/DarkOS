[BITS 16]
[ORG 0]
JMP 0x7C0:start

; >>> Variables <<<

_msg_ DB "Calling the secondary bootloader...", 0x00
_errRead_ DB ">>> Error whilst reading the secondary bootloader <<<", 0x00

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
	CALL reset			; Reset the floppy drive
	CALL read			; Read in the program
	JMP 0x0000:0x201	; Jump to the read program
	MOV SI, _msg_
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
	
reset:				; Reset the floppy drive
	MOV AX, 0		; Reset disk drives
	MOV DL, 0		; Drive 0 (0 = A drive)
	INT 0x13		; Low level disk services
	JC reset		; Jump if error
	RET
	
read:				; Read the floppy drive
	XOR AH, AH
	INT 0x13
	MOV BX, 0x201	; ES:BX = 2000:0000
	MOV ES, BX
	MOV BX, 0		; Offset
	
	MOV AH, 2		; Load disk data to ES:BX
	MOV AL, 5		; Load 5 sectors (0xA00 bytes = 2560 bytes)
	MOV CH, 0		; Cylinder 0
	MOV CL, 2		; Sector 2
	MOV DH, 0		; Head 0
	MOV DL, 0		; Drive A
	INT 0x13		; Read
	
	JC errRead		; Print error message
	RET
	
errRead:
	MOV SI, _errRead_
	CALL println
	RET
	
hang:
	CLI				; Clear interrupts
	HLT				; Halt so the CPU doesn't get munched up
	
TIMES 510 - ($ - $$) DB 0	; Fill empty space with 0
DW 0xAA55					; Bootloader signature