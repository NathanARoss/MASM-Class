; Nathan Ross
; 9/12/2018
; H02a
; This program adds two vales that the user inputs

include irvine32.inc

.data
dig1Msg		BYTE	"Enter first digit: ", 0
dig2Msg		BYTE	"Enter second digit: ", 0
sumMsg		BYTE	"Sum = ", 0
dig1		BYTE	?
dig2		BYTE	?
digSum		BYTE	?


.code
main		PROC				;Start
		mov	EDX, OFFSET dig1Msg
		call	WriteString		;print "Enter first digit: "

		call	ReadDec			;read an integer into EAX
		mov	dig1, AL		;but only read the least sig byte

		mov	EDX, OFFSET dig2Msg	;print "Enter second digit: "
		call	WriteString

		call	ReadDec			;read an integer into EAX
		mov	dig2, AL		;but only read the least sig byte

		mov	EDX, OFFSET sumMsg
		call	WriteString		;print "Sum = "

		mov	AL, dig1
		add	AL, dig2
		mov	digSum, AL		;store dig1 + dig2 to digSum

		movzx	EAX, digSum
		call	WriteDec		;print sum

		call	CRLF			;print a newline for prettiness

		exit				;Stop
main		ENDP

		END	main