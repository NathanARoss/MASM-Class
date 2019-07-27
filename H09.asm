TITLE H09

; Name: Nathan Ross
; Description: Sort an array using a selection sort
; Project: H09
; Date: 11/30/2018

include irvine32.inc

ARRAYSIZE	EQU	100

.data
A		DWORD	ARRAYSIZE DUP (?)
Num		DWORD	?
N		DWORD	?
Ct		DWORD	?
T		DWORD	?
I		DWORD	?
min		DWORD	?

.code
main		PROC				; Start
		call	Clrscr

		call	loadArray		; Call loadArray
		call	sort			; Call sort
		call	printArray		; Call printArray

		call	CRLF
		exit				; Stop
main		ENDP

loadArray	PROC				; Enter
		mov	N, 0			; N = 0
		call	ReadDec			; Input Num
		mov	Num, EAX

load1:		cmp	num, 0			; While Num != 0
		je	load2
		mov	EAX, Num		;   A(N) = Num
		mov	EBX, N
		shl	EBX, 2
		mov	A[EBX], EAX

		inc	N			;   N++
		call	ReadDec			;   Input Num
		mov	Num, EAX
		jmp	load1
load2:						; ENDWHILE
		ret				; Exit
loadArray	ENDP

sort		PROC				; Enter
		mov	I, 0			; I = 0
sort1:		mov	EAX, N			; WHILE I < N - 1
		dec	EAX
		cmp	I, EAX
		jnl	sort2
		call	onePass			;   Call onePass
		inc	I			;   I++
		jmp	sort1
sort2:						; ENDWHILE
		ret				; Exit
sort		ENDP

onePass		PROC				; Enter
		mov	EAX, I			; min = i
		mov	min, EAX
		mov	EAX, I			; Ct = I + 1
		inc	EAX
		mov	Ct, EAX
onePass1:	mov	EAX, Ct			; WHILE Ct < n
		cmp	EAX, N
		jnl	onePass2
		mov	EBX, Ct			;   IF A(Ct) < A(min)
		shl	EBX, 2
		mov	EAX, A[EBX]
		mov	EBX, min
		shl	EBX, 2
		cmp	EAX, A[EBX]
		jnl	onePass3
						;     THEN
		mov	EAX, Ct			;       min = Ct
		mov	min, EAX
onePass3:					;   ENDIF
		inc	Ct			;   Ct++
		jmp	onePass1
onePass2:					; ENDWHILE
		call	orderPair		; CALL orderPair
		ret				; Exit
onePass		ENDP

orderPair	PROC				; Enter
		mov	EBX, I			; T = A(I)
		shl	EBX, 2
		mov	EAX, A[EBX]
		mov	T, EAX
		mov	EBX, min		; A(I) = A(min)
		shl	EBX, 2
		mov	EAX, A[EBX]
		mov	EBX, I
		shl	EBX, 2
		mov	A[EBX], EAX
		mov	EAX, T			; A(min) = T
		mov	EBX, min
		shl	EBX, 2
		mov	A[EBX], EAX
		ret				; Exit
orderPair	ENDP

printArray	PROC				; Enter
		mov	Ct, 0			; Ct = 0
print1:		mov	EAX, Ct			; WHILE Ct < N
		cmp	EAX, n
		jnl	print2
		mov	EBX, Ct			;   Print A(Ct)
		shl	EBX, 2
		mov	EAX, A[EBX]
		call	WriteDec
		call	CRLF
		inc	Ct			;   Ct++
		jmp	print1
print2:						; ENDWHILE
		ret				; Exit
printArray	ENDP

		END	main