; Nathan Ross
; 9/19/2018
; H03c
; Input a person's birthday then print how old they are

include irvine32.inc

CR		EQU	13			;ASCII CHARACTER RETURN
LF		EQU	10			;ASCII LINE FEED CHARACTER

.data
curYear		DWORD	2018
curMonth	DWORD	9
curDay		DWORD	19

yearMsg		BYTE	"Enter the year of your birth: ", 0
monthMsg	BYTE	"Enter the month of your birth: ", 0
dayMsg		BYTE	"Enter the day of your birth: ", 0
bornYetMsg	BYTE	"you haven't been born yet", CR, LF, 0
yearOldMsg	BYTE	"you are less than 1 year old", CR, LF, 0
youAreMsg	BYTE	"you are ", 0
yearsOldMsg	BYTE	" years old", CR, LF, 0
happybdayMsg	BYTE	" years old, Happy Birthday", CR, LF, 0

year		DWORD	?
month		DWORD	?
day		DWORD	?


.code
main		PROC				;Start

mov		EDX, OFFSET yearMsg		;print "Enter birth year: "
call		WriteString			

call		ReadDec				
mov		year, EAX

cmp		EAX, curYear			
je		LessThanOneYearOld		;if the user was born this year
jg		NotBornYet			;if the user was not born yet

mov		EDX, OFFSET monthMsg		;ask for birth month
call		WriteString	

call		ReadDec
mov		month, EAX

mov		EBX, curYear			;EBX register will hold age
sub		EBX, year			;age = curYear - year

mov		EAX, month			;if the user was born before or
cmp		EAX, curMonth			;after this month, then we don't
ja		HasBirthdayLaterThisYear	;need to ask the day
jb		HadBirthdayEarlierThisYear

mov		EDX, OFFSET dayMsg		;ask for birth day
call		WriteString

call		ReadDec				;read the current day, but leave
mov		day, EAX			;it in EAX for cmp
cmp		EAX, curDay
ja		HasBirthDayLaterThisYear
jb		HadBirthdayEarlierThisYear
jmp		TodayIsTheirBirthday


NotBornYet:
mov		EDX, OFFSET bornYetMsg		;print you haven't been born yet
call		WriteString

jmp		EndProgram	

LessThanOneYearOld:
mov		EDX, OFFSET yearOldMsg		;say that they are less than 1
call		WriteString

jmp		EndProgram			

HasBirthdayLaterThisYear:
mov		EDX, OFFSET youAreMsg		;print "you are "
call		WriteString

sub		EBX, 1
mov		EAX, EBX
call		WriteDec

mov		EDX, OFFSET yearsOldMsg		;print " years old"
call		WriteString

jmp		EndProgram

HadBirthdayEarlierThisYear:
mov		EDX, OFFSET youAreMsg		;print "you are "
call		WriteString

mov		EAX, EBX
call		WriteDec

mov		EDX, OFFSET yearsOldMsg		;print " years old"
call		WriteString

jmp		EndProgram

TodayIsTheirBirthday:
mov		EDX, OFFSET youAreMsg		;print "you are "
call		WriteString

mov		EAX, EBX
call		WriteDec

mov		EDX, OFFSET happybdayMsg	;wish them a happy bday
call		WriteString

jmp		EndProgram


EndProgram:
call		CRLF				

		exit				;Stop
main		ENDP

		END	main