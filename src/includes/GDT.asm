gdt_start:
	gdt_null:
		DD 0x00
		DD 0x00
		
	gdt_code:
		DW 0xFFFF		; Limit (BITS 0-15)
		DW 0x0000		; Base (BITS 0-15)
		DB 0x0000		; Base (BITS 16-23)
		DB 10011010b	; 1st flags, type flags
		DB 11001111b	; 2nd flags, Limit (BITS 16-19)
		DB 0x0000		; Base (BITS 24-31)
		
	gdt_data:
		DW 0xFFFF		; Limit (BITS 0-15)
		DW 0x0000		; Base (BITS 0-15)
		DB 0x0000		; Base (BITS 16-23) 
		DB 10010010b	; 1st flags, type flags
		DB 11001111b	; 2nd flags, Limit (BITS 16-19)
		DB 0x0000		; Base (BITS 24-31)
		
gdt_end:
	gdt_descriptor:
		DW gdt_end - gdt_start - 1
		DD gdt_start

CODE_SEG EQU gdt_code - gdt_start
DATA_SEG EQU gdt_data - gdt_start