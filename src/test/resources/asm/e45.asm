*=$c000
		ldx #$03
		ldy #$35
loop:	sty $0402
		dey
		tya
		and #$04
		bne skip
		ldy #$5
skip:	dec *-10
		dex
		bne loop
		rts
