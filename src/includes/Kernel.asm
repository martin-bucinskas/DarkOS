[BITS 32]

init_protected_mode:
	MOV AX, DATA_SEG
	MOV DS, AX
	MOV SS, AX
	MOV ES, AX
	MOV FS, AX
	MOV GS, AX
		
	MOV EBP, 0x90000
	MOV ESP, EBP
		
	CALL begin_protected_mode
		
begin_protected_mode:
	MOV ESI, MSG_PROT_MODE
	CALL sprint
	
	JMP $
	
%INCLUDE "Print32.asm"
	
MSG_PROT_MODE	DB	"32 Bit Mode entered.", 0x00