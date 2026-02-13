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
LDY #1
STY 646
; Optimizer rule: Simple POKE/2
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_20:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
STY 53281
; Optimizer rule: Simple POKE/2
;
LINE_40:
;
LDA #<CONST_3
LDY #>CONST_3
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_45:
;
LDY #5
STY 646
; Optimizer rule: Simple POKE/2
LDA #<CONST_5
LDY #>CONST_5
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_46:
;
LDY #1
STY 646
; Optimizer rule: Simple POKE/2
;
LINE_50:
;
LDX #4
dcloop235_1:
LDA CONST_6R,X
STA VAR_Y,X
DEX
BPL dcloop235_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_7
LDY #>CONST_7
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_T$
LDY #>VAR_T$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_10000
;
LINE_60:
;
LDX #4
dcloop235_2:
LDA CONST_8R,X
STA VAR_Y,X
DEX
BPL dcloop235_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_9
LDY #>CONST_9
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_T$
LDY #>VAR_T$
JSR COPYSTRING
; Optimizer rule: Simplified loading of Strings/5
JSR GOSUB
JSR LINE_10000
;
LINE_70:
;
JSR GOSUB
JSR LINE_15000
;
LINE_80:
;
JSR GOSUB
JSR LINE_20000
;
LINE_90:
;
JSR GOSUB
JSR LINE_40000
JSR GOSUB
JSR LINE_41000
;
LINE_100:
;
JSR GOSUB
JSR LINE_5000
;
LINE_1000:
;
LDA #147
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<CONST_10
LDY #>CONST_10
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR END
RTS
;
LINE_5000:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_EP%
STA VAR_EP%+1
;
LINE_5010:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_CF%
STA VAR_CF%+1
JSR GOSUB
JSR LINE_8200
JSR GOSUB
JSR LINE_8000
JSR GETADOLLAR
; Optimizer rule: Memory saving GET A$/1
JSR GOSUB
JSR LINE_8100
;
LINE_5015:
;
LDA #<CONST_11
LDY #>CONST_11
STA B_REG
STY B_REG+1
LDA VAR_A$
LDY VAR_A$+1
STA A_REG
STY A_REG+1
; ignored: CHGCTX #0
JSR SEQ
LDA X_REG
COMP_SKP0:
BEQ LINE_SKIP28
; Simplified conditional branch
;
LINE_NSKIP28:
;
JMP LINE_5010
;
LINE_SKIP28:
;
;
LINE_5020:
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
COMP_SKP1:
BEQ LINE_SKIP29
; Simplified conditional branch
;
LINE_NSKIP29:
;
JMP RETURN
;
LINE_SKIP29:
;
;
LINE_5025:
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
COMP_SKP2:
BEQ LINE_SKIP30
; Simplified conditional branch
;
LINE_NSKIP30:
;
JSR GOSUB
JSR LINE_20010
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_CF%
STA VAR_CF%+1
JMP LINE_5200
;
LINE_SKIP30:
;
;
LINE_5030:
;
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR ASC
LDA #0
LDY TMP2_ZP
STY VAR_AC%
STA VAR_AC%+1
; Optimizer rule: ASC to integer variable/5
LDA #$1d
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_AC%
LDA VAR_AC%+1
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
COMP_SKP3:
BNE LINE_SKIP31
LINE_NSKIP31:
; Optimizer rule: Simplified equal comparison/6
;
LDY VAR_EP%
LDA VAR_EP%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_EP%
STA VAR_EP%+1
JMP LINE_5070
;
LINE_SKIP31:
;
;
LINE_5040:
;
LDA #$9d
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_AC%
LDA VAR_AC%+1
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
COMP_SKP4:
BNE LINE_SKIP32
LINE_NSKIP32:
; Optimizer rule: Simplified equal comparison/6
;
LDY VAR_EP%
LDA VAR_EP%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_EP%
STA VAR_EP%+1
JMP LINE_5070
;
LINE_SKIP32:
;
;
LINE_5050:
;
LDA #$11
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_AC%
LDA VAR_AC%+1
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
BEQ EQ_EQ2
LDA #0
JMP EQ_SKIP2
EQ_EQ2:
LDA #$1
EQ_SKIP2:
COMP_SKP5:
BNE LINE_NSKIP33
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP33
;
LINE_NSKIP33:
;
LDY #$00
LDA #$08
STY TMP4_REG+1
STA TMP4_REG
LDY VAR_EP%
LDA VAR_EP%+1
JSR INTADDOPT16X
STY VAR_EP%
STA VAR_EP%+1
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
JMP LINE_5070
;
LINE_SKIP33:
;
;
LINE_5060:
;
LDA #$91
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_AC%
LDA VAR_AC%+1
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
BEQ EQ_EQ3
LDA #0
JMP EQ_SKIP3
EQ_EQ3:
LDA #$1
EQ_SKIP3:
COMP_SKP6:
BNE LINE_NSKIP34
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP34
;
LINE_NSKIP34:
;
LDY #$00
LDA #$08
STY TMP4_REG+1
STA TMP4_REG
LDY VAR_EP%
LDA VAR_EP%+1
JSR INTSUBOPT16X
STY VAR_EP%
STA VAR_EP%+1
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
LINE_SKIP34:
;
;
LINE_5070:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_EP%
LDA VAR_EP%+1
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
BEQ LT_LT_EQ4
ROL
BCC LT_LT4
LT_LT_EQ4:
LDA #0
JMP LT_SKIP4
LT_LT4:
LDA #$1
LT_SKIP4:
COMP_SKP7:
BNE LINE_NSKIP35
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP35
;
LINE_NSKIP35:
;
LDY #$00
LDA #$10
STY TMP4_REG+1
STA TMP4_REG
LDY VAR_EP%
LDA VAR_EP%+1
JSR INTADDOPT16X
STY VAR_EP%
STA VAR_EP%+1
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
LINE_SKIP35:
;
;
LINE_5080:
;
LDA #$0f
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_EP%
LDA VAR_EP%+1
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
COMP_SKP8:
BNE LINE_NSKIP36
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP36
;
LINE_NSKIP36:
;
LDY #$00
LDA #$10
STY TMP4_REG+1
STA TMP4_REG
LDY VAR_EP%
LDA VAR_EP%+1
JSR INTSUBOPT16X
STY VAR_EP%
STA VAR_EP%+1
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
LINE_SKIP36:
;
;
LINE_5090:
;
LDA #$08
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_EP%
LDA VAR_EP%+1
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
BEQ LT_LT_EQ6
ROL
BCC LT_LT6
LT_LT_EQ6:
LDA #0
JMP LT_SKIP6
LT_LT6:
LDA #$1
LT_SKIP6:
COMP_SKP9:
BEQ LINE_SKIP37
; Simplified conditional branch
;
LINE_NSKIP37:
;
JSR GOSUB
JSR LINE_6000
JMP LINE_5200
;
LINE_SKIP37:
;
;
LINE_5100:
;
JSR GOSUB
JSR LINE_6500
;
LINE_5200:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_CF%
LDA VAR_CF%+1
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
EQ_EQ7:
EQ_SKIP7:
COMP_SKP10:
BNE LINE_SKIP38
LINE_NSKIP38:
; Optimizer rule: Simplified equal comparison/6
;
JSR GOSUB
JSR LINE_7000
;
LINE_SKIP38:
;
;
LINE_5999:
;
JMP LINE_5010
;
LINE_6000:
;
LDY VAR_EP%
LDA VAR_EP%+1
JSR INTFAC
LDA #<CONST_21R
LDY #>CONST_21R
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
; FAC to integer in Y/A
JSR FACINT
STY VAR_BP%
STA VAR_BP%+1
;
LINE_6010:
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
COMP_SKP11:
BNE LINE_NSKIP39
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP39
;
LINE_NSKIP39:
;
LDY VAR_BP%
LDA VAR_BP%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: Avoid PUSH/POP for INT/2
; Optimizer rule: POP and XREG combined/1
; Optimizer rule: FAC 2 X_REG(2)/1
LDA #<CONST_23
LDY #>CONST_23
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_CF%
STA VAR_CF%+1
JMP RETURN
;
LINE_SKIP39:
;
;
LINE_6020:
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
COMP_SKP12:
BNE LINE_NSKIP40
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP40
;
LINE_NSKIP40:
;
LDY #0
TYA
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
STA G_REG
STY G_REG+1
LDY VAR_BP%
LDA VAR_BP%+1
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimizer rule: Faster INT-Array store/11
; Optimizer rule: Array content is integer (store)/9
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_CF%
STA VAR_CF%+1
JMP RETURN
;
LINE_SKIP40:
;
;
LINE_6030:
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
COMP_SKP13:
BNE LINE_NSKIP41
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP41
;
LINE_NSKIP41:
;
LDY #1
LDA #0
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
STA G_REG
STY G_REG+1
LDY VAR_BP%
LDA VAR_BP%+1
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimizer rule: Faster INT-Array store/11
; Optimizer rule: Array content is integer (store)/9
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_CF%
STA VAR_CF%+1
JMP RETURN
;
LINE_SKIP41:
;
;
LINE_6040:
;
JMP RETURN
;
LINE_6500:
;
LDY #$00
LDA #$08
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_EP%
LDA VAR_EP%+1
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
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: FAC->YREG, YREG->FAC/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(1)/1
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
; FAC to integer in Y/A
JSR FACINT
STY VAR_BP%
STA VAR_BP%+1
;
LINE_6510:
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
JSR SGT
JSR REALFACPUSHXREG
; Optimizer rule: Faster stack pushes/1
; Optimizer rule: Load and PUSH combined/1
; ignored: CHGCTX #1
LDA #<CONST_24
LDY #>CONST_24
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
COMP_SKP14:
BEQ LINE_SKIP42
; Simplified conditional branch
;
LINE_NSKIP42:
;
JMP RETURN
;
LINE_SKIP42:
;
;
LINE_6520:
;
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR VAL
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACINT
STY VAR_AV%
STA VAR_AV%+1
; Value already in Y/A
;
;
STY AS_TMP
STA AS_TMP+1
LDA #<VAR_B1%[]
LDY #>VAR_B1%[]
STA G_REG
STY G_REG+1
LDY VAR_BP%
LDA VAR_BP%+1
JSR ARRAYSTORE_INT_INTEGER_AC
; Optimizer rule: Faster INT-Array store/11
; Optimizer rule: Array content is integer (store)/9
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_CF%
STA VAR_CF%+1
JMP RETURN
;
LINE_7000:
;
LDY #11
STY 53280
; Optimizer rule: Simple POKE/2
JSR GOSUB
JSR LINE_21000
JSR GOSUB
JSR LINE_22000
;
LINE_7010:
;
JSR GOSUB
JSR LINE_40000
JSR GOSUB
JSR LINE_41000
;
LINE_7020:
;
LDY #0
STY 53280
; Optimizer rule: Simple POKE/2
JMP RETURN
;
LINE_8000:
;
;
LINE_8010:
;
LDY VAR_CP%
LDA VAR_CP%+1
STY MOVBSELF8+1
; Optimizer rule: Remove INTFAC/FACWORD/3
STA MOVBSELF8+2
MOVBSELF8:
LDY $FFFF
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_OC%
STA VAR_OC%+1
LDY VAR_CP%
LDA VAR_CP%+1
STY MOVBSELF9+1
; Optimizer rule: Remove INTFAC/FACWORD/3
STA MOVBSELF9+2
LDA #$A0
MOVBSELF9:
STA $FFFF
JMP RETURN
;
LINE_8100:
;
;
LINE_8110:
;
LDY VAR_CP%
LDA VAR_CP%+1
; integer in Y/A to FAC
STY MOVBSELF10+1
STA MOVBSELF10+2
; Faster POKE of integers
;
;
;
;
LDY VAR_OC%
MOVBSELF10:
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
JMP RETURN
;
LINE_8200:
;
LDA VAR_EP%+1
AND #$00
TAX
LDY VAR_EP%
TYA
AND #$07
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
LDY #1
STY A_REG
; Optimizer rule: Omit XREG->FAC/3
JSR SHL
; Optimizer rule: Shorter SHL/4
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #$07
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_EP%
LDA VAR_EP%+1
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
LDY #2
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
LDA #<CONST_21R
LDY #>CONST_21R
JSR COPY2_XYA_XREG
; Optimizer rule: FAC->YREG, YREG->FAC/3
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFSUBMEM
; Optimizer rule: Fast FSUB (MEM)/1
; Optimizer rule: Combine load and sub/1
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
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTFADDARG
; Optimizer rule: Fast FADD (ARG)/1
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
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
STY VAR_CP%
STA VAR_CP%+1
JMP RETURN
;
LINE_10000:
;
JSR GOSUB
JSR LINE_30000
;
LINE_10005:
;
JSR GOSUB
JSR LINE_11000
;
LINE_10010:
;
LDA #176
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_10020:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_33R
LDY #>CONST_33R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
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
LDA #99
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #178
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
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
LINE_10030:
;
LDA #99
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #174
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10040:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_17R
LDY #>CONST_17R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
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
LDA #98
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
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
JSR LINEBREAK
;
LINE_10050:
;
LDA #173
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_10060:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_33R
LDY #>CONST_33R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
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
LDA #99
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #177
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
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
LINE_10070:
;
LDA #99
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #189
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_10080:
;
JMP RETURN
;
LINE_11000:
;
LDY #7
STY 646
; Optimizer rule: Simple POKE/2
LDA VAR_T$
LDY VAR_T$+1
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDY #1
STY 646
; Optimizer rule: Simple POKE/2
LDX #4
dcloop1895_1:
LDA CONST_21R,X
STA VAR_I,X
DEX
BPL dcloop1895_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_23
LDY #>CONST_23
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
LINE_11010:
;
LDA #32
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
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
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR RIGHT
JSR STROUT
;
LINE_11020:
;
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
JSR LINEBREAK
JMP RETURN
;
LINE_15000:
;
LDX #4
dcloop2061_1:
LDA CONST_33R,X
STA VAR_Y,X
DEX
BPL dcloop2061_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_30000
;
LINE_15010:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #176
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_15020:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
LDA #99
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
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
LINE_15030:
;
LDA #174
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR LINEBREAK
;
LINE_15040:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
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
LINE_15050:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #98
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDA #<CONST_17R
LDY #>CONST_17R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #98
JSR SINGLECHROUTBRKMAX
; Optimizer rule: Memory saving single char out(2)/2
; Optimizer rule: Single character output and break/2
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_15060:
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
LINE_15070:
;
LDA #<CONST_14R
LDY #>CONST_14R
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #173
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_15080:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
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
LDA #99
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
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
LINE_15090:
;
LDA #189
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JMP RETURN
;
LINE_20000:
;
;
LINE_20010:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
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
LDA #<CONST_23
LDY #>CONST_23
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
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
LDA #<VAR_B1%[]
LDY #>VAR_B1%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_29R
LDY #>CONST_29R
JSR MEMARG
JSR FACPOW
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
JSR POPREALXREG
; Optimizer rule: POP and XREG combined/1
LDA #<VAR_PT%[]
LDY #>VAR_PT%[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_INTEGER_NX
; Optimizer rule: Value already in FAC(1)/6
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
LINE_20020:
;
JSR GOSUB
JSR LINE_21000
JSR GOSUB
JSR LINE_22000
;
LINE_20030:
;
JMP RETURN
;
LINE_21000:
;
LDX #4
dcloop2559_1:
LDA CONST_6R,X
STA VAR_Y,X
DEX
BPL dcloop2559_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_30000
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
LINE_21010:
;
LDX #4
dcloop2559_2:
LDA CONST_21R,X
STA VAR_I,X
DEX
BPL dcloop2559_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_23
LDY #>CONST_23
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP8
STA JUMP_TARGET
LDA #>FORLOOP8
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP8:
;
LINE_21020:
;
LDA #29
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_21030:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
JSR ARRAYACCESS_INTEGER_S
LDA #$ff
LDY #$ff
STA TMP_ZP
STY TMP_ZP+1
LDY TMP2_ZP
LDA TMP2_ZP+1
JSR ICMP
; Optimized code for Integer(4)
;
EQ_EQ9:
EQ_SKIP9:
COMP_SKP23:
BNE LINE_SKIP43
LINE_NSKIP43:
; Optimizer rule: Simplified equal comparison/6
;
LDA #46
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_SKIP43:
;
;
LINE_21040:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDA X_REG
BEQ EQ_EQ10
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP10
EQ_EQ10:
LDA #$1
EQ_SKIP10:
COMP_SKP24:
BEQ LINE_SKIP44
; Simplified conditional branch
;
LINE_NSKIP44:
;
LDA #48
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_SKIP44:
;
;
LINE_21050:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
JSR ARRAYACCESS_INTEGER_S
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY TMP2_ZP
LDA TMP2_ZP+1
JSR ICMP
; Optimized code for Integer(6)
;
EQ_EQ11:
EQ_SKIP11:
COMP_SKP25:
BNE LINE_SKIP45
LINE_NSKIP45:
; Optimizer rule: Simplified equal comparison/6
;
LDA #49
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
;
LINE_SKIP45:
;
;
LINE_21060:
;
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
LINE_22000:
;
LDX #4
dcloop2891_1:
LDA CONST_8R,X
STA VAR_Y,X
DEX
BPL dcloop2891_1
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_30000
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
LINE_22010:
;
LDX #4
dcloop2891_2:
LDA CONST_21R,X
STA VAR_I,X
DEX
BPL dcloop2891_2
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_23
LDY #>CONST_23
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP9
STA JUMP_TARGET
LDA #>FORLOOP9
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP9:
;
LINE_22020:
;
LDA #29
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
JSR COMPACTMAX
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B1%[]
LDY #>VAR_B1%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
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
JSR POPREAL
LDX #<C_REG
LDY #>C_REG
; FAC to (X/Y)
JSR FACMEM
JSR RIGHT
JSR STROUT
;
LINE_22060:
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
LINE_30000:
;
LDA #19
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
LDX #4
dcloop3057_1:
LDA CONST_0R,X
STA VAR_I,X
DEX
BPL dcloop3057_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP10
STA JUMP_TARGET
LDA #>FORLOOP10
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP10:
LDA #17
JSR SINGLECHROUTMAX
; Optimizer rule: Memory saving single char out(1)/2
; Optimizer rule: Single character output/2
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
;
LINE_30010:
;
JMP RETURN
;
LINE_40000:
;
JSR GOSUB
JSR LINE_50000
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_I%
STA VAR_I%+1
;
LINE_40010:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_46R
LDY #>CONST_46R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP11
STA JUMP_TARGET
LDA #>FORLOOP11
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP11:
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_47
LDY #>CONST_47
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
LDY #63
LDA #0
STY A_REG
STA A_REG+1
JSR PEEKBYTEAND
JSR XREGFAC
; Optimizer rule: X_REG 2 FAC(1)/1
; FAC to integer in Y/A
JSR FACINT
STY VAR_BV%
STA VAR_BV%+1
JSR GOSUB
JSR LINE_51000
;
LINE_40020:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_49R
LDY #>CONST_49R
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0

; Optimizer rule: Remove PUSH/POP/1
JSR FACWORD
STY MOVBSELF13+1
STA MOVBSELF13+2
LDY VAR_BV%
MOVBSELF13:
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
;
LINE_40030:
;
LDY VAR_I%
LDA VAR_I%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_BV%
STA VAR_BV%+1
JSR GOSUB
JSR LINE_51000
LDY #$06
LDA #$d0
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_I%
LDA VAR_I%+1
JSR INTADD
; Optimized code for adding INTs (2)
;
;
;
;
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0

; Optimizer rule: Remove PUSH/POP/1
JSR FACWORD
STY MOVBSELF14+1
STA MOVBSELF14+2
LDY VAR_BV%
MOVBSELF14:
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
LINE_40040:
;
LDY VAR_I%
LDA VAR_I%+1
JSR SUPERFIINX
; Optimizer rule: Even faster INTEGER INC/1
STY VAR_I%
STA VAR_I%+1
LDA #$00
LDY #$01
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
BEQ LT_LT_EQ12
ROL
BCC LT_LT12
LT_LT_EQ12:
LDA #0
JMP LT_SKIP12
LT_LT12:
LDA #$1
LT_SKIP12:
COMP_SKP30:
BEQ LINE_SKIP46
; Simplified conditional branch
;
LINE_NSKIP46:
;
JMP LINE_40030
;
LINE_SKIP46:
;
;
LINE_40050:
;
JMP RETURN
;
LINE_41000:
;
JSR GOSUB
JSR LINE_50000
LDY #30
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_X%
STA VAR_X%+1
LDY #24
LDA #1
STY VAR_Y%
STA VAR_Y%+1
; Optimized code for negative constants)
;
;
;
;
LINE_41010:
;
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_20R
LDY #>CONST_20R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP12
STA JUMP_TARGET
LDA #>FORLOOP12
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP12:
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACINT
STY VAR_BV%
STA VAR_BV%+1
JSR GOSUB
JSR LINE_51000
;
LINE_41020:
;
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
LDY VAR_Y%
LDA VAR_Y%+1
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
STY VAR_SC%
STA VAR_SC%+1
;
LINE_41030:
;
LDY VAR_SC%
LDA VAR_SC%+1
STY MOVBSELF15+1
; Optimizer rule: Remove INTFAC/FACWORD/3
STA MOVBSELF15+2
LDA #$A0
MOVBSELF15:
STA $FFFF
LDY VAR_SC%
LDA VAR_SC%+1
JSR SUPERFIINX
; Optimizer rule: Faster INT+1/1
STY MOVBSELF16+1
STA MOVBSELF16+2
LDA #$A0
MOVBSELF16:
STA $FFFF
LDY #$00
LDA #$28
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_SC%
LDA VAR_SC%+1
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
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF17+1
STA MOVBSELF17+2
LDA #$A0
MOVBSELF17:
STA $FFFF
LDY #$00
LDA #$29
STA TMP3_ZP
STY TMP3_ZP+1
LDY VAR_SC%
LDA VAR_SC%+1
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
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF18+1
STA MOVBSELF18+2
LDA #$A0
MOVBSELF18:
STA $FFFF
;
LINE_41035:
;
LDA #<CONST_56
LDY #>CONST_56
JSR COPY2_XYA_YREG
; Optimizer rule: MEM 2 Y_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDY VAR_SC%
LDA VAR_SC%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACXREG
; Optimizer rule: FAC 2 X_REG(2)/1
JSR YREGFAC
; Optimizer rule: Y_REG 2 FAC(1)/1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR FASTFADDMEM
; Optimizer rule: Fast FADD (MEM)/1
; Optimizer rule: Combine load and add/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CC
LDY #>VAR_CC
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_CC
LDY #>VAR_CC
JSR REALFAC
; Optimizer rule: Remove FAC/PUSH/POP/1
JSR FACWORD
STY MOVBSELF19+1
STA MOVBSELF19+2
LDY VAR_BV%
MOVBSELF19:
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
LDY #$01
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_CC
LDY #>VAR_CC
JSR INTADDPOKE
STY MOVBSELF20+1
STA MOVBSELF20+2
; Fast add for POKE(2.1)
;
;
;
;
LDY VAR_BV%
MOVBSELF20:
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
LDY #$28
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_CC
LDY #>VAR_CC
JSR INTADDPOKE
STY MOVBSELF21+1
STA MOVBSELF21+2
; Fast add for POKE(1.1)
;
;
;
;
;
LDY VAR_BV%
MOVBSELF21:
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
LDY #$29
STY TMP_ZP
LDA #$00
STA TMP_ZP+1
LDA #<VAR_CC
LDY #>VAR_CC
JSR INTADDPOKE
STY MOVBSELF22+1
STA MOVBSELF22+2
; Fast add for POKE(1.1)
;
;
;
;
;
LDY VAR_BV%
MOVBSELF22:
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
LINE_41040:
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
BCS GT_GT13
LDA #0
JMP GT_SKIP13
GT_GT13:
LDA #$1
GT_SKIP13:
COMP_SKP31:
BNE LINE_NSKIP47
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP47
;
LINE_NSKIP47:
;
LDY #30
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_X%
STA VAR_X%+1
LDY #$00
LDA #$50
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
LINE_SKIP47:
;
;
LINE_41050:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_12
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_12:
JMP RETURN
;
LINE_50000:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_O%
STA VAR_O%+1
LDY #255
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_A%
STA VAR_A%+1
LDX #4
dcloop3721_1:
LDA CONST_21R,X
STA VAR_I,X
DEX
BPL dcloop3721_1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_2R
LDY #>CONST_2R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_23
LDY #>CONST_23
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP13
STA JUMP_TARGET
LDA #>FORLOOP13
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP13:
;
LINE_50010:
;
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_PT%[]
LDY #>VAR_PT%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_V%
STA VAR_V%+1
; Optimizer rule: Fast INTEGER array access (1)/3
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
JSR ARRAYACCESS_INTEGER_SI
STY VAR_B%
STA VAR_B%+1
; Optimizer rule: Fast INTEGER array access (1)/3
LDA #$ff
LDY #$ff
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_B%
LDA VAR_B%+1
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
EQ_EQ14:
EQ_SKIP14:
COMP_SKP33:
BNE LINE_SKIP48
LINE_NSKIP48:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_50050
;
LINE_SKIP48:
;
;
LINE_50020:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_B%
LDA VAR_B%+1
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
BEQ EQ_EQ15
LDA #0
JMP EQ_SKIP15
EQ_EQ15:
LDA #$1
EQ_SKIP15:
COMP_SKP34:
BNE LINE_NSKIP49
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP49
;
LINE_NSKIP49:
;
LDY VAR_A%
LDA VAR_A%+1
STY TMP3_ZP
STA TMP3_ZP+1
LDY VAR_V%
LDA VAR_V%+1
JSR INTSUBVAROPT
JSR INTCONV
; SUB VARs + STORE simplified
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
STY VAR_A%
STA VAR_A%+1
JMP LINE_50050
;
LINE_SKIP49:
;
;
LINE_50030:
;
LDA #$01
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_B%
LDA VAR_B%+1
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
BEQ EQ_EQ16
LDA #0
JMP EQ_SKIP16
EQ_EQ16:
LDA #$1
EQ_SKIP16:
COMP_SKP35:
BNE LINE_NSKIP50
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP50
;
LINE_NSKIP50:
;
LDY VAR_O%
LDA VAR_O%+1
STY TMP3_ZP
STA TMP3_ZP+1
LDY VAR_V%
LDA VAR_V%+1
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
STY VAR_O%
STA VAR_O%+1
;
LINE_SKIP50:
;
;
LINE_50050:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_13
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_13:
;
LINE_50060:
;
LDY #0
TYA
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_MD%
STA VAR_MD%+1
LDA #0
STA VAR_I
STA VAR_I+1
STA VAR_I+2
STA VAR_I+3
STA VAR_I+4
; Optimizer rule: Simplified setting to 0/6
LDA #<CONST_21R
LDY #>CONST_21R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
;LDA #<CONST_0R
;LDY #>CONST_0R
JSR REALFACPUSHMC
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP14
STA JUMP_TARGET
LDA #>FORLOOP14
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP14:
LDA #<VAR_I
LDY #>VAR_I
JSR COPY2_XYA_XREG
; Optimizer rule: MEM 2 X_REG/3
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_B1%[]
LDY #>VAR_B1%[]
JSR ARRAYACCESS_INTEGER_S
; Optimizer rule: Memory saving array access (integer)/3
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
NEQ_NEQ17:
NEQ_SKIP17:
COMP_SKP37:
BEQ LINE_SKIP51
LINE_NSKIP51:
; Optimizer rule: Simplified not equal comparison/6
;
LDY #1
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_MD%
STA VAR_MD%+1
LDX #4
dcloop4219_1:
LDA CONST_17R,X
STA VAR_I,X
DEX
BPL dcloop4219_1
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP51:
;
;
LINE_50070:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_14
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_14:
;
LINE_50080:
;
JMP RETURN
;
LINE_51000:
;
LDA VAR_BV%+1
AND VAR_A%+1
TAX
LDY VAR_BV%
TYA
AND VAR_A%
TAY
TXA
; Optimized code for AND/OR(2)
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
STY VAR_BV%
STA VAR_BV%+1
LDA VAR_BV%+1
ORA VAR_O%+1
TAX
LDY VAR_BV%
TYA
ORA VAR_O%
TAY
TXA
; Optimized code for AND/OR(2)
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
STY VAR_BV%
STA VAR_BV%+1
;
LINE_51010:
;
LDA #$00
LDY #$00
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_MD%
LDA VAR_MD%+1
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
EQ_EQ18:
EQ_SKIP18:
COMP_SKP39:
BNE LINE_SKIP52
LINE_NSKIP52:
; Optimizer rule: Simplified equal comparison/6
;
JMP RETURN
;
LINE_SKIP52:
;
;
LINE_51020:
;
LDY VAR_BV%
LDA VAR_BV%+1
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_BO%
STA VAR_BO%+1
LDY #7
LDA #0
; Optimizer rule: INT to FAC, FAC to INT/2
STY VAR_J%
STA VAR_J%+1
;
LINE_51025:
;
LDA #<VAR_B1%[]
LDY #>VAR_B1%[]
STA G_REG
STY G_REG+1
LDY VAR_J%
LDA VAR_J%+1
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_JJ%
STA VAR_JJ%+1
; Optimizer rule: Fast INTEGER array access (2)/3
LDY VAR_J%
LDA VAR_J%+1
STY TMP_ZP
STA TMP_ZP+1
LDY VAR_JJ%
LDA VAR_JJ%+1
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
EQ_EQ19:
EQ_SKIP19:
COMP_SKP40:
BNE LINE_SKIP53
LINE_NSKIP53:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_51060
;
LINE_SKIP53:
;
;
LINE_51030:
;
LDA #<VAR_PT%[]
LDY #>VAR_PT%[]
STA G_REG
STY G_REG+1
LDY VAR_J%
LDA VAR_J%+1
JSR ARRAYACCESS_INTEGER_INT_SI
STY VAR_V%
STA VAR_V%+1
; Optimizer rule: Fast INTEGER array access (2)/3
LDA #<VAR_PT%[]
LDY #>VAR_PT%[]
STA G_REG
STY G_REG+1
LDY VAR_JJ%
LDA VAR_JJ%+1
JSR ARRAYACCESS_INTEGER_INT
; Optimizer rule: Array index is integer (load)/7
JSR COPY_XREG2YREG
; Optimizer rule: Direct copy from X to Y/1
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
LDY VAR_BO%
LDA VAR_BO%+1
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
JSR FACINT
STY VAR_BI%
STA VAR_BI%+1
;
LINE_51040:
;
LDY VAR_BI%
LDA VAR_BI%+1
; integer in Y/A to FAC
JSR INTFAC
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
LDA Y_REG
COMP_SKP41:
BNE LINE_NSKIP54
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP54
;
LINE_NSKIP54:
;
LDA VAR_BV%+1
ORA VAR_V%+1
TAX
LDY VAR_BV%
TYA
ORA VAR_V%
TAY
TXA
; Optimized code for AND/OR(2)
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
STY VAR_BV%
STA VAR_BV%+1
JMP LINE_51060
;
LINE_SKIP54:
;
;
LINE_51050:
;
LDY VAR_V%
LDA VAR_V%+1
JSR INTFAC
LDA #<CONST_59R
LDY #>CONST_59R
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
JSR FACYREG
; Optimizer rule: FAC 2 Y_REG(2)/1
LDY VAR_BV%
LDA VAR_BV%+1
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
JSR FACINT
STY VAR_BV%
STA VAR_BV%+1
;
LINE_51060:
;
LDY VAR_J%
LDA VAR_J%+1
JSR SUPERFIDEX
; Optimizer rule: Even faster INTEGER DEC/1
STY VAR_J%
STA VAR_J%+1
LDA #$ff
LDY #$ff
STA TMP_ZP
STY TMP_ZP+1
LDY VAR_J%
LDA VAR_J%+1
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
BCS GT_GT20
LDA #0
JMP GT_SKIP20
GT_GT20:
LDA #$1
GT_SKIP20:
COMP_SKP42:
BEQ LINE_SKIP55
; Simplified conditional branch
;
LINE_NSKIP55:
;
JMP LINE_51025
;
LINE_SKIP55:
;
;
LINE_51070:
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
RIGHT		JSR STRFUNCINT
RIGHT2		LDA (TMP_ZP),Y
TAX
CMP TMP_REG			; compare the source string's length with the parameter
BCS RIGHTBELOW
STA TMP_REG			; length>source length? -> clamp to source length
RIGHTBELOW	TXA
SEC
SBC TMP_REG
BCS RIGHTNOV
LDA #0
RIGHTNOV	STA TMP_REG+1
JMP STRFUNC
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
LINEBREAK	JSR REROUTE
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
INTSUBOPT16X
INTSUB16X	SEC
TAX
TYA
SBC TMP4_REG
STA TMP4_REG
TXA
SBC TMP4_REG+1
STA TMP4_REG+1
LDY TMP4_REG
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
INTCONV		LDA TMP_FLAG	; The INT value is either already present in TMP2_ZP...or not...
BEQ INTFROMFAC
LDY TMP2_ZP
LDA TMP2_ZP+1
RTS
INTFROMFAC	JMP FACINT
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
STA VAR_Y,Y
STA VAR_I,Y
STA VAR_CC,Y
DEY
BMI REALLOOPEXIT0
JMP REALINITLOOP0
REALLOOPEXIT0:
STA VAR_EP%
STA VAR_EP%+1
STA VAR_CF%
STA VAR_CF%+1
STA VAR_AC%
STA VAR_AC%+1
STA VAR_BP%
STA VAR_BP%+1
LDA #<VAR_B0%[]
LDY #>VAR_B0%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_AV%
STA VAR_AV%+1
LDA #<VAR_B1%[]
LDY #>VAR_B1%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_CP%
STA VAR_CP%+1
STA VAR_OC%
STA VAR_OC%+1
LDA #<VAR_PT%[]
LDY #>VAR_PT%[]
JSR INITSPARAMS
JSR INITNARRAY
LDA #0
STA VAR_I%
STA VAR_I%+1
STA VAR_BV%
STA VAR_BV%+1
STA VAR_X%
STA VAR_X%+1
STA VAR_Y%
STA VAR_Y%+1
STA VAR_SC%
STA VAR_SC%+1
STA VAR_O%
STA VAR_O%+1
STA VAR_A%
STA VAR_A%+1
STA VAR_V%
STA VAR_V%+1
STA VAR_B%
STA VAR_B%+1
STA VAR_MD%
STA VAR_MD%+1
STA VAR_BO%
STA VAR_BO%+1
STA VAR_J%
STA VAR_J%+1
STA VAR_JJ%
STA VAR_JJ%+1
STA VAR_BI%
STA VAR_BI%+1
RTS
;###############################
; *** SUBROUTINES END ***
; *** CONSTANTS ***
CONSTANTS
; CONST: #1

MOSTCOMMON
CONST_0R	.REAL 1.0
; CONST: #147


; CONST: #0

CONST_2R	.REAL 0.0
; CONST: $bit fiddler / egonolsen71 - 2022
CONST_3	.BYTE 32
.STRG "bit fiddler / egonolsen71 - 2022"
; CONST: #5


; CONST: $q - quit, x - clear, 0-7 and . to set
CONST_5	.BYTE 37
.STRG "q - quit, x - clear, 0-7 and . to set"
; CONST: #4

CONST_6R	.REAL 4.0
; CONST: $stuck bits (0/1 or . for normal)
CONST_7	.BYTE 32
.STRG "stuck bits (0/1 or . for normal)"
; CONST: #10

CONST_8R	.REAL 10.0
; CONST: $connected/shorted bits
CONST_9	.BYTE 22
.STRG "connected/shorted bits"
; CONST: $have a nice basic...
CONST_10	.BYTE 20
.STRG "have a nice basic..."
; CONST: $
CONST_11	.BYTE 0
.STRG ""
; CONST: $q
CONST_12	.BYTE 1
.STRG "q"
; CONST: $x
CONST_13	.BYTE 1
.STRG "x"
; CONST: #29

CONST_14R	.REAL 29.0
; CONST: #157


; CONST: #17


; CONST: #8

CONST_17R	.REAL 8.0
; CONST: #145


; CONST: #16


; CONST: #15

CONST_20R	.REAL 15.0
; CONST: #7

CONST_21R	.REAL 7.0
; CONST: $.
CONST_22	.BYTE 1
.STRG "."
; CONST: #-1.0

CONST_23	.REAL -1.0
; CONST: $0
CONST_24	.BYTE 1
.STRG "0"
; CONST: $1
CONST_25	.BYTE 1
.STRG "1"
; CONST: $7
CONST_26	.BYTE 1
.STRG "7"
; CONST: #11


; CONST: #160


; CONST: #2

CONST_29R	.REAL 2.0
; CONST: #3


; CONST: #1024

CONST_31R	.REAL 1024.0
; CONST: #176


; CONST: #6

CONST_33R	.REAL 6.0
; CONST: #99


; CONST: #178


; CONST: #174


; CONST: #98


; CONST: #32


; CONST: #173


; CONST: #177


; CONST: #189


; CONST: #46


; CONST: #48


; CONST: #49


; CONST: #19


; CONST: #34

CONST_46R	.REAL 34.0
; CONST: #58485

CONST_47	.REAL 58485
; CONST: #63


; CONST: #1704

CONST_49R	.REAL 1704.0
; CONST: #1744


; CONST: #256


; CONST: #30


; CONST: #280.0


; CONST: #40


; CONST: #41


; CONST: #54272

CONST_56	.REAL 54272
; CONST: #37


; CONST: #80


; CONST: #255

CONST_59R	.REAL 255.0
;###############################
; ******** DATA ********
DATAS
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
;###################################
; *** VARIABLES ***
VARIABLES
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: EP%
VAR_EP%	.WORD 0
; VAR: CF%
VAR_CF%	.WORD 0
; VAR: AC%
VAR_AC%	.WORD 0
; VAR: BP%
VAR_BP%	.WORD 0
; VAR: B0%[]
.BYTE 0
.WORD 16
VAR_B0%[]	.ARRAY 16
; VAR: AV%
VAR_AV%	.WORD 0
; VAR: B1%[]
.BYTE 0
.WORD 16
VAR_B1%[]	.ARRAY 16
; VAR: CP%
VAR_CP%	.WORD 0
; VAR: OC%
VAR_OC%	.WORD 0
; VAR: I
VAR_I	.REAL 0.0
; VAR: PT%[]
.BYTE 0
.WORD 16
VAR_PT%[]	.ARRAY 16
; VAR: I%
VAR_I%	.WORD 0
; VAR: BV%
VAR_BV%	.WORD 0
; VAR: X%
VAR_X%	.WORD 0
; VAR: Y%
VAR_Y%	.WORD 0
; VAR: SC%
VAR_SC%	.WORD 0
; VAR: CC
VAR_CC	.REAL 0.0
; VAR: O%
VAR_O%	.WORD 0
; VAR: A%
VAR_A%	.WORD 0
; VAR: V%
VAR_V%	.WORD 0
; VAR: B%
VAR_B%	.WORD 0
; VAR: MD%
VAR_MD%	.WORD 0
; VAR: BO%
VAR_BO%	.WORD 0
; VAR: J%
VAR_J%	.WORD 0
; VAR: JJ%
VAR_JJ%	.WORD 0
; VAR: BI%
VAR_BI%	.WORD 0
STRINGVARS_START
; VAR: T$
VAR_T$	.WORD EMPTYSTR
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
