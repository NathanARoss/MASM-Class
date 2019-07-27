TITLE A2

; Name: Nathan Ross
; Description: Inhex finite state machine
; This program ignores invalid chars.  Confirm number by pressing enter
; Project: A2
; Date: 12/11/2018

include irvine32.inc

CR		EQU	13			;ASCII CARRIAGE RETURN

.data

.code
main		PROC				; Start
;EBX is the number we are building from character input
;ECX holds whether the number is negative or positive
		mov	EBX, 0
		mov	ECX, 0

		call	ReadChar
		cmp	AL, '-'
		je	main1
		cmp	AL, '+'
		je	main1

		jmp	main4

;handle sign
main1:
		call	WriteChar

		cmp	AL, '-'
		jne	main4
		mov	EBX, 1

		call	ReadChar
		jmp	main4

;prompt for hex digits
main4:
		movzx	EDX, AL

;user terminates number by pressing enter
		cmp	AL, CR
		je	main9

		cmp	AL, '0'
		jb	main5
		cmp	AL, '9'
		ja	main5

		sub	EDX, '0'
		jmp	main7

;not a digit
main5:
		cmp	AL, 'A'
		jb	main6
		cmp	AL, 'F'
		ja	main6

		sub	EDX, 'A' - 10
		jmp	main7

;not uppercase
main6:
		cmp	AL, 'a'
		jb	main8
		cmp	AL, 'f'
		ja	main8

		sub	EDX, 'a' - 10
		jmp	main7

;add digit to our number and print the digit
main7:
		call	WriteChar
		shl	EBX, 4
		or	EBX, EDX
		jmp	main8

;read another number
main8:
		call	ReadChar
		jmp	main4

;return key.  Number is finished being entered
main9:
		cmp	ECX, 0
		je	main10
		neg	EBX

main10:
		call	CRLF
		mov	EAX, EBX
		call	WriteHex


		call	CRLF
		exit				; Stop
main		ENDP
		END	main