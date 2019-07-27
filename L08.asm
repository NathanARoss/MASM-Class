TITLE L08

; Name: Nathan Ross, Alisson Leiva, Brandon Valdes, Patrick Tomaszewski, Jose Soto, Francisco Damian
; Description: Right justify numbers
; Project: L08
; Date: 11/1/2018

CR		EQU	13		;ASCII CHARACTER RETURN
LF		EQU	10		;ASCII LINE FEED

include irvine32.inc

.data
inMsg		BYTE	"Enter five numbers. End each number with a CR:", CR, LF, LF, 0
hyphens		BYTE	"      ----", CR, LF, 0
sum		DWORD	?
num		DWORD	?
numCt		BYTE	?

.code
main		PROC				; Start
		call	Clrscr

		lea	EDX, inMsg		; Print "Enter five numbers. End each number with a CR:"
		call	WriteString

		mov	sum, 0			; Sum 0

		mov	numCt, 0		; NumCt = 0

main1:
		cmp	numCt, 5		; WHILE NumCt < 5
		jnl	main2

		call	inNum			;   Input num
		mov	num, EAX

		mov	AL, CR			;   Print num
		call	WriteChar
		mov	EAX, num
		mov	ECX, 10
		call	outNum
		call	CRLF

		mov	EAX, num		;   sum += num
		add	sum, EAX

		inc	numCt			;   NumCt++
		jmp	main1
main2:						; ENDWHILE

		lea	EDX, hyphens		; Print "----"
		call	WriteString		

		mov	AL, CR			; Print sum
		call	WriteChar
		mov	EAX, sum
		mov	ECX, 10
		call	outNum

		call	CRLF
		exit				; Stop
main		ENDP

;********************************
; TO USE
;   Call inNum
;   Return: Number in EAX
; REGISTER USE
;   use EBX for Num
;   use AL for Char
;   use CL for dig
;********************************

;EBX will be used to create number and then moved to EAX

inNum		PROC	uses EBX ECX		; Enter
		mov	EBX, 0			; num = 0
		call	ReadChar		; input char
inNum1:		cmp	AL, CR			; WHILE char <> CR
		je	inNum2
		call	WriteChar
		movzx	ECX, AL			;   dig = Cvt2Bin (char)
		sub	CL, '0'
		mov	EAX, EBX		;   num = num * 10 + dig
		mov	EBX, 10
		mul	EBX
		add	EAX, ECX
		mov	EBX, EAX
		call	ReadChar		;   input char
		jmp	inNum1
inNum2:						; ENDWHILE

; move EBX to EAX
		mov	EAX, EBX
		ret				; Exit
inNum		ENDP

;********************************
; TO USE
;   move number to print to EAX
;   move size of number to print to ECX
;   Call outNum
; REGISTER USE
;   use EAX for Num
;   use ECX for length
;   use DL for dig
;********************************

.data
numString	BYTE	15 DUP ('*'), 0

.code
outNum		PROC	uses EAX EBX ECX EDX	; Enter
		mov	numString [ECX], 0	; numString[length] = 0
		dec	ECX			; length--

outNum1:					; Repeat

		mov	EBX, 10			;   dig = Num MOD 10
		mov	EDX, 0			;   Num = Num / 10
		div	EBX
		add	DL, '0'			;   numString[length] = Chr(dig)
		mov	numString[ECX], DL

		dec	ECX			;   length = length - 1

		cmp	EAX, 0			; UNTIL Num <= 0
		jnle	outNum1

outNum2:
		cmp	ECX, 0			; WHILE length >= 0
		jnge	outNum3

		mov	numString[ECX], ' '	;   numString[length] = ' '

		dec	ECX			;   length = length - 1

		jmp	outNum2
outNum3:					; ENDWHILE

		lea	EDX, numString		; Print numString
		call	WriteString

		ret				;Exit
outNum		ENDP

		END	main