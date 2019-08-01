basic       = $0801

*=basic

.byte $0b $08
.byte $e3
.byte $07 $9e
.byte {48+(INT(entry)-INT(INT(entry)/INT(10000))*INT(10000)) / 1000}
.byte {48+(INT(entry)-INT(INT(entry)/INT(1000))*INT(1000)) / 100}
.byte {48+(INT(entry)-INT(INT(entry)/INT(100))*INT(100)) / 10}
.byte {48+INT(entry)-INT(INT(entry)/INT(10))*INT(10)}
.byte $00 $00 $00

entry

LDA #0
STA 53280
RTS