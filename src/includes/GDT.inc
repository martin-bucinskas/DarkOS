gdtr	DW	0
		DD	0
		
setGDT:
	XOR EAX, EAX
	MOV AX, DS
	SHL EAX, 0x04
	ADD EAX, "GDT"
	MOV [gdtr + 0x02], EAX
	MOV EAX, "GDT_end"
	SUB EAX, "GDT"
	MOV [gdtr], AX
	LGDT [gdtr]
	RET