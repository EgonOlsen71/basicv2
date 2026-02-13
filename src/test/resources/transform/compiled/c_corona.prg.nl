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
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
;
LINE_20:
;
JSR GOSUB
JSR LINE_10000
LDA #0
STA VAR_SC
STA VAR_SC+1
STA VAR_SC+2
STA VAR_SC+3
STA VAR_SC+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_DD
STA VAR_DD+1
STA VAR_DD+2
STA VAR_DD+3
STA VAR_DD+4
LDX #4
dcloop235_1:
LDA CONST_1R,X
STA VAR_IV,X
LDA CONST_2R,X
STA VAR_RC,X
DEX
BPL dcloop235_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_25:
;
JSR GOSUB
JSR LINE_12000
JSR GOSUB
JSR LINE_26130
;
LINE_30:
LDX #4
dcloop235_3:
LDA CONST_3R,X
STA VAR_X,X
LDA CONST_4R,X
STA VAR_Y,X
DEX
BPL dcloop235_3
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_DF
STA VAR_DF+1
STA VAR_DF+2
STA VAR_DF+3
STA VAR_DF+4
LDX #4
dcloop235_5:
LDA CONST_5,X
STA VAR_XD,X
LDA CONST_5,X
STA VAR_YD,X
DEX
BPL dcloop235_5
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_9000
;
LINE_40:
;
LDX #4
dcloop235_7:
LDA CONST_6R,X
STA VAR_V,X
DEX
BPL dcloop235_7
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11000
JSR GOSUB
JSR LINE_11100
JSR GOSUB
JSR LINE_10500
;
LINE_50:
;
JSR GOSUB
JSR LINE_25000
JSR GOSUB
JSR LINE_20000
;
LINE_60:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_DF
LDY #>VAR_DF
JSR CMPFAC
EQ_EQ0:
EQ_SKIP0:
COMP_SKP0:
BNE LINE_SKIP41
LINE_NSKIP41:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_22000
;
LINE_SKIP41:
;
;
LINE_70:
;
JSR GOSUB
JSR LINE_29000
JMP LINE_50
;
LINE_9000:
;
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XV
LDY #>VAR_XV
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_8
LDY #>CONST_8
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_7R
LDY #>CONST_7R
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
LINE_9010:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_1R
LDY #>CONST_1R
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XV
LDY #>VAR_XV
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YV
LDY #>VAR_YV
; FAC to (X/Y)
JSR FACMEM
;
LINE_9020:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_YV
LDY #>VAR_YV
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
LDA #<VAR_XV
LDY #>VAR_XV
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
LDA #<CONST_12R
LDY #>CONST_12R
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
LDA #<VAR_VP%[]
LDY #>VAR_VP%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #5
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_VS%[]
LDY #>VAR_VS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_9030:
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
LINE_9040:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_IV
LDY #>VAR_IV
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_7R
LDY #>CONST_7R
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
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #10
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_VS%[]
LDY #>VAR_VS%[]
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
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
JMP RETURN
;
LINE_10000:
;
LDY #1
STY 646
; Optimizer rule: Simple POKE/2
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_10005:
;
LDY #4
STY 211
; Optimizer rule: Simple POKE/2
LDY #5
STY 214
; Optimizer rule: Simple POKE/2
LDY #1
STY 646
; Optimizer rule: Simple POKE/2
LDA #<58640
STA TMP_ZP
LDA #>58640
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_10006:
;
LDA #<CONST_14
LDY #>CONST_14
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10010:
;
LDX #4
dcloop733_1:
LDA CONST_15R,X
STA VAR_I,X
DEX
BPL dcloop733_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<CONST_18R
LDY #>CONST_18R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP3
CMP A_REG+1
BNE COMP_SKP3
COMP_SKP3:
BNE RBEQ_2
JMP (JUMP_TARGET)
RBEQ_2:
;
LINE_10020:
;
LDX #4
dcloop733_2:
LDA CONST_19R,X
STA VAR_I,X
DEX
BPL dcloop733_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_20R
LDY #>CONST_20R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<CONST_18R
LDY #>CONST_18R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP4
CMP A_REG+1
BNE COMP_SKP4
COMP_SKP4:
BNE RBEQ_3
JMP (JUMP_TARGET)
RBEQ_3:
;
LINE_10030:
;
LDX #4
dcloop733_3:
LDA CONST_21R,X
STA VAR_I,X
DEX
BPL dcloop733_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_22R
LDY #>CONST_22R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<CONST_23R
LDY #>CONST_23R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP5
CMP A_REG+1
BNE COMP_SKP5
COMP_SKP5:
BNE RBEQ_4
JMP (JUMP_TARGET)
RBEQ_4:
;
LINE_10040:
;
LDY #109
STY 1905
; Optimizer rule: Simple POKE/2
LDY #125
STY 1942
; Optimizer rule: Simple POKE/2
;
LINE_10050:
;
LDX #4
dcloop899_1:
LDA CONST_26,X
STA VAR_I,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_27
LDY #>CONST_27
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<CONST_11R
LDY #>CONST_11R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP6
CMP A_REG+1
BNE COMP_SKP6
COMP_SKP6:
BNE RBEQ_5
JMP (JUMP_TARGET)
RBEQ_5:
;
LINE_10060:
;
LDX #4
dcloop899_2:
LDA CONST_28,X
STA VAR_I,X
DEX
BPL dcloop899_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_29
LDY #>CONST_29
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<CONST_11R
LDY #>CONST_11R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP7
CMP A_REG+1
BNE COMP_SKP7
COMP_SKP7:
BNE RBEQ_6
JMP (JUMP_TARGET)
RBEQ_6:
;
LINE_10070:
;
LDX #4
dcloop899_3:
LDA CONST_30,X
STA VAR_I,X
DEX
BPL dcloop899_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_31
LDY #>CONST_31
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<CONST_11R
LDY #>CONST_11R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP8
CMP A_REG+1
BNE COMP_SKP8
COMP_SKP8:
BNE RBEQ_7
JMP (JUMP_TARGET)
RBEQ_7:
;
LINE_10080:
;
JMP RETURN
;
LINE_10500:
;
LDY #4
STY 211
; Optimizer rule: Simple POKE/2
LDY #5
STY 214
; Optimizer rule: Simple POKE/2
LDY #1
STY 646
; Optimizer rule: Simple POKE/2
LDA #<58640
STA TMP_ZP
LDA #>58640
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_10510:
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_11000:
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PS
LDY #>VAR_PS
JSR FACMEM
; Optimizer rule: Omit FAC load/4
LDA #<CONST_12R
LDY #>CONST_12R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_V
LDY #>VAR_V
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF12+1
STA MOVBSELF12+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF12:
STY $FFFF
JMP RETURN
;
LINE_11100:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
LDA #<CONST_33R
LDY #>CONST_33R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
JSR FACWORD
STY MOVBSELF13+1
STA MOVBSELF13+2
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
JSR FACWORD
MOVBSELF13:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
JMP RETURN
;
LINE_12000:
;
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XA
LDY #>VAR_XA
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA VAR_RP
STA VAR_RP+1
STA VAR_RP+2
STA VAR_RP+3
STA VAR_RP+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_34
LDY #>CONST_34
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_7R
LDY #>CONST_7R
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
LINE_12010:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XA
LDY #>VAR_XA
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YA
LDY #>VAR_YA
; FAC to (X/Y)
JSR FACMEM
;
LINE_12020:
;
LDA #<CONST_35
LDY #>CONST_35
JSR REALFAC
LDA #<VAR_XA
LDY #>VAR_XA
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ1
ROL
BCC LT_LT1
LT_LT_EQ1:
LDA #0
JMP LT_SKIP1
LT_LT1:
LDA #$1
LT_SKIP1:
COMP_SKP9:
BEQ LINE_SKIP42
; Simplified conditional branch
;
LINE_NSKIP42:
;
LDA #0
STA VAR_XA
STA VAR_XA+1
STA VAR_XA+2
STA VAR_XA+3
STA VAR_XA+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_12050
;
LINE_SKIP42:
;
;
LINE_12030:
;
LDA #<CONST_35
LDY #>CONST_35
JSR REALFAC
LDA #<VAR_YA
LDY #>VAR_YA
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
COMP_SKP10:
BEQ LINE_SKIP43
; Simplified conditional branch
;
LINE_NSKIP43:
;
LDA #0
STA VAR_YA
STA VAR_YA+1
STA VAR_YA+2
STA VAR_YA+3
STA VAR_YA+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_12050
;
LINE_SKIP43:
;
;
LINE_12040:
;
LDA #<CONST_36
LDY #>CONST_36
JSR REALFAC
LDA #<VAR_XA
LDY #>VAR_XA
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XA
LDY #>VAR_XA
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_36
LDY #>CONST_36
JSR REALFAC
LDA #<VAR_YA
LDY #>VAR_YA
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YA
LDY #>VAR_YA
; FAC to (X/Y)
JSR FACMEM
;
LINE_12050:
;
LDA #<VAR_XA
LDY #>VAR_XA
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = SGN(FAC)
JSR FACSIG
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XA
LDY #>VAR_XA
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_YA
LDY #>VAR_YA
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = SGN(FAC)
JSR FACSIG
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
LDX #<VAR_YA
LDY #>VAR_YA
; FAC to (X/Y)
JSR FACMEM
;
LINE_12060:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_YA
LDY #>VAR_YA
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_YA%[]
LDY #>VAR_YA%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XA
LDY #>VAR_XA
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XA%[]
LDY #>VAR_XA%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
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
JMP RETURN
;
LINE_20000:
;
LDY 56320
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_J
LDY #>VAR_J
; FAC to (X/Y)
JSR FACMEM
;
LINE_20010:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ3:
EQ_SKIP3:
COMP_SKP12:
BNE LINE_SKIP44
LINE_NSKIP44:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_20100
;
LINE_SKIP44:
;
;
LINE_20020:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Y
LDY #>VAR_Y
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y2
LDY #>VAR_Y2
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFAC
LDA #<VAR_Y2
LDY #>VAR_Y2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ4
ROL
BCC LT_LT4
LT_LT_EQ4:
LDA #0
JMP LT_SKIP4
LT_LT4:
LDA #$1
LT_SKIP4:
COMP_SKP13:
BEQ LINE_SKIP45
; Simplified conditional branch
;
LINE_NSKIP45:
;
JMP LINE_20100
;
LINE_SKIP45:
;
;
LINE_20030:
;
LDX #4
dcloop1563_1:
LDA CONST_37R,X
STA VAR_V,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11000
LDX #4
dcloop1563_2:
LDA VAR_Y2,X
STA VAR_Y,X
LDA CONST_6R,X
STA VAR_V,X
DEX
BPL dcloop1563_2
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11000
;
LINE_20100:
;
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ5:
EQ_SKIP5:
COMP_SKP14:
BNE LINE_SKIP46
LINE_NSKIP46:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_20200
;
LINE_SKIP46:
;
;
LINE_20110:
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
LDX #<VAR_Y2
LDY #>VAR_Y2
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_38R
LDY #>CONST_38R
JSR REALFAC
LDA #<VAR_Y2
LDY #>VAR_Y2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT6
LDA #0
JMP GT_SKIP6
GT_GT6:
LDA #$1
GT_SKIP6:
COMP_SKP15:
BEQ LINE_SKIP47
; Simplified conditional branch
;
LINE_NSKIP47:
;
JMP LINE_20200
;
LINE_SKIP47:
;
;
LINE_20120:
;
LDX #4
dcloop1563_4:
LDA CONST_37R,X
STA VAR_V,X
DEX
BPL dcloop1563_4
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11000
LDX #4
dcloop1563_5:
LDA VAR_Y2,X
STA VAR_Y,X
LDA CONST_6R,X
STA VAR_V,X
DEX
BPL dcloop1563_5
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11000
;
LINE_20200:
;
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ7:
EQ_SKIP7:
COMP_SKP16:
BNE LINE_SKIP48
LINE_NSKIP48:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_20300
;
LINE_SKIP48:
;
;
LINE_20210:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X2
LDY #>VAR_X2
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ8
ROL
BCC LT_LT8
LT_LT_EQ8:
LDA #0
JMP LT_SKIP8
LT_LT8:
LDA #$1
LT_SKIP8:
COMP_SKP17:
BEQ LINE_SKIP49
; Simplified conditional branch
;
LINE_NSKIP49:
;
JMP LINE_20300
;
LINE_SKIP49:
;
;
LINE_20220:
;
LDX #4
dcloop1729_1:
LDA CONST_37R,X
STA VAR_V,X
DEX
BPL dcloop1729_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11100
LDX #4
dcloop1729_2:
LDA VAR_X2,X
STA VAR_X,X
LDA CONST_6R,X
STA VAR_V,X
DEX
BPL dcloop1729_2
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11100
;
LINE_20300:
;
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ9:
EQ_SKIP9:
COMP_SKP18:
BNE LINE_SKIP50
LINE_NSKIP50:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_20400
;
LINE_SKIP50:
;
;
LINE_20310:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X
LDY #>VAR_X
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X2
LDY #>VAR_X2
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT10
LDA #0
JMP GT_SKIP10
GT_GT10:
LDA #$1
GT_SKIP10:
COMP_SKP19:
BEQ LINE_SKIP51
; Simplified conditional branch
;
LINE_NSKIP51:
;
JMP LINE_20400
;
LINE_SKIP51:
;
;
LINE_20320:
;
LDX #4
dcloop1895_1:
LDA CONST_37R,X
STA VAR_V,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11100
LDX #4
dcloop1895_2:
LDA VAR_X2,X
STA VAR_X,X
LDA CONST_6R,X
STA VAR_V,X
DEX
BPL dcloop1895_2
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_11100
;
LINE_20400:
;
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ11:
EQ_SKIP11:
COMP_SKP20:
BNE LINE_SKIP52
LINE_NSKIP52:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_20500
;
LINE_SKIP52:
;
;
LINE_20410:
LDX #4
dcloop1895_4:
LDA CONST_7R,X
STA VAR_DF,X
LDA VAR_X,X
STA VAR_XD,X
LDA VAR_Y,X
STA VAR_YD,X
LDA CONST_11R,X
STA VAR_XC,X
LDA CONST_38R,X
STA VAR_YC,X
DEX
BPL dcloop1895_4
; Special rule: Aggregation of assignments (5)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_20420:
;
LDA #<VAR_YC
LDY #>VAR_YC
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
LDA #<CONST_12R
LDY #>CONST_12R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_XD
LDY #>VAR_XD
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PX
LDY #>VAR_PX
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF15+1
STA MOVBSELF15+2
MOVBSELF15:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_18R
LDY #>CONST_18R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ13
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP13
EQ_EQ13:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP13:
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
COMP_SKP21:
BEQ LINE_SKIP53
; Simplified conditional branch
;
LINE_NSKIP53:
;
LDX #4
dcloop2061_1:
LDA CONST_5,X
STA VAR_XD,X
DEX
BPL dcloop2061_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP53:
;
;
LINE_20430:
;
LDA #<VAR_YD
LDY #>VAR_YD
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_12R
LDY #>CONST_12R
JSR REALFAC
LDA #<VAR_XC
LDY #>VAR_XC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PY
LDY #>VAR_PY
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF16+1
STA MOVBSELF16+2
MOVBSELF16:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ15
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP15
EQ_EQ15:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP15:
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
COMP_SKP22:
BEQ LINE_SKIP54
; Simplified conditional branch
;
LINE_NSKIP54:
;
LDX #4
dcloop2393_1:
LDA CONST_5,X
STA VAR_YD,X
DEX
BPL dcloop2393_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP54:
;
;
LINE_20500:
;
JMP RETURN
;
LINE_22000:
;
LDX #4
dceloop4816_1:
LDA CONST_5,X
CMP VAR_XD,X
BNE LINE_SKIP55
DEX
BPL dceloop4816_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP55:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_23000
;
LINE_SKIP55:
;
;
LINE_22010:
;
LDA #<VAR_YC
LDY #>VAR_YC
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
LDA #<CONST_12R
LDY #>CONST_12R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_XD
LDY #>VAR_XD
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PX
LDY #>VAR_PX
; FAC to (X/Y)
JSR FACMEM
;
LINE_22015:
;
LDA #<VAR_PX
LDY #>VAR_PX
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF17+1
STA MOVBSELF17+2
MOVBSELF17:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDX #4
dceloop4816_2:
LDA CONST_43R,X
CMP VAR_P,X
BNE LINE_SKIP56
DEX
BPL dceloop4816_2
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP56:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2559_1:
LDA CONST_37R,X
STA VAR_P,X
DEX
BPL dcloop2559_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_26000
;
LINE_SKIP56:
;
;
LINE_22018:
;
LDX #4
dceloop4816_3:
LDA CONST_37R,X
CMP VAR_P,X
BNE LINE_SKIP57
DEX
BPL dceloop4816_3
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP57:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2559_2:
LDA CONST_18R,X
STA VAR_P,X
DEX
BPL dcloop2559_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_22200
;
LINE_SKIP57:
;
;
LINE_22020:
;
LDX #4
dceloop4816_4:
LDA CONST_23R,X
CMP VAR_P,X
BNE LINE_SKIP58
DEX
BPL dceloop4816_4
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP58:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2559_3:
LDA CONST_42R,X
STA VAR_P,X
DEX
BPL dcloop2559_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP58:
;
;
LINE_22200:
;
LDA #<VAR_PX
LDY #>VAR_PX
JSR REALFAC
LDA #<CONST_44
LDY #>CONST_44
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF18+1
STA MOVBSELF18+2
LDA #$7
MOVBSELF18:
STA $FFFF
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
LDA #<VAR_PX
LDY #>VAR_PX
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF19+1
STA MOVBSELF19+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF19:
STY $FFFF
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
LDA #<VAR_PX
LDY #>VAR_PX
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PX
LDY #>VAR_PX
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_YC
LDY #>VAR_YC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YC
LDY #>VAR_YC
; FAC to (X/Y)
JSR FACMEM
;
LINE_22210:
;
LDA #<CONST_5
LDY #>CONST_5
JSR REALFAC
LDA #<VAR_YC
LDY #>VAR_YC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT20
LDA #0
JMP GT_SKIP20
GT_GT20:
LDA #$1
GT_SKIP20:
COMP_SKP27:
BEQ LINE_SKIP59
; Simplified conditional branch
;
LINE_NSKIP59:
;
JMP LINE_22015
;
LINE_SKIP59:
;
;
LINE_23000:
;
LDX #4
dceloop4816_5:
LDA CONST_5,X
CMP VAR_YD,X
BNE LINE_SKIP60
DEX
BPL dceloop4816_5
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP60:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_24000
;
LINE_SKIP60:
;
;
LINE_23010:
;
LDA #<VAR_YD
LDY #>VAR_YD
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_12R
LDY #>CONST_12R
JSR REALFAC
LDA #<VAR_XC
LDY #>VAR_XC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PY
LDY #>VAR_PY
; FAC to (X/Y)
JSR FACMEM
;
LINE_23015:
;
LDA #<VAR_PY
LDY #>VAR_PY
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF20+1
STA MOVBSELF20+2
MOVBSELF20:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDX #4
dceloop4816_6:
LDA CONST_43R,X
CMP VAR_P,X
BNE LINE_SKIP61
DEX
BPL dceloop4816_6
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP61:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2891_1:
LDA CONST_37R,X
STA VAR_P,X
DEX
BPL dcloop2891_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_26050
;
LINE_SKIP61:
;
;
LINE_23018:
;
LDX #4
dceloop4816_7:
LDA CONST_37R,X
CMP VAR_P,X
BNE LINE_SKIP62
DEX
BPL dceloop4816_7
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP62:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2891_2:
LDA CONST_23R,X
STA VAR_P,X
DEX
BPL dcloop2891_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_23200
;
LINE_SKIP62:
;
;
LINE_23020:
;
LDX #4
dceloop4816_8:
LDA CONST_18R,X
CMP VAR_P,X
BNE LINE_SKIP63
DEX
BPL dceloop4816_8
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP63:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2891_3:
LDA CONST_42R,X
STA VAR_P,X
DEX
BPL dcloop2891_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP63:
;
;
LINE_23200:
;
LDA #<VAR_PY
LDY #>VAR_PY
JSR REALFAC
LDA #<CONST_44
LDY #>CONST_44
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
LDA #$7
MOVBSELF21:
STA $FFFF
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
LDA #<VAR_PY
LDY #>VAR_PY
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF22+1
STA MOVBSELF22+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF22:
STY $FFFF
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_PY
LDY #>VAR_PY
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PY
LDY #>VAR_PY
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_XC
LDY #>VAR_XC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XC
LDY #>VAR_XC
; FAC to (X/Y)
JSR FACMEM
;
LINE_23210:
;
LDA #<CONST_46R
LDY #>CONST_46R
JSR REALFAC
LDA #<VAR_XC
LDY #>VAR_XC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ25
ROL
BCC LT_LT25
LT_LT_EQ25:
LDA #0
JMP LT_SKIP25
LT_LT25:
LDA #$1
LT_SKIP25:
COMP_SKP32:
BEQ LINE_SKIP64
; Simplified conditional branch
;
LINE_NSKIP64:
;
JMP LINE_23015
;
LINE_SKIP64:
;
;
LINE_24000:
LDX #4
dcloop3057_1:
LDA CONST_5,X
STA VAR_XD,X
LDA CONST_5,X
STA VAR_YD,X
DEX
BPL dcloop3057_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_25000:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_8
LDY #>CONST_8
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_7R
LDY #>CONST_7R
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
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VS%[]
LDY #>VAR_VS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_SI
LDY #>VAR_SI
; FAC to (X/Y)
JSR FACMEM
;
LINE_25005:
;
JSR GOSUB
JSR LINE_28000
LDX #4
dceloop4816_9:
LDA CONST_47R,X
CMP VAR_SI,X
BNE LINE_SKIP65
DEX
BPL dceloop4816_9
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP65:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_25100
;
LINE_SKIP65:
;
;
LINE_25010:
;
LDA #<VAR_RP
LDY #>VAR_RP
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_XA%[]
LDY #>VAR_XA%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDX #<VAR_XA
LDY #>VAR_XA
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<VAR_RP
LDY #>VAR_RP
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_YA%[]
LDY #>VAR_YA%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDX #<VAR_YA
LDY #>VAR_YA
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_RP
LDY #>VAR_RP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_RP
LDY #>VAR_RP
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_34
LDY #>CONST_34
JSR REALFAC
LDA #<VAR_RP
LDY #>VAR_RP
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT27
LDA #0
JMP GT_SKIP27
GT_GT27:
LDA #$1
GT_SKIP27:
COMP_SKP34:
BEQ LINE_SKIP66
; Simplified conditional branch
;
LINE_NSKIP66:
;
LDA #0
STA VAR_RP
STA VAR_RP+1
STA VAR_RP+2
STA VAR_RP+3
STA VAR_RP+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP66:
;
;
LINE_25020:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VP%[]
LDY #>VAR_VP%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDX #<VAR_PO
LDY #>VAR_PO
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<CONST_5
LDY #>CONST_5
JSR REALFAC
LDA #<VAR_YA
LDY #>VAR_YA
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ28
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP28
EQ_EQ28:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP28:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFAC
LDA #<VAR_PO
LDY #>VAR_PO
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ29
ROL
BCC LT_LT29
LT_LT_EQ29:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP29
LT_LT29:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP29:
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
COMP_SKP35:
BEQ LINE_SKIP67
; Simplified conditional branch
;
LINE_NSKIP67:
;
LDA #0
STA VAR_YA
STA VAR_YA+1
STA VAR_YA+2
STA VAR_YA+3
STA VAR_YA+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP67:
;
;
LINE_25030:
;
LDA #<VAR_XA
LDY #>VAR_XA
JSR REALFAC
LDA #<VAR_PO
LDY #>VAR_PO
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_YA
LDY #>VAR_YA
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PN
LDY #>VAR_PN
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF23+1
STA MOVBSELF23+2
MOVBSELF23:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
;
LINE_25040:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_SI
LDY #>VAR_SI
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_43R
LDY #>CONST_43R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ31
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP31
EQ_EQ31:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP31:
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
COMP_SKP36:
BEQ LINE_SKIP68
; Simplified conditional branch
;
LINE_NSKIP68:
;
JSR GOSUB
JSR LINE_27000
JMP LINE_25100
;
LINE_SKIP68:
;
;
LINE_25050:
;
LDX #4
dcneloop4817_1:
LDA CONST_37R,X
CMP VAR_P,X
BNE LINE_NSKIP69
DEX
BPL dcneloop4817_1
JMP LINE_SKIP69
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP69:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_25100
;
LINE_SKIP69:
;
;
LINE_25060:
;
LDA #<VAR_PN
LDY #>VAR_PN
JSR REALFAC
LDA #<CONST_44
LDY #>CONST_44
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
JSR FACWORD
STY MOVBSELF24+1
STA MOVBSELF24+2
LDA #<VAR_SI
LDY #>VAR_SI
JSR REALFAC
JSR FACWORD
MOVBSELF24:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDA #<VAR_PO
LDY #>VAR_PO
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF25+1
STA MOVBSELF25+2
LDA #$20
MOVBSELF25:
STA $FFFF
LDA #<VAR_PN
LDY #>VAR_PN
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF26+1
STA MOVBSELF26+2
LDA #$5A
MOVBSELF26:
STA $FFFF
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_PN
LDY #>VAR_PN
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VP%[]
LDY #>VAR_VP%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_25100:
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
JMP RETURN
;
LINE_26000:
;
LDA #<VAR_PX
LDY #>VAR_PX
JSR REALFAC
LDA #<CONST_44
LDY #>CONST_44
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
LDY #15
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDX #<VAR_SV
LDY #>VAR_SV
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDX #4
dcloop3555_1:
LDA VAR_PX,X
STA VAR_PP,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_26100
;
LINE_26050:
;
LDA #<VAR_PY
LDY #>VAR_PY
JSR REALFAC
LDA #<CONST_44
LDY #>CONST_44
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
LDY #15
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDX #<VAR_SV
LDY #>VAR_SV
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDX #4
dcloop3555_2:
LDA VAR_PY,X
STA VAR_PP,X
DEX
BPL dcloop3555_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_26100
;
LINE_26100:
;
JSR GOSUB
JSR LINE_26500
;
LINE_26110:
;
LDX #4
dceloop4816_10:
LDA CONST_4R,X
CMP VAR_SV,X
BNE LINE_SKIP70
DEX
BPL dceloop4816_10
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP70:
; Optimizer rule: Simplified equal comparison/6
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_IV
LDY #>VAR_IV
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_IV
LDY #>VAR_IV
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP70:
;
;
LINE_26120:
;
LDA #<CONST_47R
LDY #>CONST_47R
JSR REALFAC
LDA #<VAR_SV
LDY #>VAR_SV
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ34
LDA #0
JMP NEQ_SKIP34
NEQ_NEQ34:
LDA #$1
NEQ_SKIP34:
COMP_SKP40:
BNE LINE_NSKIP71
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP71
;
LINE_NSKIP71:
;
LDA #<CONST_50R
LDY #>CONST_50R
JSR REALFAC
LDA #<VAR_SC
LDY #>VAR_SC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SC
LDY #>VAR_SC
; FAC to (X/Y)
JSR FACMEM
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
LINE_SKIP71:
;
;
LINE_26130:
;
LDY #2
STY 211
; Optimizer rule: Simple POKE/2
LDY #24
STY 214
; Optimizer rule: Simple POKE/2
LDY #12
STY 646
; Optimizer rule: Simple POKE/2
LDA #<58640
STA TMP_ZP
LDA #>58640
STA TMP_ZP+1
JSR SYSTEMCALL
LDA #<CONST_53
LDY #>CONST_53
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_SC
LDY #>VAR_SC
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
;
LINE_26140:
;
JMP RETURN
;
LINE_26500:
;
LDA #0
STA VAR_O
STA VAR_O+1
STA VAR_O+2
STA VAR_O+3
STA VAR_O+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_8
LDY #>CONST_8
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_O
LDY #>VAR_O
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VP%[]
LDY #>VAR_VP%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDA #<VAR_PP
LDY #>VAR_PP
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ35:
EQ_SKIP35:
COMP_SKP41:
BNE LINE_SKIP72
LINE_NSKIP72:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #11
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_VS%[]
LDY #>VAR_VS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
JMP RETURN
;
LINE_SKIP72:
;
;
LINE_26510:
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
JMP RETURN
;
LINE_27000:
;
LDX #4
dcloop3887_1:
LDA VAR_PN,X
STA VAR_PX,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_27010:
;
LDA #0
STA VAR_O
STA VAR_O+1
STA VAR_O+2
STA VAR_O+3
STA VAR_O+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_8
LDY #>CONST_8
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_O
LDY #>VAR_O
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ36
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP36
NEQ_NEQ36:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP36:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VP%[]
LDY #>VAR_VP%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDA #<VAR_PX
LDY #>VAR_PX
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ37
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP37
EQ_EQ37:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP37:
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
COMP_SKP43:
BEQ LINE_SKIP73
; Simplified conditional branch
;
LINE_NSKIP73:
;
JMP LINE_27050
;
LINE_SKIP73:
;
;
LINE_27020:
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
JMP RETURN
;
LINE_27050:
;
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VS%[]
LDY #>VAR_VS%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDX #<VAR_VO
LDY #>VAR_VO
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDX #4
dcloop4053_1:
LDA CONST_4R,X
STA VAR_NS,X
DEX
BPL dcloop4053_1
; Optimizer rule: Direct copy of floats into mem/6
LDX #4
dceloop4816_11:
LDA CONST_54R,X
CMP VAR_VO,X
BNE LINE_SKIP74
DEX
BPL dceloop4816_11
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP74:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop4053_2:
LDA CONST_54R,X
STA VAR_NS,X
DEX
BPL dcloop4053_2
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_26130
;
LINE_SKIP74:
;
;
LINE_27055:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_NS
LDY #>VAR_NS
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ39
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP39
EQ_EQ39:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP39:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_47R
LDY #>CONST_47R
JSR REALFAC
LDA #<VAR_VO
LDY #>VAR_VO
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ40
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP40
NEQ_NEQ40:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP40:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_VO
LDY #>VAR_VO
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ41
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP41
NEQ_NEQ41:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP41:
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
COMP_SKP46:
BNE LINE_NSKIP75
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP75
;
LINE_NSKIP75:
;
LDA #<CONST_3R
LDY #>CONST_3R
JSR REALFAC
LDA #<VAR_SC
LDY #>VAR_SC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SC
LDY #>VAR_SC
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_IV
LDY #>VAR_IV
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_IV
LDY #>VAR_IV
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_26130
;
LINE_SKIP75:
;
;
LINE_27060:
;
LDX #4
dcloop4219_1:
LDA VAR_PO,X
STA VAR_PN,X
DEX
BPL dcloop4219_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_NS
LDY #>VAR_NS
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VS%[]
LDY #>VAR_VS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #0
STA VAR_XA
STA VAR_XA+1
STA VAR_XA+2
STA VAR_XA+3
STA VAR_XA+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_YA
STA VAR_YA+1
STA VAR_YA+2
STA VAR_YA+3
STA VAR_YA+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_27070:
;
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VP%[]
LDY #>VAR_VP%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_44
LDY #>CONST_44
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
LDA #<VAR_NS
LDY #>VAR_NS
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF30+1
STA MOVBSELF30+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF30:
STY $FFFF
JMP RETURN
;
LINE_28000:
;
LDX #4
dcneloop4817_2:
LDA CONST_4R,X
CMP VAR_SI,X
BNE LINE_NSKIP76
DEX
BPL dcneloop4817_2
JMP LINE_SKIP76
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP76:
; Optimizer rule: Simplified not equal comparison/6
;
JMP RETURN
;
LINE_SKIP76:
;
;
LINE_28010:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_R
LDY #>VAR_R
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_55
LDY #>CONST_55
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ43
ROL
BCC LT_LT43
LT_LT_EQ43:
LDA #0
JMP LT_SKIP43
LT_LT43:
LDA #$1
LT_SKIP43:
COMP_SKP48:
BNE LINE_NSKIP77
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP77
;
LINE_NSKIP77:
;
LDX #4
dcloop4385_1:
LDA CONST_47R,X
STA VAR_SI,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_IV
LDY #>VAR_IV
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_IV
LDY #>VAR_IV
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_56R
LDY #>CONST_56R
JSR REALFAC
LDA #<VAR_SC
LDY #>VAR_SC
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SC
LDY #>VAR_SC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP77:
;
;
LINE_28020:
;
LDA #<CONST_57
LDY #>CONST_57
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT44
LDA #0
JMP GT_SKIP44
GT_GT44:
LDA #$1
GT_SKIP44:
COMP_SKP49:
BNE LINE_NSKIP78
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP78
;
LINE_NSKIP78:
;
LDX #4
dcloop4551_1:
LDA CONST_54R,X
STA VAR_SI,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_IV
LDY #>VAR_IV
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_IV
LDY #>VAR_IV
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
LDA #<VAR_SC
LDY #>VAR_SC
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SC
LDY #>VAR_SC
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP78:
;
;
LINE_28030:
;
JSR GOSUB
JSR LINE_28100
JMP RETURN
;
LINE_28100:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_SI
LDY #>VAR_SI
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VS%[]
LDY #>VAR_VS%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_VP%[]
LDY #>VAR_VP%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_44
LDY #>CONST_44
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
LDA #<VAR_SI
LDY #>VAR_SI
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF31+1
STA MOVBSELF31+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF31:
STY $FFFF
JMP RETURN
;
LINE_29000:
;
LDA #<CONST_0R
LDY #>CONST_0R
JSR REALFAC
LDA #<VAR_IV
LDY #>VAR_IV
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT45
LDA #0
JMP GT_SKIP45
GT_GT45:
LDA #$1
GT_SKIP45:
COMP_SKP50:
BEQ LINE_SKIP79
; Simplified conditional branch
;
LINE_NSKIP79:
;
JMP RETURN
;
LINE_SKIP79:
;
;
LINE_29010:
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<CONST_8
LDY #>CONST_8
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_58R
LDY #>CONST_58R
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
LDA #<VAR_SC
LDY #>VAR_SC
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SC
LDY #>VAR_SC
; FAC to (X/Y)
JSR FACMEM
;
LINE_29020:
;
JSR GOSUB
JSR LINE_26130
;
LINE_29030:
;
LDY #3
STY 211
; Optimizer rule: Simple POKE/2
LDY #5
STY 214
; Optimizer rule: Simple POKE/2
LDY #1
STY 646
; Optimizer rule: Simple POKE/2
LDA #<58640
STA TMP_ZP
LDA #>58640
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_29040:
;
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_29050:
;
LDA #<CONST_60
LDY #>CONST_60
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #16
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA X_REG
BEQ EQ_EQ46
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP46
EQ_EQ46:
LDA #$1
EQ_SKIP46:
COMP_SKP51:
BEQ LINE_SKIP80
; Simplified conditional branch
;
LINE_NSKIP80:
;
JMP LINE_29050
;
LINE_SKIP80:
;
;
LINE_29060:
;
LDA #<CONST_60
LDY #>CONST_60
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #16
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA X_REG
BEQ EQ_EQ47
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP47
EQ_EQ47:
LDA #$1
EQ_SKIP47:
COMP_SKP52:
BEQ LINE_SKIP81
; Simplified conditional branch
;
LINE_NSKIP81:
;
JSR RUN
;
LINE_SKIP81:
;
;
LINE_29070:
;
JMP LINE_29060
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
STA VAR_SC,Y
STA VAR_DD,Y
STA VAR_IV,Y
STA VAR_RC,Y
STA VAR_X,Y
STA VAR_Y,Y
STA VAR_DF,Y
STA VAR_XD,Y
STA VAR_YD,Y
STA VAR_V,Y
STA VAR_XV,Y
STA VAR_I,Y
STA VAR_YV,Y
STA VAR_PS,Y
STA VAR_XA,Y
STA VAR_RP,Y
STA VAR_YA,Y
STA VAR_J,Y
STA VAR_Y2,Y
STA VAR_X2,Y
STA VAR_XC,Y
STA VAR_YC,Y
STA VAR_PX,Y
STA VAR_P,Y
STA VAR_PY,Y
STA VAR_SI,Y
STA VAR_PO,Y
STA VAR_PN,Y
STA VAR_SV,Y
STA VAR_PP,Y
STA VAR_O,Y
STA VAR_VO,Y
STA VAR_NS,Y
STA VAR_R,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
LDA #<VAR_VP%[]
LDY #>VAR_VP%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_VS%[]
LDY #>VAR_VS%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_YA%[]
LDY #>VAR_YA%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_XA%[]
LDY #>VAR_XA%[]
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
; CONST: #3

CONST_1R	.REAL 3.0
; CONST: #200

CONST_2R	.REAL 200.0
; CONST: #20

CONST_3R	.REAL 20.0
; CONST: #10

CONST_4R	.REAL 10.0
; CONST: #-1.0

CONST_5	.REAL -1.0
; CONST: #160

CONST_6R	.REAL 160.0
; CONST: #1

CONST_7R	.REAL 1.0
; CONST: #12.0

CONST_8	.REAL 12.0
; CONST: #5


; CONST: #4

CONST_10R	.REAL 4.0
; CONST: #2

CONST_11R	.REAL 2.0
; CONST: #1024

CONST_12R	.REAL 1024.0
; CONST: #147


; CONST: $detecting virus - please wait...
CONST_14	.BYTE 32
.STRG "detecting virus - please wait..."
; CONST: #1025

CONST_15R	.REAL 1025.0
; CONST: #1865

CONST_16R	.REAL 1865.0
; CONST: #40

CONST_17R	.REAL 40.0
; CONST: #93

CONST_18R	.REAL 93.0
; CONST: #1062

CONST_19R	.REAL 1062.0
; CONST: #1902

CONST_20R	.REAL 1902.0
; CONST: #1906

CONST_21R	.REAL 1906.0
; CONST: #1941

CONST_22R	.REAL 1941.0
; CONST: #64

CONST_23R	.REAL 64.0
; CONST: #109


; CONST: #125


; CONST: #55296

CONST_26	.REAL 55296
; CONST: #56256

CONST_27	.REAL 56256
; CONST: #55335

CONST_28	.REAL 55335
; CONST: #56295

CONST_29	.REAL 56295
; CONST: #56216

CONST_30	.REAL 56216
; CONST: #56253.0

CONST_31	.REAL 56253.0
; CONST: $
CONST_32	.BYTE 32
.STRG "                                "
; CONST: #1944

CONST_33R	.REAL 1944.0
; CONST: #200.0

CONST_34	.REAL 200.0
; CONST: #0.2

CONST_35	.REAL 0.2
; CONST: #0.7

CONST_36	.REAL 0.7
; CONST: #32

CONST_37R	.REAL 32.0
; CONST: #21

CONST_38R	.REAL 21.0
; CONST: #8

CONST_39R	.REAL 8.0
; CONST: #37

CONST_40R	.REAL 37.0
; CONST: #16

CONST_41R	.REAL 16.0
; CONST: #91

CONST_42R	.REAL 91.0
; CONST: #90

CONST_43R	.REAL 90.0
; CONST: #54272

CONST_44	.REAL 54272
; CONST: #7


; CONST: #38

CONST_46R	.REAL 38.0
; CONST: #11

CONST_47R	.REAL 11.0
; CONST: #1064

CONST_48R	.REAL 1064.0
; CONST: #15


; CONST: #100

CONST_50R	.REAL 100.0
; CONST: #24


; CONST: #12


; CONST: $score:
CONST_53	.BYTE 7
.STRG "score: "
; CONST: #6

CONST_54R	.REAL 6.0
; CONST: #0.003

CONST_55	.REAL 0.003
; CONST: #30

CONST_56R	.REAL 30.0
; CONST: #0.992

CONST_57	.REAL 0.992
; CONST: #25

CONST_58R	.REAL 25.0
; CONST: $virus exterminated - fire to start
CONST_59	.BYTE 34
.STRG "virus exterminated - fire to start"
; CONST: #56320

CONST_60	.REAL 56320
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: SC
VAR_SC	.REAL 0.0
; VAR: DD
VAR_DD	.REAL 0.0
; VAR: IV
VAR_IV	.REAL 0.0
; VAR: RC
VAR_RC	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: DF
VAR_DF	.REAL 0.0
; VAR: XD
VAR_XD	.REAL 0.0
; VAR: YD
VAR_YD	.REAL 0.0
; VAR: V
VAR_V	.REAL 0.0
; VAR: XV
VAR_XV	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: YV
VAR_YV	.REAL 0.0
; VAR: VP%[]
.BYTE 0
.WORD 26
VAR_VP%[]	.ARRAY 26
; VAR: VS%[]
.BYTE 0
.WORD 26
VAR_VS%[]	.ARRAY 26
; VAR: PS
VAR_PS	.REAL 0.0
; VAR: XA
VAR_XA	.REAL 0.0
; VAR: RP
VAR_RP	.REAL 0.0
; VAR: YA
VAR_YA	.REAL 0.0
; VAR: YA%[]
.BYTE 0
.WORD 402
VAR_YA%[]	.ARRAY 402
; VAR: XA%[]
.BYTE 0
.WORD 402
VAR_XA%[]	.ARRAY 402
; VAR: J
VAR_J	.REAL 0.0
; VAR: Y2
VAR_Y2	.REAL 0.0
; VAR: X2
VAR_X2	.REAL 0.0
; VAR: XC
VAR_XC	.REAL 0.0
; VAR: YC
VAR_YC	.REAL 0.0
; VAR: PX
VAR_PX	.REAL 0.0
; VAR: P
VAR_P	.REAL 0.0
; VAR: PY
VAR_PY	.REAL 0.0
; VAR: SI
VAR_SI	.REAL 0.0
; VAR: PO
VAR_PO	.REAL 0.0
; VAR: PN
VAR_PN	.REAL 0.0
; VAR: SV
VAR_SV	.REAL 0.0
; VAR: PP
VAR_PP	.REAL 0.0
; VAR: O
VAR_O	.REAL 0.0
; VAR: VO
VAR_VO	.REAL 0.0
; VAR: NS
VAR_NS	.REAL 0.0
; VAR: R
VAR_R	.REAL 0.0
STRINGVARS_START
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
