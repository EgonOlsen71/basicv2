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
LDA #147
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_102:
;
LDY #16
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_104:
;
;
LINE_105:
;
LDY #45
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_LD%
STA VAR_LD%+1
;
LINE_108:
;
;
LINE_109:
;
;
LINE_110:
;
LDY #102
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_FA%
STA VAR_FA%+1
;
LINE_111:
;
LDY #32
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_AI%
STA VAR_AI%+1
;
LINE_117:
;
;
LINE_122:
;
;
LINE_130:
;
;
LINE_134:
;
;
LINE_136:
;
LDY #27
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_TX%
STA VAR_TX%+1
LDY #23
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_TY%
STA VAR_TY%+1
;
LINE_146:
;
LDY #0
TYA
STY VAR_T1%
STA VAR_T1%+1
STY VAR_T2%
STA VAR_T2%+1
; Optimizer rule: Accumulate integer loads/6
;
LINE_156:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_XS%
STA VAR_XS%+1
LDY #3
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_YS%
STA VAR_YS%+1
;
LINE_166:
;
LDY #0
TYA
STY VAR_S1%
STA VAR_S1%+1
STY VAR_S2%
STA VAR_S2%+1
; Optimizer rule: Accumulate integer loads/6
;
LINE_176:
;
LDY #80
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_LK%
STA VAR_LK%+1
;
LINE_186:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_LT%
STA VAR_LT%+1
;
LINE_600:
;
;
LINE_601:
;
;
LINE_602:
;
LDX #4
dcloop401_1:
LDA CONST_10,X
STA VAR_N,X
DEX
BPL dcloop401_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_11
LDY #>CONST_11
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
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
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF2+1
STA MOVBSELF2+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF2:
STY $FFFF
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_0
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_0:
;
LINE_909:
;
;
LINE_910:
;
LDX #4
dcloop401_2:
LDA CONST_12R,X
STA VAR_I,X
DEX
BPL dcloop401_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_13R
LDY #>CONST_13R
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
LDA #<FORLOOP1
STA JUMP_TARGET
LDA #>FORLOOP1
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP1:
JSR READMAYBEBYTE
; Optimizer rule: Improved READ for bytes/1
STY VAR_A%
STA VAR_A%+1
JSR READMAYBEBYTE
; Optimizer rule: Improved READ for bytes/1
STY VAR_B%
STA VAR_B%+1
LDY VAR_A%
LDA VAR_A%+1
; integer in Y/A to FAC
STY MOVBSELF3+1
STA MOVBSELF3+2
; Faster POKE of integers
;
;
;
;
LDY VAR_B%
MOVBSELF3:
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
LINE_920:
;
;
LINE_930:
;
;
LINE_935:
;
;
LINE_950:
;
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
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
LDA #<VAR_J
LDY #>VAR_J
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR READNUMBER
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_LP%[]
LDY #>VAR_LP%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
;
LINE_955:
;
LDA #<VAR_J
LDY #>VAR_J
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_LP%[]
LDY #>VAR_LP%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_FK
LDY #>VAR_FK
; FAC to (X/Y)
JSR FACMEM
;
LINE_960:
;
LDA #0
STA VAR_K
STA VAR_K+1
STA VAR_K+2
STA VAR_K+3
STA VAR_K+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_15R
LDY #>CONST_15R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_K
LDY #>VAR_K
STA A_REG
STY A_REG+1
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
;
LINE_980:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_FK
LDY #>VAR_FK
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_FK
LDY #>VAR_FK
; FAC to (X/Y)
JSR FACMEM
;
LINE_990:
;
LDA #<VAR_FK
LDY #>VAR_FK
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF4+1
STA MOVBSELF4+2
LDA #$2D
MOVBSELF4:
STA $FFFF
;
LINE_995:
;
LDA #<VAR_K
LDY #>VAR_K
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_2
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_2:
;
LINE_999:
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
LINE_1000:
;
JSR GOSUB
JSR LINE_2770
;
LINE_1002:
;
;
LINE_1004:
;
;
LINE_1080:
;
LDY VAR_TY%
LDA VAR_TY%+1
; integer in Y/A to FAC
JSR INTFAC
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
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_TX%
LDA VAR_TX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF5+1
STA MOVBSELF5+2
LDA #$51
MOVBSELF5:
STA $FFFF
;
LINE_1500:
;
LDA #0
STA VAR_L
STA VAR_L+1
STA VAR_L+2
STA VAR_L+3
STA VAR_L+4
; Optimizer rule: Simplified setting to 0/6
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_L
LDY #>VAR_L
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
LDX #4
dcloop733_1:
LDA CONST_19,X
STA VAR_L,X
DEX
BPL dcloop733_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1505:
;
JSR GOSUB
JSR LINE_2300
;
LINE_1510:
;
JSR GOSUB
JSR LINE_2630
;
LINE_1550:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_K$
LDY #>VAR_K$
JSR COPYSTRING
;
LINE_1552:
;
LDA #0
STA VAR_UP
STA VAR_UP+1
STA VAR_UP+2
STA VAR_UP+3
STA VAR_UP+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DN
STA VAR_DN+1
STA VAR_DN+2
STA VAR_DN+3
STA VAR_DN+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_RT
STA VAR_RT+1
STA VAR_RT+2
STA VAR_RT+3
STA VAR_RT+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_LT
STA VAR_LT+1
STA VAR_LT+2
STA VAR_LT+3
STA VAR_LT+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1553:
;
LDA #<CONST_20
LDY #>CONST_20
STA B_REG
STY B_REG+1
LDA VAR_K$
LDY VAR_K$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP4:
BEQ LINE_SKIP22
; Simplified conditional branch
;
LINE_NSKIP22:
;
JMP LINE_2070
;
LINE_SKIP22:
;
;
LINE_1555:
;
JSR COMPACTMAX
LDA #145
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_K$
LDY VAR_K$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP5:
BEQ LINE_SKIP23
; Simplified conditional branch
;
LINE_NSKIP23:
;
LDX #4
dcloop899_1:
LDA CONST_19,X
STA VAR_UP,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP23:
;
;
LINE_1556:
;
JSR COMPACTMAX
LDA #17
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_K$
LDY VAR_K$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP6:
BEQ LINE_SKIP24
; Simplified conditional branch
;
LINE_NSKIP24:
;
LDX #4
dcloop1065_1:
LDA CONST_19,X
STA VAR_DN,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP24:
;
;
LINE_1558:
;
JSR COMPACTMAX
LDA #29
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_K$
LDY VAR_K$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP7:
BEQ LINE_SKIP25
; Simplified conditional branch
;
LINE_NSKIP25:
;
LDX #4
dcloop1065_2:
LDA CONST_19,X
STA VAR_RT,X
DEX
BPL dcloop1065_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP25:
;
;
LINE_1560:
;
JSR COMPACTMAX
LDA #157
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_K$
LDY VAR_K$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP8:
BEQ LINE_SKIP26
; Simplified conditional branch
;
LINE_NSKIP26:
;
LDX #4
dcloop1065_3:
LDA CONST_19,X
STA VAR_LT,X
DEX
BPL dcloop1065_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP26:
;
;
LINE_1565:
;
JSR GOSUB
JSR LINE_2125
;
LINE_1570:
;
JSR GOSUB
JSR LINE_2695
;
LINE_2070:
;
LDA #<VAR_L
LDY #>VAR_L
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_4
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_4:
;
LINE_2110:
;
;
LINE_2120:
;
;
LINE_2125:
;
LDY #0
TYA
STY VAR_T1%
STA VAR_T1%+1
STY VAR_T2%
STA VAR_T2%+1
; Optimizer rule: Accumulate integer loads/6
;
LINE_2140:
;
LDA #<VAR_AR%[]+0
LDY #>VAR_AR%[]+0
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_INTEGER_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ0
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP0
EQ_EQ0:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP0:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_UP
LDY #>VAR_UP
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
LDA X_REG
COMP_SKP10:
BEQ LINE_SKIP27
; Simplified conditional branch
;
LINE_NSKIP27:
;
LDY #255
LDA #255
STY VAR_T2%
STA VAR_T2%+1
; Optimized code for negative constants)
;
;
;
JMP LINE_2210
;
LINE_SKIP27:
;
;
LINE_2155:
;
LDA #<VAR_AR%[]+2
LDY #>VAR_AR%[]+2
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_INTEGER_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_DN
LDY #>VAR_DN
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
LDA X_REG
COMP_SKP11:
BEQ LINE_SKIP28
; Simplified conditional branch
;
LINE_NSKIP28:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_T2%
STA VAR_T2%+1
JMP LINE_2210
;
LINE_SKIP28:
;
;
LINE_2170:
;
LDA VAR_RT
COMP_SKP12:
BEQ LINE_SKIP29
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP29:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_T1%
STA VAR_T1%+1
JMP LINE_2210
;
LINE_SKIP29:
;
;
LINE_2190:
;
LDA VAR_LT
COMP_SKP13:
BEQ LINE_SKIP30
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP30:
;
LDY #255
LDA #255
STY VAR_T1%
STA VAR_T1%+1
; Optimized code for negative constants)
;
;
;
;
LINE_SKIP30:
;
;
LINE_2210:
;
JMP RETURN
;
LINE_2215:
;
;
LINE_2225:
;
;
LINE_2240:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDY VAR_TY%
LDA VAR_TY%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR FDEX
LDY #5
LDA #0
STY A_REG
STA A_REG+1
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
JSR XREGFAC
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
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_TX%
LDA VAR_TX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF6+1
STA MOVBSELF6+2
MOVBSELF6:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_AR%[]
LDY #>VAR_AR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
;
LINE_2245:
;
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDY VAR_TY%
LDA VAR_TY%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR FINX
LDY #5
LDA #0
STY A_REG
STA A_REG+1
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
JSR XREGFAC
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
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_TX%
LDA VAR_TX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF7+1
STA MOVBSELF7+2
MOVBSELF7:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_AR%[]
LDY #>VAR_AR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
;
LINE_2250:
;
;
LINE_2260:
;
;
LINE_2261:
;
JMP RETURN
;
LINE_2262:
;
;
LINE_2264:
;
;
LINE_2265:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDY VAR_YS%
LDA VAR_YS%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR FDEX
LDY #5
LDA #0
STY A_REG
STA A_REG+1
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
JSR XREGFAC
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
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_XS%
LDA VAR_XS%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF8+1
STA MOVBSELF8+2
MOVBSELF8:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_S3[]
LDY #>VAR_S3[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_2266:
;
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDY VAR_YS%
LDA VAR_YS%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR FINX
LDY #5
LDA #0
STY A_REG
STA A_REG+1
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
JSR XREGFAC
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
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_XS%
LDA VAR_XS%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF9+1
STA MOVBSELF9+2
MOVBSELF9:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_S3[]
LDY #>VAR_S3[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_2267:
;
LDA #<VAR_S3[]+0
LDY #>VAR_S3[]+0
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ2
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP2
EQ_EQ2:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP2:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_FL
LDY #>VAR_FL
; FAC to (X/Y)
JSR FACMEM
;
LINE_2268:
;
LDA #<VAR_S3[]+5
LDY #>VAR_S3[]+5
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AL
LDY #>VAR_AL
; FAC to (X/Y)
JSR FACMEM
;
LINE_2270:
;
JMP RETURN
;
LINE_2280:
;
;
LINE_2290:
;
;
LINE_2300:
;
LDY #0
TYA
STY VAR_S1%
STA VAR_S1%+1
STY VAR_S2%
STA VAR_S2%+1
; Optimizer rule: Accumulate integer loads/6
LDY #0
TYA
STY VAR_LJ%
STA VAR_LJ%+1
STY VAR_LB%
STA VAR_LB%+1
; Optimizer rule: Accumulate integer loads/6
LDY #80
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_LK%
STA VAR_LK%+1
LDA #0
STA VAR_J
STA VAR_J+1
STA VAR_J+2
STA VAR_J+3
STA VAR_J+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_B
STA VAR_B+1
STA VAR_B+2
STA VAR_B+3
STA VAR_B+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2310:
;
LDY VAR_XS%
LDA VAR_XS%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_TX%
LDA VAR_TX%+1
JSR ICMP
; Optimized code for Integer(1)
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
BEQ EQ_EQ4
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP4
EQ_EQ4:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP4:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V
LDY #>VAR_V
; FAC to (X/Y)
JSR FACMEM
LDY VAR_YS%
LDA VAR_YS%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_TY%
LDA VAR_TY%+1
JSR ICMP
; Optimized code for Integer(1)
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
BEQ EQ_EQ5
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP5
EQ_EQ5:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP5:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_H
LDY #>VAR_H
; FAC to (X/Y)
JSR FACMEM
;
LINE_2320:
;
LDY VAR_YS%
LDA VAR_YS%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_TY%
LDA VAR_TY%+1
JSR ICMP
; Optimized code for Integer(1)
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
BEQ LT_LT_EQ6
ROL
BCC LT_LT6
LT_LT_EQ6:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP6
LT_LT6:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP6:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F
LDY #>VAR_F
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = NOT(FAC)
JSR FACNOT
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_F
LDY #>VAR_F
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = NOT(FAC)
JSR FACNOT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
;
LINE_2333:
;
LDY VAR_XS%
LDA VAR_XS%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_TX%
LDA VAR_TX%+1
JSR ICMP
; Optimized code for Integer(1)
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
ROL
BCS GT_GT7
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP7
GT_GT7:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP7:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_J
LDY #>VAR_J
; FAC to (X/Y)
JSR FACMEM
LDY VAR_XS%
LDA VAR_XS%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_TX%
LDA VAR_TX%+1
JSR ICMP
; Optimized code for Integer(1)
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
BEQ LT_LT_EQ8
ROL
BCC LT_LT8
LT_LT_EQ8:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP8
LT_LT8:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP8:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
; FAC to (X/Y)
JSR FACMEM
;
LINE_2338:
;
;
LINE_2453:
;
LDA #0
STA VAR_M
STA VAR_M+1
STA VAR_M+2
STA VAR_M+3
STA VAR_M+4
; Optimizer rule: Simplified setting to 0/6
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDY VAR_YS%
LDA VAR_YS%+1
; integer in Y/A to FAC
PHA
TYA
PHA
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
STA G_REG
STY G_REG+1
PLA
TAY
PLA
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Index is already integer/11
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_M
LDY #>VAR_M
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
;
LINE_2466:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_25R
LDY #>CONST_25R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_YS%
LDA VAR_YS%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT9
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP9
GT_GT9:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP9:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = NOT(FAC)
JSR FACNOT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_F
LDY #>VAR_F
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
LDA X_REG
COMP_SKP14:
BEQ LINE_SKIP31
; Simplified conditional branch
;
LINE_NSKIP31:
;
JMP LINE_2473
;
LINE_SKIP31:
;
;
LINE_2468:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_25R
LDY #>CONST_25R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_YS%
LDA VAR_YS%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ10
ROL
BCC LT_LT10
LT_LT_EQ10:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP10
LT_LT10:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP10:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = NOT(FAC)
JSR FACNOT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_A
LDY #>VAR_A
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
LDA X_REG
COMP_SKP15:
BEQ LINE_SKIP32
; Simplified conditional branch
;
LINE_NSKIP32:
;
JMP LINE_2473
;
LINE_SKIP32:
;
;
LINE_2469:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_25R
LDY #>CONST_25R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_YS%
LDA VAR_YS%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = ABS(FAC)
JSR FACABS
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_TX%
LDA VAR_TX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = ABS(FAC)
JSR FACABS
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_LT%
STA VAR_LT%+1
;
LINE_2470:
;
LDY VAR_LK%
LDA VAR_LK%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_LT%
LDA VAR_LT%+1
JSR ICMP
; Optimized code for Integer(1)
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
BEQ LT_LT_EQ11
ROL
BCC LT_LT11
LT_LT_EQ11:
LDA #0
JMP LT_SKIP11
LT_LT11:
LDA #$1
LT_SKIP11:
COMP_SKP16:
BNE LINE_NSKIP33
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP33
;
LINE_NSKIP33:
;
LDY VAR_LT%
LDA VAR_LT%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_LK%
STA VAR_LK%+1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_25R
LDY #>CONST_25R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_YS%
LDA VAR_YS%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = ABS(FAC)
JSR FACABS
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_LF%
STA VAR_LF%+1
;
LINE_SKIP33:
;
;
LINE_2471:
;
;
LINE_2472:
;
;
LINE_2473:
;
LDA #<VAR_M
LDY #>VAR_M
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_5
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_5:
;
LINE_2483:
;
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP18:
BEQ LINE_SKIP34
; Simplified conditional branch
;
LINE_NSKIP34:
;
JMP LINE_3575
;
LINE_SKIP34:
;
;
LINE_2500:
;
LDY VAR_XS%
LDA VAR_XS%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_LF%
LDA VAR_LF%+1
JSR ICMP
; Optimized code for Integer(1)
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
ROL
BCS GT_GT12
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP12
GT_GT12:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP12:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_LJ%
STA VAR_LJ%+1
LDY VAR_XS%
LDA VAR_XS%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_LF%
LDA VAR_LF%+1
JSR ICMP
; Optimized code for Integer(1)
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
BEQ LT_LT_EQ13
ROL
BCC LT_LT13
LT_LT_EQ13:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP13
LT_LT13:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP13:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_LB%
STA VAR_LB%+1
;
LINE_2505:
;
;
LINE_2508:
;
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
LDA #<VAR_H
LDY #>VAR_H
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP19:
BEQ LINE_SKIP35
; Simplified conditional branch
;
LINE_NSKIP35:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_S1%
STA VAR_S1%+1
JMP LINE_2582
;
LINE_SKIP35:
;
;
LINE_2509:
;
LDA #<VAR_B
LDY #>VAR_B
JSR REALFAC
LDA #<VAR_H
LDY #>VAR_H
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP20:
BEQ LINE_SKIP36
; Simplified conditional branch
;
LINE_NSKIP36:
;
LDY #255
LDA #255
STY VAR_S1%
STA VAR_S1%+1
; Optimized code for negative constants)
;
;
;
JMP LINE_2582
;
LINE_SKIP36:
;
;
LINE_2510:
;
LDY VAR_LJ%
LDA VAR_LJ%+1
; integer in Y/A to FAC
STY Y_REG
ORA Y_REG
COMP_SKP21:
BEQ LINE_SKIP37
; Optimizer rule: Simpler IF <int> THEN/4
; Simplified conditional branch
;
LINE_NSKIP37:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_S1%
STA VAR_S1%+1
JMP LINE_2582
;
LINE_SKIP37:
;
;
LINE_2515:
;
LDY VAR_LB%
LDA VAR_LB%+1
; integer in Y/A to FAC
STY Y_REG
ORA Y_REG
COMP_SKP22:
BEQ LINE_SKIP38
; Optimizer rule: Simpler IF <int> THEN/4
; Simplified conditional branch
;
LINE_NSKIP38:
;
LDY #255
LDA #255
STY VAR_S1%
STA VAR_S1%+1
; Optimized code for negative constants)
;
;
;
JMP LINE_2582
;
LINE_SKIP38:
;
;
LINE_2535:
;
LDA #<VAR_FL
LDY #>VAR_FL
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP23:
BEQ LINE_SKIP39
; Simplified conditional branch
;
LINE_NSKIP39:
;
LDY #255
LDA #255
STY VAR_S2%
STA VAR_S2%+1
; Optimized code for negative constants)
;
;
;
JMP LINE_2582
;
LINE_SKIP39:
;
;
LINE_2540:
;
LDA #<VAR_AL
LDY #>VAR_AL
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP24:
BEQ LINE_SKIP40
; Simplified conditional branch
;
LINE_NSKIP40:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_S2%
STA VAR_S2%+1
;
LINE_SKIP40:
;
;
LINE_2582:
;
JMP RETURN
;
LINE_2615:
;
;
LINE_2625:
;
;
LINE_2630:
;
LDY VAR_YS%
LDA VAR_YS%+1
; integer in Y/A to FAC
JSR INTFAC
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
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_XS%
LDA VAR_XS%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_S3[]+20
LDY #>VAR_S3[]+20
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_REAL_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF10+1
STA MOVBSELF10+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF10:
STY $FFFF
;
LINE_2645:
;
LDY VAR_XS%
LDA VAR_XS%+1
STY TMP3_ZP
STA TMP3_ZP+1
LDY VAR_S1%
LDA VAR_S1%+1
JSR INTADDVAROPT
JSR INTCONV
; ADD VARs + STORE simplified
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
STY VAR_XS%
STA VAR_XS%+1
;
LINE_2650:
;
LDY VAR_YS%
LDA VAR_YS%+1
STY TMP3_ZP
STA TMP3_ZP+1
LDY VAR_S2%
LDA VAR_S2%+1
JSR INTADDVAROPT
JSR INTCONV
; ADD VARs + STORE simplified
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
STY VAR_YS%
STA VAR_YS%+1
;
LINE_2655:
;
LDA #<CONST_26R
LDY #>CONST_26R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDY VAR_YS%
LDA VAR_YS%+1
; integer in Y/A to FAC
JSR INTFAC
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
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_XS%
LDA VAR_XS%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF11+1
STA MOVBSELF11+2
MOVBSELF11:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_S3[]
LDY #>VAR_S3[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_2660:
;
LDY VAR_YS%
LDA VAR_YS%+1
; integer in Y/A to FAC
JSR INTFAC
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
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_XS%
LDA VAR_XS%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF12+1
STA MOVBSELF12+2
LDA #$41
MOVBSELF12:
STA $FFFF
;
LINE_2665:
;
JSR GOSUB
JSR LINE_2265
;
LINE_2670:
;
JMP RETURN
;
LINE_2680:
;
;
LINE_2690:
;
;
LINE_2695:
;
LDY VAR_TY%
LDA VAR_TY%+1
; integer in Y/A to FAC
JSR INTFAC
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
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_TX%
LDA VAR_TX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_AR%[]+8
LDY #>VAR_AR%[]+8
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_INTEGER_INT_PRE
; Optimized code for constant array access
;
; Optimizer rule: Array index is integer (load)/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF13+1
STA MOVBSELF13+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF13:
STY $FFFF
;
LINE_2700:
;
LDY VAR_TX%
LDA VAR_TX%+1
STY TMP3_ZP
STA TMP3_ZP+1
LDY VAR_T1%
LDA VAR_T1%+1
JSR INTADDVAROPT
JSR INTCONV
; ADD VARs + STORE simplified
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
STY VAR_TX%
STA VAR_TX%+1
;
LINE_2710:
;
LDY VAR_TY%
LDA VAR_TY%+1
STY TMP3_ZP
STA TMP3_ZP+1
LDY VAR_T2%
LDA VAR_T2%+1
JSR INTADDVAROPT
JSR INTCONV
; ADD VARs + STORE simplified
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
STY VAR_TY%
STA VAR_TY%+1
;
LINE_2712:
;
LDA #<CONST_26R
LDY #>CONST_26R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDY VAR_TY%
LDA VAR_TY%+1
; integer in Y/A to FAC
JSR INTFAC
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
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_TX%
LDA VAR_TX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF14+1
STA MOVBSELF14+2
MOVBSELF14:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_AR%[]
LDY #>VAR_AR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
;
LINE_2715:
;
LDY VAR_TY%
LDA VAR_TY%+1
; integer in Y/A to FAC
JSR INTFAC
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
LDA #<CONST_17
LDY #>CONST_17
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
LDY VAR_TX%
LDA VAR_TX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
STY MOVBSELF15+1
STA MOVBSELF15+2
LDA #$51
MOVBSELF15:
STA $FFFF
;
LINE_2725:
;
;
LINE_2735:
;
JSR GOSUB
JSR LINE_2240
;
LINE_2740:
;
JMP RETURN
;
LINE_2750:
;
;
LINE_2760:
;
;
LINE_2770:
;
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_28R
LDY #>CONST_28R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
;
LINE_2778:
;
LDY #35
STY 211
; Optimizer rule: Simple POKE/2
LDY #0
STY 214
; Optimizer rule: Simple POKE/2
LDA #<58640
STA TMP_ZP
LDA #>58640
STA TMP_ZP+1
JSR SYSTEMCALL
LDA #<VAR_Y
LDY #>VAR_Y
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_2779:
;
LDA #0
STA VAR_C
STA VAR_C+1
STA VAR_C+2
STA VAR_C+3
STA VAR_C+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_2780:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_30R
LDY #>CONST_30R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_12R
;LDY #>CONST_12R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
;
LINE_2785:
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
LDA #<CONST_31R
LDY #>CONST_31R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
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
LDX #<VAR_MP
LDY #>VAR_MP
; FAC to (X/Y)
JSR FACMEM
;
LINE_2789:
;
LDA #<VAR_MP
LDY #>VAR_MP
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF18+1
STA MOVBSELF18+2
MOVBSELF18:
LDA $FFFF
CMP #45
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
NEQ_NEQ14:
NEQ_SKIP14:
COMP_SKP25:
BEQ LINE_SKIP41
LINE_NSKIP41:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_2900
;
LINE_SKIP41:
;
;
LINE_2790:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_MP
LDY #>VAR_MP
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_FM
LDY #>VAR_FM
; FAC to (X/Y)
JSR FACMEM
;
LINE_2800:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_MP
LDY #>VAR_MP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_AM
LDY #>VAR_AM
; FAC to (X/Y)
JSR FACMEM
;
LINE_2810:
;
LDA #<VAR_FM
LDY #>VAR_FM
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF19+1
STA MOVBSELF19+2
MOVBSELF19:
LDA $FFFF
CMP #32
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
LDA #0
JMP EQ_SKIP15
EQ_EQ15:
LDA #$1
EQ_SKIP15:
COMP_SKP26:
BNE LINE_NSKIP42
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP42
;
LINE_NSKIP42:
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
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_C
LDY #>VAR_C
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_25R
LDY #>CONST_25R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACARG
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
JSR XXBASINT
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (2)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
JMP LINE_2900
;
LINE_SKIP42:
;
;
LINE_2820:
;
LDA #<VAR_AM
LDY #>VAR_AM
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF20+1
STA MOVBSELF20+2
MOVBSELF20:
LDA $FFFF
CMP #102
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
;
BEQ EQ_EQ16
LDA #0
JMP EQ_SKIP16
EQ_EQ16:
LDA #$1
EQ_SKIP16:
COMP_SKP27:
BNE LINE_NSKIP43
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP43
;
LINE_NSKIP43:
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
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_C
LDY #>VAR_C
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_25R
LDY #>CONST_25R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
JSR FACINT
STY TMP4_REG
STA TMP4_REG+1
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
JSR FACINT
JSR INTADD16
LDA #<VAR_X
LDY #>VAR_X
JSR COPY2_XYA_YREG
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
STA G_REG
STY G_REG+1
LDY TMP4_REG
LDA TMP4_REG+1
JSR ARRAYSTORE_INTEGER_INT
; Optimizer rule: Improved int array store/22
;
LINE_SKIP43:
;
;
LINE_2900:
;
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
;
LINE_2910:
;
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_7
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_7:
;
LINE_2915:
;
;
LINE_2918:
;
;
LINE_2924:
;
;
LINE_2929:
;
;
LINE_2939:
;
;
LINE_2949:
;
;
LINE_2959:
;
;
LINE_2964:
;
;
LINE_2967:
;
;
LINE_2970:
;
JMP RETURN
;
LINE_2972:
;
;
LINE_2975:
;
;
LINE_2979:
;
;
LINE_2985:
;
LDY #15
STY 54296
; Optimizer rule: Simple POKE/2
LDY #129
STY 54276
; Optimizer rule: Simple POKE/2
LDY #15
STY 54277
; Optimizer rule: Simple POKE/2
LDY #40
STY 54273
; Optimizer rule: Simple POKE/2
LDY #200
STY 54272
; Optimizer rule: Simple POKE/2
;
LINE_2990:
;
LDY #0
STY 54276
; Optimizer rule: Simple POKE/2
STY 54277
; Optimizer rule: Simple POKE/2
;
LINE_2995:
;
JMP RETURN
;
LINE_3000:
;
;
LINE_3200:
;
;
LINE_3275:
;
;
LINE_3280:
;
;
LINE_3285:
;
;
LINE_3286:
;
;
LINE_3287:
;
;
LINE_3288:
;
;
LINE_3289:
;
;
LINE_3323:
;
;
LINE_3325:
;
;
LINE_3326:
;
;
LINE_3327:
;
;
LINE_3328:
;
;
LINE_3400:
;
;
LINE_3410:
;
;
LINE_3420:
;
;
LINE_3425:
;
;
LINE_3426:
;
;
LINE_3427:
;
;
LINE_3428:
;
;
LINE_3430:
;
;
LINE_3440:
;
;
LINE_3450:
;
;
LINE_3460:
;
;
LINE_3465:
;
;
LINE_3466:
;
;
LINE_3467:
;
;
LINE_3490:
;
;
LINE_3500:
;
;
LINE_3510:
;
;
LINE_3520:
;
;
LINE_3525:
;
;
LINE_3530:
;
;
LINE_3540:
;
;
LINE_3550:
;
;
LINE_3555:
;
;
LINE_3560:
;
;
LINE_3565:
;
;
LINE_3570:
;
;
LINE_3575:
;
LDA #<CONST_34
LDY #>CONST_34
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3580:
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
ARRAYACCESS_INTEGER_INT_PRE
LDX G_REG
STX TMP_ZP
LDX G_REG+1
STX TMP_ZP+1
JMP AIIDI
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
INTADDVAROPT
LDX #0			; Mark as "further int opt possible"
BEQ INTADDADD
INTADDVAR	LDX #1
INTADDADD	STX INT_FLAG
LDX #128		; Do the fast way for negative numbers and everything below 16384...first var
STX TMP_REG		; Note to self: What I call first here, is actually the second variable and what I call
BIT TMP_REG		; second is the first. Because this is an addition, it doesn't really matter unless people
BNE INTADDVARC2	; tend to use smaller values more on the right side, which I simply don't know...
LDX #64
STX TMP_REG
BIT TMP_REG
BEQ INTADDVARC2
JMP FLOATINTADD
INTADDVARC2
PHA
LDA TMP3_ZP+1
LDX #128		; Do the fast way for everything below 16384 but positive...second var
STX TMP_REG		; If var is negative, and var2 isn't, this could always be done, but we are ignoring
BIT TMP_REG		; this here for now to simplify the check...
BEQ INTADDVARC3
PLA
JMP FLOATINTADD
INTADDVARC3
LDX #64
STX TMP_REG
BIT TMP_REG
BEQ INTINTADDVAR2
PLA
JMP FLOATINTADD
INTINTADDVAR2
LDX #1
STX TMP_FLAG
TYA
CLC
ADC TMP3_ZP
TAY
PLA
ADC TMP3_ZP+1
STY TMP2_ZP
STA TMP2_ZP+1
LDX INT_FLAG
BNE INTADDVAREND
RTS
INTADDVAREND
JMP INTFAC
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
INTCONV		LDA TMP_FLAG	; The INT value is either already present in TMP2_ZP...or not...
BEQ INTFROMFAC
LDY TMP2_ZP
LDA TMP2_ZP+1
RTS
INTFROMFAC	JMP FACINT
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
ICMP		STY TMP3_ZP
STA TMP3_ZP+1
LDA TMP_ZP+1
CMP TMP3_ZP+1
BNE ICMPNE2
LDA TMP_ZP
CMP TMP3_ZP
ICMPNE		BEQ ICMPEQ
BCS ICMPHIGHER
JMP ICMPLOWER
ICMPNE2		BPL ICMPHIGHER
JMP ICMPLOWER
ICMPEQ		LDA #0
RTS
ICMPLOWER	LDA #$FF
SEC
RTS
ICMPHIGHER	LDA #$01
CLC
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
FINX		LDA #<REAL_CONST_ONE
LDY #>REAL_CONST_ONE
JSR REALFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
JMP FACXREG
;###################################
;###################################
FDEX		LDA #<REAL_CONST_ONE
LDY #>REAL_CONST_ONE
JSR REALFAC
JSR XREGARG
JSR FASTFSUBARG
; Optimizer rule: Fast FSUB (ARG)/1
JMP FACXREG
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
STA VAR_N,Y
STA VAR_L,Y
STA VAR_O,Y
STA VAR_I,Y
STA VAR_J,Y
STA VAR_FK,Y
STA VAR_K,Y
STA VAR_UP,Y
STA VAR_DN,Y
STA VAR_RT,Y
STA VAR_LT,Y
STA VAR_FL,Y
STA VAR_AL,Y
STA VAR_B,Y
STA VAR_V,Y
STA VAR_H,Y
STA VAR_F,Y
STA VAR_A,Y
STA VAR_M,Y
STA VAR_Y,Y
STA VAR_C,Y
STA VAR_X,Y
STA VAR_MP,Y
STA VAR_FM,Y
STA VAR_AM,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
STA VAR_LD%
STA VAR_LD%+1
STA VAR_FA%
STA VAR_FA%+1
STA VAR_AI%
STA VAR_AI%+1
STA VAR_TX%
STA VAR_TX%+1
STA VAR_TY%
STA VAR_TY%+1
STA VAR_T1%
STA VAR_T1%+1
STA VAR_T2%
STA VAR_T2%+1
STA VAR_XS%
STA VAR_XS%+1
STA VAR_YS%
STA VAR_YS%+1
STA VAR_S1%
STA VAR_S1%+1
STA VAR_S2%
STA VAR_S2%+1
STA VAR_LK%
STA VAR_LK%+1
STA VAR_LT%
STA VAR_LT%+1
STA VAR_A%
STA VAR_A%+1
STA VAR_B%
STA VAR_B%+1
LDA #<VAR_LP%[]
LDY #>VAR_LP%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_AR%[]
LDY #>VAR_AR%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_S3[]
LDY #>VAR_S3[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_LJ%
STA VAR_LJ%+1
STA VAR_LB%
STA VAR_LB%+1
LDA #<VAR_LA%[]
LDY #>VAR_LA%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_LF%
STA VAR_LF%+1
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #147


; CONST: #16


; CONST: #45

CONST_2R	.REAL 45.0
; CONST: #102


; CONST: #32


; CONST: #27


; CONST: #23


; CONST: #0

CONST_7R	.REAL 0.0
; CONST: #3


; CONST: #80


; CONST: #54272

CONST_10	.REAL 54272
; CONST: #54296

CONST_11	.REAL 54296
; CONST: #1

MOSTCOMMON
CONST_12R	.REAL 1.0
; CONST: #200

CONST_13R	.REAL 200.0
; CONST: #14

CONST_14R	.REAL 14.0
; CONST: #5

CONST_15R	.REAL 5.0
; CONST: #40

CONST_16R	.REAL 40.0
; CONST: #1024.0

CONST_17	.REAL 1024.0
; CONST: #81


; CONST: #-1.0

CONST_19	.REAL -1.0
; CONST: $
CONST_20	.BYTE 0
.STRG ""
; CONST: #145


; CONST: #17


; CONST: #29


; CONST: #157


; CONST: #25

CONST_25R	.REAL 25.0
; CONST: #4

CONST_26R	.REAL 4.0
; CONST: #65


; CONST: #24

CONST_28R	.REAL 24.0
; CONST: #35


; CONST: #39

CONST_30R	.REAL 39.0
; CONST: #1024

CONST_31R	.REAL 1024.0
; CONST: #15


; CONST: #129


; CONST: $got ya! [=
CONST_34	.BYTE 10
.STRG "got ya! [="
;###############################
; ******** DATA ********
DATAS
.BYTE 0
.WORD 1184
.BYTE 102
.BYTE 0
.WORD 1185
.BYTE 102
.BYTE 0
.WORD 1186
.BYTE 102
.BYTE 0
.WORD 1187
.BYTE 102
.BYTE 0
.WORD 1188
.BYTE 102
.BYTE 0
.WORD 1189
.BYTE 102
.BYTE 0
.WORD 1190
.BYTE 102
.BYTE 0
.WORD 1191
.BYTE 102
.BYTE 0
.WORD 1192
.BYTE 102
.BYTE 0
.WORD 1193
.BYTE 102
.BYTE 0
.WORD 1194
.BYTE 102
.BYTE 0
.WORD 1195
.BYTE 102
.BYTE 0
.WORD 1196
.BYTE 102
.BYTE 0
.WORD 1197
.BYTE 102
.BYTE 0
.WORD 1198
.BYTE 102
.BYTE 0
.WORD 1199
.BYTE 102
.BYTE 0
.WORD 1200
.BYTE 102
.BYTE 0
.WORD 1201
.BYTE 102
.BYTE 0
.WORD 1202
.BYTE 102
.BYTE 0
.WORD 1203
.BYTE 102
.BYTE 0
.WORD 1204
.BYTE 102
.BYTE 0
.WORD 1205
.BYTE 102
.BYTE 0
.WORD 1206
.BYTE 102
.BYTE 0
.WORD 1207
.BYTE 102
.BYTE 0
.WORD 1208
.BYTE 102
.BYTE 0
.WORD 1209
.BYTE 102
.BYTE 0
.WORD 1210
.BYTE 102
.BYTE 0
.WORD 1211
.BYTE 102
.BYTE 0
.WORD 1212
.BYTE 102
.BYTE 0
.WORD 1213
.BYTE 102
.BYTE 0
.WORD 1214
.BYTE 102
.BYTE 0
.WORD 1215
.BYTE 102
.BYTE 0
.WORD 1216
.BYTE 102
.BYTE 0
.WORD 1217
.BYTE 102
.BYTE 0
.WORD 1218
.BYTE 102
.BYTE 0
.WORD 1219
.BYTE 102
.BYTE 0
.WORD 1220
.BYTE 102
.BYTE 0
.WORD 1221
.BYTE 102
.BYTE 0
.WORD 1222
.BYTE 102
.BYTE 0
.WORD 1223
.BYTE 102
.BYTE 0
.WORD 1384
.BYTE 102
.BYTE 0
.WORD 1385
.BYTE 102
.BYTE 0
.WORD 1386
.BYTE 102
.BYTE 0
.WORD 1387
.BYTE 102
.BYTE 0
.WORD 1388
.BYTE 102
.BYTE 0
.WORD 1389
.BYTE 102
.BYTE 0
.WORD 1390
.BYTE 102
.BYTE 0
.WORD 1391
.BYTE 102
.BYTE 0
.WORD 1392
.BYTE 102
.BYTE 0
.WORD 1393
.BYTE 102
.BYTE 0
.WORD 1394
.BYTE 102
.BYTE 0
.WORD 1395
.BYTE 102
.BYTE 0
.WORD 1396
.BYTE 102
.BYTE 0
.WORD 1397
.BYTE 102
.BYTE 0
.WORD 1398
.BYTE 102
.BYTE 0
.WORD 1399
.BYTE 102
.BYTE 0
.WORD 1400
.BYTE 102
.BYTE 0
.WORD 1401
.BYTE 102
.BYTE 0
.WORD 1402
.BYTE 102
.BYTE 0
.WORD 1403
.BYTE 102
.BYTE 0
.WORD 1404
.BYTE 102
.BYTE 0
.WORD 1405
.BYTE 102
.BYTE 0
.WORD 1406
.BYTE 102
.BYTE 0
.WORD 1407
.BYTE 102
.BYTE 0
.WORD 1408
.BYTE 102
.BYTE 0
.WORD 1409
.BYTE 102
.BYTE 0
.WORD 1410
.BYTE 102
.BYTE 0
.WORD 1411
.BYTE 102
.BYTE 0
.WORD 1412
.BYTE 102
.BYTE 0
.WORD 1413
.BYTE 102
.BYTE 0
.WORD 1414
.BYTE 102
.BYTE 0
.WORD 1415
.BYTE 102
.BYTE 0
.WORD 1416
.BYTE 102
.BYTE 0
.WORD 1417
.BYTE 102
.BYTE 0
.WORD 1418
.BYTE 102
.BYTE 0
.WORD 1419
.BYTE 102
.BYTE 0
.WORD 1420
.BYTE 102
.BYTE 0
.WORD 1421
.BYTE 102
.BYTE 0
.WORD 1422
.BYTE 102
.BYTE 0
.WORD 1423
.BYTE 102
.BYTE 0
.WORD 1584
.BYTE 102
.BYTE 0
.WORD 1585
.BYTE 102
.BYTE 0
.WORD 1586
.BYTE 102
.BYTE 0
.WORD 1587
.BYTE 102
.BYTE 0
.WORD 1588
.BYTE 102
.BYTE 0
.WORD 1589
.BYTE 102
.BYTE 0
.WORD 1590
.BYTE 102
.BYTE 0
.WORD 1591
.BYTE 102
.BYTE 0
.WORD 1592
.BYTE 102
.BYTE 0
.WORD 1593
.BYTE 102
.BYTE 0
.WORD 1594
.BYTE 102
.BYTE 0
.WORD 1595
.BYTE 102
.BYTE 0
.WORD 1596
.BYTE 102
.BYTE 0
.WORD 1597
.BYTE 102
.BYTE 0
.WORD 1598
.BYTE 102
.BYTE 0
.WORD 1599
.BYTE 102
.BYTE 0
.WORD 1600
.BYTE 102
.BYTE 0
.WORD 1601
.BYTE 102
.BYTE 0
.WORD 1602
.BYTE 102
.BYTE 0
.WORD 1603
.BYTE 102
.BYTE 0
.WORD 1604
.BYTE 102
.BYTE 0
.WORD 1605
.BYTE 102
.BYTE 0
.WORD 1606
.BYTE 102
.BYTE 0
.WORD 1607
.BYTE 102
.BYTE 0
.WORD 1608
.BYTE 102
.BYTE 0
.WORD 1609
.BYTE 102
.BYTE 0
.WORD 1610
.BYTE 102
.BYTE 0
.WORD 1611
.BYTE 102
.BYTE 0
.WORD 1612
.BYTE 102
.BYTE 0
.WORD 1613
.BYTE 102
.BYTE 0
.WORD 1614
.BYTE 102
.BYTE 0
.WORD 1615
.BYTE 102
.BYTE 0
.WORD 1616
.BYTE 102
.BYTE 0
.WORD 1617
.BYTE 102
.BYTE 0
.WORD 1618
.BYTE 102
.BYTE 0
.WORD 1619
.BYTE 102
.BYTE 0
.WORD 1620
.BYTE 102
.BYTE 0
.WORD 1621
.BYTE 102
.BYTE 0
.WORD 1622
.BYTE 102
.BYTE 0
.WORD 1623
.BYTE 102
.BYTE 0
.WORD 1784
.BYTE 102
.BYTE 0
.WORD 1785
.BYTE 102
.BYTE 0
.WORD 1786
.BYTE 102
.BYTE 0
.WORD 1787
.BYTE 102
.BYTE 0
.WORD 1788
.BYTE 102
.BYTE 0
.WORD 1789
.BYTE 102
.BYTE 0
.WORD 1790
.BYTE 102
.BYTE 0
.WORD 1791
.BYTE 102
.BYTE 0
.WORD 1792
.BYTE 102
.BYTE 0
.WORD 1793
.BYTE 102
.BYTE 0
.WORD 1794
.BYTE 102
.BYTE 0
.WORD 1795
.BYTE 102
.BYTE 0
.WORD 1796
.BYTE 102
.BYTE 0
.WORD 1797
.BYTE 102
.BYTE 0
.WORD 1798
.BYTE 102
.BYTE 0
.WORD 1799
.BYTE 102
.BYTE 0
.WORD 1800
.BYTE 102
.BYTE 0
.WORD 1801
.BYTE 102
.BYTE 0
.WORD 1802
.BYTE 102
.BYTE 0
.WORD 1803
.BYTE 102
.BYTE 0
.WORD 1804
.BYTE 102
.BYTE 0
.WORD 1805
.BYTE 102
.BYTE 0
.WORD 1806
.BYTE 102
.BYTE 0
.WORD 1807
.BYTE 102
.BYTE 0
.WORD 1808
.BYTE 102
.BYTE 0
.WORD 1809
.BYTE 102
.BYTE 0
.WORD 1810
.BYTE 102
.BYTE 0
.WORD 1811
.BYTE 102
.BYTE 0
.WORD 1812
.BYTE 102
.BYTE 0
.WORD 1813
.BYTE 102
.BYTE 0
.WORD 1814
.BYTE 102
.BYTE 0
.WORD 1815
.BYTE 102
.BYTE 0
.WORD 1816
.BYTE 102
.BYTE 0
.WORD 1817
.BYTE 102
.BYTE 0
.WORD 1818
.BYTE 102
.BYTE 0
.WORD 1819
.BYTE 102
.BYTE 0
.WORD 1820
.BYTE 102
.BYTE 0
.WORD 1821
.BYTE 102
.BYTE 0
.WORD 1822
.BYTE 102
.BYTE 0
.WORD 1823
.BYTE 102
.BYTE 0
.WORD 1984
.BYTE 102
.BYTE 0
.WORD 1985
.BYTE 102
.BYTE 0
.WORD 1986
.BYTE 102
.BYTE 0
.WORD 1987
.BYTE 102
.BYTE 0
.WORD 1988
.BYTE 102
.BYTE 0
.WORD 1989
.BYTE 102
.BYTE 0
.WORD 1990
.BYTE 102
.BYTE 0
.WORD 1991
.BYTE 102
.BYTE 0
.WORD 1992
.BYTE 102
.BYTE 0
.WORD 1993
.BYTE 102
.BYTE 0
.WORD 1994
.BYTE 102
.BYTE 0
.WORD 1995
.BYTE 102
.BYTE 0
.WORD 1996
.BYTE 102
.BYTE 0
.WORD 1997
.BYTE 102
.BYTE 0
.WORD 1998
.BYTE 102
.BYTE 0
.WORD 1999
.BYTE 102
.BYTE 0
.WORD 2000
.BYTE 102
.BYTE 0
.WORD 2001
.BYTE 102
.BYTE 0
.WORD 2002
.BYTE 102
.BYTE 0
.WORD 2003
.BYTE 102
.BYTE 0
.WORD 2004
.BYTE 102
.BYTE 0
.WORD 2005
.BYTE 102
.BYTE 0
.WORD 2006
.BYTE 102
.BYTE 0
.WORD 2007
.BYTE 102
.BYTE 0
.WORD 2008
.BYTE 102
.BYTE 0
.WORD 2009
.BYTE 102
.BYTE 0
.WORD 2010
.BYTE 102
.BYTE 0
.WORD 2011
.BYTE 102
.BYTE 0
.WORD 2012
.BYTE 102
.BYTE 0
.WORD 2013
.BYTE 102
.BYTE 0
.WORD 2014
.BYTE 102
.BYTE 0
.WORD 2015
.BYTE 102
.BYTE 0
.WORD 2016
.BYTE 102
.BYTE 0
.WORD 2017
.BYTE 102
.BYTE 0
.WORD 2018
.BYTE 102
.BYTE 0
.WORD 2019
.BYTE 102
.BYTE 0
.WORD 2020
.BYTE 102
.BYTE 0
.WORD 2021
.BYTE 102
.BYTE 0
.WORD 2022
.BYTE 102
.BYTE 0
.WORD 2023
.BYTE 102
.BYTE 0
.WORD 1185
.BYTE 0
.WORD 1389
.BYTE 0
.WORD 1399
.BYTE 0
.WORD 1409
.BYTE 0
.WORD 1419
.BYTE 0
.WORD 1594
.BYTE 0
.WORD 1604
.BYTE 0
.WORD 1614
.BYTE 0
.WORD 1789
.BYTE 0
.WORD 1799
.BYTE 0
.WORD 1809
.BYTE 0
.WORD 1819
.BYTE 0
.WORD 1994
.BYTE 0
.WORD 2004
.BYTE 0
.WORD 2014
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: LD%
VAR_LD%	.WORD 0
; VAR: FA%
VAR_FA%	.WORD 0
; VAR: AI%
VAR_AI%	.WORD 0
; VAR: TX%
VAR_TX%	.WORD 0
; VAR: TY%
VAR_TY%	.WORD 0
; VAR: T1%
VAR_T1%	.WORD 0
; VAR: T2%
VAR_T2%	.WORD 0
; VAR: XS%
VAR_XS%	.WORD 0
; VAR: YS%
VAR_YS%	.WORD 0
; VAR: S1%
VAR_S1%	.WORD 0
; VAR: S2%
VAR_S2%	.WORD 0
; VAR: LK%
VAR_LK%	.WORD 0
; VAR: LT%
VAR_LT%	.WORD 0
; VAR: N
VAR_N	.REAL 0.0
; VAR: L
VAR_L	.REAL 0.0
; VAR: O
VAR_O	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: A%
VAR_A%	.WORD 0
; VAR: B%
VAR_B%	.WORD 0
; VAR: J
VAR_J	.REAL 0.0
; VAR: LP%[]
.BYTE 0
.WORD 30
VAR_LP%[]	.ARRAY 30
; VAR: FK
VAR_FK	.REAL 0.0
; VAR: K
VAR_K	.REAL 0.0
; VAR: UP
VAR_UP	.REAL 0.0
; VAR: DN
VAR_DN	.REAL 0.0
; VAR: RT
VAR_RT	.REAL 0.0
; VAR: LT
VAR_LT	.REAL 0.0
; VAR: AR%[]
.BYTE 0
.WORD 10
VAR_AR%[]	.ARRAY 10
; VAR: S3[]
.BYTE 1
.WORD 25
VAR_S3[]	.ARRAY 25
; VAR: FL
VAR_FL	.REAL 0.0
; VAR: AL
VAR_AL	.REAL 0.0
; VAR: LJ%
VAR_LJ%	.WORD 0
; VAR: LB%
VAR_LB%	.WORD 0
; VAR: B
VAR_B	.REAL 0.0
; VAR: V
VAR_V	.REAL 0.0
; VAR: H
VAR_H	.REAL 0.0
; VAR: F
VAR_F	.REAL 0.0
; VAR: A
VAR_A	.REAL 0.0
; VAR: M
VAR_M	.REAL 0.0
; VAR: LA%[]
.BYTE 0
.WORD 550
VAR_LA%[]	.ARRAY 550
; VAR: LF%
VAR_LF%	.WORD 0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: C
VAR_C	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: MP
VAR_MP	.REAL 0.0
; VAR: FM
VAR_FM	.REAL 0.0
; VAR: AM
VAR_AM	.REAL 0.0
STRINGVARS_START
; VAR: K$
VAR_K$	.WORD EMPTYSTR
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
