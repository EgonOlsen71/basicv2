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
LDX #4
dcloop235_1:
LDA CONST_0,X
STA VAR_V,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_11:
;
LDY #$15
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_V
LDY #>VAR_V
JSR INTADDPOKE
STY MOVBSELF1+1
STA MOVBSELF1+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$1
MOVBSELF1:
STA $FFFF
;
LINE_12:
;
LDY #13
STY 2040
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
LDA #<CONST_5R
LDY #>CONST_5R
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
LDA #<CONST_6R
LDY #>CONST_6R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
JSR FACWORD
STY MOVBSELF3+1
STA MOVBSELF3+2
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFAC
JSR FACWORD
MOVBSELF3:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
LDA #<CONST_7
LDY #>CONST_7
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
JSR FACWORD
STY MOVBSELF4+1
STA MOVBSELF4+2
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFAC
JSR FACWORD
MOVBSELF4:
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
LINE_25:
;
JSR GOSUB
JSR LINE_900
;
LINE_30:
;
LDX #4
dcloop401_1:
LDA CONST_8R,X
STA VAR_X,X
DEX
BPL dcloop401_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
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
LDX #4
dcloop401_2:
LDA VAR_X,X
STA VAR_Y,X
DEX
BPL dcloop401_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_35:
;
;
LINE_40:
;
LDA #<VAR_X
LDY #>VAR_X
JSR COPY2_XYA_XREG
LDA #<VAR_V
LDY #>VAR_V
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF5+1
STA MOVBSELF5+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF5:
STY $FFFF
;
LINE_50:
;
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_V
LDY #>VAR_V
JSR INTADDPOKE
STY MOVBSELF6+1
STA MOVBSELF6+2
; Fast add for POKE(2)
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
JSR FACWORD
MOVBSELF6:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_55:
LDX #4
dcloop567_1:
LDA VAR_X,X
STA VAR_XP,X
LDA VAR_Y,X
STA VAR_YP,X
DEX
BPL dcloop567_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_1000
;
LINE_60:
;
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
;
LINE_70:
;
JMP LINE_30
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
LINE_898:
;
;
LINE_899:
;
;
LINE_900:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_2R
LDY #>CONST_2R
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
LINE_910:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_11R
LDY #>CONST_11R
JSR MEMARG
JSR FACPOW
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_PW[]
LDY #>VAR_PW[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_920:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_PW[]
LDY #>VAR_PW[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<CONST_12R
LDY #>CONST_12R
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
LDA #<CONST_12R
LDY #>CONST_12R
JSR MEMARG
JSR FASTAND
; Optimizer rule: Swap AND order/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_MA[]
LDY #>VAR_MA[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
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
LINE_930:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_13R
LDY #>CONST_13R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_PW[]
LDY #>VAR_PW[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #0
STA VAR_RO
STA VAR_RO+1
STA VAR_RO+2
STA VAR_RO+3
STA VAR_RO+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_14
LDY #>CONST_14
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #6
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA #<CONST_15R
LDY #>CONST_15R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ0:
EQ_SKIP0:
COMP_SKP3:
BNE LINE_SKIP14
LINE_NSKIP14:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1065_1:
LDA CONST_16R,X
STA VAR_RO,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP14:
;
;
LINE_940:
;
;
LINE_950:
;
JMP RETURN
;
LINE_998:
;
;
LINE_999:
;
;
LINE_1000:
;
LDX #4
dcloop1065_2:
LDA CONST_0,X
STA VAR_V,X
DEX
BPL dcloop1065_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_RO
LDY #>VAR_RO
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CA
LDY #>VAR_CA
; FAC to (X/Y)
JSR FACMEM
;
LINE_1020:
;
JSR GOSUB
JSR LINE_5000
;
LINE_1040:
;
;
LINE_1060:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_5020
LDA #0
STA VAR_II
STA VAR_II+1
STA VAR_II+2
STA VAR_II+3
STA VAR_II+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_CG
STA VAR_CG+1
STA VAR_CG+2
STA VAR_CG+3
STA VAR_CG+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_OY
STA VAR_OY+1
STA VAR_OY+2
STA VAR_OY+3
STA VAR_OY+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1065:
;
JSR GOSUB
JSR LINE_5500
;
LINE_1070:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_7
LDY #>CONST_7
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
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
LDX #<VAR_LA
LDY #>VAR_LA
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_CN
LDY #>VAR_CN
JSR REALFAC
LDA #<VAR_CH
LDY #>VAR_CH
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
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
LDX #<VAR_CP
LDY #>VAR_CP
; FAC to (X/Y)
JSR FACMEM
;
LINE_1075:
;
LDA VAR_LA
BEQ EQ_SKIP1
EQ_EQ1:
JMP LINE_SKIP15
EQ_SKIP1:
COMP_SKP4:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP15:
;
JMP LINE_1085
;
LINE_SKIP15:
;
;
LINE_1080:
;
LDA #<VAR_CX
LDY #>VAR_CX
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_PW[]
LDY #>VAR_PW[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<VAR_CP
LDY #>VAR_CP
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; FAC = ARG * FAC
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CP
LDY #>VAR_CP
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_12R
LDY #>CONST_12R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_CP
LDY #>VAR_CP
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
LDX #<VAR_CP
LDY #>VAR_CP
JSR FACMEM
; Optimizer rule: Omit FAC load/4
LDA #<VAR_LA
LDY #>VAR_LA
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_LA
LDY #>VAR_LA
; FAC to (X/Y)
JSR FACMEM
;
LINE_1082:
;
LDA #<VAR_CX
LDY #>VAR_CX
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA Y_REG
COMP_SKP5:
BNE LINE_NSKIP16
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP16
;
LINE_NSKIP16:
;
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
LDA #<VAR_II
LDY #>VAR_II
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ2
ROL
BCC LT_LT2
LT_LT_EQ2:
LDA #0
JMP LT_SKIP2
LT_LT2:
LDA #$1
LT_SKIP2:
COMP_SKP6:
BEQ LINE_SKIP17
; Simplified conditional branch
;
LINE_NSKIP17:
;
JSR GOSUB
JSR LINE_5100
;
LINE_SKIP17:
;
;
LINE_SKIP16:
;
;
LINE_1084:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_18
LDY #>CONST_18
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
JSR FACWORD
STY MOVBSELF9+1
STA MOVBSELF9+2
LDA #<VAR_LA
LDY #>VAR_LA
JSR REALFAC
JSR FACWORD
MOVBSELF9:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
JSR GOSUB
JSR LINE_5600
;
LINE_1085:
;
LDA #<CONST_17R
LDY #>CONST_17R
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_CG
LDY #>VAR_CG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CG
LDY #>VAR_CG
; FAC to (X/Y)
JSR FACMEM
;
LINE_1090:
;
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
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
COMP_SKP7:
BNE LINE_NSKIP18
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP18
;
LINE_NSKIP18:
;
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_CG
LDY #>VAR_CG
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
COMP_SKP8:
BNE LINE_NSKIP19
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP19
;
LINE_NSKIP19:
;
LDA #<CONST_20R
LDY #>CONST_20R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ5
ROL
BCC LT_LT5
LT_LT_EQ5:
LDA #0
JMP LT_SKIP5
LT_LT5:
LDA #$1
LT_SKIP5:
COMP_SKP9:
BEQ LINE_SKIP20
; Simplified conditional branch
;
LINE_NSKIP20:
;
JMP LINE_1065
;
LINE_SKIP20:
;
;
LINE_SKIP19:
;
;
LINE_SKIP18:
;
;
LINE_1100:
;
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ6
BCS GTEQ_GTEQ6
LDA #0
JMP GTEQ_SKIP6
GTEQ_GTEQ6:
LDA #$1
GTEQ_SKIP6:
COMP_SKP10:
BEQ LINE_SKIP21
; Simplified conditional branch
;
LINE_NSKIP21:
;
JMP RETURN
;
LINE_SKIP21:
;
;
LINE_1102:
;
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_CN
LDY #>VAR_CN
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ7
LDA #0
JMP EQ_SKIP7
EQ_EQ7:
LDA #$1
EQ_SKIP7:
COMP_SKP11:
BNE LINE_NSKIP22
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP22
;
LINE_NSKIP22:
;
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_CG
LDY #>VAR_CG
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
COMP_SKP12:
BEQ LINE_SKIP23
; Simplified conditional branch
;
LINE_NSKIP23:
;
LDA VAR_OY
BEQ EQ_SKIP9
EQ_EQ9:
JMP LINE_SKIP24
EQ_SKIP9:
COMP_SKP13:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP24:
;
JSR GOSUB
JSR LINE_5040
JMP LINE_1065
;
LINE_SKIP24:
;
;
LINE_SKIP23:
;
;
LINE_SKIP22:
;
;
LINE_1104:
;
LDA #<VAR_OY
LDY #>VAR_OY
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA Y_REG
COMP_SKP14:
BNE LINE_NSKIP25
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP25
;
LINE_NSKIP25:
;
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_YP
LDY #>VAR_YP
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YP
LDY #>VAR_YP
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA VAR_OY
STA VAR_OY+1
STA VAR_OY+2
STA VAR_OY+3
STA VAR_OY+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP25:
;
;
LINE_1110:
;
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_XP
LDY #>VAR_XP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XP
LDY #>VAR_XP
; FAC to (X/Y)
JSR FACMEM
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
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
LDA #<VAR_II
LDY #>VAR_II
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ10
LDA #0
JMP EQ_SKIP10
EQ_EQ10:
LDA #$1
EQ_SKIP10:
COMP_SKP15:
BNE LINE_NSKIP26
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP26
;
LINE_NSKIP26:
;
LDA #<CONST_1R
LDY #>CONST_1R
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
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFAC
LDA #<VAR_XP
LDY #>VAR_XP
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XP
LDY #>VAR_XP
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_YP
LDY #>VAR_YP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YP
LDY #>VAR_YP
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP26:
;
;
LINE_1120:
;
LDX #4
dcloop2725_1:
LDA VAR_II,X
STA VAR_I,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_5020
JSR GOSUB
JSR LINE_5000
;
LINE_1130:
;
LDA #0
STA VAR_CG
STA VAR_CG+1
STA VAR_CG+2
STA VAR_CG+3
STA VAR_CG+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_1065
;
LINE_4998:
;
;
LINE_4999:
;
;
LINE_5000:
;
LDA #<CONST_8R
LDY #>CONST_8R
JSR REALFAC
LDA #<VAR_XP
LDY #>VAR_XP
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDY #3
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XS
LDY #>VAR_XS
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_22R
LDY #>CONST_22R
JSR REALFAC
LDA #<VAR_YP
LDY #>VAR_YP
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
LDY #3
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHR
; Optimizer rule: Shorter SHR/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YS
LDY #>VAR_YS
; FAC to (X/Y)
JSR FACMEM
;
LINE_5010:
;
LDA #<VAR_YS
LDY #>VAR_YS
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
LDA #<VAR_XS
LDY #>VAR_XS
JSR REALFAC
LDA #<CONST_24
LDY #>CONST_24
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF10+1
STA MOVBSELF10+2
MOVBSELF10:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
LDY #3
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_CA
LDY #>VAR_CA
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CH
LDY #>VAR_CH
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_5018:
;
;
LINE_5019:
;
;
LINE_5020:
;
LDA #<CONST_22R
LDY #>CONST_22R
JSR REALFAC
LDA #<VAR_YP
LDY #>VAR_YP
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_10R
LDY #>CONST_10R
JSR MEMARG
JSR FASTAND
; Optimizer rule: Swap AND order/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CN
LDY #>VAR_CN
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
LDA #<VAR_XP
LDY #>VAR_XP
JSR MEMARG
JSR FASTAND
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CX
LDY #>VAR_CX
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_5038:
;
;
LINE_5039:
;
;
LINE_5040:
;
LDA #<VAR_CN
LDY #>VAR_CN
JSR REALFAC
LDA #<CONST_10R
LDY #>CONST_10R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CG
LDY #>VAR_CG
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA VAR_CN
STA VAR_CN+1
STA VAR_CN+2
STA VAR_CN+3
STA VAR_CN+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_YP
LDY #>VAR_YP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_YP
LDY #>VAR_YP
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_5000
LDX #4
dcloop3223_1:
LDA CONST_25,X
STA VAR_OY,X
DEX
BPL dcloop3223_1
; Optimizer rule: Direct copy of floats into mem/6
JMP RETURN
;
LINE_5098:
;
;
LINE_5099:
;
;
LINE_5100:
;
LDA #<CONST_26R
LDY #>CONST_26R
JSR REALFAC
LDA #<VAR_XS
LDY #>VAR_XS
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ11
BCS GTEQ_GTEQ11
LDA #0
JMP GTEQ_SKIP11
GTEQ_GTEQ11:
LDA #$1
GTEQ_SKIP11:
COMP_SKP16:
BEQ LINE_SKIP27
; Simplified conditional branch
;
LINE_NSKIP27:
;
JMP RETURN
;
LINE_SKIP27:
;
;
LINE_5110:
;
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_XP
LDY #>VAR_XP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XP
LDY #>VAR_XP
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_5000
;
LINE_5130:
;
LDA #<VAR_CN
LDY #>VAR_CN
JSR REALFAC
LDA #<VAR_CH
LDY #>VAR_CH
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
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
LDX #<VAR_CP
LDY #>VAR_CP
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_CX
LDY #>VAR_CX
JSR REALFAC
LDA #<CONST_19R
LDY #>CONST_19R
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_PW[]
LDY #>VAR_PW[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
LDA #<VAR_CP
LDY #>VAR_CP
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid Y_REG copy/4
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FACDIV
; Optimizer rule: Combine load and div/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CP
LDY #>VAR_CP
; FAC to (X/Y)
JSR FACMEM
;
LINE_5140:
;
LDA #<VAR_CX
LDY #>VAR_CX
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_MA[]
LDY #>VAR_MA[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
LDX #<VAR_MM
LDY #>VAR_MM
; FAC to (X/Y)
JSR FACMEM
;
LINE_5150:
;
LDA #<CONST_12R
LDY #>CONST_12R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_MM
LDY #>VAR_MM
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
JSR PUSHREAL
LDA #<VAR_CP
LDY #>VAR_CP
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
LDX #<VAR_CP
LDY #>VAR_CP
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_MM
LDY #>VAR_MM
JSR REALFAC
LDA #<VAR_CP
LDY #>VAR_CP
JSR MEMARG
JSR FASTOR
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: Faster logic OR/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_LA
LDY #>VAR_LA
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_LA
LDY #>VAR_LA
; FAC to (X/Y)
JSR FACMEM
;
LINE_5160:
;
LDA #<CONST_19R
LDY #>CONST_19R
JSR REALFAC
LDA #<VAR_XP
LDY #>VAR_XP
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_XP
LDY #>VAR_XP
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_5000
JMP RETURN
;
LINE_5498:
;
;
LINE_5499:
;
;
LINE_5500:
;
LDA #<CONST_27
LDY #>CONST_27
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #254
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
STY 56334
LDA 1
AND #251
STA 1
; Simplified POKE Y,PEEK(X) OR/AND c
;
;
;
;
;
;
;
;
; Optimizer rule: Faster PEEKBYTEAND/2
;
LINE_5510:
;
JMP RETURN
;
LINE_5598:
;
;
LINE_5599:
;
;
LINE_5600:
;
LDA #<CONST_2R
LDY #>CONST_2R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #4
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEOR
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
STY 1
LDA 56334
ORA #1
STA 56334
; Simplified POKE Y,PEEK(X) OR/AND c
;
;
;
;
;
;
;
;
; Optimizer rule: Faster PEEKBYTEOR/2
;
LINE_5610:
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
RESTORE		LDA #<DATAS
LDY #>DATAS
STA DATASP
STY DATASP+1
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
PEEKBYTEOR
JSR PEEKBYTESUB
PEEKBYTEORSUBINT
TYA
ORA A_REG
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
STA VAR_V,Y
STA VAR_N,Y
STA VAR_Q,Y
STA VAR_X,Y
STA VAR_Y,Y
STA VAR_XP,Y
STA VAR_YP,Y
STA VAR_I,Y
STA VAR_RO,Y
STA VAR_CA,Y
STA VAR_II,Y
STA VAR_CG,Y
STA VAR_OY,Y
STA VAR_LA,Y
STA VAR_CN,Y
STA VAR_CH,Y
STA VAR_CP,Y
STA VAR_CX,Y
STA VAR_XS,Y
STA VAR_YS,Y
STA VAR_MM,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
LDA #<VAR_PW[]
LDY #>VAR_PW[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_MA[]
LDY #>VAR_MA[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #53248

CONST_0	.REAL 53248
; CONST: #21

CONST_1R	.REAL 21.0
; CONST: #1

CONST_2R	.REAL 1.0
; CONST: #13


; CONST: #0


; CONST: #62

CONST_5R	.REAL 62.0
; CONST: #832

CONST_6R	.REAL 832.0
; CONST: #49152

CONST_7	.REAL 49152
; CONST: #24

CONST_8R	.REAL 24.0
; CONST: #200

CONST_9R	.REAL 200.0
; CONST: #7

CONST_10R	.REAL 7.0
; CONST: #2

CONST_11R	.REAL 2.0
; CONST: #255

CONST_12R	.REAL 255.0
; CONST: #256

CONST_13R	.REAL 256.0
; CONST: #53272

CONST_14	.REAL 53272
; CONST: #6

CONST_15R	.REAL 6.0
; CONST: #2048

CONST_16R	.REAL 2048.0
; CONST: #3

CONST_17R	.REAL 3.0
; CONST: #832.0

CONST_18	.REAL 832.0
; CONST: #8

CONST_19R	.REAL 8.0
; CONST: #63

CONST_20R	.REAL 63.0
; CONST: #66

CONST_21R	.REAL 66.0
; CONST: #50

CONST_22R	.REAL 50.0
; CONST: #5


; CONST: #1024.0

CONST_24	.REAL 1024.0
; CONST: #-1.0

CONST_25	.REAL -1.0
; CONST: #39

CONST_26R	.REAL 39.0
; CONST: #56334

CONST_27	.REAL 56334
; CONST: #254


; CONST: #251


; CONST: #4


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
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: V
VAR_V	.REAL 0.0
; VAR: N
VAR_N	.REAL 0.0
; VAR: Q
VAR_Q	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: XP
VAR_XP	.REAL 0.0
; VAR: YP
VAR_YP	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: PW[]
.BYTE 1
.WORD 45
VAR_PW[]	.ARRAY 45
; VAR: MA[]
.BYTE 1
.WORD 45
VAR_MA[]	.ARRAY 45
; VAR: RO
VAR_RO	.REAL 0.0
; VAR: CA
VAR_CA	.REAL 0.0
; VAR: II
VAR_II	.REAL 0.0
; VAR: CG
VAR_CG	.REAL 0.0
; VAR: OY
VAR_OY	.REAL 0.0
; VAR: LA
VAR_LA	.REAL 0.0
; VAR: CN
VAR_CN	.REAL 0.0
; VAR: CH
VAR_CH	.REAL 0.0
; VAR: CP
VAR_CP	.REAL 0.0
; VAR: CX
VAR_CX	.REAL 0.0
; VAR: XS
VAR_XS	.REAL 0.0
; VAR: YS
VAR_YS	.REAL 0.0
; VAR: MM
VAR_MM	.REAL 0.0
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
