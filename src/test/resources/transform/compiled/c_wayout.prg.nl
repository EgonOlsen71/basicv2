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
LINE_5:
;
;
LINE_8:
;
LDX #4
dcloop235_1:
LDA CONST_0,X
STA VAR_F,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_33:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
LDA #<CONST_2
LDY #>CONST_2
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR CLR
;
LINE_34:
;
LDA #0
STA VAR_C0
STA VAR_C0+1
STA VAR_C0+2
STA VAR_C0+3
STA VAR_C0+4
LDX #4
dcloop235_2:
LDA CONST_3R,X
STA VAR_C1,X
LDA CONST_4R,X
STA VAR_C2,X
LDA CONST_5R,X
STA VAR_C3,X
LDA CONST_6R,X
STA VAR_C4,X
LDA CONST_7R,X
STA VAR_C7,X
DEX
BPL dcloop235_2
; Special rule: Aggregation of assignments (5)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_35:
;
;
LINE_36:
;
;
LINE_37:
;
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
LDA #<CONST_10
LDY #>CONST_10
STA A_REG
STY A_REG+1
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_A$[]
LDY #>VAR_A$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<CONST_11
LDY #>CONST_11
STA A_REG
STY A_REG+1
LDA #<CONST_6R
LDY #>CONST_6R
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
LINE_38:
;
;
LINE_39:
;
;
LINE_40:
;
LDA #0
STA VAR_M1
STA VAR_M1+1
STA VAR_M1+2
STA VAR_M1+3
STA VAR_M1+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_41:
;
INPUT3:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_14
LDY #>CONST_14
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP0:
BEQ INPUT3_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_15
LDY #>CONST_15
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
LINE_42:
;
LDA #<CONST_16R
LDY #>CONST_16R
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
LDA #<CONST_12
LDY #>CONST_12
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
BEQ LINE_SKIP205
; Simplified conditional branch
;
LINE_NSKIP205:
;
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_41
;
LINE_SKIP205:
;
;
LINE_43:
;
INPUT4:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_18
LDY #>CONST_18
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP3:
BEQ INPUT4_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_15
LDY #>CONST_15
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
LINE_44:
;
LDA #<CONST_19R
LDY #>CONST_19R
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
LDA #<CONST_12
LDY #>CONST_12
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
BEQ LINE_SKIP206
; Simplified conditional branch
;
LINE_NSKIP206:
;
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_43
;
LINE_SKIP206:
;
;
LINE_45:
;
LDA #<CONST_20
LDY #>CONST_20
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
LDA #118
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
LDA #<CONST_22
LDY #>CONST_22
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_46:
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
LINE_47:
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
LINE_48:
;
LDX #4
dcloop235_7:
LDA VAR_X,X
STA VAR_AA,X
DEX
BPL dcloop235_7
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_49:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_23
LDY #>CONST_23
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
dcloop235_8:
LDA CONST_24,X
STA VAR_C,X
DEX
BPL dcloop235_8
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_50:
LDX #4
dcloop401_1:
LDA VAR_X,X
STA VAR_R,X
LDA CONST_23,X
STA VAR_S,X
DEX
BPL dcloop401_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_57
;
LINE_51:
;
LDX #4
dcneloop5315_1:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_NSKIP207
DEX
BPL dcneloop5315_1
JMP LINE_SKIP207
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP207:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_55
;
LINE_SKIP207:
;
;
LINE_52:
;
LDX #4
dcneloop5315_2:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP208
DEX
BPL dcneloop5315_2
JMP LINE_SKIP208
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP208:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_54
;
LINE_SKIP208:
;
;
LINE_53:
LDX #4
dcloop401_3:
LDA CONST_23,X
STA VAR_R,X
LDA CONST_23,X
STA VAR_S,X
DEX
BPL dcloop401_3
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_56
;
LINE_54:
;
LDX #4
dcloop401_5:
LDA CONST_23,X
STA VAR_R,X
DEX
BPL dcloop401_5
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
JMP LINE_56
;
LINE_55:
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
LINE_56:
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
BEQ LINE_SKIP209
; Simplified conditional branch
;
LINE_NSKIP209:
;
JMP LINE_51
;
LINE_SKIP209:
;
;
LINE_57:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_R
LDY #>VAR_R
JSR CMPFAC
EQ_EQ7:
EQ_SKIP7:
COMP_SKP9:
BNE LINE_SKIP210
LINE_NSKIP210:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_89
;
LINE_SKIP210:
;
;
LINE_58:
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
BEQ LINE_SKIP211
; Simplified conditional branch
;
LINE_NSKIP211:
;
JMP LINE_89
;
LINE_SKIP211:
;
;
LINE_59:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR CMPFAC
EQ_EQ8:
EQ_SKIP8:
COMP_SKP11:
BNE LINE_SKIP212
LINE_NSKIP212:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_73
;
LINE_SKIP212:
;
;
LINE_60:
;
LDA #<CONST_24
LDY #>CONST_24
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
BEQ LINE_SKIP213
; Simplified conditional branch
;
LINE_NSKIP213:
;
JMP LINE_73
;
LINE_SKIP213:
;
;
LINE_61:
;
LDX #4
dceloop5314_1:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_SKIP214
DEX
BPL dceloop5314_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP214:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_65
;
LINE_SKIP214:
;
;
LINE_62:
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
BEQ LINE_SKIP215
; Simplified conditional branch
;
LINE_NSKIP215:
;
JMP LINE_65
;
LINE_SKIP215:
;
;
LINE_63:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_25
LDY #>CONST_25
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
LINE_64:
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
JMP LINE_120
AFTER8SUB0:
ON8SUB1:
INX
CPX TMP_ZP
COMP_SKP16:
BNE AFTER8SUB1
JMP LINE_124
AFTER8SUB1:
ON8SUB2:
INX
CPX TMP_ZP
COMP_SKP17:
BNE AFTER8SUB2
JMP LINE_128
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
LINE_65:
;
LDX #4
dcneloop5315_3:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP216
DEX
BPL dcneloop5315_3
JMP LINE_SKIP216
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP216:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_68
;
LINE_SKIP216:
;
;
LINE_66:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ11:
EQ_SKIP11:
COMP_SKP19:
BNE LINE_SKIP217
LINE_NSKIP217:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_71
;
LINE_SKIP217:
;
;
LINE_67:
;
LDX #4
dcloop567_1:
LDA CONST_23,X
STA VAR_Q,X
DEX
BPL dcloop567_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_69
;
LINE_68:
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
BEQ LINE_SKIP218
; Simplified conditional branch
;
LINE_NSKIP218:
;
JMP LINE_71
;
LINE_SKIP218:
;
;
LINE_69:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_25
LDY #>CONST_25
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
LINE_70:
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
JMP LINE_120
AFTER9SUB0:
ON9SUB1:
INX
CPX TMP_ZP
COMP_SKP22:
BNE AFTER9SUB1
JMP LINE_124
AFTER9SUB1:
ON9SUB2:
INX
CPX TMP_ZP
COMP_SKP23:
BNE AFTER9SUB2
JMP LINE_135
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
LINE_71:
;
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
LINE_72:
;
JMP LINE_70
;
LINE_73:
;
LDX #4
dceloop5314_2:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_SKIP219
DEX
BPL dceloop5314_2
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP219:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_83
;
LINE_SKIP219:
;
;
LINE_74:
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
BEQ LINE_SKIP220
; Simplified conditional branch
;
LINE_NSKIP220:
;
JMP LINE_83
;
LINE_SKIP220:
;
;
LINE_75:
;
LDX #4
dcneloop5315_4:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP221
DEX
BPL dcneloop5315_4
JMP LINE_SKIP221
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP221:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_78
;
LINE_SKIP221:
;
;
LINE_76:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ14:
EQ_SKIP14:
COMP_SKP27:
BNE LINE_SKIP222
LINE_NSKIP222:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_81
;
LINE_SKIP222:
;
;
LINE_77:
;
LDX #4
dcloop733_1:
LDA CONST_23,X
STA VAR_Q,X
DEX
BPL dcloop733_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_79
;
LINE_78:
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
BEQ LINE_SKIP223
; Simplified conditional branch
;
LINE_NSKIP223:
;
JMP LINE_81
;
LINE_SKIP223:
;
;
LINE_79:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_25
LDY #>CONST_25
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
LINE_80:
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
JMP LINE_120
AFTER10SUB0:
ON10SUB1:
INX
CPX TMP_ZP
COMP_SKP30:
BNE AFTER10SUB1
JMP LINE_128
AFTER10SUB1:
ON10SUB2:
INX
CPX TMP_ZP
COMP_SKP31:
BNE AFTER10SUB2
JMP LINE_135
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
LINE_81:
;
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
LINE_82:
;
JMP LINE_80
;
LINE_83:
;
LDX #4
dcneloop5315_5:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP224
DEX
BPL dcneloop5315_5
JMP LINE_SKIP224
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP224:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_86
;
LINE_SKIP224:
;
;
LINE_84:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ16:
EQ_SKIP16:
COMP_SKP33:
BNE LINE_SKIP225
LINE_NSKIP225:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_120
;
LINE_SKIP225:
;
;
LINE_85:
;
LDX #4
dcloop733_2:
LDA CONST_23,X
STA VAR_Q,X
DEX
BPL dcloop733_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_87
;
LINE_86:
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
BEQ LINE_SKIP226
; Simplified conditional branch
;
LINE_NSKIP226:
;
JMP LINE_120
;
LINE_SKIP226:
;
;
LINE_87:
;
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
LINE_88:
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
JMP LINE_120
AFTER11SUB0:
ON11SUB1:
INX
CPX TMP_ZP
COMP_SKP36:
BNE AFTER11SUB1
JMP LINE_135
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
LINE_89:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_S
LDY #>VAR_S
JSR CMPFAC
EQ_EQ17:
EQ_SKIP17:
COMP_SKP37:
BNE LINE_SKIP227
LINE_NSKIP227:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_107
;
LINE_SKIP227:
;
;
LINE_90:
;
LDA #<CONST_24
LDY #>CONST_24
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
BEQ LINE_SKIP228
; Simplified conditional branch
;
LINE_NSKIP228:
;
JMP LINE_107
;
LINE_SKIP228:
;
;
LINE_91:
;
LDX #4
dceloop5314_3:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_SKIP229
DEX
BPL dceloop5314_3
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP229:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_101
;
LINE_SKIP229:
;
;
LINE_92:
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
BEQ LINE_SKIP230
; Simplified conditional branch
;
LINE_NSKIP230:
;
JMP LINE_101
;
LINE_SKIP230:
;
;
LINE_93:
;
LDX #4
dcneloop5315_6:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP231
DEX
BPL dcneloop5315_6
JMP LINE_SKIP231
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP231:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_96
;
LINE_SKIP231:
;
;
LINE_94:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ20:
EQ_SKIP20:
COMP_SKP42:
BNE LINE_SKIP232
LINE_NSKIP232:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_99
;
LINE_SKIP232:
;
;
LINE_95:
;
LDX #4
dcloop899_1:
LDA CONST_23,X
STA VAR_Q,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_97
;
LINE_96:
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
BEQ LINE_SKIP233
; Simplified conditional branch
;
LINE_NSKIP233:
;
JMP LINE_99
;
LINE_SKIP233:
;
;
LINE_97:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_25
LDY #>CONST_25
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
LINE_98:
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
JMP LINE_124
AFTER12SUB0:
ON12SUB1:
INX
CPX TMP_ZP
COMP_SKP45:
BNE AFTER12SUB1
JMP LINE_128
AFTER12SUB1:
ON12SUB2:
INX
CPX TMP_ZP
COMP_SKP46:
BNE AFTER12SUB2
JMP LINE_135
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
LINE_99:
;
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
LINE_100:
;
JMP LINE_98
;
LINE_101:
;
LDX #4
dcneloop5315_7:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP234
DEX
BPL dcneloop5315_7
JMP LINE_SKIP234
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP234:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_104
;
LINE_SKIP234:
;
;
LINE_102:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ22:
EQ_SKIP22:
COMP_SKP48:
BNE LINE_SKIP235
LINE_NSKIP235:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_124
;
LINE_SKIP235:
;
;
LINE_103:
;
LDX #4
dcloop1065_1:
LDA CONST_23,X
STA VAR_Q,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_105
;
LINE_104:
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
BEQ LINE_SKIP236
; Simplified conditional branch
;
LINE_NSKIP236:
;
JMP LINE_124
;
LINE_SKIP236:
;
;
LINE_105:
;
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
LINE_106:
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
JMP LINE_124
AFTER13SUB0:
ON13SUB1:
INX
CPX TMP_ZP
COMP_SKP51:
BNE AFTER13SUB1
JMP LINE_135
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
LINE_107:
;
LDX #4
dceloop5314_4:
LDA VAR_H,X
CMP VAR_R,X
BNE LINE_SKIP237
DEX
BPL dceloop5314_4
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP237:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_115
;
LINE_SKIP237:
;
;
LINE_108:
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
BEQ LINE_SKIP238
; Simplified conditional branch
;
LINE_NSKIP238:
;
JMP LINE_115
;
LINE_SKIP238:
;
;
LINE_109:
;
LDX #4
dcneloop5315_8:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP239
DEX
BPL dcneloop5315_8
JMP LINE_SKIP239
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP239:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_112
;
LINE_SKIP239:
;
;
LINE_110:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ25:
EQ_SKIP25:
COMP_SKP55:
BNE LINE_SKIP240
LINE_NSKIP240:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_128
;
LINE_SKIP240:
;
;
LINE_111:
;
LDX #4
dcloop1065_2:
LDA CONST_23,X
STA VAR_Q,X
DEX
BPL dcloop1065_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_113
;
LINE_112:
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
BEQ LINE_SKIP241
; Simplified conditional branch
;
LINE_NSKIP241:
;
JMP LINE_128
;
LINE_SKIP241:
;
;
LINE_113:
;
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
LINE_114:
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
JMP LINE_128
AFTER14SUB0:
ON14SUB1:
INX
CPX TMP_ZP
COMP_SKP58:
BNE AFTER14SUB1
JMP LINE_135
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
LINE_115:
;
LDX #4
dcneloop5315_9:
LDA VAR_V,X
CMP VAR_S,X
BNE LINE_NSKIP242
DEX
BPL dcneloop5315_9
JMP LINE_SKIP242
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP242:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_118
;
LINE_SKIP242:
;
;
LINE_116:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ27:
EQ_SKIP27:
COMP_SKP60:
BNE LINE_SKIP243
LINE_NSKIP243:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_51
;
LINE_SKIP243:
;
;
LINE_117:
;
LDX #4
dcloop1231_1:
LDA CONST_23,X
STA VAR_Q,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_119
;
LINE_118:
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
BEQ LINE_SKIP244
; Simplified conditional branch
;
LINE_NSKIP244:
;
JMP LINE_51
;
LINE_SKIP244:
;
;
LINE_119:
;
JMP LINE_135
;
LINE_120:
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
LINE_121:
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
LDA #<CONST_24
LDY #>CONST_24
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
LINE_122:
;
LDX #4
dceloop5314_5:
LDA VAR_A,X
CMP VAR_C,X
BNE LINE_SKIP245
DEX
BPL dceloop5314_5
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP245:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_145
;
LINE_SKIP245:
;
;
LINE_123:
;
LDA #0
STA VAR_Q
STA VAR_Q+1
STA VAR_Q+2
STA VAR_Q+3
STA VAR_Q+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_57
;
LINE_124:
;
LDA #<CONST_24
LDY #>CONST_24
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
LINE_125:
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
LINE_126:
;
LDA #<CONST_24
LDY #>CONST_24
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
BNE LINE_SKIP246
DEX
BPL dceloop5314_6
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP246:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_145
;
LINE_SKIP246:
;
;
LINE_127:
;
LDA #0
STA VAR_Q
STA VAR_Q+1
STA VAR_Q+2
STA VAR_Q+3
STA VAR_Q+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_57
;
LINE_128:
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
LINE_129:
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
BEQ LINE_SKIP247
; Simplified conditional branch
;
LINE_NSKIP247:
;
JMP LINE_131
;
LINE_SKIP247:
;
;
LINE_130:
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
LDA #<CONST_25
LDY #>CONST_25
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JMP LINE_132
;
LINE_131:
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
LDA #<CONST_24
LDY #>CONST_24
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
LINE_132:
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
LINE_133:
;
LDX #4
dceloop5314_7:
LDA VAR_A,X
CMP VAR_C,X
BNE LINE_SKIP248
DEX
BPL dceloop5314_7
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP248:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_145
;
LINE_SKIP248:
;
;
LINE_134:
;
JMP LINE_89
;
LINE_135:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Q
LDY #>VAR_Q
JSR CMPFAC
EQ_EQ32:
EQ_SKIP32:
COMP_SKP66:
BNE LINE_SKIP249
LINE_NSKIP249:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_141
;
LINE_SKIP249:
;
;
LINE_136:
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
BEQ LINE_SKIP250
; Simplified conditional branch
;
LINE_NSKIP250:
;
JMP LINE_138
;
LINE_SKIP250:
;
;
LINE_137:
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
LDA #<CONST_25
LDY #>CONST_25
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B[]
LDY #>VAR_B[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JMP LINE_139
;
LINE_138:
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
;
LINE_139:
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
BNE LINE_SKIP251
DEX
BPL dceloop5314_8
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP251:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_145
;
LINE_SKIP251:
;
;
LINE_140:
;
JMP LINE_57
;
LINE_141:
;
LDX #4
dcloop1563_1:
LDA CONST_23,X
STA VAR_Z,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_142:
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
BEQ LINE_SKIP252
; Simplified conditional branch
;
LINE_NSKIP252:
;
JMP LINE_144
;
LINE_SKIP252:
;
;
LINE_143:
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
LDA #<CONST_25
LDY #>CONST_25
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
JMP LINE_51
;
LINE_144:
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
LDX #4
dcloop1729_1:
LDA CONST_23,X
STA VAR_R,X
LDA CONST_23,X
STA VAR_S,X
DEX
BPL dcloop1729_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_56
;
LINE_145:
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
BNE LINE_NSKIP253
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP253
;
LINE_NSKIP253:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
LINE_SKIP253:
;
;
LINE_146:
;
JSR GOSUB
JSR LINE_147
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
LDA #<CONST_26
LDY #>CONST_26
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_27
LDY #>CONST_27
JSR REALFAC
LDA #<CONST_28
LDY #>CONST_28
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_29R
LDY #>CONST_29R
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
STY MOVBSELF3+1
STA MOVBSELF3+2
LDA #$1E
MOVBSELF3:
STA $FFFF
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
LDA #<CONST_26
LDY #>CONST_26
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_27
LDY #>CONST_27
JSR REALFAC
LDA #<CONST_31
LDY #>CONST_31
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
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
STY MOVBSELF4+1
STA MOVBSELF4+2
LDA #$7
MOVBSELF4:
STA $FFFF
JMP LINE_173
;
LINE_147:
;
JSR GOSUB
JSR LINE_189
;
LINE_148:
;
LDX #4
dcloop1895_1:
LDA CONST_23,X
STA VAR_M1,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dceloop5314_9:
LDA CONST_33R,X
CMP VAR_V,X
BNE LINE_SKIP254
DEX
BPL dceloop5314_9
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP254:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_150
;
LINE_SKIP254:
;
;
LINE_149:
;
LDX #4
dcloop1895_2:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop1895_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<CONST_33R
LDY #>CONST_33R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_3R
;LDY #>CONST_3R
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
LINE_150:
;
LDX #4
dcloop1895_3:
LDA VAR_V,X
STA VAR_J,X
DEX
BPL dcloop1895_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_23
LDY #>CONST_23
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_34
LDY #>CONST_34
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
LDA #<CONST_16R
LDY #>CONST_16R
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
LINE_151:
;
LDX #4
dcloop1895_4:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop1895_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
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
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_152:
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
BEQ LINE_SKIP255
; Simplified conditional branch
;
LINE_NSKIP255:
;
JMP LINE_156
;
LINE_SKIP255:
;
;
LINE_153:
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
LDA #<CONST_24
LDY #>CONST_24
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ39:
EQ_SKIP39:
COMP_SKP74:
BNE LINE_SKIP256
LINE_NSKIP256:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_156
;
LINE_SKIP256:
;
;
LINE_154:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_155:
;
JMP LINE_157
;
LINE_156:
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_157:
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
LINE_158:
;
LDA #32
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_159:
;
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
LDA #<CONST_16R
LDY #>CONST_16R
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
;
LINE_160:
;
LDX #4
dcloop1895_5:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop1895_5
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
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
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_161:
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
LDA #<CONST_24
LDY #>CONST_24
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
BEQ LINE_SKIP257
; Simplified conditional branch
;
LINE_NSKIP257:
;
JMP LINE_164
;
LINE_SKIP257:
;
;
LINE_162:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_163:
;
JMP LINE_165
;
LINE_164:
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_165:
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
LINE_166:
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
LINE_167:
;
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop2061_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop2061_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
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
LINE_168:
;
LDX #4
dceloop5314_10:
LDA VAR_AA,X
CMP VAR_I,X
BNE LINE_SKIP258
DEX
BPL dceloop5314_10
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP258:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_170
;
LINE_SKIP258:
;
;
LINE_169:
;
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_171
;
LINE_170:
;
LDA #<CONST_40
LDY #>CONST_40
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_171:
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
LINE_172:
;
LDA #32
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_173:
;
LDX #4
dcloop2061_2:
LDA VAR_AA,X
STA VAR_W,X
DEX
BPL dcloop2061_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_174:
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
;LDA #<CONST_3R
;LDY #>CONST_3R
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
LINE_175:
;
LDX #4
dcloop2061_3:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop2061_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_H
LDY #>VAR_H
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
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
;
LINE_176:
;
LDA VAR_J
COMP_SKP81:
BEQ LINE_SKIP259
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP259:
;
JMP LINE_179
;
LINE_SKIP259:
;
;
LINE_177:
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
BNE LINE_NSKIP260
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP260
;
LINE_NSKIP260:
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
LDA #<CONST_25
LDY #>CONST_25
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
JMP LINE_181
;
LINE_SKIP260:
;
;
LINE_178:
;
LDX #4
dcloop2061_4:
LDA CONST_23,X
STA VAR_M,X
DEX
BPL dcloop2061_4
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_180
;
LINE_179:
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
LINE_180:
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
LDA #<CONST_25
LDY #>CONST_25
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
LINE_181:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ43:
EQ_SKIP43:
COMP_SKP83:
BNE LINE_SKIP261
LINE_NSKIP261:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2227_1:
LDA CONST_23,X
STA VAR_M,X
DEX
BPL dcloop2227_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_183
;
LINE_SKIP261:
;
;
LINE_182:
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
LDA #<CONST_6R
LDY #>CONST_6R
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
LINE_183:
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
LINE_184:
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
LINE_185:
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
LINE_186:
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_187:
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
LDA CONST_23,X
STA VAR_Z,X
LDA CONST_23,X
STA VAR_EL,X
LDA CONST_23,X
STA VAR_ER,X
DEX
BPL dcloop2227_3
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_188:
;
JMP LINE_259
;
LINE_189:
;
JSR LINEBREAK
LDA #<CONST_41
LDY #>CONST_41
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_190:
;
LDA #<CONST_42
LDY #>CONST_42
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_191:
;
LDA #<CONST_43
LDY #>CONST_43
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_192:
;
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_193:
;
LDA #<CONST_45
LDY #>CONST_45
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDY #0
STY 198
; Optimizer rule: Simple POKE/2
LDA #<CONST_46R
LDY #>CONST_46R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
WAIT1:
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
JSR FACWORD
STY MOVSELF0+1
STA MOVSELF0+2
MOVSELF0:
LDA $FFFF
TAY
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDA #<D_REG
LDY #>D_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
LDX #<D_REG
LDY #>D_REG
; FAC to (X/Y)
JSR FACMEM
LDA D_REG
COMP_SKP86:
BEQ WAIT1
; Optimizer rule: CMP (REG) = 0(2)/3
;
LINE_194:
;
JMP RETURN
;
LINE_195:
;
JSR GOSUB
JSR LINE_147
LDA #<CONST_47
LDY #>CONST_47
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
LINE_196:
;
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
LDA #<CONST_48
LDY #>CONST_48
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
LDA #<CONST_26
LDY #>CONST_26
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_27
LDY #>CONST_27
JSR REALFAC
LDA #<CONST_28
LDY #>CONST_28
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_29R
LDY #>CONST_29R
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
STY MOVBSELF6+1
STA MOVBSELF6+2
LDA #$51
MOVBSELF6:
STA $FFFF
;
LINE_197:
;
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
LDA #<CONST_48
LDY #>CONST_48
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
LDA #<CONST_26
LDY #>CONST_26
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_27
LDY #>CONST_27
JSR REALFAC
LDA #<CONST_31
LDY #>CONST_31
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
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
STY MOVBSELF7+1
STA MOVBSELF7+2
LDA #$7
MOVBSELF7:
STA $FFFF
;
LINE_198:
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
COMP_SKP87:
BEQ LINE_SKIP262
; Simplified conditional branch
;
LINE_NSKIP262:
;
JMP LINE_474
;
LINE_SKIP262:
;
;
LINE_199:
;
LDA #<CONST_50
LDY #>CONST_50
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_200:
;
LDY 56320
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_JO
LDY #>VAR_JO
; FAC to (X/Y)
JSR FACMEM
;
LINE_201:
;
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFAC
LDA #<VAR_JO
LDY #>VAR_JO
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BEQ EQ_EQ45
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP45
EQ_EQ45:
LDA #$1
EQ_SKIP45:
COMP_SKP88:
BEQ LINE_SKIP263
; Simplified conditional branch
;
LINE_NSKIP263:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_II
LDY #>VAR_II
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_II
LDY #>VAR_II
; FAC to (X/Y)
JSR FACMEM
JMP LINE_206
;
LINE_SKIP263:
;
;
LINE_202:
;
LDA #<CONST_51R
LDY #>CONST_51R
JSR REALFAC
LDA #<VAR_JO
LDY #>VAR_JO
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BEQ EQ_EQ46
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP46
EQ_EQ46:
LDA #$1
EQ_SKIP46:
COMP_SKP89:
BEQ LINE_SKIP264
; Simplified conditional branch
;
LINE_NSKIP264:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_II
LDY #>VAR_II
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_II
LDY #>VAR_II
; FAC to (X/Y)
JSR FACMEM
JMP LINE_208
;
LINE_SKIP264:
;
;
LINE_203:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_JO
LDY #>VAR_JO
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BEQ EQ_EQ47
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP47
EQ_EQ47:
LDA #$1
EQ_SKIP47:
COMP_SKP90:
BEQ LINE_SKIP265
; Simplified conditional branch
;
LINE_NSKIP265:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_II
LDY #>VAR_II
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_II
LDY #>VAR_II
; FAC to (X/Y)
JSR FACMEM
JMP LINE_254
;
LINE_SKIP265:
;
;
LINE_204:
;
LDA #<CONST_52R
LDY #>CONST_52R
JSR REALFAC
LDA #<VAR_JO
LDY #>VAR_JO
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BEQ EQ_EQ48
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP48
EQ_EQ48:
LDA #$1
EQ_SKIP48:
COMP_SKP91:
BEQ LINE_SKIP266
; Simplified conditional branch
;
LINE_NSKIP266:
;
LDA #<CONST_53R
LDY #>CONST_53R
JSR REALFAC
LDA #<VAR_II
LDY #>VAR_II
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_II
LDY #>VAR_II
; FAC to (X/Y)
JSR FACMEM
JMP LINE_195
;
LINE_SKIP266:
;
;
LINE_205:
;
JMP LINE_200
;
LINE_206:
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
BEQ LT_LT_EQ49
ROL
BCC LT_LT49
LT_LT_EQ49:
LDA #0
JMP LT_SKIP49
LT_LT49:
LDA #$1
LT_SKIP49:
COMP_SKP92:
BEQ LINE_SKIP267
; Simplified conditional branch
;
LINE_NSKIP267:
;
LDA #<CONST_54
LDY #>CONST_54
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
LINE_SKIP267:
;
;
LINE_207:
;
JMP LINE_259
;
LINE_208:
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT50
LDA #0
JMP GT_SKIP50
GT_GT50:
LDA #$1
GT_SKIP50:
COMP_SKP93:
BEQ LINE_SKIP268
; Simplified conditional branch
;
LINE_NSKIP268:
;
LDA #<CONST_54
LDY #>CONST_54
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
LINE_SKIP268:
;
;
LINE_209:
;
JMP LINE_259
;
LINE_210:
;
JMP RETURN
;
LINE_211:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ51
LDA #0
JMP EQ_SKIP51
EQ_EQ51:
LDA #$1
EQ_SKIP51:
COMP_SKP94:
BNE LINE_NSKIP269
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP269
;
LINE_NSKIP269:
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
JMP LINE_216
;
LINE_SKIP269:
;
;
LINE_212:
;
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ52
ROL
BCC LT_LT52
LT_LT_EQ52:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP52
LT_LT52:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP52:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24
LDY #>CONST_24
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ53
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP53
EQ_EQ53:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP53:
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
BEQ LINE_SKIP270
; Simplified conditional branch
;
LINE_NSKIP270:
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
JMP LINE_216
;
LINE_SKIP270:
;
;
LINE_213:
;
LDA #<CONST_25
LDY #>CONST_25
JSR REALFAC
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
COMP_SKP96:
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
JMP LINE_216
;
LINE_SKIP271:
;
;
LINE_214:
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
LDA #<CONST_54
LDY #>CONST_54
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
COMP_SKP97:
BNE LINE_NSKIP272
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP272
;
LINE_NSKIP272:
;
LDX #4
dcloop2725_1:
LDA VAR_A,X
STA VAR_A1,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_24
LDY #>CONST_24
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
JMP LINE_216
;
LINE_SKIP272:
;
;
LINE_215:
;
LDX #4
dcloop2725_2:
LDA CONST_23,X
STA VAR_EL,X
DEX
BPL dcloop2725_2
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_216:
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
EQ_EQ57:
EQ_SKIP57:
COMP_SKP98:
BNE LINE_SKIP273
LINE_NSKIP273:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_218
;
LINE_SKIP273:
;
;
LINE_217:
;
LDX #4
dcloop2725_3:
LDA CONST_24,X
STA VAR_I,X
DEX
BPL dcloop2725_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Z
LDY #>VAR_Z
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
LDA #<CONST_55R
LDY #>CONST_55R
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
LINE_218:
;
LDA #<CONST_24
LDY #>CONST_24
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
LINE_219:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ58
LDA #0
JMP EQ_SKIP58
EQ_EQ58:
LDA #$1
EQ_SKIP58:
COMP_SKP100:
BNE LINE_NSKIP274
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP274
;
LINE_NSKIP274:
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
JMP LINE_224
;
LINE_SKIP274:
;
;
LINE_220:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT59
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP59
GT_GT59:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP59:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24
LDY #>CONST_24
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ60
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP60
EQ_EQ60:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP60:
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
BNE LINE_NSKIP275
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP275
;
LINE_NSKIP275:
;
LDX #4
dcloop2725_4:
LDA VAR_A,X
STA VAR_A1,X
DEX
BPL dcloop2725_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_24
LDY #>CONST_24
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
JMP LINE_224
;
LINE_SKIP275:
;
;
LINE_221:
;
LDA #<CONST_25
LDY #>CONST_25
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ61
LDA #0
JMP EQ_SKIP61
EQ_EQ61:
LDA #$1
EQ_SKIP61:
COMP_SKP102:
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
JMP LINE_224
;
LINE_SKIP276:
;
;
LINE_222:
;
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ62
ROL
BCC LT_LT62
LT_LT_EQ62:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP62
LT_LT62:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP62:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ63
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP63
EQ_EQ63:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP63:
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
BEQ LINE_SKIP277
; Simplified conditional branch
;
LINE_NSKIP277:
LDX #4
dcloop2891_1:
LDA VAR_A,X
STA VAR_A1,X
LDA VAR_B,X
STA VAR_B1,X
DEX
BPL dcloop2891_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_224
;
LINE_SKIP277:
;
;
LINE_223:
;
LDX #4
dcloop2891_3:
LDA CONST_23,X
STA VAR_ER,X
DEX
BPL dcloop2891_3
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_224:
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
EQ_EQ64:
EQ_SKIP64:
COMP_SKP104:
BNE LINE_SKIP278
LINE_NSKIP278:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_226
;
LINE_SKIP278:
;
;
LINE_225:
;
LDX #4
dcloop2891_4:
LDA CONST_24,X
STA VAR_I,X
DEX
BPL dcloop2891_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Z
LDY #>VAR_Z
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
LDA #<CONST_55R
LDY #>CONST_55R
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
LINE_226:
;
LDA #<CONST_24
LDY #>CONST_24
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
LINE_227:
;
LDA VAR_B
BEQ EQ_SKIP65
EQ_EQ65:
JMP LINE_SKIP279
EQ_SKIP65:
COMP_SKP106:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP279:
;
JMP LINE_235
;
LINE_SKIP279:
;
;
LINE_228:
;
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT66
LDA #0
JMP GT_SKIP66
GT_GT66:
LDA #$1
GT_SKIP66:
COMP_SKP107:
BEQ LINE_SKIP280
; Simplified conditional branch
;
LINE_NSKIP280:
;
LDX #4
dcloop2891_5:
LDA CONST_25,X
STA VAR_E,X
DEX
BPL dcloop2891_5
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP280:
;
;
LINE_229:
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
EQ_EQ67:
EQ_SKIP67:
COMP_SKP108:
BNE LINE_SKIP281
LINE_NSKIP281:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_231
;
LINE_SKIP281:
;
;
LINE_230:
;
LDX #4
dcloop2891_6:
LDA CONST_24,X
STA VAR_I,X
DEX
BPL dcloop2891_6
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Z
LDY #>VAR_Z
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
LDA #<CONST_55R
LDY #>CONST_55R
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
LINE_231:
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
LDA #<CONST_6R
LDY #>CONST_6R
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
LINE_232:
;
LDA VAR_C
BEQ EQ_SKIP68
EQ_EQ68:
JMP LINE_SKIP282
EQ_SKIP68:
COMP_SKP110:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP282:
;
JSR GOSUB
JSR LINE_211
;
LINE_SKIP282:
;
;
LINE_233:
;
LDA VAR_D
BEQ EQ_SKIP69
EQ_EQ69:
JMP LINE_SKIP283
EQ_SKIP69:
COMP_SKP111:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP283:
;
JSR GOSUB
JSR LINE_219
;
LINE_SKIP283:
;
;
LINE_234:
;
JMP RETURN
;
LINE_235:
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
dcloop3057_1:
LDA CONST_34,X
STA VAR_E,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_236:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
NEQ_NEQ70:
NEQ_SKIP70:
COMP_SKP112:
BEQ LINE_SKIP284
LINE_NSKIP284:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_240
;
LINE_SKIP284:
;
;
LINE_237:
;
LDX #4
dcloop3057_2:
LDA CONST_23,X
STA VAR_E,X
DEX
BPL dcloop3057_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_238:
;
LDX #4
dceloop5314_11:
LDA VAR_W,X
CMP VAR_A,X
BNE LINE_SKIP285
DEX
BPL dceloop5314_11
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP285:
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
LINE_SKIP285:
;
;
LINE_239:
;
JMP RETURN
;
LINE_240:
;
LDX #4
dceloop5314_12:
LDA CONST_25,X
CMP VAR_Z,X
BNE LINE_SKIP286
DEX
BPL dceloop5314_12
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP286:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop3057_3:
LDA CONST_24,X
STA VAR_E,X
DEX
BPL dcloop3057_3
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP286:
;
;
LINE_241:
;
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ73
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP73
EQ_EQ73:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP73:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24
LDY #>CONST_24
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ74
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP74
EQ_EQ74:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP74:
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
BEQ LINE_SKIP287
; Simplified conditional branch
;
LINE_NSKIP287:
;
LDX #4
dcloop3057_4:
LDA CONST_24,X
STA VAR_E,X
DEX
BPL dcloop3057_4
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP287:
;
;
LINE_242:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ75
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP75
EQ_EQ75:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP75:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ76
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP76
EQ_EQ76:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP76:
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
BEQ LINE_SKIP288
; Simplified conditional branch
;
LINE_NSKIP288:
;
LDX #4
dcloop3057_5:
LDA CONST_24,X
STA VAR_E,X
DEX
BPL dcloop3057_5
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP288:
;
;
LINE_243:
;
JMP RETURN
;
LINE_244:
;
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT77
LDA #0
JMP GT_SKIP77
GT_GT77:
LDA #$1
GT_SKIP77:
COMP_SKP117:
BEQ LINE_SKIP289
; Simplified conditional branch
;
LINE_NSKIP289:
;
JMP LINE_250
;
LINE_SKIP289:
;
;
LINE_245:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
EQ_EQ78:
EQ_SKIP78:
COMP_SKP118:
BNE LINE_SKIP290
LINE_NSKIP290:
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
LINE_SKIP290:
;
;
LINE_246:
;
LDX #4
dceloop5314_13:
LDA CONST_24,X
CMP VAR_Z,X
BNE LINE_SKIP291
DEX
BPL dceloop5314_13
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP291:
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
LINE_SKIP291:
;
;
LINE_247:
;
LDX #4
dceloop5314_14:
LDA CONST_25,X
CMP VAR_Z,X
BNE LINE_SKIP292
DEX
BPL dceloop5314_14
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP292:
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
LINE_SKIP292:
;
;
LINE_248:
;
LDX #4
dceloop5314_15:
LDA CONST_54,X
CMP VAR_Z,X
BNE LINE_SKIP293
DEX
BPL dceloop5314_15
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP293:
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
LINE_SKIP293:
;
;
LINE_249:
;
LDA #<CONST_56
LDY #>CONST_56
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_250:
;
LDA VAR_E
BEQ EQ_SKIP82
EQ_EQ82:
JMP LINE_SKIP294
EQ_SKIP82:
COMP_SKP122:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP294:
;
JMP LINE_252
;
LINE_SKIP294:
;
;
LINE_251:
;
LDA #<CONST_57
LDY #>CONST_57
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_252:
;
LDX #4
dcloop3223_1:
LDA CONST_23,X
STA VAR_S,X
DEX
BPL dcloop3223_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_253:
;
JMP RETURN
;
LINE_254:
LDX #4
dcloop3223_2:
LDA VAR_X,X
STA VAR_A,X
LDA VAR_Y,X
STA VAR_B,X
DEX
BPL dcloop3223_2
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_255:
;
JSR GOSUB
JSR LINE_227
;
LINE_256:
;
JSR GOSUB
JSR LINE_244
;
LINE_257:
LDX #4
dcloop3223_4:
LDA VAR_A,X
STA VAR_X,X
LDA VAR_B,X
STA VAR_Y,X
DEX
BPL dcloop3223_4
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_258:
;
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT83
LDA #0
JMP GT_SKIP83
GT_GT83:
LDA #$1
GT_SKIP83:
COMP_SKP123:
BEQ LINE_SKIP295
; Simplified conditional branch
;
LINE_NSKIP295:
;
JMP LINE_198
;
LINE_SKIP295:
;
;
LINE_259:
LDX #4
dcloop3223_6:
LDA VAR_X,X
STA VAR_A,X
LDA VAR_Y,X
STA VAR_B,X
DEX
BPL dcloop3223_6
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_260:
;
JSR GOSUB
JSR LINE_227
;
LINE_261:
;
;
LINE_262:
;
LDX #4
dcloop3223_8:
LDA CONST_23,X
STA VAR_T,X
DEX
BPL dcloop3223_8
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_53R
LDY #>CONST_53R
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
LDA #<FORLOOP10
STA JUMP_TARGET
LDA #>FORLOOP10
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP10:
;
LINE_263:
;
JSR GOSUB
JSR LINE_274
;
LINE_264:
;
LDA VAR_E
COMP_SKP124:
BEQ LINE_SKIP296
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP296:
;
LDX #4
dcloop3223_9:
LDA CONST_58,X
STA VAR_T,X
DEX
BPL dcloop3223_9
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_268
;
LINE_SKIP296:
;
;
LINE_265:
;
JSR GOSUB
JSR LINE_244
;
LINE_266:
;
JSR GOSUB
JSR LINE_227
;
LINE_267:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT84
LDA #0
JMP GT_SKIP84
GT_GT84:
LDA #$1
GT_SKIP84:
COMP_SKP125:
BEQ LINE_SKIP297
; Simplified conditional branch
;
LINE_NSKIP297:
;
LDX #4
dcloop3223_10:
LDA CONST_58,X
STA VAR_T,X
DEX
BPL dcloop3223_10
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_268
;
LINE_SKIP297:
;
;
LINE_268:
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
LINE_269:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
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
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ86
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP86
EQ_EQ86:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP86:
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
BEQ EQ_EQ87
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP87
EQ_EQ87:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP87:
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
BEQ LINE_SKIP298
; Simplified conditional branch
;
LINE_NSKIP298:
;
JMP LINE_273
;
LINE_SKIP298:
;
;
LINE_270:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ88
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP88
EQ_EQ88:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP88:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ89
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP89
EQ_EQ89:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP89:
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
BNE NEQ_NEQ90
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP90
NEQ_NEQ90:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP90:
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
BEQ LINE_SKIP299
; Simplified conditional branch
;
LINE_NSKIP299:
;
JSR GOSUB
JSR LINE_249
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_272
;
LINE_SKIP299:
;
;
LINE_271:
;
JMP LINE_273
;
LINE_272:
;
JSR GOSUB
JSR LINE_249
LDA #<CONST_60
LDY #>CONST_60
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_273:
;
JMP LINE_198
;
LINE_274:
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
JMP LINE_275
AFTER15SUB0:
ON15SUB1:
INX
CPX TMP_ZP
COMP_SKP130:
BNE AFTER15SUB1
JMP LINE_311
AFTER15SUB1:
ON15SUB2:
INX
CPX TMP_ZP
COMP_SKP131:
BNE AFTER15SUB2
JMP LINE_355
AFTER15SUB2:
ON15SUB3:
INX
CPX TMP_ZP
COMP_SKP132:
BNE AFTER15SUB3
JMP LINE_399
AFTER15SUB3:
ON15SUB4:
INX
CPX TMP_ZP
COMP_SKP133:
BNE AFTER15SUB4
JMP LINE_447
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
LINE_275:
;
;
LINE_276:
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_277:
;
LDA #<CONST_24
LDY #>CONST_24
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT91
LDA #0
JMP GT_SKIP91
GT_GT91:
LDA #$1
GT_SKIP91:
COMP_SKP134:
BEQ LINE_SKIP300
; Simplified conditional branch
;
LINE_NSKIP300:
;
JMP RETURN
;
LINE_SKIP300:
;
;
LINE_278:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT92
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP92
GT_GT92:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP92:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ93
ROL
BCC LT_LT93
LT_LT_EQ93:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP93
LT_LT93:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP93:
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
BEQ LINE_SKIP301
; Simplified conditional branch
;
LINE_NSKIP301:
;
JSR GOSUB
JSR LINE_251
JMP RETURN
;
LINE_SKIP301:
;
;
LINE_279:
;
LDX #4
dcloop3389_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop3389_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_61R
LDY #>CONST_61R
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
EQ_EQ94:
EQ_SKIP94:
COMP_SKP136:
BNE LINE_SKIP302
LINE_NSKIP302:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_62
LDY #>CONST_62
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_285
;
LINE_SKIP302:
;
;
LINE_280:
;
LDA VAR_Y
BEQ EQ_EQ95
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP95
EQ_EQ95:
LDA #$1
EQ_SKIP95:
COMP_SKP137:
BNE LINE_NSKIP303
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP303
;
LINE_NSKIP303:
;
LDA #<CONST_63
LDY #>CONST_63
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
LDA #<CONST_64
LDY #>CONST_64
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
LDA #<CONST_65
LDY #>CONST_65
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
LDA #<CONST_66
LDY #>CONST_66
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_285
;
LINE_SKIP303:
;
;
LINE_281:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ96:
EQ_SKIP96:
COMP_SKP138:
BNE LINE_SKIP304
LINE_NSKIP304:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_67
LDY #>CONST_67
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_285
;
LINE_SKIP304:
;
;
LINE_282:
;
LDX #4
dceloop5314_16:
LDA CONST_24,X
CMP VAR_I,X
BNE LINE_SKIP305
DEX
BPL dceloop5314_16
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP305:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_68
LDY #>CONST_68
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_285
;
LINE_SKIP305:
;
;
LINE_283:
;
LDA #<CONST_29R
LDY #>CONST_29R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ98
ROL
BCC LT_LT98
LT_LT_EQ98:
LDA #0
JMP LT_SKIP98
LT_LT98:
LDA #$1
LT_SKIP98:
COMP_SKP140:
BEQ LINE_SKIP306
; Simplified conditional branch
;
LINE_NSKIP306:
;
LDA #<CONST_69
LDY #>CONST_69
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_285
;
LINE_SKIP306:
;
;
LINE_284:
;
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_285:
;
LDA VAR_E
BEQ EQ_SKIP99
EQ_EQ99:
JMP LINE_SKIP307
EQ_SKIP99:
COMP_SKP141:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP307:
;
LDA #<CONST_71R
LDY #>CONST_71R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
JMP LINE_288
;
LINE_SKIP307:
;
;
LINE_286:
;
LDA VAR_Y
BEQ EQ_EQ100
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP100
EQ_EQ100:
LDA #$1
EQ_SKIP100:
COMP_SKP142:
BNE LINE_NSKIP308
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP308
;
LINE_NSKIP308:
;
LDA #<CONST_72
LDY #>CONST_72
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
LDA #<CONST_71R
LDY #>CONST_71R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_65
LDY #>CONST_65
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
LDA #<CONST_66
LDY #>CONST_66
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_288
;
LINE_SKIP308:
;
;
LINE_287:
;
LDA #<CONST_73
LDY #>CONST_73
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_288:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ101:
EQ_SKIP101:
COMP_SKP143:
BNE LINE_SKIP309
LINE_NSKIP309:
; Optimizer rule: Simplified equal comparison/6
;
LDA #116
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_294
;
LINE_SKIP309:
;
;
LINE_289:
;
LDA VAR_Y
BEQ EQ_EQ102
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP102
EQ_EQ102:
LDA #$1
EQ_SKIP102:
COMP_SKP144:
BNE LINE_NSKIP310
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP310
;
LINE_NSKIP310:
;
LDA #<CONST_72
LDY #>CONST_72
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
LDA #<CONST_64
LDY #>CONST_64
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
LDA #<CONST_65
LDY #>CONST_65
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
LDA #<CONST_66
LDY #>CONST_66
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_294
;
LINE_SKIP310:
;
;
LINE_290:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ103:
EQ_SKIP103:
COMP_SKP145:
BNE LINE_SKIP311
LINE_NSKIP311:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_75
LDY #>CONST_75
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_294
;
LINE_SKIP311:
;
;
LINE_291:
;
LDX #4
dceloop5314_17:
LDA CONST_24,X
CMP VAR_I,X
BNE LINE_SKIP312
DEX
BPL dceloop5314_17
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP312:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_76
LDY #>CONST_76
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_294
;
LINE_SKIP312:
;
;
LINE_292:
;
LDA #<CONST_29R
LDY #>CONST_29R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ105
ROL
BCC LT_LT105
LT_LT_EQ105:
LDA #0
JMP LT_SKIP105
LT_LT105:
LDA #$1
LT_SKIP105:
COMP_SKP147:
BEQ LINE_SKIP313
; Simplified conditional branch
;
LINE_NSKIP313:
;
LDA #<CONST_77
LDY #>CONST_77
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_294
;
LINE_SKIP313:
;
;
LINE_293:
;
LDA #<CONST_78
LDY #>CONST_78
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_294:
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
LINE_295:
;
LDX #4
dcloop3555_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_25
LDY #>CONST_25
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
LDA #<FORLOOP12
STA JUMP_TARGET
LDA #>FORLOOP12
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP12:
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ106
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP106
EQ_EQ106:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP106:
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
BEQ EQ_EQ107
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP107
EQ_EQ107:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP107:
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
BEQ EQ_EQ108
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP108
EQ_EQ108:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP108:
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
BEQ LINE_SKIP314
; Simplified conditional branch
;
LINE_NSKIP314:
;
JMP LINE_301
;
LINE_SKIP314:
;
;
LINE_296:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ109:
NEQ_SKIP109:
COMP_SKP150:
BEQ LINE_SKIP315
LINE_NSKIP315:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_298
;
LINE_SKIP315:
;
;
LINE_297:
;
LDA VAR_EL
BEQ EQ_SKIP110
EQ_EQ110:
JMP LINE_SKIP316
EQ_SKIP110:
COMP_SKP151:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP316:
;
LDA #<CONST_79
LDY #>CONST_79
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_302
;
LINE_SKIP316:
;
;
LINE_298:
;
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_64
LDY #>CONST_64
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
LDA #<CONST_81
LDY #>CONST_81
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
;
LINE_299:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ111:
EQ_SKIP111:
COMP_SKP152:
BNE LINE_SKIP317
LINE_NSKIP317:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_302
;
LINE_SKIP317:
;
;
LINE_300:
;
JMP LINE_303
;
LINE_301:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_83
LDY #>CONST_83
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_84
LDY #>CONST_84
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ112:
NEQ_SKIP112:
COMP_SKP153:
BEQ LINE_SKIP318
LINE_NSKIP318:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_303
;
LINE_SKIP318:
;
;
LINE_302:
;
LDA VAR_E
BEQ EQ_SKIP113
EQ_EQ113:
JMP LINE_SKIP319
EQ_SKIP113:
COMP_SKP154:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP319:
;
LDA #<CONST_85
LDY #>CONST_85
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_304
;
LINE_SKIP319:
;
;
LINE_303:
;
LDA #<CONST_86
LDY #>CONST_86
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_304:
;
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ114
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP114
EQ_EQ114:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP114:
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
BEQ EQ_EQ115
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP115
EQ_EQ115:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP115:
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
BEQ EQ_EQ116
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP116
EQ_EQ116:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP116:
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
BEQ LINE_SKIP320
; Simplified conditional branch
;
LINE_NSKIP320:
;
JMP LINE_308
;
LINE_SKIP320:
;
;
LINE_305:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ117:
NEQ_SKIP117:
COMP_SKP156:
BEQ LINE_SKIP321
LINE_NSKIP321:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_307
;
LINE_SKIP321:
;
;
LINE_306:
;
LDA VAR_ER
BEQ EQ_SKIP118
EQ_EQ118:
JMP LINE_SKIP322
EQ_SKIP118:
COMP_SKP157:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP322:
;
LDA #<CONST_87
LDY #>CONST_87
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_309
;
LINE_SKIP322:
;
;
LINE_307:
;
LDA #<CONST_38
LDY #>CONST_38
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
LDA #<CONST_81
LDY #>CONST_81
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
LDA #<CONST_64
LDY #>CONST_64
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_309
;
LINE_308:
;
LDA #<CONST_38
LDY #>CONST_38
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_309:
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
LINE_310:
;
JMP RETURN
;
LINE_311:
;
;
LINE_312:
;
LDA #<CONST_90
LDY #>CONST_90
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_91
LDY #>CONST_91
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_313:
;
LDX #4
dcloop3887_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_24
LDY #>CONST_24
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
BEQ EQ_SKIP119
EQ_EQ119:
JMP LINE_SKIP323
EQ_SKIP119:
COMP_SKP159:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP323:
;
JMP LINE_316
;
LINE_SKIP323:
;
;
LINE_314:
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
LDA #<CONST_24
LDY #>CONST_24
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
JMP LINE_319
;
LINE_315:
;
LDA #<CONST_92
LDY #>CONST_92
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_319
;
LINE_316:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ120:
EQ_SKIP120:
COMP_SKP160:
BNE LINE_SKIP324
LINE_NSKIP324:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_54
LDY #>CONST_54
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
JMP LINE_319
;
LINE_SKIP324:
;
;
LINE_317:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ121:
EQ_SKIP121:
COMP_SKP161:
BNE LINE_SKIP325
LINE_NSKIP325:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_93
LDY #>CONST_93
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_319
;
LINE_SKIP325:
;
;
LINE_318:
;
LDA #<CONST_94
LDY #>CONST_94
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_319:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ122
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP122
EQ_EQ122:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP122:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ123
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP123
EQ_EQ123:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP123:
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
BEQ LINE_SKIP326
; Simplified conditional branch
;
LINE_NSKIP326:
;
LDA #<CONST_55R
LDY #>CONST_55R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
JMP LINE_321
;
LINE_SKIP326:
;
;
LINE_320:
;
LDA #<CONST_95
LDY #>CONST_95
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_321:
;
LDA VAR_D
BEQ EQ_SKIP124
EQ_EQ124:
JMP LINE_SKIP327
EQ_SKIP124:
COMP_SKP163:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP327:
;
JMP LINE_323
;
LINE_SKIP327:
;
;
LINE_322:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_24
LDY #>CONST_24
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
JMP LINE_326
;
LINE_323:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ125:
EQ_SKIP125:
COMP_SKP164:
BNE LINE_SKIP328
LINE_NSKIP328:
; Optimizer rule: Simplified equal comparison/6
;
JSR LINEBREAK
JMP LINE_326
;
LINE_SKIP328:
;
;
LINE_324:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ126:
EQ_SKIP126:
COMP_SKP165:
BNE LINE_SKIP329
LINE_NSKIP329:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_93
LDY #>CONST_93
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_326
;
LINE_SKIP329:
;
;
LINE_325:
;
LDA #<CONST_96
LDY #>CONST_96
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_326:
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
LINE_327:
;
LDX #4
dcloop3887_2:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop3887_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_97R
LDY #>CONST_97R
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
EQ_EQ127:
EQ_SKIP127:
COMP_SKP167:
BNE LINE_SKIP330
LINE_NSKIP330:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_98
LDY #>CONST_98
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_332
;
LINE_SKIP330:
;
;
LINE_328:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ128:
EQ_SKIP128:
COMP_SKP168:
BNE LINE_SKIP331
LINE_NSKIP331:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_99
LDY #>CONST_99
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_332
;
LINE_SKIP331:
;
;
LINE_329:
;
LDX #4
dceloop5314_18:
LDA CONST_25,X
CMP VAR_I,X
BNE LINE_SKIP332
DEX
BPL dceloop5314_18
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP332:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_100
LDY #>CONST_100
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_332
;
LINE_SKIP332:
;
;
LINE_330:
;
LDA #<CONST_101R
LDY #>CONST_101R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT130
LDA #0
JMP GT_SKIP130
GT_GT130:
LDA #$1
GT_SKIP130:
COMP_SKP170:
BEQ LINE_SKIP333
; Simplified conditional branch
;
LINE_NSKIP333:
;
LDA #<CONST_102
LDY #>CONST_102
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_332
;
LINE_SKIP333:
;
;
LINE_331:
;
LDA #<CONST_103
LDY #>CONST_103
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_332:
;
LDA VAR_E
BEQ EQ_SKIP131
EQ_EQ131:
JMP LINE_SKIP334
EQ_SKIP131:
COMP_SKP171:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP334:
;
LDA #<CONST_104
LDY #>CONST_104
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_334
;
LINE_SKIP334:
;
;
LINE_333:
;
LDA #<CONST_105
LDY #>CONST_105
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_334:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ132:
EQ_SKIP132:
COMP_SKP172:
BNE LINE_SKIP335
LINE_NSKIP335:
; Optimizer rule: Simplified equal comparison/6
;
LDA #116
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_339
;
LINE_SKIP335:
;
;
LINE_335:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ133:
EQ_SKIP133:
COMP_SKP173:
BNE LINE_SKIP336
LINE_NSKIP336:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_106
LDY #>CONST_106
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_339
;
LINE_SKIP336:
;
;
LINE_336:
;
LDX #4
dceloop5314_19:
LDA CONST_25,X
CMP VAR_I,X
BNE LINE_SKIP337
DEX
BPL dceloop5314_19
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP337:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_107
LDY #>CONST_107
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_339
;
LINE_SKIP337:
;
;
LINE_337:
;
LDA #<CONST_101R
LDY #>CONST_101R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT135
LDA #0
JMP GT_SKIP135
GT_GT135:
LDA #$1
GT_SKIP135:
COMP_SKP175:
BEQ LINE_SKIP338
; Simplified conditional branch
;
LINE_NSKIP338:
;
LDA #<CONST_108
LDY #>CONST_108
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_339
;
LINE_SKIP338:
;
;
LINE_338:
;
LDA #<CONST_109
LDY #>CONST_109
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_339:
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
LINE_340:
;
LDX #4
dcloop4053_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop4053_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_6R
LDY #>CONST_6R
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
EQ_EQ136:
EQ_SKIP136:
COMP_SKP177:
BNE LINE_SKIP339
LINE_NSKIP339:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_345
;
LINE_SKIP339:
;
;
LINE_341:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ137:
NEQ_SKIP137:
COMP_SKP178:
BEQ LINE_SKIP340
LINE_NSKIP340:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_344
;
LINE_SKIP340:
;
;
LINE_342:
;
LDA VAR_EL
BEQ EQ_SKIP138
EQ_EQ138:
JMP LINE_SKIP341
EQ_SKIP138:
COMP_SKP179:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP341:
;
LDA #<CONST_110
LDY #>CONST_110
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_346
;
LINE_SKIP341:
;
;
LINE_343:
;
LDA #<CONST_111
LDY #>CONST_111
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_346
;
LINE_344:
;
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_54
LDY #>CONST_54
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
LDA #<CONST_81
LDY #>CONST_81
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
JMP LINE_347
;
LINE_345:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_54
LDY #>CONST_54
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_84
LDY #>CONST_84
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ139:
NEQ_SKIP139:
COMP_SKP180:
BEQ LINE_SKIP342
LINE_NSKIP342:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_347
;
LINE_SKIP342:
;
;
LINE_346:
;
LDA VAR_E
BEQ EQ_SKIP140
EQ_EQ140:
JMP LINE_SKIP343
EQ_SKIP140:
COMP_SKP181:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP343:
;
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_348
;
LINE_SKIP343:
;
;
LINE_347:
;
LDA #<CONST_113
LDY #>CONST_113
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_348:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ141:
EQ_SKIP141:
COMP_SKP182:
BNE LINE_SKIP344
LINE_NSKIP344:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_352
;
LINE_SKIP344:
;
;
LINE_349:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ142:
NEQ_SKIP142:
COMP_SKP183:
BEQ LINE_SKIP345
LINE_NSKIP345:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_351
;
LINE_SKIP345:
;
;
LINE_350:
;
LDA VAR_ER
BEQ EQ_SKIP143
EQ_EQ143:
JMP LINE_SKIP346
EQ_SKIP143:
COMP_SKP184:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP346:
;
LDA #<CONST_114
LDY #>CONST_114
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_353
;
LINE_SKIP346:
;
;
LINE_351:
;
LDA #<CONST_38
LDY #>CONST_38
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
LDA #<CONST_81
LDY #>CONST_81
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
LDA #<CONST_54
LDY #>CONST_54
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_353
;
LINE_352:
;
LDA #<CONST_38
LDY #>CONST_38
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_353
;
LINE_353:
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
LINE_354:
;
JMP RETURN
;
LINE_355:
;
;
LINE_356:
;
LDA #<CONST_115
LDY #>CONST_115
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<CONST_116
LDY #>CONST_116
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
LINE_357:
;
LDX #4
dcloop4219_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop4219_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_5R
LDY #>CONST_5R
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
BEQ EQ_SKIP144
EQ_EQ144:
JMP LINE_SKIP347
EQ_SKIP144:
COMP_SKP186:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP347:
;
JMP LINE_359
;
LINE_SKIP347:
;
;
LINE_358:
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
LDA #<CONST_25
LDY #>CONST_25
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
JMP LINE_362
;
LINE_359:
;
LDA #<CONST_25
LDY #>CONST_25
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ145
ROL
BCC LT_LT145
LT_LT_EQ145:
LDA #0
JMP LT_SKIP145
LT_LT145:
LDA #$1
LT_SKIP145:
COMP_SKP187:
BEQ LINE_SKIP348
; Simplified conditional branch
;
LINE_NSKIP348:
;
LDA #<CONST_117
LDY #>CONST_117
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_362
;
LINE_SKIP348:
;
;
LINE_360:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ146:
EQ_SKIP146:
COMP_SKP188:
BNE LINE_SKIP349
LINE_NSKIP349:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_118
LDY #>CONST_118
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_362
;
LINE_SKIP349:
;
;
LINE_361:
;
LDA #<CONST_119
LDY #>CONST_119
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_362:
;
LDA #<CONST_24
LDY #>CONST_24
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ147
BEQ LTEQ_LTEQ147
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LTEQ_SKIP147
LTEQ_LTEQ147:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LTEQ_SKIP147:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ148
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP148
EQ_EQ148:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP148:
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
BEQ LINE_SKIP350
; Simplified conditional branch
;
LINE_NSKIP350:
;
LDA #<CONST_120
LDY #>CONST_120
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_364
;
LINE_SKIP350:
;
;
LINE_363:
;
LDA #<CONST_121
LDY #>CONST_121
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_364:
;
LDA VAR_D
BEQ EQ_SKIP149
EQ_EQ149:
JMP LINE_SKIP351
EQ_SKIP149:
COMP_SKP190:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP351:
;
JMP LINE_366
;
LINE_SKIP351:
;
;
LINE_365:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_5R
LDY #>CONST_5R
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
JMP LINE_369
;
LINE_366:
;
LDA #<CONST_25
LDY #>CONST_25
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ150
ROL
BCC LT_LT150
LT_LT_EQ150:
LDA #0
JMP LT_SKIP150
LT_LT150:
LDA #$1
LT_SKIP150:
COMP_SKP191:
BEQ LINE_SKIP352
; Simplified conditional branch
;
LINE_NSKIP352:
;
JSR LINEBREAK
JMP LINE_369
;
LINE_SKIP352:
;
;
LINE_367:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ151:
EQ_SKIP151:
COMP_SKP192:
BNE LINE_SKIP353
LINE_NSKIP353:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_118
LDY #>CONST_118
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_369
;
LINE_SKIP353:
;
;
LINE_368:
;
LDA #<CONST_96
LDY #>CONST_96
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_369:
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
LINE_370:
;
LDX #4
dcloop4385_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_122R
LDY #>CONST_122R
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
EQ_EQ152:
EQ_SKIP152:
COMP_SKP194:
BNE LINE_SKIP354
LINE_NSKIP354:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_123
LDY #>CONST_123
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_375
;
LINE_SKIP354:
;
;
LINE_371:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ153:
EQ_SKIP153:
COMP_SKP195:
BNE LINE_SKIP355
LINE_NSKIP355:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_124
LDY #>CONST_124
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_375
;
LINE_SKIP355:
;
;
LINE_372:
;
LDX #4
dceloop5314_20:
LDA CONST_24,X
CMP VAR_I,X
BNE LINE_SKIP356
DEX
BPL dceloop5314_20
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP356:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_125
LDY #>CONST_125
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_375
;
LINE_SKIP356:
;
;
LINE_373:
;
LDA #<CONST_126
LDY #>CONST_126
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT155
LDA #0
JMP GT_SKIP155
GT_GT155:
LDA #$1
GT_SKIP155:
COMP_SKP197:
BEQ LINE_SKIP357
; Simplified conditional branch
;
LINE_NSKIP357:
;
LDA #<CONST_127
LDY #>CONST_127
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_375
;
LINE_SKIP357:
;
;
LINE_374:
;
LDA #<CONST_128
LDY #>CONST_128
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_375:
;
LDA VAR_E
BEQ EQ_SKIP156
EQ_EQ156:
JMP LINE_SKIP358
EQ_SKIP156:
COMP_SKP198:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP358:
;
LDA #<CONST_120
LDY #>CONST_120
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_377
;
LINE_SKIP358:
;
;
LINE_376:
;
LDA #<CONST_75
LDY #>CONST_75
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_377:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ157:
EQ_SKIP157:
COMP_SKP199:
BNE LINE_SKIP359
LINE_NSKIP359:
; Optimizer rule: Simplified equal comparison/6
;
LDA #116
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_382
;
LINE_SKIP359:
;
;
LINE_378:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ158:
EQ_SKIP158:
COMP_SKP200:
BNE LINE_SKIP360
LINE_NSKIP360:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_124
LDY #>CONST_124
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_382
;
LINE_SKIP360:
;
;
LINE_379:
;
LDX #4
dceloop5314_21:
LDA CONST_24,X
CMP VAR_I,X
BNE LINE_SKIP361
DEX
BPL dceloop5314_21
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP361:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_129
LDY #>CONST_129
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_382
;
LINE_SKIP361:
;
;
LINE_380:
;
LDA #<CONST_126
LDY #>CONST_126
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT160
LDA #0
JMP GT_SKIP160
GT_GT160:
LDA #$1
GT_SKIP160:
COMP_SKP202:
BEQ LINE_SKIP362
; Simplified conditional branch
;
LINE_NSKIP362:
;
LDA #<CONST_130
LDY #>CONST_130
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_382
;
LINE_SKIP362:
;
;
LINE_381:
;
LDA #<CONST_77
LDY #>CONST_77
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_382:
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
LINE_383:
;
LDX #4
dcloop4551_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_5R
LDY #>CONST_5R
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
EQ_EQ161:
EQ_SKIP161:
COMP_SKP204:
BNE LINE_SKIP363
LINE_NSKIP363:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_389
;
LINE_SKIP363:
;
;
LINE_384:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ162:
NEQ_SKIP162:
COMP_SKP205:
BEQ LINE_SKIP364
LINE_NSKIP364:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_386
;
LINE_SKIP364:
;
;
LINE_385:
;
LDA VAR_EL
BEQ EQ_SKIP163
EQ_EQ163:
JMP LINE_SKIP365
EQ_SKIP163:
COMP_SKP206:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP365:
;
LDA #<CONST_131
LDY #>CONST_131
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_390
;
LINE_SKIP365:
;
;
LINE_386:
;
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_25
LDY #>CONST_25
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
LDA #<CONST_81
LDY #>CONST_81
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
;
LINE_387:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ164:
EQ_SKIP164:
COMP_SKP207:
BNE LINE_SKIP366
LINE_NSKIP366:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_390
;
LINE_SKIP366:
;
;
LINE_388:
;
JMP LINE_391
;
LINE_389:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_25
LDY #>CONST_25
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_84
LDY #>CONST_84
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
JMP LINE_387
;
LINE_390:
;
LDA VAR_E
BEQ EQ_SKIP165
EQ_EQ165:
JMP LINE_SKIP367
EQ_SKIP165:
COMP_SKP208:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP367:
;
LDA #<CONST_132
LDY #>CONST_132
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_392
;
LINE_SKIP367:
;
;
LINE_391:
;
LDA #<CONST_133
LDY #>CONST_133
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_392:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ166:
EQ_SKIP166:
COMP_SKP209:
BNE LINE_SKIP368
LINE_NSKIP368:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_396
;
LINE_SKIP368:
;
;
LINE_393:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ167:
NEQ_SKIP167:
COMP_SKP210:
BEQ LINE_SKIP369
LINE_NSKIP369:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_395
;
LINE_SKIP369:
;
;
LINE_394:
;
LDA VAR_ER
BEQ EQ_SKIP168
EQ_EQ168:
JMP LINE_SKIP370
EQ_SKIP168:
COMP_SKP211:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP370:
;
LDA #<CONST_134
LDY #>CONST_134
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_397
;
LINE_SKIP370:
;
;
LINE_395:
;
LDA #<CONST_38
LDY #>CONST_38
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #<CONST_135
LDY #>CONST_135
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_25
LDY #>CONST_25
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_397
;
LINE_396:
;
LDA #<CONST_38
LDY #>CONST_38
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_397:
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
LINE_398:
;
JMP RETURN
;
LINE_399:
;
;
LINE_400:
;
LDA #<CONST_136
LDY #>CONST_136
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<CONST_117
LDY #>CONST_117
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
LINE_401:
;
LDX #4
dcloop4717_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop4717_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_4R
LDY #>CONST_4R
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
BEQ EQ_SKIP169
EQ_EQ169:
JMP LINE_SKIP371
EQ_SKIP169:
COMP_SKP213:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP371:
;
JMP LINE_403
;
LINE_SKIP371:
;
;
LINE_402:
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
LDA #<CONST_24
LDY #>CONST_24
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
JMP LINE_406
;
LINE_403:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ170:
EQ_SKIP170:
COMP_SKP214:
BNE LINE_SKIP372
LINE_NSKIP372:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_137
LDY #>CONST_137
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_406
;
LINE_SKIP372:
;
;
LINE_404:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ171:
EQ_SKIP171:
COMP_SKP215:
BNE LINE_SKIP373
LINE_NSKIP373:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_138
LDY #>CONST_138
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_406
;
LINE_SKIP373:
;
;
LINE_405:
;
LDA #<CONST_139
LDY #>CONST_139
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_406:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ172
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP172
EQ_EQ172:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP172:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_12
LDY #>CONST_12
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ173
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP173
EQ_EQ173:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP173:
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
BEQ LINE_SKIP374
; Simplified conditional branch
;
LINE_NSKIP374:
;
LDA #<CONST_116
LDY #>CONST_116
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_408
;
LINE_SKIP374:
;
;
LINE_407:
;
LDA #<CONST_93
LDY #>CONST_93
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_408:
;
LDA VAR_D
BEQ EQ_SKIP174
EQ_EQ174:
JMP LINE_SKIP375
EQ_SKIP174:
COMP_SKP217:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP375:
;
JMP LINE_411
;
LINE_SKIP375:
;
;
LINE_409:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ175:
EQ_SKIP175:
COMP_SKP218:
BNE LINE_SKIP376
LINE_NSKIP376:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_140
LDY #>CONST_140
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP376:
;
;
LINE_410:
;
LDA #110
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_414
;
LINE_411:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ176:
EQ_SKIP176:
COMP_SKP219:
BNE LINE_SKIP377
LINE_NSKIP377:
; Optimizer rule: Simplified equal comparison/6
;
JSR LINEBREAK
JMP LINE_414
;
LINE_SKIP377:
;
;
LINE_412:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ177:
EQ_SKIP177:
COMP_SKP220:
BNE LINE_SKIP378
LINE_NSKIP378:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_138
LDY #>CONST_138
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_414
;
LINE_SKIP378:
;
;
LINE_413:
;
LDA #<CONST_96
LDY #>CONST_96
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_414:
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
LINE_415:
;
LDX #4
dcloop4717_2:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop4717_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_53R
LDY #>CONST_53R
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
EQ_EQ178:
EQ_SKIP178:
COMP_SKP222:
BNE LINE_SKIP379
LINE_NSKIP379:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_141
LDY #>CONST_141
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_420
;
LINE_SKIP379:
;
;
LINE_416:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_EL
LDY #>VAR_EL
JSR CMPFAC
EQ_EQ179:
EQ_SKIP179:
COMP_SKP223:
BNE LINE_SKIP380
LINE_NSKIP380:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_142
LDY #>CONST_142
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_420
;
LINE_SKIP380:
;
;
LINE_417:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ180:
EQ_SKIP180:
COMP_SKP224:
BNE LINE_SKIP381
LINE_NSKIP381:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_143
LDY #>CONST_143
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_420
;
LINE_SKIP381:
;
;
LINE_418:
;
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT181
LDA #0
JMP GT_SKIP181
GT_GT181:
LDA #$1
GT_SKIP181:
COMP_SKP225:
BEQ LINE_SKIP382
; Simplified conditional branch
;
LINE_NSKIP382:
;
LDA #<CONST_144
LDY #>CONST_144
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_420
;
LINE_SKIP382:
;
;
LINE_419:
;
LDA #<CONST_143
LDY #>CONST_143
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_420:
;
LDA VAR_E
BEQ EQ_SKIP182
EQ_EQ182:
JMP LINE_SKIP383
EQ_SKIP182:
COMP_SKP226:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP383:
;
LDA #<CONST_116
LDY #>CONST_116
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_422
;
LINE_SKIP383:
;
;
LINE_421:
;
LDA #<CONST_99
LDY #>CONST_99
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_422:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ183:
EQ_SKIP183:
COMP_SKP227:
BNE LINE_SKIP384
LINE_NSKIP384:
; Optimizer rule: Simplified equal comparison/6
;
LDA #116
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_427
;
LINE_SKIP384:
;
;
LINE_423:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR CMPFAC
EQ_EQ184:
EQ_SKIP184:
COMP_SKP228:
BNE LINE_SKIP385
LINE_NSKIP385:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_145
LDY #>CONST_145
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_427
;
LINE_SKIP385:
;
;
LINE_424:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ185:
EQ_SKIP185:
COMP_SKP229:
BNE LINE_SKIP386
LINE_NSKIP386:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_146
LDY #>CONST_146
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_427
;
LINE_SKIP386:
;
;
LINE_425:
;
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT186
LDA #0
JMP GT_SKIP186
GT_GT186:
LDA #$1
GT_SKIP186:
COMP_SKP230:
BEQ LINE_SKIP387
; Simplified conditional branch
;
LINE_NSKIP387:
;
LDA #<CONST_147
LDY #>CONST_147
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_427
;
LINE_SKIP387:
;
;
LINE_426:
;
LDA #<CONST_109
LDY #>CONST_109
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_427:
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
LINE_428:
;
LDX #4
dcloop4883_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop4883_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_4R
LDY #>CONST_4R
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
EQ_EQ187:
EQ_SKIP187:
COMP_SKP232:
BNE LINE_SKIP388
LINE_NSKIP388:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_434
;
LINE_SKIP388:
;
;
LINE_429:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ188:
NEQ_SKIP188:
COMP_SKP233:
BEQ LINE_SKIP389
LINE_NSKIP389:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_431
;
LINE_SKIP389:
;
;
LINE_430:
;
LDA VAR_EL
BEQ EQ_SKIP189
EQ_EQ189:
JMP LINE_SKIP390
EQ_SKIP189:
COMP_SKP234:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP390:
;
LDA #<CONST_148
LDY #>CONST_148
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_437
;
LINE_SKIP390:
;
;
LINE_431:
;
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_24
LDY #>CONST_24
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
LDA #<CONST_81
LDY #>CONST_81
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUT
;
LINE_432:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ190:
EQ_SKIP190:
COMP_SKP235:
BNE LINE_SKIP391
LINE_NSKIP391:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_437
;
LINE_SKIP391:
;
;
LINE_433:
;
JMP LINE_438
;
LINE_434:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
EQ_EQ191:
EQ_SKIP191:
COMP_SKP236:
BNE LINE_SKIP392
LINE_NSKIP392:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_140
LDY #>CONST_140
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP392:
;
;
LINE_435:
;
LDA #<CONST_84
LDY #>CONST_84
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_436:
;
LDX #4
dceloop5314_22:
LDA CONST_24,X
CMP VAR_I,X
BNE LINE_SKIP393
DEX
BPL dceloop5314_22
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP393:
; Optimizer rule: Simplified equal comparison/6
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JMP LINE_438
;
LINE_SKIP393:
;
;
LINE_437:
;
LDA VAR_E
BEQ EQ_SKIP193
EQ_EQ193:
JMP LINE_SKIP394
EQ_SKIP193:
COMP_SKP238:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP394:
;
LDA #<CONST_149
LDY #>CONST_149
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_439
;
LINE_SKIP394:
;
;
LINE_438:
;
LDA #<CONST_150
LDY #>CONST_150
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_439:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ194:
EQ_SKIP194:
COMP_SKP239:
BNE LINE_SKIP395
LINE_NSKIP395:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_443
;
LINE_SKIP395:
;
;
LINE_440:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
NEQ_NEQ195:
NEQ_SKIP195:
COMP_SKP240:
BEQ LINE_SKIP396
LINE_NSKIP396:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_442
;
LINE_SKIP396:
;
;
LINE_441:
;
LDA VAR_ER
BEQ EQ_SKIP196
EQ_EQ196:
JMP LINE_SKIP397
EQ_SKIP196:
COMP_SKP241:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP397:
;
LDA #<CONST_151
LDY #>CONST_151
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_445
;
LINE_SKIP397:
;
;
LINE_442:
;
LDA #<CONST_38
LDY #>CONST_38
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
LDA #<CONST_81
LDY #>CONST_81
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
LDA #<CONST_24
LDY #>CONST_24
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
LDA #<CONST_81
LDY #>CONST_81
STA B_REG
STY B_REG+1
JSR LEFT
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_445
;
LINE_443:
;
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dceloop5314_23:
LDA CONST_24,X
CMP VAR_I,X
BNE LINE_SKIP398
DEX
BPL dceloop5314_23
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP398:
; Optimizer rule: Simplified equal comparison/6
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_SKIP398:
;
;
LINE_444:
;
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_445:
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
LINE_446:
;
JMP RETURN
;
LINE_447:
;
;
LINE_448:
;
LDA #<CONST_152
LDY #>CONST_152
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR COMPACTMAX
LDA #<CONST_137
LDY #>CONST_137
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
LINE_449:
;
LDA VAR_Z$
LDY VAR_Z$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_C
BEQ EQ_SKIP198
EQ_EQ198:
JMP LINE_SKIP399
EQ_SKIP198:
COMP_SKP244:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP399:
;
JMP LINE_451
;
LINE_SKIP399:
;
;
LINE_450:
;
LDA #109
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JMP LINE_452
;
LINE_451:
;
LDA #<CONST_96
LDY #>CONST_96
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_452:
;
LDA VAR_E
BEQ EQ_SKIP199
EQ_EQ199:
JMP LINE_SKIP400
EQ_SKIP199:
COMP_SKP245:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP400:
;
LDA #<CONST_137
LDY #>CONST_137
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_454
;
LINE_SKIP400:
;
;
LINE_453:
;
LDA #<CONST_138
LDY #>CONST_138
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_454:
;
LDA VAR_D
BEQ EQ_SKIP200
EQ_EQ200:
JMP LINE_SKIP401
EQ_SKIP200:
COMP_SKP246:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP401:
;
JMP LINE_456
;
LINE_SKIP401:
;
;
LINE_455:
;
LDA #110
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_457
;
LINE_456:
;
LDA #<CONST_96
LDY #>CONST_96
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_457:
;
LDX #4
dcloop5049_1:
LDA CONST_23,X
STA VAR_I,X
DEX
BPL dcloop5049_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_5R
LDY #>CONST_5R
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
EQ_EQ201:
EQ_SKIP201:
COMP_SKP247:
BNE LINE_SKIP402
LINE_NSKIP402:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_459
;
LINE_SKIP402:
;
;
LINE_458:
;
LDA #<CONST_77
LDY #>CONST_77
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_460
;
LINE_459:
;
LDA #121
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_460:
;
LDA VAR_E
BEQ EQ_SKIP202
EQ_EQ202:
JMP LINE_SKIP403
EQ_SKIP202:
COMP_SKP248:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP403:
;
LDA #<CONST_137
LDY #>CONST_137
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_462
;
LINE_SKIP403:
;
;
LINE_461:
;
LDA #<CONST_154
LDY #>CONST_154
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_462:
;
LDA VAR_D
BEQ EQ_SKIP203
EQ_EQ203:
JMP LINE_SKIP404
EQ_SKIP203:
COMP_SKP249:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP404:
;
LDA #<CONST_77
LDY #>CONST_77
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_464
;
LINE_SKIP404:
;
;
LINE_463:
;
LDA #116
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_464:
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
LINE_465:
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
EQ_EQ204:
EQ_SKIP204:
COMP_SKP251:
BNE LINE_SKIP405
LINE_NSKIP405:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_467
;
LINE_SKIP405:
;
;
LINE_466:
;
LDA #<CONST_155
LDY #>CONST_155
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_468
;
LINE_467:
;
LDA #<CONST_84
LDY #>CONST_84
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_468:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
EQ_EQ205:
EQ_SKIP205:
COMP_SKP252:
BNE LINE_SKIP406
LINE_NSKIP406:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_156
LDY #>CONST_156
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_470
;
LINE_SKIP406:
;
;
LINE_469:
;
LDA #<CONST_157
LDY #>CONST_157
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_470:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
EQ_EQ206:
EQ_SKIP206:
COMP_SKP253:
BNE LINE_SKIP407
LINE_NSKIP407:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_472
;
LINE_SKIP407:
;
;
LINE_471:
;
LDA #<CONST_135
LDY #>CONST_135
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_473
;
LINE_472:
;
LDA #<CONST_158
LDY #>CONST_158
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_473:
;
JMP RETURN
;
LINE_474:
;
LDA #<CONST_159
LDY #>CONST_159
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_475:
;
LDA VAR_M1
COMP_SKP254:
BEQ LINE_SKIP408
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP408:
;
LDA #<CONST_160
LDY #>CONST_160
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_478
;
LINE_SKIP408:
;
;
LINE_476:
;
LDA #<CONST_161
LDY #>CONST_161
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_211
;
LINE_477:
;
JSR GOSUB
JSR LINE_147
;
LINE_478:
;
LDA #<CONST_162
LDY #>CONST_162
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_II
LDY #>VAR_II
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<CONST_163
LDY #>CONST_163
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
INPUT5:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_164
LDY #>CONST_164
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
LINE_479:
;
JSR COMPACTMAX
LDA #<CONST_165
LDY #>CONST_165
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA VAR_Z$
LDY VAR_Z$+1
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
COMP_SKP256:
BEQ LINE_SKIP409
; Simplified conditional branch
;
LINE_NSKIP409:
;
JSR CLR
JMP LINE_33
;
LINE_SKIP409:
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
CLR			JMP START
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
STA VAR_F,Y
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
STA VAR_JO,Y
STA VAR_II,Y
STA VAR_A1,Y
STA VAR_B,Y
STA VAR_B1,Y
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
; CONST: #55296

CONST_0	.REAL 55296
; CONST: #0


; CONST: ${142}{clear}{ct h}{down*4}{yellow}
CONST_2	.BYTE 34
.STRG "{142}{clear}{ct h}{down*4}{yellow}"
; CONST: #1

MOSTCOMMON
CONST_3R	.REAL 1.0
; CONST: #2

CONST_4R	.REAL 2.0
; CONST: #3

CONST_5R	.REAL 3.0
; CONST: #4

CONST_6R	.REAL 4.0
; CONST: #7

CONST_7R	.REAL 7.0
; CONST: $nord
CONST_8	.BYTE 4
.STRG "nord"
; CONST: $ost
CONST_9	.BYTE 3
.STRG "ost"
; CONST: $sued
CONST_10	.BYTE 4
.STRG "sued"
; CONST: $west
CONST_11	.BYTE 4
.STRG "west"
; CONST: #0.0

CONST_12	.REAL 0.0
; CONST: ${reverse off}{green}{down*2}gib die dimension des labyrinths ein:
CONST_13	.BYTE 65
.STRG "{reverse off}{green}{down*2}gib die dimension des labyrinths ein:"
; CONST: ${down}wie breit
CONST_14	.BYTE 15
.STRG "{down}wie breit"
; CONST: $?redo from start
CONST_15	.BYTE 16
.STRG "?redo from start"
; CONST: #19

CONST_16R	.REAL 19.0
; CONST: ${up*2}
CONST_17	.BYTE 6
.STRG "{up*2}"
; CONST: ${down}wie lang
CONST_18	.BYTE 14
.STRG "{down}wie lang"
; CONST: #10

CONST_19R	.REAL 10.0
; CONST: ${down}nun wird ein
CONST_20	.BYTE 18
.STRG "{down}nun wird ein"
; CONST: #118


; CONST: $labyrinth erzeugt
CONST_22	.BYTE 17
.STRG "labyrinth erzeugt"
; CONST: #1.0

CONST_23	.REAL 1.0
; CONST: #2.0

CONST_24	.REAL 2.0
; CONST: #3.0

CONST_25	.REAL 3.0
; CONST: #40.0

CONST_26	.REAL 40.0
; CONST: #480.0

CONST_27	.REAL 480.0
; CONST: #1024.0

CONST_28	.REAL 1024.0
; CONST: #18

CONST_29R	.REAL 18.0
; CONST: #30


; CONST: #55314

CONST_31	.REAL 55314
; CONST: ${clear}
CONST_32	.BYTE 7
.STRG "{clear}"
; CONST: #11

CONST_33R	.REAL 11.0
; CONST: #-1.0

CONST_34	.REAL -1.0
; CONST: ${reverse on}
CONST_35	.BYTE 13
.STRG "{reverse on} "
; CONST: ${black} {green}
CONST_36	.BYTE 15
.STRG "{black} {green}"
; CONST: #32


; CONST: ${reverse on}
CONST_38	.BYTE 12
.STRG "{reverse on}"
; CONST: ${space*2}
CONST_39	.BYTE 9
.STRG "{space*2}"
; CONST: $ {black} {green}
CONST_40	.BYTE 16
.STRG " {black} {green}"
; CONST: ${clear}{down*2}gesteuert wird mit dem joystick :
CONST_41	.BYTE 48
.STRG "{clear}{down*2}gesteuert wird mit dem joystick :"
; CONST: ${down}{reverse on}v{reverse off}-bewegt dich einen schritt vorwaerts,
CONST_42	.BYTE 69
.STRG "{down}{reverse on}v{reverse off}-bewegt dich einen schritt vorwaerts,"
; CONST: ${down}{reverse on}l{reverse off}-drehung 90 grad nach links,
CONST_43	.BYTE 60
.STRG "{down}{reverse on}l{reverse off}-drehung 90 grad nach links,"
; CONST: ${down}{reverse on}r{reverse off}-drehung 90 grad nach rechts,
CONST_44	.BYTE 61
.STRG "{down}{reverse on}r{reverse off}-drehung 90 grad nach rechts,"
; CONST: ${down}{reverse on}feuer{reverse off}-hilfe!
CONST_45	.BYTE 43
.STRG "{down}{reverse on}feuer{reverse off}-hilfe!"
; CONST: #198

CONST_46R	.REAL 198.0
; CONST: ${down}du bist hier {yellow}Q{green}, blickrichtung
CONST_47	.BYTE 51
.STRG "{down}du bist hier {yellow}Q{green}, blickrichtung "
; CONST: #80.0

CONST_48	.REAL 80.0
; CONST: #81


; CONST: ${home}{down*24}was nun?
CONST_50	.BYTE 23
.STRG "{home}{down*24}was nun?"
; CONST: #8

CONST_51R	.REAL 8.0
; CONST: #16

CONST_52R	.REAL 16.0
; CONST: #5

CONST_53R	.REAL 5.0
; CONST: #4.0

CONST_54	.REAL 4.0
; CONST: #14

CONST_55R	.REAL 14.0
; CONST: ${home}{down*10}{right*10}
CONST_56	.BYTE 25
.STRG "{home}{down*10}{right*10}"
; CONST: ${ct g}
CONST_57	.BYTE 6
.STRG "{ct g}"
; CONST: #5.0

CONST_58	.REAL 5.0
; CONST: ${up*4}{right*3}aeussere wand
CONST_59	.BYTE 28
.STRG "{up*4}{right*3}aeussere wand"
; CONST: ${up*2}{right*2}du bist aussen !!!
CONST_60	.BYTE 33
.STRG "{up*2}{right*2}du bist aussen !!!"
; CONST: #21

CONST_61R	.REAL 21.0
; CONST: ${right*8}Y
CONST_62	.BYTE 10
.STRG "{right*8}Y"
; CONST: ${right}{reverse on}{red}
CONST_63	.BYTE 24
.STRG "{right}{reverse on}{red}"
; CONST: #8.0

CONST_64	.REAL 8.0
; CONST: ${cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}
CONST_65	.BYTE 144
.STRG "{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}{cm e}{cm r}"
; CONST: ${green}
CONST_66	.BYTE 7
.STRG "{green}"
; CONST: ${right}{white}{cm +*8}{green}
CONST_67	.BYTE 29
.STRG "{right}{white}{cm +*8}{green}"
; CONST: ${right}{cm @*7}{white}{cm +}{green}
CONST_68	.BYTE 35
.STRG "{right}{cm @*7}{white}{cm +}{green}"
; CONST: ${right*8}{white}{cm +}{green}
CONST_69	.BYTE 29
.STRG "{right*8}{white}{cm +}{green}"
; CONST: ${right}{reverse on}{space*7}{reverse off}{white}{cm +}{green}
CONST_70	.BYTE 61
.STRG "{right}{reverse on}{space*7}{reverse off}{white}{cm +}{green}"
; CONST: #22

CONST_71R	.REAL 22.0
; CONST: ${reverse on}{red}
CONST_72	.BYTE 17
.STRG "{reverse on}{red}"
; CONST: ${white}{cm +*22}{green}
CONST_73	.BYTE 23
.STRG "{white}{cm +*22}{green}"
; CONST: #116


; CONST: ${white}{cm +*8}{green}
CONST_75	.BYTE 22
.STRG "{white}{cm +*8}{green}"
; CONST: ${white}{cm +}{green}{cm @*7}
CONST_76	.BYTE 28
.STRG "{white}{cm +}{green}{cm @*7}"
; CONST: ${white}{cm +}{green}
CONST_77	.BYTE 20
.STRG "{white}{cm +}{green}"
; CONST: ${white}{cm +}{reverse on}{green}{space*7}
CONST_78	.BYTE 41
.STRG "{white}{cm +}{reverse on}{green}{space*7}"
; CONST: ${right}{reverse on}{cm t*7}N
CONST_79	.BYTE 28
.STRG "{right}{reverse on}{cm t*7}N"
; CONST: ${right}{reverse on}
CONST_80	.BYTE 19
.STRG "{right}{reverse on}"
; CONST: ${space*47}
CONST_81	.BYTE 10
.STRG "{space*47}"
; CONST: #110


; CONST: #9.0

CONST_83	.REAL 9.0
; CONST: ${reverse on}{sh pound}
CONST_84	.BYTE 22
.STRG "{reverse on}{sh pound}"
; CONST: ${reverse on}{cm t*22}
CONST_85	.BYTE 21
.STRG "{reverse on}{cm t*22}"
; CONST: ${reverse on}{space*22}
CONST_86	.BYTE 22
.STRG "{reverse on}{space*22}"
; CONST: ${reverse on}M{cm t*7}
CONST_87	.BYTE 21
.STRG "{reverse on}M{cm t*7}"
; CONST: #109


; CONST: ${cm asterisk}
CONST_89	.BYTE 13
.STRG "{cm asterisk}"
; CONST: ${home}
CONST_90	.BYTE 6
.STRG "{home}"
; CONST: ${right*9}
CONST_91	.BYTE 9
.STRG "{right*9}"
; CONST: ${right*3}M
CONST_92	.BYTE 10
.STRG "{right*3}M"
; CONST: ${cm @*4}
CONST_93	.BYTE 8
.STRG "{cm @*4}"
; CONST: ${right*3}{cm @}
CONST_94	.BYTE 15
.STRG "{right*3}{cm @}"
; CONST: ${cm @*14}
CONST_95	.BYTE 9
.STRG "{cm @*14}"
; CONST: ${cm @}
CONST_96	.BYTE 6
.STRG "{cm @}"
; CONST: #15

CONST_97R	.REAL 15.0
; CONST: ${right*3}Y
CONST_98	.BYTE 10
.STRG "{right*3}Y"
; CONST: ${reverse on}{white}{cm +*4}{reverse off}{green}
CONST_99	.BYTE 47
.STRG "{reverse on}{white}{cm +*4}{reverse off}{green}"
; CONST: ${cm @*3}{reverse on}{white}{cm +}{reverse off}{green}
CONST_100	.BYTE 53
.STRG "{cm @*3}{reverse on}{white}{cm +}{reverse off}{green}"
; CONST: #12

CONST_101R	.REAL 12.0
; CONST: ${reverse on}{space*3}{white}{cm +}{reverse off}{green}
CONST_102	.BYTE 54
.STRG "{reverse on}{space*3}{white}{cm +}{reverse off}{green}"
; CONST: ${space*3}{reverse on}{white}{cm +}{reverse off}{green}
CONST_103	.BYTE 54
.STRG "{space*3}{reverse on}{white}{cm +}{reverse off}{green}"
; CONST: ${right*14}
CONST_104	.BYTE 10
.STRG "{right*14}"
; CONST: ${reverse on}{white}{cm +*14}{reverse off}{green}
CONST_105	.BYTE 48
.STRG "{reverse on}{white}{cm +*14}{reverse off}{green}"
; CONST: ${reverse on}{white}{cm +*4}{green}
CONST_106	.BYTE 34
.STRG "{reverse on}{white}{cm +*4}{green}"
; CONST: ${reverse on}{white}{cm +}{reverse off}{green}{cm @*3}
CONST_107	.BYTE 53
.STRG "{reverse on}{white}{cm +}{reverse off}{green}{cm @*3}"
; CONST: ${reverse on}{white}{cm +}{green}{space*3}
CONST_108	.BYTE 41
.STRG "{reverse on}{white}{cm +}{green}{space*3}"
; CONST: ${reverse on}{white}{cm +}{green}
CONST_109	.BYTE 32
.STRG "{reverse on}{white}{cm +}{green}"
; CONST: ${reverse on}{cm t*3}N
CONST_110	.BYTE 21
.STRG "{reverse on}{cm t*3}N"
; CONST: ${reverse on}{space*3}N
CONST_111	.BYTE 22
.STRG "{reverse on}{space*3}N"
; CONST: ${reverse on}{cm t*14}
CONST_112	.BYTE 21
.STRG "{reverse on}{cm t*14}"
; CONST: ${reverse on}{space*14}
CONST_113	.BYTE 22
.STRG "{reverse on}{space*14}"
; CONST: ${reverse on}M{cm t*3}
CONST_114	.BYTE 21
.STRG "{reverse on}M{cm t*3}"
; CONST: ${home}{down*2}
CONST_115	.BYTE 14
.STRG "{home}{down*2}"
; CONST: ${right*4}
CONST_116	.BYTE 9
.STRG "{right*4}"
; CONST: ${right*3}
CONST_117	.BYTE 9
.STRG "{right*3}"
; CONST: ${cm @*3}
CONST_118	.BYTE 8
.STRG "{cm @*3}"
; CONST: ${right*2}{cm @}
CONST_119	.BYTE 15
.STRG "{right*2}{cm @}"
; CONST: ${right*8}
CONST_120	.BYTE 9
.STRG "{right*8}"
; CONST: ${cm @*8}
CONST_121	.BYTE 8
.STRG "{cm @*8}"
; CONST: #9

CONST_122R	.REAL 9.0
; CONST: ${right*2}Y
CONST_123	.BYTE 10
.STRG "{right*2}Y"
; CONST: ${white}{cm +*3}{green}
CONST_124	.BYTE 22
.STRG "{white}{cm +*3}{green}"
; CONST: ${cm @*2}{white}{cm +}{green}
CONST_125	.BYTE 28
.STRG "{cm @*2}{white}{cm +}{green}"
; CONST: #7.0

CONST_126	.REAL 7.0
; CONST: ${reverse on}{space*2}{reverse off}{white}{cm +}{green}
CONST_127	.BYTE 54
.STRG "{reverse on}{space*2}{reverse off}{white}{cm +}{green}"
; CONST: ${space*2}{white}{cm +}{green}
CONST_128	.BYTE 29
.STRG "{space*2}{white}{cm +}{green}"
; CONST: ${white}{cm +}{green}{cm @*2}
CONST_129	.BYTE 28
.STRG "{white}{cm +}{green}{cm @*2}"
; CONST: ${white}{cm +}{green}{reverse on}{space*2}{reverse off}
CONST_130	.BYTE 54
.STRG "{white}{cm +}{green}{reverse on}{space*2}{reverse off}"
; CONST: ${reverse on}{cm t*2}N
CONST_131	.BYTE 21
.STRG "{reverse on}{cm t*2}N"
; CONST: ${reverse on}{cm t*8}
CONST_132	.BYTE 20
.STRG "{reverse on}{cm t*8}"
; CONST: ${reverse on}{space*8}
CONST_133	.BYTE 21
.STRG "{reverse on}{space*8}"
; CONST: ${reverse on}M{cm t*2}
CONST_134	.BYTE 21
.STRG "{reverse on}M{cm t*2}"
; CONST: ${reverse on}M
CONST_135	.BYTE 13
.STRG "{reverse on}M"
; CONST: ${home}{down*5}
CONST_136	.BYTE 14
.STRG "{home}{down*5}"
; CONST: ${right*2}
CONST_137	.BYTE 9
.STRG "{right*2}"
; CONST: ${cm @*2}
CONST_138	.BYTE 8
.STRG "{cm @*2}"
; CONST: ${right}{cm @}
CONST_139	.BYTE 13
.STRG "{right}{cm @}"
; CONST: ${right}
CONST_140	.BYTE 7
.STRG "{right}"
; CONST: ${right}Y
CONST_141	.BYTE 8
.STRG "{right}Y"
; CONST: ${reverse on}{white}{cm +*2}{reverse off}{green}
CONST_142	.BYTE 47
.STRG "{reverse on}{white}{cm +*2}{reverse off}{green}"
; CONST: $ {reverse on}{white}{cm +}{reverse off}{green}
CONST_143	.BYTE 46
.STRG " {reverse on}{white}{cm +}{reverse off}{green}"
; CONST: ${reverse on}{cm t}{white}{cm +}{reverse off}{green}
CONST_144	.BYTE 51
.STRG "{reverse on}{cm t}{white}{cm +}{reverse off}{green}"
; CONST: ${reverse on}{white}{cm +*2}{green}
CONST_145	.BYTE 34
.STRG "{reverse on}{white}{cm +*2}{green}"
; CONST: ${reverse on}{white}{cm +}{reverse off}{green}{cm @}
CONST_146	.BYTE 51
.STRG "{reverse on}{white}{cm +}{reverse off}{green}{cm @}"
; CONST: ${reverse on}{white}{cm +}{green}
CONST_147	.BYTE 33
.STRG "{reverse on}{white}{cm +}{green} "
; CONST: ${reverse on}{cm t}N
CONST_148	.BYTE 19
.STRG "{reverse on}{cm t}N"
; CONST: ${reverse on}{cm t*4}
CONST_149	.BYTE 20
.STRG "{reverse on}{cm t*4}"
; CONST: ${reverse on}{space*4}
CONST_150	.BYTE 21
.STRG "{reverse on}{space*4}"
; CONST: ${reverse on}M{cm t}
CONST_151	.BYTE 19
.STRG "{reverse on}M{cm t}"
; CONST: ${home}{down*7}
CONST_152	.BYTE 14
.STRG "{home}{down*7}"
; CONST: #121


; CONST: ${white}{cm +*2}{green}
CONST_154	.BYTE 22
.STRG "{white}{cm +*2}{green}"
; CONST: ${reverse on}N
CONST_155	.BYTE 13
.STRG "{reverse on}N"
; CONST: ${reverse on}{space*2}
CONST_156	.BYTE 21
.STRG "{reverse on}{space*2}"
; CONST: ${reverse on}{cm t*2}
CONST_157	.BYTE 20
.STRG "{reverse on}{cm t*2}"
; CONST: ${reverse on}{cm asterisk}
CONST_158	.BYTE 25
.STRG "{reverse on}{cm asterisk}"
; CONST: ${clear}{down*2}du bist aussen !
CONST_159	.BYTE 31
.STRG "{clear}{down*2}du bist aussen !"
; CONST: ${down*4}
CONST_160	.BYTE 8
.STRG "{down*4}"
; CONST: ${clear}hier ist der irrgarten
CONST_161	.BYTE 29
.STRG "{clear}hier ist der irrgarten"
; CONST: $du hast
CONST_162	.BYTE 8
.STRG "du hast "
; CONST: $ schritte gebraucht
CONST_163	.BYTE 19
.STRG " schritte gebraucht"
; CONST: ${down*4}noch ein spiel
CONST_164	.BYTE 22
.STRG "{down*4}noch ein spiel"
; CONST: $j
CONST_165	.BYTE 1
.STRG "j"
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: F
VAR_F	.REAL 0.0
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
; VAR: JO
VAR_JO	.REAL 0.0
; VAR: II
VAR_II	.REAL 0.0
; VAR: A1
VAR_A1	.REAL 0.0
; VAR: B
VAR_B	.REAL 0.0
; VAR: B1
VAR_B1	.REAL 0.0
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
