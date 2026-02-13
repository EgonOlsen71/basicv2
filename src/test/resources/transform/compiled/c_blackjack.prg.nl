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
JSR CLR
LDA #14
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<CONST_1
LDY #>CONST_1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_2
LDY #>CONST_2
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDY #12
STY 59468
; Optimizer rule: Simple POKE/2
LDA #142
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_1:
;
LDA #<CONST_5
LDY #>CONST_5
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_6R
LDY #>CONST_6R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_7
LDY #>CONST_7
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_3R
LDY #>CONST_3R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_8
LDY #>CONST_8
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_2:
;
LDA #<CONST_9R
LDY #>CONST_9R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_10
LDY #>CONST_10
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDX #4
dcloop235_1:
LDA CONST_11R,X
STA VAR_I,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_3:
;
;
LINE_5:
;
;
LINE_6:
;
;
LINE_7:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_B$
STY VAR_B$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDX #4
dcloop235_2:
LDA CONST_13R,X
STA VAR_Z1,X
DEX
BPL dcloop235_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_14R
LDY #>CONST_14R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z1
LDY #>VAR_Z1
STA A_REG
STY A_REG+1
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
JSR COMPACTMAX
LDA #<CONST_15
LDY #>CONST_15
STA B_REG
STY B_REG+1
LDA VAR_B$
LDY VAR_B$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_B$
LDY #>VAR_B$
JSR COPYSTRING
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
LINE_8:
;
LDX #4
dcloop235_3:
LDA CONST_13R,X
STA VAR_FF,X
DEX
BPL dcloop235_3
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_22:
;
LDA #<CONST_2
LDY #>CONST_2
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_30
JMP LINE_235
;
LINE_30:
;
LDA #<CONST_17
LDY #>CONST_17
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_50110
JSR GOSUB
JSR LINE_51540
;
LINE_35:
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
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
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_C%[]
LDY #>VAR_C%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
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
LINE_40:
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
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
LINE_41:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDA #<CONST_18R
LDY #>CONST_18R
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Faster RND/4
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
LDX #<VAR_R
LDY #>VAR_R
; FAC to (X/Y)
JSR FACMEM
;
LINE_42:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_C%[]
LDY #>VAR_C%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDX #<VAR_TE
LDY #>VAR_TE
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
LDA #<VAR_C%[]
LDY #>VAR_C%[]
JSR ARRAYACCESS_INTEGER_S
JSR COPY_XREG2YREG
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREGFAC
; Optimizer rule: Faster array access setup(1)/10
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_C%[]
LDY #>VAR_C%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_TE
LDY #>VAR_TE
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_C%[]
LDY #>VAR_C%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
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
LDA #0
STA VAR_R
STA VAR_R+1
STA VAR_R+2
STA VAR_R+3
STA VAR_R+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_45:
;
JMP RETURN
;
LINE_100:
;
LDA #<CONST_19
LDY #>CONST_19
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_20
LDY #>CONST_20
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_21
LDY #>CONST_21
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_22
LDY #>CONST_22
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_101:
;
LDA #<CONST_23
LDY #>CONST_23
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_24
LDY #>CONST_24
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_25
LDY #>CONST_25
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_24
LDY #>CONST_24
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_26
LDY #>CONST_26
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_102:
;
LDA #<CONST_27
LDY #>CONST_27
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_24
LDY #>CONST_24
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_28
LDY #>CONST_28
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_28
LDY #>CONST_28
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_24
LDY #>CONST_24
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_29
LDY #>CONST_29
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_103:
;
JSR GOSUB
JSR LINE_116
JMP LINE_119
;
LINE_104:
;
JSR GOSUB
JSR LINE_103
JMP LINE_121
;
LINE_105:
;
JSR GOSUB
JSR LINE_117
JMP LINE_119
;
LINE_106:
;
JSR GOSUB
JSR LINE_105
LDA #<CONST_30
LDY #>CONST_30
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_107:
;
JSR GOSUB
JSR LINE_118
JMP LINE_119
;
LINE_108:
;
JSR GOSUB
JSR LINE_107
JMP LINE_121
;
LINE_109:
;
JSR GOSUB
JSR LINE_118
LDA #<CONST_31
LDY #>CONST_31
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_34
LDY #>CONST_34
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_25
LDY #>CONST_25
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_35
LDY #>CONST_35
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_110:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_37
LDY #>CONST_37
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_111:
;
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_40
LDY #>CONST_40
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_41
LDY #>CONST_41
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_42
LDY #>CONST_42
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_43
LDY #>CONST_43
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_119
;
LINE_112:
;
LDA #<CONST_44
LDY #>CONST_44
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_45
LDY #>CONST_45
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_46
LDY #>CONST_46
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_47
LDY #>CONST_47
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_113:
;
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_48
LDY #>CONST_48
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_49
LDY #>CONST_49
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_50
LDY #>CONST_50
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_119
;
LINE_114:
;
LDA #<CONST_51
LDY #>CONST_51
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_52
LDY #>CONST_52
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_53
LDY #>CONST_53
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_54
LDY #>CONST_54
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_115:
;
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_55
LDY #>CONST_55
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_41
LDY #>CONST_41
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_56
LDY #>CONST_56
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_57
LDY #>CONST_57
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_119
;
LINE_116:
;
LDA #<CONST_58
LDY #>CONST_58
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_60
LDY #>CONST_60
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_61
LDY #>CONST_61
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_117:
;
JSR GOSUB
JSR LINE_116
LDA #<CONST_62
LDY #>CONST_62
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_63
LDY #>CONST_63
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_118:
;
JSR GOSUB
JSR LINE_116
LDA #<CONST_64
LDY #>CONST_64
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_65
LDY #>CONST_65
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_59
LDY #>CONST_59
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_66
LDY #>CONST_66
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_119:
;
LDA #<CONST_67
LDY #>CONST_67
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP3:
BNE LINE_NSKIP124
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP124
;
LINE_NSKIP124:
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_31
LDY #>CONST_31
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_N$
LDY VAR_N$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_68
LDY #>CONST_68
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_69
LDY #>CONST_69
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_71
LDY #>CONST_71
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_N$
LDY VAR_N$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_72
LDY #>CONST_72
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_73
LDY #>CONST_73
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_SKIP124:
;
;
LINE_120:
;
LDA #<CONST_74
LDY #>CONST_74
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP4:
BNE LINE_NSKIP125
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP125
;
LINE_NSKIP125:
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_75
LDY #>CONST_75
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_33
LDY #>CONST_33
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_N$
LDY VAR_N$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_68
LDY #>CONST_68
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_69
LDY #>CONST_69
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_71
LDY #>CONST_71
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_N$
LDY VAR_N$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_72
LDY #>CONST_72
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_73
LDY #>CONST_73
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_SKIP125:
;
;
LINE_121:
;
LDA #<CONST_76
LDY #>CONST_76
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_Y$
LDY VAR_Y$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_77
LDY #>CONST_77
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_130:
;
LDX #4
dcneloop5315_1:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_NSKIP126
DEX
BPL dcneloop5315_1
JMP LINE_SKIP126
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP126:
; Optimizer rule: Simplified not equal comparison/6
;
JMP RETURN
;
LINE_SKIP126:
;
;
LINE_131:
;
LDA #<CONST_79
LDY #>CONST_79
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDX #4
dceloop5314_1:
LDA VAR_TY,X
CMP VAR_T,X
BNE LINE_SKIP127
DEX
BPL dceloop5314_1
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP127:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_80
LDY #>CONST_80
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP127:
;
;
LINE_132:
;
LDA #<VAR_TY
LDY #>VAR_TY
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
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
COMP_SKP7:
BEQ LINE_SKIP128
; Simplified conditional branch
;
LINE_NSKIP128:
;
LDA #<CONST_81
LDY #>CONST_81
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP128:
;
;
LINE_133:
;
JSR GOSUB
JSR LINE_50100
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_W$
STY VAR_W$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
JMP RETURN
;
LINE_235:
;
LDA #0
STA VAR_B
STA VAR_B+1
STA VAR_B+2
STA VAR_B+3
STA VAR_B+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_A
STA VAR_A+1
STA VAR_A+2
STA VAR_A+3
STA VAR_A+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_C
STA VAR_C+1
STA VAR_C+2
STA VAR_C+3
STA VAR_C+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_V
STA VAR_V+1
STA VAR_V+2
STA VAR_V+3
STA VAR_V+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_VV
STA VAR_VV+1
STA VAR_VV+2
STA VAR_VV+3
STA VAR_VV+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_X7
STA VAR_X7+1
STA VAR_X7+2
STA VAR_X7+3
STA VAR_X7+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_X8
STA VAR_X8+1
STA VAR_X8+2
STA VAR_X8+3
STA VAR_X8+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_Z
STA VAR_Z+1
STA VAR_Z+2
STA VAR_Z+3
STA VAR_Z+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_30000:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_83R
LDY #>CONST_83R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
JSR COMPACTMAX
LDA VAR_B$
LDY VAR_B$+1
STA B_REG
STY B_REG+1
LDY #19
JSR LEFTCONST
; Optimized code for LEFT/RIGHT
;
;
;
;
;
JSR STROUT
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_83R
LDY #>CONST_83R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_85
LDY #>CONST_85
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop733_1:
LDA CONST_86R,X
STA VAR_Z9,X
DEX
BPL dcloop733_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_51530
LDA #0
STA VAR_Z9
STA VAR_Z9+1
STA VAR_Z9+2
STA VAR_Z9+3
STA VAR_Z9+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_30020:
;
LDA #0
STA VAR_BJ
STA VAR_BJ+1
STA VAR_BJ+2
STA VAR_BJ+3
STA VAR_BJ+4
; Optimizer rule: Simplified setting to 0/6
LDA #<VAR_X1
LDY #>VAR_X1
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X2
LDY #>VAR_X2
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X2
LDY #>VAR_X2
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
COMP_SKP8:
BEQ LINE_SKIP129
; Simplified conditional branch
;
LINE_NSKIP129:
;
JMP LINE_30000
;
LINE_SKIP129:
;
;
LINE_30101:
;
LDA #<CONST_87R
LDY #>CONST_87R
JSR REALFAC
LDA #<VAR_X2
LDY #>VAR_X2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT4
LDA #0
JMP GT_SKIP4
GT_GT4:
LDA #$1
GT_SKIP4:
COMP_SKP9:
BEQ LINE_SKIP130
; Simplified conditional branch
;
LINE_NSKIP130:
;
LDA #<CONST_88
LDY #>CONST_88
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_50100
JMP LINE_30000
;
LINE_SKIP130:
;
;
LINE_30102:
LDX #4
dcloop899_1:
LDA CONST_13R,X
STA VAR_H,X
LDA VAR_X2,X
STA VAR_DD,X
DEX
BPL dcloop899_1
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_2
LDY #>CONST_2
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_49121
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_83R
LDY #>CONST_83R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_X2
LDY #>VAR_X2
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_30110:
;
LDA #<CONST_90R
LDY #>CONST_90R
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT5
LDA #0
JMP GT_SKIP5
GT_GT5:
LDA #$1
GT_SKIP5:
COMP_SKP10:
BEQ LINE_SKIP131
; Simplified conditional branch
;
LINE_NSKIP131:
;
JSR GOSUB
JSR LINE_30
;
LINE_SKIP131:
;
;
LINE_30900:
;
LDA #<CONST_67
LDY #>CONST_67
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_52000
;
LINE_31004:
;
LDX #4
dcloop899_3:
LDA VAR_X3,X
STA VAR_D2,X
DEX
BPL dcloop899_3
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_N$
LDY VAR_N$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D2$
LDY #>VAR_D2$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA VAR_Y$
LDY VAR_Y$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D5$
LDY #>VAR_D5$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDX #4
dcloop899_4:
LDA CONST_3R,X
STA VAR_X,X
DEX
BPL dcloop899_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_31300:
;
JSR GOSUB
JSR LINE_53000
JSR GOSUB
JSR LINE_50700
;
LINE_31910:
;
LDA #<CONST_74
LDY #>CONST_74
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_52200
;
LINE_40100:
;
LDA #0
STA VAR_H
STA VAR_H+1
STA VAR_H+2
STA VAR_H+3
STA VAR_H+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_53000
;
LINE_40200:
;
LDX #4
dcloop899_5:
LDA VAR_X3,X
STA VAR_D1,X
DEX
BPL dcloop899_5
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_N$
LDY VAR_N$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D1$
LDY #>VAR_D1$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA VAR_Y$
LDY VAR_Y$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D3$
LDY #>VAR_D3$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDX #4
dcloop899_6:
LDA CONST_13R,X
STA VAR_H,X
DEX
BPL dcloop899_6
; Optimizer rule: Direct copy of floats into mem/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
;
LINE_40210:
;
LDA #<CONST_67
LDY #>CONST_67
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_52800
;
LINE_40217:
;
LDX #4
dceloop5314_2:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_SKIP132
DEX
BPL dceloop5314_2
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP132:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop1065_1:
LDA VAR_X8,X
STA VAR_P2,X
DEX
BPL dcloop1065_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP132:
;
;
LINE_40218:
;
LDX #4
dcloop1065_2:
LDA VAR_X3,X
STA VAR_D4,X
DEX
BPL dcloop1065_2
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_N$
LDY VAR_N$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D4$
LDY #>VAR_D4$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA VAR_Y$
LDY VAR_Y$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_D6$
LDY #>VAR_D6$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_40224:
;
JSR COMPACTMAX
LDA #<VAR_X8
LDY #>VAR_X8
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
LDA #<VAR_T5$
LDY #>VAR_T5$
JSR COPYSTRING
;
LINE_40225:
;
LDA #<CONST_78R
LDY #>CONST_78R
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
JSR GOSUB
JSR LINE_53000
JSR GOSUB
JSR LINE_50700
;
LINE_40360:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
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
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT8
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP8
GT_GT8:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP8:
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
COMP_SKP12:
BEQ LINE_SKIP133
; Simplified conditional branch
;
LINE_NSKIP133:
;
JMP RETURN
;
LINE_SKIP133:
;
;
LINE_40370:
;
LDA #<CONST_86R
LDY #>CONST_86R
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
;
LINE_40380:
;
LDA #<CONST_74
LDY #>CONST_74
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_52800
JSR GOSUB
JSR LINE_53000
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
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
JSR GOSUB
JSR LINE_50700
;
LINE_40560:
;
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT9
LDA #0
JMP GT_SKIP9
GT_GT9:
LDA #$1
GT_SKIP9:
COMP_SKP13:
BEQ LINE_SKIP134
; Simplified conditional branch
;
LINE_NSKIP134:
;
JMP RETURN
;
LINE_SKIP134:
;
;
LINE_40566:
;
LDA #<CONST_92R
LDY #>CONST_92R
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
;
LINE_40570:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X3
LDY #>VAR_X3
JSR CMPFAC
EQ_EQ10:
EQ_SKIP10:
COMP_SKP14:
BNE LINE_SKIP135
LINE_NSKIP135:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_59700
;
LINE_SKIP135:
;
;
LINE_40700:
;
JSR COMPACTMAX
LDA #<VAR_X8
LDY #>VAR_X8
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
LDA #<CONST_93
LDY #>CONST_93
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
JSR GOSUB
JSR LINE_59800
;
LINE_40710:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT11
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP11
GT_GT11:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP11:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
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
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTOR
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic OR/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP15:
BEQ LINE_SKIP136
; Simplified conditional branch
;
LINE_NSKIP136:
;
JMP LINE_49000
;
LINE_SKIP136:
;
;
LINE_40720:
;
LDA #<CONST_95R
LDY #>CONST_95R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ14
ROL
BCC LT_LT14
LT_LT_EQ14:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP14
LT_LT14:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP14:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
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
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP16:
BEQ LINE_SKIP137
; Simplified conditional branch
;
LINE_NSKIP137:
;
JMP LINE_49000
;
LINE_SKIP137:
;
;
LINE_40723:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_D2
LDY #>VAR_D2
JSR REALFAC
LDA #<VAR_D4
LDY #>VAR_D4
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ17
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP17
EQ_EQ17:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP17:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP17:
BEQ LINE_SKIP138
; Simplified conditional branch
;
LINE_NSKIP138:
;
JMP LINE_57000
;
LINE_SKIP138:
;
;
LINE_40726:
;
LDA #<CONST_96
LDY #>CONST_96
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ19
ROL
BCC LT_LT19
LT_LT_EQ19:
LDA #0
JMP LT_SKIP19
LT_LT19:
LDA #$1
LT_SKIP19:
COMP_SKP18:
BNE LINE_NSKIP139
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP139
;
LINE_NSKIP139:
;
JSR COMPACTMAX
LDA #<CONST_97
LDY #>CONST_97
STA TMP_ZP
STY TMP_ZP+1
JSR PUSHINT
; Optimizer rule: Fast address push/3
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
LDY #22
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
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
;
LINE_SKIP139:
;
;
LINE_40730:
;
JSR GOSUB
JSR LINE_51500
;
LINE_40910:
;
LDA #<CONST_98
LDY #>CONST_98
STA B_REG
STY B_REG+1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP19:
BEQ LINE_SKIP140
; Simplified conditional branch
;
LINE_NSKIP140:
;
JSR GOSUB
JSR LINE_40210
JMP LINE_40700
;
LINE_SKIP140:
;
;
LINE_40950:
;
LDA #<CONST_99
LDY #>CONST_99
STA B_REG
STY B_REG+1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP20:
BEQ LINE_SKIP141
; Simplified conditional branch
;
LINE_NSKIP141:
;
JMP LINE_49000
;
LINE_SKIP141:
;
;
LINE_40956:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ20
ROL
BCC LT_LT20
LT_LT_EQ20:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP20
LT_LT20:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP20:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_74
LDY #>CONST_74
STA B_REG
STY B_REG+1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP21:
BEQ LINE_SKIP142
; Simplified conditional branch
;
LINE_NSKIP142:
;
JMP LINE_59600
;
LINE_SKIP142:
;
;
LINE_40960:
;
JMP LINE_40720
;
LINE_45000:
;
LDX #4
dcloop1397_1:
LDA VAR_C,X
STA VAR_CC,X
DEX
BPL dcloop1397_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_74
LDY #>CONST_74
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_53000
LDX #4
dcloop1397_2:
LDA VAR_D1,X
STA VAR_X3,X
DEX
BPL dcloop1397_2
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_D1$
LDY VAR_D1$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_N$
LDY #>VAR_N$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA VAR_D3$
LDY VAR_D3$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_50700
LDA #<CONST_86R
LDY #>CONST_86R
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
;
LINE_45001:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ21
ROL
BCC LT_LT21
LT_LT_EQ21:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP21
LT_LT21:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP21:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_VV
LDY #>VAR_VV
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ22
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP22
EQ_EQ22:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP22:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ23
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP23
EQ_EQ23:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP23:
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
COMP_SKP22:
BNE LINE_NSKIP143
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP143
;
LINE_NSKIP143:
;
JSR COMPACTMAX
LDA #<VAR_X8
LDY #>VAR_X8
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
LDA #<CONST_93
LDY #>CONST_93
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
JSR GOSUB
JSR LINE_59800
;
LINE_SKIP143:
;
;
LINE_45002:
;
LDA #<CONST_95R
LDY #>CONST_95R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ25
ROL
BCC LT_LT25
LT_LT_EQ25:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP25
LT_LT25:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP25:
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
COMP_SKP23:
BNE LINE_NSKIP144
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP144
;
LINE_NSKIP144:
;
JSR COMPACTMAX
LDA #<VAR_X8
LDY #>VAR_X8
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
LDA #<CONST_93
LDY #>CONST_93
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
JSR GOSUB
JSR LINE_59800
;
LINE_SKIP144:
;
;
LINE_45015:
;
LDX #4
dceloop5314_3:
LDA CONST_94R,X
CMP VAR_X7,X
BNE LINE_SKIP145
DEX
BPL dceloop5314_3
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP145:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_45021
;
LINE_SKIP145:
;
;
LINE_45016:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ27
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP27
NEQ_NEQ27:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP27:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
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
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_CC
LDY #>VAR_CC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ29
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP29
EQ_EQ29:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP29:
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
COMP_SKP25:
BEQ LINE_SKIP146
; Simplified conditional branch
;
LINE_NSKIP146:
;
JMP LINE_45021
;
LINE_SKIP146:
;
;
LINE_45018:
;
LDA #<CONST_100R
LDY #>CONST_100R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT30
LDA #0
JMP GT_SKIP30
GT_GT30:
LDA #$1
GT_SKIP30:
COMP_SKP26:
BEQ LINE_SKIP147
; Simplified conditional branch
;
LINE_NSKIP147:
;
JMP LINE_45021
;
LINE_SKIP147:
;
;
LINE_45020:
;
LDA #<CONST_9R
LDY #>CONST_9R
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
LDX #4
dcloop1563_1:
LDA CONST_9R,X
STA VAR_C,X
DEX
BPL dcloop1563_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_40380
JMP LINE_45015
;
LINE_45021:
;
LDX #4
dcneloop5315_2:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_NSKIP148
DEX
BPL dcneloop5315_2
JMP LINE_SKIP148
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP148:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_46000
;
LINE_SKIP148:
;
;
LINE_45022:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_VV
LDY #>VAR_VV
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
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_P2
LDY #>VAR_P2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ33
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP33
EQ_EQ33:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP33:
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
COMP_SKP28:
BEQ LINE_SKIP149
; Simplified conditional branch
;
LINE_NSKIP149:
;
LDX #4
dcloop1729_1:
LDA VAR_CC,X
STA VAR_C,X
DEX
BPL dcloop1729_1
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_58000
;
LINE_SKIP149:
;
;
LINE_45023:
;
LDA VAR_VV
COMP_SKP29:
BEQ LINE_SKIP150
; Optimizer rule: Simplified boolean comparison/3
; Simplified conditional branch
;
LINE_NSKIP150:
;
JSR GOSUB
JSR LINE_59500
;
LINE_SKIP150:
;
;
LINE_45024:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_P2
LDY #>VAR_P2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT34
LDA #0
JMP GT_SKIP34
GT_GT34:
LDA #$1
GT_SKIP34:
COMP_SKP30:
BEQ LINE_SKIP151
; Simplified conditional branch
;
LINE_NSKIP151:
;
JSR GOSUB
JSR LINE_57500
;
LINE_SKIP151:
;
;
LINE_45025:
;
LDA #<CONST_95R
LDY #>CONST_95R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
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
COMP_SKP31:
BEQ LINE_SKIP152
; Simplified conditional branch
;
LINE_NSKIP152:
;
JMP LINE_45031
;
LINE_SKIP152:
;
;
LINE_45027:
;
LDA #<CONST_101
LDY #>CONST_101
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_69
LDY #>CONST_69
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_102
LDY #>CONST_102
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_X7
LDY #>VAR_X7
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_45028:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_P2
LDY #>VAR_P2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ36
ROL
BCC LT_LT36
LT_LT_EQ36:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP36
LT_LT36:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP36:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_VV
LDY #>VAR_VV
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
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
COMP_SKP32:
BEQ LINE_SKIP153
; Simplified conditional branch
;
LINE_NSKIP153:
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP153:
;
;
LINE_45029:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_P1
LDY #>VAR_P1
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ38
ROL
BCC LT_LT38
LT_LT_EQ38:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP38
LT_LT38:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP38:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
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
COMP_SKP33:
BEQ LINE_SKIP154
; Simplified conditional branch
;
LINE_NSKIP154:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP154:
;
;
LINE_45030:
;
JMP LINE_49004
;
LINE_45031:
;
LDA #<VAR_X7
LDY #>VAR_X7
JSR REALFAC
LDA #<VAR_P1
LDY #>VAR_P1
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT40
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP40
GT_GT40:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP40:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_P1
LDY #>VAR_P1
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ41
ROL
BCC LT_LT41
LT_LT_EQ41:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP41
LT_LT41:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP41:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ42
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP42
EQ_EQ42:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP42:
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
COMP_SKP34:
BEQ LINE_SKIP155
; Simplified conditional branch
;
LINE_NSKIP155:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP155:
;
;
LINE_45032:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ43
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP43
EQ_EQ43:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP43:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P1
LDY #>VAR_P1
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT44
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP44
GT_GT44:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP44:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_P1
LDY #>VAR_P1
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ45
ROL
BCC LT_LT45
LT_LT_EQ45:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP45
LT_LT45:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP45:
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
BEQ LINE_SKIP156
; Simplified conditional branch
;
LINE_NSKIP156:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP156:
;
;
LINE_45033:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_VV
LDY #>VAR_VV
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ46
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP46
EQ_EQ46:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP46:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P2
LDY #>VAR_P2
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT47
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP47
GT_GT47:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP47:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_P2
LDY #>VAR_P2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ48
ROL
BCC LT_LT48
LT_LT_EQ48:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP48
LT_LT48:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP48:
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
COMP_SKP36:
BEQ LINE_SKIP157
; Simplified conditional branch
;
LINE_NSKIP157:
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP157:
;
;
LINE_45034:
;
LDA #<VAR_X7
LDY #>VAR_X7
JSR REALFAC
LDA #<VAR_P2
LDY #>VAR_P2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT49
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP49
GT_GT49:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP49:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_P2
LDY #>VAR_P2
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ50
ROL
BCC LT_LT50
LT_LT_EQ50:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP50
LT_LT50:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP50:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_VV
LDY #>VAR_VV
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ51
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP51
EQ_EQ51:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP51:
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
COMP_SKP37:
BEQ LINE_SKIP158
; Simplified conditional branch
;
LINE_NSKIP158:
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP158:
;
;
LINE_46000:
;
JMP LINE_49004
;
LINE_49000:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ52
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP52
EQ_EQ52:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP52:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_95R
LDY #>CONST_95R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ53
ROL
BCC LT_LT53
LT_LT_EQ53:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP53
LT_LT53:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP53:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ54
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP54
EQ_EQ54:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP54:
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
COMP_SKP38:
BEQ LINE_SKIP159
; Simplified conditional branch
;
LINE_NSKIP159:
;
LDX #4
dcloop2227_1:
LDA CONST_103R,X
STA VAR_VV,X
DEX
BPL dcloop2227_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP159:
;
;
LINE_49001:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ55
ROL
BCC LT_LT55
LT_LT_EQ55:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP55
LT_LT55:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP55:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_95R
LDY #>CONST_95R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ56
ROL
BCC LT_LT56
LT_LT_EQ56:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP56
LT_LT56:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP56:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_92R
LDY #>CONST_92R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ57
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP57
EQ_EQ57:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP57:
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
COMP_SKP39:
BEQ LINE_SKIP160
; Simplified conditional branch
;
LINE_NSKIP160:
;
LDX #4
dcloop2227_2:
LDA CONST_104R,X
STA VAR_V,X
DEX
BPL dcloop2227_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP160:
;
;
LINE_49002:
;
LDX #4
dceloop5314_4:
LDA CONST_91R,X
CMP VAR_Z,X
BNE LINE_SKIP161
DEX
BPL dceloop5314_4
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP161:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_49005
;
LINE_SKIP161:
;
;
LINE_49003:
;
JMP LINE_45000
;
LINE_49004:
;
LDX #4
dceloop5314_5:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_SKIP162
DEX
BPL dceloop5314_5
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP162:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_49110
;
LINE_SKIP162:
;
;
LINE_49005:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT60
LDA #0
JMP GT_SKIP60
GT_GT60:
LDA #$1
GT_SKIP60:
COMP_SKP42:
BEQ LINE_SKIP163
; Simplified conditional branch
;
LINE_NSKIP163:
;
JSR GOSUB
JSR LINE_57500
JMP LINE_49110
;
LINE_SKIP163:
;
;
LINE_49006:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
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
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT62
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP62
GT_GT62:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP62:
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
BEQ LINE_SKIP164
; Simplified conditional branch
;
LINE_NSKIP164:
;
JMP LINE_59010
;
LINE_SKIP164:
;
;
LINE_49007:
;
LDX #4
dceloop5314_6:
LDA CONST_94R,X
CMP VAR_X8,X
BNE LINE_SKIP165
DEX
BPL dceloop5314_6
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP165:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_58000
;
LINE_SKIP165:
;
;
LINE_49009:
;
LDX #4
dceloop5314_7:
LDA CONST_94R,X
CMP VAR_X7,X
BNE LINE_SKIP166
DEX
BPL dceloop5314_7
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP166:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_58500
;
LINE_SKIP166:
;
;
LINE_49010:
;
LDX #4
dceloop5314_8:
LDA CONST_104R,X
CMP VAR_V,X
BNE LINE_SKIP167
DEX
BPL dceloop5314_8
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP167:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_59500
JMP LINE_49110
;
LINE_SKIP167:
;
;
LINE_49011:
;
LDX #4
dceloop5314_9:
LDA CONST_91R,X
CMP VAR_Z,X
BNE LINE_SKIP168
DEX
BPL dceloop5314_9
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP168:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_57100
;
LINE_SKIP168:
;
;
LINE_49015:
;
LDA #<VAR_X7
LDY #>VAR_X7
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT67
LDA #0
JMP GT_SKIP67
GT_GT67:
LDA #$1
GT_SKIP67:
COMP_SKP48:
BEQ LINE_SKIP169
; Simplified conditional branch
;
LINE_NSKIP169:
;
JMP LINE_59010
;
LINE_SKIP169:
;
;
LINE_49020:
;
LDX #4
dceloop5314_10:
LDA VAR_X7,X
CMP VAR_X8,X
BNE LINE_SKIP170
DEX
BPL dceloop5314_10
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP170:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_59030
;
LINE_SKIP170:
;
;
LINE_49030:
;
LDA #<VAR_X7
LDY #>VAR_X7
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ69
ROL
BCC LT_LT69
LT_LT_EQ69:
LDA #0
JMP LT_SKIP69
LT_LT69:
LDA #$1
LT_SKIP69:
COMP_SKP50:
BEQ LINE_SKIP171
; Simplified conditional branch
;
LINE_NSKIP171:
;
JMP LINE_59050
;
LINE_SKIP171:
;
;
LINE_49110:
;
LDX #4
dceloop5314_11:
LDA CONST_91R,X
CMP VAR_Z,X
BNE LINE_SKIP172
DEX
BPL dceloop5314_11
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP172:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_57100
;
LINE_SKIP172:
;
;
LINE_49116:
;
LDA #<CONST_95R
LDY #>CONST_95R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ71
ROL
BCC LT_LT71
LT_LT_EQ71:
LDA #0
JMP LT_SKIP71
LT_LT71:
LDA #$1
LT_SKIP71:
COMP_SKP52:
BNE LINE_NSKIP173
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP173
;
LINE_NSKIP173:
;
LDA #<CONST_101
LDY #>CONST_101
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_69
LDY #>CONST_69
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_105
LDY #>CONST_105
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_X7
LDY #>VAR_X7
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
;
LINE_SKIP173:
;
;
LINE_49117:
;
LDA VAR_Z
BEQ EQ_SKIP72
EQ_EQ72:
JMP LINE_SKIP174
EQ_SKIP72:
COMP_SKP53:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP174:
;
JSR GOSUB
JSR LINE_50100
;
LINE_SKIP174:
;
;
LINE_49120:
;
JSR GOSUB
JSR LINE_130
JSR GOSUB
JSR LINE_49121
JMP LINE_235
;
LINE_49121:
;
LDX #4
dcloop2559_1:
LDA VAR_T,X
STA VAR_TY,X
DEX
BPL dcloop2559_1
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_T
BEQ EQ_SKIP73
EQ_EQ73:
JMP LINE_SKIP175
EQ_SKIP73:
COMP_SKP54:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP175:
;
LDA #<CONST_106
LDY #>CONST_106
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP175:
;
;
LINE_49122:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT74
LDA #0
JMP GT_SKIP74
GT_GT74:
LDA #$1
GT_SKIP74:
COMP_SKP55:
BNE LINE_NSKIP176
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP176
;
LINE_NSKIP176:
;
JSR COMPACTMAX
LDA #<VAR_T
LDY #>VAR_T
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
LDA #<CONST_107
LDY #>CONST_107
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
;
LINE_SKIP176:
;
;
LINE_49123:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ75
ROL
BCC LT_LT75
LT_LT_EQ75:
LDA #0
JMP LT_SKIP75
LT_LT75:
LDA #$1
LT_SKIP75:
COMP_SKP56:
BNE LINE_NSKIP177
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP177
;
LINE_NSKIP177:
;
JSR COMPACTMAX
LDA #<VAR_T
LDY #>VAR_T
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = ABS(FAC)
JSR FACABS
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
; ignored: CHGCTX #1
JSR STR
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA #<CONST_108
LDY #>CONST_108
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
;
LINE_SKIP177:
;
;
LINE_49125:
;
JSR COMPACTMAX
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
JSR XREGFAC
LDA #<CONST_83R
LDY #>CONST_83R
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
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
; ignored: CHGCTX #1
LDA VAR_B$
LDY VAR_B$+1
STA B_REG
STY B_REG+1
JSR LEFT
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
LDA VAR_W$
LDY VAR_W$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
LDA VAR_FF
BEQ EQ_SKIP76
EQ_EQ76:
JMP LINE_SKIP178
EQ_SKIP76:
COMP_SKP57:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP178:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_W$
LDY VAR_W$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_SKIP178:
;
;
LINE_49126:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_FF
LDY #>VAR_FF
JSR CMPFAC
EQ_EQ77:
EQ_SKIP77:
COMP_SKP58:
BNE LINE_SKIP179
LINE_NSKIP179:
; Optimizer rule: Simplified equal comparison/6
;
LDA #0
STA VAR_FF
STA VAR_FF+1
STA VAR_FF+2
STA VAR_FF+3
STA VAR_FF+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP179:
;
;
LINE_49127:
;
JMP RETURN
;
LINE_50100:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BNE NEQ_NEQ78
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP NEQ_SKIP78
NEQ_NEQ78:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
NEQ_SKIP78:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ79
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP79
EQ_EQ79:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP79:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_BJ
LDY #>VAR_BJ
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ80
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP80
EQ_EQ80:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP80:
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
COMP_SKP59:
BEQ LINE_SKIP180
; Simplified conditional branch
;
LINE_NSKIP180:
;
LDA #<CONST_79
LDY #>CONST_79
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP180:
;
;
LINE_50105:
;
JSR COMPACTMAX
LDA #<CONST_109
LDY #>CONST_109
STA B_REG
STY B_REG+1
LDA VAR_W$
LDY VAR_W$+1
STA A_REG
STY A_REG+1
JSR CONCAT
LDA VAR_B$
LDY VAR_B$+1
STA B_REG
STY B_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
JSR COMPACTMAX
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
LDY #32
JSR LEFTCONST
; Optimized code for LEFT/RIGHT
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
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
;
LINE_50110:
;
LDX #4
dcloop2725_1:
LDA CONST_13R,X
STA VAR_Z1,X
DEX
BPL dcloop2725_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_111R
LDY #>CONST_111R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z1
LDY #>VAR_Z1
STA A_REG
STY A_REG+1
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_113
LDY #>CONST_113
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_W$
LDY VAR_W$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_114
LDY #>CONST_114
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_W$
LDY VAR_W$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<VAR_Z1
LDY #>VAR_Z1
STA A_REG
STY A_REG+1
JSR NEXT
LDA A_REG
BNE RBEQ_3
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_3:
JMP RETURN
;
LINE_50700:
;
LDA #<VAR_X3
LDY #>VAR_X3
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR FACWORD
STY TMP_ZP
; Optimizer rule: FAC 2 Y_REG(2)/1
ON1SUB0:
LDX #1
CPX TMP_ZP
COMP_SKP61:
BNE ON1SUB1
JSR GOSUB
JSR LINE_100
JMP GSKIPON1
ON1SUB1:
INX
CPX TMP_ZP
COMP_SKP62:
BNE ON1SUB2
JSR GOSUB
JSR LINE_101
JMP GSKIPON1
ON1SUB2:
INX
CPX TMP_ZP
COMP_SKP63:
BNE ON1SUB3
JSR GOSUB
JSR LINE_102
JMP GSKIPON1
ON1SUB3:
INX
CPX TMP_ZP
COMP_SKP64:
BNE ON1SUB4
JSR GOSUB
JSR LINE_103
JMP GSKIPON1
ON1SUB4:
INX
CPX TMP_ZP
COMP_SKP65:
BNE ON1SUB5
JSR GOSUB
JSR LINE_104
JMP GSKIPON1
ON1SUB5:
INX
CPX TMP_ZP
COMP_SKP66:
BNE ON1SUB6
JSR GOSUB
JSR LINE_105
JMP GSKIPON1
ON1SUB6:
INX
CPX TMP_ZP
COMP_SKP67:
BNE ON1SUB7
JSR GOSUB
JSR LINE_106
JMP GSKIPON1
ON1SUB7:
INX
CPX TMP_ZP
COMP_SKP68:
BNE ON1SUB8
JSR GOSUB
JSR LINE_107
JMP GSKIPON1
ON1SUB8:
INX
CPX TMP_ZP
COMP_SKP69:
BNE ON1SUB9
JSR GOSUB
JSR LINE_108
JMP GSKIPON1
ON1SUB9:
INX
CPX TMP_ZP
COMP_SKP70:
BNE ON1SUB10
JSR GOSUB
JSR LINE_109
JMP GSKIPON1
ON1SUB10:
INX
CPX TMP_ZP
COMP_SKP71:
BNE ON1SUB11
JSR GOSUB
JSR LINE_110
JMP GSKIPON1
ON1SUB11:
INX
CPX TMP_ZP
COMP_SKP72:
BNE ON1SUB12
JSR GOSUB
JSR LINE_112
JMP GSKIPON1
ON1SUB12:
INX
CPX TMP_ZP
COMP_SKP73:
BNE GSKIPON1
JSR GOSUB
JSR LINE_114
JMP GSKIPON1
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
LINE_50740:
;
JMP RETURN
;
LINE_51500:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_118
LDY #>CONST_118
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_W$
LDY VAR_W$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_119
LDY #>CONST_119
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_51530:
;
JSR GOSUB
JSR LINE_63000
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
LDX #<VAR_X1
LDY #>VAR_X1
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDA VAR_W$
LDY VAR_W$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_51540:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_118
LDY #>CONST_118
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_B$
LDY VAR_B$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_120
LDY #>CONST_120
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_52000:
;
;
LINE_52200:
;
LDA #<VAR_R
LDY #>VAR_R
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_C%[]
LDY #>VAR_C%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDX #<VAR_TE
LDY #>VAR_TE
JSR XREG2VAR
; Optimizer rule: Faster REG copy into VAR/3
LDY #2
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_TE
LDY #>VAR_TE
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
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
LDX #<VAR_X3
LDY #>VAR_X3
; FAC to (X/Y)
JSR FACMEM
JSR COMPACTMAX
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X3
LDY #>VAR_X3
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
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<VAR_TE
LDY #>VAR_TE
JSR COPY2_XYA_XREG
; Optimizer rule: Avoid YREG usage/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
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
JSR PUSHREAL
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_121
LDY #>CONST_121
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
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
;
LINE_52210:
;
JSR COMPACTMAX
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFAC
LDA #<VAR_X3
LDY #>VAR_X3
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_121
LDY #>CONST_121
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
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_N$
LDY #>VAR_N$
JSR COPYSTRING
LDX #4
dcloop2891_1:
LDA VAR_X3,X
STA VAR_X9,X
DEX
BPL dcloop2891_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_52220:
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
;
LINE_52620:
;
LDA #<CONST_103R
LDY #>CONST_103R
JSR REALFAC
LDA #<VAR_X3
LDY #>VAR_X3
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT81
LDA #0
JMP GT_SKIP81
GT_GT81:
LDA #$1
GT_SKIP81:
COMP_SKP74:
BEQ LINE_SKIP181
; Simplified conditional branch
;
LINE_NSKIP181:
;
LDX #4
dcloop3057_1:
LDA CONST_111R,X
STA VAR_X9,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP181:
;
;
LINE_52625:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X3
LDY #>VAR_X3
JSR CMPFAC
EQ_EQ82:
EQ_SKIP82:
COMP_SKP75:
BNE LINE_SKIP182
LINE_NSKIP182:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop3057_2:
LDA CONST_116R,X
STA VAR_X9,X
DEX
BPL dcloop3057_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP182:
;
;
LINE_52630:
;
LDA #<CONST_67
LDY #>CONST_67
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP76:
BEQ LINE_SKIP183
; Simplified conditional branch
;
LINE_NSKIP183:
;
JMP LINE_52650
;
LINE_SKIP183:
;
;
LINE_52635:
;
LDA #<VAR_X9
LDY #>VAR_X9
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X8
LDY #>VAR_X8
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X3
LDY #>VAR_X3
JSR CMPFAC
EQ_EQ83:
EQ_SKIP83:
COMP_SKP77:
BNE LINE_SKIP184
LINE_NSKIP184:
; Optimizer rule: Simplified equal comparison/6
;
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
LINE_SKIP184:
;
;
LINE_52640:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT84
LDA #0
JMP GT_SKIP84
GT_GT84:
LDA #$1
GT_SKIP84:
COMP_SKP78:
BNE LINE_NSKIP185
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP185
;
LINE_NSKIP185:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT85
LDA #0
JMP GT_SKIP85
GT_GT85:
LDA #$1
GT_SKIP85:
COMP_SKP79:
BNE LINE_NSKIP186
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP186
;
LINE_NSKIP186:
;
LDA #<CONST_111R
LDY #>CONST_111R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X8
LDY #>VAR_X8
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_A
LDY #>VAR_A
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP186:
;
;
LINE_SKIP185:
;
;
LINE_52645:
;
JMP RETURN
;
LINE_52650:
;
LDA #<VAR_X9
LDY #>VAR_X9
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X7
LDY #>VAR_X7
; FAC to (X/Y)
JSR FACMEM
;
LINE_52651:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_X3
LDY #>VAR_X3
JSR CMPFAC
EQ_EQ86:
EQ_SKIP86:
COMP_SKP80:
BNE LINE_SKIP187
LINE_NSKIP187:
; Optimizer rule: Simplified equal comparison/6
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP187:
;
;
LINE_52652:
;
LDA #<VAR_X8
LDY #>VAR_X8
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ87
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP87
EQ_EQ87:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP87:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_95R
LDY #>CONST_95R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ88
ROL
BCC LT_LT88
LT_LT_EQ88:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP88
LT_LT88:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP88:
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
COMP_SKP81:
BEQ LINE_SKIP188
; Simplified conditional branch
;
LINE_NSKIP188:
;
JMP LINE_52670
;
LINE_SKIP188:
;
;
LINE_52660:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT89
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP89
GT_GT89:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP89:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT90
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP90
GT_GT90:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP90:
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
COMP_SKP82:
BNE LINE_NSKIP189
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP189
;
LINE_NSKIP189:
;
LDA #<CONST_111R
LDY #>CONST_111R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X7
LDY #>VAR_X7
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_B
LDY #>VAR_B
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_B
LDY #>VAR_B
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP189:
;
;
LINE_52670:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT91
LDA #0
JMP GT_SKIP91
GT_GT91:
LDA #$1
GT_SKIP91:
COMP_SKP83:
BEQ LINE_SKIP190
; Simplified conditional branch
;
LINE_NSKIP190:
;
LDX #4
dcloop3223_1:
LDA CONST_78R,X
STA VAR_C,X
DEX
BPL dcloop3223_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP190:
;
;
LINE_52700:
;
JMP RETURN
;
LINE_52800:
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
;
LINE_52810:
;
LDA #<CONST_74
LDY #>CONST_74
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP84:
BEQ LINE_SKIP191
; Simplified conditional branch
;
LINE_NSKIP191:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP191:
;
;
LINE_52820:
;
LDA #<CONST_67
LDY #>CONST_67
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP85:
BEQ LINE_SKIP192
; Simplified conditional branch
;
LINE_NSKIP192:
;
LDX #4
dcloop3389_1:
LDA CONST_3R,X
STA VAR_X,X
DEX
BPL dcloop3389_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP192:
;
;
LINE_52830:
;
JMP LINE_52200
;
LINE_53000:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_53100:
;
LDA #<CONST_67
LDY #>CONST_67
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP86:
BEQ LINE_SKIP193
; Simplified conditional branch
;
LINE_NSKIP193:
;
LDX #4
dcloop3389_2:
LDA CONST_3R,X
STA VAR_X,X
DEX
BPL dcloop3389_2
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP193:
;
;
LINE_53120:
;
LDA #<CONST_74
LDY #>CONST_74
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
BEQ LINE_SKIP194
; Simplified conditional branch
;
LINE_NSKIP194:
;
LDA #0
STA VAR_X
STA VAR_X+1
STA VAR_X+2
STA VAR_X+3
STA VAR_X+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_SKIP194:
;
;
LINE_53130:
;
LDA VAR_X
BEQ EQ_SKIP92
EQ_EQ92:
JMP LINE_SKIP195
EQ_SKIP92:
COMP_SKP88:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP195:
;
JMP LINE_53405
;
LINE_SKIP195:
;
;
LINE_53200:
;
LDX #4
dcloop3389_3:
LDA CONST_13R,X
STA VAR_Z1,X
DEX
BPL dcloop3389_3
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_X
LDY #>VAR_X
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z1
LDY #>VAR_Z1
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
LDA #<CONST_122
LDY #>CONST_122
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
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
LINE_53405:
;
LDA VAR_Y
BEQ EQ_SKIP93
EQ_EQ93:
JMP LINE_SKIP196
EQ_SKIP93:
COMP_SKP90:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP196:
;
JMP LINE_53701
;
LINE_SKIP196:
;
;
LINE_53500:
;
LDX #4
dcloop3389_4:
LDA CONST_13R,X
STA VAR_Z1,X
DEX
BPL dcloop3389_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z1
LDY #>VAR_Z1
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
LDA #<CONST_123
LDY #>CONST_123
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
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
LINE_53701:
;
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ94
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP94
EQ_EQ94:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP94:
; Real in (A/Y) to FAC
JSR REALFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_74
LDY #>CONST_74
STA B_REG
STY B_REG+1
LDA VAR_X$
LDY VAR_X$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA X_REG
COMP_SKP92:
BEQ LINE_SKIP197
; Simplified conditional branch
;
LINE_NSKIP197:
;
JMP LINE_53710
;
LINE_SKIP197:
;
;
LINE_53705:
;
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT95
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP95
GT_GT95:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP95:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT96
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP96
GT_GT96:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP96:
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
COMP_SKP93:
BEQ LINE_SKIP198
; Simplified conditional branch
;
LINE_NSKIP198:
;
LDA #<CONST_124
LDY #>CONST_124
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_123
LDY #>CONST_123
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP198:
;
;
LINE_53710:
;
LDX #4
dcloop3555_1:
LDA CONST_13R,X
STA VAR_Z1,X
DEX
BPL dcloop3555_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_103R
LDY #>CONST_103R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z1
LDY #>VAR_Z1
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
;
LINE_53805:
;
LDA VAR_H
BEQ EQ_SKIP97
EQ_EQ97:
JMP LINE_SKIP199
EQ_SKIP97:
COMP_SKP94:
; Optimizer rule: Reverted comparison/6
; Simplified conditional branch
;
LINE_NSKIP199:
;
LDA #<CONST_125
LDY #>CONST_125
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_126
LDY #>CONST_126
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP199:
;
;
LINE_53810:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_H
LDY #>VAR_H
JSR CMPFAC
EQ_EQ98:
EQ_SKIP98:
COMP_SKP95:
BNE LINE_SKIP200
LINE_NSKIP200:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_127
LDY #>CONST_127
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_126
LDY #>CONST_126
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP200:
;
;
LINE_53910:
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
LINE_53920:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_H
LDY #>VAR_H
JSR CMPFAC
EQ_EQ99:
EQ_SKIP99:
COMP_SKP97:
BNE LINE_SKIP201
LINE_NSKIP201:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_32
LDY #>CONST_32
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_SKIP201:
;
;
LINE_53930:
;
JMP RETURN
;
LINE_57000:
;
LDA #<CONST_128
LDY #>CONST_128
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_51500
;
LINE_57010:
;
LDA #<CONST_99
LDY #>CONST_99
STA B_REG
STY B_REG+1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP98:
BEQ LINE_SKIP202
; Simplified conditional branch
;
LINE_NSKIP202:
;
JMP LINE_40726
;
LINE_SKIP202:
;
;
LINE_57015:
;
LDA #<CONST_98
LDY #>CONST_98
STA B_REG
STY B_REG+1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP99:
BEQ LINE_SKIP203
; Simplified conditional branch
;
LINE_NSKIP203:
;
JMP LINE_57000
;
LINE_SKIP203:
;
;
LINE_57020:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D2
LDY #>VAR_D2
JSR CMPFAC
EQ_EQ100:
EQ_SKIP100:
COMP_SKP100:
BNE LINE_SKIP204
LINE_NSKIP204:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop3721_1:
LDA CONST_13R,X
STA VAR_A,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP204:
;
;
LINE_57021:
;
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_X8
LDY #>VAR_X8
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(2)/1
; FAC = FAC>>A
JSR SHR
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F
LDY #>VAR_F
; FAC to (X/Y)
JSR FACMEM
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D2
LDY #>VAR_D2
JSR CMPFAC
EQ_EQ101:
EQ_SKIP101:
COMP_SKP101:
BNE LINE_SKIP205
LINE_NSKIP205:
LDX #4
dcloop3721_2:
LDA CONST_116R,X
STA VAR_F,X
LDA CONST_116R,X
STA VAR_X8,X
DEX
BPL dcloop3721_2
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP205:
;
;
LINE_57025:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_69
LDY #>CONST_69
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_129
LDY #>CONST_129
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDX #4
dcloop3721_4:
LDA CONST_13R,X
STA VAR_Z1,X
DEX
BPL dcloop3721_4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_103R
LDY #>CONST_103R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_13R
;LDY #>CONST_13R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z1
LDY #>VAR_Z1
STA A_REG
STY A_REG+1
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
LDA VAR_B$
LDY VAR_B$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
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
LDA #0
STA VAR_C
STA VAR_C+1
STA VAR_C+2
STA VAR_C+3
STA VAR_C+4
; Optimizer rule: Simplified setting to 0/6
;
LINE_57030:
;
LDA #<CONST_67
LDY #>CONST_67
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDX #4
dcloop3721_5:
LDA CONST_117R,X
STA VAR_X,X
DEX
BPL dcloop3721_5
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA VAR_Y
STA VAR_Y+1
STA VAR_Y+2
STA VAR_Y+3
STA VAR_Y+4
; Optimizer rule: Simplified setting to 0/6
JSR GOSUB
JSR LINE_53000
LDX #4
dcloop3721_6:
LDA VAR_D2,X
STA VAR_X3,X
DEX
BPL dcloop3721_6
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_D2$
LDY VAR_D2$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_N$
LDY #>VAR_N$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA VAR_D5$
LDY VAR_D5$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_50700
;
LINE_57040:
;
LDA #<CONST_67
LDY #>CONST_67
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
LDX #4
dcloop3721_7:
LDA CONST_117R,X
STA VAR_X,X
LDA CONST_83R,X
STA VAR_Y,X
DEX
BPL dcloop3721_7
; Special rule: Aggregation of assignments (2)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_53000
LDX #4
dcloop3721_9:
LDA VAR_D4,X
STA VAR_X3,X
DEX
BPL dcloop3721_9
; Optimizer rule: Direct copy of floats into mem/6
LDA VAR_D4$
LDY VAR_D4$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_N$
LDY #>VAR_N$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA VAR_D6$
LDY VAR_D6$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Y$
LDY #>VAR_Y$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_50700
;
LINE_57070:
LDX #4
dcloop3721_10:
LDA VAR_F,X
STA VAR_X8,X
LDA CONST_13R,X
STA VAR_C,X
LDA CONST_130,X
STA VAR_Y,X
LDA CONST_91R,X
STA VAR_Z,X
LDA CONST_117R,X
STA VAR_X,X
DEX
BPL dcloop3721_10
; Special rule: Aggregation of assignments (5)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_40210
JMP LINE_40700
;
LINE_57100:
;
LDA #<CONST_95R
LDY #>CONST_95R
JSR REALFAC
LDA #<VAR_X8
LDY #>VAR_X8
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ102
ROL
BCC LT_LT102
LT_LT_EQ102:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP102
LT_LT102:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP102:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ103
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP103
EQ_EQ103:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP103:
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
COMP_SKP103:
BNE LINE_NSKIP206
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP206
;
LINE_NSKIP206:
;
JSR COMPACTMAX
LDA #<VAR_X8
LDY #>VAR_X8
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
LDA #<CONST_93
LDY #>CONST_93
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
JSR GOSUB
JSR LINE_59800
;
LINE_SKIP206:
;
;
LINE_57110:
;
LDA #0
STA VAR_A
STA VAR_A+1
STA VAR_A+2
STA VAR_A+3
STA VAR_A+4
LDX #4
dcloop3887_1:
LDA VAR_X8,X
STA VAR_P1,X
LDA VAR_F,X
STA VAR_X8,X
LDA CONST_91R,X
STA VAR_C,X
DEX
BPL dcloop3887_1
; Special rule: Aggregation of assignments (3)
; Optimizer rule: Direct copy of floats into mem/6
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_D2
LDY #>VAR_D2
JSR CMPFAC
EQ_EQ104:
EQ_SKIP104:
COMP_SKP104:
BNE LINE_SKIP207
LINE_NSKIP207:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop3887_4:
LDA CONST_13R,X
STA VAR_A,X
DEX
BPL dcloop3887_4
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP207:
;
;
LINE_57170:
;
LDA #<CONST_67
LDY #>CONST_67
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_X$
LDY #>VAR_X$
JSR COPYSTRING
LDX #4
dcloop3887_5:
LDA VAR_F,X
STA VAR_X8,X
LDA CONST_13R,X
STA VAR_C,X
LDA CONST_84R,X
STA VAR_Y,X
LDA CONST_78R,X
STA VAR_Z,X
LDA CONST_117R,X
STA VAR_X,X
DEX
BPL dcloop3887_5
; Special rule: Aggregation of assignments (5)
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_40210
JMP LINE_40700
;
LINE_57500:
;
LDX #4
dceloop5314_12:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_SKIP208
DEX
BPL dceloop5314_12
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP208:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP208:
;
;
LINE_57505:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
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
COMP_SKP106:
BEQ LINE_SKIP209
; Simplified conditional branch
;
LINE_NSKIP209:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP209:
;
;
LINE_57510:
;
JSR COMPACTMAX
LDA VAR_T5$
LDY VAR_T5$+1
STA B_REG
STY B_REG+1
LDA #<CONST_131
LDY #>CONST_131
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
JSR GOSUB
JSR LINE_59800
LDA #<CONST_132
LDY #>CONST_132
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JMP RETURN
;
LINE_58000:
;
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT107
LDA #0
JMP GT_SKIP107
GT_GT107:
LDA #$1
GT_SKIP107:
COMP_SKP107:
BEQ LINE_SKIP210
; Simplified conditional branch
;
LINE_NSKIP210:
;
JMP LINE_58100
;
LINE_SKIP210:
;
;
LINE_58003:
;
LDA #<VAR_X8
LDY #>VAR_X8
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ108
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP108
EQ_EQ108:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP108:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ109
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP109
EQ_EQ109:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP109:
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
COMP_SKP108:
BEQ LINE_SKIP211
; Simplified conditional branch
;
LINE_NSKIP211:
;
JMP LINE_59030
;
LINE_SKIP211:
;
;
LINE_58005:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ110
LDA #0
JMP EQ_SKIP110
EQ_EQ110:
LDA #$1
EQ_SKIP110:
COMP_SKP109:
BNE LINE_NSKIP212
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP212
;
LINE_NSKIP212:
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<CONST_133
LDY #>CONST_133
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_T
LDY #>VAR_T
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP212:
;
;
LINE_58015:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ111
ROL
BCC LT_LT111
LT_LT_EQ111:
LDA #0
JMP LT_SKIP111
LT_LT111:
LDA #$1
LT_SKIP111:
COMP_SKP110:
BNE LINE_NSKIP213
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP213
;
LINE_NSKIP213:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<CONST_133
LDY #>CONST_133
JSR FASTFMULMEM
; Optimizer rule: Fast FMUL (MEM)/1
; Optimizer rule: Highly simplified loading for calculations (mul)/6
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<VAR_T
LDY #>VAR_T
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP213:
;
;
LINE_58025:
;
LDX #4
dcloop4053_1:
LDA CONST_13R,X
STA VAR_BJ,X
DEX
BPL dcloop4053_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_134
LDY #>CONST_134
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JMP LINE_49110
;
LINE_58100:
;
LDA #<VAR_X8
LDY #>VAR_X8
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ112
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP112
EQ_EQ112:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP112:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ113
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP113
EQ_EQ113:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP113:
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
COMP_SKP111:
BEQ LINE_SKIP214
; Simplified conditional branch
;
LINE_NSKIP214:
;
JMP LINE_59030
;
LINE_SKIP214:
;
;
LINE_58101:
;
LDA #<CONST_104R
LDY #>CONST_104R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ114
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP114
EQ_EQ114:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP114:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ115
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP115
EQ_EQ115:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP115:
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
COMP_SKP112:
BEQ LINE_SKIP215
; Simplified conditional branch
;
LINE_NSKIP215:
;
JSR GOSUB
JSR LINE_59500
JMP LINE_49110
;
LINE_SKIP215:
;
;
LINE_58102:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ116
ROL
BCC LT_LT116
LT_LT_EQ116:
LDA #0
JMP LT_SKIP116
LT_LT116:
LDA #$1
LT_SKIP116:
COMP_SKP113:
BEQ LINE_SKIP216
; Simplified conditional branch
;
LINE_NSKIP216:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP216:
;
;
LINE_58103:
;
LDX #4
dceloop5314_13:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_SKIP217
DEX
BPL dceloop5314_13
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP217:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP217:
;
;
LINE_58105:
;
LDA #<CONST_135
LDY #>CONST_135
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_59800
LDX #4
dcneloop5315_3:
LDA VAR_X8,X
CMP VAR_X7,X
BNE LINE_NSKIP218
DEX
BPL dcneloop5315_3
JMP LINE_SKIP218
; Optimizer rule: Direct compare(<>) of floats/8
LINE_NSKIP218:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_49110
;
LINE_SKIP218:
;
;
LINE_58500:
;
LDX #4
dceloop5314_14:
LDA VAR_X8,X
CMP VAR_X7,X
BNE LINE_SKIP219
DEX
BPL dceloop5314_14
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP219:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_59030
;
LINE_SKIP219:
;
;
LINE_58502:
;
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT120
LDA #0
JMP GT_SKIP120
GT_GT120:
LDA #$1
GT_SKIP120:
COMP_SKP117:
BEQ LINE_SKIP220
; Simplified conditional branch
;
LINE_NSKIP220:
;
JMP LINE_58600
;
LINE_SKIP220:
;
;
LINE_58510:
;
LDA #<CONST_136
LDY #>CONST_136
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
JMP LINE_49110
;
LINE_58600:
;
LDA VAR_Z
BEQ EQ_EQ121
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP121
EQ_EQ121:
LDA #$1
EQ_SKIP121:
COMP_SKP118:
BNE LINE_NSKIP221
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP221
;
LINE_NSKIP221:
;
LDX #4
dceloop5314_15:
LDA VAR_X8,X
CMP VAR_X7,X
BNE LINE_SKIP222
DEX
BPL dceloop5314_15
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP222:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_59030
;
LINE_SKIP222:
;
;
LINE_SKIP221:
;
;
LINE_58610:
;
LDX #4
dceloop5314_16:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_SKIP223
DEX
BPL dceloop5314_16
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP223:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP223:
;
;
LINE_58620:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ124
ROL
BCC LT_LT124
LT_LT_EQ124:
LDA #0
JMP LT_SKIP124
LT_LT124:
LDA #$1
LT_SKIP124:
COMP_SKP121:
BEQ LINE_SKIP224
; Simplified conditional branch
;
LINE_NSKIP224:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP224:
;
;
LINE_58630:
;
LDA #<CONST_81
LDY #>CONST_81
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JMP LINE_49110
;
LINE_59010:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_79
LDY #>CONST_79
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_59013:
;
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT125
LDA #0
JMP GT_SKIP125
GT_GT125:
LDA #$1
GT_SKIP125:
COMP_SKP122:
BNE LINE_NSKIP225
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP225
;
LINE_NSKIP225:
;
LDA #<CONST_101
LDY #>CONST_101
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_69
LDY #>CONST_69
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_102
LDY #>CONST_102
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_X7
LDY #>VAR_X7
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR REALOUTBRK
; Optimizer rule: REALOUT + LINEBRK/1
LDA #<CONST_79
LDY #>CONST_79
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP225:
;
;
LINE_59029:
;
JMP LINE_49110
;
LINE_59030:
;
LDA #<CONST_137
LDY #>CONST_137
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_59037:
;
LDA #<CONST_91R
LDY #>CONST_91R
JSR REALFAC
LDA #<VAR_C
LDY #>VAR_C
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ126
LDA #0
JMP EQ_SKIP126
EQ_EQ126:
LDA #$1
EQ_SKIP126:
COMP_SKP123:
BNE LINE_NSKIP226
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP226
;
LINE_NSKIP226:
;
LDX #4
dceloop5314_17:
LDA CONST_94R,X
CMP VAR_X7,X
BNE LINE_SKIP227
DEX
BPL dceloop5314_17
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP227:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_138
LDY #>CONST_138
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_SKIP227:
;
;
LINE_SKIP226:
;
;
LINE_59040:
;
JMP LINE_49110
;
LINE_59050:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_81
LDY #>CONST_81
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JMP LINE_49110
;
LINE_59500:
;
LDX #4
dceloop5314_18:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_SKIP228
DEX
BPL dceloop5314_18
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP228:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP228:
;
;
LINE_59510:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ129
ROL
BCC LT_LT129
LT_LT_EQ129:
LDA #0
JMP LT_SKIP129
LT_LT129:
LDA #$1
LT_SKIP129:
COMP_SKP126:
BEQ LINE_SKIP229
; Simplified conditional branch
;
LINE_NSKIP229:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP229:
;
;
LINE_59520:
;
LDA #<CONST_139
LDY #>CONST_139
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA #<CONST_16R
LDY #>CONST_16R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT130
LDA #0
JMP GT_SKIP130
GT_GT130:
LDA #$1
GT_SKIP130:
COMP_SKP127:
BEQ LINE_SKIP230
; Simplified conditional branch
;
LINE_NSKIP230:
;
JMP LINE_59800
;
LINE_SKIP230:
;
;
LINE_59530:
;
JMP RETURN
;
LINE_59600:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ131
ROL
BCC LT_LT131
LT_LT_EQ131:
LDA #0
JMP LT_SKIP131
LT_LT131:
LDA #$1
LT_SKIP131:
COMP_SKP128:
BEQ LINE_SKIP231
; Simplified conditional branch
;
LINE_NSKIP231:
;
LDA #<VAR_X2
LDY #>VAR_X2
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #1
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X2
LDY #>VAR_X2
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP231:
;
;
LINE_59605:
;
LDX #4
dceloop5314_19:
LDA CONST_78R,X
CMP VAR_Z,X
BNE LINE_SKIP232
DEX
BPL dceloop5314_19
; Optimizer rule: Direct compare(=) of floats/7
LINE_NSKIP232:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_DD
LDY #>VAR_DD
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY #1
STY A_REG
JSR XREGFAC
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_DD
LDY #>VAR_DD
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP232:
;
;
LINE_59606:
;
JSR GOSUB
JSR LINE_40210
JMP LINE_49000
;
LINE_59700:
;
LDA #<CONST_140
LDY #>CONST_140
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_51500
;
LINE_59720:
;
LDA #<CONST_99
LDY #>CONST_99
STA B_REG
STY B_REG+1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP130:
BEQ LINE_SKIP233
; Simplified conditional branch
;
LINE_NSKIP233:
;
JMP RETURN
;
LINE_SKIP233:
;
;
LINE_59722:
;
LDA #<CONST_98
LDY #>CONST_98
STA B_REG
STY B_REG+1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP131:
BEQ LINE_SKIP234
; Simplified conditional branch
;
LINE_NSKIP234:
;
JMP LINE_59730
;
LINE_SKIP234:
;
;
LINE_59724:
;
JMP LINE_59700
;
LINE_59730:
;
LDA #<CONST_141
LDY #>CONST_141
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDX #4
dcloop4717_1:
LDA CONST_86R,X
STA VAR_Z9,X
DEX
BPL dcloop4717_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_51500
LDA #<VAR_X1
LDY #>VAR_X1
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC = INT(FAC)
JSR BASINT
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_87R
LDY #>CONST_87R
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT133
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP133
GT_GT133:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP133:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_I
LDY #>VAR_I
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ134
ROL
BCC LT_LT134
LT_LT_EQ134:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP134
LT_LT134:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP134:
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
COMP_SKP132:
BEQ LINE_SKIP235
; Simplified conditional branch
;
LINE_NSKIP235:
;
JMP LINE_59730
;
LINE_SKIP235:
;
;
LINE_59750:
;
LDA #0
STA VAR_Z9
STA VAR_Z9+1
STA VAR_Z9+2
STA VAR_Z9+3
STA VAR_Z9+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_94R
LDY #>CONST_94R
JSR REALFAC
LDA #<VAR_X7
LDY #>VAR_X7
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ135
LDA #0
JMP EQ_SKIP135
EQ_EQ135:
LDA #$1
EQ_SKIP135:
COMP_SKP133:
BNE LINE_NSKIP236
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP236
;
LINE_NSKIP236:
;
LDA #<VAR_I
LDY #>VAR_I
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
LDA #<VAR_T
LDY #>VAR_T
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_SKIP236:
;
;
LINE_59760:
;
LDA #<CONST_142
LDY #>CONST_142
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_50100
JSR GOSUB
JSR LINE_51540
;
LINE_59770:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<VAR_T
LDY #>VAR_T
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_T
LDY #>VAR_T
; FAC to (X/Y)
JSR FACMEM
JMP RETURN
;
LINE_59800:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ136
ROL
BCC LT_LT136
LT_LT_EQ136:
LDA #0
JMP LT_SKIP136
LT_LT136:
LDA #$1
LT_SKIP136:
COMP_SKP134:
BNE LINE_NSKIP237
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP237
;
LINE_NSKIP237:
;
LDA #<CONST_143
LDY #>CONST_143
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_W$
LDY VAR_W$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_144
LDY #>CONST_144
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_SKIP237:
;
;
LINE_59810:
;
LDA #<CONST_78R
LDY #>CONST_78R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ137
LDA #0
JMP EQ_SKIP137
EQ_EQ137:
LDA #$1
EQ_SKIP137:
COMP_SKP135:
BNE LINE_NSKIP238
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP238
;
LINE_NSKIP238:
;
LDA #<CONST_143
LDY #>CONST_143
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_112
LDY #>CONST_112
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_70
LDY #>CONST_70
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_145
LDY #>CONST_145
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_W$
LDY VAR_W$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_144
LDY #>CONST_144
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JMP RETURN
;
LINE_SKIP238:
;
;
LINE_59820:
;
JMP RETURN
;
LINE_63000:
;
LDA #<EMPTYSTR
LDY #>EMPTYSTR
STA VAR_W$
STY VAR_W$+1
; Optimizer rule: Faster empty string/4
; Optimizer rule: Simplified loading of Strings/5
LDA #<CONST_146
LDY #>CONST_146
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z1$
LDY #>VAR_Z1$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA #<CONST_15
LDY #>CONST_15
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z2$
LDY #>VAR_Z2$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
;
LINE_63020:
;
LDA VAR_Z1$
LDY VAR_Z1$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_145
LDY #>CONST_145
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop4883_1:
LDA CONST_13R,X
STA VAR_Z1,X
DEX
BPL dcloop4883_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_63025:
;
JSR GETSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_J$
LDY #>VAR_J$
JSR COPYSTRING
LDA #<CONST_12
LDY #>CONST_12
STA B_REG
STY B_REG+1
LDA VAR_J$
LDY VAR_J$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SNEQ
LDA X_REG
COMP_SKP136:
BEQ LINE_SKIP239
; Simplified conditional branch
;
LINE_NSKIP239:
;
JMP LINE_63100
;
LINE_SKIP239:
;
;
LINE_63030:
;
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
LDA #<VAR_Z1
LDY #>VAR_Z1
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z1
LDY #>VAR_Z1
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_6R
LDY #>CONST_6R
JSR REALFAC
LDA #<VAR_Z1
LDY #>VAR_Z1
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ138
ROL
BCC LT_LT138
LT_LT_EQ138:
LDA #0
JMP LT_SKIP138
LT_LT138:
LDA #$1
LT_SKIP138:
COMP_SKP137:
BEQ LINE_SKIP240
; Simplified conditional branch
;
LINE_NSKIP240:
;
JMP LINE_63025
;
LINE_SKIP240:
;
;
LINE_63040:
;
LDA VAR_Z1$
LDY VAR_Z1$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z$
LDY #>VAR_Z$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA VAR_Z2$
LDY VAR_Z2$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z1$
LDY #>VAR_Z1$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
LDA VAR_Z$
LDY VAR_Z$+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_Z2$
LDY #>VAR_Z2$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JMP LINE_63020
;
LINE_63100:
;
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
JSR ASC
LDA #<CONST_117R
LDY #>CONST_117R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ139:
EQ_SKIP139:
COMP_SKP138:
BNE LINE_SKIP241
LINE_NSKIP241:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_147
LDY #>CONST_147
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP RETURN
;
LINE_SKIP241:
;
;
LINE_63110:
;
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
JSR ASC
LDA #<CONST_83R
LDY #>CONST_83R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ140:
EQ_SKIP140:
COMP_SKP139:
BNE LINE_SKIP242
LINE_NSKIP242:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_63200
;
LINE_SKIP242:
;
;
LINE_63130:
;
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
JSR ASC
LDA #<CONST_148R
LDY #>CONST_148R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR XREGARG
; Optimizer rule: X_REG 2 ARG/1
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_J
LDY #>VAR_J
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_149R
LDY #>CONST_149R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ141
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP141
EQ_EQ141:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP141:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_150R
LDY #>CONST_150R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ142
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP142
EQ_EQ142:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP142:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_151R
LDY #>CONST_151R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ143
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP143
EQ_EQ143:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP143:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_84R
LDY #>CONST_84R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ144
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP144
EQ_EQ144:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP144:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_152R
LDY #>CONST_152R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ145
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP145
EQ_EQ145:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP145:
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
COMP_SKP140:
BEQ LINE_SKIP243
; Simplified conditional branch
;
LINE_NSKIP243:
;
JMP LINE_63020
;
LINE_SKIP243:
;
;
LINE_63140:
;
JSR COMPACTMAX
LDA VAR_J$
LDY VAR_J$+1
STA B_REG
STY B_REG+1
LDA VAR_W$
LDY VAR_W$+1
STA A_REG
STY A_REG+1
JSR CONCAT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
LDA #<CONST_147
LDY #>CONST_147
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_J$
LDY VAR_J$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<VAR_Z9
LDY #>VAR_Z9
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
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
BEQ LT_LT_EQ146
ROL
BCC LT_LT146
LT_LT_EQ146:
LDA #0
JMP LT_SKIP146
LT_LT146:
LDA #$1
LT_SKIP146:
COMP_SKP141:
BEQ LINE_SKIP244
; Simplified conditional branch
;
LINE_NSKIP244:
;
JMP LINE_63020
;
LINE_SKIP244:
;
;
LINE_63150:
;
LDA #<VAR_Z9
LDY #>VAR_Z9
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
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
BEQ GTEQ_GTEQ147
BCS GTEQ_GTEQ147
LDA #0
JMP GTEQ_SKIP147
GTEQ_GTEQ147:
LDA #$1
GTEQ_SKIP147:
COMP_SKP142:
BEQ LINE_SKIP245
; Simplified conditional branch
;
LINE_NSKIP245:
;
JMP RETURN
;
LINE_SKIP245:
;
;
LINE_63160:
;
LDA #<CONST_147
LDY #>CONST_147
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_J$
LDY VAR_J$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JMP LINE_63020
;
LINE_63200:
;
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
JSR LEN
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ148
ROL
BCC LT_LT148
LT_LT_EQ148:
LDA #0
JMP LT_SKIP148
LT_LT148:
LDA #$1
LT_SKIP148:
COMP_SKP143:
BEQ LINE_SKIP246
; Simplified conditional branch
;
LINE_NSKIP246:
;
JMP LINE_63000
;
LINE_SKIP246:
;
;
LINE_63210:
;
LDA VAR_J$
LDY VAR_J$+1
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
JSR LEN
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ149:
EQ_SKIP149:
COMP_SKP144:
BNE LINE_SKIP247
LINE_NSKIP247:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_63000
;
LINE_SKIP247:
;
;
LINE_63220:
;
JSR COMPACTMAX
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
JSR LEN
JSR ONETOFAC
; Optimizer rule: Faster setting to 1/1
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
; ignored: CHGCTX #1
LDA VAR_W$
LDY VAR_W$+1
STA B_REG
STY B_REG+1
JSR LEFT
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_W$
LDY #>VAR_W$
JSR COPYSTRING
JMP LINE_63020
;
LINE_63999:
;
JSR END
RTS
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
STA VAR_I,Y
STA VAR_Z1,Y
STA VAR_FF,Y
STA VAR_R,Y
STA VAR_TE,Y
STA VAR_Z,Y
STA VAR_TY,Y
STA VAR_T,Y
STA VAR_B,Y
STA VAR_A,Y
STA VAR_C,Y
STA VAR_V,Y
STA VAR_VV,Y
STA VAR_X7,Y
STA VAR_X8,Y
STA VAR_Z9,Y
STA VAR_BJ,Y
STA VAR_X1,Y
STA VAR_X2,Y
STA VAR_H,Y
STA VAR_DD,Y
STA VAR_X3,Y
STA VAR_D2,Y
STA VAR_X,Y
STA VAR_Y,Y
STA VAR_D1,Y
STA VAR_P2,Y
STA VAR_D4,Y
STA VAR_CC,Y
STA VAR_P1,Y
STA VAR_X9,Y
STA VAR_F,Y
STA VAR_J,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
LDA #<VAR_C%[]
LDY #>VAR_C%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #14


; CONST: ${home*2}
CONST_1	.BYTE 8
.STRG "{home*2}"
; CONST: ${clear}
CONST_2	.BYTE 7
.STRG "{clear}"
; CONST: #12

CONST_3R	.REAL 12.0
; CONST: #142


; CONST: ${clear}{down*8}
CONST_5	.BYTE 15
.STRG "{clear}{down*8}"
; CONST: #15

CONST_6R	.REAL 15.0
; CONST: $blackjack
CONST_7	.BYTE 9
.STRG "blackjack"
; CONST: $copyright 1978
CONST_8	.BYTE 14
.STRG "copyright 1978"
; CONST: #4

CONST_9R	.REAL 4.0
; CONST: $commodore business machines inc
CONST_10	.BYTE 31
.STRG "commodore business machines inc"
; CONST: #1000

CONST_11R	.REAL 1000.0
; CONST: $
CONST_12	.BYTE 0
.STRG ""
; CONST: #1

MOSTCOMMON
CONST_13R	.REAL 1.0
; CONST: #30

CONST_14R	.REAL 30.0
; CONST: $
CONST_15	.BYTE 1
.STRG " "
; CONST: #0

CONST_16R	.REAL 0.0
; CONST: $s h u f f l i n g
CONST_17	.BYTE 17
.STRG "s h u f f l i n g"
; CONST: #51

CONST_18R	.REAL 51.0
; CONST: ${reverse on}a{down}{left}
CONST_19	.BYTE 25
.STRG "{reverse on}a{down}{left}"
; CONST: ${right*2}{down} {left}{down*2}
CONST_20	.BYTE 30
.STRG "{right*2}{down} {left}{down*2}"
; CONST: ${left}{down*2} {right*2}{down}
CONST_21	.BYTE 30
.STRG "{left}{down*2} {right*2}{down}"
; CONST: ${down}{left}a{reverse off}
CONST_22	.BYTE 26
.STRG "{down}{left}a{reverse off}"
; CONST: ${reverse on}2{down}{left}
CONST_23	.BYTE 25
.STRG "{reverse on}2{down}{left}"
; CONST: ${right*2}{down}
CONST_24	.BYTE 15
.STRG "{right*2}{down}"
; CONST: ${left}{down*4}
CONST_25	.BYTE 14
.STRG "{left}{down*4}"
; CONST: ${down}{left}2{reverse off}
CONST_26	.BYTE 26
.STRG "{down}{left}2{reverse off}"
; CONST: ${reverse on}3{down}{left}
CONST_27	.BYTE 25
.STRG "{reverse on}3{down}{left}"
; CONST: ${left}{down*2}
CONST_28	.BYTE 14
.STRG "{left}{down*2}"
; CONST: ${down}{left}3{reverse off}
CONST_29	.BYTE 26
.STRG "{down}{left}3{reverse off}"
; CONST: ${reverse on}{up*4}{left*3}
CONST_30	.BYTE 26
.STRG "{reverse on}{up*4}{left*3}"
; CONST: ${reverse on}{down*2}
CONST_31	.BYTE 20
.STRG "{reverse on}{down*2}"
; CONST: ${up*9}
CONST_32	.BYTE 6
.STRG "{up*9}"
; CONST: ${left*7}
CONST_33	.BYTE 8
.STRG "{left*7}"
; CONST: $10{down}{right}{down}
CONST_34	.BYTE 21
.STRG "10{down}{right}{down}"
; CONST: ${right*2}{down*2}{left}10{reverse off}
CONST_35	.BYTE 38
.STRG "{right*2}{down*2}{left}10{reverse off}"
; CONST: ${down}{reverse on}{space*2}{reverse on}{cm asterisk}{reverse off} {reverse on}{sh pound}{right*2}
CONST_36	.BYTE 97
.STRG "{down}{reverse on}{space*2}{reverse on}{cm asterisk}{reverse off} {reverse on}{sh pound}{right*2}"
; CONST: ${down}{right}G{cm n} {cm g}{right*2}
CONST_37	.BYTE 36
.STRG "{down}{right}G{cm n} {cm g}{right*2}"
; CONST: ${down}{right}G{reverse off}{space*3}{right*3}
CONST_38	.BYTE 45
.STRG "{down}{right}G{reverse off}{space*3}{right*3}"
; CONST: ${down}{reverse on}G{reverse off}{space*3}{reverse on}H{right}
CONST_39	.BYTE 61
.STRG "{down}{reverse on}G{reverse off}{space*3}{reverse on}H{right}"
; CONST: ${reverse on}{down}{right} {reverse off}{space*3}{reverse on}H{right}
CONST_40	.BYTE 68
.STRG "{reverse on}{down}{right} {reverse off}{space*3}{reverse on}H{right}"
; CONST: ${down}{right*2}{reverse off}{space*3}{reverse on}H{right}
CONST_41	.BYTE 57
.STRG "{down}{right*2}{reverse off}{space*3}{reverse on}H{right}"
; CONST: ${right*2}{cm m*2}{cm g}H{right}
CONST_42	.BYTE 31
.STRG "{right*2}{cm m*2}{cm g}H{right}"
; CONST: ${reverse off}{down}{right*2}{sh pound} {cm asterisk}{reverse off}{right*2}
CONST_43	.BYTE 74
.STRG "{reverse off}{down}{right*2}{sh pound} {cm asterisk}{reverse off}{right*2}"
; CONST: ${down}{reverse on}{space*2}{reverse on}{sh pound}{cm t}T {right}
CONST_44	.BYTE 64
.STRG "{down}{reverse on}{space*2}{reverse on}{sh pound}{cm t}T {right}"
; CONST: ${down}{right}{reverse off}{sh pound}{reverse on}B {cm j}{right*2}
CONST_45	.BYTE 65
.STRG "{down}{right}{reverse off}{sh pound}{reverse on}B {cm j}{right*2}"
; CONST: ${down}{right}{reverse off}{space*4}{reverse on}{cm f}{right*2}
CONST_46	.BYTE 62
.STRG "{down}{right}{reverse off}{space*4}{reverse on}{cm f}{right*2}"
; CONST: ${reverse off}{down}{space*5}
CONST_47	.BYTE 28
.STRG "{reverse off}{down}{space*5}"
; CONST: ${down}{right*2}{reverse on}{cm c}{reverse off}{space*4}
CONST_48	.BYTE 55
.STRG "{down}{right*2}{reverse on}{cm c}{reverse off}{space*4}"
; CONST: ${reverse on}{down}{right*3}{cm l} {sh -}{sh pound}
CONST_49	.BYTE 50
.STRG "{reverse on}{down}{right*3}{cm l} {sh -}{sh pound}"
; CONST: ${reverse off}{down}{right*2}{reverse on} Y{cm @}{reverse off}{sh pound}{reverse off}{right*2}
CONST_50	.BYTE 93
.STRG "{reverse off}{down}{right*2}{reverse on} Y{cm @}{reverse off}{sh pound}{reverse off}{right*2}"
; CONST: ${down}{reverse on}{space*2}{reverse on}{cm asterisk}{reverse off}{space*2}{reverse on}{sh pound}{right*2}
CONST_51	.BYTE 105
.STRG "{down}{reverse on}{space*2}{reverse on}{cm asterisk}{reverse off}{space*2}{reverse on}{sh pound}{right*2}"
; CONST: ${down} {cm n} {reverse off} {right*2}
CONST_52	.BYTE 37
.STRG "{down} {cm n} {reverse off} {right*2}"
; CONST: ${down}{right}{reverse off}{sh pound}{space*3}{cm c}{right}
CONST_53	.BYTE 58
.STRG "{down}{right}{reverse off}{sh pound}{space*3}{cm c}{right}"
; CONST: ${down}{reverse on} {reverse off}{space*5}{reverse on}
CONST_54	.BYTE 54
.STRG "{down}{reverse on} {reverse off}{space*5}{reverse on} "
; CONST: ${down}{right}{reverse off}{cm f}{reverse off}{space*3}{reverse on}{sh pound}
CONST_55	.BYTE 76
.STRG "{down}{right}{reverse off}{cm f}{reverse off}{space*3}{reverse on}{sh pound}"
; CONST: ${right*2} {reverse off} {reverse on}{cm m}{cm g}{right}
CONST_56	.BYTE 55
.STRG "{right*2} {reverse off} {reverse on}{cm m}{cm g}{right}"
; CONST: ${reverse off}{down}{right*2}{sh pound}{space*2}{cm asterisk}{right*2}
CONST_57	.BYTE 69
.STRG "{reverse off}{down}{right*2}{sh pound}{space*2}{cm asterisk}{right*2}"
; CONST: ${reverse on}{sh space}{down}{left}
CONST_58	.BYTE 35
.STRG "{reverse on}{sh space}{down}{left} "
; CONST: ${right*3}
CONST_59	.BYTE 9
.STRG "{right*3}"
; CONST: ${down*6}{left*5}
CONST_60	.BYTE 16
.STRG "{down*6}{left*5}"
; CONST: $ {reverse off}
CONST_61	.BYTE 14
.STRG " {reverse off}"
; CONST: ${reverse on}{left*6}{up*3}
CONST_62	.BYTE 26
.STRG "{reverse on}{left*6}{up*3}"
; CONST: ${down*3}{right}{reverse off}
CONST_63	.BYTE 28
.STRG "{down*3}{right}{reverse off}"
; CONST: ${reverse on}{up*4}{left*6}
CONST_64	.BYTE 26
.STRG "{reverse on}{up*4}{left*6}"
; CONST: ${down*2}{left*5}
CONST_65	.BYTE 16
.STRG "{down*2}{left*5}"
; CONST: ${down*2}{right}{reverse off}
CONST_66	.BYTE 28
.STRG "{down*2}{right}{reverse off}"
; CONST: $p
CONST_67	.BYTE 1
.STRG "p"
; CONST: ${left}{down}
CONST_68	.BYTE 12
.STRG "{left}{down}"
; CONST: ${down*9}
CONST_69	.BYTE 8
.STRG "{down*9}"
; CONST: ${right*7}
CONST_70	.BYTE 9
.STRG "{right*7}"
; CONST: ${left*2}{up*2}
CONST_71	.BYTE 14
.STRG "{left*2}{up*2}"
; CONST: ${up}{left}
CONST_72	.BYTE 10
.STRG "{up}{left}"
; CONST: ${left}{reverse off}
CONST_73	.BYTE 19
.STRG "{left}{reverse off}"
; CONST: $d
CONST_74	.BYTE 1
.STRG "d"
; CONST: ${reverse on}{down}
CONST_75	.BYTE 18
.STRG "{reverse on}{down}"
; CONST: ${reverse on}{up*3}{left*3}
CONST_76	.BYTE 26
.STRG "{reverse on}{up*3}{left*3}"
; CONST: ${right*3}{down*4}{reverse off}
CONST_77	.BYTE 30
.STRG "{right*3}{down*4}{reverse off}"
; CONST: #3

CONST_78R	.REAL 3.0
; CONST: $you win
CONST_79	.BYTE 7
.STRG "you win"
; CONST: $you split
CONST_80	.BYTE 9
.STRG "you split"
; CONST: $dealer wins
CONST_81	.BYTE 11
.STRG "dealer wins"
; CONST: ${home}
CONST_82	.BYTE 6
.STRG "{home}"
; CONST: #20

CONST_83R	.REAL 20.0
; CONST: #19

CONST_84R	.REAL 19.0
; CONST: $your bet?
CONST_85	.BYTE 10
.STRG "your bet? "
; CONST: #6

CONST_86R	.REAL 6.0
; CONST: #25000

CONST_87R	.REAL 25000.0
; CONST: $house limit = $25000
CONST_88	.BYTE 20
.STRG "house limit = $25000"
; CONST: $bet $
CONST_89	.BYTE 5
.STRG "bet $"
; CONST: #36

CONST_90R	.REAL 36.0
; CONST: #2

CONST_91R	.REAL 2.0
; CONST: #5

CONST_92R	.REAL 5.0
; CONST: $you have
CONST_93	.BYTE 8
.STRG "you have"
; CONST: #21

CONST_94R	.REAL 21.0
; CONST: #22

CONST_95R	.REAL 22.0
; CONST: $do you want a hit?(y/n)
CONST_96	.BYTE 23
.STRG "do you want a hit?(y/n)"
; CONST: $/d)
CONST_97	.BYTE 3
.STRG "/d)"
; CONST: $y
CONST_98	.BYTE 1
.STRG "y"
; CONST: $n
CONST_99	.BYTE 1
.STRG "n"
; CONST: #16

CONST_100R	.REAL 16.0
; CONST: ${home}{down}
CONST_101	.BYTE 12
.STRG "{home}{down}"
; CONST: ${reverse off}busted with
CONST_102	.BYTE 24
.STRG "{reverse off}busted with"
; CONST: #9

CONST_103R	.REAL 9.0
; CONST: #8

CONST_104R	.REAL 8.0
; CONST: ${reverse off}dealer has
CONST_105	.BYTE 23
.STRG "{reverse off}dealer has"
; CONST: $broke even
CONST_106	.BYTE 10
.STRG "broke even"
; CONST: $winning $
CONST_107	.BYTE 9
.STRG "winning $"
; CONST: $losing $
CONST_108	.BYTE 8
.STRG "losing $"
; CONST: ${reverse off}
CONST_109	.BYTE 13
.STRG "{reverse off}"
; CONST: #32


; CONST: #10

CONST_111R	.REAL 10.0
; CONST: ${down*9}{down*3}
CONST_112	.BYTE 16
.STRG "{down*9}{down*3}"
; CONST: ${up}{reverse on}
CONST_113	.BYTE 16
.STRG "{up}{reverse on}"
; CONST: ${up}{reverse off}
CONST_114	.BYTE 17
.STRG "{up}{reverse off}"
; CONST: #7


; CONST: #11

CONST_116R	.REAL 11.0
; CONST: #13

CONST_117R	.REAL 13.0
; CONST: ${up}
CONST_118	.BYTE 4
.STRG "{up}"
; CONST: ${space*3}{left*3}
CONST_119	.BYTE 17
.STRG "{space*3}{left*3}"
; CONST: ${space*8}
CONST_120	.BYTE 9
.STRG "{space*8}"
; CONST: $ASXZa234567891jqk
CONST_121	.BYTE 17
.STRG "ASXZa234567891jqk"
; CONST: ${down}
CONST_122	.BYTE 6
.STRG "{down}"
; CONST: ${right}
CONST_123	.BYTE 7
.STRG "{right}"
; CONST: ${reverse on}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}
CONST_124	.BYTE 174
.STRG "{reverse on}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}"
; CONST: ${cm +*7}
CONST_125	.BYTE 8
.STRG "{cm +*7}"
; CONST: ${down}{left*7}
CONST_126	.BYTE 14
.STRG "{down}{left*7}"
; CONST: ${reverse on}{space*7}{reverse off}
CONST_127	.BYTE 34
.STRG "{reverse on}{space*7}{reverse off}"
; CONST: $do you want to split?(y/n)
CONST_128	.BYTE 26
.STRG "do you want to split?(y/n)"
; CONST: ${down*3}
CONST_129	.BYTE 8
.STRG "{down*3}"
; CONST: #-1.0

CONST_130	.REAL -1.0
; CONST: $busted with
CONST_131	.BYTE 11
.STRG "busted with"
; CONST: $dealer won
CONST_132	.BYTE 10
.STRG "dealer won"
; CONST: #1.5

CONST_133	.REAL 1.5
; CONST: $you win with {reverse on}blackjack{reverse off}
CONST_134	.BYTE 47
.STRG "you win with {reverse on}blackjack{reverse off}"
; CONST: $you have 21
CONST_135	.BYTE 11
.STRG "you have 21"
; CONST: $dealer wins with {reverse on}blackjack
CONST_136	.BYTE 38
.STRG "dealer wins with {reverse on}blackjack"
; CONST: $this is a push
CONST_137	.BYTE 14
.STRG "this is a push"
; CONST: $both have blackjack
CONST_138	.BYTE 19
.STRG "both have blackjack"
; CONST: $5 card charlie !
CONST_139	.BYTE 16
.STRG "5 card charlie !"
; CONST: $insurance?(y/n)
CONST_140	.BYTE 15
.STRG "insurance?(y/n)"
; CONST: $insurance bet $
CONST_141	.BYTE 15
.STRG "insurance bet $"
; CONST: $no blackjack lost your insurance
CONST_142	.BYTE 32
.STRG "no blackjack lost your insurance"
; CONST: ${home}{up}{reverse off}
CONST_143	.BYTE 23
.STRG "{home}{up}{reverse off}"
; CONST: ${space*2}
CONST_144	.BYTE 9
.STRG "{space*2}"
; CONST: ${left}
CONST_145	.BYTE 6
.STRG "{left}"
; CONST: ${cm +}
CONST_146	.BYTE 6
.STRG "{cm +}"
; CONST: $ {left}
CONST_147	.BYTE 7
.STRG " {left}"
; CONST: #127

CONST_148R	.REAL 127.0
; CONST: #69

CONST_149R	.REAL 69.0
; CONST: #29

CONST_150R	.REAL 29.0
; CONST: #17

CONST_151R	.REAL 17.0
; CONST: #34

CONST_152R	.REAL 34.0
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: I
VAR_I	.REAL 0.0
; VAR: Z1
VAR_Z1	.REAL 0.0
; VAR: FF
VAR_FF	.REAL 0.0
; VAR: C%[]
.BYTE 0
.WORD 104
VAR_C%[]	.ARRAY 104
; VAR: R
VAR_R	.REAL 0.0
; VAR: TE
VAR_TE	.REAL 0.0
; VAR: Z
VAR_Z	.REAL 0.0
; VAR: TY
VAR_TY	.REAL 0.0
; VAR: T
VAR_T	.REAL 0.0
; VAR: B
VAR_B	.REAL 0.0
; VAR: A
VAR_A	.REAL 0.0
; VAR: C
VAR_C	.REAL 0.0
; VAR: V
VAR_V	.REAL 0.0
; VAR: VV
VAR_VV	.REAL 0.0
; VAR: X7
VAR_X7	.REAL 0.0
; VAR: X8
VAR_X8	.REAL 0.0
; VAR: Z9
VAR_Z9	.REAL 0.0
; VAR: BJ
VAR_BJ	.REAL 0.0
; VAR: X1
VAR_X1	.REAL 0.0
; VAR: X2
VAR_X2	.REAL 0.0
; VAR: H
VAR_H	.REAL 0.0
; VAR: DD
VAR_DD	.REAL 0.0
; VAR: X3
VAR_X3	.REAL 0.0
; VAR: D2
VAR_D2	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: D1
VAR_D1	.REAL 0.0
; VAR: P2
VAR_P2	.REAL 0.0
; VAR: D4
VAR_D4	.REAL 0.0
; VAR: CC
VAR_CC	.REAL 0.0
; VAR: P1
VAR_P1	.REAL 0.0
; VAR: X9
VAR_X9	.REAL 0.0
; VAR: F
VAR_F	.REAL 0.0
; VAR: J
VAR_J	.REAL 0.0
STRINGVARS_START
; VAR: B$
VAR_B$	.WORD EMPTYSTR
; VAR: W$
VAR_W$	.WORD EMPTYSTR
; VAR: Y$
VAR_Y$	.WORD EMPTYSTR
; VAR: X$
VAR_X$	.WORD EMPTYSTR
; VAR: N$
VAR_N$	.WORD EMPTYSTR
; VAR: D2$
VAR_D2$	.WORD EMPTYSTR
; VAR: D5$
VAR_D5$	.WORD EMPTYSTR
; VAR: D1$
VAR_D1$	.WORD EMPTYSTR
; VAR: D3$
VAR_D3$	.WORD EMPTYSTR
; VAR: D4$
VAR_D4$	.WORD EMPTYSTR
; VAR: D6$
VAR_D6$	.WORD EMPTYSTR
; VAR: T5$
VAR_T5$	.WORD EMPTYSTR
; VAR: J$
VAR_J$	.WORD EMPTYSTR
; VAR: Z1$
VAR_Z1$	.WORD EMPTYSTR
; VAR: Z2$
VAR_Z2$	.WORD EMPTYSTR
; VAR: Z$
VAR_Z$	.WORD EMPTYSTR
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
