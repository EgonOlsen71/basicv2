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
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDY #15
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
LDY #0
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_20:
;
LDA #0
STA VAR_CN
STA VAR_CN+1
STA VAR_CN+2
STA VAR_CN+3
STA VAR_CN+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_25:
;
LDA #<CONST_3
LDY #>CONST_3
STA A_REG
STY A_REG+1
LDA #<CONST_2R
LDY #>CONST_2R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_OP$[]
LDY #>VAR_OP$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<CONST_5
LDY #>CONST_5
STA A_REG
STY A_REG+1
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_OP$[]
LDY #>VAR_OP$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_30:
;
JSR GOSUB
JSR LINE_1000
;
LINE_40:
;
LDA VAR_X
BEQ EQ_SKIP0
EQ_EQ0:
JMP LINE_SKIP32
EQ_SKIP0:
COMP_SKP0:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP32:
;
JSR GOSUB
JSR LINE_1200
;
LINE_SKIP32:
;
;
LINE_45:
;
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ1
BEQ LTEQ_LTEQ1
LDA #0
JMP LTEQ_SKIP1
LTEQ_LTEQ1:
LDA #$1
LTEQ_SKIP1:
COMP_SKP1:
BEQ LINE_SKIP33
; Simplified conditional branch
;
LINE_NSKIP33:
;
JSR RUN
;
LINE_SKIP33:
;
;
LINE_50:
;
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ2
BCS GTEQ_GTEQ2
LDA #0
JMP GTEQ_SKIP2
GTEQ_GTEQ2:
LDA #$1
GTEQ_SKIP2:
COMP_SKP2:
BEQ LINE_SKIP34
; Simplified conditional branch
;
LINE_NSKIP34:
;
LDX #4
dcloop401_1:
LDA CONST_4R,X
STA VAR_X,X
DEX
BPL dcloop401_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP34:
;
;
LINE_60:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X
LDY #>VAR_X
JSR CMPFAC
EQ_EQ3:
EQ_SKIP3:
COMP_SKP3:
BNE LINE_SKIP35
LINE_NSKIP35:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_100
;
LINE_SKIP35:
;
;
LINE_70:
;
JSR GOSUB
JSR LINE_2000
JMP LINE_30
;
LINE_100:
;
JSR GOSUB
JSR LINE_2000
;
LINE_110:
;
LDA #<CONST_7
LDY #>CONST_7
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MG$
LDY #>VAR_MG$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_10000
;
LINE_120:
;
LDA #0
STA VAR_DC
STA VAR_DC+1
STA VAR_DC+2
STA VAR_DC+3
STA VAR_DC+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_1500
LDY #15
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_130:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_DC
LDY #>VAR_DC
JSR CMPFAC
EQ_EQ4:
EQ_SKIP4:
COMP_SKP4:
BNE LINE_SKIP36
LINE_NSKIP36:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_2000
LDA #<CONST_8
LDY #>CONST_8
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MG$
LDY #>VAR_MG$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_10000
;
LINE_SKIP36:
;
;
LINE_140:
;
LDA #0
STA VAR_DC
STA VAR_DC+1
STA VAR_DC+2
STA VAR_DC+3
STA VAR_DC+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_1600
;
LINE_150:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_DC
LDY #>VAR_DC
JSR CMPFAC
EQ_EQ5:
EQ_SKIP5:
COMP_SKP5:
BNE LINE_SKIP37
LINE_NSKIP37:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_2000
LDA #<CONST_9
LDY #>CONST_9
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MG$
LDY #>VAR_MG$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_10000
;
LINE_SKIP37:
;
;
LINE_160:
;
LDA #0
STA VAR_DC
STA VAR_DC+1
STA VAR_DC+2
STA VAR_DC+3
STA VAR_DC+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_1900
LDY #15
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_170:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_DC
LDY #>VAR_DC
JSR CMPFAC
EQ_EQ6:
EQ_SKIP6:
COMP_SKP6:
BNE LINE_SKIP38
LINE_NSKIP38:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_2000
LDA #<CONST_10
LDY #>CONST_10
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MG$
LDY #>VAR_MG$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_10000
;
LINE_SKIP38:
;
;
LINE_180:
;
JSR GOSUB
JSR LINE_4000
;
LINE_200:
;
LDA #<CONST_11
LDY #>CONST_11
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR END
RTS
;
LINE_1000:
;
LDA #<CONST_12
LDY #>CONST_12
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1010:
;
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1015:
;
LDA #<CONST_14
LDY #>CONST_14
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1020:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_Z%
STA VAR_Z%+1
LDA #<CONST_15
LDY #>CONST_15
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_CN
LDY #>VAR_CN
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
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
; Optimizer rule: FAC 2 X_REG(2)/1
JSR REALOUT
JSR CRSRRIGHT
INPUT3:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_16
LDY #>CONST_16
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP7:
BEQ INPUT3_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP INPUT3
INPUT3_0:
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP4
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACINT
STY VAR_Z%
STA VAR_Z%+1
EMPTYINPUTSKIP4:
JSR QUEUESIZE
LDA X_REG
COMP_SKP8:
BEQ INPUTCHECK3
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK3:
;
LINE_1030:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_Z%
LDA VAR_Z%+1
JSR ICMP
; Optimized code for Integer(2)
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
BEQ EQ_EQ7
LDA #0
JMP EQ_SKIP7
EQ_EQ7:
LDA #$1
EQ_SKIP7:
COMP_SKP9:
BNE LINE_NSKIP39
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP39
;
LINE_NSKIP39:
;
LDX #4
dcloop899_1:
LDA CONST_4R,X
STA VAR_X,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CN
LDY #>VAR_CN
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_SKIP39:
;
;
LINE_1040:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_N%
STA VAR_N%+1
LDA #<CONST_19
LDY #>CONST_19
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_CN
LDY #>VAR_CN
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
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
; Optimizer rule: FAC 2 X_REG(2)/1
JSR REALOUT
JSR CRSRRIGHT
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
COMP_SKP10:
BEQ INPUT4_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP INPUT4
INPUT4_0:
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP5
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACINT
STY VAR_N%
STA VAR_N%+1
EMPTYINPUTSKIP5:
JSR QUEUESIZE
LDA X_REG
COMP_SKP11:
BEQ INPUTCHECK4
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK4:
;
LINE_1050:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_N%
LDA VAR_N%+1
JSR ICMP
; Optimized code for Integer(2)
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
EQ_EQ8:
EQ_SKIP8:
COMP_SKP12:
BNE LINE_SKIP40
LINE_NSKIP40:
; Optimizer rule: Simplified equal comparison/6
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_N%
STA VAR_N%+1
;
LINE_SKIP40:
;
;
LINE_1060:
;
LDA #<VAR_CN
LDY #>VAR_CN
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_Z%
LDA VAR_Z%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_CN
LDY #>VAR_CN
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_N%
LDA VAR_N%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_1070:
;
JMP RETURN
;
LINE_1200:
;
LDX #4
dceloop4816_1:
LDA CONST_20R,X
CMP VAR_CN,X
BNE LINE_SKIP41
DEX
BPL dceloop4816_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP41:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1231_1:
LDA CONST_4R,X
STA VAR_X,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP41:
;
;
LINE_1205:
;
LDA #<CONST_14
LDY #>CONST_14
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1210:
;
LDA #<CONST_21
LDY #>CONST_21
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_1220:
;
INPUT5:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_16
LDY #>CONST_16
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
COMP_SKP14:
BEQ INPUTCHECK5
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK5:
LDA #<CONST_16
LDY #>CONST_16
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP15:
BEQ LINE_SKIP42
; Simplified conditional branch
;
LINE_NSKIP42:
;
LDX #4
dcloop1231_2:
LDA CONST_4R,X
STA VAR_X,X
DEX
BPL dcloop1231_2
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_SKIP42:
;
;
LINE_1230:
;
LDA #<CONST_5
LDY #>CONST_5
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
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
LDA #<CONST_3
LDY #>CONST_3
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
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
COMP_SKP16:
BEQ LINE_SKIP43
; Simplified conditional branch
;
LINE_NSKIP43:
;
JMP LINE_1200
;
LINE_SKIP43:
;
;
LINE_1240:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_OP%
STA VAR_OP%+1
LDA #<CONST_5
LDY #>CONST_5
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP17:
BEQ LINE_SKIP44
; Simplified conditional branch
;
LINE_NSKIP44:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_OP%
STA VAR_OP%+1
;
LINE_SKIP44:
;
;
LINE_1250:
;
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_CN
LDY #>VAR_CN
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_OP%
LDA VAR_OP%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_OP%[]
LDY #>VAR_OP%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CN
LDY #>VAR_CN
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_1499:
;
;
LINE_1500:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_CN
LDY #>VAR_CN
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_18R
LDY #>CONST_18R
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
LINE_1510:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_Z%
STA VAR_Z%+1
; Optimizer rule: Fast INTEGER array access (1)/3
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
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_N%
STA VAR_N%+1
; Optimizer rule: Fast INTEGER array access (1)/3
;
LINE_1520:
;
JSR GOSUB
JSR LINE_1800
;
LINE_1530:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_Z%
LDA VAR_Z%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
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
LDY VAR_N%
LDA VAR_N%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_1540:
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
JMP RETURN
;
LINE_1599:
;
;
LINE_1600:
;
LDX #4
dcloop1563_1:
LDA CONST_18R,X
STA VAR_I,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_CN
LDY #>VAR_CN
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_18R
LDY #>CONST_18R
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
LINE_1610:
;
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_OP%[]
LDY #>VAR_OP%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_OP%
STA VAR_OP%+1
; Optimizer rule: Fast INTEGER array access (1)/3
;
LINE_1620:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_OP%
LDA VAR_OP%+1
JSR ICMP
; Optimized code for Integer(2)
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
EQ_EQ10:
EQ_SKIP10:
COMP_SKP19:
BNE LINE_SKIP45
LINE_NSKIP45:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_1650
;
LINE_SKIP45:
;
;
LINE_1630:
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
JMP RETURN
;
LINE_1650:
;
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_OP%[]
LDY #>VAR_OP%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_T%
STA VAR_T%+1
; Optimizer rule: Fast INTEGER array access (1)/3
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
;
LINE_1660:
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
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_T%
LDA VAR_T%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
LDX #4
dcloop1895_1:
LDA CONST_4R,X
STA VAR_DC,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_1800:
;
LDY VAR_Z%
LDA VAR_Z%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_MX%
STA VAR_MX%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
LDY VAR_N%
LDA VAR_N%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ11
ROL
BCC LT_LT11
LT_LT_EQ11:
LDA #0
JMP LT_SKIP11
LT_LT11:
LDA #$1
LT_SKIP11:
COMP_SKP21:
BEQ LINE_SKIP46
; Simplified conditional branch
;
LINE_NSKIP46:
;
LDY VAR_N%
LDA VAR_N%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_MX%
STA VAR_MX%+1
;
LINE_SKIP46:
;
;
LINE_1805:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_MX%
LDA VAR_MX%+1
JSR ICMP
; Optimized code for Integer(2)
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
BCC LTEQ_LTEQ12
BEQ LTEQ_LTEQ12
LDA #0
JMP LTEQ_SKIP12
LTEQ_LTEQ12:
LDA #$1
LTEQ_SKIP12:
COMP_SKP22:
BEQ LINE_SKIP47
; Simplified conditional branch
;
LINE_NSKIP47:
;
JMP RETURN
;
LINE_SKIP47:
;
;
LINE_1810:
;
LDY VAR_MX%
LDA VAR_MX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_22
LDY #>CONST_22
JSR REALFACPUSH
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
LDA #<CONST_1R
LDY #>CONST_1R
JSR REALFAC
LDA #<VAR_M
LDY #>VAR_M
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 53280
;
LINE_1820:
;
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_Z%
LDA VAR_Z%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_K
LDY #>VAR_K
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_K
LDY #>VAR_K
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ13
LDA #0
JMP EQ_SKIP13
EQ_EQ13:
LDA #$1
EQ_SKIP13:
COMP_SKP23:
BNE LINE_NSKIP48
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP48
;
LINE_NSKIP48:
;
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_N%
LDA VAR_N%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_K
LDY #>VAR_K
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_K
LDY #>VAR_K
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ14:
EQ_SKIP14:
COMP_SKP24:
BNE LINE_SKIP49
LINE_NSKIP49:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_1840
;
LINE_SKIP49:
;
;
LINE_SKIP48:
;
;
LINE_1825:
;
LDY VAR_MX%
LDA VAR_MX%+1
JSR INTFAC
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_XREG
; Optimizer rule: Omit Y_REG/6
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ15:
EQ_SKIP15:
COMP_SKP25:
BNE LINE_SKIP50
LINE_NSKIP50:
; Optimizer rule: Simplified equal comparison/6
;
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDY VAR_MX%
LDA VAR_MX%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP50:
;
;
LINE_1830:
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
JMP RETURN
;
LINE_1840:
;
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_Z%
LDA VAR_Z%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_Z%
STA VAR_Z%+1
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_N%
LDA VAR_N%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_N%
STA VAR_N%+1
LDX #4
dcloop2393_1:
LDA CONST_4R,X
STA VAR_DC,X
DEX
BPL dcloop2393_1
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_1899:
;
;
LINE_1900:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_18R
LDY #>CONST_18R
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
LINE_1910:
;
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_CN
LDY #>VAR_CN
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_18R
LDY #>CONST_18R
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
LINE_1920:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_Z%
STA VAR_Z%+1
; Optimizer rule: Fast INTEGER array access (1)/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_N%
STA VAR_N%+1
; Optimizer rule: Fast INTEGER array access (1)/3
;
LINE_1930:
;
JSR GOSUB
JSR LINE_1800
;
LINE_1940:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_Z%
LDA VAR_Z%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_N%
LDA VAR_N%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_1950:
;
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_Z%
STA VAR_Z%+1
; Optimizer rule: Fast INTEGER array access (1)/3
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
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_N%
STA VAR_N%+1
; Optimizer rule: Fast INTEGER array access (1)/3
;
LINE_1960:
;
JSR GOSUB
JSR LINE_1800
;
LINE_1970:
;
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_Z%
LDA VAR_Z%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
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
LDY VAR_N%
LDA VAR_N%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_1980:
;
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_3
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_3:
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
JMP RETURN
;
LINE_1999:
;
;
LINE_2000:
;
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_2010:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_CN
LDY #>VAR_CN
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_18R
LDY #>CONST_18R
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
LINE_2020:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_Z%
STA VAR_Z%+1
; Optimizer rule: Fast INTEGER array access (1)/3
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
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_N%
STA VAR_N%+1
; Optimizer rule: Fast INTEGER array access (1)/3
LDY #255
LDA #255
STY VAR_OP%
STA VAR_OP%+1
; Optimized code for negative constants)
;
;
;
;
LINE_2030:
;
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT16
LDA #0
JMP GT_SKIP16
GT_GT16:
LDA #$1
GT_SKIP16:
COMP_SKP29:
BNE LINE_NSKIP51
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP51
;
LINE_NSKIP51:
;
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_OP%[]
LDY #>VAR_OP%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_OP%
STA VAR_OP%+1
; Optimizer rule: Fast INTEGER array access (1)/3
;
LINE_SKIP51:
;
;
LINE_2040:
;
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_PP%
STA VAR_PP%+1
LDA #0
STA VAR_EO
STA VAR_EO+1
STA VAR_EO+2
STA VAR_EO+3
STA VAR_EO+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_3000
;
LINE_2050:
;
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
LINE_2060:
;
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT17
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP17
GT_GT17:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP17:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_EO
LDY #>VAR_EO
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
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP31:
BNE LINE_NSKIP52
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP52
;
LINE_NSKIP52:
;
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDY #2
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_18R
LDY #>CONST_18R
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
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_24
LDY #>CONST_24
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP52:
;
;
LINE_2070:
;
JMP RETURN
;
LINE_3000:
;
;
LINE_3010:
;
LDY VAR_PP%
LDA VAR_PP%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
LDY #3
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_P%
STA VAR_P%+1
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_N%
LDA VAR_N%+1
JSR ICMP
; Optimized code for Integer(2)
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
EQ_EQ19:
EQ_SKIP19:
COMP_SKP32:
BNE LINE_SKIP53
LINE_NSKIP53:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop3223_1:
LDA CONST_4R,X
STA VAR_EO,X
DEX
BPL dcloop3223_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_3110
;
LINE_SKIP53:
;
;
LINE_3020:
;
LDA #<CONST_26
LDY #>CONST_26
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3030:
;
LDY VAR_P%
LDA VAR_P%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
;
LINE_3040:
;
LDA #$0f
LDY #$27
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_Z%
LDA VAR_Z%+1
JSR ICMP
; Optimized code for Integer(2)
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
BEQ LT_LT_EQ20
ROL
BCC LT_LT20
LT_LT_EQ20:
LDA #0
JMP LT_SKIP20
LT_LT20:
LDA #$1
LT_SKIP20:
COMP_SKP33:
BNE LINE_NSKIP54
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP54
;
LINE_NSKIP54:
;
JSR COMPACTMAX
LDY VAR_Z%
LDA VAR_Z%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR STR
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
LDA #<CONST_28R
LDY #>CONST_28R
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
; ignored: CHGCTX #1
JSR SPC
;
LINE_SKIP54:
;
;
LINE_3050:
;
LDY VAR_Z%
STY TMP_ZP
LDA VAR_Z%+1
STA TMP_ZP+1
JSR INTOUTFAST
; Fast integer print
;
JSR CRSRRIGHT
;
LINE_3060:
;
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDY VAR_P%
LDA VAR_P%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3070:
;
LDA #<CONST_30
LDY #>CONST_30
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_3080:
;
LDY VAR_P%
LDA VAR_P%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
;
LINE_3090:
;
LDA #$0f
LDY #$27
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_N%
LDA VAR_N%+1
JSR ICMP
; Optimized code for Integer(2)
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
BEQ LT_LT_EQ21
ROL
BCC LT_LT21
LT_LT_EQ21:
LDA #0
JMP LT_SKIP21
LT_LT21:
LDA #$1
LT_SKIP21:
COMP_SKP34:
BNE LINE_NSKIP55
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP55
;
LINE_NSKIP55:
;
JSR COMPACTMAX
LDY VAR_N%
LDA VAR_N%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR STR
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
LDA #<CONST_28R
LDY #>CONST_28R
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
; ignored: CHGCTX #1
JSR SPC
;
LINE_SKIP55:
;
;
LINE_3100:
;
LDY VAR_N%
STY TMP_ZP
LDA VAR_N%+1
STA TMP_ZP+1
JSR INTOUTFAST
; Fast integer print
;
JSR CRSRRIGHT
;
LINE_3110:
;
LDA #$ff
LDY #$ff
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_OP%
LDA VAR_OP%+1
JSR ICMP
; Optimized code for Integer(2)
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
BNE NEQ_NEQ22
LDA #0
JMP NEQ_SKIP22
NEQ_NEQ22:
LDA #$1
NEQ_SKIP22:
COMP_SKP35:
BNE LINE_NSKIP56
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP56
;
LINE_NSKIP56:
;
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_P%
LDA VAR_P%+1
JSR INTSUB
; Optimized code for subtracting INTs (1)
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
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
; ignored: CHGCTX #1
JSR SPC
LDA #<VAR_OP$[]
LDY #>VAR_OP$[]
STA G_REG
STY G_REG+1
LDY VAR_OP%
LDA VAR_OP%+1
JSR ARRAYACCESS_STRING_INT
; Optimizer rule: Array index is integer (load)/7
JSR STROUT
;
LINE_SKIP56:
;
;
LINE_3120:
;
JMP RETURN
;
LINE_4000:
;
LDX #4
dcloop3721_1:
LDA CONST_4R,X
STA VAR_SP,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_4010:
;
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
LDY #0
TYA
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_Z1%
STA VAR_Z1%+1
; Optimizer rule: Fast INTEGER array access (2)/3
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
LDY #1
LDA #0
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_N1%
STA VAR_N1%+1
; Optimizer rule: Fast INTEGER array access (2)/3
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
LDY #2
LDA #0
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_Z2%
STA VAR_Z2%+1
; Optimizer rule: Fast INTEGER array access (2)/3
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
LDY #3
LDA #0
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_N2%
STA VAR_N2%+1
; Optimizer rule: Fast INTEGER array access (2)/3
;
LINE_4020:
;
LDA #<VAR_OP%[]
LDY #>VAR_OP%[]
STA G_REG
STY G_REG+1
LDY #0
TYA
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_OP%
STA VAR_OP%+1
; Optimizer rule: Fast INTEGER array access (2)/3
;
LINE_4030:
;
LDY #0
TYA
STY VAR_Z%
STA VAR_Z%+1
STY VAR_N%
STA VAR_N%+1
; Optimizer rule: Accumulate integer loads/6
;
LINE_4040:
;
LDA VAR_OP
COMP_SKP36:
BEQ LINE_SKIP57
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP57:
;
LDA #<CONST_31
LDY #>CONST_31
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_OP
LDY #>VAR_OP
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
JSR END
RTS
;
LINE_SKIP57:
;
;
LINE_4050:
;
LDY VAR_Z2%
LDA VAR_Z2%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
LDY VAR_Z1%
LDA VAR_Z1%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_Z%
STA VAR_Z%+1
LDY VAR_N2%
LDA VAR_N2%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
LDY VAR_N1%
LDA VAR_N1%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_N%
STA VAR_N%+1
JSR GOSUB
JSR LINE_1800
LDY #15
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_4060:
;
LDX #4
dcloop3887_1:
LDA CONST_32R,X
STA VAR_I,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_CN
LDY #>VAR_CN
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_18R
LDY #>CONST_18R
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
LINE_4070:
;
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
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
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
;
LINE_4080:
;
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_OP%
STA VAR_OP%+1
; Optimizer rule: Store and load/3
JSR FIDEX
; Optimizer rule: Fast INTEGER DEC/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_OP%[]
LDY #>VAR_OP%[]
STA G_REG
STY G_REG+1
LDY VAR_OP%
LDA VAR_OP%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_OP%[]
LDY #>VAR_OP%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
;
LINE_4090:
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
LINE_4100:
;
LDY VAR_Z%
LDA VAR_Z%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
LDY #0
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY VAR_N%
LDA VAR_N%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
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
;
LINE_4110:
;
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CN
LDY #>VAR_CN
; FAC to (X/Y)
JSR FACMEM
;
LINE_4120:
;
LDA VAR_CN
BEQ EQ_SKIP23
EQ_EQ23:
JMP LINE_SKIP58
EQ_SKIP23:
COMP_SKP38:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP58:
;
LDA #<CONST_33
LDY #>CONST_33
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MG$
LDY #>VAR_MG$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP58:
;
;
LINE_4130:
;
LDA #<VAR_CN
LDY #>VAR_CN
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA Y_REG
COMP_SKP39:
BNE LINE_NSKIP59
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP59
;
LINE_NSKIP59:
;
JSR COMPACTMAX
LDA #<VAR_SP
LDY #>VAR_SP
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
LDA #<CONST_34
LDY #>CONST_34
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MG$
LDY #>VAR_MG$
JSR COPYSTRING
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_SP
LDY #>VAR_SP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SP
LDY #>VAR_SP
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP59:
;
;
LINE_4140:
;
JSR GOSUB
JSR LINE_2000
JSR GOSUB
JSR LINE_10000
;
LINE_4150:
;
LDA VAR_CN
BEQ EQ_SKIP24
EQ_EQ24:
JMP LINE_SKIP60
EQ_SKIP24:
COMP_SKP40:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP60:
;
JMP LINE_5000
;
LINE_SKIP60:
;
;
LINE_4160:
;
JMP LINE_4010
;
LINE_5000:
;
JSR GOSUB
JSR LINE_2000
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_5010:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_36
LDY #>CONST_36
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
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
LDA #<CONST_37
LDY #>CONST_37
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
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
COMP_SKP41:
BEQ LINE_SKIP61
; Simplified conditional branch
;
LINE_NSKIP61:
;
JMP LINE_5010
;
LINE_SKIP61:
;
;
LINE_5020:
;
LDA #<CONST_36
LDY #>CONST_36
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP42:
BEQ LINE_SKIP62
; Simplified conditional branch
;
LINE_NSKIP62:
;
JSR RUN
;
LINE_SKIP62:
;
;
LINE_5030:
;
LDA #0
STA VAR_CN
STA VAR_CN+1
STA VAR_CN+2
STA VAR_CN+3
STA VAR_CN+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DC
STA VAR_DC+1
STA VAR_DC+2
STA VAR_DC+3
STA VAR_DC+4
; Optimizer rule: Simplified setting to 0/6
LDY VAR_Z%
LDA VAR_Z%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
LDY #0
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY VAR_N%
LDA VAR_N%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
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
;
LINE_5035:
;
LDX #4
dcloop4551_1:
LDA CONST_18R,X
STA VAR_I,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_38R
LDY #>CONST_38R
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
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
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
LINE_5040:
;
JSR GOSUB
JSR LINE_2000
JMP LINE_40
;
LINE_10000:
;
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_MG$
LDY VAR_MG$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR LINEBREAK
;
LINE_10005:
;
LDA #<CONST_40
LDY #>CONST_40
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_10010:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_16
LDY #>CONST_16
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP44:
BEQ LINE_SKIP63
; Simplified conditional branch
;
LINE_NSKIP63:
;
JMP LINE_10010
;
LINE_SKIP63:
;
;
LINE_10020:
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
ARRAYACCESS_INTEGER_SI
STA G_REG
STY G_REG+1
JSR XREGFAC
JSR FACINT
ARRAYACCESS_INTEGER_INT_SI
TAX
TYA
ASL
STA TMP2_ZP
TXA
ROL
STA TMP2_ZP+1
LDA TMP2_ZP
CLC
ADC G_REG
STA TMP_ZP
LDA G_REG+1
ADC TMP2_ZP+1
STA TMP_ZP+1
LDY #1
LDA (TMP_ZP),Y
TAX
DEY
LDA (TMP_ZP),Y
TAY
TXA
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
;	A=B-C => LDY/LDA - TMP3_ZP
FLOATINTSUBSW
JSR INTFAC
JSR FACXREG
LDA #0
STA TMP_FLAG	; flag that the value isn't present in TMP2_ZP
LDY TMP3_ZP
LDA TMP3_ZP+1
JSR INTFAC
JSR XREGARG
JMP FASTFSUBARG
;###################################
;###################################
INTSUBOPT	LDX #0			; Mark as "further int opt possible"
BEQ INTSUBSUB2
INTSUB		LDX #1
INTSUBSUB2	STX INT_FLAG
LDX #128		; Do the fast way for positive numbers
STX TMP_REG
BIT TMP_REG
BEQ INTINTSUB
JMP FLOATINTSUBSW
INTINTSUB	LDX #1			; flag that the value is present in TMP2_ZP
STX TMP_FLAG
PHA
TYA
SEC
SBC TMP3_ZP
TAY
PLA
SBC TMP3_ZP+1
STY TMP2_ZP
STA TMP2_ZP+1
LDX INT_FLAG
BNE INTSUBEND
RTS
INTSUBEND
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
FIDEX		CPY #0
BNE FIDEXNOV
SEC
SBC #$1
FIDEXNOV	DEY
JSR INTFAC
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
STA VAR_CN,Y
STA VAR_X,Y
STA VAR_DC,Y
STA VAR_I,Y
STA VAR_M,Y
STA VAR_K,Y
STA VAR_P,Y
STA VAR_EO,Y
STA VAR_SP,Y
STA VAR_OP,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
STA VAR_Z%
STA VAR_Z%+1
STA VAR_N%
STA VAR_N%+1
LDA #<VAR_FR%[]
LDY #>VAR_FR%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_OP%
STA VAR_OP%+1
LDA #<VAR_OP%[]
LDY #>VAR_OP%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_T%
STA VAR_T%+1
STA VAR_MX%
STA VAR_MX%+1
STA VAR_PP%
STA VAR_PP%+1
STA VAR_P%
STA VAR_P%+1
STA VAR_Z1%
STA VAR_Z1%+1
STA VAR_N1%
STA VAR_N1%+1
STA VAR_Z2%
STA VAR_Z2%+1
STA VAR_N2%
STA VAR_N2%+1
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #147


; CONST: #15

CONST_1R	.REAL 15.0
; CONST: #0

CONST_2R	.REAL 0.0
; CONST: $*
CONST_3	.BYTE 1
.STRG "*"
; CONST: #1

CONST_4R	.REAL 1.0
; CONST: $/
CONST_5	.BYTE 1
.STRG "/"
; CONST: #8

CONST_6R	.REAL 8.0
; CONST: $gleichung!
CONST_7	.BYTE 10
.STRG "gleichung!"
; CONST: $brueche gekuerzt!
CONST_8	.BYTE 17
.STRG "brueche gekuerzt!"
; CONST: $divisionen ersetzt!
CONST_9	.BYTE 19
.STRG "divisionen ersetzt!"
; CONST: $brueche weiter gekuerzt!
CONST_10	.BYTE 24
.STRG "brueche weiter gekuerzt!"
; CONST: ${home}
CONST_11	.BYTE 6
.STRG "{home}"
; CONST: ${home}{down*10}{space*30}
CONST_12	.BYTE 25
.STRG "{home}{down*10}{space*30}"
; CONST: ${home}{down*12}{space*30}
CONST_13	.BYTE 25
.STRG "{home}{down*12}{space*30}"
; CONST: ${home}{down*14}{space*30}
CONST_14	.BYTE 25
.STRG "{home}{down*14}{space*30}"
; CONST: ${home}{down*10}zaehler
CONST_15	.BYTE 22
.STRG "{home}{down*10}zaehler"
; CONST: $
CONST_16	.BYTE 0
.STRG ""
; CONST: $?redo from start
CONST_17	.BYTE 16
.STRG "?redo from start"
; CONST: #2

CONST_18R	.REAL 2.0
; CONST: ${home}{down*12}nenner
CONST_19	.BYTE 21
.STRG "{home}{down*12}nenner"
; CONST: #6

CONST_20R	.REAL 6.0
; CONST: ${home}{down*14}rechenzeichen (* oder /)
CONST_21	.BYTE 39
.STRG "{home}{down*14}rechenzeichen (* oder /)"
; CONST: #-1.0

CONST_22	.REAL -1.0
; CONST: ${home}{down*3}
CONST_23	.BYTE 14
.STRG "{home}{down*3}"
; CONST: $= ?
CONST_24	.BYTE 3
.STRG "= ?"
; CONST: #3


; CONST: ${home}{down*2}
CONST_26	.BYTE 14
.STRG "{home}{down*2}"
; CONST: #9999


; CONST: #5

CONST_28R	.REAL 5.0
; CONST: $-----
CONST_29	.BYTE 5
.STRG "-----"
; CONST: ${home}{down*4}
CONST_30	.BYTE 14
.STRG "{home}{down*4}"
; CONST: $unbekannte operation:
CONST_31	.BYTE 22
.STRG "unbekannte operation: "
; CONST: #4

CONST_32R	.REAL 4.0
; CONST: $loesung!
CONST_33	.BYTE 8
.STRG "loesung!"
; CONST: $schritt
CONST_34	.BYTE 7
.STRG "schritt"
; CONST: ${home}{down*10}ergebnis uebernehmen (j/n)?
CONST_35	.BYTE 42
.STRG "{home}{down*10}ergebnis uebernehmen (j/n)?"
; CONST: $n
CONST_36	.BYTE 1
.STRG "n"
; CONST: $j
CONST_37	.BYTE 1
.STRG "j"
; CONST: #10

CONST_38R	.REAL 10.0
; CONST: ${home}{down*10}
CONST_39	.BYTE 15
.STRG "{home}{down*10}"
; CONST: $taste fuer naechsten schritt!
CONST_40	.BYTE 29
.STRG "taste fuer naechsten schritt!"
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: CN
VAR_CN	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: DC
VAR_DC	.REAL 0.0
; VAR: Z%
VAR_Z%	.WORD 0
; VAR: N%
VAR_N%	.WORD 0
; VAR: FR%[]
.BYTE 0
.WORD 22
VAR_FR%[]	.ARRAY 22
; VAR: OP%
VAR_OP%	.WORD 0
; VAR: OP%[]
.BYTE 0
.WORD 10
VAR_OP%[]	.ARRAY 10
; VAR: I
VAR_I	.REAL 0.0
; VAR: T%
VAR_T%	.WORD 0
; VAR: MX%
VAR_MX%	.WORD 0
; VAR: M
VAR_M	.REAL 0.0
; VAR: K
VAR_K	.REAL 0.0
; VAR: P
VAR_P	.REAL 0.0
; VAR: PP%
VAR_PP%	.WORD 0
; VAR: EO
VAR_EO	.REAL 0.0
; VAR: P%
VAR_P%	.WORD 0
; VAR: SP
VAR_SP	.REAL 0.0
; VAR: Z1%
VAR_Z1%	.WORD 0
; VAR: N1%
VAR_N1%	.WORD 0
; VAR: Z2%
VAR_Z2%	.WORD 0
; VAR: N2%
VAR_N2%	.WORD 0
; VAR: OP
VAR_OP	.REAL 0.0
STRINGVARS_START
; VAR: MG$
VAR_MG$	.WORD EMPTYSTR
; VAR: A$
VAR_A$	.WORD EMPTYSTR
; VAR: TI$
VAR_TI$ .WORD EMPTYSTR
STRINGVARS_END
STRINGARRAYS_START
; VAR: OP$[]
.BYTE 2
.WORD 4
VAR_OP$[]
.WORD EMPTYSTR EMPTYSTR
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
