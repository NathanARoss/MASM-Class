; Nathan Ross
; 9/27/2018
; H04
; Print the sum of 2 hex digits

include irvine32.inc

CR		EQU	13			;ASCII CHARACTER RETURN
LF		EQU	10			;ASCII LINE FEED CHARACTER

.data
hex1Msg		BYTE	"Enter first digit: ", 0
hex2Msg		BYTE	"Enter second digit: ", 0
hexSumMsg	BYTE	"Hex sum = ", 0
hexDig1		BYTE	?
hexDig2		BYTE	?
hexSum		BYTE	?

.code
main		PROC				;Start
		mov	EDX, OFFSET hex1Msg	;print "Enter first digit"
		call	WriteString

		call	ReadHex			;read hex char
		mov	hexDig1, AL
		
		mov	EDX, OFFSET hex2Msg	;print "Enter second digit"
		call	WriteString

		call	ReadHex			;read hex char
		mov	hexDig2, AL

		mov	AL, hexDig1		;hexSum = hex1 to hex2
		add	AL, hexDig2
		mov	hexSum, AL

		movzx	EAX, hexSum		;print hexSum
		mov	EBX, 1			;configure to print 2 digits
		call	WriteHexB

call		CRLF
		exit				;Stop
main		ENDP

		END	main