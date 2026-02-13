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
LINE_1000:
;
JMP LINE_1310
;
LINE_1010:
;
;
LINE_1020:
;
;
LINE_1030:
;
;
LINE_1040:
;
LDY #64
STY 19
; Optimizer rule: Simple POKE/2
;
LINE_1050:
;
INPUT1:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_1
LDY #>CONST_1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP6
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A$
LDY #>VAR_A$
JSR COPYSTRING
EMPTYINPUTSKIP6:
JSR QUEUESIZE
LDA X_REG
COMP_SKP0:
BEQ INPUTCHECK1
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK1:
;
LINE_1060:
;
LDY CONST_2
STY 19
; Optimizer rule: Simple POKE/2
;
LINE_1070:
;
JSR LINEBREAK
;
LINE_1080:
;
JMP RETURN
;
LINE_1090:
;
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
JSR CLEARQUEUE
JSR COMPACTMAX
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTSTRCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP7
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X1$
LDY #>VAR_X1$
JSR COPYSTRING
EMPTYINPUTSKIP7:
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTSTRCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP8
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X2$
LDY #>VAR_X2$
JSR COPYSTRING
EMPTYINPUTSKIP8:
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTSTRCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP9
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X3$
LDY #>VAR_X3$
JSR COPYSTRING
EMPTYINPUTSKIP9:
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTSTRCHANNEL
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP10
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X4$
LDY #>VAR_X4$
JSR COPYSTRING
EMPTYINPUTSKIP10:
;
LINE_1100:
;
LDA VAR_X1$
LDY VAR_X1$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
;
LINE_1110:
;
JSR COMPACTMAX
LDA #<CONST_4
LDY #>CONST_4
STA B_REG
STY B_REG+1
LDA VAR_X1$
LDY VAR_X1$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_X2$
LDY VAR_X2$+1
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_4
LDY #>CONST_4
STA B_REG
STY B_REG+1
JSR CONCAT
LDA VAR_X3$
LDY VAR_X3$+1
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_4
LDY #>CONST_4
STA B_REG
STY B_REG+1
JSR CONCAT
LDA VAR_X4$
LDY VAR_X4$+1
STA B_REG
STY B_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D$
LDY #>VAR_D$
JSR COPYSTRING
;
LINE_1120:
;
JMP RETURN
;
LINE_1130:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_L$
LDY #>VAR_L$
JSR COPYSTRING
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_H$
LDY #>VAR_H$
JSR COPYSTRING
;
LINE_1140:
;
JSR COMPACTMAX
LDA CONST_2
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_H$
LDY VAR_H$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASCNXREG
LDY #0
LDA TMP2_ZP
JSR INTFAC
JSR FACXREG
; Optimized ASC*256
;
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA CONST_2
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_L$
LDY VAR_L$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AD
LDY #>VAR_AD
; FAC to (X/Y)
JSR FACMEM
;
LINE_1150:
;
JMP RETURN
;
LINE_1160:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_DA$
STY VAR_DA$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_1170:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
;
LINE_1180:
;
LDA #<CONST_1
LDY #>CONST_1
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP1:
BEQ LINE_SKIP45
; Simplified conditional branch
;
LINE_NSKIP45:
;
JSR COMPACTMAX
LDA VAR_X$
LDY VAR_X$+1
STA B_REG
STY B_REG+1
LDA VAR_DA$
LDY VAR_DA$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_DA$
LDY #>VAR_DA$
JSR COPYSTRING
JMP LINE_1170
;
LINE_SKIP45:
;
;
LINE_1190:
;
JMP RETURN
;
LINE_1200:
;
LDX #4
dcloop401_1:
LDA CONST_3R,X
STA VAR_YY,X
DEX
BPL dcloop401_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_SS
LDY #>VAR_SS
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_YY
LDY #>VAR_YY
STA A_REG
STY A_REG+1
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
;
LINE_1210:
;
LDA #<VAR_YY
LDY #>VAR_YY
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<VAR_JA
LDY #>VAR_JA
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ0:
EQ_SKIP0:
COMP_SKP2:
BNE LINE_SKIP46
LINE_NSKIP46:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_YY
LDY #>VAR_YY
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_U[]
LDY #>VAR_U[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_JN
LDY #>VAR_JN
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_SKIP46:
;
;
LINE_1220:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_0
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_0:
;
LINE_1230:
;
LDA #<CONST_7
LDY #>CONST_7
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_ER$
LDY #>VAR_ER$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_1240:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_ER
LDY #>VAR_ER
; FAC to (X/Y)
JSR FACMEM
;
LINE_1250:
;
JSR GOSUB
JSR LINE_3580
;
LINE_1260:
;
LDX #4
dcloop567_1:
LDA CONST_8,X
STA VAR_JN,X
DEX
BPL dcloop567_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1270:
;
JMP RETURN
;
LINE_1280:
;
;
LINE_1290:
;
;
LINE_1300:
;
;
LINE_1310:
;
;
LINE_1320:
;
;
LINE_1330:
;
;
LINE_1340:
;
;
LINE_1350:
;
;
LINE_1360:
;
;
LINE_1370:
;
;
LINE_1380:
;
LDA #<CONST_9
LDY #>CONST_9
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1390:
;
LDA #<CONST_10
LDY #>CONST_10
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1400:
;
JSR GOSUB
JSR LINE_1040
;
LINE_1410:
;
LDA VAR_A$
LDY VAR_A$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_SN$
LDY #>VAR_SN$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_1420:
;
LDA #<CONST_11
LDY #>CONST_11
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1430:
;
JSR GOSUB
JSR LINE_1040
;
LINE_1440:
;
LDA VAR_A$
LDY VAR_A$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_DN$
LDY #>VAR_DN$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_1450:
;
LDA #<CONST_12
LDY #>CONST_12
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1460:
;
LDY CONST_2
STY 204
; Optimizer rule: Simple POKE/2
;
LINE_1470:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_FO$
LDY #>VAR_FO$
JSR COPYSTRING
;
LINE_1480:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_FO$
LDY VAR_FO$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_14
LDY #>CONST_14
STA B_REG
STY B_REG+1
LDA VAR_FO$
LDY VAR_FO$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_15
LDY #>CONST_15
STA B_REG
STY B_REG+1
LDA VAR_FO$
LDY VAR_FO$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP4:
BEQ LINE_SKIP47
; Simplified conditional branch
;
LINE_NSKIP47:
;
JMP LINE_1470
;
LINE_SKIP47:
;
;
LINE_1490:
;
LDY #1
STY 204
; Optimizer rule: Simple POKE/2
;
LINE_1500:
;
LDA VAR_FO$
LDY VAR_FO$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1510:
;
LDA #<CONST_16
LDY #>CONST_16
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1520:
;
JSR GOSUB
JSR LINE_1040
;
LINE_1530:
;
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<VAR_SA
LDY #>VAR_SA
; FAC to (X/Y)
JSR FACMEM
;
LINE_1540:
;
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1550:
;
JSR GOSUB
JSR LINE_1040
;
LINE_1560:
;
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_SZ
LDY #>VAR_SZ
; FAC to (X/Y)
JSR FACMEM
;
LINE_1570:
;
LDA #<CONST_18
LDY #>CONST_18
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1580:
;
JSR GOSUB
JSR LINE_1040
;
LINE_1590:
;
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_SW
LDY #>VAR_SW
; FAC to (X/Y)
JSR FACMEM
;
LINE_1600:
;
LDA #<CONST_9
LDY #>CONST_9
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1610:
;
LDA #<CONST_19
LDY #>CONST_19
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_SN$
LDY VAR_SN$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1620:
;
LDA #<CONST_20
LDY #>CONST_20
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_DN$
LDY VAR_DN$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1630:
;
;
LINE_1640:
;
;
LINE_1650:
;
;
LINE_1660:
;
LDA #<CONST_21
LDY #>CONST_21
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_22R
LDY #>CONST_22R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1670:
;
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24
LDY #>CONST_24
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_25R
LDY #>CONST_25R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_22R
LDY #>CONST_22R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_1680:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24
LDY #>CONST_24
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA VAR_SN$
LDY VAR_SN$+1
STA B_REG
STY B_REG+1
LDY B_REG
LDA B_REG+1
STY G_REG
STA G_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_26R
LDY #>CONST_26R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_1690:
;
JSR GOSUB
JSR LINE_1090
;
LINE_1700:
;
LDA VAR_D
COMP_SKP5:
BEQ LINE_SKIP48
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP48:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
JSR GOSUB
JSR LINE_3600
JSR RUN
;
LINE_SKIP48:
;
;
LINE_1710:
;
JSR GOSUB
JSR LINE_1130
;
LINE_1720:
;
JSR GOSUB
JSR LINE_1130
;
LINE_1730:
;
LDA VAR_AD
BEQ EQ_SKIP1
EQ_EQ1:
JMP LINE_SKIP49
EQ_SKIP1:
COMP_SKP6:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP49:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
JMP LINE_1840
;
LINE_SKIP49:
;
;
LINE_1740:
;
JSR GOSUB
JSR LINE_1130
;
LINE_1750:
;
LDA #<CONST_21
LDY #>CONST_21
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_27R
LDY #>CONST_27R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<VAR_AD
LDY #>VAR_AD
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_1760:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_SS
LDY #>VAR_SS
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SS
LDY #>VAR_SS
; FAC to (X/Y)
JSR FACMEM
;
LINE_1770:
;
LDA #<VAR_SS
LDY #>VAR_SS
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AD
LDY #>VAR_AD
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_S[]
LDY #>VAR_S[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1780:
;
JSR GOSUB
JSR LINE_1160
;
LINE_1790:
;
LDA VAR_DA$
LDY VAR_DA$+1
STA A_REG
STY A_REG+1
LDA #<VAR_SS
LDY #>VAR_SS
JSR COPY2_XYA_XREGFAC
; Optimizer rule: Faster array access setup(2)/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_S$[]
LDY #>VAR_S$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_1800:
;
JMP LINE_1720
;
LINE_1810:
;
;
LINE_1820:
;
;
LINE_1830:
;
;
LINE_1840:
;
LDA #<CONST_21
LDY #>CONST_21
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_28R
LDY #>CONST_28R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1850:
;
LDX #4
dcloop1065_1:
LDA CONST_3R,X
STA VAR_I,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_SS
LDY #>VAR_SS
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
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
LINE_1860:
;
LDA #<CONST_21
LDY #>CONST_21
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_30R
LDY #>CONST_30R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_1870:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_SW
LDY #>VAR_SW
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_SZ
LDY #>VAR_SZ
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
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_U[]
LDY #>VAR_U[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1880:
;
LDA #0
STA VAR_F1
STA VAR_F1+1
STA VAR_F1+2
STA VAR_F1+3
STA VAR_F1+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1890:
;
LDA #0
STA VAR_F2
STA VAR_F2+1
STA VAR_F2+2
STA VAR_F2+3
STA VAR_F2+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1900:
;
LDA #0
STA VAR_F3
STA VAR_F3+1
STA VAR_F3+2
STA VAR_F3+3
STA VAR_F3+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1910:
;
LDX #4
dcloop1065_2:
LDA CONST_3R,X
STA VAR_M,X
DEX
BPL dcloop1065_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_S$[]
LDY #>VAR_S$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_M
LDY #>VAR_M
STA A_REG
STY A_REG+1
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
;
LINE_1920:
;
JSR COMPACTMAX
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; ignored: CHGCTX #1
LDA #<VAR_S$[]
LDY #>VAR_S$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
;
LINE_1930:
;
JSR COMPACTMAX
LDA CONST_2
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_1940:
;
LDA #<CONST_1
LDY #>CONST_1
STA B_REG
STY B_REG+1
LDA VAR_ZE$
LDY VAR_ZE$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_31
LDY #>CONST_31
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP7:
BEQ LINE_SKIP50
; Simplified conditional branch
;
LINE_NSKIP50:
;
JMP LINE_2010
;
LINE_SKIP50:
;
;
LINE_1950:
;
LDX #4
dceloop5148_1:
LDA CONST_32R,X
CMP VAR_X,X
BNE LINE_SKIP51
DEX
BPL dceloop5148_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP51:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1231_1:
LDA CONST_3R,X
STA VAR_F1,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP51:
;
;
LINE_1960:
;
LDX #4
dceloop5148_2:
LDA CONST_33R,X
CMP VAR_X,X
BNE LINE_SKIP52
DEX
BPL dceloop5148_2
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP52:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1397_1:
LDA CONST_3R,X
STA VAR_F1,X
DEX
BPL dcloop1397_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP52:
;
;
LINE_1970:
;
LDX #4
dceloop5148_3:
LDA CONST_34R,X
CMP VAR_X,X
BNE LINE_SKIP53
DEX
BPL dceloop5148_3
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP53:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_F2
LDY #>VAR_F2
JSR REALFAC
LDA #<CONST_3R
LDY #>CONST_3R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F2
LDY #>VAR_F2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP53:
;
;
LINE_1980:
;
JSR COMPACTMAX
LDA VAR_X$
LDY VAR_X$+1
STA B_REG
STY B_REG+1
LDA VAR_ZE$
LDY VAR_ZE$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_ZE$
LDY #>VAR_ZE$
JSR COPYSTRING
;
LINE_1990:
;
LDA #<VAR_M
LDY #>VAR_M
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
;
LINE_2000:
;
LDX #4
dcloop1397_2:
LDA CONST_3R,X
STA VAR_F3,X
DEX
BPL dcloop1397_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2010:
;
LDA VAR_F3
BEQ EQ_SKIP5
EQ_EQ5:
JMP LINE_SKIP54
EQ_SKIP5:
COMP_SKP12:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP54:
;
LDA #<VAR_F2
LDY #>VAR_F2
JSR REALFAC
LDA #<VAR_F1
LDY #>VAR_F1
JSR MEMARG
JSR FASTOR
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP13:
BEQ LINE_SKIP55
; Simplified conditional branch
;
LINE_NSKIP55:
;
JMP LINE_1980
;
LINE_SKIP55:
;
;
LINE_SKIP54:
;
;
LINE_2020:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_DD
LDY #>VAR_DD
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DD
LDY #>VAR_DD
; FAC to (X/Y)
JSR FACMEM
;
LINE_2030:
;
LDA VAR_ZE$
LDY VAR_ZE$+1
STA A_REG
STY A_REG+1
LDA #<VAR_DD
LDY #>VAR_DD
JSR COPY2_XYA_XREGFAC
; Optimizer rule: Faster array access setup(2)/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_2040:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_ZE$
STY VAR_ZE$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_2050:
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_SW
LDY #>VAR_SW
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_SZ
LDY #>VAR_SZ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_SW
LDY #>VAR_SW
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_D[]
LDY #>VAR_D[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_2060:
;
LDA VAR_F3
BEQ EQ_SKIP6
EQ_EQ6:
JMP LINE_SKIP56
EQ_SKIP6:
COMP_SKP14:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP56:
;
LDA #<VAR_M
LDY #>VAR_M
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_2
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_2:
;
LINE_SKIP56:
;
;
LINE_2070:
;
LDA #<CONST_1
LDY #>CONST_1
STA A_REG
STY A_REG+1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_S$[]
LDY #>VAR_S$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_2080:
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
LINE_2090:
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_8
LDY #>CONST_8
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT7
LDA #0
JMP GT_SKIP7
GT_GT7:
LDA #$1
GT_SKIP7:
COMP_SKP17:
BEQ LINE_SKIP57
; Simplified conditional branch
;
LINE_NSKIP57:
;
LDA #<CONST_35
LDY #>CONST_35
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_ER$
LDY #>VAR_ER$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA #0
STA VAR_ER
STA VAR_ER+1
STA VAR_ER+2
STA VAR_ER+3
STA VAR_ER+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_3580
JSR RUN
;
LINE_SKIP57:
;
;
LINE_2100:
;
;
LINE_2110:
;
;
LINE_2120:
;
;
LINE_2130:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_22R
LDY #>CONST_22R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_37
LDY #>CONST_37
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2140:
;
LDX #4
dcloop1729_1:
LDA CONST_3R,X
STA VAR_I,X
DEX
BPL dcloop1729_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
;
LINE_2150:
;
LDA #0
STA VAR_MM
STA VAR_MM+1
STA VAR_MM+2
STA VAR_MM+3
STA VAR_MM+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2160:
;
LDA #0
STA VAR_F1
STA VAR_F1+1
STA VAR_F1+2
STA VAR_F1+3
STA VAR_F1+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2170:
;
LDA #0
STA VAR_F2
STA VAR_F2+1
STA VAR_F2+2
STA VAR_F2+3
STA VAR_F2+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2180:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_27R
LDY #>CONST_27R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_2190:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
;
LINE_2200:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT8
LDA #0
JMP GT_SKIP8
GT_GT8:
LDA #$1
GT_SKIP8:
COMP_SKP18:
BEQ LINE_SKIP58
; Simplified conditional branch
;
LINE_NSKIP58:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_4
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_4:
JMP LINE_3090
;
LINE_SKIP58:
;
;
LINE_2210:
;
JSR COMPACTMAX
LDA CONST_2
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; ignored: CHGCTX #0
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_YY
LDY #>VAR_YY
; FAC to (X/Y)
JSR FACMEM
;
LINE_2220:
;
LDX #4
dceloop5148_4:
LDA CONST_34R,X
CMP VAR_YY,X
BNE LINE_SKIP59
DEX
BPL dceloop5148_4
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP59:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_F2
LDY #>VAR_F2
JSR REALFAC
LDA #<CONST_3R
LDY #>CONST_3R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F2
LDY #>VAR_F2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP59:
;
;
LINE_2230:
;
LDX #4
dceloop5148_5:
LDA CONST_33R,X
CMP VAR_YY,X
BNE LINE_SKIP60
DEX
BPL dceloop5148_5
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP60:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1895_1:
LDA CONST_3R,X
STA VAR_F1,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP60:
;
;
LINE_2240:
;
LDA #<VAR_F2
LDY #>VAR_F2
JSR REALFAC
LDA #<VAR_F1
LDY #>VAR_F1
JSR MEMARG
JSR FASTOR
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP22:
BEQ LINE_SKIP61
; Simplified conditional branch
;
LINE_NSKIP61:
;
JMP LINE_2190
;
LINE_SKIP61:
;
;
LINE_2250:
;
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
LDA #<VAR_YY
LDY #>VAR_YY
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ11
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP11
EQ_EQ11:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP11:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFAC
LDA #<VAR_YY
LDY #>VAR_YY
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ12
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP12
EQ_EQ12:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP12:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP23:
BEQ LINE_SKIP62
; Simplified conditional branch
;
LINE_NSKIP62:
;
JMP LINE_2310
;
LINE_SKIP62:
;
;
LINE_2260:
;
LDX #4
dceloop5148_6:
LDA CONST_41R,X
CMP VAR_YY,X
BNE LINE_SKIP63
DEX
BPL dceloop5148_6
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP63:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_2490
;
LINE_SKIP63:
;
;
LINE_2270:
;
LDX #4
dceloop5148_7:
LDA CONST_42R,X
CMP VAR_YY,X
BNE LINE_SKIP64
DEX
BPL dceloop5148_7
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP64:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_2570
;
LINE_SKIP64:
;
;
LINE_2280:
;
LDX #4
dceloop5148_8:
LDA CONST_43R,X
CMP VAR_YY,X
BNE LINE_SKIP65
DEX
BPL dceloop5148_8
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP65:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_2980
;
LINE_SKIP65:
;
;
LINE_2290:
;
JMP LINE_2190
;
LINE_2300:
;
;
LINE_2310:
;
LDA #0
STA VAR_JA
STA VAR_JA+1
STA VAR_JA+2
STA VAR_JA+3
STA VAR_JA+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2320:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_JA$
STY VAR_JA$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_2330:
;
LDA #0
STA VAR_NN
STA VAR_NN+1
STA VAR_NN+2
STA VAR_NN+3
STA VAR_NN+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2340:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_NN
LDY #>VAR_NN
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_NN
LDY #>VAR_NN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2350:
;
JSR COMPACTMAX
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_NN$
LDY #>VAR_NN$
JSR COPYSTRING
;
LINE_2360:
;
LDA #<CONST_44
LDY #>CONST_44
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_45
LDY #>CONST_45
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SGT
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_46
LDY #>CONST_46
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SLT
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP27:
BEQ LINE_SKIP66
; Simplified conditional branch
;
LINE_NSKIP66:
;
JMP LINE_2390
;
LINE_SKIP66:
;
;
LINE_2370:
;
JSR COMPACTMAX
LDA VAR_NN$
LDY VAR_NN$+1
STA B_REG
STY B_REG+1
LDA VAR_JA$
LDY VAR_JA$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_JA$
LDY #>VAR_JA$
JSR COPYSTRING
;
LINE_2380:
;
JMP LINE_2340
;
LINE_2390:
;
LDA VAR_JA$
LDY VAR_JA$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_JA
LDY #>VAR_JA
; FAC to (X/Y)
JSR FACMEM
;
LINE_2400:
;
JSR GOSUB
JSR LINE_1200
;
LINE_2410:
;
JSR COMPACTMAX
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR LEFT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_LI$
LDY #>VAR_LI$
JSR COPYSTRING
;
LINE_2420:
;
JSR COMPACTMAX
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_47
LDY #>CONST_47
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_RE$
LDY #>VAR_RE$
JSR COPYSTRING
;
LINE_2430:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_JN
LDY #>VAR_JN
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR STR
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_LI$
LDY VAR_LI$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_RE$
LDY VAR_RE$+1
STA B_REG
STY B_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_2440:
;
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
;
LINE_2450:
;
JMP LINE_2190
;
LINE_2460:
;
;
LINE_2470:
;
;
LINE_2480:
;
;
LINE_2490:
;
LDA #0
STA VAR_NN
STA VAR_NN+1
STA VAR_NN+2
STA VAR_NN+3
STA VAR_NN+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2500:
;
;
LINE_2510:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_NN
LDY #>VAR_NN
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_NN
LDY #>VAR_NN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2520:
;
JSR COMPACTMAX
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_NN$
LDY #>VAR_NN$
JSR COPYSTRING
;
LINE_2530:
;
LDA #<CONST_44
LDY #>CONST_44
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_45
LDY #>CONST_45
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SGT
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_46
LDY #>CONST_46
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SLT
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP28:
BEQ LINE_SKIP67
; Simplified conditional branch
;
LINE_NSKIP67:
;
JMP LINE_2190
;
LINE_SKIP67:
;
;
LINE_2540:
;
LDA #<CONST_44
LDY #>CONST_44
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP29:
BEQ LINE_SKIP68
; Simplified conditional branch
;
LINE_NSKIP68:
;
JMP LINE_2510
;
LINE_SKIP68:
;
;
LINE_2550:
;
JMP LINE_2310
;
LINE_2560:
;
;
LINE_2570:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
;
LINE_2580:
;
JSR COMPACTMAX
LDA CONST_2
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; ignored: CHGCTX #0
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_AS
LDY #>VAR_AS
; FAC to (X/Y)
JSR FACMEM
;
LINE_2590:
;
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
LDA #<VAR_AS
LDY #>VAR_AS
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ16
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP16
EQ_EQ16:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP16:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFAC
LDA #<VAR_AS
LDY #>VAR_AS
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ17
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP17
EQ_EQ17:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP17:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP30:
BEQ LINE_SKIP69
; Simplified conditional branch
;
LINE_NSKIP69:
;
JMP LINE_2760
;
LINE_SKIP69:
;
;
LINE_2600:
;
LDX #4
dceloop5148_9:
LDA CONST_43R,X
CMP VAR_AS,X
BNE LINE_SKIP70
DEX
BPL dceloop5148_9
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP70:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_2670
;
LINE_SKIP70:
;
;
LINE_2610:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ19
ROL
BCC LT_LT19
LT_LT_EQ19:
LDA #0
JMP LT_SKIP19
LT_LT19:
LDA #$1
LT_SKIP19:
COMP_SKP32:
BEQ LINE_SKIP71
; Simplified conditional branch
;
LINE_NSKIP71:
;
JMP LINE_2570
;
LINE_SKIP71:
;
;
LINE_2620:
;
LDA #<CONST_48
LDY #>CONST_48
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_ER$
LDY #>VAR_ER$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_2630:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_ER
LDY #>VAR_ER
; FAC to (X/Y)
JSR FACMEM
;
LINE_2640:
;
JSR GOSUB
JSR LINE_3580
;
LINE_2650:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_5
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_5:
;
LINE_2660:
;
;
LINE_2670:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
;
LINE_2680:
;
JSR COMPACTMAX
LDA CONST_2
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; ignored: CHGCTX #0
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_AS
LDY #>VAR_AS
; FAC to (X/Y)
JSR FACMEM
;
LINE_2690:
;
LDX #4
dceloop5148_10:
LDA CONST_49R,X
CMP VAR_AS,X
BNE LINE_SKIP72
DEX
BPL dceloop5148_10
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP72:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_2760
;
LINE_SKIP72:
;
;
LINE_2700:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ21
ROL
BCC LT_LT21
LT_LT_EQ21:
LDA #0
JMP LT_SKIP21
LT_LT21:
LDA #$1
LT_SKIP21:
COMP_SKP35:
BEQ LINE_SKIP73
; Simplified conditional branch
;
LINE_NSKIP73:
;
JMP LINE_2670
;
LINE_SKIP73:
;
;
LINE_2710:
;
LDA #<CONST_50
LDY #>CONST_50
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_ER$
LDY #>VAR_ER$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_2720:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_ER
LDY #>VAR_ER
; FAC to (X/Y)
JSR FACMEM
;
LINE_2730:
;
JSR GOSUB
JSR LINE_3580
;
LINE_2740:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
;
LINE_2750:
;
;
LINE_2760:
;
LDA #0
STA VAR_NN
STA VAR_NN+1
STA VAR_NN+2
STA VAR_NN+3
STA VAR_NN+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2770:
;
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
;
LINE_2780:
;
LDA #0
STA VAR_NN
STA VAR_NN+1
STA VAR_NN+2
STA VAR_NN+3
STA VAR_NN+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2790:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_JA$
STY VAR_JA$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_2800:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_NN
LDY #>VAR_NN
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_NN
LDY #>VAR_NN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2810:
;
JSR COMPACTMAX
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_NN$
LDY #>VAR_NN$
JSR COPYSTRING
;
LINE_2820:
;
LDA #<CONST_44
LDY #>CONST_44
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_45
LDY #>CONST_45
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SGT
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_46
LDY #>CONST_46
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SLT
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP37:
BEQ LINE_SKIP74
; Simplified conditional branch
;
LINE_NSKIP74:
;
JMP LINE_2850
;
LINE_SKIP74:
;
;
LINE_2830:
;
JSR COMPACTMAX
LDA VAR_NN$
LDY VAR_NN$+1
STA B_REG
STY B_REG+1
LDA VAR_JA$
LDY VAR_JA$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_JA$
LDY #>VAR_JA$
JSR COPYSTRING
;
LINE_2840:
;
JMP LINE_2800
;
LINE_2850:
;
LDA VAR_JA$
LDY VAR_JA$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_JA
LDY #>VAR_JA
; FAC to (X/Y)
JSR FACMEM
;
LINE_2860:
;
JSR GOSUB
JSR LINE_1200
;
LINE_2870:
;
JSR COMPACTMAX
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR LEFT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_LI$
LDY #>VAR_LI$
JSR COPYSTRING
;
LINE_2880:
;
JSR COMPACTMAX
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_47
LDY #>CONST_47
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_RE$
LDY #>VAR_RE$
JSR COPYSTRING
;
LINE_2890:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_JN
LDY #>VAR_JN
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR STR
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_LI$
LDY VAR_LI$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_RE$
LDY VAR_RE$+1
STA B_REG
STY B_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_2900:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_NN
LDY #>VAR_NN
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_NN
LDY #>VAR_NN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2910:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_NN
LDY #>VAR_NN
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_NN
LDY #>VAR_NN
; FAC to (X/Y)
JSR FACMEM
;
LINE_2920:
;
JSR COMPACTMAX
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_NN$
LDY #>VAR_NN$
JSR COPYSTRING
;
LINE_2930:
;
LDA #<CONST_44
LDY #>CONST_44
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP38:
BEQ LINE_SKIP75
; Simplified conditional branch
;
LINE_NSKIP75:
;
JMP LINE_2910
;
LINE_SKIP75:
;
;
LINE_2940:
;
LDA #<CONST_4
LDY #>CONST_4
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP39:
BEQ LINE_SKIP76
; Simplified conditional branch
;
LINE_NSKIP76:
;
JMP LINE_2770
;
LINE_SKIP76:
;
;
LINE_2950:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT22
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP22
GT_GT22:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP22:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_31
LDY #>CONST_31
STA B_REG
STY B_REG+1
LDA VAR_NN$
LDY VAR_NN$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP40:
BEQ LINE_SKIP77
; Simplified conditional branch
;
LINE_NSKIP77:
;
LDA #<VAR_NN
LDY #>VAR_NN
JSR REALFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
JMP LINE_2190
;
LINE_SKIP77:
;
;
LINE_2960:
;
JMP LINE_2910
;
LINE_2970:
;
;
LINE_2980:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
;
LINE_2990:
;
JSR COMPACTMAX
LDA CONST_2
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; ignored: CHGCTX #0
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_AS
LDY #>VAR_AS
; FAC to (X/Y)
JSR FACMEM
;
LINE_3000:
;
LDX #4
dceloop5148_11:
LDA CONST_49R,X
CMP VAR_AS,X
BNE LINE_SKIP78
DEX
BPL dceloop5148_11
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP78:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_2310
;
LINE_SKIP78:
;
;
LINE_3010:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ24
ROL
BCC LT_LT24
LT_LT_EQ24:
LDA #0
JMP LT_SKIP24
LT_LT24:
LDA #$1
LT_SKIP24:
COMP_SKP42:
BEQ LINE_SKIP79
; Simplified conditional branch
;
LINE_NSKIP79:
;
JMP LINE_2980
;
LINE_SKIP79:
;
;
LINE_3020:
;
LDA #<CONST_50
LDY #>CONST_50
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_ER$
LDY #>VAR_ER$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_3030:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_ER
LDY #>VAR_ER
; FAC to (X/Y)
JSR FACMEM
;
LINE_3040:
;
JSR GOSUB
JSR LINE_3580
;
LINE_3050:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_7
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_7:
;
LINE_3060:
;
;
LINE_3070:
;
;
LINE_3080:
;
;
LINE_3090:
;
LDA #<CONST_14
LDY #>CONST_14
STA B_REG
STY B_REG+1
LDA VAR_FO$
LDY VAR_FO$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_15
LDY #>CONST_15
STA B_REG
STY B_REG+1
LDA VAR_FO$
LDY VAR_FO$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP44:
BEQ LINE_SKIP80
; Simplified conditional branch
;
LINE_NSKIP80:
;
JMP LINE_3300
;
LINE_SKIP80:
;
;
LINE_3100:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_28R
LDY #>CONST_28R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_51
LDY #>CONST_51
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3110:
;
LDA #0
STA VAR_FO
STA VAR_FO+1
STA VAR_FO+2
STA VAR_FO+3
STA VAR_FO+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_3120:
;
LDX #4
dcloop3887_1:
LDA CONST_3R,X
STA VAR_I,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
;
LINE_3130:
;
LDA #0
STA VAR_MM
STA VAR_MM+1
STA VAR_MM+2
STA VAR_MM+3
STA VAR_MM+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_3140:
;
LDA #0
STA VAR_F1
STA VAR_F1+1
STA VAR_F1+2
STA VAR_F1+3
STA VAR_F1+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_3150:
;
LDA #0
STA VAR_F2
STA VAR_F2+1
STA VAR_F2+2
STA VAR_F2+3
STA VAR_F2+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_3160:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; ignored: CHGCTX #0
LDA #<VAR_FO
LDY #>VAR_FO
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<CONST_52
LDY #>CONST_52
STA B_REG
STY B_REG+1
JSR LEFT
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_3170:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_30R
LDY #>CONST_30R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_3180:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_MM
LDY #>VAR_MM
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
;
LINE_3190:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT25
LDA #0
JMP GT_SKIP25
GT_GT25:
LDA #$1
GT_SKIP25:
COMP_SKP45:
BEQ LINE_SKIP81
; Simplified conditional branch
;
LINE_NSKIP81:
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
JMP LINE_3300
;
LINE_SKIP81:
;
;
LINE_3200:
;
JSR COMPACTMAX
LDA CONST_2
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; ignored: CHGCTX #0
LDA #<VAR_MM
LDY #>VAR_MM
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_YY
LDY #>VAR_YY
; FAC to (X/Y)
JSR FACMEM
;
LINE_3210:
;
LDX #4
dceloop5148_12:
LDA CONST_34R,X
CMP VAR_YY,X
BNE LINE_SKIP82
DEX
BPL dceloop5148_12
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP82:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_F2
LDY #>VAR_F2
JSR REALFAC
LDA #<CONST_3R
LDY #>CONST_3R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F2
LDY #>VAR_F2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP82:
;
;
LINE_3220:
;
LDX #4
dceloop5148_13:
LDA CONST_33R,X
CMP VAR_YY,X
BNE LINE_SKIP83
DEX
BPL dceloop5148_13
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP83:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop4053_1:
LDA CONST_3R,X
STA VAR_F1,X
DEX
BPL dcloop4053_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP83:
;
;
LINE_3230:
;
LDA #<VAR_F2
LDY #>VAR_F2
JSR REALFAC
LDA #<VAR_F1
LDY #>VAR_F1
JSR MEMARG
JSR FASTOR
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP49:
BEQ LINE_SKIP84
; Simplified conditional branch
;
LINE_NSKIP84:
;
JMP LINE_3180
;
LINE_SKIP84:
;
;
LINE_3240:
;
LDX #4
dceloop5148_14:
LDA CONST_53R,X
CMP VAR_YY,X
BNE LINE_SKIP85
DEX
BPL dceloop5148_14
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP85:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_FO
LDY #>VAR_FO
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_FO
LDY #>VAR_FO
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP85:
;
;
LINE_3250:
;
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_FO
LDY #>VAR_FO
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT29
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP29
GT_GT29:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP29:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_54R
LDY #>CONST_54R
JSR REALFAC
LDA #<VAR_YY
LDY #>VAR_YY
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ30
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP30
EQ_EQ30:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP30:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP51:
BNE LINE_NSKIP86
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP86
;
LINE_NSKIP86:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_FO
LDY #>VAR_FO
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_FO
LDY #>VAR_FO
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<CONST_22R
LDY #>CONST_22R
JSR REALFAC
LDA #<VAR_FO
LDY #>VAR_FO
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_47
LDY #>CONST_47
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR MID
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; ignored: CHGCTX #0
LDA #<VAR_FO
LDY #>VAR_FO
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<CONST_52
LDY #>CONST_52
STA B_REG
STY B_REG+1
JSR LEFT
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_SKIP86:
;
;
LINE_3260:
;
JMP LINE_3180
;
LINE_3270:
;
;
LINE_3280:
;
;
LINE_3290:
;
;
LINE_3300:
;
LDA #<CONST_55
LDY #>CONST_55
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_56R
LDY #>CONST_56R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_57
LDY #>CONST_57
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3310:
;
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24
LDY #>CONST_24
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_25R
LDY #>CONST_25R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_22R
LDY #>CONST_22R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_3320:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24
LDY #>CONST_24
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA VAR_DN$
LDY VAR_DN$+1
STA B_REG
STY B_REG+1
LDY B_REG
LDA B_REG+1
STY G_REG
STA G_REG+1
JSR POPREAL
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_26R
LDY #>CONST_26R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_3330:
;
JSR GOSUB
JSR LINE_1090
;
LINE_3340:
;
LDA VAR_D
COMP_SKP52:
BEQ LINE_SKIP87
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP87:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
JSR GOSUB
JSR LINE_3600
JMP LINE_3300
;
LINE_SKIP87:
;
;
LINE_3350:
;
LDX #4
dcloop4385_1:
LDA VAR_SA,X
STA VAR_AD,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_3360:
;
LDA #<VAR_SA
LDY #>VAR_SA
JSR REALFAC
LDA #<CONST_58R
LDY #>CONST_58R
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_LB
LDY #>VAR_LB
; FAC to (X/Y)
JSR FACMEM
;
LINE_3370:
;
LDY #8
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_SA
LDY #>VAR_SA
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_HB
LDY #>VAR_HB
; FAC to (X/Y)
JSR FACMEM
;
LINE_3380:
;
JSR LOCKCHANNEL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_LB
LDY #>VAR_LB
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR CHR
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_HB
LDY #>VAR_HB
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR CHR
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR UNLOCKCHANNEL
;
LINE_3390:
;
LDX #4
dcloop4551_1:
LDA CONST_3R,X
STA VAR_I,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
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
LINE_3400:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
LDA #<VAR_AD
LDY #>VAR_AD
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_59R
LDY #>CONST_59R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AD
LDY #>VAR_AD
; FAC to (X/Y)
JSR FACMEM
;
LINE_3410:
;
LDA #<VAR_AD
LDY #>VAR_AD
JSR REALFAC
LDA #<CONST_58R
LDY #>CONST_58R
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_LP
LDY #>VAR_LP
; FAC to (X/Y)
JSR FACMEM
;
LINE_3420:
;
LDY #8
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_AD
LDY #>VAR_AD
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_HP
LDY #>VAR_HP
; FAC to (X/Y)
JSR FACMEM
;
LINE_3430:
;
JSR LOCKCHANNEL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_LP
LDY #>VAR_LP
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR CHR
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_HP
LDY #>VAR_HP
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR CHR
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR UNLOCKCHANNEL
;
LINE_3440:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_58R
LDY #>CONST_58R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_LZ
LDY #>VAR_LZ
; FAC to (X/Y)
JSR FACMEM
;
LINE_3450:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDY #8
STY A_REG
JSR XREGFAC
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_HZ
LDY #>VAR_HZ
; FAC to (X/Y)
JSR FACMEM
;
LINE_3460:
;
JSR LOCKCHANNEL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_LZ
LDY #>VAR_LZ
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR CHR
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_HZ
LDY #>VAR_HZ
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR CHR
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR UNLOCKCHANNEL
;
LINE_3470:
;
JSR LOCKCHANNEL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_D$[]
LDY #>VAR_D$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA CONST_2
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR UNLOCKCHANNEL
;
LINE_3480:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_9
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_9:
;
LINE_3490:
;
JSR LOCKCHANNEL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA CONST_2
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA CONST_2
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR UNLOCKCHANNEL
;
LINE_3500:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_3510:
;
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_3520:
;
LDA #<CONST_60
LDY #>CONST_60
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDY VAR_ER%
STY TMP_ZP
LDA VAR_ER%+1
STA TMP_ZP+1
JSR INTOUTBRKFAST
; Fast integer print
;
; Optimizer rule: INTOUT + LINEBRK/1
;
LINE_3530:
;
JSR LINEBREAK
;
LINE_3540:
;
JSR END
RTS
;
LINE_3550:
;
;
LINE_3560:
;
;
LINE_3570:
;
;
LINE_3580:
;
LDA VAR_ER$
LDY VAR_ER$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D$
LDY #>VAR_D$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_3590:
;
LDX #4
dcloop4883_1:
LDA VAR_ER,X
STA VAR_D,X
DEX
BPL dcloop4883_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_3600:
;
LDA #<CONST_61
LDY #>CONST_61
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_SN$
LDY VAR_SN$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_62
LDY #>CONST_62
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3610:
;
LDA #<CONST_63
LDY #>CONST_63
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_D$
LDY VAR_D$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3620:
;
LDA VAR_D$
LDY VAR_D$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
LDA #<VAR_D
LDY #>VAR_D
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
NEQ_NEQ31:
NEQ_SKIP31:
COMP_SKP54:
BEQ LINE_SKIP88
LINE_NSKIP88:
; Optimizer rule: Simplified not equal comparison/6
;
LDA #<CONST_64
LDY #>CONST_64
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_D
LDY #>VAR_D
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
;
LINE_SKIP88:
;
;
LINE_3630:
;
LDX #4
dcloop4883_2:
LDA CONST_3R,X
STA VAR_T,X
DEX
BPL dcloop4883_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_65R
LDY #>CONST_65R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_T
LDY #>VAR_T
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
;
LINE_3640:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
;
LINE_3650:
;
LDA #<CONST_1
LDY #>CONST_1
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP55:
BEQ LINE_SKIP89
; Simplified conditional branch
;
LINE_NSKIP89:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_10
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_10:
;
LINE_SKIP89:
;
;
LINE_3660:
;
LDA #<CONST_66
LDY #>CONST_66
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3670:
;
LDA #<CONST_67
LDY #>CONST_67
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3680:
;
JMP RETURN
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
RUN			LDX SP_SAVE
TXS
JMP PROGRAMSTART
;###################################
;###################################
RESTORE		LDA #<DATAS
LDY #>DATAS
STA DATASP
STY DATASP+1
RTS
;###################################
;###################################
MID			LDA #<D_REG
LDY #>D_REG
JSR REALFAC
JSR SGNFAC
ROL
BCC MIDLENGTH		; an actual length was given...
MIDNEGC		JSR STRFUNCINT		; ...no, it wasn't.
LDA TMP_REG			; copy start position from TMP_REG into TMP_REG+1
STA TMP_REG+1
BNE MIDOK2
JMP ILLEGALQUANTITY	; start has to be larger than 0
MIDOK2		DEC TMP_REG+1		; BASIC starts at 1, we start at 0
LDA (TMP_ZP),Y
SEC
SBC TMP_REG+1
STA TMP_REG			; store the calculated length
BCS	MIDNOV2
STY TMP_REG			; Set length to 0, if start>string length
JMP MIDNOV2
MIDLENGTH	JSR FACWORD
MIDCONST	STY TMP2_REG		; save the length in TMP2_REG
JSR STRFUNCINT
LDA TMP_REG			; copy start position from TMP_REG into TMP_REG+1
BNE MIDOK
JMP ILLEGALQUANTITY	; start has to be larger than 0
MIDOK		LDX TMP2_REG
STX TMP_REG			; store the length saved above in TMP_REG
STA TMP_REG+1
DEC TMP_REG+1		; BASIC starts at 1, we start at 0
MIDNOV
MIDNOV2		LDA TMP_REG+1		; the starting position
CLC
ADC TMP_REG			; add the length
BCS MIDCLAMP
CMP (TMP_ZP),Y
BCS	MIDCLAMP
MIDCOPY		JMP STRFUNC
MIDCLAMP	LDA (TMP_ZP),Y		; Clamp to the string's length, if needed...
SEC
SBC TMP_REG+1
STA TMP_REG
BCS MIDCOPY
STY TMP_REG
JMP MIDCOPY
;###################################
;###################################
LEFT		JSR STRFUNCINT
LEFT2		STY TMP_REG+1		; store the start position (always 0 for left$)
LDA (TMP_ZP),Y
CMP TMP_REG			; compare the source string's length with the parameter
BCS LEFTBELOW
STA TMP_REG			; length>source length? -> clamp to source length
LEFTBELOW	JMP STRFUNC
;###################################
;###################################
STRFUNCINT 	LDA B_REG			;the source string
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
LDA #<C_REG
LDY #>C_REG
JSR REALFAC
JSR FACWORD
STY TMP_REG			; store the parameter
LDY #0
RTS
;###################################
;###################################
; Generic function for string functions like for left$, right$ and mid$. It reuses the actual code to
; copy strings for an assignment but it jumps into it at a "copy only" stage. However, it still assumes
; that the source pointer points towards the length of the source string.
; We have to adapt to that behaviours, so we are adjusting and/or saving/restoring some values here.
STRFUNC		LDA TMP_REG+1
BEQ STARTATZERO
LDA TMP_ZP
CLC
ADC TMP_REG+1
STA TMP_ZP
BCC STARTATZERO
INC TMP_ZP+1
STARTATZERO	LDY #0
LDA (TMP_ZP),Y
PHA					; save the first byte of the source string on the stack
LDA TMP_REG
BNE STRFUNCNZ
LDA #<EMPTYSTR
STA A_REG
LDA #>EMPTYSTR
STA A_REG+1
PLA					; if the lenght is 0, it's an indicator that we are outside of the string (or the length is actual 0)
; The latter case doesn't matter but in the former one, we must not restore the stacked value in memory
; because we are then writting somewhere in other memory that's not the string...which is evil!
JMP EXITSTRFUNC
STRFUNCNZ	STA (TMP_ZP),Y
LDA #<A_REG
LDY #>A_REG
STA TMP2_ZP
STY TMP2_ZP+1
LDX TMP_REG			; Put length into X for copy
JSR COPYONLY
PLA
LDY #0
STA (TMP_ZP),Y		; restore the first byte of the source string from the stack
EXITSTRFUNC	RTS
;###################################
;###################################
CONCAT		LDA A_REG
STA TMP_ZP
LDA A_REG+1
STA TMP_ZP+1
LDA STRBUFP		; adjust A_REG so that it points to the new tmp buffer
STA A_REG
STA TMP3_ZP
LDA STRBUFP+1
STA A_REG+1
STA TMP3_ZP+1
LDY #0
LDA (TMP_ZP),Y
TAX
LDA B_REG
STA TMP2_ZP
LDA B_REG+1
STA TMP2_ZP+1
TXA
CLC
ADC (TMP2_ZP),Y
BCC CCSTRFITS
JMP STRINGTOOLONG
CCSTRFITS	STA (TMP3_ZP),Y
INC TMP3_ZP
BNE CCNOOV2
INC TMP3_ZP+1
CCNOOV2		CLC
ADC STRBUFP
PHP
CLC
ADC #3
STA STRBUFP
BCC CCNOCS1
INC STRBUFP+1
CCNOCS1		PLP
BCC CCSTRFITS2
INC STRBUFP+1
CCSTRFITS2	JSR COPY2CONCAT		;...copy into the buffer
LDA B_REG			;set the content to append
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
JMP COPY2CONCAT		;..and copy it
;###################################
;###################################
COPY2CONCAT	LDY #0
LDA (TMP_ZP),Y
BEQ NOC2C			; Nothing to append, skip
STA TMP2_ZP
INC TMP_ZP
BNE COPY2LOOP
INC TMP_ZP+1
COPY2LOOP	LDA (TMP_ZP),Y
STA (TMP3_ZP),Y
INY
CPY TMP2_ZP
BNE COPY2LOOP
TYA
CLC
ADC TMP3_ZP			; Update tmp pointer in concat memory
STA TMP3_ZP
BCC NOC2C
INC TMP3_ZP+1
NOC2C		RTS
;###################################
;###################################
STR			JSR YREGFAC
STRINT		LDY #1
JSR FACSTR
LDY #0
STY TMP_ZP+1
LDA #LOFBUF
STA TMP_ZP
DEY
STRLOOP		INY
LDA LOFBUFH,Y
BNE STRLOOP
STY LOFBUF
TYA
TAX			; Length in X
LDA #<A_REG
LDY #>A_REG
STA TMP2_ZP
STY TMP2_ZP+1
JMP COPYONLY
;###################################
;###################################
VAL			LDA B_REG
STA INDEX1
LDA B_REG+1
STA INDEX1+1
LDY #0
STY VALTYPE
LDA (INDEX1),Y
BNE	DOACVAL
JMP ZEROSET
DOACVAL		TAY
INC INDEX1
BNE VALSTR
INC INDEX1+1
VALSTR		JSR VALS
JMP FACXREG	;RTS is implicit
;###################################
;###################################
TAB			JSR TABSPCINIT
JSR REROUTE
LDA CMD_NUM
BEQ NORMALTAB		; No reroute? Normal TAB
CMP #3
BEQ NORMALTAB2		; To screen? Normal TAB
JMP TABCHANNEL2
NORMALTAB2	JSR CLRCHNEW
NORMALTAB	SEC
JMP TABSPC
;###################################
;###################################
TABSPCINIT	SEC
JSR CRSRPOS
STY $09
JSR YREGFAC
JSR FACWORD
TYA
TAX
RTS
;###################################
;###################################
TABSPC	    BCC DOSPC
TXA
SBC $09
BCC TABSPCQUIT
TAX
DOSPC		INX
TABSPCLOOP  DEX
BNE TABSPCRIGHT
TABSPCQUIT	RTS
TABSPCRIGHT	JSR CRSRRIGHT
JMP TABSPCLOOP
;###################################
;###################################
LEN			LDA B_REG
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y
STA TMP2_ZP		;For use in a later optimization
BEQ ZEROLEN
TAY
LDA #0
JSR INTFAC
JMP FACXREG	;RTS is implicit
ZEROLEN		JMP ZEROSET
;###################################
;###################################
ASCNXREG	LDA B_REG
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y
BNE DOASCNXREG
JMP ILLEGALQUANTITY
DOASCNXREG	INY
LDA (TMP_ZP),Y
STA TMP2_ZP
RTS
;###################################
;###################################
ASC			LDA B_REG
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y
BNE DOASC
JMP ILLEGALQUANTITY
DOASC		INY
LDA (TMP_ZP),Y
STA TMP2_ZP		;For use in a later optimization
TAY
LDA #0
JSR INTFAC
JMP FACXREG
;###################################
;###################################
CHR			JSR YREGFAC
CHRFAC2		JSR FACWORD
TYA
TAX
LDA STRBUFP
STA TMP_ZP
STA A_REG
LDA STRBUFP+1
STA TMP_ZP+1
STA A_REG+1
LDA #1
LDY #0
STA (TMP_ZP),Y
TXA
LDY #1
STA (TMP_ZP),Y
LDA STRBUFP
CLC
ADC #2
STA STRBUFP
BCC NOCHR1
INC STRBUFP+1
NOCHR1		RTS
;###################################
;###################################
CHRINTB		JSR CHRINT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
RTS
;###################################
;###################################
CHRINT		TAX
LDA STRBUFP
STA TMP_ZP
STA A_REG
LDA STRBUFP+1
STA TMP_ZP+1
STA A_REG+1
LDA #1
LDY #0
STA (TMP_ZP),Y
TXA
INY
STA (TMP_ZP),Y
LDA STRBUFP
CLC
ADC #2
STA STRBUFP
BCC NOCHR2
INC STRBUFP+1
NOCHR2		RTS
;###################################
;###################################
SAVEPOINTERS
LDA TMP_ZP			; ...save the pointers
STA STORE1
LDA TMP_ZP+1
STA STORE1+1
LDA TMP2_ZP
STA STORE2
LDA TMP2_ZP+1
STA STORE2+1
LDA TMP3_ZP
STA STORE3
LDA TMP3_ZP+1
STA STORE3+1
RTS
;###################################
;###################################
RESTOREPOINTERS
LDA STORE3+1		; ...restore the pointers
STA TMP3_ZP+1
LDA STORE3
STA TMP3_ZP
LDA STORE2+1
STA TMP2_ZP+1
LDA STORE2
STA TMP2_ZP
LDA STORE1+1
STA TMP_ZP+1
LDA STORE1
STA TMP_ZP
RTS
;###################################
;###################################
; This check is called in places, where the actual source's length is unknown.
; So we compact assuming the maximum string length of 255. It's not ideal this way
; but it's better than what we did before: Read some random length out of whatever
; memory location TMP_ZP/TMP_ZP+1 was pointing to...
COMPACTMAX
LDA #$FF
LDY #$0
JMP COMPACTF
;###################################
;###################################
COMPACT
LDY #0
GCBUFNE		LDA (TMP_ZP),Y		; Get the source's length
COMPACTF	STA TMP4_REG		; ...and store it
LDY STRBUFP+1		; First, check if the new string would fit into memory...
STY TMP4_REG+1		; For that, we have to calculate the new strbufp after adding the string
INY					; add 1 to the high byte to check, if at least 256 bytes are free (fast path)
BEQ ENDMEM			; actually, if this happens, all went wrong anyway...whatever...
CPY ENDSTRBUF+1		; check, if there are at least 256 bytes free. If there are, no detailed check is needed...
BCC RGCEXIT			; there are? We are out then.
ENDMEM		LDA STRBUFP
CLC
ADC TMP4_REG
STA TMP4_REG
BCC	RGCNOOV1
INC TMP4_REG+1
RGCNOOV1	CLC
LDA TMP4_REG
ADC #3
STA TMP4_REG
BCC	RGCNOOV2
INC TMP4_REG+1
RGCNOOV2	LDA TMP4_REG+1		; Now do the actual check
CMP ENDSTRBUF+1
BEQ RGCLOW1
BCS GCEXECOMP		; Doesn't fit, run GC!
JMP RGCEXIT
RGCLOW1		LDA TMP4_REG
CMP ENDSTRBUF
BCS	GCEXECOMP		; This also triggers if it would fit exactly...but anyway...
RGCEXIT		RTS					; It fits? Then exit without GC
GCEXECOMP	LDA STRBUFP
STA STORE4
LDA STRBUFP+1
STA STORE4+1
JSR GCEXE
JMP CHECKMEMORY
;###################################
;###################################
GCEXE		JSR SAVEPOINTERS
LDA #0
STA LASTVAR
STA LASTVAR+1		; reset the last variable pointer to 0
LDA #<STRBUF
STA TMP_ZP
STA GCSTART
LDA #>STRBUF
STA TMP_ZP+1		; Pointer into the string memory, initialized to point at the start...
STA GCSTART+1
GCLOOP		LDY #0
LDA TMP_ZP
STA GCWORK
LDA TMP_ZP+1
STA GCWORK+1		; store the pointer for later use...
LDA (TMP_ZP),Y
STA GCLEN			; store the length
INC TMP_ZP
BNE GCLOOPNOOV
INC TMP_ZP+1
GCLOOPNOOV	LDA TMP_ZP
CLC
ADC GCLEN
STA TMP_ZP
BCC GCLOOPNOOV2
INC TMP_ZP+1		; TMP_ZP now points to the reference to the string variable that used this chunk once
GCLOOPNOOV2 LDY #0
LDA (TMP_ZP),Y
STA TMP2_ZP
INY
LDA (TMP_ZP),Y
STA TMP2_ZP+1		; Store the variable reference in TMP2_ZP
LDA TMP_ZP
CLC
ADC #2
STA TMP_ZP
BCC GCLOOPNOOV3
INC TMP_ZP+1		; adjust the pointer to point to the next entry
GCLOOPNOOV3 LDY #0
LDA (TMP2_ZP),Y
CMP GCWORK
BNE GCKLOOP
INY
LDA (TMP2_ZP),Y
CMP GCWORK+1
BEQ MEMFREE
GCKLOOP		LDA TMP_ZP+1		; Check if we have processed all of the string memory...
CMP HIGHP+1
BEQ GCHECKLOW
BCC GCLOOP
JMP GCDONE
GCHECKLOW	LDA TMP_ZP
CMP HIGHP
BCS GCDONE
JMP GCLOOP
MEMFREE		LDA GCSTART			; found a variable that points to this chunk...
CMP GCWORK			; ...then check if the can be copied down. This is the case if GCSTART!=GCWORK
BNE COPYDOWN
LDA GCSTART+1
CMP GCWORK+1
BNE COPYDOWN
LDA TMP_ZP			; GCSTART==GCWORK...adjust GCSTART and continue
STA GCSTART
LDA TMP_ZP+1
STA GCSTART+1
JMP	GCKLOOP			; continue if needed...
COPYDOWN	LDA GCSTART			; There's a gap in memory, so copy the found variable down to GCSTART and adjust GCSTART accordingly
STA TMP_REG
LDA GCSTART+1
STA TMP_REG+1		; set the target location...
LDA GCWORK
STA TMP2_REG
LDA GCWORK+1
STA TMP2_REG+1		; set the source location...
LDA TMP_ZP
SEC
SBC GCWORK
STA TMP3_REG
LDA TMP_ZP+1
SBC GCWORK+1
STA TMP3_REG+1		; set the length
LDA GCSTART
CLC
ADC TMP3_REG
STA GCSTART
LDA GCSTART+1
ADC TMP3_REG+1
STA GCSTART+1		; update GCSTART to point to the next free chunk
JSR QUICKCOPY		; copy the chunk down to (former, now stored in TMP_REG) GCSTART
LDY #0
LDA TMP_REG
STA (TMP2_ZP),Y
INY
LDA TMP_REG+1
STA (TMP2_ZP),Y		; ...and adjust the pointer to the memory in the variable to that new location
JMP GCKLOOP
GCDONE		LDA GCSTART
STA HIGHP
STA STRBUFP
LDA GCSTART+1
STA HIGHP+1
STA STRBUFP+1		; Update the string pointers to the new, hopefully lower position
GCSKIP		JSR RESTOREPOINTERS
RTS					; Remember: GC has to adjust highp as well!
;###################################
;###################################
CHECKMEMORY
LDA STRBUFP+1		; Check if we are out of memory even after a garbage collection.
CMP STORE4+1		; This is indicated by the string pointer being still equal or higher
BCC STILLFITSCM		; than before the GC. We are not checking against the actual memory limit,
; because the GC stops before reaching it, leaving all unhandled variables
; untouched. That's because we can't free anything more if we've already reached
; the limit. But there's no direct indicator of this, so we use this indirect one.
BEQ CHECKMEMLOWCM
JMP OUTOFMEMORY		; STRBUFP>last value? OOM!
CHECKMEMLOWCM
LDA STRBUFP			; High bytes are equal? Check low bytes
CMP STORE4
BCC	STILLFITSCM
JMP OUTOFMEMORY		; No? OOM
STILLFITSCM RTS
;###################################
;###################################
QUICKCOPY	LDA TMP_REG		; a self modifying copy routine
STA TMEM+1
LDA TMP_REG+1
STA TMEM+2
LDA TMP2_REG
STA SMEM+1
LDA TMP2_REG+1
STA SMEM+2
LDY #$0
LDX TMP3_REG
BNE QCLOOP
LDA TMP3_REG+1
BEQ QCEXIT		; length is null, nothing to copy
QCLOOP
SMEM		LDA $0000,Y
TMEM		STA $0000,Y
INY
BNE YNOOV
INC TMEM+2
INC SMEM+2
YNOOV		DEX
BNE QCLOOP
LDA TMP3_REG+1
BEQ QCEXIT
DEC TMP3_REG+1
JMP QCLOOP
QCEXIT		RTS
;###################################
;###################################
COPYSTRING	STA TMP2_ZP
STY TMP2_ZP+1
CPY TMP_ZP+1
BNE CONTCOPY
LDA TMP2_ZP
CMP TMP_ZP
BNE CONTCOPY
RTS					; A copy from a variable into the same instance is pointless an will be ignored.
CONTCOPY	JSR COMPACT			; Do a GC if needed
LDY #0
STY TMP_FLAG
LDA (TMP_ZP),Y
BNE NOTEMPTYSTR
LDA #<EMPTYSTR		; The source is empty? Then assign the empty string constant instead
STA TMP_ZP
LDA #>EMPTYSTR
STA TMP_ZP+1
JMP ISCONST
NOTEMPTYSTR	TAX					; Store the length of the source in X...this is valid until right to the end, where it's not longer used anyway
LDA (TMP2_ZP),Y
STA TMP3_ZP
INY
LDA (TMP2_ZP),Y
STA TMP3_ZP+1
DEY
LDA TMP_ZP+1		; Check if the source is a constant (upper bound). If so, don't copy it but just point to it
CMP #>CONSTANTS_END
BEQ CHECKLOW1
BCS INVAR
JMP CHECKNEXT
CHECKLOW1	LDA TMP_ZP
CMP #<CONSTANTS_END
BCS INVAR
CHECKNEXT	LDA TMP_ZP+1		; Check if the source is a constant (lower bound). If so, don't copy it but just point to it
CMP #>CONSTANTS
BEQ CHECKLOW3
BCC INVAR
JMP ISCONST
CHECKLOW3	LDA TMP_ZP
CMP #<CONSTANTS
BCC INVAR			; No, it's not a constant. It's something from lower memory...
ISCONST		JSR CHECKLASTVAR	; Reclaim formerly used memory if possible
LDA TMP_ZP
STA (TMP2_ZP),Y		; Yes, it's a constant...
INY
LDA TMP_ZP+1
STA (TMP2_ZP),Y
LDA HIGHP			; Reset the memory pointer to the last assigned one. Everything that came later has to be temp. data
STA STRBUFP
LDA HIGHP+1
STA STRBUFP+1
RTS
INVAR		INY
LDA (TMP2_ZP),Y		; Check if the target is currently pointing into the constant pool. If so, don't update that memory by accident
CMP #>CONSTANTS_END
BEQ CHECKLOW2
BCS INVAR2
JMP PUPDATEPTR
CHECKLOW2	DEY
LDA (TMP2_ZP),Y
CMP #<CONSTANTS_END
BCS INVAR2
JMP PUPDATEPTR
INVAR2		LDY #0			; The target is somewhere in var memory (i.e. not in constant memory)
LDA (TMP3_ZP),Y
STA TMP_REG
TXA
CMP TMP_REG		; Compare the string-to-copy's length (in A) with the variable's current one (in TMP_REG)
BEQ UPDATEHP2	; does the new string fit into the old memory location (i.e. is it the same length)?
; Shorter strings would fit as well, but aren't stored this way or otherwise, the result would
; be some stray memory chunk that none could identify properly when doing a GC
PUPDATEPTR	JSR CHECKLASTVAR
LDY #1			; No? Then new memory has to be used. Update the "highest memory position" in the process
STY TMP_FLAG	; to regain temp. memory used for non-assigned strings like for printing and such...
JMP UPDATEPTR	; ...we set a flag here to handle this case later
UPDATEHP2	LDA HIGHP		; Update the memory pointer to the last assigned position, reclaim some memory this way
STA STRBUFP
LDA HIGHP+1
STA STRBUFP+1
JMP STRFITS
COPYONLY	LDY #0
STY TMP_FLAG
JMP CHECKMEM
ALTCOPY		JMP COPYSTRING2
UPDATEPTR	LDA TMP_ZP+1	; Check if the new string comes after or equals highp, which indicates that it can be
CMP HIGHP+1		; "copied down". This is another routine, because of...reasons...
BEQ CHECKXT1
BCS ALTCOPY
JMP CHECKMEM
CHECKXT1	LDA TMP_ZP
CMP HIGHP
BCS ALTCOPY
CHECKMEM
MEMOK		LDY #0
LDA STRBUFP		; no, then copy it into string memory later...
STA (TMP2_ZP),Y	; ...but update the string memory pointer now
STA TMP3_ZP
LDA STRBUFP+1
INY
STA (TMP2_ZP),Y
STA TMP3_ZP+1
TXA
CLC
ADC STRBUFP
PHP
CLC
ADC #3
STA STRBUFP
BCC NOCS1
INC STRBUFP+1
NOCS1		PLP
BCC STRFITS
INC STRBUFP+1
STRFITS		LDY TMP_FLAG	; Check if the pointer to the highest mem addr is used by an actual string
BEQ NOHPUPDATE	; has to be updated and do that...
LDA HIGHP+1
CMP STRBUFP+1
BCC UPDATEHIGHP
BEQ CHECKNEXTHP
JMP NOHPUPDATE
CHECKNEXTHP	LDA HIGHP
CMP	STRBUFP
BCC UPDATEHIGHP
JMP NOHPUPDATE
UPDATEHIGHP	LDA STRBUFP
STA HIGHP
LDA STRBUFP+1
STA HIGHP+1		; set new pointer
JSR REMEMBERLASTVAR
JSR STOREVARREF
NOHPUPDATE	LDY #0
LDA (TMP_ZP),Y	; Set the new length...
STA (TMP3_ZP),Y
TAY				; Copy length to Y
BEQ	EXITCOPY	; Length 0? nothing to copy then...
LOOP		LDA (TMP_ZP),Y	; Copy the actual string
STA (TMP3_ZP),Y
DEY
BNE LOOP
EXITCOPY	RTS
;###################################
;###################################
; Special copy routine that handles the case that a string is >highp but might interleave with the temp data that has to be copied into it.
; Therefor, this routine copies from lower to higher addresses and not vice versa like the simpler one above.
COPYSTRING2	LDY #0
LDA (TMP_ZP),Y
STA TMP_REG
TAX
LDA HIGHP
STA TMP3_ZP
STA (TMP2_ZP),Y
LDA HIGHP+1
STA TMP3_ZP+1
INY
STA (TMP2_ZP),Y
JSR REMEMBERLASTVAR
; Do a quick test, if a real copy is needed or if the memory addrs are equal anyway?
; This introduces some overhead but according to my tests, its actually faster this way.
LDA TMP_ZP
CMP TMP3_ZP
BNE DOLOOP
LDA TMP_ZP+1
CMP TMP3_ZP+1
BEQ SKIPCP2
DOLOOP		DEY
TXA
STA (TMP3_ZP),Y
INY
ASLOOP		LDA (TMP_ZP),Y
STA (TMP3_ZP),Y
INY
DEX
BNE	ASLOOP
SKIPCP2		LDA HIGHP
CLC
ADC TMP_REG
PHP
CLC
ADC #3
STA HIGHP
STA STRBUFP
BCC SKIPLOWAS1
INC HIGHP+1
SKIPLOWAS1	PLP
BCC SKIPLOWAS2
INC HIGHP+1
SKIPLOWAS2	LDA HIGHP+1
STA STRBUFP+1
JSR STOREVARREF
RTS
;###################################
;###################################
; Checks if this variable is the same one that has been stored last. If so, we can reclaim its memory first.
CHECKLASTVAR
LDA TMP2_ZP
CMP LASTVAR
BNE NOTSAMEVAR
LDA TMP2_ZP+1
CMP LASTVAR+1
BNE NOTSAMEVAR
LDA LASTVARP			; The target is the last string that has been added. We can free it's currently used memory then.
STA HIGHP
STA STRBUFP
LDA LASTVARP+1
STA HIGHP+1
STA STRBUFP+1
NOTSAMEVAR	RTS
;###################################
;###################################
; Stores the last variable reference that has been stored in string memory.
REMEMBERLASTVAR
LDA TMP2_ZP
STA LASTVAR
LDA TMP2_ZP+1
STA LASTVAR+1
LDA TMP3_ZP
STA LASTVARP
LDA TMP3_ZP+1
STA LASTVARP+1	; Remember this variable as the last written one
RTS
;###################################
;###################################
; Appends a reference to the variable at the end of the string in memory for
; easier GC later...
STOREVARREF
TYA
PHA				; Save Y reg
LDA TMP_ZP
PHA
LDA TMP_ZP+1
PHA
LDA HIGHP+1
STA TMP_ZP+1
LDA HIGHP
SEC
SBC #2
STA TMP_ZP
BCS RLVNOOV
DEC TMP_ZP+1
RLVNOOV		LDA TMP2_ZP
LDY #0
STA (TMP_ZP),Y
LDA TMP2_ZP+1
INY
STA (TMP_ZP),Y	; Store the reference to the variable that uses this chunk of memory at the end of the string
PLA
STA TMP_ZP+1
PLA
STA TMP_ZP		; ...restore TMP_ZP
PLA
TAY				; ...restore Y reg
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
INTOUTBRKFAST
JSR REROUTE
JSR INTOUTFASTZ
LDA #$0D
JSR CHROUT
JMP RESETROUTE
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
REALOUT		LDA X_REG
BNE RNOTNULL
JMP PRINTNULL
RNOTNULL	JSR CHECKFORFASTOUT
JMP RESETROUTE
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
LINEBREAK	JSR REROUTE
LDA #$0D
JSR CHROUT
JMP RESETROUTE
;###################################
;###################################
PRINTNULL	JSR REROUTE
LDA #$20
JSR CHROUT
LDA #$30
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
STROUTWL	STA A_REG
STY A_REG+1
STROUT		JSR REROUTE
LDA A_REG
STA INDEX1
LDA A_REG+1
STA INDEX1+1
LDY #0
LDA (INDEX1),Y
TAX
INC INDEX1
BNE PRINTSTR
INC INDEX1+1
PRINTSTR	JSR PRINTSTRS
LDA HIGHP			; Update the memory pointer to the last actually assigned one
STA STRBUFP
LDA HIGHP+1
STA STRBUFP+1
JSR RESETROUTE
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
ARRAYACCESS_STRING
JSR XREGFAC
JSR FACINT
ARRAYACCESS_STRING_INT
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
LDY #0
LDA (TMP_ZP),Y
STA A_REG
INY
LDA (TMP_ZP),Y
STA A_REG+1
RTS
;###################################
;###################################
ARRAYACCESS_REAL_S
STA G_REG
STY G_REG+1
ARRAYACCESS_REAL
JSR XREGFAC
JSR FACINT
ARRAYACCESS_REAL_INT
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
STA TMP3_ZP
LDA TMP_ZP+1
ADC TMP2_ZP+1
STA TMP3_ZP+1
JMP COPY2_XY_XREG
;###################################
;###################################
ARRAYSTORE_STRING
JSR XREGFAC
JSR FACINT
ARRAYSTORE_STRING_INT
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
TAX
LDA TMP_ZP+1
ADC TMP2_ZP+1
TAY
LDA A_REG
STA TMP_ZP
LDA A_REG+1
STA TMP_ZP+1
TXA
JMP COPYSTRING	; RTS is implicit
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
QUEUESIZE	LDY INPUTQUEUEP
LDA #0
JSR INTFAC
JMP FACXREG
;###################################
;###################################
CLEARQUEUE	LDA #$0
STA INPUTQUEUEP
RTS
;###################################
;###################################
CLEANINPUT	LDY #0				; Processes an input string similar to BASIC's with the only difference that a " at the "wrong" location will be ignored instead of triggering an error
LDX #0
STY STORE1			; Marks "quote-mode", 0 if off, 1 is on
STY STORE2			; Char found, 0 means none, something else means at least one
DEY
CILOOP		INY
LDA $0200,Y
BNE CINOEND
JMP CIEND			; String terminator found, exit
CINOEND		STA STORE3			; store current char
LDA STORE1
BEQ CINOQUOTE		; Not in quote mode...
LDA STORE3
CMP	#$22			; found a quote (in quote mode)?
BNE	CISTILLQUOTE	; no? Then we are still in quote mode
LDA #0				; yes? quote mode off
STA STORE1
JMP CILOOP
CISTILLQUOTE
STA $0200,X
INX
JMP CILOOP
CINOQUOTE	LDA STORE3
CMP	#$22
BNE	CISOMECHAR		; no quote?
CIFIRSTCHAR	LDA #1				; quote?
STA STORE1			; enable quote mode
STA STORE2			; set char flag
JMP CILOOP
CISOMECHAR 	CMP #$3A			; a : then stop evaluating here
BNE	CINOCOLON
JMP CIEND
CINOCOLON	CMP #$2C			; a ,?
BNE CINOCOMMA
LDA #$22			; replace a comma by a ". This will be handled later in the actual input routine
STA $0200,X
INX
LDA #0
STA STORE2			; Reset char flag to 0
JMP CILOOP
CINOCOMMA	CMP #$20			; a blank? Only add this, if char flag is !=0
BNE	CINOSPACE
LDA STORE2			; check char flag
BEQ CINEXT			; Set? Then continue normally
LDA STORE3
CINOSPACE	STA $0200,X
STA STORE2			; update char flag with some value!=0
INX
CINEXT		JMP CILOOP
CIEND		LDA #0
STA $0200,X			; Write terminator...
RTS					; ...and exit
;###################################
;###################################
QMARKOUT1	LDA #1
STA TMP_ZP
JMP QMARKOUT
;###################################
;###################################
QMARKOUT	LDA IOCHANNEL				; only print the ? if it's keyboard/direct input. IOCHANNEL holds the active io device
BNE NOQMARK
JSR REROUTE
LDA #63
LDY TMP_ZP
CPY #2				; print either one or two question marks
BNE ONEQMARK
JSR CHROUT
ONEQMARK	JSR CHROUT
LDA #32
JSR CHROUT
JMP RESETROUTE
NOQMARK		RTS
;###################################
;###################################
INPUTSTR	LDA #$0
INPUTSTR2	STA TMP_REG+1
LDA #$0
STX INPUTLENGTH
STA TMP_REG
STA TMP_FLAG
LDX INPUTQUEUEP
BEQ INPUTNORM
LDA #LOFBUF
LDX #$1
CLC
ADC INPUTQUEUE
STA TMP_ZP
BCC INNONO
LDX #$2
INNONO		STX TMP_ZP+1
DEC	INPUTQUEUEP		; Decrement the queue size
LDY INPUTQUEUE		; Store current offset in Y
STY TMP_REG			; Store the value to subtract it later on
DEY
LDX #$0
SHRINKQ		LDA INPUTQUEUEP
BEQ QUEUEEMPTY
INX
LDA INPUTQUEUE,X	; Copy the queue's content down one entry
DEX
STA INPUTQUEUE,X
INX
CPX INPUTQUEUEP
BNE SHRINKQ
QUEUEEMPTY	JMP ISTRLOOP
INPUTNORM	AND #$FF
JSR INPUT
JSR CLEANINPUT
LDA #LOFBUF
STA TMP_ZP
LDA #$1
STA TMP_ZP+1
LDY #0
DEY
ISTRLOOP	INY
LDA INPUTBUF,Y
TAX
CMP #$22			; found "?  (" is a replacement for , at this stage because " can't occur in an input string while , can)
BNE	ICHECK
STA TMP_FLAG
LDA #$0
STA INPUTBUF,Y			; replace , by the string terminator
LDX INPUTQUEUEP		; load the queue size
BNE	INQUEUENE		; If empty, set at least to one
STA INPUTQUEUE		; ...and set the first index to 0
INX
INQUEUENE	INY
TYA
STA INPUTQUEUE,X	; store the offset in the queue
INX
STX INPUTQUEUEP		; update the queue size
JMP ISTRLOOP		; Back to loop...
ICHECK		TXA					; String terminator?
BNE ISTRLOOP		; No, loop...
LDA TMP_FLAG
BEQ	ISIMPLECOPY
JMP	INPUTSTR
ISIMPLECOPY	TYA
SEC
SBC TMP_REG
LDY #0
STA (TMP_ZP),Y
TAX				; Length in X
STX INPUTLENGTH
LDA TMP_REG+1	; Check for numeric mode
BEQ	INISSTR
RTS
INISSTR		LDA #<A_REG
LDY #>A_REG
STA TMP2_ZP
STY TMP2_ZP+1
JSR COPYONLY
RTS
;###################################
;###################################
GETADOLLAR	JSR GETSTR		; Saves memory in the common GET A$ case...
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A$
LDY #>VAR_A$
JMP COPYSTRING
;###################################
;###################################
GETSTR		LDA #8
LDY #0
JSR COMPACTF
LDY #0
STY CMD_NUM		; Reset CMD target
JSR GETIN
CMP #0			; Without this compare, it works for disk and keyboard GETs...but not for those from the RS232 port...DOH!
BNE SOMEKEY
NOKEY		LDA #<EMPTYSTR
STA A_REG
LDA #>EMPTYSTR
STA A_REG+1
RTS
SOMEKEY		TAX
LDA STRBUFP
STA TMP_ZP
STA A_REG
LDA STRBUFP+1
STA TMP_ZP+1
STA A_REG+1
LDA #1
LDY #0
STA (TMP_ZP),Y
TXA
LDY #1
STA (TMP_ZP),Y
LDA STRBUFP
CLC
ADC #2
STA STRBUFP
BCC GETSTR1
INC STRBUFP+1
GETSTR1		RTS
;###################################
;###################################
ZEROSET		LDA #0
STA X_REG
STA X_REG+1
STA X_REG+2
STA X_REG+3
STA X_REG+4
RTS
;###################################
;###################################
SLT			LDA A_REG
LDX B_REG
STX A_REG
STA B_REG
LDA A_REG+1
LDX B_REG+1
STX A_REG+1
STA B_REG+1
JMP SGT
;###################################
;###################################
SGT			JSR CMPSTRGT
LDA TMP3_ZP
BNE NOTSGT
LDA #<REAL_CONST_MINUS_ONE
STA TMP3_ZP
LDA #>REAL_CONST_MINUS_ONE
STA TMP3_ZP+1
JMP COPY2_XY_XREG
NOTSGT		JMP ZEROSET
;###################################
;###################################
CMPSTRGT	LDY #0				;Returns 0 if A>B, something else otherwise
LDX #1
LDA A_REG
STA TMP_ZP
LDA A_REG+1
STA TMP_ZP+1
LDA B_REG
STA TMP2_ZP
LDA B_REG+1
STA TMP2_ZP+1
CMP TMP_ZP+1
BNE CMPSTRSK2
LDA TMP2_ZP
CMP TMP_ZP
BNE CMPSTRSK2
JMP STRSGTRES
CMPSTRSK2	LDA (TMP2_ZP),Y
STA TMP3_ZP+1
LDA (TMP_ZP),Y
STA TMP3_ZP
CMP TMP3_ZP+1
BCC DONTSWAP
LDA TMP3_ZP+1
DONTSWAP	TAX
BNE NOTZSTR
LDX #1
LDA TMP3_ZP+1
CMP TMP3_ZP
;BEQ STRSGTRES
BCS STRSGTRES
LDX #0
JMP STRSGTRES
NOTZSTR		INC TMP_ZP
BNE SCGTSKP1
INC TMP_ZP+1
SCGTSKP1	INC TMP2_ZP
BNE CMPSGTLOOP
INC TMP2_ZP+1
CMPSGTLOOP	LDA (TMP_ZP),Y
CMP (TMP2_ZP),Y
BCC STRSGTRES
BEQ SGTEQCONT
LDX #0
JMP STRSGTRES
SGTEQCONT	INY
DEX
BNE CMPSGTLOOP
LDA TMP3_ZP+1					; All equal so far...decide based on the length then
CMP TMP3_ZP
BCC STRSGTRES
LDX #1
STRSGTRES	STX TMP3_ZP
RTS
;###################################
;###################################
SEQ			JSR CMPSTR
LDA TMP3_ZP
BNE NOTSEQ
LDA #<REAL_CONST_MINUS_ONE
STA TMP3_ZP
LDA #>REAL_CONST_MINUS_ONE
STA TMP3_ZP+1
JMP COPY2_XY_XREG
NOTSEQ		JMP ZEROSET
;###################################
;###################################
SNEQ		JSR CMPSTR
LDA TMP3_ZP
BEQ NOTSEQ
LDA #<REAL_CONST_MINUS_ONE
STA TMP3_ZP
LDA #>REAL_CONST_MINUS_ONE
STA TMP3_ZP+1
JMP COPY2_XY_XREG
;###################################
;###################################
CMPSTR		LDY #0			;Returns 0 if strings are equal, something else otherwise
LDX #1
LDA A_REG
STA TMP_ZP
LDA A_REG+1
STA TMP_ZP+1
LDA B_REG
STA TMP2_ZP
LDA B_REG+1
STA TMP2_ZP+1
CMP TMP_ZP+1
BNE CMPSTRSK1
LDA TMP2_ZP
CMP TMP_ZP
BNE CMPSTRSK1
LDX #0
JMP STRCMPRES
CMPSTRSK1	LDA (TMP_ZP),Y
CMP (TMP2_ZP),Y
BNE STRCMPRES
TAX
BNE NOTZCTR
LDX #0
JMP STRCMPRES
NOTZCTR		INC TMP_ZP
BNE SCSKP1
INC TMP_ZP+1
SCSKP1		INC TMP2_ZP
BNE CMPSTRLOOP
INC TMP2_ZP+1
CMPSTRLOOP	LDA (TMP_ZP),Y
CMP (TMP2_ZP),Y
BNE STRCMPRES
INY
DEX
BNE CMPSTRLOOP
STRCMPRES	STX TMP3_ZP
RTS
;###################################
;###################################
PUSHINT		LDX FPSTACKP
STX TMP2_ZP
LDX FPSTACKP+1
STX TMP2_ZP+1
LDA TMP_ZP
LDY #0
STA (TMP2_ZP),Y
LDA TMP_ZP+1
INY
STA (TMP2_ZP),Y
LDA TMP2_ZP
CLC
ADC #2
STA FPSTACKP
LDA TMP2_ZP+1
ADC #0
STA FPSTACKP+1
RTS
;###################################
;###################################
POPINT2B	LDA FPSTACKP
SEC
SBC #2
STA FPSTACKP
LDA FPSTACKP+1
SBC #0
STA FPSTACKP+1
LDX FPSTACKP
STX TMP2_ZP
LDX FPSTACKP+1
STX TMP2_ZP+1
LDY #0
LDA (TMP2_ZP),Y
STA B_REG
INY
LDA (TMP2_ZP),Y
STA B_REG+1
RTS
;##################################
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
REALFACPUSHMC
LDX FPSTACKP
LDY FPSTACKP+1
STX TMP2_ZP
STY TMP2_ZP+1
LDY #0
LDA MOSTCOMMON
STA (TMP2_ZP),Y
INY
LDA MOSTCOMMON+1
STA (TMP2_ZP),Y
INY
LDA MOSTCOMMON+2
STA (TMP2_ZP),Y
INY
LDA MOSTCOMMON+3
STA (TMP2_ZP),Y
INY
LDA MOSTCOMMON+4
STA (TMP2_ZP),Y
TXA				;LDA FPSTACKP
CLC
ADC #5
STA FPSTACKP
BCC NOPVRFPXXMC
INC FPSTACKP+1
NOPVRFPXXMC
RTS
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
INCTMPZP	LDA TMP_ZP
CLC
ADC TMP3_ZP
STA TMP_ZP
BCC NOPV2
INC TMP_ZP+1
NOPV2		RTS
;###################################
;###################################
COPY2_XYA	STA TMP3_ZP
COPY2_XY	STX TMP_ZP
STY TMP_ZP+1
COPY3_XY	LDY #0
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
RTS
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
COPY2_XYA_XREGFAC
STA TMP3_ZP
STY TMP3_ZP+1
COPY2_XY_XREGFAC
LDX #<X_REG		; the pointer to X_REG has to be in X, because the "value already in X"-optimization might expect it to be there! YIKES!
LDY #0
LDA (TMP3_ZP),Y
STA X_REG
STA FACEXP
STY FACOV
INY
LDA (TMP3_ZP),Y
STA X_REG+1
STA FACSGN
ORA #$80
STA FACHO
INY
LDA (TMP3_ZP),Y
STA X_REG+2
STA FACMOH
INY
LDA (TMP3_ZP),Y
STA X_REG+3
STA FACMO
INY
LDA (TMP3_ZP),Y
STA X_REG+4
STA FACLO
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
COPY2_XYA_CREG
STA TMP3_ZP
STY TMP3_ZP+1
COPY2_XY_CREG
LDX #<C_REG		; the pointer to C_REG has to be in X, because the "value already in X"-optimization might expect it to be there! YIKES!
LDY #0
LDA (TMP3_ZP),Y
STA C_REG
INY
LDA (TMP3_ZP),Y
STA C_REG+1
INY
LDA (TMP3_ZP),Y
STA C_REG+2
INY
LDA (TMP3_ZP),Y
STA C_REG+3
INY
LDA (TMP3_ZP),Y
STA C_REG+4
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
LOCKCHANNEL
PHA
LDA #$FF
STA CHLOCKFLAG
PLA
RTS
;##################################
;##################################
UNLOCKCHANNEL
PHA
LDA #0
STA CHLOCKFLAG
PLA
JMP CLRCH
;###################################
;###################################
INITOUTCHANNEL
LDA CHLOCKFLAG
BEQ INITOUT2
CMP #$FF
BNE SKIPINITCH
INITOUT2
LDA #<C_REG
LDY #>C_REG
JSR REALFAC
JSR FACWORD
TYA
TAX
CPX CMD_NUM
BNE CMDNEQUAL
LDY #0
STY CMD_NUM			; Reset CMD channel
CMDNEQUAL	STA CHANNEL
STA CHLOCKFLAG
JMP CHKOUT
SKIPINITCH
RTS
;###################################
;###################################
INITINCHANNEL
LDA IOCHANNEL
STA STORE1+1
LDA #1
STA IOCHANNEL		; Something that's not the screen...that's enough for the check the CRSRRIGHT does...
LDA #<C_REG
LDY #>C_REG
JSR REALFAC
JSR FACWORD
TYA
TAX
STA CHANNEL
STA CHLOCKFLAG
JMP CHKIN
RTS
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
GETSTRCHANNEL
JSR INITINCHANNEL
JSR GETSTR
JMP CLRINCH
;###################################
;###################################
INPUTLENGTHCHECK	LDA INPUTLENGTH
RTS
;###################################
;###################################
INPUTSTRCHANNEL
JSR INITINCHANNEL
JSR INPUTSTR
JMP CLRINCH
;###################################
;###################################
STROUTCHANNEL
JSR INITOUTCHANNEL
JSR STROUT
JMP CLRCHNEW
;###################################
;###################################
TABCHANNEL
JSR INITOUTCHANNEL
TABCHANNELINT
LDA CHANNEL
CMP #3		; To the screen?
BEQ TABSCREEN
TABCHANNEL2	LDA IOCHANNEL
STA STORE1
LDA #1
STA IOCHANNEL		; Something that's not the screen...that's enough for the check the CRSRRIGHT does...
JSR YREGFAC
JSR FACWORD
TYA
TAX
JMP EXITCHANNEL
TABSCREEN
JSR CLRCHNEW
JMP TAB
;###################################
;###################################
EXITCHANNEL	CLC
JSR TABSPC
JSR CLRCHNEW
LDA STORE1
STA IOCHANNEL
RTS
;###################################
;###################################
CLRINCH		JSR CLRCH
LDA STORE1+1
STA IOCHANNEL
RTS
;###################################
;###################################
OPEN		JSR SETEMPTYSTR	; Prepare with an empty string
JSR YREGFAC
JSR FACWORD
STY TMP_REG		; store parameter count in TMP_REG
JSR XREGFAC
JSR FACWORD
STY LOGICADDR	; store logical address
DEC TMP_REG
BEQ ALLPARAMS
LDA #<C_REG
LDY #>C_REG
JSR REALFAC
JSR FACWORD
STY DEVICENUM	; store device number
DEC TMP_REG
BEQ ALLPARAMS
LDA #<D_REG
LDY #>D_REG
JSR REALFAC
JSR FACWORD
STY SECADDR		; store secondary address
DEC TMP_REG
BEQ ALLPARAMS
JSR SETNAMEPRT
ALLPARAMS
<IF BOOST>
JSR BOOSTOFF
</IF>
JSR OPENCH
BCS OPENERR
RTS
OPENERR		STA TMP2_ZP
LDA LOGICADDR
JSR CLOSECH
<IF BOOST>
JSR BOOSTON
</IF>
LDX TMP2_ZP
JMP ERRALL
;###################################
;###################################
SETEMPTYSTR
LDA #<EMPTYSTR
STA FILEADDR
LDA #>EMPTYSTR
STA FILEADDR+1
LDA #0
STA FILELEN
STA LOGICADDR
STA DEVICENUM
STA SECADDR
RTS
;###################################
;###################################
SETNAMEPRT	LDA G_REG
LDY G_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y	; get string parameter length
STA FILELEN
INC G_REG
BNE SNPNOOV
INC G_REG+1
SNPNOOV		LDA G_REG
LDY G_REG+1
STA FILEADDR		; low byte of string parameter
STY FILEADDR+1	; high byte of string parameter
RTS
;###################################
;###################################
CLOSE		JSR XREGFAC
JSR FACWORD
TYA				; file number into A
JSR CLOSECH
<IF BOOST>
JSR BOOSTON
</IF>
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
OUTOFMEMORY
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
LDX #$10
JMP ERRALL
;###################################
;###################################
STRINGTOOLONG
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
LDX #$17
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
EXTRAIGNORED
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
JMP ERREI
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
STA VAR_D,Y
STA VAR_AD,Y
STA VAR_YY,Y
STA VAR_SS,Y
STA VAR_JA,Y
STA VAR_JN,Y
STA VAR_I,Y
STA VAR_ER,Y
STA VAR_SA,Y
STA VAR_SZ,Y
STA VAR_SW,Y
STA VAR_DD,Y
STA VAR_F1,Y
STA VAR_F2,Y
STA VAR_F3,Y
STA VAR_M,Y
STA VAR_X,Y
STA VAR_MM,Y
STA VAR_NN,Y
STA VAR_AS,Y
STA VAR_FO,Y
STA VAR_LB,Y
STA VAR_HB,Y
STA VAR_LP,Y
STA VAR_HP,Y
STA VAR_LZ,Y
STA VAR_HZ,Y
STA VAR_T,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_U[]
LDY #>VAR_U[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_D[]
LDY #>VAR_D[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_ER%
STA VAR_ER%+1
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #64


; CONST: $
CONST_1	.BYTE 0
.STRG ""
; CONST: #0
CONST_2R
CONST_2	.REAL 0
; CONST: #1

MOSTCOMMON
CONST_3R	.REAL 1.0
; CONST: $,
CONST_4	.BYTE 1
.STRG ","
; CONST: #2

CONST_5R	.REAL 2.0
; CONST: #8


; CONST: $Undef'd Statement Error
CONST_7	.BYTE 23
.STRG "Undef'd Statement Error"
; CONST: #63999

CONST_8	.REAL 63999
; CONST: ${clear}{down}{space*6}Recompactor{space*4}by GD-Soft {ct h}{ct n}
CONST_9	.BYTE 65
.STRG "{clear}{down}{space*6}Recompactor{space*4}by GD-Soft {ct h}{ct n}"
; CONST: ${down*2} Source-Filename{space*6}:
CONST_10	.BYTE 35
.STRG "{down*2} Source-Filename{space*6}: "
; CONST: ${down} Destination-Filename :
CONST_11	.BYTE 30
.STRG "{down} Destination-Filename : "
; CONST: ${down} Schleifen formatieren (j/n) :
CONST_12	.BYTE 37
.STRG "{down} Schleifen formatieren (j/n) : "
; CONST: $n
CONST_13	.BYTE 1
.STRG "n"
; CONST: $y
CONST_14	.BYTE 1
.STRG "y"
; CONST: $j
CONST_15	.BYTE 1
.STRG "j"
; CONST: ${down} Startadresse{space*2}: 2049{left*4}
CONST_16	.BYTE 42
.STRG "{down} Startadresse{space*2}: 2049{left*4}"
; CONST: ${down} Startzeilennr.: 1000{left*4}
CONST_17	.BYTE 35
.STRG "{down} Startzeilennr.: 1000{left*4}"
; CONST: ${down} Schrittweite{space*2}: 10{left*2}
CONST_18	.BYTE 40
.STRG "{down} Schrittweite{space*2}: 10{left*2}"
; CONST: ${down*2}{space*3}Sourcefile{space*6}:
CONST_19	.BYTE 38
.STRG "{down*2}{space*3}Sourcefile{space*6}: "
; CONST: ${down}{space*3}Destinationfile :
CONST_20	.BYTE 33
.STRG "{down}{space*3}Destinationfile : "
; CONST: ${home}{down*10}
CONST_21	.BYTE 15
.STRG "{home}{down*10}"
; CONST: #3

CONST_22R	.REAL 3.0
; CONST: $Pass 1 :
CONST_23	.BYTE 8
.STRG "Pass 1 :"
; CONST: #8.0

CONST_24	.REAL 8.0
; CONST: #15

CONST_25R	.REAL 15.0
; CONST: #4

CONST_26R	.REAL 4.0
; CONST: #11

CONST_27R	.REAL 11.0
; CONST: #23

CONST_28R	.REAL 23.0
; CONST: $Pass 2 :
CONST_29	.BYTE 8
.STRG "Pass 2 :"
; CONST: #31

CONST_30R	.REAL 31.0
; CONST: $:
CONST_31	.BYTE 1
.STRG ":"
; CONST: #139

CONST_32R	.REAL 139.0
; CONST: #143

CONST_33R	.REAL 143.0
; CONST: #34

CONST_34R	.REAL 34.0
; CONST: $Line Increment too large !
CONST_35	.BYTE 26
.STRG "Line Increment too large !"
; CONST: ${home}{down*13}
CONST_36	.BYTE 15
.STRG "{home}{down*13}"
; CONST: $Pass 3 :
CONST_37	.BYTE 8
.STRG "Pass 3 :"
; CONST: #0.0


; CONST: #141

CONST_39R	.REAL 141.0
; CONST: #137

CONST_40R	.REAL 137.0
; CONST: #167

CONST_41R	.REAL 167.0
; CONST: #145

CONST_42R	.REAL 145.0
; CONST: #203

CONST_43R	.REAL 203.0
; CONST: $
CONST_44	.BYTE 1
.STRG " "
; CONST: $9
CONST_45	.BYTE 1
.STRG "9"
; CONST: $0
CONST_46	.BYTE 1
.STRG "0"
; CONST: #-1

CONST_47	.REAL -1
; CONST: $ON without GOTO Error
CONST_48	.BYTE 21
.STRG "ON without GOTO Error"
; CONST: #164

CONST_49R	.REAL 164.0
; CONST: $GO without TO Error
CONST_50	.BYTE 19
.STRG "GO without TO Error"
; CONST: $Pass 4 :
CONST_51	.BYTE 8
.STRG "Pass 4 :"
; CONST: $:{space*20}
CONST_52	.BYTE 11
.STRG ":{space*20}"
; CONST: #129

CONST_53R	.REAL 129.0
; CONST: #130

CONST_54R	.REAL 130.0
; CONST: ${home}{down*17}
CONST_55	.BYTE 15
.STRG "{home}{down*17}"
; CONST: #16

CONST_56R	.REAL 16.0
; CONST: ${reverse on} saving
CONST_57	.BYTE 20
.STRG "{reverse on} saving "
; CONST: #255

CONST_58R	.REAL 255.0
; CONST: #5

CONST_59R	.REAL 5.0
; CONST: ${home}{down*20}{space*2}Errors :
CONST_60	.BYTE 32
.STRG "{home}{down*20}{space*2}Errors :"
; CONST: ${home}{down*21}{right}error for
CONST_61	.BYTE 32
.STRG "{home}{down*21}{right}error for "
; CONST: $ :
CONST_62	.BYTE 2
.STRG " :"
; CONST: ${down}{sh space}
CONST_63	.BYTE 16
.STRG "{down}{sh space}"
; CONST: ${right}in
CONST_64	.BYTE 9
.STRG "{right}in"
; CONST: #5000

CONST_65R	.REAL 5000.0
; CONST: ${home}{down*21}{space*39}
CONST_66	.BYTE 25
.STRG "{home}{down*21}{space*39}"
; CONST: ${down}{space*39}
CONST_67	.BYTE 16
.STRG "{down}{space*39}"
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: D
VAR_D	.REAL 0.0
; VAR: AD
VAR_AD	.REAL 0.0
; VAR: YY
VAR_YY	.REAL 0.0
; VAR: SS
VAR_SS	.REAL 0.0
; VAR: S[]
.BYTE 1
.WORD 2505
VAR_S[]	.ARRAY 2505
; VAR: JA
VAR_JA	.REAL 0.0
; VAR: U[]
.BYTE 1
.WORD 2505
VAR_U[]	.ARRAY 2505
; VAR: JN
VAR_JN	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: D[]
.BYTE 1
.WORD 5005
VAR_D[]	.ARRAY 5005
; VAR: ER
VAR_ER	.REAL 0.0
; VAR: SA
VAR_SA	.REAL 0.0
; VAR: SZ
VAR_SZ	.REAL 0.0
; VAR: SW
VAR_SW	.REAL 0.0
; VAR: DD
VAR_DD	.REAL 0.0
; VAR: F1
VAR_F1	.REAL 0.0
; VAR: F2
VAR_F2	.REAL 0.0
; VAR: F3
VAR_F3	.REAL 0.0
; VAR: M
VAR_M	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: MM
VAR_MM	.REAL 0.0
; VAR: NN
VAR_NN	.REAL 0.0
; VAR: AS
VAR_AS	.REAL 0.0
; VAR: FO
VAR_FO	.REAL 0.0
; VAR: LB
VAR_LB	.REAL 0.0
; VAR: HB
VAR_HB	.REAL 0.0
; VAR: LP
VAR_LP	.REAL 0.0
; VAR: HP
VAR_HP	.REAL 0.0
; VAR: LZ
VAR_LZ	.REAL 0.0
; VAR: HZ
VAR_HZ	.REAL 0.0
; VAR: ER%
VAR_ER%	.WORD 0
; VAR: T
VAR_T	.REAL 0.0
STRINGVARS_START
; VAR: A$
VAR_A$	.WORD EMPTYSTR
; VAR: X1$
VAR_X1$	.WORD EMPTYSTR
; VAR: X2$
VAR_X2$	.WORD EMPTYSTR
; VAR: X3$
VAR_X3$	.WORD EMPTYSTR
; VAR: X4$
VAR_X4$	.WORD EMPTYSTR
; VAR: D$
VAR_D$	.WORD EMPTYSTR
; VAR: L$
VAR_L$	.WORD EMPTYSTR
; VAR: H$
VAR_H$	.WORD EMPTYSTR
; VAR: DA$
VAR_DA$	.WORD EMPTYSTR
; VAR: X$
VAR_X$	.WORD EMPTYSTR
; VAR: ER$
VAR_ER$	.WORD EMPTYSTR
; VAR: SN$
VAR_SN$	.WORD EMPTYSTR
; VAR: DN$
VAR_DN$	.WORD EMPTYSTR
; VAR: FO$
VAR_FO$	.WORD EMPTYSTR
; VAR: ZE$
VAR_ZE$	.WORD EMPTYSTR
; VAR: JA$
VAR_JA$	.WORD EMPTYSTR
; VAR: NN$
VAR_NN$	.WORD EMPTYSTR
; VAR: LI$
VAR_LI$	.WORD EMPTYSTR
; VAR: RE$
VAR_RE$	.WORD EMPTYSTR
; VAR: TI$
VAR_TI$ .WORD EMPTYSTR
STRINGVARS_END
STRINGARRAYS_START
; VAR: S$[]
.BYTE 2
.WORD 1002
VAR_S$[]
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR
; VAR: D$[]
.BYTE 2
.WORD 2002
VAR_D$[]
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR
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
