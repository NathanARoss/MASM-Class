; Nathan Ross
; 9/12/2018
; H02b
; This program inputs a year before the current year and prints how years passed

include irvine32.inc

CR		EQU	13			;ASCII FOR CHARACTER RETURN
LF		EQU	10			;ASCII LINE FEED CHARACTER

.data
currentYear	DWORD	2018
yearMsg		BYTE	"Enter a year: ", 0
year		DWORD	?
yearCountMsg	BYTE	" years have passed", CR, LF, 0

.code
main		PROC				;Start
		mov	EDX, OFFSET yearMsg	;print "Enter a year: "
		call	WriteString			

		call	ReadDec			;read an integer into year
		mov	year, EAX

		mov	EAX, currentYear	;store (currentYear - year) in EAX
		mov	EBX, year
		sub	EAX, EBX

		call	WriteDec		;print (year - currentYear)

		lea	EDX, yearCountMsg	;print " years have passed"
		call	WriteString			

		call	CRLF			;print "\n"
		exit				;Stop
main		ENDP

		END	main