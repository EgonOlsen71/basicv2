*=$c000
		lda #<NUMBER
		ldy #>NUMBER
		jsr $BBA2
		ldx #00
		ldy #$20
		jsr 48087
		lda #0
		ldy #$20
		jsr 48034
		jsr 49009
		ldx #$10
		ldy #$20
		jsr 48087
		jsr 43708
		rts

NUMBER	.real 3124.4569
