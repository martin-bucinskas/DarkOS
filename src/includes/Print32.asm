dochar:
    CALL cprint              ; print one character
sprint:
    MOV EAX, [ESI]          ; string char to AL
    LEA ESI, [ESI+1]
    CMP AL, 0
    JNE dochar               ; else, we're done
    ADD BYTE [ypos], 1       ; down one row
    MOV BYTE [xpos], 0       ; back to left
    RET
 
cprint:
    MOV AH, 0x0F             ; attrib = white on BLack
    MOV ECX, EAX             ; save char/attribute
    MOVZX EAX, BYTE [ypos]
    MOV EDX, 160             ; 2 BYTEs (char/attrib)
    MUL EDX                  ; for 80 columns
    MOVZX EBX, BYTE [xpos]
    SHL EBX, 1               ; times 2 to skip attrib
 
    MOV EDI, 0xb8000         ; start of video memory
    ADD EDI, EAX             ; ADD y offset
    ADD EDI, EBX             ; ADD x offset
 
    MOV EAX, ECX             ; restore char/attribute
    MOV WORD [DS:EDI], AX
    ADD BYTE [xpos], 1       ; advance to right
 
    RET
 
;------------------------------------
 
printreg32:
    MOV EDI, outstr32
    MOV EAX, [reg32]
    MOV ESI, hexstr
    MOV ECX, 8               ; eight nibBLes
 
hexloop:
    ROL EAX, 4               ; leftmost will
    MOV EBX, EAX             ; become rightmost
    AND EBX, 0x0f ;
    MOV BL, [ESI + EBX]      ; index into hexstr
    MOV [EDI], BL
    INC EDI
    DEC ECX
    JNZ hexloop
 
    MOV ESI, outstr32
    CALL sprint
 
    RET
 
;------------------------------------
 
xpos db 0
ypos db 0
hexstr db '0123456789ABCDEF'
outstr32 db '00000000', 0    ; register vALue
reg32 dd 0                   ; pass vALues to printreg32