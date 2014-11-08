start:
	MOV SI, LOADED_MSG
	CALL print_new_line
	
	; Enable A20 line if disabled
	CALL A20_LINE

;TODO >> FIX KERNEL LOADING INTO MEMORY <<
	MOV SI, LOADING_KERNEL
	CALL print_new_line
	CALL loadKernel
	
	; Set up basic stack
	MOV AX, 0x0100
	MOV SS, AX
	MOV SP, 0x0200
	
	; Load GDT
	CLI
	LGDT[GDTR]
	
	; Enable protected mode
	MOV EAX, CR0
	OR AL, 0x01
	MOV CR0, EAX
	
	;JMP 0x08:0x9000
	
	JMP $
	
; >>> Methods <<<

A20_LINE:
	CALL check_A20
	CMP AX, 0x00
	JE .skip_enable_A20
	CMP AX, 0x01
	JE .enable_A20
	
	.enable_A20:
		MOV SI, A20_DISABLED
		CALL print_new_line
		
		CALL enable_A20
		
		MOV SI, A20_ENABLED
		CALL print_new_line
		
		RET
		
	.skip_enable_A20
		MOV SI, A20_ALREADY_ENABLED
		CALL print_new_line
		RET
		
%INCLUDE "KernelLoader.inc"
%INCLUDE "Print.inc"
%INCLUDE "Debug.inc"
%INCLUDE "A20.inc"
%INCLUDE "GDT.inc"
	
LOADED_MSG			DB	"Second Stage Loaded.", 0x00
A20_ALREADY_ENABLED	DB	"A20 is already enabled.", 0x00
A20_DISABLED		DB	"A20 is disabled. Attempting to enable it.", 0x00
A20_ENABLED			DB 	"A20 enabled.", 0x00
LOADING_KERNEL		DB	"Loading the kernel into memory.", 0x00
GDTR:
	NULL_SEL 
	DD 0
	DD 0
	GDTsize DW 0x10	; Limit
	GDTbase	DD 0x50	; Base address