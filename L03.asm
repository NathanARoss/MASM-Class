TITLE	L03 Selection
; Nathan Ross, Alisson Leiva, Patrick Tomaszewski, Brandon Valdes, Francisco Damian
; 9/20/2018
; L03
; Data Validation of Digit

include irvine32.inc

.data
digMsg		BYTE	"Enter a digit: ", 0
isDigMsg	BYTE	" is a digit", 0
isntDigMsg	BYTE	" is not a digit", 0
char		BYTE	?

.code
main		PROC					;Start
		call	Clrscr

		lea	EDX, digMsg			; Print "Enter a digit: "
		call	WriteString

		call	ReadChar			; Input char
		call	WriteChar
		mov	char, AL

		cmp	char, '0'			; IF char >= '0' AND char <= '9'
		jnae	main1
		cmp	char, '9'
		jnbe	main1

							;   THEN

		lea	EDX, isDigMsg			;     Print " is a digit"
		call	WriteString

		jmp	main2
main1:							;   ELSE
		lea	EDX, isntDigMsg			;     Print " is not a digit"
		call	WriteString
main2:							; ENDIF

		call	CRLF
		exit					; Stop
main		ENDP

		END	main