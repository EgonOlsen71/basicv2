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
LDY #45
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_WL%
STA VAR_WL%+1
LDY #32
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_HL%
STA VAR_HL%+1
LDY #100
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_JY%
STA VAR_JY%+1
;
LINE_20:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_JU%
STA VAR_JU%+1
LDY #2
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_JD%
STA VAR_JD%+1
LDY #4
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_JL%
STA VAR_JL%+1
LDY #8
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_JR%
STA VAR_JR%+1
;
LINE_30:
;
;
LINE_40:
;
LDY #3
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
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
LDY #2
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
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
LDY #2
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
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
LDY #2
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
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
LINE_60:
;
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
STA G_REG
STY G_REG+1
LDY #4
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
STA G_REG
STY G_REG+1
LDY #5
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
STA G_REG
STY G_REG+1
LDY #6
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
STA G_REG
STY G_REG+1
LDY #7
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
STA G_REG
STY G_REG+1
LDY #8
LDA #0
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimized code for fixed integer index(1)
;
;
;
; Optimizer rule: Array content is integer (store)/9
;
LINE_70:
;
;
LINE_80:
;
LDA #<CONST_7R
LDY #>CONST_7R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_12
LDY #>CONST_12
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_LO%[]
LDY #>VAR_LO%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #40
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RO%[]
LDY #>VAR_RO%[]
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
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
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
;
LINE_90:
;
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_LO%[]
LDY #>VAR_LO%[]
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
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_14
LDY #>CONST_14
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_RO%[]
LDY #>VAR_RO%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #40
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
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
LINE_100:
;
LDY #40
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_LO%[]
LDY #>VAR_LO%[]
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
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_12
LDY #>CONST_12
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_RO%[]
LDY #>VAR_RO%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_14
LDY #>CONST_14
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_110:
;
LDA #<CONST_8R
LDY #>CONST_8R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_14
LDY #>CONST_14
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_LO%[]
LDY #>VAR_LO%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_RO%[]
LDY #>VAR_RO%[]
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
LDA #<CONST_8R
LDY #>CONST_8R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_12
LDY #>CONST_12
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_120:
;
;
LINE_130:
;
LDY #8
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_AX%[]
LDY #>VAR_AX%[]
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
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_AY%[]
LDY #>VAR_AY%[]
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
;
LINE_140:
;
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_AX%[]
LDY #>VAR_AX%[]
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
LDY #8
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_AY%[]
LDY #>VAR_AY%[]
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
LINE_150:
;
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_15
LDY #>CONST_15
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AX%[]
LDY #>VAR_AX%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_AY%[]
LDY #>VAR_AY%[]
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
;
LINE_160:
;
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_AX%[]
LDY #>VAR_AX%[]
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
LDA #<CONST_8R
LDY #>CONST_8R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_15
LDY #>CONST_15
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_AY%[]
LDY #>VAR_AY%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
;
LINE_170:
;
LDY #0
TYA
STY VAR_FX%
STA VAR_FX%+1
STY VAR_FY%
STA VAR_FY%+1
; Optimizer rule: Accumulate integer loads/6
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_DI%
STA VAR_DI%+1
LDA #0
STA VAR_PO
STA VAR_PO+1
STA VAR_PO+2
STA VAR_PO+3
STA VAR_PO+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_180:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_C$
STY VAR_C$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
;
LINE_190:
;
LDA #<CONST_17
LDY #>CONST_17
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #252
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG | FAC
JSR FASTOR
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; FAC to integer in Y/A
JSR FACWORD
STY 56576
;
LINE_200:
;
LDY #132
STY 648
; Optimizer rule: Simple POKE/2
;
LINE_210:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
;
LINE_230:
;
LDA 53272
ORA #14
STA 53272
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
LINE_240:
;
JSR GOSUB
JSR LINE_10000
;
LINE_250:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_22R
LDY #>CONST_22R
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
JSR READMAYBEBYTE
; Optimizer rule: Improved READ for bytes/1
STY VAR_B%
STA VAR_B%+1
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_23
LDY #>CONST_23
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0

; Optimizer rule: Remove PUSH/POP/1
JSR FACWORD
STY MOVBSELF6+1
STA MOVBSELF6+2
LDY VAR_B%
MOVBSELF6:
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
BNE RBEQ_0
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_0:
;
LINE_260:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_24R
LDY #>CONST_24R
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
STY VAR_B%
STA VAR_B%+1
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_25
LDY #>CONST_25
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0

; Optimizer rule: Remove PUSH/POP/1
JSR FACWORD
STY MOVBSELF7+1
STA MOVBSELF7+2
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
LINE_265:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_26R
LDY #>CONST_26R
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
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
JSR READNUMBER
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDX #<VAR_V
LDY #>VAR_V
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_V
LDY #>VAR_V
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_MV[]
LDY #>VAR_MV[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
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
LINE_270:
;
LDY #255
STY 54286
; Optimizer rule: Simple POKE/2
STY 54287
; Optimizer rule: Simple POKE/2
LDY #128
STY 54290
; Optimizer rule: Simple POKE/2
;
LINE_280:
;
LDY #14
STY 646
; Optimizer rule: Simple POKE/2
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_290:
;
LDA 53270
ORA #16
STA 53270
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
LINE_300:
;
LDY #14
STY 53282
; Optimizer rule: Simple POKE/2
LDY #15
STY 53283
; Optimizer rule: Simple POKE/2
;
LINE_310:
;
JSR GOSUB
JSR LINE_11000
;
LINE_320:
;
JMP LINE_8000
;
LINE_8000:
;
;
LINE_8010:
;
LDY 56320
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_J%
STA VAR_J%+1
LDY #0
TYA
STY VAR_PJ%
STA VAR_PJ%+1
STY VAR_TM%
STA VAR_TM%+1
; Optimizer rule: Accumulate integer loads/6
;
LINE_8020:
;
LDY VAR_PJ%
LDA VAR_PJ%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_J%
LDA VAR_J%+1
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
BEQ EQ_EQ0
LDA #0
JMP EQ_SKIP0
EQ_EQ0:
LDA #$1
EQ_SKIP0:
COMP_SKP3:
BNE LINE_NSKIP42
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP42
;
LINE_NSKIP42:
;
LDA #$64
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_TM%
LDA VAR_TM%+1
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
NEQ_NEQ1:
NEQ_SKIP1:
COMP_SKP4:
BEQ LINE_SKIP43
LINE_NSKIP43:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_8200
;
LINE_SKIP43:
;
;
LINE_SKIP42:
;
;
LINE_8030:
;
LDY VAR_PJ%
LDA VAR_PJ%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_J%
LDA VAR_J%+1
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
NEQ_NEQ2:
NEQ_SKIP2:
COMP_SKP5:
BEQ LINE_SKIP44
LINE_NSKIP44:
; Optimizer rule: Simplified not equal comparison/6
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_TM%
STA VAR_TM%+1
LDY VAR_J%
LDA VAR_J%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_PJ%
STA VAR_PJ%+1
;
LINE_SKIP44:
;
;
LINE_8040:
;
LDA VAR_J%+1
AND #$00
TAX
LDY VAR_J%
TYA
AND #$01
TAY
TXA
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
JSR FACXREG
; Optimized code for AND/OR
;
;
;
;
;
;
;
;
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BNE NEQ_NEQ3
LDA #0
; Optimizer rule: CMP (REG) != 0/3
JMP NEQ_SKIP3
NEQ_NEQ3:
LDA #$1
NEQ_SKIP3:
COMP_SKP6:
BEQ LINE_SKIP45
; Simplified conditional branch
;
LINE_NSKIP45:
;
JMP LINE_8070
;
LINE_SKIP45:
;
;
LINE_8050:
;
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
LDA #<VAR_PO
LDY #>VAR_PO
JSR REALFAC
JSR FACWORD
JSR OPT_POKE_ADD
STY MOVBSELF16+1
STA MOVBSELF16+2
; Optimized code for POKE/PEEK with addition(2)
;
;
;
;
;
;
;
;
;
MOVBSELF16:
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
BNE NEQ_NEQ4
LDA #0
JMP NEQ_SKIP4
NEQ_NEQ4:
LDA #$1
NEQ_SKIP4:
COMP_SKP7:
BNE LINE_NSKIP46
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP46
;
LINE_NSKIP46:
;
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
LDA #<VAR_PO
LDY #>VAR_PO
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PO
LDY #>VAR_PO
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_10200
JSR GOSUB
JSR LINE_14000
;
LINE_SKIP46:
;
;
LINE_8060:
;
JMP LINE_8200
;
LINE_8070:
;
LDA VAR_J%+1
AND #$00
TAX
LDY VAR_J%
TYA
AND #$02
TAY
TXA
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
JSR FACXREG
; Optimized code for AND/OR
;
;
;
;
;
;
;
;
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BNE NEQ_NEQ5
LDA #0
; Optimizer rule: CMP (REG) != 0/3
JMP NEQ_SKIP5
NEQ_NEQ5:
LDA #$1
NEQ_SKIP5:
COMP_SKP8:
BEQ LINE_SKIP47
; Simplified conditional branch
;
LINE_NSKIP47:
;
JMP LINE_8100
;
LINE_SKIP47:
;
;
LINE_8080:
;
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
LDA #<VAR_PO
LDY #>VAR_PO
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF17+1
STA MOVBSELF17+2
MOVBSELF17:
LDA $FFFF
CMP #45
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
BNE NEQ_NEQ6
LDA #0
JMP NEQ_SKIP6
NEQ_NEQ6:
LDA #$1
NEQ_SKIP6:
COMP_SKP9:
BNE LINE_NSKIP48
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP48
;
LINE_NSKIP48:
;
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
LDA #<VAR_PO
LDY #>VAR_PO
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
LDX #<VAR_PO
LDY #>VAR_PO
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_10400
JSR GOSUB
JSR LINE_14000
;
LINE_SKIP48:
;
;
LINE_8090:
;
JMP LINE_8200
;
LINE_8100:
;
LDA VAR_J%+1
AND #$00
TAX
LDY VAR_J%
TYA
AND #$08
TAY
TXA
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
JSR FACXREG
; Optimized code for AND/OR
;
;
;
;
;
;
;
;
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BNE NEQ_NEQ7
LDA #0
; Optimizer rule: CMP (REG) != 0/3
JMP NEQ_SKIP7
NEQ_NEQ7:
LDA #$1
NEQ_SKIP7:
COMP_SKP10:
BEQ LINE_SKIP49
; Simplified conditional branch
;
LINE_NSKIP49:
;
JMP LINE_8150
;
LINE_SKIP49:
;
;
LINE_8110:
;
LDY VAR_DI%
LDA VAR_DI%+1
JSR SUPERFIINX
AND #$00
TAX
TYA
AND #$03
TAY
TXA
; Optimized code for +1 AND/OR
;
;
;
;
;
;
;
STY VAR_DI%
STA VAR_DI%+1
;
LINE_8120:
;
LDY VAR_DI%
STY 34808
LINE_8130:
; Optimizer rule: Remove unneeded LDA calls(2)/3
;
JSR GOSUB
JSR LINE_14000
;
LINE_8140:
;
LDA #<CONST_32
LDY #>CONST_32
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #8
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA X_REG
BEQ EQ_EQ8
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP8
EQ_EQ8:
LDA #$1
EQ_SKIP8:
COMP_SKP11:
BEQ LINE_SKIP50
; Simplified conditional branch
;
LINE_NSKIP50:
;
JMP LINE_8140
;
LINE_SKIP50:
;
;
LINE_8150:
;
LDA VAR_J%+1
AND #$00
TAX
LDY VAR_J%
TYA
AND #$04
TAY
TXA
JSR INTFAC
; Optimizer rule: Substitute double INT()/1
JSR FACXREG
; Optimized code for AND/OR
;
;
;
;
;
;
;
;
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
BNE NEQ_NEQ9
LDA #0
; Optimizer rule: CMP (REG) != 0/3
JMP NEQ_SKIP9
NEQ_NEQ9:
LDA #$1
NEQ_SKIP9:
COMP_SKP12:
BEQ LINE_SKIP51
; Simplified conditional branch
;
LINE_NSKIP51:
;
JMP LINE_8200
;
LINE_SKIP51:
;
;
LINE_8160:
;
LDY VAR_DI%
LDA VAR_DI%+1
JSR SUPERFIDEX
AND #$00
TAX
TYA
AND #$03
TAY
TXA
; Optimized code for +1 AND/OR
;
;
;
;
;
;
;
STY VAR_DI%
STA VAR_DI%+1
;
LINE_8170:
;
LDY VAR_DI%
STY 34808
LINE_8180:
; Optimizer rule: Remove unneeded LDA calls(2)/3
;
JSR GOSUB
JSR LINE_14000
;
LINE_8190:
;
LDA #<CONST_32
LDY #>CONST_32
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #4
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
LDA X_REG
BEQ EQ_EQ10
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP10
EQ_EQ10:
LDA #$1
EQ_SKIP10:
COMP_SKP13:
BEQ LINE_SKIP52
; Simplified conditional branch
;
LINE_NSKIP52:
;
JMP LINE_8190
;
LINE_SKIP52:
;
;
LINE_8200:
;
LDA #$02
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_TM%
LDA VAR_TM%+1
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
BEQ LT_LT_EQ11
ROL
BCC LT_LT11
LT_LT_EQ11:
LDA #0
JMP LT_SKIP11
LT_LT11:
LDA #$1
LT_SKIP11:
COMP_SKP14:
BEQ LINE_SKIP53
; Simplified conditional branch
;
LINE_NSKIP53:
;
LDY VAR_TM%
LDA VAR_TM%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_TM%
STA VAR_TM%+1
;
LINE_SKIP53:
;
;
LINE_8210:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_C$
LDY #>VAR_C$
JSR COPYSTRING
LDA #<CONST_33
LDY #>CONST_33
STA B_REG
STY B_REG+1
LDA VAR_C$
LDY VAR_C$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP15:
BEQ LINE_SKIP54
; Simplified conditional branch
;
LINE_NSKIP54:
;
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR RUN
;
LINE_SKIP54:
;
;
LINE_8220:
;
JMP LINE_8000
;
LINE_10000:
;
;
LINE_10010:
;
LDA #<CONST_34
LDY #>CONST_34
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
;
LINE_10020:
;
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
LINE_10040:
;
LDX #4
dcloop1563_1:
LDA CONST_37,X
STA VAR_P,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_38
LDY #>CONST_38
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_3R
LDY #>CONST_3R
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
LDA #<VAR_P
LDY #>VAR_P
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDY #$00
STY TMP_ZP
LDA #$20
STA TMP_ZP+1
LDA #<VAR_P
LDY #>VAR_P
JSR INTADDPOKE
STY MOVBSELF22+1
STA MOVBSELF22+2
; Fast add for POKE(1)
;
;
;
;
;
JSR POPREAL
JSR FACWORD
STY MOVBSELF23+1
STA MOVBSELF23+2
MOVBSELF22:
LDY $FFFF
MOVBSELF23:
STY $FFFF
; Optimizer rule: Fast byte copy/8
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
LINE_10050:
;
LDA #<CONST_3R
LDY #>CONST_3R
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
;
LINE_10060:
;
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
JMP RETURN
;
LINE_10200:
;
;
LINE_10210:
;
LDA #<VAR_AX%[]
LDY #>VAR_AX%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
LDY VAR_FX%
LDA VAR_FX%+1
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_FX%
STA VAR_FX%+1
;
LINE_10220:
;
LDA #<VAR_AY%[]
LDY #>VAR_AY%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
LDY VAR_FY%
LDA VAR_FY%+1
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_FY%
STA VAR_FY%+1
;
LINE_10230:
;
LDY VAR_FY%
STY 53249
LINE_10240:
; Optimizer rule: Remove unneeded LDA calls(2)/3
;
LDA #<CONST_24R
LDY #>CONST_24R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_FX%
LDA VAR_FX%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 53248
;
LINE_10250:
;
LDA #$ff
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_FX%
LDA VAR_FX%+1
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = FAC * -1
JSR NEG
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 53264
;
LINE_10260:
;
JMP RETURN
;
LINE_10400:
;
;
LINE_10410:
;
LDA #<VAR_AX%[]
LDY #>VAR_AX%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
LDY VAR_FX%
LDA VAR_FX%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_FX%
STA VAR_FX%+1
;
LINE_10420:
;
LDA #<VAR_AY%[]
LDY #>VAR_AY%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
LDY VAR_FY%
LDA VAR_FY%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACINT
STY VAR_FY%
STA VAR_FY%+1
;
LINE_10430:
;
JSR GOSUB
JSR LINE_10230
JMP RETURN
;
LINE_11000:
;
;
LINE_11010:
;
JSR GOSUB
JSR LINE_12000
;
LINE_11020:
;
LDY #208
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_FX%
STA VAR_FX%+1
LDY #74
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_FY%
STA VAR_FY%+1
;
LINE_11030:
;
LDX #4
dcloop1895_1:
LDA CONST_42,X
STA VAR_PO,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_11040:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_DI%
STA VAR_DI%+1
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_PO
LDY #>VAR_PO
JSR INTADDPOKE
STY MOVBSELF29+1
STA MOVBSELF29+2
; Fast add for POKE(2)
;
;
;
;
MOVBSELF29:
LDA $FFFF
CMP #32
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
EQ_EQ13:
EQ_SKIP13:
COMP_SKP17:
BNE LINE_SKIP55
LINE_NSKIP55:
; Optimizer rule: Simplified equal comparison/6
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_DI%
STA VAR_DI%+1
;
LINE_SKIP55:
;
;
LINE_11050:
;
LDY VAR_FX%
STY 53248
; Optimizer rule: Remove unneeded LDA calls(1)/2
LDY VAR_FY%
STY 53249
; Optimizer rule: Remove unneeded LDA calls(1)/2
LDY VAR_DI%
STY 34808
; Optimizer rule: Remove unneeded LDA calls(1)/2
LDY #1
STY 53269
; Optimizer rule: Simple POKE/2
;
LINE_11060:
;
LDY #7
STY 53287
; Optimizer rule: Simple POKE/2
;
LINE_11070:
;
JSR GOSUB
JSR LINE_14000
;
LINE_11080:
;
JMP RETURN
;
LINE_12000:
;
;
LINE_12010:
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
LDY #0
TYA
STY VAR_I%
STA VAR_I%+1
STY VAR_X%
STA VAR_X%+1
; Optimizer rule: Accumulate integer loads/6
LDA #0
STA VAR_P
STA VAR_P+1
STA VAR_P+2
STA VAR_P+3
STA VAR_P+4
; Optimizer rule: Simplified setting to 0/6
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_K%
STA VAR_K%+1
;
LINE_12020:
;
LDY #2
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_D%[]
LDY #>VAR_D%[]
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
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_43
LDY #>CONST_43
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D%[]
LDY #>VAR_D%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_44
LDY #>CONST_44
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D%[]
LDY #>VAR_D%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #80
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_D%[]
LDY #>VAR_D%[]
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
LINE_12030:
;
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_D2%[]
LDY #>VAR_D2%[]
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
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_12
LDY #>CONST_12
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D2%[]
LDY #>VAR_D2%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<CONST_4R
LDY #>CONST_4R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_14
LDY #>CONST_14
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_D2%[]
LDY #>VAR_D2%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #40
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_D2%[]
LDY #>VAR_D2%[]
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
LINE_12040:
;
LDX #4
dcloop2227_1:
LDA CONST_46,X
STA VAR_P,X
DEX
BPL dcloop2227_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_47R
LDY #>CONST_47R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_I%
STA VAR_I%+1
;
LINE_12050:
;
LDX #4
dcloop2227_2:
LDA VAR_P,X
STA VAR_PA,X
DEX
BPL dcloop2227_2
; Optimizer rule: Direct copy of floats into mem/6
LDY #45
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_V%
STA VAR_V%+1
LDY #17
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
JSR GOSUB
JSR LINE_13000
;
LINE_12060:
;
LDA #<CONST_49R
LDY #>CONST_49R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PA
LDY #>VAR_PA
; FAC to (X/Y)
JSR FACMEM
LDY #9
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_V%
STA VAR_V%+1
LDY #17
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
JSR GOSUB
JSR LINE_13000
;
LINE_12070:
;
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_P
LDY #>VAR_P
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
LDY VAR_I%
LDA VAR_I%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_I%
STA VAR_I%+1
LDA #$16
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_I%
LDA VAR_I%+1
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
BEQ LT_LT_EQ14
ROL
BCC LT_LT14
LT_LT_EQ14:
LDA #0
JMP LT_SKIP14
LT_LT14:
LDA #$1
LT_SKIP14:
COMP_SKP18:
BEQ LINE_SKIP56
; Simplified conditional branch
;
LINE_NSKIP56:
;
JMP LINE_12050
;
LINE_SKIP56:
;
;
LINE_12080:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
LDA #<CONST_49R
LDY #>CONST_49R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF35+1
STA MOVBSELF35+2
LDA #$0
MOVBSELF35:
STA $FFFF
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF36+1
STA MOVBSELF36+2
LDA #$4
MOVBSELF36:
STA $FFFF
;
LINE_12090:
;
LDA #<CONST_52
LDY #>CONST_52
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #3
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACINT
STY VAR_K%
STA VAR_K%+1
LDA #<VAR_D%[]
LDY #>VAR_D%[]
STA G_REG
STY G_REG+1
LDY VAR_K%
LDA VAR_K%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF37+1
STA MOVBSELF37+2
MOVBSELF37:
LDY $FFFF
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
;
LINE_12100:
;
LDA #$2d
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_C%
LDA VAR_C%+1
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
NEQ_NEQ15:
NEQ_SKIP15:
COMP_SKP19:
BEQ LINE_SKIP57
LINE_NSKIP57:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_12150
;
LINE_SKIP57:
;
;
LINE_12110:
;
LDY #$00
STY TMP_ZP
LDA #$54
STA TMP_ZP+1
LDA #<VAR_B
LDY #>VAR_B
JSR INTADDPOKE
STY MOVBSELF38+1
STA MOVBSELF38+2
; Fast add for POKE(1)
;
;
;
;
;
LDA #$0
MOVBSELF38:
STA $FFFF
LDA #<VAR_B
LDY #>VAR_B
JSR REALFAC
; Optimizer rule: Remove FAC/PUSH/POP/1
JSR FACWORD
STY MOVBSELF39+1
STA MOVBSELF39+2
LDY VAR_K%
MOVBSELF39:
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
LDA #<VAR_D2%[]
LDY #>VAR_D2%[]
STA G_REG
STY G_REG+1
LDY VAR_K%
LDA VAR_K%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF40+1
STA MOVBSELF40+2
LDA #$20
MOVBSELF40:
STA $FFFF
LDX #4
dcloop2393_1:
LDA VAR_B,X
STA VAR_A,X
DEX
BPL dcloop2393_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_12120:
;
LDA #<CONST_52
LDY #>CONST_52
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #3
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACINT
STY VAR_K%
STA VAR_K%+1
LDA #<VAR_D%[]
LDY #>VAR_D%[]
STA G_REG
STY G_REG+1
LDY VAR_K%
LDA VAR_K%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF41+1
STA MOVBSELF41+2
MOVBSELF41:
LDY $FFFF
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
;
LINE_12130:
;
JMP LINE_12100
;
LINE_12150:
;
LDY VAR_K%
LDA VAR_K%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_X%
STA VAR_X%+1
LDY VAR_K%
LDA VAR_K%+1
JSR SUPERFIINX
AND #$00
TAX
TYA
AND #$03
TAY
TXA
; Optimized code for +1 AND/OR
;
;
;
;
;
;
;
STY VAR_K%
STA VAR_K%+1
;
LINE_12160:
;
LDY VAR_X%
LDA VAR_X%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_K%
LDA VAR_K%+1
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
EQ_EQ16:
EQ_SKIP16:
COMP_SKP20:
BNE LINE_SKIP58
LINE_NSKIP58:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_12250
;
LINE_SKIP58:
;
;
LINE_12170:
;
LDA #<VAR_D%[]
LDY #>VAR_D%[]
STA G_REG
STY G_REG+1
LDY VAR_K%
LDA VAR_K%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
JSR FACMEM
; Optimizer rule: Omit FAC load/4
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF42+1
STA MOVBSELF42+2
MOVBSELF42:
LDY $FFFF
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
;
LINE_12180:
;
LDA #$2d
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_C%
LDA VAR_C%+1
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
NEQ_NEQ17:
NEQ_SKIP17:
COMP_SKP21:
BEQ LINE_SKIP59
LINE_NSKIP59:
; Optimizer rule: Simplified not equal comparison/6
;
LDY VAR_K%
LDA VAR_K%+1
JSR SUPERFIINX
AND #$00
TAX
TYA
AND #$03
TAY
TXA
; Optimized code for +1 AND/OR
;
;
;
;
;
;
;
STY VAR_K%
STA VAR_K%+1
JMP LINE_12200
;
LINE_SKIP59:
;
;
LINE_12190:
;
LDY #$00
STY TMP_ZP
LDA #$54
STA TMP_ZP+1
LDA #<VAR_B
LDY #>VAR_B
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
LDA #<VAR_B
LDY #>VAR_B
JSR REALFAC
; Optimizer rule: Remove FAC/PUSH/POP/1
JSR FACWORD
STY MOVBSELF44+1
STA MOVBSELF44+2
LDY VAR_K%
MOVBSELF44:
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
LDA #<VAR_D2%[]
LDY #>VAR_D2%[]
STA G_REG
STY G_REG+1
LDY VAR_K%
LDA VAR_K%+1
JSR ARRAYACCESS_INTEGER_INT
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
JSR FACWORD
JSR OPT_POKE_ADD
STY MOVBSELF45+1
STA MOVBSELF45+2
; Optimized code for POKE/PEEK with addition(2)
;
;
;
;
;
;
;
;
;
LDA #$20
MOVBSELF45:
STA $FFFF
LDX #4
dcloop2725_1:
LDA VAR_B,X
STA VAR_A,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_12250
;
LINE_12200:
;
JMP LINE_12160
;
LINE_12250:
;
LDY VAR_X%
LDA VAR_X%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_K%
LDA VAR_K%+1
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
NEQ_NEQ18:
NEQ_SKIP18:
COMP_SKP22:
BEQ LINE_SKIP60
LINE_NSKIP60:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_12300
;
LINE_SKIP60:
;
;
LINE_12260:
;
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF46+1
STA MOVBSELF46+2
MOVBSELF46:
LDY $FFFF
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_K%
STA VAR_K%+1
LDA #<VAR_A
LDY #>VAR_A
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF47+1
STA MOVBSELF47+2
LDA #$20
MOVBSELF47:
STA $FFFF
;
LINE_12270:
;
LDA #$04
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_K%
LDA VAR_K%+1
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
BNE NEQ_NEQ19
LDA #0
JMP NEQ_SKIP19
NEQ_NEQ19:
LDA #$1
NEQ_SKIP19:
COMP_SKP23:
BNE LINE_NSKIP61
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP61
;
LINE_NSKIP61:
;
LDA #<VAR_D%[]
LDY #>VAR_D%[]
STA G_REG
STY G_REG+1
LDY VAR_K%
LDA VAR_K%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
JSR XREGFAC
LDA #<VAR_A
LDY #>VAR_A
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
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP61:
;
;
LINE_12300:
;
LDA #$04
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_K%
LDA VAR_K%+1
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
NEQ_NEQ20:
NEQ_SKIP20:
COMP_SKP24:
BEQ LINE_SKIP62
LINE_NSKIP62:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_12090
;
LINE_SKIP62:
;
;
LINE_12310:
;
JMP RETURN
;
LINE_13000:
;
;
LINE_13040:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KK%
STA VAR_KK%+1
;
LINE_13050:
;
LDA #<VAR_PA
LDY #>VAR_PA
JSR REALFAC
; Optimizer rule: Remove FAC/PUSH/POP/1
JSR FACWORD
STY MOVBSELF48+1
STA MOVBSELF48+2
LDY VAR_V%
MOVBSELF48:
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
LDY VAR_KK%
LDA VAR_KK%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KK%
STA VAR_KK%+1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_PA
LDY #>VAR_PA
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PA
LDY #>VAR_PA
; FAC to (X/Y)
JSR FACMEM
;
LINE_13060:
;
LDY VAR_C%
LDA VAR_C%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KK%
LDA VAR_KK%+1
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
BEQ LT_LT_EQ21
ROL
BCC LT_LT21
LT_LT_EQ21:
LDA #0
JMP LT_SKIP21
LT_LT21:
LDA #$1
LT_SKIP21:
COMP_SKP25:
BEQ LINE_SKIP63
; Simplified conditional branch
;
LINE_NSKIP63:
;
JMP LINE_13050
;
LINE_SKIP63:
;
;
LINE_13070:
;
JMP RETURN
;
LINE_14000:
;
;
LINE_14010:
;
LDY #0
TYA
STY VAR_K%
STA VAR_K%+1
STY VAR_Z%
STA VAR_Z%+1
; Optimizer rule: Accumulate integer loads/6
LDX #4
dcloop3057_1:
LDA VAR_PO,X
STA VAR_P,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_14020:
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
BEQ GTEQ_GTEQ22
BCS GTEQ_GTEQ22
LDA #0
JMP GTEQ_SKIP22
GTEQ_GTEQ22:
LDA #$1
GTEQ_SKIP22:
COMP_SKP26:
BEQ LINE_SKIP64
; Simplified conditional branch
;
LINE_NSKIP64:
;
JMP LINE_14200
;
LINE_SKIP64:
;
;
LINE_14030:
;
LDA #<VAR_P
LDY #>VAR_P
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF49+1
STA MOVBSELF49+2
MOVBSELF49:
LDA $FFFF
CMP #45
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
EQ_EQ23:
EQ_SKIP23:
COMP_SKP27:
BNE LINE_SKIP65
LINE_NSKIP65:
; Optimizer rule: Simplified equal comparison/6
;
LDY VAR_Z%
LDA VAR_Z%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_IQ%
STA VAR_IQ%+1
LDY #45
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_CQ%
STA VAR_CQ%+1
JSR GOSUB
JSR LINE_15000
JMP LINE_14200
;
LINE_SKIP65:
;
;
LINE_14040:
;
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
STA G_REG
STY G_REG+1
LDY VAR_Z%
LDA VAR_Z%+1
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_K%
STA VAR_K%+1
; Optimizer rule: Fast INTEGER array access (2)/3
;
LINE_14050:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_K%
LDA VAR_K%+1
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
BEQ LT_LT_EQ24
ROL
BCC LT_LT24
LT_LT_EQ24:
LDA #0
JMP LT_SKIP24
LT_LT24:
LDA #$1
LT_SKIP24:
COMP_SKP28:
BEQ LINE_SKIP66
; Simplified conditional branch
;
LINE_NSKIP66:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_K%
STA VAR_K%+1
;
LINE_SKIP66:
;
;
LINE_14070:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_LH%
STA VAR_LH%+1
LDA #<VAR_LO%[]
LDY #>VAR_LO%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
LDA #<VAR_P
LDY #>VAR_P
JSR REALFAC
JSR FACWORD
JSR OPT_POKE_ADD
STY MOVBSELF50+1
STA MOVBSELF50+2
; Optimized code for POKE/PEEK with addition(2)
;
;
;
;
;
;
;
;
;
MOVBSELF50:
LDA $FFFF
CMP #32
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
EQ_EQ25:
EQ_SKIP25:
COMP_SKP29:
BNE LINE_SKIP67
LINE_NSKIP67:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
STA G_REG
STY G_REG+1
LDY VAR_Z%
LDA VAR_Z%+1
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_LH%
STA VAR_LH%+1
; Optimizer rule: Fast INTEGER array access (2)/3
;
LINE_SKIP67:
;
;
LINE_14080:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_RH%
STA VAR_RH%+1
LDA #<VAR_RO%[]
LDY #>VAR_RO%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
LDA #<VAR_P
LDY #>VAR_P
JSR REALFAC
JSR FACWORD
JSR OPT_POKE_ADD
STY MOVBSELF51+1
STA MOVBSELF51+2
; Optimized code for POKE/PEEK with addition(2)
;
;
;
;
;
;
;
;
;
MOVBSELF51:
LDA $FFFF
CMP #32
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
EQ_EQ26:
EQ_SKIP26:
COMP_SKP30:
BNE LINE_SKIP68
LINE_NSKIP68:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
STA G_REG
STY G_REG+1
LDY VAR_Z%
LDA VAR_Z%+1
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_RH%
STA VAR_RH%+1
; Optimizer rule: Fast INTEGER array access (2)/3
;
LINE_SKIP68:
;
;
LINE_14090:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_K%
LDA VAR_K%+1
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
BEQ LT_LT_EQ27
ROL
BCC LT_LT27
LT_LT_EQ27:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP27
LT_LT27:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP27:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
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
BEQ GTEQ_GTEQ28
BCS GTEQ_GTEQ28
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GTEQ_SKIP28
GTEQ_GTEQ28:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GTEQ_SKIP28:
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
COMP_SKP31:
BEQ LINE_SKIP69
; Simplified conditional branch
;
LINE_NSKIP69:
;
JMP LINE_14160
;
LINE_SKIP69:
;
;
LINE_14100:
;
LDY VAR_Z%
LDA VAR_Z%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_IQ%
STA VAR_IQ%+1
JSR GOSUB
JSR LINE_16000
;
LINE_14110:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_RH%
LDA VAR_RH%+1
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
COMP_SKP32:
BEQ LINE_SKIP70
; Simplified conditional branch
;
LINE_NSKIP70:
;
LDY VAR_RH%
LDA VAR_RH%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_RH%
STA VAR_RH%+1
;
LINE_SKIP70:
;
;
LINE_14120:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_LH%
LDA VAR_LH%+1
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
COMP_SKP33:
BEQ LINE_SKIP71
; Simplified conditional branch
;
LINE_NSKIP71:
;
LDY VAR_LH%
LDA VAR_LH%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_LH%
STA VAR_LH%+1
;
LINE_SKIP71:
;
;
LINE_14130:
;
LDY VAR_Z%
LDA VAR_Z%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_Z%
STA VAR_Z%+1
;
LINE_14140:
;
LDY VAR_K%
LDA VAR_K%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_K%
STA VAR_K%+1
;
LINE_14150:
;
JMP LINE_14090
;
LINE_14160:
;
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
STA G_REG
STY G_REG+1
LDY VAR_DI%
LDA VAR_DI%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
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
LDX #<VAR_P
LDY #>VAR_P
; FAC to (X/Y)
JSR FACMEM
;
LINE_14170:
;
JMP LINE_14020
;
LINE_14200:
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
BEQ GTEQ_GTEQ31
BCS GTEQ_GTEQ31
LDA #0
JMP GTEQ_SKIP31
GTEQ_GTEQ31:
LDA #$1
GTEQ_SKIP31:
COMP_SKP34:
BEQ LINE_SKIP72
; Simplified conditional branch
;
LINE_NSKIP72:
;
LDY VAR_Z%
LDA VAR_Z%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_IQ%
STA VAR_IQ%+1
LDY #40
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_CQ%
STA VAR_CQ%+1
JSR GOSUB
JSR LINE_15000
;
LINE_SKIP72:
;
;
LINE_14210:
;
JMP RETURN
;
LINE_15000:
;
;
LINE_15020:
;
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_IQ%
LDA VAR_IQ%+1
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
LDA #<VAR_MV[]
LDY #>VAR_MV[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDY VAR_IQ%
LDA VAR_IQ%+1
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
LDX #<VAR_PJ
LDY #>VAR_PJ
; FAC to (X/Y)
JSR FACMEM
;
LINE_15030:
;
LDY VAR_IQ%
LDA VAR_IQ%+1
JSR INTFAC
LDA #<CONST_54R
LDY #>CONST_54R
JSR COPY2_XYA_XREG
; Optimizer rule: Omit Y_REG/6
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_IQ%
LDA VAR_IQ%+1
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_LJ%
STA VAR_LJ%+1
;
LINE_15040:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
LDY VAR_LJ%
LDA VAR_LJ%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
LDY VAR_CQ%
LDA VAR_CQ%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_V%
STA VAR_V%+1
;
LINE_15050:
;
LDX #4
dcloop3721_1:
LDA VAR_PJ,X
STA VAR_PA,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_13000
;
LINE_15060:
;
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
LDY VAR_LJ%
LDA VAR_LJ%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCS GT_GT32
LDA #0
JMP GT_SKIP32
GT_GT32:
LDA #$1
GT_SKIP32:
COMP_SKP35:
BEQ LINE_SKIP73
; Simplified conditional branch
;
LINE_NSKIP73:
;
JMP RETURN
;
LINE_SKIP73:
;
;
LINE_15070:
;
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PJ
LDY #>VAR_PJ
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PJ
LDY #>VAR_PJ
; FAC to (X/Y)
JSR FACMEM
JMP LINE_15050
;
LINE_16000:
;
;
LINE_16020:
;
LDY #$00
LDA #$02
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_IQ%
LDA VAR_IQ%+1
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
LDA #<VAR_MV[]
LDY #>VAR_MV[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDY VAR_IQ%
LDA VAR_IQ%+1
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
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
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
;
LINE_16030:
;
LDY VAR_IQ%
LDA VAR_IQ%+1
JSR INTFAC
LDA #<CONST_55R
LDY #>CONST_55R
JSR COPY2_XYA_XREG
; Optimizer rule: Omit Y_REG/6
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDY VAR_IQ%
LDA VAR_IQ%+1
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_LQ%
STA VAR_LQ%+1
;
LINE_16040:
;
LDX #4
dcloop3887_1:
LDA VAR_PQ,X
STA VAR_PA,X
DEX
BPL dcloop3887_1
; Optimizer rule: Direct copy of floats into mem/6
LDY #34
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_V%
STA VAR_V%+1
LDY VAR_LQ%
LDA VAR_LQ%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
JSR GOSUB
JSR LINE_13000
LDX #4
dcloop3887_2:
LDA VAR_PA,X
STA VAR_PQ,X
DEX
BPL dcloop3887_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_16050:
;
LDY VAR_RH%
LDA VAR_RH%+1
; integer in Y/A to FAC
STY Y_REG
ORA Y_REG
COMP_SKP36:
BEQ LINE_SKIP74
; Optimizer rule: Simpler IF <int> THEN/4
; Simplified conditional branch
;
LINE_NSKIP74:
;
JSR GOSUB
JSR LINE_16200
JMP LINE_16080
;
LINE_SKIP74:
;
;
LINE_16060:
;
JSR GOSUB
JSR LINE_16400
;
LINE_16080:
;
LDY VAR_LQ%
LDA VAR_LQ%+1
JSR INTFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR COPY2_XYA_XREG
; Optimizer rule: Omit Y_REG/6
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop3887_3:
LDA VAR_PQ,X
STA VAR_PA,X
DEX
BPL dcloop3887_3
; Optimizer rule: Direct copy of floats into mem/6
LDY VAR_LQ%
LDA VAR_LQ%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_C%
STA VAR_C%+1
LDY #34
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_V%
STA VAR_V%+1
JSR GOSUB
JSR LINE_13000
;
LINE_16090:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_LH%
LDA VAR_LH%+1
; integer in Y/A to FAC
STY Y_REG
ORA Y_REG
COMP_SKP37:
BEQ LINE_SKIP75
; Optimizer rule: Simpler IF <int> THEN/4
; Simplified conditional branch
;
LINE_NSKIP75:
;
JSR GOSUB
JSR LINE_16500
JMP LINE_16110
;
LINE_SKIP75:
;
;
LINE_16100:
;
JSR GOSUB
JSR LINE_16700
;
LINE_16110:
;
JMP RETURN
;
LINE_16200:
;
;
LINE_16210:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF52+1
STA MOVBSELF52+2
LDA #$27
MOVBSELF52:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY #2
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16220:
;
LDY VAR_RH%
LDA VAR_RH%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCS GT_GT33
LDA #0
JMP GT_SKIP33
GT_GT33:
LDA #$1
GT_SKIP33:
COMP_SKP38:
BEQ LINE_SKIP76
; Simplified conditional branch
;
LINE_NSKIP76:
;
JMP LINE_16240
;
LINE_SKIP76:
;
;
LINE_16225:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF53+1
STA MOVBSELF53+2
LDA #$28
MOVBSELF53:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16230:
;
JMP LINE_16220
;
LINE_16240:
;
LDY VAR_RH%
LDA VAR_RH%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
LDY VAR_LQ%
LDA VAR_LQ%+1
STY TMP3_ZP
STA TMP3_ZP+1
LDY VAR_RH%
LDA VAR_RH%+1
JSR INTSUBVAR
; Optimized code for adding/subtracting INT variables
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
STY VAR_EQ%
STA VAR_EQ%+1
;
LINE_16250:
;
LDY VAR_EQ%
LDA VAR_EQ%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCS GT_GT34
LDA #0
JMP GT_SKIP34
GT_GT34:
LDA #$1
GT_SKIP34:
COMP_SKP39:
BEQ LINE_SKIP77
; Simplified conditional branch
;
LINE_NSKIP77:
;
JMP LINE_16270
;
LINE_SKIP77:
;
;
LINE_16255:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF54+1
STA MOVBSELF54+2
LDA #$22
MOVBSELF54:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16260:
;
JMP LINE_16250
;
LINE_16270:
;
LDY #2
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16280:
;
LDY VAR_RH%
LDA VAR_RH%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCS GT_GT35
LDA #0
JMP GT_SKIP35
GT_GT35:
LDA #$1
GT_SKIP35:
COMP_SKP40:
BEQ LINE_SKIP78
; Simplified conditional branch
;
LINE_NSKIP78:
;
JMP LINE_16300
;
LINE_SKIP78:
;
;
LINE_16285:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF55+1
STA MOVBSELF55+2
LDA #$28
MOVBSELF55:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16290:
;
JMP LINE_16280
;
LINE_16300:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF56+1
STA MOVBSELF56+2
LDA #$2A
MOVBSELF56:
STA $FFFF
JMP RETURN
;
LINE_16400:
;
;
LINE_16410:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF57+1
STA MOVBSELF57+2
LDA #$23
MOVBSELF57:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
;
LINE_16420:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16430:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF58+1
STA MOVBSELF58+2
LDA #$24
MOVBSELF58:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
LDY VAR_LQ%
LDA VAR_LQ%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCC LTEQ_LTEQ36
BEQ LTEQ_LTEQ36
LDA #0
JMP LTEQ_SKIP36
LTEQ_LTEQ36:
LDA #$1
LTEQ_SKIP36:
COMP_SKP41:
BEQ LINE_SKIP79
; Simplified conditional branch
;
LINE_NSKIP79:
;
JMP LINE_16430
;
LINE_SKIP79:
;
;
LINE_16450:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF59+1
STA MOVBSELF59+2
LDA #$25
MOVBSELF59:
STA $FFFF
JMP RETURN
;
LINE_16500:
;
;
LINE_16510:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF60+1
STA MOVBSELF60+2
LDA #$2B
MOVBSELF60:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY #2
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16520:
;
LDY VAR_LH%
LDA VAR_LH%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCS GT_GT37
LDA #0
JMP GT_SKIP37
GT_GT37:
LDA #$1
GT_SKIP37:
COMP_SKP42:
BEQ LINE_SKIP80
; Simplified conditional branch
;
LINE_NSKIP80:
;
JMP LINE_16540
;
LINE_SKIP80:
;
;
LINE_16525:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF61+1
STA MOVBSELF61+2
LDA #$28
MOVBSELF61:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16530:
;
JMP LINE_16520
;
LINE_16540:
;
LDY VAR_LH%
LDA VAR_LH%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
LDY VAR_LQ%
LDA VAR_LQ%+1
STY TMP3_ZP
STA TMP3_ZP+1
LDY VAR_LH%
LDA VAR_LH%+1
JSR INTSUBVAR
; Optimized code for adding/subtracting INT variables
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
STY VAR_EQ%
STA VAR_EQ%+1
;
LINE_16550:
;
LDY VAR_EQ%
LDA VAR_EQ%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCS GT_GT38
LDA #0
JMP GT_SKIP38
GT_GT38:
LDA #$1
GT_SKIP38:
COMP_SKP43:
BEQ LINE_SKIP81
; Simplified conditional branch
;
LINE_NSKIP81:
;
JMP LINE_16570
;
LINE_SKIP81:
;
;
LINE_16555:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF62+1
STA MOVBSELF62+2
LDA #$22
MOVBSELF62:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16560:
;
JMP LINE_16550
;
LINE_16570:
;
LDY #2
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16580:
;
LDY VAR_LH%
LDA VAR_LH%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCS GT_GT39
LDA #0
JMP GT_SKIP39
GT_GT39:
LDA #$1
GT_SKIP39:
COMP_SKP44:
BEQ LINE_SKIP82
; Simplified conditional branch
;
LINE_NSKIP82:
;
JMP LINE_16600
;
LINE_SKIP82:
;
;
LINE_16585:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF63+1
STA MOVBSELF63+2
LDA #$28
MOVBSELF63:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16590:
;
JMP LINE_16580
;
LINE_16600:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF64+1
STA MOVBSELF64+2
LDA #$2C
MOVBSELF64:
STA $FFFF
JMP RETURN
;
LINE_16700:
;
;
LINE_16710:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF65+1
STA MOVBSELF65+2
LDA #$26
MOVBSELF65:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
;
LINE_16720:
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_KQ%
STA VAR_KQ%+1
;
LINE_16730:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF66+1
STA MOVBSELF66+2
LDA #$24
MOVBSELF66:
STA $FFFF
LDA #<CONST_13R
LDY #>CONST_13R
JSR REALFAC
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_PQ
LDY #>VAR_PQ
; FAC to (X/Y)
JSR FACMEM
LDY VAR_KQ%
LDA VAR_KQ%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_KQ%
STA VAR_KQ%+1
LDY VAR_LQ%
LDA VAR_LQ%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_KQ%
LDA VAR_KQ%+1
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
BCC LTEQ_LTEQ40
BEQ LTEQ_LTEQ40
LDA #0
JMP LTEQ_SKIP40
LTEQ_LTEQ40:
LDA #$1
LTEQ_SKIP40:
COMP_SKP45:
BEQ LINE_SKIP83
; Simplified conditional branch
;
LINE_NSKIP83:
;
JMP LINE_16730
;
LINE_SKIP83:
;
;
LINE_16750:
;
LDA #<VAR_PQ
LDY #>VAR_PQ
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF67+1
STA MOVBSELF67+2
LDA #$21
MOVBSELF67:
STA $FFFF
JMP RETURN
;
LINE_60000:
;
;
LINE_60010:
;
;
LINE_60020:
;
;
LINE_60030:
;
;
LINE_60040:
;
;
LINE_60050:
;
;
LINE_60060:
;
;
LINE_60070:
;
;
LINE_60100:
;
;
LINE_60110:
;
;
LINE_60120:
;
;
LINE_60130:
;
;
LINE_60140:
;
;
LINE_60150:
;
;
LINE_60160:
;
;
LINE_60170:
;
;
LINE_60180:
;
;
LINE_60190:
;
;
LINE_60200:
;
;
LINE_60210:
;
;
LINE_60220:
;
;
LINE_60230:
;
;
LINE_60240:
;
;
LINE_60250:
;
;
LINE_60260:
;
;
LINE_60300:
;
;
LINE_60310:
;
;
LINE_60320:
;
;
LINE_60330:
;
;
LINE_60340:
;
;
LINE_60350:
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
INTSUBVAROPT
LDX #0			; Mark as "further int opt possible"
BEQ INTSUBSUB
INTSUBVAR	LDX #1
INTSUBSUB	STX INT_FLAG
LDX #128		; Do the fast way for positive numbers  below 16384...second var
STX TMP_REG
BIT TMP_REG
BEQ INTSUBVARC2
JMP FLOATINTSUB
INTSUBVARC2
LDX #64
STX TMP_REG
BIT TMP_REG
BEQ INTSUBVARC3
JMP FLOATINTSUB
INTSUBVARC3
PHA
LDA TMP3_ZP+1
LDX #128		; Do the fast way for everything positive...first var
STX TMP_REG
BIT TMP_REG
BEQ INTINTSUBVAR2
PLA
JMP FLOATINTSUB
INTINTSUBVAR2
LDX #1
STX TMP_FLAG
TYA
STA TMP_REG
PLA
STA TMP_REG+1
LDA TMP3_ZP
SEC
SBC TMP_REG
TAY
LDA TMP3_ZP+1
SBC TMP_REG+1
STY TMP2_ZP
STA TMP2_ZP+1
LDX INT_FLAG
BNE INTSUBVAREND
RTS
INTSUBVAREND
JMP INTFAC
;###################################
;###################################
;	A=B-C => TMP3_ZP - LDY/LDA
FLOATINTSUB	JSR INTFAC
JSR FACXREG
LDA #0
STA TMP_FLAG	; flag that the value isn't present in TMP2_ZP
LDY TMP3_ZP
LDA TMP3_ZP+1
JSR INTFAC
JSR FACARG
JSR XREGFAC
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
OPT_POKE_ADD
CLC
TAX
TYA
ADC TMP2_ZP
TAY
TXA
ADC TMP2_ZP+1
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
CLRCHNEW
LDA CHLOCKFLAG
BNE SKIPCLRCH
JMP CLRCH
SKIPCLRCH
RTS
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
STA VAR_PO,Y
STA VAR_I,Y
STA VAR_V,Y
STA VAR_P,Y
STA VAR_A,Y
STA VAR_B,Y
STA VAR_PA,Y
STA VAR_PJ,Y
STA VAR_PQ,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
STA VAR_WL%
STA VAR_WL%+1
STA VAR_HL%
STA VAR_HL%+1
STA VAR_JY%
STA VAR_JY%+1
STA VAR_JU%
STA VAR_JU%+1
STA VAR_JD%
STA VAR_JD%+1
STA VAR_JL%
STA VAR_JL%+1
STA VAR_JR%
STA VAR_JR%+1
LDA #<VAR_WD%[]
LDY #>VAR_WD%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_LO%[]
LDY #>VAR_LO%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_RO%[]
LDY #>VAR_RO%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_AO%[]
LDY #>VAR_AO%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_AX%[]
LDY #>VAR_AX%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_AY%[]
LDY #>VAR_AY%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_FX%
STA VAR_FX%+1
STA VAR_FY%
STA VAR_FY%+1
STA VAR_DI%
STA VAR_DI%+1
STA VAR_B%
STA VAR_B%+1
LDA #<VAR_MV[]
LDY #>VAR_MV[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_J%
STA VAR_J%+1
STA VAR_PJ%
STA VAR_PJ%+1
STA VAR_TM%
STA VAR_TM%+1
STA VAR_I%
STA VAR_I%+1
STA VAR_X%
STA VAR_X%+1
STA VAR_K%
STA VAR_K%+1
LDA #<VAR_D%[]
LDY #>VAR_D%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #<VAR_D2%[]
LDY #>VAR_D2%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_V%
STA VAR_V%+1
STA VAR_C%
STA VAR_C%+1
STA VAR_KK%
STA VAR_KK%+1
STA VAR_Z%
STA VAR_Z%+1
STA VAR_IQ%
STA VAR_IQ%+1
STA VAR_CQ%
STA VAR_CQ%+1
STA VAR_LH%
STA VAR_LH%+1
STA VAR_RH%
STA VAR_RH%+1
STA VAR_LJ%
STA VAR_LJ%+1
STA VAR_KQ%
STA VAR_KQ%+1
STA VAR_LQ%
STA VAR_LQ%+1
STA VAR_EQ%
STA VAR_EQ%+1
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #45


; CONST: #32


; CONST: #100


; CONST: #1

CONST_3R	.REAL 1.0
; CONST: #2

CONST_4R	.REAL 2.0
; CONST: #4


; CONST: #8


; CONST: #0

CONST_7R	.REAL 0.0
; CONST: #3

CONST_8R	.REAL 3.0
; CONST: #5


; CONST: #6


; CONST: #7


; CONST: #-40.0

CONST_12	.REAL -40.0
; CONST: #40

CONST_13R	.REAL 40.0
; CONST: #-1.0

CONST_14	.REAL -1.0
; CONST: #-8.0

CONST_15	.REAL -8.0
; CONST: $


; CONST: #56576

CONST_17	.REAL 56576
; CONST: #252


; CONST: #132


; CONST: #53272


; CONST: #14


; CONST: #103

CONST_22R	.REAL 103.0
; CONST: #47368

CONST_23	.REAL 47368
; CONST: #255

CONST_24R	.REAL 255.0
; CONST: #32768

CONST_25	.REAL 32768
; CONST: #24

CONST_26R	.REAL 24.0
; CONST: #128


; CONST: #147


; CONST: #53270


; CONST: #16


; CONST: #15


; CONST: #56320

CONST_32	.REAL 56320
; CONST: $
CONST_33	.BYTE 1
.STRG " "
; CONST: #56334

CONST_34	.REAL 56334
; CONST: #254


; CONST: #251


; CONST: #47104

CONST_37	.REAL 47104
; CONST: #49151.0

CONST_38	.REAL 49151.0
; CONST: #8192


; CONST: #208


; CONST: #74


; CONST: #33935

CONST_42	.REAL 33935
; CONST: #-80.0

CONST_43	.REAL -80.0
; CONST: #-2.0

CONST_44	.REAL -2.0
; CONST: #80


; CONST: #33894

CONST_46	.REAL 33894
; CONST: #41

CONST_47R	.REAL 41.0
; CONST: #17


; CONST: #21504

CONST_49R	.REAL 21504.0
; CONST: #9


; CONST: #22


; CONST: #54299

CONST_52	.REAL 54299
; CONST: #10


; CONST: #21

CONST_54R	.REAL 21.0
; CONST: #19

CONST_55R	.REAL 19.0
; CONST: #34


; CONST: #39


; CONST: #42


; CONST: #35


; CONST: #36


; CONST: #37


; CONST: #43


; CONST: #44


; CONST: #38


; CONST: #33


;###############################
; ******** DATA ********
DATAS
.BYTE 102
.BYTE 89
.BYTE 86
.BYTE 89
.BYTE 86
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 102
.BYTE 153
.BYTE 102
.BYTE 153
.BYTE 102
.BYTE 153
.BYTE 102
.BYTE 153
.BYTE 101
.BYTE 153
.BYTE 101
.BYTE 149
.BYTE 85
.BYTE 149
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 85
.BYTE 149
.BYTE 101
.BYTE 149
.BYTE 101
.BYTE 153
.BYTE 85
.BYTE 85
.BYTE 86
.BYTE 85
.BYTE 86
.BYTE 89
.BYTE 102
.BYTE 89
.BYTE 102
.BYTE 155
.BYTE 109
.BYTE 151
.BYTE 109
.BYTE 183
.BYTE 221
.BYTE 119
.BYTE 221
.BYTE 119
.BYTE 221
.BYTE 119
.BYTE 221
.BYTE 119
.BYTE 221
.BYTE 119
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
.BYTE 221
.BYTE 183
.BYTE 93
.BYTE 183
.BYTE 109
.BYTE 155
.BYTE 101
.BYTE 155
.BYTE 221
.BYTE 119
.BYTE 222
.BYTE 121
.BYTE 214
.BYTE 121
.BYTE 230
.BYTE 153
.BYTE 230
.BYTE 89
.BYTE 230
.BYTE 121
.BYTE 222
.BYTE 117
.BYTE 222
.BYTE 119
.BYTE 170
.BYTE 170
.BYTE 170
.BYTE 170
.BYTE 170
.BYTE 170
.BYTE 170
.BYTE 170
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 8
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 12
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 126
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 126
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 12
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 8
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
.BYTE 24
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 24
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 24
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 126
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 60
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 24
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
.BYTE 16
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 48
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 126
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 126
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 48
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 16
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
.BYTE 24
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 60
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 126
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 24
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 24
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 24
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
.BYTE 1
.REAL 33792.0
.BYTE 1
.REAL 33832.0
.BYTE 1
.REAL 33872.0
.BYTE 1
.REAL 33912.0
.BYTE 1
.REAL 33952.0
.BYTE 1
.REAL 33992.0
.BYTE 1
.REAL 34032.0
.BYTE 1
.REAL 34072.0
.BYTE 1
.REAL 34112.0
.BYTE 1
.REAL 34152.0
.BYTE 1
.REAL 34192.0
.BYTE 1
.REAL 34232.0
.BYTE 1
.REAL 34272.0
.BYTE 1
.REAL 34312.0
.BYTE 1
.REAL 34352.0
.BYTE 1
.REAL 34392.0
.BYTE 1
.REAL 34432.0
.BYTE 1
.REAL 34472.0
.BYTE 1
.REAL 34512.0
.BYTE 1
.REAL 34552.0
.BYTE 1
.REAL 34592.0
.BYTE 1
.REAL 34632.0
.BYTE 1
.REAL 34672.0
.BYTE 1
.REAL 34712.0
.BYTE 1
.REAL 34752.0
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: WL%
VAR_WL%	.WORD 0
; VAR: HL%
VAR_HL%	.WORD 0
; VAR: JY%
VAR_JY%	.WORD 0
; VAR: JU%
VAR_JU%	.WORD 0
; VAR: JD%
VAR_JD%	.WORD 0
; VAR: JL%
VAR_JL%	.WORD 0
; VAR: JR%
VAR_JR%	.WORD 0
; VAR: WD%[]
.BYTE 0
.WORD 40
VAR_WD%[]	.ARRAY 40
; VAR: LO%[]
.BYTE 0
.WORD 8
VAR_LO%[]	.ARRAY 8
; VAR: RO%[]
.BYTE 0
.WORD 8
VAR_RO%[]	.ARRAY 8
; VAR: AO%[]
.BYTE 0
.WORD 8
VAR_AO%[]	.ARRAY 8
; VAR: AX%[]
.BYTE 0
.WORD 8
VAR_AX%[]	.ARRAY 8
; VAR: AY%[]
.BYTE 0
.WORD 8
VAR_AY%[]	.ARRAY 8
; VAR: FX%
VAR_FX%	.WORD 0
; VAR: FY%
VAR_FY%	.WORD 0
; VAR: DI%
VAR_DI%	.WORD 0
; VAR: PO
VAR_PO	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: B%
VAR_B%	.WORD 0
; VAR: V
VAR_V	.REAL 0.0
; VAR: MV[]
.BYTE 1
.WORD 125
VAR_MV[]	.ARRAY 125
; VAR: J%
VAR_J%	.WORD 0
; VAR: PJ%
VAR_PJ%	.WORD 0
; VAR: TM%
VAR_TM%	.WORD 0
; VAR: P
VAR_P	.REAL 0.0
; VAR: A
VAR_A	.REAL 0.0
; VAR: B
VAR_B	.REAL 0.0
; VAR: I%
VAR_I%	.WORD 0
; VAR: X%
VAR_X%	.WORD 0
; VAR: K%
VAR_K%	.WORD 0
; VAR: D%[]
.BYTE 0
.WORD 8
VAR_D%[]	.ARRAY 8
; VAR: D2%[]
.BYTE 0
.WORD 8
VAR_D2%[]	.ARRAY 8
; VAR: PA
VAR_PA	.REAL 0.0
; VAR: V%
VAR_V%	.WORD 0
; VAR: C%
VAR_C%	.WORD 0
; VAR: KK%
VAR_KK%	.WORD 0
; VAR: Z%
VAR_Z%	.WORD 0
; VAR: IQ%
VAR_IQ%	.WORD 0
; VAR: CQ%
VAR_CQ%	.WORD 0
; VAR: LH%
VAR_LH%	.WORD 0
; VAR: RH%
VAR_RH%	.WORD 0
; VAR: PJ
VAR_PJ	.REAL 0.0
; VAR: LJ%
VAR_LJ%	.WORD 0
; VAR: KQ%
VAR_KQ%	.WORD 0
; VAR: PQ
VAR_PQ	.REAL 0.0
; VAR: LQ%
VAR_LQ%	.WORD 0
; VAR: EQ%
VAR_EQ%	.WORD 0
STRINGVARS_START
; VAR: C$
VAR_C$	.WORD EMPTYSTR
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
