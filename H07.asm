; Nathan Ross
; 11/1/2018
; H07
; Read a num from the keyboard then print that many Fibonacci numbers

include irvine32.inc

CR		EQU	13		;ASCII CARRIAGE RETURN
LF		EQU	10		;ASCII LINE FEED

.data
enterMsg	BYTE	"Enter the number of terms: ", 0
firstMsg	BYTE	"First ", 0
termsMsg	BYTE	" terms of the Fibonacci series are:", CR, LF, 0

.code
main		PROC			;Start
		lea	EDX, enterMsg	;print "Enter the number of terms: "
		call	WriteString
		call	ReadDec		;input termCt
		mov	ECX, EAX

;EAX is fib1
;EBX is fib2
;ECX is termCt
		mov	EAX, 1		;fib1 = 1
		mov	EBX, 0		;fib2 = 0

main1:					;Do
		add	EAX, EBX	;  fib1 += fib2
		call	WriteDec	;  print fib1
		call	CRLF
		xchg	EAX, EBX	;  swap (fib1, fib2)
		loop	main1		;While --termCt > 0

		call	CRLF		;print "\n"
		exit			;Stop
main		ENDP

		END	main