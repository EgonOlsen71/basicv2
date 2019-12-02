;60010 for i=oo to oo+3:aa=peek(i)+ad
;60030 poke aa+54272,cv:poke aa,ch
;60040 next:return

*=51200

startaddr=155
addaddr=679
char=681
color=682

		ldy #3
loop	lda (startaddr),y
		clc
		adc addaddr
		sta 251
		ldx addaddr+1
		bcc skiphi
		inx
skiphi	stx 252
		sty 2
		ldy #0
		lda char
		sta (251),y
		lda 251
		clc
		adc #<54272
		sta 251
		lda 252
		adc #>54272
		sta 252
		lda color
		sta (251),y
		ldy 2
		beq end
		dey
		jmp loop
end		rts
		
		

