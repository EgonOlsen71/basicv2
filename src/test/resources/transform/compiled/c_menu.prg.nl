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
LDA #0
STA VAR_B
STA VAR_B+1
STA VAR_B+2
STA VAR_B+3
STA VAR_B+4
; Optimizer rule: Simplified setting to 0/6
LDX #4
dcloop235_1:
LDA CONST_1R,X
STA VAR_MA,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1:
;
;
LINE_2:
;
;
LINE_3:
;
;
LINE_4:
;
;
LINE_5:
;
;
LINE_6:
;
;
LINE_10:
;
LDA #147
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_12:
;
;
LINE_20:
;
LDY #3
STY 646
; Optimizer rule: Simple POKE/2
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
;
LINE_30:
LDX #4
dcloop401_1:
LDA CONST_4R,X
STA VAR_P,X
LDA CONST_4R,X
STA VAR_MI,X
DEX
BPL dcloop401_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_100:
;
LDY #15
STY 782
; Optimizer rule: Simple POKE/2
;
LINE_110:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 781
;
LINE_120:
;
LDY #0
STY 783
; Optimizer rule: Simple POKE/2
;
LINE_130:
;
LDA #<65520
STA TMP_ZP
LDA #>65520
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_200:
;
;
LINE_205:
;
LDA #<CONST_7
LDY #>CONST_7
STA A_REG
STY A_REG+1
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_210:
;
LDA #<CONST_9
LDY #>CONST_9
STA A_REG
STY A_REG+1
LDA #<CONST_8R
LDY #>CONST_8R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_215:
;
LDA #<CONST_10
LDY #>CONST_10
STA A_REG
STY A_REG+1
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_220:
;
LDA #<CONST_12
LDY #>CONST_12
STA A_REG
STY A_REG+1
LDA #<CONST_11R
LDY #>CONST_11R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_225:
;
LDA #<CONST_14
LDY #>CONST_14
STA A_REG
STY A_REG+1
LDA #<CONST_13R
LDY #>CONST_13R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_230:
;
LDA #<CONST_16
LDY #>CONST_16
STA A_REG
STY A_REG+1
LDA #<CONST_15R
LDY #>CONST_15R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_235:
;
LDA #<CONST_18
LDY #>CONST_18
STA A_REG
STY A_REG+1
LDA #<CONST_17R
LDY #>CONST_17R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_240:
;
LDA #<CONST_20
LDY #>CONST_20
STA A_REG
STY A_REG+1
LDA #<CONST_19R
LDY #>CONST_19R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_245:
;
LDA #<CONST_22
LDY #>CONST_22
STA A_REG
STY A_REG+1
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_250:
;
LDA #<CONST_24
LDY #>CONST_24
STA A_REG
STY A_REG+1
LDA #<CONST_23R
LDY #>CONST_23R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_255:
;
LDA #<CONST_26
LDY #>CONST_26
STA A_REG
STY A_REG+1
LDA #<CONST_25R
LDY #>CONST_25R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_262:
;
LDX #4
dcloop899_1:
LDA CONST_27,X
STA VAR_I,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
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
;
LINE_264:
;
LDA #<CONST_28
LDY #>CONST_28
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP0:
BEQ LINE_SKIP10
; Simplified conditional branch
;
LINE_NSKIP10:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MA
LDY #>VAR_MA
; FAC to (X/Y)
JSR FACMEM
JMP LINE_270
;
LINE_SKIP10:
;
;
LINE_265:
;
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
LINE_270:
;
JSR GOSUB
JSR LINE_6000
;
LINE_275:
;
JSR GOSUB
JSR LINE_8000
;
LINE_280:
;
JSR GOSUB
JSR LINE_7000
LDX #4
dcloop1231_1:
LDA CONST_4R,X
STA VAR_P,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_290:
;
LDY #11
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_300:
;
LDX #4
dcloop1231_2:
LDA CONST_27,X
STA VAR_I,X
DEX
BPL dcloop1231_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
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
LINE_310:
;
LDA #<CONST_29
LDY #>CONST_29
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
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_320:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
LDY #5
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_400:
;
LDA #<CONST_30
LDY #>CONST_30
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_C$
LDY #>VAR_C$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA #<CONST_31
LDY #>CONST_31
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D$
LDY #>VAR_D$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_J$
STY VAR_J$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_410:
;
LDY #16
STY 782
; Optimizer rule: Simple POKE/2
;
LINE_420:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 781
;
LINE_430:
;
LDY #0
STY 783
; Optimizer rule: Simple POKE/2
;
LINE_440:
;
LDA #<65520
STA TMP_ZP
LDA #>65520
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_450:
;
LDY #5
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_460:
;
JSR COMPACTMAX
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_C$
LDY VAR_C$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_D$
LDY VAR_D$+1
STA B_REG
STY B_REG+1
JSR CONCAT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_500:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_B$
LDY #>VAR_B$
JSR COPYSTRING
LDA #<CONST_28
LDY #>CONST_28
STA B_REG
STY B_REG+1
LDA VAR_B$
LDY VAR_B$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP3:
BEQ LINE_SKIP11
; Simplified conditional branch
;
LINE_NSKIP11:
;
JMP LINE_500
;
LINE_SKIP11:
;
;
LINE_510:
;
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ0
ROL
BCC LT_LT0
LT_LT_EQ0:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP0
LT_LT0:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP0:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_33
LDY #>CONST_33
STA B_REG
STY B_REG+1
LDA VAR_B$
LDY VAR_B$+1
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
COMP_SKP4:
BEQ LINE_SKIP12
; Simplified conditional branch
;
LINE_NSKIP12:
;
JMP LINE_1000
;
LINE_SKIP12:
;
;
LINE_515:
;
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ1
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP1
EQ_EQ1:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP1:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_33
LDY #>CONST_33
STA B_REG
STY B_REG+1
LDA VAR_B$
LDY VAR_B$+1
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
COMP_SKP5:
BEQ LINE_SKIP13
; Simplified conditional branch
;
LINE_NSKIP13:
;
JMP LINE_3000
;
LINE_SKIP13:
;
;
LINE_520:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT2
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP2
GT_GT2:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP2:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_34
LDY #>CONST_34
STA B_REG
STY B_REG+1
LDA VAR_B$
LDY VAR_B$+1
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
COMP_SKP6:
BEQ LINE_SKIP14
; Simplified conditional branch
;
LINE_NSKIP14:
;
JMP LINE_2000
;
LINE_SKIP14:
;
;
LINE_525:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ3
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP3
EQ_EQ3:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP3:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_34
LDY #>CONST_34
STA B_REG
STY B_REG+1
LDA VAR_B$
LDY VAR_B$+1
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
BEQ LINE_SKIP15
; Simplified conditional branch
;
LINE_NSKIP15:
;
JMP LINE_4000
;
LINE_SKIP15:
;
;
LINE_530:
;
JSR COMPACTMAX
LDA #13
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_B$
LDY VAR_B$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP8:
BEQ LINE_SKIP16
; Simplified conditional branch
;
LINE_NSKIP16:
;
JMP LINE_5000
;
LINE_SKIP16:
;
;
LINE_540:
;
JMP LINE_500
;
LINE_1000:
;
LDY #11
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_1001:
;
LDY #16
STY 782
; Optimizer rule: Simple POKE/2
;
LINE_1010:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 781
;
LINE_1020:
;
LDY #0
STY 783
; Optimizer rule: Simple POKE/2
;
LINE_1030:
;
LDA #<65520
STA TMP_ZP
LDA #>65520
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_1040:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_C$
STY VAR_C$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_D$
STY VAR_D$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
JSR COMPACTMAX
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_C$
LDY VAR_C$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_D$
LDY VAR_D$+1
STA B_REG
STY B_REG+1
JSR CONCAT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1050:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
JMP LINE_400
;
LINE_2000:
;
LDY #11
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_2001:
;
LDY #16
STY 782
; Optimizer rule: Simple POKE/2
;
LINE_2010:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 781
;
LINE_2020:
;
LDY #0
STY 783
; Optimizer rule: Simple POKE/2
;
LINE_2030:
;
LDA #<65520
STA TMP_ZP
LDA #>65520
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_2040:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_C$
STY VAR_C$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_D$
STY VAR_D$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
JSR COMPACTMAX
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_C$
LDY VAR_C$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_D$
LDY VAR_D$+1
STA B_REG
STY B_REG+1
JSR CONCAT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2050:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
JMP LINE_400
;
LINE_3000:
;
LDY #11
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_3001:
;
LDY #16
STY 782
; Optimizer rule: Simple POKE/2
;
LINE_3010:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 781
;
LINE_3020:
;
LDY #0
STY 783
; Optimizer rule: Simple POKE/2
;
LINE_3030:
;
LDA #<65520
STA TMP_ZP
LDA #>65520
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_3035:
;
LDY #11
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_3040:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_C$
STY VAR_C$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_D$
STY VAR_D$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
JSR COMPACTMAX
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_C$
LDY VAR_C$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_D$
LDY VAR_D$+1
STA B_REG
STY B_REG+1
JSR CONCAT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3050:
;
LDX #4
dcloop2725_1:
LDA CONST_27,X
STA VAR_P,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_400
;
LINE_4000:
;
LDY #11
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_4001:
;
LDY #16
STY 782
; Optimizer rule: Simple POKE/2
;
LINE_4010:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 781
;
LINE_4020:
;
LDY #0
STY 783
; Optimizer rule: Simple POKE/2
;
LINE_4030:
;
LDA #<65520
STA TMP_ZP
LDA #>65520
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_4040:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_C$
STY VAR_C$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_D$
STY VAR_D$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
JSR COMPACTMAX
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_C$
LDY VAR_C$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_D$
LDY VAR_D$+1
STA B_REG
STY B_REG+1
JSR CONCAT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_4050:
;
LDX #4
dcloop3057_1:
LDA VAR_MA,X
STA VAR_P,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_400
;
LINE_5000:
;
LDA #147
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_5010:
;
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_5020:
;
LDX #4
dcloop3057_2:
LDA CONST_36R,X
STA VAR_T,X
DEX
BPL dcloop3057_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_5030:
;
JMP LINE_10
;
LINE_6000:
;
;
LINE_6010:
;
LDX #4
dcloop3057_3:
LDA CONST_27,X
STA VAR_I,X
DEX
BPL dcloop3057_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
;
LINE_6030:
;
LDA #<VAR_B
LDY #>VAR_B
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR POPREAL
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT4
LDA #0
JMP GT_SKIP4
GT_GT4:
LDA #$1
GT_SKIP4:
COMP_SKP9:
BNE LINE_NSKIP17
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP17
;
LINE_NSKIP17:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
LDX #<VAR_B
LDY #>VAR_B
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
;
LINE_SKIP17:
;
;
LINE_6040:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_2
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_2:
;
LINE_6050:
;
JMP RETURN
;
LINE_7000:
;
;
LINE_7001:
;
LDY #12
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_7005:
;
LDA #<CONST_38
LDY #>CONST_38
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_7010:
;
LDX #4
dcloop3389_1:
LDA CONST_4R,X
STA VAR_I,X
DEX
BPL dcloop3389_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_B
LDY #>VAR_B
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
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
LINE_7020:
;
LDA #<CONST_40
LDY #>CONST_40
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_7030:
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
LINE_7040:
;
LDA #<CONST_41
LDY #>CONST_41
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_7050:
;
LDX #4
dcloop3555_1:
LDA CONST_27,X
STA VAR_I,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
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
LINE_7060:
;
LDA #<CONST_42
LDY #>CONST_42
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_43
LDY #>CONST_43
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_B
LDY #>VAR_B
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_7070:
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
;
LINE_7080:
;
LDA #<CONST_42
LDY #>CONST_42
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_45
LDY #>CONST_45
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_7090:
;
LDX #4
dcloop3721_1:
LDA CONST_4R,X
STA VAR_I,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_B
LDY #>VAR_B
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
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
LINE_7100:
;
LDA #<CONST_46
LDY #>CONST_46
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_7110:
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
LINE_7120:
;
LDA #<CONST_47
LDY #>CONST_47
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_7130:
;
;
LINE_7200:
;
LDY #16
STY 782
; Optimizer rule: Simple POKE/2
;
LINE_7210:
;
LDY #4
STY 781
; Optimizer rule: Simple POKE/2
;
LINE_7220:
;
LDY #0
STY 783
; Optimizer rule: Simple POKE/2
;
LINE_7230:
;
LDA #<65520
STA TMP_ZP
LDA #>65520
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_7240:
;
JMP RETURN
;
LINE_8000:
;
;
LINE_8010:
;
LDX #4
dcloop3887_1:
LDA CONST_27,X
STA VAR_P,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_MA
LDY #>VAR_MA
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
;
LINE_8020:
;
LDA #<VAR_B
LDY #>VAR_B
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR POPREAL
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ5
ROL
BCC LT_LT5
LT_LT_EQ5:
LDA #0
JMP LT_SKIP5
LT_LT5:
LDA #$1
LT_SKIP5:
COMP_SKP14:
BEQ LINE_SKIP18
; Simplified conditional branch
;
LINE_NSKIP18:
;
JSR GOSUB
JSR LINE_8500
;
LINE_SKIP18:
;
;
LINE_8030:
;
LDA #<VAR_B
LDY #>VAR_B
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR POPREAL
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ6:
EQ_SKIP6:
COMP_SKP15:
BNE LINE_SKIP19
LINE_NSKIP19:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
;
LINE_SKIP19:
;
;
LINE_8040:
;
JMP RETURN
;
LINE_8500:
;
;
LINE_8510:
;
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
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
LDA #<VAR_B
LDY #>VAR_B
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
;
LINE_8520:
;
LDA #<CONST_48
LDY #>CONST_48
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_8530:
;
LDX #4
dcloop4385_1:
LDA CONST_4R,X
STA VAR_I,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_D
LDY #>VAR_D
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
;
LINE_8540:
;
LDA #<VAR_P
LDY #>VAR_P
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA VAR_J$
LDY VAR_J$+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_8550:
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
LINE_8560:
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
SYSTEMCALL
LDA TMP_ZP
STA SCDO+1
LDA TMP_ZP+1
STA SCDO+2
LDA $030F
PHA
LDA $030C
LDX $030D
LDY $030E
PLP
<IF BIGRAM>
JSR ENABLEROM
</IF>
SCDO		JSR $FFFF
<IF BIGRAM>
JSR DISABLEROM
</IF>
PHP
STA $030C
STX $030D
STY $030E
PLA
STA $030F
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
SPC			JSR TABSPCINIT
JSR REROUTE
LDA CMD_NUM
BEQ NORMALSPC		; No reroute? Normal SPC
CMP #3
BEQ NORMALSPC2		; To screen? Normal SPC
JMP TABCHANNEL2
NORMALSPC2	JSR CLRCHNEW
NORMALSPC	CLC
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
SINGLECHROUTBRKMAX
JSR SINGLECHROUTBRK
JMP COMPACTMAX
;###################################
;###################################
SINGLECHROUTBRK
STA TMP_ZP
JSR REROUTE
LDA TMP_ZP
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
INCTMPZP	LDA TMP_ZP
CLC
ADC TMP3_ZP
STA TMP_ZP
BCC NOPV2
INC TMP_ZP+1
NOPV2		RTS
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
CLRCHNEW
LDA CHLOCKFLAG
BNE SKIPCLRCH
JMP CLRCH
SKIPCLRCH
RTS
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
XREG2VAR
STX TMP_ZP
STY TMP_ZP+1
LDY #0
LDA X_REG
STA (TMP_ZP),Y
INY
LDA X_REG+1
STA (TMP_ZP),Y
INY
LDA X_REG+2
STA (TMP_ZP),Y
INY
LDA X_REG+3
STA (TMP_ZP),Y
INY
LDA X_REG+4
STA (TMP_ZP),Y
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
;###############################
INITVARS
JSR INITSTRVARS
LDA #0
LDY #4
REALINITLOOP0:
STA VAR_B,Y
STA VAR_MA,Y
STA VAR_P,Y
STA VAR_MI,Y
STA VAR_I,Y
STA VAR_T,Y
STA VAR_D,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #0


; CONST: #20

CONST_1R	.REAL 20.0
; CONST: #147


; CONST: #3

CONST_3R	.REAL 3.0
; CONST: #1

CONST_4R	.REAL 1.0
; CONST: #15


; CONST: #2.0

CONST_6	.REAL 2.0
; CONST: $eins
CONST_7	.BYTE 4
.STRG "eins"
; CONST: #2

CONST_8R	.REAL 2.0
; CONST: $zwei
CONST_9	.BYTE 4
.STRG "zwei"
; CONST: $drei
CONST_10	.BYTE 4
.STRG "drei"
; CONST: #4

CONST_11R	.REAL 4.0
; CONST: $vier
CONST_12	.BYTE 4
.STRG "vier"
; CONST: #5

CONST_13R	.REAL 5.0
; CONST: $fuenf
CONST_14	.BYTE 5
.STRG "fuenf"
; CONST: #6

CONST_15R	.REAL 6.0
; CONST: $sechs
CONST_16	.BYTE 5
.STRG "sechs"
; CONST: #7

CONST_17R	.REAL 7.0
; CONST: $sieben{space*2}
CONST_18	.BYTE 15
.STRG "sieben{space*2}"
; CONST: #8

CONST_19R	.REAL 8.0
; CONST: $acht
CONST_20	.BYTE 4
.STRG "acht"
; CONST: #9

CONST_21R	.REAL 9.0
; CONST: $neun{space*4}
CONST_22	.BYTE 13
.STRG "neun{space*4}"
; CONST: #10

CONST_23R	.REAL 10.0
; CONST: $zehn
CONST_24	.BYTE 4
.STRG "zehn"
; CONST: #11

CONST_25R	.REAL 11.0
; CONST: $elf
CONST_26	.BYTE 4
.STRG "elf "
; CONST: #1.0

CONST_27	.REAL 1.0
; CONST: $
CONST_28	.BYTE 0
.STRG ""
; CONST: #16.0

CONST_29	.REAL 16.0
; CONST: ${reverse on}
CONST_30	.BYTE 12
.STRG "{reverse on}"
; CONST: ${reverse off}
CONST_31	.BYTE 13
.STRG "{reverse off}"
; CONST: #16


; CONST: ${down}
CONST_33	.BYTE 6
.STRG "{down}"
; CONST: ${up}
CONST_34	.BYTE 4
.STRG "{up}"
; CONST: #13


; CONST: #500

CONST_36R	.REAL 500.0
; CONST: #12


; CONST: #13.0

CONST_38	.REAL 13.0
; CONST: $O
CONST_39	.BYTE 1
.STRG "O"
; CONST: ${cm y}
CONST_40	.BYTE 6
.STRG "{cm y}"
; CONST: $P
CONST_41	.BYTE 1
.STRG "P"
; CONST: #15.0

CONST_42	.REAL 15.0
; CONST: ${cm h}
CONST_43	.BYTE 6
.STRG "{cm h}"
; CONST: ${cm n}
CONST_44	.BYTE 6
.STRG "{cm n}"
; CONST: $L
CONST_45	.BYTE 1
.STRG "L"
; CONST: ${cm p}
CONST_46	.BYTE 6
.STRG "{cm p}"
; CONST: $N
CONST_47	.BYTE 1
.STRG "N"
; CONST: $
CONST_48	.BYTE 1
.STRG " "
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: B
VAR_B	.REAL 0.0
; VAR: MA
VAR_MA	.REAL 0.0
; VAR: P
VAR_P	.REAL 0.0
; VAR: MI
VAR_MI	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: T
VAR_T	.REAL 0.0
; VAR: D
VAR_D	.REAL 0.0
STRINGVARS_START
; VAR: C$
VAR_C$	.WORD EMPTYSTR
; VAR: D$
VAR_D$	.WORD EMPTYSTR
; VAR: J$
VAR_J$	.WORD EMPTYSTR
; VAR: B$
VAR_B$	.WORD EMPTYSTR
; VAR: TI$
VAR_TI$ .WORD EMPTYSTR
STRINGVARS_END
STRINGARRAYS_START
; VAR: A$[]
.BYTE 2
.WORD 42
VAR_A$[]
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
