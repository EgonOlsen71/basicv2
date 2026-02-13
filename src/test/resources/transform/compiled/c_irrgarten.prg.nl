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
LDA #0
STA VAR_C0
STA VAR_C0+1
STA VAR_C0+2
STA VAR_C0+3
STA VAR_C0+4
LDX #4
dcloop235_1:
LDA CONST_1R,X
STA VAR_C1,X
LDA CONST_2R,X
STA VAR_C2,X
LDA CONST_3R,X
STA VAR_C3,X
LDA CONST_4R,X
STA VAR_C4,X
LDA CONST_5R,X
STA VAR_C7,X
DEX
BPL dcloop235_1
; Special rule: Aggregation of assignments (5)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_20:
;
;
LINE_30:
;
;
LINE_40:
;
LDA #<CONST_6
LDY #>CONST_6
STA A_REG
STY A_REG+1
LDA #<CONST_1R
LDY #>CONST_1R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<CONST_7
LDY #>CONST_7
STA A_REG
STY A_REG+1
LDA #<CONST_2R
LDY #>CONST_2R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<CONST_8
LDY #>CONST_8
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
LDA #<CONST_9
LDY #>CONST_9
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
LINE_50:
;
;
LINE_60:
;
;
LINE_70:
;
LDA #0
STA VAR_M1
STA VAR_M1+1
STA VAR_M1+2
STA VAR_M1+3
STA VAR_M1+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_11
LDY #>CONST_11
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_80:
;
INPUT3:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_12
LDY #>CONST_12
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP0:
BEQ INPUT3_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP INPUT3
INPUT3_0:
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP4
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_H
LDY #>VAR_H
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP4:
JSR QUEUESIZE
LDA X_REG
COMP_SKP1:
BEQ INPUTCHECK3
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK3:
;
LINE_90:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_H
LDY #>VAR_H
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT0
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP0
GT_GT0:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP0:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_H
LDY #>VAR_H
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
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP2:
BEQ LINE_SKIP206
; Simplified conditional branch
;
LINE_NSKIP206:
;
LDA #<CONST_15
LDY #>CONST_15
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_80
;
LINE_SKIP206:
;
;
LINE_100:
;
INPUT4:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_16
LDY #>CONST_16
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP3:
BEQ INPUT4_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP INPUT4
INPUT4_0:
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP5
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_V
LDY #>VAR_V
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP5:
JSR QUEUESIZE
LDA X_REG
COMP_SKP4:
BEQ INPUTCHECK4
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK4:
;
LINE_110:
;
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
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
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP5:
BEQ LINE_SKIP207
; Simplified conditional branch
;
LINE_NSKIP207:
;
LDA #<CONST_15
LDY #>CONST_15
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_100
;
LINE_SKIP207:
;
;
LINE_120:
;
LDA #<CONST_18
LDY #>CONST_18
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_H
LDY #>VAR_H
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #88
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<VAR_V
LDY #>VAR_V
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<CONST_20
LDY #>CONST_20
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_130:
;
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<VAR_H
LDY #>VAR_H
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
;
LINE_140:
;
LDA #0
STA VAR_Q
STA VAR_Q+1
STA VAR_Q+2
STA VAR_Q+3
STA VAR_Q+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_Z
STA VAR_Z+1
STA VAR_Z+2
STA VAR_Z+3
STA VAR_Z+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_150:
;
LDX #4
dcloop235_6:
LDA VAR_X,X
STA VAR_AA,X
DEX
BPL dcloop235_6
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_160:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_21
LDY #>CONST_21
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDX #4
dcloop235_7:
LDA CONST_22,X
STA VAR_C,X
DEX
BPL dcloop235_7
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_170:
LDX #4
dcloop235_8:
LDA VAR_X,X
STA VAR_R,X
LDA CONST_21,X
STA VAR_S,X
DEX
BPL dcloop235_8
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_240
;
LINE_180:
;
LDX #4
dcneloop5315_1:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_NSKIP208
DEX
BPL dcneloop5315_1
JMP LINE_SKIP208
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP208:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_220
;
LINE_SKIP208:
;
;
LINE_190:
;
LDX #4
dcneloop5315_2:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP209
DEX
BPL dcneloop5315_2
JMP LINE_SKIP209
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP209:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_210
;
LINE_SKIP209:
;
;
LINE_200:
LDX #4
dcloop401_1:
LDA CONST_21,X
STA VAR_R,X
LDA CONST_21,X
STA VAR_S,X
DEX
BPL dcloop401_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_230
;
LINE_210:
;
LDX #4
dcloop401_3:
LDA CONST_21,X
STA VAR_R,X
DEX
BPL dcloop401_3
; Optimizer rule: Direct copy of floats into mem/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_S
LDY #>VAR_S
; FAC to (X/Y)
JSR FACMEM
JMP LINE_230
;
LINE_220:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
LINE_230:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
BEQ EQ_EQ6
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP6
EQ_EQ6:
LDA #$1
EQ_SKIP6:
COMP_SKP8:
BEQ LINE_SKIP210
; Simplified conditional branch
;
LINE_NSKIP210:
;
JMP LINE_180
;
LINE_SKIP210:
;
;
LINE_240:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR CMPFAC
EQ_EQ7:
EQ_SKIP7:
COMP_SKP9:
BNE LINE_SKIP211
LINE_NSKIP211:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_560
;
LINE_SKIP211:
;
;
LINE_250:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP10:
BEQ LINE_SKIP212
; Simplified conditional branch
;
LINE_NSKIP212:
;
JMP LINE_560
;
LINE_SKIP212:
;
;
LINE_260:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR CMPFAC
EQ_EQ8:
EQ_SKIP8:
COMP_SKP11:
BNE LINE_SKIP213
LINE_NSKIP213:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_400
;
LINE_SKIP213:
;
;
LINE_270:
;
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP12:
BEQ LINE_SKIP214
; Simplified conditional branch
;
LINE_NSKIP214:
;
JMP LINE_400
;
LINE_SKIP214:
;
;
LINE_280:
;
LDX #4
dceloop5314_1:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_SKIP215
DEX
BPL dceloop5314_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP215:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_320
;
LINE_SKIP215:
;
;
LINE_290:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP14:
BEQ LINE_SKIP216
; Simplified conditional branch
;
LINE_NSKIP216:
;
JMP LINE_320
;
LINE_SKIP216:
;
;
LINE_300:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_23
LDY #>CONST_23
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Faster RND/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_310:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON8SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP15:
BNE AFTER8SUB0
JMP LINE_870
AFTER8SUB0:
ON8SUB1:
INX
CPX TMP_ZP
COMP_SKP16:
BNE AFTER8SUB1
JMP LINE_910
AFTER8SUB1:
ON8SUB2:
INX
CPX TMP_ZP
COMP_SKP17:
BNE AFTER8SUB2
JMP LINE_950
AFTER8SUB2:
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
GSKIPON8:
;
LINE_320:
;
LDX #4
dcneloop5315_3:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP217
DEX
BPL dcneloop5315_3
JMP LINE_SKIP217
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP217:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_350
;
LINE_SKIP217:
;
;
LINE_330:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ11:
EQ_SKIP11:
COMP_SKP19:
BNE LINE_SKIP218
LINE_NSKIP218:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_380
;
LINE_SKIP218:
;
;
LINE_340:
;
LDX #4
dcloop567_1:
LDA CONST_21,X
STA VAR_Q,X
DEX
BPL dcloop567_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_360
;
LINE_350:
;
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP20:
BEQ LINE_SKIP219
; Simplified conditional branch
;
LINE_NSKIP219:
;
JMP LINE_380
;
LINE_SKIP219:
;
;
LINE_360:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_23
LDY #>CONST_23
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Faster RND/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_370:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON9SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP21:
BNE AFTER9SUB0
JMP LINE_870
AFTER9SUB0:
ON9SUB1:
INX
CPX TMP_ZP
COMP_SKP22:
BNE AFTER9SUB1
JMP LINE_910
AFTER9SUB1:
ON9SUB2:
INX
CPX TMP_ZP
COMP_SKP23:
BNE AFTER9SUB2
JMP LINE_1020
AFTER9SUB2:
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
GSKIPON9:
;
LINE_380:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_390:
;
JMP LINE_370
;
LINE_400:
;
LDX #4
dceloop5314_2:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_SKIP220
DEX
BPL dceloop5314_2
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP220:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_500
;
LINE_SKIP220:
;
;
LINE_410:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP25:
BEQ LINE_SKIP221
; Simplified conditional branch
;
LINE_NSKIP221:
;
JMP LINE_500
;
LINE_SKIP221:
;
;
LINE_420:
;
LDX #4
dcneloop5315_4:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP222
DEX
BPL dcneloop5315_4
JMP LINE_SKIP222
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP222:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_450
;
LINE_SKIP222:
;
;
LINE_430:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ14:
EQ_SKIP14:
COMP_SKP27:
BNE LINE_SKIP223
LINE_NSKIP223:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_480
;
LINE_SKIP223:
;
;
LINE_440:
;
LDX #4
dcloop733_1:
LDA CONST_21,X
STA VAR_Q,X
DEX
BPL dcloop733_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_460
;
LINE_450:
;
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP28:
BEQ LINE_SKIP224
; Simplified conditional branch
;
LINE_NSKIP224:
;
JMP LINE_480
;
LINE_SKIP224:
;
;
LINE_460:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_23
LDY #>CONST_23
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Faster RND/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_470:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON10SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP29:
BNE AFTER10SUB0
JMP LINE_870
AFTER10SUB0:
ON10SUB1:
INX
CPX TMP_ZP
COMP_SKP30:
BNE AFTER10SUB1
JMP LINE_950
AFTER10SUB1:
ON10SUB2:
INX
CPX TMP_ZP
COMP_SKP31:
BNE AFTER10SUB2
JMP LINE_1020
AFTER10SUB2:
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
GSKIPON10:
;
LINE_480:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_490:
;
JMP LINE_470
;
LINE_500:
;
LDX #4
dcneloop5315_5:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP225
DEX
BPL dcneloop5315_5
JMP LINE_SKIP225
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP225:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_530
;
LINE_SKIP225:
;
;
LINE_510:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ16:
EQ_SKIP16:
COMP_SKP33:
BNE LINE_SKIP226
LINE_NSKIP226:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_870
;
LINE_SKIP226:
;
;
LINE_520:
;
LDX #4
dcloop733_2:
LDA CONST_21,X
STA VAR_Q,X
DEX
BPL dcloop733_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_540
;
LINE_530:
;
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP34:
BEQ LINE_SKIP227
; Simplified conditional branch
;
LINE_NSKIP227:
;
JMP LINE_870
;
LINE_SKIP227:
;
;
LINE_540:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_550:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON11SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP35:
BNE AFTER11SUB0
JMP LINE_870
AFTER11SUB0:
ON11SUB1:
INX
CPX TMP_ZP
COMP_SKP36:
BNE AFTER11SUB1
JMP LINE_1020
AFTER11SUB1:
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
GSKIPON11:
;
LINE_560:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR CMPFAC
EQ_EQ17:
EQ_SKIP17:
COMP_SKP37:
BNE LINE_SKIP228
LINE_NSKIP228:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_740
;
LINE_SKIP228:
;
;
LINE_570:
;
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP38:
BEQ LINE_SKIP229
; Simplified conditional branch
;
LINE_NSKIP229:
;
JMP LINE_740
;
LINE_SKIP229:
;
;
LINE_580:
;
LDX #4
dceloop5314_3:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_SKIP230
DEX
BPL dceloop5314_3
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP230:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_680
;
LINE_SKIP230:
;
;
LINE_590:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP40:
BEQ LINE_SKIP231
; Simplified conditional branch
;
LINE_NSKIP231:
;
JMP LINE_680
;
LINE_SKIP231:
;
;
LINE_600:
;
LDX #4
dcneloop5315_6:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP232
DEX
BPL dcneloop5315_6
JMP LINE_SKIP232
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP232:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_630
;
LINE_SKIP232:
;
;
LINE_610:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ20:
EQ_SKIP20:
COMP_SKP42:
BNE LINE_SKIP233
LINE_NSKIP233:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_660
;
LINE_SKIP233:
;
;
LINE_620:
;
LDX #4
dcloop899_1:
LDA CONST_21,X
STA VAR_Q,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_640
;
LINE_630:
;
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP43:
BEQ LINE_SKIP234
; Simplified conditional branch
;
LINE_NSKIP234:
;
JMP LINE_660
;
LINE_SKIP234:
;
;
LINE_640:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_23
LDY #>CONST_23
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Faster RND/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_650:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON12SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP44:
BNE AFTER12SUB0
JMP LINE_910
AFTER12SUB0:
ON12SUB1:
INX
CPX TMP_ZP
COMP_SKP45:
BNE AFTER12SUB1
JMP LINE_950
AFTER12SUB1:
ON12SUB2:
INX
CPX TMP_ZP
COMP_SKP46:
BNE AFTER12SUB2
JMP LINE_1020
AFTER12SUB2:
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
GSKIPON12:
;
LINE_660:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_670:
;
JMP LINE_650
;
LINE_680:
;
LDX #4
dcneloop5315_7:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP235
DEX
BPL dcneloop5315_7
JMP LINE_SKIP235
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP235:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_710
;
LINE_SKIP235:
;
;
LINE_690:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ22:
EQ_SKIP22:
COMP_SKP48:
BNE LINE_SKIP236
LINE_NSKIP236:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_910
;
LINE_SKIP236:
;
;
LINE_700:
;
LDX #4
dcloop1065_1:
LDA CONST_21,X
STA VAR_Q,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_720
;
LINE_710:
;
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP49:
BEQ LINE_SKIP237
; Simplified conditional branch
;
LINE_NSKIP237:
;
JMP LINE_910
;
LINE_SKIP237:
;
;
LINE_720:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_730:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON13SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP50:
BNE AFTER13SUB0
JMP LINE_910
AFTER13SUB0:
ON13SUB1:
INX
CPX TMP_ZP
COMP_SKP51:
BNE AFTER13SUB1
JMP LINE_1020
AFTER13SUB1:
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
GSKIPON13:
;
LINE_740:
;
LDX #4
dceloop5314_4:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_SKIP238
DEX
BPL dceloop5314_4
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP238:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_820
;
LINE_SKIP238:
;
;
LINE_750:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP53:
BEQ LINE_SKIP239
; Simplified conditional branch
;
LINE_NSKIP239:
;
JMP LINE_820
;
LINE_SKIP239:
;
;
LINE_760:
;
LDX #4
dcneloop5315_8:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP240
DEX
BPL dcneloop5315_8
JMP LINE_SKIP240
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP240:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_790
;
LINE_SKIP240:
;
;
LINE_770:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ25:
EQ_SKIP25:
COMP_SKP55:
BNE LINE_SKIP241
LINE_NSKIP241:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_950
;
LINE_SKIP241:
;
;
LINE_780:
;
LDX #4
dcloop1065_2:
LDA CONST_21,X
STA VAR_Q,X
DEX
BPL dcloop1065_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_800
;
LINE_790:
;
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP56:
BEQ LINE_SKIP242
; Simplified conditional branch
;
LINE_NSKIP242:
;
JMP LINE_950
;
LINE_SKIP242:
;
;
LINE_800:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_810:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON14SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP57:
BNE AFTER14SUB0
JMP LINE_950
AFTER14SUB0:
ON14SUB1:
INX
CPX TMP_ZP
COMP_SKP58:
BNE AFTER14SUB1
JMP LINE_1020
AFTER14SUB1:
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
GSKIPON14:
;
LINE_820:
;
LDX #4
dcneloop5315_9:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP243
DEX
BPL dcneloop5315_9
JMP LINE_SKIP243
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP243:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_850
;
LINE_SKIP243:
;
;
LINE_830:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ27:
EQ_SKIP27:
COMP_SKP60:
BNE LINE_SKIP244
LINE_NSKIP244:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_180
;
LINE_SKIP244:
;
;
LINE_840:
;
LDX #4
dcloop1231_1:
LDA CONST_21,X
STA VAR_Q,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_860
;
LINE_850:
;
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
COMP_SKP61:
BEQ LINE_SKIP245
; Simplified conditional branch
;
LINE_NSKIP245:
;
JMP LINE_180
;
LINE_SKIP245:
;
;
LINE_860:
;
JMP LINE_1020
;
LINE_870:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_C
LDY #>VAR_C
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_880:
;
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_22
LDY #>CONST_22
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_R
LDY #>VAR_R
; FAC to (X/Y)
JSR FACMEM
;
LINE_890:
;
LDX #4
dceloop5314_5:
LDA VAR_A,X
CMP VAR_C,X
BNE LINE_SKIP246
DEX
BPL dceloop5314_5
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP246:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1120
;
LINE_SKIP246:
;
;
LINE_900:
;
LDA #0
STA VAR_Q
STA VAR_Q+1
STA VAR_Q+2
STA VAR_Q+3
STA VAR_Q+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_240
;
LINE_910:
;
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_C
LDY #>VAR_C
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_920:
;
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
LINE_930:
;
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_21
LDY #>CONST_21
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_S
LDY #>VAR_S
; FAC to (X/Y)
JSR FACMEM
LDX #4
dceloop5314_6:
LDA VAR_A,X
CMP VAR_C,X
BNE LINE_SKIP247
DEX
BPL dceloop5314_6
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP247:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1120
;
LINE_SKIP247:
;
;
LINE_940:
;
LDA #0
STA VAR_Q
STA VAR_Q+1
STA VAR_Q+2
STA VAR_Q+3
STA VAR_Q+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_240
;
LINE_950:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_C
LDY #>VAR_C
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_960:
;
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
BEQ EQ_EQ30
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP30
EQ_EQ30:
LDA #$1
EQ_SKIP30:
COMP_SKP64:
BEQ LINE_SKIP248
; Simplified conditional branch
;
LINE_NSKIP248:
;
JMP LINE_980
;
LINE_SKIP248:
;
;
LINE_970:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_23
LDY #>CONST_23
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JMP LINE_990
;
LINE_980:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_22
LDY #>CONST_22
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_990:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
LINE_1000:
;
LDX #4
dceloop5314_7:
LDA VAR_A,X
CMP VAR_C,X
BNE LINE_SKIP249
DEX
BPL dceloop5314_7
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP249:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1120
;
LINE_SKIP249:
;
;
LINE_1010:
;
JMP LINE_560
;
LINE_1020:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Q
LDY #>VAR_Q
JSR CMPFAC
EQ_EQ32:
EQ_SKIP32:
COMP_SKP66:
BNE LINE_SKIP250
LINE_NSKIP250:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1080
;
LINE_SKIP250:
;
;
LINE_1030:
;
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_C
LDY #>VAR_C
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
BEQ EQ_EQ33
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP33
EQ_EQ33:
LDA #$1
EQ_SKIP33:
COMP_SKP67:
BEQ LINE_SKIP251
; Simplified conditional branch
;
LINE_NSKIP251:
;
JMP LINE_1050
;
LINE_SKIP251:
;
;
LINE_1040:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_23
LDY #>CONST_23
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JMP LINE_1060
;
LINE_1050:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_21
LDY #>CONST_21
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1060:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_S
LDY #>VAR_S
; FAC to (X/Y)
JSR FACMEM
LDX #4
dceloop5314_8:
LDA VAR_A,X
CMP VAR_C,X
BNE LINE_SKIP252
DEX
BPL dceloop5314_8
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP252:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1120
;
LINE_SKIP252:
;
;
LINE_1070:
;
JMP LINE_240
;
LINE_1080:
;
LDX #4
dcloop1563_1:
LDA CONST_21,X
STA VAR_Z,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1090:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
BEQ EQ_EQ35
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP35
EQ_EQ35:
LDA #$1
EQ_SKIP35:
COMP_SKP69:
BEQ LINE_SKIP253
; Simplified conditional branch
;
LINE_NSKIP253:
;
JMP LINE_1110
;
LINE_SKIP253:
;
;
LINE_1100:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_23
LDY #>CONST_23
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #0
STA VAR_Q
STA VAR_Q+1
STA VAR_Q+2
STA VAR_Q+3
STA VAR_Q+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_180
;
LINE_1110:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_21
LDY #>CONST_21
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #0
STA VAR_Q
STA VAR_Q+1
STA VAR_Q+2
STA VAR_Q+3
STA VAR_Q+4
LDX #4
dcloop1729_1:
LDA CONST_21,X
STA VAR_R,X
LDA CONST_21,X
STA VAR_S,X
DEX
BPL dcloop1729_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_230
;
LINE_1120:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ36
LDA #0
JMP NEQ_SKIP36
NEQ_NEQ36:
LDA #$1
NEQ_SKIP36:
COMP_SKP70:
BNE LINE_NSKIP254
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP254
;
LINE_NSKIP254:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_V
LDY #>VAR_V
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_V
LDY #>VAR_V
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_SKIP254:
;
;
LINE_1130:
;
JSR GOSUB
JSR LINE_1140
LDA #<VAR_AA
LDY #>VAR_AA
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
JSR PUSHREAL
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<CONST_24
LDY #>CONST_24
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_25
LDY #>CONST_25
JSR REALFAC
LDA #<CONST_26
LDY #>CONST_26
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_27R
LDY #>CONST_27R
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
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF1+1
STA MOVBSELF1+2
LDA #$1E
MOVBSELF1:
STA $FFFF
JMP LINE_1410
;
LINE_1140:
;
;
LINE_1150:
;
LDX #4
dcloop1895_1:
LDA CONST_21,X
STA VAR_M1,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dceloop5314_9:
LDA CONST_30R,X
CMP VAR_V,X
BNE LINE_SKIP255
DEX
BPL dceloop5314_9
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP255:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1170
;
LINE_SKIP255:
;
;
LINE_1160:
;
LDX #4
dcloop1895_2:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop1895_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<CONST_30R
LDY #>CONST_30R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
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
JSR LINEBREAK
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
LINE_1170:
;
LDX #4
dcloop1895_3:
LDA VAR_V,X
STA VAR_J,X
DEX
BPL dcloop1895_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_21
LDY #>CONST_21
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_31
LDY #>CONST_31
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
LDA #<FORLOOP1
STA JUMP_TARGET
LDA #>FORLOOP1
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP1:
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
LDA #<CONST_14R
LDY #>CONST_14R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
;
LINE_1180:
;
LDX #4
dcloop1895_4:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop1895_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
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
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1190:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA X_REG
BEQ EQ_EQ38
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP38
EQ_EQ38:
LDA #$1
EQ_SKIP38:
COMP_SKP73:
BEQ LINE_SKIP256
; Simplified conditional branch
;
LINE_NSKIP256:
;
JMP LINE_1230
;
LINE_SKIP256:
;
;
LINE_1200:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ39:
EQ_SKIP39:
COMP_SKP74:
BNE LINE_SKIP257
LINE_NSKIP257:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1230
;
LINE_SKIP257:
;
;
LINE_1210:
;
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1220:
;
JMP LINE_1240
;
LINE_1230:
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_1240:
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
;
LINE_1250:
;
LDA #32
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1260:
;
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
LDA #<CONST_14R
LDY #>CONST_14R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1270:
;
LDX #4
dcloop1895_5:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop1895_5
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
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
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1280:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ40
ROL
BCC LT_LT40
LT_LT_EQ40:
LDA #0
JMP LT_SKIP40
LT_LT40:
LDA #$1
LT_SKIP40:
COMP_SKP76:
BEQ LINE_SKIP258
; Simplified conditional branch
;
LINE_NSKIP258:
;
JMP LINE_1310
;
LINE_SKIP258:
;
;
LINE_1290:
;
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1300:
;
JMP LINE_1320
;
LINE_1310:
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_1320:
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
JSR LINEBREAK
;
LINE_1340:
;
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_3
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_3:
;
LINE_1350:
;
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
LDA #<CONST_14R
LDY #>CONST_14R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop2061_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop2061_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
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
LINE_1360:
;
LDX #4
dceloop5314_10:
LDA VAR_AA,X
CMP VAR_I,X
BNE LINE_SKIP259
DEX
BPL dceloop5314_10
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP259:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1380
;
LINE_SKIP259:
;
;
LINE_1370:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_1390
;
LINE_1380:
;
LDA #<CONST_37
LDY #>CONST_37
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1390:
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
LINE_1400:
;
LDA #32
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_1410:
;
LDX #4
dcloop2061_2:
LDA VAR_AA,X
STA VAR_W,X
DEX
BPL dcloop2061_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1420:
;
LDA #0
STA VAR_J
STA VAR_J+1
STA VAR_J+2
STA VAR_J+3
STA VAR_J+4
; Optimizer rule: Simplified setting to 0/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_V
LDY #>VAR_V
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
;
LINE_1430:
;
LDX #4
dcloop2061_3:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop2061_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
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
LINE_1440:
;
LDA VAR_J
COMP_SKP81:
BEQ LINE_SKIP260
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP260:
;
JMP LINE_1470
;
LINE_SKIP260:
;
;
LINE_1450:
;
LDA #<VAR_W
LDY #>VAR_W
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ42
LDA #0
JMP EQ_SKIP42
EQ_EQ42:
LDA #$1
EQ_SKIP42:
COMP_SKP82:
BNE LINE_NSKIP261
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP261
;
LINE_NSKIP261:
;
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<CONST_23
LDY #>CONST_23
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JMP LINE_1490
;
LINE_SKIP261:
;
;
LINE_1460:
;
LDX #4
dcloop2061_4:
LDA CONST_21,X
STA VAR_M,X
DEX
BPL dcloop2061_4
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_1480
;
LINE_1470:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
;
LINE_1480:
;
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #3
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<CONST_23
LDY #>CONST_23
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
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
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1490:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ43:
EQ_SKIP43:
COMP_SKP83:
BNE LINE_SKIP262
LINE_NSKIP262:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2227_1:
LDA CONST_21,X
STA VAR_M,X
DEX
BPL dcloop2227_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_1510
;
LINE_SKIP262:
;
;
LINE_1500:
;
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #2
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
;
LINE_1510:
;
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<VAR_M
LDY #>VAR_M
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
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1520:
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
LINE_1530:
;
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
;
LINE_1540:
;
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1550:
;
LDX #4
dcloop2227_2:
LDA VAR_W,X
STA VAR_X,X
DEX
BPL dcloop2227_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
LDX #4
dcloop2227_3:
LDA CONST_21,X
STA VAR_Z,X
LDA CONST_21,X
STA VAR_EL,X
LDA CONST_21,X
STA VAR_ER,X
DEX
BPL dcloop2227_3
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1560:
;
JMP LINE_2260
;
LINE_1570:
;
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1580:
;
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1590:
;
LDA #<CONST_40
LDY #>CONST_40
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1600:
;
LDA #<CONST_41
LDY #>CONST_41
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1610:
;
LDA #<CONST_42
LDY #>CONST_42
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1620:
;
JMP RETURN
;
LINE_1630:
;
JSR GOSUB
JSR LINE_1140
LDA #<CONST_43
LDY #>CONST_43
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_Z
LDY #>VAR_Z
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
LINE_1640:
;
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
LDA #<CONST_44
LDY #>CONST_44
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_X
LDY #>VAR_X
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
JSR PUSHREAL
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<CONST_24
LDY #>CONST_24
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_25
LDY #>CONST_25
JSR REALFAC
LDA #<CONST_26
LDY #>CONST_26
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_27R
LDY #>CONST_27R
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
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF2+1
STA MOVBSELF2+2
LDA #$66
MOVBSELF2:
STA $FFFF
;
LINE_1650:
;
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT44
LDA #0
JMP GT_SKIP44
GT_GT44:
LDA #$1
GT_SKIP44:
COMP_SKP86:
BEQ LINE_SKIP263
; Simplified conditional branch
;
LINE_NSKIP263:
;
JMP LINE_4520
;
LINE_SKIP263:
;
;
LINE_1660:
;
LDA #<CONST_46
LDY #>CONST_46
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1670:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
LDA #<CONST_47
LDY #>CONST_47
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP87:
BEQ LINE_SKIP264
; Simplified conditional branch
;
LINE_NSKIP264:
;
JMP LINE_1670
;
LINE_SKIP264:
;
;
LINE_1680:
;
LDA #<CONST_48
LDY #>CONST_48
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP88:
BEQ LINE_SKIP265
; Simplified conditional branch
;
LINE_NSKIP265:
;
JMP LINE_1730
;
LINE_SKIP265:
;
;
LINE_1690:
;
LDA #<CONST_49
LDY #>CONST_49
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP89:
BEQ LINE_SKIP266
; Simplified conditional branch
;
LINE_NSKIP266:
;
JMP LINE_1750
;
LINE_SKIP266:
;
;
LINE_1700:
;
LDA #<CONST_50
LDY #>CONST_50
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP90:
BEQ LINE_SKIP267
; Simplified conditional branch
;
LINE_NSKIP267:
;
JMP LINE_2210
;
LINE_SKIP267:
;
;
LINE_1710:
;
LDA #<CONST_51
LDY #>CONST_51
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP91:
BEQ LINE_SKIP268
; Simplified conditional branch
;
LINE_NSKIP268:
;
JMP LINE_1630
;
LINE_SKIP268:
;
;
LINE_1720:
;
JMP LINE_1670
;
LINE_1730:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ45
ROL
BCC LT_LT45
LT_LT_EQ45:
LDA #0
JMP LT_SKIP45
LT_LT45:
LDA #$1
LT_SKIP45:
COMP_SKP92:
BEQ LINE_SKIP269
; Simplified conditional branch
;
LINE_NSKIP269:
;
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP269:
;
;
LINE_1740:
;
JMP LINE_2260
;
LINE_1750:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT46
LDA #0
JMP GT_SKIP46
GT_GT46:
LDA #$1
GT_SKIP46:
COMP_SKP93:
BEQ LINE_SKIP270
; Simplified conditional branch
;
LINE_NSKIP270:
;
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP270:
;
;
LINE_1760:
;
JMP LINE_2260
;
LINE_1770:
;
JMP RETURN
;
LINE_1780:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ47
LDA #0
JMP EQ_SKIP47
EQ_EQ47:
LDA #$1
EQ_SKIP47:
COMP_SKP94:
BNE LINE_NSKIP271
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP271
;
LINE_NSKIP271:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A1
LDY #>VAR_A1
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B1
LDY #>VAR_B1
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1830
;
LINE_SKIP271:
;
;
LINE_1790:
;
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ48
ROL
BCC LT_LT48
LT_LT_EQ48:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP48
LT_LT48:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP48:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ49
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP49
EQ_EQ49:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP49:
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
COMP_SKP95:
BEQ LINE_SKIP272
; Simplified conditional branch
;
LINE_NSKIP272:
LDX #4
dcloop2559_1:
LDA VAR_A,X
STA VAR_A1,X
LDA VAR_B,X
STA VAR_B1,X
DEX
BPL dcloop2559_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_1830
;
LINE_SKIP272:
;
;
LINE_1800:
;
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ50
LDA #0
JMP EQ_SKIP50
EQ_EQ50:
LDA #$1
EQ_SKIP50:
COMP_SKP96:
BNE LINE_NSKIP273
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP273
;
LINE_NSKIP273:
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
LDX #<VAR_A1
LDY #>VAR_A1
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B1
LDY #>VAR_B1
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1830
;
LINE_SKIP273:
;
;
LINE_1810:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT51
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP51
GT_GT51:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP51:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
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
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP97:
BNE LINE_NSKIP274
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP274
;
LINE_NSKIP274:
;
LDX #4
dcloop2559_3:
LDA VAR_A,X
STA VAR_A1,X
DEX
BPL dcloop2559_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B1
LDY #>VAR_B1
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1830
;
LINE_SKIP274:
;
;
LINE_1820:
;
LDX #4
dcloop2559_4:
LDA CONST_21,X
STA VAR_EL,X
DEX
BPL dcloop2559_4
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_1830:
;
LDA #<VAR_B1
LDY #>VAR_B1
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_A1
LDY #>VAR_A1
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_F
LDY #>VAR_F
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ53:
EQ_SKIP53:
COMP_SKP98:
BNE LINE_SKIP275
LINE_NSKIP275:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1850
;
LINE_SKIP275:
;
;
LINE_1840:
;
LDX #4
dcloop2559_5:
LDA CONST_22,X
STA VAR_I,X
DEX
BPL dcloop2559_5
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #3
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_53R
LDY #>CONST_53R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F
LDY #>VAR_F
; FAC to (X/Y)
JSR FACMEM
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
LINE_1850:
;
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_EL
LDY #>VAR_EL
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_1860:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ54
LDA #0
JMP EQ_SKIP54
EQ_EQ54:
LDA #$1
EQ_SKIP54:
COMP_SKP100:
BNE LINE_NSKIP276
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP276
;
LINE_NSKIP276:
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
LDX #<VAR_A1
LDY #>VAR_A1
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B1
LDY #>VAR_B1
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1910
;
LINE_SKIP276:
;
;
LINE_1870:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT55
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP55
GT_GT55:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP55:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ56
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP56
EQ_EQ56:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP56:
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
COMP_SKP101:
BNE LINE_NSKIP277
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP277
;
LINE_NSKIP277:
;
LDX #4
dcloop2725_1:
LDA VAR_A,X
STA VAR_A1,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B1
LDY #>VAR_B1
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1910
;
LINE_SKIP277:
;
;
LINE_1880:
;
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ57
LDA #0
JMP EQ_SKIP57
EQ_EQ57:
LDA #$1
EQ_SKIP57:
COMP_SKP102:
BNE LINE_NSKIP278
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP278
;
LINE_NSKIP278:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A1
LDY #>VAR_A1
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B1
LDY #>VAR_B1
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1910
;
LINE_SKIP278:
;
;
LINE_1890:
;
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ58
ROL
BCC LT_LT58
LT_LT_EQ58:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP58
LT_LT58:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP58:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ59
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP59
EQ_EQ59:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP59:
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
COMP_SKP103:
BEQ LINE_SKIP279
; Simplified conditional branch
;
LINE_NSKIP279:
LDX #4
dcloop2725_2:
LDA VAR_A,X
STA VAR_A1,X
LDA VAR_B,X
STA VAR_B1,X
DEX
BPL dcloop2725_2
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_1910
;
LINE_SKIP279:
;
;
LINE_1900:
;
LDX #4
dcloop2725_4:
LDA CONST_21,X
STA VAR_ER,X
DEX
BPL dcloop2725_4
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_1910:
;
LDA #<VAR_B1
LDY #>VAR_B1
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_A1
LDY #>VAR_A1
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_F
LDY #>VAR_F
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ60:
EQ_SKIP60:
COMP_SKP104:
BNE LINE_SKIP280
LINE_NSKIP280:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1930
;
LINE_SKIP280:
;
;
LINE_1920:
;
LDX #4
dcloop2725_5:
LDA CONST_22,X
STA VAR_I,X
DEX
BPL dcloop2725_5
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #3
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_53R
LDY #>CONST_53R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F
LDY #>VAR_F
; FAC to (X/Y)
JSR FACMEM
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
LINE_1930:
;
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ER
LDY #>VAR_ER
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_1940:
;
LDA VAR_B
BEQ EQ_SKIP61
EQ_EQ61:
JMP LINE_SKIP281
EQ_SKIP61:
COMP_SKP106:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP281:
;
JMP LINE_2020
;
LINE_SKIP281:
;
;
LINE_1950:
;
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT62
LDA #0
JMP GT_SKIP62
GT_GT62:
LDA #$1
GT_SKIP62:
COMP_SKP107:
BEQ LINE_SKIP282
; Simplified conditional branch
;
LINE_NSKIP282:
;
LDX #4
dcloop2891_1:
LDA CONST_23,X
STA VAR_E,X
DEX
BPL dcloop2891_1
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP282:
;
;
LINE_1960:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_F
LDY #>VAR_F
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ63:
EQ_SKIP63:
COMP_SKP108:
BNE LINE_SKIP283
LINE_NSKIP283:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1980
;
LINE_SKIP283:
;
;
LINE_1970:
;
LDX #4
dcloop2891_2:
LDA CONST_22,X
STA VAR_I,X
DEX
BPL dcloop2891_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #3
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_53R
LDY #>CONST_53R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F
LDY #>VAR_F
; FAC to (X/Y)
JSR FACMEM
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
LINE_1980:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
;
LINE_1990:
;
LDA VAR_C
BEQ EQ_SKIP64
EQ_EQ64:
JMP LINE_SKIP284
EQ_SKIP64:
COMP_SKP110:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP284:
;
JSR GOSUB
JSR LINE_1780
;
LINE_SKIP284:
;
;
LINE_2000:
;
LDA VAR_D
BEQ EQ_SKIP65
EQ_EQ65:
JMP LINE_SKIP285
EQ_SKIP65:
COMP_SKP111:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP285:
;
JSR GOSUB
JSR LINE_1860
;
LINE_SKIP285:
;
;
LINE_2010:
;
JMP RETURN
;
LINE_2020:
;
LDA #0
STA VAR_C
STA VAR_C+1
STA VAR_C+2
STA VAR_C+3
STA VAR_C+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_D
STA VAR_D+1
STA VAR_D+2
STA VAR_D+3
STA VAR_D+4
; Optimizer rule: Simplified setting to 0/6
LDX #4
dcloop2891_3:
LDA CONST_31,X
STA VAR_E,X
DEX
BPL dcloop2891_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2030:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
NEQ_NEQ66:
NEQ_SKIP66:
COMP_SKP112:
BEQ LINE_SKIP286
LINE_NSKIP286:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_2070
;
LINE_SKIP286:
;
;
LINE_2040:
;
LDX #4
dcloop2891_4:
LDA CONST_21,X
STA VAR_E,X
DEX
BPL dcloop2891_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2050:
;
LDX #4
dceloop5314_11:
LDA VAR_W,X
CMP VAR_A,X
BNE LINE_SKIP287
DEX
BPL dceloop5314_11
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP287:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_E
STA VAR_E+1
STA VAR_E+2
STA VAR_E+3
STA VAR_E+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP287:
;
;
LINE_2060:
;
JMP RETURN
;
LINE_2070:
;
LDX #4
dceloop5314_12:
LDA CONST_23,X
CMP VAR_Z,X
BNE LINE_SKIP288
DEX
BPL dceloop5314_12
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP288:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop3057_1:
LDA CONST_22,X
STA VAR_E,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP288:
;
;
LINE_2080:
;
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ69
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP69
EQ_EQ69:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP69:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ70
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP70
EQ_EQ70:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP70:
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
COMP_SKP115:
BEQ LINE_SKIP289
; Simplified conditional branch
;
LINE_NSKIP289:
;
LDX #4
dcloop3057_2:
LDA CONST_22,X
STA VAR_E,X
DEX
BPL dcloop3057_2
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP289:
;
;
LINE_2090:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ71
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP71
EQ_EQ71:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP71:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ72
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP72
EQ_EQ72:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP72:
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
COMP_SKP116:
BEQ LINE_SKIP290
; Simplified conditional branch
;
LINE_NSKIP290:
;
LDX #4
dcloop3057_3:
LDA CONST_22,X
STA VAR_E,X
DEX
BPL dcloop3057_3
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP290:
;
;
LINE_2100:
;
JMP RETURN
;
LINE_2110:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT73
LDA #0
JMP GT_SKIP73
GT_GT73:
LDA #$1
GT_SKIP73:
COMP_SKP117:
BEQ LINE_SKIP291
; Simplified conditional branch
;
LINE_NSKIP291:
;
JMP LINE_2170
;
LINE_SKIP291:
;
;
LINE_2120:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ74:
EQ_SKIP74:
COMP_SKP118:
BNE LINE_SKIP292
LINE_NSKIP292:
; Optimizer rule: Simplified equal comparison/6
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_SKIP292:
;
;
LINE_2130:
;
LDX #4
dceloop5314_13:
LDA CONST_22,X
CMP VAR_Z,X
BNE LINE_SKIP293
DEX
BPL dceloop5314_13
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP293:
; Optimizer rule: Simplified equal comparison/6
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
JMP RETURN
;
LINE_SKIP293:
;
;
LINE_2140:
;
LDX #4
dceloop5314_14:
LDA CONST_23,X
CMP VAR_Z,X
BNE LINE_SKIP294
DEX
BPL dceloop5314_14
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP294:
; Optimizer rule: Simplified equal comparison/6
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_SKIP294:
;
;
LINE_2150:
;
LDX #4
dceloop5314_15:
LDA CONST_52,X
CMP VAR_Z,X
BNE LINE_SKIP295
DEX
BPL dceloop5314_15
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP295:
; Optimizer rule: Simplified equal comparison/6
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_SKIP295:
;
;
LINE_2160:
;
LDA #<CONST_54
LDY #>CONST_54
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_2170:
;
LDA VAR_E
BEQ EQ_SKIP78
EQ_EQ78:
JMP LINE_SKIP296
EQ_SKIP78:
COMP_SKP122:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP296:
;
JMP LINE_2190
;
LINE_SKIP296:
;
;
LINE_2180:
;
LDA #<CONST_55
LDY #>CONST_55
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_2190:
;
LDX #4
dcloop3057_4:
LDA CONST_21,X
STA VAR_S,X
DEX
BPL dcloop3057_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2200:
;
JMP RETURN
;
LINE_2210:
LDX #4
dcloop3057_5:
LDA VAR_X,X
STA VAR_A,X
LDA VAR_Y,X
STA VAR_B,X
DEX
BPL dcloop3057_5
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2220:
;
JSR GOSUB
JSR LINE_1940
;
LINE_2230:
;
JSR GOSUB
JSR LINE_2110
;
LINE_2240:
LDX #4
dcloop3223_1:
LDA VAR_A,X
STA VAR_X,X
LDA VAR_B,X
STA VAR_Y,X
DEX
BPL dcloop3223_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2250:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT79
LDA #0
JMP GT_SKIP79
GT_GT79:
LDA #$1
GT_SKIP79:
COMP_SKP123:
BEQ LINE_SKIP297
; Simplified conditional branch
;
LINE_NSKIP297:
;
JMP LINE_1650
;
LINE_SKIP297:
;
;
LINE_2260:
LDX #4
dcloop3223_3:
LDA VAR_X,X
STA VAR_A,X
LDA VAR_Y,X
STA VAR_B,X
DEX
BPL dcloop3223_3
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2270:
;
JSR GOSUB
JSR LINE_1940
;
LINE_2280:
;
;
LINE_2290:
;
LDX #4
dcloop3223_5:
LDA CONST_21,X
STA VAR_T,X
DEX
BPL dcloop3223_5
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_56R
LDY #>CONST_56R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_T
LDY #>VAR_T
STA A_REG
STY A_REG+1
LDA #<FORLOOP10
STA JUMP_TARGET
LDA #>FORLOOP10
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP10:
;
LINE_2300:
;
JSR GOSUB
JSR LINE_2410
;
LINE_2310:
;
LDA VAR_E
COMP_SKP124:
BEQ LINE_SKIP298
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP298:
;
LDX #4
dcloop3223_6:
LDA CONST_57,X
STA VAR_T,X
DEX
BPL dcloop3223_6
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_2350
;
LINE_SKIP298:
;
;
LINE_2320:
;
JSR GOSUB
JSR LINE_2110
;
LINE_2330:
;
JSR GOSUB
JSR LINE_1940
;
LINE_2340:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT80
LDA #0
JMP GT_SKIP80
GT_GT80:
LDA #$1
GT_SKIP80:
COMP_SKP125:
BEQ LINE_SKIP299
; Simplified conditional branch
;
LINE_NSKIP299:
;
LDX #4
dcloop3223_7:
LDA CONST_57,X
STA VAR_T,X
DEX
BPL dcloop3223_7
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_2350
;
LINE_SKIP299:
;
;
LINE_2350:
;
LDA #<VAR_T
LDY #>VAR_T
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_10
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_10:
;
LINE_2360:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ81
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP81
EQ_EQ81:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP81:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ82
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP82
EQ_EQ82:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP82:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_W
LDY #>VAR_W
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ83
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP83
EQ_EQ83:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP83:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP127:
BEQ LINE_SKIP300
; Simplified conditional branch
;
LINE_NSKIP300:
;
JMP LINE_2400
;
LINE_SKIP300:
;
;
LINE_2370:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ84
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP84
EQ_EQ84:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP84:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ85
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP85
EQ_EQ85:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP85:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_W
LDY #>VAR_W
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ86
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP86
NEQ_NEQ86:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP86:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP128:
BEQ LINE_SKIP301
; Simplified conditional branch
;
LINE_NSKIP301:
;
JSR GOSUB
JSR LINE_2160
LDA #<CONST_58
LDY #>CONST_58
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2390
;
LINE_SKIP301:
;
;
LINE_2380:
;
JMP LINE_2400
;
LINE_2390:
;
JSR GOSUB
JSR LINE_2160
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2400:
;
JMP LINE_1650
;
LINE_2410:
;
LDA #<VAR_T
LDY #>VAR_T
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON15SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP129:
BNE AFTER15SUB0
JMP LINE_2420
AFTER15SUB0:
ON15SUB1:
INX
CPX TMP_ZP
COMP_SKP130:
BNE AFTER15SUB1
JMP LINE_2780
AFTER15SUB1:
ON15SUB2:
INX
CPX TMP_ZP
COMP_SKP131:
BNE AFTER15SUB2
JMP LINE_3220
AFTER15SUB2:
ON15SUB3:
INX
CPX TMP_ZP
COMP_SKP132:
BNE AFTER15SUB3
JMP LINE_3710
AFTER15SUB3:
ON15SUB4:
INX
CPX TMP_ZP
COMP_SKP133:
BNE AFTER15SUB4
JMP LINE_4250
AFTER15SUB4:
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
;
;
;
;
;
;
GSKIPON15:
;
LINE_2420:
;
;
LINE_2430:
;
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_2440:
;
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT87
LDA #0
JMP GT_SKIP87
GT_GT87:
LDA #$1
GT_SKIP87:
COMP_SKP134:
BEQ LINE_SKIP302
; Simplified conditional branch
;
LINE_NSKIP302:
;
JMP RETURN
;
LINE_SKIP302:
;
;
LINE_2450:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT88
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP88
GT_GT88:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP88:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ89
ROL
BCC LT_LT89
LT_LT_EQ89:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP89
LT_LT89:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP89:
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
COMP_SKP135:
BEQ LINE_SKIP303
; Simplified conditional branch
;
LINE_NSKIP303:
;
JSR GOSUB
JSR LINE_2180
JMP RETURN
;
LINE_SKIP303:
;
;
LINE_2460:
;
LDX #4
dcloop3389_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop3389_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_60R
LDY #>CONST_60R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP11
STA JUMP_TARGET
LDA #>FORLOOP11
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP11:
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ90:
EQ_SKIP90:
COMP_SKP136:
BNE LINE_SKIP304
LINE_NSKIP304:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_61
LDY #>CONST_61
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2520
;
LINE_SKIP304:
;
;
LINE_2470:
;
LDA VAR_Y
BEQ EQ_EQ91
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP91
EQ_EQ91:
LDA #$1
EQ_SKIP91:
COMP_SKP137:
BNE LINE_NSKIP305
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP305
;
LINE_NSKIP305:
;
LDA #<CONST_62
LDY #>CONST_62
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_63
LDY #>CONST_63
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_64
LDY #>CONST_64
STA B_REG
STY B_REG+1
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
JSR STROUT
JMP LINE_2520
;
LINE_SKIP305:
;
;
LINE_2480:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ92:
EQ_SKIP92:
COMP_SKP138:
BNE LINE_SKIP306
LINE_NSKIP306:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_65
LDY #>CONST_65
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2520
;
LINE_SKIP306:
;
;
LINE_2490:
;
LDX #4
dceloop5314_16:
LDA CONST_22,X
CMP VAR_I,X
BNE LINE_SKIP307
DEX
BPL dceloop5314_16
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP307:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_66
LDY #>CONST_66
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2520
;
LINE_SKIP307:
;
;
LINE_2500:
;
LDA #<CONST_27R
LDY #>CONST_27R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ94
ROL
BCC LT_LT94
LT_LT_EQ94:
LDA #0
JMP LT_SKIP94
LT_LT94:
LDA #$1
LT_SKIP94:
COMP_SKP140:
BEQ LINE_SKIP308
; Simplified conditional branch
;
LINE_NSKIP308:
;
LDA #<CONST_67
LDY #>CONST_67
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2520
;
LINE_SKIP308:
;
;
LINE_2510:
;
LDA #<CONST_68
LDY #>CONST_68
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_2520:
;
LDA VAR_E
BEQ EQ_SKIP95
EQ_EQ95:
JMP LINE_SKIP309
EQ_SKIP95:
COMP_SKP141:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP309:
;
LDA #<CONST_69R
LDY #>CONST_69R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
JMP LINE_2550
;
LINE_SKIP309:
;
;
LINE_2530:
;
LDA VAR_Y
BEQ EQ_EQ96
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP96
EQ_EQ96:
LDA #$1
EQ_SKIP96:
COMP_SKP142:
BNE LINE_NSKIP310
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP310
;
LINE_NSKIP310:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_69R
LDY #>CONST_69R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_64
LDY #>CONST_64
STA B_REG
STY B_REG+1
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
JSR STROUT
JMP LINE_2550
;
LINE_SKIP310:
;
;
LINE_2540:
;
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_2550:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ97:
EQ_SKIP97:
COMP_SKP143:
BNE LINE_SKIP311
LINE_NSKIP311:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_71
LDY #>CONST_71
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2610
;
LINE_SKIP311:
;
;
LINE_2560:
;
LDA VAR_Y
BEQ EQ_EQ98
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP98
EQ_EQ98:
LDA #$1
EQ_SKIP98:
COMP_SKP144:
BNE LINE_NSKIP312
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP312
;
LINE_NSKIP312:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_63
LDY #>CONST_63
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_64
LDY #>CONST_64
STA B_REG
STY B_REG+1
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
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2610
;
LINE_SKIP312:
;
;
LINE_2570:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ99:
EQ_SKIP99:
COMP_SKP145:
BNE LINE_SKIP313
LINE_NSKIP313:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_72
LDY #>CONST_72
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2610
;
LINE_SKIP313:
;
;
LINE_2580:
;
LDX #4
dceloop5314_17:
LDA CONST_22,X
CMP VAR_I,X
BNE LINE_SKIP314
DEX
BPL dceloop5314_17
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP314:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_73
LDY #>CONST_73
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2610
;
LINE_SKIP314:
;
;
LINE_2590:
;
LDA #<CONST_27R
LDY #>CONST_27R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ101
ROL
BCC LT_LT101
LT_LT_EQ101:
LDA #0
JMP LT_SKIP101
LT_LT101:
LDA #$1
LT_SKIP101:
COMP_SKP147:
BEQ LINE_SKIP315
; Simplified conditional branch
;
LINE_NSKIP315:
;
LDA #<CONST_74
LDY #>CONST_74
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2610
;
LINE_SKIP315:
;
;
LINE_2600:
;
LDA #<CONST_75
LDY #>CONST_75
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2610:
;
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
;
LINE_2620:
;
LDX #4
dcloop3555_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_23
LDY #>CONST_23
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP12
STA JUMP_TARGET
LDA #>FORLOOP12
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP12:
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ102
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP102
EQ_EQ102:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP102:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_W
LDY #>VAR_W
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ103
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP103
EQ_EQ103:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP103:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ104
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP104
EQ_EQ104:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP104:
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
COMP_SKP149:
BEQ LINE_SKIP316
; Simplified conditional branch
;
LINE_NSKIP316:
;
JMP LINE_2680
;
LINE_SKIP316:
;
;
LINE_2630:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ105:
NEQ_SKIP105:
COMP_SKP150:
BEQ LINE_SKIP317
LINE_NSKIP317:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_2650
;
LINE_SKIP317:
;
;
LINE_2640:
;
LDA VAR_EL
BEQ EQ_SKIP106
EQ_EQ106:
JMP LINE_SKIP318
EQ_SKIP106:
COMP_SKP151:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP318:
;
LDA #<CONST_76
LDY #>CONST_76
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2690
;
LINE_SKIP318:
;
;
LINE_2650:
;
LDA #<CONST_62
LDY #>CONST_62
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_63
LDY #>CONST_63
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #110
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
;
LINE_2660:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ107:
EQ_SKIP107:
COMP_SKP152:
BNE LINE_SKIP319
LINE_NSKIP319:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_2690
;
LINE_SKIP319:
;
;
LINE_2670:
;
JMP LINE_2700
;
LINE_2680:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_79
LDY #>CONST_79
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ108:
NEQ_SKIP108:
COMP_SKP153:
BEQ LINE_SKIP320
LINE_NSKIP320:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_2700
;
LINE_SKIP320:
;
;
LINE_2690:
;
LDA VAR_E
BEQ EQ_SKIP109
EQ_EQ109:
JMP LINE_SKIP321
EQ_SKIP109:
COMP_SKP154:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP321:
;
LDA #<CONST_81
LDY #>CONST_81
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2710
;
LINE_SKIP321:
;
;
LINE_2700:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_2710:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ110
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP110
EQ_EQ110:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP110:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_W
LDY #>VAR_W
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ111
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP111
EQ_EQ111:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP111:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ112
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP112
EQ_EQ112:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP112:
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
COMP_SKP155:
BEQ LINE_SKIP322
; Simplified conditional branch
;
LINE_NSKIP322:
;
JMP LINE_2750
;
LINE_SKIP322:
;
;
LINE_2720:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ113:
NEQ_SKIP113:
COMP_SKP156:
BEQ LINE_SKIP323
LINE_NSKIP323:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_2740
;
LINE_SKIP323:
;
;
LINE_2730:
;
LDA VAR_ER
BEQ EQ_SKIP114
EQ_EQ114:
JMP LINE_SKIP324
EQ_SKIP114:
COMP_SKP157:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP324:
;
LDA #<CONST_83
LDY #>CONST_83
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2760
;
LINE_SKIP324:
;
;
LINE_2740:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #109
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_63
LDY #>CONST_63
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2760
;
LINE_2750:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #<CONST_85
LDY #>CONST_85
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2760:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_12
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_12:
;
LINE_2770:
;
JMP RETURN
;
LINE_2780:
;
;
LINE_2790:
;
LDA #<CONST_86
LDY #>CONST_86
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_87
LDY #>CONST_87
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_2800:
;
LDX #4
dcloop3721_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_22
LDY #>CONST_22
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
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
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_C
BEQ EQ_SKIP115
EQ_EQ115:
JMP LINE_SKIP325
EQ_SKIP115:
COMP_SKP159:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP325:
;
JMP LINE_2830
;
LINE_SKIP325:
;
;
LINE_2810:
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #109
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_22
LDY #>CONST_22
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
JMP LINE_2860
;
LINE_2820:
;
LDA #<CONST_88
LDY #>CONST_88
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2860
;
LINE_2830:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ116:
EQ_SKIP116:
COMP_SKP160:
BNE LINE_SKIP326
LINE_NSKIP326:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_52
LDY #>CONST_52
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
JMP LINE_2860
;
LINE_SKIP326:
;
;
LINE_2840:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ117:
EQ_SKIP117:
COMP_SKP161:
BNE LINE_SKIP327
LINE_NSKIP327:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2860
;
LINE_SKIP327:
;
;
LINE_2850:
;
LDA #<CONST_90
LDY #>CONST_90
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_2860:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ118
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP118
EQ_EQ118:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP118:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ119
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP119
EQ_EQ119:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP119:
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
COMP_SKP162:
BEQ LINE_SKIP328
; Simplified conditional branch
;
LINE_NSKIP328:
;
LDA #<CONST_53R
LDY #>CONST_53R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
JMP LINE_2880
;
LINE_SKIP328:
;
;
LINE_2870:
;
LDA #<CONST_91
LDY #>CONST_91
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_2880:
;
LDA VAR_D
BEQ EQ_SKIP120
EQ_EQ120:
JMP LINE_SKIP329
EQ_SKIP120:
COMP_SKP163:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP329:
;
JMP LINE_2900
;
LINE_SKIP329:
;
;
LINE_2890:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_22
LDY #>CONST_22
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #110
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2930
;
LINE_2900:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ121:
EQ_SKIP121:
COMP_SKP164:
BNE LINE_SKIP330
LINE_NSKIP330:
; Optimizer rule: Simplified equal comparison/6
;
JSR LINEBREAK
JMP LINE_2930
;
LINE_SKIP330:
;
;
LINE_2910:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ122:
EQ_SKIP122:
COMP_SKP165:
BNE LINE_SKIP331
LINE_NSKIP331:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_2930
;
LINE_SKIP331:
;
;
LINE_2920:
;
LDA #<CONST_92
LDY #>CONST_92
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2930:
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
;
LINE_2940:
;
LDX #4
dcloop3887_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_93R
LDY #>CONST_93R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ123:
EQ_SKIP123:
COMP_SKP167:
BNE LINE_SKIP332
LINE_NSKIP332:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_94
LDY #>CONST_94
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2990
;
LINE_SKIP332:
;
;
LINE_2950:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ124:
EQ_SKIP124:
COMP_SKP168:
BNE LINE_SKIP333
LINE_NSKIP333:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_95
LDY #>CONST_95
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2990
;
LINE_SKIP333:
;
;
LINE_2960:
;
LDX #4
dceloop5314_18:
LDA CONST_23,X
CMP VAR_I,X
BNE LINE_SKIP334
DEX
BPL dceloop5314_18
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP334:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_96
LDY #>CONST_96
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2990
;
LINE_SKIP334:
;
;
LINE_2970:
;
LDA #<CONST_97R
LDY #>CONST_97R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT126
LDA #0
JMP GT_SKIP126
GT_GT126:
LDA #$1
GT_SKIP126:
COMP_SKP170:
BEQ LINE_SKIP335
; Simplified conditional branch
;
LINE_NSKIP335:
;
LDA #<CONST_98
LDY #>CONST_98
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_2990
;
LINE_SKIP335:
;
;
LINE_2980:
;
LDA #<CONST_99
LDY #>CONST_99
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_2990:
;
LDA VAR_E
BEQ EQ_SKIP127
EQ_EQ127:
JMP LINE_SKIP336
EQ_SKIP127:
COMP_SKP171:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP336:
;
LDA #<CONST_100
LDY #>CONST_100
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3010
;
LINE_SKIP336:
;
;
LINE_3000:
;
LDA #<CONST_101
LDY #>CONST_101
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3010:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ128:
EQ_SKIP128:
COMP_SKP172:
BNE LINE_SKIP337
LINE_NSKIP337:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_71
LDY #>CONST_71
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3060
;
LINE_SKIP337:
;
;
LINE_3020:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ129:
EQ_SKIP129:
COMP_SKP173:
BNE LINE_SKIP338
LINE_NSKIP338:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_102
LDY #>CONST_102
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3060
;
LINE_SKIP338:
;
;
LINE_3030:
;
LDX #4
dceloop5314_19:
LDA CONST_23,X
CMP VAR_I,X
BNE LINE_SKIP339
DEX
BPL dceloop5314_19
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP339:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_103
LDY #>CONST_103
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3060
;
LINE_SKIP339:
;
;
LINE_3040:
;
LDA #<CONST_97R
LDY #>CONST_97R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT131
LDA #0
JMP GT_SKIP131
GT_GT131:
LDA #$1
GT_SKIP131:
COMP_SKP175:
BEQ LINE_SKIP340
; Simplified conditional branch
;
LINE_NSKIP340:
;
LDA #<CONST_104
LDY #>CONST_104
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3060
;
LINE_SKIP340:
;
;
LINE_3050:
;
LDA #<CONST_105
LDY #>CONST_105
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3060:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_14
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_14:
;
LINE_3070:
;
LDX #4
dcloop3887_2:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop3887_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
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
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ132:
EQ_SKIP132:
COMP_SKP177:
BNE LINE_SKIP341
LINE_NSKIP341:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_3120
;
LINE_SKIP341:
;
;
LINE_3080:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ133:
NEQ_SKIP133:
COMP_SKP178:
BEQ LINE_SKIP342
LINE_NSKIP342:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_3110
;
LINE_SKIP342:
;
;
LINE_3090:
;
LDA VAR_EL
BEQ EQ_SKIP134
EQ_EQ134:
JMP LINE_SKIP343
EQ_SKIP134:
COMP_SKP179:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP343:
;
LDA #<CONST_106
LDY #>CONST_106
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3130
;
LINE_SKIP343:
;
;
LINE_3100:
;
LDA #<CONST_107
LDY #>CONST_107
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3130
;
LINE_3110:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_52
LDY #>CONST_52
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #110
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
JMP LINE_3140
;
LINE_3120:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_52
LDY #>CONST_52
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ135:
NEQ_SKIP135:
COMP_SKP180:
BEQ LINE_SKIP344
LINE_NSKIP344:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_3140
;
LINE_SKIP344:
;
;
LINE_3130:
;
LDA VAR_E
BEQ EQ_SKIP136
EQ_EQ136:
JMP LINE_SKIP345
EQ_SKIP136:
COMP_SKP181:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP345:
;
LDA #<CONST_108
LDY #>CONST_108
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3150
;
LINE_SKIP345:
;
;
LINE_3140:
;
LDA #<CONST_109
LDY #>CONST_109
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3150:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ137:
EQ_SKIP137:
COMP_SKP182:
BNE LINE_SKIP346
LINE_NSKIP346:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_3190
;
LINE_SKIP346:
;
;
LINE_3160:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ138:
NEQ_SKIP138:
COMP_SKP183:
BEQ LINE_SKIP347
LINE_NSKIP347:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_3180
;
LINE_SKIP347:
;
;
LINE_3170:
;
LDA VAR_ER
BEQ EQ_SKIP139
EQ_EQ139:
JMP LINE_SKIP348
EQ_SKIP139:
COMP_SKP184:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP348:
;
LDA #<CONST_110
LDY #>CONST_110
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3200
;
LINE_SKIP348:
;
;
LINE_3180:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #109
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_52
LDY #>CONST_52
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3200
;
LINE_3190:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #<CONST_85
LDY #>CONST_85
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3200
;
LINE_3200:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_15
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_15:
;
LINE_3210:
;
JMP RETURN
;
LINE_3220:
;
;
LINE_3230:
;
LDA #<CONST_111
LDY #>CONST_111
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<CONST_112
LDY #>CONST_112
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
;
LINE_3240:
;
LDX #4
dcloop4053_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop4053_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_3R
LDY #>CONST_3R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
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
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_C
BEQ EQ_SKIP140
EQ_EQ140:
JMP LINE_SKIP349
EQ_SKIP140:
COMP_SKP186:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP349:
;
JMP LINE_3260
;
LINE_SKIP349:
;
;
LINE_3250:
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #109
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_23
LDY #>CONST_23
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
JMP LINE_3290
;
LINE_3260:
;
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ141
ROL
BCC LT_LT141
LT_LT_EQ141:
LDA #0
JMP LT_SKIP141
LT_LT141:
LDA #$1
LT_SKIP141:
COMP_SKP187:
BEQ LINE_SKIP350
; Simplified conditional branch
;
LINE_NSKIP350:
;
LDA #<CONST_113
LDY #>CONST_113
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3290
;
LINE_SKIP350:
;
;
LINE_3270:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ142:
EQ_SKIP142:
COMP_SKP188:
BNE LINE_SKIP351
LINE_NSKIP351:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_114
LDY #>CONST_114
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3290
;
LINE_SKIP351:
;
;
LINE_3280:
;
LDA #<CONST_115
LDY #>CONST_115
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3290:
;
LDA #<CONST_22
LDY #>CONST_22
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ143
BEQ LTEQ_LTEQ143
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LTEQ_SKIP143
LTEQ_LTEQ143:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LTEQ_SKIP143:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ144
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP144
EQ_EQ144:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP144:
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
COMP_SKP189:
BEQ LINE_SKIP352
; Simplified conditional branch
;
LINE_NSKIP352:
;
LDA #<CONST_116
LDY #>CONST_116
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3310
;
LINE_SKIP352:
;
;
LINE_3300:
;
LDA #<CONST_117
LDY #>CONST_117
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3310:
;
LDA VAR_D
BEQ EQ_SKIP145
EQ_EQ145:
JMP LINE_SKIP353
EQ_SKIP145:
COMP_SKP190:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP353:
;
JMP LINE_3330
;
LINE_SKIP353:
;
;
LINE_3320:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_3R
LDY #>CONST_3R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #110
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3360
;
LINE_3330:
;
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ146
ROL
BCC LT_LT146
LT_LT_EQ146:
LDA #0
JMP LT_SKIP146
LT_LT146:
LDA #$1
LT_SKIP146:
COMP_SKP191:
BEQ LINE_SKIP354
; Simplified conditional branch
;
LINE_NSKIP354:
;
JSR LINEBREAK
JMP LINE_3360
;
LINE_SKIP354:
;
;
LINE_3340:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ147:
EQ_SKIP147:
COMP_SKP192:
BNE LINE_SKIP355
LINE_NSKIP355:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_114
LDY #>CONST_114
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3360
;
LINE_SKIP355:
;
;
LINE_3350:
;
LDA #<CONST_92
LDY #>CONST_92
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3360:
;
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
;
LINE_3370:
;
LDX #4
dcloop4219_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop4219_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_118R
LDY #>CONST_118R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
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
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ148:
EQ_SKIP148:
COMP_SKP194:
BNE LINE_SKIP356
LINE_NSKIP356:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_119
LDY #>CONST_119
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3420
;
LINE_SKIP356:
;
;
LINE_3380:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ149:
EQ_SKIP149:
COMP_SKP195:
BNE LINE_SKIP357
LINE_NSKIP357:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_120
LDY #>CONST_120
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3420
;
LINE_SKIP357:
;
;
LINE_3390:
;
LDX #4
dceloop5314_20:
LDA CONST_22,X
CMP VAR_I,X
BNE LINE_SKIP358
DEX
BPL dceloop5314_20
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP358:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_121
LDY #>CONST_121
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3420
;
LINE_SKIP358:
;
;
LINE_3400:
;
LDA #<CONST_122
LDY #>CONST_122
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT151
LDA #0
JMP GT_SKIP151
GT_GT151:
LDA #$1
GT_SKIP151:
COMP_SKP197:
BEQ LINE_SKIP359
; Simplified conditional branch
;
LINE_NSKIP359:
;
LDA #<CONST_123
LDY #>CONST_123
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3420
;
LINE_SKIP359:
;
;
LINE_3410:
;
LDA #<CONST_124
LDY #>CONST_124
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3420:
;
LDA VAR_E
BEQ EQ_SKIP152
EQ_EQ152:
JMP LINE_SKIP360
EQ_SKIP152:
COMP_SKP198:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP360:
;
LDA #<CONST_116
LDY #>CONST_116
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3440
;
LINE_SKIP360:
;
;
LINE_3430:
;
LDA #<CONST_72
LDY #>CONST_72
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3440:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ153:
EQ_SKIP153:
COMP_SKP199:
BNE LINE_SKIP361
LINE_NSKIP361:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_71
LDY #>CONST_71
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3490
;
LINE_SKIP361:
;
;
LINE_3450:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ154:
EQ_SKIP154:
COMP_SKP200:
BNE LINE_SKIP362
LINE_NSKIP362:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_120
LDY #>CONST_120
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3490
;
LINE_SKIP362:
;
;
LINE_3460:
;
LDX #4
dceloop5314_21:
LDA CONST_22,X
CMP VAR_I,X
BNE LINE_SKIP363
DEX
BPL dceloop5314_21
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP363:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_125
LDY #>CONST_125
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3490
;
LINE_SKIP363:
;
;
LINE_3470:
;
LDA #<CONST_122
LDY #>CONST_122
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT156
LDA #0
JMP GT_SKIP156
GT_GT156:
LDA #$1
GT_SKIP156:
COMP_SKP202:
BEQ LINE_SKIP364
; Simplified conditional branch
;
LINE_NSKIP364:
;
LDA #<CONST_126
LDY #>CONST_126
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3490
;
LINE_SKIP364:
;
;
LINE_3480:
;
LDA #<CONST_74
LDY #>CONST_74
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3490:
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
;
LINE_3500:
;
LDX #4
dcloop4385_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_3R
LDY #>CONST_3R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP18
STA JUMP_TARGET
LDA #>FORLOOP18
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP18:
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ157:
EQ_SKIP157:
COMP_SKP204:
BNE LINE_SKIP365
LINE_NSKIP365:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_3560
;
LINE_SKIP365:
;
;
LINE_3510:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ158:
NEQ_SKIP158:
COMP_SKP205:
BEQ LINE_SKIP366
LINE_NSKIP366:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_3530
;
LINE_SKIP366:
;
;
LINE_3520:
;
LDA VAR_EL
BEQ EQ_SKIP159
EQ_EQ159:
JMP LINE_SKIP367
EQ_SKIP159:
COMP_SKP206:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP367:
;
LDA #<CONST_127
LDY #>CONST_127
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3570
;
LINE_SKIP367:
;
;
LINE_3530:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_23
LDY #>CONST_23
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #110
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
;
LINE_3540:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ160:
EQ_SKIP160:
COMP_SKP207:
BNE LINE_SKIP368
LINE_NSKIP368:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_3570
;
LINE_SKIP368:
;
;
LINE_3550:
;
JMP LINE_3580
;
LINE_3560:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_23
LDY #>CONST_23
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
JMP LINE_3540
;
LINE_3570:
;
LDA VAR_E
BEQ EQ_SKIP161
EQ_EQ161:
JMP LINE_SKIP369
EQ_SKIP161:
COMP_SKP208:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP369:
;
LDA #<CONST_128
LDY #>CONST_128
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3590
;
LINE_SKIP369:
;
;
LINE_3580:
;
LDA #<CONST_129
LDY #>CONST_129
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3590:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ162:
EQ_SKIP162:
COMP_SKP209:
BNE LINE_SKIP370
LINE_NSKIP370:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_3650
;
LINE_SKIP370:
;
;
LINE_3600:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ163:
NEQ_SKIP163:
COMP_SKP210:
BEQ LINE_SKIP371
LINE_NSKIP371:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_3620
;
LINE_SKIP371:
;
;
LINE_3610:
;
LDA VAR_ER
BEQ EQ_SKIP164
EQ_EQ164:
JMP LINE_SKIP372
EQ_SKIP164:
COMP_SKP211:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP372:
;
LDA #<CONST_130
LDY #>CONST_130
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3690
;
LINE_SKIP372:
;
;
LINE_3620:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #<CONST_131
LDY #>CONST_131
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_23
LDY #>CONST_23
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3690
;
LINE_3650:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #<CONST_85
LDY #>CONST_85
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3690:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_18
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_18:
;
LINE_3700:
;
JMP RETURN
;
LINE_3710:
;
;
LINE_3720:
;
LDA #<CONST_132
LDY #>CONST_132
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<CONST_113
LDY #>CONST_113
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
;
LINE_3730:
;
LDX #4
dcloop4551_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP19
STA JUMP_TARGET
LDA #>FORLOOP19
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP19:
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_C
BEQ EQ_SKIP165
EQ_EQ165:
JMP LINE_SKIP373
EQ_SKIP165:
COMP_SKP213:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP373:
;
JMP LINE_3770
;
LINE_SKIP373:
;
;
LINE_3740:
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #109
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_22
LDY #>CONST_22
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
JMP LINE_3810
;
LINE_3770:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ166:
EQ_SKIP166:
COMP_SKP214:
BNE LINE_SKIP374
LINE_NSKIP374:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_133
LDY #>CONST_133
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3810
;
LINE_SKIP374:
;
;
LINE_3790:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ167:
EQ_SKIP167:
COMP_SKP215:
BNE LINE_SKIP375
LINE_NSKIP375:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_134
LDY #>CONST_134
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3810
;
LINE_SKIP375:
;
;
LINE_3800:
;
LDA #<CONST_135
LDY #>CONST_135
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3810:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ168
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP168
EQ_EQ168:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP168:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ169
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP169
EQ_EQ169:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP169:
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
COMP_SKP216:
BEQ LINE_SKIP376
; Simplified conditional branch
;
LINE_NSKIP376:
;
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3830
;
LINE_SKIP376:
;
;
LINE_3820:
;
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3830:
;
LDA VAR_D
BEQ EQ_SKIP170
EQ_EQ170:
JMP LINE_SKIP377
EQ_SKIP170:
COMP_SKP217:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP377:
;
JMP LINE_3870
;
LINE_SKIP377:
;
;
LINE_3840:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ171:
EQ_SKIP171:
COMP_SKP218:
BNE LINE_SKIP378
LINE_NSKIP378:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_136
LDY #>CONST_136
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP378:
;
;
LINE_3850:
;
LDA #110
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3910
;
LINE_3870:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ172:
EQ_SKIP172:
COMP_SKP219:
BNE LINE_SKIP379
LINE_NSKIP379:
; Optimizer rule: Simplified equal comparison/6
;
JSR LINEBREAK
JMP LINE_3910
;
LINE_SKIP379:
;
;
LINE_3890:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ173:
EQ_SKIP173:
COMP_SKP220:
BNE LINE_SKIP380
LINE_NSKIP380:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_134
LDY #>CONST_134
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_3910
;
LINE_SKIP380:
;
;
LINE_3900:
;
LDA #<CONST_92
LDY #>CONST_92
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3910:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_19
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_19:
;
LINE_3920:
;
LDX #4
dcloop4717_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop4717_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_56R
LDY #>CONST_56R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP20
STA JUMP_TARGET
LDA #>FORLOOP20
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP20:
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ174:
EQ_SKIP174:
COMP_SKP222:
BNE LINE_SKIP381
LINE_NSKIP381:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_137
LDY #>CONST_137
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3970
;
LINE_SKIP381:
;
;
LINE_3930:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ175:
EQ_SKIP175:
COMP_SKP223:
BNE LINE_SKIP382
LINE_NSKIP382:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_138
LDY #>CONST_138
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3970
;
LINE_SKIP382:
;
;
LINE_3940:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ176:
EQ_SKIP176:
COMP_SKP224:
BNE LINE_SKIP383
LINE_NSKIP383:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_139
LDY #>CONST_139
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3970
;
LINE_SKIP383:
;
;
LINE_3950:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT177
LDA #0
JMP GT_SKIP177
GT_GT177:
LDA #$1
GT_SKIP177:
COMP_SKP225:
BEQ LINE_SKIP384
; Simplified conditional branch
;
LINE_NSKIP384:
;
LDA #<CONST_140
LDY #>CONST_140
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3970
;
LINE_SKIP384:
;
;
LINE_3960:
;
LDA #<CONST_141
LDY #>CONST_141
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3970:
;
LDA VAR_E
BEQ EQ_SKIP178
EQ_EQ178:
JMP LINE_SKIP385
EQ_SKIP178:
COMP_SKP226:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP385:
;
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_3990
;
LINE_SKIP385:
;
;
LINE_3980:
;
LDA #<CONST_95
LDY #>CONST_95
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3990:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ179:
EQ_SKIP179:
COMP_SKP227:
BNE LINE_SKIP386
LINE_NSKIP386:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_71
LDY #>CONST_71
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4040
;
LINE_SKIP386:
;
;
LINE_4000:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ180:
EQ_SKIP180:
COMP_SKP228:
BNE LINE_SKIP387
LINE_NSKIP387:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_142
LDY #>CONST_142
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4040
;
LINE_SKIP387:
;
;
LINE_4010:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ181:
EQ_SKIP181:
COMP_SKP229:
BNE LINE_SKIP388
LINE_NSKIP388:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_143
LDY #>CONST_143
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4040
;
LINE_SKIP388:
;
;
LINE_4020:
;
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT182
LDA #0
JMP GT_SKIP182
GT_GT182:
LDA #$1
GT_SKIP182:
COMP_SKP230:
BEQ LINE_SKIP389
; Simplified conditional branch
;
LINE_NSKIP389:
;
LDA #<CONST_144
LDY #>CONST_144
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4040
;
LINE_SKIP389:
;
;
LINE_4030:
;
LDA #<CONST_105
LDY #>CONST_105
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_4040:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_20
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_20:
;
LINE_4050:
;
LDX #4
dcloop4717_2:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop4717_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP21
STA JUMP_TARGET
LDA #>FORLOOP21
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP21:
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ183:
EQ_SKIP183:
COMP_SKP232:
BNE LINE_SKIP390
LINE_NSKIP390:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_4100
;
LINE_SKIP390:
;
;
LINE_4060:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ184:
NEQ_SKIP184:
COMP_SKP233:
BEQ LINE_SKIP391
LINE_NSKIP391:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_4080
;
LINE_SKIP391:
;
;
LINE_4070:
;
LDA VAR_EL
BEQ EQ_SKIP185
EQ_EQ185:
JMP LINE_SKIP392
EQ_SKIP185:
COMP_SKP234:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP392:
;
LDA #<CONST_145
LDY #>CONST_145
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_4130
;
LINE_SKIP392:
;
;
LINE_4080:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_22
LDY #>CONST_22
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #110
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
;
LINE_4085:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ186:
EQ_SKIP186:
COMP_SKP235:
BNE LINE_SKIP393
LINE_NSKIP393:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_4130
;
LINE_SKIP393:
;
;
LINE_4090:
;
JMP LINE_4140
;
LINE_4100:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ187:
EQ_SKIP187:
COMP_SKP236:
BNE LINE_SKIP394
LINE_NSKIP394:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_136
LDY #>CONST_136
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP394:
;
;
LINE_4110:
;
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_4120:
;
LDX #4
dceloop5314_22:
LDA CONST_22,X
CMP VAR_I,X
BNE LINE_SKIP395
DEX
BPL dceloop5314_22
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP395:
; Optimizer rule: Simplified equal comparison/6
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JMP LINE_4140
;
LINE_SKIP395:
;
;
LINE_4130:
;
LDA VAR_E
BEQ EQ_SKIP189
EQ_EQ189:
JMP LINE_SKIP396
EQ_SKIP189:
COMP_SKP238:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP396:
;
LDA #<CONST_146
LDY #>CONST_146
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_4150
;
LINE_SKIP396:
;
;
LINE_4140:
;
LDA #<CONST_147
LDY #>CONST_147
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_4150:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ190:
EQ_SKIP190:
COMP_SKP239:
BNE LINE_SKIP397
LINE_NSKIP397:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_4200
;
LINE_SKIP397:
;
;
LINE_4160:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ191:
NEQ_SKIP191:
COMP_SKP240:
BEQ LINE_SKIP398
LINE_NSKIP398:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_4180
;
LINE_SKIP398:
;
;
LINE_4170:
;
LDA VAR_ER
BEQ EQ_SKIP192
EQ_EQ192:
JMP LINE_SKIP399
EQ_SKIP192:
COMP_SKP241:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP399:
;
LDA #<CONST_148
LDY #>CONST_148
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4230
;
LINE_SKIP399:
;
;
LINE_4180:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_22
LDY #>CONST_22
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
LDA #<CONST_77
LDY #>CONST_77
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4230
;
LINE_4200:
;
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dceloop5314_23:
LDA CONST_22,X
CMP VAR_I,X
BNE LINE_SKIP400
DEX
BPL dceloop5314_23
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP400:
; Optimizer rule: Simplified equal comparison/6
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_SKIP400:
;
;
LINE_4210:
;
LDA #<CONST_85
LDY #>CONST_85
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_4230:
;
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_21
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_21:
;
LINE_4240:
;
JMP RETURN
;
LINE_4250:
;
;
LINE_4260:
;
LDA #<CONST_149
LDY #>CONST_149
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<CONST_133
LDY #>CONST_133
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
;
LINE_4270:
;
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_C
BEQ EQ_SKIP194
EQ_EQ194:
JMP LINE_SKIP401
EQ_SKIP194:
COMP_SKP244:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP401:
;
JMP LINE_4290
;
LINE_SKIP401:
;
;
LINE_4280:
;
LDA #109
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JMP LINE_4300
;
LINE_4290:
;
LDA #<CONST_92
LDY #>CONST_92
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_4300:
;
LDA VAR_E
BEQ EQ_SKIP195
EQ_EQ195:
JMP LINE_SKIP402
EQ_SKIP195:
COMP_SKP245:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP402:
;
LDA #<CONST_133
LDY #>CONST_133
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_4320
;
LINE_SKIP402:
;
;
LINE_4310:
;
LDA #<CONST_134
LDY #>CONST_134
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_4320:
;
LDA VAR_D
BEQ EQ_SKIP196
EQ_EQ196:
JMP LINE_SKIP403
EQ_SKIP196:
COMP_SKP246:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP403:
;
JMP LINE_4340
;
LINE_SKIP403:
;
;
LINE_4330:
;
LDA #110
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4350
;
LINE_4340:
;
LDA #<CONST_92
LDY #>CONST_92
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_4350:
;
LDX #4
dcloop5049_1:
LDA CONST_21,X
STA VAR_I,X
DEX
BPL dcloop5049_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_3R
LDY #>CONST_3R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP22
STA JUMP_TARGET
LDA #>FORLOOP22
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP22:
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ197:
EQ_SKIP197:
COMP_SKP247:
BNE LINE_SKIP404
LINE_NSKIP404:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_4370
;
LINE_SKIP404:
;
;
LINE_4360:
;
LDA #<CONST_74
LDY #>CONST_74
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_4380
;
LINE_4370:
;
LDA #<CONST_150
LDY #>CONST_150
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_4380:
;
LDA VAR_E
BEQ EQ_SKIP198
EQ_EQ198:
JMP LINE_SKIP405
EQ_SKIP198:
COMP_SKP248:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP405:
;
LDA #<CONST_133
LDY #>CONST_133
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_4400
;
LINE_SKIP405:
;
;
LINE_4390:
;
LDA #<CONST_151
LDY #>CONST_151
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_4400:
;
LDA VAR_D
BEQ EQ_SKIP199
EQ_EQ199:
JMP LINE_SKIP406
EQ_SKIP199:
COMP_SKP249:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP406:
;
LDA #<CONST_74
LDY #>CONST_74
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4420
;
LINE_SKIP406:
;
;
LINE_4410:
;
LDA #<CONST_71
LDY #>CONST_71
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_4420:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_22
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_22:
;
LINE_4430:
;
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
EQ_EQ200:
EQ_SKIP200:
COMP_SKP251:
BNE LINE_SKIP407
LINE_NSKIP407:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_4450
;
LINE_SKIP407:
;
;
LINE_4440:
;
LDA #<CONST_152
LDY #>CONST_152
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_4460
;
LINE_4450:
;
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_4460:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
EQ_EQ201:
EQ_SKIP201:
COMP_SKP252:
BNE LINE_SKIP408
LINE_NSKIP408:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_153
LDY #>CONST_153
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_4480
;
LINE_SKIP408:
;
;
LINE_4470:
;
LDA #<CONST_154
LDY #>CONST_154
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_4480:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ202:
EQ_SKIP202:
COMP_SKP253:
BNE LINE_SKIP409
LINE_NSKIP409:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_4500
;
LINE_SKIP409:
;
;
LINE_4490:
;
LDA #<CONST_131
LDY #>CONST_131
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4510
;
LINE_4500:
;
LDA #<CONST_155
LDY #>CONST_155
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_4510:
;
JMP RETURN
;
LINE_4520:
;
LDA #<CONST_156
LDY #>CONST_156
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_4530:
;
LDA VAR_M1
COMP_SKP254:
BEQ LINE_SKIP410
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP410:
;
LDA #<CONST_157
LDY #>CONST_157
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_4560
;
LINE_SKIP410:
;
;
LINE_4540:
;
LDA #<CONST_158
LDY #>CONST_158
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_1780
;
LINE_4550:
;
JSR GOSUB
JSR LINE_1140
;
LINE_4560:
;
INPUT5:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_159
LDY #>CONST_159
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
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
EMPTYINPUTSKIP6:
JSR QUEUESIZE
LDA X_REG
COMP_SKP255:
BEQ INPUTCHECK5
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK5:
;
LINE_4570:
;
LDA #<CONST_160
LDY #>CONST_160
STA B_REG
STY B_REG+1
LDA VAR_Z$
LDY VAR_Z$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP256:
BEQ LINE_SKIP411
; Simplified conditional branch
;
LINE_NSKIP411:
;
JMP LINE_70
;
LINE_SKIP411:
;
;
LINE_4580:
;
JSR END
RTS
;
LINE_4590:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP23
STA JUMP_TARGET
LDA #>FORLOOP23
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP23:
LDA #0
STA VAR_J
STA VAR_J+1
STA VAR_J+2
STA VAR_J+3
STA VAR_J+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
LDA #<FORLOOP24
STA JUMP_TARGET
LDA #>FORLOOP24
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP24:
;
LINE_4600:
;
JSR COMPACTMAX
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_161
LDY #>CONST_161
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
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
; ignored: CHGCTX #1
JSR STR
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
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA #<CONST_162
LDY #>CONST_162
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR RIGHT
JSR STROUT
LDA #<CONST_136
LDY #>CONST_136
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_23
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_23:
JSR LINEBREAK
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_24
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_24:
;
LINE_4610:
;
JSR LINEBREAK
JSR LINEBREAK
;
LINE_4620:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_V
LDY #>VAR_V
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_J
LDY #>VAR_J
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_31
LDY #>CONST_31
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
LDA #<FORLOOP25
STA JUMP_TARGET
LDA #>FORLOOP25
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP25:
LDX #4
dcloop5215_1:
LDA CONST_1R,X
STA VAR_I,X
DEX
BPL dcloop5215_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_1R
;LDY #>CONST_1R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP26
STA JUMP_TARGET
LDA #>FORLOOP26
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP26:
;
LINE_4630:
;
JSR COMPACTMAX
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_161
LDY #>CONST_161
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
TXA
LDY #>C_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #4
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
JSR FACARG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_B[]
LDY #>VAR_B[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
; ignored: CHGCTX #1
JSR STR
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
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA #<CONST_162
LDY #>CONST_162
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR RIGHT
JSR STROUT
LDA #<CONST_136
LDY #>CONST_136
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_25
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_25:
JSR LINEBREAK
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_26
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_26:
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
RIGHT		JSR STRFUNCINT
RIGHT2		LDA (TMP_ZP),Y
TAX
CMP TMP_REG			; compare the source string's length with the parameter
BCS RIGHTBELOW
STA TMP_REG			; length>source length? -> clamp to source length
RIGHTBELOW	TXA
SEC
SBC TMP_REG
BCS RIGHTNOV
LDA #0
RIGHTNOV	STA TMP_REG+1
JMP STRFUNC
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
INPUTNUMBER	LDA #$1
JSR INPUTSTR2
LDA TMP_ZP
STA INDEX1
LDA TMP_ZP+1
STA INDEX1+1
LDY #0
STY VALTYPE
LDA (INDEX1),Y
STA TMP_REG		; Store the string's length
TAY
INC INDEX1
BNE VALSTR2
INC INDEX1+1
VALSTR2		LDY #$0			; check, if it's a valid number input. This check might not be 100% like the one done by BASIC V2...well, who cares...?!?
DEY
LDX #$0			; bit 0: Number found, bit 1: plus found, bit 2: minus found, bit 3: e found, bit 4: . found
NUMCHKLOOP	INY
CPY TMP_REG
BEQ NUMOK
LDA (INDEX1),Y
CMP #$20
BEQ NUMCHKLOOP	; ignore spaces
CMP #43			; check +
BNE	NOPLUS
TXA
BIT VAL6		; nothing found yet, ok
BNE	CHECKERR
ORA #2
TAX
JMP NUMCHKLOOP
NOPLUS		CMP #45			; check -
BNE	NOMINUS
TXA
BIT VAL6		; nothing found yet, ok
BNE	CHECKERR
ORA #4
TAX
JMP NUMCHKLOOP
NOMINUS		CMP #69			; check -
BNE	NOEEE
TXA
BIT VAL8		; no e found yet, ok
BNE	CHECKERR
ORA #8
AND #249		; +- are allowed after an e again
TAX
JMP NUMCHKLOOP
NOEEE		CMP #46			; check .
BNE	NOPOINT
TXA
BIT VAL24		; no . found yet, ok
BNE	CHECKERR
ORA #16
TAX
JMP NUMCHKLOOP
NOPOINT		CMP #48
BCC	CHECKERR	; <0
CMP #58
BCS CHECKERR	; >9
TXA
ORA #1
TAX
JMP NUMCHKLOOP
VAL1		.BYTE 1
VAL6		.BYTE 6
VAL8		.BYTE 8
VAL24		.BYTE 24
CHECKERR	LDA #<REAL_CONST_MINUS_ONE
STA TMP3_ZP
LDA #>REAL_CONST_MINUS_ONE
STA TMP3_ZP+1
JMP COPY2_XY_XREG
RTS				; Flag error and return
; check, if the input string looked like a number
NUMOK		LDA TMP_REG
JSR VALS
LDA #$0			; flag as number
STA X_REG
JMP FACYREG		; ...and return
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
INPUTLENGTHCHECK	LDA INPUTLENGTH
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
XXBASINT	LDA ARGLO		;BASINT breaks the content of ARG, so we save and restore it in F_REG
STA F_REG+4
LDA ARGMO
STA F_REG+3
LDA ARGMOH
STA F_REG+2
LDA ARGSGN
ORA #$7F
AND ARGHO
STA F_REG+1
LDA ARGEXP
STA F_REG
JSR BASINT
LDA F_REG+4
STA ARGLO
LDA F_REG+3
STA ARGMO
LDA F_REG+2
STA ARGMOH
LDA F_REG+1
STA ARGSGN
EOR FACSGN		; Does this have a point in this context? I'm not sure...
STA ARISGN
LDA ARGSGN
ORA #$80
STA ARGHO
LDA F_REG
STA ARGEXP
LDA FACEXP
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
STA VAR_C0,Y
STA VAR_C1,Y
STA VAR_C2,Y
STA VAR_C3,Y
STA VAR_C4,Y
STA VAR_C7,Y
STA VAR_M1,Y
STA VAR_H,Y
STA VAR_V,Y
STA VAR_A,Y
STA VAR_Q,Y
STA VAR_Z,Y
STA VAR_X,Y
STA VAR_AA,Y
STA VAR_C,Y
STA VAR_R,Y
STA VAR_S,Y
STA VAR_I,Y
STA VAR_J,Y
STA VAR_W,Y
STA VAR_M,Y
STA VAR_Y,Y
STA VAR_EL,Y
STA VAR_ER,Y
STA VAR_A1,Y
STA VAR_B,Y
STA VAR_B1,Y
STA VAR_F,Y
STA VAR_E,Y
STA VAR_D,Y
STA VAR_T,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_B[]
LDY #>VAR_B[]
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
; CONST: #1

MOSTCOMMON
CONST_1R	.REAL 1.0
; CONST: #2

CONST_2R	.REAL 2.0
; CONST: #3

CONST_3R	.REAL 3.0
; CONST: #4

CONST_4R	.REAL 4.0
; CONST: #7

CONST_5R	.REAL 7.0
; CONST: $north
CONST_6	.BYTE 5
.STRG "north"
; CONST: $east
CONST_7	.BYTE 4
.STRG "east"
; CONST: $south
CONST_8	.BYTE 5
.STRG "south"
; CONST: $west
CONST_9	.BYTE 4
.STRG "west"
; CONST: #0.0

CONST_10	.REAL 0.0
; CONST: ${clear}{white}{down}enter dimensions of labyrinth:
CONST_11	.BYTE 50
.STRG "{clear}{white}{down}enter dimensions of labyrinth:"
; CONST: ${down}how wide
CONST_12	.BYTE 14
.STRG "{down}how wide"
; CONST: $?redo from start
CONST_13	.BYTE 16
.STRG "?redo from start"
; CONST: #19

CONST_14R	.REAL 19.0
; CONST: ${up*2}
CONST_15	.BYTE 6
.STRG "{up*2}"
; CONST: ${down}how deep
CONST_16	.BYTE 14
.STRG "{down}how deep"
; CONST: #10

CONST_17R	.REAL 10.0
; CONST: ${down}now creating a
CONST_18	.BYTE 20
.STRG "{down}now creating a"
; CONST: #88


; CONST: $labyrinth
CONST_20	.BYTE 9
.STRG "labyrinth"
; CONST: #1.0

CONST_21	.REAL 1.0
; CONST: #2.0

CONST_22	.REAL 2.0
; CONST: #3.0

CONST_23	.REAL 3.0
; CONST: #40.0

CONST_24	.REAL 40.0
; CONST: #480.0

CONST_25	.REAL 480.0
; CONST: #1024.0

CONST_26	.REAL 1024.0
; CONST: #18

CONST_27R	.REAL 18.0
; CONST: #30


; CONST: ${clear}
CONST_29	.BYTE 7
.STRG "{clear}"
; CONST: #11

CONST_30R	.REAL 11.0
; CONST: #-1.0

CONST_31	.REAL -1.0
; CONST: ${reverse on}
CONST_32	.BYTE 13
.STRG "{reverse on} "
; CONST: ${black} {white}
CONST_33	.BYTE 15
.STRG "{black} {white}"
; CONST: #32


; CONST: ${reverse on}
CONST_35	.BYTE 12
.STRG "{reverse on}"
; CONST: ${space*2}
CONST_36	.BYTE 9
.STRG "{space*2}"
; CONST: $ {black} {white}
CONST_37	.BYTE 16
.STRG " {black} {white}"
; CONST: ${down*2}you can give the following instructions:
CONST_38	.BYTE 48
.STRG "{down*2}you can give the following instructions:"
; CONST: ${down}{reverse on}f{reverse off}-move forwards one block;
CONST_39	.BYTE 57
.STRG "{down}{reverse on}f{reverse off}-move forwards one block;"
; CONST: ${down}{reverse on}l{reverse off}-turn left{sh space}90 degress;
CONST_40	.BYTE 63
.STRG "{down}{reverse on}l{reverse off}-turn left{sh space}90 degress;"
; CONST: ${down}{reverse on}r{reverse off}-turn right{sh space}90 degrees;
CONST_41	.BYTE 64
.STRG "{down}{reverse on}r{reverse off}-turn right{sh space}90 degrees;"
; CONST: ${down}{reverse on}h{reverse off}-help!
CONST_42	.BYTE 38
.STRG "{down}{reverse on}h{reverse off}-help!"
; CONST: ${down}you are here {cm +}, facing
CONST_43	.BYTE 34
.STRG "{down}you are here {cm +}, facing "
; CONST: #80.0

CONST_44	.REAL 80.0
; CONST: #102


; CONST: ${home}{down*24}what now?
CONST_46	.BYTE 24
.STRG "{home}{down*24}what now?"
; CONST: $
CONST_47	.BYTE 0
.STRG ""
; CONST: $l
CONST_48	.BYTE 1
.STRG "l"
; CONST: $r
CONST_49	.BYTE 1
.STRG "r"
; CONST: $f
CONST_50	.BYTE 1
.STRG "f"
; CONST: $h
CONST_51	.BYTE 1
.STRG "h"
; CONST: #4.0

CONST_52	.REAL 4.0
; CONST: #14

CONST_53R	.REAL 14.0
; CONST: ${home}{down*10}{right*10}
CONST_54	.BYTE 25
.STRG "{home}{down*10}{right*10}"
; CONST: ${ct g}
CONST_55	.BYTE 6
.STRG "{ct g}"
; CONST: #5

CONST_56R	.REAL 5.0
; CONST: #5.0

CONST_57	.REAL 5.0
; CONST: ${up*4}{right*3}external wall
CONST_58	.BYTE 28
.STRG "{up*4}{right*3}external wall"
; CONST: ${up*2}{right*2}you're outside!
CONST_59	.BYTE 30
.STRG "{up*2}{right*2}you're outside!"
; CONST: #21

CONST_60R	.REAL 21.0
; CONST: ${right*8}{cm m}
CONST_61	.BYTE 15
.STRG "{right*8}{cm m}"
; CONST: ${right}{reverse on}
CONST_62	.BYTE 19
.STRG "{right}{reverse on}"
; CONST: #8.0

CONST_63	.REAL 8.0
; CONST: ${cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}
CONST_64	.BYTE 144
.STRG "{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}"
; CONST: ${right}{cm +*8}
CONST_65	.BYTE 15
.STRG "{right}{cm +*8}"
; CONST: ${right}{cm @*7}{cm +}
CONST_66	.BYTE 21
.STRG "{right}{cm @*7}{cm +}"
; CONST: ${right*8}{cm +}
CONST_67	.BYTE 15
.STRG "{right*8}{cm +}"
; CONST: ${right}{reverse on}{space*7}{reverse off}{cm +}
CONST_68	.BYTE 47
.STRG "{right}{reverse on}{space*7}{reverse off}{cm +}"
; CONST: #22

CONST_69R	.REAL 22.0
; CONST: ${cm +*22}
CONST_70	.BYTE 9
.STRG "{cm +*22}"
; CONST: ${cm g}
CONST_71	.BYTE 6
.STRG "{cm g}"
; CONST: ${cm +*8}
CONST_72	.BYTE 8
.STRG "{cm +*8}"
; CONST: ${cm +}{cm @*7}
CONST_73	.BYTE 14
.STRG "{cm +}{cm @*7}"
; CONST: ${cm +}
CONST_74	.BYTE 6
.STRG "{cm +}"
; CONST: ${cm +}{reverse on}{space*7}
CONST_75	.BYTE 27
.STRG "{cm +}{reverse on}{space*7}"
; CONST: ${right}{reverse on}{cm t*7}N
CONST_76	.BYTE 28
.STRG "{right}{reverse on}{cm t*7}N"
; CONST: ${space*47}
CONST_77	.BYTE 10
.STRG "{space*47}"
; CONST: #110


; CONST: #9.0

CONST_79	.REAL 9.0
; CONST: ${reverse on}{sh pound}
CONST_80	.BYTE 22
.STRG "{reverse on}{sh pound}"
; CONST: ${reverse on}{cm t*22}
CONST_81	.BYTE 21
.STRG "{reverse on}{cm t*22}"
; CONST: ${reverse on}{space*22}
CONST_82	.BYTE 22
.STRG "{reverse on}{space*22}"
; CONST: ${reverse on}M{cm t*7}
CONST_83	.BYTE 21
.STRG "{reverse on}M{cm t*7}"
; CONST: #109


; CONST: ${cm asterisk}
CONST_85	.BYTE 13
.STRG "{cm asterisk}"
; CONST: ${home}
CONST_86	.BYTE 6
.STRG "{home}"
; CONST: ${right*9}
CONST_87	.BYTE 9
.STRG "{right*9}"
; CONST: ${right*3}M
CONST_88	.BYTE 10
.STRG "{right*3}M"
; CONST: ${cm @*4}
CONST_89	.BYTE 8
.STRG "{cm @*4}"
; CONST: ${right*3}{cm @}
CONST_90	.BYTE 15
.STRG "{right*3}{cm @}"
; CONST: ${cm @*14}
CONST_91	.BYTE 9
.STRG "{cm @*14}"
; CONST: ${cm @}
CONST_92	.BYTE 6
.STRG "{cm @}"
; CONST: #15

CONST_93R	.REAL 15.0
; CONST: ${right*3}{cm m}
CONST_94	.BYTE 15
.STRG "{right*3}{cm m}"
; CONST: ${reverse on}{cm +*4}{reverse off}
CONST_95	.BYTE 33
.STRG "{reverse on}{cm +*4}{reverse off}"
; CONST: ${cm @*3}{reverse on}{cm +}{reverse off}
CONST_96	.BYTE 39
.STRG "{cm @*3}{reverse on}{cm +}{reverse off}"
; CONST: #12

CONST_97R	.REAL 12.0
; CONST: ${reverse on}{space*3}{cm +}{reverse off}
CONST_98	.BYTE 40
.STRG "{reverse on}{space*3}{cm +}{reverse off}"
; CONST: ${space*3}{reverse on}{cm +}{reverse off}
CONST_99	.BYTE 40
.STRG "{space*3}{reverse on}{cm +}{reverse off}"
; CONST: ${right*14}
CONST_100	.BYTE 10
.STRG "{right*14}"
; CONST: ${reverse on}{cm +*14}{reverse off}
CONST_101	.BYTE 34
.STRG "{reverse on}{cm +*14}{reverse off}"
; CONST: ${reverse on}{cm +*4}
CONST_102	.BYTE 20
.STRG "{reverse on}{cm +*4}"
; CONST: ${reverse on}{cm +}{reverse off}{cm @*3}
CONST_103	.BYTE 39
.STRG "{reverse on}{cm +}{reverse off}{cm @*3}"
; CONST: ${reverse on}{cm +}{space*3}
CONST_104	.BYTE 27
.STRG "{reverse on}{cm +}{space*3}"
; CONST: ${reverse on}{cm +}
CONST_105	.BYTE 18
.STRG "{reverse on}{cm +}"
; CONST: ${reverse on}{cm t*3}N
CONST_106	.BYTE 21
.STRG "{reverse on}{cm t*3}N"
; CONST: ${reverse on}{space*3}N
CONST_107	.BYTE 22
.STRG "{reverse on}{space*3}N"
; CONST: ${reverse on}{cm t*14}
CONST_108	.BYTE 21
.STRG "{reverse on}{cm t*14}"
; CONST: ${reverse on}{space*14}
CONST_109	.BYTE 22
.STRG "{reverse on}{space*14}"
; CONST: ${reverse on}M{cm t*3}
CONST_110	.BYTE 21
.STRG "{reverse on}M{cm t*3}"
; CONST: ${home}{down*2}
CONST_111	.BYTE 14
.STRG "{home}{down*2}"
; CONST: ${right*4}
CONST_112	.BYTE 9
.STRG "{right*4}"
; CONST: ${right*3}
CONST_113	.BYTE 9
.STRG "{right*3}"
; CONST: ${cm @*3}
CONST_114	.BYTE 8
.STRG "{cm @*3}"
; CONST: ${right*2}{cm @}
CONST_115	.BYTE 15
.STRG "{right*2}{cm @}"
; CONST: ${right*8}
CONST_116	.BYTE 9
.STRG "{right*8}"
; CONST: ${cm @*8}
CONST_117	.BYTE 8
.STRG "{cm @*8}"
; CONST: #9

CONST_118R	.REAL 9.0
; CONST: ${right*2}{cm m}
CONST_119	.BYTE 15
.STRG "{right*2}{cm m}"
; CONST: ${cm +*3}
CONST_120	.BYTE 8
.STRG "{cm +*3}"
; CONST: ${cm @*2}{cm +}
CONST_121	.BYTE 14
.STRG "{cm @*2}{cm +}"
; CONST: #7.0

CONST_122	.REAL 7.0
; CONST: ${reverse on}{space*2}{reverse off}{cm +}
CONST_123	.BYTE 40
.STRG "{reverse on}{space*2}{reverse off}{cm +}"
; CONST: ${space*2}{cm +}
CONST_124	.BYTE 15
.STRG "{space*2}{cm +}"
; CONST: ${cm +}{cm @*2}
CONST_125	.BYTE 14
.STRG "{cm +}{cm @*2}"
; CONST: ${cm +}{reverse on}{space*2}{reverse off}
CONST_126	.BYTE 40
.STRG "{cm +}{reverse on}{space*2}{reverse off}"
; CONST: ${reverse on}{cm t*2}N
CONST_127	.BYTE 21
.STRG "{reverse on}{cm t*2}N"
; CONST: ${reverse on}{cm t*8}
CONST_128	.BYTE 20
.STRG "{reverse on}{cm t*8}"
; CONST: ${reverse on}{space*8}
CONST_129	.BYTE 21
.STRG "{reverse on}{space*8}"
; CONST: ${reverse on}M{cm t*2}
CONST_130	.BYTE 21
.STRG "{reverse on}M{cm t*2}"
; CONST: ${reverse on}M
CONST_131	.BYTE 13
.STRG "{reverse on}M"
; CONST: ${home}{down*5}
CONST_132	.BYTE 14
.STRG "{home}{down*5}"
; CONST: ${right*2}
CONST_133	.BYTE 9
.STRG "{right*2}"
; CONST: ${cm @*2}
CONST_134	.BYTE 8
.STRG "{cm @*2}"
; CONST: ${right}{cm @}
CONST_135	.BYTE 13
.STRG "{right}{cm @}"
; CONST: ${right}
CONST_136	.BYTE 7
.STRG "{right}"
; CONST: ${right}{cm m}
CONST_137	.BYTE 13
.STRG "{right}{cm m}"
; CONST: ${reverse on}{cm +*2}{reverse off}
CONST_138	.BYTE 33
.STRG "{reverse on}{cm +*2}{reverse off}"
; CONST: ${cm @}{reverse on}{cm +}{reverse off}
CONST_139	.BYTE 37
.STRG "{cm @}{reverse on}{cm +}{reverse off}"
; CONST: ${reverse on}{cm t}{cm +}{reverse off}
CONST_140	.BYTE 37
.STRG "{reverse on}{cm t}{cm +}{reverse off}"
; CONST: $ {reverse on}{cm +}{reverse off}
CONST_141	.BYTE 32
.STRG " {reverse on}{cm +}{reverse off}"
; CONST: ${reverse on}{cm +*2}
CONST_142	.BYTE 20
.STRG "{reverse on}{cm +*2}"
; CONST: ${reverse on}{cm +}{reverse off}{cm @}
CONST_143	.BYTE 37
.STRG "{reverse on}{cm +}{reverse off}{cm @}"
; CONST: ${reverse on}{cm +}
CONST_144	.BYTE 19
.STRG "{reverse on}{cm +} "
; CONST: ${reverse on}{cm t}N
CONST_145	.BYTE 19
.STRG "{reverse on}{cm t}N"
; CONST: ${reverse on}{cm t*4}
CONST_146	.BYTE 20
.STRG "{reverse on}{cm t*4}"
; CONST: ${reverse on}{space*4}
CONST_147	.BYTE 21
.STRG "{reverse on}{space*4}"
; CONST: ${reverse on}M{cm t}
CONST_148	.BYTE 19
.STRG "{reverse on}M{cm t}"
; CONST: ${home}{down*7}
CONST_149	.BYTE 14
.STRG "{home}{down*7}"
; CONST: ${cm m}
CONST_150	.BYTE 6
.STRG "{cm m}"
; CONST: ${cm +*2}
CONST_151	.BYTE 8
.STRG "{cm +*2}"
; CONST: ${reverse on}N
CONST_152	.BYTE 13
.STRG "{reverse on}N"
; CONST: ${reverse on}{space*2}
CONST_153	.BYTE 21
.STRG "{reverse on}{space*2}"
; CONST: ${reverse on}{cm t*2}
CONST_154	.BYTE 20
.STRG "{reverse on}{cm t*2}"
; CONST: ${reverse on}{cm asterisk}
CONST_155	.BYTE 25
.STRG "{reverse on}{cm asterisk}"
; CONST: ${clear}you're out!
CONST_156	.BYTE 18
.STRG "{clear}you're out!"
; CONST: ${down*4}
CONST_157	.BYTE 8
.STRG "{down*4}"
; CONST: ${clear}here is the maze
CONST_158	.BYTE 23
.STRG "{clear}here is the maze"
; CONST: $another game
CONST_159	.BYTE 12
.STRG "another game"
; CONST: $y
CONST_160	.BYTE 1
.STRG "y"
; CONST: #-1

CONST_161	.REAL -1
; CONST: $0
CONST_162	.BYTE 1
.STRG "0"
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: C0
VAR_C0	.REAL 0.0
; VAR: C1
VAR_C1	.REAL 0.0
; VAR: C2
VAR_C2	.REAL 0.0
; VAR: C3
VAR_C3	.REAL 0.0
; VAR: C4
VAR_C4	.REAL 0.0
; VAR: C7
VAR_C7	.REAL 0.0
; VAR: M1
VAR_M1	.REAL 0.0
; VAR: H
VAR_H	.REAL 0.0
; VAR: V
VAR_V	.REAL 0.0
; VAR: A
VAR_A	.REAL 0.0
; VAR: Q
VAR_Q	.REAL 0.0
; VAR: Z
VAR_Z	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: AA
VAR_AA	.REAL 0.0
; VAR: A[]
.BYTE 1
.WORD 1200
VAR_A[]	.ARRAY 1200
; VAR: C
VAR_C	.REAL 0.0
; VAR: R
VAR_R	.REAL 0.0
; VAR: S
VAR_S	.REAL 0.0
; VAR: B[]
.BYTE 1
.WORD 1200
VAR_B[]	.ARRAY 1200
; VAR: I
VAR_I	.REAL 0.0
; VAR: J
VAR_J	.REAL 0.0
; VAR: W
VAR_W	.REAL 0.0
; VAR: M
VAR_M	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: EL
VAR_EL	.REAL 0.0
; VAR: ER
VAR_ER	.REAL 0.0
; VAR: A1
VAR_A1	.REAL 0.0
; VAR: B
VAR_B	.REAL 0.0
; VAR: B1
VAR_B1	.REAL 0.0
; VAR: F
VAR_F	.REAL 0.0
; VAR: E
VAR_E	.REAL 0.0
; VAR: D
VAR_D	.REAL 0.0
; VAR: T
VAR_T	.REAL 0.0
STRINGVARS_START
; VAR: Z$
VAR_Z$	.WORD EMPTYSTR
; VAR: TI$
VAR_TI$ .WORD EMPTYSTR
STRINGVARS_END
STRINGARRAYS_START
; VAR: A$[]
.BYTE 2
.WORD 22
VAR_A$[]
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
