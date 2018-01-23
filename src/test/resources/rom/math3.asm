*=$c000
LDY #$a0
LDA #$11
JSR $B391
ldx #00
ldy #$20
jsr 48087
jsr 43708
LDA #00
LDY #$20
JSR $BBA2
jsr 43708
LDA #00
LDY #$20
JSR $BBA2
RTS