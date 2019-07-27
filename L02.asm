; Nathan Ross, Brandon Valdes, Alisson Salazar, Jose Soto, Fransico Damian, Patrick Tomaszewski
; 9/13/2018
; L02
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

mov		EDX, OFFSET dig1Msg
call		WriteString			;print "Enter first digit: "

call		inDig				;read an integer into EAX
mov		dig1, AL			;but only read the least sig byte

call		CRLF

mov		EDX, OFFSET dig2Msg		;print "Enter second digit: "
call		WriteString

call		inDig				;read an integer into EAX
mov		dig2, AL			;but only read the least sig byte

call		CRLF

mov		AL, dig1			;digSum = dig1 + dig2
add		AL, dig2
mov		digSum, AL			

mov		EDX, OFFSET sumMsg		;print "Sum = "
call		WriteString			

mov		AL, digSum
call		outDig				;print sum

call		CRLF				;print a newline for prettiness

		exit				;Stop
main		ENDP


;*****************************
; Input digit
; input: none
; Output: digit returned in AL
;*****************************

inDig		PROC				; Enter

		call ReadChar
		call WriteChar
		sub	AL, '0'			; convert number from ASCII to byte

		ret				; Exit
inDig		ENDP

;*************************************
; Print digit
; input: value to print in AL register
; output: none
;*************************************

outDig		PROC				; Enter

		add	AL, '0'			; Print dig
		call	WriteChar

		ret
outDig		ENDP

		END	main