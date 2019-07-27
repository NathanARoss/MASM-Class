TITLE L07

; Name: Nathan Ross, Alisson Leiva, Brandon Valdes, Patrick Tomaszewski, Jose Soto, Francisco Damian
; Description: Test Macros
; Project: L07
; Date: 10/30/2018

INCLUDE irvine32.inc
INCLUDE M07.txt

isdig		MACRO	char
		local	isdig1, isdig2
		cmp	char, '0'		; IF char >= '0' and char <= '9'
		jnae	isdig1
		cmp	char, '9'
		jnbe	isdig1
		test	char, 0			;   THEN zflag = 1
		jmp	isdig2
isdig1:						;   ELSE zflag = 0
isdig2:						; ENDIF
		ENDM

CR		EQU	13
LF		EQU	10

.data
msg		BYTE	"Enter a character: ", 0
char		BYTE	?
isDigMsg	BYTE	" is digit", CR, LF, 0
isHexMsg	BYTE	" is hex digit", CR, LF, 0
isAlpMsg	BYTE	" is alpha", CR, LF, 0
isLowMsg	BYTE	" is lower case", CR, LF, 0
isUpMsg		BYTE	" is upper case", CR, LF, 0
toUpMsg		BYTE	" to upper: ", 0
toLowMsg	BYTE	" to lower: ", 0

.code
main		PROC				; Start
		call	Clrscr

		lea	EDX, msg		; Print "Enter a character: "
		call	WriteString

		call	ReadChar		; Input char
		mov	char, AL

		mov	AL, char		; Print char
		call	WriteChar

		call	CRLF

main1:		cmp	char, CR		; WHILE char <> CR
		je	main2

		isdig	char			;   IF isdig(char)
		jne	main3

		lea	EDX, isDigMsg		;     THEN Print "is digit"
		call	WriteString
main3:						;   ENDIF

		ishex	char			;   IF ishex(char)
		jne	main4

		lea	EDX, isHexMsg		;     THEN Print "is hex digit"
		call	WriteString
main4:						;   ENDIF

		islower	char			;   IF islower(char)
		jne	main5
		lea	EDX, isLowMsg		;     THEN Print "is lower case"
		call	WriteString
main5:						;   ENDIF

		isupper	char			;   IF isupper(char)
		jne	main6
		lea	EDX, isUpMsg		;     THEN Print "is upper case"
		call	WriteString
main6:						;   ENDIF

		isalpha	char			;   IF isalpha(char)
		jne	main7			;     THEN
		lea	EDX, isAlpMsg		;       Print "is alpha"
		call	WriteString
		toupper	char			;       char = toupper(char)
		lea	EDX, toUpMsg		;       Print "to upper: ", char
		call	WriteString
		mov	AL, char
		call	WriteChar
		call	CRLF
		tolower	char			;       char = tolower(char)
		lea	EDX, toLowMsg		;       Print "to lower: ", char
		call	WriteString
		mov	AL, char
		call	WriteChar
		call	CRLF
main7:						;   ENDIF

		lea	EDX, msg		;   Print "Enter a character: "
		call	WriteString

		call	ReadChar		;   Input char
		mov	char, AL

		mov	AL, char		;   Print char
		call	WriteChar

		call	CRLF
		jmp	main1
main2:						; ENDWHILE
		call	CRLF
		exit				; Stop

main		ENDP

END main
