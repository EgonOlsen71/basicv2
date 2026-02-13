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
LINE_20:
;
;
LINE_30:
;
INPUT1:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP0:
BEQ INPUT1_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_2
LDY #>CONST_2
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP INPUT1
INPUT1_0:
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP2
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
EMPTYINPUTSKIP2:
JSR QUEUESIZE
LDA X_REG
COMP_SKP1:
BEQ INPUTCHECK1
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK1:
;
LINE_40:
;
LDA #<CONST_3
LDY #>CONST_3
STA TMP_ZP
STY TMP_ZP+1
; Optimizer rule: MEM->REG, REG->TMP_ZP/4
JSR WRITETID
LDA #<CONST_4
LDY #>CONST_4
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_A%
LDA VAR_A%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_6
LDY #>CONST_6
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
; FAC = INT(FAC)
JSR FACINT
; Optimizer rule: No need for INT(3)/1
STY VAR_A%
STA VAR_A%+1
;
LINE_50:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_7
LDY #>CONST_7
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_8R
LDY #>CONST_8R
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
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_60:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT0
LDA #0
JMP GT_SKIP0
GT_GT0:
LDA #$1
GT_SKIP0:
COMP_SKP2:
BNE LINE_NSKIP132
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP132
;
LINE_NSKIP132:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP132:
;
;
LINE_70:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ1
BEQ LTEQ_LTEQ1
LDA #0
JMP LTEQ_SKIP1
LTEQ_LTEQ1:
LDA #$1
LTEQ_SKIP1:
COMP_SKP3:
BNE LINE_NSKIP133
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP133
;
LINE_NSKIP133:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP133:
;
;
LINE_80:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_90:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_100:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
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
COMP_SKP4:
BEQ LINE_SKIP134
; Simplified conditional branch
;
LINE_NSKIP134:
;
LDX #4
dcloop235_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP134:
;
;
LINE_110:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT3
LDA #0
JMP GT_SKIP3
GT_GT3:
LDA #$1
GT_SKIP3:
COMP_SKP5:
BEQ LINE_SKIP135
; Simplified conditional branch
;
LINE_NSKIP135:
;
LDX #4
dcloop235_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop235_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP135:
;
;
LINE_120:
;
LDA #<CONST_12R
LDY #>CONST_12R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_130:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_15
LDY #>CONST_15
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_16R
LDY #>CONST_16R
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
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_140:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT4
LDA #0
JMP GT_SKIP4
GT_GT4:
LDA #$1
GT_SKIP4:
COMP_SKP6:
BNE LINE_NSKIP136
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP136
;
LINE_NSKIP136:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP136:
;
;
LINE_150:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ5
BEQ LTEQ_LTEQ5
LDA #0
JMP LTEQ_SKIP5
LTEQ_LTEQ5:
LDA #$1
LTEQ_SKIP5:
COMP_SKP7:
BNE LINE_NSKIP137
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP137
;
LINE_NSKIP137:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP137:
;
;
LINE_160:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_170:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_180:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ6
ROL
BCC LT_LT6
LT_LT_EQ6:
LDA #0
JMP LT_SKIP6
LT_LT6:
LDA #$1
LT_SKIP6:
COMP_SKP8:
BEQ LINE_SKIP138
; Simplified conditional branch
;
LINE_NSKIP138:
;
LDX #4
dcloop401_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop401_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP138:
;
;
LINE_190:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT7
LDA #0
JMP GT_SKIP7
GT_GT7:
LDA #$1
GT_SKIP7:
COMP_SKP9:
BEQ LINE_SKIP139
; Simplified conditional branch
;
LINE_NSKIP139:
;
LDX #4
dcloop401_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop401_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP139:
;
;
LINE_200:
;
LDA #<CONST_17R
LDY #>CONST_17R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_210:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_18
LDY #>CONST_18
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_19
LDY #>CONST_19
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_220:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT8
LDA #0
JMP GT_SKIP8
GT_GT8:
LDA #$1
GT_SKIP8:
COMP_SKP10:
BNE LINE_NSKIP140
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP140
;
LINE_NSKIP140:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP140:
;
;
LINE_230:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ9
BEQ LTEQ_LTEQ9
LDA #0
JMP LTEQ_SKIP9
LTEQ_LTEQ9:
LDA #$1
LTEQ_SKIP9:
COMP_SKP11:
BNE LINE_NSKIP141
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP141
;
LINE_NSKIP141:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP141:
;
;
LINE_240:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_250:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_260:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ10
ROL
BCC LT_LT10
LT_LT_EQ10:
LDA #0
JMP LT_SKIP10
LT_LT10:
LDA #$1
LT_SKIP10:
COMP_SKP12:
BEQ LINE_SKIP142
; Simplified conditional branch
;
LINE_NSKIP142:
;
LDX #4
dcloop401_3:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop401_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP142:
;
;
LINE_270:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT11
LDA #0
JMP GT_SKIP11
GT_GT11:
LDA #$1
GT_SKIP11:
COMP_SKP13:
BEQ LINE_SKIP143
; Simplified conditional branch
;
LINE_NSKIP143:
;
LDX #4
dcloop401_4:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop401_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP143:
;
;
LINE_280:
;
LDA #<CONST_20R
LDY #>CONST_20R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_290:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_21
LDY #>CONST_21
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_300:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT12
LDA #0
JMP GT_SKIP12
GT_GT12:
LDA #$1
GT_SKIP12:
COMP_SKP14:
BNE LINE_NSKIP144
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP144
;
LINE_NSKIP144:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP144:
;
;
LINE_310:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ13
BEQ LTEQ_LTEQ13
LDA #0
JMP LTEQ_SKIP13
LTEQ_LTEQ13:
LDA #$1
LTEQ_SKIP13:
COMP_SKP15:
BNE LINE_NSKIP145
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP145
;
LINE_NSKIP145:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP145:
;
;
LINE_320:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_330:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_340:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ14
ROL
BCC LT_LT14
LT_LT_EQ14:
LDA #0
JMP LT_SKIP14
LT_LT14:
LDA #$1
LT_SKIP14:
COMP_SKP16:
BEQ LINE_SKIP146
; Simplified conditional branch
;
LINE_NSKIP146:
;
LDX #4
dcloop401_5:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop401_5
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP146:
;
;
LINE_350:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT15
LDA #0
JMP GT_SKIP15
GT_GT15:
LDA #$1
GT_SKIP15:
COMP_SKP17:
BEQ LINE_SKIP147
; Simplified conditional branch
;
LINE_NSKIP147:
;
LDX #4
dcloop567_1:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop567_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP147:
;
;
LINE_360:
;
LDA #<CONST_22R
LDY #>CONST_22R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_370:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_24R
LDY #>CONST_24R
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
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_380:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT16
LDA #0
JMP GT_SKIP16
GT_GT16:
LDA #$1
GT_SKIP16:
COMP_SKP18:
BNE LINE_NSKIP148
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP148
;
LINE_NSKIP148:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP148:
;
;
LINE_390:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ17
BEQ LTEQ_LTEQ17
LDA #0
JMP LTEQ_SKIP17
LTEQ_LTEQ17:
LDA #$1
LTEQ_SKIP17:
COMP_SKP19:
BNE LINE_NSKIP149
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP149
;
LINE_NSKIP149:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP149:
;
;
LINE_400:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_410:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_420:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
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
BEQ LINE_SKIP150
; Simplified conditional branch
;
LINE_NSKIP150:
;
LDX #4
dcloop567_2:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop567_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP150:
;
;
LINE_430:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT19
LDA #0
JMP GT_SKIP19
GT_GT19:
LDA #$1
GT_SKIP19:
COMP_SKP21:
BEQ LINE_SKIP151
; Simplified conditional branch
;
LINE_NSKIP151:
;
LDX #4
dcloop567_3:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop567_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP151:
;
;
LINE_440:
;
LDA #<CONST_25R
LDY #>CONST_25R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_450:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_26
LDY #>CONST_26
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_460:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT20
LDA #0
JMP GT_SKIP20
GT_GT20:
LDA #$1
GT_SKIP20:
COMP_SKP22:
BNE LINE_NSKIP152
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP152
;
LINE_NSKIP152:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP152:
;
;
LINE_470:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ21
BEQ LTEQ_LTEQ21
LDA #0
JMP LTEQ_SKIP21
LTEQ_LTEQ21:
LDA #$1
LTEQ_SKIP21:
COMP_SKP23:
BNE LINE_NSKIP153
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP153
;
LINE_NSKIP153:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP153:
;
;
LINE_480:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_490:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_500:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ22
ROL
BCC LT_LT22
LT_LT_EQ22:
LDA #0
JMP LT_SKIP22
LT_LT22:
LDA #$1
LT_SKIP22:
COMP_SKP24:
BEQ LINE_SKIP154
; Simplified conditional branch
;
LINE_NSKIP154:
;
LDX #4
dcloop567_4:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop567_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP154:
;
;
LINE_510:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT23
LDA #0
JMP GT_SKIP23
GT_GT23:
LDA #$1
GT_SKIP23:
COMP_SKP25:
BEQ LINE_SKIP155
; Simplified conditional branch
;
LINE_NSKIP155:
;
LDX #4
dcloop567_5:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop567_5
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP155:
;
;
LINE_520:
;
LDA #<CONST_8R
LDY #>CONST_8R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_530:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_27
LDY #>CONST_27
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_540:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT24
LDA #0
JMP GT_SKIP24
GT_GT24:
LDA #$1
GT_SKIP24:
COMP_SKP26:
BNE LINE_NSKIP156
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP156
;
LINE_NSKIP156:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP156:
;
;
LINE_550:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ25
BEQ LTEQ_LTEQ25
LDA #0
JMP LTEQ_SKIP25
LTEQ_LTEQ25:
LDA #$1
LTEQ_SKIP25:
COMP_SKP27:
BNE LINE_NSKIP157
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP157
;
LINE_NSKIP157:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP157:
;
;
LINE_560:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_570:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_580:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ26
ROL
BCC LT_LT26
LT_LT_EQ26:
LDA #0
JMP LT_SKIP26
LT_LT26:
LDA #$1
LT_SKIP26:
COMP_SKP28:
BEQ LINE_SKIP158
; Simplified conditional branch
;
LINE_NSKIP158:
;
LDX #4
dcloop733_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop733_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP158:
;
;
LINE_590:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT27
LDA #0
JMP GT_SKIP27
GT_GT27:
LDA #$1
GT_SKIP27:
COMP_SKP29:
BEQ LINE_SKIP159
; Simplified conditional branch
;
LINE_NSKIP159:
;
LDX #4
dcloop733_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop733_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP159:
;
;
LINE_600:
;
LDA #<CONST_28R
LDY #>CONST_28R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_610:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_29
LDY #>CONST_29
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_30R
LDY #>CONST_30R
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
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_620:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT28
LDA #0
JMP GT_SKIP28
GT_GT28:
LDA #$1
GT_SKIP28:
COMP_SKP30:
BNE LINE_NSKIP160
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP160
;
LINE_NSKIP160:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP160:
;
;
LINE_630:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ29
BEQ LTEQ_LTEQ29
LDA #0
JMP LTEQ_SKIP29
LTEQ_LTEQ29:
LDA #$1
LTEQ_SKIP29:
COMP_SKP31:
BNE LINE_NSKIP161
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP161
;
LINE_NSKIP161:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP161:
;
;
LINE_640:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_650:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_660:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ30
ROL
BCC LT_LT30
LT_LT_EQ30:
LDA #0
JMP LT_SKIP30
LT_LT30:
LDA #$1
LT_SKIP30:
COMP_SKP32:
BEQ LINE_SKIP162
; Simplified conditional branch
;
LINE_NSKIP162:
;
LDX #4
dcloop733_3:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop733_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP162:
;
;
LINE_670:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT31
LDA #0
JMP GT_SKIP31
GT_GT31:
LDA #$1
GT_SKIP31:
COMP_SKP33:
BEQ LINE_SKIP163
; Simplified conditional branch
;
LINE_NSKIP163:
;
LDX #4
dcloop733_4:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop733_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP163:
;
;
LINE_680:
;
LDA #<CONST_31R
LDY #>CONST_31R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_690:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_32
LDY #>CONST_32
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_700:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT32
LDA #0
JMP GT_SKIP32
GT_GT32:
LDA #$1
GT_SKIP32:
COMP_SKP34:
BNE LINE_NSKIP164
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP164
;
LINE_NSKIP164:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP164:
;
;
LINE_710:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ33
BEQ LTEQ_LTEQ33
LDA #0
JMP LTEQ_SKIP33
LTEQ_LTEQ33:
LDA #$1
LTEQ_SKIP33:
COMP_SKP35:
BNE LINE_NSKIP165
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP165
;
LINE_NSKIP165:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP165:
;
;
LINE_720:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_730:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_740:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ34
ROL
BCC LT_LT34
LT_LT_EQ34:
LDA #0
JMP LT_SKIP34
LT_LT34:
LDA #$1
LT_SKIP34:
COMP_SKP36:
BEQ LINE_SKIP166
; Simplified conditional branch
;
LINE_NSKIP166:
;
LDX #4
dcloop899_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP166:
;
;
LINE_750:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT35
LDA #0
JMP GT_SKIP35
GT_GT35:
LDA #$1
GT_SKIP35:
COMP_SKP37:
BEQ LINE_SKIP167
; Simplified conditional branch
;
LINE_NSKIP167:
;
LDX #4
dcloop899_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop899_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP167:
;
;
LINE_760:
;
LDA #<CONST_33R
LDY #>CONST_33R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_770:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_34
LDY #>CONST_34
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_780:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT36
LDA #0
JMP GT_SKIP36
GT_GT36:
LDA #$1
GT_SKIP36:
COMP_SKP38:
BNE LINE_NSKIP168
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP168
;
LINE_NSKIP168:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP168:
;
;
LINE_790:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ37
BEQ LTEQ_LTEQ37
LDA #0
JMP LTEQ_SKIP37
LTEQ_LTEQ37:
LDA #$1
LTEQ_SKIP37:
COMP_SKP39:
BNE LINE_NSKIP169
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP169
;
LINE_NSKIP169:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP169:
;
;
LINE_800:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_810:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_820:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ38
ROL
BCC LT_LT38
LT_LT_EQ38:
LDA #0
JMP LT_SKIP38
LT_LT38:
LDA #$1
LT_SKIP38:
COMP_SKP40:
BEQ LINE_SKIP170
; Simplified conditional branch
;
LINE_NSKIP170:
;
LDX #4
dcloop899_3:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop899_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP170:
;
;
LINE_830:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT39
LDA #0
JMP GT_SKIP39
GT_GT39:
LDA #$1
GT_SKIP39:
COMP_SKP41:
BEQ LINE_SKIP171
; Simplified conditional branch
;
LINE_NSKIP171:
;
LDX #4
dcloop899_4:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop899_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP171:
;
;
LINE_840:
;
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_850:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_36
LDY #>CONST_36
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_37R
LDY #>CONST_37R
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
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_860:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT40
LDA #0
JMP GT_SKIP40
GT_GT40:
LDA #$1
GT_SKIP40:
COMP_SKP42:
BNE LINE_NSKIP172
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP172
;
LINE_NSKIP172:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP172:
;
;
LINE_870:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ41
BEQ LTEQ_LTEQ41
LDA #0
JMP LTEQ_SKIP41
LTEQ_LTEQ41:
LDA #$1
LTEQ_SKIP41:
COMP_SKP43:
BNE LINE_NSKIP173
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP173
;
LINE_NSKIP173:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP173:
;
;
LINE_880:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_890:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_900:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ42
ROL
BCC LT_LT42
LT_LT_EQ42:
LDA #0
JMP LT_SKIP42
LT_LT42:
LDA #$1
LT_SKIP42:
COMP_SKP44:
BEQ LINE_SKIP174
; Simplified conditional branch
;
LINE_NSKIP174:
;
LDX #4
dcloop1065_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP174:
;
;
LINE_910:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT43
LDA #0
JMP GT_SKIP43
GT_GT43:
LDA #$1
GT_SKIP43:
COMP_SKP45:
BEQ LINE_SKIP175
; Simplified conditional branch
;
LINE_NSKIP175:
;
LDX #4
dcloop1065_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop1065_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP175:
;
;
LINE_920:
;
LDA #<CONST_38R
LDY #>CONST_38R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_930:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_39
LDY #>CONST_39
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_940:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT44
LDA #0
JMP GT_SKIP44
GT_GT44:
LDA #$1
GT_SKIP44:
COMP_SKP46:
BNE LINE_NSKIP176
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP176
;
LINE_NSKIP176:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP176:
;
;
LINE_950:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ45
BEQ LTEQ_LTEQ45
LDA #0
JMP LTEQ_SKIP45
LTEQ_LTEQ45:
LDA #$1
LTEQ_SKIP45:
COMP_SKP47:
BNE LINE_NSKIP177
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP177
;
LINE_NSKIP177:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP177:
;
;
LINE_960:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_970:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_980:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ46
ROL
BCC LT_LT46
LT_LT_EQ46:
LDA #0
JMP LT_SKIP46
LT_LT46:
LDA #$1
LT_SKIP46:
COMP_SKP48:
BEQ LINE_SKIP178
; Simplified conditional branch
;
LINE_NSKIP178:
;
LDX #4
dcloop1065_3:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop1065_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP178:
;
;
LINE_990:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT47
LDA #0
JMP GT_SKIP47
GT_GT47:
LDA #$1
GT_SKIP47:
COMP_SKP49:
BEQ LINE_SKIP179
; Simplified conditional branch
;
LINE_NSKIP179:
;
LDX #4
dcloop1065_4:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop1065_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP179:
;
;
LINE_1000:
;
LDA #<CONST_40R
LDY #>CONST_40R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1010:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_41
LDY #>CONST_41
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_42R
LDY #>CONST_42R
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
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1020:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT48
LDA #0
JMP GT_SKIP48
GT_GT48:
LDA #$1
GT_SKIP48:
COMP_SKP50:
BNE LINE_NSKIP180
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP180
;
LINE_NSKIP180:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP180:
;
;
LINE_1030:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ49
BEQ LTEQ_LTEQ49
LDA #0
JMP LTEQ_SKIP49
LTEQ_LTEQ49:
LDA #$1
LTEQ_SKIP49:
COMP_SKP51:
BNE LINE_NSKIP181
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP181
;
LINE_NSKIP181:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP181:
;
;
LINE_1040:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1050:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1060:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ50
ROL
BCC LT_LT50
LT_LT_EQ50:
LDA #0
JMP LT_SKIP50
LT_LT50:
LDA #$1
LT_SKIP50:
COMP_SKP52:
BEQ LINE_SKIP182
; Simplified conditional branch
;
LINE_NSKIP182:
;
LDX #4
dcloop1231_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP182:
;
;
LINE_1070:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT51
LDA #0
JMP GT_SKIP51
GT_GT51:
LDA #$1
GT_SKIP51:
COMP_SKP53:
BEQ LINE_SKIP183
; Simplified conditional branch
;
LINE_NSKIP183:
;
LDX #4
dcloop1231_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop1231_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP183:
;
;
LINE_1080:
;
LDA #<CONST_43R
LDY #>CONST_43R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1090:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_44
LDY #>CONST_44
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_45
LDY #>CONST_45
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1100:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT52
LDA #0
JMP GT_SKIP52
GT_GT52:
LDA #$1
GT_SKIP52:
COMP_SKP54:
BNE LINE_NSKIP184
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP184
;
LINE_NSKIP184:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP184:
;
;
LINE_1110:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ53
BEQ LTEQ_LTEQ53
LDA #0
JMP LTEQ_SKIP53
LTEQ_LTEQ53:
LDA #$1
LTEQ_SKIP53:
COMP_SKP55:
BNE LINE_NSKIP185
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP185
;
LINE_NSKIP185:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP185:
;
;
LINE_1120:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1130:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1140:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ54
ROL
BCC LT_LT54
LT_LT_EQ54:
LDA #0
JMP LT_SKIP54
LT_LT54:
LDA #$1
LT_SKIP54:
COMP_SKP56:
BEQ LINE_SKIP186
; Simplified conditional branch
;
LINE_NSKIP186:
;
LDX #4
dcloop1231_3:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop1231_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP186:
;
;
LINE_1150:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT55
LDA #0
JMP GT_SKIP55
GT_GT55:
LDA #$1
GT_SKIP55:
COMP_SKP57:
BEQ LINE_SKIP187
; Simplified conditional branch
;
LINE_NSKIP187:
;
LDX #4
dcloop1231_4:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop1231_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP187:
;
;
LINE_1160:
;
LDA #<CONST_46R
LDY #>CONST_46R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1170:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_47
LDY #>CONST_47
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_48
LDY #>CONST_48
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1180:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT56
LDA #0
JMP GT_SKIP56
GT_GT56:
LDA #$1
GT_SKIP56:
COMP_SKP58:
BNE LINE_NSKIP188
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP188
;
LINE_NSKIP188:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP188:
;
;
LINE_1190:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ57
BEQ LTEQ_LTEQ57
LDA #0
JMP LTEQ_SKIP57
LTEQ_LTEQ57:
LDA #$1
LTEQ_SKIP57:
COMP_SKP59:
BNE LINE_NSKIP189
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP189
;
LINE_NSKIP189:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP189:
;
;
LINE_1200:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1210:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1220:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ58
ROL
BCC LT_LT58
LT_LT_EQ58:
LDA #0
JMP LT_SKIP58
LT_LT58:
LDA #$1
LT_SKIP58:
COMP_SKP60:
BEQ LINE_SKIP190
; Simplified conditional branch
;
LINE_NSKIP190:
;
LDX #4
dcloop1397_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop1397_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP190:
;
;
LINE_1230:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT59
LDA #0
JMP GT_SKIP59
GT_GT59:
LDA #$1
GT_SKIP59:
COMP_SKP61:
BEQ LINE_SKIP191
; Simplified conditional branch
;
LINE_NSKIP191:
;
LDX #4
dcloop1397_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop1397_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP191:
;
;
LINE_1240:
;
LDA #<CONST_49R
LDY #>CONST_49R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1250:
;
LDY #$00
LDA #$80
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_A%
LDA VAR_A%+1
JSR INTADD
; Optimized code for adding INTs (1)
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
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_50
LDY #>CONST_50
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1260:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT60
LDA #0
JMP GT_SKIP60
GT_GT60:
LDA #$1
GT_SKIP60:
COMP_SKP62:
BNE LINE_NSKIP192
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP192
;
LINE_NSKIP192:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP192:
;
;
LINE_1270:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ61
BEQ LTEQ_LTEQ61
LDA #0
JMP LTEQ_SKIP61
LTEQ_LTEQ61:
LDA #$1
LTEQ_SKIP61:
COMP_SKP63:
BNE LINE_NSKIP193
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP193
;
LINE_NSKIP193:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_9
LDY #>CONST_9
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP193:
;
;
LINE_1280:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #6
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1290:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1300:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ62
ROL
BCC LT_LT62
LT_LT_EQ62:
LDA #0
JMP LT_SKIP62
LT_LT62:
LDA #$1
LT_SKIP62:
COMP_SKP64:
BEQ LINE_SKIP194
; Simplified conditional branch
;
LINE_NSKIP194:
;
LDX #4
dcloop1397_3:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop1397_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP194:
;
;
LINE_1310:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT63
LDA #0
JMP GT_SKIP63
GT_GT63:
LDA #$1
GT_SKIP63:
COMP_SKP65:
BEQ LINE_SKIP195
; Simplified conditional branch
;
LINE_NSKIP195:
;
LDX #4
dcloop1397_4:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop1397_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP195:
;
;
LINE_1320:
;
LDA #<CONST_51R
LDY #>CONST_51R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L1[]
LDY #>VAR_L1[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1330:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1340:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1350:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_53
LDY #>CONST_53
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1360:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1370:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_55
LDY #>CONST_55
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1380:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_56
LDY #>CONST_56
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1390:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_57
LDY #>CONST_57
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1400:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_58
LDY #>CONST_58
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1410:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_55
LDY #>CONST_55
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1420:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_59
LDY #>CONST_59
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1430:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_60
LDY #>CONST_60
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1440:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_61
LDY #>CONST_61
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1450:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1460:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1470:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_62
LDY #>CONST_62
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1480:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_60
LDY #>CONST_60
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1490:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_63
LDY #>CONST_63
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1500:
;
; Optimizer rule: VAR into FAC, FAC into VAR/0
;
LINE_1510:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT64
LDA #0
JMP GT_SKIP64
GT_GT64:
LDA #$1
GT_SKIP64:
COMP_SKP66:
BNE LINE_NSKIP196
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP196
;
LINE_NSKIP196:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP196:
;
;
LINE_1520:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ65
BEQ LTEQ_LTEQ65
LDA #0
JMP LTEQ_SKIP65
LTEQ_LTEQ65:
LDA #$1
LTEQ_SKIP65:
COMP_SKP67:
BNE LINE_NSKIP197
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP197
;
LINE_NSKIP197:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP197:
;
;
LINE_1530:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1540:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1550:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
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
COMP_SKP68:
BEQ LINE_SKIP198
; Simplified conditional branch
;
LINE_NSKIP198:
;
LDX #4
dcloop1729_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop1729_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP198:
;
;
LINE_1560:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT67
LDA #0
JMP GT_SKIP67
GT_GT67:
LDA #$1
GT_SKIP67:
COMP_SKP69:
BEQ LINE_SKIP199
; Simplified conditional branch
;
LINE_NSKIP199:
;
LDX #4
dcloop1729_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop1729_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP199:
;
;
LINE_1570:
;
LDA #<CONST_12R
LDY #>CONST_12R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1580:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1590:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_65
LDY #>CONST_65
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1600:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_66
LDY #>CONST_66
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1610:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_67
LDY #>CONST_67
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1620:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_68
LDY #>CONST_68
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1630:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_69
LDY #>CONST_69
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1640:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_70
LDY #>CONST_70
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1650:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_71
LDY #>CONST_71
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1660:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_72
LDY #>CONST_72
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1670:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_73
LDY #>CONST_73
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1680:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_70
LDY #>CONST_70
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1690:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_74
LDY #>CONST_74
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1700:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_75
LDY #>CONST_75
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1710:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1720:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_59
LDY #>CONST_59
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1730:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1740:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_76
LDY #>CONST_76
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1750:
;
LDA #<CONST_77R
LDY #>CONST_77R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1760:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT68
LDA #0
JMP GT_SKIP68
GT_GT68:
LDA #$1
GT_SKIP68:
COMP_SKP70:
BNE LINE_NSKIP200
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP200
;
LINE_NSKIP200:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP200:
;
;
LINE_1770:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ69
BEQ LTEQ_LTEQ69
LDA #0
JMP LTEQ_SKIP69
LTEQ_LTEQ69:
LDA #$1
LTEQ_SKIP69:
COMP_SKP71:
BNE LINE_NSKIP201
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP201
;
LINE_NSKIP201:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP201:
;
;
LINE_1780:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1790:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1800:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
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
COMP_SKP72:
BEQ LINE_SKIP202
; Simplified conditional branch
;
LINE_NSKIP202:
;
LDX #4
dcloop1895_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP202:
;
;
LINE_1810:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT71
LDA #0
JMP GT_SKIP71
GT_GT71:
LDA #$1
GT_SKIP71:
COMP_SKP73:
BEQ LINE_SKIP203
; Simplified conditional branch
;
LINE_NSKIP203:
;
LDX #4
dcloop1895_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop1895_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP203:
;
;
LINE_1820:
;
LDA #<CONST_17R
LDY #>CONST_17R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_1830:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1840:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1850:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_78
LDY #>CONST_78
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1860:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_79
LDY #>CONST_79
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1870:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_80
LDY #>CONST_80
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1880:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_32
LDY #>CONST_32
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1890:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_81
LDY #>CONST_81
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1900:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_82
LDY #>CONST_82
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1910:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_75
LDY #>CONST_75
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1920:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_83
LDY #>CONST_83
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1930:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_58
LDY #>CONST_58
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1940:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_26
LDY #>CONST_26
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1950:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_84
LDY #>CONST_84
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1960:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_85
LDY #>CONST_85
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1970:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_86
LDY #>CONST_86
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1980:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_87
LDY #>CONST_87
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_1990:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2000:
;
LDA #<CONST_88R
LDY #>CONST_88R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2010:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT72
LDA #0
JMP GT_SKIP72
GT_GT72:
LDA #$1
GT_SKIP72:
COMP_SKP74:
BNE LINE_NSKIP204
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP204
;
LINE_NSKIP204:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP204:
;
;
LINE_2020:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ73
BEQ LTEQ_LTEQ73
LDA #0
JMP LTEQ_SKIP73
LTEQ_LTEQ73:
LDA #$1
LTEQ_SKIP73:
COMP_SKP75:
BNE LINE_NSKIP205
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP205
;
LINE_NSKIP205:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP205:
;
;
LINE_2030:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2040:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2050:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ74
ROL
BCC LT_LT74
LT_LT_EQ74:
LDA #0
JMP LT_SKIP74
LT_LT74:
LDA #$1
LT_SKIP74:
COMP_SKP76:
BEQ LINE_SKIP206
; Simplified conditional branch
;
LINE_NSKIP206:
;
LDX #4
dcloop2061_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop2061_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP206:
;
;
LINE_2060:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT75
LDA #0
JMP GT_SKIP75
GT_GT75:
LDA #$1
GT_SKIP75:
COMP_SKP77:
BEQ LINE_SKIP207
; Simplified conditional branch
;
LINE_NSKIP207:
;
LDX #4
dcloop2061_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop2061_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP207:
;
;
LINE_2070:
;
LDA #<CONST_20R
LDY #>CONST_20R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_2080:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2090:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_89
LDY #>CONST_89
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2100:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2110:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_90
LDY #>CONST_90
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2120:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_91
LDY #>CONST_91
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2130:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_92
LDY #>CONST_92
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2140:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_55
LDY #>CONST_55
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2150:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_93
LDY #>CONST_93
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2160:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_94
LDY #>CONST_94
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2170:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDY #2
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2180:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_93
LDY #>CONST_93
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2190:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_95
LDY #>CONST_95
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2200:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_59
LDY #>CONST_59
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2210:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_96
LDY #>CONST_96
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2220:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_75
LDY #>CONST_75
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2230:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_97
LDY #>CONST_97
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2240:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_80
LDY #>CONST_80
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2250:
;
LDA #<CONST_98R
LDY #>CONST_98R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2260:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT76
LDA #0
JMP GT_SKIP76
GT_GT76:
LDA #$1
GT_SKIP76:
COMP_SKP78:
BNE LINE_NSKIP208
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP208
;
LINE_NSKIP208:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP208:
;
;
LINE_2270:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ77
BEQ LTEQ_LTEQ77
LDA #0
JMP LTEQ_SKIP77
LTEQ_LTEQ77:
LDA #$1
LTEQ_SKIP77:
COMP_SKP79:
BNE LINE_NSKIP209
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP209
;
LINE_NSKIP209:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP209:
;
;
LINE_2280:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2290:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2300:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ78
ROL
BCC LT_LT78
LT_LT_EQ78:
LDA #0
JMP LT_SKIP78
LT_LT78:
LDA #$1
LT_SKIP78:
COMP_SKP80:
BEQ LINE_SKIP210
; Simplified conditional branch
;
LINE_NSKIP210:
;
LDX #4
dcloop2393_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop2393_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP210:
;
;
LINE_2310:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT79
LDA #0
JMP GT_SKIP79
GT_GT79:
LDA #$1
GT_SKIP79:
COMP_SKP81:
BEQ LINE_SKIP211
; Simplified conditional branch
;
LINE_NSKIP211:
;
LDX #4
dcloop2393_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop2393_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP211:
;
;
LINE_2320:
;
LDA #<CONST_22R
LDY #>CONST_22R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_2330:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2340:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2350:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_55
LDY #>CONST_55
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2360:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_73
LDY #>CONST_73
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2370:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_70
LDY #>CONST_70
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2380:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_66
LDY #>CONST_66
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2390:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_91
LDY #>CONST_91
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2400:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_56
LDY #>CONST_56
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2410:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_100
LDY #>CONST_100
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2420:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_101
LDY #>CONST_101
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2430:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_102
LDY #>CONST_102
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2440:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_103
LDY #>CONST_103
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2450:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_101
LDY #>CONST_101
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2460:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_86
LDY #>CONST_86
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2470:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_104
LDY #>CONST_104
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2480:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_105
LDY #>CONST_105
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2490:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_50
LDY #>CONST_50
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2500:
;
LDA #<CONST_106
LDY #>CONST_106
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2510:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT80
LDA #0
JMP GT_SKIP80
GT_GT80:
LDA #$1
GT_SKIP80:
COMP_SKP82:
BNE LINE_NSKIP212
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP212
;
LINE_NSKIP212:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP212:
;
;
LINE_2520:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ81
BEQ LTEQ_LTEQ81
LDA #0
JMP LTEQ_SKIP81
LTEQ_LTEQ81:
LDA #$1
LTEQ_SKIP81:
COMP_SKP83:
BNE LINE_NSKIP213
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP213
;
LINE_NSKIP213:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP213:
;
;
LINE_2530:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2540:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2550:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ82
ROL
BCC LT_LT82
LT_LT_EQ82:
LDA #0
JMP LT_SKIP82
LT_LT82:
LDA #$1
LT_SKIP82:
COMP_SKP84:
BEQ LINE_SKIP214
; Simplified conditional branch
;
LINE_NSKIP214:
;
LDX #4
dcloop2559_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop2559_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP214:
;
;
LINE_2560:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT83
LDA #0
JMP GT_SKIP83
GT_GT83:
LDA #$1
GT_SKIP83:
COMP_SKP85:
BEQ LINE_SKIP215
; Simplified conditional branch
;
LINE_NSKIP215:
;
LDX #4
dcloop2559_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop2559_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP215:
;
;
LINE_2570:
;
LDA #<CONST_25R
LDY #>CONST_25R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_2580:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2590:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_101
LDY #>CONST_101
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2600:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_107
LDY #>CONST_107
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2610:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_69
LDY #>CONST_69
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2620:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_47
LDY #>CONST_47
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2630:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_89
LDY #>CONST_89
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2640:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_61
LDY #>CONST_61
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2650:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_84
LDY #>CONST_84
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2660:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_21
LDY #>CONST_21
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2670:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_70
LDY #>CONST_70
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2680:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_93
LDY #>CONST_93
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2690:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_108
LDY #>CONST_108
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2700:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_47
LDY #>CONST_47
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2710:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_81
LDY #>CONST_81
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2720:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_108
LDY #>CONST_108
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2730:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_84
LDY #>CONST_84
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2740:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_85
LDY #>CONST_85
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2750:
;
; Optimizer rule: VAR into FAC, FAC into VAR/0
;
LINE_2760:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT84
LDA #0
JMP GT_SKIP84
GT_GT84:
LDA #$1
GT_SKIP84:
COMP_SKP86:
BNE LINE_NSKIP216
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP216
;
LINE_NSKIP216:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP216:
;
;
LINE_2770:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ85
BEQ LTEQ_LTEQ85
LDA #0
JMP LTEQ_SKIP85
LTEQ_LTEQ85:
LDA #$1
LTEQ_SKIP85:
COMP_SKP87:
BNE LINE_NSKIP217
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP217
;
LINE_NSKIP217:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP217:
;
;
LINE_2780:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2790:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2800:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ86
ROL
BCC LT_LT86
LT_LT_EQ86:
LDA #0
JMP LT_SKIP86
LT_LT86:
LDA #$1
LT_SKIP86:
COMP_SKP88:
BEQ LINE_SKIP218
; Simplified conditional branch
;
LINE_NSKIP218:
;
LDX #4
dcloop2725_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP218:
;
;
LINE_2810:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT87
LDA #0
JMP GT_SKIP87
GT_GT87:
LDA #$1
GT_SKIP87:
COMP_SKP89:
BEQ LINE_SKIP219
; Simplified conditional branch
;
LINE_NSKIP219:
;
LDX #4
dcloop2891_1:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop2891_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP219:
;
;
LINE_2820:
;
LDA #<CONST_8R
LDY #>CONST_8R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_2830:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2840:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_73
LDY #>CONST_73
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2850:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_15
LDY #>CONST_15
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2860:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_90
LDY #>CONST_90
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2870:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_84
LDY #>CONST_84
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2880:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_84
LDY #>CONST_84
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2890:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2900:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_109
LDY #>CONST_109
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2910:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_101
LDY #>CONST_101
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2920:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_63
LDY #>CONST_63
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2930:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_81
LDY #>CONST_81
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2940:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_110
LDY #>CONST_110
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2950:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_111
LDY #>CONST_111
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2960:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2970:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2980:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_112
LDY #>CONST_112
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_2990:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_70
LDY #>CONST_70
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3000:
;
LDA #<CONST_113R
LDY #>CONST_113R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3010:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT88
LDA #0
JMP GT_SKIP88
GT_GT88:
LDA #$1
GT_SKIP88:
COMP_SKP90:
BNE LINE_NSKIP220
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP220
;
LINE_NSKIP220:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP220:
;
;
LINE_3020:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ89
BEQ LTEQ_LTEQ89
LDA #0
JMP LTEQ_SKIP89
LTEQ_LTEQ89:
LDA #$1
LTEQ_SKIP89:
COMP_SKP91:
BNE LINE_NSKIP221
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP221
;
LINE_NSKIP221:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP221:
;
;
LINE_3030:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3040:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3050:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ90
ROL
BCC LT_LT90
LT_LT_EQ90:
LDA #0
JMP LT_SKIP90
LT_LT90:
LDA #$1
LT_SKIP90:
COMP_SKP92:
BEQ LINE_SKIP222
; Simplified conditional branch
;
LINE_NSKIP222:
;
LDX #4
dcloop3057_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP222:
;
;
LINE_3060:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT91
LDA #0
JMP GT_SKIP91
GT_GT91:
LDA #$1
GT_SKIP91:
COMP_SKP93:
BEQ LINE_SKIP223
; Simplified conditional branch
;
LINE_NSKIP223:
;
LDX #4
dcloop3057_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop3057_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP223:
;
;
LINE_3070:
;
LDA #<CONST_28R
LDY #>CONST_28R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_3080:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_3090:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3100:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_108
LDY #>CONST_108
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3110:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_78
LDY #>CONST_78
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3120:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_114
LDY #>CONST_114
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3130:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_115
LDY #>CONST_115
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3140:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_53
LDY #>CONST_53
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3150:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_92
LDY #>CONST_92
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3160:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_82
LDY #>CONST_82
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3170:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_62
LDY #>CONST_62
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3180:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_66
LDY #>CONST_66
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3190:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_116
LDY #>CONST_116
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3200:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_53
LDY #>CONST_53
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3210:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_117
LDY #>CONST_117
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3220:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3230:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_118
LDY #>CONST_118
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3240:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_71
LDY #>CONST_71
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3250:
;
LDA #<CONST_119
LDY #>CONST_119
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3260:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT92
LDA #0
JMP GT_SKIP92
GT_GT92:
LDA #$1
GT_SKIP92:
COMP_SKP94:
BNE LINE_NSKIP224
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP224
;
LINE_NSKIP224:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP224:
;
;
LINE_3270:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ93
BEQ LTEQ_LTEQ93
LDA #0
JMP LTEQ_SKIP93
LTEQ_LTEQ93:
LDA #$1
LTEQ_SKIP93:
COMP_SKP95:
BNE LINE_NSKIP225
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP225
;
LINE_NSKIP225:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP225:
;
;
LINE_3280:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3290:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3300:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
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
COMP_SKP96:
BEQ LINE_SKIP226
; Simplified conditional branch
;
LINE_NSKIP226:
;
LDX #4
dcloop3223_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop3223_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP226:
;
;
LINE_3310:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT95
LDA #0
JMP GT_SKIP95
GT_GT95:
LDA #$1
GT_SKIP95:
COMP_SKP97:
BEQ LINE_SKIP227
; Simplified conditional branch
;
LINE_NSKIP227:
;
LDX #4
dcloop3223_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop3223_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP227:
;
;
LINE_3320:
;
LDA #<CONST_31R
LDY #>CONST_31R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_3330:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_3340:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_21
LDY #>CONST_21
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3350:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_63
LDY #>CONST_63
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3360:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_120
LDY #>CONST_120
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3370:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_55
LDY #>CONST_55
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3380:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_121
LDY #>CONST_121
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3390:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3400:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_93
LDY #>CONST_93
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3410:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_56
LDY #>CONST_56
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3420:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_55
LDY #>CONST_55
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3430:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3440:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_117
LDY #>CONST_117
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3450:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_68
LDY #>CONST_68
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3460:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_92
LDY #>CONST_92
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3470:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_83
LDY #>CONST_83
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3480:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_111
LDY #>CONST_111
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3490:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_121
LDY #>CONST_121
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3500:
;
LDA #<CONST_122R
LDY #>CONST_122R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3510:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT96
LDA #0
JMP GT_SKIP96
GT_GT96:
LDA #$1
GT_SKIP96:
COMP_SKP98:
BNE LINE_NSKIP228
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP228
;
LINE_NSKIP228:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP228:
;
;
LINE_3520:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ97
BEQ LTEQ_LTEQ97
LDA #0
JMP LTEQ_SKIP97
LTEQ_LTEQ97:
LDA #$1
LTEQ_SKIP97:
COMP_SKP99:
BNE LINE_NSKIP229
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP229
;
LINE_NSKIP229:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP229:
;
;
LINE_3530:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3540:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3550:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
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
COMP_SKP100:
BEQ LINE_SKIP230
; Simplified conditional branch
;
LINE_NSKIP230:
;
LDX #4
dcloop3555_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP230:
;
;
LINE_3560:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT99
LDA #0
JMP GT_SKIP99
GT_GT99:
LDA #$1
GT_SKIP99:
COMP_SKP101:
BEQ LINE_SKIP231
; Simplified conditional branch
;
LINE_NSKIP231:
;
LDX #4
dcloop3555_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop3555_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP231:
;
;
LINE_3570:
;
LDA #<CONST_33R
LDY #>CONST_33R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_3580:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_3590:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_47
LDY #>CONST_47
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3600:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3610:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_123
LDY #>CONST_123
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3620:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_56
LDY #>CONST_56
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3630:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_67
LDY #>CONST_67
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3640:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3650:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_120
LDY #>CONST_120
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3660:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_86
LDY #>CONST_86
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3670:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_86
LDY #>CONST_86
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3680:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3690:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_124
LDY #>CONST_124
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3700:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3710:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3720:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_62
LDY #>CONST_62
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3730:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_125
LDY #>CONST_125
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3740:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_86
LDY #>CONST_86
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3750:
;
LDA #<CONST_126R
LDY #>CONST_126R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3760:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT100
LDA #0
JMP GT_SKIP100
GT_GT100:
LDA #$1
GT_SKIP100:
COMP_SKP102:
BNE LINE_NSKIP232
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP232
;
LINE_NSKIP232:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP232:
;
;
LINE_3770:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ101
BEQ LTEQ_LTEQ101
LDA #0
JMP LTEQ_SKIP101
LTEQ_LTEQ101:
LDA #$1
LTEQ_SKIP101:
COMP_SKP103:
BNE LINE_NSKIP233
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP233
;
LINE_NSKIP233:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP233:
;
;
LINE_3780:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3790:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3800:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ102
ROL
BCC LT_LT102
LT_LT_EQ102:
LDA #0
JMP LT_SKIP102
LT_LT102:
LDA #$1
LT_SKIP102:
COMP_SKP104:
BEQ LINE_SKIP234
; Simplified conditional branch
;
LINE_NSKIP234:
;
LDX #4
dcloop3721_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP234:
;
;
LINE_3810:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT103
LDA #0
JMP GT_SKIP103
GT_GT103:
LDA #$1
GT_SKIP103:
COMP_SKP105:
BEQ LINE_SKIP235
; Simplified conditional branch
;
LINE_NSKIP235:
;
LDX #4
dcloop3721_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop3721_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP235:
;
;
LINE_3820:
;
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_3830:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_3840:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_96
LDY #>CONST_96
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3850:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3860:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_68
LDY #>CONST_68
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3870:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_96
LDY #>CONST_96
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3880:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_111
LDY #>CONST_111
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3890:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3900:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_58
LDY #>CONST_58
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3910:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3920:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_75
LDY #>CONST_75
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3930:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3940:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3950:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_99
LDY #>CONST_99
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3960:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_75
LDY #>CONST_75
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3970:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_59
LDY #>CONST_59
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3980:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_91
LDY #>CONST_91
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_3990:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_18
LDY #>CONST_18
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4000:
;
LDA #<CONST_127
LDY #>CONST_127
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4010:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT104
LDA #0
JMP GT_SKIP104
GT_GT104:
LDA #$1
GT_SKIP104:
COMP_SKP106:
BNE LINE_NSKIP236
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP236
;
LINE_NSKIP236:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP236:
;
;
LINE_4020:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ105
BEQ LTEQ_LTEQ105
LDA #0
JMP LTEQ_SKIP105
LTEQ_LTEQ105:
LDA #$1
LTEQ_SKIP105:
COMP_SKP107:
BNE LINE_NSKIP237
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP237
;
LINE_NSKIP237:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP237:
;
;
LINE_4030:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4040:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4050:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ106
ROL
BCC LT_LT106
LT_LT_EQ106:
LDA #0
JMP LT_SKIP106
LT_LT106:
LDA #$1
LT_SKIP106:
COMP_SKP108:
BEQ LINE_SKIP238
; Simplified conditional branch
;
LINE_NSKIP238:
;
LDX #4
dcloop3887_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP238:
;
;
LINE_4060:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT107
LDA #0
JMP GT_SKIP107
GT_GT107:
LDA #$1
GT_SKIP107:
COMP_SKP109:
BEQ LINE_SKIP239
; Simplified conditional branch
;
LINE_NSKIP239:
;
LDX #4
dcloop4053_1:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop4053_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP239:
;
;
LINE_4070:
;
LDA #<CONST_38R
LDY #>CONST_38R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_4080:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_4090:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_91
LDY #>CONST_91
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4100:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_128
LDY #>CONST_128
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4110:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_60
LDY #>CONST_60
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4120:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_69
LDY #>CONST_69
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4130:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_129
LDY #>CONST_129
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4140:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_81
LDY #>CONST_81
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4150:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_92
LDY #>CONST_92
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4160:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_107
LDY #>CONST_107
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4170:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_55
LDY #>CONST_55
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4180:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_130
LDY #>CONST_130
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4190:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_100
LDY #>CONST_100
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4200:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_117
LDY #>CONST_117
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4210:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_131
LDY #>CONST_131
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4220:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_82
LDY #>CONST_82
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4230:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_132
LDY #>CONST_132
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4240:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_85
LDY #>CONST_85
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4250:
;
LDA #<CONST_133R
LDY #>CONST_133R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4260:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT108
LDA #0
JMP GT_SKIP108
GT_GT108:
LDA #$1
GT_SKIP108:
COMP_SKP110:
BNE LINE_NSKIP240
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP240
;
LINE_NSKIP240:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP240:
;
;
LINE_4270:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ109
BEQ LTEQ_LTEQ109
LDA #0
JMP LTEQ_SKIP109
LTEQ_LTEQ109:
LDA #$1
LTEQ_SKIP109:
COMP_SKP111:
BNE LINE_NSKIP241
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP241
;
LINE_NSKIP241:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP241:
;
;
LINE_4280:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4290:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4300:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ110
ROL
BCC LT_LT110
LT_LT_EQ110:
LDA #0
JMP LT_SKIP110
LT_LT110:
LDA #$1
LT_SKIP110:
COMP_SKP112:
BEQ LINE_SKIP242
; Simplified conditional branch
;
LINE_NSKIP242:
;
LDX #4
dcloop4219_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop4219_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP242:
;
;
LINE_4310:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT111
LDA #0
JMP GT_SKIP111
GT_GT111:
LDA #$1
GT_SKIP111:
COMP_SKP113:
BEQ LINE_SKIP243
; Simplified conditional branch
;
LINE_NSKIP243:
;
LDX #4
dcloop4219_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop4219_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP243:
;
;
LINE_4320:
;
LDA #<CONST_40R
LDY #>CONST_40R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_4330:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_4340:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_80
LDY #>CONST_80
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4350:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_134
LDY #>CONST_134
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4360:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_107
LDY #>CONST_107
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4370:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_121
LDY #>CONST_121
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4380:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_56
LDY #>CONST_56
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4390:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_117
LDY #>CONST_117
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4400:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_117
LDY #>CONST_117
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4410:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_134
LDY #>CONST_134
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4420:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_96
LDY #>CONST_96
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4430:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_104
LDY #>CONST_104
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4440:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_53
LDY #>CONST_53
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4450:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_18
LDY #>CONST_18
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4460:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_125
LDY #>CONST_125
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4470:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_79
LDY #>CONST_79
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4480:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_128
LDY #>CONST_128
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4490:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_61
LDY #>CONST_61
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4500:
;
; Optimizer rule: VAR into FAC, FAC into VAR/0
;
LINE_4510:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT112
LDA #0
JMP GT_SKIP112
GT_GT112:
LDA #$1
GT_SKIP112:
COMP_SKP114:
BNE LINE_NSKIP244
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP244
;
LINE_NSKIP244:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP244:
;
;
LINE_4520:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ113
BEQ LTEQ_LTEQ113
LDA #0
JMP LTEQ_SKIP113
LTEQ_LTEQ113:
LDA #$1
LTEQ_SKIP113:
COMP_SKP115:
BNE LINE_NSKIP245
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP245
;
LINE_NSKIP245:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP245:
;
;
LINE_4530:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4540:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4550:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ114
ROL
BCC LT_LT114
LT_LT_EQ114:
LDA #0
JMP LT_SKIP114
LT_LT114:
LDA #$1
LT_SKIP114:
COMP_SKP116:
BEQ LINE_SKIP246
; Simplified conditional branch
;
LINE_NSKIP246:
;
LDX #4
dcloop4385_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP246:
;
;
LINE_4560:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT115
LDA #0
JMP GT_SKIP115
GT_GT115:
LDA #$1
GT_SKIP115:
COMP_SKP117:
BEQ LINE_SKIP247
; Simplified conditional branch
;
LINE_NSKIP247:
;
LDX #4
dcloop4385_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop4385_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP247:
;
;
LINE_4570:
;
LDA #<CONST_43R
LDY #>CONST_43R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_4580:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_4590:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_130
LDY #>CONST_130
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4600:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_131
LDY #>CONST_131
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4610:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_135
LDY #>CONST_135
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4620:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_134
LDY #>CONST_134
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4630:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_65
LDY #>CONST_65
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4640:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_15
LDY #>CONST_15
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4650:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_76
LDY #>CONST_76
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4660:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_58
LDY #>CONST_58
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4670:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_107
LDY #>CONST_107
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4680:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_83
LDY #>CONST_83
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4690:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_103
LDY #>CONST_103
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4700:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4710:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_117
LDY #>CONST_117
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4720:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_54
LDY #>CONST_54
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4730:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_136
LDY #>CONST_136
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4740:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_96
LDY #>CONST_96
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4750:
;
LDA #<CONST_137
LDY #>CONST_137
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4760:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT116
LDA #0
JMP GT_SKIP116
GT_GT116:
LDA #$1
GT_SKIP116:
COMP_SKP118:
BNE LINE_NSKIP248
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP248
;
LINE_NSKIP248:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP248:
;
;
LINE_4770:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ117
BEQ LTEQ_LTEQ117
LDA #0
JMP LTEQ_SKIP117
LTEQ_LTEQ117:
LDA #$1
LTEQ_SKIP117:
COMP_SKP119:
BNE LINE_NSKIP249
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP249
;
LINE_NSKIP249:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP249:
;
;
LINE_4780:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4790:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4800:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ118
ROL
BCC LT_LT118
LT_LT_EQ118:
LDA #0
JMP LT_SKIP118
LT_LT118:
LDA #$1
LT_SKIP118:
COMP_SKP120:
BEQ LINE_SKIP250
; Simplified conditional branch
;
LINE_NSKIP250:
;
LDX #4
dcloop4717_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop4717_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP250:
;
;
LINE_4810:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT119
LDA #0
JMP GT_SKIP119
GT_GT119:
LDA #$1
GT_SKIP119:
COMP_SKP121:
BEQ LINE_SKIP251
; Simplified conditional branch
;
LINE_NSKIP251:
;
LDX #4
dcloop4717_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop4717_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP251:
;
;
LINE_4820:
;
LDA #<CONST_46R
LDY #>CONST_46R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_4830:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_4840:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_92
LDY #>CONST_92
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4850:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_73
LDY #>CONST_73
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4860:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_111
LDY #>CONST_111
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4870:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_47
LDY #>CONST_47
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4880:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_101
LDY #>CONST_101
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4890:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_62
LDY #>CONST_62
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4900:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_80
LDY #>CONST_80
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4910:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_47
LDY #>CONST_47
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4920:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_94
LDY #>CONST_94
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4930:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_93
LDY #>CONST_93
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4940:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_135
LDY #>CONST_135
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4950:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_15
LDY #>CONST_15
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4960:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_130
LDY #>CONST_130
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4970:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_66
LDY #>CONST_66
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4980:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_138
LDY #>CONST_138
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_4990:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5000:
;
LDA #<CONST_139
LDY #>CONST_139
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5010:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT120
LDA #0
JMP GT_SKIP120
GT_GT120:
LDA #$1
GT_SKIP120:
COMP_SKP122:
BNE LINE_NSKIP252
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP252
;
LINE_NSKIP252:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP252:
;
;
LINE_5020:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ121
BEQ LTEQ_LTEQ121
LDA #0
JMP LTEQ_SKIP121
LTEQ_LTEQ121:
LDA #$1
LTEQ_SKIP121:
COMP_SKP123:
BNE LINE_NSKIP253
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP253
;
LINE_NSKIP253:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP253:
;
;
LINE_5030:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5040:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5050:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ122
ROL
BCC LT_LT122
LT_LT_EQ122:
LDA #0
JMP LT_SKIP122
LT_LT122:
LDA #$1
LT_SKIP122:
COMP_SKP124:
BEQ LINE_SKIP254
; Simplified conditional branch
;
LINE_NSKIP254:
;
LDX #4
dcloop4883_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop4883_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP254:
;
;
LINE_5060:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT123
LDA #0
JMP GT_SKIP123
GT_GT123:
LDA #$1
GT_SKIP123:
COMP_SKP125:
BEQ LINE_SKIP255
; Simplified conditional branch
;
LINE_NSKIP255:
;
LDX #4
dcloop4883_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop4883_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP255:
;
;
LINE_5070:
;
LDA #<CONST_49R
LDY #>CONST_49R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_5080:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_5090:
;
LDA #<VAR_L1[]+5
LDY #>VAR_L1[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_95
LDY #>CONST_95
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5100:
;
LDA #<VAR_L1[]+10
LDY #>VAR_L1[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_140
LDY #>CONST_140
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5110:
;
LDA #<VAR_L1[]+15
LDY #>VAR_L1[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_59
LDY #>CONST_59
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5120:
;
LDA #<VAR_L1[]+20
LDY #>VAR_L1[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_93
LDY #>CONST_93
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5130:
;
LDA #<VAR_L1[]+25
LDY #>VAR_L1[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_62
LDY #>CONST_62
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5140:
;
LDA #<VAR_L1[]+30
LDY #>VAR_L1[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_66
LDY #>CONST_66
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5150:
;
LDA #<VAR_L1[]+35
LDY #>VAR_L1[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_69
LDY #>CONST_69
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5160:
;
LDA #<VAR_L1[]+40
LDY #>VAR_L1[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_75
LDY #>CONST_75
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5170:
;
LDA #<VAR_L1[]+45
LDY #>VAR_L1[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_15
LDY #>CONST_15
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5180:
;
LDA #<VAR_L1[]+50
LDY #>VAR_L1[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_62
LDY #>CONST_62
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5190:
;
LDA #<VAR_L1[]+55
LDY #>VAR_L1[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_85
LDY #>CONST_85
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5200:
;
LDA #<VAR_L1[]+60
LDY #>VAR_L1[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_109
LDY #>CONST_109
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5210:
;
LDA #<VAR_L1[]+65
LDY #>VAR_L1[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_66
LDY #>CONST_66
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5220:
;
LDA #<VAR_L1[]+70
LDY #>VAR_L1[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_140
LDY #>CONST_140
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5230:
;
LDA #<VAR_L1[]+75
LDY #>VAR_L1[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_23
LDY #>CONST_23
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5240:
;
LDA #<VAR_L1[]+80
LDY #>VAR_L1[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_121
LDY #>CONST_121
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5250:
;
LDA #<CONST_141R
LDY #>CONST_141R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5260:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT124
LDA #0
JMP GT_SKIP124
GT_GT124:
LDA #$1
GT_SKIP124:
COMP_SKP126:
BNE LINE_NSKIP256
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP256
;
LINE_NSKIP256:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP256:
;
;
LINE_5270:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ125
BEQ LTEQ_LTEQ125
LDA #0
JMP LTEQ_SKIP125
LTEQ_LTEQ125:
LDA #$1
LTEQ_SKIP125:
COMP_SKP127:
BNE LINE_NSKIP257
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP257
;
LINE_NSKIP257:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_64
LDY #>CONST_64
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP257:
;
;
LINE_5280:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #5
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5290:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5300:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ126
ROL
BCC LT_LT126
LT_LT_EQ126:
LDA #0
JMP LT_SKIP126
LT_LT126:
LDA #$1
LT_SKIP126:
COMP_SKP128:
BEQ LINE_SKIP258
; Simplified conditional branch
;
LINE_NSKIP258:
;
LDX #4
dcloop5049_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop5049_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP258:
;
;
LINE_5310:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT127
LDA #0
JMP GT_SKIP127
GT_GT127:
LDA #$1
GT_SKIP127:
COMP_SKP129:
BEQ LINE_SKIP259
; Simplified conditional branch
;
LINE_NSKIP259:
;
LDX #4
dcloop5049_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop5049_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP259:
;
;
LINE_5320:
;
LDA #<CONST_51R
LDY #>CONST_51R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L2[]
LDY #>VAR_L2[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_5330:
;
LDA #0
STA VAR_AC
STA VAR_AC+1
STA VAR_AC+2
STA VAR_AC+3
STA VAR_AC+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_5340:
;
LDA #<VAR_L2[]+5
LDY #>VAR_L2[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_129
LDY #>CONST_129
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5350:
;
LDA #<VAR_L2[]+10
LDY #>VAR_L2[]+10
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_27
LDY #>CONST_27
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5360:
;
LDA #<VAR_L2[]+15
LDY #>VAR_L2[]+15
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_142
LDY #>CONST_142
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5370:
;
LDA #<VAR_L2[]+20
LDY #>VAR_L2[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_143
LDY #>CONST_143
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5380:
;
LDA #<VAR_L2[]+25
LDY #>VAR_L2[]+25
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_144
LDY #>CONST_144
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5390:
;
LDA #<VAR_L2[]+30
LDY #>VAR_L2[]+30
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_117
LDY #>CONST_117
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5400:
;
LDA #<VAR_L2[]+35
LDY #>VAR_L2[]+35
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_145
LDY #>CONST_145
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5410:
;
LDA #<VAR_L2[]+40
LDY #>VAR_L2[]+40
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_29
LDY #>CONST_29
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5420:
;
LDA #<VAR_L2[]+45
LDY #>VAR_L2[]+45
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_146
LDY #>CONST_146
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5430:
;
LDA #<VAR_L2[]+50
LDY #>VAR_L2[]+50
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_145
LDY #>CONST_145
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5440:
;
LDA #<VAR_L2[]+55
LDY #>VAR_L2[]+55
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_94
LDY #>CONST_94
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5450:
;
LDA #<VAR_L2[]+60
LDY #>VAR_L2[]+60
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_147
LDY #>CONST_147
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5460:
;
LDA #<VAR_L2[]+65
LDY #>VAR_L2[]+65
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_50
LDY #>CONST_50
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5470:
;
LDA #<VAR_L2[]+70
LDY #>VAR_L2[]+70
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_148
LDY #>CONST_148
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5480:
;
LDA #<VAR_L2[]+75
LDY #>VAR_L2[]+75
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_149
LDY #>CONST_149
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5490:
;
LDA #<VAR_L2[]+80
LDY #>VAR_L2[]+80
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_26
LDY #>CONST_26
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_AC
LDY #>VAR_AC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5500:
;
LDA #<CONST_150
LDY #>CONST_150
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5510:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT128
LDA #0
JMP GT_SKIP128
GT_GT128:
LDA #$1
GT_SKIP128:
COMP_SKP130:
BNE LINE_NSKIP260
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP260
;
LINE_NSKIP260:
;
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_151
LDY #>CONST_151
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10
LDY #>CONST_10
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
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP260:
;
;
LINE_5520:
;
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ129
BEQ LTEQ_LTEQ129
LDA #0
JMP LTEQ_SKIP129
LTEQ_LTEQ129:
LDA #$1
LTEQ_SKIP129:
COMP_SKP131:
BNE LINE_NSKIP261
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP261
;
LINE_NSKIP261:
;
LDA #<CONST_10
LDY #>CONST_10
JSR REALFAC
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AC
LDY #>VAR_AC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_151
LDY #>CONST_151
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11
LDY #>CONST_11
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP261:
;
;
LINE_5530:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
LDY #7
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_22R
LDY #>CONST_22R
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
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5540:
;
LDA #<CONST_6
LDY #>CONST_6
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AC
LDY #>VAR_AC
; FAC to (X/Y)
JSR FACMEM
;
LINE_5550:
;
LDA #<CONST_13
LDY #>CONST_13
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ130
ROL
BCC LT_LT130
LT_LT_EQ130:
LDA #0
JMP LT_SKIP130
LT_LT130:
LDA #$1
LT_SKIP130:
COMP_SKP132:
BEQ LINE_SKIP262
; Simplified conditional branch
;
LINE_NSKIP262:
;
LDX #4
dcloop5381_1:
LDA CONST_13,X
STA VAR_AC,X
DEX
BPL dcloop5381_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP262:
;
;
LINE_5560:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT131
LDA #0
JMP GT_SKIP131
GT_GT131:
LDA #$1
GT_SKIP131:
COMP_SKP133:
BEQ LINE_SKIP263
; Simplified conditional branch
;
LINE_NSKIP263:
;
LDX #4
dcloop5381_2:
LDA CONST_14R,X
STA VAR_AC,X
DEX
BPL dcloop5381_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP263:
;
;
LINE_5570:
;
LDA #<CONST_22R
LDY #>CONST_22R
JSR REALFAC
LDA #<VAR_AC
LDY #>VAR_AC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_152
LDY #>CONST_152
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_RE
LDY #>VAR_RE
; FAC to (X/Y)
JSR FACMEM
;
LINE_5580:
;
LDA #<VAR_RE
LDY #>VAR_RE
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
JSR TABOUT
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
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
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
ARRAYACCESS_REAL_INT_PRE
LDX G_REG
STX TMP3_ZP
LDX G_REG+1
STX TMP3_ZP+1
JMP COPY2_XY_XREG
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
FLOATINTADD	JSR INTFAC
JSR FACXREG
LDA #0
STA TMP_FLAG	; flag that the value isn't present in TMP2_ZP
LDY TMP3_ZP
LDA TMP3_ZP+1
JSR INTFAC
JSR XREGARG
JMP FASTFADDARG
;###################################
;###################################
INTADDOPT	LDX #0			; Mark as "further int opt possible"
BEQ INTADDADD2
INTADD		LDX #1
INTADDADD2	STX INT_FLAG
LDX #128		; Do the fast way for negative numbers and everything below 16384
STX TMP_REG
BIT TMP_REG
BNE INTINTADD
LDX #64
STX TMP_REG
BIT TMP_REG
BEQ INTINTADD
JMP FLOATINTADD
INTINTADD	LDX #1			; flag that the value is present in TMP2_ZP
STX TMP_FLAG
PHA
TYA
CLC
ADC TMP3_ZP
TAY
PLA
ADC TMP3_ZP+1
STY TMP2_ZP
STA TMP2_ZP+1
LDX INT_FLAG
BNE INTADDEND
RTS
INTADDEND
JMP INTFAC
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
STA VAR_AC,Y
STA VAR_RE,Y
STA VAR_TI,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
STA VAR_A%
STA VAR_A%+1
LDA #<VAR_L1[]
LDY #>VAR_L1[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_L2[]
LDY #>VAR_L2[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: $enter a number:
CONST_0	.BYTE 15
.STRG "enter a number:"
; CONST: #0
CONST_1R
CONST_1	.REAL 0
; CONST: $?redo from start
CONST_2	.BYTE 16
.STRG "?redo from start"
; CONST: $000000
CONST_3	.BYTE 6
.STRG "000000"
; CONST: #0.024574

CONST_4	.REAL 0.024574
; CONST: #128

CONST_5R	.REAL 128.0
; CONST: #0.5

CONST_6	.REAL 0.5
; CONST: #117.0

CONST_7	.REAL 117.0
; CONST: #6

CONST_8R	.REAL 6.0
; CONST: #1169513172

CONST_9	.REAL 1169513172
; CONST: #1.073741824E9

CONST_10	.REAL 1.073741824E9
; CONST: #2.147483648E9

CONST_11	.REAL 2.147483648E9
; CONST: #1

CONST_12R	.REAL 1.0
; CONST: #-128.0

CONST_13	.REAL -128.0
; CONST: #127

CONST_14R	.REAL 127.0
; CONST: #28.0

CONST_15	.REAL 28.0
; CONST: #2935

CONST_16R	.REAL 2935.0
; CONST: #2

CONST_17R	.REAL 2.0
; CONST: #17.0

CONST_18	.REAL 17.0
; CONST: #-2477.0

CONST_19	.REAL -2477.0
; CONST: #3

CONST_20R	.REAL 3.0
; CONST: #-31.0

CONST_21	.REAL -31.0
; CONST: #4

CONST_22R	.REAL 4.0
; CONST: #12.0

CONST_23	.REAL 12.0
; CONST: #3191

CONST_24R	.REAL 3191.0
; CONST: #5

CONST_25R	.REAL 5.0
; CONST: #-127.0

CONST_26	.REAL -127.0
; CONST: #-91.0

CONST_27	.REAL -91.0
; CONST: #7

CONST_28R	.REAL 7.0
; CONST: #66.0

CONST_29	.REAL 66.0
; CONST: #1747

CONST_30R	.REAL 1747.0
; CONST: #8

CONST_31R	.REAL 8.0
; CONST: #-2.0

CONST_32	.REAL -2.0
; CONST: #9

CONST_33R	.REAL 9.0
; CONST: #-43.0

CONST_34	.REAL -43.0
; CONST: #10

CONST_35R	.REAL 10.0
; CONST: #-44.0

CONST_36	.REAL -44.0
; CONST: #8562

CONST_37R	.REAL 8562.0
; CONST: #11

CONST_38R	.REAL 11.0
; CONST: #-78.0

CONST_39	.REAL -78.0
; CONST: #12

CONST_40R	.REAL 12.0
; CONST: #97.0

CONST_41	.REAL 97.0
; CONST: #1839

CONST_42R	.REAL 1839.0
; CONST: #13

CONST_43R	.REAL 13.0
; CONST: #120.0

CONST_44	.REAL 120.0
; CONST: #-2713.0

CONST_45	.REAL -2713.0
; CONST: #14

CONST_46R	.REAL 14.0
; CONST: #25.0

CONST_47	.REAL 25.0
; CONST: #-4044.0

CONST_48	.REAL -4044.0
; CONST: #15

CONST_49R	.REAL 15.0
; CONST: #-33.0

CONST_50	.REAL -33.0
; CONST: #16

CONST_51R	.REAL 16.0
; CONST: #-18.0

CONST_52	.REAL -18.0
; CONST: #-4.0

CONST_53	.REAL -4.0
; CONST: #0.0

CONST_54	.REAL 0.0
; CONST: #-20.0

CONST_55	.REAL -20.0
; CONST: #5.0

CONST_56	.REAL 5.0
; CONST: #23.0

CONST_57	.REAL 23.0
; CONST: #-17.0

CONST_58	.REAL -17.0
; CONST: #-26.0

CONST_59	.REAL -26.0
; CONST: #-8.0

CONST_60	.REAL -8.0
; CONST: #3.0

CONST_61	.REAL 3.0
; CONST: #-6.0

CONST_62	.REAL -6.0
; CONST: #-11.0

CONST_63	.REAL -11.0
; CONST: #1799998806

CONST_64	.REAL 1799998806
; CONST: #-36.0

CONST_65	.REAL -36.0
; CONST: #-21.0

CONST_66	.REAL -21.0
; CONST: #39.0

CONST_67	.REAL 39.0
; CONST: #20.0

CONST_68	.REAL 20.0
; CONST: #-15.0

CONST_69	.REAL -15.0
; CONST: #-34.0

CONST_70	.REAL -34.0
; CONST: #-30.0

CONST_71	.REAL -30.0
; CONST: #-37.0

CONST_72	.REAL -37.0
; CONST: #-16.0

CONST_73	.REAL -16.0
; CONST: #49.0

CONST_74	.REAL 49.0
; CONST: #6.0

CONST_75	.REAL 6.0
; CONST: #-7.0

CONST_76	.REAL -7.0
; CONST: #1205

CONST_77R	.REAL 1205.0
; CONST: #22.0

CONST_78	.REAL 22.0
; CONST: #7.0

CONST_79	.REAL 7.0
; CONST: #-32.0

CONST_80	.REAL -32.0
; CONST: #-1.0

CONST_81	.REAL -1.0
; CONST: #-23.0

CONST_82	.REAL -23.0
; CONST: #-25.0

CONST_83	.REAL -25.0
; CONST: #27.0

CONST_84	.REAL 27.0
; CONST: #24.0

CONST_85	.REAL 24.0
; CONST: #-22.0

CONST_86	.REAL -22.0
; CONST: #-55.0

CONST_87	.REAL -55.0
; CONST: #2680

CONST_88R	.REAL 2680.0
; CONST: #15.0

CONST_89	.REAL 15.0
; CONST: #-38.0

CONST_90	.REAL -38.0
; CONST: #-9.0

CONST_91	.REAL -9.0
; CONST: #14.0

CONST_92	.REAL 14.0
; CONST: #19.0

CONST_93	.REAL 19.0
; CONST: #31.0

CONST_94	.REAL 31.0
; CONST: #-76.0

CONST_95	.REAL -76.0
; CONST: #-3.0

CONST_96	.REAL -3.0
; CONST: #-71.0

CONST_97	.REAL -71.0
; CONST: #1581

CONST_98R	.REAL 1581.0
; CONST: #13.0

CONST_99	.REAL 13.0
; CONST: #38.0

CONST_100	.REAL 38.0
; CONST: #26.0

CONST_101	.REAL 26.0
; CONST: #-28.0

CONST_102	.REAL -28.0
; CONST: #111.0

CONST_103	.REAL 111.0
; CONST: #30.0

CONST_104	.REAL 30.0
; CONST: #53.0

CONST_105	.REAL 53.0
; CONST: #-1935.0

CONST_106	.REAL -1935.0
; CONST: #-13.0

CONST_107	.REAL -13.0
; CONST: #-10.0

CONST_108	.REAL -10.0
; CONST: #-27.0

CONST_109	.REAL -27.0
; CONST: #-106.0

CONST_110	.REAL -106.0
; CONST: #11.0

CONST_111	.REAL 11.0
; CONST: #-51.0

CONST_112	.REAL -51.0
; CONST: #2713

CONST_113R	.REAL 2713.0
; CONST: #-29.0

CONST_114	.REAL -29.0
; CONST: #-19.0

CONST_115	.REAL -19.0
; CONST: #92.0

CONST_116	.REAL 92.0
; CONST: #29.0

CONST_117	.REAL 29.0
; CONST: #91.0

CONST_118	.REAL 91.0
; CONST: #-2050.0

CONST_119	.REAL -2050.0
; CONST: #21.0

CONST_120	.REAL 21.0
; CONST: #-12.0

CONST_121	.REAL -12.0
; CONST: #1295

CONST_122R	.REAL 1295.0
; CONST: #-41.0

CONST_123	.REAL -41.0
; CONST: #-101.0

CONST_124	.REAL -101.0
; CONST: #-24.0

CONST_125	.REAL -24.0
; CONST: #2516

CONST_126R	.REAL 2516.0
; CONST: #-441.0

CONST_127	.REAL -441.0
; CONST: #9.0

CONST_128	.REAL 9.0
; CONST: #33.0

CONST_129	.REAL 33.0
; CONST: #18.0

CONST_130	.REAL 18.0
; CONST: #-14.0

CONST_131	.REAL -14.0
; CONST: #40.0

CONST_132	.REAL 40.0
; CONST: #1206

CONST_133R	.REAL 1206.0
; CONST: #-5.0

CONST_134	.REAL -5.0
; CONST: #54.0

CONST_135	.REAL 54.0
; CONST: #69.0

CONST_136	.REAL 69.0
; CONST: #-2132.0

CONST_137	.REAL -2132.0
; CONST: #59.0

CONST_138	.REAL 59.0
; CONST: #-1717.0

CONST_139	.REAL -1717.0
; CONST: #-53.0

CONST_140	.REAL -53.0
; CONST: #1354

CONST_141R	.REAL 1354.0
; CONST: #-117.0

CONST_142	.REAL -117.0
; CONST: #-54.0

CONST_143	.REAL -54.0
; CONST: #94.0

CONST_144	.REAL 94.0
; CONST: #-50.0

CONST_145	.REAL -50.0
; CONST: #-99.0

CONST_146	.REAL -99.0
; CONST: #-80.0

CONST_147	.REAL -80.0
; CONST: #84.0

CONST_148	.REAL 84.0
; CONST: #47.0

CONST_149	.REAL 47.0
; CONST: #-4212.0

CONST_150	.REAL -4212.0
; CONST: #1623303118

CONST_151	.REAL 1623303118
; CONST: #0.008472

CONST_152	.REAL 0.008472
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: A%
VAR_A%	.WORD 0
; VAR: AC
VAR_AC	.REAL 0.0
; VAR: L1[]
.BYTE 1
.WORD 85
VAR_L1[]	.ARRAY 85
; VAR: L2[]
.BYTE 1
.WORD 85
VAR_L2[]	.ARRAY 85
; VAR: RE
VAR_RE	.REAL 0.0
; VAR: TI
VAR_TI	.REAL 0.0
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
