; Nathan Ross
; 11/1/2018
; H08A
; Input a string and print it back in reverse

include irvine32.inc

CR		EQU	13		;ASCII CARRIAGE RETURN
LF		EQU	10		;ASCII LINE FEED

.data
msg		BYTE	"Enter a string", CR, LF, 0
strg		BYTE	21 DUP (?)
i		DWORD	?
copyStrg	BYTE	SIZEOF strg DUP (?)
j		DWORD	?

.code
main		PROC				;Start
		lea	EDX, msg		;print "Enter a string"
		call	WriteString

		lea	EDX, strg
		mov	ECX, SIZEOF strg
		call	ReadString		;Input strg
		mov	i, EAX			;i = strgSize
		mov	j, 0

		dec	i			;i--
main1:						;Do
		mov	ESI, i
		mov	AL, strg[ESI]
		mov	ESI, j
		mov	copyStrg[ESI], AL

		dec	i
		inc	j

		cmp	i, 0			;while i >= 0
		jnl	main1

		mov	ESI, j			;copyStrg[strgSize] = 0
		mov	copyStrg[ESI], 0

		lea	EDX, copyStrg		;print copyStrg
		call	WriteString

		call	CRLF			;print "\n"
		exit				;Stop
main		ENDP

		END	main