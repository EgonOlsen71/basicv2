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
LDY #21
STY 53272
; Optimizer rule: Simple POKE/2
LDY #3
STY 53280
; Optimizer rule: Simple POKE/2
LDY #0
STY 53281
; Optimizer rule: Simple POKE/2
LDX #4
dcloop235_1:
LDA CONST_3R,X
STA VAR_CR,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_4:
;
;
LINE_13:
;
;
LINE_14:
;
;
LINE_80:
;
LDA #0
STA VAR_MO
STA VAR_MO+1
STA VAR_MO+2
STA VAR_MO+3
STA VAR_MO+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_90:
;
JMP LINE_62000
;
LINE_100:
;
;
LINE_110:
LDX #4
dcloop235_2:
LDA CONST_4R,X
STA VAR_F,X
LDA CONST_5R,X
STA VAR_FC,X
DEX
BPL dcloop235_2
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_120:
;
JMP LINE_1500
;
LINE_140:
;
LDA #0
STA VAR_P
STA VAR_P+1
STA VAR_P+2
STA VAR_P+3
STA VAR_P+4
LDX #4
dcloop235_4:
LDA CONST_6R,X
STA VAR_C,X
LDA CONST_7,X
STA VAR_M,X
LDA VAR_M,X
STA VAR_K,X
LDA VAR_M,X
STA VAR_L,X
LDA CONST_6R,X
STA VAR_I,X
LDA CONST_6R,X
STA VAR_J,X
DEX
BPL dcloop235_4
; Special rule: Aggregation of assignments (6)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_145:
;
LDY #32
STY 54276
; Optimizer rule: Simple POKE/2
LDY #0
STY 54283
; Optimizer rule: Simple POKE/2
STY 54290
; Optimizer rule: Simple POKE/2
LDY #15
STY 54296
; Optimizer rule: Simple POKE/2
;
LINE_146:
;
LDY #0
STY 54274
; Optimizer rule: Simple POKE/2
LDY #8
STY 54275
; Optimizer rule: Simple POKE/2
LDY #0
STY 54277
; Optimizer rule: Simple POKE/2
LDY #240
STY 54278
; Optimizer rule: Simple POKE/2
STY 54295
; Optimizer rule: Simple POKE/2
;
LINE_150:
;
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
LDX #4
dcloop235_10:
LDA CONST_12,X
STA VAR_CC,X
LDA CONST_13,X
STA VAR_DD,X
LDA CONST_14,X
STA VAR_EE,X
LDA CONST_15,X
STA VAR_FF,X
LDA CONST_16,X
STA VAR_G,X
DEX
BPL dcloop235_10
; Special rule: Aggregation of assignments (5)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_170:
;
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<CONST_18R
LDY #>CONST_18R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop235_15:
LDA CONST_19,X
STA VAR_X,X
DEX
BPL dcloop235_15
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_200:
;
;
LINE_210:
;
;
LINE_220:
;
JSR LINEBREAK
LDA #<CONST_20
LDY #>CONST_20
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_22
LDY #>CONST_22
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_230:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_24
LDY #>CONST_24
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_240:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_25
LDY #>CONST_25
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_250:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_26
LDY #>CONST_26
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_260:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_26
LDY #>CONST_26
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_270:
;
LDA #<CONST_27
LDY #>CONST_27
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_28R
LDY #>CONST_28R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_280:
;
LDA #<CONST_30
LDY #>CONST_30
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_31R
LDY #>CONST_31R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_290:
;
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_300:
;
LDA #<CONST_34
LDY #>CONST_34
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_310:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_320:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_37
LDY #>CONST_37
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_330:
;
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_MO
LDY #>VAR_MO
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT0
LDA #0
JMP GT_SKIP0
GT_GT0:
LDA #$1
GT_SKIP0:
COMP_SKP0:
BEQ LINE_SKIP69
; Simplified conditional branch
;
LINE_NSKIP69:
;
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP69:
;
;
LINE_331:
;
LDA VAR_MO
BEQ EQ_SKIP1
EQ_EQ1:
JMP LINE_SKIP70
EQ_SKIP1:
COMP_SKP1:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP70:
;
LDA #<CONST_40
LDY #>CONST_40
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP70:
;
;
LINE_335:
;
LDY #160
STY 2023
; Optimizer rule: Simple POKE/2
LDY #14
STY 56295
; Optimizer rule: Simple POKE/2
;
LINE_350:
;
LDA #<CONST_43
LDY #>CONST_43
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_360:
;
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_370:
;
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_380:
;
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_390:
;
LDA #<CONST_45
LDY #>CONST_45
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_400:
;
LDA #<CONST_46
LDY #>CONST_46
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_410:
;
LDA #<CONST_47
LDY #>CONST_47
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_420:
;
LDA #<CONST_48
LDY #>CONST_48
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_430:
;
LDA #<CONST_49
LDY #>CONST_49
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_440:
;
LDA #<CONST_50
LDY #>CONST_50
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_450:
;
LDA #<CONST_51
LDY #>CONST_51
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_460:
;
LDA #<CONST_52
LDY #>CONST_52
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_470:
;
LDA #<CONST_6R
LDY #>CONST_6R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_53
LDY #>CONST_53
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_480:
;
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_O
LDY #>VAR_O
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
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
;
LINE_500:
;
LDY #255
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_O
LDY #>VAR_O
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ2
ROL
BCC LT_LT2
LT_LT_EQ2:
LDA #0
JMP LT_SKIP2
LT_LT2:
LDA #$1
LT_SKIP2:
COMP_SKP2:
BEQ LINE_SKIP71
; Simplified conditional branch
;
LINE_NSKIP71:
;
LDA #0
STA VAR_O
STA VAR_O+1
STA VAR_O+2
STA VAR_O+3
STA VAR_O+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP71:
;
;
LINE_508:
;
LDA #<CONST_56
LDY #>CONST_56
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_O
LDY #>VAR_O
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR INTOUT
JSR CRSRRIGHT
LDA #<CONST_57
LDY #>CONST_57
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_58R
LDY #>CONST_58R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_O
LDY #>VAR_O
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ3
ROL
BCC LT_LT3
LT_LT_EQ3:
LDA #0
JMP LT_SKIP3
LT_LT3:
LDA #$1
LT_SKIP3:
COMP_SKP3:
BEQ LINE_SKIP72
; Simplified conditional branch
;
LINE_NSKIP72:
;
JMP LINE_1230
;
LINE_SKIP72:
;
;
LINE_509:
;
LDX #4
dcloop567_1:
LDA CONST_11R,X
STA VAR_I,X
DEX
BPL dcloop567_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_510:
;
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_MO
LDY #>VAR_MO
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT4
LDA #0
JMP GT_SKIP4
GT_GT4:
LDA #$1
GT_SKIP4:
COMP_SKP4:
BEQ LINE_SKIP73
; Simplified conditional branch
;
LINE_NSKIP73:
;
JMP LINE_520
;
LINE_SKIP73:
;
;
LINE_511:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D$
LDY #>VAR_D$
JSR COPYSTRING
LDA #<CONST_60
LDY #>CONST_60
STA B_REG
STY B_REG+1
LDA VAR_D$
LDY VAR_D$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SGT
LDA X_REG
COMP_SKP5:
BEQ LINE_SKIP74
; Simplified conditional branch
;
LINE_NSKIP74:
;
LDY #0
STY 198
; Optimizer rule: Simple POKE/2
LDX #4
dcloop733_1:
LDA CONST_55R,X
STA VAR_MO,X
DEX
BPL dcloop733_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_62000
JMP LINE_120
;
LINE_SKIP74:
;
;
LINE_512:
;
LDA #<CONST_61
LDY #>CONST_61
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ5
ROL
BCC LT_LT5
LT_LT_EQ5:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP5
LT_LT5:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP5:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_62
LDY #>CONST_62
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT6
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP6
GT_GT6:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP6:
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
COMP_SKP6:
BEQ LINE_SKIP75
; Simplified conditional branch
;
LINE_NSKIP75:
;
LDX #4
dcloop733_2:
LDA CONST_6R,X
STA VAR_Y,X
DEX
BPL dcloop733_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_550
;
LINE_SKIP75:
;
;
LINE_513:
;
LDA #<CONST_63
LDY #>CONST_63
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ7
ROL
BCC LT_LT7
LT_LT_EQ7:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP7
LT_LT7:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP7:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT8
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP8
GT_GT8:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP8:
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
COMP_SKP7:
BEQ LINE_SKIP76
; Simplified conditional branch
;
LINE_NSKIP76:
;
LDX #4
dcloop733_3:
LDA CONST_65R,X
STA VAR_Y,X
DEX
BPL dcloop733_3
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_550
;
LINE_SKIP76:
;
;
LINE_514:
;
LDA #<CONST_66
LDY #>CONST_66
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ9
ROL
BCC LT_LT9
LT_LT_EQ9:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP9
LT_LT9:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP9:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_67
LDY #>CONST_67
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT10
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP10
GT_GT10:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP10:
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
COMP_SKP8:
BEQ LINE_SKIP77
; Simplified conditional branch
;
LINE_NSKIP77:
;
LDX #4
dcloop899_1:
LDA CONST_1R,X
STA VAR_Y,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_550
;
LINE_SKIP77:
;
;
LINE_515:
;
LDA #<VAR_FC
LDY #>VAR_FC
JSR REALFAC
LDA #<VAR_FT
LDY #>VAR_FT
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ11
ROL
BCC LT_LT11
LT_LT_EQ11:
LDA #0
JMP LT_SKIP11
LT_LT11:
LDA #$1
LT_SKIP11:
COMP_SKP9:
BEQ LINE_SKIP78
; Simplified conditional branch
;
LINE_NSKIP78:
;
JMP LINE_1740
;
LINE_SKIP78:
;
;
LINE_516:
;
LDX #4
dcloop899_2:
LDA CONST_55R,X
STA VAR_FT,X
DEX
BPL dcloop899_2
; Optimizer rule: Direct copy of floats into mem/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_68R
LDY #>CONST_68R
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_D%
STA VAR_D%+1
;
LINE_517:
;
LDA #<CONST_69
LDY #>CONST_69
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ12
ROL
BCC LT_LT12
LT_LT_EQ12:
LDA #0
JMP LT_SKIP12
LT_LT12:
LDA #$1
LT_SKIP12:
COMP_SKP10:
BNE LINE_NSKIP79
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP79
;
LINE_NSKIP79:
;
LDY #$00
LDA #$03
STY TMP4_REG+1
STA TMP4_REG
LDY VAR_D%
LDA VAR_D%+1
JSR INTADDOPT16X
STY VAR_D%
STA VAR_D%+1
; Optimized code for adding/subtracting ints and store in int
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
;
;
;
;
;
;
LINE_SKIP79:
;
;
LINE_518:
;
LDA #<CONST_70
LDY #>CONST_70
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT13
LDA #0
JMP GT_SKIP13
GT_GT13:
LDA #$1
GT_SKIP13:
COMP_SKP11:
BNE LINE_NSKIP80
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP80
;
LINE_NSKIP80:
;
LDY #$00
LDA #$03
STY TMP4_REG+1
STA TMP4_REG
LDY VAR_D%
LDA VAR_D%+1
JSR INTSUBOPT16X
STY VAR_D%
STA VAR_D%+1
; Optimized code for adding/subtracting ints and store in int
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
;
;
;
;
;
;
LINE_SKIP80:
;
;
LINE_519:
;
LDY VAR_D%
LDA VAR_D%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
JMP LINE_550
;
LINE_520:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D$
LDY #>VAR_D$
JSR COPYSTRING
LDA #<CONST_60
LDY #>CONST_60
STA B_REG
STY B_REG+1
LDA VAR_D$
LDY VAR_D$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ14
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP14
EQ_EQ14:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP14:
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
COMP_SKP12:
BEQ LINE_SKIP81
; Simplified conditional branch
;
LINE_NSKIP81:
;
JMP LINE_1740
;
LINE_SKIP81:
;
;
LINE_530:
;
LDA #<CONST_60
LDY #>CONST_60
STA B_REG
STY B_REG+1
LDA VAR_D$
LDY VAR_D$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP13:
BEQ LINE_SKIP82
; Simplified conditional branch
;
LINE_NSKIP82:
;
LDA #<VAR_M
LDY #>VAR_M
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF19+1
STA MOVBSELF19+2
LDA #$20
MOVBSELF19:
STA $FFFF
JMP LINE_750
;
LINE_SKIP82:
;
;
LINE_534:
;
LDA #<CONST_71
LDY #>CONST_71
STA B_REG
STY B_REG+1
LDA VAR_D$
LDY VAR_D$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP14:
BEQ LINE_SKIP83
; Simplified conditional branch
;
LINE_NSKIP83:
;
JMP LINE_1230
;
LINE_SKIP83:
;
;
LINE_540:
;
LDA VAR_D$
LDY VAR_D$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
LDX #<VAR_Y
LDY #>VAR_Y
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ15
ROL
BCC LT_LT15
LT_LT_EQ15:
LDA #0
JMP LT_SKIP15
LT_LT15:
LDA #$1
LT_SKIP15:
COMP_SKP15:
BEQ LINE_SKIP84
; Simplified conditional branch
;
LINE_NSKIP84:
;
JMP LINE_520
;
LINE_SKIP84:
;
;
LINE_550:
;
LDA #<CONST_72R
LDY #>CONST_72R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
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
LDA #<CONST_68R
LDY #>CONST_68R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ18
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP18
EQ_EQ18:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP18:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP16:
BEQ LINE_SKIP85
; Simplified conditional branch
;
LINE_NSKIP85:
;
LDX #4
dcloop1065_1:
LDA CONST_65R,X
STA VAR_X,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_580
;
LINE_SKIP85:
;
;
LINE_560:
;
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ19
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP19
EQ_EQ19:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP19:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_73R
LDY #>CONST_73R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ20
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP20
EQ_EQ20:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP20:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_74R
LDY #>CONST_74R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ21
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP21
EQ_EQ21:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP21:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP17:
BEQ LINE_SKIP86
; Simplified conditional branch
;
LINE_NSKIP86:
;
LDX #4
dcloop1231_1:
LDA CONST_75R,X
STA VAR_X,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_580
;
LINE_SKIP86:
;
;
LINE_570:
;
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ22
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP22
EQ_EQ22:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP22:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_65R
LDY #>CONST_65R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ23
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP23
EQ_EQ23:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP23:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ24
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP24
EQ_EQ24:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP24:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP18:
BEQ LINE_SKIP87
; Simplified conditional branch
;
LINE_NSKIP87:
;
LDX #4
dcloop1231_2:
LDA CONST_31R,X
STA VAR_X,X
DEX
BPL dcloop1231_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP87:
;
;
LINE_580:
;
LDA #<CONST_65R
LDY #>CONST_65R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT25
LDA #0
JMP GT_SKIP25
GT_GT25:
LDA #$1
GT_SKIP25:
COMP_SKP19:
BEQ LINE_SKIP88
; Simplified conditional branch
;
LINE_NSKIP88:
;
JMP LINE_660
;
LINE_SKIP88:
;
;
LINE_590:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT26
LDA #0
JMP GT_SKIP26
GT_GT26:
LDA #$1
GT_SKIP26:
COMP_SKP20:
BEQ LINE_SKIP89
; Simplified conditional branch
;
LINE_NSKIP89:
;
JMP LINE_630
;
LINE_SKIP89:
;
;
LINE_600:
;
LDY #0
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<CONST_76
LDY #>CONST_76
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop1231_3:
LDA CONST_55R,X
STA VAR_A,X
DEX
BPL dcloop1231_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_X
LDY #>VAR_X
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_A
LDY #>VAR_A
STA A_REG
STY A_REG+1
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
LDA #<CONST_77
LDY #>CONST_77
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_A
LDY #>VAR_A
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
; FAC to integer in Y/A
JSR FACWORD
STY 54273
;
LINE_610:
;
LDX #4
dcloop1231_4:
LDA VAR_A,X
STA VAR_B,X
DEX
BPL dcloop1231_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
LDA #<CONST_78
LDY #>CONST_78
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AA
LDY #>VAR_AA
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF23+1
STA MOVBSELF23+2
MOVBSELF23:
LDA $FFFF
CMP #42
BCC PEEKLT0
BEQ PEEKEQ0
LDA #$FF
JMP PEEKDONE0
PEEKLT0:
LDA #$01
JMP PEEKDONE0
PEEKEQ0:
LDA #0
PEEKDONE0:
; Optimized comparison for PEEK
;
EQ_EQ27:
EQ_SKIP27:
COMP_SKP21:
BNE LINE_SKIP90
LINE_NSKIP90:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_1160
LDX #4
dcloop1397_1:
LDA VAR_X,X
STA VAR_A,X
DEX
BPL dcloop1397_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP90:
;
;
LINE_620:
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
LDX #4
dcloop1397_2:
LDA CONST_55R,X
STA VAR_X,X
DEX
BPL dcloop1397_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_B
LDY #>VAR_B
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP1
STA JUMP_TARGET
LDA #>FORLOOP1
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP1:
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
LDA #32
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
JMP LINE_690
;
LINE_630:
;
JSR GOSUB
JSR LINE_840
LDY #0
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<CONST_81
LDY #>CONST_81
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop1397_3:
LDA CONST_55R,X
STA VAR_A,X
DEX
BPL dcloop1397_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_X
LDY #>VAR_X
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_A
LDY #>VAR_A
STA A_REG
STY A_REG+1
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_640:
;
LDA #<VAR_A
LDY #>VAR_A
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
; FAC to integer in Y/A
JSR FACWORD
STY 54273
LDX #4
dcloop1397_4:
LDA VAR_A,X
STA VAR_B,X
DEX
BPL dcloop1397_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
LDA #<CONST_83
LDY #>CONST_83
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AA
LDY #>VAR_AA
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF28+1
STA MOVBSELF28+2
MOVBSELF28:
LDA $FFFF
CMP #42
BCC PEEKLT1
BEQ PEEKEQ1
LDA #$FF
JMP PEEKDONE1
PEEKLT1:
LDA #$01
JMP PEEKDONE1
PEEKEQ1:
LDA #0
PEEKDONE1:
; Optimized comparison for PEEK
;
EQ_EQ28:
EQ_SKIP28:
COMP_SKP24:
BNE LINE_SKIP91
LINE_NSKIP91:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_1160
LDX #4
dcloop1397_5:
LDA VAR_X,X
STA VAR_A,X
DEX
BPL dcloop1397_5
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP91:
;
;
LINE_650:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_2
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_2:
LDX #4
dcloop1397_6:
LDA CONST_55R,X
STA VAR_X,X
DEX
BPL dcloop1397_6
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_B
LDY #>VAR_B
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
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
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_3
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_3:
LDA #32
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
JMP LINE_690
;
LINE_660:
;
JSR GOSUB
JSR LINE_840
LDY #0
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
JSR GOSUB
JSR LINE_1000
LDA #<CONST_84
LDY #>CONST_84
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop1563_1:
LDA CONST_55R,X
STA VAR_A,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_X
LDY #>VAR_X
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_A
LDY #>VAR_A
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_670:
;
LDA #<VAR_A
LDY #>VAR_A
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
; FAC to integer in Y/A
JSR FACWORD
STY 54273
LDX #4
dcloop1563_2:
LDA VAR_A,X
STA VAR_B,X
DEX
BPL dcloop1563_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
LDA #<CONST_85
LDY #>CONST_85
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AA
LDY #>VAR_AA
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF33+1
STA MOVBSELF33+2
MOVBSELF33:
LDA $FFFF
CMP #42
BCC PEEKLT2
BEQ PEEKEQ2
LDA #$FF
JMP PEEKDONE2
PEEKLT2:
LDA #$01
JMP PEEKDONE2
PEEKEQ2:
LDA #0
PEEKDONE2:
; Optimized comparison for PEEK
;
EQ_EQ29:
EQ_SKIP29:
COMP_SKP27:
BNE LINE_SKIP92
LINE_NSKIP92:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_1160
LDX #4
dcloop1563_3:
LDA VAR_X,X
STA VAR_A,X
DEX
BPL dcloop1563_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP92:
;
;
LINE_680:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_4
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_4:
LDX #4
dcloop1563_4:
LDA CONST_55R,X
STA VAR_X,X
DEX
BPL dcloop1563_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_B
LDY #>VAR_B
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
LDA #<CONST_86
LDY #>CONST_86
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_5
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_5:
LDA #32
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
JSR GOSUB
JSR LINE_840
;
LINE_690:
;
LDX #4
dceloop4816_1:
LDA VAR_K,X
CMP VAR_AA,X
BNE LINE_SKIP93
DEX
BPL dceloop4816_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP93:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1563_5:
LDA CONST_14,X
STA VAR_K,X
DEX
BPL dcloop1563_5
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_720
;
LINE_SKIP93:
;
;
LINE_700:
;
LDX #4
dceloop4816_2:
LDA VAR_L,X
CMP VAR_AA,X
BNE LINE_SKIP94
DEX
BPL dceloop4816_2
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP94:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1729_1:
LDA CONST_87,X
STA VAR_L,X
DEX
BPL dcloop1729_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_720
;
LINE_SKIP94:
;
;
LINE_710:
;
LDX #4
dceloop4816_3:
LDA VAR_M,X
CMP VAR_AA,X
BNE LINE_SKIP95
DEX
BPL dceloop4816_3
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP95:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1729_2:
LDA CONST_88,X
STA VAR_M,X
DEX
BPL dcloop1729_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP95:
;
;
LINE_720:
;
LDX #4
dcloop1729_3:
LDA VAR_X,X
STA VAR_Y,X
DEX
BPL dcloop1729_3
; Optimizer rule: Direct copy of floats into mem/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ33:
EQ_SKIP33:
COMP_SKP33:
BNE LINE_SKIP96
LINE_NSKIP96:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP96:
;
;
LINE_730:
;
LDA #<CONST_89R
LDY #>CONST_89R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ34
LDA #0
JMP EQ_SKIP34
EQ_EQ34:
LDA #$1
EQ_SKIP34:
COMP_SKP34:
BNE LINE_NSKIP97
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP97
;
LINE_NSKIP97:
;
LDA #0
STA VAR_Z
STA VAR_Z+1
STA VAR_Z+2
STA VAR_Z+3
STA VAR_Z+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_O
LDY #>VAR_O
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP97:
;
;
LINE_740:
;
LDY #0
STY 198
; Optimizer rule: Simple POKE/2
LDX #4
dcloop1729_4:
LDA CONST_5R,X
STA VAR_FC,X
DEX
BPL dcloop1729_4
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_350
;
LINE_750:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_N
LDY #>VAR_N
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF36+1
STA MOVBSELF36+2
LDA #$20
MOVBSELF36:
STA $FFFF
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF37+1
STA MOVBSELF37+2
LDA #$20
MOVBSELF37:
STA $FFFF
LDA #<VAR_M
LDY #>VAR_M
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF38+1
STA MOVBSELF38+2
LDA #$20
MOVBSELF38:
STA $FFFF
;
LINE_760:
;
LDA #<CONST_90
LDY #>CONST_90
JSR REALFAC
LDA #<VAR_N
LDY #>VAR_N
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ35
ROL
BCC LT_LT35
LT_LT_EQ35:
LDA #0
JMP LT_SKIP35
LT_LT35:
LDA #$1
LT_SKIP35:
COMP_SKP35:
BNE LINE_NSKIP98
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP98
;
LINE_NSKIP98:
;
LDY #240
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_K
LDY #>VAR_K
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_K
LDY #>VAR_K
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_92R
LDY #>CONST_92R
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
; FAC to (X/Y)
JSR FACMEM
JMP LINE_800
;
LINE_SKIP98:
;
;
LINE_770:
;
LDA #<CONST_93
LDY #>CONST_93
JSR REALFAC
LDA #<VAR_N
LDY #>VAR_N
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ36
ROL
BCC LT_LT36
LT_LT_EQ36:
LDA #0
JMP LT_SKIP36
LT_LT36:
LDA #$1
LT_SKIP36:
COMP_SKP36:
BNE LINE_NSKIP99
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP99
;
LINE_NSKIP99:
;
LDY #248
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_K
LDY #>VAR_K
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_K
LDY #>VAR_K
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_L
LDY #>VAR_L
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_L
LDY #>VAR_L
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_J
LDY #>VAR_J
; FAC to (X/Y)
JSR FACMEM
JMP LINE_800
;
LINE_SKIP99:
;
;
LINE_780:
;
LDA #<CONST_95
LDY #>CONST_95
JSR REALFAC
LDA #<VAR_N
LDY #>VAR_N
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ37
ROL
BCC LT_LT37
LT_LT_EQ37:
LDA #0
JMP LT_SKIP37
LT_LT37:
LDA #$1
LT_SKIP37:
COMP_SKP37:
BNE LINE_NSKIP100
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP100
;
LINE_NSKIP100:
;
LDY #255
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_96R
LDY #>CONST_96R
JSR REALFAC
LDA #<VAR_K
LDY #>VAR_K
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_K
LDY #>VAR_K
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_L
LDY #>VAR_L
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_L
LDY #>VAR_L
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
; FAC to (X/Y)
JSR FACMEM
JMP LINE_800
;
LINE_SKIP100:
;
;
LINE_790:
;
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_K
LDY #>VAR_K
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_K
LDY #>VAR_K
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_91R
LDY #>CONST_91R
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_J
LDY #>VAR_J
; FAC to (X/Y)
JSR FACMEM
;
LINE_800:
;
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<CONST_97R
LDY #>CONST_97R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT38
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP38
GT_GT38:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP38:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ39
ROL
BCC LT_LT39
LT_LT_EQ39:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP39
LT_LT39:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP39:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_M
LDY #>VAR_M
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT40
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP40
GT_GT40:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP40:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_M
LDY #>VAR_M
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ41
ROL
BCC LT_LT41
LT_LT_EQ41:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP41
LT_LT41:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP41:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
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
COMP_SKP38:
BEQ LINE_SKIP101
; Simplified conditional branch
;
LINE_NSKIP101:
LDX #4
dcloop2227_1:
LDA CONST_6R,X
STA VAR_C,X
LDA CONST_14,X
STA VAR_M,X
DEX
BPL dcloop2227_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP101:
;
;
LINE_810:
;
LDA #<VAR_M
LDY #>VAR_M
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF46+1
STA MOVBSELF46+2
LDA #$1
MOVBSELF46:
STA $FFFF
LDA #<VAR_M
LDY #>VAR_M
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF47+1
STA MOVBSELF47+2
LDA #$2A
MOVBSELF47:
STA $FFFF
LDA #<CONST_97R
LDY #>CONST_97R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT42
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP42
GT_GT42:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP42:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ43
ROL
BCC LT_LT43
LT_LT_EQ43:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP43
LT_LT43:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP43:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_L
LDY #>VAR_L
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT44
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP44
GT_GT44:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP44:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_L
LDY #>VAR_L
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ45
ROL
BCC LT_LT45
LT_LT_EQ45:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP45
LT_LT45:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP45:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
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
COMP_SKP39:
BEQ LINE_SKIP102
; Simplified conditional branch
;
LINE_NSKIP102:
LDX #4
dcloop2227_3:
LDA CONST_6R,X
STA VAR_J,X
LDA CONST_14,X
STA VAR_L,X
DEX
BPL dcloop2227_3
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP102:
;
;
LINE_820:
;
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF48+1
STA MOVBSELF48+2
LDA #$1
MOVBSELF48:
STA $FFFF
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF49+1
STA MOVBSELF49+2
LDA #$2A
MOVBSELF49:
STA $FFFF
LDA #<CONST_97R
LDY #>CONST_97R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT46
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP46
GT_GT46:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP46:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ47
ROL
BCC LT_LT47
LT_LT_EQ47:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP47
LT_LT47:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP47:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_K
LDY #>VAR_K
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT48
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP48
GT_GT48:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP48:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_K
LDY #>VAR_K
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ49
ROL
BCC LT_LT49
LT_LT_EQ49:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP49
LT_LT49:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP49:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
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
COMP_SKP40:
BEQ LINE_SKIP103
; Simplified conditional branch
;
LINE_NSKIP103:
LDX #4
dcloop2393_1:
LDA CONST_6R,X
STA VAR_I,X
LDA CONST_14,X
STA VAR_K,X
DEX
BPL dcloop2393_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP103:
;
;
LINE_822:
;
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
LDA #<VAR_L
LDY #>VAR_L
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ50
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP50
EQ_EQ50:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP50:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
LDA #<VAR_M
LDY #>VAR_M
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ51
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP51
EQ_EQ51:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP51:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
LDA #<VAR_M
LDY #>VAR_M
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ52
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP52
EQ_EQ52:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP52:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP41:
BEQ LINE_SKIP104
; Simplified conditional branch
;
LINE_NSKIP104:
;
JMP LINE_750
;
LINE_SKIP104:
;
;
LINE_824:
;
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF50+1
STA MOVBSELF50+2
LDA #$1
MOVBSELF50:
STA $FFFF
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF51+1
STA MOVBSELF51+2
LDA #$1
MOVBSELF51:
STA $FFFF
LDA #<VAR_M
LDY #>VAR_M
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF52+1
STA MOVBSELF52+2
LDA #$1
MOVBSELF52:
STA $FFFF
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF53+1
STA MOVBSELF53+2
LDA #$2A
MOVBSELF53:
STA $FFFF
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF54+1
STA MOVBSELF54+2
LDA #$2A
MOVBSELF54:
STA $FFFF
LDA #<VAR_M
LDY #>VAR_M
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF55+1
STA MOVBSELF55+2
LDA #$2A
MOVBSELF55:
STA $FFFF
JMP LINE_500
;
LINE_840:
;
LDA #<CONST_100
LDY #>CONST_100
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_850:
;
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_860:
;
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_870:
;
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_880:
;
LDA #<CONST_45
LDY #>CONST_45
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_890:
;
LDA #<CONST_46
LDY #>CONST_46
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_900:
;
LDA #<CONST_101
LDY #>CONST_101
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_910:
;
LDA #<CONST_102
LDY #>CONST_102
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_920:
;
LDA #<CONST_103
LDY #>CONST_103
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_930:
;
LDA #<CONST_104
LDY #>CONST_104
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_940:
;
LDA #<CONST_105
LDY #>CONST_105
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_950:
;
LDA #<CONST_106
LDY #>CONST_106
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_960:
;
LDA #<CONST_107
LDY #>CONST_107
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_970:
;
LDA #<CONST_108
LDY #>CONST_108
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_980:
;
LDA #<CONST_109
LDY #>CONST_109
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_990:
;
LDA #<CONST_110
LDY #>CONST_110
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_1000:
;
LDA #<CONST_111
LDY #>CONST_111
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1010:
;
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1020:
;
LDA #<CONST_101
LDY #>CONST_101
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1030:
;
LDA #<CONST_102
LDY #>CONST_102
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1040:
;
LDA #<CONST_103
LDY #>CONST_103
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1050:
;
LDA #<CONST_113
LDY #>CONST_113
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1060:
;
LDA #<CONST_114
LDY #>CONST_114
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1070:
;
LDA #<CONST_115
LDY #>CONST_115
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1080:
;
LDA #<CONST_116
LDY #>CONST_116
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1090:
;
LDA #<CONST_117
LDY #>CONST_117
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1100:
;
LDA #<CONST_118
LDY #>CONST_118
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1110:
;
LDA #<CONST_119
LDY #>CONST_119
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1120:
;
LDA #<CONST_107
LDY #>CONST_107
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1130:
;
LDA #<CONST_108
LDY #>CONST_108
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1140:
;
LDA #<CONST_109
LDY #>CONST_109
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1150:
;
LDA #<CONST_110
LDY #>CONST_110
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_1160:
;
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_AA
LDY #>VAR_AA
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF56+1
STA MOVBSELF56+2
MOVBSELF56:
LDA $FFFF
CMP #42
BCC PEEKLT3
BEQ PEEKEQ3
LDA #$FF
JMP PEEKDONE3
PEEKLT3:
LDA #$01
JMP PEEKDONE3
PEEKEQ3:
LDA #0
PEEKDONE3:
; Optimized comparison for PEEK
;
BEQ EQ_EQ53
LDA #0
JMP EQ_SKIP53
EQ_EQ53:
LDA #$1
EQ_SKIP53:
COMP_SKP42:
BNE LINE_NSKIP105
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP105
;
LINE_NSKIP105:
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
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP105:
;
;
LINE_1170:
;
LDY #$28
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AA
LDY #>VAR_AA
JSR INTADDPOKE
STY MOVBSELF57+1
STA MOVBSELF57+2
; Fast add for POKE(1)
;
;
;
;
;
MOVBSELF57:
LDA $FFFF
CMP #42
BCC PEEKLT4
BEQ PEEKEQ4
LDA #$FF
JMP PEEKDONE4
PEEKLT4:
LDA #$01
JMP PEEKDONE4
PEEKEQ4:
LDA #0
PEEKDONE4:
; Optimized comparison for PEEK
;
BEQ EQ_EQ54
LDA #0
JMP EQ_SKIP54
EQ_EQ54:
LDA #$1
EQ_SKIP54:
COMP_SKP43:
BNE LINE_NSKIP106
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP106
;
LINE_NSKIP106:
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
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP106:
;
;
LINE_1180:
;
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AA
LDY #>VAR_AA
JSR INTADDPOKE
STY MOVBSELF58+1
STA MOVBSELF58+2
; Fast add for POKE(2)
;
;
;
;
MOVBSELF58:
LDA $FFFF
CMP #42
BCC PEEKLT5
BEQ PEEKEQ5
LDA #$FF
JMP PEEKDONE5
PEEKLT5:
LDA #$01
JMP PEEKDONE5
PEEKEQ5:
LDA #0
PEEKDONE5:
; Optimized comparison for PEEK
;
BEQ EQ_EQ55
LDA #0
JMP EQ_SKIP55
EQ_EQ55:
LDA #$1
EQ_SKIP55:
COMP_SKP44:
BNE LINE_NSKIP107
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP107
;
LINE_NSKIP107:
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
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP107:
;
;
LINE_1185:
;
LDA #<VAR_AA
LDY #>VAR_AA
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_A
LDY #>VAR_A
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 54273
;
LINE_1190:
;
LDA #<VAR_AA
LDY #>VAR_AA
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF60+1
STA MOVBSELF60+2
LDA #$AA
MOVBSELF60:
STA $FFFF
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_AA
LDY #>VAR_AA
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF61+1
STA MOVBSELF61+2
LDA #$A0
MOVBSELF61:
STA $FFFF
LDY #$28
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AA
LDY #>VAR_AA
JSR INTADDPOKE
STY MOVBSELF62+1
STA MOVBSELF62+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$A0
MOVBSELF62:
STA $FFFF
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_AA
LDY #>VAR_AA
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF63+1
STA MOVBSELF63+2
LDA #$A0
MOVBSELF63:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AA
LDY #>VAR_AA
JSR INTADDPOKE
STY MOVBSELF64+1
STA MOVBSELF64+2
; Fast add for POKE(2)
;
;
;
;
LDA #$A0
MOVBSELF64:
STA $FFFF
;
LINE_1195:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF65+1
STA MOVBSELF65+2
LDA #$4
MOVBSELF65:
STA $FFFF
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF66+1
STA MOVBSELF66+2
LDA #$4
MOVBSELF66:
STA $FFFF
LDY #$28
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AC
LDY #>VAR_AC
JSR INTADDPOKE
STY MOVBSELF67+1
STA MOVBSELF67+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$4
MOVBSELF67:
STA $FFFF
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF68+1
STA MOVBSELF68+2
LDA #$4
MOVBSELF68:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AC
LDY #>VAR_AC
JSR INTADDPOKE
STY MOVBSELF69+1
STA MOVBSELF69+2
; Fast add for POKE(2)
;
;
;
;
LDA #$4
MOVBSELF69:
STA $FFFF
LDA #<VAR_A
LDY #>VAR_A
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #2
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 54273
;
LINE_1200:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF71+1
STA MOVBSELF71+2
LDA #$2
MOVBSELF71:
STA $FFFF
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF72+1
STA MOVBSELF72+2
LDA #$2
MOVBSELF72:
STA $FFFF
LDY #$28
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AC
LDY #>VAR_AC
JSR INTADDPOKE
STY MOVBSELF73+1
STA MOVBSELF73+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$2
MOVBSELF73:
STA $FFFF
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF74+1
STA MOVBSELF74+2
LDA #$2
MOVBSELF74:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AC
LDY #>VAR_AC
JSR INTADDPOKE
STY MOVBSELF75+1
STA MOVBSELF75+2
; Fast add for POKE(2)
;
;
;
;
LDA #$2
MOVBSELF75:
STA $FFFF
;
LINE_1205:
;
LDA #<VAR_AA
LDY #>VAR_AA
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF76+1
STA MOVBSELF76+2
LDA #$20
MOVBSELF76:
STA $FFFF
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_AA
LDY #>VAR_AA
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF77+1
STA MOVBSELF77+2
LDA #$20
MOVBSELF77:
STA $FFFF
LDY #$28
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AA
LDY #>VAR_AA
JSR INTADDPOKE
STY MOVBSELF78+1
STA MOVBSELF78+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$20
MOVBSELF78:
STA $FFFF
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_AA
LDY #>VAR_AA
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF79+1
STA MOVBSELF79+2
LDA #$20
MOVBSELF79:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_AA
LDY #>VAR_AA
JSR INTADDPOKE
STY MOVBSELF80+1
STA MOVBSELF80+2
; Fast add for POKE(2)
;
;
;
;
LDA #$20
MOVBSELF80:
STA $FFFF
;
LINE_1210:
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
LDX #4
dcloop3057_1:
LDA CONST_121,X
STA VAR_G,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_122
LDY #>CONST_122
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
;
LINE_1220:
;
LDX #4
dcloop3057_2:
LDA CONST_123R,X
STA VAR_Z,X
DEX
BPL dcloop3057_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_124R
LDY #>CONST_124R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_125
LDY #>CONST_125
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z
LDY #>VAR_Z
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
LDA #<VAR_Z
LDY #>VAR_Z
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 54273
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
JMP RETURN
;
LINE_1230:
;
LDY #65
STY 54276
; Optimizer rule: Simple POKE/2
LDX #4
dcloop3057_3:
LDA CONST_127R,X
STA VAR_Z,X
DEX
BPL dcloop3057_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_128
LDY #>CONST_128
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z
LDY #>VAR_Z
STA A_REG
STY A_REG+1
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
LDA #<VAR_Z
LDY #>VAR_Z
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 54273
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_7
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_7:
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF85+1
STA MOVBSELF85+2
LDA #$20
MOVBSELF85:
STA $FFFF
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF86+1
STA MOVBSELF86+2
LDA #$20
MOVBSELF86:
STA $FFFF
LDA #<VAR_M
LDY #>VAR_M
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF87+1
STA MOVBSELF87+2
LDA #$20
MOVBSELF87:
STA $FFFF
;
LINE_1240:
;
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<CONST_129
LDY #>CONST_129
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_130R
LDY #>CONST_130R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_131
LDY #>CONST_131
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1250:
;
LDA #<CONST_132
LDY #>CONST_132
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<CONST_133
LDY #>CONST_133
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1270:
;
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ56
ROL
BCC LT_LT56
LT_LT_EQ56:
LDA #0
JMP LT_SKIP56
LT_LT56:
LDA #$1
LT_SKIP56:
COMP_SKP47:
BEQ LINE_SKIP108
; Simplified conditional branch
;
LINE_NSKIP108:
;
JMP LINE_1310
;
LINE_SKIP108:
;
;
LINE_1280:
;
LDA #<CONST_134
LDY #>CONST_134
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1290:
;
LDA #<CONST_135
LDY #>CONST_135
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1300:
;
LDA #<CONST_10R
LDY #>CONST_10R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_136
LDY #>CONST_136
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_1860
;
LINE_1310:
;
LDA #<CONST_137R
LDY #>CONST_137R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT57
LDA #0
JMP GT_SKIP57
GT_GT57:
LDA #$1
GT_SKIP57:
COMP_SKP48:
BEQ LINE_SKIP109
; Simplified conditional branch
;
LINE_NSKIP109:
;
LDA #<CONST_138
LDY #>CONST_138
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_1360
;
LINE_SKIP109:
;
;
LINE_1320:
;
LDA #<CONST_139R
LDY #>CONST_139R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT58
LDA #0
JMP GT_SKIP58
GT_GT58:
LDA #$1
GT_SKIP58:
COMP_SKP49:
BEQ LINE_SKIP110
; Simplified conditional branch
;
LINE_NSKIP110:
;
LDA #<CONST_140
LDY #>CONST_140
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_1360
;
LINE_SKIP110:
;
;
LINE_1330:
;
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT59
LDA #0
JMP GT_SKIP59
GT_GT59:
LDA #$1
GT_SKIP59:
COMP_SKP50:
BEQ LINE_SKIP111
; Simplified conditional branch
;
LINE_NSKIP111:
;
LDA #<CONST_141
LDY #>CONST_141
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_1360
;
LINE_SKIP111:
;
;
LINE_1340:
;
LDA #<CONST_142R
LDY #>CONST_142R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT60
LDA #0
JMP GT_SKIP60
GT_GT60:
LDA #$1
GT_SKIP60:
COMP_SKP51:
BEQ LINE_SKIP112
; Simplified conditional branch
;
LINE_NSKIP112:
;
LDA #<CONST_143
LDY #>CONST_143
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_1360
;
LINE_SKIP112:
;
;
LINE_1350:
;
LDA #<CONST_144
LDY #>CONST_144
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1360:
;
LDA VAR_MO
BEQ EQ_EQ61
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP61
EQ_EQ61:
LDA #$1
EQ_SKIP61:
COMP_SKP52:
BNE LINE_NSKIP113
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP113
;
LINE_NSKIP113:
;
LDX #4
dcloop3389_1:
LDA CONST_55R,X
STA VAR_I,X
DEX
BPL dcloop3389_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_145R
LDY #>CONST_145R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP8
STA JUMP_TARGET
LDA #>FORLOOP8
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP8:
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D$
LDY #>VAR_D$
JSR COPYSTRING
LDA #<CONST_60
LDY #>CONST_60
STA B_REG
STY B_REG+1
LDA VAR_D$
LDY VAR_D$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP53:
BEQ LINE_SKIP114
; Simplified conditional branch
;
LINE_NSKIP114:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_8
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_8:
JSR RUN
;
LINE_SKIP114:
;
;
LINE_SKIP113:
;
;
LINE_1365:
;
LDA VAR_MO
BEQ EQ_SKIP62
EQ_EQ62:
JMP LINE_SKIP115
EQ_SKIP62:
COMP_SKP55:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP115:
;
LDX #4
dcloop3389_2:
LDA CONST_55R,X
STA VAR_MO,X
DEX
BPL dcloop3389_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_90
;
LINE_SKIP115:
;
;
LINE_1370:
;
LDA #<CONST_146
LDY #>CONST_146
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR GOSUB
JSR LINE_60000
;
LINE_1390:
;
JSR COMPACTMAX
LDA #<CONST_147
LDY #>CONST_147
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA VAR_IN$
LDY VAR_IN$+1
STA B_REG
STY B_REG+1
LDY #1
JSR LEFTCONST
; Optimized code for LEFT/RIGHT
;
;
;
;
;
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP56:
BEQ LINE_SKIP116
; Simplified conditional branch
;
LINE_NSKIP116:
;
JSR RUN
;
LINE_SKIP116:
;
;
LINE_1400:
;
JSR LINEBREAK
;
LINE_1500:
;
LDA VAR_MO
BEQ EQ_SKIP63
EQ_EQ63:
JMP LINE_SKIP117
EQ_SKIP63:
COMP_SKP57:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP117:
;
LDX #4
dcloop3389_3:
LDA CONST_55R,X
STA VAR_D,X
DEX
BPL dcloop3389_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_148
LDY #>CONST_148
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_IN$
LDY #>VAR_IN$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JMP LINE_1840
;
LINE_SKIP117:
;
;
LINE_1510:
;
LDA #0
STA VAR_D
STA VAR_D+1
STA VAR_D+2
STA VAR_D+3
STA VAR_D+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_149
LDY #>CONST_149
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR GOSUB
JSR LINE_60000
;
LINE_1520:
;
;
LINE_1530:
;
JSR COMPACTMAX
LDA #<CONST_150
LDY #>CONST_150
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA VAR_IN$
LDY VAR_IN$+1
STA B_REG
STY B_REG+1
LDY #1
JSR LEFTCONST
; Optimized code for LEFT/RIGHT
;
;
;
;
;
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP58:
BEQ LINE_SKIP118
; Simplified conditional branch
;
LINE_NSKIP118:
;
LDX #4
dcloop3389_4:
LDA CONST_55R,X
STA VAR_D,X
DEX
BPL dcloop3389_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP118:
;
;
LINE_1540:
;
JMP LINE_1820
;
LINE_1740:
;
LDA #<CONST_122
LDY #>CONST_122
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_O
LDY #>VAR_O
; FAC to (X/Y)
JSR FACMEM
LDY #255
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF91+1
STA MOVBSELF91+2
LDA #$20
MOVBSELF91:
STA $FFFF
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_S
LDY #>VAR_S
; FAC to (X/Y)
JSR FACMEM
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<CONST_151
LDY #>CONST_151
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ64
ROL
BCC LT_LT64
LT_LT_EQ64:
LDA #0
JMP LT_SKIP64
LT_LT64:
LDA #$1
LT_SKIP64:
COMP_SKP59:
BEQ LINE_SKIP119
; Simplified conditional branch
;
LINE_NSKIP119:
;
LDA #<CONST_74R
LDY #>CONST_74R
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP119:
;
;
LINE_1745:
;
LDA VAR_MO
BEQ EQ_EQ65
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP65
EQ_EQ65:
LDA #$1
EQ_SKIP65:
COMP_SKP60:
BNE LINE_NSKIP120
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP120
;
LINE_NSKIP120:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #3
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
LDY #2
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_65R
LDY #>CONST_65R
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
LDX #<VAR_FC
LDY #>VAR_FC
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_FT
LDY #>VAR_FT
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_FT
LDY #>VAR_FT
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP120:
;
;
LINE_1750:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_G
LDY #>VAR_G
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_152
LDY #>CONST_152
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ66
ROL
BCC LT_LT66
LT_LT_EQ66:
LDA #0
JMP LT_SKIP66
LT_LT66:
LDA #$1
LT_SKIP66:
COMP_SKP61:
BEQ LINE_SKIP121
; Simplified conditional branch
;
LINE_NSKIP121:
;
LDA #<CONST_153R
LDY #>CONST_153R
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP121:
;
;
LINE_1760:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ67
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP67
EQ_EQ67:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP67:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_154
LDY #>CONST_154
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ68
ROL
BCC LT_LT68
LT_LT_EQ68:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP68
LT_LT68:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP68:
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
COMP_SKP62:
BEQ LINE_SKIP122
; Simplified conditional branch
;
LINE_NSKIP122:
;
LDX #4
dcloop3721_1:
LDA CONST_16,X
STA VAR_G,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_500
;
LINE_SKIP122:
;
;
LINE_1770:
;
LDA #<CONST_15
LDY #>CONST_15
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ69
ROL
BCC LT_LT69
LT_LT_EQ69:
LDA #0
JMP LT_SKIP69
LT_LT69:
LDA #$1
LT_SKIP69:
COMP_SKP63:
BEQ LINE_SKIP123
; Simplified conditional branch
;
LINE_NSKIP123:
;
JMP LINE_1810
;
LINE_SKIP123:
;
;
LINE_1780:
;
LDA #<CONST_14
LDY #>CONST_14
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ70
ROL
BCC LT_LT70
LT_LT_EQ70:
LDA #0
JMP LT_SKIP70
LT_LT70:
LDA #$1
LT_SKIP70:
COMP_SKP64:
BEQ LINE_SKIP124
; Simplified conditional branch
;
LINE_NSKIP124:
;
JMP LINE_1800
;
LINE_SKIP124:
;
;
LINE_1790:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
LDY #240
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF95+1
STA MOVBSELF95+2
LDA #$1
MOVBSELF95:
STA $FFFF
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF96+1
STA MOVBSELF96+2
LDA #$2A
MOVBSELF96:
STA $FFFF
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
JMP LINE_500
;
LINE_1800:
;
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
LDY #248
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF100+1
STA MOVBSELF100+2
LDA #$1
MOVBSELF100:
STA $FFFF
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF101+1
STA MOVBSELF101+2
LDA #$2A
MOVBSELF101:
STA $FFFF
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
JMP LINE_500
;
LINE_1810:
;
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
LDY #255
STY 54273
; Optimizer rule: Simple POKE/2
LDY #33
STY 54276
; Optimizer rule: Simple POKE/2
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<CONST_98
LDY #>CONST_98
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF105+1
STA MOVBSELF105+2
LDA #$1
MOVBSELF105:
STA $FFFF
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF106+1
STA MOVBSELF106+2
LDA #$2A
MOVBSELF106:
STA $FFFF
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
JMP LINE_500
;
LINE_1820:
;
LDA #<CONST_155
LDY #>CONST_155
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1830:
;
JSR GOSUB
JSR LINE_60000
;
LINE_1835:
;
LDA VAR_IN$
LDY VAR_IN$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
LDX #<VAR_T
LDY #>VAR_T
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT71
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP71
GT_GT71:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP71:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ72
ROL
BCC LT_LT72
LT_LT_EQ72:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP72
LT_LT72:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP72:
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
COMP_SKP65:
BEQ LINE_SKIP125
; Simplified conditional branch
;
LINE_NSKIP125:
;
JMP LINE_1820
;
LINE_SKIP125:
;
;
LINE_1840:
;
LDA VAR_IN$
LDY VAR_IN$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
LDX #<VAR_T
LDY #>VAR_T
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #1
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_68R
LDY #>CONST_68R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
;
LINE_1850:
;
JMP LINE_140
;
LINE_1860:
;
LDY #65
STY 54276
; Optimizer rule: Simple POKE/2
LDX #4
dcloop4053_1:
LDA CONST_55R,X
STA VAR_Z,X
DEX
BPL dcloop4053_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_73R
LDY #>CONST_73R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z
LDY #>VAR_Z
STA A_REG
STY A_REG+1
LDA #<FORLOOP9
STA JUMP_TARGET
LDA #>FORLOOP9
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP9:
LDX #4
dcloop4053_2:
LDA CONST_5R,X
STA VAR_X,X
DEX
BPL dcloop4053_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_156R
LDY #>CONST_156R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP10
STA JUMP_TARGET
LDA #>FORLOOP10
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP10:
LDA #<VAR_X
LDY #>VAR_X
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 54273
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
LDX #4
dcloop4053_3:
LDA CONST_157R,X
STA VAR_X,X
DEX
BPL dcloop4053_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_158R
LDY #>CONST_158R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP11
STA JUMP_TARGET
LDA #>FORLOOP11
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP11:
LDA #<VAR_X
LDY #>VAR_X
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 54273
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
LINE_1870:
;
LDX #4
dcloop4053_4:
LDA CONST_123R,X
STA VAR_X,X
DEX
BPL dcloop4053_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_124R
LDY #>CONST_124R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_159
LDY #>CONST_159
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP12
STA JUMP_TARGET
LDA #>FORLOOP12
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP12:
LDA #<VAR_X
LDY #>VAR_X
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 54273
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_11
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_11:
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_12
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_12:
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
JMP LINE_1360
;
LINE_1880:
;
JSR END
RTS
;
LINE_60000:
;
LDY #0
STY 198
; Optimizer rule: Simple POKE/2
LDA #<CONST_160
LDY #>CONST_160
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_IN$
LDY #>VAR_IN$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
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
dcloop4053_5:
LDA VAR_TI,X
STA VAR_ZT,X
LDA CONST_74R,X
STA VAR_ZC,X
DEX
BPL dcloop4053_5
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_60010:
;
LDX #4
dcloop4053_7:
LDA CONST_55R,X
STA VAR_I,X
DEX
BPL dcloop4053_7
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_161R
LDY #>CONST_161R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP13
STA JUMP_TARGET
LDA #>FORLOOP13
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP13:
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
LDA #<CONST_60
LDY #>CONST_60
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP70:
BEQ LINE_SKIP126
; Simplified conditional branch
;
LINE_NSKIP126:
;
JMP LINE_60070
;
LINE_SKIP126:
;
;
LINE_60020:
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
LDA #<VAR_TI
LDY #>VAR_TI
JSR REALFAC
LDA #<VAR_ZT
LDY #>VAR_ZT
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ73
BEQ LTEQ_LTEQ73
LDA #0
JMP LTEQ_SKIP73
LTEQ_LTEQ73:
LDA #$1
LTEQ_SKIP73:
COMP_SKP71:
BNE LINE_NSKIP127
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP127
;
LINE_NSKIP127:
;
JSR COMPACTMAX
LDA #<VAR_ZC
LDY #>VAR_ZC
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_162
LDY #>CONST_162
STA B_REG
STY B_REG+1
LDY #1
JSR MIDCONST
; Optimized code for MID(1)
;
;
;
;
;
;
;
JSR STROUT
LDA #<CONST_163
LDY #>CONST_163
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_ZC
LDY #>VAR_ZC
JSR REALFAC
LDA #<CONST_1R
LDY #>CONST_1R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ZC
LDY #>VAR_ZC
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
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
LDA #<VAR_TI
LDY #>VAR_TI
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ZT
LDY #>VAR_ZT
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP127:
;
;
LINE_60030:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_13
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_13:
JSR RUN
;
LINE_60070:
;
LDA VAR_Z$
LDY VAR_Z$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR ASC
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDA VAR_IN$
LDY VAR_IN$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
LDX #<VAR_ZL
LDY #>VAR_ZL
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<CONST_164R
LDY #>CONST_164R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ74
ROL
BCC LT_LT74
LT_LT_EQ74:
LDA #0
JMP LT_SKIP74
LT_LT74:
LDA #$1
LT_SKIP74:
COMP_SKP73:
BEQ LINE_SKIP128
; Simplified conditional branch
;
LINE_NSKIP128:
;
LDA #<CONST_165
LDY #>CONST_165
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_60110
;
LINE_SKIP128:
;
;
LINE_60080:
;
LDA #<CONST_164R
LDY #>CONST_164R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_166R
LDY #>CONST_166R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ75
ROL
BCC LT_LT75
LT_LT_EQ75:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP75
LT_LT75:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP75:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_164R
LDY #>CONST_164R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_167R
LDY #>CONST_167R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT76
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP76
GT_GT76:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP76:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_FL
LDY #>VAR_FL
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
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
COMP_SKP74:
BNE LINE_NSKIP129
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP129
;
LINE_NSKIP129:
;
JSR COMPACTMAX
LDA #<CONST_168R
LDY #>CONST_168R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_54R
LDY #>CONST_54R
JSR MEMARG
JSR FASTAND
; Optimizer rule: Swap AND order/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR CHRFAC2
; Optimizer rule: CHR value already in FAC/1
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
;
LINE_SKIP129:
;
;
LINE_60090:
;
LDA #<CONST_74R
LDY #>CONST_74R
JSR REALFAC
LDA #<VAR_ZL
LDY #>VAR_ZL
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT77
LDA #0
JMP GT_SKIP77
GT_GT77:
LDA #$1
GT_SKIP77:
COMP_SKP75:
BEQ LINE_SKIP130
; Simplified conditional branch
;
LINE_NSKIP130:
;
JMP LINE_60010
;
LINE_SKIP130:
;
;
LINE_60100:
;
JSR COMPACTMAX
LDA VAR_Z$
LDY VAR_Z$+1
STA B_REG
STY B_REG+1
LDA VAR_IN$
LDY VAR_IN$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_IN$
LDY #>VAR_IN$
JSR COPYSTRING
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_60110:
;
LDA #<CONST_169R
LDY #>CONST_169R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ78
LDA #0
JMP EQ_SKIP78
EQ_EQ78:
LDA #$1
EQ_SKIP78:
COMP_SKP76:
BNE LINE_NSKIP131
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP131
;
LINE_NSKIP131:
;
JSR COMPACTMAX
LDA #<CONST_74R
LDY #>CONST_74R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA VAR_IN$
LDY VAR_IN$+1
STA B_REG
STY B_REG+1
JSR MIDNEGC
; Optimized code for MID(1)
;
;
;
;
;
;
;
;
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_IN$
LDY #>VAR_IN$
JSR COPYSTRING
JSR LINEBREAK
JMP RETURN
;
LINE_SKIP131:
;
;
LINE_60120:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ZL
LDY #>VAR_ZL
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT79
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP79
GT_GT79:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP79:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ80
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP80
EQ_EQ80:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP80:
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
COMP_SKP77:
BNE LINE_NSKIP132
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP132
;
LINE_NSKIP132:
;
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ZL
LDY #>VAR_ZL
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
; ignored: CHGCTX #1
LDA VAR_IN$
LDY VAR_IN$+1
STA B_REG
STY B_REG+1
JSR LEFT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_IN$
LDY #>VAR_IN$
JSR COPYSTRING
LDA #<CONST_163
LDY #>CONST_163
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_60010
;
LINE_SKIP132:
;
;
LINE_60130:
;
LDA #<CONST_171R
LDY #>CONST_171R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ81
LDA #0
JMP EQ_SKIP81
EQ_EQ81:
LDA #$1
EQ_SKIP81:
COMP_SKP78:
BNE LINE_NSKIP133
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP133
;
LINE_NSKIP133:
;
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ZL
LDY #>VAR_ZL
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT82
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP82
GT_GT82:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP82:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_172
LDY #>CONST_172
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR CHRFAC2
; Optimizer rule: CHR value already in FAC/1
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
LDX #4
dcloop4551_1:
LDA CONST_74R,X
STA VAR_Z,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_ZL
LDY #>VAR_ZL
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z
LDY #>VAR_Z
STA A_REG
STY A_REG+1
LDA #<FORLOOP14
STA JUMP_TARGET
LDA #>FORLOOP14
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP14:
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_Z
LDY #>VAR_Z
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_14
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_14:
JMP LINE_60000
;
LINE_SKIP133:
;
;
LINE_60140:
;
JMP LINE_60010
;
LINE_60200:
;
JSR GOSUB
JSR LINE_60500
;
LINE_60210:
;
LDA #<CONST_173
LDY #>CONST_173
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_60240:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_174R
LDY #>CONST_174R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP15
STA JUMP_TARGET
LDA #>FORLOOP15
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP15:
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_T$
LDY #>VAR_T$
JSR COPYSTRING
LDA #<CONST_60
LDY #>CONST_60
STA B_REG
STY B_REG+1
LDA VAR_T$
LDY VAR_T$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP80:
BEQ LINE_SKIP134
; Simplified conditional branch
;
LINE_NSKIP134:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_15
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_15:
JSR RUN
;
LINE_SKIP134:
;
;
LINE_60250:
;
LDA #<CONST_175
LDY #>CONST_175
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_100
;
LINE_60260:
;
LDA #<CONST_176
LDY #>CONST_176
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_60265:
;
JSR GOSUB
JSR LINE_60500
;
LINE_60270:
;
JMP RETURN
;
LINE_60500:
;
LDX #4
dcloop4551_2:
LDA CONST_55R,X
STA VAR_I,X
DEX
BPL dcloop4551_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_142R
LDY #>CONST_142R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP16
STA JUMP_TARGET
LDA #>FORLOOP16
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP16:
LDA #<CONST_177
LDY #>CONST_177
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_16
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_16:
JMP RETURN
;
LINE_62000:
;
LDA #<CONST_178
LDY #>CONST_178
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_179
LDY #>CONST_179
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62010:
;
LDA #<CONST_180
LDY #>CONST_180
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62011:
;
LDA #<CONST_181
LDY #>CONST_181
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62020:
;
JSR GOSUB
JSR LINE_60500
;
LINE_62030:
;
LDA #<CONST_182
LDY #>CONST_182
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62040:
;
LDA VAR_MO
BEQ EQ_EQ83
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP83
EQ_EQ83:
LDA #$1
EQ_SKIP83:
COMP_SKP83:
BNE LINE_NSKIP135
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP135
;
LINE_NSKIP135:
;
LDX #4
dcloop4717_1:
LDA CONST_55R,X
STA VAR_I,X
DEX
BPL dcloop4717_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_161R
LDY #>CONST_161R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_55R
;LDY #>CONST_55R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP17
STA JUMP_TARGET
LDA #>FORLOOP17
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP17:
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
LDA #<CONST_60
LDY #>CONST_60
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP84:
BEQ LINE_SKIP136
; Simplified conditional branch
;
LINE_NSKIP136:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_17
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_17:
JMP LINE_100
;
LINE_SKIP136:
;
;
LINE_SKIP135:
;
;
LINE_62050:
;
LDX #4
dcloop4717_2:
LDA CONST_55R,X
STA VAR_MO,X
DEX
BPL dcloop4717_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_62080:
;
LDA #<CONST_183
LDY #>CONST_183
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR GOSUB
JSR LINE_60000
;
LINE_62090:
;
JSR COMPACTMAX
LDA #<CONST_150
LDY #>CONST_150
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA VAR_IN$
LDY VAR_IN$+1
STA B_REG
STY B_REG+1
LDY #1
JSR LEFTCONST
; Optimized code for LEFT/RIGHT
;
;
;
;
;
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP86:
BEQ LINE_SKIP137
; Simplified conditional branch
;
LINE_NSKIP137:
;
JMP LINE_100
;
LINE_SKIP137:
;
;
LINE_62100:
;
LDA #<CONST_184
LDY #>CONST_184
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62105:
;
JSR GOSUB
JSR LINE_60500
;
LINE_62110:
;
LDA #<CONST_185
LDY #>CONST_185
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62120:
;
LDA #<CONST_186
LDY #>CONST_186
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62130:
;
LDA #<CONST_187
LDY #>CONST_187
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62140:
;
LDA #<CONST_188
LDY #>CONST_188
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62150:
;
LDA #<CONST_189
LDY #>CONST_189
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62160:
;
LDA #<CONST_190
LDY #>CONST_190
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62170:
;
LDA #<CONST_191
LDY #>CONST_191
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62180:
;
LDA #<CONST_192
LDY #>CONST_192
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62190:
;
LDA #<CONST_193
LDY #>CONST_193
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_62200:
;
JSR GOSUB
JSR LINE_60200
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
LEFTCONSTA	CMP #0
BEQ LEFTCONST
LDY #$FF
LEFTCONST	JSR STRFUNCINTINT
JMP LEFT2
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
STRFUNCINTINT
LDA B_REG			;the source string
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
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
INTOUT		JMP REALOUT
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
INTSUBOPT16X
INTSUB16X	SEC
TAX
TYA
SBC TMP4_REG
STA TMP4_REG
TXA
SBC TMP4_REG+1
STA TMP4_REG+1
LDY TMP4_REG
RTS
;###################################
;###################################
INTADD16 	CLC
TAX
TYA
ADC TMP4_REG
STA TMP4_REG
TXA
ADC TMP4_REG+1
STA TMP4_REG+1
RTS
;###################################
;###################################
INTADDOPT16X
INTADD16X	JSR INTADD16
LDY TMP4_REG
LDA TMP4_REG+1
RTS
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
INTADDPOKE	JSR REALFAC
JSR FACWORD
TAX
TYA
CLC
ADC TMP_ZP
TAY
TXA
ADC TMP_ZP+1
RTS
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
STA VAR_CR,Y
STA VAR_MO,Y
STA VAR_F,Y
STA VAR_FC,Y
STA VAR_P,Y
STA VAR_C,Y
STA VAR_M,Y
STA VAR_K,Y
STA VAR_L,Y
STA VAR_I,Y
STA VAR_J,Y
STA VAR_Y,Y
STA VAR_CC,Y
STA VAR_DD,Y
STA VAR_EE,Y
STA VAR_FF,Y
STA VAR_G,Y
STA VAR_E,Y
STA VAR_O,Y
STA VAR_X,Y
STA VAR_T,Y
STA VAR_FT,Y
STA VAR_D,Y
STA VAR_A,Y
STA VAR_B,Y
STA VAR_AA,Y
STA VAR_Z,Y
STA VAR_N,Y
STA VAR_AC,Y
STA VAR_S,Y
STA VAR_TI,Y
STA VAR_ZT,Y
STA VAR_ZC,Y
STA VAR_ZL,Y
STA VAR_FL,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
STA VAR_D%
STA VAR_D%+1
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #21


; CONST: #3

CONST_1R	.REAL 3.0
; CONST: #0

CONST_2R	.REAL 0.0
; CONST: #1024

CONST_3R	.REAL 1024.0
; CONST: #42

CONST_4R	.REAL 42.0
; CONST: #20

CONST_5R	.REAL 20.0
; CONST: #9

CONST_6R	.REAL 9.0
; CONST: #1566.0

CONST_7	.REAL 1566.0
; CONST: #32

CONST_8R	.REAL 32.0
; CONST: #15

CONST_9R	.REAL 15.0
; CONST: #8

CONST_10R	.REAL 8.0
; CONST: #240

CONST_11R	.REAL 240.0
; CONST: #1166.0

CONST_12	.REAL 1166.0
; CONST: #1726.0

CONST_13	.REAL 1726.0
; CONST: #1526.0

CONST_14	.REAL 1526.0
; CONST: #1326.0

CONST_15	.REAL 1326.0
; CONST: #1814.0

CONST_16	.REAL 1814.0
; CONST: ${clear}{light green}
CONST_17	.BYTE 20
.STRG "{clear}{light green}"
; CONST: #500

CONST_18R	.REAL 500.0
; CONST: #1063.0

CONST_19	.REAL 1063.0
; CONST: ${home}{down*13}
CONST_20	.BYTE 15
.STRG "{home}{down*13}"
; CONST: #35

CONST_21R	.REAL 35.0
; CONST: ${orange}{sh -}
CONST_22	.BYTE 14
.STRG "{orange}{sh -}"
; CONST: #33

CONST_23R	.REAL 33.0
; CONST: ${orange}{sh -} {reverse on} {reverse off}
CONST_24	.BYTE 41
.STRG "{orange}{sh -} {reverse on} {reverse off}"
; CONST: ${orange}{reverse on} {reverse off} {reverse on} {reverse off} {sh -}
CONST_25	.BYTE 68
.STRG "{orange}{reverse on} {reverse off} {reverse on} {reverse off} {sh -}"
; CONST: ${orange}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}
CONST_26	.BYTE 88
.STRG "{orange}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}"
; CONST: ${brown} {cm @*13}
CONST_27	.BYTE 17
.STRG "{brown} {cm @*13}"
; CONST: #19

CONST_28R	.REAL 19.0
; CONST: ${orange}{reverse on} {reverse off} {sh -} {reverse on} {reverse off}
CONST_29	.BYTE 68
.STRG "{orange}{reverse on} {reverse off} {sh -} {reverse on} {reverse off}"
; CONST: ${brown}{reverse on}{sh pound}{cm t}{space*11}NL{reverse off}
CONST_30	.BYTE 60
.STRG "{brown}{reverse on}{sh pound}{cm t}{space*11}NL{reverse off}"
; CONST: #18

CONST_31R	.REAL 18.0
; CONST: ${orange}{sh -} {sh -} {reverse on} {reverse off}
CONST_32	.BYTE 48
.STRG "{orange}{sh -} {sh -} {reverse on} {reverse off}"
; CONST: ${brown}{reverse on}{sh asterisk}OPEOPM{cm r}OEDO{cm t}{cm g*2}{reverse off}L{green}{cm p}{cm o}{cm i}{reverse on}{cm u}{cm y}{cm t*4}{cm y*2}{cm u*2}{reverse off}{cm i}{cm o*2}{cm p}{orange}{sh -}{green}{cm p}{orange}{sh -}{green}{cm p}{orange}{sh -}{green}{cm @*2}
CONST_33	.BYTE 265
.STRG "{brown}{reverse on}{sh asterisk}OPEOPM{cm r}OEDO{cm t}{cm g*2}{reverse off}L{green}{cm p}{cm o}{cm i}{reverse on}{cm u}{cm y}{cm t*4}{cm y*2}{cm u*2}{reverse off}{cm i}{cm o*2}{cm p}{orange}{sh -}{green}{cm p}{orange}{sh -}{green}{cm p}{orange}{sh -}{green}{cm @*2}"
; CONST: ${brown}{reverse on}{cm g*2}{cm m} {cm g}{cm m} {sh -}{cm g}{space*2}{cm g} {cm g}{cm m*2}{light blue}{space*17}{reverse off}{orange}{sh -}{reverse on}{light blue} {reverse off}{orange}{sh -}{reverse on}{light blue} {reverse off}{orange}{sh -}{reverse on}{light blue}{space*2}
CONST_34	.BYTE 275
.STRG "{brown}{reverse on}{cm g*2}{cm m} {cm g}{cm m} {sh -}{cm g}{space*2}{cm g} {cm g}{cm m*2}{light blue}{space*17}{reverse off}{orange}{sh -}{reverse on}{light blue} {reverse off}{orange}{sh -}{reverse on}{light blue} {reverse off}{orange}{sh -}{reverse on}{light blue}{space*2}"
; CONST: ${brown}{reverse on}{cm g*2}{space*2}{cm g}{cm m} {sh -}{space*3}{cm g} {cm g}{cm m*2}{light blue}{space*19}{reverse off}{orange}{sh -}{reverse on}{light blue}{space*4}
CONST_35	.BYTE 167
.STRG "{brown}{reverse on}{cm g*2}{space*2}{cm g}{cm m} {sh -}{space*3}{cm g} {cm g}{cm m*2}{light blue}{space*19}{reverse off}{orange}{sh -}{reverse on}{light blue}{space*4}"
; CONST: ${light blue}{space*2}{brown}{reverse off}{cm asterisk}{reverse on} {cm g}{cm m} {cm @}{cm o}{cm @} {reverse off}{sh pound}{reverse on}{light blue}{space*4}{reverse off}
CONST_36	.BYTE 168
.STRG "{light blue}{space*2}{brown}{reverse off}{cm asterisk}{reverse on} {cm g}{cm m} {cm @}{cm o}{cm @} {reverse off}{sh pound}{reverse on}{light blue}{space*4}{reverse off}"
; CONST: ${reverse on}{light blue}{space*24}{light green}
CONST_37	.BYTE 47
.STRG "{reverse on}{light blue}{space*24}{light green}"
; CONST: ${reverse on}{light blue}{space*13}hit 'q' to end{space*4}skill
CONST_38	.BYTE 62
.STRG "{reverse on}{light blue}{space*13}hit 'q' to end{space*4}skill"
; CONST: ${left} {left*3} {reverse off}{light green}
CONST_39	.BYTE 42
.STRG "{left} {left*3} {reverse off}{light green}"
; CONST: ${reverse on}{light blue}{space*13}frog!{space*2}hit a key to play{space*2}{light green}
CONST_40	.BYTE 87
.STRG "{reverse on}{light blue}{space*13}frog!{space*2}hit a key to play{space*2}{light green}"
; CONST: #160


; CONST: #14


; CONST: ${reverse off}{light green}{home}{down*8}{right}{space*11}
CONST_43	.BYTE 57
.STRG "{reverse off}{light green}{home}{down*8}{right}{space*11}"
; CONST: ${right}{space*11}
CONST_44	.BYTE 17
.STRG "{right}{space*11}"
; CONST: ${right}{space*4}{cm @}{cm p}{cm o}{cm p}{space*3}
CONST_45	.BYTE 49
.STRG "{right}{space*4}{cm @}{cm p}{cm o}{cm p}{space*3}"
; CONST: ${right}{space*3}{reverse on}{sh pound}{space*2}(q{cm asterisk}{reverse off}
CONST_46	.BYTE 76
.STRG "{right}{space*3}{reverse on}{sh pound}{space*2}(q{cm asterisk}{reverse off} "
; CONST: ${right}{space*2}{reverse on}{sh pound}{space*4}' U
CONST_47	.BYTE 50
.STRG "{right}{space*2}{reverse on}{sh pound}{space*4}' U"
; CONST: ${right} {reverse on}{sh pound}{cm @*4} ) {reverse off}{sh pound}
CONST_48	.BYTE 64
.STRG "{right} {reverse on}{sh pound}{cm @*4} ) {reverse off}{sh pound}"
; CONST: ${right}{reverse on}{sh pound}N{space*2}, M {reverse off}{sh pound}
CONST_49	.BYTE 66
.STRG "{right}{reverse on}{sh pound}N{space*2}, M {reverse off}{sh pound}"
; CONST: ${right}{reverse on}NN{cm t*2}{space*2}N{cm n}
CONST_50	.BYTE 45
.STRG "{right}{reverse on}NN{cm t*2}{space*2}N{cm n}"
; CONST: ${right}{cm asterisk}{reverse on}{cm g}('{cm t*4}{cm asterisk}
CONST_51	.BYTE 61
.STRG "{right}{cm asterisk}{reverse on}{cm g}('{cm t*4}{cm asterisk}"
; CONST: ${right*2}{cm y}{cm u*3}{cm asterisk}{reverse on}MMM{cm asterisk}
CONST_52	.BYTE 64
.STRG "{right*2}{cm y}{cm u*3}{cm asterisk}{reverse on}MMM{cm asterisk}"
; CONST: ${cm y}{cm u}{home}
CONST_53	.BYTE 18
.STRG "{cm y}{cm u}{home}"
; CONST: #255

CONST_54R	.REAL 255.0
; CONST: #1

MOSTCOMMON
CONST_55R	.REAL 1.0
; CONST: ${purple}{home}{down}{right}
CONST_56	.BYTE 27
.STRG "{purple}{home}{down}{right}"
; CONST: ${left} calories
CONST_57	.BYTE 16
.STRG "{left} calories "
; CONST: #29

CONST_58R	.REAL 29.0
; CONST: $ bugs
CONST_59	.BYTE 5
.STRG " bugs"
; CONST: $
CONST_60	.BYTE 0
.STRG ""
; CONST: #1287.0

CONST_61	.REAL 1287.0
; CONST: #1284.0

CONST_62	.REAL 1284.0
; CONST: #1447.0

CONST_63	.REAL 1447.0
; CONST: #1444.0

CONST_64	.REAL 1444.0
; CONST: #6

CONST_65R	.REAL 6.0
; CONST: #1607.0

CONST_66	.REAL 1607.0
; CONST: #1604.0

CONST_67	.REAL 1604.0
; CONST: #4

CONST_68R	.REAL 4.0
; CONST: #1374.0

CONST_69	.REAL 1374.0
; CONST: #1584.0

CONST_70	.REAL 1584.0
; CONST: $q
CONST_71	.BYTE 1
.STRG "q"
; CONST: #7

CONST_72R	.REAL 7.0
; CONST: #5

CONST_73R	.REAL 5.0
; CONST: #2

CONST_74R	.REAL 2.0
; CONST: #12

CONST_75R	.REAL 12.0
; CONST: ${home}{down*14}{right*11}
CONST_76	.BYTE 25
.STRG "{home}{down*14}{right*11}"
; CONST: ${pink}CI{left}
CONST_77	.BYTE 14
.STRG "{pink}CI{left}"
; CONST: #1596.0

CONST_78	.REAL 1596.0
; CONST: #42.0


; CONST: ${pink}{left}K {left*2}
CONST_80	.BYTE 22
.STRG "{pink}{left}K {left*2}"
; CONST: ${home}{down*10}{right*11}
CONST_81	.BYTE 25
.STRG "{home}{down*10}{right*11}"
; CONST: ${pink}{sh asterisk}I{left}
CONST_82	.BYTE 26
.STRG "{pink}{sh asterisk}I{left}"
; CONST: #1436.0

CONST_83	.REAL 1436.0
; CONST: ${home}{down*6}{right*11}
CONST_84	.BYTE 24
.STRG "{home}{down*6}{right*11}"
; CONST: #1276.0

CONST_85	.REAL 1276.0
; CONST: ${left}K {left*2}
CONST_86	.BYTE 16
.STRG "{left}K {left*2}"
; CONST: #1486.0

CONST_87	.REAL 1486.0
; CONST: #1446.0

CONST_88	.REAL 1446.0
; CONST: #95

CONST_89R	.REAL 95.0
; CONST: #0.1126

CONST_90	.REAL 0.1126
; CONST: #41

CONST_91R	.REAL 41.0
; CONST: #40

CONST_92R	.REAL 40.0
; CONST: #0.2253

CONST_93	.REAL 0.2253
; CONST: #248


; CONST: #0.5379

CONST_95	.REAL 0.5379
; CONST: #39

CONST_96R	.REAL 39.0
; CONST: #17

CONST_97R	.REAL 17.0
; CONST: #55296.0

CONST_98	.REAL 55296.0
; CONST: #1024.0

CONST_99	.REAL 1024.0
; CONST: ${home}{light green}{down*4}{right}{space*11}
CONST_100	.BYTE 44
.STRG "{home}{light green}{down*4}{right}{space*11}"
; CONST: ${right}{space*2}{reverse on}{sh pound}{space*4}' U{reverse off}
CONST_101	.BYTE 63
.STRG "{right}{space*2}{reverse on}{sh pound}{space*4}' U{reverse off}"
; CONST: ${right} {reverse on}{sh pound}{space*5}) {reverse off}{sh pound}
CONST_102	.BYTE 64
.STRG "{right} {reverse on}{sh pound}{space*5}) {reverse off}{sh pound}"
; CONST: ${right}{reverse on}{sh pound}{space*7}{reverse off}{sh pound}
CONST_103	.BYTE 62
.STRG "{right}{reverse on}{sh pound}{space*7}{reverse off}{sh pound} "
; CONST: ${right}{reverse on}N{cm t*5}M {reverse off}{space*2}
CONST_104	.BYTE 52
.STRG "{right}{reverse on}N{cm t*5}M {reverse off}{space*2}"
; CONST: ${right}{cm asterisk}{reverse on}{space*4}, ){cm asterisk}{reverse off}
CONST_105	.BYTE 71
.STRG "{right}{cm asterisk}{reverse on}{space*4}, ){cm asterisk}{reverse off} "
; CONST: ${right}{space*2}{cm y}{cm u}{reverse on}N {reverse off}{sh pound} {cm asterisk}{reverse on}P{reverse off}
CONST_106	.BYTE 105
.STRG "{right}{space*2}{cm y}{cm u}{reverse on}N {reverse off}{sh pound} {cm asterisk}{reverse on}P{reverse off}"
; CONST: ${right}{space*3}{reverse on}{sh pound} {reverse off}{sh pound}{space*4}
CONST_107	.BYTE 71
.STRG "{right}{space*3}{reverse on}{sh pound} {reverse off}{sh pound}{space*4}"
; CONST: ${right}{space*2}{reverse on}{sh pound} {reverse off}{sh pound}{space*5}
CONST_108	.BYTE 71
.STRG "{right}{space*2}{reverse on}{sh pound} {reverse off}{sh pound}{space*5}"
; CONST: ${right}{space*2}{reverse on}('{cm t*4}{cm asterisk}{reverse off}
CONST_109	.BYTE 64
.STRG "{right}{space*2}{reverse on}('{cm t*4}{cm asterisk}{reverse off}"
; CONST: ${right*3}{cm u*3}{cm asterisk}{reverse on}MMM{cm asterisk}{reverse off}
CONST_110	.BYTE 71
.STRG "{right*3}{cm u*3}{cm asterisk}{reverse on}MMM{cm asterisk}{reverse off}"
; CONST: ${home}{light green}{down*4}{space*5}{cm @}{cm p}{cm o}{cm p}
CONST_111	.BYTE 60
.STRG "{home}{light green}{down*4}{space*5}{cm @}{cm p}{cm o}{cm p}"
; CONST: ${right}{space*3}{reverse on}{sh pound}{space*2}(q{cm asterisk}{reverse off}
CONST_112	.BYTE 75
.STRG "{right}{space*3}{reverse on}{sh pound}{space*2}(q{cm asterisk}{reverse off}"
; CONST: ${right}{reverse on} {cm t*2}M{space*4}{reverse off}{space*2}
CONST_113	.BYTE 60
.STRG "{right}{reverse on} {cm t*2}M{space*4}{reverse off}{space*2}"
; CONST: ${right}{cm asterisk}{reverse on}{space*3}M, ){cm asterisk}{reverse off}
CONST_114	.BYTE 72
.STRG "{right}{cm asterisk}{reverse on}{space*3}M, ){cm asterisk}{reverse off} "
; CONST: ${right} {cm asterisk}{reverse on}{space*2}({reverse off}{sh pound}{space*2}{cm asterisk}{reverse on}P
CONST_115	.BYTE 101
.STRG "{right} {cm asterisk}{reverse on}{space*2}({reverse off}{sh pound}{space*2}{cm asterisk}{reverse on}P"
; CONST: ${right}{space*2}{cm asterisk}{reverse on}{space*2}{cm asterisk}{reverse off}{space*4}
CONST_116	.BYTE 85
.STRG "{right}{space*2}{cm asterisk}{reverse on}{space*2}{cm asterisk}{reverse off}{space*4}"
; CONST: ${right}{space*3}{cm asterisk}{reverse on}{space*2}{cm asterisk}{reverse off}{space*3}
CONST_117	.BYTE 85
.STRG "{right}{space*3}{cm asterisk}{reverse on}{space*2}{cm asterisk}{reverse off}{space*3}"
; CONST: ${right}{space*4}{cm asterisk}{reverse on} ){reverse off}{space*3}
CONST_118	.BYTE 65
.STRG "{right}{space*4}{cm asterisk}{reverse on} ){reverse off}{space*3}"
; CONST: ${right}{space*4}{reverse on}{sh pound} {reverse off}{sh pound}{space*3}
CONST_119	.BYTE 71
.STRG "{right}{space*4}{reverse on}{sh pound} {reverse off}{sh pound}{space*3}"
; CONST: #170


; CONST: #1812.0

CONST_121	.REAL 1812.0
; CONST: #0.3

CONST_122	.REAL 0.3
; CONST: #200

CONST_123R	.REAL 200.0
; CONST: #100

CONST_124R	.REAL 100.0
; CONST: #-5.0

CONST_125	.REAL -5.0
; CONST: #65


; CONST: #63

CONST_127R	.REAL 63.0
; CONST: #-0.2

CONST_128	.REAL -0.2
; CONST: ${home}{down}
CONST_129	.BYTE 12
.STRG "{home}{down}"
; CONST: #37

CONST_130R	.REAL 37.0
; CONST: ${space*2}
CONST_131	.BYTE 9
.STRG "{space*2}"
; CONST: ${up}{right}you caught
CONST_132	.BYTE 21
.STRG "{up}{right}you caught"
; CONST: ${left} bugs!
CONST_133	.BYTE 12
.STRG "{left} bugs!"
; CONST: ${white}{down}{right}he flies, he leaps tall buildings,
CONST_134	.BYTE 54
.STRG "{white}{down}{right}he flies, he leaps tall buildings,"
; CONST: ${right}his tongue is magic - it's........
CONST_135	.BYTE 41
.STRG "{right}his tongue is magic - it's........"
; CONST: ${down}{yellow}{reverse on} suuuperrrfrog!!
CONST_136	.BYTE 43
.STRG "{down}{yellow}{reverse on} suuuperrrfrog!! "
; CONST: #30

CONST_137R	.REAL 30.0
; CONST: ${down}{right}{white}{space*2}bullroarer, king of the pond!!
CONST_138	.BYTE 59
.STRG "{down}{right}{white}{space*2}bullroarer, king of the pond!!"
; CONST: #25

CONST_139R	.REAL 25.0
; CONST: ${down}{right}{white}{space*2}a bullfrog, well fed!!
CONST_140	.BYTE 51
.STRG "{down}{right}{white}{space*2}a bullfrog, well fed!!"
; CONST: ${down}{right}{white}{space*2}a tree frog.
CONST_141	.BYTE 41
.STRG "{down}{right}{white}{space*2}a tree frog."
; CONST: #10

CONST_142R	.REAL 10.0
; CONST: ${down}{right}{white}{space*2}a tadpole.
CONST_143	.BYTE 39
.STRG "{down}{right}{white}{space*2}a tadpole."
; CONST: ${down}{right}{white}{space*2}you ought to eat vegetables!
CONST_144	.BYTE 57
.STRG "{down}{right}{white}{space*2}you ought to eat vegetables!"
; CONST: #1000

CONST_145R	.REAL 1000.0
; CONST: ${cyan}{down}{space*7}play again?{space*11}{left*10}
CONST_146	.BYTE 51
.STRG "{cyan}{down}{space*7}play again?{space*11}{left*10}"
; CONST: $n
CONST_147	.BYTE 1
.STRG "n"
; CONST: $5
CONST_148	.BYTE 1
.STRG "5"
; CONST: ${up*2}{space*7}do you want three bugs?{space*11}{left*10}
CONST_149	.BYTE 57
.STRG "{up*2}{space*7}do you want three bugs?{space*11}{left*10}"
; CONST: $y
CONST_150	.BYTE 1
.STRG "y"
; CONST: #0.5

CONST_151	.REAL 0.5
; CONST: #0.25

CONST_152	.REAL 0.25
; CONST: #78

CONST_153R	.REAL 78.0
; CONST: #1096.0

CONST_154	.REAL 1096.0
; CONST: ${up*2} please enter skill level (0 thru 9){space*5}{left*4}
CONST_155	.BYTE 59
.STRG "{up*2} please enter skill level (0 thru 9){space*5}{left*4}"
; CONST: #120

CONST_156R	.REAL 120.0
; CONST: #50

CONST_157R	.REAL 50.0
; CONST: #130

CONST_158R	.REAL 130.0
; CONST: #-0.5

CONST_159	.REAL -0.5
; CONST: $
CONST_160	.BYTE 1
.STRG " "
; CONST: #2000

CONST_161R	.REAL 2000.0
; CONST: $ {cm p}
CONST_162	.BYTE 7
.STRG " {cm p}"
; CONST: ${left}
CONST_163	.BYTE 6
.STRG "{left}"
; CONST: #127

CONST_164R	.REAL 127.0
; CONST: $ {left}
CONST_165	.BYTE 7
.STRG " {left}"
; CONST: #91

CONST_166R	.REAL 91.0
; CONST: #64

CONST_167R	.REAL 64.0
; CONST: #128

CONST_168R	.REAL 128.0
; CONST: #13

CONST_169R	.REAL 13.0
; CONST: #-1


; CONST: #141

CONST_171R	.REAL 141.0
; CONST: #-20.0

CONST_172	.REAL -20.0
; CONST: ${cyan}{space*9}press {reverse on}{purple} space {reverse off}{cyan} to begin
CONST_173	.BYTE 76
.STRG "{cyan}{space*9}press {reverse on}{purple} space {reverse off}{cyan} to begin"
; CONST: #3000

CONST_174R	.REAL 3000.0
; CONST: ${clear}{down*11}
CONST_175	.BYTE 16
.STRG "{clear}{down*11}"
; CONST: ${clear}{space*37}
CONST_176	.BYTE 17
.STRG "{clear}{space*37}"
; CONST: ${sh asterisk*4}
CONST_177	.BYTE 15
.STRG "{sh asterisk*4}"
; CONST: ${clear}{down*2}{cyan}{space*26}
CONST_178	.BYTE 31
.STRG "{clear}{down*2}{cyan}{space*26}"
; CONST: ${space*5}
CONST_179	.BYTE 9
.STRG "{space*5}"
; CONST: ${down}{pink}{space*35}{down}
CONST_180	.BYTE 28
.STRG "{down}{pink}{space*35}{down}"
; CONST: ${down}{white}{space*37}{light blue}{down}
CONST_181	.BYTE 41
.STRG "{down}{white}{space*37}{light blue}{down}"
; CONST: ${down}{light green}{space*9}>> back to nature <<
CONST_182	.BYTE 48
.STRG "{down}{light green}{space*9}>> back to nature <<"
; CONST: ${down*3}{yellow}{space*5}do you need the directions?{space*9}{left*8}
CONST_183	.BYTE 69
.STRG "{down*3}{yellow}{space*5}do you need the directions?{space*9}{left*8}"
; CONST: ${clear}{down}{cyan}{space*34}
CONST_184	.BYTE 29
.STRG "{clear}{down}{cyan}{space*34}"
; CONST: ${white} froggy needs bugs to live. you control
CONST_185	.BYTE 46
.STRG "{white} froggy needs bugs to live. you control"
; CONST: ${down*2}{right}his {yellow}tongue {white}.........{reverse on}{pink}short{reverse off} {reverse on}{white}medium{reverse off} {reverse on}{light blue}long
CONST_186	.BYTE 154
.STRG "{down*2}{right}his {yellow}tongue {white}.........{reverse on}{pink}short{reverse off} {reverse on}{white}medium{reverse off} {reverse on}{light blue}long"
; CONST: ${down}{white} and {purple}height {white}....{reverse on}{light green}high{reverse off}{space*3}{orange}7{space*5}8{space*5}9
CONST_187	.BYTE 124
.STRG "{down}{white} and {purple}height {white}....{reverse on}{light green}high{reverse off}{space*3}{orange}7{space*5}8{space*5}9"
; CONST: ${down}{white} with the{space*5}..{reverse on}{yellow}middle{reverse off} {orange}4{space*5}5{space*5}6
CONST_188	.BYTE 102
.STRG "{down}{white} with the{space*5}..{reverse on}{yellow}middle{reverse off} {orange}4{space*5}5{space*5}6"
; CONST: ${down}{white} number pad.{space*3}.{reverse on}{cyan}low{reverse off}{space*4}{orange}1{space*5}2{space*5}3
CONST_189	.BYTE 107
.STRG "{down}{white} number pad.{space*3}.{reverse on}{cyan}low{reverse off}{space*4}{orange}1{space*5}2{space*5}3"
; CONST: ${down*2}{white} the farther he has to reach, the more
CONST_190	.BYTE 53
.STRG "{down*2}{white} the farther he has to reach, the more"
; CONST: ${down} energy he uses.{space*2}a higher skill level
CONST_191	.BYTE 51
.STRG "{down} energy he uses.{space*2}a higher skill level"
; CONST: ${down} will cause a bug to move more quickly
CONST_192	.BYTE 44
.STRG "{down} will cause a bug to move more quickly"
; CONST: ${down} and the frog to consume more energy.{cyan}
CONST_193	.BYTE 49
.STRG "{down} and the frog to consume more energy.{cyan}"
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: CR
VAR_CR	.REAL 0.0
; VAR: MO
VAR_MO	.REAL 0.0
; VAR: F
VAR_F	.REAL 0.0
; VAR: FC
VAR_FC	.REAL 0.0
; VAR: P
VAR_P	.REAL 0.0
; VAR: C
VAR_C	.REAL 0.0
; VAR: M
VAR_M	.REAL 0.0
; VAR: K
VAR_K	.REAL 0.0
; VAR: L
VAR_L	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: J
VAR_J	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: CC
VAR_CC	.REAL 0.0
; VAR: DD
VAR_DD	.REAL 0.0
; VAR: EE
VAR_EE	.REAL 0.0
; VAR: FF
VAR_FF	.REAL 0.0
; VAR: G
VAR_G	.REAL 0.0
; VAR: E
VAR_E	.REAL 0.0
; VAR: O
VAR_O	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: T
VAR_T	.REAL 0.0
; VAR: FT
VAR_FT	.REAL 0.0
; VAR: D%
VAR_D%	.WORD 0
; VAR: D
VAR_D	.REAL 0.0
; VAR: A
VAR_A	.REAL 0.0
; VAR: B
VAR_B	.REAL 0.0
; VAR: AA
VAR_AA	.REAL 0.0
; VAR: Z
VAR_Z	.REAL 0.0
; VAR: N
VAR_N	.REAL 0.0
; VAR: AC
VAR_AC	.REAL 0.0
; VAR: S
VAR_S	.REAL 0.0
; VAR: TI
VAR_TI	.REAL 0.0
; VAR: ZT
VAR_ZT	.REAL 0.0
; VAR: ZC
VAR_ZC	.REAL 0.0
; VAR: ZL
VAR_ZL	.REAL 0.0
; VAR: FL
VAR_FL	.REAL 0.0
STRINGVARS_START
; VAR: D$
VAR_D$	.WORD EMPTYSTR
; VAR: IN$
VAR_IN$	.WORD EMPTYSTR
; VAR: Z$
VAR_Z$	.WORD EMPTYSTR
; VAR: T$
VAR_T$	.WORD EMPTYSTR
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
