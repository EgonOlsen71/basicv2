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
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
LDY #15
STY 646
; Optimizer rule: Simple POKE/2
LDY #128
STY 650
; Optimizer rule: Simple POKE/2
;
LINE_10:
;
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<CONST_4
LDY #>CONST_4
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_11:
;
LDY #1
STY 53269
; Optimizer rule: Simple POKE/2
;
LINE_12:
;
LDY #13
STY 2040
; Optimizer rule: Simple POKE/2
LDY #14
STY 53287
; Optimizer rule: Simple POKE/2
LDY #29
STY 56325
; Optimizer rule: Simple POKE/2
;
LINE_20:
;
LDA #0
STA VAR_N
STA VAR_N+1
STA VAR_N+2
STA VAR_N+3
STA VAR_N+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_9R
LDY #>CONST_9R
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
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
JSR READNUMBER
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_Q
LDY #>VAR_Q
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
LDA #<CONST_10R
LDY #>CONST_10R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
JSR FACWORD
STY MOVBSELF9+1
STA MOVBSELF9+2
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFAC
JSR FACWORD
MOVBSELF9:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
LDA #<CONST_11R
LDY #>CONST_11R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
JSR FACWORD
STY MOVBSELF10+1
STA MOVBSELF10+2
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFAC
JSR FACWORD
MOVBSELF10:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
LDA #<CONST_12
LDY #>CONST_12
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
JSR FACWORD
STY MOVBSELF11+1
STA MOVBSELF11+2
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFAC
JSR FACWORD
MOVBSELF11:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
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
LINE_23:
;
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_14
LDY #>CONST_14
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_25:
;
JSR GOSUB
JSR LINE_30000
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_1000
;
LINE_30:
LDX #4
dcloop401_1:
LDA CONST_15R,X
STA VAR_X,X
LDA CONST_16R,X
STA VAR_Y,X
DEX
BPL dcloop401_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
LDY #0
STY 49663
; Optimizer rule: Simple POKE/2
;
LINE_50:
;
LDY #8
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_X
LDY #>VAR_X
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
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XL
LDY #>VAR_XL
; FAC to (X/Y)
JSR FACMEM
;
LINE_52:
;
LDA #<VAR_XL
LDY #>VAR_XL
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 49659
LDA #<VAR_XH
LDY #>VAR_XH
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 49660
LDA #<VAR_Y
LDY #>VAR_Y
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 49661
;
LINE_55:
;
LDA #<49664
STA TMP_ZP
LDA #>49664
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_60:
;
LDY #0
STY 198
; Optimizer rule: Simple POKE/2
LDA #<CONST_19R
LDY #>CONST_19R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_5R
LDY #>CONST_5R
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
COMP_SKP1:
BEQ WAIT1
; Optimizer rule: CMP (REG) = 0(2)/3
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
;
LINE_70:
;
LDA #<CONST_20
LDY #>CONST_20
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP2:
BEQ LINE_SKIP9
; Simplified conditional branch
;
LINE_NSKIP9:
;
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDY #0
STY 53269
; Optimizer rule: Simple POKE/2
LDY #40
STY 56325
; Optimizer rule: Simple POKE/2
JSR END
RTS
;
LINE_SKIP9:
;
;
LINE_80:
;
LDA #<CONST_22
LDY #>CONST_22
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP3:
BEQ LINE_SKIP10
; Simplified conditional branch
;
LINE_NSKIP10:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
JMP LINE_115
;
LINE_SKIP10:
;
;
LINE_90:
;
LDA #<CONST_24
LDY #>CONST_24
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP4:
BEQ LINE_SKIP11
; Simplified conditional branch
;
LINE_NSKIP11:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
JMP LINE_118
;
LINE_SKIP11:
;
;
LINE_100:
;
LDA #<CONST_25
LDY #>CONST_25
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP5:
BEQ LINE_SKIP12
; Simplified conditional branch
;
LINE_NSKIP12:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
JMP LINE_118
;
LINE_SKIP12:
;
;
LINE_110:
;
LDA #<CONST_26
LDY #>CONST_26
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP6:
BEQ LINE_SKIP13
; Simplified conditional branch
;
LINE_NSKIP13:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
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
JMP LINE_115
;
LINE_SKIP13:
;
;
LINE_112:
;
JMP LINE_60
;
LINE_115:
;
LDA #<CONST_27R
LDY #>CONST_27R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ0
ROL
BCC LT_LT0
LT_LT_EQ0:
LDA #0
JMP LT_SKIP0
LT_LT0:
LDA #$1
LT_SKIP0:
COMP_SKP7:
BEQ LINE_SKIP14
; Simplified conditional branch
;
LINE_NSKIP14:
;
LDX #4
dcloop1231_1:
LDA CONST_27R,X
STA VAR_Y,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP14:
;
;
LINE_116:
;
LDA #<CONST_28R
LDY #>CONST_28R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT1
LDA #0
JMP GT_SKIP1
GT_GT1:
LDA #$1
GT_SKIP1:
COMP_SKP8:
BEQ LINE_SKIP15
; Simplified conditional branch
;
LINE_NSKIP15:
;
LDX #4
dcloop1231_2:
LDA CONST_28R,X
STA VAR_Y,X
DEX
BPL dcloop1231_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP15:
;
;
LINE_117:
;
JMP LINE_50
;
LINE_118:
;
LDA #<CONST_29R
LDY #>CONST_29R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
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
COMP_SKP9:
BEQ LINE_SKIP16
; Simplified conditional branch
;
LINE_NSKIP16:
;
LDX #4
dcloop1397_1:
LDA CONST_29R,X
STA VAR_X,X
DEX
BPL dcloop1397_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP16:
;
;
LINE_119:
;
LDA #<CONST_30R
LDY #>CONST_30R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT3
LDA #0
JMP GT_SKIP3
GT_GT3:
LDA #$1
GT_SKIP3:
COMP_SKP10:
BEQ LINE_SKIP17
; Simplified conditional branch
;
LINE_NSKIP17:
;
LDX #4
dcloop1397_2:
LDA CONST_30R,X
STA VAR_X,X
DEX
BPL dcloop1397_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP17:
;
;
LINE_120:
;
JMP LINE_50
;
LINE_200:
;
;
LINE_210:
;
;
LINE_220:
;
;
LINE_230:
;
;
LINE_240:
;
;
LINE_1000:
;
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_1020:
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
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
LDY #5
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
;
LINE_1025:
;
LDA #<VAR_Y
LDY #>VAR_Y
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
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_OF
LDY #>VAR_OF
; FAC to (X/Y)
JSR FACMEM
;
LINE_1030:
;
LDA #<VAR_OF
LDY #>VAR_OF
JSR REALFAC
LDA #<CONST_33R
LDY #>CONST_33R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF19+1
STA MOVBSELF19+2
LDA #$7E
MOVBSELF19:
STA $FFFF
LDA #<VAR_OF
LDY #>VAR_OF
JSR REALFAC
LDA #<CONST_35
LDY #>CONST_35
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF20+1
STA MOVBSELF20+2
LDA #$7
MOVBSELF20:
STA $FFFF
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
LINE_1040:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_38R
LDY #>CONST_38R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Faster RND/4
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
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_39R
LDY #>CONST_39R
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
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
;
LINE_1050:
;
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
LDA #<VAR_Y
LDY #>VAR_Y
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
LDA #<VAR_P
LDY #>VAR_P
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_OF
LDY #>VAR_OF
JSR FACMEM
; Optimizer rule: Omit FAC load/4
LDA #<CONST_33R
LDY #>CONST_33R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF21+1
STA MOVBSELF21+2
LDA #$68
MOVBSELF21:
STA $FFFF
LDA #<VAR_OF
LDY #>VAR_OF
JSR REALFAC
LDA #<CONST_35
LDY #>CONST_35
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF22+1
STA MOVBSELF22+2
LDA #$F
MOVBSELF22:
STA $FFFF
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
;
LINE_1055:
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
LINE_1060:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<VAR_Y
LDY #>VAR_Y
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
LDA #<VAR_P
LDY #>VAR_P
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_OF
LDY #>VAR_OF
JSR FACMEM
; Optimizer rule: Omit FAC load/4
LDA #<CONST_33R
LDY #>CONST_33R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF23+1
STA MOVBSELF23+2
LDA #$68
MOVBSELF23:
STA $FFFF
LDA #<VAR_OF
LDY #>VAR_OF
JSR REALFAC
LDA #<CONST_35
LDY #>CONST_35
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF24+1
STA MOVBSELF24+2
LDA #$F
MOVBSELF24:
STA $FFFF
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
;
LINE_1065:
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
LINE_1070:
;
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
LDA #<VAR_Y
LDY #>VAR_Y
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
LDA #<VAR_P
LDY #>VAR_P
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_OF
LDY #>VAR_OF
JSR FACMEM
; Optimizer rule: Omit FAC load/4
LDA #<CONST_33R
LDY #>CONST_33R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF25+1
STA MOVBSELF25+2
LDA #$68
MOVBSELF25:
STA $FFFF
LDA #<VAR_OF
LDY #>VAR_OF
JSR REALFAC
LDA #<CONST_35
LDY #>CONST_35
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF26+1
STA MOVBSELF26+2
LDA #$F
MOVBSELF26:
STA $FFFF
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
;
LINE_1075:
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
LINE_1080:
;
LDA #<CONST_32R
LDY #>CONST_32R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_32R
LDY #>CONST_32R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<VAR_Y
LDY #>VAR_Y
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
LDA #<VAR_P
LDY #>VAR_P
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_OF
LDY #>VAR_OF
JSR FACMEM
; Optimizer rule: Omit FAC load/4
LDA #<CONST_33R
LDY #>CONST_33R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF27+1
STA MOVBSELF27+2
LDA #$68
MOVBSELF27:
STA $FFFF
LDA #<VAR_OF
LDY #>VAR_OF
JSR REALFAC
LDA #<CONST_35
LDY #>CONST_35
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF28+1
STA MOVBSELF28+2
LDA #$F
MOVBSELF28:
STA $FFFF
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
;
LINE_1100:
;
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
;
LINE_1102:
;
LDA #19
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #17
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #17
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #17
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #17
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #17
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_1104:
;
LDA #29
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #29
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #29
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #29
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_1110:
;
LDA #<CONST_43
LDY #>CONST_43
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1120:
;
JMP RETURN
;
LINE_30000:
;
LDX #4
dcloop2891_1:
LDA CONST_44,X
STA VAR_QQ,X
DEX
BPL dcloop2891_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_45
LDY #>CONST_45
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
LDA #<VAR_QQ
LDY #>VAR_QQ
STA A_REG
STY A_REG+1
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
JSR READNUMBER
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_DQ
LDY #>VAR_DQ
JSR FACMEM
JSR FACXREG
LDA #<VAR_QQ
LDY #>VAR_QQ
JSR REALFAC
LDX #<X_REG
; Optimizer rule: Move variable directly in XREG/9
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF29+1
STA MOVBSELF29+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF29:
STY $FFFF
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
LINE_30001:
;
JMP RETURN
;
LINE_30002:
;
;
LINE_30003:
;
;
LINE_30004:
;
;
LINE_30005:
;
;
LINE_30006:
;
;
LINE_30007:
;
;
LINE_30008:
;
;
LINE_30009:
;
;
LINE_30010:
;
;
LINE_30011:
;
;
LINE_30012:
;
;
LINE_30013:
;
;
LINE_30014:
;
;
LINE_30015:
;
;
LINE_30016:
;
;
LINE_30017:
;
;
LINE_30018:
;
;
LINE_30019:
;
;
LINE_30020:
;
;
LINE_30021:
;
;
LINE_30022:
;
;
LINE_30023:
;
;
LINE_30024:
;
;
LINE_30025:
;
;
LINE_30026:
;
;
LINE_30027:
;
;
LINE_30028:
;
;
LINE_30029:
;
;
LINE_30030:
;
;
LINE_30031:
;
;
LINE_30032:
;
;
LINE_30033:
;
;
LINE_30034:
;
;
LINE_30035:
;
;
LINE_30036:
;
;
LINE_30037:
;
;
LINE_30038:
;
;
LINE_30039:
;
;
LINE_30040:
;
;
LINE_30041:
;
;
LINE_30042:
;
;
LINE_30043:
;
;
LINE_30044:
;
;
LINE_30045:
;
;
LINE_30046:
;
;
LINE_30047:
;
;
LINE_30048:
;
;
LINE_30049:
;
;
LINE_30050:
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
STA VAR_N,Y
STA VAR_Q,Y
STA VAR_X,Y
STA VAR_Y,Y
STA VAR_XH,Y
STA VAR_XL,Y
STA VAR_I,Y
STA VAR_OF,Y
STA VAR_P,Y
STA VAR_QQ,Y
STA VAR_DQ,Y
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

CONST_0R	.REAL 0.0
; CONST: #15


; CONST: #128


; CONST: #147


; CONST: $initializing sprites...
CONST_4	.BYTE 23
.STRG "initializing sprites..."
; CONST: #1

CONST_5R	.REAL 1.0
; CONST: #13


; CONST: #14


; CONST: #29


; CONST: #62

CONST_9R	.REAL 62.0
; CONST: #832

CONST_10R	.REAL 832.0
; CONST: #896

CONST_11R	.REAL 896.0
; CONST: #49152

CONST_12	.REAL 49152
; CONST: $done
CONST_13	.BYTE 4
.STRG "done"
; CONST: $initializing machine code...
CONST_14	.BYTE 28
.STRG "initializing machine code..."
; CONST: #150

CONST_15R	.REAL 150.0
; CONST: #80

CONST_16R	.REAL 80.0
; CONST: #8


; CONST: #255

CONST_18R	.REAL 255.0
; CONST: #198

CONST_19R	.REAL 198.0
; CONST: $x
CONST_20	.BYTE 1
.STRG "x"
; CONST: #40


; CONST: $w
CONST_22	.BYTE 1
.STRG "w"
; CONST: #3

CONST_23R	.REAL 3.0
; CONST: $a
CONST_24	.BYTE 1
.STRG "a"
; CONST: $d
CONST_25	.BYTE 1
.STRG "d"
; CONST: $s
CONST_26	.BYTE 1
.STRG "s"
; CONST: #50

CONST_27R	.REAL 50.0
; CONST: #250

CONST_28R	.REAL 250.0
; CONST: #24

CONST_29R	.REAL 24.0
; CONST: #320

CONST_30R	.REAL 320.0
; CONST: #5


; CONST: #4

CONST_32R	.REAL 4.0
; CONST: #1024

CONST_33R	.REAL 1024.0
; CONST: #126


; CONST: #55296

CONST_35	.REAL 55296
; CONST: #7


; CONST: #6

CONST_37R	.REAL 6.0
; CONST: #22

CONST_38R	.REAL 22.0
; CONST: #2

CONST_39R	.REAL 2.0
; CONST: #104


; CONST: #19


; CONST: #17


; CONST: $** use wasd to move, x to exit **
CONST_43	.BYTE 33
.STRG "** use wasd to move, x to exit **"
; CONST: #49664

CONST_44	.REAL 49664
; CONST: #50535

CONST_45	.REAL 50535
;###############################
; ******** DATA ********
DATAS
.BYTE 3
.BYTE 0
.BYTE 127
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 1
.BYTE 3
.BYTE 255
.BYTE 192
.BYTE 3
.BYTE 3
.BYTE 3
.BYTE 255
.BYTE 224
.BYTE 3
.BYTE 3
.BYTE 231
.BYTE 224
.BYTE 7
.BYTE 217
.BYTE 240
.BYTE 7
.BYTE 223
.BYTE 240
.BYTE 7
.BYTE 217
.BYTE 240
.BYTE 3
.BYTE 3
.BYTE 231
.BYTE 224
.BYTE 3
.BYTE 3
.BYTE 3
.BYTE 255
.BYTE 224
.BYTE 3
.BYTE 3
.BYTE 3
.BYTE 255
.BYTE 224
.BYTE 3
.BYTE 2
.BYTE 3
.BYTE 255
.BYTE 160
.BYTE 3
.BYTE 1
.BYTE 127
.BYTE 64
.BYTE 3
.BYTE 1
.BYTE 62
.BYTE 64
.BYTE 3
.BYTE 0
.BYTE 156
.BYTE 128
.BYTE 3
.BYTE 0
.BYTE 156
.BYTE 128
.BYTE 3
.BYTE 0
.BYTE 73
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 73
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 62
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 62
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 62
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 28
.BYTE 3
.BYTE 0
.BYTE 32
.BYTE 46
.BYTE 197
.BYTE 169
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 62
.BYTE 197
.BYTE 141
.BYTE 63
.BYTE 197
.BYTE 141
.BYTE 64
.BYTE 197
.BYTE 141
.BYTE 67
.BYTE 197
.BYTE 141
.BYTE 68
.BYTE 197
.BYTE 141
.BYTE 69
.BYTE 197
.BYTE 141
.BYTE 71
.BYTE 197
.BYTE 141
.BYTE 76
.BYTE 197
.BYTE 141
.BYTE 75
.BYTE 197
.BYTE 141
.BYTE 66
.BYTE 197
.BYTE 141
.BYTE 65
.BYTE 197
.BYTE 173
.BYTE 251
.BYTE 193
.BYTE 141
.BYTE 83
.BYTE 197
.BYTE 173
.BYTE 252
.BYTE 193
.BYTE 141
.BYTE 84
.BYTE 197
.BYTE 173
.BYTE 253
.BYTE 193
.BYTE 141
.BYTE 85
.BYTE 197
.BYTE 169
.BYTE 208
.BYTE 141
.BYTE 72
.BYTE 197
.BYTE 173
.BYTE 24
.BYTE 208
.BYTE 41
.BYTE 6
.BYTE 201
.BYTE 6
.BYTE 208
.BYTE 9
.BYTE 173
.BYTE 72
.BYTE 197
.BYTE 24
.BYTE 105
.BYTE 8
.BYTE 141
.BYTE 72
.BYTE 197
.BYTE 32
.BYTE 104
.BYTE 196
.BYTE 169
.BYTE 64
.BYTE 141
.BYTE 79
.BYTE 197
.BYTE 238
.BYTE 103
.BYTE 197
.BYTE 173
.BYTE 103
.BYTE 197
.BYTE 201
.BYTE 15
.BYTE 208
.BYTE 5
.BYTE 169
.BYTE 13
.BYTE 141
.BYTE 103
.BYTE 197
.BYTE 141
.BYTE 81
.BYTE 197
.BYTE 32
.BYTE 7
.BYTE 197
.BYTE 173
.BYTE 79
.BYTE 197
.BYTE 141
.BYTE 77
.BYTE 197
.BYTE 173
.BYTE 80
.BYTE 197
.BYTE 141
.BYTE 78
.BYTE 197
.BYTE 169
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 62
.BYTE 197
.BYTE 141
.BYTE 63
.BYTE 197
.BYTE 141
.BYTE 66
.BYTE 197
.BYTE 141
.BYTE 65
.BYTE 197
.BYTE 32
.BYTE 84
.BYTE 196
.BYTE 174
.BYTE 62
.BYTE 197
.BYTE 189
.BYTE 3
.BYTE 0
.BYTE 192
.BYTE 240
.BYTE 66
.BYTE 141
.BYTE 67
.BYTE 197
.BYTE 32
.BYTE 183
.BYTE 195
.BYTE 174
.BYTE 76
.BYTE 197
.BYTE 240
.BYTE 6
.BYTE 14
.BYTE 64
.BYTE 197
.BYTE 202
.BYTE 208
.BYTE 250
.BYTE 169
.BYTE 3
.BYTE 255
.BYTE 77
.BYTE 64
.BYTE 197
.BYTE 45
.BYTE 67
.BYTE 197
.BYTE 141
.BYTE 67
.BYTE 197
.BYTE 173
.BYTE 76
.BYTE 197
.BYTE 240
.BYTE 12
.BYTE 173
.BYTE 63
.BYTE 197
.BYTE 41
.BYTE 3
.BYTE 3
.BYTE 201
.BYTE 3
.BYTE 3
.BYTE 240
.BYTE 3
.BYTE 3
.BYTE 32
.BYTE 239
.BYTE 195
.BYTE 173
.BYTE 77
.BYTE 197
.BYTE 24
.BYTE 109
.BYTE 62
.BYTE 197
.BYTE 133
.BYTE 34
.BYTE 173
.BYTE 78
.BYTE 197
.BYTE 105
.BYTE 3
.BYTE 0
.BYTE 133
.BYTE 35
.BYTE 173
.BYTE 67
.BYTE 197
.BYTE 145
.BYTE 34
.BYTE 174
.BYTE 62
.BYTE 197
.BYTE 232
.BYTE 232
.BYTE 232
.BYTE 142
.BYTE 62
.BYTE 197
.BYTE 238
.BYTE 75
.BYTE 197
.BYTE 238
.BYTE 65
.BYTE 197
.BYTE 173
.BYTE 75
.BYTE 197
.BYTE 201
.BYTE 8
.BYTE 176
.BYTE 14
.BYTE 173
.BYTE 65
.BYTE 197
.BYTE 201
.BYTE 8
.BYTE 176
.BYTE 7
.BYTE 224
.BYTE 63
.BYTE 176
.BYTE 3
.BYTE 3
.BYTE 76
.BYTE 137
.BYTE 194
.BYTE 224
.BYTE 65
.BYTE 144
.BYTE 3
.BYTE 3
.BYTE 76
.BYTE 126
.BYTE 195
.BYTE 173
.BYTE 75
.BYTE 197
.BYTE 201
.BYTE 8
.BYTE 208
.BYTE 18
.BYTE 173
.BYTE 66
.BYTE 197
.BYTE 208
.BYTE 13
.BYTE 173
.BYTE 65
.BYTE 197
.BYTE 201
.BYTE 8
.BYTE 176
.BYTE 6
.BYTE 32
.BYTE 207
.BYTE 195
.BYTE 76
.BYTE 137
.BYTE 194
.BYTE 173
.BYTE 66
.BYTE 197
.BYTE 240
.BYTE 14
.BYTE 173
.BYTE 253
.BYTE 193
.BYTE 56
.BYTE 233
.BYTE 8
.BYTE 141
.BYTE 253
.BYTE 193
.BYTE 169
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 66
.BYTE 197
.BYTE 173
.BYTE 251
.BYTE 193
.BYTE 24
.BYTE 105
.BYTE 8
.BYTE 141
.BYTE 251
.BYTE 193
.BYTE 173
.BYTE 252
.BYTE 193
.BYTE 105
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 252
.BYTE 193
.BYTE 238
.BYTE 63
.BYTE 197
.BYTE 173
.BYTE 63
.BYTE 197
.BYTE 41
.BYTE 3
.BYTE 3
.BYTE 201
.BYTE 3
.BYTE 3
.BYTE 208
.BYTE 35
.BYTE 173
.BYTE 63
.BYTE 197
.BYTE 24
.BYTE 105
.BYTE 21
.BYTE 141
.BYTE 63
.BYTE 197
.BYTE 173
.BYTE 251
.BYTE 193
.BYTE 56
.BYTE 233
.BYTE 24
.BYTE 141
.BYTE 251
.BYTE 193
.BYTE 173
.BYTE 252
.BYTE 193
.BYTE 233
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 252
.BYTE 193
.BYTE 173
.BYTE 253
.BYTE 193
.BYTE 24
.BYTE 105
.BYTE 8
.BYTE 141
.BYTE 253
.BYTE 193
.BYTE 173
.BYTE 63
.BYTE 197
.BYTE 141
.BYTE 62
.BYTE 197
.BYTE 32
.BYTE 84
.BYTE 196
.BYTE 32
.BYTE 104
.BYTE 196
.BYTE 169
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 65
.BYTE 197
.BYTE 76
.BYTE 137
.BYTE 194
.BYTE 32
.BYTE 54
.BYTE 197
.BYTE 173
.BYTE 3
.BYTE 255
.BYTE 193
.BYTE 168
.BYTE 10
.BYTE 170
.BYTE 173
.BYTE 83
.BYTE 197
.BYTE 157
.BYTE 3
.BYTE 0
.BYTE 208
.BYTE 232
.BYTE 173
.BYTE 85
.BYTE 197
.BYTE 157
.BYTE 3
.BYTE 0
.BYTE 208
.BYTE 185
.BYTE 95
.BYTE 197
.BYTE 174
.BYTE 84
.BYTE 197
.BYTE 240
.BYTE 9
.BYTE 13
.BYTE 16
.BYTE 208
.BYTE 141
.BYTE 16
.BYTE 208
.BYTE 76
.BYTE 173
.BYTE 195
.BYTE 73
.BYTE 3
.BYTE 255
.BYTE 45
.BYTE 16
.BYTE 208
.BYTE 141
.BYTE 16
.BYTE 208
.BYTE 173
.BYTE 103
.BYTE 197
.BYTE 174
.BYTE 3
.BYTE 255
.BYTE 193
.BYTE 157
.BYTE 248
.BYTE 7
.BYTE 96
.BYTE 173
.BYTE 73
.BYTE 197
.BYTE 24
.BYTE 109
.BYTE 75
.BYTE 197
.BYTE 133
.BYTE 34
.BYTE 173
.BYTE 74
.BYTE 197
.BYTE 105
.BYTE 3
.BYTE 0
.BYTE 133
.BYTE 35
.BYTE 160
.BYTE 3
.BYTE 0
.BYTE 177
.BYTE 34
.BYTE 141
.BYTE 64
.BYTE 197
.BYTE 96
.BYTE 169
.BYTE 7
.BYTE 56
.BYTE 237
.BYTE 75
.BYTE 197
.BYTE 141
.BYTE 65
.BYTE 197
.BYTE 169
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 75
.BYTE 197
.BYTE 173
.BYTE 253
.BYTE 193
.BYTE 24
.BYTE 105
.BYTE 8
.BYTE 141
.BYTE 253
.BYTE 193
.BYTE 32
.BYTE 104
.BYTE 196
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 141
.BYTE 66
.BYTE 197
.BYTE 96
.BYTE 173
.BYTE 68
.BYTE 197
.BYTE 201
.BYTE 39
.BYTE 144
.BYTE 3
.BYTE 1
.BYTE 96
.BYTE 173
.BYTE 251
.BYTE 193
.BYTE 24
.BYTE 105
.BYTE 8
.BYTE 141
.BYTE 251
.BYTE 193
.BYTE 173
.BYTE 252
.BYTE 193
.BYTE 105
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 252
.BYTE 193
.BYTE 32
.BYTE 104
.BYTE 196
.BYTE 32
.BYTE 183
.BYTE 195
.BYTE 169
.BYTE 8
.BYTE 56
.BYTE 237
.BYTE 76
.BYTE 197
.BYTE 170
.BYTE 240
.BYTE 6
.BYTE 78
.BYTE 64
.BYTE 197
.BYTE 202
.BYTE 208
.BYTE 250
.BYTE 174
.BYTE 76
.BYTE 197
.BYTE 189
.BYTE 86
.BYTE 197
.BYTE 141
.BYTE 70
.BYTE 197
.BYTE 169
.BYTE 3
.BYTE 255
.BYTE 77
.BYTE 64
.BYTE 197
.BYTE 141
.BYTE 79
.BYTE 197
.BYTE 169
.BYTE 3
.BYTE 255
.BYTE 77
.BYTE 70
.BYTE 197
.BYTE 45
.BYTE 79
.BYTE 197
.BYTE 13
.BYTE 70
.BYTE 197
.BYTE 45
.BYTE 67
.BYTE 197
.BYTE 141
.BYTE 67
.BYTE 197
.BYTE 173
.BYTE 251
.BYTE 193
.BYTE 56
.BYTE 233
.BYTE 8
.BYTE 141
.BYTE 251
.BYTE 193
.BYTE 173
.BYTE 252
.BYTE 193
.BYTE 233
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 252
.BYTE 193
.BYTE 32
.BYTE 104
.BYTE 196
.BYTE 96
.BYTE 173
.BYTE 253
.BYTE 193
.BYTE 56
.BYTE 233
.BYTE 50
.BYTE 41
.BYTE 7
.BYTE 141
.BYTE 75
.BYTE 197
.BYTE 173
.BYTE 251
.BYTE 193
.BYTE 41
.BYTE 7
.BYTE 141
.BYTE 76
.BYTE 197
.BYTE 96
.BYTE 173
.BYTE 251
.BYTE 193
.BYTE 56
.BYTE 233
.BYTE 24
.BYTE 141
.BYTE 79
.BYTE 197
.BYTE 173
.BYTE 252
.BYTE 193
.BYTE 233
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 80
.BYTE 197
.BYTE 32
.BYTE 225
.BYTE 196
.BYTE 173
.BYTE 79
.BYTE 197
.BYTE 141
.BYTE 68
.BYTE 197
.BYTE 173
.BYTE 253
.BYTE 193
.BYTE 56
.BYTE 233
.BYTE 50
.BYTE 74
.BYTE 74
.BYTE 74
.BYTE 141
.BYTE 69
.BYTE 197
.BYTE 141
.BYTE 81
.BYTE 197
.BYTE 169
.BYTE 40
.BYTE 141
.BYTE 79
.BYTE 197
.BYTE 32
.BYTE 7
.BYTE 197
.BYTE 173
.BYTE 79
.BYTE 197
.BYTE 24
.BYTE 109
.BYTE 68
.BYTE 197
.BYTE 141
.BYTE 79
.BYTE 197
.BYTE 173
.BYTE 80
.BYTE 197
.BYTE 105
.BYTE 3
.BYTE 0
.BYTE 141
.BYTE 80
.BYTE 197
.BYTE 173
.BYTE 79
.BYTE 197
.BYTE 24
.BYTE 105
.BYTE 3
.BYTE 0
.BYTE 133
.BYTE 34
.BYTE 173
.BYTE 80
.BYTE 197
.BYTE 105
.BYTE 4
.BYTE 133
.BYTE 35
.BYTE 160
.BYTE 3
.BYTE 0
.BYTE 140
.BYTE 80
.BYTE 197
.BYTE 177
.BYTE 34
.BYTE 201
.BYTE 126
.BYTE 208
.BYTE 3
.BYTE 2
.BYTE 169
.BYTE 32
.BYTE 141
.BYTE 79
.BYTE 197
.BYTE 32
.BYTE 244
.BYTE 196
.BYTE 173
.BYTE 79
.BYTE 197
.BYTE 24
.BYTE 109
.BYTE 71
.BYTE 197
.BYTE 141
.BYTE 73
.BYTE 197
.BYTE 173
.BYTE 80
.BYTE 197
.BYTE 109
.BYTE 72
.BYTE 197
.BYTE 141
.BYTE 74
.BYTE 197
.BYTE 96
.BYTE 78
.BYTE 80
.BYTE 197
.BYTE 110
.BYTE 79
.BYTE 197
.BYTE 78
.BYTE 80
.BYTE 197
.BYTE 110
.BYTE 79
.BYTE 197
.BYTE 78
.BYTE 80
.BYTE 197
.BYTE 110
.BYTE 79
.BYTE 197
.BYTE 96
.BYTE 14
.BYTE 79
.BYTE 197
.BYTE 46
.BYTE 80
.BYTE 197
.BYTE 14
.BYTE 79
.BYTE 197
.BYTE 46
.BYTE 80
.BYTE 197
.BYTE 14
.BYTE 79
.BYTE 197
.BYTE 46
.BYTE 80
.BYTE 197
.BYTE 96
.BYTE 169
.BYTE 3
.BYTE 0
.BYTE 168
.BYTE 140
.BYTE 80
.BYTE 197
.BYTE 240
.BYTE 17
.BYTE 24
.BYTE 109
.BYTE 79
.BYTE 197
.BYTE 170
.BYTE 152
.BYTE 109
.BYTE 80
.BYTE 197
.BYTE 168
.BYTE 138
.BYTE 14
.BYTE 79
.BYTE 197
.BYTE 46
.BYTE 80
.BYTE 197
.BYTE 78
.BYTE 81
.BYTE 197
.BYTE 176
.BYTE 234
.BYTE 208
.BYTE 243
.BYTE 141
.BYTE 79
.BYTE 197
.BYTE 140
.BYTE 80
.BYTE 197
.BYTE 96
.BYTE 120
.BYTE 165
.BYTE 3
.BYTE 1
.BYTE 41
.BYTE 251
.BYTE 133
.BYTE 3
.BYTE 1
.BYTE 96
.BYTE 165
.BYTE 3
.BYTE 1
.BYTE 9
.BYTE 4
.BYTE 133
.BYTE 3
.BYTE 1
.BYTE 88
.BYTE 96
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 208
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 255
.BYTE 254
.BYTE 252
.BYTE 248
.BYTE 240
.BYTE 224
.BYTE 192
.BYTE 128
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 1
.BYTE 3
.BYTE 2
.BYTE 4
.BYTE 8
.BYTE 16
.BYTE 32
.BYTE 64
.BYTE 128
.BYTE 13
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: N
VAR_N	.REAL 0.0
; VAR: Q
VAR_Q	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: XH
VAR_XH	.REAL 0.0
; VAR: XL
VAR_XL	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: OF
VAR_OF	.REAL 0.0
; VAR: P
VAR_P	.REAL 0.0
; VAR: QQ
VAR_QQ	.REAL 0.0
; VAR: DQ
VAR_DQ	.REAL 0.0
STRINGVARS_START
; VAR: A$
VAR_A$	.WORD EMPTYSTR
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
