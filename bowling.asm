global _start

section .text

;	rdi: frame number
; 	rsi: pin array ptr
total:	mov	rax, 0
	mov	al, byte[rsi]

	; pins[0] == 10
	cmp	al, 10
	jne	elif
	cmp	byte[rsi+1], 255
	je	cont
	add	al, byte[rsi+1]
	cmp	byte[rsi+2], 255
	je	cont
	add	al, byte[rsi+2]

cont:	add	rsi, 1
	jmp	endif

	; pins[0] + pins[1] == 10
elif:	mov	al, byte[rsi]
	add	al, byte[rsi+1]
	cmp	al, 10
	jne	else
	add	al, byte[rsi+2]
	add	rsi, 2
	jmp	endif

else:	mov	al, byte[rsi]
	add	al, byte[rsi+1]
	add	rsi, 2

endif:  add	rdi, 1

	cmp	rdi, 10 ; frame 10 is the last one
	je	finish

	push	rax
	push	rbp
	call	total
	mov	rcx, rax
	pop	rbp
	pop	rax
	add	rax, rcx
finish:	ret


_start:
	mov	rsi, zeros
	mov	rdi, 0
	call	total
	cmp	rax, 0
	mov	rdi, 1
	jne	break

	mov	rsi, ones
	mov	rdi, 0
	call	total
	cmp	rax, 20
	mov	rdi, 2
	jne	break

	mov	rsi, spare
	mov	rdi, 0
	call	total
	cmp	rax, 16
	mov	rdi, 3
	jne	break

	mov	rsi, strike
	mov	rdi, 0
	call	total
	cmp	rax, 24
	mov	rdi, 4
	jne	break

	mov	rsi, max
	mov	rdi, 0
	call	total
	cmp	rax, 300
	mov	rdi, 5
	jne	break

	mov	rdi, 0
break:	mov	rax, 60
	syscall


section .data

;       frames | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10        |
zeros:	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,      255
ones:	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1,      255
spare:	db	5, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,      255
strike:	db	10,   3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,      255
max:	db	10,   10,   10,   10,   10,   10,   10,   10,   10,   10, 10, 10, 255
