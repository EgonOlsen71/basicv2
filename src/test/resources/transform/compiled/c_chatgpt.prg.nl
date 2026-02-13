REALFAC = $BBA2
MEMARG = $BA8C
MEMMUL = $BA28
MEMSUB = $B850
FACMEM = $BBD7
PRINTSTRS = $AB25
VALS = $B7B5
CMPFAC = $BC5B
FACADD = $B867
SGNFAC = $BC2B
ARGADD = $B86A
ARGAND = $AFE9
ARGDIV = $BB14
FACMUL = $BA30
FACLOG = $B9EA
FACSQR = $BF71
FACEXPCALL = $BFED
FACABS = $BC58
FACSIN = $E26B
FACCOS = $E264
FACTAN = $E2B4
FACATN = $E30E
FACSIG = $BC39
FACNOT = $AED4
FACRND = $E097
XFACWORD = $B7F7
FACDIV = $BB0F
BASINT = $BCCC
FACPOW = $BF7B
FACSUB = $B853
FACOR = $AFE6
ARGFAC = $BBFC
FACARG = $BC0C
FACSTR = $BDDF
FACINT = $B1AA
RNDFAC = $BC1B
INTFAC = $B391
WRITETIS = $A9E7
GETTI = $BE68
GETTIME = $AF7E
COPYTIME = $AF87
TI2FAC = $AF84
BYTEFAC = $B3A2
CRSRRIGHT = $AB3B
ERRALL = $A437
ERRIQ = $B248
ERREI = $ACF4
ERRSYN = $AF08
INPUT = $A560
CRSRPOS = $FFF0
CHROUT = $FFD2
GETIN = $FFE4
OPENCH = $FFC0
CLOSECH = $FFC3
CHKIN = $FFC6
CHKOUT = $FFC9
CLRCH = $FFCC
LOADXX = $FFD5
SAVEXX = $FFD8
TWAIT = $FFE1
ERRFNF = $F12F
ARGSGN=$6E
ARGLO=$6D
ARGMO=$6C
ARGMOH=$6B
ARGHO=$6A
ARGEXP=$69
FACSGN=$66
FACLO=$65
FACMO=$64
FACMOH=$63
FACHO=$62
FACEXP=$61
FACOV=$70
OLDOV=$56
ARISGN=$6F
FAC=$61
RESLO=$29
RESMO=$28
RESMOH=$27
RESHO=$26
RESOV=$2A
RESHOP=$6F
FACHOP=$56
ITERCNT=$67
IOCHANNEL=$13
BASICSTART=$2B
BASICEND=$37
STATUS=$90
VERCHK=$93
SECADDR=$B9
DEVICENUM=$BA
FILELEN=$B7
LOGICADDR=$B8
FILEADDR=$BB
LOADEND=$C3
KEYNDX=$C6
INDEX1=$22
VALTYPE=$0D
LOWDS=$5D
TIMEADDR=$A0
BASICPOINTER=$7A
LOADOK_STATUS=64
LOFBUF=$FF
LOFBUFH=$100
INPUTBUF=$200
BASICBUFFER=820
TMP_ZP = 105
TMP2_ZP = 107
TMP3_ZP = 34
;make sure that JUMP_TARGET's low can't be $ff
JUMP_TARGET = 69
TMP_REG=71
G_REG=73
X_REG=61
*=2072
TSX
STX SP_SAVE
; *** CODE ***
PROGRAMSTART:
JSR START
;
LINE_0:
;
;
LINE_100:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_110:
;
LDA #<CONST_1
LDY #>CONST_1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_120:
;
LDA #<CONST_2
LDY #>CONST_2
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_130:
;
LDA #<CONST_3
LDY #>CONST_3
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_140:
;
LDA #<CONST_4
LDY #>CONST_4
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_150:
;
LDA #<CONST_5
LDY #>CONST_5
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_160:
;
LDA #<CONST_6
LDY #>CONST_6
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_170:
;
LDA #<CONST_7
LDY #>CONST_7
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_180:
;
LDA #<CONST_8
LDY #>CONST_8
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_190:
;
LDA #<CONST_9
LDY #>CONST_9
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_200:
;
LDA #<CONST_10
LDY #>CONST_10
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_210:
;
LDA #<CONST_11
LDY #>CONST_11
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_220:
;
LDA #<CONST_12
LDY #>CONST_12
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_230:
;
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_240:
;
LDA #<CONST_14
LDY #>CONST_14
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_250:
;
LDA #<CONST_15
LDY #>CONST_15
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_260:
;
LDA #<CONST_16
LDY #>CONST_16
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_270:
;
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_280:
;
LDA #<CONST_18
LDY #>CONST_18
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_290:
;
LDA #<CONST_19
LDY #>CONST_19
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_300:
;
LDA #<CONST_20
LDY #>CONST_20
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_310:
;
LDA #<CONST_21
LDY #>CONST_21
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_320:
;
LDA #<CONST_22
LDY #>CONST_22
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_330:
;
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_340:
;
LDA #<CONST_24
LDY #>CONST_24
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_350:
;
LDA #<CONST_25
LDY #>CONST_25
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_360:
;
LDA #<CONST_26
LDY #>CONST_26
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_370:
;
LDA #<CONST_27
LDY #>CONST_27
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_380:
;
LDA #<CONST_28
LDY #>CONST_28
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_390:
;
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_400:
;
LDA #<CONST_30
LDY #>CONST_30
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_410:
;
LDA #<CONST_31
LDY #>CONST_31
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_420:
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_430:
;
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_440:
;
LDA #<CONST_34
LDY #>CONST_34
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_450:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_460:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_470:
;
LDA #<CONST_37
LDY #>CONST_37
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_480:
;
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_490:
;
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_500:
;
LDA #<CONST_40
LDY #>CONST_40
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_510:
;
LDA #<CONST_41
LDY #>CONST_41
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR END
RTS
; *** SUBROUTINES ***
;###################################
END			LDX SP_SAVE
TXS
<IF BIGRAM>
JSR ENABLEROM
</IF>
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
RTS
;###################################
;###################################
START		LDA ENDSTRBUF+1
BNE ENDGIVEN
LDA BASICEND
STA ENDSTRBUF
LDA BASICEND+1
STA ENDSTRBUF+1
ENDGIVEN	LDA #<FPSTACK
LDY #>FPSTACK
STA FPSTACKP
STY FPSTACKP+1
LDA #<FORSTACK
LDY #>FORSTACK
STA FORSTACKP
STY FORSTACKP+1
LDA #<STRBUF
LDY #>STRBUF
STA STRBUFP
STY STRBUFP+1
STA HIGHP
STY HIGHP+1
LDA #0
STA CHLOCKFLAG
STA LASTVAR
STA LASTVAR+1
JSR INITVARS
LDA #0
STA CMD_NUM
STA CHANNEL
TAY
TAX
<IF X16>
JSR VARBANKON
</IF>
STA KEYNDX
<IF X16>
JSR VARBANKOFF
LDA #DEFAULT_BANK
STA RAMSELECT
</IF>
JSR RESTORE
CLC
<IF BOOST>
JSR BOOSTENABLE
</IF>
RTS
;###################################
;###################################
INITNARRAY
STA TMP_ZP
STY TMP_ZP+1
LDY #0
TYA
NINITLOOP	STA (TMP_ZP),Y
INC TMP_ZP
BNE NLOOPNOV
INC TMP_ZP+1
NLOOPNOV	LDX TMP2_ZP
BNE NLOOPNOV2
DEC TMP2_ZP+1
NLOOPNOV2	DEC TMP2_ZP
BNE NINITLOOP
LDX TMP2_ZP+1
BNE NINITLOOP
RTS
;###################################
;###################################
INITSTRARRAY
STA TMP_ZP
STY TMP_ZP+1
SINITLOOP	LDY #0
LDA #<EMPTYSTR
STA (TMP_ZP),Y
LDA #>EMPTYSTR
INY
STA (TMP_ZP),Y
CLC
LDA TMP_ZP
ADC #2
STA TMP_ZP
BCC SLOOPNOV1
INC TMP_ZP+1
SLOOPNOV1	SEC
LDA TMP2_ZP
SBC #2
STA TMP2_ZP
BCS SLOOPNOV2
DEC TMP2_ZP+1
SLOOPNOV2	LDA TMP2_ZP
BNE SINITLOOP
LDA TMP2_ZP+1
BNE SINITLOOP
RTS
;###################################
;###################################
INITSPARAMS	STA TMP3_ZP
STY TMP3_ZP+1
SEC
SBC #2
STA TMP_ZP
TYA
SBC #0
STA TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y
STA TMP2_ZP
INY
LDA (TMP_ZP),Y
STA TMP2_ZP+1
LDA TMP3_ZP
LDY TMP3_ZP+1
RTS
;##################################
;##################################
INITSTRVARS	LDA #<STRINGVARS_START		; Reset all string variables...
LDY #>STRINGVARS_START
CMP #<STRINGVARS_END
BNE INITIT1
CPY #>STRINGVARS_END
BNE INITIT1
JMP INITSA2					; No string variables at all
INITIT1		STA TMP_ZP
STY TMP_ZP+1
LDY #0
INITSTRLOOP	LDA #<EMPTYSTR
STA (TMP_ZP),Y
INY
LDA #>EMPTYSTR
STA (TMP_ZP),Y
DEY
LDA TMP_ZP
CLC
ADC #2
STA TMP_ZP
LDA TMP_ZP+1
ADC #0
STA TMP_ZP+1
CMP #>STRINGVARS_END
BNE INITSTRLOOP
LDA TMP_ZP
CMP #<STRINGVARS_END
BNE INITSTRLOOP
INITSA2		LDA #<STRINGARRAYS_START	; ...and all string arrays
LDY #>STRINGARRAYS_START
CMP #<STRINGARRAYS_END
BNE ARRAYLOOP
CPY #>STRINGARRAYS_END
BNE ARRAYLOOP
RTS							;...no string array at all
ARRAYLOOP	CLC
ADC #3
BCC ARRAYSKIP1
INY
ARRAYSKIP1	CPY #>STRINGARRAYS_END
BEQ ARRAYSC
BCC ARRAYSKIP2
JMP ARRAYQUIT
ARRAYSC		CMP #<STRINGARRAYS_END
BCS ARRAYQUIT
ARRAYSKIP2	STA TMP_REG
STY TMP_REG+1
JSR INITSPARAMS
LDA TMP_REG
LDY TMP_REG+1
JSR INITSTRARRAY
LDA TMP_ZP
LDY TMP_ZP+1
JMP ARRAYLOOP
ARRAYQUIT	RTS
;###################################
;###################################
RESTORE		LDA #<DATAS
LDY #>DATAS
STA DATASP
STY DATASP+1
RTS
;###################################
;###################################
REROUTE		LDA CMD_NUM		; if CMD mode, enable channel output
BEQ REROUTECMD
TAX
STA CHANNEL
JMP CHKOUT
REROUTECMD	RTS
;###################################
;###################################
RESETROUTE	LDA CMD_NUM		; if CMD mode, disable channel output
BEQ RESETROUTECMD
JMP CLRCHNEW
RESETROUTECMD
RTS
;###################################
;###################################
STROUTBRKWL	STA A_REG
STY A_REG+1
STROUTBRK	JSR REROUTE
LDA A_REG
STA INDEX1
LDA A_REG+1
STA INDEX1+1
LDY #0
LDA (INDEX1),Y
TAX
INC INDEX1
BNE PRINTSTR2
INC INDEX1+1
PRINTSTR2	JSR PRINTSTRS
LDA HIGHP			; Update the memory pointer to the last actually assigned one
STA STRBUFP
LDA HIGHP+1
STA STRBUFP+1
LDA #$0D
JSR CHROUT
JMP RESETROUTE 	;RTS is implicit
;###################################
;###################################
CLRCHNEW
LDA CHLOCKFLAG
BNE SKIPCLRCH
JMP CLRCH
SKIPCLRCH
RTS
;###################################
;###################################
<IF BOOST>
BOOSTENABLE
LDA $D030
CMP #$FF
BNE C128
RTS
C128
LDA #1
STA BOOSTFLAG
LDA #0
STA BOOSTCNT
LDA $0314
STA IRQROUT
LDA $0315
STA IRQROUT+1
SEI
LDA #<MYRASTER
STA $0314
LDA #>MYRASTER
STA $0315
LDA #46
STA $D012
LDA $D011
AND #127
STA $D011
LDA $D01A
ORA #1
STA $D01A
CLI
RTS
MYRASTER
LDA $D019
BMI RASTER
LDA $DC0D
CLI
JMP $EA31
RASTER
STA $D019
LDA $D012
CMP #254
BCS SETSTART
LDA #0
STA $D030
LDA #254
STA $D012
JMP EXIT
SETSTART
LDA #1
STA $D030
LDA #46
STA $D012
EXIT
PLA
TAY
PLA
TAX
PLA
RTI
BOOSTFLAG
.BYTE 0
BOOSTCNT
.BYTE 0
IRQROUT
.WORD 0
NOBOOST
RTS
BOOSTOFF
LDA BOOSTFLAG
BEQ NOBOOST
SEI
LDA $D01A
AND #14
STA $D01A
LDA #0
STA $D030
INC BOOSTCNT
CLI
RTS
BOOSTON
LDA BOOSTFLAG
BEQ NOBOOST
LDA BOOSTCNT
BEQ BOOSTZERO	; Zero? Then just enable boost
BPL BOOSTNOV
LDA #0			; Counter >128, then reset it anyway (should not occur)
STA BOOSTCNT
JMP BOOSTZERO
BOOSTNOV
DEC BOOSTCNT
BNE NOBOOST
BOOSTZERO
SEI
LDA $D01A
ORA #1
STA $D01A
CLI
RTS
BOOSTDIASBLE
LDA BOOSTFLAG
BEQ NOBOOST
JSR BOOSTOFF
SEI
LDA IRQROUT
STA $0314
LDA IRQROUT+1
STA $0315
CLI
RTS
</IF>
;###################################
;###############################
INITVARS
JSR INITSTRVARS
LDA #0
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: $dies ist ein text und ihm geht's gut. hier ist noch etwas mehr text.
CONST_0	.BYTE 68
.STRG "dies ist ein text und ihm geht's gut. hier ist noch etwas mehr text."
; CONST: $ich habe gehoert, dass es diesem text gut geht. ja, das stimmt, dies ist ein text und ihm geht's gut.
CONST_1	.BYTE 101
.STRG "ich habe gehoert, dass es diesem text gut geht. ja, das stimmt, dies ist ein text und ihm geht's gut."
; CONST: $in diesem text geht es gut, dies ist ein text und ihm geht's gut.
CONST_2	.BYTE 65
.STRG "in diesem text geht es gut, dies ist ein text und ihm geht's gut."
; CONST: $ich bin mir sicher, dass dieser text gut geht, dies ist ein text und ihm geht's gut.
CONST_3	.BYTE 84
.STRG "ich bin mir sicher, dass dieser text gut geht, dies ist ein text und ihm geht's gut."
; CONST: $ein text zu haben und dass es ihm gut geht, ist etwas wunderbares. dies ist ein text und ihm geht's gut.
CONST_4	.BYTE 104
.STRG "ein text zu haben und dass es ihm gut geht, ist etwas wunderbares. dies ist ein text und ihm geht's gut."
; CONST: $einige texte gehen es nicht gut, aber dieser hier, dies ist ein text und ihm geht's gut.
CONST_5	.BYTE 88
.STRG "einige texte gehen es nicht gut, aber dieser hier, dies ist ein text und ihm geht's gut."
; CONST: $dies ist ein text und ihm geht's gut. lass uns mehr darueber erfahren.
CONST_6	.BYTE 70
.STRG "dies ist ein text und ihm geht's gut. lass uns mehr darueber erfahren."
; CONST: $ich denke, es ist wichtig zu wissen, dass ein text gut geht. dies ist ein text und ihm geht's gut.
CONST_7	.BYTE 98
.STRG "ich denke, es ist wichtig zu wissen, dass ein text gut geht. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist ein gutes zeichen. dies ist ein text und ihm geht's gut.
CONST_8	.BYTE 84
.STRG "ein text, der gut geht, ist ein gutes zeichen. dies ist ein text und ihm geht's gut."
; CONST: $wenn ein text gut geht, geht es auch dem autor gut. dies ist ein text und ihm geht's gut.
CONST_9	.BYTE 89
.STRG "wenn ein text gut geht, geht es auch dem autor gut. dies ist ein text und ihm geht's gut."
; CONST: $es ist schoen zu sehen, wenn ein text gut geht. dies ist ein text und ihm geht's gut.
CONST_10	.BYTE 85
.STRG "es ist schoen zu sehen, wenn ein text gut geht. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie eine sonnenblume in einem garten. dies ist ein text und ihm geht's gut.
CONST_11	.BYTE 103
.STRG "ein text, der gut geht, ist wie eine sonnenblume in einem garten. dies ist ein text und ihm geht's gut."
; CONST: $ein text der gut geht, ist wie ein lied, das gut gesungen wird. dies ist ein text und ihm geht's gut.
CONST_12	.BYTE 101
.STRG "ein text der gut geht, ist wie ein lied, das gut gesungen wird. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein puzzle, das gut zusammengesetzt ist. dies ist ein text und ihm geht's gut.
CONST_13	.BYTE 110
.STRG "ein text, der gut geht, ist wie ein puzzle, das gut zusammengesetzt ist. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein gutes buch. dies ist ein text und ihm geht's gut.
CONST_14	.BYTE 85
.STRG "ein text, der gut geht, ist wie ein gutes buch. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein gutes essen. dies ist ein text und ihm geht's gut.
CONST_15	.BYTE 86
.STRG "ein text, der gut geht, ist wie ein gutes essen. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein guter film. dies ist ein text und ihm geht's gut.
CONST_16	.BYTE 85
.STRG "ein text, der gut geht, ist wie ein guter film. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein gutes spiel. dies ist ein text und ihm geht's gut.
CONST_17	.BYTE 86
.STRG "ein text, der gut geht, ist wie ein gutes spiel. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein guter sport. dies ist ein text und ihm geht's gut.
CONST_18	.BYTE 86
.STRG "ein text, der gut geht, ist wie ein guter sport. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein gutes hobby. dies ist ein text und ihm geht's gut.
CONST_19	.BYTE 86
.STRG "ein text, der gut geht, ist wie ein gutes hobby. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein guter freund. dies ist ein text und ihm geht's gut.
CONST_20	.BYTE 87
.STRG "ein text, der gut geht, ist wie ein guter freund. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein gutes zuhause. dies ist ein text und ihm geht's gut.
CONST_21	.BYTE 88
.STRG "ein text, der gut geht, ist wie ein gutes zuhause. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein guter urlaub. dies ist ein text und ihm geht's gut.
CONST_22	.BYTE 87
.STRG "ein text, der gut geht, ist wie ein guter urlaub. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein guter job. dies ist ein text und ihm geht's gut.
CONST_23	.BYTE 84
.STRG "ein text, der gut geht, ist wie ein guter job. dies ist ein text und ihm geht's gut."
; CONST: $ein text, der gut geht, ist wie ein gutes leben. dies ist ein text und ihm geht's gut.
CONST_24	.BYTE 86
.STRG "ein text, der gut geht, ist wie ein gutes leben. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie ein puzzle mit allen teilen an ort und stelle. dies ist ein text und ihm geht's gut.
CONST_25	.BYTE 114
.STRG "ein gut gehender text ist wie ein puzzle mit allen teilen an ort und stelle. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text erzaehlt eine geschichte, die das herz beruehrt. dies ist ein text und ihm geht's gut.
CONST_26	.BYTE 108
.STRG "ein gut gehender text erzaehlt eine geschichte, die das herz beruehrt. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text spricht die seele an. dies ist ein text und ihm geht's gut.
CONST_27	.BYTE 81
.STRG "ein gut gehender text spricht die seele an. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text bringt licht in die dunkelheit. dies ist ein text und ihm geht's gut.
CONST_28	.BYTE 91
.STRG "ein gut gehender text bringt licht in die dunkelheit. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text schenkt freude und inspiration. dies ist ein text und ihm geht's gut.
CONST_29	.BYTE 91
.STRG "ein gut gehender text schenkt freude und inspiration. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie eine oase in der wueste. dies ist ein text und ihm geht's gut.
CONST_30	.BYTE 92
.STRG "ein gut gehender text ist wie eine oase in der wueste. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie ein sonnenaufgang am morgen. dies ist ein text und ihm geht's gut.
CONST_31	.BYTE 96
.STRG "ein gut gehender text ist wie ein sonnenaufgang am morgen. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie ein lied, das im herzen nachklingt. dies ist ein text und ihm geht's gut.
CONST_32	.BYTE 103
.STRG "ein gut gehender text ist wie ein lied, das im herzen nachklingt. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie ein schatz, den man immer wieder entdeckt. dies ist ein text und ihm geht's gut.
CONST_33	.BYTE 110
.STRG "ein gut gehender text ist wie ein schatz, den man immer wieder entdeckt. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie eine tasse tee an einem kalten tag. dies ist ein text und ihm geht's gut.
CONST_34	.BYTE 103
.STRG "ein gut gehender text ist wie eine tasse tee an einem kalten tag. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie eine umarmung von einem geliebten menschen. dies ist ein text und ihm geht's gut.
CONST_35	.BYTE 111
.STRG "ein gut gehender text ist wie eine umarmung von einem geliebten menschen. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie ein atemzug frischer luft. dies ist ein text und ihm geht's gut.
CONST_36	.BYTE 94
.STRG "ein gut gehender text ist wie ein atemzug frischer luft. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie eine brise, die die seele erfrischt. dies ist ein text und ihm geht's gut.
CONST_37	.BYTE 104
.STRG "ein gut gehender text ist wie eine brise, die die seele erfrischt. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie ein geschenk, das man immer wieder aufs neue entdeckt. dies ist ein text und ihm geht's gut.
CONST_38	.BYTE 122
.STRG "ein gut gehender text ist wie ein geschenk, das man immer wieder aufs neue entdeckt. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie eine reise, die nie endet. dies ist ein text und ihm geht's gut.
CONST_39	.BYTE 94
.STRG "ein gut gehender text ist wie eine reise, die nie endet. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie ein laecheln, das die welt heller macht. dies ist ein text und ihm geht's gut.
CONST_40	.BYTE 108
.STRG "ein gut gehender text ist wie ein laecheln, das die welt heller macht. dies ist ein text und ihm geht's gut."
; CONST: $ein gut gehender text ist wie eine tuer, die zu neuen moeglichkeiten fuehrt. dies ist ein text und ihm geht's gut.
CONST_41	.BYTE 114
.STRG "ein gut gehender text ist wie eine tuer, die zu neuen moeglichkeiten fuehrt. dies ist ein text und ihm geht's gut."
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
STRINGVARS_START
; VAR: TI$
VAR_TI$ .WORD EMPTYSTR
STRINGVARS_END
STRINGARRAYS_START
STRINGARRAYS_END
VARIABLES_END
; *** INTERNAL ***
Y_REG	.REAL 0.0
C_REG	.REAL 0.0
D_REG	.REAL 0.0
E_REG	.REAL 0.0
F_REG	.REAL 0.0
A_REG	.WORD 0
B_REG	.WORD 0
CMD_NUM	.BYTE 0
CHANNEL	.BYTE 0
SP_SAVE	.BYTE 0
TMP2_REG	.WORD 0
TMP3_REG	.WORD 0
TMP4_REG	.WORD 0
AS_TMP	.WORD 0
BPOINTER_TMP	.WORD 0
BASICTEXTP	.BYTE 0
STORE1	.WORD 0
STORE2	.WORD 0
STORE3	.WORD 0
STORE4	.WORD 0
GCSTART	.WORD 0
GCLEN	.WORD 0
GCWORK	.WORD 0
INPUTLENGTH	.BYTE 0
TMP_FREG	.REAL 0
TMP2_FREG	.REAL 0
TMP_FLAG	.BYTE 0
INT_FLAG	.BYTE 0
REAL_CONST_ONE	.REAL 1.0
REAL_CONST_ZERO	.REAL 0.0
REAL_CONST_MINUS_ONE	.REAL -1.0
CHLOCKFLAG	.BYTE 0
EMPTYSTR	.BYTE 0
FPSTACKP	.WORD FPSTACK
FORSTACKP	.WORD FORSTACK
DATASP	.WORD DATAS
LASTVAR	.WORD 0
LASTVARP	.WORD 0
HIGHP	.WORD STRBUF
STRBUFP	.WORD STRBUF
ENDSTRBUF	.WORD 0
INPUTQUEUEP	.BYTE 0
PROGRAMEND
INPUTQUEUE	.ARRAY $0F
FPSTACK .ARRAY 100
FORSTACK .ARRAY 340
STRBUF	.BYTE 0
