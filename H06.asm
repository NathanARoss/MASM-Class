; Nathan Ross
; 10/18/2018
; H06
; Read 5 hex numbers and print the largest

include irvine32.inc

CR		EQU	13		;ASCII CARRIAGE RETURN
LF		EQU	10		;ASCII LINE FEED

.data
inHexMsg	BYTE	"Enter five hex numbers:", CR, LF, LF, 0
hyphens		BYTE	"--------", CR, LF, 0
largestMsg	BYTE	"Largest = ", 0
hexNum		DWORD	?
largeNum	DWORD	?

.code
main		PROC			;Start

		call	Clrscr

		lea	EDX, inHexMsg	;Print "Enter five hex numbers:"
		call	WriteString
		call	ReadHex		;Input largestNum
		mov	largeNum, EAX

		mov	ECX, 4		;loop = 4				
main1:					;DO
		call	ReadHex		;  Input hexNum
		cmp	EAX, largeNum	;  IF hexNum > largeNum
		jng	main2		;  THEN
		mov	largeNum, EAX	;    largeNum = hexNum
main2:					;  ENDIF
		loop	main1		;WHILE --loop > 0

		lea	EDX, hyphens	;Print "--------"
		call	WriteString
		lea	EDX, largestMsg	;Print "Largest = "
		call	WriteString
		mov	EAX, largeNum	;Print largeNum
		call	WriteHex

		call	CRLF
		exit			;Stop
main		ENDP

		END	main