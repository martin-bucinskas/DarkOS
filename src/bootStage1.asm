[BITS 16]
[ORG 0x7C00]

start:
	; Updates the segment registers
	CLI				; Disable interrupts
	MOV AX, CS
	MOV DS, AX
	MOV ES, AX
	MOV SS, AX
	STI				; Enable interrupts
	
	PUSH SI
	
	MOV SI, _msg_
	CALL print_new_line
	
	POP SI
	
	CALL disk_load
	
	JMP 0x2000:0x0000
	
	JMP $
	
; >>> Methods <<<
	
disk_load:
	MOV AH, 0x02
	MOV AL, 0x02
	MOV CH, 0x00
	MOV CL, 0x02
	MOV DH, 0x00
	MOV DL, 0x00
	MOV BX, 0x2000
	MOV ES, BX
	MOV BX, 0x0000
	
.readsector:
	INT 0x13
	JC .readsector
	
	MOV AX, 0x2000
	MOV DS, AX
	RET
	
%INCLUDE "Print.asm"
	
; >>> Data <<<

_msg_ DB "Loading the second stage bootloader from floppy disk...", 0x00

TIMES 510 - ($ - $$) DB 0	; Fill empty space with 0
DW 0xAA55					; Bootloader signature