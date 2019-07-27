; Nathan Ross, Alisson Lieva, Brandon Valdes, Patrick Tomasezwski, Francisco Damiam, Jose Soto
; 9/6/2018
; L01
; This program prints "Hello World"

include irvine32.inc
CR		EQU	13 ; ASCII FOR CHARACTER RETURN
LF		=	10 ; ASCII LINE FEED CHARACTER
.data
helloMsg	BYTE	"Hello", 0
worldMsg	BYTE	"World", CR, LF, 0

.code
main		proc				; Start
		call	Clrscr		

		call	PrtHelloMsg		; Print "Hello"

		mov	AL, ' '			; Print ' '
		call	WriteChar

		call	PrtWorldMsg		; Print "Hello"
		
		call	CRLF

		exit				; Stop
main		endp

PrtHelloMsg	PROC				; Enter

		mov	EDX, OFFSET helloMsg	; Print "Hello"
		call	WriteString

		ret				; Exit
PrtHelloMsg	ENDP


PrtWorldMsg	PROC				; Enter

		lea	EDX, worldMsg		; Print "World"
		call	WriteString

		ret				; Exit
PrtWorldMsg	ENDP

		end	main