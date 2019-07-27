; Nathan Ross
; 11/1/2018
; H08C
; Input a string and capitalize each word

include irvine32.inc
include M07.txt

CR		EQU	13		;ASCII CARRIAGE RETURN
LF		EQU	10		;ASCII LINE FEED

.data
msg		BYTE	"Enter a string", CR, LF, 0
strg		BYTE	21 DUP (?)
i		DWORD	?
copyStrg	BYTE	SIZEOF strg DUP (?)
j		DWORD	?
char		BYTE	?
prevChar	BYTE	?

.code
main		PROC				;Start
		lea	EDX, msg		;print "Enter a string"
		call	WriteString

		lea	EDX, strg
		mov	ECX, SIZEOF strg
		call	ReadString		;Input strg
		mov	i, EAX			;i = strgSize
		mov	j, 0

		mov	prevChar, ' '		;prevChar = ' '
main1:						;Do
		mov	ESI, j			;char = strg[j]
		mov	AL, strg[ESI]
		mov	char, AL

		isWSpace prevChar		;f isWChar(prevChar)
		jne	main2
		isalpha	char			;AND isAlpha(char)
		jne	main2
		toupper	char			;char = toUpper(char)
main2:
		mov	AL, char		;copyStrg[j] = char
		mov	copyStrg[ESI], AL	

		inc	j			;j++
		mov	AL, char		;prevChar = char
		mov	prevChar, AL

		mov	EAX, j			;while j <= i
		cmp	EAX, i			
		jle	main1

		lea	EDX, copyStrg		;print copyStrg
		call	WriteString

		call	CRLF			;print "\n"
		exit				;Stop
main		ENDP

		END	main