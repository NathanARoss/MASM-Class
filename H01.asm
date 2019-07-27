TITLE H01

; Nathan Ross
; Prints "Hello World"
; H01
; 9/6/2018

include irvine32.inc

CR		EQU		13	;ASCII FOR CHARACTER RETURN
LF		EQU		10	;ASCII LINE FEED CHARACTER

;Question: What is the difference between = and EQU?
;Answer: values defined with = can be redefined, but those defined with EQU cannot
;	 EQU can be used to declare text macros unlike =

msg		TEXTEQU		<"Hello World", CR, LF, 0>

;Question: What about TEXTEQU?
;Answer: TEXTEQU creates only text macros, cannot create integers
;Unlike integer macros, text macros can always be redefined

.data
helloMsg	BYTE	msg

.code
main		PROC			;Start
		call	Clrscr
		lea	EDX, helloMsg	;Print "Hello World"
		call	WriteString
		exit			;Stop
main		ENDP

		END	main