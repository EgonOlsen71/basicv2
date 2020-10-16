*=$0801

.byte $15 $08 $00 $00 $9e $32 $30 $37 $32 $3a $8f $20 $4d $4f $53 $43 $4f $4d $50 $00 $00 $00 $00

memstart=2049
memend=53100

decruncher
.word 0
code
.array 1024

header
data
.word 0
compLen
.word 0
ucLen
.word 0

data
