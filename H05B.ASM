; Nathan Ross
; 10/11/2018
; H03C
; Determines your age and if it's your birthday.

include irvine32.inc

LF		EQU	10
CR		EQU	13

.data
curYear		DWORD	2018
curMonth	DWORD	10
curDay		DWORD	11

yearMsg		BYTE	"Enter birth year: ", 0
monthMsg	BYTE	"Enter birth month: ", 0
dayMsg		BYTE	"Enter birth day: ", 0

youAreMsg	BYTE	"You are ", 0
yearsOldMsg	BYTE	" years old", 0
happyBMsg	BYTE	", Happy Birthday", CR, LF, 0
bornYetMsg	BYTE	"You haven't been born yet", CR, LF, 0
oneYrMsg	BYTE	"You are less than 1 year old", CR, LF, 0
exitMsg		BYTE	"You are too old. Thank you for using my program.", CR, LF, 0

year		DWORD	?
month		DWORD	?
day		DWORD	?
age		DWORD	?

.code
main		proc
		lea	EDX, yearMsg	;Print "Enter birth year: "	
		call	WriteString

		call	ReadDec		;Input year
		mov	year, EAX

main0:		mov	EAX, year	;While year != 0
		cmp	EAX, 0
		je	main12

		mov	EAX, year	;  IF year = curYear
		cmp	EAX, curYEar
		;jz	main12
		jne	main1
					;  then
		lea	EDX, oneYrMsg	;    Print "you are less than 1 year old\n"
		call	WriteString
main1:					;  ENDIF

		mov	EAX, year	;  IF year != curYear
		cmp	EAX, curYear
		je	main10
					;  then
		lea	EDX, monthMsg	;    Print "Enter birth month: "	
		call	WriteString

		call	ReadDec		;    Input month
		mov	month, EAX

		mov	EAX, curYear	;    age = curYear - year
		sub	EAX, year
		mov	age, EAX

		mov	EAX, month	;    IF month > curMonth
		cmp	EAX, curMonth
		jbe	main2
					;    then
		mov	EAX, age	;      age  = age - 1
		sub	EAX, 1
		mov	age, EAX

		call	PrintAge	;      Print "you are "; age; " years old\n"
		call	CRLF
		jmp	main9
main2:					;    ELSE
		mov	EAX, month	;      IF month < curMonth
		cmp	EAX, curMonth
		jae	main3
					;      then
		call	PrintAge	;        Print "you are "; age; " years old\n"
		call	CRLF
		jmp	main8
main3:					;      ELSE
		lea	EDX, dayMsg	;        Print "Enter birth day: "	
		call	WriteString
		
		call	ReadDec		;        Input day
		mov	day, EAX;

		mov	EAX, day	;        IF day > curDay
		cmp	EAX, curDay
		jbe	main4
					;        then
		mov	EAX, age	;          age  = age - 1
		sub	EAX, 1
		mov	age, EAX

		call	PrintAge	;          Print "you are "; age; " years old\n"
		call	CRLF
		jmp	main7
main4:					;        ELSE
		mov	EAX, day	;          IF day < curDay
		cmp	EAX, curDay
		jae	main5
					;          then
		call	PrintAge	;            Print "you are "; age; " years old\n"
		call	CRLF

		jmp	main6
main5:					;          ELSE

		call	PrintAge	;            Print "you are "; age; "years old, Happy Birthday!\n"
		lea	EDX, happyBMsg
		call	WriteString

main6:					;          ENDIF
main7:					;        ENDIF
main8:					;      ENDIF
main9:					;    ENDIF
		jmp	main11
main10:					;  ELSE
		lea	EDX, bornYetMsg	;    Print "you haven't been born yet.\n"
		call	WriteString
main11:					;  ENDIF
		lea	EDX, yearMsg	;  Print "Enter birth year: "	
		call	WriteString

		call	ReadDec		;  Input year
		mov	year, EAX

		jmp main0
main12:					;EndWhile
		
		lea	EDX, exitMsg	;Print "You are too old. Thank you for using my program.\n"
		call	WriteString

		exit
main		endp


;*******************
; Print "you are "; age; " years old."
; input: age variable
; output: none
; overwrites EAX and EDX
;*******************
printAge	PROC				;Enter
		lea	EDX, youAreMsg		;print "you are "
		call	WriteString

		mov	EAX, age
		call	WriteDec		;print age

		lea	EDX, yearsOldMsg	;print " years old"
		call	WriteString

		ret				;Exit
printAge	ENDP

		END	main