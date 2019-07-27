; Nathan Ross
; 9/19/2018
; H03a
; This program inputs two numbers and prints the larger one

include irvine32.inc

.data
num1Msg		BYTE	"Enter first number: ", 0
num2Msg		BYTE	"Enter second number: ", 0
largerMsg	BYTE	"Larger = ", 0
num1		BYTE	?
num2		BYTE	?
large		BYTE	?


.code
main		PROC				;Start

		lea	EDX, num1Msg		;print "Enter first number: "
		call	WriteString		

		call	ReadDec			;Input num1
		mov	num1, AL			

		lea	EDX, num2Msg		;print "Enter second number: "
		call	WriteString			

		call	ReadDec			;Input num2
		mov	num2, AL			

		lea	EDX, largerMsg		;print "Larger = "
		call	WriteString

		mov	AL, num1		;if num1 <= num2
		cmp	AL, num2
		ja	L1			;then
		mov	AL, num2		;  large = num2
		mov	large, AL
		jmp	L2
L1:						;else
		mov	AL, num1		;  large = num1
		mov	large, AL
L2:						;endif

		movzx	EAX, large
		call	WriteDec		;print large

		call	CRLF			;print "\n"

		exit				;Stop
main		ENDP

		END	main