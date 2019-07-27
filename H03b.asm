; Nathan Ross
; 9/19/2018
; H03b
; This program inputs three numbers and prints the largest one

include irvine32.inc

CR		EQU	13			;ASCII CHARACTER RETURN
LF		EQU	10			;ASCII LINE FEED CHARACTER

.data
numMsg		BYTE	"Enter three numbers:", CR, LF, CR, LF, 0
largestMsg	BYTE	"Largest = ", 0
num1		BYTE	?
num2		BYTE	?
num3		BYTE	?


.code
main		PROC				;Start

		lea	EDX, numMsg		;print "Enter three numbers:\n\n"
		call	WriteString			

		call	ReadDec			;Input num1
		mov	num1, AL

		call	ReadDec			;Input num2
		mov	num2, AL

		call	ReadDec			;Input num3
		mov	num3, AL

;compare num1 to num2 and store the larger of the two
		mov	AL, num1		;if num1 > num2 then
		cmp	AL, num2
		jbe	L1			
		mov	BL, num1		;  temp = num1
		jmp	L2
L1:						;else
		mov	BL, num2		;  temp = num2
L2:						;endif

;compare the previous number to number 3 and store the larger of the two
		cmp	BL, num3		;if temp <= num3 then
		ja	L3
		mov	BL, num3		;  temp = num3
L3:						;endif

;temp now contains the largest of the three numbers
		lea	EDX, largestMsg		;print "Largest = "
		call	WriteString

		movzx	EAX, BL			;print temp
		call	WriteDec

		call	CRLF			;print "\n"

		exit				;Stop
main		ENDP

		END	main