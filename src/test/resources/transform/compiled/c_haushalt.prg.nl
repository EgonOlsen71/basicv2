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
LINE_1:
;
;
LINE_2:
;
;
LINE_6:
;
;
LINE_8:
;
;
LINE_9:
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
;
LINE_40:
;
;
LINE_50:
;
;
LINE_60:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_70:
;
JSR GOSUB
JSR LINE_30000
;
LINE_80:
;
LDA #14
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1000:
;
LDX #4
dcloop235_1:
LDA CONST_2,X
STA VAR_I,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_3
LDY #>CONST_3
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
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
;
LINE_1010:
;
JSR READNUMBER
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_X
LDY #>VAR_X
JSR FACMEM
JSR FACXREG
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDX #<X_REG
; Optimizer rule: Move variable directly in XREG/9
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF1+1
STA MOVBSELF1+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF1:
STY $FFFF
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
LINE_1020:
;
;
LINE_1030:
;
LDX #4
dcloop235_2:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop235_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP1
STA JUMP_TARGET
LDA #>FORLOOP1
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP1:
LDA #<VAR_N
LDY #>VAR_N
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR READSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_MO$[]
LDY #>VAR_MO$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
;
LINE_1040:
;
;
LINE_1050:
;
LDX #4
dcloop235_3:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop235_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR READSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_2
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_2:
;
LINE_1060:
;
LDX #4
dcloop401_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop401_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR COMPACTMAX
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA #<CONST_10
LDY #>CONST_10
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_3
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_3:
;
LINE_1070:
;
;
LINE_2000:
;
LDY #0
STY 53281
; Optimizer rule: Simple POKE/2
STY 53280
; Optimizer rule: Simple POKE/2
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #14
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2010:
;
LDA #<CONST_11
LDY #>CONST_11
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2030:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
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
BEQ LINE_SKIP72
; Simplified conditional branch
;
LINE_NSKIP72:
;
JMP LINE_2030
;
LINE_SKIP72:
;
;
LINE_2040:
;
LDA #<CONST_13
LDY #>CONST_13
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
BEQ LINE_SKIP73
; Simplified conditional branch
;
LINE_NSKIP73:
;
JMP LINE_10110
;
LINE_SKIP73:
;
;
LINE_2041:
;
;
LINE_2050:
;
LDA #<CONST_14
LDY #>CONST_14
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2060:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
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
BEQ LINE_SKIP74
; Simplified conditional branch
;
LINE_NSKIP74:
;
JMP LINE_2060
;
LINE_SKIP74:
;
;
LINE_2070:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP7:
BEQ LINE_SKIP75
; Simplified conditional branch
;
LINE_NSKIP75:
;
JMP LINE_10010
;
LINE_SKIP75:
;
;
LINE_2080:
;
LDA #<CONST_15
LDY #>CONST_15
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2090:
;
LDA #<CONST_16
LDY #>CONST_16
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2100:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP8:
BEQ LINE_SKIP76
; Simplified conditional branch
;
LINE_NSKIP76:
;
JMP LINE_2100
;
LINE_SKIP76:
;
;
LINE_2110:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP9:
BEQ LINE_SKIP77
; Simplified conditional branch
;
LINE_NSKIP77:
;
JMP LINE_10510
;
LINE_SKIP77:
;
;
LINE_2111:
;
;
LINE_2120:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2130:
;
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2140:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP10:
BEQ LINE_SKIP78
; Simplified conditional branch
;
LINE_NSKIP78:
;
JMP LINE_2140
;
LINE_SKIP78:
;
;
LINE_2150:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP11:
BEQ LINE_SKIP79
; Simplified conditional branch
;
LINE_NSKIP79:
;
JMP LINE_10810
;
LINE_SKIP79:
;
;
LINE_2151:
;
;
LINE_2160:
;
LDA #<CONST_18
LDY #>CONST_18
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2170:
;
;
LINE_2180:
;
LDA #<CONST_19
LDY #>CONST_19
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #14
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_20
LDY #>CONST_20
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A$
LDY #>VAR_A$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDX #4
dcloop567_1:
LDA CONST_21R,X
STA VAR_PU,X
DEX
BPL dcloop567_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_2185:
;
LDX #4
dcloop567_2:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop567_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
LDA #<CONST_22
LDY #>CONST_22
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_4
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_4:
;
LINE_2186:
;
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2190:
;
LDX #4
dcloop567_3:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop567_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_5
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_5:
;
LINE_2191:
;
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2192:
;
LDX #4
dcloop733_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop733_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
LDA #<CONST_24R
LDY #>CONST_24R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
;
LINE_2200:
;
LDA #<CONST_25
LDY #>CONST_25
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2205:
;
LDA #<CONST_26
LDY #>CONST_26
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2210:
;
LDA #<CONST_27
LDY #>CONST_27
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_28
LDY #>CONST_28
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2220:
;
;
LINE_2229:
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
COMP_SKP15:
BEQ LINE_SKIP80
; Simplified conditional branch
;
LINE_NSKIP80:
;
JMP LINE_2235
;
LINE_SKIP80:
;
;
LINE_2230:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP16:
BEQ LINE_SKIP81
; Simplified conditional branch
;
LINE_NSKIP81:
;
JMP LINE_2230
;
LINE_SKIP81:
;
;
LINE_2235:
;
JSR COMPACTMAX
LDA #13
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP17:
BNE LINE_NSKIP82
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP82
;
LINE_NSKIP82:
;
LDA #<CONST_30
LDY #>CONST_30
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_PU
LDY #>VAR_PU
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_SKIP82:
;
;
LINE_2240:
;
JSR COMPACTMAX
LDA #17
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP18:
BEQ LINE_SKIP83
; Simplified conditional branch
;
LINE_NSKIP83:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_PU
LDY #>VAR_PU
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PU
LDY #>VAR_PU
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP83:
;
;
LINE_2250:
;
JSR COMPACTMAX
LDA #145
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP19:
BEQ LINE_SKIP84
; Simplified conditional branch
;
LINE_NSKIP84:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_PU
LDY #>VAR_PU
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PU
LDY #>VAR_PU
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP84:
;
;
LINE_2260:
;
JSR COMPACTMAX
LDA #13
JSR CHRINTB
; Optimizer rule: Memory saving CHRINT/1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP20:
BEQ LINE_SKIP85
; Simplified conditional branch
;
LINE_NSKIP85:
;
JSR GOSUB
JSR LINE_5000
;
LINE_SKIP85:
;
;
LINE_2261:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
LDA #<VAR_PU
LDY #>VAR_PU
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT0
LDA #0
JMP GT_SKIP0
GT_GT0:
LDA #$1
GT_SKIP0:
COMP_SKP21:
BEQ LINE_SKIP86
; Simplified conditional branch
;
LINE_NSKIP86:
;
LDX #4
dcloop899_1:
LDA CONST_4R,X
STA VAR_PU,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP86:
;
;
LINE_2262:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_PU
LDY #>VAR_PU
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
COMP_SKP22:
BEQ LINE_SKIP87
; Simplified conditional branch
;
LINE_NSKIP87:
;
LDX #4
dcloop899_2:
LDA CONST_7R,X
STA VAR_PU,X
DEX
BPL dcloop899_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP87:
;
;
LINE_2263:
;
LDA #<CONST_33
LDY #>CONST_33
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP23:
BEQ LINE_SKIP88
; Simplified conditional branch
;
LINE_NSKIP88:
;
JMP LINE_15010
;
LINE_SKIP88:
;
;
LINE_2270:
;
LDA #<CONST_34
LDY #>CONST_34
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2286:
;
LDX #4
dcloop899_3:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop899_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_35R
LDY #>CONST_35R
JSR REALFAC
LDA #<VAR_PU
LDY #>VAR_PU
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_7
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_7:
;
LINE_2290:
;
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_PU
LDY #>VAR_PU
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2300:
;
JMP LINE_2230
;
LINE_5000:
;
LDA #<CONST_34
LDY #>CONST_34
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_SU$
STY VAR_SU$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_5010:
;
INPUT18:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_37
LDY #>CONST_37
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP27
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_SU$
LDY #>VAR_SU$
JSR COPYSTRING
EMPTYINPUTSKIP27:
JSR QUEUESIZE
LDA X_REG
COMP_SKP25:
BEQ INPUTCHECK18
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK18:
JSR LINEBREAK
;
LINE_5011:
;
LDA 1184
CMP #32
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
NEQ_NEQ2:
NEQ_SKIP2:
COMP_SKP26:
BEQ LINE_SKIP89
LINE_NSKIP89:
; Optimizer rule: Simplified not equal comparison/6
;
LDX #4
dcloop1065_1:
LDA CONST_4R,X
STA VAR_V,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP89:
;
;
LINE_5012:
;
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_V
LDY #>VAR_V
JSR CMPFAC
EQ_EQ3:
EQ_SKIP3:
COMP_SKP27:
BNE LINE_SKIP90
LINE_NSKIP90:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_V
STA VAR_V+1
STA VAR_V+2
STA VAR_V+3
STA VAR_V+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_5000
;
LINE_SKIP90:
;
;
LINE_5013:
;
JMP LINE_12000
;
LINE_5014:
;
LDA VAR_SU$
LDY VAR_SU$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_SU
LDY #>VAR_SU
; FAC to (X/Y)
JSR FACMEM
;
LINE_5020:
;
LDA #<VAR_PU
LDY #>VAR_PU
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_PU
LDY #>VAR_PU
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_GS[]
LDY #>VAR_GS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<VAR_SU
LDY #>VAR_SU
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
LDA #<VAR_GS[]
LDY #>VAR_GS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_5025:
;
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_5030:
;
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_5035:
;
LDA #<VAR_PU
LDY #>VAR_PU
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_GS[]
LDY #>VAR_GS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_Y
LDY #>VAR_Y
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR GOSUB
JSR LINE_20000
LDA VAR_Y$
LDY VAR_Y$+1
STA A_REG
STY A_REG+1
LDA #<VAR_PU
LDY #>VAR_PU
JSR COPY2_XYA_XREGFAC
; Optimizer rule: Faster array access setup(2)/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_5040:
;
LDX #4
dcloop1065_2:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop1065_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP8
STA JUMP_TARGET
LDA #>FORLOOP8
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP8:
LDA #<CONST_24R
LDY #>CONST_24R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
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
LINE_5050:
;
JMP RETURN
;
LINE_9999:
;
JSR END
RTS
;
LINE_10000:
;
;
LINE_10010:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10020:
;
LDA #<49152
STA TMP_ZP
LDA #>49152
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_10030:
;
LDA #<CONST_40
LDY #>CONST_40
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10040:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP29:
BEQ LINE_SKIP91
; Simplified conditional branch
;
LINE_NSKIP91:
;
JMP LINE_10040
;
LINE_SKIP91:
;
;
LINE_10050:
;
LDA VAR_OK
BEQ EQ_SKIP4
EQ_EQ4:
JMP LINE_SKIP92
EQ_SKIP4:
COMP_SKP30:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP92:
;
JMP LINE_2000
;
LINE_SKIP92:
;
;
LINE_10051:
;
JMP LINE_2160
;
LINE_10055:
;
LDA #0
STA VAR_OK
STA VAR_OK+1
STA VAR_OK+2
STA VAR_OK+3
STA VAR_OK+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_2160
;
LINE_10060:
;
;
LINE_10100:
;
;
LINE_10110:
;
LDA #142
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10120:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10130:
;
LDA #<CONST_42
LDY #>CONST_42
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10140:
;
INPUT19:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_43
LDY #>CONST_43
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP28
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MO$
LDY #>VAR_MO$
JSR COPYSTRING
EMPTYINPUTSKIP28:
JSR QUEUESIZE
LDA X_REG
COMP_SKP31:
BEQ INPUTCHECK19
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK19:
;
LINE_10150:
;
INPUT20:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP29
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
EMPTYINPUTSKIP29:
JSR QUEUESIZE
LDA X_REG
COMP_SKP32:
BEQ INPUTCHECK20
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK20:
;
LINE_10170:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<CONST_46
LDY #>CONST_46
STA B_REG
STY B_REG+1
LDA VAR_MO$
LDY VAR_MO$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_47
LDY #>CONST_47
STA B_REG
STY B_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY G_REG
STA G_REG+1
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
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_10180:
;
LDX #4
dcloop1231_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP9
STA JUMP_TARGET
LDA #>FORLOOP9
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP9:
;
LINE_10190:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR CLEARQUEUE
JSR COMPACTMAX
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTNUMBERCHANNEL
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP30
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP30:
;
LINE_10200:
;
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_Z
LDY #>VAR_Z
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_GS[]
LDY #>VAR_GS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #0
STA VAR_Z
STA VAR_Z+1
STA VAR_Z+2
STA VAR_Z+3
STA VAR_Z+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_10210:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_9
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_9:
;
LINE_10221:
;
;
LINE_10230:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_10233:
;
LDX #4
dcloop1397_1:
LDA CONST_4R,X
STA VAR_Q,X
DEX
BPL dcloop1397_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Q
LDY #>VAR_Q
STA A_REG
STY A_REG+1
LDA #<FORLOOP10
STA JUMP_TARGET
LDA #>FORLOOP10
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP10:
LDA #<VAR_Q
LDY #>VAR_Q
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_GS[]
LDY #>VAR_GS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_Y
LDY #>VAR_Y
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR GOSUB
JSR LINE_20000
LDA VAR_Y$
LDY VAR_Y$+1
STA A_REG
STY A_REG+1
LDA #<VAR_Q
LDY #>VAR_Q
JSR COPY2_XYA_XREGFAC
; Optimizer rule: Faster array access setup(2)/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_Y$
STY VAR_Y$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<VAR_Q
LDY #>VAR_Q
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_10
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_10:
;
LINE_10235:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_FE
LDY #>VAR_FE
JSR CMPFAC
EQ_EQ5:
EQ_SKIP5:
COMP_SKP35:
BNE LINE_SKIP93
LINE_NSKIP93:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_FE
STA VAR_FE+1
STA VAR_FE+2
STA VAR_FE+3
STA VAR_FE+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_10100
;
LINE_SKIP93:
;
;
LINE_10240:
;
JMP LINE_2160
;
LINE_10250:
;
JSR END
RTS
;
LINE_10260:
;
;
LINE_10300:
;
;
LINE_10310:
;
LDA #<CONST_49
LDY #>CONST_49
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10311:
;
LDA #142
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10315:
;
INPUT21:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_50
LDY #>CONST_50
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP31
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MO$
LDY #>VAR_MO$
JSR COPYSTRING
EMPTYINPUTSKIP31:
JSR QUEUESIZE
LDA X_REG
COMP_SKP36:
BEQ INPUTCHECK21
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK21:
;
LINE_10320:
;
INPUT22:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_51
LDY #>CONST_51
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP32
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
EMPTYINPUTSKIP32:
JSR QUEUESIZE
LDA X_REG
COMP_SKP37:
BEQ INPUTCHECK22
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK22:
;
LINE_10330:
;
INPUT23:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_52
LDY #>CONST_52
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP33
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_UE$
LDY #>VAR_UE$
JSR COPYSTRING
EMPTYINPUTSKIP33:
JSR QUEUESIZE
LDA X_REG
COMP_SKP38:
BEQ INPUTCHECK23
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK23:
;
LINE_10340:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_UE$
LDY VAR_UE$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP39:
BEQ LINE_SKIP94
; Simplified conditional branch
;
LINE_NSKIP94:
;
LDA #<CONST_53
LDY #>CONST_53
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_UE$
LDY #>VAR_UE$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JMP LINE_10360
;
LINE_SKIP94:
;
;
LINE_10350:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_UE$
LDY VAR_UE$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP40:
BEQ LINE_SKIP95
; Simplified conditional branch
;
LINE_NSKIP95:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_UE$
STY VAR_UE$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP95:
;
;
LINE_10360:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA VAR_MO$
LDY VAR_MO$+1
STA B_REG
STY B_REG+1
LDA VAR_UE$
LDY VAR_UE$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA #<CONST_46
LDY #>CONST_46
STA B_REG
STY B_REG+1
JSR CONCAT
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_54
LDY #>CONST_54
STA B_REG
STY B_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY G_REG
STA G_REG+1
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
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_10370:
;
LDX #4
dcloop1563_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP11
STA JUMP_TARGET
LDA #>FORLOOP11
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP11:
;
LINE_10380:
;
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_GS[]
LDY #>VAR_GS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
;
LINE_10390:
;
JSR LOCKCHANNEL
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR REALOUTCHANNEL
LDA #<CONST_46
LDY #>CONST_46
STA A_REG
STY A_REG+1
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_10400:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_11
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_11:
;
LINE_10410:
;
JSR GOSUB
JSR LINE_10710
;
LINE_10411:
;
;
LINE_10420:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_10425:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_FE
LDY #>VAR_FE
JSR CMPFAC
EQ_EQ6:
EQ_SKIP6:
COMP_SKP42:
BNE LINE_SKIP96
LINE_NSKIP96:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_FE
STA VAR_FE+1
STA VAR_FE+2
STA VAR_FE+3
STA VAR_FE+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_10300
;
LINE_SKIP96:
;
;
LINE_10430:
;
LDA #14
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_10440:
;
JSR END
RTS
;
LINE_10450:
;
;
LINE_10460:
;
;
LINE_10500:
;
;
LINE_10510:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #142
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10520:
;
LDA #<CONST_55
LDY #>CONST_55
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_UN
LDY #>VAR_UN
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
JSR LINEBREAK
;
LINE_10540:
;
INPUT24:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_56
LDY #>CONST_56
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP43:
BEQ INPUT24_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_57
LDY #>CONST_57
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP INPUT24
INPUT24_0:
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP34
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP34:
JSR QUEUESIZE
LDA X_REG
COMP_SKP44:
BEQ INPUTCHECK24
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK24:
;
LINE_10542:
;
LDA #<CONST_58
LDY #>CONST_58
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10543:
;
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10544:
;
LDA #<CONST_60
LDY #>CONST_60
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10545:
;
LDX #4
dcloop1729_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop1729_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_X
LDY #>VAR_X
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP12
STA JUMP_TARGET
LDA #>FORLOOP12
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP12:
INPUT25:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_61
LDY #>CONST_61
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP45:
BEQ INPUT25_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_57
LDY #>CONST_57
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP INPUT25
INPUT25_0:
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_M[]
LDY #>VAR_M[]
STA G_REG
STY G_REG+1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP35
JSR ARRAYSTORE_REAL
EMPTYINPUTSKIP35:
JSR QUEUESIZE
LDA X_REG
COMP_SKP46:
BEQ INPUTCHECK25
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK25:
LDA #<CONST_62
LDY #>CONST_62
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDX #4
dcloop1729_2:
LDA CONST_63R,X
STA VAR_P,X
DEX
BPL dcloop1729_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_10546:
;
LDA #<CONST_64
LDY #>CONST_64
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10547:
;
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_M[]
LDY #>VAR_M[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_M[]
LDY #>VAR_M[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
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
COMP_SKP47:
BEQ LINE_SKIP97
; Simplified conditional branch
;
LINE_NSKIP97:
;
JMP LINE_10540
;
LINE_SKIP97:
;
;
LINE_10548:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_12
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_12:
;
LINE_10550:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X
LDY #>VAR_X
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
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
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
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP49:
BEQ LINE_SKIP98
; Simplified conditional branch
;
LINE_NSKIP98:
;
LDA #<CONST_65
LDY #>CONST_65
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_10540
;
LINE_SKIP98:
;
;
LINE_10560:
;
INPUT26:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_66
LDY #>CONST_66
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP36
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
EMPTYINPUTSKIP36:
JSR QUEUESIZE
LDA X_REG
COMP_SKP50:
BEQ INPUTCHECK26
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK26:
;
LINE_10570:
;
LDX #4
dcloop1895_1:
LDA CONST_4R,X
STA VAR_P,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_X
LDY #>VAR_X
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
LDA #<FORLOOP13
STA JUMP_TARGET
LDA #>FORLOOP13
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP13:
LDA #<VAR_P
LDY #>VAR_P
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_M[]
LDY #>VAR_M[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
;
LINE_10580:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<CONST_46
LDY #>CONST_46
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_MO$[]
LDY #>VAR_MO$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_47
LDY #>CONST_47
STA B_REG
STY B_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY G_REG
STA G_REG+1
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
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_10590:
;
LDX #4
dcloop1895_2:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop1895_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP14
STA JUMP_TARGET
LDA #>FORLOOP14
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP14:
;
LINE_10600:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR CLEARQUEUE
JSR COMPACTMAX
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTNUMBERCHANNEL
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_NU[]
LDY #>VAR_NU[]
STA G_REG
STY G_REG+1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP37
JSR ARRAYSTORE_REAL
EMPTYINPUTSKIP37:
;
LINE_10610:
;
LDA #<VAR_N
LDY #>VAR_N
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_NU[]
LDY #>VAR_NU[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_GS[]
LDY #>VAR_GS[]
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
LDA #<VAR_GS[]
LDY #>VAR_GS[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_10620:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_13
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_13:
;
LINE_10630:
;
JSR GOSUB
JSR LINE_10710
;
LINE_10631:
;
;
LINE_10635:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_FE
LDY #>VAR_FE
JSR CMPFAC
EQ_EQ11:
EQ_SKIP11:
COMP_SKP52:
BNE LINE_SKIP99
LINE_NSKIP99:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_FE
STA VAR_FE+1
STA VAR_FE+2
STA VAR_FE+3
STA VAR_FE+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_10510
;
LINE_SKIP99:
;
;
LINE_10640:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_MO$[]
LDY #>VAR_MO$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUT
LDA #<CONST_67
LDY #>CONST_67
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10650:
;
LDA #<VAR_P
LDY #>VAR_P
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_14
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_14:
;
LINE_10651:
;
LDX #4
dcloop2061_1:
LDA CONST_4R,X
STA VAR_Q,X
DEX
BPL dcloop2061_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Q
LDY #>VAR_Q
STA A_REG
STY A_REG+1
LDA #<FORLOOP15
STA JUMP_TARGET
LDA #>FORLOOP15
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP15:
LDA #<VAR_Q
LDY #>VAR_Q
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_GS[]
LDY #>VAR_GS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_Y
LDY #>VAR_Y
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR GOSUB
JSR LINE_20000
LDA VAR_Y$
LDY VAR_Y$+1
STA A_REG
STY A_REG+1
LDA #<VAR_Q
LDY #>VAR_Q
JSR COPY2_XYA_XREGFAC
; Optimizer rule: Faster array access setup(2)/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_Y$
STY VAR_Y$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<VAR_Q
LDY #>VAR_Q
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_15
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_15:
;
LINE_10660:
;
JMP LINE_2160
;
LINE_10670:
;
;
LINE_10680:
;
;
LINE_10690:
;
JSR END
RTS
;
LINE_10700:
;
;
LINE_10710:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10711:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_7R
LDY #>CONST_7R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_10720:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
JSR CLEARQUEUE
JSR COMPACTMAX
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTNUMBERCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP38
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP38:
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTSTRCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP39
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_B$
LDY #>VAR_B$
JSR COPYSTRING
EMPTYINPUTSKIP39:
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTNUMBERCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP40
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP40:
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTNUMBERCHANNEL
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP41
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP41:
;
LINE_10725:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_10730:
;
LDA #<VAR_A
LDY #>VAR_A
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA VAR_B$
LDY VAR_B$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_C
LDY #>VAR_C
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<VAR_D
LDY #>VAR_D
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10740:
;
LDA #<CONST_68
LDY #>CONST_68
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA VAR_A
COMP_SKP55:
BEQ LINE_SKIP100
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP100:
;
LDX #4
dcloop2227_1:
LDA CONST_4R,X
STA VAR_FE,X
DEX
BPL dcloop2227_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP100:
;
;
LINE_10750:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP56:
BEQ LINE_SKIP101
; Simplified conditional branch
;
LINE_NSKIP101:
;
JMP LINE_10750
;
LINE_SKIP101:
;
;
LINE_10751:
;
LDA #<CONST_69
LDY #>CONST_69
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10760:
;
LDA VAR_FE
COMP_SKP57:
BEQ LINE_SKIP102
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP102:
;
LDA #14
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
JMP LINE_2000
;
LINE_SKIP102:
;
;
LINE_10770:
;
JMP RETURN
;
LINE_10780:
;
;
LINE_10790:
;
JSR END
RTS
;
LINE_10800:
;
;
LINE_10810:
;
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10820:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP58:
BEQ LINE_SKIP103
; Simplified conditional branch
;
LINE_NSKIP103:
;
JMP LINE_10820
;
LINE_SKIP103:
;
;
LINE_10825:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP59:
BEQ LINE_SKIP104
; Simplified conditional branch
;
LINE_NSKIP104:
;
JMP LINE_10840
;
LINE_SKIP104:
;
;
LINE_10830:
;
JSR RUN
;
LINE_10840:
;
JSR END
RTS
;
LINE_10850:
;
;
LINE_10860:
;
;
LINE_10870:
;
JSR END
RTS
;
LINE_11000:
;
;
LINE_11010:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_E$
STY VAR_E$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_M$
STY VAR_M$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_J$
STY VAR_J$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #142
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_11020:
;
LDA #<CONST_71
LDY #>CONST_71
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_11030:
;
INPUT27:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_72
LDY #>CONST_72
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP42
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_M$
LDY #>VAR_M$
JSR COPYSTRING
EMPTYINPUTSKIP42:
JSR QUEUESIZE
LDA X_REG
COMP_SKP60:
BEQ INPUTCHECK27
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK27:
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_M$
LDY VAR_M$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP61:
BEQ LINE_SKIP105
; Simplified conditional branch
;
LINE_NSKIP105:
;
JMP LINE_11090
;
LINE_SKIP105:
;
;
LINE_11040:
;
LDX #4
dcloop2393_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop2393_1
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_M$
LDY VAR_M$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP16
STA JUMP_TARGET
LDA #>FORLOOP16
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP16:
;
LINE_11050:
;
JSR COMPACTMAX
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA VAR_M$
LDY VAR_M$+1
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
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
;
LINE_11060:
;
LDA #<CONST_73R
LDY #>CONST_73R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT12
LDA #0
JMP GT_SKIP12
GT_GT12:
LDA #$1
GT_SKIP12:
COMP_SKP62:
BNE LINE_NSKIP106
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP106
;
LINE_NSKIP106:
;
JSR COMPACTMAX
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR CHRFAC2
; Optimizer rule: CHR value already in FAC/1
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_E$
LDY VAR_E$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_E$
LDY #>VAR_E$
JSR COPYSTRING
;
LINE_SKIP106:
;
;
LINE_11061:
;
LDA #<CONST_73R
LDY #>CONST_73R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BCC LTEQ_LTEQ13
BEQ LTEQ_LTEQ13
LDA #0
JMP LTEQ_SKIP13
LTEQ_LTEQ13:
LDA #$1
LTEQ_SKIP13:
COMP_SKP63:
BNE LINE_NSKIP107
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP107
;
LINE_NSKIP107:
;
JSR COMPACTMAX
LDA #<VAR_E
LDY #>VAR_E
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR CHR
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_E$
LDY VAR_E$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_E$
LDY #>VAR_E$
JSR COPYSTRING
;
LINE_SKIP107:
;
;
LINE_11070:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_16
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_16:
;
LINE_11080:
;
LDA VAR_E$
LDY VAR_E$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_M$
LDY #>VAR_M$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_11090:
;
INPUT28:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_74
LDY #>CONST_74
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP43
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
EMPTYINPUTSKIP43:
JSR QUEUESIZE
LDA X_REG
COMP_SKP65:
BEQ INPUTCHECK28
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK28:
;
LINE_11100:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_11110:
;
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #14
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; ignored: CHGCTX #0
LDA #1
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
LDA #<CONST_75
LDY #>CONST_75
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #27
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR UNLOCKCHANNEL
;
LINE_11120:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_11130:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_77R
LDY #>CONST_77R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_11140:
;
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA VAR_M$
LDY VAR_M$+1
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_46
LDY #>CONST_46
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
JSR LOCKCHANNEL
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_11150:
;
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_78
LDY #>CONST_78
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_11160:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #0
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
LDA #<CONST_75
LDY #>CONST_75
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #27
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR UNLOCKCHANNEL
;
LINE_11170:
;
JSR LOCKCHANNEL
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_11180:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_11190:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_77R
LDY #>CONST_77R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_11200:
;
LDX #4
dcloop2725_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP17
STA JUMP_TARGET
LDA #>FORLOOP17
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP17:
;
LINE_11210:
;
LDA #<VAR_N
LDY #>VAR_N
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_P$[]
LDY #>VAR_P$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_11220:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_17
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_17:
;
LINE_11230:
;
LDX #4
dcloop2725_2:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop2725_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP18
STA JUMP_TARGET
LDA #>FORLOOP18
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP18:
;
LINE_11240:
;
LDA #<CONST_79R
LDY #>CONST_79R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_N
LDY #>VAR_N
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
LDA #<VAR_P$[]
LDY #>VAR_P$[]
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
BEQ LT_LT_EQ14
ROL
BCC LT_LT14
LT_LT_EQ14:
LDA #0
JMP LT_SKIP14
LT_LT14:
LDA #$1
LT_SKIP14:
COMP_SKP67:
BNE LINE_NSKIP108
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP108
;
LINE_NSKIP108:
;
LDA #<VAR_N
LDY #>VAR_N
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<CONST_46
LDY #>CONST_46
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_P$[]
LDY #>VAR_P$[]
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
LDA #<VAR_P$[]
LDY #>VAR_P$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
JMP LINE_11240
;
LINE_SKIP108:
;
;
LINE_11250:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_18
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_18:
;
LINE_11270:
;
LDX #4
dcloop2891_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop2891_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP19
STA JUMP_TARGET
LDA #>FORLOOP19
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP19:
;
LINE_11280:
;
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_P$[]
LDY #>VAR_P$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_80
LDY #>CONST_80
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_11290:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_19
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_19:
;
LINE_11350:
;
JSR LOCKCHANNEL
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_11360:
;
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_81
LDY #>CONST_81
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA VAR_GE$
LDY VAR_GE$+1
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_82
LDY #>CONST_82
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_11370:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_11380:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<CONST_83
LDY #>CONST_83
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #27
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR UNLOCKCHANNEL
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_11390:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_77R
LDY #>CONST_77R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_11400:
;
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_84
LDY #>CONST_84
STA A_REG
STY A_REG+1
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_11410:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_11420:
;
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_35R
LDY #>CONST_35R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_11430:
;
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<CONST_85
LDY #>CONST_85
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #27
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
JSR LOCKCHANNEL
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #12
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_11440:
;
LDA #14
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_12000:
;
LDX #4
dcloop3057_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_SU$
LDY VAR_SU$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP20
STA JUMP_TARGET
LDA #>FORLOOP20
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP20:
;
LINE_12010:
;
JSR COMPACTMAX
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA VAR_SU$
LDY VAR_SU$+1
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
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A$
LDY #>VAR_A$
JSR COPYSTRING
;
LINE_12020:
;
LDA #<CONST_86
LDY #>CONST_86
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SGT
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_87
LDY #>CONST_87
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SLT
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP70:
BEQ LINE_SKIP109
; Simplified conditional branch
;
LINE_NSKIP109:
;
LDX #4
dcloop3223_1:
LDA CONST_4R,X
STA VAR_V,X
DEX
BPL dcloop3223_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP109:
;
;
LINE_12021:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_V
LDY #>VAR_V
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
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_75
LDY #>CONST_75
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
COMP_SKP71:
BEQ LINE_SKIP110
; Simplified conditional branch
;
LINE_NSKIP110:
;
LDX #4
dcloop3223_2:
LDA CONST_21R,X
STA VAR_V,X
DEX
BPL dcloop3223_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP110:
;
;
LINE_12025:
;
LDA #<CONST_88
LDY #>CONST_88
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
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
COMP_SKP72:
BEQ LINE_SKIP111
; Simplified conditional branch
;
LINE_NSKIP111:
;
LDX #4
dcloop3223_3:
LDA CONST_35R,X
STA VAR_V,X
DEX
BPL dcloop3223_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP111:
;
;
LINE_12026:
;
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP73:
BEQ LINE_SKIP112
; Simplified conditional branch
;
LINE_NSKIP112:
;
LDA #0
STA VAR_V
STA VAR_V+1
STA VAR_V+2
STA VAR_V+3
STA VAR_V+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_5014
;
LINE_SKIP112:
;
;
LINE_12027:
;
LDA #<CONST_35R
LDY #>CONST_35R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ17
LDA #0
JMP EQ_SKIP17
EQ_EQ17:
LDA #$1
EQ_SKIP17:
COMP_SKP74:
BNE LINE_NSKIP113
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP113
;
LINE_NSKIP113:
;
LDA #<CONST_89R
LDY #>CONST_89R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_90
LDY #>CONST_90
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #0
STA VAR_V
STA VAR_V+1
STA VAR_V+2
STA VAR_V+3
STA VAR_V+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_5000
;
LINE_SKIP113:
;
;
LINE_12028:
;
LDA #0
STA VAR_V
STA VAR_V+1
STA VAR_V+2
STA VAR_V+3
STA VAR_V+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_12060:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_20
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_20:
;
LINE_12070:
;
JMP LINE_5014
;
LINE_14999:
;
JSR END
RTS
;
LINE_15000:
;
;
LINE_15010:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #0
STA VAR_GE
STA VAR_GE+1
STA VAR_GE+2
STA VAR_GE+3
STA VAR_GE+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_15011:
;
JMP LINE_40000
;
LINE_15020:
;
LDA #<CONST_91
LDY #>CONST_91
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15030:
;
LDA #<CONST_92
LDY #>CONST_92
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15031:
;
LDX #4
dcloop3389_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop3389_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP21
STA JUMP_TARGET
LDA #>FORLOOP21
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP21:
LDA #<CONST_12
LDY #>CONST_12
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP76:
BEQ LINE_SKIP114
; Simplified conditional branch
;
LINE_NSKIP114:
;
LDA #<CONST_93
LDY #>CONST_93
STA A_REG
STY A_REG+1
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: Simplified string array assignment/7
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_SKIP114:
;
;
LINE_15032:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_21
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_21:
;
LINE_15040:
;
LDX #4
dcloop3389_2:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop3389_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP22
STA JUMP_TARGET
LDA #>FORLOOP22
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP22:
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUT
LDA #<CONST_24R
LDY #>CONST_24R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA #<VAR_GS$[]
LDY #>VAR_GS$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_22
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_22:
;
LINE_15041:
;
LDX #4
dcloop3389_3:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop3389_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP23
STA JUMP_TARGET
LDA #>FORLOOP23
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP23:
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_GS[]
LDY #>VAR_GS[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<VAR_GE
LDY #>VAR_GE
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_GE
LDY #>VAR_GE
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_23
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_23:
LDX #4
dcloop3389_4:
LDA VAR_GE,X
STA VAR_Y,X
DEX
BPL dcloop3389_4
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_20000
LDA VAR_Y$
LDY VAR_Y$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_GE$
LDY #>VAR_GE$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_15042:
;
LDA #<CONST_94
LDY #>CONST_94
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_GE$
LDY VAR_GE$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_95
LDY #>CONST_95
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15050:
;
LDA #<CONST_96
LDY #>CONST_96
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15060:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP80:
BEQ LINE_SKIP115
; Simplified conditional branch
;
LINE_NSKIP115:
;
JMP LINE_15060
;
LINE_SKIP115:
;
;
LINE_15070:
;
LDA #<CONST_97
LDY #>CONST_97
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15080:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP81:
BEQ LINE_SKIP116
; Simplified conditional branch
;
LINE_NSKIP116:
;
JMP LINE_15080
;
LINE_SKIP116:
;
;
LINE_15090:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP82:
BEQ LINE_SKIP117
; Simplified conditional branch
;
LINE_NSKIP117:
;
JSR GOSUB
JSR LINE_11010
;
LINE_SKIP117:
;
;
LINE_15091:
;
;
LINE_15100:
;
LDA #<CONST_98
LDY #>CONST_98
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15110:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP83:
BEQ LINE_SKIP118
; Simplified conditional branch
;
LINE_NSKIP118:
;
JMP LINE_15110
;
LINE_SKIP118:
;
;
LINE_15120:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP84:
BEQ LINE_SKIP119
; Simplified conditional branch
;
LINE_NSKIP119:
;
JSR GOSUB
JSR LINE_10310
;
LINE_SKIP119:
;
;
LINE_15121:
;
;
LINE_15130:
;
LDA #<CONST_99
LDY #>CONST_99
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15140:
;
LDA #<CONST_100
LDY #>CONST_100
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15150:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP85:
BEQ LINE_SKIP120
; Simplified conditional branch
;
LINE_NSKIP120:
;
JMP LINE_15150
;
LINE_SKIP120:
;
;
LINE_15160:
;
LDA #<CONST_101
LDY #>CONST_101
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP86:
BEQ LINE_SKIP121
; Simplified conditional branch
;
LINE_NSKIP121:
;
LDX #4
dcloop3555_1:
LDA CONST_4R,X
STA VAR_PU,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_2160
;
LINE_SKIP121:
;
;
LINE_15170:
;
LDA #<CONST_102
LDY #>CONST_102
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP87:
BEQ LINE_SKIP122
; Simplified conditional branch
;
LINE_NSKIP122:
;
JSR RUN
;
LINE_SKIP122:
;
;
LINE_15180:
;
JMP LINE_15150
;
LINE_15190:
;
;
LINE_15200:
;
;
LINE_20000:
;
JSR COMPACTMAX
LDA #<VAR_Y
LDY #>VAR_Y
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR STR
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
;
LINE_20010:
;
LDX #4
dcloop3721_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP24
STA JUMP_TARGET
LDA #>FORLOOP24
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP24:
;
LINE_20020:
;
JSR COMPACTMAX
LDA #<CONST_88
LDY #>CONST_88
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
JSR CHARAT
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP88:
BEQ LINE_SKIP123
; Simplified conditional branch
;
LINE_NSKIP123:
;
JMP LINE_20060
;
LINE_SKIP123:
;
;
LINE_20030:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_24
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_24:
;
LINE_20040:
;
JSR COMPACTMAX
LDA #<CONST_88
LDY #>CONST_88
STA B_REG
STY B_REG+1
LDA VAR_Y$
LDY VAR_Y$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
;
LINE_20050:
;
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_N
LDY #>VAR_N
; FAC to (X/Y)
JSR FACMEM
;
LINE_20060:
;
JSR COMPACTMAX
LDA #<CONST_103
LDY #>CONST_103
STA B_REG
STY B_REG+1
LDA VAR_Y$
LDY VAR_Y$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
;
LINE_20070:
;
JSR COMPACTMAX
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFAC
LDA #<VAR_N
LDY #>VAR_N
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
; ignored: CHGCTX #1
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
JSR LEFT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
;
LINE_20080:
;
JSR COMPACTMAX
LDA #<CONST_104
LDY #>CONST_104
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
LDY #2
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
COMP_SKP90:
BNE LINE_NSKIP124
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP124
;
LINE_NSKIP124:
;
JSR COMPACTMAX
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA VAR_Y$
LDY VAR_Y$+1
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
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA #<CONST_87
LDY #>CONST_87
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
;
LINE_SKIP124:
;
;
LINE_20090:
;
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_N
LDY #>VAR_N
; FAC to (X/Y)
JSR FACMEM
;
LINE_20100:
;
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
JSR LEN
LDA #<CONST_105R
LDY #>CONST_105R
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
COMP_SKP91:
BEQ LINE_SKIP125
; Simplified conditional branch
;
LINE_NSKIP125:
;
JSR COMPACTMAX
LDA VAR_Y$
LDY VAR_Y$+1
STA B_REG
STY B_REG+1
LDA #<CONST_46
LDY #>CONST_46
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
JMP LINE_20100
;
LINE_SKIP125:
;
;
LINE_20120:
;
JMP RETURN
;
LINE_21000:
;
;
LINE_21010:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #142
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21020:
;
LDA #<CONST_106
LDY #>CONST_106
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21030:
;
INPUT29:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_107
LDY #>CONST_107
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP44
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MO$
LDY #>VAR_MO$
JSR COPYSTRING
EMPTYINPUTSKIP44:
JSR QUEUESIZE
LDA X_REG
COMP_SKP92:
BEQ INPUTCHECK29
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK29:
;
LINE_21040:
;
INPUT30:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_108
LDY #>CONST_108
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP45
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
EMPTYINPUTSKIP45:
JSR QUEUESIZE
LDA X_REG
COMP_SKP93:
BEQ INPUTCHECK30
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK30:
;
LINE_21050:
;
INPUT31:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_109
LDY #>CONST_109
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP46
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_UE$
LDY #>VAR_UE$
JSR COPYSTRING
EMPTYINPUTSKIP46:
JSR QUEUESIZE
LDA X_REG
COMP_SKP94:
BEQ INPUTCHECK31
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK31:
;
LINE_21060:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_UE$
LDY VAR_UE$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP95:
BEQ LINE_SKIP126
; Simplified conditional branch
;
LINE_NSKIP126:
;
LDA #<CONST_53
LDY #>CONST_53
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_UE$
LDY #>VAR_UE$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JMP LINE_21080
;
LINE_SKIP126:
;
;
LINE_21070:
;
LDA #<CONST_13
LDY #>CONST_13
STA B_REG
STY B_REG+1
LDA VAR_UE$
LDY VAR_UE$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP96:
BEQ LINE_SKIP127
; Simplified conditional branch
;
LINE_NSKIP127:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_UE$
STY VAR_UE$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP127:
;
;
LINE_21080:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA VAR_MO$
LDY VAR_MO$+1
STA B_REG
STY B_REG+1
LDA VAR_UE$
LDY VAR_UE$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA #<CONST_46
LDY #>CONST_46
STA B_REG
STY B_REG+1
JSR CONCAT
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_110
LDY #>CONST_110
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_54
LDY #>CONST_54
STA B_REG
STY B_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY G_REG
STA G_REG+1
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
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_21090:
;
LDX #4
dcloop3887_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP25
STA JUMP_TARGET
LDA #>FORLOOP25
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP25:
;
LINE_21100:
;
JSR LOCKCHANNEL
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_21105:
;
JSR LOCKCHANNEL
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR STROUTCHANNEL
JSR LINEBREAKCHANNEL
JSR UNLOCKCHANNEL
;
LINE_21110:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_25
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_25:
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_21120:
;
JSR GOSUB
JSR LINE_10710
LDA #14
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_21130:
;
;
LINE_21140:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_FE
LDY #>VAR_FE
JSR CMPFAC
EQ_EQ19:
EQ_SKIP19:
COMP_SKP98:
BNE LINE_SKIP128
LINE_NSKIP128:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_FE
STA VAR_FE+1
STA VAR_FE+2
STA VAR_FE+3
STA VAR_FE+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_21000
;
LINE_SKIP128:
;
;
LINE_21150:
;
JMP LINE_40000
;
LINE_21160:
;
;
LINE_22000:
;
;
LINE_22010:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #142
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_22020:
;
LDA #<CONST_111
LDY #>CONST_111
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_22030:
;
INPUT32:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP47
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_MO$
LDY #>VAR_MO$
JSR COPYSTRING
EMPTYINPUTSKIP47:
JSR QUEUESIZE
LDA X_REG
COMP_SKP99:
BEQ INPUTCHECK32
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK32:
;
LINE_22040:
;
INPUT33:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_113
LDY #>CONST_113
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP48
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
EMPTYINPUTSKIP48:
JSR QUEUESIZE
LDA X_REG
COMP_SKP100:
BEQ INPUTCHECK33
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK33:
;
LINE_22050:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_45R
LDY #>CONST_45R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<CONST_46
LDY #>CONST_46
STA B_REG
STY B_REG+1
LDA VAR_MO$
LDY VAR_MO$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_110
LDY #>CONST_110
STA B_REG
STY B_REG+1
JSR CONCAT
LDA #<CONST_47
LDY #>CONST_47
STA B_REG
STY B_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY G_REG
STA G_REG+1
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
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_22060:
;
LDX #4
dcloop4219_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop4219_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP26
STA JUMP_TARGET
LDA #>FORLOOP26
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP26:
;
LINE_22070:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR CLEARQUEUE
JSR COMPACTMAX
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTSTRCHANNEL
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP49
JSR ARRAYSTORE_STRING
EMPTYINPUTSKIP49:
;
LINE_22080:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR CLEARQUEUE
JSR COMPACTMAX
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTSTRCHANNEL
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP50
JSR ARRAYSTORE_STRING
EMPTYINPUTSKIP50:
;
LINE_22090:
;
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_26
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_26:
;
LINE_22100:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_22110:
;
JSR GOSUB
JSR LINE_10710
;
LINE_22120:
;
;
LINE_22130:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_FE
LDY #>VAR_FE
JSR CMPFAC
EQ_EQ20:
EQ_SKIP20:
COMP_SKP102:
BNE LINE_SKIP129
LINE_NSKIP129:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_FE
STA VAR_FE+1
STA VAR_FE+2
STA VAR_FE+3
STA VAR_FE+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_22000
;
LINE_SKIP129:
;
;
LINE_22140:
;
LDA #14
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_22150:
;
JMP LINE_40000
;
LINE_22999:
;
JSR END
RTS
;
LINE_30000:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDY #0
STY 53281
; Optimizer rule: Simple POKE/2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_30010:
;
LDA #<CONST_8R
LDY #>CONST_8R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_114
LDY #>CONST_114
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_30020:
;
LDA #<CONST_8R
LDY #>CONST_8R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR TAB
LDA #<CONST_115
LDY #>CONST_115
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_30030:
;
LDA #<CONST_116
LDY #>CONST_116
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_30040:
;
LDA #<CONST_117
LDY #>CONST_117
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_30050:
;
LDA #<CONST_118
LDY #>CONST_118
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_30060:
;
LDA #<CONST_119
LDY #>CONST_119
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_30070:
;
LDA #<CONST_120
LDY #>CONST_120
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_30080:
;
LDA #<CONST_121
LDY #>CONST_121
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_30090:
;
JMP RETURN
;
LINE_30999:
;
JSR END
RTS
;
LINE_40000:
;
LDA #<CONST_122
LDY #>CONST_122
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40010:
;
LDA #<CONST_123
LDY #>CONST_123
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40020:
;
LDA #<CONST_124
LDY #>CONST_124
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40030:
;
LDA #<CONST_125
LDY #>CONST_125
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40040:
;
LDA #<CONST_126
LDY #>CONST_126
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40041:
;
LDA #<CONST_127
LDY #>CONST_127
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40042:
;
LDA #<CONST_128
LDY #>CONST_128
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40043:
;
LDA #<CONST_129
LDY #>CONST_129
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40044:
;
LDA #<CONST_130
LDY #>CONST_130
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40050:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP103:
BEQ LINE_SKIP130
; Simplified conditional branch
;
LINE_NSKIP130:
;
JMP LINE_40050
;
LINE_SKIP130:
;
;
LINE_40060:
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
COMP_SKP104:
BEQ LINE_SKIP131
; Simplified conditional branch
;
LINE_NSKIP131:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_15020
;
LINE_SKIP131:
;
;
LINE_40070:
;
LDA #<CONST_131
LDY #>CONST_131
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP105:
BEQ LINE_SKIP132
; Simplified conditional branch
;
LINE_NSKIP132:
;
JMP LINE_40500
;
LINE_SKIP132:
;
;
LINE_40080:
;
LDA #<CONST_83
LDY #>CONST_83
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP106:
BEQ LINE_SKIP133
; Simplified conditional branch
;
LINE_NSKIP133:
;
JMP LINE_2160
;
LINE_SKIP133:
;
;
LINE_40081:
;
LDA #<CONST_132
LDY #>CONST_132
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP107:
BEQ LINE_SKIP134
; Simplified conditional branch
;
LINE_NSKIP134:
;
JMP LINE_10110
;
LINE_SKIP134:
;
;
LINE_40082:
;
LDA #<CONST_133
LDY #>CONST_133
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP108:
BEQ LINE_SKIP135
; Simplified conditional branch
;
LINE_NSKIP135:
;
LDX #4
dcloop4385_1:
LDA CONST_4R,X
STA VAR_OK,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_10010
;
LINE_SKIP135:
;
;
LINE_40083:
;
LDA #<CONST_134
LDY #>CONST_134
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP109:
BEQ LINE_SKIP136
; Simplified conditional branch
;
LINE_NSKIP136:
;
JMP LINE_21010
;
LINE_SKIP136:
;
;
LINE_40084:
;
LDA #<CONST_135
LDY #>CONST_135
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP110:
BEQ LINE_SKIP137
; Simplified conditional branch
;
LINE_NSKIP137:
;
JMP LINE_22010
;
LINE_SKIP137:
;
;
LINE_40090:
;
JMP LINE_40050
;
LINE_40500:
;
LDA #<CONST_136
LDY #>CONST_136
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_A$
STY VAR_A$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_40510:
;
;
LINE_40520:
;
LDA #<CONST_137
LDY #>CONST_137
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40530:
;
LDA #<CONST_138
LDY #>CONST_138
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40531:
;
LDA #<CONST_139
LDY #>CONST_139
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40532:
;
LDA #<CONST_140
LDY #>CONST_140
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40533:
;
LDA #<CONST_141
LDY #>CONST_141
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40540:
;
LDX #4
dcloop4551_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP27
STA JUMP_TARGET
LDA #>FORLOOP27
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP27:
LDA #<CONST_89R
LDY #>CONST_89R
JSR REALFAC
LDA #<VAR_N
LDY #>VAR_N
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
COMP_SKP111:
BNE LINE_NSKIP138
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP138
;
LINE_NSKIP138:
;
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<CONST_142
LDY #>CONST_142
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_27
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_27:
;
LINE_SKIP138:
;
;
LINE_40541:
;
LDA #<CONST_105R
LDY #>CONST_105R
JSR REALFAC
LDA #<VAR_N
LDY #>VAR_N
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT22
LDA #0
JMP GT_SKIP22
GT_GT22:
LDA #$1
GT_SKIP22:
COMP_SKP113:
BNE LINE_NSKIP139
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP139
;
LINE_NSKIP139:
;
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<CONST_143
LDY #>CONST_143
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_28
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_28:
;
LINE_SKIP139:
;
;
LINE_40550:
;
INPUT34:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_144
LDY #>CONST_144
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP51
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_VE$
LDY #>VAR_VE$
JSR COPYSTRING
EMPTYINPUTSKIP51:
JSR QUEUESIZE
LDA X_REG
COMP_SKP115:
BEQ INPUTCHECK34
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK34:
LDA VAR_VE$
LDY VAR_VE$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
LDX #<VAR_VE
LDY #>VAR_VE
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<CONST_87
LDY #>CONST_87
STA B_REG
STY B_REG+1
LDA VAR_VE$
LDY VAR_VE$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP116:
BEQ LINE_SKIP140
; Simplified conditional branch
;
LINE_NSKIP140:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_VE$
STY VAR_VE$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
JMP LINE_40700
;
LINE_SKIP140:
;
;
LINE_40551:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
LDA #<VAR_VE
LDY #>VAR_VE
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT23
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP23
GT_GT23:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP23:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_VE
LDY #>VAR_VE
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ24
ROL
BCC LT_LT24
LT_LT_EQ24:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP24
LT_LT24:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP24:
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
COMP_SKP117:
BEQ LINE_SKIP141
; Simplified conditional branch
;
LINE_NSKIP141:
;
JMP LINE_2160
;
LINE_SKIP141:
;
;
LINE_40552:
;
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_VE$
LDY VAR_VE$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP118:
BEQ LINE_SKIP142
; Simplified conditional branch
;
LINE_NSKIP142:
;
JMP LINE_2160
;
LINE_SKIP142:
;
;
LINE_40560:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_VE$
STY VAR_VE$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<CONST_145
LDY #>CONST_145
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_VE
LDY #>VAR_VE
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
JSR STROUTBRK
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40570:
;
INPUT35:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_146
LDY #>CONST_146
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP52
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A$
LDY #>VAR_A$
JSR COPYSTRING
EMPTYINPUTSKIP52:
JSR QUEUESIZE
LDA X_REG
COMP_SKP119:
BEQ INPUTCHECK35
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK35:
;
LINE_40571:
;
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
JSR LEN
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT25
LDA #0
JMP GT_SKIP25
GT_GT25:
LDA #$1
GT_SKIP25:
COMP_SKP120:
BEQ LINE_SKIP143
; Simplified conditional branch
;
LINE_NSKIP143:
;
LDA #<CONST_65
LDY #>CONST_65
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP LINE_40570
;
LINE_SKIP143:
;
;
LINE_40580:
;
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_VE
LDY #>VAR_VE
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_A$
STY VAR_A$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_VE
LDY #>VAR_VE
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR COMPACTMAX
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_VE
LDY #>VAR_VE
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA #<CONST_10
LDY #>CONST_10
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
;
LINE_40590:
;
LDA #<CONST_0
LDY #>CONST_0
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_40600:
;
JMP LINE_40500
;
LINE_40700:
;
JSR RESTORE
;
LINE_40710:
;
LDX #4
dcloop4883_1:
LDA CONST_2,X
STA VAR_I,X
DEX
BPL dcloop4883_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_3
LDY #>CONST_3
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
LDA #<FORLOOP28
STA JUMP_TARGET
LDA #>FORLOOP28
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP28:
;
LINE_40720:
;
JSR READNUMBER
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_29
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_29:
;
LINE_40730:
;
LDX #4
dcloop4883_2:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop4883_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP29
STA JUMP_TARGET
LDA #>FORLOOP29
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP29:
JSR READSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_30
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_30:
;
LINE_40740:
;
LDX #4
dcloop4883_3:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop4883_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP30
STA JUMP_TARGET
LDA #>FORLOOP30
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP30:
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR READSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_31
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_31:
;
LINE_40750:
;
LDX #4
dcloop5049_1:
LDA CONST_4R,X
STA VAR_N,X
DEX
BPL dcloop5049_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_4R
;LDY #>CONST_4R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
LDA #<FORLOOP31
STA JUMP_TARGET
LDA #>FORLOOP31
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP31:
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
JSR COMPACTMAX
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
; ignored: CHGCTX #1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYACCESS_STRING
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA #<CONST_10
LDY #>CONST_10
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_PU$[]
LDY #>VAR_PU$[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_STRING
LDA #<VAR_N
LDY #>VAR_N
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_32
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_32:
;
LINE_40760:
;
JMP LINE_40500
;
LINE_50020:
;
;
LINE_50030:
;
;
LINE_50040:
;
;
LINE_50050:
;
;
LINE_50060:
;
;
LINE_50070:
;
;
LINE_50080:
;
;
LINE_50090:
;
;
LINE_50100:
;
;
LINE_50110:
;
;
LINE_50120:
;
;
LINE_50130:
;
;
LINE_50140:
;
;
LINE_50150:
;
;
LINE_50160:
;
;
LINE_50170:
;
;
LINE_50180:
;
;
LINE_50190:
;
;
LINE_50200:
;
;
LINE_50210:
;
;
LINE_50220:
;
;
LINE_50230:
;
;
LINE_50240:
;
;
LINE_50250:
;
;
LINE_50260:
;
;
LINE_50270:
;
;
LINE_50280:
;
;
LINE_50290:
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
CHARAT		JSR STRFUNCINT
LDA TMP_REG
BNE CHARATOK
JMP ILLEGALQUANTITY	; start has to be larger than 0
CHARATOK	LDY #0
LDA (TMP_ZP),Y
STA TMP_REG+1		; store source length
LDX TMP_REG
CPX TMP_REG+1
BEQ CHARATOK3
BCC CHARATOK3
JMP CHARATOOR
CHARATOK3
CLC
LDA TMP_ZP
ADC TMP_REG
STA TMP_ZP
BCC CHARATOK2
INC TMP_ZP+1
CHARATOK2	LDY #0
LDA (TMP_ZP),Y
STA CHARSTORE+1
LDA #<CHARSTORE
STA A_REG
LDA #>CHARSTORE
STA A_REG+1
RTS
CHARATOOR	LDA #<EMPTYSTR
STA A_REG
LDA #>EMPTYSTR
STA A_REG+1
RTS
CHARSTORE	.WORD 1
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
READSTR		JSR READINIT
CMP #$2
BNE DATA2STR		; It's a number and has to be converted
LDA TMP3_ZP
STA A_REG
LDA TMP3_ZP+1
STA A_REG+1
LDA (TMP3_ZP),Y
CLC
ADC TMP3_ZP
STA TMP3_ZP
BCC READNOOV2
INC TMP3_ZP+1
READNOOV2	JSR NEXTDATA
INC DATASP
BNE READNOOV3
INC DATASP+1
READNOOV3	RTS
;###################################
;###################################
NEXTDATA	LDA TMP3_ZP			; Adjust pointer to the next element
STA DATASP
LDA TMP3_ZP+1
STA DATASP+1
RTS
;###################################
;###################################
DATA2STR	CMP #$1
BEQ DREAL2STR		; It's a floating point number...
CMP #$0
BEQ DATA2STRINT
CMP #$4
BCS DSHORTBYTE
LDA (TMP3_ZP),Y		; It's a byte
TAY
JSR BYTEFAC
LDX #1
JSR READADDPTR
JMP DFAC2STR
DATA2STRINT	LDA (TMP3_ZP),Y		; It's an integer
STA TMP_REG
INY
LDA (TMP3_ZP),Y
LDY TMP_REG
JSR INTFAC
LDX #2
JSR READADDPTR
JMP DFAC2STR
DSHORTBYTE	TAY
JSR BYTEFAC
JMP DFAC2STR
DREAL2STR	LDA TMP3_ZP
LDY TMP3_ZP+1
JSR REALFAC
LDX #5
JSR READADDPTR
DFAC2STR	JSR NEXTDATA
JMP STRINTREAD
;###################################
;###################################
STRINTREAD	LDY #1			; Special INT to STR routine that handles the fact that in case of conversions from data entries, there's no leading blank for positive numbers
JSR FACSTR
LDY #0
STY TMP_ZP+1
LDA #LOFBUF
STA TMP_ZP
DEY
STRLOOPREAD	INY
LDA LOFBUFH,Y
BNE STRLOOPREAD
STY LOFBUF
TYA
TAX			; Length in X
LDA LOFBUFH
CMP #$20
BNE STRREADNP
INC TMP_ZP	; Starts with blank? Remove it...
INC TMP_ZP+1
DEC LOFBUF
LDA LOFBUF
STA LOFBUFH  ; Copy the new length over
DEX			 ; length -1
STRREADNP	LDA #<A_REG
LDY #>A_REG
STA TMP2_ZP
STY TMP2_ZP+1
JMP COPYONLY
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
COPY2_XYA	STA TMP3_ZP
COPY2_XY	STX TMP_ZP
STY TMP_ZP+1
COPY3_XY	LDY #0
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
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
COPY2_XYA_XREGFAC
STA TMP3_ZP
STY TMP3_ZP+1
COPY2_XY_XREGFAC
LDX #<X_REG		; the pointer to X_REG has to be in X, because the "value already in X"-optimization might expect it to be there! YIKES!
LDY #0
LDA (TMP3_ZP),Y
STA X_REG
STA FACEXP
STY FACOV
INY
LDA (TMP3_ZP),Y
STA X_REG+1
STA FACSGN
ORA #$80
STA FACHO
INY
LDA (TMP3_ZP),Y
STA X_REG+2
STA FACMOH
INY
LDA (TMP3_ZP),Y
STA X_REG+3
STA FACMO
INY
LDA (TMP3_ZP),Y
STA X_REG+4
STA FACLO
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
LOCKCHANNEL
PHA
LDA #$FF
STA CHLOCKFLAG
PLA
RTS
;##################################
;##################################
UNLOCKCHANNEL
PHA
LDA #0
STA CHLOCKFLAG
PLA
JMP CLRCH
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
INITINCHANNEL
LDA IOCHANNEL
STA STORE1+1
LDA #1
STA IOCHANNEL		; Something that's not the screen...that's enough for the check the CRSRRIGHT does...
LDA #<C_REG
LDY #>C_REG
JSR REALFAC
JSR FACWORD
TYA
TAX
STA CHANNEL
STA CHLOCKFLAG
JMP CHKIN
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
REALOUTCHANNEL
JSR INITOUTCHANNEL
JSR REALOUT
JMP CLRCHNEW
;###################################
;###################################
INPUTLENGTHCHECK	LDA INPUTLENGTH
RTS
;###################################
;###################################
INPUTSTRCHANNEL
JSR INITINCHANNEL
JSR INPUTSTR
JMP CLRINCH
;###################################
;###################################
INPUTNUMBERCHANNEL
JSR INITINCHANNEL
JSR INPUTNUMBER
JMP CLRINCH
;###################################
;###################################
STROUTCHANNEL
JSR INITOUTCHANNEL
JSR STROUT
JMP CLRCHNEW
;###################################
;###################################
LINEBREAKCHANNEL
JSR INITOUTCHANNEL
JSR LINEBREAK
JMP CLRCHNEW
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
CLRINCH		JSR CLRCH
LDA STORE1+1
STA IOCHANNEL
RTS
;###################################
;###################################
OPEN		JSR SETEMPTYSTR	; Prepare with an empty string
JSR YREGFAC
JSR FACWORD
STY TMP_REG		; store parameter count in TMP_REG
JSR XREGFAC
JSR FACWORD
STY LOGICADDR	; store logical address
DEC TMP_REG
BEQ ALLPARAMS
LDA #<C_REG
LDY #>C_REG
JSR REALFAC
JSR FACWORD
STY DEVICENUM	; store device number
DEC TMP_REG
BEQ ALLPARAMS
LDA #<D_REG
LDY #>D_REG
JSR REALFAC
JSR FACWORD
STY SECADDR		; store secondary address
DEC TMP_REG
BEQ ALLPARAMS
JSR SETNAMEPRT
ALLPARAMS
<IF BOOST>
JSR BOOSTOFF
</IF>
JSR OPENCH
BCS OPENERR
RTS
OPENERR		STA TMP2_ZP
LDA LOGICADDR
JSR CLOSECH
<IF BOOST>
JSR BOOSTON
</IF>
LDX TMP2_ZP
JMP ERRALL
;###################################
;###################################
SETEMPTYSTR
LDA #<EMPTYSTR
STA FILEADDR
LDA #>EMPTYSTR
STA FILEADDR+1
LDA #0
STA FILELEN
STA LOGICADDR
STA DEVICENUM
STA SECADDR
RTS
;###################################
;###################################
SETNAMEPRT	LDA G_REG
LDY G_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y	; get string parameter length
STA FILELEN
INC G_REG
BNE SNPNOOV
INC G_REG+1
SNPNOOV		LDA G_REG
LDY G_REG+1
STA FILEADDR		; low byte of string parameter
STY FILEADDR+1	; high byte of string parameter
RTS
;###################################
;###################################
CLOSE		JSR XREGFAC
JSR FACWORD
TYA				; file number into A
JSR CLOSECH
<IF BOOST>
JSR BOOSTON
</IF>
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
;###############################
INITVARS
JSR INITSTRVARS
LDA #0
LDY #4
REALINITLOOP0:
STA VAR_I,Y
STA VAR_X,Y
STA VAR_N,Y
STA VAR_PU,Y
STA VAR_V,Y
STA VAR_SU,Y
STA VAR_Y,Y
STA VAR_OK,Y
STA VAR_Z,Y
STA VAR_Q,Y
STA VAR_FE,Y
STA VAR_UN,Y
STA VAR_P,Y
STA VAR_M,Y
STA VAR_A,Y
STA VAR_C,Y
STA VAR_D,Y
STA VAR_E,Y
STA VAR_GE,Y
STA VAR_VE,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
LDA #<VAR_GS[]
LDY #>VAR_GS[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_M[]
LDY #>VAR_M[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_NU[]
LDY #>VAR_NU[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: ${clear}
CONST_0	.BYTE 7
.STRG "{clear}"
; CONST: #14


; CONST: #49152

CONST_2	.REAL 49152
; CONST: #49256

CONST_3	.REAL 49256
; CONST: #1

MOSTCOMMON
CONST_4R	.REAL 1.0
; CONST: #0


; CONST: #12

CONST_6R	.REAL 12.0
; CONST: #15

CONST_7R	.REAL 15.0
; CONST: #16

CONST_8R	.REAL 16.0
; CONST: #32

CONST_9R	.REAL 32.0
; CONST: ${reverse on}
CONST_10	.BYTE 12
.STRG "{reverse on}"
; CONST: ${cyan}{down*3}{right*2}Wollen Sie eine Datei laden (J/N)
CONST_11	.BYTE 56
.STRG "{cyan}{down*3}{right*2}Wollen Sie eine Datei laden (J/N)"
; CONST: $
CONST_12	.BYTE 0
.STRG ""
; CONST: $j
CONST_13	.BYTE 1
.STRG "j"
; CONST: ${up}{right*2}Wollen Sie das Directory sehen (J/N)
CONST_14	.BYTE 49
.STRG "{up}{right*2}Wollen Sie das Directory sehen (J/N)"
; CONST: ${up}{right*2}{space*4}Wollen Sie eine Gesamtsumme{space*5}
CONST_15	.BYTE 58
.STRG "{up}{right*2}{space*4}Wollen Sie eine Gesamtsumme{space*5}"
; CONST: ${down}{right*2}von mehreren Monaten erstellen (J/N)
CONST_16	.BYTE 51
.STRG "{down}{right*2}von mehreren Monaten erstellen (J/N)"
; CONST: ${down*3}{right*2}Wollen Sie das Programm beenden (J/N)
CONST_17	.BYTE 54
.STRG "{down*3}{right*2}Wollen Sie das Programm beenden (J/N)"
; CONST: ${clear}{space*15}{reverse on}{purple}HAUSHALT{cyan}
CONST_18	.BYTE 51
.STRG "{clear}{space*15}{reverse on}{purple}HAUSHALT{cyan}"
; CONST: ${down*2}
CONST_19	.BYTE 8
.STRG "{down*2}"
; CONST: $1
CONST_20	.BYTE 1
.STRG "1"
; CONST: #2

CONST_21R	.REAL 2.0
; CONST: $....................
CONST_22	.BYTE 20
.STRG "...................."
; CONST: ${home}{down*4}
CONST_23	.BYTE 14
.STRG "{home}{down*4}"
; CONST: #20

CONST_24R	.REAL 20.0
; CONST: ${down}{right}Cursorbewegung mit <CRSR UP/DOWN>
CONST_25	.BYTE 46
.STRG "{down}{right}Cursorbewegung mit <CRSR UP/DOWN>"
; CONST: ${right}'RETURN' fuer Eingabe
CONST_26	.BYTE 28
.STRG "{right}'RETURN' fuer Eingabe"
; CONST: ${right}'S' fuer Sonstiges (z.B. GESAMTSUMMEN)
CONST_27	.BYTE 45
.STRG "{right}'S' fuer Sonstiges (z.B. GESAMTSUMMEN)"
; CONST: ${home}{down*6}
CONST_28	.BYTE 14
.STRG "{home}{down*6}"
; CONST: #13


; CONST: ${up}
CONST_30	.BYTE 4
.STRG "{up}"
; CONST: #17


; CONST: #145


; CONST: $s
CONST_33	.BYTE 1
.STRG "s"
; CONST: ${home}
CONST_34	.BYTE 6
.STRG "{home}"
; CONST: #3

CONST_35R	.REAL 3.0
; CONST: ${down}
CONST_36	.BYTE 6
.STRG "{down}"
; CONST: ${down*2}{yellow}SUMMENEINGABE{cyan}
CONST_37	.BYTE 35
.STRG "{down*2}{yellow}SUMMENEINGABE{cyan}"
; CONST: ${up*2}{space*15}{up}{left*2}{space*23}
CONST_38	.BYTE 38
.STRG "{up*2}{space*15}{up}{left*2}{space*23}"
; CONST: ${home}{down*3}{space*35}
CONST_39	.BYTE 24
.STRG "{home}{down*3}{space*35}"
; CONST: ${down}Taste
CONST_40	.BYTE 11
.STRG "{down}Taste"
; CONST: #142


; CONST: ${space*7}{reverse on}unterroutine datei laden
CONST_42	.BYTE 45
.STRG "{space*7}{reverse on}unterroutine datei laden"
; CONST: ${down*2}dateiname{space*2}(monat)
CONST_43	.BYTE 33
.STRG "{down*2}dateiname{space*2}(monat)"
; CONST: ${down*2}jahr z.b. 1986
CONST_44	.BYTE 22
.STRG "{down*2}jahr z.b. 1986"
; CONST: #8

CONST_45R	.REAL 8.0
; CONST: $
CONST_46	.BYTE 1
.STRG " "
; CONST: $,s,r
CONST_47	.BYTE 4
.STRG ",s,r"
; CONST: #4

CONST_48R	.REAL 4.0
; CONST: ${clear}{down}{space*5}{reverse on}unterroutine datei speichern
CONST_49	.BYTE 62
.STRG "{clear}{down}{space*5}{reverse on}unterroutine datei speichern"
; CONST: ${down*2}{right}dateiname (monat)
CONST_50	.BYTE 32
.STRG "{down*2}{right}dateiname (monat)"
; CONST: ${down*2}{right}jahr z.b. 1986{space*3}
CONST_51	.BYTE 38
.STRG "{down*2}{right}jahr z.b. 1986{space*3}"
; CONST: ${down*2}{right}alte datei ueberschreiben (j/n)
CONST_52	.BYTE 46
.STRG "{down*2}{right}alte datei ueberschreiben (j/n)"
; CONST: $@:
CONST_53	.BYTE 2
.STRG "@:"
; CONST: $,s,w
CONST_54	.BYTE 4
.STRG ",s,w"
; CONST: ${down}{space*8}{reverse on}
CONST_55	.BYTE 27
.STRG "{down}{space*8}{reverse on}"
; CONST: ${down*2}von wievielen monaten (1-12)
CONST_56	.BYTE 36
.STRG "{down*2}von wievielen monaten (1-12)"
; CONST: $?redo from start
CONST_57	.BYTE 16
.STRG "?redo from start"
; CONST: ${clear}{down}1=januar 2=februar 3=maerz 4=april
CONST_58	.BYTE 47
.STRG "{clear}{down}1=januar 2=februar 3=maerz 4=april"
; CONST: $5=mai{space*4}6=juni{space*4}7=juli{space*2}8=august
CONST_59	.BYTE 52
.STRG "5=mai{space*4}6=juni{space*4}7=juli{space*2}8=august"
; CONST: $9=sept. 10=okt.{space*3}11=nov. 12=dezember
CONST_60	.BYTE 43
.STRG "9=sept. 10=okt.{space*3}11=nov. 12=dezember"
; CONST: ${down}monat (1-12)
CONST_61	.BYTE 18
.STRG "{down}monat (1-12)"
; CONST: $ok
CONST_62	.BYTE 2
.STRG "ok"
; CONST: #500

CONST_63R	.REAL 500.0
; CONST: ${up}{space*2}{up}{left*2}{space*17}{up*2}
CONST_64	.BYTE 41
.STRG "{up}{space*2}{up}{left*2}{space*17}{up*2}"
; CONST: ${up*4}
CONST_65	.BYTE 6
.STRG "{up*4}"
; CONST: ${down*2}von welchem jahr (z.b.1986)
CONST_66	.BYTE 35
.STRG "{down*2}von welchem jahr (z.b.1986)"
; CONST: ${space*13}
CONST_67	.BYTE 10
.STRG "{space*13}"
; CONST: $taste{up}
CONST_68	.BYTE 9
.STRG "taste{up}"
; CONST: ${space*5}{up*6}
CONST_69	.BYTE 15
.STRG "{space*5}{up*6}"
; CONST: ${clear}{down*2}Sind Sie sicher (J/N)
CONST_70	.BYTE 36
.STRG "{clear}{down*2}Sind Sie sicher (J/N)"
; CONST: ${down}{space*8}{reverse on}unterroutine drucken
CONST_71	.BYTE 47
.STRG "{down}{space*8}{reverse on}unterroutine drucken"
; CONST: ${down*2}{right*2}monat
CONST_72	.BYTE 22
.STRG "{down*2}{right*2}monat"
; CONST: #64

CONST_73R	.REAL 64.0
; CONST: ${down*2}{right*2}jahr
CONST_74	.BYTE 21
.STRG "{down*2}{right*2}jahr"
; CONST: $-
CONST_75	.BYTE 1
.STRG "-"
; CONST: #27


; CONST: #7

CONST_77R	.REAL 7.0
; CONST: $GESAMTSUMMEN
CONST_78	.BYTE 12
.STRG "GESAMTSUMMEN"
; CONST: #22

CONST_79R	.REAL 22.0
; CONST: $DM
CONST_80	.BYTE 2
.STRG "DM"
; CONST: $GESAMTSUMME
CONST_81	.BYTE 11
.STRG "GESAMTSUMME"
; CONST: $ DM
CONST_82	.BYTE 3
.STRG " DM"
; CONST: $3
CONST_83	.BYTE 1
.STRG "3"
; CONST: ${space*13}-------------
CONST_84	.BYTE 23
.STRG "{space*13}-------------"
; CONST: $@
CONST_85	.BYTE 1
.STRG "@"
; CONST: $9
CONST_86	.BYTE 1
.STRG "9"
; CONST: $0
CONST_87	.BYTE 1
.STRG "0"
; CONST: $.
CONST_88	.BYTE 1
.STRG "."
; CONST: #10

CONST_89R	.REAL 10.0
; CONST: ${space*19}
CONST_90	.BYTE 10
.STRG "{space*19}"
; CONST: ${space*12}{light blue}{reverse on}GESAMTSUMMEN
CONST_91	.BYTE 46
.STRG "{space*12}{light blue}{reverse on}GESAMTSUMMEN"
; CONST: ${down}{cyan}
CONST_92	.BYTE 12
.STRG "{down}{cyan}"
; CONST: ${space*5}0.00
CONST_93	.BYTE 13
.STRG "{space*5}0.00"
; CONST: ${down}{reverse on}GESAMTSUMME
CONST_94	.BYTE 30
.STRG "{down}{reverse on}GESAMTSUMME "
; CONST: ${reverse on} DM
CONST_95	.BYTE 15
.STRG "{reverse on} DM"
; CONST: ${down}TASTE
CONST_96	.BYTE 11
.STRG "{down}TASTE"
; CONST: ${clear}{down*2}{right*2}Gesamtsummen drucken (J/N)
CONST_97	.BYTE 50
.STRG "{clear}{down*2}{right*2}Gesamtsummen drucken (J/N)"
; CONST: ${clear}{up}{right*2}Gesamtsummen Abspeichern (J/N)
CONST_98	.BYTE 50
.STRG "{clear}{up}{right*2}Gesamtsummen Abspeichern (J/N)"
; CONST: ${up}'N' fuer neuen Programmstart{space*6}
CONST_99	.BYTE 41
.STRG "{up}'N' fuer neuen Programmstart{space*6}"
; CONST: ${down}'A' zum Veraendern der alten Werte
CONST_100	.BYTE 40
.STRG "{down}'A' zum Veraendern der alten Werte"
; CONST: $a
CONST_101	.BYTE 1
.STRG "a"
; CONST: $n
CONST_102	.BYTE 1
.STRG "n"
; CONST: $00
CONST_103	.BYTE 2
.STRG "00"
; CONST: $ .
CONST_104	.BYTE 2
.STRG " ."
; CONST: #9

CONST_105R	.REAL 9.0
; CONST: ${down}{space*6}{reverse on}abspeichern der einzelposten{down*3}
CONST_106	.BYTE 63
.STRG "{down}{space*6}{reverse on}abspeichern der einzelposten{down*3}"
; CONST: ${down}name (z.b.januar)
CONST_107	.BYTE 23
.STRG "{down}name (z.b.januar)"
; CONST: ${down}jahr (z.b. 1986)
CONST_108	.BYTE 22
.STRG "{down}jahr (z.b. 1986)"
; CONST: ${down}alte datei ueberschreiben (j/n)
CONST_109	.BYTE 37
.STRG "{down}alte datei ueberschreiben (j/n)"
; CONST: $ eipu
CONST_110	.BYTE 5
.STRG " eipu"
; CONST: ${down}{space*8}{reverse on}laden der einzelposten{down*3}
CONST_111	.BYTE 57
.STRG "{down}{space*8}{reverse on}laden der einzelposten{down*3}"
; CONST: ${down*2}name (z.b.januar)
CONST_112	.BYTE 25
.STRG "{down*2}name (z.b.januar)"
; CONST: ${down*2}jahr (z.b. 1986)
CONST_113	.BYTE 24
.STRG "{down*2}jahr (z.b. 1986)"
; CONST: ${down*3}{yellow}MUCKSOFT
CONST_114	.BYTE 24
.STRG "{down*3}{yellow}MUCKSOFT"
; CONST: ${down}{green}PRESENTS
CONST_115	.BYTE 21
.STRG "{down}{green}PRESENTS"
; CONST: ${down*4}
CONST_116	.BYTE 8
.STRG "{down*4}"
; CONST: ${light blue}{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off}{space*3}{reverse on}{space*3}{reverse off}
CONST_117	.BYTE 357
.STRG "{light blue}{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off}{space*3}{reverse on}{space*3}{reverse off}"
; CONST: ${space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*3}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*4}{reverse on}
CONST_118	.BYTE 362
.STRG "{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*3}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*4}{reverse on} "
; CONST: ${space*5}{reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off}{space*4}{reverse on}
CONST_119	.BYTE 286
.STRG "{space*5}{reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off}{space*4}{reverse on} "
; CONST: ${space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*3}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*4}{reverse on}
CONST_120	.BYTE 362
.STRG "{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*3}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*4}{reverse on} "
; CONST: ${space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off}{space*2}{reverse on}
CONST_121	.BYTE 351
.STRG "{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off}{space*2}{reverse on} "
; CONST: ${clear}{down*2}{space*7}{reverse on}UNTERROUTINE{sh space}SONSTIGES
CONST_122	.BYTE 67
.STRG "{clear}{down*2}{space*7}{reverse on}UNTERROUTINE{sh space}SONSTIGES"
; CONST: ${down*3}Waehlen Sie:
CONST_123	.BYTE 20
.STRG "{down*3}Waehlen Sie:"
; CONST: ${down}'1' fuer Gesamtsummenausgabe
CONST_124	.BYTE 34
.STRG "{down}'1' fuer Gesamtsummenausgabe"
; CONST: ${down}'2' zum Definieren einzelner Punkte
CONST_125	.BYTE 41
.STRG "{down}'2' zum Definieren einzelner Punkte"
; CONST: ${down}'3' fuer Rueckkehr ins Eingabemenue
CONST_126	.BYTE 41
.STRG "{down}'3' fuer Rueckkehr ins Eingabemenue"
; CONST: ${down}'4' zum Laden einer Datei
CONST_127	.BYTE 31
.STRG "{down}'4' zum Laden einer Datei"
; CONST: ${down}'5' zum Anzeigen des Directorys
CONST_128	.BYTE 37
.STRG "{down}'5' zum Anzeigen des Directorys"
; CONST: ${down}'6' zum Abspeichern der Eingabepunkte
CONST_129	.BYTE 43
.STRG "{down}'6' zum Abspeichern der Eingabepunkte"
; CONST: ${down}'7' zum Laden der Eingabepunkte
CONST_130	.BYTE 37
.STRG "{down}'7' zum Laden der Eingabepunkte"
; CONST: $2
CONST_131	.BYTE 1
.STRG "2"
; CONST: $4
CONST_132	.BYTE 1
.STRG "4"
; CONST: $5
CONST_133	.BYTE 1
.STRG "5"
; CONST: $6
CONST_134	.BYTE 1
.STRG "6"
; CONST: $7
CONST_135	.BYTE 1
.STRG "7"
; CONST: ${clear}{space*9}{reverse on}UNTERROUTINE{sh space}DEFINIEREN
CONST_136	.BYTE 60
.STRG "{clear}{space*9}{reverse on}UNTERROUTINE{sh space}DEFINIEREN"
; CONST: ${down}{right}Welchen Wert wollen Sie veraendern ?
CONST_137	.BYTE 49
.STRG "{down}{right}Welchen Wert wollen Sie veraendern ?"
; CONST: ${right}Geben Sie die Zahl ein.
CONST_138	.BYTE 30
.STRG "{right}Geben Sie die Zahl ein."
; CONST: ${right}'0' fuer Zurueckdefinition in normale
CONST_139	.BYTE 44
.STRG "{right}'0' fuer Zurueckdefinition in normale"
; CONST: ${right}Werte.
CONST_140	.BYTE 13
.STRG "{right}Werte."
; CONST: ${right}'RETURN' fuer Ende{down}
CONST_141	.BYTE 31
.STRG "{right}'RETURN' fuer Ende{down}"
; CONST: ${space*5}
CONST_142	.BYTE 9
.STRG "{space*5}"
; CONST: ${space*4}
CONST_143	.BYTE 9
.STRG "{space*4}"
; CONST: ${down}{right}ALSO:
CONST_144	.BYTE 18
.STRG "{down}{right}ALSO:"
; CONST: ${clear}{down}{right*2}In was soll{space*3}
CONST_145	.BYTE 42
.STRG "{clear}{down}{right*2}In was soll{space*3}"
; CONST: ${down}{right*2}veraendert werden (max 20 Buchstaben){down}{right*2}
CONST_146	.BYTE 67
.STRG "{down}{right*2}veraendert werden (max 20 Buchstaben){down}{right*2}"
;###############################
; ******** DATA ********
DATAS
.BYTE 169
.BYTE 36
.BYTE 133
.BYTE 251
.BYTE 169
.BYTE 251
.BYTE 133
.BYTE 187
.BYTE 169
.BYTE 3
.BYTE 0
.BYTE 133
.BYTE 188
.BYTE 169
.BYTE 3
.BYTE 1
.BYTE 133
.BYTE 183
.BYTE 169
.BYTE 8
.BYTE 133
.BYTE 186
.BYTE 169
.BYTE 96
.BYTE 133
.BYTE 185
.BYTE 32
.BYTE 213
.BYTE 243
.BYTE 165
.BYTE 186
.BYTE 32
.BYTE 180
.BYTE 3
.BYTE 255
.BYTE 165
.BYTE 185
.BYTE 32
.BYTE 150
.BYTE 3
.BYTE 255
.BYTE 169
.BYTE 3
.BYTE 0
.BYTE 133
.BYTE 144
.BYTE 160
.BYTE 3
.BYTE 3
.BYTE 132
.BYTE 251
.BYTE 32
.BYTE 165
.BYTE 3
.BYTE 255
.BYTE 133
.BYTE 252
.BYTE 164
.BYTE 144
.BYTE 208
.BYTE 47
.BYTE 32
.BYTE 165
.BYTE 3
.BYTE 255
.BYTE 164
.BYTE 144
.BYTE 208
.BYTE 40
.BYTE 164
.BYTE 251
.BYTE 136
.BYTE 208
.BYTE 233
.BYTE 166
.BYTE 252
.BYTE 32
.BYTE 205
.BYTE 189
.BYTE 169
.BYTE 32
.BYTE 32
.BYTE 210
.BYTE 3
.BYTE 255
.BYTE 32
.BYTE 165
.BYTE 3
.BYTE 255
.BYTE 166
.BYTE 144
.BYTE 208
.BYTE 18
.BYTE 170
.BYTE 240
.BYTE 6
.BYTE 32
.BYTE 210
.BYTE 3
.BYTE 255
.BYTE 76
.BYTE 76
.BYTE 192
.BYTE 169
.BYTE 13
.BYTE 32
.BYTE 210
.BYTE 3
.BYTE 255
.BYTE 160
.BYTE 3
.BYTE 2
.BYTE 208
.BYTE 198
.BYTE 32
.BYTE 66
.BYTE 246
.BYTE 96
.BYTE 2
.BYTE 6
.STRG "JANUAR"
.BYTE 2
.BYTE 7
.STRG "FEBRUAR"
.BYTE 2
.BYTE 5
.STRG "MAERZ"
.BYTE 2
.BYTE 5
.STRG "APRIL"
.BYTE 2
.BYTE 3
.STRG "MAI"
.BYTE 2
.BYTE 4
.STRG "JUNI"
.BYTE 2
.BYTE 4
.STRG "JULI"
.BYTE 2
.BYTE 6
.STRG "AUGUST"
.BYTE 2
.BYTE 9
.STRG "SEPTEMBER"
.BYTE 2
.BYTE 7
.STRG "OKTOBER"
.BYTE 2
.BYTE 8
.STRG "NOVEMBER"
.BYTE 2
.BYTE 8
.STRG "DEZEMBER"
.BYTE 2
.BYTE 6
.STRG "Benzin"
.BYTE 2
.BYTE 14
.STRG "Auto sonstiges"
.BYTE 2
.BYTE 8
.STRG "Kleidung"
.BYTE 2
.BYTE 15
.STRG "Medizin+Hygiene"
.BYTE 2
.BYTE 7
.STRG "Hausrat"
.BYTE 2
.BYTE 8
.STRG "Haushalt"
.BYTE 2
.BYTE 11
.STRG "Taschengeld"
.BYTE 2
.BYTE 7
.STRG "Telefon"
.BYTE 2
.BYTE 6
.STRG "Garten"
.BYTE 2
.BYTE 4
.STRG "Grab"
.BYTE 2
.BYTE 14
.STRG "Sport+Freizeit"
.BYTE 2
.BYTE 20
.STRG "Bausparen+Hypotheken"
.BYTE 2
.BYTE 13
.STRG "Strom+Zeitung"
.BYTE 2
.BYTE 8
.STRG "Sontiges"
.BYTE 2
.BYTE 11
.STRG "Undefiniert"
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: I
VAR_I	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: N
VAR_N	.REAL 0.0
; VAR: PU
VAR_PU	.REAL 0.0
; VAR: V
VAR_V	.REAL 0.0
; VAR: SU
VAR_SU	.REAL 0.0
; VAR: GS[]
.BYTE 1
.WORD 80
VAR_GS[]	.ARRAY 80
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: OK
VAR_OK	.REAL 0.0
; VAR: Z
VAR_Z	.REAL 0.0
; VAR: Q
VAR_Q	.REAL 0.0
; VAR: FE
VAR_FE	.REAL 0.0
; VAR: UN
VAR_UN	.REAL 0.0
; VAR: M[]
.BYTE 1
.WORD 65
VAR_M[]	.ARRAY 65
; VAR: P
VAR_P	.REAL 0.0
; VAR: M
VAR_M	.REAL 0.0
; VAR: NU[]
.BYTE 1
.WORD 80
VAR_NU[]	.ARRAY 80
; VAR: A
VAR_A	.REAL 0.0
; VAR: C
VAR_C	.REAL 0.0
; VAR: D
VAR_D	.REAL 0.0
; VAR: E
VAR_E	.REAL 0.0
; VAR: GE
VAR_GE	.REAL 0.0
; VAR: VE
VAR_VE	.REAL 0.0
STRINGVARS_START
; VAR: A$
VAR_A$	.WORD EMPTYSTR
; VAR: SU$
VAR_SU$	.WORD EMPTYSTR
; VAR: Y$
VAR_Y$	.WORD EMPTYSTR
; VAR: MO$
VAR_MO$	.WORD EMPTYSTR
; VAR: J$
VAR_J$	.WORD EMPTYSTR
; VAR: UE$
VAR_UE$	.WORD EMPTYSTR
; VAR: B$
VAR_B$	.WORD EMPTYSTR
; VAR: E$
VAR_E$	.WORD EMPTYSTR
; VAR: M$
VAR_M$	.WORD EMPTYSTR
; VAR: GE$
VAR_GE$	.WORD EMPTYSTR
; VAR: VE$
VAR_VE$	.WORD EMPTYSTR
; VAR: X$
VAR_X$	.WORD EMPTYSTR
; VAR: TI$
VAR_TI$ .WORD EMPTYSTR
STRINGVARS_END
STRINGARRAYS_START
; VAR: MO$[]
.BYTE 2
.WORD 26
VAR_MO$[]
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR
; VAR: PU$[]
.BYTE 2
.WORD 96
VAR_PU$[]
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
; VAR: GS$[]
.BYTE 2
.WORD 32
VAR_GS$[]
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
; VAR: P$[]
.BYTE 2
.WORD 32
VAR_P$[]
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
.WORD EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR EMPTYSTR
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
