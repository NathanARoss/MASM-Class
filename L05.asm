; Nathan Ross, Alisson Leiva, Brandon Valdes, Patrick Tomaszewski, Jose Soto, Francisco Damian
; 10/11/2018
; L05
; Read a hex char and convert it to binary

include irvine32.inc

CR		EQU	13		;ASCII CHARACTER RETURN
LF		EQU	10		;ASCII LINE FEED

.data
inHexMsg	BYTE	"Enter five hex numbers:", CR, LF, LF, 0
hyphens		BYTE	"--------", CR, LF, 0
hexNum		DWORD	?
hexSum		DWORD	?
numCt		BYTE	?

.code
main		PROC			;Start

		call	Clrscr

		lea	EDX, inHexMsg	; Print "Enter five hex numbers:"
		call	WriteString
		mov	hexSum, 0	; hexSum = 0
		mov	numCt, 0	; numCt = 0

main1:		cmp	numCt, 5	; WHILE numCt < 5
		jnl	main2
		call	inHex		;   Input hexNum
		call	CRLF
		mov	hexNum, EAX
		mov	EAX, hexNum	;   hexSum += hexNum
		add	hexSum, EAX
		inc	numCt		;   numCt++
		jmp	main1
main2:					; ENDWHILE

		lea	EDX, hyphens	; Print "--------"
		call	WriteString
		mov	EAX, hexSum	; Print hexSum
		call	outHex

		call	CRLF
		exit			;Stop
main		ENDP

;*******************
; Input a hex number
; Input: none
; Output: hex number returned in EAX
;*******************

;EBX will be used to create number and then moved to EAX

inHex		PROC			; Enter

		mov	EBX, 0		; hexNum = 0
		call	ReadChar	; Input char
inHex1:		cmp	AL, CR		; WHILE char <> CR
		je	inHex2
		call	WriteChar	

		cmp	AL, '9'		;   hexDig = cvt2bin(char)
		ja	inHex3
		sub	AL, '0'
		jmp	inHex4
inHex3:		and	AL, 11011111b	;   hexDig = TO_UPPER(hexDig)
		sub	AL, '0' + 7
inHex4:		
		movzx	EAX, AL		;   hexNum = hexNum * 16 + hexDig
		shl	EBX, 4
		add	EBX, EAX
		call	ReadChar	;   Input char
		jmp	inHex1
inHex2:					; ENDWHILE

; move EBX to EAX
		mov	EAX, EBX
		ret			; Exit
inHex		ENDP

;*******************
; Print hex number
; Input: value to print in EAX
; Output: none
;*******************

;The hexNum is moved to EBX so AL can be used to output hex character
;ECX is used for digCt

outHex		PROC			; Enter

;save EAX in EBX
		mov	EBX, EAX
		mov	ECX, 0		; digCt = 0
outHex2:	cmp	ECX, 8		; WHILE digCt < 8
		jnl	outHex1
		mov	EAX, EBX	;   Print LeftMostHex(hexSum)
		shr	EAX, 28
		cmp	AL, 9
		jg	outHex3
		add	AL, '0'
		jmp	outHex4
outHex3:	add	AL, '0' + 7
outHex4:	call	WriteChar
		shl	EBX, 4		;   hexNum *= 16
		inc	ECX		;   digCt++
		jmp	outHex2
outHex1:				; ENDWHILE

		ret			; Exit
outHex		ENDP

		END	main