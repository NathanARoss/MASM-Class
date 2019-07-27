; Name: Nathan Ross
; Description: Input # of cups, output # of quarts
; Project: Final question 1
; Date: 12/20/2018

INCLUDE irvine32.inc

CR		EQU	13
LF		EQU	10

.data
errorMsg	BYTE	"Error. Enter a non-negative # of cups", CR, LF, 0
promptMsg	BYTE	"Enter a number of cups: ", 0
welcomeMsg	BYTE	"Thank you for starting your free trial of Cups2Quarts!", CR, LF, "You have 4 uses remaining.", CR, LF, 0
goodbyeMsg	BYTE	"Thank you for using this free trial!", CR, LF, "Please consider purchasing this software :)", CR, LF, 0
outputMsg1	BYTE	" cups contains ", 0
outputMsg2	BYTE	" quarts", CR, LF, 0
cups		SDWORD	?
quarts		SDWORD	?

.code
mQtsToCups	MACRO	cups			; mQtsToCups(cups: int)
		LOCAL	error, end

		cmp	cups, 0			;   if cups < 0
		jl	error			
						;   Then
		mov	EAX, cups		;     qts = cups
		shl	EAX, 2			;     qts *= 4
		jmp	end
error:						;   Else
		mov	EAX, 0			;     qts = 0
		lea	EDX, errorMsg		;     print "Error. Enter a non-negative # of cups\n"
		call	WriteString
						;   EndIf
end:						;   return qts
		ENDM


main		PROC				; Start
		call	Clrscr

		lea	EDX, welcomeMsg		; print "Thank you for starting your free trial of cups to quarts!\n"
		call	WriteString
		call	CRLF			; print "\n"

		mov	ECX, 4			; i = 4
main1:						; DO
		lea	EDX, promptMsg		; print "Enter a number of cups: "
		call	WriteString
		call	ReadInt			; input cups
		mov	cups, EAX

		mQtsToCups cups			; quarts = mQtsToCups(cups)
		mov	quarts, EAX

		mov	EAX, cups		; print "\(cups) cups contains \(quarts) quarts\n"
		call	WriteInt
		lea	EDX, outputMsg1
		call	WriteString
		mov	EAX, quarts		
		call	WriteDec
		lea	EDX, outputMsg2
		call	WriteString

		call	CRLF			; print "\n"
		loop	main1			; WHILE --i > 0

		lea	EDX, goodbyeMsg		; print "Thank you for using this free trial!\nPlease consider purchasing this software :)"
		call	WriteString

		call	CRLF
		exit				; Stop

main		ENDP
		END	main