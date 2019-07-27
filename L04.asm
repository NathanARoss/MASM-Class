; Nathan Ross, Alisson Leiva, Brandon Valdes, Brittany Castaneda, Patrick Tomaszewski, Jose Soto, Francisco Damian
; 9/27/2018
; L04
; Read a hex char and convert it to binary

include irvine32.inc

CR		EQU	13			;ASCII CHARACTER RETURN
LF		EQU	10			;ASCII LINE FEED CHARACTER

.data
firstMsg	BYTE	"Enter first hex digit: ", 0
secondMsg	BYTE	"Enter second hex digit: ", 0
hexSumMsg	BYTE	"Hex Sum = ", 0
hexDig1		BYTE	?
hexDig2		BYTE	?
hexSum		BYTE	?

.code
main		PROC				;Start
	
		call	Clrscr

		lea	EDX, firstMsg		;print "Enter first hex digit: "
		call	WriteString

		call	inHex			;Input hexDig1
		mov	hexDig1, AL
		call	CRLF

		lea	EDX, secondMsg		;Print "Enter second hex digit: "
		call	WriteString

		call	inHex			;Input hexDig2
		mov	hexDig2, AL
		call	CRLF

		mov	AL, hexDig1		;hexSum = hexDig1 + hexDig2
		add	AL, hexDig2
		mov	hexSum, AL

		lea	EDX, hexSumMsg		;Print "Hex Sum = ", hexSum
		call	WriteString
		movzx	EAX, hexSum
		call	outHex
		call	CRLF

		call		CRLF				;newline for neatness
		exit				;Stop
main		ENDP

;*******************
; Input hex digit
; Input: none
; Output: hex digit returned in AL
;*******************

inHex		PROC					;Enter
		call	ReadChar			; input hexDigit
		call	WriteChar
		cmp	AL, '9'
		ja	inHex1
		sub	AL, '0'
		jmp	inHex2

;change lower case to upper case
inHex1:		and	AL, 11011111B
		sub	AL, '0' + 7
inHex2:	
		ret					;Exit
inHex		ENDP

;*******************
; Print hex digit
; Input: value to print in AL register
; output: none
;*******************

outHex		PROC					;Enter
		cmp	AL, 9				; Print hexDigit
		ja	outHex1
		add	AL, '0'
		jmp	outHex2
outHex1:	add	AL, '0' + 7
outHex2:	call	WriteChar
		ret					;Exit
outHex		ENDP

		END	main