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
LINE_10:
;
;
LINE_12:
;
;
LINE_13:
;
;
LINE_15:
;
;
LINE_16:
;
;
LINE_17:
;
;
LINE_20:
;
;
LINE_21:
;
;
LINE_22:
;
;
LINE_28:
;
JSR GOSUB
JSR LINE_13000
;
LINE_29:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
STY 53269
; Optimizer rule: Simple POKE/2
;
LINE_30:
;
LDA #<CONST_1
LDY #>CONST_1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_32:
;
LDA #<CONST_2
LDY #>CONST_2
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_34:
;
LDA #<CONST_3
LDY #>CONST_3
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40:
;
LDA #<CONST_4
LDY #>CONST_4
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_42:
;
LDA #<CONST_5
LDY #>CONST_5
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_44:
;
LDA #<CONST_6
LDY #>CONST_6
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_50:
;
LDA #<CONST_7
LDY #>CONST_7
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_52:
;
LDA #<CONST_8
LDY #>CONST_8
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_60:
;
LDA #<CONST_9
LDY #>CONST_9
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_70:
;
LDA #<CONST_10
LDY #>CONST_10
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_90:
;
JMP LINE_20000
;
LINE_100:
;
LDA #<CONST_11
LDY #>CONST_11
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_110:
;
LDA #<CONST_12
LDY #>CONST_12
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_120:
;
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_10020
;
LINE_130:
;
LDY #127
STY 56333
; Optimizer rule: Simple POKE/2
;
LINE_135:
;
LDY #0
STY 53265
; Optimizer rule: Simple POKE/2
;
LINE_150:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_15
LDY #>CONST_15
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
;
LINE_180:
;
LDY #14
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_190:
;
LDY #3
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_200:
;
LDY #3
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_210:
;
LDY #14
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_220:
;
LDY #6
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_240:
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
LINE_250:
;
LDY #129
STY 56333
; Optimizer rule: Simple POKE/2
LDY #27
STY 53265
; Optimizer rule: Simple POKE/2
;
LINE_253:
;
LDA #<CONST_22
LDY #>CONST_22
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_10020
;
LINE_265:
;
LDY #127
STY 56333
; Optimizer rule: Simple POKE/2
;
LINE_266:
;
LDY #0
STY 53265
; Optimizer rule: Simple POKE/2
;
LINE_270:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_23R
LDY #>CONST_23R
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
LDA #<FORLOOP1
STA JUMP_TARGET
LDA #>FORLOOP1
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP1:
;
LINE_271:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_272:
;
LDY #2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_273:
;
LDY #2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_274:
;
LDY #2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_275:
;
LDY #8
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_276:
;
LDY #8
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_277:
;
LDY #8
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_280:
;
LDY #7
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_281:
;
LDY #1
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_282:
;
LDY #1
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_283:
;
LDY #7
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_284:
;
LDY #8
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_285:
;
LDY #8
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_286:
;
LDY #8
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_287:
;
LDY #2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_288:
;
LDY #2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_289:
;
LDY #2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_290:
;
LDY #2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_291:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_295:
;
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
;
LINE_300:
;
LDY #129
STY 56333
; Optimizer rule: Simple POKE/2
LDY #27
STY 53265
; Optimizer rule: Simple POKE/2
JMP RETURN
;
LINE_305:
;
;
LINE_310:
;
LDA #<CONST_27
LDY #>CONST_27
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_320:
;
LDA #<CONST_28
LDY #>CONST_28
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_330:
;
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_340:
;
LDA #<CONST_30
LDY #>CONST_30
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_350:
;
JSR GOSUB
JSR LINE_10020
LDX #4
dcloop567_1:
LDA CONST_31R,X
STA VAR_X1,X
LDA CONST_16R,X
STA VAR_X2,X
LDA CONST_17R,X
STA VAR_Y1,X
LDA CONST_32R,X
STA VAR_Y2,X
DEX
BPL dcloop567_1
; Special rule: Aggregation of assignments (4)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_355:
;
JSR GOSUB
JSR LINE_11000
;
LINE_360:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_370:
;
LDA #<CONST_33R
LDY #>CONST_33R
JSR REALFAC
LDA #<VAR_X1
LDY #>VAR_X1
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X1
LDY #>VAR_X1
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_34R
LDY #>CONST_34R
JSR REALFAC
LDA #<VAR_X1
LDY #>VAR_X1
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ0
BCS GTEQ_GTEQ0
LDA #0
JMP GTEQ_SKIP0
GTEQ_GTEQ0:
LDA #$1
GTEQ_SKIP0:
COMP_SKP2:
BEQ LINE_SKIP33
; Simplified conditional branch
;
LINE_NSKIP33:
;
LDA #<CONST_34R
LDY #>CONST_34R
JSR REALFAC
LDA #<VAR_X1
LDY #>VAR_X1
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X1
LDY #>VAR_X1
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP33:
;
;
LINE_375:
;
LDA #<CONST_35R
LDY #>CONST_35R
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X2
LDY #>VAR_X2
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_34R
LDY #>CONST_34R
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ1
BCS GTEQ_GTEQ1
LDA #0
JMP GTEQ_SKIP1
GTEQ_GTEQ1:
LDA #$1
GTEQ_SKIP1:
COMP_SKP3:
BEQ LINE_SKIP34
; Simplified conditional branch
;
LINE_NSKIP34:
;
LDA #<CONST_34R
LDY #>CONST_34R
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X2
LDY #>VAR_X2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP34:
;
;
LINE_380:
;
LDA #<CONST_36R
LDY #>CONST_36R
JSR REALFAC
LDA #<VAR_Y1
LDY #>VAR_Y1
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y1
LDY #>VAR_Y1
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFAC
LDA #<VAR_Y1
LDY #>VAR_Y1
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ2
BCS GTEQ_GTEQ2
LDA #0
JMP GTEQ_SKIP2
GTEQ_GTEQ2:
LDA #$1
GTEQ_SKIP2:
COMP_SKP4:
BEQ LINE_SKIP35
; Simplified conditional branch
;
LINE_NSKIP35:
;
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFAC
LDA #<VAR_Y1
LDY #>VAR_Y1
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y1
LDY #>VAR_Y1
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP35:
;
;
LINE_385:
;
LDA #<CONST_26R
LDY #>CONST_26R
JSR REALFAC
LDA #<VAR_Y2
LDY #>VAR_Y2
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y2
LDY #>VAR_Y2
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFAC
LDA #<VAR_Y2
LDY #>VAR_Y2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ3
BCS GTEQ_GTEQ3
LDA #0
JMP GTEQ_SKIP3
GTEQ_GTEQ3:
LDA #$1
GTEQ_SKIP3:
COMP_SKP5:
BEQ LINE_SKIP36
; Simplified conditional branch
;
LINE_NSKIP36:
;
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFAC
LDA #<VAR_Y2
LDY #>VAR_Y2
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y2
LDY #>VAR_Y2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP36:
;
;
LINE_390:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_CO
LDY #>VAR_CO
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_38R
LDY #>CONST_38R
JSR MEMARG
JSR FASTAND
; Optimizer rule: Swap AND order/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CO
LDY #>VAR_CO
; FAC to (X/Y)
JSR FACMEM
;
LINE_395:
;
JSR GOSUB
JSR LINE_12000
;
LINE_400:
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
LDX #<VAR_I
LDY #>VAR_I
; FAC to (X/Y)
JSR FACMEM
;
LINE_405:
;
LDA 198
CMP #0
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
;
BEQ EQ_EQ4
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP4
EQ_EQ4:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP4:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
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
BEQ LINE_SKIP37
; Simplified conditional branch
;
LINE_NSKIP37:
;
JMP LINE_370
;
LINE_SKIP37:
;
;
LINE_410:
;
LDX #4
dcloop1065_1:
LDA CONST_40R,X
STA VAR_MU,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_14000
LDA #<CONST_41
LDY #>CONST_41
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_415:
;
JSR GOSUB
JSR LINE_10020
;
LINE_420:
;
JSR GOSUB
JSR LINE_11000
LDX #4
dcloop1065_2:
LDA CONST_16R,X
STA VAR_H1,X
LDA CONST_24R,X
STA VAR_V1,X
LDA CONST_24R,X
STA VAR_H2,X
LDA CONST_16R,X
STA VAR_V2,X
DEX
BPL dcloop1065_2
; Special rule: Aggregation of assignments (4)
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_425:
LDX #4
dcloop1065_6:
LDA CONST_16R,X
STA VAR_X1,X
LDA CONST_24R,X
STA VAR_Y1,X
LDA CONST_42R,X
STA VAR_X2,X
LDA CONST_43R,X
STA VAR_Y2,X
LDA CONST_16R,X
STA VAR_CC,X
DEX
BPL dcloop1065_6
; Special rule: Aggregation of assignments (5)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_430:
;
LDA VAR_X1
BEQ EQ_SKIP6
EQ_EQ6:
JMP LINE_SKIP38
EQ_SKIP6:
COMP_SKP7:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP38:
;
LDA #<VAR_H1
LDY #>VAR_H1
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_H1
LDY #>VAR_H1
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP38:
;
;
LINE_440:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X2
LDY #>VAR_X2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ7
BEQ LTEQ_LTEQ7
LDA #0
JMP LTEQ_SKIP7
LTEQ_LTEQ7:
LDA #$1
LTEQ_SKIP7:
COMP_SKP8:
BEQ LINE_SKIP39
; Simplified conditional branch
;
LINE_NSKIP39:
;
LDA #<VAR_H2
LDY #>VAR_H2
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_H2
LDY #>VAR_H2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP39:
;
;
LINE_450:
;
LDA VAR_Y1
BEQ EQ_SKIP8
EQ_EQ8:
JMP LINE_SKIP40
EQ_SKIP8:
COMP_SKP9:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP40:
;
LDA #<VAR_V1
LDY #>VAR_V1
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V1
LDY #>VAR_V1
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP40:
;
;
LINE_460:
;
LDA VAR_Y2
BEQ EQ_SKIP9
EQ_EQ9:
JMP LINE_SKIP41
EQ_SKIP9:
COMP_SKP10:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP41:
;
LDA #<VAR_V2
LDY #>VAR_V2
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V2
LDY #>VAR_V2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP41:
;
;
LINE_470:
;
LDX #4
dceloop4816_1:
LDA CONST_44R,X
CMP VAR_X1,X
BNE LINE_SKIP42
DEX
BPL dceloop4816_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP42:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_H1
LDY #>VAR_H1
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_H1
LDY #>VAR_H1
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP42:
;
;
LINE_480:
;
LDA #<CONST_45R
LDY #>CONST_45R
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ11
BCS GTEQ_GTEQ11
LDA #0
JMP GTEQ_SKIP11
GTEQ_GTEQ11:
LDA #$1
GTEQ_SKIP11:
COMP_SKP12:
BEQ LINE_SKIP43
; Simplified conditional branch
;
LINE_NSKIP43:
;
LDA #<VAR_H2
LDY #>VAR_H2
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_H2
LDY #>VAR_H2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP43:
;
;
LINE_490:
;
LDX #4
dceloop4816_2:
LDA CONST_46R,X
CMP VAR_Y1,X
BNE LINE_SKIP44
DEX
BPL dceloop4816_2
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP44:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_V1
LDY #>VAR_V1
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V1
LDY #>VAR_V1
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP44:
;
;
LINE_500:
;
LDX #4
dceloop4816_3:
LDA CONST_46R,X
CMP VAR_Y2,X
BNE LINE_SKIP45
DEX
BPL dceloop4816_3
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP45:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_V2
LDY #>VAR_V2
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V2
LDY #>VAR_V2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP45:
;
;
LINE_510:
;
LDA #<VAR_H1
LDY #>VAR_H1
JSR REALFAC
LDA #<VAR_X1
LDY #>VAR_X1
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X1
LDY #>VAR_X1
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_H2
LDY #>VAR_H2
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X2
LDY #>VAR_X2
; FAC to (X/Y)
JSR FACMEM
;
LINE_520:
;
LDA #<VAR_V1
LDY #>VAR_V1
JSR REALFAC
LDA #<VAR_Y1
LDY #>VAR_Y1
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y1
LDY #>VAR_Y1
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_V2
LDY #>VAR_V2
JSR REALFAC
LDA #<VAR_Y2
LDY #>VAR_Y2
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y2
LDY #>VAR_Y2
; FAC to (X/Y)
JSR FACMEM
;
LINE_525:
;
LDA #<VAR_CC
LDY #>VAR_CC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_CO[]
LDY #>VAR_CO[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_CO
LDY #>VAR_CO
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_CC
LDY #>VAR_CC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CC
LDY #>VAR_CC
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_47R
LDY #>CONST_47R
JSR REALFAC
LDA #<VAR_CC
LDY #>VAR_CC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT14
LDA #0
JMP GT_SKIP14
GT_GT14:
LDA #$1
GT_SKIP14:
COMP_SKP15:
BEQ LINE_SKIP46
; Simplified conditional branch
;
LINE_NSKIP46:
;
LDA #0
STA VAR_CC
STA VAR_CC+1
STA VAR_CC+2
STA VAR_CC+3
STA VAR_CC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP46:
;
;
LINE_530:
;
JSR GOSUB
JSR LINE_12000
;
LINE_540:
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
LDX #<VAR_I
LDY #>VAR_I
; FAC to (X/Y)
JSR FACMEM
LDA 198
CMP #0
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
;
BEQ EQ_EQ15
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP15
EQ_EQ15:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP15:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ16
ROL
BCC LT_LT16
LT_LT_EQ16:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP16
LT_LT16:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP16:
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
COMP_SKP16:
BEQ LINE_SKIP47
; Simplified conditional branch
;
LINE_NSKIP47:
;
JMP LINE_430
;
LINE_SKIP47:
;
;
LINE_550:
;
LDX #4
dcloop1729_1:
LDA CONST_48R,X
STA VAR_MU,X
DEX
BPL dcloop1729_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_14000
JMP RETURN
;
LINE_560:
;
;
LINE_570:
;
LDA #<CONST_49
LDY #>CONST_49
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_580:
;
LDA #<CONST_50
LDY #>CONST_50
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_590:
;
LDA #<CONST_51
LDY #>CONST_51
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_600:
;
LDA #<CONST_52
LDY #>CONST_52
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_605:
;
LDA #<CONST_53
LDY #>CONST_53
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_1000
;
LINE_610:
;
;
LINE_620:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_26R
LDY #>CONST_26R
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
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
;
LINE_630:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_54
LDY #>CONST_54
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF38+1
STA MOVBSELF38+2
LDA #$D
MOVBSELF38:
STA $FFFF
;
LINE_640:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_56
LDY #>CONST_56
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF39+1
STA MOVBSELF39+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF39:
STY $FFFF
;
LINE_645:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_57R
LDY #>CONST_57R
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_X[]
LDY #>VAR_X[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACYREG
LDY #4
LDA #0
STY A_REG
STA A_REG+1
; Optimizer rule: Value in YREG still in FAC/5
; Optimizer rule: Y_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = FAC<<A
JSR SHL
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #1
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
LDA #<CONST_58R
LDY #>CONST_58R
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_Y[]
LDY #>VAR_Y[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_647:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_XS[]
LDY #>VAR_XS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_YS[]
LDY #>VAR_YS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_650:
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
LINE_660:
;
LDY #0
STY 53275
; Optimizer rule: Simple POKE/2
LDY #255
STY 53269
; Optimizer rule: Simple POKE/2
;
LINE_662:
;
LDA #0
STA VAR_A
STA VAR_A+1
STA VAR_A+2
STA VAR_A+3
STA VAR_A+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_665:
;
;
LINE_670:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_26R
LDY #>CONST_26R
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
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
;
LINE_690:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_X[]
LDY #>VAR_X[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_60R
LDY #>CONST_60R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP18:
BNE LINE_NSKIP48
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP48
;
LINE_NSKIP48:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_P2[]
LDY #>VAR_P2[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDY $d010
LDA #0
; Optimized code for PEEK(<constant>)(2)
;
;
;
;
;
;
;
;
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 53264
JMP LINE_710
;
LINE_SKIP48:
;
;
LINE_700:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_P2[]
LDY #>VAR_P2[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<CONST_59R
LDY #>CONST_59R
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
JSR PUSHREAL
LDY $d010
LDA #0
; Optimized code for PEEK(<constant>)(2)
;
;
;
;
;
;
;
;
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 53264
;
LINE_710:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_62
LDY #>CONST_62
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_X[]
LDY #>VAR_X[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_59R
LDY #>CONST_59R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF46+1
STA MOVBSELF46+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF46:
STY $FFFF
;
LINE_715:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_63
LDY #>CONST_63
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_Y[]
LDY #>VAR_Y[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF47+1
STA MOVBSELF47+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF47:
STY $FFFF
;
LINE_720:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XS[]
LDY #>VAR_XS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_X[]
LDY #>VAR_X[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_X[]
LDY #>VAR_X[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_730:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_YS[]
LDY #>VAR_YS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_Y[]
LDY #>VAR_Y[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_Y[]
LDY #>VAR_Y[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_740:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_X[]
LDY #>VAR_X[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_64R
LDY #>CONST_64R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT17
LDA #0
JMP GT_SKIP17
GT_GT17:
LDA #$1
GT_SKIP17:
COMP_SKP19:
BNE LINE_NSKIP49
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP49
;
LINE_NSKIP49:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_X[]
LDY #>VAR_X[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<CONST_65R
LDY #>CONST_65R
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_X[]
LDY #>VAR_X[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XS[]
LDY #>VAR_XS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_XS[]
LDY #>VAR_XS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JSR GOSUB
JSR LINE_950
;
LINE_SKIP49:
;
;
LINE_750:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_X[]
LDY #>VAR_X[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_46R
LDY #>CONST_46R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ18
ROL
BCC LT_LT18
LT_LT_EQ18:
LDA #0
JMP LT_SKIP18
LT_LT18:
LDA #$1
LT_SKIP18:
COMP_SKP20:
BNE LINE_NSKIP50
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP50
;
LINE_NSKIP50:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_X[]
LDY #>VAR_X[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<CONST_66R
LDY #>CONST_66R
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_X[]
LDY #>VAR_X[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XS[]
LDY #>VAR_XS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_XS[]
LDY #>VAR_XS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JSR GOSUB
JSR LINE_950
;
LINE_SKIP50:
;
;
LINE_760:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_Y[]
LDY #>VAR_Y[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_58R
LDY #>CONST_58R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
COMP_SKP21:
BNE LINE_NSKIP51
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP51
;
LINE_NSKIP51:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_Y[]
LDY #>VAR_Y[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<CONST_67R
LDY #>CONST_67R
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_Y[]
LDY #>VAR_Y[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_YS[]
LDY #>VAR_YS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_YS[]
LDY #>VAR_YS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JSR GOSUB
JSR LINE_950
;
LINE_SKIP51:
;
;
LINE_770:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_Y[]
LDY #>VAR_Y[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_68R
LDY #>CONST_68R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT20
LDA #0
JMP GT_SKIP20
GT_GT20:
LDA #$1
GT_SKIP20:
COMP_SKP22:
BNE LINE_NSKIP52
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP52
;
LINE_NSKIP52:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_Y[]
LDY #>VAR_Y[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<CONST_69R
LDY #>CONST_69R
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_Y[]
LDY #>VAR_Y[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_YS[]
LDY #>VAR_YS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_YS[]
LDY #>VAR_YS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JSR GOSUB
JSR LINE_950
;
LINE_SKIP52:
;
;
LINE_800:
;
;
LINE_810:
;
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ21
ROL
BCC LT_LT21
LT_LT_EQ21:
LDA #0
JMP LT_SKIP21
LT_LT21:
LDA #$1
LT_SKIP21:
COMP_SKP23:
BEQ LINE_SKIP53
; Simplified conditional branch
;
LINE_NSKIP53:
;
JMP LINE_880
;
LINE_SKIP53:
;
;
LINE_820:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XS[]
LDY #>VAR_XS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
LDA #<VAR_XS[]
LDY #>VAR_XS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_YS[]
LDY #>VAR_YS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_YS[]
LDY #>VAR_YS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_880:
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
LINE_882:
;
LDX #4
dceloop4816_4:
LDA CONST_18R,X
CMP VAR_A,X
BNE LINE_SKIP54
DEX
BPL dceloop4816_4
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP54:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_A
STA VAR_A+1
STA VAR_A+2
STA VAR_A+3
STA VAR_A+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP54:
;
;
LINE_883:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
;
LINE_886:
;
;
LINE_887:
;
LDA #<VAR_B
LDY #>VAR_B
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA Y_REG
COMP_SKP26:
BNE LINE_NSKIP55
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP55
;
LINE_NSKIP55:
;
LDA #<CONST_70
LDY #>CONST_70
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #128
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA X_REG
BEQ EQ_EQ23
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP23
EQ_EQ23:
LDA #$1
EQ_SKIP23:
COMP_SKP27:
BEQ LINE_SKIP56
; Simplified conditional branch
;
LINE_NSKIP56:
;
JMP LINE_887
;
LINE_SKIP56:
;
;
LINE_SKIP55:
;
;
LINE_890:
;
LDY 198
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BEQ EQ_EQ24
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP24
EQ_EQ24:
LDA #$1
EQ_SKIP24:
COMP_SKP28:
BEQ LINE_SKIP57
; Simplified conditional branch
;
LINE_NSKIP57:
;
JMP LINE_670
;
LINE_SKIP57:
;
;
LINE_900:
;
LDY #0
STY 198
; Optimizer rule: Simple POKE/2
JMP RETURN
;
LINE_950:
;
LDA #<VAR_SN
LDY #>VAR_SN
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 54296
LDA #<VAR_SN
LDY #>VAR_SN
JSR REALFAC
LDA #<CONST_38R
LDY #>CONST_38R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SN
LDY #>VAR_SN
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_990:
;
JSR END
RTS
;
LINE_999:
;
;
LINE_1000:
;
JSR GOSUB
JSR LINE_10600
LDA #0
STA VAR_B
STA VAR_B+1
STA VAR_B+2
STA VAR_B+3
STA VAR_B+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_610
;
LINE_1010:
;
LDA #<CONST_72
LDY #>CONST_72
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1020:
;
LDA #<CONST_73
LDY #>CONST_73
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1030:
;
JSR GOSUB
JSR LINE_10600
;
LINE_1050:
;
LDX #4
dcloop3223_1:
LDA CONST_74,X
STA VAR_B,X
DEX
BPL dcloop3223_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_610
;
LINE_1090:
;
JMP RETURN
;
LINE_9999:
;
;
LINE_10000:
;
LDA #<CONST_75
LDY #>CONST_75
STA TMP_ZP
STY TMP_ZP+1
; Optimizer rule: MEM->REG, REG->TMP_ZP/4
JSR WRITETID
JMP LINE_10100
;
LINE_10010:
;
LDA #<CONST_76
LDY #>CONST_76
STA TMP_ZP
STY TMP_ZP+1
; Optimizer rule: MEM->REG, REG->TMP_ZP/4
JSR WRITETID
JMP LINE_10100
;
LINE_10020:
;
LDA #<CONST_77
LDY #>CONST_77
STA TMP_ZP
STY TMP_ZP+1
; Optimizer rule: MEM->REG, REG->TMP_ZP/4
JSR WRITETID
JMP LINE_10100
;
LINE_10100:
;
JSR GOSUB
JSR LINE_10600
JMP LINE_10500
;
LINE_10500:
;
LDY #0
STY 198
; Optimizer rule: Simple POKE/2
;
LINE_10510:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_78
LDY #>CONST_78
STA B_REG
STY B_REG+1
JSR READTID
LDA VAR_TI$
LDY VAR_TI$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SLT
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_79
LDY #>CONST_79
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
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
COMP_SKP29:
BEQ LINE_SKIP58
; Simplified conditional branch
;
LINE_NSKIP58:
;
JMP LINE_10510
;
LINE_SKIP58:
;
;
LINE_10520:
;
JMP RETURN
;
LINE_10600:
;
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_10998:
;
;
LINE_11000:
;
LDX #4
dcloop3223_2:
LDA CONST_81R,X
STA VAR_I,X
DEX
BPL dcloop3223_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_82R
LDY #>CONST_82R
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
LDA #<CONST_83R
LDY #>CONST_83R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP30
CMP A_REG+1
BNE COMP_SKP30
COMP_SKP30:
BNE RBEQ_4
JMP (JUMP_TARGET)
RBEQ_4:
;
LINE_11010:
;
JMP RETURN
;
LINE_11997:
;
;
LINE_11998:
;
;
LINE_11999:
;
;
LINE_12000:
;
LDA #<VAR_X1
LDY #>VAR_X1
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ25
BCS GTEQ_GTEQ25
LDA #0
JMP GTEQ_SKIP25
GTEQ_GTEQ25:
LDA #$1
GTEQ_SKIP25:
COMP_SKP31:
BEQ LINE_SKIP59
; Simplified conditional branch
;
LINE_NSKIP59:
LDX #4
dcloop3389_1:
LDA VAR_X1,X
STA VAR_XA,X
LDA VAR_X2,X
STA VAR_XE,X
DEX
BPL dcloop3389_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_12002
;
LINE_SKIP59:
;
;
LINE_12001:
LDX #4
dcloop3389_3:
LDA VAR_X2,X
STA VAR_XA,X
LDA VAR_X1,X
STA VAR_XE,X
DEX
BPL dcloop3389_3
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_12002:
;
LDA #<VAR_Y1
LDY #>VAR_Y1
JSR REALFAC
LDA #<VAR_Y2
LDY #>VAR_Y2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ26
BCS GTEQ_GTEQ26
LDA #0
JMP GTEQ_SKIP26
GTEQ_GTEQ26:
LDA #$1
GTEQ_SKIP26:
COMP_SKP32:
BEQ LINE_SKIP60
; Simplified conditional branch
;
LINE_NSKIP60:
LDX #4
dcloop3389_5:
LDA VAR_Y1,X
STA VAR_YA,X
LDA VAR_Y2,X
STA VAR_YE,X
DEX
BPL dcloop3389_5
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_12050
;
LINE_SKIP60:
;
;
LINE_12003:
LDX #4
dcloop3389_7:
LDA VAR_Y2,X
STA VAR_YA,X
LDA VAR_Y1,X
STA VAR_YE,X
DEX
BPL dcloop3389_7
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_12050:
;
LDA #<VAR_YA
LDY #>VAR_YA
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_SC[]
LDY #>VAR_SC[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_Y
LDY #>VAR_Y
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<VAR_YE
LDY #>VAR_YE
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_SC[]
LDY #>VAR_SC[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_34R
LDY #>CONST_34R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
;
LINE_12060:
;
LDA #<VAR_XA
LDY #>VAR_XA
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_XE
LDY #>VAR_XE
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
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
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
;
LINE_12070:
;
LDA #<VAR_CO
LDY #>VAR_CO
JSR COPY2_XYA_XREG
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF52+1
STA MOVBSELF52+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF52:
STY $FFFF
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_5
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_5:
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
;
LINE_12090:
;
JMP RETURN
;
LINE_12998:
;
;
LINE_12999:
;
;
LINE_13000:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_46R
LDY #>CONST_46R
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
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACYREG
LDY #5
LDA #0
STY A_REG
STA A_REG+1
; Optimizer rule: Value in YREG still in FAC/5
; Optimizer rule: Y_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = FAC<<A
JSR SHL
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #3
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
LDA #<CONST_85
LDY #>CONST_85
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
LDA #<VAR_SC[]
LDY #>VAR_SC[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
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
;
LINE_13010:
;
;
LINE_13020:
;
LDA #0
STA VAR_A
STA VAR_A+1
STA VAR_A+2
STA VAR_A+3
STA VAR_A+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_47R
LDY #>CONST_47R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_A
LDY #>VAR_A
STA A_REG
STY A_REG+1
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
LDA #<VAR_A
LDY #>VAR_A
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR READNUMBER
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_CO[]
LDY #>VAR_CO[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
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
;
LINE_13030:
;
LDA #0
STA VAR_MP
STA VAR_MP+1
STA VAR_MP+2
STA VAR_MP+3
STA VAR_MP+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_13040:
;
LDA #0
STA VAR_A
STA VAR_A+1
STA VAR_A+2
STA VAR_A+3
STA VAR_A+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_26R
LDY #>CONST_26R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_A
LDY #>VAR_A
STA A_REG
STY A_REG+1
LDA #<FORLOOP8
STA JUMP_TARGET
LDA #>FORLOOP8
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP8:
LDA #<VAR_A
LDY #>VAR_A
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
LDA #<CONST_24R
LDY #>CONST_24R
JSR MEMARG
JSR FACPOW
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_P2[]
LDY #>VAR_P2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
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
LINE_13050:
;
LDX #4
dcloop3721_1:
LDA CONST_86R,X
STA VAR_I,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_87
LDY #>CONST_87
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(1)/1
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP9
STA JUMP_TARGET
LDA #>FORLOOP9
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP9:
;
LINE_13060:
;
JSR READNUMBER
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_A
LDY #>VAR_A
JSR FACMEM
JSR FACXREG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDX #<X_REG
; Optimizer rule: Move variable directly in XREG/9
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF53+1
STA MOVBSELF53+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF53:
STY $FFFF
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_10
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_10:
;
LINE_13090:
;
JMP RETURN
;
LINE_13499:
;
;
LINE_13500:
;
;
LINE_13599:
;
;
LINE_13600:
;
;
LINE_13601:
;
;
LINE_13602:
;
;
LINE_13603:
;
;
LINE_13604:
;
;
LINE_13605:
;
;
LINE_13606:
;
;
LINE_13607:
;
;
LINE_13608:
;
;
LINE_13998:
;
;
LINE_13999:
;
;
LINE_14000:
LDX #4
dcloop3887_1:
LDA CONST_81R,X
STA VAR_I,X
LDA CONST_36R,X
STA VAR_A,X
DEX
BPL dcloop3887_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_14010:
;
LDX #4
dcloop3887_3:
LDA CONST_84R,X
STA VAR_A,X
DEX
BPL dcloop3887_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_14020:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF54+1
STA MOVBSELF54+2
LDA #$20
MOVBSELF54:
STA $FFFF
LDA #<VAR_MU
LDY #>VAR_MU
JSR REALFAC
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
;
LINE_14030:
;
LDA #<CONST_89R
LDY #>CONST_89R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ27
BCS GTEQ_GTEQ27
LDA #0
JMP GTEQ_SKIP27
GTEQ_GTEQ27:
LDA #$1
GTEQ_SKIP27:
COMP_SKP39:
BEQ LINE_SKIP61
; Simplified conditional branch
;
LINE_NSKIP61:
;
LDA #<CONST_90R
LDY #>CONST_90R
JSR REALFAC
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
;
LINE_SKIP61:
;
;
LINE_14040:
;
LDX #4
dcneloop4817_1:
LDA CONST_81R,X
CMP VAR_I,X
BNE LINE_NSKIP62
DEX
BPL dcneloop4817_1
JMP LINE_SKIP62
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP62:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_14010
;
LINE_SKIP62:
;
;
LINE_14050:
;
JMP RETURN
;
LINE_20000:
;
;
LINE_20010:
;
LDA #<CONST_91
LDY #>CONST_91
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_20020:
;
LDA #<CONST_92
LDY #>CONST_92
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_20030:
;
LDA #<CONST_93
LDY #>CONST_93
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_20040:
;
LDA #<CONST_94
LDY #>CONST_94
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_20050:
;
LDA #<CONST_95
LDY #>CONST_95
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_20090:
;
LDA #<CONST_96
LDY #>CONST_96
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_20092:
;
;
LINE_20094:
;
;
LINE_20100:
;
LDA #<CONST_75
LDY #>CONST_75
STA TMP_ZP
STY TMP_ZP+1
; Optimizer rule: MEM->REG, REG->TMP_ZP/4
JSR WRITETID
JSR GOSUB
JSR LINE_10500
;
LINE_20110:
;
LDA #<CONST_97
LDY #>CONST_97
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SLTEQ
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_98
LDY #>CONST_98
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SGTEQ
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP41:
BEQ LINE_SKIP63
; Simplified conditional branch
;
LINE_NSKIP63:
;
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_MP
LDY #>VAR_MP
; FAC to (X/Y)
JSR FACMEM
JMP LINE_20130
;
LINE_SKIP63:
;
;
LINE_20120:
;
LDA #<CONST_79
LDY #>CONST_79
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP42:
BEQ LINE_SKIP64
; Simplified conditional branch
;
LINE_NSKIP64:
;
JMP LINE_20100
;
LINE_SKIP64:
;
;
LINE_20125:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_MP
LDY #>VAR_MP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MP
LDY #>VAR_MP
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_32R
LDY #>CONST_32R
JSR REALFAC
LDA #<VAR_MP
LDY #>VAR_MP
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT29
LDA #0
JMP GT_SKIP29
GT_GT29:
LDA #$1
GT_SKIP29:
COMP_SKP43:
BEQ LINE_SKIP65
; Simplified conditional branch
;
LINE_NSKIP65:
;
LDX #4
dcloop4219_1:
LDA CONST_16R,X
STA VAR_MP,X
DEX
BPL dcloop4219_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP65:
;
;
LINE_20130:
;
LDA #<VAR_MP
LDY #>VAR_MP
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON1SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP44:
BNE ON1SUB1
JSR GOSUB
JSR LINE_310
JMP GSKIPON1
ON1SUB1:
INX
CPX TMP_ZP
COMP_SKP45:
BNE ON1SUB2
JSR GOSUB
JSR LINE_570
JMP GSKIPON1
ON1SUB2:
INX
CPX TMP_ZP
COMP_SKP46:
BNE ON1SUB3
JSR GOSUB
JSR LINE_100
JMP GSKIPON1
ON1SUB3:
INX
CPX TMP_ZP
COMP_SKP47:
BNE GSKIPON1
JSR GOSUB
JSR LINE_21000
JMP GSKIPON1
; Optimized code for ON XX GOYYY
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
;
;
;
;
;
;
GSKIPON1:
;
LINE_20140:
;
JMP LINE_29
;
LINE_21000:
;
LDA #<CONST_99
LDY #>CONST_99
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21010:
;
LDA #<CONST_100
LDY #>CONST_100
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21015:
;
LDA #<CONST_101
LDY #>CONST_101
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21020:
;
LDA #<CONST_102
LDY #>CONST_102
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21030:
;
LDA #<CONST_103
LDY #>CONST_103
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21040:
;
LDA #<CONST_104
LDY #>CONST_104
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21050:
;
LDA #<CONST_105
LDY #>CONST_105
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21060:
;
LDA #<CONST_106
LDY #>CONST_106
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21070:
;
LDA #<CONST_107
LDY #>CONST_107
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21080:
;
LDA #<CONST_108
LDY #>CONST_108
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21090:
;
LDA #<CONST_109
LDY #>CONST_109
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21100:
;
LDA #<CONST_110
LDY #>CONST_110
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21110:
;
LDA #<CONST_111
LDY #>CONST_111
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21120:
;
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21130:
;
LDA #<CONST_113
LDY #>CONST_113
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_10000
;
LINE_21140:
;
LDA #<CONST_114
LDY #>CONST_114
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR TABOUT
;
LINE_21150:
;
LDA #<CONST_115
LDY #>CONST_115
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21160:
;
LDA #<CONST_116
LDY #>CONST_116
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21170:
;
LDA #<CONST_117
LDY #>CONST_117
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21180:
;
LDA #<CONST_118
LDY #>CONST_118
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21190:
;
LDA #<CONST_119
LDY #>CONST_119
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21200:
;
LDA #<CONST_120
LDY #>CONST_120
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDY #$00
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
JSR INTOUTFAST
; Fast integer print (2)
;
JSR CRSRRIGHT
LDA #<CONST_121
LDY #>CONST_121
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #34
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<CONST_123
LDY #>CONST_123
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #34
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<CONST_124
LDY #>CONST_124
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21210:
;
LDA #<CONST_125
LDY #>CONST_125
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21220:
;
LDA #<CONST_126
LDY #>CONST_126
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21230:
;
LDA #<CONST_127
LDY #>CONST_127
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21240:
;
LDA #<CONST_128
LDY #>CONST_128
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21250:
;
LDA #<CONST_129
LDY #>CONST_129
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_10000
;
LINE_21260:
;
LDA #<CONST_130
LDY #>CONST_130
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21300:
;
;
LINE_21310:
;
LDX #4
dcloop4551_1:
LDA CONST_16R,X
STA VAR_I,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_131R
LDY #>CONST_131R
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
LDA #<FORLOOP10
STA JUMP_TARGET
LDA #>FORLOOP10
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP10:
;
LINE_21320:
;
;LDA #<VAR_I
;LDY #>VAR_I
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #65
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_11
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_11:
;
LINE_21330:
;
LDA #<CONST_75
LDY #>CONST_75
STA TMP_ZP
STY TMP_ZP+1
; Optimizer rule: MEM->REG, REG->TMP_ZP/4
JSR WRITETID
LDA #<CONST_123
LDY #>CONST_123
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_0R
LDY #>CONST_0R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FRE
JSR INTOUT
JSR CRSRRIGHT
LDA #<CONST_133R
LDY #>CONST_133R
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
JSR FACDIV
; Optimizer rule: Combine load and div/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_21335:
;
LDA #<CONST_134
LDY #>CONST_134
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21336:
;
LDA #<CONST_135
LDY #>CONST_135
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21340:
;
JSR GOSUB
JSR LINE_10010
;
LINE_21400:
;
LDA #<CONST_136
LDY #>CONST_136
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21410:
;
LDA #<CONST_137
LDY #>CONST_137
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21420:
;
LDA #<CONST_138
LDY #>CONST_138
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21430:
;
LDA #<CONST_139
LDY #>CONST_139
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21440:
;
LDA #<CONST_140
LDY #>CONST_140
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21450:
;
LDA #<CONST_141
LDY #>CONST_141
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21460:
;
LDA #<CONST_142
LDY #>CONST_142
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21470:
;
LDA #<CONST_143
LDY #>CONST_143
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21480:
;
LDA #<CONST_144
LDY #>CONST_144
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21490:
;
LDA #<CONST_145
LDY #>CONST_145
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21500:
;
LDA #<CONST_146
LDY #>CONST_146
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21510:
;
LDA #<CONST_147
LDY #>CONST_147
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21520:
;
LDA #<CONST_148
LDY #>CONST_148
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21525:
;
LDA #<CONST_149
LDY #>CONST_149
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21530:
;
LDA #<CONST_150
LDY #>CONST_150
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21540:
;
JSR GOSUB
JSR LINE_10000
;
LINE_21550:
;
LDA #<CONST_151
LDY #>CONST_151
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21560:
;
LDA #<CONST_152
LDY #>CONST_152
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21570:
;
JMP LINE_10000
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
READTID		LDA $FE
PHA
<IF !X16>
STA FACOV
JSR TI2FAC
LDY #0
STY LOWDS+1
DEY
STY FACOV+1
LDY #$06
STY LOWDS
LDY #$24
JSR GETTI
</IF>
<IF X16>
JSR READTID_X16
</IF>
LDA #$FE
STA TMP_ZP
LDA #0
STA TMP_ZP+1
LDA #$6
SEI				; prevent $FE from being overwritten. because the x16 doesn't like this
STA $FE
LDA #<VAR_TI$
LDY #>VAR_TI$
JSR COPYSTRING
PLA
STA $FE
CLI
RTS
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
INTOUTFAST	JSR REROUTE
JSR INTOUTFASTZ
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
SINGLECHROUTMAX
JSR SINGLECHROUT
JMP COMPACTMAX
;###################################
;###################################
SINGLECHROUT
STA TMP_ZP
JSR REROUTE
LDA TMP_ZP
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
FRE
JSR GCEXE
LDA ENDSTRBUF
SEC
SBC STRBUFP
TAY
LDA ENDSTRBUF+1
SBC STRBUFP+1
JSR INTFAC
JMP FACXREG
;###################################
;###################################
TABOUT		JSR REROUTE
LDA CMD_NUM
BEQ NORMALTABOUT		; No reroute? Normal TABOUT
CMP #3
BEQ NORMALTABOUT2		; To screen? Normal TAB
JMP TABOUTCHANNEL2
NORMALTABOUT2
JSR CLRCHNEW
NORMALTABOUT
SEC
JSR CRSRPOS
TYA
SEC
TABSUB 		SBC #$0A
BCS TABSUB
EOR #$FF
ADC #$01
TAX
INX
TABLOOP 	DEX
BNE TABRIGHT
RTS
TABRIGHT	JSR CRSRRIGHT
JMP TABLOOP
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
SGTEQ		JSR CMPSTRGTEQ
LDA TMP3_ZP
BNE NOTSGTEQ
LDA #<REAL_CONST_MINUS_ONE
STA TMP3_ZP
LDA #>REAL_CONST_MINUS_ONE
STA TMP3_ZP+1
JMP COPY2_XY_XREG
NOTSGTEQ	JMP ZEROSET
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
SLTEQ		LDA A_REG
LDX B_REG
STX A_REG
STA B_REG
LDA A_REG+1
LDX B_REG+1
STX A_REG+1
STA B_REG+1
JMP SGTEQ
;###################################
;###################################
CMPSTRGTEQ	LDY #0				;Returns 0 if A>=B, something else otherwise
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
BNE CMPSTRSK3
LDA TMP2_ZP
CMP TMP_ZP
BNE CMPSTRSK3
LDX #0
JMP STRSGTEQRES
CMPSTRSK3	LDA (TMP2_ZP),Y
STA TMP3_ZP+1
LDA (TMP_ZP),Y
STA TMP3_ZP
CMP TMP3_ZP+1
BCC DONTSWAPEQ
LDA TMP3_ZP+1
DONTSWAPEQ	TAX
BNE NOTZSTR2
LDX #1
LDA TMP3_ZP+1
CMP TMP3_ZP
BEQ SKIPEQ1
BCS STRSGTEQRES
SKIPEQ1		LDX #0
JMP STRSGTEQRES
NOTZSTR2	INC TMP_ZP
BNE SCGTEQSKP1
INC TMP_ZP+1
SCGTEQSKP1	INC TMP2_ZP
BNE CMPSGTEQLOOP
INC TMP2_ZP+1
CMPSGTEQLOOP
LDA (TMP_ZP),Y
CMP (TMP2_ZP),Y
BEQ SGTEQCONT2
BCC STRSGTEQRES
LDX #0
JMP STRSGTEQRES
SGTEQCONT2	INY
DEX
BNE CMPSGTEQLOOP
LDA TMP3_ZP+1					; All equal so far...decide based on the length then
CMP TMP3_ZP
BEQ STRSGTEQRES
BCC STRSGTEQRES
LDX #1
STRSGTEQRES	STX TMP3_ZP
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
NEG			LDA FACSGN
EOR #$FF
STA FACSGN
RTS
;### HELPER ########################
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
TABOUTCHANNEL
JSR INITOUTCHANNEL
LDA CHANNEL
CMP #3		; To the screen?
BEQ TABOUTSCREEN
TABOUTCHANNEL2
LDA IOCHANNEL
STA STORE1
LDA #1
STA IOCHANNEL		; Something that's not the screen...that's enough for the check the CRSRRIGHT does...
LDX #10
JMP EXITCHANNEL
TABOUTSCREEN
JSR CLRCHNEW
JMP TABOUT
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
OUTOFDATA
<IF BOOST>
JSR BOOSTDIASBLE
</IF>
LDX #$0D
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
STA VAR_I,Y
STA VAR_X1,Y
STA VAR_X2,Y
STA VAR_Y1,Y
STA VAR_Y2,Y
STA VAR_CO,Y
STA VAR_MU,Y
STA VAR_H1,Y
STA VAR_V1,Y
STA VAR_H2,Y
STA VAR_V2,Y
STA VAR_CC,Y
STA VAR_A,Y
STA VAR_B,Y
STA VAR_SN,Y
STA VAR_XA,Y
STA VAR_XE,Y
STA VAR_YA,Y
STA VAR_YE,Y
STA VAR_Y,Y
STA VAR_X,Y
STA VAR_MP,Y
STA VAR_TI,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
LDA #<VAR_CO[]
LDY #>VAR_CO[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_X[]
LDY #>VAR_X[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_Y[]
LDY #>VAR_Y[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_XS[]
LDY #>VAR_XS[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_YS[]
LDY #>VAR_YS[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_P2[]
LDY #>VAR_P2[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_SC[]
LDY #>VAR_SC[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #0

CONST_0R	.REAL 0.0
; CONST: ${white}{ct h}{ct n}{clear}{space*8}*** Basic-Boss ***
CONST_1	.BYTE 53
.STRG "{white}{ct h}{ct n}{clear}{space*8}*** Basic-Boss ***"
; CONST: ${down}Programmieren in Basic mit der
CONST_2	.BYTE 36
.STRG "{down}Programmieren in Basic mit der"
; CONST: $Geschwindigkeit von Maschinensprache !
CONST_3	.BYTE 38
.STRG "Geschwindigkeit von Maschinensprache !"
; CONST: ${down}{gray}Unmoeglich? Nein!
CONST_4	.BYTE 29
.STRG "{down}{gray}Unmoeglich? Nein!"
; CONST: $Dieses Programm wurde von vorne bis
CONST_5	.BYTE 35
.STRG "Dieses Programm wurde von vorne bis"
; CONST: $hinten in Basic programmiert.
CONST_6	.BYTE 29
.STRG "hinten in Basic programmiert."
; CONST: $Dann wurde es vom Basic-Boss in reine
CONST_7	.BYTE 37
.STRG "Dann wurde es vom Basic-Boss in reine"
; CONST: $Maschinensprache uebersetzt.
CONST_8	.BYTE 28
.STRG "Maschinensprache uebersetzt."
; CONST: ${down}Bitte ueberzeugen Sie sich von seiner
CONST_9	.BYTE 43
.STRG "{down}Bitte ueberzeugen Sie sich von seiner"
; CONST: $Geschwindigkeit !
CONST_10	.BYTE 17
.STRG "Geschwindigkeit !"
; CONST: ${clear}{down*2}{space*2}So sieht es aus, wenn die Bild-
CONST_11	.BYTE 55
.STRG "{clear}{down*2}{space*2}So sieht es aus, wenn die Bild-"
; CONST: ${down}{space*2}schirmfarbe in schneller Folge
CONST_12	.BYTE 45
.STRG "{down}{space*2}schirmfarbe in schneller Folge"
; CONST: ${down}{space*2}veraendert wird:
CONST_13	.BYTE 31
.STRG "{down}{space*2}veraendert wird:"
; CONST: #127


; CONST: #60000

CONST_15	.REAL 60000
; CONST: #1

CONST_16R	.REAL 1.0
; CONST: #14

CONST_17R	.REAL 14.0
; CONST: #3

CONST_18R	.REAL 3.0
; CONST: #6


; CONST: #129


; CONST: #27


; CONST: ${clear}{down*2} oder so:
CONST_22	.BYTE 24
.STRG "{clear}{down*2} oder so:"
; CONST: #30000

CONST_23R	.REAL 30000.0
; CONST: #2

CONST_24R	.REAL 2.0
; CONST: #8


; CONST: #7

CONST_26R	.REAL 7.0
; CONST: ${clear}{down*2}{space*2}Wenn ein mit dem Basic-Boss
CONST_27	.BYTE 51
.STRG "{clear}{down*2}{space*2}Wenn ein mit dem Basic-Boss"
; CONST: ${down}{space*2}compiliertes Basicprogramm den
CONST_28	.BYTE 45
.STRG "{down}{space*2}compiliertes Basicprogramm den"
; CONST: ${down}{space*2}Bildschirm bearbeitet, sieht das
CONST_29	.BYTE 47
.STRG "{down}{space*2}Bildschirm bearbeitet, sieht das"
; CONST: ${down}{space*2}so aus:
CONST_30	.BYTE 22
.STRG "{down}{space*2}so aus:"
; CONST: #10

CONST_31R	.REAL 10.0
; CONST: #4

CONST_32R	.REAL 4.0
; CONST: #33

CONST_33R	.REAL 33.0
; CONST: #40

CONST_34R	.REAL 40.0
; CONST: #17

CONST_35R	.REAL 17.0
; CONST: #21

CONST_36R	.REAL 21.0
; CONST: #25

CONST_37R	.REAL 25.0
; CONST: #15

CONST_38R	.REAL 15.0
; CONST: #1000

CONST_39R	.REAL 1000.0
; CONST: #11

CONST_40R	.REAL 11.0
; CONST: ${home}{down*2} oder so:
CONST_41	.BYTE 23
.STRG "{home}{down*2} oder so:"
; CONST: #37

CONST_42R	.REAL 37.0
; CONST: #22

CONST_43R	.REAL 22.0
; CONST: #39

CONST_44R	.REAL 39.0
; CONST: #38

CONST_45R	.REAL 38.0
; CONST: #24

CONST_46R	.REAL 24.0
; CONST: #23

CONST_47R	.REAL 23.0
; CONST: #500

CONST_48R	.REAL 500.0
; CONST: ${clear}Nun huepfen ein paar Sprites ueber
CONST_49	.BYTE 41
.STRG "{clear}Nun huepfen ein paar Sprites ueber"
; CONST: ${down}den Bildschirm. Allerdings ergibt sich
CONST_50	.BYTE 44
.STRG "{down}den Bildschirm. Allerdings ergibt sich"
; CONST: ${down}hier ein Problem: Das Programm ist
CONST_51	.BYTE 40
.STRG "{down}hier ein Problem: Das Programm ist"
; CONST: ${down}zu schnell. Es muss also gebremst
CONST_52	.BYTE 39
.STRG "{down}zu schnell. Es muss also gebremst"
; CONST: ${down}werden:
CONST_53	.BYTE 13
.STRG "{down}werden:"
; CONST: #2040.0

CONST_54	.REAL 2040.0
; CONST: #13


; CONST: #53287.0

CONST_56	.REAL 53287.0
; CONST: #130

CONST_57R	.REAL 130.0
; CONST: #50

CONST_58R	.REAL 50.0
; CONST: #255

CONST_59R	.REAL 255.0
; CONST: #256

CONST_60R	.REAL 256.0
; CONST: #53264.0


; CONST: #53248.0

CONST_62	.REAL 53248.0
; CONST: #53249.0

CONST_63	.REAL 53249.0
; CONST: #320

CONST_64R	.REAL 320.0
; CONST: #640

CONST_65R	.REAL 640.0
; CONST: #48

CONST_66R	.REAL 48.0
; CONST: #100

CONST_67R	.REAL 100.0
; CONST: #229

CONST_68R	.REAL 229.0
; CONST: #458

CONST_69R	.REAL 458.0
; CONST: #53265.0

CONST_70	.REAL 53265.0
; CONST: #128


; CONST: ${down*2}jetzt ist es gebremst und wird
CONST_72	.BYTE 38
.STRG "{down*2}jetzt ist es gebremst und wird"
; CONST: ${down*2}mit dem Rasterstrahl synchronisiert.
CONST_73	.BYTE 44
.STRG "{down*2}mit dem Rasterstrahl synchronisiert."
; CONST: #-1.0

CONST_74	.REAL -1.0
; CONST: $000000
CONST_75	.BYTE 6
.STRG "000000"
; CONST: $000030
CONST_76	.BYTE 6
.STRG "000030"
; CONST: $000035
CONST_77	.BYTE 6
.STRG "000035"
; CONST: $000040
CONST_78	.BYTE 6
.STRG "000040"
; CONST: $
CONST_79	.BYTE 0
.STRG ""
; CONST: ${down*3}{space*12}- Taste -
CONST_80	.BYTE 27
.STRG "{down*3}{space*12}- Taste -"
; CONST: #1024

CONST_81R	.REAL 1024.0
; CONST: #2023

CONST_82R	.REAL 2023.0
; CONST: #160

CONST_83R	.REAL 160.0
; CONST: #5

CONST_84R	.REAL 5.0
; CONST: #55296

CONST_85	.REAL 55296
; CONST: #832

CONST_86R	.REAL 832.0
; CONST: #894.0

CONST_87	.REAL 894.0
; CONST: #32


; CONST: #2045

CONST_89R	.REAL 2045.0
; CONST: #1021

CONST_90R	.REAL 1021.0
; CONST: ${down}{right*2}Waehlen Sie:
CONST_91	.BYTE 27
.STRG "{down}{right*2}Waehlen Sie:"
; CONST: ${down}{space*3}1...Bildschirmdemo
CONST_92	.BYTE 33
.STRG "{down}{space*3}1...Bildschirmdemo"
; CONST: ${space*3}2...Spritedemo
CONST_93	.BYTE 23
.STRG "{space*3}2...Spritedemo"
; CONST: ${space*3}3...Hintergrunddemo
CONST_94	.BYTE 28
.STRG "{space*3}3...Hintergrunddemo"
; CONST: ${space*3}4...Noch was
CONST_95	.BYTE 21
.STRG "{space*3}4...Noch was"
; CONST: ${down*2}(Thilo Herrmann, 1988)
CONST_96	.BYTE 30
.STRG "{down*2}(Thilo Herrmann, 1988)"
; CONST: $4
CONST_97	.BYTE 1
.STRG "4"
; CONST: $1
CONST_98	.BYTE 1
.STRG "1"
; CONST: ${clear}{down*2}Sie sollten zum Vergleich mal die
CONST_99	.BYTE 48
.STRG "{clear}{down*2}Sie sollten zum Vergleich mal die"
; CONST: $Basic-Version dieses Programms
CONST_100	.BYTE 30
.STRG "Basic-Version dieses Programms"
; CONST: $ablaufen lassen !
CONST_101	.BYTE 17
.STRG "ablaufen lassen !"
; CONST: ${down}Das Basicprogramm zeigt auch, dass
CONST_102	.BYTE 40
.STRG "{down}Das Basicprogramm zeigt auch, dass"
; CONST: $der Programmierer alle Moeglichkeiten
CONST_103	.BYTE 37
.STRG "der Programmierer alle Moeglichkeiten"
; CONST: $von Basic ausreizen kann, ohne dass er
CONST_104	.BYTE 38
.STRG "von Basic ausreizen kann, ohne dass er"
; CONST: $unnoetig eingeschraenkt wird.
CONST_105	.BYTE 29
.STRG "unnoetig eingeschraenkt wird."
; CONST: ${down}Denn ausser solchen Bildschirm-
CONST_106	.BYTE 37
.STRG "{down}Denn ausser solchen Bildschirm-"
; CONST: $spielereien kann man auch ernstere
CONST_107	.BYTE 34
.STRG "spielereien kann man auch ernstere"
; CONST: $Anwendungen programmieren, da der
CONST_108	.BYTE 33
.STRG "Anwendungen programmieren, da der"
; CONST: $Basic-Boss z.B. eine wesentlich
CONST_109	.BYTE 31
.STRG "Basic-Boss z.B. eine wesentlich"
; CONST: $leistungsfaehigere Stringverwaltung
CONST_110	.BYTE 35
.STRG "leistungsfaehigere Stringverwaltung"
; CONST: $besitzt als der Basicinterpreter. Darum
CONST_111	.BYTE 39
.STRG "besitzt als der Basicinterpreter. Darum"
; CONST: $ist nun auch die Garbage-Collection
CONST_112	.BYTE 35
.STRG "ist nun auch die Garbage-Collection"
; CONST: $um einiges schneller.
CONST_113	.BYTE 21
.STRG "um einiges schneller."
; CONST: ${clear}Was das heisst, werden Sie merken
CONST_114	.BYTE 40
.STRG "{clear}Was das heisst, werden Sie merken"
; CONST: $wenn Sie folgendes Programm ablaufen
CONST_115	.BYTE 36
.STRG "wenn Sie folgendes Programm ablaufen"
; CONST: $lassen:{down}
CONST_116	.BYTE 13
.STRG "lassen:{down}"
; CONST: $10 dim a$(2000)
CONST_117	.BYTE 15
.STRG "10 dim a$(2000)"
; CONST: $20 for i=1 to 2000
CONST_118	.BYTE 18
.STRG "20 for i=1 to 2000"
; CONST: $30 a$(i)=chr$(65):next i
CONST_119	.BYTE 24
.STRG "30 a$(i)=chr$(65):next i"
; CONST: $40 ti$=
CONST_120	.BYTE 7
.STRG "40 ti$="
; CONST: $:print
CONST_121	.BYTE 6
.STRG ":print"
; CONST: #34


; CONST: $frei
CONST_123	.BYTE 4
.STRG "frei"
; CONST: $fre(0);ti/60
CONST_124	.BYTE 12
.STRG "fre(0);ti/60"
; CONST: ${down}Allein der FRE-Befehl benoetigt ca.
CONST_125	.BYTE 41
.STRG "{down}Allein der FRE-Befehl benoetigt ca."
; CONST: $339 Sekunden, da er eine Garbage-
CONST_126	.BYTE 33
.STRG "339 Sekunden, da er eine Garbage-"
; CONST: $Collection ausloest.
CONST_127	.BYTE 20
.STRG "Collection ausloest."
; CONST: ${down}Das gleiche Programm koennen Sie nun
CONST_128	.BYTE 42
.STRG "{down}Das gleiche Programm koennen Sie nun"
; CONST: $in der compilierten Version starten:
CONST_129	.BYTE 37
.STRG "in der compilierten Version starten: "
; CONST: ${clear}{down*2} gestartet...
CONST_130	.BYTE 28
.STRG "{clear}{down*2} gestartet..."
; CONST: #2000

CONST_131R	.REAL 2000.0
; CONST: #65


; CONST: #60

CONST_133R	.REAL 60.0
; CONST: ${down*2}Damit ist die Garbage-Collection
CONST_134	.BYTE 40
.STRG "{down*2}Damit ist die Garbage-Collection"
; CONST: ${down}in diesem Fall etwa 680 mal schneller !
CONST_135	.BYTE 45
.STRG "{down}in diesem Fall etwa 680 mal schneller !"
; CONST: ${clear}{down*2}Die Leistungsdaten des Basic-Boss:
CONST_136	.BYTE 49
.STRG "{clear}{down*2}Die Leistungsdaten des Basic-Boss:"
; CONST: ${down}- kurze Compilate
CONST_137	.BYTE 23
.STRG "{down}- kurze Compilate"
; CONST: $- optimierter und effizienter Code
CONST_138	.BYTE 34
.STRG "- optimierter und effizienter Code"
; CONST: $- sehr schnelle Variablentypen
CONST_139	.BYTE 30
.STRG "- sehr schnelle Variablentypen"
; CONST: $- extrem kurze Compilierzeiten
CONST_140	.BYTE 30
.STRG "- extrem kurze Compilierzeiten"
; CONST: $- eine hochflexible Compilerarchitektur
CONST_141	.BYTE 39
.STRG "- eine hochflexible Compilerarchitektur"
; CONST: $- 62 KByte Basicspeicher
CONST_142	.BYTE 24
.STRG "- 62 KByte Basicspeicher"
; CONST: $- eine schnelle FOR-NEXT-Schleife
CONST_143	.BYTE 33
.STRG "- eine schnelle FOR-NEXT-Schleife"
; CONST: $- gepackte und schnelle Daten bei DATA
CONST_144	.BYTE 38
.STRG "- gepackte und schnelle Daten bei DATA"
; CONST: $- stark beschleunigte Arrays
CONST_145	.BYTE 28
.STRG "- stark beschleunigte Arrays"
; CONST: $- beliebig lange Variablennamen
CONST_146	.BYTE 31
.STRG "- beliebig lange Variablennamen"
; CONST: $- genaue deutsche Fehlermeldungen
CONST_147	.BYTE 33
.STRG "- genaue deutsche Fehlermeldungen"
; CONST: $- Erzeugung echten Maschinencodes
CONST_148	.BYTE 33
.STRG "- Erzeugung echten Maschinencodes"
; CONST: $- kein Kopierschutz
CONST_149	.BYTE 19
.STRG "- kein Kopierschutz"
; CONST: ${down*2} und noch einiges mehr...
CONST_150	.BYTE 33
.STRG "{down*2} und noch einiges mehr..."
; CONST: ${clear}{down*3} Ich bin jedem dankbar, der dieses
CONST_151	.BYTE 49
.STRG "{clear}{down*3} Ich bin jedem dankbar, der dieses"
; CONST: $ {down}Demoprogramm weiterverbreitet.
CONST_152	.BYTE 37
.STRG " {down}Demoprogramm weiterverbreitet."
;###############################
; ******** DATA ********
DATAS
.BYTE 3
.BYTE 0
.BYTE 6
.BYTE 14
.BYTE 3
.BYTE 3
.BYTE 3
.BYTE 1
.BYTE 3
.BYTE 3
.BYTE 14
.BYTE 6
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 2
.BYTE 8
.BYTE 7
.BYTE 3
.BYTE 1
.BYTE 7
.BYTE 8
.BYTE 3
.BYTE 2
.BYTE 3
.BYTE 0
.BYTE 11
.BYTE 5
.BYTE 13
.BYTE 3
.BYTE 1
.BYTE 13
.BYTE 5
.BYTE 11
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 3
.BYTE 3
.BYTE 255
.BYTE 192
.BYTE 15
.BYTE 3
.BYTE 255
.BYTE 240
.BYTE 31
.BYTE 3
.BYTE 255
.BYTE 248
.BYTE 63
.BYTE 3
.BYTE 255
.BYTE 252
.BYTE 127
.BYTE 3
.BYTE 255
.BYTE 254
.BYTE 127
.BYTE 3
.BYTE 255
.BYTE 254
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 255
.BYTE 127
.BYTE 3
.BYTE 255
.BYTE 254
.BYTE 127
.BYTE 3
.BYTE 255
.BYTE 254
.BYTE 63
.BYTE 3
.BYTE 255
.BYTE 252
.BYTE 31
.BYTE 3
.BYTE 255
.BYTE 248
.BYTE 15
.BYTE 3
.BYTE 255
.BYTE 240
.BYTE 3
.BYTE 3
.BYTE 3
.BYTE 255
.BYTE 192
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 255
.BYTE 3
.BYTE 0
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: I
MOSTCOMMON
VAR_I	.REAL 0.0
; VAR: X1
VAR_X1	.REAL 0.0
; VAR: X2
VAR_X2	.REAL 0.0
; VAR: Y1
VAR_Y1	.REAL 0.0
; VAR: Y2
VAR_Y2	.REAL 0.0
; VAR: CO
VAR_CO	.REAL 0.0
; VAR: MU
VAR_MU	.REAL 0.0
; VAR: H1
VAR_H1	.REAL 0.0
; VAR: V1
VAR_V1	.REAL 0.0
; VAR: H2
VAR_H2	.REAL 0.0
; VAR: V2
VAR_V2	.REAL 0.0
; VAR: CC
VAR_CC	.REAL 0.0
; VAR: CO[]
.BYTE 1
.WORD 120
VAR_CO[]	.ARRAY 120
; VAR: X[]
.BYTE 1
.WORD 40
VAR_X[]	.ARRAY 40
; VAR: Y[]
.BYTE 1
.WORD 40
VAR_Y[]	.ARRAY 40
; VAR: XS[]
.BYTE 1
.WORD 40
VAR_XS[]	.ARRAY 40
; VAR: YS[]
.BYTE 1
.WORD 40
VAR_YS[]	.ARRAY 40
; VAR: A
VAR_A	.REAL 0.0
; VAR: P2[]
.BYTE 1
.WORD 40
VAR_P2[]	.ARRAY 40
; VAR: B
VAR_B	.REAL 0.0
; VAR: SN
VAR_SN	.REAL 0.0
; VAR: XA
VAR_XA	.REAL 0.0
; VAR: XE
VAR_XE	.REAL 0.0
; VAR: YA
VAR_YA	.REAL 0.0
; VAR: YE
VAR_YE	.REAL 0.0
; VAR: SC[]
.BYTE 1
.WORD 125
VAR_SC[]	.ARRAY 125
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: MP
VAR_MP	.REAL 0.0
; VAR: TI
VAR_TI	.REAL 0.0
STRINGVARS_START
; VAR: TI$
VAR_TI$	.WORD EMPTYSTR
; VAR: A$
VAR_A$	.WORD EMPTYSTR
STRINGVARS_END
STRINGARRAYS_START
; VAR: A$[]
.BYTE 2
.WORD 4002
VAR_A$[]
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
