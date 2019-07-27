; Nathan Ross, Alisson Leiva, Brandon Valdes, Patrick Tomaszewski, Jose Soto, Francisco Damian
; 10/18/2018
; L06
; Input 5 numbers and print the largest using inNum and outNum

include irvine32.inc

CR		EQU	13		;ASCII CHARACTER RETURN
LF		EQU	10		;ASCII LINE FEED



.data
inNumMsg	BYTE	"Enter five numbers:", CR, LF, LF, 0
num		DWORD	?
numCt		BYTE	?
largeNum	DWORD	?
largeMsg	BYTE	"Largest = ", 0

.code
main		PROC				;Start

		call	Clrscr

		lea	EDX, inNumMsg		; Print "Enter five numbers:"
		call	WriteString

		call	inNum			; Input num
		mov	num, EAX
		call	CRLF

		mov	EAX, num		; largeNum = num
		mov	largeNum, EAX

		mov	numCt, 1		; numCt = 1

main1:		cmp	numCt, 5		; WHILE numCt < 5
		jnl	main2

		call	inNum			;   Input num
		mov	num, EAX
		call	CRLF

		mov	EAX, num		;   IF num > largeNum
		cmp	EAX, largeNum
		jng	main3

		mov	EAX, num		;     THEN largeNum = num
		mov	largeNum, EAX

main3:		;   ENDIF

		inc	numCt			;   numCt++
		jmp	main1
main2:						; ENDWHILE

		lea	EDX, largeMsg		; Print "Largest = ", largeNum
		call	WriteString
		mov	EAX, largeNum
		call	outNum

		call	CRLF
		exit				;Stop
main		ENDP

;******************************************
; Input a number
; Input: none
; Output: number returned in EAX
;*****************************************

;EBX will be used to create number and then moved to EAX

inNum		PROC				; Enter

		mov	EBX, 0			; num = 0

		call	ReadChar		; input char

inNum1:		cmp	AL, CR			; WHILE char <> CR
		je	inNum2
		call	WriteChar

		sub	AL, '0'			;   dig = Cvt2Bin (char)
		movzx	ECX, AL

		mov	EAX, EBX		;   num = num * 10 + dig
		mov	EBX, 10
		mul	EBX
		mov	EBX, EAX
		add	EBX, ECX

		call	ReadChar		;   input char
		jmp	inNum1
inNum2:						; ENDWHILE

; move EBX to EAX
		mov	EAX, EBX

		ret				; Exit
inNum		ENDP

;*****************************************
; Print number
; Input: value to print in EAX
; Output: none
;*****************************************

; ECX is used for digCt

outNum		PROC				;Enter

		mov	ECX, 0			; digCt = 0

outNum1:					; Repeat
		mov	EBX, 10			;   dig = Num MOD 10
		mov	EDX, 0			;   Num = Num / 10
		div	EBX			
						
		push	EDX			;   push dig
		inc	ECX			;   digCt++
		cmp	EAX, 0			; UNTIL Num <= 0
		jnle	outNum1

outNum2:	cmp	ECX, 0			; WHILE digCt > 0
		jng	outNum3

		pop	EDX			;   pop dig

		mov	AL, DL			;   print dig
		add	AL, '0'
		call	WriteChar
		
		dec	ECX			;   digCt--

		jmp	outNum2
outNum3:					; ENDWHILE

		ret				;Exit
outNum		ENDP

		END	main