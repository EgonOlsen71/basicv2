*=$0801

.byte $15 $08 $00 $00 $9e $32 $30 $37 $32 $3a $8f $20 $4d $4f $53 $43 $4f $4d $50 $00 $00 $00 $00

MEMSTART=2049
MEMEND=53100

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

jsr copy

sei
lda $1
sta tmpreg
and $fe
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

jsr copy

lda tmpreg
sta $1
cli

;rts
jmp SCREEN

copy:
lda COPYTO
clc
adc COPYLEN
sta COPYTO

lda COPYTO+1
adc COPYLEN+1
sta COPYTO+1

lda COPYFROM
sta copystart
clc
adc COPYLEN
sta COPYFROM

lda COPYFROM+1
sta copystart+1
adc COPYLEN+1
sta COPYFROM+1

ldy #0
loop:
dec COPYTO
bpl skip1
lda COPYTO
cmp #$ff
bne skip1
dec COPYTO+1
skip1:
dec COPYFROM
bpl skip2
lda COPYFROM
cmp #$ff
bne skip2
dec COPYFROM+1
skip2:
lda (COPYFROM),y
sta (COPYTO),y
sta SCREEN+999
lda copystart+1
cmp COPYFROM+1
bne loop
lda copystart
cmp COPYFROM
bne loop

rts

tmpreg:
.byte 0

copystart:
.word 0

decruncher:
{code}

data:
