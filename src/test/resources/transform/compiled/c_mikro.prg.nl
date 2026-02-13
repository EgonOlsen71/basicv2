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
LDA #<CONST_1
LDY #>CONST_1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15:
;
;
LINE_20:
;
LDA #0
STA VAR_G
STA VAR_G+1
STA VAR_G+2
STA VAR_G+3
STA VAR_G+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_1780
JMP LINE_590
;
LINE_30:
;
;
LINE_40:
;
JSR GOSUB
JSR LINE_400
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF1+1
STA MOVBSELF1+2
LDA #$A9
MOVBSELF1:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF2+1
STA MOVBSELF2+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF2:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDX #4
dcloop235_1:
LDA CONST_5R,X
STA VAR_K,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_50:
;
LDA #<VAR_V
LDY #>VAR_V
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA Y_REG
COMP_SKP0:
BNE LINE_NSKIP86
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP86
;
LINE_NSKIP86:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF3+1
STA MOVBSELF3+2
LDA #$AD
MOVBSELF3:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF4+1
STA MOVBSELF4+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF4:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDX #4
dcloop235_2:
LDA CONST_7R,X
STA VAR_K,X
DEX
BPL dcloop235_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP86:
;
;
LINE_60:
;
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF5+1
STA MOVBSELF5+2
LDA #$AE
MOVBSELF5:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF6+1
STA MOVBSELF6+2
; Fast add for POKE(2)
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
JSR FACWORD
MOVBSELF6:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF7+1
STA MOVBSELF7+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF7:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_70:
;
LDA VAR_V
BEQ EQ_EQ0
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP0
EQ_EQ0:
LDA #$1
EQ_SKIP0:
COMP_SKP1:
BNE LINE_NSKIP87
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP87
;
LINE_NSKIP87:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF8+1
STA MOVBSELF8+2
LDA #$A2
MOVBSELF8:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF9+1
STA MOVBSELF9+2
; Fast add for POKE(2)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF9:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_SKIP87:
;
;
LINE_80:
;
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
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
LINE_90:
;
;
LINE_100:
;
LDA #0
STA VAR_P
STA VAR_P+1
STA VAR_P+2
STA VAR_P+3
STA VAR_P+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF10+1
STA MOVBSELF10+2
MOVBSELF10:
LDA $FFFF
CMP #194
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
BEQ EQ_EQ1
LDA #0
JMP EQ_SKIP1
EQ_EQ1:
LDA #$1
EQ_SKIP1:
COMP_SKP2:
BNE LINE_NSKIP88
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP88
;
LINE_NSKIP88:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop401_1:
LDA CONST_4R,X
STA VAR_P,X
DEX
BPL dcloop401_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP88:
;
;
LINE_110:
;
JSR GOSUB
JSR LINE_40
;
LINE_120:
;
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT2
LDA #0
JMP GT_SKIP2
GT_GT2:
LDA #$1
GT_SKIP2:
COMP_SKP3:
BEQ LINE_SKIP89
; Simplified conditional branch
;
LINE_NSKIP89:
;
LDA #<CONST_12
LDY #>CONST_12
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ER
LDY #>VAR_ER
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_SKIP89:
;
;
LINE_130:
;
LDA #0
STA VAR_O
STA VAR_O+1
STA VAR_O+2
STA VAR_O+3
STA VAR_O+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
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
LDX #<VAR_B
LDY #>VAR_B
; FAC to (X/Y)
JSR FACMEM
LDX #4
dceloop4982_1:
LDA CONST_6R,X
CMP VAR_B,X
BNE LINE_SKIP90
DEX
BPL dceloop4982_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP90:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_280
;
LINE_SKIP90:
;
;
LINE_140:
;
LDX #4
dceloop4982_2:
LDA CONST_13R,X
CMP VAR_B,X
BNE LINE_SKIP91
DEX
BPL dceloop4982_2
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP91:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_280
;
LINE_SKIP91:
;
;
LINE_150:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ5
LDA #0
JMP EQ_SKIP5
EQ_EQ5:
LDA #$1
EQ_SKIP5:
COMP_SKP6:
BNE LINE_NSKIP92
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP92
;
LINE_NSKIP92:
;
LDX #4
dcloop401_2:
LDA CONST_15R,X
STA VAR_O,X
DEX
BPL dcloop401_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF12+1
STA MOVBSELF12+2
LDA #$18
MOVBSELF12:
STA $FFFF
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
LINE_SKIP92:
;
;
LINE_160:
;
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ6
LDA #0
JMP EQ_SKIP6
EQ_EQ6:
LDA #$1
EQ_SKIP6:
COMP_SKP7:
BNE LINE_NSKIP93
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP93
;
LINE_NSKIP93:
;
LDX #4
dcloop401_3:
LDA CONST_18R,X
STA VAR_O,X
DEX
BPL dcloop401_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF13+1
STA MOVBSELF13+2
LDA #$38
MOVBSELF13:
STA $FFFF
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
LINE_SKIP93:
;
;
LINE_170:
;
LDX #4
dceloop4982_3:
LDA CONST_20R,X
CMP VAR_B,X
BNE LINE_SKIP94
DEX
BPL dceloop4982_3
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP94:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop567_1:
LDA CONST_21R,X
STA VAR_O,X
DEX
BPL dcloop567_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP94:
;
;
LINE_180:
;
LDX #4
dceloop4982_4:
LDA CONST_22R,X
CMP VAR_B,X
BNE LINE_SKIP95
DEX
BPL dceloop4982_4
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP95:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop567_2:
LDA CONST_23R,X
STA VAR_O,X
DEX
BPL dcloop567_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP95:
;
;
LINE_190:
;
LDA VAR_O
BEQ EQ_SKIP9
EQ_EQ9:
JMP LINE_SKIP96
EQ_SKIP9:
COMP_SKP10:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP96:
;
JMP LINE_320
;
LINE_SKIP96:
;
;
LINE_200:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_400
LDA #<VAR_A
LDY #>VAR_A
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF14+1
STA MOVBSELF14+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF14:
STY $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF15+1
STA MOVBSELF15+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF15:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDX #4
dcloop567_3:
LDA CONST_5R,X
STA VAR_K,X
DEX
BPL dcloop567_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_210:
;
LDA #<VAR_V
LDY #>VAR_V
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA Y_REG
COMP_SKP11:
BNE LINE_NSKIP97
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP97
;
LINE_NSKIP97:
;
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF16+1
STA MOVBSELF16+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF16:
STY $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF17+1
STA MOVBSELF17+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF17:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDX #4
dcloop567_4:
LDA CONST_7R,X
STA VAR_K,X
DEX
BPL dcloop567_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP97:
;
;
LINE_220:
;
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF18+1
STA MOVBSELF18+2
LDA #$A8
MOVBSELF18:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF19+1
STA MOVBSELF19+2
; Fast add for POKE(2)
;
;
;
;
LDA #$8A
MOVBSELF19:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
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
LINE_230:
;
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF20+1
STA MOVBSELF20+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF20:
STY $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF21+1
STA MOVBSELF21+2
; Fast add for POKE(2)
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
JSR FACWORD
MOVBSELF21:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF22+1
STA MOVBSELF22+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF22:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_240:
;
LDA VAR_V
BEQ EQ_EQ10
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP10
EQ_EQ10:
LDA #$1
EQ_SKIP10:
COMP_SKP12:
BNE LINE_NSKIP98
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP98
;
LINE_NSKIP98:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF23+1
STA MOVBSELF23+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF23:
STY $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF24+1
STA MOVBSELF24+2
; Fast add for POKE(2)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF24:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_SKIP98:
;
;
LINE_250:
;
LDA #<VAR_K
LDY #>VAR_K
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF25+1
STA MOVBSELF25+2
LDA #$AA
MOVBSELF25:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF26+1
STA MOVBSELF26+2
; Fast add for POKE(2)
;
;
;
;
LDA #$98
MOVBSELF26:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
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
LINE_260:
;
JMP LINE_120
;
LINE_270:
;
;
LINE_280:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF27+1
STA MOVBSELF27+2
LDA #$85
MOVBSELF27:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF28+1
STA MOVBSELF28+2
; Fast add for POKE(2)
;
;
;
;
LDA #$61
MOVBSELF28:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF29+1
STA MOVBSELF29+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$86
MOVBSELF29:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF30+1
STA MOVBSELF30+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$62
MOVBSELF30:
STA $FFFF
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_40
;
LINE_290:
;
LDX #4
dcloop899_1:
LDA CONST_4R,X
STA VAR_G,X
DEX
BPL dcloop899_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF31+1
STA MOVBSELF31+2
LDA #$18
MOVBSELF31:
STA $FFFF
LDX #4
dceloop4982_5:
LDA CONST_6R,X
CMP VAR_B,X
BNE LINE_SKIP99
DEX
BPL dceloop4982_5
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP99:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF32+1
STA MOVBSELF32+2
LDA #$38
MOVBSELF32:
STA $FFFF
;
LINE_SKIP99:
;
;
LINE_300:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_570
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF33+1
STA MOVBSELF33+2
; Fast add for POKE(2)
;
;
;
;
LDA #$20
MOVBSELF33:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF34+1
STA MOVBSELF34+2
; Fast add for POKE(1)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF34:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF35+1
STA MOVBSELF35+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF35:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
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
JMP LINE_120
;
LINE_310:
;
;
LINE_320:
;
LDA VAR_P
BEQ EQ_SKIP12
EQ_EQ12:
JMP LINE_SKIP100
EQ_SKIP12:
COMP_SKP14:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP100:
;
JMP RETURN
;
LINE_SKIP100:
;
;
LINE_330:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF36+1
STA MOVBSELF36+2
LDA #$85
MOVBSELF36:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF37+1
STA MOVBSELF37+2
; Fast add for POKE(2)
;
;
;
;
LDA #$22
MOVBSELF37:
STA $FFFF
;
LINE_340:
;
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF38+1
STA MOVBSELF38+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$86
MOVBSELF38:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF39+1
STA MOVBSELF39+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$23
MOVBSELF39:
STA $FFFF
;
LINE_350:
;
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF40+1
STA MOVBSELF40+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$A2
MOVBSELF40:
STA $FFFF
LDY #$05
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF41+1
STA MOVBSELF41+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$0
MOVBSELF41:
STA $FFFF
;
LINE_360:
;
LDY #$06
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF42+1
STA MOVBSELF42+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$A0
MOVBSELF42:
STA $FFFF
LDY #$07
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF43+1
STA MOVBSELF43+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$0
MOVBSELF43:
STA $FFFF
;
LINE_370:
;
LDY #$08
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF44+1
STA MOVBSELF44+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$B1
MOVBSELF44:
STA $FFFF
LDY #$09
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF45+1
STA MOVBSELF45+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$22
MOVBSELF45:
STA $FFFF
;
LINE_380:
;
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA VAR_P
STA VAR_P+1
STA VAR_P+2
STA VAR_P+3
STA VAR_P+4
; Optimizer rule: Simplified setting to 0/6
JMP LINE_120
;
LINE_390:
;
;
LINE_400:
;
LDA #0
STA VAR_N
STA VAR_N+1
STA VAR_N+2
STA VAR_N+3
STA VAR_N+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V
STA VAR_V+1
STA VAR_V+2
STA VAR_V+3
STA VAR_V+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF46+1
STA MOVBSELF46+2
MOVBSELF46:
LDA $FFFF
CMP #65
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
BEQ LT_LT_EQ13
ROL
BCC LT_LT13
LT_LT_EQ13:
LDA #0
JMP LT_SKIP13
LT_LT13:
LDA #$1
LT_SKIP13:
COMP_SKP15:
BEQ LINE_SKIP101
; Simplified conditional branch
;
LINE_NSKIP101:
;
JMP LINE_420
;
LINE_SKIP101:
;
;
LINE_410:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF47+1
STA MOVBSELF47+2
MOVBSELF47:
LDA $FFFF
CMP #91
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
BEQ LINE_SKIP102
; Simplified conditional branch
;
LINE_NSKIP102:
;
JMP LINE_490
;
LINE_SKIP102:
;
;
LINE_420:
;
LDA #0
STA VAR_T
STA VAR_T+1
STA VAR_T+2
STA VAR_T+3
STA VAR_T+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF48+1
STA MOVBSELF48+2
MOVBSELF48:
LDA $FFFF
CMP #170
BCC PEEKLT3
BEQ PEEKEQ3
LDA #$FF
JMP PEEKDONE3
PEEKLT3:
LDA #$01
JMP PEEKDONE3
PEEKEQ3:
LDA #0
PEEKDONE3:
; Optimized comparison for PEEK
;
;
EQ_EQ15:
EQ_SKIP15:
COMP_SKP17:
BNE LINE_SKIP103
LINE_NSKIP103:
; Optimizer rule: Simplified equal comparison/6
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JMP LINE_440
;
LINE_SKIP103:
;
;
LINE_430:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF49+1
STA MOVBSELF49+2
MOVBSELF49:
LDA $FFFF
CMP #171
BCC PEEKLT4
BEQ PEEKEQ4
LDA #$FF
JMP PEEKDONE4
PEEKLT4:
LDA #$01
JMP PEEKDONE4
PEEKEQ4:
LDA #0
PEEKDONE4:
; Optimized comparison for PEEK
;
;
EQ_EQ16:
EQ_SKIP16:
COMP_SKP18:
BNE LINE_SKIP104
LINE_NSKIP104:
; Optimizer rule: Simplified equal comparison/6
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop1231_1:
LDA CONST_4R,X
STA VAR_T,X
DEX
BPL dcloop1231_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP104:
;
;
LINE_440:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF50+1
STA MOVBSELF50+2
MOVBSELF50:
LDA $FFFF
CMP #57
BCC PEEKLT5
BEQ PEEKEQ5
LDA #$FF
JMP PEEKDONE5
PEEKLT5:
LDA #$01
JMP PEEKDONE5
PEEKEQ5:
LDA #0
PEEKDONE5:
; Optimized comparison for PEEK
;
;
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
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF51+1
STA MOVBSELF51+2
MOVBSELF51:
LDA $FFFF
CMP #48
BCC PEEKLT6
BEQ PEEKEQ6
LDA #$FF
JMP PEEKDONE6
PEEKLT6:
LDA #$01
JMP PEEKDONE6
PEEKEQ6:
LDA #0
PEEKDONE6:
; Optimized comparison for PEEK
;
;
BEQ LT_LT_EQ18
ROL
BCC LT_LT18
LT_LT_EQ18:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP18
LT_LT18:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP18:
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
COMP_SKP19:
BNE LINE_NSKIP105
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP105
;
LINE_NSKIP105:
;
LDA #<CONST_47
LDY #>CONST_47
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR REALOUT
JSR CRSRRIGHT
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF52+1
STA MOVBSELF52+2
MOVBSELF52:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ER
LDY #>VAR_ER
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP105:
;
;
LINE_450:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF53+1
STA MOVBSELF53+2
MOVBSELF53:
LDA $FFFF
CMP #58
BCC PEEKLT7
BEQ PEEKEQ7
LDA #$FF
JMP PEEKDONE7
PEEKLT7:
LDA #$01
JMP PEEKDONE7
PEEKEQ7:
LDA #0
PEEKDONE7:
; Optimized comparison for PEEK
;
;
BEQ LT_LT_EQ19
ROL
BCC LT_LT19
LT_LT_EQ19:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP19
LT_LT19:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP19:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF54+1
STA MOVBSELF54+2
MOVBSELF54:
LDA $FFFF
CMP #47
BCC PEEKLT8
BEQ PEEKEQ8
LDA #$FF
JMP PEEKDONE8
PEEKLT8:
LDA #$01
JMP PEEKDONE8
PEEKEQ8:
LDA #0
PEEKDONE8:
; Optimized comparison for PEEK
;
;
ROL
BCS GT_GT20
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP20
GT_GT20:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP20:
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
COMP_SKP20:
BNE LINE_NSKIP106
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP106
;
LINE_NSKIP106:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF55+1
STA MOVBSELF55+2
MOVBSELF55:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_N
LDY #>VAR_N
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
LDY #3
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
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_46R
LDY #>CONST_46R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_N
LDY #>VAR_N
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JMP LINE_450
;
LINE_SKIP106:
;
;
LINE_460:
;
LDA VAR_T
BEQ EQ_SKIP21
EQ_EQ21:
JMP LINE_SKIP107
EQ_SKIP21:
COMP_SKP21:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP107:
;
LDX #4
dcloop1397_1:
LDA VAR_N,X
STA VAR_D,X
DEX
BPL dcloop1397_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_570
;
LINE_SKIP107:
;
;
LINE_470:
;
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
LDA #<CONST_51
LDY #>CONST_51
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
JMP LINE_570
;
LINE_480:
;
;
LINE_490:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF56+1
STA MOVBSELF56+2
MOVBSELF56:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_V
LDY #>VAR_V
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop1397_2:
LDA VAR_V,X
STA VAR_D,X
DEX
BPL dcloop1397_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_500:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF57+1
STA MOVBSELF57+2
MOVBSELF57:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_52R
LDY #>CONST_52R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT22
LDA #0
JMP GT_SKIP22
GT_GT22:
LDA #$1
GT_SKIP22:
COMP_SKP22:
BEQ LINE_SKIP108
; Simplified conditional branch
;
LINE_NSKIP108:
;
JMP LINE_560
;
LINE_SKIP108:
;
;
LINE_510:
;
LDA #<CONST_32R
LDY #>CONST_32R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ23
ROL
BCC LT_LT23
LT_LT_EQ23:
LDA #0
JMP LT_SKIP23
LT_LT23:
LDA #$1
LT_SKIP23:
COMP_SKP23:
BEQ LINE_SKIP109
; Simplified conditional branch
;
LINE_NSKIP109:
;
JMP LINE_560
;
LINE_SKIP109:
;
;
LINE_520:
;
LDX #4
dceloop4982_6:
LDA CONST_53R,X
CMP VAR_T,X
BNE LINE_SKIP110
DEX
BPL dceloop4982_6
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP110:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_560
;
LINE_SKIP110:
;
;
LINE_530:
;
LDX #4
dceloop4982_7:
LDA CONST_54R,X
CMP VAR_T,X
BNE LINE_SKIP111
DEX
BPL dceloop4982_7
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP111:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_560
;
LINE_SKIP111:
;
;
LINE_540:
;
LDX #4
dceloop4982_8:
LDA CONST_55R,X
CMP VAR_T,X
BNE LINE_SKIP112
DEX
BPL dceloop4982_8
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP112:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_560
;
LINE_SKIP112:
;
;
LINE_550:
;
LDA #<CONST_34R
LDY #>CONST_34R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT27
LDA #0
JMP GT_SKIP27
GT_GT27:
LDA #$1
GT_SKIP27:
COMP_SKP27:
BEQ LINE_SKIP113
; Simplified conditional branch
;
LINE_NSKIP113:
;
JMP LINE_500
;
LINE_SKIP113:
;
;
LINE_560:
;
LDA #<CONST_43R
LDY #>CONST_43R
JSR REALFAC
LDA #<VAR_D
LDY #>VAR_D
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_D
LDY #>VAR_D
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #1
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_56R
LDY #>CONST_56R
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
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
;
LINE_570:
;
LDY #8
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_D
LDY #>VAR_D
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
STY VAR_H%
STA VAR_H%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_H
LDY #>VAR_H
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_H
LDY #>VAR_H
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #8
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_D
LDY #>VAR_D
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_L
LDY #>VAR_L
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_L
LDY #>VAR_L
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_57R
LDY #>CONST_57R
JSR MEMARG
JSR FASTAND
; Optimizer rule: Swap AND order/7
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_C
LDY #>VAR_C
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_580:
;
;
LINE_590:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A1$
LDY #>VAR_A1$
JSR COPYSTRING
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A2$
LDY #>VAR_A2$
JSR COPYSTRING
LDA #<CONST_58
LDY #>CONST_58
STA TMP_ZP
STY TMP_ZP+1
; Optimizer rule: MEM->REG, REG->TMP_ZP/4
JSR WRITETID
;
LINE_600:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_L1$
LDY #>VAR_L1$
JSR COPYSTRING
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_L2$
LDY #>VAR_L2$
JSR COPYSTRING
JSR COMPACTMAX
LDA VAR_Z$
LDY VAR_Z$+1
STA B_REG
STY B_REG+1
LDA VAR_L2$
LDY VAR_L2$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
LDY #>X_REG
LDA #<X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA VAR_Z$
LDY VAR_Z$+1
STA B_REG
STY B_REG+1
LDA VAR_L1$
LDY VAR_L1$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
LDA VAR_T
BEQ EQ_SKIP28
EQ_EQ28:
JMP LINE_SKIP114
EQ_SKIP28:
COMP_SKP28:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP114:
;
JMP LINE_1920
;
LINE_SKIP114:
;
;
LINE_610:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_S1$
LDY #>VAR_S1$
JSR COPYSTRING
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_S2$
LDY #>VAR_S2$
JSR COPYSTRING
JSR COMPACTMAX
LDA VAR_Z$
LDY VAR_Z$+1
STA B_REG
STY B_REG+1
LDA VAR_S2$
LDY VAR_S2$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASCNXREG
LDY #0
LDA TMP2_ZP
JSR INTFAC
JSR FACXREG
; Optimized ASC*256
;
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA VAR_Z$
LDY VAR_Z$+1
STA B_REG
STY B_REG+1
LDA VAR_S1$
LDY VAR_S1$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_620:
;
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_S[]
LDY #>VAR_S[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<VAR_M
LDY #>VAR_M
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A
LDY #>VAR_A
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L[]
LDY #>VAR_L[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_M
LDY #>VAR_M
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_M
LDY #>VAR_M
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
;
LINE_630:
;
LDA #<VAR_F
LDY #>VAR_F
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA Y_REG
COMP_SKP29:
BNE LINE_NSKIP115
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP115
;
LINE_NSKIP115:
;
LDA #<VAR_F
LDY #>VAR_F
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_F
LDY #>VAR_F
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF58+1
STA MOVBSELF58+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF58:
STY $FFFF
LDA #<CONST_38R
LDY #>CONST_38R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF59+1
STA MOVBSELF59+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF59:
STY $FFFF
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF60+1
STA MOVBSELF60+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF60:
STY $FFFF
LDA #0
STA VAR_F
STA VAR_F+1
STA VAR_F+2
STA VAR_F+3
STA VAR_F+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP115:
;
;
LINE_640:
;
LDX #4
dcloop1729_1:
LDA CONST_60R,X
STA VAR_J,X
DEX
BPL dcloop1729_1
; Optimizer rule: Direct copy of floats into mem/6
LDY 653
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP30:
BEQ LINE_SKIP116
; Simplified conditional branch
;
LINE_NSKIP116:
;
JMP LINE_640
;
LINE_SKIP116:
;
;
LINE_650:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR GETSTRCHANNEL
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_B$
LDY #>VAR_B$
JSR COPYSTRING
LDY STATUS
; Byte in Y to FAC
JSR BYTEFAC
LDX #<VAR_ST
LDY #>VAR_ST
JSR FACMEM
LDA VAR_ST
COMP_SKP31:
BEQ LINE_SKIP117
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP117:
;
JMP LINE_1920
;
LINE_SKIP117:
;
;
LINE_660:
;
JSR COMPACTMAX
LDA VAR_Z$
LDY VAR_Z$+1
STA B_REG
STY B_REG+1
LDA VAR_B$
LDY VAR_B$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
LDX #<VAR_B
LDY #>VAR_B
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
JSR FACXREG
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
LDX #<X_REG
; Optimizer rule: Move variable directly in XREG/9
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF62+1
STA MOVBSELF62+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF62:
STY $FFFF
LDA #<CONST_32R
LDY #>CONST_32R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ29
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP29
NEQ_NEQ29:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP29:
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_Q
LDY #>VAR_Q
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG | FAC
JSR FASTOR
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP32:
BEQ LINE_SKIP118
; Simplified conditional branch
;
LINE_NSKIP118:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_J
LDY #>VAR_J
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_J
LDY #>VAR_J
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP118:
;
;
LINE_670:
;
LDX #4
dceloop4982_9:
LDA CONST_33R,X
CMP VAR_B,X
BNE LINE_SKIP119
DEX
BPL dceloop4982_9
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP119:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = NOT(FAC)
JSR FACNOT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Q
LDY #>VAR_Q
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP119:
;
;
LINE_680:
;
LDA #<CONST_61R
LDY #>CONST_61R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ31
ROL
BCC LT_LT31
LT_LT_EQ31:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP31
LT_LT31:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP31:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR FASTOR
; Optimizer rule: Swap OR order/7
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP34:
BEQ LINE_SKIP120
; Simplified conditional branch
;
LINE_NSKIP120:
;
LDA VAR_B$
LDY VAR_B$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP120:
;
;
LINE_690:
;
LDA #<VAR_B
LDY #>VAR_B
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC to integer in Y/A
JSR FACWORD
STY 780
LDY #0
STY 15
; Optimizer rule: Simple POKE/2
;
LINE_700:
;
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ32
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP32
EQ_EQ32:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP32:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_62R
LDY #>CONST_62R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ33
ROL
BCC LT_LT33
LT_LT_EQ33:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP33
LT_LT33:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP33:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_63R
LDY #>CONST_63R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT34
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP34
GT_GT34:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP34:
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
COMP_SKP35:
BEQ LINE_SKIP121
; Simplified conditional branch
;
LINE_NSKIP121:
;
LDY #255
STY 782
; Optimizer rule: Simple POKE/2
LDY #185
STY 768
; Optimizer rule: Simple POKE/2
LDY #128
STY 783
; Optimizer rule: Simple POKE/2
LDA #<42775
STA TMP_ZP
LDA #>42775
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_SKIP121:
;
;
LINE_710:
;
LDY #139
STY 768
; Optimizer rule: Simple POKE/2
LDA VAR_Q
COMP_SKP36:
BEQ LINE_SKIP122
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP122:
;
JMP LINE_650
;
LINE_SKIP122:
;
;
LINE_720:
;
LDA #<CONST_32R
LDY #>CONST_32R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ35
ROL
BCC LT_LT35
LT_LT_EQ35:
LDA #0
JMP LT_SKIP35
LT_LT35:
LDA #$1
LT_SKIP35:
COMP_SKP37:
BEQ LINE_SKIP123
; Simplified conditional branch
;
LINE_NSKIP123:
;
JSR LINEBREAK
JSR GOSUB
JSR LINE_770
JMP LINE_600
;
LINE_SKIP123:
;
;
LINE_730:
;
LDX #4
dceloop4982_10:
LDA CONST_66R,X
CMP VAR_B,X
BNE LINE_SKIP124
DEX
BPL dceloop4982_10
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP124:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_770
JMP LINE_640
;
LINE_SKIP124:
;
;
LINE_740:
;
LDX #4
dceloop4982_11:
LDA CONST_49R,X
CMP VAR_B,X
BNE LINE_SKIP125
DEX
BPL dceloop4982_11
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP125:
; Optimizer rule: Simplified equal comparison/6
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
LDX #<VAR_J
LDY #>VAR_J
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_770
JMP LINE_640
;
LINE_SKIP125:
;
;
LINE_750:
;
JMP LINE_650
;
LINE_760:
;
;
LINE_770:
;
LDY 828
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop1895_1:
LDA CONST_67R,X
STA VAR_U,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF70+1
STA MOVBSELF70+2
LDA #$0
MOVBSELF70:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_J
LDY #>VAR_J
JSR INTADDPOKE
STY MOVBSELF71+1
STA MOVBSELF71+2
; Fast add for POKE(2)
;
;
;
;
LDA #$0
MOVBSELF71:
STA $FFFF
;
LINE_780:
;
LDX #4
dceloop4982_12:
LDA CONST_68R,X
CMP VAR_B,X
BNE LINE_SKIP126
DEX
BPL dceloop4982_12
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP126:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_940
;
LINE_SKIP126:
;
;
LINE_790:
;
LDA #<CONST_69R
LDY #>CONST_69R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
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
LDA #<CONST_70R
LDY #>CONST_70R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ40
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP40
EQ_EQ40:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP40:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_61R
LDY #>CONST_61R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ41
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP41
EQ_EQ41:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP41:
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP41:
BNE LINE_NSKIP127
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP127
;
LINE_NSKIP127:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF72+1
STA MOVBSELF72+2
LDA #$60
MOVBSELF72:
STA $FFFF
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
LINE_SKIP127:
;
;
LINE_800:
;
LDX #4
dceloop4982_13:
LDA CONST_72R,X
CMP VAR_B,X
BNE LINE_SKIP128
DEX
BPL dceloop4982_13
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP128:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1680
;
LINE_SKIP128:
;
;
LINE_810:
;
LDX #4
dceloop4982_14:
LDA CONST_65R,X
CMP VAR_B,X
BNE LINE_SKIP129
DEX
BPL dceloop4982_14
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP129:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1040
;
LINE_SKIP129:
;
;
LINE_820:
;
LDX #4
dceloop4982_15:
LDA CONST_73R,X
CMP VAR_B,X
BNE LINE_SKIP130
DEX
BPL dceloop4982_15
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP130:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1170
;
LINE_SKIP130:
;
;
LINE_830:
;
LDX #4
dceloop4982_16:
LDA CONST_74R,X
CMP VAR_B,X
BNE LINE_SKIP131
DEX
BPL dceloop4982_16
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP131:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1720
;
LINE_SKIP131:
;
;
LINE_840:
;
LDX #4
dceloop4982_17:
LDA CONST_75R,X
CMP VAR_B,X
BNE LINE_SKIP132
DEX
BPL dceloop4982_17
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP132:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1510
;
LINE_SKIP132:
;
;
LINE_850:
;
LDX #4
dceloop4982_18:
LDA CONST_76R,X
CMP VAR_B,X
BNE LINE_SKIP133
DEX
BPL dceloop4982_18
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP133:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1650
;
LINE_SKIP133:
;
;
LINE_860:
;
LDX #4
dceloop4982_19:
LDA CONST_77R,X
CMP VAR_B,X
BNE LINE_SKIP134
DEX
BPL dceloop4982_19
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP134:
; Optimizer rule: Simplified equal comparison/6
;
JMP RETURN
;
LINE_SKIP134:
;
;
LINE_870:
;
LDX #4
dceloop4982_20:
LDA CONST_78R,X
CMP VAR_B,X
BNE LINE_SKIP135
DEX
BPL dceloop4982_20
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP135:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2061_1:
LDA CONST_79R,X
STA VAR_O,X
DEX
BPL dcloop2061_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_1480
;
LINE_SKIP135:
;
;
LINE_880:
;
LDX #4
dceloop4982_21:
LDA CONST_80R,X
CMP VAR_B,X
BNE LINE_SKIP136
DEX
BPL dceloop4982_21
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP136:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop2061_2:
LDA CONST_32R,X
STA VAR_O,X
DEX
BPL dcloop2061_2
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_1480
;
LINE_SKIP136:
;
;
LINE_890:
;
LDA #<CONST_52R
LDY #>CONST_52R
JSR REALFAC
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
LDA #<CONST_46R
LDY #>CONST_46R
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
COMP_SKP51:
BEQ LINE_SKIP137
; Simplified conditional branch
;
LINE_NSKIP137:
;
JMP LINE_920
;
LINE_SKIP137:
;
;
LINE_900:
;
LDA #<CONST_81R
LDY #>CONST_81R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT53
LDA #0
JMP GT_SKIP53
GT_GT53:
LDA #$1
GT_SKIP53:
COMP_SKP52:
BEQ LINE_SKIP138
; Simplified conditional branch
;
LINE_NSKIP138:
;
JMP LINE_950
;
LINE_SKIP138:
;
;
LINE_910:
;
LDA #<CONST_49R
LDY #>CONST_49R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
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
COMP_SKP53:
BEQ LINE_SKIP139
; Simplified conditional branch
;
LINE_NSKIP139:
LDX #4
dcloop2227_1:
LDA CONST_60R,X
STA VAR_U,X
LDA CONST_79R,X
STA VAR_O,X
DEX
BPL dcloop2227_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_1480
;
LINE_SKIP139:
;
;
LINE_920:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_48R
LDY #>CONST_48R
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR REALOUT
JSR CRSRRIGHT
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF73+1
STA MOVBSELF73+2
MOVBSELF73:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_ER
LDY #>VAR_ER
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_930:
;
;
LINE_940:
;
LDX #4
dcloop2227_3:
LDA CONST_60R,X
STA VAR_I,X
DEX
BPL dcloop2227_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_83R
LDY #>CONST_83R
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
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_I
LDY #>VAR_I
JSR INTADDPOKE
STY MOVBSELF74+1
STA MOVBSELF74+2
; Fast add for POKE(2)
;
;
;
;
JSR POPREAL
JSR FACWORD
STY MOVBSELF75+1
STA MOVBSELF75+2
MOVBSELF74:
LDY $FFFF
MOVBSELF75:
STY $FFFF
; Optimizer rule: Fast byte copy/8
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
LINE_950:
;
LDX #4
dcloop2227_4:
LDA CONST_60R,X
STA VAR_U,X
DEX
BPL dcloop2227_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF76+1
STA MOVBSELF76+2
MOVBSELF76:
LDA $FFFF
CMP #65
BCC PEEKLT9
BEQ PEEKEQ9
LDA #$FF
JMP PEEKDONE9
PEEKLT9:
LDA #$01
JMP PEEKDONE9
PEEKEQ9:
LDA #0
PEEKDONE9:
; Optimized comparison for PEEK
;
;
BEQ LT_LT_EQ55
ROL
BCC LT_LT55
LT_LT_EQ55:
LDA #0
JMP LT_SKIP55
LT_LT55:
LDA #$1
LT_SKIP55:
COMP_SKP55:
BEQ LINE_SKIP140
; Simplified conditional branch
;
LINE_NSKIP140:
;
JMP LINE_920
;
LINE_SKIP140:
;
;
LINE_960:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF77+1
STA MOVBSELF77+2
MOVBSELF77:
LDA $FFFF
CMP #90
BCC PEEKLT10
BEQ PEEKEQ10
LDA #$FF
JMP PEEKDONE10
PEEKLT10:
LDA #$01
JMP PEEKDONE10
PEEKEQ10:
LDA #0
PEEKDONE10:
; Optimized comparison for PEEK
;
;
ROL
BCS GT_GT56
LDA #0
JMP GT_SKIP56
GT_GT56:
LDA #$1
GT_SKIP56:
COMP_SKP56:
BEQ LINE_SKIP141
; Simplified conditional branch
;
LINE_NSKIP141:
;
JMP LINE_920
;
LINE_SKIP141:
;
;
LINE_970:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF78+1
STA MOVBSELF78+2
MOVBSELF78:
LDA $FFFF
CMP #178
BCC PEEKLT11
BEQ PEEKEQ11
LDA #$FF
JMP PEEKDONE11
PEEKLT11:
LDA #$01
JMP PEEKDONE11
PEEKEQ11:
LDA #0
PEEKDONE11:
; Optimized comparison for PEEK
;
;
NEQ_NEQ57:
NEQ_SKIP57:
COMP_SKP57:
BEQ LINE_SKIP142
LINE_NSKIP142:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_920
;
LINE_SKIP142:
;
;
LINE_980:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_100
LDY 828
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
;
LINE_990:
;
JSR GOSUB
JSR LINE_560
;
LINE_1000:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF80+1
STA MOVBSELF80+2
LDA #$8D
MOVBSELF80:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF81+1
STA MOVBSELF81+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF81:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF82+1
STA MOVBSELF82+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF82:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_1010:
;
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF83+1
STA MOVBSELF83+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$8E
MOVBSELF83:
STA $FFFF
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF84+1
STA MOVBSELF84+2
; Fast add for POKE(1)
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
JSR FACWORD
MOVBSELF84:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$05
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF85+1
STA MOVBSELF85+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF85:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_1020:
;
LDA #<CONST_36R
LDY #>CONST_36R
JSR REALFAC
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
LINE_1030:
;
;
LINE_1040:
;
JSR GOSUB
JSR LINE_100
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF86+1
STA MOVBSELF86+2
MOVBSELF86:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_W
LDY #>VAR_W
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
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
COMP_SKP58:
BEQ LINE_SKIP143
; Simplified conditional branch
;
LINE_NSKIP143:
;
JMP LINE_920
;
LINE_SKIP143:
;
;
LINE_1050:
;
LDA #<CONST_85R
LDY #>CONST_85R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT59
LDA #0
JMP GT_SKIP59
GT_GT59:
LDA #$1
GT_SKIP59:
COMP_SKP59:
BEQ LINE_SKIP144
; Simplified conditional branch
;
LINE_NSKIP144:
;
JMP LINE_920
;
LINE_SKIP144:
;
;
LINE_1060:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF87+1
STA MOVBSELF87+2
LDA #$85
MOVBSELF87:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF88+1
STA MOVBSELF88+2
; Fast add for POKE(2)
;
;
;
;
LDA #$22
MOVBSELF88:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF89+1
STA MOVBSELF89+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$86
MOVBSELF89:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF90+1
STA MOVBSELF90+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$23
MOVBSELF90:
STA $FFFF
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
;
LINE_1070:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF91+1
STA MOVBSELF91+2
MOVBSELF91:
LDA $FFFF
CMP #177
BCC PEEKLT12
BEQ PEEKEQ12
LDA #$FF
JMP PEEKDONE12
PEEKLT12:
LDA #$01
JMP PEEKDONE12
PEEKEQ12:
LDA #0
PEEKDONE12:
; Optimized comparison for PEEK
;
;
BEQ EQ_EQ60
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP60
EQ_EQ60:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP60:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_85R
LDY #>CONST_85R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ61
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP61
EQ_EQ61:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP61:
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
COMP_SKP60:
BEQ LINE_SKIP145
; Simplified conditional branch
;
LINE_NSKIP145:
;
LDX #4
dcloop2559_1:
LDA CONST_86R,X
STA VAR_W,X
DEX
BPL dcloop2559_1
; Optimizer rule: Direct copy of floats into mem/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP145:
;
;
LINE_1080:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF92+1
STA MOVBSELF92+2
MOVBSELF92:
LDA $FFFF
CMP #179
BCC PEEKLT13
BEQ PEEKEQ13
LDA #$FF
JMP PEEKDONE13
PEEKLT13:
LDA #$01
JMP PEEKDONE13
PEEKEQ13:
LDA #0
PEEKDONE13:
; Optimized comparison for PEEK
;
;
BEQ EQ_EQ62
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP62
EQ_EQ62:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP62:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
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
COMP_SKP61:
BEQ LINE_SKIP146
; Simplified conditional branch
;
LINE_NSKIP146:
;
LDX #4
dcloop2559_2:
LDA CONST_86R,X
STA VAR_W,X
DEX
BPL dcloop2559_2
; Optimizer rule: Direct copy of floats into mem/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP146:
;
;
LINE_1090:
;
JSR GOSUB
JSR LINE_100
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF93+1
STA MOVBSELF93+2
LDA #$E4
MOVBSELF93:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF94+1
STA MOVBSELF94+2
; Fast add for POKE(2)
;
;
;
;
LDA #$23
MOVBSELF94:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF95+1
STA MOVBSELF95+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$F0
MOVBSELF95:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF96+1
STA MOVBSELF96+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$4
MOVBSELF96:
STA $FFFF
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
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
LDX #4
dcloop2559_3:
LDA VAR_A,X
STA VAR_F,X
DEX
BPL dcloop2559_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1100:
;
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF97+1
STA MOVBSELF97+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$6
MOVBSELF97:
STA $FFFF
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF98+1
STA MOVBSELF98+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$C5
MOVBSELF98:
STA $FFFF
LDY #$05
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF99+1
STA MOVBSELF99+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$22
MOVBSELF99:
STA $FFFF
;
LINE_1110:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF100+1
STA MOVBSELF100+2
LDA #$F0
MOVBSELF100:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF101+1
STA MOVBSELF101+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$D0
MOVBSELF101:
STA $FFFF
LDY #$08
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF102+1
STA MOVBSELF102+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$F0
MOVBSELF102:
STA $FFFF
;
LINE_1120:
;
LDA #<CONST_84R
LDY #>CONST_84R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ64
LDA #0
JMP EQ_SKIP64
EQ_EQ64:
LDA #$1
EQ_SKIP64:
COMP_SKP62:
BNE LINE_NSKIP147
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP147
;
LINE_NSKIP147:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF103+1
STA MOVBSELF103+2
LDA #$D0
MOVBSELF103:
STA $FFFF
LDY #$08
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF104+1
STA MOVBSELF104+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$D0
MOVBSELF104:
STA $FFFF
;
LINE_SKIP147:
;
;
LINE_1130:
;
LDA #<CONST_85R
LDY #>CONST_85R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ65
LDA #0
JMP EQ_SKIP65
EQ_EQ65:
LDA #$1
EQ_SKIP65:
COMP_SKP63:
BNE LINE_NSKIP148
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP148
;
LINE_NSKIP148:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF105+1
STA MOVBSELF105+2
LDA #$90
MOVBSELF105:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF106+1
STA MOVBSELF106+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$B0
MOVBSELF106:
STA $FFFF
;
LINE_SKIP148:
;
;
LINE_1140:
;
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ66
LDA #0
JMP EQ_SKIP66
EQ_EQ66:
LDA #$1
EQ_SKIP66:
COMP_SKP64:
BNE LINE_NSKIP149
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP149
;
LINE_NSKIP149:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF107+1
STA MOVBSELF107+2
LDA #$B0
MOVBSELF107:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF108+1
STA MOVBSELF108+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$90
MOVBSELF108:
STA $FFFF
;
LINE_SKIP149:
;
;
LINE_1150:
;
LDA #<CONST_36R
LDY #>CONST_36R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF109+1
STA MOVBSELF109+2
JSR POPREAL
JSR FACWORD
STY MOVBSELF110+1
STA MOVBSELF110+2
MOVBSELF109:
LDY $FFFF
MOVBSELF110:
STY $FFFF
; Optimizer rule: Fast byte copy/8
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
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
LINE_1160:
;
;
LINE_1170:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF111+1
STA MOVBSELF111+2
MOVBSELF111:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_W
LDY #>VAR_W
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_32R
LDY #>CONST_32R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ67
ROL
BCC LT_LT67
LT_LT_EQ67:
LDA #0
JMP LT_SKIP67
LT_LT67:
LDA #$1
LT_SKIP67:
COMP_SKP65:
BEQ LINE_SKIP150
; Simplified conditional branch
;
LINE_NSKIP150:
;
JMP LINE_1450
;
LINE_SKIP150:
;
;
LINE_1180:
;
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_U
LDY #>VAR_U
JSR INTADDPOKE
STY MOVBSELF112+1
STA MOVBSELF112+2
; Fast add for POKE(2)
;
;
;
;
MOVBSELF112:
LDA $FFFF
CMP #32
BCC PEEKLT14
BEQ PEEKEQ14
LDA #$FF
JMP PEEKDONE14
PEEKLT14:
LDA #$01
JMP PEEKDONE14
PEEKEQ14:
LDA #0
PEEKDONE14:
; Optimized comparison for PEEK
;
;
BEQ LT_LT_EQ68
ROL
BCC LT_LT68
LT_LT_EQ68:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP68
LT_LT68:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP68:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_53R
LDY #>CONST_53R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
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
COMP_SKP66:
BEQ LINE_SKIP151
; Simplified conditional branch
;
LINE_NSKIP151:
;
JMP RETURN
;
LINE_SKIP151:
;
;
LINE_1190:
;
LDX #4
dceloop4982_22:
LDA CONST_53R,X
CMP VAR_W,X
BNE LINE_SKIP152
DEX
BPL dceloop4982_22
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP152:
; Optimizer rule: Simplified equal comparison/6
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1170
;
LINE_SKIP152:
;
;
LINE_1200:
;
LDX #4
dceloop4982_23:
LDA CONST_91R,X
CMP VAR_W,X
BNE LINE_SKIP153
DEX
BPL dceloop4982_23
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP153:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1300
;
LINE_SKIP153:
;
;
LINE_1210:
;
LDX #4
dceloop4982_24:
LDA CONST_33R,X
CMP VAR_W,X
BNE LINE_SKIP154
DEX
BPL dceloop4982_24
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP154:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1340
;
LINE_SKIP154:
;
;
LINE_1220:
;
;
LINE_1230:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF113+1
STA MOVBSELF113+2
LDA #$A9
MOVBSELF113:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF114+1
STA MOVBSELF114+2
; Fast add for POKE(2)
;
;
;
;
LDA #$1D
MOVBSELF114:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF115+1
STA MOVBSELF115+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$20
MOVBSELF115:
STA $FFFF
;
LINE_1240:
;
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF116+1
STA MOVBSELF116+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$D2
MOVBSELF116:
STA $FFFF
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF117+1
STA MOVBSELF117+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$FF
MOVBSELF117:
STA $FFFF
LDA #<CONST_35R
LDY #>CONST_35R
JSR REALFAC
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
LINE_1250:
;
JSR GOSUB
JSR LINE_100
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF118+1
STA MOVBSELF118+2
LDA #$86
MOVBSELF118:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF119+1
STA MOVBSELF119+2
; Fast add for POKE(2)
;
;
;
;
LDA #$22
MOVBSELF119:
STA $FFFF
;
LINE_1260:
;
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF120+1
STA MOVBSELF120+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$AA
MOVBSELF120:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF121+1
STA MOVBSELF121+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$A5
MOVBSELF121:
STA $FFFF
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF122+1
STA MOVBSELF122+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$22
MOVBSELF122:
STA $FFFF
;
LINE_1270:
;
LDY #$05
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF123+1
STA MOVBSELF123+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$20
MOVBSELF123:
STA $FFFF
LDY #$06
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF124+1
STA MOVBSELF124+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$CD
MOVBSELF124:
STA $FFFF
LDY #$07
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF125+1
STA MOVBSELF125+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$BD
MOVBSELF125:
STA $FFFF
;
LINE_1280:
;
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFAC
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
JMP LINE_1170
;
LINE_1290:
;
;
LINE_1300:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF126+1
STA MOVBSELF126+2
MOVBSELF126:
LDA $FFFF
CMP #40
BCC PEEKLT15
BEQ PEEKEQ15
LDA #$FF
JMP PEEKDONE15
PEEKLT15:
LDA #$01
JMP PEEKDONE15
PEEKEQ15:
LDA #0
PEEKDONE15:
; Optimized comparison for PEEK
;
;
NEQ_NEQ73:
NEQ_SKIP73:
COMP_SKP70:
BEQ LINE_SKIP155
LINE_NSKIP155:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_920
;
LINE_SKIP155:
;
;
LINE_1310:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_100
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF127+1
STA MOVBSELF127+2
LDA #$20
MOVBSELF127:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF128+1
STA MOVBSELF128+2
; Fast add for POKE(2)
;
;
;
;
LDA #$D2
MOVBSELF128:
STA $FFFF
;
LINE_1320:
;
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF129+1
STA MOVBSELF129+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$FF
MOVBSELF129:
STA $FFFF
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1170
;
LINE_1330:
;
;
LINE_1340:
;
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_570
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF130+1
STA MOVBSELF130+2
LDA #$A9
MOVBSELF130:
STA $FFFF
;
LINE_1350:
;
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF131+1
STA MOVBSELF131+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF131:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF132+1
STA MOVBSELF132+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$A0
MOVBSELF132:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF133+1
STA MOVBSELF133+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF133:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_1360:
;
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF134+1
STA MOVBSELF134+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$20
MOVBSELF134:
STA $FFFF
LDY #$05
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF135+1
STA MOVBSELF135+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$1E
MOVBSELF135:
STA $FFFF
LDY #$06
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF136+1
STA MOVBSELF136+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$AB
MOVBSELF136:
STA $FFFF
;
LINE_1370:
;
LDY #$07
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF137+1
STA MOVBSELF137+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$18
MOVBSELF137:
STA $FFFF
LDY #$08
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF138+1
STA MOVBSELF138+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$90
MOVBSELF138:
STA $FFFF
LDY #$09
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF139+1
STA MOVBSELF139+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$0
MOVBSELF139:
STA $FFFF
;
LINE_1380:
;
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_W
LDY #>VAR_W
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
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
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1390:
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT74
LDA #0
JMP GT_SKIP74
GT_GT74:
LDA #$1
GT_SKIP74:
COMP_SKP71:
BEQ LINE_SKIP156
; Simplified conditional branch
;
LINE_NSKIP156:
;
JMP LINE_1430
;
LINE_SKIP156:
;
;
LINE_1400:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF140+1
STA MOVBSELF140+2
MOVBSELF140:
LDA $FFFF
CMP #34
BCC PEEKLT16
BEQ PEEKEQ16
LDA #$FF
JMP PEEKDONE16
PEEKLT16:
LDA #$01
JMP PEEKDONE16
PEEKEQ16:
LDA #0
PEEKDONE16:
; Optimized comparison for PEEK
;
;
EQ_EQ75:
EQ_SKIP75:
COMP_SKP72:
BNE LINE_SKIP157
LINE_NSKIP157:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_1430
;
LINE_SKIP157:
;
;
LINE_1410:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF141+1
STA MOVBSELF141+2
MOVBSELF141:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BEQ EQ_EQ76
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP76
EQ_EQ76:
LDA #$1
EQ_SKIP76:
COMP_SKP73:
BEQ LINE_SKIP158
; Simplified conditional branch
;
LINE_NSKIP158:
;
JMP LINE_1430
;
LINE_SKIP158:
;
;
LINE_1420:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF142+1
STA MOVBSELF142+2
JSR POPREAL
JSR FACWORD
STY MOVBSELF143+1
STA MOVBSELF143+2
MOVBSELF142:
LDY $FFFF
MOVBSELF143:
STY $FFFF
; Optimizer rule: Fast byte copy/8
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
JMP LINE_1390
;
LINE_1430:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
LDA #<VAR_W
LDY #>VAR_W
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF144+1
STA MOVBSELF144+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF144:
STY $FFFF
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF145+1
STA MOVBSELF145+2
LDA #$0
MOVBSELF145:
STA $FFFF
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
LINE_1440:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JMP LINE_1170
;
LINE_1450:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF146+1
STA MOVBSELF146+2
LDA #$A9
MOVBSELF146:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF147+1
STA MOVBSELF147+2
; Fast add for POKE(2)
;
;
;
;
LDA #$D
MOVBSELF147:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF148+1
STA MOVBSELF148+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$20
MOVBSELF148:
STA $FFFF
;
LINE_1460:
;
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF149+1
STA MOVBSELF149+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$D2
MOVBSELF149:
STA $FFFF
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF150+1
STA MOVBSELF150+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$FF
MOVBSELF150:
STA $FFFF
LDA #<CONST_35R
LDY #>CONST_35R
JSR REALFAC
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
LINE_1470:
;
;
LINE_1480:
;
LDA #<VAR_O
LDY #>VAR_O
JSR COPY2_XYA_XREG
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF151+1
STA MOVBSELF151+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF151:
STY $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF152+1
STA MOVBSELF152+2
; Fast add for POKE(2)
;
;
;
;
LDA #$0
MOVBSELF152:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF153+1
STA MOVBSELF153+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$0
MOVBSELF153:
STA $FFFF
JSR GOSUB
JSR LINE_400
;
LINE_1490:
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
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_N
LDY #>VAR_N
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_N[]
LDY #>VAR_N[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A
LDY #>VAR_A
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A[]
LDY #>VAR_A[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
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
LINE_1500:
;
;
LINE_1510:
;
LDX #4
dcloop3555_1:
LDA CONST_99R,X
STA VAR_U,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_100
;
LINE_1520:
;
LDX #4
dcloop3555_2:
LDA VAR_A,X
STA VAR_LP,X
DEX
BPL dcloop3555_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF154+1
STA MOVBSELF154+2
LDA #$4C
MOVBSELF154:
STA $FFFF
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
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
LINE_1530:
LDX #4
dcloop3555_3:
LDA VAR_U,X
STA VAR_HU,X
LDA CONST_67R,X
STA VAR_U,X
DEX
BPL dcloop3555_3
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_40
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_HU
LDY #>VAR_HU
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
;
LINE_1540:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF155+1
STA MOVBSELF155+2
LDA #$85
MOVBSELF155:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF156+1
STA MOVBSELF156+2
; Fast add for POKE(2)
;
;
;
;
LDA #$22
MOVBSELF156:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF157+1
STA MOVBSELF157+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$86
MOVBSELF157:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF158+1
STA MOVBSELF158+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$23
MOVBSELF158:
STA $FFFF
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
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
LINE_1550:
LDX #4
dcloop3721_1:
LDA VAR_F,X
STA VAR_HF,X
LDA CONST_40R,X
STA VAR_W,X
DEX
BPL dcloop3721_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_1090
LDX #4
dcloop3721_3:
LDA VAR_HF,X
STA VAR_F,X
DEX
BPL dcloop3721_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_1560:
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF159+1
STA MOVBSELF159+2
LDA #$3
MOVBSELF159:
STA $FFFF
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF160+1
STA MOVBSELF160+2
LDA #$2
MOVBSELF160:
STA $FFFF
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF161+1
STA MOVBSELF161+2
LDA #$B
MOVBSELF161:
STA $FFFF
;
LINE_1570:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF162+1
STA MOVBSELF162+2
LDA #$B0
MOVBSELF162:
STA $FFFF
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF163+1
STA MOVBSELF163+2
LDA #$F0
MOVBSELF163:
STA $FFFF
;
LINE_1580:
;
LDX #4
dcloop3721_4:
LDA VAR_A,X
STA VAR_XA,X
DEX
BPL dcloop3721_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF164+1
STA MOVBSELF164+2
LDA #$4C
MOVBSELF164:
STA $FFFF
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
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
LINE_1590:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF165+1
STA MOVBSELF165+2
MOVBSELF165:
LDA $FFFF
CMP #169
BCC PEEKLT17
BEQ PEEKEQ17
LDA #$FF
JMP PEEKDONE17
PEEKLT17:
LDA #$01
JMP PEEKDONE17
PEEKEQ17:
LDA #0
PEEKDONE17:
; Optimized comparison for PEEK
;
;
BNE NEQ_NEQ77
LDA #0
JMP NEQ_SKIP77
NEQ_NEQ77:
LDA #$1
NEQ_SKIP77:
COMP_SKP74:
BNE LINE_NSKIP159
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP159
;
LINE_NSKIP159:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF166+1
STA MOVBSELF166+2
LDA #$A9
MOVBSELF166:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF167+1
STA MOVBSELF167+2
; Fast add for POKE(2)
;
;
;
;
LDA #$1
MOVBSELF167:
STA $FFFF
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF168+1
STA MOVBSELF168+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$A2
MOVBSELF168:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF169+1
STA MOVBSELF169+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$0
MOVBSELF169:
STA $FFFF
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
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
JMP LINE_1610
;
LINE_SKIP159:
;
;
LINE_1600:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_100
;
LINE_1610:
LDX #4
dcloop3887_1:
LDA CONST_60R,X
STA VAR_U,X
LDA CONST_14R,X
STA VAR_B,X
DEX
BPL dcloop3887_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_150
;
LINE_1620:
;
LDX #4
dcloop3887_3:
LDA VAR_A,X
STA VAR_D,X
DEX
BPL dcloop3887_3
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_570
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_LP
LDY #>VAR_LP
JSR INTADDPOKE
STY MOVBSELF170+1
STA MOVBSELF170+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF170:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_LP
LDY #>VAR_LP
JSR INTADDPOKE
STY MOVBSELF171+1
STA MOVBSELF171+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF171:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_1630:
;
LDY 829
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_990
JMP RETURN
;
LINE_1640:
;
;
LINE_1650:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
LDA #<VAR_LP
LDY #>VAR_LP
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_570
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF173+1
STA MOVBSELF173+2
LDA #$4C
MOVBSELF173:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF174+1
STA MOVBSELF174+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF174:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF175+1
STA MOVBSELF175+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF175:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDA #<CONST_7R
LDY #>CONST_7R
JSR REALFAC
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
LDX #4
dcloop3887_4:
LDA VAR_A,X
STA VAR_D,X
DEX
BPL dcloop3887_4
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_570
;
LINE_1660:
;
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_XA
LDY #>VAR_XA
JSR INTADDPOKE
STY MOVBSELF176+1
STA MOVBSELF176+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF176:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_XA
LDY #>VAR_XA
JSR INTADDPOKE
STY MOVBSELF177+1
STA MOVBSELF177+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF177:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
JMP RETURN
;
LINE_1670:
;
;
LINE_1680:
;
JSR GOSUB
JSR LINE_100
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF178+1
STA MOVBSELF178+2
LDA #$85
MOVBSELF178:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF179+1
STA MOVBSELF179+2
; Fast add for POKE(2)
;
;
;
;
LDA #$14
MOVBSELF179:
STA $FFFF
;
LINE_1690:
;
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF180+1
STA MOVBSELF180+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$86
MOVBSELF180:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF181+1
STA MOVBSELF181+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$15
MOVBSELF181:
STA $FFFF
;
LINE_1700:
;
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF182+1
STA MOVBSELF182+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$20
MOVBSELF182:
STA $FFFF
LDY #$05
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF183+1
STA MOVBSELF183+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$36
MOVBSELF183:
STA $FFFF
LDY #$06
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF184+1
STA MOVBSELF184+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$E1
MOVBSELF184:
STA $FFFF
LDA #<CONST_38R
LDY #>CONST_38R
JSR REALFAC
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
LINE_1710:
;
;
LINE_1720:
;
JSR GOSUB
JSR LINE_100
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF185+1
STA MOVBSELF185+2
LDA #$85
MOVBSELF185:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF186+1
STA MOVBSELF186+2
; Fast add for POKE(2)
;
;
;
;
LDA #$22
MOVBSELF186:
STA $FFFF
;
LINE_1730:
;
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF187+1
STA MOVBSELF187+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$86
MOVBSELF187:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF188+1
STA MOVBSELF188+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$23
MOVBSELF188:
STA $FFFF
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
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
LINE_1740:
;
LDA #<VAR_U
LDY #>VAR_U
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF189+1
STA MOVBSELF189+2
MOVBSELF189:
LDA $FFFF
CMP #44
BCC PEEKLT18
BEQ PEEKEQ18
LDA #$FF
JMP PEEKDONE18
PEEKLT18:
LDA #$01
JMP PEEKDONE18
PEEKEQ18:
LDA #0
PEEKDONE18:
; Optimized comparison for PEEK
;
;
NEQ_NEQ78:
NEQ_SKIP78:
COMP_SKP75:
BEQ LINE_SKIP160
LINE_NSKIP160:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_920
;
LINE_SKIP160:
;
;
LINE_1750:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_U
LDY #>VAR_U
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_100
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF190+1
STA MOVBSELF190+2
LDA #$A0
MOVBSELF190:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF191+1
STA MOVBSELF191+2
; Fast add for POKE(2)
;
;
;
;
LDA #$0
MOVBSELF191:
STA $FFFF
;
LINE_1760:
;
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF192+1
STA MOVBSELF192+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$91
MOVBSELF192:
STA $FFFF
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_A
LDY #>VAR_A
JSR INTADDPOKE
STY MOVBSELF193+1
STA MOVBSELF193+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$22
MOVBSELF193:
STA $FFFF
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
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
LINE_1770:
;
;
LINE_1780:
;
;
LINE_1790:
;
LDA #0
STA VAR_A
STA VAR_A+1
STA VAR_A+2
STA VAR_A+3
STA VAR_A+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_B
STA VAR_B+1
STA VAR_B+2
STA VAR_B+3
STA VAR_B+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_U
STA VAR_U+1
STA VAR_U+2
STA VAR_U+3
STA VAR_U+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_J
STA VAR_J+1
STA VAR_J+2
STA VAR_J+3
STA VAR_J+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_K
STA VAR_K+1
STA VAR_K+2
STA VAR_K+3
STA VAR_K+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V
STA VAR_V+1
STA VAR_V+2
STA VAR_V+3
STA VAR_V+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_D
STA VAR_D+1
STA VAR_D+2
STA VAR_D+3
STA VAR_D+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1800:
;
LDA #0
STA VAR_C
STA VAR_C+1
STA VAR_C+2
STA VAR_C+3
STA VAR_C+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_H
STA VAR_H+1
STA VAR_H+2
STA VAR_H+3
STA VAR_H+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_L
STA VAR_L+1
STA VAR_L+2
STA VAR_L+3
STA VAR_L+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_W
STA VAR_W+1
STA VAR_W+2
STA VAR_W+3
STA VAR_W+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1810:
;
LDY #0
STY 53281
; Optimizer rule: Simple POKE/2
STY 53280
; Optimizer rule: Simple POKE/2
LDY #15
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_1820:
;
LDA #<CONST_107
LDY #>CONST_107
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_S$
LDY #>VAR_S$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDX #4
dcloop4219_1:
LDA CONST_108,X
STA VAR_S,X
DEX
BPL dcloop4219_1
; Optimizer rule: Direct copy of floats into mem/6
JSR COMPACTMAX
LDA #0
JSR CHRINT
; Optimizer rule: CHR with integer constant/2
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
;
LINE_1830:
;
INPUT3:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_109
LDY #>CONST_109
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP8
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_S$
LDY #>VAR_S$
JSR COPYSTRING
EMPTYINPUTSKIP8:
JSR QUEUESIZE
LDA X_REG
COMP_SKP76:
BEQ INPUTCHECK3
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK3:
;
LINE_1840:
;
JSR RESTORE
LDA #<CONST_110
LDY #>CONST_110
STA B_REG
STY B_REG+1
LDA VAR_S$
LDY VAR_S$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP77:
BEQ LINE_SKIP161
; Simplified conditional branch
;
LINE_NSKIP161:
;
JSR END
RTS
;
LINE_SKIP161:
;
;
LINE_1850:
;
INPUT4:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_111
LDY #>CONST_111
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTNUMBER
LDA X_REG
COMP_SKP78:
BEQ INPUT4_0
; Optimizer rule: CMP (REG) = 0(2)/3
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP INPUT4
INPUT4_0:
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP9
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_S
LDY #>VAR_S
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP9:
JSR QUEUESIZE
LDA X_REG
COMP_SKP79:
BEQ INPUTCHECK4
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK4:
JSR LINEBREAK
LDA #<CONST_36R
LDY #>CONST_36R
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
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
LINE_1860:
;
LDX #4
dcloop4385_1:
LDA VAR_A,X
STA VAR_D,X
DEX
BPL dcloop4385_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_570
LDA #<VAR_S
LDY #>VAR_S
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF197+1
STA MOVBSELF197+2
LDA #$4C
MOVBSELF197:
STA $FFFF
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_S
LDY #>VAR_S
JSR INTADDPOKE
STY MOVBSELF198+1
STA MOVBSELF198+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF198:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_S
LDY #>VAR_S
JSR INTADDPOKE
STY MOVBSELF199+1
STA MOVBSELF199+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF199:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_1870:
;
LDY #$03
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_S
LDY #>VAR_S
JSR INTADDPOKE
STY MOVBSELF200+1
STA MOVBSELF200+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$4C
MOVBSELF200:
STA $FFFF
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_S
LDY #>VAR_S
JSR INTADDPOKE
STY MOVBSELF201+1
STA MOVBSELF201+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$74
MOVBSELF201:
STA $FFFF
LDY #$05
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_S
LDY #>VAR_S
JSR INTADDPOKE
STY MOVBSELF202+1
STA MOVBSELF202+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$A4
MOVBSELF202:
STA $FFFF
;
LINE_1880:
;
LDA #<CONST_106R
LDY #>CONST_106R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_106R
LDY #>CONST_106R
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
LDA #<CONST_7R
LDY #>CONST_7R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA VAR_S$
LDY VAR_S$+1
STA B_REG
STY B_REG+1
LDA #<CONST_115
LDY #>CONST_115
STA A_REG
STY A_REG+1
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
LDA #<CONST_24R
LDY #>CONST_24R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
;
LINE_1890:
;
LDA #<CONST_106R
LDY #>CONST_106R
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
LDA #<C_REG
LDY #>C_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP10
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_E1
LDY #>VAR_E1
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP10:
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
BEQ EMPTYINPUTSKIP11
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_E2$
LDY #>VAR_E2$
JSR COPYSTRING
EMPTYINPUTSKIP11:
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
BEQ EMPTYINPUTSKIP12
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_E3
LDY #>VAR_E3
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP12:
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR INPUTNUMBERCHANNEL
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP13
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_E4
LDY #>VAR_E4
; FAC to (X/Y)
JSR FACMEM
EMPTYINPUTSKIP13:
LDA VAR_E1
BEQ EQ_SKIP79
EQ_EQ79:
JMP LINE_SKIP162
EQ_SKIP79:
COMP_SKP80:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP162:
;
JMP RETURN
;
LINE_SKIP162:
;
;
LINE_1900:
;
LDA #<VAR_E1
LDY #>VAR_E1
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA VAR_E2$
LDY VAR_E2$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_E3
LDY #>VAR_E3
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<VAR_E4
LDY #>VAR_E4
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_1910:
;
;
LINE_1920:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
LDA #<CONST_106R
LDY #>CONST_106R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
;
LINE_1930:
;
LDA VAR_R
BEQ EQ_SKIP80
EQ_EQ80:
JMP LINE_SKIP163
EQ_SKIP80:
COMP_SKP81:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP163:
;
JMP LINE_1980
;
LINE_SKIP163:
;
;
LINE_1940:
;
LDX #4
dcloop4551_1:
LDA CONST_4R,X
STA VAR_I,X
DEX
BPL dcloop4551_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_R
LDY #>VAR_R
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
LDA #<VAR_N[]
LDY #>VAR_N[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_N
LDY #>VAR_N
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_W
LDY #>VAR_W
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #0
STA VAR_D
STA VAR_D+1
STA VAR_D+2
STA VAR_D+3
STA VAR_D+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_1950:
;
LDA #0
STA VAR_T
STA VAR_T+1
STA VAR_T+2
STA VAR_T+3
STA VAR_T+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_M
LDY #>VAR_M
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_T
LDY #>VAR_T
STA A_REG
STY A_REG+1
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<VAR_N
LDY #>VAR_N
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ81
LDA #0
JMP EQ_SKIP81
EQ_EQ81:
LDA #$1
EQ_SKIP81:
COMP_SKP82:
BNE LINE_NSKIP164
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP164
;
LINE_NSKIP164:
;
LDA #<VAR_T
LDY #>VAR_T
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_L[]
LDY #>VAR_L[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDX #<VAR_D
LDY #>VAR_D
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDX #4
dcloop4551_2:
LDA VAR_M,X
STA VAR_T,X
DEX
BPL dcloop4551_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP164:
;
;
LINE_1960:
;
LDA #<VAR_T
LDY #>VAR_T
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
JSR GOSUB
JSR LINE_570
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_W
LDY #>VAR_W
JSR INTADDPOKE
STY MOVBSELF203+1
STA MOVBSELF203+2
; Fast add for POKE(2)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF203:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
;
LINE_1970:
;
LDY #$02
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_W
LDY #>VAR_W
JSR INTADDPOKE
STY MOVBSELF204+1
STA MOVBSELF204+2
; Fast add for POKE(1)
LDA #<VAR_H
LDY #>VAR_H
JSR REALFAC
JSR FACWORD
MOVBSELF204:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
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
LINE_1980:
;
LDA VAR_G
BEQ EQ_SKIP82
EQ_EQ82:
JMP LINE_SKIP165
EQ_SKIP82:
COMP_SKP85:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP165:
;
JMP LINE_2030
;
LINE_SKIP165:
;
;
LINE_1990:
;
LDX #4
dcloop4551_3:
LDA VAR_A,X
STA VAR_D,X
DEX
BPL dcloop4551_3
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_570
LDY #$04
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_S
LDY #>VAR_S
JSR INTADDPOKE
STY MOVBSELF205+1
STA MOVBSELF205+2
; Fast add for POKE(1)
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
JSR FACWORD
MOVBSELF205:
STY $FFFF
; Optimizer rule: Switch order of calculations for POKE/15
LDA #<CONST_35R
LDY #>CONST_35R
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_H
LDY #>VAR_H
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF206+1
STA MOVBSELF206+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF206:
STY $FFFF
;
LINE_2000:
;
JSR READNUMBER
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFAC
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ83
ROL
BCC LT_LT83
LT_LT_EQ83:
LDA #0
JMP LT_SKIP83
LT_LT83:
LDA #$1
LT_SKIP83:
COMP_SKP86:
BEQ LINE_SKIP166
; Simplified conditional branch
;
LINE_NSKIP166:
;
JMP LINE_2030
;
LINE_SKIP166:
;
;
LINE_2010:
;
LDA #<VAR_D
LDY #>VAR_D
JSR COPY2_XYA_XREG
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
JSR FACWORD
; Optimizer rule: No push, direct to FAC/7
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF207+1
STA MOVBSELF207+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF207:
STY $FFFF
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
LINE_2020:
;
JMP LINE_2000
;
LINE_2030:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF208+1
STA MOVBSELF208+2
LDA #$0
MOVBSELF208:
STA $FFFF
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
;
LINE_2040:
;
LDA #<CONST_116
LDY #>CONST_116
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_ER
LDY #>VAR_ER
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_2050:
;
LDA #<CONST_117
LDY #>CONST_117
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_S
LDY #>VAR_S
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUT
JSR CRSRRIGHT
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_E
LDY #>VAR_E
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
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
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_2060:
;
LDA VAR_S$
LDY VAR_S$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_119
LDY #>CONST_119
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR READTID
LDA VAR_TI$
LDY VAR_TI$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2070:
;
LDA #<CONST_120
LDY #>CONST_120
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDY #0
STY 198
; Optimizer rule: Simple POKE/2
;
LINE_2080:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
LDA #<CONST_121
LDY #>CONST_121
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP87:
BEQ LINE_SKIP167
; Simplified conditional branch
;
LINE_NSKIP167:
;
JMP LINE_2170
;
LINE_SKIP167:
;
;
LINE_2090:
;
LDA #<CONST_122
LDY #>CONST_122
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP88:
BEQ LINE_SKIP168
; Simplified conditional branch
;
LINE_NSKIP168:
;
JMP LINE_2140
;
LINE_SKIP168:
;
;
LINE_2100:
;
LDA #<CONST_123
LDY #>CONST_123
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP89:
BEQ LINE_SKIP169
; Simplified conditional branch
;
LINE_NSKIP169:
;
JSR GOSUB
JSR LINE_1820
JMP LINE_590
;
LINE_SKIP169:
;
;
LINE_2110:
;
LDA #<CONST_124
LDY #>CONST_124
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP90:
BEQ LINE_SKIP170
; Simplified conditional branch
;
LINE_NSKIP170:
;
JSR END
RTS
;
LINE_SKIP170:
;
;
LINE_2130:
;
JMP LINE_2080
;
LINE_2140:
;
LDX #4
dcloop4717_1:
LDA CONST_56R,X
STA VAR_I,X
DEX
BPL dcloop4717_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_125R
LDY #>CONST_125R
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
LDA #<CONST_2R
LDY #>CONST_2R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR FASTFOR
LDY #0
TYA
CPY A_REG
BNE COMP_SKP91
CMP A_REG+1
BNE COMP_SKP91
COMP_SKP91:
BNE RBEQ_3
JMP (JUMP_TARGET)
RBEQ_3:
;
LINE_2150:
;
LDA #<VAR_S
LDY #>VAR_S
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR SYSTEMCALLDYN
JMP LINE_2070
;
LINE_2160:
;
;
LINE_2170:
;
JSR COMPACTMAX
LDA #<CONST_126
LDY #>CONST_126
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA VAR_S$
LDY VAR_S$+1
STA B_REG
STY B_REG+1
LDY #13
JSR LEFTCONST
; Optimized code for LEFT/RIGHT
;
;
;
;
;
JSR POPINT2B
; Optimizer rule: Simplified POPINT/1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_N$
LDY #>VAR_N$
JSR COPYSTRING
INPUT5:
JSR CLEARQUEUE
JSR COMPACTMAX
LDA #<CONST_127
LDY #>CONST_127
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR QMARKOUT1
JSR INPUTSTR
JSR INPUTLENGTHCHECK
BEQ EMPTYINPUTSKIP14
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_N$
LDY #>VAR_N$
JSR COPYSTRING
EMPTYINPUTSKIP14:
JSR QUEUESIZE
LDA X_REG
COMP_SKP92:
BEQ INPUTCHECK5
; Optimizer rule: CMP (REG) = 0(2)/3
JSR EXTRAIGNORED
INPUTCHECK5:
;
LINE_2180:
;
LDA #<CONST_106R
LDY #>CONST_106R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_39R
LDY #>CONST_39R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_106R
LDY #>CONST_106R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA VAR_N$
LDY VAR_N$+1
STA B_REG
STY B_REG+1
LDA #<CONST_128
LDY #>CONST_128
STA A_REG
STY A_REG+1
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
LDA #<CONST_24R
LDY #>CONST_24R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR OPEN
LDA #<CONST_106R
LDY #>CONST_106R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR CLOSE
LDA VAR_N$
LDY VAR_N$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_T$
LDY #>VAR_T$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_2190:
;
LDX #4
dcloop4883_1:
LDA CONST_4R,X
STA VAR_I,X
DEX
BPL dcloop4883_1
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_T$
LDY VAR_T$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_4R
LDY #>CONST_4R
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
JSR REALFAC
LDA #<CONST_99R
LDY #>CONST_99R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
JSR COMPACTMAX
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_CREG
; Optimizer rule: Direct copy from MEM to C/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA VAR_T$
LDY VAR_T$+1
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
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF210+1
STA MOVBSELF210+2
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF210:
STY $FFFF
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
LINE_2200:
;
LDY #3
STY 782
; Optimizer rule: Simple POKE/2
LDY #64
STY 781
; Optimizer rule: Simple POKE/2
LDA VAR_T$
LDY VAR_T$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACWORD
STY 780
LDA #<65469
STA TMP_ZP
LDA #>65469
STA TMP_ZP+1
JSR SYSTEMCALL
LDY #1
STY 780
; Optimizer rule: Simple POKE/2
;
LINE_2210:
;
LDY #8
STY 781
; Optimizer rule: Simple POKE/2
LDY #1
STY 782
; Optimizer rule: Simple POKE/2
LDA #<65466
STA TMP_ZP
LDA #>65466
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_2220:
;
LDY #8
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_S
LDY #>VAR_S
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 254
LDY 254
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
LDY #8
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_S
LDY #>VAR_S
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 253
LDY #253
STY 780
; Optimizer rule: Simple POKE/2
LDY #8
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_E
LDY #>VAR_E
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 782
;
LINE_2230:
;
LDY 782
LDA #0
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
LDY #8
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_E
LDY #>VAR_E
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 781
LDA #<65496
STA TMP_ZP
LDA #>65496
STA TMP_ZP+1
JSR SYSTEMCALL
;
LINE_2240:
;
LDA #<CONST_130R
LDY #>CONST_130R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY STATUS
; Byte in Y to FAC
JSR BYTEFAC
LDX #<VAR_ST
LDY #>VAR_ST
JSR FACMEM
LDA #<VAR_ST
LDY #>VAR_ST
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_131R
LDY #>CONST_131R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #1
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP94:
BEQ LINE_SKIP171
; Simplified conditional branch
;
LINE_NSKIP171:
;
LDA #<CONST_132
LDY #>CONST_132
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_SKIP171:
;
;
LINE_2250:
;
JMP LINE_2070
;
LINE_2260:
;
;
LINE_2270:
;
;
LINE_2280:
;
;
LINE_2290:
;
;
LINE_2300:
;
;
LINE_2310:
;
;
LINE_2320:
;
;
LINE_2330:
;
;
LINE_2340:
;
;
LINE_2350:
;
;
LINE_2360:
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
SYSTEMCALLDYN
JSR XREGFAC
JSR FACWORD
STY TMP_ZP
STA TMP_ZP+1
JMP SYSTEMCALL
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
ASCNXREG	LDA B_REG
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y
BNE DOASCNXREG
JMP ILLEGALQUANTITY
DOASCNXREG	INY
LDA (TMP_ZP),Y
STA TMP2_ZP
RTS
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
GETSTRCHANNEL
JSR INITINCHANNEL
JSR GETSTR
JMP CLRINCH
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
STA VAR_G,Y
STA VAR_A,Y
STA VAR_L,Y
STA VAR_K,Y
STA VAR_V,Y
STA VAR_H,Y
STA VAR_C,Y
STA VAR_P,Y
STA VAR_U,Y
STA VAR_ER,Y
STA VAR_O,Y
STA VAR_B,Y
STA VAR_S,Y
STA VAR_D,Y
STA VAR_N,Y
STA VAR_T,Y
STA VAR_M,Y
STA VAR_F,Y
STA VAR_J,Y
STA VAR_ST,Y
STA VAR_Q,Y
STA VAR_I,Y
STA VAR_W,Y
STA VAR_R,Y
STA VAR_LP,Y
STA VAR_HU,Y
STA VAR_HF,Y
STA VAR_XA,Y
STA VAR_E1,Y
STA VAR_E3,Y
STA VAR_E4,Y
STA VAR_E,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
STA VAR_H%
STA VAR_H%+1
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_L[]
LDY #>VAR_L[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_N[]
LDY #>VAR_N[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_A[]
LDY #>VAR_A[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #147


; CONST: ${control-q}{lgrn}micro compiler
CONST_1	.BYTE 31
.STRG "{control-q}{lgrn}micro compiler"
; CONST: #0

CONST_2R	.REAL 0.0
; CONST: #169


; CONST: #1

CONST_4R	.REAL 1.0
; CONST: #2

CONST_5R	.REAL 2.0
; CONST: #173

CONST_6R	.REAL 173.0
; CONST: #3

CONST_7R	.REAL 3.0
; CONST: #174


; CONST: #162


; CONST: #194


; CONST: #912

CONST_11R	.REAL 912.0
; CONST: ${ctrl 9}overflow
CONST_12	.BYTE 16
.STRG "{ctrl 9}overflow"
; CONST: #172

CONST_13R	.REAL 172.0
; CONST: #170

CONST_14R	.REAL 170.0
; CONST: #109

CONST_15R	.REAL 109.0
; CONST: #24


; CONST: #171

CONST_17R	.REAL 171.0
; CONST: #237

CONST_18R	.REAL 237.0
; CONST: #56


; CONST: #175

CONST_20R	.REAL 175.0
; CONST: #45

CONST_21R	.REAL 45.0
; CONST: #176

CONST_22R	.REAL 176.0
; CONST: #13

CONST_23R	.REAL 13.0
; CONST: #4

CONST_24R	.REAL 4.0
; CONST: #168


; CONST: #138


; CONST: #152


; CONST: #133


; CONST: #97


; CONST: #134


; CONST: #98


; CONST: #32

CONST_32R	.REAL 32.0
; CONST: #34

CONST_33R	.REAL 34.0
; CONST: #35

CONST_34R	.REAL 35.0
; CONST: #5

CONST_35R	.REAL 5.0
; CONST: #6

CONST_36R	.REAL 6.0
; CONST: #160


; CONST: #7

CONST_38R	.REAL 7.0
; CONST: #8

CONST_39R	.REAL 8.0
; CONST: #177

CONST_40R	.REAL 177.0
; CONST: #9

CONST_41R	.REAL 9.0
; CONST: #10

CONST_42R	.REAL 10.0
; CONST: #65

CONST_43R	.REAL 65.0
; CONST: #91


; CONST: #57


; CONST: #48

CONST_46R	.REAL 48.0
; CONST: ${ctrl 9}error bei
CONST_47	.BYTE 17
.STRG "{ctrl 9}error bei"
; CONST: #827

CONST_48R	.REAL 827.0
; CONST: #58

CONST_49R	.REAL 58.0
; CONST: #47


; CONST: #65536

CONST_51	.REAL 65536
; CONST: #90

CONST_52R	.REAL 90.0
; CONST: #59

CONST_53R	.REAL 59.0
; CONST: #44

CONST_54R	.REAL 44.0
; CONST: #41

CONST_55R	.REAL 41.0
; CONST: #680

CONST_56R	.REAL 680.0
; CONST: #255

CONST_57R	.REAL 255.0
; CONST: $000000
CONST_58	.BYTE 6
.STRG "000000"
; CONST: ${left}
CONST_59	.BYTE 6
.STRG "{left}"
; CONST: #828

CONST_60R	.REAL 828.0
; CONST: #128

CONST_61R	.REAL 128.0
; CONST: #204

CONST_62R	.REAL 204.0
; CONST: #127

CONST_63R	.REAL 127.0
; CONST: #185


; CONST: #139

CONST_65R	.REAL 139.0
; CONST: #167

CONST_66R	.REAL 167.0
; CONST: #829

CONST_67R	.REAL 829.0
; CONST: #136

CONST_68R	.REAL 136.0
; CONST: #144

CONST_69R	.REAL 144.0
; CONST: #142

CONST_70R	.REAL 142.0
; CONST: #96


; CONST: #158

CONST_72R	.REAL 158.0
; CONST: #153

CONST_73R	.REAL 153.0
; CONST: #151

CONST_74R	.REAL 151.0
; CONST: #129

CONST_75R	.REAL 129.0
; CONST: #130

CONST_76R	.REAL 130.0
; CONST: #143

CONST_77R	.REAL 143.0
; CONST: #137

CONST_78R	.REAL 137.0
; CONST: #76

CONST_79R	.REAL 76.0
; CONST: #141

CONST_80R	.REAL 141.0
; CONST: #64

CONST_81R	.REAL 64.0
; CONST: ${ctrl 9}error
CONST_82	.BYTE 13
.STRG "{ctrl 9}error"
; CONST: #842

CONST_83R	.REAL 842.0
; CONST: #178

CONST_84R	.REAL 178.0
; CONST: #179

CONST_85R	.REAL 179.0
; CONST: #180

CONST_86R	.REAL 180.0
; CONST: #228


; CONST: #240


; CONST: #197


; CONST: #208


; CONST: #199

CONST_91R	.REAL 199.0
; CONST: #29


; CONST: #210


; CONST: #165


; CONST: #205


; CONST: #189


; CONST: #40


; CONST: #30


; CONST: #831

CONST_99R	.REAL 831.0
; CONST: #11


; CONST: #20


; CONST: #21


; CONST: #54


; CONST: #225


; CONST: #145


; CONST: #15

CONST_106R	.REAL 15.0
; CONST: $test.comp
CONST_107	.BYTE 9
.STRG "test.comp"
; CONST: #49152

CONST_108	.REAL 49152
; CONST: ${control-q}name des quelltextes
CONST_109	.BYTE 31
.STRG "{control-q}name des quelltextes"
; CONST: $*
CONST_110	.BYTE 1
.STRG "*"
; CONST: $startadresse
CONST_111	.BYTE 12
.STRG "startadresse"
; CONST: $?redo from start
CONST_112	.BYTE 16
.STRG "?redo from start"
; CONST: #116


; CONST: #164


; CONST: $0:
CONST_115	.BYTE 2
.STRG "0:"
; CONST: ${control-q}errors
CONST_116	.BYTE 17
.STRG "{control-q}errors"
; CONST: $adressbereich
CONST_117	.BYTE 13
.STRG "adressbereich"
; CONST: #-1.0

CONST_118	.REAL -1.0
; CONST: $ kompiliert, zeit:
CONST_119	.BYTE 18
.STRG " kompiliert, zeit:"
; CONST: ${control-q}1=save 2=exec 3=comp 4=quit
CONST_120	.BYTE 38
.STRG "{control-q}1=save 2=exec 3=comp 4=quit"
; CONST: $1
CONST_121	.BYTE 1
.STRG "1"
; CONST: $2
CONST_122	.BYTE 1
.STRG "2"
; CONST: $3
CONST_123	.BYTE 1
.STRG "3"
; CONST: $4
CONST_124	.BYTE 1
.STRG "4"
; CONST: #731

CONST_125R	.REAL 731.0
; CONST: $.ml
CONST_126	.BYTE 3
.STRG ".ml"
; CONST: ${control-q}name
CONST_127	.BYTE 15
.STRG "{control-q}name"
; CONST: $s0:
CONST_128	.BYTE 3
.STRG "s0:"
; CONST: #253


; CONST: #191

CONST_130R	.REAL 191.0
; CONST: #783

CONST_131R	.REAL 783.0
; CONST: $disk error
CONST_132	.BYTE 10
.STRG "disk error"
;###############################
; ******** DATA ********
DATAS
.BYTE 133
.BYTE 99
.BYTE 134
.BYTE 100
.BYTE 162
.BYTE 3
.BYTE 0
.BYTE 134
.BYTE 101
.BYTE 134
.BYTE 102
.BYTE 160
.BYTE 16
.BYTE 144
.BYTE 34
.BYTE 6
.BYTE 97
.BYTE 38
.BYTE 98
.BYTE 38
.BYTE 101
.BYTE 38
.BYTE 102
.BYTE 56
.BYTE 165
.BYTE 101
.BYTE 229
.BYTE 99
.BYTE 170
.BYTE 165
.BYTE 102
.BYTE 229
.BYTE 100
.BYTE 144
.BYTE 6
.BYTE 134
.BYTE 101
.BYTE 133
.BYTE 102
.BYTE 230
.BYTE 97
.BYTE 136
.BYTE 208
.BYTE 227
.BYTE 165
.BYTE 97
.BYTE 166
.BYTE 98
.BYTE 96
.BYTE 70
.BYTE 102
.BYTE 102
.BYTE 101
.BYTE 102
.BYTE 98
.BYTE 102
.BYTE 97
.BYTE 136
.BYTE 48
.BYTE 240
.BYTE 144
.BYTE 243
.BYTE 24
.BYTE 165
.BYTE 101
.BYTE 101
.BYTE 99
.BYTE 133
.BYTE 101
.BYTE 165
.BYTE 102
.BYTE 101
.BYTE 100
.BYTE 133
.BYTE 102
.BYTE 24
.BYTE 144
.BYTE 227
.BYTE 0
.WORD -1
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: G
VAR_G	.REAL 0.0
; VAR: A
VAR_A	.REAL 0.0
; VAR: L
VAR_L	.REAL 0.0
; VAR: K
VAR_K	.REAL 0.0
; VAR: V
VAR_V	.REAL 0.0
; VAR: H
VAR_H	.REAL 0.0
; VAR: C
VAR_C	.REAL 0.0
; VAR: P
VAR_P	.REAL 0.0
; VAR: U
VAR_U	.REAL 0.0
; VAR: ER
VAR_ER	.REAL 0.0
; VAR: O
VAR_O	.REAL 0.0
; VAR: B
VAR_B	.REAL 0.0
; VAR: S
VAR_S	.REAL 0.0
; VAR: D
VAR_D	.REAL 0.0
; VAR: N
VAR_N	.REAL 0.0
; VAR: T
VAR_T	.REAL 0.0
; VAR: H%
VAR_H%	.WORD 0
; VAR: M
VAR_M	.REAL 0.0
; VAR: S[]
.BYTE 1
.WORD 1280
VAR_S[]	.ARRAY 1280
; VAR: L[]
.BYTE 1
.WORD 1280
VAR_L[]	.ARRAY 1280
; VAR: F
VAR_F	.REAL 0.0
; VAR: J
VAR_J	.REAL 0.0
; VAR: ST
VAR_ST	.REAL 0.0
; VAR: Q
VAR_Q	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: W
VAR_W	.REAL 0.0
; VAR: R
VAR_R	.REAL 0.0
; VAR: N[]
.BYTE 1
.WORD 320
VAR_N[]	.ARRAY 320
; VAR: A[]
.BYTE 1
.WORD 320
VAR_A[]	.ARRAY 320
; VAR: LP
VAR_LP	.REAL 0.0
; VAR: HU
VAR_HU	.REAL 0.0
; VAR: HF
VAR_HF	.REAL 0.0
; VAR: XA
VAR_XA	.REAL 0.0
; VAR: E1
VAR_E1	.REAL 0.0
; VAR: E3
VAR_E3	.REAL 0.0
; VAR: E4
VAR_E4	.REAL 0.0
; VAR: E
VAR_E	.REAL 0.0
STRINGVARS_START
; VAR: A1$
VAR_A1$	.WORD EMPTYSTR
; VAR: A2$
VAR_A2$	.WORD EMPTYSTR
; VAR: TI$
VAR_TI$	.WORD EMPTYSTR
; VAR: L1$
VAR_L1$	.WORD EMPTYSTR
; VAR: L2$
VAR_L2$	.WORD EMPTYSTR
; VAR: Z$
VAR_Z$	.WORD EMPTYSTR
; VAR: S1$
VAR_S1$	.WORD EMPTYSTR
; VAR: S2$
VAR_S2$	.WORD EMPTYSTR
; VAR: B$
VAR_B$	.WORD EMPTYSTR
; VAR: S$
VAR_S$	.WORD EMPTYSTR
; VAR: E2$
VAR_E2$	.WORD EMPTYSTR
; VAR: X$
VAR_X$	.WORD EMPTYSTR
; VAR: N$
VAR_N$	.WORD EMPTYSTR
; VAR: T$
VAR_T$	.WORD EMPTYSTR
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
