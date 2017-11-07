*=$c000
		ldx #$03
		ldy #$36
loop:	sty $0402
		dey
		dey
		tya
		and #$04
		bne skip
		ldy #$45
skip:	dec *-11
		dex
		bne loop
		rts
