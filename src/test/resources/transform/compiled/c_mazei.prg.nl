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
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR REALOUT
JSR CRSRRIGHT
JSR TABOUT
LDA #142
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_20:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
;
LINE_30:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
;
LINE_40:
;
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
LDA #<FORLOOP1
STA JUMP_TARGET
LDA #>FORLOOP1
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP1:
;
LINE_50:
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
JSR PUSHREAL
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
LDA #<CONST_7
LDY #>CONST_7
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
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
;
LINE_60:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF3+1
STA MOVBSELF3+2
LDA #$1
MOVBSELF3:
STA $FFFF
;
LINE_70:
;
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_0
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_0:
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
LINE_80:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
;
LINE_90:
;
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
;
LINE_100:
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
JSR PUSHREAL
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
LDA #<CONST_8R
LDY #>CONST_8R
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
;
LINE_110:
;
LDY VAR_A%
LDA VAR_A%+1
STY MOVBSELF4+1
; Optimizer rule: Remove INTFAC/FACWORD/3
STA MOVBSELF4+2
LDA #$51
MOVBSELF4:
STA $FFFF
;
LINE_120:
;
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_2
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_2:
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_3
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_3:
;
LINE_130:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
;
LINE_140:
;
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
;
LINE_150:
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
JSR PUSHREAL
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
LDA #<CONST_8R
LDY #>CONST_8R
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
;
LINE_160:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_10R
LDY #>CONST_10R
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
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_Z%
STA VAR_Z%+1
;
LINE_170:
;
LDY #32
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_B%
STA VAR_B%+1
;
LINE_180:
;
LDA #$0a
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
EQ_EQ0:
EQ_SKIP0:
COMP_SKP4:
BNE LINE_SKIP48
LINE_NSKIP48:
; Optimizer rule: Simplified equal comparison/6
;
LDY #42
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_B%
STA VAR_B%+1
;
LINE_SKIP48:
;
;
LINE_190:
;
LDA #$28
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
EQ_EQ1:
EQ_SKIP1:
COMP_SKP5:
BNE LINE_SKIP49
LINE_NSKIP49:
; Optimizer rule: Simplified equal comparison/6
;
LDY #46
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_B%
STA VAR_B%+1
;
LINE_SKIP49:
;
;
LINE_200:
;
LDY VAR_A%
LDA VAR_A%+1
; integer in Y/A to FAC
STY MOVBSELF5+1
STA MOVBSELF5+2
; Faster POKE of integers
;
;
;
;
LDY VAR_B%
MOVBSELF5:
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
;
LINE_210:
;
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_4
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_4:
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_5
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_5:
;
LINE_220:
;
LDY #1
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_230:
;
;
LINE_240:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
;
LINE_250:
;
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
;
LINE_260:
;
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
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
LDY #160
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_270:
;
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_7
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_7:
;
LINE_280:
;
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
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
LINE_290:
;
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
LDY #253
LDA #3
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_300:
;
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
LDY #42
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_310:
;
LDY #255
LDA #255
STY VAR_X%
STA VAR_X%+1
; Optimized code for negative constants)
;
;
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_Y%
STA VAR_Y%+1
;
LINE_320:
;
LDY #$00
LDA #$02
STY TMP4_REG+1
STA TMP4_REG
LDY VAR_X%
LDA VAR_X%+1
JSR INTADDOPT16X
STY VAR_X%
STA VAR_X%+1
; Optimized code for adding/subtracting ints and store in int
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
LDA #$25
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_X%
LDA VAR_X%+1
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
ROL
BCS GT_GT2
LDA #0
JMP GT_SKIP2
GT_GT2:
LDA #$1
GT_SKIP2:
COMP_SKP10:
BNE LINE_NSKIP50
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP50
;
LINE_NSKIP50:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_X%
STA VAR_X%+1
LDY #$00
LDA #$02
STY TMP4_REG+1
STA TMP4_REG
LDY VAR_Y%
LDA VAR_Y%+1
JSR INTADDOPT16X
STY VAR_Y%
STA VAR_Y%+1
; Optimized code for adding/subtracting ints and store in int
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
LINE_SKIP50:
;
;
LINE_330:
;
LDA #$17
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_Y%
LDA VAR_Y%+1
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
ROL
BCS GT_GT3
LDA #0
JMP GT_SKIP3
GT_GT3:
LDA #$1
GT_SKIP3:
COMP_SKP11:
BEQ LINE_SKIP51
; Simplified conditional branch
;
LINE_NSKIP51:
;
JMP LINE_490
;
LINE_SKIP51:
;
;
LINE_340:
;
LDY VAR_Y%
LDA VAR_Y%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_X%
LDA VAR_X%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Fast INTEGER array access (1)/3
;
LINE_350:
;
LDA #$a0
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_A%
LDA VAR_A%+1
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
EQ_EQ4:
EQ_SKIP4:
COMP_SKP12:
BNE LINE_SKIP52
LINE_NSKIP52:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_320
;
LINE_SKIP52:
;
;
LINE_360:
;
LDY VAR_X%
LDA VAR_X%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_XX%
STA VAR_XX%+1
LDY VAR_Y%
LDA VAR_Y%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_YY%
STA VAR_YY%+1
;
LINE_370:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_RI%
STA VAR_RI%+1
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
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
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY #2
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY #3
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_380:
;
LDA #$02
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_XX%
LDA VAR_XX%+1
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
ROL
BCS GT_GT5
LDA #0
JMP GT_SKIP5
GT_GT5:
LDA #$1
GT_SKIP5:
COMP_SKP13:
BNE LINE_NSKIP53
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP53
;
LINE_NSKIP53:
;
LDY VAR_YY%
LDA VAR_YY%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_XX%
LDA VAR_XX%+1
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
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ6
LDA #0
JMP EQ_SKIP6
EQ_EQ6:
LDA #$1
EQ_SKIP6:
COMP_SKP14:
BNE LINE_NSKIP54
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP54
;
LINE_NSKIP54:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #4
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP54:
;
;
LINE_SKIP53:
;
;
LINE_390:
;
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTADD
LDA #$27
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY TMP2_ZP
LDA TMP2_ZP+1
JSR ICMP
; Optimized code for Integer(+2.0)
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
BEQ LT_LT_EQ7
ROL
BCC LT_LT7
LT_LT_EQ7:
LDA #0
JMP LT_SKIP7
LT_LT7:
LDA #$1
LT_SKIP7:
COMP_SKP15:
BNE LINE_NSKIP55
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP55
;
LINE_NSKIP55:
;
LDY VAR_YY%
LDA VAR_YY%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_XX%
LDA VAR_XX%+1
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
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ8
LDA #0
JMP EQ_SKIP8
EQ_EQ8:
LDA #$1
EQ_SKIP8:
COMP_SKP16:
BNE LINE_NSKIP56
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP56
;
LINE_NSKIP56:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #2
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP56:
;
;
LINE_SKIP55:
;
;
LINE_400:
;
LDA #$02
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_YY%
LDA VAR_YY%+1
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
ROL
BCS GT_GT9
LDA #0
JMP GT_SKIP9
GT_GT9:
LDA #$1
GT_SKIP9:
COMP_SKP17:
BNE LINE_NSKIP57
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP57
;
LINE_NSKIP57:
;
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_YY%
LDA VAR_YY%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
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
COMP_SKP18:
BNE LINE_NSKIP58
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP58
;
LINE_NSKIP58:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP58:
;
;
LINE_SKIP57:
;
;
LINE_410:
;
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_YY%
LDA VAR_YY%+1
JSR INTADD
LDA #$19
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY TMP2_ZP
LDA TMP2_ZP+1
JSR ICMP
; Optimized code for Integer(+2.0)
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
BEQ LT_LT_EQ11
ROL
BCC LT_LT11
LT_LT_EQ11:
LDA #0
JMP LT_SKIP11
LT_LT11:
LDA #$1
LT_SKIP11:
COMP_SKP19:
BNE LINE_NSKIP59
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP59
;
LINE_NSKIP59:
;
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_YY%
LDA VAR_YY%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ12
LDA #0
JMP EQ_SKIP12
EQ_EQ12:
LDA #$1
EQ_SKIP12:
COMP_SKP20:
BNE LINE_NSKIP60
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP60
;
LINE_NSKIP60:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #3
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP60:
;
;
LINE_SKIP59:
;
;
LINE_420:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_RI%
LDA VAR_RI%+1
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
EQ_EQ13:
EQ_SKIP13:
COMP_SKP21:
BNE LINE_SKIP61
LINE_NSKIP61:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_320
;
LINE_SKIP61:
;
;
LINE_430:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_RI%
LDA VAR_RI%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
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
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
;
LINE_440:
;
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY VAR_A%
LDA VAR_A%+1
JSR ARRAYACCESS_INTEGER_INT
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY TMP2_ZP
LDA TMP2_ZP+1
JSR ICMP
; Optimized code for Integer(6)
;
BEQ EQ_EQ14
LDA #0
JMP EQ_SKIP14
EQ_EQ14:
LDA #$1
EQ_SKIP14:
COMP_SKP22:
BNE LINE_NSKIP62
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP62
;
LINE_NSKIP62:
;
LDY VAR_YY%
LDA VAR_YY%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_YY%
STA VAR_YY%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
LDY VAR_YY%
LDA VAR_YY%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_YY%
STA VAR_YY%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP62:
;
;
LINE_450:
;
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY VAR_A%
LDA VAR_A%+1
JSR ARRAYACCESS_INTEGER_INT
LDA #$02
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY TMP2_ZP
LDA TMP2_ZP+1
JSR ICMP
; Optimized code for Integer(4)
;
;
BEQ EQ_EQ15
LDA #0
JMP EQ_SKIP15
EQ_EQ15:
LDA #$1
EQ_SKIP15:
COMP_SKP23:
BNE LINE_NSKIP63
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP63
;
LINE_NSKIP63:
;
LDY VAR_XX%
LDA VAR_XX%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_XX%
STA VAR_XX%+1
LDY VAR_YY%
LDA VAR_YY%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
LDY VAR_XX%
LDA VAR_XX%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_XX%
STA VAR_XX%+1
LDY VAR_YY%
LDA VAR_YY%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP63:
;
;
LINE_460:
;
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY VAR_A%
LDA VAR_A%+1
JSR ARRAYACCESS_INTEGER_INT
LDA #$03
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY TMP2_ZP
LDA TMP2_ZP+1
JSR ICMP
; Optimized code for Integer(4)
;
;
BEQ EQ_EQ16
LDA #0
JMP EQ_SKIP16
EQ_EQ16:
LDA #$1
EQ_SKIP16:
COMP_SKP24:
BNE LINE_NSKIP64
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP64
;
LINE_NSKIP64:
;
LDY VAR_YY%
LDA VAR_YY%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_YY%
STA VAR_YY%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
LDY VAR_YY%
LDA VAR_YY%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_YY%
STA VAR_YY%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP64:
;
;
LINE_470:
;
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY VAR_A%
LDA VAR_A%+1
JSR ARRAYACCESS_INTEGER_INT
LDA #$04
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY TMP2_ZP
LDA TMP2_ZP+1
JSR ICMP
; Optimized code for Integer(4)
;
;
BEQ EQ_EQ17
LDA #0
JMP EQ_SKIP17
EQ_EQ17:
LDA #$1
EQ_SKIP17:
COMP_SKP25:
BNE LINE_NSKIP65
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP65
;
LINE_NSKIP65:
;
LDY VAR_XX%
LDA VAR_XX%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_XX%
STA VAR_XX%+1
LDY VAR_YY%
LDA VAR_YY%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
LDY VAR_XX%
LDA VAR_XX%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_XX%
STA VAR_XX%+1
LDY VAR_YY%
LDA VAR_YY%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #32
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP65:
;
;
LINE_480:
;
JMP LINE_370
;
LINE_490:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP8
STA JUMP_TARGET
LDA #>FORLOOP8
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP8:
;
LINE_500:
;
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
LDA #<FORLOOP9
STA JUMP_TARGET
LDA #>FORLOOP9
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP9:
;
LINE_510:
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
JSR PUSHREAL
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
LDA #<CONST_8R
LDY #>CONST_8R
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
;
LINE_520:
;
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
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
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_B%
STA VAR_B%+1
; Optimizer rule: Fast INTEGER array access (1)/3
;
LINE_530:
;
LDY VAR_A%
LDA VAR_A%+1
; integer in Y/A to FAC
STY MOVBSELF7+1
STA MOVBSELF7+2
; Faster POKE of integers
;
;
;
;
LDY VAR_B%
MOVBSELF7:
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
;
LINE_540:
;
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_8
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_8:
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_9
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_9:
;
LINE_550:
;
LDY #0
TYA
STY VAR_XX%
STA VAR_XX%+1
STY VAR_YY%
STA VAR_YY%+1
; Optimizer rule: Accumulate integer loads/6
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_RI%
STA VAR_RI%+1
;
LINE_560:
;
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
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
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY #2
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY #3
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_570:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_X%
STA VAR_X%+1
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_Y%
STA VAR_Y%+1
;
LINE_580:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
;
LINE_590:
;
LDY VAR_A%
LDA VAR_A%+1
STY MOVBSELF8+1
; Optimizer rule: Remove INTFAC/FACWORD/3
STA MOVBSELF8+2
LDA #$51
MOVBSELF8:
STA $FFFF
;
LINE_600:
;
LDY #37
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_XX%
STA VAR_XX%+1
LDY #24
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_YY%
STA VAR_YY%+1
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_ZZ%
STA VAR_ZZ%+1
;
LINE_610:
;
LDY VAR_YY%
LDA VAR_YY%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
;
LINE_620:
;
LDY VAR_A%
LDA VAR_A%+1
STY MOVBSELF9+1
; Optimizer rule: Remove INTFAC/FACWORD/3
STA MOVBSELF9+2
LDA #$2A
MOVBSELF9:
STA $FFFF
;
LINE_630:
;
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
;
LINE_640:
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
COMP_SKP28:
BNE LINE_NSKIP66
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP66
;
LINE_NSKIP66:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACINT
STY VAR_A%
STA VAR_A%+1
STY MOVBSELF10+1
STA MOVBSELF10+2
; Optimized code for POKE of Integer values(3)
;
;
;
;
;
;
;
;
LDA #$51
MOVBSELF10:
STA $FFFF
;
LINE_SKIP66:
;
;
LINE_650:
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
COMP_SKP29:
BEQ LINE_SKIP67
; Simplified conditional branch
;
LINE_NSKIP67:
;
JMP LINE_960
;
LINE_SKIP67:
;
;
LINE_660:
;
LDA #<CONST_27
LDY #>CONST_27
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP30:
BEQ LINE_SKIP68
; Simplified conditional branch
;
LINE_NSKIP68:
;
JSR GOSUB
JSR LINE_740
;
LINE_SKIP68:
;
;
LINE_670:
;
LDA #<CONST_28
LDY #>CONST_28
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP31:
BEQ LINE_SKIP69
; Simplified conditional branch
;
LINE_NSKIP69:
;
JSR GOSUB
JSR LINE_800
;
LINE_SKIP69:
;
;
LINE_680:
;
LDA #<CONST_29
LDY #>CONST_29
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP32:
BEQ LINE_SKIP70
; Simplified conditional branch
;
LINE_NSKIP70:
;
JSR GOSUB
JSR LINE_850
;
LINE_SKIP70:
;
;
LINE_690:
;
LDA #<CONST_30
LDY #>CONST_30
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP33:
BEQ LINE_SKIP71
; Simplified conditional branch
;
LINE_NSKIP71:
;
JSR GOSUB
JSR LINE_910
;
LINE_SKIP71:
;
;
LINE_700:
;
JSR GOSUB
JSR LINE_1060
;
LINE_710:
;
LDY VAR_YY%
LDA VAR_YY%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_Y%
LDA VAR_Y%+1
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
BEQ EQ_EQ18
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP18
EQ_EQ18:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP18:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDY VAR_XX%
LDA VAR_XX%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_X%
LDA VAR_X%+1
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
BEQ EQ_EQ19
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP19
EQ_EQ19:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP19:
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
COMP_SKP34:
BEQ LINE_SKIP72
; Simplified conditional branch
;
LINE_NSKIP72:
;
LDY #2
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_SKIP72:
;
;
LINE_720:
;
LDY VAR_YY%
LDA VAR_YY%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_Y%
LDA VAR_Y%+1
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
BNE NEQ_NEQ20
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP20
NEQ_NEQ20:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP20:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDY VAR_XX%
LDA VAR_XX%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_X%
LDA VAR_X%+1
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
BNE NEQ_NEQ21
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP21
NEQ_NEQ21:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP21:
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
COMP_SKP35:
BEQ LINE_SKIP73
; Simplified conditional branch
;
LINE_NSKIP73:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
;
LINE_SKIP73:
;
;
LINE_730:
;
JMP LINE_630
;
LINE_740:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_Y%
LDA VAR_Y%+1
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
BEQ LT_LT_EQ22
ROL
BCC LT_LT22
LT_LT_EQ22:
LDA #0
JMP LT_SKIP22
LT_LT22:
LDA #$1
LT_SKIP22:
COMP_SKP36:
BEQ LINE_SKIP74
; Simplified conditional branch
;
LINE_NSKIP74:
;
JMP LINE_790
;
LINE_SKIP74:
;
;
LINE_750:
;
LDY VAR_Y%
LDA VAR_Y%+1
JSR FIDEX
; Optimizer rule: Fast INTEGER DEC/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_X%
LDA VAR_X%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ23:
EQ_SKIP23:
COMP_SKP37:
BNE LINE_SKIP75
LINE_NSKIP75:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_790
;
LINE_SKIP75:
;
;
LINE_760:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF13+1
STA MOVBSELF13+2
LDA #$20
MOVBSELF13:
STA $FFFF
;
LINE_770:
;
LDY VAR_Y%
LDA VAR_Y%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_Y%
STA VAR_Y%+1
;
LINE_780:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF14+1
STA MOVBSELF14+2
LDA #$51
MOVBSELF14:
STA $FFFF
;
LINE_790:
;
JMP RETURN
;
LINE_800:
;
LDY VAR_Y%
LDA VAR_Y%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY VAR_X%
LDA VAR_X%+1
JSR FIINX
; Optimizer rule: Fast INTEGER INC/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
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
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ24:
EQ_SKIP24:
COMP_SKP38:
BNE LINE_SKIP76
LINE_NSKIP76:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_840
;
LINE_SKIP76:
;
;
LINE_810:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF15+1
STA MOVBSELF15+2
LDA #$20
MOVBSELF15:
STA $FFFF
;
LINE_820:
;
LDY VAR_X%
LDA VAR_X%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_X%
STA VAR_X%+1
;
LINE_830:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF16+1
STA MOVBSELF16+2
LDA #$51
MOVBSELF16:
STA $FFFF
;
LINE_840:
;
JMP RETURN
;
LINE_850:
;
LDY VAR_Y%
LDA VAR_Y%+1
JSR FIINX
; Optimizer rule: Fast INTEGER INC/3
LDA #<CONST_4R
LDY #>CONST_4R
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
COMP_SKP39:
BEQ LINE_SKIP77
; Simplified conditional branch
;
LINE_NSKIP77:
;
JMP LINE_900
;
LINE_SKIP77:
;
;
LINE_860:
;
LDY VAR_Y%
LDA VAR_Y%+1
JSR FIINX
; Optimizer rule: Fast INTEGER INC/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_X%
LDA VAR_X%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ26:
EQ_SKIP26:
COMP_SKP40:
BNE LINE_SKIP78
LINE_NSKIP78:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_900
;
LINE_SKIP78:
;
;
LINE_870:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF17+1
STA MOVBSELF17+2
LDA #$20
MOVBSELF17:
STA $FFFF
;
LINE_880:
;
LDY VAR_Y%
LDA VAR_Y%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_Y%
STA VAR_Y%+1
;
LINE_890:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF18+1
STA MOVBSELF18+2
LDA #$51
MOVBSELF18:
STA $FFFF
;
LINE_900:
;
JMP RETURN
;
LINE_910:
;
LDY VAR_Y%
LDA VAR_Y%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY VAR_X%
LDA VAR_X%+1
JSR FIDEX
; Optimizer rule: Fast INTEGER DEC/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
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
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ27:
EQ_SKIP27:
COMP_SKP41:
BNE LINE_SKIP79
LINE_NSKIP79:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_950
;
LINE_SKIP79:
;
;
LINE_920:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF19+1
STA MOVBSELF19+2
LDA #$20
MOVBSELF19:
STA $FFFF
;
LINE_930:
;
LDY VAR_X%
LDA VAR_X%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_X%
STA VAR_X%+1
;
LINE_940:
;
LDY VAR_Y%
LDA VAR_Y%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_X%
LDA VAR_X%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF20+1
STA MOVBSELF20+2
LDA #$51
MOVBSELF20:
STA $FFFF
;
LINE_950:
;
JMP RETURN
;
LINE_960:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP10
STA JUMP_TARGET
LDA #>FORLOOP10
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP10:
;
LINE_970:
;
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_3R
;LDY #>CONST_3R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
LDA #<FORLOOP11
STA JUMP_TARGET
LDA #>FORLOOP11
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP11:
;
LINE_980:
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
JSR PUSHREAL
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
LDA #<CONST_8R
LDY #>CONST_8R
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
; Optimizer rule: Remove unneeded INT->WORD conversion/0
STY MOVBSELF21+1
STA MOVBSELF21+2
LDA #$20
MOVBSELF21:
STA $FFFF
;
LINE_990:
;
LDA #<VAR_Y
LDY #>VAR_Y
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_10
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_10:
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_11
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_11:
;
LINE_1000:
;
LDA #<CONST_31
LDY #>CONST_31
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1010:
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1020:
;
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1030:
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1040:
;
LDA #<CONST_31
LDY #>CONST_31
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1050:
;
JSR CLR
JSR END
RTS
;
LINE_1060:
;
LDY VAR_ZZ%
LDA VAR_ZZ%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_A%
STA VAR_A%+1
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_RI%
STA VAR_RI%+1
;
LINE_1070:
;
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
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
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY #2
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY #3
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_1080:
;
LDY VAR_A%
LDA VAR_A%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_A%
STA VAR_A%+1
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_A%
LDA VAR_A%+1
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
BEQ LT_LT_EQ28
ROL
BCC LT_LT28
LT_LT_EQ28:
LDA #0
JMP LT_SKIP28
LT_LT28:
LDA #$1
LT_SKIP28:
COMP_SKP44:
BEQ LINE_SKIP80
; Simplified conditional branch
;
LINE_NSKIP80:
;
LDY #4
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_A%
STA VAR_A%+1
;
LINE_SKIP80:
;
;
LINE_1090:
;
JSR GOSUB
JSR LINE_1300
;
LINE_1100:
;
LDY VAR_A%
LDA VAR_A%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_A%
STA VAR_A%+1
LDA #$04
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_A%
LDA VAR_A%+1
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
ROL
BCS GT_GT29
LDA #0
JMP GT_SKIP29
GT_GT29:
LDA #$1
GT_SKIP29:
COMP_SKP45:
BEQ LINE_SKIP81
; Simplified conditional branch
;
LINE_NSKIP81:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_A%
STA VAR_A%+1
;
LINE_SKIP81:
;
;
LINE_1110:
;
JSR GOSUB
JSR LINE_1300
;
LINE_1120:
;
LDY VAR_A%
LDA VAR_A%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_A%
STA VAR_A%+1
LDA #$04
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_A%
LDA VAR_A%+1
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
ROL
BCS GT_GT30
LDA #0
JMP GT_SKIP30
GT_GT30:
LDA #$1
GT_SKIP30:
COMP_SKP46:
BEQ LINE_SKIP82
; Simplified conditional branch
;
LINE_NSKIP82:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_A%
STA VAR_A%+1
;
LINE_SKIP82:
;
;
LINE_1130:
;
JSR GOSUB
JSR LINE_1300
;
LINE_1140:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_RI%
LDA VAR_RI%+1
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
EQ_EQ31:
EQ_SKIP31:
COMP_SKP47:
BNE LINE_SKIP83
LINE_NSKIP83:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_1250
;
LINE_SKIP83:
;
;
LINE_1150:
;
LDY VAR_YY%
LDA VAR_YY%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
;
LINE_1160:
;
LDY VAR_A%
LDA VAR_A%+1
STY MOVBSELF22+1
; Optimizer rule: Remove INTFAC/FACWORD/3
STA MOVBSELF22+2
LDA #$20
MOVBSELF22:
STA $FFFF
;
LINE_1170:
;
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
LDY VAR_RI%
LDA VAR_RI%+1
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_ZZ%
STA VAR_ZZ%+1
; Optimizer rule: Fast INTEGER array access (2)/3
;
LINE_1180:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_ZZ%
LDA VAR_ZZ%+1
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
EQ_EQ32:
EQ_SKIP32:
COMP_SKP48:
BNE LINE_SKIP84
LINE_NSKIP84:
; Optimizer rule: Simplified equal comparison/6
;
LDY VAR_YY%
LDA VAR_YY%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_YY%
STA VAR_YY%+1
;
LINE_SKIP84:
;
;
LINE_1190:
;
LDA #$02
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_ZZ%
LDA VAR_ZZ%+1
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
EQ_EQ33:
EQ_SKIP33:
COMP_SKP49:
BNE LINE_SKIP85
LINE_NSKIP85:
; Optimizer rule: Simplified equal comparison/6
;
LDY VAR_XX%
LDA VAR_XX%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_XX%
STA VAR_XX%+1
;
LINE_SKIP85:
;
;
LINE_1200:
;
LDA #$03
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_ZZ%
LDA VAR_ZZ%+1
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
EQ_EQ34:
EQ_SKIP34:
COMP_SKP50:
BNE LINE_SKIP86
LINE_NSKIP86:
; Optimizer rule: Simplified equal comparison/6
;
LDY VAR_YY%
LDA VAR_YY%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_YY%
STA VAR_YY%+1
;
LINE_SKIP86:
;
;
LINE_1210:
;
LDA #$04
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_ZZ%
LDA VAR_ZZ%+1
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
EQ_EQ35:
EQ_SKIP35:
COMP_SKP51:
BNE LINE_SKIP87
LINE_NSKIP87:
; Optimizer rule: Simplified equal comparison/6
;
LDY VAR_XX%
LDA VAR_XX%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_XX%
STA VAR_XX%+1
;
LINE_SKIP87:
;
;
LINE_1220:
;
LDY VAR_YY%
LDA VAR_YY%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY #$04
LDA #$00
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_A%
STA VAR_A%+1
;
LINE_1230:
;
LDY VAR_A%
LDA VAR_A%+1
STY MOVBSELF23+1
; Optimizer rule: Remove INTFAC/FACWORD/3
STA MOVBSELF23+2
LDA #$2A
MOVBSELF23:
STA $FFFF
;
LINE_1240:
;
JMP RETURN
;
LINE_1250:
;
LDY VAR_ZZ%
LDA VAR_ZZ%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_A%
STA VAR_A%+1
;
LINE_1260:
;
LDY VAR_A%
LDA VAR_A%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_A%
STA VAR_A%+1
LDA #$04
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_A%
LDA VAR_A%+1
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
ROL
BCS GT_GT36
LDA #0
JMP GT_SKIP36
GT_GT36:
LDA #$1
GT_SKIP36:
COMP_SKP52:
BEQ LINE_SKIP88
; Simplified conditional branch
;
LINE_NSKIP88:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_A%
STA VAR_A%+1
;
LINE_SKIP88:
;
;
LINE_1270:
;
LDY VAR_A%
LDA VAR_A%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_A%
STA VAR_A%+1
LDA #$04
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_A%
LDA VAR_A%+1
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
ROL
BCS GT_GT37
LDA #0
JMP GT_SKIP37
GT_GT37:
LDA #$1
GT_SKIP37:
COMP_SKP53:
BEQ LINE_SKIP89
; Simplified conditional branch
;
LINE_NSKIP89:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_A%
STA VAR_A%+1
;
LINE_SKIP89:
;
;
LINE_1280:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_A%
LDA VAR_A%+1
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_1290:
;
JMP RETURN
;
LINE_1300:
;
LDY VAR_A%
LDA VAR_A%+1
; integer in Y/A to FAC
STY TMP_ZP
; Optimizer rule: Remove INT conversions/1
; Optimizer rule: FAC 2 Y_REG(2)/1
ON1SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP54:
BNE AFTER1SUB0
JMP LINE_1320
AFTER1SUB0:
ON1SUB1:
INX
CPX TMP_ZP
COMP_SKP55:
BNE AFTER1SUB1
JMP LINE_1350
AFTER1SUB1:
ON1SUB2:
INX
CPX TMP_ZP
COMP_SKP56:
BNE AFTER1SUB2
JMP LINE_1370
AFTER1SUB2:
ON1SUB3:
INX
CPX TMP_ZP
COMP_SKP57:
BNE AFTER1SUB3
JMP LINE_1400
AFTER1SUB3:
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
GSKIPON1:
;
LINE_1310:
;
JMP LINE_960
;
LINE_1320:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_YY%
LDA VAR_YY%+1
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
BEQ LT_LT_EQ38
ROL
BCC LT_LT38
LT_LT_EQ38:
LDA #0
JMP LT_SKIP38
LT_LT38:
LDA #$1
LT_SKIP38:
COMP_SKP58:
BEQ LINE_SKIP90
; Simplified conditional branch
;
LINE_NSKIP90:
;
JMP LINE_1340
;
LINE_SKIP90:
;
;
LINE_1330:
;
LDY VAR_YY%
LDA VAR_YY%+1
JSR FIDEX
; Optimizer rule: Fast INTEGER DEC/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ39
LDA #0
JMP EQ_SKIP39
EQ_EQ39:
LDA #$1
EQ_SKIP39:
COMP_SKP59:
BNE LINE_NSKIP91
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP91
;
LINE_NSKIP91:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP91:
;
;
LINE_1340:
;
JMP LINE_1410
;
LINE_1350:
;
LDY VAR_YY%
LDA VAR_YY%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY VAR_XX%
LDA VAR_XX%+1
JSR FIINX
; Optimizer rule: Fast INTEGER INC/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
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
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ40
LDA #0
JMP EQ_SKIP40
EQ_EQ40:
LDA #$1
EQ_SKIP40:
COMP_SKP60:
BNE LINE_NSKIP92
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP92
;
LINE_NSKIP92:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #2
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP92:
;
;
LINE_1360:
;
JMP LINE_1410
;
LINE_1370:
;
LDY VAR_YY%
LDA VAR_YY%+1
JSR FIINX
; Optimizer rule: Fast INTEGER INC/3
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT41
LDA #0
JMP GT_SKIP41
GT_GT41:
LDA #$1
GT_SKIP41:
COMP_SKP61:
BEQ LINE_SKIP93
; Simplified conditional branch
;
LINE_NSKIP93:
;
JMP LINE_1390
;
LINE_SKIP93:
;
;
LINE_1380:
;
LDY VAR_YY%
LDA VAR_YY%+1
JSR FIINX
; Optimizer rule: Fast INTEGER INC/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACXREG
LDY VAR_XX%
LDA VAR_XX%+1
JSR INTFAC
JSR XREGARG
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: Improved index calculation (3)/6
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
JSR FACXREG
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ42
LDA #0
JMP EQ_SKIP42
EQ_EQ42:
LDA #$1
EQ_SKIP42:
COMP_SKP62:
BNE LINE_NSKIP94
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP94
;
LINE_NSKIP94:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #3
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP94:
;
;
LINE_1390:
;
JMP LINE_1410
;
LINE_1400:
;
LDY VAR_YY%
LDA VAR_YY%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Improved index calculation (1)/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDY VAR_XX%
LDA VAR_XX%+1
JSR FIDEX
; Optimizer rule: Fast INTEGER DEC/3
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
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
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR ARRAYACCESS_INTEGER_SNX
; Optimizer rule: Value already in FAC(2)/4
; Optimizer rule: Memory saving array access (integer)/3
LDA #<CONST_11R
LDY #>CONST_11R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ43
LDA #0
JMP EQ_SKIP43
EQ_EQ43:
LDA #$1
EQ_SKIP43:
COMP_SKP63:
BNE LINE_NSKIP95
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP95
;
LINE_NSKIP95:
;
LDY VAR_RI%
LDA VAR_RI%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_RI%
STA VAR_RI%+1
; Optimizer rule: Store and load/3
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDY #4
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INT_INTEGER
; Optimizer rule: Array content is integer (store)/9
;
LINE_SKIP95:
;
;
LINE_1410:
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
PRINTNULL	JSR REROUTE
LDA #$20
JSR CHROUT
LDA #$30
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
INTADDOPT16X
INTADD16X	JSR INTADD16
LDY TMP4_REG
LDA TMP4_REG+1
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
FIDEX		CPY #0
BNE FIDEXNOV
SEC
SBC #$1
FIDEXNOV	DEY
JSR INTFAC
JMP FACXREG
;###################################
;###################################
FIINX		INY
BNE FIINXNOV
CLC
ADC #$1
FIINXNOV	JSR INTFAC
JMP FACXREG
;###################################
;###################################
SUPERFIINX	INY
BNE SFIINXNOV
CLC
ADC #$1
CMP #$80
BNE SFIINXNOV
JMP ILLEGALQUANTITY
SFIINXNOV	RTS
;###################################
;###################################
SUPERFIDEX	CPY #0
BNE SUPERFIDEXNOV
SEC
SBC #$1
CMP #$7F
BNE SUPERFIDEXNOV
JMP ILLEGALQUANTITY
SUPERFIDEXNOV
DEY
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
STA VAR_TI,Y
STA VAR_X,Y
STA VAR_Y,Y
STA VAR_A,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
STA VAR_A%
STA VAR_A%+1
STA VAR_Z%
STA VAR_Z%+1
STA VAR_B%
STA VAR_B%+1
LDA #<VAR_FE%[]
LDY #>VAR_FE%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_X%
STA VAR_X%+1
STA VAR_Y%
STA VAR_Y%+1
STA VAR_XX%
STA VAR_XX%+1
STA VAR_YY%
STA VAR_YY%+1
STA VAR_RI%
STA VAR_RI%+1
LDA #<VAR_RI%[]
LDY #>VAR_RI%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_ZZ%
STA VAR_ZZ%+1
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #142


; CONST: #0


; CONST: #39

CONST_2R	.REAL 39.0
; CONST: #1

MOSTCOMMON
CONST_3R	.REAL 1.0
; CONST: #24

CONST_4R	.REAL 24.0
; CONST: #5


; CONST: #3


; CONST: #55296

CONST_7	.REAL 55296
; CONST: #1024

CONST_8R	.REAL 1024.0
; CONST: #81


; CONST: #50

CONST_10R	.REAL 50.0
; CONST: #32

CONST_11R	.REAL 32.0
; CONST: #10


; CONST: #42


; CONST: #40


; CONST: #46


; CONST: #41

CONST_16R	.REAL 41.0
; CONST: #160

CONST_17R	.REAL 160.0
; CONST: #1021


; CONST: #-1.0


; CONST: #2


; CONST: #37


; CONST: #23


; CONST: #4


; CONST: #25


; CONST: $
CONST_25	.BYTE 0
.STRG ""
; CONST: $q
CONST_26	.BYTE 1
.STRG "q"
; CONST: $w
CONST_27	.BYTE 1
.STRG "w"
; CONST: $d
CONST_28	.BYTE 1
.STRG "d"
; CONST: $s
CONST_29	.BYTE 1
.STRG "s"
; CONST: $a
CONST_30	.BYTE 1
.STRG "a"
; CONST: $***************
CONST_31	.BYTE 15
.STRG "***************"
; CONST: $*             *
CONST_32	.BYTE 15
.STRG "*             *"
; CONST: $* sabrinachen *
CONST_33	.BYTE 15
.STRG "* sabrinachen *"
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: TI
VAR_TI	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: A
VAR_A	.REAL 0.0
; VAR: A%
VAR_A%	.WORD 0
; VAR: Z%
VAR_Z%	.WORD 0
; VAR: B%
VAR_B%	.WORD 0
; VAR: FE%[]
.BYTE 0
.WORD 2132
VAR_FE%[]	.ARRAY 2132
; VAR: X%
VAR_X%	.WORD 0
; VAR: Y%
VAR_Y%	.WORD 0
; VAR: XX%
VAR_XX%	.WORD 0
; VAR: YY%
VAR_YY%	.WORD 0
; VAR: RI%
VAR_RI%	.WORD 0
; VAR: RI%[]
.BYTE 0
.WORD 8
VAR_RI%[]	.ARRAY 8
; VAR: ZZ%
VAR_ZZ%	.WORD 0
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
