*=$0801

.byte $15 $08 $00 $00 $9e $32 $30 $37 $32 $3a $8f $20 $4d $4f $53 $43 $4f $4d $50 $00 $00 $00 $00

MEMSTART=2049
MEMEND=53248

COPYFROM=$61
COPYTO=$63
COPYLEN=$65

DATAPOS=$69
TOTALLEN=$6B
COMPPOS=$6D


SCREEN=$0400

		lda #<decruncher
		sta COPYFROM
		lda #>decruncher
		sta COPYFROM+1
		
		lda #<data
		sec
		sbc COPYFROM
		sta COPYLEN
		lda #>data
		sbc COPYFROM+1
		sta COPYLEN+1
		
		lda #<SCREEN
		sta COPYTO
		lda #>SCREEN
		sta COPYTO+1
		
		jsr copydown
		
		sei
		lda $1
		sta tmpreg
		and #$fe
		sta $1
		
		lda #<data
		clc
		adc #6
		sta COPYFROM
		lda #>data
		adc #0
		sta COPYFROM+1
		
		lda data+2
		sec
		sbc #6
		sta COPYLEN
		sta TOTALLEN
		lda data+3
		sbc #0
		sta COPYLEN+1
		sta TOTALLEN+1
		
		lda data
		sec
		sbc #6
		sta COMPPOS
		lda data+1
		sbc #0
		sta COMPPOS+1
		
		lda #<MEMEND
		sec
		sbc COPYLEN
		sta COPYTO
		sta DATAPOS
		lda #>MEMEND
		sbc COPYLEN+1
		sta COPYTO+1
		sta DATAPOS+1
		
		lda COMPPOS
		clc
		adc DATAPOS
		sta COMPPOS
		lda COMPPOS+1
		adc DATAPOS+1
		sta COMPPOS+1
		
		jsr copyup
		
		lda tmpreg
		sta $1
		cli
		
		jmp SCREEN

copyup:
		ldx COPYLEN+1
		clc
		txa
		adc COPYFROM+1
		sta COPYFROM+1
		clc
		txa
		adc COPYTO+1
		sta COPYTO+1
		inx
		ldy COPYLEN
		beq cskip3
		dey
		beq cskip2

cloop:      
		lda (COPYFROM),y
		sta (COPYTO),y
		dey
		bne cloop

cskip2:    
		lda (COPYFROM),y
		sta (COPYTO),y
  
cskip3:  
		dey
		dec COPYFROM+1
		dec COPYTO+1
		dex
		bne cloop
		ldy #0
		ldy #0
		rts
		
		
copydown:

		ldy #0
		ldx COPYLEN+1
		beq cdlowonly

cdloop:   

		lda (COPYFROM),y
		sta (COPYTO),y
		iny
		bne cdloop
		inc COPYFROM+1
		inc COPYTO+1
		dex
		bne cdloop

cdlowonly:   
  
		ldx COPYLEN
		beq cdendcopy

cdlooplow:      
		lda (COPYFROM),y
		sta (COPYTO),y
		iny
		dex
		bne cdlooplow

cdendcopy:
		ldy #0
		ldx #0
		rts

tmpreg:
		.byte 0

copystart:
		.word 0

decruncher:
{code}

data:
