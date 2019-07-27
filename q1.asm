; Nathan Ross
; 11/8/2018
; Question 1
; implement the following expression: EAX = val2 - 10 - (val3 + -val1) = -24

include irvine32.inc
CR		EQU	13			; ASCII CARRIAGE RETURN
LF		=	10			; ASCII LINE FEED

.data
val1		SDWORD   6
val2		SDWORD   -15
val3		SDWORD   5
var1Msg		BYTE	"var1 = ", 0
var2Msg		BYTE	"var2 = ", 0
var3Msg		BYTE	"var3 = ", 0
exprMsg		BYTE	"val2 - 10 - (val3 + -val1) = ", 0
entNewMsg	BYTE	"Enter new values.", CR, LF, 0

.code
main		proc				; Start
		call	Clrscr

		lea	EDX, var1Msg		; Print "val1 = ", val1
		call	WriteString
		mov	EAX, val1
		call	WriteInt
		call	CRLF

		lea	EDX, var2Msg		; Print "val2 = ", val2
		call	WriteString
		mov	EAX, val2
		call	WriteInt
		call	CRLF

		lea	EDX, var3Msg		; Print "val3 = ", val3
		call	WriteString
		mov	EAX, val3
		call	WriteInt
		call	CRLF

main1:		lea	EDX, exprMsg		; Print "val2 - 10 - (val3 + -val1) = "
		call	WriteString

		mov	EAX, val2		; EAX = FFFFFFF1h (-15d)
		sub	EAX, 10			; EAX = FFFFFFE7h (-25d)

		mov	EBX, val3		; EBX = 00000005h (5d)

		mov	ECX, val1		; ECX = 00000006h (6d)

		neg	ECX			; ECX = FFFFFFFAh (-6d)

		add	EBX, ECX		; EBX = FFFFFFFFh (-1d)

		sub	EAX, EBX		; EAX = FFFFFFE8h (-24d)

		call	WriteInt		; Print "-24"
		call	CRLF
		call	CRLF

		lea	EDX, entNewMsg
		call	WriteString

		lea	EDX, var1Msg		; Print "val1 = "
		call	WriteString
		call	ReadInt			; Input val1
		mov	val1, EAX

		lea	EDX, var2Msg		; Print "val2 = "
		call	WriteString
		call	ReadInt			; Input val2
		mov	val2, EAX

		lea	EDX, var3Msg		; Print "val3 = "
		call	WriteString
		call	ReadInt			; Input val3
		mov	val3, EAX

		jmp	main1
		
		call	CRLF
		exit				; Stop
main		endp

end	main
