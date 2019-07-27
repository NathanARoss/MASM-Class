; Nathan Ross
; 10/11/2018
; H05a
; Read 5 hex numbers and print the sum

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
		call	ReadHex		;   Input hexNum
		mov	hexNum, EAX
		mov	EAX, hexNum	;   hexSum += hexNum
		add	hexSum, EAX
		inc	numCt		;   numCt++
		jmp	main1
main2:					; ENDWHILE

		lea	EDX, hyphens	; Print "--------"
		call	WriteString
		mov	EAX, hexSum	; Print hexSum
		call	WriteHex

		call	CRLF
		exit			;Stop
main		ENDP

		END	main