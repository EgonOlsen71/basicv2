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
;
LINE_110:
;
LDA #<CONST_0
LDY #>CONST_0
STA TMP_ZP
STY TMP_ZP+1
; Optimizer rule: MEM->REG, REG->TMP_ZP/4
JSR WRITETID
;
LINE_120:
;
;
LINE_130:
;
LDX #4
dcloop235_1:
LDA CONST_1R,X
STA VAR_W,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_140:
;
;
LINE_150:
;
LDA #0
STA VAR_XD
STA VAR_XD+1
STA VAR_XD+2
STA VAR_XD+3
STA VAR_XD+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_YD
STA VAR_YD+1
STA VAR_YD+2
STA VAR_YD+3
STA VAR_YD+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_XH
STA VAR_XH+1
STA VAR_XH+2
STA VAR_XH+3
STA VAR_XH+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_YH
STA VAR_YH+1
STA VAR_YH+2
STA VAR_YH+3
STA VAR_YH+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_TC
STA VAR_TC+1
STA VAR_TC+2
STA VAR_TC+3
STA VAR_TC+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_T
STA VAR_T+1
STA VAR_T+2
STA VAR_T+3
STA VAR_T+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_L
STA VAR_L+1
STA VAR_L+2
STA VAR_L+3
STA VAR_L+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_R
STA VAR_R+1
STA VAR_R+2
STA VAR_R+3
STA VAR_R+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_160:
;
LDA #0
STA VAR_TT
STA VAR_TT+1
STA VAR_TT+2
STA VAR_TT+3
STA VAR_TT+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_TL
STA VAR_TL+1
STA VAR_TL+2
STA VAR_TL+3
STA VAR_TL+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_TR
STA VAR_TR+1
STA VAR_TR+2
STA VAR_TR+3
STA VAR_TR+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DL
STA VAR_DL+1
STA VAR_DL+2
STA VAR_DL+3
STA VAR_DL+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DR
STA VAR_DR+1
STA VAR_DR+2
STA VAR_DR+3
STA VAR_DR+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_U0
STA VAR_U0+1
STA VAR_U0+2
STA VAR_U0+3
STA VAR_U0+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_U1
STA VAR_U1+1
STA VAR_U1+2
STA VAR_U1+3
STA VAR_U1+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V0
STA VAR_V0+1
STA VAR_V0+2
STA VAR_V0+3
STA VAR_V0+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V1
STA VAR_V1+1
STA VAR_V1+2
STA VAR_V1+3
STA VAR_V1+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_170:
;
LDA #0
STA VAR_N
STA VAR_N+1
STA VAR_N+2
STA VAR_N+3
STA VAR_N+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DF
STA VAR_DF+1
STA VAR_DF+2
STA VAR_DF+3
STA VAR_DF+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DE
STA VAR_DE+1
STA VAR_DE+2
STA VAR_DE+3
STA VAR_DE+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_XS
STA VAR_XS+1
STA VAR_XS+2
STA VAR_XS+3
STA VAR_XS+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_XE
STA VAR_XE+1
STA VAR_XE+2
STA VAR_XE+3
STA VAR_XE+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_US
STA VAR_US+1
STA VAR_US+2
STA VAR_US+3
STA VAR_US+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_UE
STA VAR_UE+1
STA VAR_UE+2
STA VAR_UE+3
STA VAR_UE+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_VS
STA VAR_VS+1
STA VAR_VS+2
STA VAR_VS+3
STA VAR_VS+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_VE
STA VAR_VE+1
STA VAR_VE+2
STA VAR_VE+3
STA VAR_VE+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_KP
STA VAR_KP+1
STA VAR_KP+2
STA VAR_KP+3
STA VAR_KP+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_180:
;
LDA #0
STA VAR_U
STA VAR_U+1
STA VAR_U+2
STA VAR_U+3
STA VAR_U+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V
STA VAR_V+1
STA VAR_V+2
STA VAR_V+3
STA VAR_V+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_LE
STA VAR_LE+1
STA VAR_LE+2
STA VAR_LE+3
STA VAR_LE+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DU
STA VAR_DU+1
STA VAR_DU+2
STA VAR_DU+3
STA VAR_DU+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DV
STA VAR_DV+1
STA VAR_DV+2
STA VAR_DV+3
STA VAR_DV+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_TP
STA VAR_TP+1
STA VAR_TP+2
STA VAR_TP+3
STA VAR_TP+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_SI
STA VAR_SI+1
STA VAR_SI+2
STA VAR_SI+3
STA VAR_SI+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_190:
;
LDA #0
STA VAR_CO
STA VAR_CO+1
STA VAR_CO+2
STA VAR_CO+3
STA VAR_CO+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_C
STA VAR_C+1
STA VAR_C+2
STA VAR_C+3
STA VAR_C+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_MT
STA VAR_MT+1
STA VAR_MT+2
STA VAR_MT+3
STA VAR_MT+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_MA
STA VAR_MA+1
STA VAR_MA+2
STA VAR_MA+3
STA VAR_MA+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_XC
STA VAR_XC+1
STA VAR_XC+2
STA VAR_XC+3
STA VAR_XC+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_ZC
STA VAR_ZC+1
STA VAR_ZC+2
STA VAR_ZC+3
STA VAR_ZC+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_XN
STA VAR_XN+1
STA VAR_XN+2
STA VAR_XN+3
STA VAR_XN+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_YN
STA VAR_YN+1
STA VAR_YN+2
STA VAR_YN+3
STA VAR_YN+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_ZN
STA VAR_ZN+1
STA VAR_ZN+2
STA VAR_ZN+3
STA VAR_ZN+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_200:
;
JSR GOSUB
JSR LINE_2400
;
LINE_210:
;
JSR GOSUB
JSR LINE_300
;
LINE_220:
;
JSR GOSUB
JSR LINE_2310
;
LINE_230:
;
JSR GOSUB
JSR LINE_2340
;
LINE_240:
;
JSR GOSUB
JSR LINE_440
;
LINE_250:
;
<IF !X16>
SEI
LDY TIMEADDR
LDX TIMEADDR+1
LDA TIMEADDR+2
CLI
</IF>
SEC
JSR COPYTIME
JSR GETTIME
LDX #<VAR_TI
LDY #>VAR_TI
JSR FACMEM
LDX #4
dcloop401_1:
LDA VAR_TI,X
STA VAR_TT,X
DEX
BPL dcloop401_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_260:
;
;
LINE_270:
;
JSR GOSUB
JSR LINE_370
;
LINE_280:
;
LDA #<VAR_TT
LDY #>VAR_TT
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_290:
;
JSR END
RTS
;
LINE_300:
;
;
LINE_310:
;
LDA #<CONST_3
LDY #>CONST_3
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #252
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG | FAC
JSR FASTOR
; Optimizer rule: Faster logic OR/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 56576
;
LINE_320:
;
LDY 53272
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_6
LDY #>CONST_6
JSR MEMARG
JSR FASTAND
; Optimizer rule: Swap AND order/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_7R
LDY #>CONST_7R
JSR MEMARG
JSR FASTOR
; Optimizer rule: Swap OR order/7
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; FAC to integer in Y/A
JSR FACWORD
STY 53272
;
LINE_330:
;
LDA #<CONST_8
LDY #>CONST_8
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #15
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG | FAC
JSR FASTOR
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; FAC to integer in Y/A
JSR FACWORD
STY 53272
;
LINE_340:
;
LDA 53265
ORA #32
STA 53265
; Simplified POKE Y,PEEK(X) OR/AND c
;
;
;
;
;
;
;
;
; Optimizer rule: Faster PEEKBYTEOR/2
;
LINE_350:
;
LDA 53270
ORA #16
STA 53270
; Simplified POKE Y,PEEK(X) OR/AND c
;
;
;
;
;
;
;
;
; Optimizer rule: Faster PEEKBYTEOR/2
;
LINE_360:
;
JMP RETURN
;
LINE_370:
;
;
LINE_380:
;
LDA #<CONST_3
LDY #>CONST_3
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #252
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA #<CONST_15R
LDY #>CONST_15R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG | FAC
JSR FASTOR
; Optimizer rule: Faster logic OR/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 56576
;
LINE_390:
;
LDY 53272
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_6
LDY #>CONST_6
JSR MEMARG
JSR FASTAND
; Optimizer rule: Swap AND order/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR MEMARG
JSR FASTOR
; Optimizer rule: Swap OR order/7
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; FAC to integer in Y/A
JSR FACWORD
STY 53272
;
LINE_400:
;
LDA #<CONST_8
LDY #>CONST_8
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #15
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG | FAC
JSR FASTOR
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; FAC to integer in Y/A
JSR FACWORD
STY 53272
;
LINE_410:
;
LDA 53265
AND #223
STA 53265
; Simplified POKE Y,PEEK(X) OR/AND c
;
;
;
;
;
;
;
;
; Optimizer rule: Faster PEEKBYTEAND/2
;
LINE_420:
;
LDA 53270
AND #239
STA 53270
; Simplified POKE Y,PEEK(X) OR/AND c
;
;
;
;
;
;
;
;
; Optimizer rule: Faster PEEKBYTEAND/2
;
LINE_430:
;
JMP RETURN
;
LINE_440:
;
;
LINE_450:
;
JSR GOSUB
JSR LINE_2190
;
LINE_460:
LDX #4
dcloop733_1:
LDA CONST_19R,X
STA VAR_XD,X
LDA CONST_19R,X
STA VAR_YD,X
DEX
BPL dcloop733_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_470:
;
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_XD
LDY #>VAR_XD
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XH
LDY #>VAR_XH
; FAC to (X/Y)
JSR FACMEM
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_YD
LDY #>VAR_YD
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YH
LDY #>VAR_YH
; FAC to (X/Y)
JSR FACMEM
;
LINE_480:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_15R
LDY #>CONST_15R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #1
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: FAC->YREG, YREG->FAC/3
; Optimizer rule: Y_REG 2 FAC(1)/1
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG^FAC
JSR FACPOW
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<CONST_20R
LDY #>CONST_20R
JSR COPY2_XYA_XREG
; Optimizer rule: FAC->YREG, YREG->FAC/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_PT%[]
LDY #>VAR_PT%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_0
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_0:
;
LINE_490:
;
LDX #4
dcloop733_3:
LDA CONST_21,X
STA VAR_W,X
DEX
BPL dcloop733_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_500:
;
JSR GOSUB
JSR LINE_520
;
LINE_510:
;
JMP RETURN
;
LINE_520:
;
;
LINE_530:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_W
LDY #>VAR_W
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AG[]
LDY #>VAR_AG[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<CONST_16R
LDY #>CONST_16R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_7R
LDY #>CONST_7R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AG[]
LDY #>VAR_AG[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_W
LDY #>VAR_W
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AG[]
LDY #>VAR_AG[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_540:
;
JSR GOSUB
JSR LINE_1840
;
LINE_550:
;
JSR GOSUB
JSR LINE_570
;
LINE_560:
;
JMP RETURN
;
LINE_570:
;
;
LINE_580:
;
JSR GOSUB
JSR LINE_2310
;
LINE_590:
;
LDA #0
STA VAR_TC
STA VAR_TC+1
STA VAR_TC+2
STA VAR_TC+3
STA VAR_TC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_600:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_22R
LDY #>CONST_22R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP1
STA JUMP_TARGET
LDA #>FORLOOP1
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP1:
;
LINE_610:
;
LDA #0
STA VAR_T
STA VAR_T+1
STA VAR_T+2
STA VAR_T+3
STA VAR_T+4
LDX #4
dcloop899_1:
LDA CONST_15R,X
STA VAR_L,X
LDA CONST_24R,X
STA VAR_R,X
DEX
BPL dcloop899_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_620:
;
LDA #0
STA VAR_TT
STA VAR_TT+1
STA VAR_TT+2
STA VAR_TT+3
STA VAR_TT+4
LDX #4
dcloop899_3:
LDA CONST_5R,X
STA VAR_TL,X
LDA CONST_25R,X
STA VAR_TR,X
DEX
BPL dcloop899_3
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_630:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_25R
LDY #>CONST_25R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ GTEQ_GTEQ0
BCS GTEQ_GTEQ0
LDA #0
JMP GTEQ_SKIP0
GTEQ_GTEQ0:
LDA #$1
GTEQ_SKIP0:
COMP_SKP1:
BEQ LINE_SKIP15
; Simplified conditional branch
;
LINE_NSKIP15:
;
JMP LINE_660
;
LINE_SKIP15:
;
;
LINE_640:
LDX #4
dcloop899_5:
LDA CONST_15R,X
STA VAR_T,X
LDA CONST_24R,X
STA VAR_L,X
DEX
BPL dcloop899_5
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_R
STA VAR_R+1
STA VAR_R+2
STA VAR_R+3
STA VAR_R+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_650:
LDX #4
dcloop1065_1:
LDA CONST_5R,X
STA VAR_TT,X
LDA CONST_25R,X
STA VAR_TL,X
DEX
BPL dcloop1065_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_TR
STA VAR_TR+1
STA VAR_TR+2
STA VAR_TR+3
STA VAR_TR+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_660:
;
;
LINE_670:
;
LDA #<VAR_T
LDY #>VAR_T
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_26R
LDY #>CONST_26R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ GTEQ_GTEQ1
BCS GTEQ_GTEQ1
LDA #0
JMP GTEQ_SKIP1
GTEQ_GTEQ1:
LDA #$1
GTEQ_SKIP1:
COMP_SKP2:
BEQ LINE_SKIP16
; Simplified conditional branch
;
LINE_NSKIP16:
;
JMP LINE_700
;
LINE_SKIP16:
;
;
LINE_680:
;
LDX #4
dcloop1065_3:
LDA CONST_24R,X
STA VAR_T,X
DEX
BPL dcloop1065_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_L
STA VAR_L+1
STA VAR_L+2
STA VAR_L+3
STA VAR_L+4
; Optimizer rule: Simplified setting to 0/6
LDX #4
dcloop1065_4:
LDA CONST_15R,X
STA VAR_R,X
DEX
BPL dcloop1065_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_690:
;
LDX #4
dcloop1065_5:
LDA CONST_25R,X
STA VAR_TT,X
DEX
BPL dcloop1065_5
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_TL
STA VAR_TL+1
STA VAR_TL+2
STA VAR_TL+3
STA VAR_TL+4
; Optimizer rule: Simplified setting to 0/6
LDX #4
dcloop1065_6:
LDA CONST_5R,X
STA VAR_TR,X
DEX
BPL dcloop1065_6
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_700:
;
;
LINE_710:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_720:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<VAR_L
LDY #>VAR_L
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_L
LDY #>VAR_L
; FAC to (X/Y)
JSR FACMEM
;
LINE_730:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_R
LDY #>VAR_R
; FAC to (X/Y)
JSR FACMEM
;
LINE_740:
;
LDA #<VAR_TC
LDY #>VAR_TC
JSR REALFAC
LDA #<VAR_TT
LDY #>VAR_TT
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_TT
LDY #>VAR_TT
; FAC to (X/Y)
JSR FACMEM
;
LINE_750:
;
LDA #<VAR_TC
LDY #>VAR_TC
JSR REALFAC
LDA #<VAR_TL
LDY #>VAR_TL
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_TL
LDY #>VAR_TL
; FAC to (X/Y)
JSR FACMEM
;
LINE_760:
;
LDA #<VAR_TC
LDY #>VAR_TC
JSR REALFAC
LDA #<VAR_TR
LDY #>VAR_TR
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_TR
LDY #>VAR_TR
; FAC to (X/Y)
JSR FACMEM
;
LINE_770:
;
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_L
LDY #>VAR_L
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DL
LDY #>VAR_DL
; FAC to (X/Y)
JSR FACMEM
;
LINE_780:
;
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DR
LDY #>VAR_DR
; FAC to (X/Y)
JSR FACMEM
;
LINE_790:
;
LDA #<VAR_TT
LDY #>VAR_TT
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_TL
LDY #>VAR_TL
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U0
LDY #>VAR_U0
; FAC to (X/Y)
JSR FACMEM
;
LINE_800:
;
LDA #<VAR_TT
LDY #>VAR_TT
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_TR
LDY #>VAR_TR
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U1
LDY #>VAR_U1
; FAC to (X/Y)
JSR FACMEM
;
LINE_810:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TT
LDY #>VAR_TT
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TL
LDY #>VAR_TL
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V0
LDY #>VAR_V0
; FAC to (X/Y)
JSR FACMEM
;
LINE_820:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TT
LDY #>VAR_TT
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TR
LDY #>VAR_TR
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V1
LDY #>VAR_V1
; FAC to (X/Y)
JSR FACMEM
;
LINE_830:
;
LDX #4
dcloop1397_1:
LDA VAR_L,X
STA VAR_N,X
DEX
BPL dcloop1397_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_840:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_N
LDY #>VAR_N
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BCC LTEQ_LTEQ2
BEQ LTEQ_LTEQ2
LDA #0
JMP LTEQ_SKIP2
LTEQ_LTEQ2:
LDA #$1
LTEQ_SKIP2:
COMP_SKP3:
BEQ LINE_SKIP17
; Simplified conditional branch
;
LINE_NSKIP17:
;
JMP LINE_860
;
LINE_SKIP17:
;
;
LINE_850:
;
LDX #4
dcloop1563_1:
LDA VAR_R,X
STA VAR_N,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_860:
;
;
LINE_870:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_L
LDY #>VAR_L
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DF
LDY #>VAR_DF
; FAC to (X/Y)
JSR FACMEM
;
LINE_880:
;
LDA VAR_DF
COMP_SKP4:
BEQ LINE_SKIP18
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP18:
;
JMP LINE_910
;
LINE_SKIP18:
;
;
LINE_890:
;
LDA #0
STA VAR_DL
STA VAR_DL+1
STA VAR_DL+2
STA VAR_DL+3
STA VAR_DL+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_U0
STA VAR_U0+1
STA VAR_U0+2
STA VAR_U0+3
STA VAR_U0+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V0
STA VAR_V0+1
STA VAR_V0+2
STA VAR_V0+3
STA VAR_V0+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_900:
;
JMP LINE_950
;
LINE_910:
;
;
LINE_920:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_DL
LDY #>VAR_DL
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DL
LDY #>VAR_DL
; FAC to (X/Y)
JSR FACMEM
;
LINE_930:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_U0
LDY #>VAR_U0
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U0
LDY #>VAR_U0
; FAC to (X/Y)
JSR FACMEM
;
LINE_940:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_V0
LDY #>VAR_V0
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V0
LDY #>VAR_V0
; FAC to (X/Y)
JSR FACMEM
;
LINE_950:
;
;
LINE_960:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DE
LDY #>VAR_DE
; FAC to (X/Y)
JSR FACMEM
;
LINE_970:
;
LDA VAR_DE
COMP_SKP5:
BEQ LINE_SKIP19
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP19:
;
JMP LINE_1000
;
LINE_SKIP19:
;
;
LINE_980:
;
LDA #0
STA VAR_DR
STA VAR_DR+1
STA VAR_DR+2
STA VAR_DR+3
STA VAR_DR+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_U1
STA VAR_U1+1
STA VAR_U1+2
STA VAR_U1+3
STA VAR_U1+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V1
STA VAR_V1+1
STA VAR_V1+2
STA VAR_V1+3
STA VAR_V1+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_990:
;
JMP LINE_1040
;
LINE_1000:
;
;
LINE_1010:
;
LDA #<VAR_DE
LDY #>VAR_DE
JSR REALFAC
LDA #<VAR_DR
LDY #>VAR_DR
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DR
LDY #>VAR_DR
; FAC to (X/Y)
JSR FACMEM
;
LINE_1020:
;
LDA #<VAR_DE
LDY #>VAR_DE
JSR REALFAC
LDA #<VAR_U1
LDY #>VAR_U1
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U1
LDY #>VAR_U1
; FAC to (X/Y)
JSR FACMEM
;
LINE_1030:
;
LDA #<VAR_DE
LDY #>VAR_DE
JSR REALFAC
LDA #<VAR_V1
LDY #>VAR_V1
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V1
LDY #>VAR_V1
; FAC to (X/Y)
JSR FACMEM
;
LINE_1040:
;
;
LINE_1050:
;
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XS
LDY #>VAR_XS
; FAC to (X/Y)
JSR FACMEM
;
LINE_1060:
;
LDA #<VAR_TT
LDY #>VAR_TT
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_US
LDY #>VAR_US
; FAC to (X/Y)
JSR FACMEM
;
LINE_1070:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TT
LDY #>VAR_TT
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_VS
LDY #>VAR_VS
; FAC to (X/Y)
JSR FACMEM
;
LINE_1080:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_L
LDY #>VAR_L
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
LDA #<X_REG
LDY #>X_REG
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc (mul)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_KP
LDY #>VAR_KP
; FAC to (X/Y)
JSR FACMEM
;
LINE_1090:
;
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_L
LDY #>VAR_L
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
LDA #<X_REG
LDY #>X_REG
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc (mul)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_KP
LDY #>VAR_KP
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_KP
LDY #>VAR_KP
; FAC to (X/Y)
JSR FACMEM
;
LINE_1100:
;
;
LINE_1110:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
LDA #<VAR_KP
LDY #>VAR_KP
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ3
BEQ LTEQ_LTEQ3
LDA #0
JMP LTEQ_SKIP3
LTEQ_LTEQ3:
LDA #$1
LTEQ_SKIP3:
COMP_SKP6:
BEQ LINE_SKIP20
; Simplified conditional branch
;
LINE_NSKIP20:
;
JMP LINE_1190
;
LINE_SKIP20:
;
;
LINE_1120:
;
;
LINE_1130:
LDX #4
dcloop1895_1:
LDA VAR_DL,X
STA VAR_Q,X
LDA VAR_DR,X
STA VAR_DL,X
LDA VAR_Q,X
STA VAR_DR,X
DEX
BPL dcloop1895_1
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1140:
LDX #4
dcloop1895_4:
LDA VAR_DF,X
STA VAR_Q,X
LDA VAR_DE,X
STA VAR_DF,X
LDA VAR_Q,X
STA VAR_DE,X
DEX
BPL dcloop1895_4
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1150:
LDX #4
dcloop1895_7:
LDA VAR_L,X
STA VAR_Q,X
LDA VAR_R,X
STA VAR_L,X
LDA VAR_Q,X
STA VAR_R,X
DEX
BPL dcloop1895_7
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1160:
LDX #4
dcloop2061_1:
LDA VAR_TL,X
STA VAR_Q,X
LDA VAR_TR,X
STA VAR_TL,X
LDA VAR_Q,X
STA VAR_TR,X
DEX
BPL dcloop2061_1
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1170:
LDX #4
dcloop2061_4:
LDA VAR_U0,X
STA VAR_Q,X
LDA VAR_U1,X
STA VAR_U0,X
LDA VAR_Q,X
STA VAR_U1,X
DEX
BPL dcloop2061_4
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1180:
LDX #4
dcloop2061_7:
LDA VAR_V0,X
STA VAR_Q,X
LDA VAR_V1,X
STA VAR_V0,X
LDA VAR_Q,X
STA VAR_V1,X
DEX
BPL dcloop2061_7
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1190:
;
;
LINE_1200:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
;
LINE_1210:
;
LDX #4
dcloop2061_10:
LDA VAR_US,X
STA VAR_UE,X
DEX
BPL dcloop2061_10
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1220:
;
LDX #4
dcloop2061_11:
LDA VAR_VS,X
STA VAR_VE,X
DEX
BPL dcloop2061_11
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1230:
;
LDA #<VAR_DR
LDY #>VAR_DR
JSR REALFAC
LDA #<VAR_DE
LDY #>VAR_DE
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XE
LDY #>VAR_XE
; FAC to (X/Y)
JSR FACMEM
;
LINE_1240:
;
;
LINE_1250:
;
LDA #0
STA VAR_IT
STA VAR_IT+1
STA VAR_IT+2
STA VAR_IT+3
STA VAR_IT+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_IT
LDY #>VAR_IT
STA A_REG
STY A_REG+1
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
;
LINE_1260:
;
;
LINE_1270:
LDX #4
dcloop2227_1:
LDA VAR_US,X
STA VAR_U,X
LDA VAR_VS,X
STA VAR_V,X
DEX
BPL dcloop2227_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1280:
;
LDA #<VAR_XS
LDY #>VAR_XS
JSR REALFAC
LDA #<VAR_XE
LDY #>VAR_XE
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_LE
LDY #>VAR_LE
; FAC to (X/Y)
JSR FACMEM
;
LINE_1290:
;
LDA #0
STA VAR_DU
STA VAR_DU+1
STA VAR_DU+2
STA VAR_DU+3
STA VAR_DU+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DV
STA VAR_DV+1
STA VAR_DV+2
STA VAR_DV+3
STA VAR_DV+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1300:
;
LDA VAR_LE
BEQ EQ_SKIP4
EQ_EQ4:
JMP LINE_SKIP21
EQ_SKIP4:
COMP_SKP7:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP21:
;
JMP LINE_1330
;
LINE_SKIP21:
;
;
LINE_1310:
;
LDA #<VAR_US
LDY #>VAR_US
JSR REALFAC
LDA #<VAR_UE
LDY #>VAR_UE
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_LE
LDY #>VAR_LE
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DU
LDY #>VAR_DU
; FAC to (X/Y)
JSR FACMEM
;
LINE_1320:
;
LDA #<VAR_VS
LDY #>VAR_VS
JSR REALFAC
LDA #<VAR_VE
LDY #>VAR_VE
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_LE
LDY #>VAR_LE
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DV
LDY #>VAR_DV
; FAC to (X/Y)
JSR FACMEM
;
LINE_1330:
;
;
LINE_1340:
;
LDA #<CONST_26R
LDY #>CONST_26R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #3
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_Y
LDY #>VAR_Y
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #8
LDA #0
STY A_REG
STA A_REG+1
JSR COPY_XREG2YREG
; Optimizer rule: FAC already populated/6
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC = FAC<<A
JSR SHL
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #6
LDA #0
STY A_REG
STA A_REG+1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
; FAC = FAC<<A
JSR SHL
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_28R
LDY #>CONST_28R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MT
LDY #>VAR_MT
; FAC to (X/Y)
JSR FACMEM
;
LINE_1350:
;
LDY #7
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_XS
LDY #>VAR_XS
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
LDY #7
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_XE
LDY #>VAR_XE
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
;
LINE_1360:
;
LDY #7
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_U
LDY #>VAR_U
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_V
LDY #>VAR_V
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_29R
LDY #>CONST_29R
JSR MEMARG
JSR FASTAND
; Optimizer rule: Swap AND order/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_TP
LDY #>VAR_TP
; FAC to (X/Y)
JSR FACMEM
;
LINE_1370:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_MT
LDY #>VAR_MT
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MA
LDY #>VAR_MA
; FAC to (X/Y)
JSR FACMEM
;
LINE_1380:
;
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_15R
LDY #>CONST_15R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDA #<VAR_PT%[]
LDY #>VAR_PT%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_30R
LDY #>CONST_30R
JSR REALFAC
LDA #<VAR_TP
LDY #>VAR_TP
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_31
LDY #>CONST_31
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF13+1
STA MOVBSELF13+2
MOVBSELF13:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
LDA #<X_REG
LDY #>X_REG
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc (mul)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF14+1
STA MOVBSELF14+2
MOVBSELF14:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF15+1
STA MOVBSELF15+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF15:
STY $FFFF
;
LINE_1390:
;
LDA #<VAR_DU
LDY #>VAR_DU
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_DV
LDY #>VAR_DV
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V
LDY #>VAR_V
; FAC to (X/Y)
JSR FACMEM
;
LINE_1400:
;
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
;
LINE_1410:
;
LDA #<VAR_DL
LDY #>VAR_DL
JSR REALFAC
LDA #<VAR_XS
LDY #>VAR_XS
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XS
LDY #>VAR_XS
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_DR
LDY #>VAR_DR
JSR REALFAC
LDA #<VAR_XE
LDY #>VAR_XE
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XE
LDY #>VAR_XE
; FAC to (X/Y)
JSR FACMEM
;
LINE_1420:
;
LDA #<VAR_U0
LDY #>VAR_U0
JSR REALFAC
LDA #<VAR_US
LDY #>VAR_US
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_US
LDY #>VAR_US
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_V0
LDY #>VAR_V0
JSR REALFAC
LDA #<VAR_VS
LDY #>VAR_VS
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_VS
LDY #>VAR_VS
; FAC to (X/Y)
JSR FACMEM
;
LINE_1430:
;
LDA #<VAR_U1
LDY #>VAR_U1
JSR REALFAC
LDA #<VAR_UE
LDY #>VAR_UE
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_UE
LDY #>VAR_UE
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_V1
LDY #>VAR_V1
JSR REALFAC
LDA #<VAR_VE
LDY #>VAR_VE
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_VE
LDY #>VAR_VE
; FAC to (X/Y)
JSR FACMEM
;
LINE_1440:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Y
LDY #>VAR_Y
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
;
LINE_1450:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_N
LDY #>VAR_N
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR XREGFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BCC LTEQ_LTEQ5
BEQ LTEQ_LTEQ5
LDA #0
JMP LTEQ_SKIP5
LTEQ_LTEQ5:
LDA #$1
LTEQ_SKIP5:
COMP_SKP9:
BEQ LINE_SKIP22
; Simplified conditional branch
;
LINE_NSKIP22:
;
JMP LINE_1260
;
LINE_SKIP22:
;
;
LINE_1460:
;
LDX #4
dceloop4982_1:
LDA VAR_R,X
CMP VAR_N,X
BNE LINE_SKIP23
DEX
BPL dceloop4982_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP23:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1630
;
LINE_SKIP23:
;
;
LINE_1470:
;
LDX #4
dcloop2725_1:
LDA VAR_R,X
STA VAR_N,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1480:
;
LDA #<VAR_L
LDY #>VAR_L
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DL
LDY #>VAR_DL
; FAC to (X/Y)
JSR FACMEM
;
LINE_1490:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_L
LDY #>VAR_L
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DF
LDY #>VAR_DF
; FAC to (X/Y)
JSR FACMEM
;
LINE_1500:
;
LDA #<VAR_L
LDY #>VAR_L
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XS
LDY #>VAR_XS
; FAC to (X/Y)
JSR FACMEM
;
LINE_1510:
;
LDA #<VAR_TL
LDY #>VAR_TL
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_TR
LDY #>VAR_TR
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U0
LDY #>VAR_U0
; FAC to (X/Y)
JSR FACMEM
;
LINE_1520:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TL
LDY #>VAR_TL
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TR
LDY #>VAR_TR
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V0
LDY #>VAR_V0
; FAC to (X/Y)
JSR FACMEM
;
LINE_1530:
;
LDA #<VAR_TL
LDY #>VAR_TL
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_US
LDY #>VAR_US
; FAC to (X/Y)
JSR FACMEM
;
LINE_1540:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TL
LDY #>VAR_TL
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_VS
LDY #>VAR_VS
; FAC to (X/Y)
JSR FACMEM
;
LINE_1550:
;
LDA VAR_DF
COMP_SKP11:
BEQ LINE_SKIP24
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP24:
;
JMP LINE_1580
;
LINE_SKIP24:
;
;
LINE_1560:
;
LDA #0
STA VAR_DL
STA VAR_DL+1
STA VAR_DL+2
STA VAR_DL+3
STA VAR_DL+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_U0
STA VAR_U0+1
STA VAR_U0+2
STA VAR_U0+3
STA VAR_U0+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V0
STA VAR_V0+1
STA VAR_V0+2
STA VAR_V0+3
STA VAR_V0+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1570:
;
JMP LINE_1790
;
LINE_1580:
;
;
LINE_1590:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_DL
LDY #>VAR_DL
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DL
LDY #>VAR_DL
; FAC to (X/Y)
JSR FACMEM
;
LINE_1600:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_U0
LDY #>VAR_U0
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U0
LDY #>VAR_U0
; FAC to (X/Y)
JSR FACMEM
;
LINE_1610:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_V0
LDY #>VAR_V0
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V0
LDY #>VAR_V0
; FAC to (X/Y)
JSR FACMEM
;
LINE_1620:
;
JMP LINE_1790
;
LINE_1630:
;
;
LINE_1640:
;
LDX #4
dcloop3057_1:
LDA VAR_L,X
STA VAR_N,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1650:
;
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_L
LDY #>VAR_L
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DR
LDY #>VAR_DR
; FAC to (X/Y)
JSR FACMEM
;
LINE_1660:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_L
LDY #>VAR_L
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DF
LDY #>VAR_DF
; FAC to (X/Y)
JSR FACMEM
;
LINE_1670:
;
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XE
LDY #>VAR_XE
; FAC to (X/Y)
JSR FACMEM
;
LINE_1680:
;
LDA #<VAR_TR
LDY #>VAR_TR
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_TL
LDY #>VAR_TL
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U1
LDY #>VAR_U1
; FAC to (X/Y)
JSR FACMEM
;
LINE_1690:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TR
LDY #>VAR_TR
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TL
LDY #>VAR_TL
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V1
LDY #>VAR_V1
; FAC to (X/Y)
JSR FACMEM
;
LINE_1700:
;
LDA #<VAR_TR
LDY #>VAR_TR
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_UE
LDY #>VAR_UE
; FAC to (X/Y)
JSR FACMEM
;
LINE_1710:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_TR
LDY #>VAR_TR
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_VE
LDY #>VAR_VE
; FAC to (X/Y)
JSR FACMEM
;
LINE_1720:
;
LDA VAR_DF
COMP_SKP12:
BEQ LINE_SKIP25
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP25:
;
JMP LINE_1750
;
LINE_SKIP25:
;
;
LINE_1730:
;
LDA #0
STA VAR_DR
STA VAR_DR+1
STA VAR_DR+2
STA VAR_DR+3
STA VAR_DR+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_U1
STA VAR_U1+1
STA VAR_U1+2
STA VAR_U1+3
STA VAR_U1+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V1
STA VAR_V1+1
STA VAR_V1+2
STA VAR_V1+3
STA VAR_V1+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1740:
;
JMP LINE_1790
;
LINE_1750:
;
;
LINE_1760:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_DR
LDY #>VAR_DR
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DR
LDY #>VAR_DR
; FAC to (X/Y)
JSR FACMEM
;
LINE_1770:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_U1
LDY #>VAR_U1
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U1
LDY #>VAR_U1
; FAC to (X/Y)
JSR FACMEM
;
LINE_1780:
;
LDA #<VAR_DF
LDY #>VAR_DF
JSR REALFAC
LDA #<VAR_V1
LDY #>VAR_V1
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V1
LDY #>VAR_V1
; FAC to (X/Y)
JSR FACMEM
;
LINE_1790:
;
;
LINE_1800:
;
LDA #<VAR_IT
LDY #>VAR_IT
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_2
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_2:
;
LINE_1810:
;
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
LDA #<VAR_TC
LDY #>VAR_TC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_TC
LDY #>VAR_TC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1820:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_3
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_3:
;
LINE_1830:
;
JMP RETURN
;
LINE_1840:
;
;
LINE_1850:
;
LDA #0
STA VAR_C
STA VAR_C+1
STA VAR_C+2
STA VAR_C+3
STA VAR_C+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1860:
;
LDA #0
STA VAR_P
STA VAR_P+1
STA VAR_P+2
STA VAR_P+3
STA VAR_P+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_22R
LDY #>CONST_22R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_15R
LDY #>CONST_15R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
;
LINE_1870:
;
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_XC
LDY #>VAR_XC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1880:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_YC
LDY #>VAR_YC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1890:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_32
LDY #>CONST_32
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ZC
LDY #>VAR_ZC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1900:
LDX #4
dcloop3389_1:
LDA VAR_XC,X
STA VAR_XN,X
LDA VAR_YC,X
STA VAR_YN,X
LDA VAR_ZC,X
STA VAR_ZN,X
DEX
BPL dcloop3389_1
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1910:
;
LDA #<VAR_AG[]+0
LDY #>VAR_AG[]+0
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA X_REG
BEQ EQ_EQ7
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP7
EQ_EQ7:
LDA #$1
EQ_SKIP7:
COMP_SKP15:
BEQ LINE_SKIP26
; Simplified conditional branch
;
LINE_NSKIP26:
;
JMP LINE_1980
;
LINE_SKIP26:
;
;
LINE_1920:
;
LDA #<VAR_AG[]+0
LDY #>VAR_AG[]+0
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = SIN(FAC)
JSR FACSIN
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SI
LDY #>VAR_SI
; FAC to (X/Y)
JSR FACMEM
;
LINE_1930:
;
LDA #<VAR_AG[]+0
LDY #>VAR_AG[]+0
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = COS(FAC)
JSR FACCOS
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CO
LDY #>VAR_CO
; FAC to (X/Y)
JSR FACMEM
;
LINE_1940:
;
LDA #<VAR_SI
LDY #>VAR_SI
JSR REALFAC
LDA #<VAR_ZC
LDY #>VAR_ZC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_CO
LDY #>VAR_CO
JSR REALFAC
LDA #<VAR_YC
LDY #>VAR_YC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YN
LDY #>VAR_YN
; FAC to (X/Y)
JSR FACMEM
;
LINE_1950:
;
LDA #<VAR_CO
LDY #>VAR_CO
JSR REALFAC
LDA #<VAR_ZC
LDY #>VAR_ZC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_SI
LDY #>VAR_SI
JSR REALFAC
LDA #<VAR_YC
LDY #>VAR_YC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ZN
LDY #>VAR_ZN
; FAC to (X/Y)
JSR FACMEM
;
LINE_1960:
;
LDX #4
dcloop3555_1:
LDA VAR_YN,X
STA VAR_YC,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1970:
;
LDX #4
dcloop3555_2:
LDA VAR_ZN,X
STA VAR_ZC,X
DEX
BPL dcloop3555_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1980:
;
;
LINE_1990:
;
LDA #<VAR_AG[]+5
LDY #>VAR_AG[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA X_REG
BEQ EQ_EQ8
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP8
EQ_EQ8:
LDA #$1
EQ_SKIP8:
COMP_SKP16:
BEQ LINE_SKIP27
; Simplified conditional branch
;
LINE_NSKIP27:
;
JMP LINE_2060
;
LINE_SKIP27:
;
;
LINE_2000:
;
LDA #<VAR_AG[]+5
LDY #>VAR_AG[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = SIN(FAC)
JSR FACSIN
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SI
LDY #>VAR_SI
; FAC to (X/Y)
JSR FACMEM
;
LINE_2010:
;
LDA #<VAR_AG[]+5
LDY #>VAR_AG[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = COS(FAC)
JSR FACCOS
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CO
LDY #>VAR_CO
; FAC to (X/Y)
JSR FACMEM
;
LINE_2020:
;
LDA #<VAR_SI
LDY #>VAR_SI
JSR REALFAC
LDA #<VAR_XC
LDY #>VAR_XC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_CO
LDY #>VAR_CO
JSR REALFAC
LDA #<VAR_ZC
LDY #>VAR_ZC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ZN
LDY #>VAR_ZN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2030:
;
LDA #<VAR_CO
LDY #>VAR_CO
JSR REALFAC
LDA #<VAR_XC
LDY #>VAR_XC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_SI
LDY #>VAR_SI
JSR REALFAC
LDA #<VAR_ZC
LDY #>VAR_ZC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XN
LDY #>VAR_XN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2040:
;
LDX #4
dcloop3721_1:
LDA VAR_XN,X
STA VAR_XC,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2050:
;
LDX #4
dcloop3721_2:
LDA VAR_ZN,X
STA VAR_ZC,X
DEX
BPL dcloop3721_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2060:
;
;
LINE_2070:
;
LDA #<VAR_AG[]+10
LDY #>VAR_AG[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA X_REG
BEQ EQ_EQ9
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP9
EQ_EQ9:
LDA #$1
EQ_SKIP9:
COMP_SKP17:
BEQ LINE_SKIP28
; Simplified conditional branch
;
LINE_NSKIP28:
;
JMP LINE_2120
;
LINE_SKIP28:
;
;
LINE_2080:
;
LDA #<VAR_AG[]+10
LDY #>VAR_AG[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = SIN(FAC)
JSR FACSIN
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SI
LDY #>VAR_SI
; FAC to (X/Y)
JSR FACMEM
;
LINE_2090:
;
LDA #<VAR_AG[]+10
LDY #>VAR_AG[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = COS(FAC)
JSR FACCOS
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CO
LDY #>VAR_CO
; FAC to (X/Y)
JSR FACMEM
;
LINE_2100:
;
LDA #<VAR_SI
LDY #>VAR_SI
JSR REALFAC
LDA #<VAR_YC
LDY #>VAR_YC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_CO
LDY #>VAR_CO
JSR REALFAC
LDA #<VAR_XC
LDY #>VAR_XC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XN
LDY #>VAR_XN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2110:
;
LDA #<VAR_CO
LDY #>VAR_CO
JSR REALFAC
LDA #<VAR_YC
LDY #>VAR_YC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_SI
LDY #>VAR_SI
JSR REALFAC
LDA #<VAR_XC
LDY #>VAR_XC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YN
LDY #>VAR_YN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2120:
;
;
LINE_2130:
;
LDA #<CONST_32
LDY #>CONST_32
JSR REALFAC
LDA #<VAR_ZN
LDY #>VAR_ZN
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ZN
LDY #>VAR_ZN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2140:
;
LDA #<VAR_C
LDY #>VAR_C
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_XN
LDY #>VAR_XN
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_ZN
LDY #>VAR_ZN
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_XH
LDY #>VAR_XH
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
;
LINE_2150:
;
LDA #<VAR_C
LDY #>VAR_C
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_YN
LDY #>VAR_YN
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #7
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_ZN
LDY #>VAR_ZN
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_YH
LDY #>VAR_YH
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
;
LINE_2160:
;
LDA #<VAR_C
LDY #>VAR_C
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_2
LDY #>CONST_2
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
;
LINE_2170:
;
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_4
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_4:
;
LINE_2180:
;
JMP RETURN
;
LINE_2190:
;
;
LINE_2200:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_33
LDY #>CONST_33
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #10
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
LDY #1
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_35
LDY #>CONST_35
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_2210:
;
LDY #10
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
LDY #3
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDA #<CONST_25R
LDY #>CONST_25R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_33
LDY #>CONST_33
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_36R
LDY #>CONST_36R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_35
LDY #>CONST_35
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_2220:
;
LDA #<CONST_24R
LDY #>CONST_24R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_33
LDY #>CONST_33
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_26R
LDY #>CONST_26R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_33
LDY #>CONST_33
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_27R
LDY #>CONST_27R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_35
LDY #>CONST_35
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_2230:
;
LDY #10
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
LDY #9
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #10
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
LDY #10
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDA #<CONST_37R
LDY #>CONST_37R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_35
LDY #>CONST_35
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_2240:
;
LDY #10
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
LDY #12
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDA #<CONST_39R
LDY #>CONST_39R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_33
LDY #>CONST_33
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_40R
LDY #>CONST_40R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_35
LDY #>CONST_35
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_2250:
;
LDA #<CONST_9R
LDY #>CONST_9R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_33
LDY #>CONST_33
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #10
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
LDY #16
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDA #<CONST_22R
LDY #>CONST_22R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_35
LDY #>CONST_35
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_2260:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_41
LDY #>CONST_41
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
LDY #1
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
LDY #2
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_2270:
;
LDA #<CONST_15R
LDY #>CONST_15R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_41
LDY #>CONST_41
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_25R
LDY #>CONST_25R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_41
LDY #>CONST_41
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_36R
LDY #>CONST_36R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_41
LDY #>CONST_41
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_2280:
;
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
LDY #6
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
LDY #7
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
LDY #8
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_2290:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_41
LDY #>CONST_41
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_34R
LDY #>CONST_34R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_41
LDY #>CONST_41
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
STA G_REG
STY G_REG+1
LDY #11
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_2300:
;
JMP RETURN
;
LINE_2310:
;
;
LINE_2320:
;
LDX #4
dcloop4385_1:
LDA CONST_28R,X
STA VAR_I,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<CONST_7R
LDY #>CONST_7R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP19
CMP A_REG+1
BNE COMP_SKP19
COMP_SKP19:
BNE RBEQ_5
JMP (JUMP_TARGET)
RBEQ_5:
;
LINE_2330:
;
JMP RETURN
;
LINE_2340:
;
;
LINE_2350:
;
LDY #1
STY 53281
; Optimizer rule: Simple POKE/2
;
LINE_2360:
;
LDX #4
dcloop4551_1:
LDA CONST_43R,X
STA VAR_V,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2370:
;
LDX #4
dcloop4551_2:
LDA CONST_44R,X
STA VAR_I,X
DEX
BPL dcloop4551_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_45R
LDY #>CONST_45R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<VAR_V
LDY #>VAR_V
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP20
CMP A_REG+1
BNE COMP_SKP20
COMP_SKP20:
BNE RBEQ_6
JMP (JUMP_TARGET)
RBEQ_6:
;
LINE_2380:
;
LDX #4
dcloop4551_3:
LDA CONST_46,X
STA VAR_I,X
DEX
BPL dcloop4551_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_47
LDY #>CONST_47
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP21
CMP A_REG+1
BNE COMP_SKP21
COMP_SKP21:
BNE RBEQ_7
JMP (JUMP_TARGET)
RBEQ_7:
;
LINE_2390:
;
JMP RETURN
;
LINE_2400:
;
;
LINE_2410:
;
LDA #<CONST_48
LDY #>CONST_48
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2420:
;
LDA #<CONST_31
LDY #>CONST_31
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
;
LINE_2430:
;
;
LINE_2440:
;
JSR READNUMBER
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
JSR READMAYBEBYTE
; Optimizer rule: Improved READ for bytes/1
STY VAR_V%
STA VAR_V%+1
;
LINE_2450:
;
LDA VAR_C
BEQ EQ_SKIP10
EQ_EQ10:
JMP LINE_SKIP29
EQ_SKIP10:
COMP_SKP22:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP29:
;
JMP LINE_2520
;
LINE_SKIP29:
;
;
LINE_2460:
;
LDX #4
dcloop4551_4:
LDA CONST_16R,X
STA VAR_I,X
DEX
BPL dcloop4551_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_C
LDY #>VAR_C
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
;
LINE_2470:
;
LDA #<VAR_P
LDY #>VAR_P
JSR REALFAC
; Optimizer rule: Remove FAC/PUSH/POP/1
JSR FACWORD
STY MOVBSELF17+1
STA MOVBSELF17+2
LDY VAR_V%
MOVBSELF17:
STY $FFFF
; Optimized code for POKE of Integer values(1)
;
;
;
;
;
;
;
;
;
;
LINE_2480:
;
LDY VAR_V%
STY 53280
LINE_2490:
; Optimizer rule: Remove unneeded LDA calls(2)/3
;
LDA #<CONST_25R
LDY #>CONST_25R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
;
LINE_2500:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_8
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_8:
;
LINE_2510:
;
JMP LINE_2430
;
LINE_2520:
;
;
LINE_2530:
;
LDX #4
dcloop4717_1:
LDA CONST_31,X
STA VAR_I,X
DEX
BPL dcloop4717_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_49
LDY #>CONST_49
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_25R
LDY #>CONST_25R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
;
LINE_2540:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF19+1
STA MOVBSELF19+2
MOVBSELF19:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V
LDY #>VAR_V
; FAC to (X/Y)
JSR FACMEM
;
LINE_2550:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_50R
LDY #>CONST_50R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF20+1
STA MOVBSELF20+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF20:
STY $FFFF
;
LINE_2560:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_51R
LDY #>CONST_51R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #4
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF21+1
STA MOVBSELF21+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF21:
STY $FFFF
;
LINE_2570:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_38R
LDY #>CONST_38R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #2
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF22+1
STA MOVBSELF22+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF22:
STY $FFFF
;
LINE_2580:
;
LDA #<CONST_15R
LDY #>CONST_15R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_15R
LDY #>CONST_15R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF23+1
STA MOVBSELF23+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF23:
STY $FFFF
;
LINE_2590:
;
LDA #<VAR_V
LDY #>VAR_V
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 53280
;
LINE_2600:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_9
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_9:
;
LINE_2610:
;
JMP RETURN
;
LINE_2620:
;
;
LINE_2630:
;
;
LINE_2640:
;
;
LINE_2650:
;
;
LINE_2660:
;
;
LINE_2670:
;
;
LINE_2680:
;
;
LINE_2690:
;
;
LINE_2700:
;
;
LINE_2710:
;
;
LINE_2720:
;
;
LINE_2730:
;
;
LINE_2740:
;
;
LINE_2750:
;
;
LINE_2760:
;
;
LINE_2770:
;
;
LINE_2780:
;
;
LINE_2790:
;
;
LINE_2800:
;
;
LINE_2810:
;
;
LINE_2820:
;
;
LINE_2830:
;
;
LINE_2840:
;
;
LINE_2850:
;
;
LINE_2860:
;
;
LINE_2870:
;
;
LINE_2880:
;
;
LINE_2890:
;
;
LINE_2900:
;
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
; Special loop to handle the common for-poke-next-case
; used to clear the screen and such...
FASTFOR		JSR POPREAL
JSR SGNFAC
STA TMP_REG		; store sign
BCC FFPOSSTEP
LDA #<REAL_CONST_MINUS_ONE	; negative...negate it
LDY #>REAL_CONST_MINUS_ONE
JSR MEMARG	; to ARG
JSR FACMUL	; MUL
FFPOSSTEP	JSR FACWORD	; to WORD
STY TMP2_ZP
STA TMP2_ZP+1	; step
LDA A_REG
LDY A_REG+1
JSR REALFAC
JSR FACWORD
STY TMP_ZP
STA TMP_ZP+1	; from
JSR POPREAL
JSR FACWORD
STY TMP2_ZP+2
STA TMP2_ZP+3	; end
JSR XREGFAC
JSR FACINT
STY TMP3_ZP		; value
LDA TMP2_ZP+1
BNE STEPNOTONE
LDA TMP2_ZP
CMP #$1
BNE STEPNOTONE
JMP STEPONE
STEPNOTONE	LDA TMP_REG
BEQ FFSTEPZERO
ROL
FFSTEPZERO	BCC FFSTEPPOS
FFSTEPNEG	LDY #0
LDA TMP3_ZP
TAX
FFNEGLOOP	TXA
STA (TMP_ZP),Y
LDA TMP_ZP
SEC
SBC TMP2_ZP
STA TMP_ZP
LDA TMP_ZP+1
BCS	FFNEGSKIP
SBC TMP2_ZP+1
STA TMP_ZP+1
FFNEGSKIP	CMP TMP2_ZP+3
BEQ FFNEGCHECK2
BCS FFNEGLOOP
JMP FFDONE
FFNEGCHECK2	LDA TMP_ZP
CMP TMP2_ZP+2
BCS FFNEGLOOP
JMP FFDONE
FFSTEPPOS	LDY #0
LDA TMP3_ZP
TAX
FFPOSLOOP	TXA
STA (TMP_ZP),Y
LDA TMP_ZP
CLC
ADC TMP2_ZP
STA TMP_ZP
LDA TMP_ZP+1
BCC	FFPOSSKIP
ADC TMP2_ZP+1
STA TMP_ZP+1
FFPOSSKIP	CMP TMP2_ZP+3
BCC FFPOSLOOP
BEQ FFPOSCHECK2
JMP FFDONE
FFPOSCHECK2	LDA TMP_ZP
CMP TMP2_ZP+2
BCC FFPOSLOOP
BEQ FFPOSLOOP
FFDONE		LDY TMP_ZP
LDA TMP_ZP+1
JSR INTFAC
LDX A_REG
LDY A_REG+1
LDA #1
STA A_REG
JMP FACMEM		; Store end value in loop variable
; Special routine for step=1/-1
STEPONE	LDA TMP_REG
BEQ OFFSTEPZERO
ROL
OFFSTEPZERO	BCC OFFSTEPPOS
OFFSTEPNEG	LDY #0
LDA TMP3_ZP
TAX
OFFNEGLOOP	TXA
STA (TMP_ZP),Y
LDA TMP_ZP
BNE ONOOVERFLOW
DEC TMP_ZP+1
ONOOVERFLOW	DEC TMP_ZP
LDA TMP_ZP+1
OFFNEGSKIP	CMP TMP2_ZP+3
BEQ OFFNEGCHECK2
BCS OFFNEGLOOP
JMP FFDONE
OFFNEGCHECK2
LDA TMP_ZP
CMP TMP2_ZP+2
BCS OFFNEGLOOP
JMP FFDONE
OFFSTEPPOS	LDY #0
LDA TMP3_ZP
TAX
OFFPOSLOOP	TXA
STA (TMP_ZP),Y
INC TMP_ZP
BNE ONOOVERFLOW2
INC TMP_ZP+1
ONOOVERFLOW2
LDA TMP_ZP+1
OFFPOSSKIP	CMP TMP2_ZP+3
BCC OFFPOSLOOP
BEQ OFFPOSCHECK2
JMP FFDONE
OFFPOSCHECK2
LDA TMP_ZP
CMP TMP2_ZP+2
BCC OFFPOSLOOP
BEQ OFFPOSLOOP
JMP FFDONE
;###################################
;###################################
WRITETID	LDY #0
LDA (TMP_ZP),Y
CMP #$6
BEQ FORMATOK
JMP ILLEGALQUANTITY
FORMATOK	INC TMP_ZP
BNE WRITE2
INC TMP_ZP+1
WRITE2		LDA TMP_ZP
STA INDEX1
LDA TMP_ZP+1
STA INDEX1+1
<IF !X16>
JMP WRITETIS
</IF>
<IF X16>
JMP WRITETID_X16
</IF>
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
INTOUTFASTZ	LDX #32				; SPACE
LDA TMP_ZP+1
BPL INTISPOS
CLC
LDA TMP_ZP
EOR #$FF
ADC #1
STA TMP_ZP
LDA TMP_ZP+1
EOR #$FF
ADC #0
STA TMP_ZP+1
LDX #45				; MINUS
INTISPOS
TXA
JSR CHROUT
JSR CONVPOSINT
LDA NUMFLAG
BNE ALLINTOUTDONE
LDA #48
JSR CHROUT
ALLINTOUTDONE
RTS
;###################################
;###################################
NUMBEROUT
BEQ NUMZERO
ORA #$30
STA NUMFLAG
JMP CHROUT
NUMZERO
LDX NUMFLAG
BEQ STILLZERO
ORA #$30
JMP CHROUT
STILLZERO
RTS
;###################################
;###################################
CONVPOSINT
JSR INT2BCD
LDX #0
STX NUMFLAG
AND #$0F
JSR NUMBEROUT
LDA BCD+1
LSR
LSR
LSR
LSR
JSR NUMBEROUT
LDA BCD+1
AND #$0F
TAY
JSR NUMBEROUT
LDA BCD
LSR
LSR
LSR
LSR
JSR NUMBEROUT
LDA BCD
AND #$0F
JSR NUMBEROUT
RTS
;###################################
;###################################
INT2BCD
SED
LDA #0
STA BCD
STA BCD+1
STA BCD+2
ASL TMP_ZP
ROL TMP_ZP+1
LDA BCD
ADC BCD
STA BCD
ASL TMP_ZP
ROL TMP_ZP+1
ADC BCD
STA BCD
ASL TMP_ZP
ROL TMP_ZP+1
ADC BCD
STA BCD
ASL TMP_ZP
ROL TMP_ZP+1
ADC BCD
STA BCD
ASL TMP_ZP
ROL TMP_ZP+1
ADC BCD
STA BCD
ASL TMP_ZP
ROL TMP_ZP+1
ADC BCD
STA BCD
LDX #7
BCDBIT1
ASL TMP_ZP
ROL TMP_ZP+1
LDA BCD
ADC BCD
STA BCD
LDA BCD+1
ADC BCD+1
STA BCD+1
DEX
BNE BCDBIT1
LDX #3
BCDBIT2
ASL TMP_ZP
ROL TMP_ZP+1
LDA BCD
ADC BCD
STA BCD
LDA BCD+1
ADC BCD+1
STA BCD+1
LDA BCD+2
ADC BCD+2
STA BCD+2
DEX
BNE BCDBIT2
CLD
RTS
BCD
.WORD 0 0
NUMFLAG
.BYTE 0
;###################################
;###################################
REALOUTFAST	JSR FACINT
STA TMP_ZP+1
STY TMP_ZP
JMP INTOUTFASTZ
;###################################
;###################################
CHECKFORFASTOUT
JSR REROUTE
JSR XREGFAC
LDA FACEXP
CMP #$90
BCS REALOUTINT
CMP #$81
BCC REALOUTINT
MAYBEREALOUTFAST
LDA FACEXP+3
BNE REALOUTINT
LDA FACEXP+4
BNE REALOUTINT
LDA FACEXP
SEC
SBC #129
ASL
TAX
LDA FACEXP+1
AND MANTMASK,X
BNE	REALOUTINT
INX
LDA FACEXP+2
AND MANTMASK,X
BNE	REALOUTINT
JMP REALOUTFAST
REALOUTINT	LDY #0
JSR FACSTR
LDY #0
LDA LOFBUF,Y
STRLOOPRO	JSR CHROUT
INY
LDA LOFBUF,Y
BNE STRLOOPRO
RTS
MANTMASK
.BYTE 127 255 63 255 31 255 15 255 7 255 3 255 1 255 0 255 0 127 0 63 0 31 0 15 0 7 0 3 0 1
;###################################
;###################################
REALOUTBRK  LDA X_REG
BNE RNOTNULLBRK
JMP PRINTNULLBRK
RNOTNULLBRK	JSR CHECKFORFASTOUT
LDA #$0D
JSR CHROUT
JMP RESETROUTE
;###################################
;###################################
PRINTNULLBRK
JSR REROUTE
LDA #$20
JSR CHROUT
LDA #$30
JSR CHROUT
LDA #$0D
JSR CHROUT
JMP RESETROUTE
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
ARRAYACCESS_INTEGER_SNX
STA G_REG
STY G_REG+1
JMP ARRAYACCESS_INTEGER_NX
;###################################
;###################################
ARRAYACCESS_INTEGER_S
STA G_REG
STY G_REG+1
ARRAYACCESS_INTEGER
JSR XREGFAC
ARRAYACCESS_INTEGER_NX
JSR FACINT
ARRAYACCESS_INTEGER_INT
LDX G_REG
STX TMP_ZP
LDX G_REG+1
STX TMP_ZP+1
TAX
TYA
ASL
STA TMP2_ZP
TXA
ROL
STA TMP2_ZP+1
LDA TMP_ZP
CLC
ADC TMP2_ZP
STA TMP_ZP
LDA TMP_ZP+1
ADC TMP2_ZP+1
STA TMP_ZP+1
AIIDI		LDY #1
LDA (TMP_ZP),Y
TAX
DEY
LDA (TMP_ZP),Y
TAY
TXA
STY TMP2_ZP		; Store for integer optimization later on
STA TMP2_ZP+1
JSR INTFAC
JMP FACXREG	;RTS is implicit
;###################################
;###################################
ARRAYACCESS_REAL_INT_PRE
LDX G_REG
STX TMP3_ZP
LDX G_REG+1
STX TMP3_ZP+1
JMP COPY2_XY_XREG
;###################################
;###################################
ARRAYSTORE_INT_INTEGER
JSR XREGFAC
JSR FACINT
ARRAYSTORE_INT_INTEGER_AC
LDX G_REG
STX TMP_ZP
LDX G_REG+1
STX TMP_ZP+1
TAX
TYA
ASL
STA TMP2_ZP
TXA
ROL
STA TMP2_ZP+1
LDA TMP_ZP
CLC
ADC TMP2_ZP
STA TMP_ZP
LDA TMP_ZP+1
ADC TMP2_ZP+1
STA TMP_ZP+1
LDY #1
LDA AS_TMP+1
STA (TMP_ZP),Y
DEY
LDA AS_TMP
STA (TMP_ZP),Y
RTS
;###################################
;###################################
ARRAYSTORE_INTEGER
JSR XREGFAC
ARRAYSTORE_INTEGER_NX
JSR FACINT
ARRAYSTORE_INTEGER_INT
LDX G_REG
STX TMP_ZP
LDX G_REG+1
STX TMP_ZP+1
TAX
TYA
ASL
STA TMP2_ZP
TXA
ROL
STA TMP2_ZP+1
LDA TMP_ZP
CLC
ADC TMP2_ZP
STA TMP_ZP
LDA TMP_ZP+1
ADC TMP2_ZP+1
STA TMP_ZP+1
JSR YREGFAC
JSR FACINT
STY TMP3_ZP
LDY #1
STA (TMP_ZP),Y
DEY
LDA TMP3_ZP
STA (TMP_ZP),Y
RTS
;###################################
;###################################
ARRAYSTORE_REAL
JSR XREGFAC
JSR FACINT
ARRAYSTORE_REAL_INT
LDX G_REG
STX TMP_ZP
LDX G_REG+1
STX TMP_ZP+1
STY TMP3_ZP
STA TMP3_ZP+1
TAX
TYA
ASL
TAY
TXA
ROL
TAX
TYA
ASL
STA TMP2_ZP
TXA
ROL
STA TMP2_ZP+1
LDA TMP_ZP
CLC
ADC TMP3_ZP
STA TMP_ZP
LDA TMP_ZP+1
ADC TMP3_ZP+1
STA TMP_ZP+1
LDA TMP_ZP
CLC
ADC TMP2_ZP
STA TMP_ZP
LDA TMP_ZP+1
ADC TMP2_ZP+1
STA TMP_ZP+1
JMP COPY2_YREG_XYA	;RTS is implicit
;###################################
;###################################
ADJUSTSTACK LDA FORSTACKP	; Adjust the FORSTACK in case a new loop uses an unclosed old one (i.e. the code jumped out of that loop with goto)
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
ADSEARCHFOR	LDA TMP_ZP
CMP #<FORSTACK
BNE ADJUST2
LDA TMP_ZP+1
CMP #>FORSTACK
BNE ADJUST2
RTS				; Start of Stack reached? Return
ADJUST2		LDA TMP_ZP
SEC
SBC #2
STA TMP_ZP
BCS ADNOPV1N1
DEC TMP_ZP+1
ADNOPV1N1	LDY #0
LDA (TMP_ZP),Y
BNE ADNOGOSUB
RTS				; Encountered a GOSUB on the way? Then return (is this correct?)
ADNOGOSUB
INY
LDA TMP_ZP
SEC
SBC (TMP_ZP),Y
STA TMP_ZP
BCS ADNOPV1N2
DEC TMP_ZP+1
ADNOPV1N2	DEY
LDA A_REG
ADCMPFOR	CMP (TMP_ZP),Y
BNE ADSEARCHFOR
LDA A_REG+1
INY
CMP (TMP_ZP),Y
BEQ ADFOUNDFOR
JMP ADSEARCHFOR
ADLOW0		LDX A_REG+1
BEQ ADFOUNDFOR
BNE ADCMPFOR
ADFOUNDFOR	LDA TMP_ZP		; Adjust the stack so that it points onto the last entry for the "new" loop variable
STA FORSTACKP
LDA TMP_ZP+1
STA FORSTACKP+1
RTS
;###################################
;###################################
INITFOR		JSR ADJUSTSTACK
LDA FORSTACKP
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
LDY #0
LDA A_REG
STA (TMP_ZP),Y
INY
LDA A_REG+1
STA (TMP_ZP),Y
INY
LDA JUMP_TARGET
STA (TMP_ZP),Y
INY
LDA JUMP_TARGET+1
STA (TMP_ZP),Y
INY
STY TMP3_ZP
JSR INCTMPZP
JSR POPREAL
LDX TMP_ZP
LDY TMP_ZP+1
; FAC to (X/Y)
JSR FACMEM
JSR SGNFAC
STA TMP_FLAG
LDY #5
STY TMP3_ZP
JSR INCTMPZP
JSR POPREAL
LDX TMP_ZP
LDY TMP_ZP+1
; FAC to (X/Y)
JSR FACMEM
LDY #5
STY TMP3_ZP
JSR INCTMPZP
LDY #0
LDA TMP_FLAG
STA (TMP_ZP),Y
INY
LDA #1
STA (TMP_ZP),Y
INY
LDA #15
STA (TMP_ZP),Y
LDY #3
STY TMP3_ZP
JSR INCTMPZP
LDA TMP_ZP
STA FORSTACKP
LDA TMP_ZP+1
STA FORSTACKP+1
RTS
;###################################
;###################################
NEXT		LDA FORSTACKP
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
SEARCHFOR	LDA TMP_ZP+1
STA TMP3_REG+1
LDA TMP_ZP
STA TMP3_REG
SEC
SBC #2
STA TMP_ZP
BCS NOPV1N1
DEC TMP_ZP+1
NOPV1N1		LDY #0
LDA (TMP_ZP),Y
BNE NOGOSUB
JMP NEXTWOFOR
NOGOSUB
INY
LDA TMP_ZP
SEC
SBC (TMP_ZP),Y
STA TMP_ZP
BCS NOPV1N2
DEC TMP_ZP+1
NOPV1N2		DEY
LDA A_REG
BEQ LOW0
CMPFOR		CMP (TMP_ZP),Y
BNE SEARCHFOR
LDA A_REG+1
INY
CMP (TMP_ZP),Y
BEQ FOUNDFOR
JMP SEARCHFOR
LOW0		LDX A_REG+1
BEQ FOUNDFOR
BNE CMPFOR
FOUNDFOR	LDA TMP_ZP
STA TMP2_REG
LDA TMP_ZP+1
STA TMP2_REG+1
VARREAL
LDY #0
STY A_REG+1 ; Has to be done anyway...so we can do it here as well
LDA (TMP_ZP),Y
TAX
INY
LDA (TMP_ZP),Y
TAY
TXA
JSR REALFAC
CALCNEXT	LDA TMP_ZP
CLC
ADC #4
STA TMP_ZP
BCC NOPV2IN
INC TMP_ZP+1
NOPV2IN		STA TMP_REG
LDY TMP_ZP+1
STY TMP_REG+1
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
LDA TMP2_REG
STA TMP_ZP
LDA TMP2_REG+1
STA TMP_ZP+1
STOREREAL
LDY #0
LDA (TMP_ZP),Y
TAX
INY
LDA (TMP_ZP),Y
TAY
JSR FACMEM	;FAC TO (X/Y)
CMPFORXX	LDA #5
STA TMP3_ZP
LDA TMP_REG
CLC
ADC #5
STA TMP_REG
BCC NOPV3
INC TMP_REG+1
NOPV3		LDY TMP_REG+1
JSR CMPFAC 	;CMPFAC
BEQ LOOPING
PHA
LDY #14
LDA (TMP_ZP),Y
BEQ STEPZERO
ROL
BCC STEPPOS
STEPNEG		PLA
ROL
BCC LOOPING
BCS EXITLOOP
STEPPOS		PLA
ROL
BCC EXITLOOP
LOOPING		LDA TMP3_REG
STA FORSTACKP
LDA TMP3_REG+1
STA FORSTACKP+1
LDA TMP2_REG
CLC
ADC #2
STA TMP2_REG
BCC NOPV4IN
INC TMP2_REG+1
NOPV4IN		LDY #0
STY A_REG
STA TMP_ZP
LDA TMP2_REG+1
STA TMP_ZP+1
LDA (TMP_ZP),Y
STA JUMP_TARGET
INY
LDA (TMP_ZP),Y
STA JUMP_TARGET+1
RTS
STEPZERO	PLA
JMP LOOPING
EXITLOOP	LDA TMP2_REG
STA FORSTACKP
LDA TMP2_REG+1
STA FORSTACKP+1
LDA #1
STA A_REG
RTS
;###################################
;###################################
RETURN		LDA FORSTACKP
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
SEARCHGOSUB	LDA TMP_ZP
SEC
SBC #2
STA TMP_ZP
BCS NOPV1SG
DEC TMP_ZP+1
NOPV1SG		LDY #0
LDA (TMP_ZP),Y
BEQ FOUNDGOSUB
INY
LDA (TMP_ZP),Y
STA TMP3_ZP
LDA TMP_ZP
SEC
SBC (TMP_ZP),Y
STA TMP_ZP
BCS NOPV1GS
DEC TMP_ZP+1
NOPV1GS		JMP SEARCHGOSUB
FOUNDGOSUB
LDA TMP_ZP
STA FORSTACKP
LDA TMP_ZP+1
STA FORSTACKP+1
RTS
;###################################
;###################################
GOSUB		LDA FORSTACKP
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
LDY #0
TYA
STA (TMP_ZP),Y
INY
STA (TMP_ZP),Y
INY
TYA
CLC
ADC TMP_ZP
STA FORSTACKP
BCC GOSUBNOOV
INC FORSTACKP+1
GOSUBNOOV	RTS
;###################################
;###################################
READINIT	LDA DATASP
STA TMP3_ZP
LDA DATASP+1
STA TMP3_ZP+1
LDY #$0
LDA (TMP3_ZP),Y
INC TMP3_ZP
BNE READNOOV
INC TMP3_ZP+1
READNOOV	CMP #$FF
BNE MOREDATA
JMP OUTOFDATA
MOREDATA	RTS
;###################################
;###################################
READADDPTR	STX TMP_REG+1
LDA TMP3_ZP
CLC
ADC TMP_REG+1
STA TMP3_ZP
BCC READADDPTRX
INC TMP3_ZP+1
READADDPTRX	RTS
;###################################
;###################################
READMAYBEBYTE					; Version of READ for Bytes...maybe. Can switch to the old routine, if needed....
JSR READINIT
CMP #3
BCS RMBISBYTE
JSR MORENUMDATA
JMP FACINT
RMBISBYTE	BNE RMBNOTYPE
LDA (TMP3_ZP),Y
TAY
LDX #1
JSR READADDPTR
JMP RMBNOTYPE2
RMBNOTYPE	TAY
RMBNOTYPE2	JSR NEXTDATA
LDA #0
RTS
;###################################
;###################################
READNUMBER	JSR READINIT
MORENUMDATA CMP #$2				; Strings are not allowed here
BNE NUMNUM
LDA (TMP3_ZP),Y		; ...unless they are empty, which makes them count as 0
BEQ RNESTR
CMP #1				; or a "." or "e", which is 0 as well...so length has to be 1..
BEQ STRGNUMCHK
JMP SYNTAXERROR
STRGNUMCHK 	INY
LDA (TMP3_ZP),Y
CMP #46				; ...and really a "."?
BEQ RNESTR2
CMP #69				; ...or really an "e"?
BEQ RNESTR2
JMP SYNTAXERROR
RNESTR2		LDA #0
LDY #0
JSR INTFAC
LDX #2
JSR READADDPTR
JMP NUMREAD
RNESTR		LDA #0
LDY #0
JSR INTFAC
LDX #1
JSR READADDPTR
JMP NUMREAD
NUMNUM		CMP #$1
BEQ NUMREADREAL
CMP #$0
BEQ NUMREADINT
CMP #$4
BCS READNOTYPE
LDA (TMP3_ZP),Y
TAY
JSR BYTEFAC
LDX #1
JSR READADDPTR
JMP NUMREAD			; It's a byte
READNOTYPE	TAY					; It's a byte >3, which mean it has no typing stored to save memory
JSR BYTEFAC
JMP NUMREAD
NUMREADINT	LDA (TMP3_ZP),Y		; It's an integer
STA TMP_REG
INY
LDA (TMP3_ZP),Y
LDY TMP_REG
JSR INTFAC
LDX #2
JSR READADDPTR
JMP NUMREAD
NUMREADREAL	LDA TMP3_ZP
LDY TMP3_ZP+1
JSR REALFAC
LDX #5
JSR READADDPTR
NUMREAD		JSR NEXTDATA
JMP FACYREG		; ...and return
;###################################
;###################################
NEXTDATA	LDA TMP3_ZP			; Adjust pointer to the next element
STA DATASP
LDA TMP3_ZP+1
STA DATASP+1
RTS
;###################################
;##################################
REALFACPUSH	STA TMP_ZP
STY	TMP_ZP+1
LDX FPSTACKP
LDY FPSTACKP+1
STX TMP2_ZP
STY TMP2_ZP+1
LDY #0
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
INY
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
INY
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
INY
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
INY
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
TXA				;LDA FPSTACKP
CLC
ADC #5
STA FPSTACKP
BCC NOPVRFPXX
INC FPSTACKP+1
NOPVRFPXX	RTS
;###################################
;###################################
REALFACPUSHXREG
LDX FPSTACKP
LDY FPSTACKP+1
STX TMP2_ZP
STY TMP2_ZP+1
LDY #0
LDA X_REG
STA (TMP2_ZP),Y
INY
LDA X_REG+1
STA (TMP2_ZP),Y
INY
LDA X_REG+2
STA (TMP2_ZP),Y
INY
LDA X_REG+3
STA (TMP2_ZP),Y
INY
LDA X_REG+4
STA (TMP2_ZP),Y
TXA				;LDA FPSTACKP
CLC
ADC #5
STA FPSTACKP
BCC NOPVRFPXXXREG
INC FPSTACKP+1
NOPVRFPXXXREG
RTS
;###################################
;###################################
PUSHREAL	LDX FPSTACKP
LDY FPSTACKP+1
JSR FACMEM
LDA FPSTACKP
CLC
ADC #5
STA FPSTACKP
BCC NOPVPUR
INC FPSTACKP+1
NOPVPUR		RTS
;###################################
;###################################
POPREAL2X	LDA FPSTACKP
SEC
SBC #5
STA FPSTACKP
BCS NOPVPR2X
DEC FPSTACKP+1
NOPVPR2X	LDA FPSTACKP
LDY FPSTACKP+1
JSR REALFAC
JSR XREGARG
RTS
;###################################
;###################################
POPREAL		LDA FPSTACKP
SEC
SBC #5
STA FPSTACKP
BCS NOPVPR
DEC FPSTACKP+1
NOPVPR		LDA FPSTACKP
LDY FPSTACKP+1
JMP REALFAC
;###################################
;###################################
POPREALXREG LDA FPSTACKP
SEC
SBC #5
STA FPSTACKP
BCS NOPVPRXR
DEC FPSTACKP+1
NOPVPRXR	LDA FPSTACKP
LDY FPSTACKP+1
STA TMP_ZP
STY TMP_ZP+1
LDY #$4
LDA (TMP_ZP),Y
STA X_REG+4
STA FACLO
DEY
LDA (TMP_ZP),Y
STA X_REG+3
STA FACMO
DEY
LDA (TMP_ZP),Y
STA X_REG+2
STA FACMOH
DEY
LDA (TMP_ZP),Y
STA X_REG+1
STA FACSGN
ORA #$80
STA FACHO
DEY
LDA (TMP_ZP),Y
STA X_REG
STA FACEXP
STY FACOV
RTS
;###################################
;###################################
SHR			LDA FACEXP
BEQ SHROK
SEC
SBC A_REG
BCS SHROK
LDA #0
STA FACSGN
STA FACLO
STA FACMO
STA FACMOH
STA FACHO
SHROK		STA FACEXP
RTS
;###################################
;###################################
SHL			LDA FACEXP
BEQ SHLOK
CLC
ADC A_REG
BCC SHLOK
LDA #0
STA FACSGN
STA FACLO
STA FACMO
STA FACMOH
STA FACHO
LDA #$FF
SHLOK		STA FACEXP
RTS
;###################################
;###################################
INCTMPZP	LDA TMP_ZP
CLC
ADC TMP3_ZP
STA TMP_ZP
BCC NOPV2
INC TMP_ZP+1
NOPV2		RTS
;###################################
;###################################
COPY2_YREG_XYA
LDY #0
LDA Y_REG
STA (TMP_ZP),Y
INY
LDA Y_REG+1
STA (TMP_ZP),Y
INY
LDA Y_REG+2
STA (TMP_ZP),Y
INY
LDA Y_REG+3
STA (TMP_ZP),Y
INY
LDA Y_REG+4
STA (TMP_ZP),Y
RTS
;###################################
;###################################
COPY2_XYA_XREG
STA TMP3_ZP
STY TMP3_ZP+1
COPY2_XY_XREG
LDX #<X_REG		; the pointer to X_REG has to be in X, because the "value already in X"-optimization might expect it to be there! YIKES!
LDY #0
LDA (TMP3_ZP),Y
STA X_REG
INY
LDA (TMP3_ZP),Y
STA X_REG+1
INY
LDA (TMP3_ZP),Y
STA X_REG+2
INY
LDA (TMP3_ZP),Y
STA X_REG+3
INY
LDA (TMP3_ZP),Y
STA X_REG+4
RTS
;###################################
;###################################
COPY2_XYA_YREG
STA TMP3_ZP
STY TMP3_ZP+1
COPY2_XY_YREG
LDX #<Y_REG		; the pointer to Y_REG has to be in X, because the "value already in X"-optimization might expect it to be there! YIKES!
LDY #0
LDA (TMP3_ZP),Y
STA Y_REG
INY
LDA (TMP3_ZP),Y
STA Y_REG+1
INY
LDA (TMP3_ZP),Y
STA Y_REG+2
INY
LDA (TMP3_ZP),Y
STA Y_REG+3
INY
LDA (TMP3_ZP),Y
STA Y_REG+4
RTS
;###################################
;###################################
COPY_XREG2YREG
LDA X_REG
STA Y_REG
LDA X_REG+1
STA Y_REG+1
LDA X_REG+2
STA Y_REG+2
LDA X_REG+3
STA Y_REG+3
LDA X_REG+4
STA Y_REG+4
RTS
;###################################
;###################################
PEEKBYTEAND
JSR PEEKBYTESUB
PEEKBYTEANDSUBINT
TYA
AND A_REG
TAY
LDA #0
JMP PEEKBYTESTORE
;###################################
;###################################
PEEKBYTESTORE
STY TMP2_ZP		; Store here for later optimization
JSR	INTFAC
JMP FACXREG
;###################################
;###################################
PEEKBYTESUB
JSR YREGFAC
JSR FACWORD
PEEKBYTESUBINT
STY PEEKBYTE+1
STA PEEKBYTE+2
PEEKBYTE
LDY $FFFF
LDX #0
RTS
;###################################
;###################################
<IF !BIGRAM>
FACWORD
LDA FACEXP			; Check if there's a -0 in FAC1
BNE DOFACWORD
STA FACSGN			; make sure that it's not -0
DOFACWORD:
JMP XFACWORD
</IF>
;###################################
;###################################
ONETOFAC    LDX #129
STX FAC
DEX
STX FAC+1
LDX #0
STX FAC+2
STX FAC+3
STX FAC+4
STX FAC+5
STX FAC+15
RTS
;###################################
;###################################
FASTAND		LDA ARGEXP			; Check ARG for 0
BNE CHECKFAC
STA FACSGN			; if so, set FAC to 0 and exit
STA FACLO
STA FACMO
STA FACMOH
STA FACHO
STA FACEXP
RTS
CHECKFAC	LDA FACEXP			; Check if there's a -1 in FAC1
BNE FACNOTNULL
STA FACSGN			; make sure that it's not -0
RTS				; FAC is 0, then exit
FACNOTNULL	CMP #$81
BNE NORMALAND
LDA FACHO
CMP #$80
BNE NORMALAND
LDA FACMOH
BNE NORMALAND
LDA FACMO
BNE NORMALAND
LDA FACLO
BNE NORMALAND
LDA FACSGN
ROL
BCC NORMALAND
LDA ARGEXP			; Check if there's a -1 in ARG
CMP #$81
BNE NORMALAND
LDA ARGHO
CMP #$80
BNE NORMALAND
LDA ARGMOH
BNE NORMALAND
LDA ARGMO
BNE NORMALAND
LDA ARGLO
BNE NORMALAND
LDA ARGSGN
ROL
BCC NORMALAND
RTS				; both, FAC1 and ARG contain -1...then we leave FAC1 untouched and return
NORMALAND	JMP ARGAND
;###################################
;###################################
FASTOR		LDA FACEXP			; Check FAC for 0
BNE CHECKFACOR
LDA ARGEXP			; if so, is ARG = 0 as well?
BNE CHECKARGOR	; no, continue with ARG (FAC is still 0 here)
LDA #0
STA FACSGN			; make sure that the negative flag is deleted in this case...
RTS				; yes? Then we leave FAC untouched
CHECKFACOR	LDA FACEXP			; Check if there's a -1 in FAC1
CMP #$81
BNE NORMALOR
LDA FACHO
CMP #$80
BNE NORMALOR
LDA FACMOH
BNE NORMALOR
LDA FACMO
BNE NORMALOR
LDA FACLO
BNE NORMALOR
LDA FACSGN
ROL
BCC NORMALOR
CHECKARGOR	LDA ARGEXP			; Check if there's a -1 in ARG
BNE CHECKARGOR2
RTS 			; ARG is actually 0? Then the value of FAC doesn't change. We can exit here
CHECKARGOR2	CMP #$81
BNE NORMALOR
LDA ARGHO
CMP #$80
BNE NORMALOR
LDA ARGMOH
BNE NORMALOR
LDA ARGMO
BNE NORMALOR
LDA ARGLO
BNE NORMALOR
LDA ARGSGN
AND #$80
CMP #$80
BNE NORMALOR
JMP ARGFAC		; ARG is 1, so just copy it to FAC and exit (implicit)
NORMALOR	JMP FACOR
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
NEXTWOFOR
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
LDX #$0A
JMP ERRALL
;###################################
;###################################
OUTOFDATA
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
LDX #$0D
JMP ERRALL
;###################################
;###################################
ILLEGALQUANTITY
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
JMP ERRIQ
;###################################
;###################################
SYNTAXERROR
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
JMP ERRSYN
;###################################
;###################################
FACXREG		LDA FACLO
STA X_REG+4
LDA FACMO
STA X_REG+3
LDA FACMOH
STA X_REG+2
LDA FACSGN
ORA #$7F
AND FACHO
STA X_REG+1
LDA FACEXP
STA X_REG
LDA #0			; Why? Don't know...the ROM does this as well...
STA FACOV
RTS
;###################################
;###################################
FACYREG		LDA FACLO
STA Y_REG+4
LDA FACMO
STA Y_REG+3
LDA FACMOH
STA Y_REG+2
LDA FACSGN
ORA #$7F
AND FACHO
STA Y_REG+1
LDA FACEXP
STA Y_REG
LDA #0			; Why? Don't know...the ROM does this as well...
STA FACOV
RTS
;###################################
;###################################
XREGFAC		LDA X_REG+4
STA FACLO
LDA X_REG+3
STA FACMO
LDA X_REG+2
STA FACMOH
LDA X_REG+1
STA FACSGN
ORA #$80
STA FACHO
LDA X_REG
STA FACEXP
LDA #0
STA FACOV
RTS
;###################################
;###################################
XREGARG		LDA X_REG+4
STA ARGLO
LDA X_REG+3
STA ARGMO
LDA X_REG+2
STA ARGMOH
LDA X_REG+1
STA ARGSGN
EOR FACSGN
STA ARISGN
LDA ARGSGN
ORA #$80
STA ARGHO
LDA X_REG
STA ARGEXP
LDA FACEXP
RTS
;###################################
;###################################
YREGFAC		LDA Y_REG+4
STA FACLO
LDA Y_REG+3
STA FACMO
LDA Y_REG+2
STA FACMOH
LDA Y_REG+1
STA FACSGN
ORA #$80
STA FACHO
LDA Y_REG
STA FACEXP
LDA #0
STA FACOV
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
;###################################
FASTFSUBMEM
JSR MEMARG
FASTFSUBARG
LDA FACSGN
EOR #$FF
STA FACSGN
EOR ARGSGN
STA ARISGN
LDA FACEXP
JMP FASTFADDARG
;###################################
;###################################
FASTFADDMEM
JSR MEMARG
FASTFADDARG
BNE FADDRET2   		; JUMP IF FAC IS NOT ZERO.
JMP ARGFAC
FADDRET2	LDA ARGEXP
BNE FADDRET1   		; JUMP IF ARG IS NOT ZERO.
RTS
FADDRET1	SEC
SBC FACEXP
BEQ FFADD_EXPEQ     ; JUMP IF NO SHIFTING NEEDED. THE A REGISTER IS ALREADY ZERO.
BCC FFADD_SHFARG1   ; JUMP IF ARG NEEDS SHIFTING (HAS SMALLER EXPONENT).
; HERE, FAC IS THE SMALLEST OPERAND, AND ARG IS THE LARGEST.
; FAC WILL NEED TO BE SHIFTED RIGHT,
; COPY EXPONENT AND SIGN FROM ARG.
LDY ARGEXP
STY FACEXP
LDY ARGSGN
STY FACSGN
LDX #0
STX OLDOV      		; ARG HAS NO ROUNDING BITS.
LDX #FAC       		; INDICATE FAC IS THE SMALLEST OPERAND.
; A CONTAINS NUMBER OF BITS TO ROTATE RIGHT.
SEC
SBC #$08
BMI FFADD_SHFFAC2
; A >= 8, THEREFORE SHIFT RIGHT ONE BYTE.
FFADD_SHFFAC1
LDY FACLO      		; LO -> OV
STY FACOV
LDY FACMO      		; MO -> LO
STY FACMO+1
LDY FACMOH     		; MOH -> MO
STY FACMOH+1
LDY FACHO      		; HO -> MOH
STY FACHO+1
LDY #0
STY FACHO      		; 0 -> HO
SBC #$08       		; CARRY IS ALWAYS SET HERE.
BPL FFADD_SHFFAC1   ; JUMP IF MORE BYTES TO SHIFT.
FFADD_SHFFAC2
ADC #$08       		; CARRY IS ALWAYS CLEAR HERE.
BEQ FFADD_SHFFAC4   ; JUMP IF NO MORE SHIFTING.
TAY
LDA FACOV
FFADD_SHFFAC3
LSR FACHO      		; HO
ROR FACMOH     		; MOH
ROR FACMO      		; MO
ROR FACLO      		; LO
ROR            		; OV
DEY
BNE FFADD_SHFFAC3
JMP FFADD_MANADD2   ; NO MORE SHIFTING.
FFADD_SHFFAC4
LDA FACOV       	; THE A-REGISTER CONTAINS THE SHIFTED ROUNDING BITS OF FAC.
JMP FFADD_MANADD2
FFADD_EXPEQ
LDX FACOV
STX OLDOV
; OLDOV NOW CONTAINS ROUNDING BITS OF FAC.
; THE A-REGISTER CONTAINS THE ROUNDING BITS OF ARG (I.E. ZERO).
JMP FFADD_MANADD1
FFADD_SHFARG2
LDA FACOV      		; THE A-REGISTER CONTAINS THE SHIFTED ROUNDING BITS OF ARG.
JMP FFADD_MANADD1
FFADD_SHFARG1
LDX FACOV
STX OLDOV      		; OLDOV NOW CONTAINS ROUNDING BITS OF FAC.
LDX #$00       		; USE X-REGISTER FOR ROUNDING BITS OF ARG.
; -A CONTAINS NUMBER OF BITS TO ROTATE RIGHT.
; CARRY IS ALWAYS CLEAR HERE.
ADC #$08
BPL FFADD_SHFARG6   ; JUMP IF LESS THAN 8 SHIFTS.
FFADD_SHFARG3
LDX ARGLO      		; SHIFT RIGHT ONE BYTE
LDY ARGMO      		; MO -> LO
STY ARGMO+1
LDY ARGMOH     		; MOH -> MO
STY ARGMOH+1
LDY ARGHO      		; HO -> MOH
STY ARGHO+1
LDY #0
STY ARGHO      		; 0 -> HO
FFADD_SHFARG4
ADC #$08
BMI FFADD_SHFARG3
BEQ FFADD_SHFARG3
FFADD_SHFARG6
SBC #$08
BEQ FFADD_SHFARG2   ; JUMP IF NO MORE SHIFTING.
TAY
TXA            		; ROUNDING BITS.
FFADD_SHFARG5
LSR ARGHO
ROR ARGMOH
ROR ARGMO
ROR ARGLO
ROR         		; OV
INY
BNE FFADD_SHFARG5
FFADD_MANADD1
LDX #ARGEXP    		; INDICATE ARG IS THE SMALLEST OPERAND.
FFADD_MANADD2
BIT ARISGN
BMI FFADD_MANSUB1   ; JUMP IF OPERANDS HAVE DIFFERENT SIGN.
CLC
ADC OLDOV
STA FACOV
LDA FACLO
ADC ARGLO
STA FACLO
LDA FACMO
ADC ARGMO
STA FACMO
LDA FACMOH
ADC ARGMOH
STA FACMOH
LDA FACHO
ADC ARGHO
STA FACHO
BCC FFADD_RNDRTS
INC FACEXP
BEQ FFADD_OVERR
; CARRY BIT IS SET HERE.
ROR FACHO
ROR FACMOH
ROR FACMO
ROR FACLO
ROR FACOV
FFADD_RNDRTS
RTS
FFADD_OVERR
JMP ILLEGALQUANTITY
FFADD_MANSUB1
LDY #FACEXP
CPX #ARGEXP
BEQ FFADD_MANSUB2
LDY #ARGEXP
FFADD_MANSUB2
SEC            		; NEGATE THE ROUNDING BITS BEFORE ADDING.
EOR #$FF
ADC OLDOV
STA FACOV
LDA 4,Y
SBC 4,X
STA FACLO
LDA 3,Y
SBC 3,X
STA FACMO
LDA 2,Y
SBC 2,X
STA FACMOH
LDA 1,Y
SBC 1,X
STA FACHO
BCS FCNORMAL
LDA FACSGN
EOR #$FF
STA FACSGN
LDA FACHO
EOR #$FF
STA FACHO
LDA FACMOH
EOR #$FF
STA FACMOH
LDA FACMO
EOR #$FF
STA FACMO
LDA FACLO
EOR #$FF
STA FACLO
LDA FACOV
EOR #$FF
CLC
ADC #1
STA FACOV
BNE FCNORMAL
INC FACLO
BNE FCNORMAL
INC FACMO
BNE FCNORMAL
INC FACMOH
BNE FCNORMAL
INC FACHO
FCNORMAL  	BIT FACHO
BMI FFADD_RET       ; JUMP IF NUMBER IS ALREADY NORMALIZED.
LDA #0         		; NUMBER OF BITS ROTATED.
CLC
FFADD_NORM3
LDX FACHO
BNE FFADD_NORM1
LDX FACHO+1
STX FACHO
LDX FACMOH+1
STX FACMOH
LDX FACMO+1
STX FACMO
LDX FACOV
STX FACLO
LDX #0
STX FACOV
ADC #$08
CMP #$20
BNE FFADD_NORM3
JMP FFADD_ZEROFAC
FFADD_NORM2
CLC
ADC #1
ASL FACOV
ROL FACLO
ROL FACMO
ROL FACMOH
ROL FACHO
FFADD_NORM1
BPL FFADD_NORM2     ; WE MUST SHIFT LEFT ONE BIT
SEC
SBC FACEXP
BCS FFADD_ZEROFAC
EOR #$FF
CLC
ADC #1
STA FACEXP
FFADD_RET   RTS
FFADD_ZEROFAC
LDX #0
STX FACEXP
STX FACSGN
RTS
;###################################
;###################################
FASTFMULMEM
JSR MEMARG
FASTFMULARG
BEQ FFMUL_MULTRT    ; JUMP IF FAC IS ZERO.
LDA ARGEXP
BEQ FFMUL_ZEREMV    ; JUMP IF ARG IS ZERO.
CLC
ADC FACEXP
BCC FFMUL_TRYOFF
CLC
BPL FFMUL_ADJUST
JMP ILLEGALQUANTITY
FFMUL_ZEREMV
LDY #0
STY FACEXP     		; RESULT IS ZERO.
STY FACSGN
FFMUL_MULTRT
RTS
FFMUL_TRYOFF
BPL FFMUL_ZEREMV    ; JUMP IF UNDERFLOW.
FFMUL_ADJUST
ADC #$80       		; CARRY IS ALWAYS CLEAR HERE.
BEQ FFMUL_ZEREMV    ; JUMP IF UNDERFLOW.
STA FACEXP
LDA ARISGN
STA FACSGN
LDY #0
STY RESHOP
STY RESHO
STY RESMOH
STY RESMO
STY RESLO
STY RESOV
STY FACHOP
FFMUL_B0
LSR ARGLO      		; B0
BCC FFMUL_B1
LDA RESOV
CLC
ADC FACMOH     		; A2
STA RESOV
LDA RESLO
ADC FACHO      		; A3
STA RESLO
LDA RESMO
ADC FACHOP     		; A4
STA RESMO
BCC FFMUL_B1
INC RESMOH
BNE FFMUL_B1
INC RESHO
BNE FFMUL_B1
INC RESHOP
FFMUL_B1
LSR ARGMO      		; B1
BCC FFMUL_B2
LDA RESOV
CLC
ADC FACMO      		; A1
STA RESOV
LDA RESLO
ADC FACMOH     		; A2
STA RESLO
LDA RESMO
ADC FACHO      		; A3
STA RESMO
LDA RESMOH
ADC FACHOP     		; A4
STA RESMOH
BCC FFMUL_B2
INC RESHO
BNE FFMUL_B2
INC RESHOP
FFMUL_B2
LSR ARGMOH     		; B2
BCC FFMUL_B3
LDA RESOV
CLC
ADC FACLO      		; A0
STA RESOV
LDA RESLO
ADC FACMO      		; A1
STA RESLO
LDA RESMO
ADC FACMOH     		; A2
STA RESMO
LDA RESMOH
ADC FACHO      		; A3
STA RESMOH
LDA RESHO
ADC FACHOP     		; A4
STA RESHO
BCC FFMUL_B3
INC RESHOP
FFMUL_B3
LSR ARGHO      		; B3
BCC FFMUL_ROTA
LDA RESOV
CLC
ADC FACOV      		; AV
STA RESOV
LDA RESLO
ADC FACLO      		; A0
STA RESLO
LDA RESMO
ADC FACMO      		; A1
STA RESMO
LDA RESMOH
ADC FACMOH     		; A2
STA RESMOH
LDA RESHO
ADC FACHO      		; A3
STA RESHO
LDA RESHOP
ADC FACHOP     		; A4
STA RESHOP
FFMUL_ROTA
ASL FACOV
ROL FACLO
ROL FACMO
ROL FACMOH
ROL FACHO
ROL FACHOP
BMI FFMUL_FIN
JMP FFMUL_B0
FFMUL_FIN
LDA RESHOP
STA FACHO
LDA RESHO
STA FACMOH
LDA RESMOH
STA FACMO
LDA RESMO
STA FACLO
LDA RESLO
STA FACOV
JMP FCNORMAL    		; IN BASIC/XADD.S
MUL10
JSR ARGFAC      	; ARG = FAC; LEAVES EXPONENT IN A REGISTER.
TAX            		; EXPONENT
BEQ FFMUL_MUL101    ; RETURN IF ZERO.
CLC
ADC #2
BCS FFMUL_MUL102    ; JUMP IF OVERFLOW
STA FACEXP     		; STORE NEW EXPONENT.
LDY #0
STY ARISGN
JSR FASTFADDARG      ; THE Z FLAG IS CLEAR HERE.
INC FACEXP
BEQ FFMUL_MUL102     ; JUMP IF OVERFLOW
FFMUL_MUL101
RTS
FFMUL_MUL102
JMP ILLEGALQUANTITY
MUL6
JSR ARGFAC      	; ARG = FAC
TAX            		; EXPONENT
BEQ FFMUL_MUL61     ; RETURN IF ZERO.
INC FACEXP
BEQ FFMUL_MUL62     ; JUMP IF OVERFLOW
LDY #0
STY ARISGN
JSR FASTFADDARG      ; THE Z FLAG IS CLEAR HERE.
INC FACEXP
BEQ FFMUL_MUL62     ; OVERFLOW
FFMUL_MUL61
RTS
FFMUL_MUL62
JMP ILLEGALQUANTITY
;###################################
;###############################
INITVARS
JSR INITSTRVARS
LDA #0
LDY #4
REALINITLOOP0:
STA VAR_W,Y
STA VAR_XD,Y
STA VAR_YD,Y
STA VAR_XH,Y
STA VAR_YH,Y
STA VAR_TC,Y
STA VAR_T,Y
STA VAR_L,Y
STA VAR_R,Y
STA VAR_TT,Y
STA VAR_TL,Y
STA VAR_TR,Y
STA VAR_DL,Y
STA VAR_DR,Y
STA VAR_U0,Y
STA VAR_U1,Y
STA VAR_V0,Y
STA VAR_V1,Y
STA VAR_N,Y
STA VAR_DF,Y
STA VAR_DE,Y
STA VAR_XS,Y
STA VAR_XE,Y
STA VAR_US,Y
STA VAR_UE,Y
STA VAR_VS,Y
STA VAR_VE,Y
STA VAR_KP,Y
STA VAR_U,Y
STA VAR_V,Y
STA VAR_LE,Y
STA VAR_DU,Y
STA VAR_DV,Y
STA VAR_X,Y
STA VAR_Y,Y
STA VAR_TP,Y
STA VAR_SI,Y
STA VAR_CO,Y
STA VAR_C,Y
STA VAR_MT,Y
STA VAR_MA,Y
STA VAR_XC,Y
STA VAR_ZC,Y
STA VAR_XN,Y
STA VAR_YN,Y
STA VAR_ZN,Y
STA VAR_TI,Y
STA VAR_I,Y
STA VAR_Q,Y
STA VAR_IT,Y
STA VAR_P,Y
STA VAR_YC,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
LDA #<VAR_PT%[]
LDY #>VAR_PT%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_AG[]
LDY #>VAR_AG[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_XY%[]
LDY #>VAR_XY%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_TS%[]
LDY #>VAR_TS%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_CS%[]
LDY #>VAR_CS%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_V%
STA VAR_V%+1
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: $000000
CONST_0	.BYTE 6
.STRG "000000"
; CONST: #40

CONST_1R	.REAL 40.0
; CONST: #0.0

CONST_2	.REAL 0.0
; CONST: #56576

CONST_3	.REAL 56576
; CONST: #252

CONST_4R	.REAL 252.0
; CONST: #2

CONST_5R	.REAL 2.0
; CONST: #247.0

CONST_6	.REAL 247.0
; CONST: #0

CONST_7R	.REAL 0.0
; CONST: #53272

CONST_8	.REAL 53272
; CONST: #15

CONST_9R	.REAL 15.0
; CONST: #128

CONST_10R	.REAL 128.0
; CONST: #53265


; CONST: #32


; CONST: #53270


; CONST: #16

CONST_14R	.REAL 16.0
; CONST: #3

CONST_15R	.REAL 3.0
; CONST: #1

CONST_16R	.REAL 1.0
; CONST: #223


; CONST: #239


; CONST: #200

CONST_19R	.REAL 200.0
; CONST: #64

CONST_20R	.REAL 64.0
; CONST: #0.3

CONST_21	.REAL 0.3
; CONST: #17

CONST_22R	.REAL 17.0
; CONST: #9

CONST_23R	.REAL 9.0
; CONST: #6

CONST_24R	.REAL 6.0
; CONST: #4

CONST_25R	.REAL 4.0
; CONST: #7

CONST_26R	.REAL 7.0
; CONST: #8

CONST_27R	.REAL 8.0
; CONST: #16384

CONST_28R	.REAL 16384.0
; CONST: #4032

CONST_29R	.REAL 4032.0
; CONST: #4095

CONST_30R	.REAL 4095.0
; CONST: #49152.0

CONST_31	.REAL 49152.0
; CONST: #25.0

CONST_32	.REAL 25.0
; CONST: #-10.0

CONST_33	.REAL -10.0
; CONST: #10

CONST_34R	.REAL 10.0
; CONST: #-25.0

CONST_35	.REAL -25.0
; CONST: #5

CONST_36R	.REAL 5.0
; CONST: #11

CONST_37R	.REAL 11.0
; CONST: #12

CONST_38R	.REAL 12.0
; CONST: #13

CONST_39R	.REAL 13.0
; CONST: #14

CONST_40R	.REAL 14.0
; CONST: #64.0

CONST_41	.REAL 64.0
; CONST: #24383

CONST_42R	.REAL 24383.0
; CONST: #110

CONST_43R	.REAL 110.0
; CONST: #24576

CONST_44R	.REAL 24576.0
; CONST: #25575

CONST_45R	.REAL 25575.0
; CONST: #55296

CONST_46	.REAL 55296
; CONST: #56295

CONST_47	.REAL 56295
; CONST: ${clr}unpacking texture...
CONST_48	.BYTE 25
.STRG "{clr}unpacking texture..."
; CONST: #53247.0

CONST_49	.REAL 53247.0
; CONST: #192

CONST_50R	.REAL 192.0
; CONST: #48

CONST_51R	.REAL 48.0
;###############################
; ******** DATA ********
DATAS
.BYTE 199
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 90
.BYTE 13
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 149
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 12
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 3
.BYTE 85
.BYTE 12
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 3
.BYTE 3
.BYTE 85
.BYTE 12
.BYTE 170
.BYTE 4
.BYTE 85
.BYTE 11
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 4
.BYTE 85
.BYTE 11
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 4
.BYTE 85
.BYTE 11
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 4
.BYTE 85
.BYTE 11
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 149
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 11
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 149
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 90
.BYTE 13
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 3
.BYTE 2
.BYTE 170
.BYTE 3
.BYTE 3
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 7
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 3
.BYTE 85
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 90
.BYTE 7
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 7
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 13
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 13
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 7
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 1
.BYTE 218
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 1
.BYTE 250
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 1
.BYTE 254
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 3
.BYTE 170
.BYTE 3
.BYTE 3
.BYTE 3
.BYTE 255
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 149
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 3
.BYTE 2
.BYTE 170
.BYTE 3
.BYTE 3
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 1
.BYTE 234
.BYTE 7
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 149
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 13
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 3
.BYTE 2
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 11
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 4
.BYTE 85
.BYTE 11
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 4
.BYTE 85
.BYTE 12
.BYTE 170
.BYTE 4
.BYTE 85
.BYTE 12
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 149
.BYTE 3
.BYTE 3
.BYTE 85
.BYTE 12
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 3
.BYTE 85
.BYTE 13
.BYTE 170
.BYTE 3
.BYTE 3
.BYTE 85
.BYTE 13
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 40
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 6
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 154
.BYTE 8
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 6
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 90
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 3
.BYTE 1
.BYTE 90
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 150
.BYTE 3
.BYTE 1
.BYTE 153
.BYTE 3
.BYTE 1
.BYTE 101
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 3
.BYTE 1
.BYTE 89
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 154
.BYTE 3
.BYTE 1
.BYTE 90
.BYTE 3
.BYTE 2
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 3
.BYTE 1
.BYTE 166
.BYTE 3
.BYTE 1
.BYTE 150
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 166
.BYTE 3
.BYTE 1
.BYTE 154
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 166
.BYTE 3
.BYTE 1
.BYTE 153
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 150
.BYTE 3
.BYTE 1
.BYTE 153
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 166
.BYTE 3
.BYTE 2
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 90
.BYTE 3
.BYTE 1
.BYTE 166
.BYTE 3
.BYTE 1
.BYTE 150
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 3
.BYTE 1
.BYTE 154
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 150
.BYTE 3
.BYTE 1
.BYTE 153
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 154
.BYTE 3
.BYTE 1
.BYTE 153
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 3
.BYTE 2
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 150
.BYTE 3
.BYTE 1
.BYTE 166
.BYTE 3
.BYTE 1
.BYTE 154
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 3
.BYTE 1
.BYTE 154
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 166
.BYTE 3
.BYTE 1
.BYTE 153
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 150
.BYTE 3
.BYTE 1
.BYTE 153
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 3
.BYTE 2
.BYTE 170
.BYTE 3
.BYTE 2
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 166
.BYTE 3
.BYTE 1
.BYTE 154
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 106
.BYTE 3
.BYTE 1
.BYTE 85
.BYTE 3
.BYTE 1
.BYTE 165
.BYTE 3
.BYTE 1
.BYTE 105
.BYTE 3
.BYTE 1
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 86
.BYTE 160
.BYTE 170
.BYTE 3
.BYTE 1
.BYTE 170
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: W
VAR_W	.REAL 0.0
; VAR: XD
VAR_XD	.REAL 0.0
; VAR: YD
VAR_YD	.REAL 0.0
; VAR: XH
VAR_XH	.REAL 0.0
; VAR: YH
VAR_YH	.REAL 0.0
; VAR: TC
VAR_TC	.REAL 0.0
; VAR: T
VAR_T	.REAL 0.0
; VAR: L
VAR_L	.REAL 0.0
; VAR: R
VAR_R	.REAL 0.0
; VAR: TT
VAR_TT	.REAL 0.0
; VAR: TL
VAR_TL	.REAL 0.0
; VAR: TR
VAR_TR	.REAL 0.0
; VAR: DL
VAR_DL	.REAL 0.0
; VAR: DR
VAR_DR	.REAL 0.0
; VAR: U0
VAR_U0	.REAL 0.0
; VAR: U1
VAR_U1	.REAL 0.0
; VAR: V0
VAR_V0	.REAL 0.0
; VAR: V1
VAR_V1	.REAL 0.0
; VAR: N
VAR_N	.REAL 0.0
; VAR: DF
VAR_DF	.REAL 0.0
; VAR: DE
VAR_DE	.REAL 0.0
; VAR: XS
VAR_XS	.REAL 0.0
; VAR: XE
VAR_XE	.REAL 0.0
; VAR: US
VAR_US	.REAL 0.0
; VAR: UE
VAR_UE	.REAL 0.0
; VAR: VS
VAR_VS	.REAL 0.0
; VAR: VE
VAR_VE	.REAL 0.0
; VAR: KP
VAR_KP	.REAL 0.0
; VAR: U
VAR_U	.REAL 0.0
; VAR: V
VAR_V	.REAL 0.0
; VAR: LE
VAR_LE	.REAL 0.0
; VAR: DU
VAR_DU	.REAL 0.0
; VAR: DV
VAR_DV	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: TP
VAR_TP	.REAL 0.0
; VAR: SI
VAR_SI	.REAL 0.0
; VAR: CO
VAR_CO	.REAL 0.0
; VAR: C
VAR_C	.REAL 0.0
; VAR: MT
VAR_MT	.REAL 0.0
; VAR: MA
VAR_MA	.REAL 0.0
; VAR: XC
VAR_XC	.REAL 0.0
; VAR: ZC
VAR_ZC	.REAL 0.0
; VAR: XN
VAR_XN	.REAL 0.0
; VAR: YN
VAR_YN	.REAL 0.0
; VAR: ZN
VAR_ZN	.REAL 0.0
; VAR: TI
VAR_TI	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: PT%[]
.BYTE 0
.WORD 10
VAR_PT%[]	.ARRAY 10
; VAR: AG[]
.BYTE 1
.WORD 20
VAR_AG[]	.ARRAY 20
; VAR: XY%[]
.BYTE 0
.WORD 38
VAR_XY%[]	.ARRAY 38
; VAR: TS%[]
.BYTE 0
.WORD 26
VAR_TS%[]	.ARRAY 26
; VAR: Q
VAR_Q	.REAL 0.0
; VAR: IT
VAR_IT	.REAL 0.0
; VAR: P
VAR_P	.REAL 0.0
; VAR: CS%[]
.BYTE 0
.WORD 38
VAR_CS%[]	.ARRAY 38
; VAR: YC
VAR_YC	.REAL 0.0
; VAR: V%
VAR_V%	.WORD 0
STRINGVARS_START
; VAR: TI$
VAR_TI$	.WORD EMPTYSTR
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
