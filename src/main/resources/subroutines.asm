;###################################
START		RTS

;###################################
END			RTS
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
			STA $22
			LDA TMP_ZP+1
			STA $23
			JSR $A9E7
			RTS
;###################################
READTID		LDA #0
			STA $70
			JSR $AF84 
			LDY #0
			STY $5E
			DEY
			STY $71
			LDY #$06
			STY $5D
			LDY #$24
			JSR $BE68
			LDA #$FE
			STA TMP_ZP
			LDA #0
			STA TMP_ZP+1
			LDA #$6
			STA $FE
			LDA #<VAR_TI$
			LDY #>VAR_TI$
			JSR COPYSTRING
TIDDONE		RTS			
;###################################
STROUT		LDA A_REG
			STA $22
			LDA A_REG+1
			STA $23
			LDY #0
			LDA ($22),Y
			TAX
			INC $22
			BNE PRINTSTR
			INC $23
PRINTSTR	JSR $AB25
			RTS
;###################################
; Basic idea of how string handling works in this context: Each string assigned will be copied from the source to the target, except those in the constant pool.
; If the target can contain the new string, it will be copied into the same memory location, maybe with a shorter length.
; If it doesn't fit, the new string will be copied into string memory and the target will point to it. Strings from the constant pool
; will be referenced only and not copied.
COPYSTRING	STA TMP2_ZP
			STY TMP2_ZP+1
			LDY #0
			LDA (TMP2_ZP),Y
			STA TMP3_ZP
			INY
			LDA (TMP2_ZP),Y
			STA TMP3_ZP+1
			DEY
			
			LDA TMP_ZP+1		; Check if the source is a constant (upper bound). If so, don't copy it but just point to it
			CMP #>VARIABLES
			BEQ CHECKLOW1
			BCS INVAR
			JMP CHECKNEXT
CHECKLOW1	LDA TMP_ZP
			CMP #<VARIABLES
			BCS INVAR
			
CHECKNEXT	LDA TMP_ZP+1		; Check if the source is a constant (lower bound). If so, don't copy it but just point to it
			CMP #>CONSTANTS
			BEQ CHECKLOW3
			BCC INVAR
			JMP ISCONST
CHECKLOW3	LDA TMP_ZP
			CMP #<CONSTANTS
			BCC INVAR			; No, it's not a constant. It's something from lower memory...
			
ISCONST		STA (TMP2_ZP),Y		; Yes, it's a constant...
			INY
			LDA TMP_ZP+1
			STA (TMP2_ZP),Y
			RTS
						
INVAR		INY
			LDA (TMP2_ZP),Y		; Check if the target is currently pointing into the constant pool. If so, don't update that memory by accident
			CMP #>VARIABLES
			BEQ CHECKLOW2
			BCS INVAR2
			JMP UPDATEPTR
CHECKLOW2	DEY
			LDA (TMP2_ZP),Y
			CMP #<VARIABLES
			BCS INVAR2
			JMP UPDATEPTR
INVAR2		LDY #0
			LDA (TMP3_ZP),Y
			STA TMP_REG
			LDA (TMP_ZP),Y
			TAX
			CMP TMP_REG		; Compare the string-to-copy's length (in A) with the variable's current one (in TMP_REG)
			BEQ STRFITS
			BCC STRFITS		; does the new string fits into the old memory location?
UPDATEPTR	LDY #0
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
			STA STRBUFP
			BCC NOCS1
			INC STRBUFP+1
NOCS1		INC STRBUFP
			BNE STRFITS
			INC STRBUFP+1
STRFITS		LDY #0
			LDA (TMP_ZP),Y	; Set the new length...
			STA (TMP3_ZP),Y
			TAY				; Copy length to Y
			BEQ	EXITCOPY	; Length 0? nothing to copy then...
			INC TMP_ZP		; Adjust pointer to reflect that the first byte stores the length
			BNE NOOV1
			INC TMP_ZP+1
NOOV1		INC TMP3_ZP
			BNE LOOP
			INC TMP3_ZP+1
LOOP		LDA (TMP_ZP),Y	; Copy the actual string
			STA (TMP3_ZP),Y
			DEY
			BNE LOOP
			LDA (TMP_ZP),Y	; Copy the actual string, last byte of it
			STA (TMP3_ZP),Y
EXITCOPY	RTS

;###################################
REALOUT		LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $BDDD
			JSR $B487
			JSR $AB21
			JMP $AB3B	;RTS is implicit

;###################################
REALOUTBRK  LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $BDDD
			JSR $B487
			JSR $AB21
			JSR $AB3B
LINEBREAK	LDA #$0D
			JMP $FFD2 	;RTS is implicit

;###################################
ARRAYACCESS_INTEGER
			LDA G_REG
			STA TMP_ZP
			LDA G_REG+1
			STA TMP_ZP+1
INTARRAY2	LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
			LDA (TMP_ZP),Y
			TAX
			DEY
			LDA (TMP_ZP),Y
			TAY
			TXA
			JSR $B391
			LDX #<X_REG
			LDY #>X_REG
			; FAC to (X/Y)
			JMP $BBD7	;RTS is implicit
; #######
ARRAYACCESS_REAL
			LDA G_REG
			STA TMP_ZP
			LDA G_REG+1
			STA TMP_ZP+1
REALARRAY2	LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
			LDX #<X_REG
			STX TMP_ZP
			LDY #>X_REG
			STY TMP_ZP+1
			JMP COPY3_XY	;RTS is implicit

;###################################
ARRAYSTORE_INTEGER
			LDA G_REG
			STA TMP_ZP
			LDA G_REG+1
			STA TMP_ZP+1
INTARRAY1	LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
			LDA #<Y_REG
			LDY #>Y_REG
			JSR $BBA2
			JSR $B1AA
			STY TMP3_ZP
			LDY #1
			STA (TMP_ZP),Y
			DEY
			LDA TMP3_ZP
			STA (TMP_ZP),Y
			RTS
; #######
ARRAYSTORE_REAL
			LDA G_REG
			STA TMP_ZP
			LDA G_REG+1
			STA TMP_ZP+1
REALARRAY1	LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
			LDA #<Y_REG
			STA TMP3_ZP
			LDY #>Y_REG
			STY TMP3_ZP+1
			JMP COPY3_XY	;RTS is implicit

;###################################
INITFOR		LDA FORSTACKP
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
			JSR $BBD7
			JSR $BC2B
			STA TMP_FLAG
			LDY #5
			STY TMP3_ZP
			JSR INCTMPZP
			JSR POPREAL
			LDX TMP_ZP
			LDY TMP_ZP+1
			; FAC to (X/Y)
			JSR $BBD7
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
			JSR $BBA2

CALCNEXT	LDA TMP_ZP
			CLC
			ADC #4
			STA TMP_ZP
			BCC NOPV2IN
			INC TMP_ZP+1
NOPV2IN		STA TMP_REG
			LDY TMP_ZP+1
			STY TMP_REG+1
			JSR $B867   ;M-ADD

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
			JSR $BBD7	;FAC TO (X/Y)

CMPFOR		LDA #5
			STA TMP3_ZP
			JSR INCTMPREG
			LDA TMP_REG
			LDY TMP_REG+1
			JSR $BC5B 	;CMPFAC
			BEQ LOOPING

			PHA
			LDY #14
			LDA (TMP_ZP),Y
			BEQ STEPZERO
			ROL
STEPZERO	BCC STEPPOS
STEPNEG		PLA
			ROL
			BCC LOOPING
			BCS EXITLOOP

STEPPOS		PLA
			ROL
			BCC EXITLOOP
			JMP LOOPING

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

EXITLOOP	LDA TMP2_REG
			STA FORSTACKP
			LDA TMP2_REG+1
			STA FORSTACKP+1
			LDA #1
			STA A_REG
			RTS

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
			JSR DECTMPZP
			JMP SEARCHGOSUB
FOUNDGOSUB
			LDA TMP_ZP
			STA FORSTACKP
			LDA TMP_ZP+1
			STA FORSTACKP+1
			RTS

;###################################
GOSUB		LDA FORSTACKP
			STA TMP_ZP
			LDA FORSTACKP+1
			STA TMP_ZP+1
			LDY #0
			LDA #0
			STA (TMP_ZP),Y
			INY
			STA (TMP_ZP),Y
			INY
			STY TMP3_ZP
			JSR INCTMPZP
			LDA TMP_ZP
			STA FORSTACKP
			LDA TMP_ZP+1
			STA FORSTACKP+1
			RTS

;###################################
COMPACT		RTS

;###################################
GETSTR		RTS

;###################################
SEQ			RTS

;###################################
READNUMBER	RTS

;###################################
PUSHREAL	LDX FPSTACKP
			LDY FPSTACKP+1
			JSR $BBD7
			LDA FPSTACKP
			CLC
			ADC #5
			STA FPSTACKP
			BCC NOPVPUR
			INC FPSTACKP+1
NOPVPUR		RTS

;###################################
POPREAL		LDA FPSTACKP
			SEC
			SBC #5
			STA FPSTACKP
			BCS NOPVPR
			DEC FPSTACKP+1
NOPVPR		LDA FPSTACKP
			LDY FPSTACKP+1
			JSR $BBA2
			RTS

;### HELPER #######################
;###################################
DECTMPZP    LDA TMP_ZP
			SEC
			SBC TMP3_ZP
			STA TMP_ZP
			BCS NOPV1
			DEC TMP_ZP+1
NOPV1		RTS

;###################################
INCTMPZP	LDA TMP_ZP
			CLC
			ADC TMP3_ZP
			STA TMP_ZP
			BCC NOPV2
			INC TMP_ZP+1
NOPV2		RTS

;###################################
INCTMPREG	LDA TMP_REG
			CLC
			ADC TMP3_ZP
			STA TMP_REG
			BCC NOPV3
			INC TMP_REG+1
NOPV3		RTS

;###################################
INCTMP2REG	LDA TMP2_REG
			CLC
			ADC TMP3_ZP
			STA TMP2_REG
			BCC NOPV4
			INC TMP2_REG+1
NOPV4		RTS
;###################################
STORE_AY	STA TMP3_ZP
			STY TMP3_ZP+1
			RTS
;###################################
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
SQRT		LDX #<TMP_FREG
			LDY #>TMP_FREG
			JSR $BBD7
			LDA TMP_FREG+1
			BMI ILLEGALQUANTITY
			LDA TMP_FREG
			BEQ DONE
 
			LDY #$00
			STY TMP2_FREG+1
			STY TMP2_FREG+2
			STY TMP2_FREG+3
			STY TMP2_FREG+4
 
			LDA TMP_FREG
			ROR
			BCS SQRTADD
			LDX #$80
			STA TMP2_FREG+1
SQRTADD 	ADC #$40
			STA TMP2_FREG
			LDA TMP_FREG+1
			ORA TMP2_FREG+1
			LSR
			LSR
			LSR
			LSR
			TAX
			LDA SQRTTABLE,X
			STA TMP2_FREG+1
			LDA #04
			STA $FB
MINUS		LDA #<TMP2_FREG
			LDY #>TMP2_FREG
			JSR $BBA2
			LDA #<TMP_FREG
			LDY #>TMP_FREG
			JSR $BB0F 
			LDA #<TMP2_FREG
			LDY #>TMP2_FREG
			JSR $B867
			DEC $61
			LDX #<TMP2_FREG
			LDY #>TMP2_FREG
			JSR $BBD7
			DEC $FB
			BNE MINUS
DONE		RTS

NEXTWOFOR	LDX #$0A
			JMP $A437

ILLEGALQUANTITY
			JMP $B248
 
ERROR		JMP $AF08	;General purpose error, here a syntax error
 
SQRTTABLE
	.BYTE 03 11 18 25 32 38 44 50
	.BYTE 58 69 79 89 98 107 115 123

