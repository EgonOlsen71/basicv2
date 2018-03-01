;###################################
START		LDA #<FPSTACK
			LDY #>FPSTACK
			STA FPSTACKP
			STY FPSTACKP+1
			LDA #<FORSTACK
			LDY #>FORSTACK
			STA FORSTACKP
			STY FORSTACKP+1
			LDA #<CONCATBUF
			LDY #>CONCATBUF
			STA CONCATBUFP
			STY CONCATBUFP+1
			LDA #<STRBUF
			LDY #>STRBUF
			STA STRBUFP
			STY STRBUFP+1
			STA HIGHP
			STY HIGHP+1
			LDA #0
			STA LASTVAR
			STA LASTVAR+1
			JSR INITVARS
			RTS
;###################################
INITNARRAY 
			STA TMP_ZP
			STY TMP_ZP+1
			LDY #0
			LDA #0
NINITLOOP	STA (TMP_ZP),Y
			LDA TMP3_ZP+1
			INC TMP_ZP
			BNE NLOOPNOV
			INC TMP_ZP+1
NLOOPNOV	SEC
			LDA TMP2_ZP
			SBC #1
			STA TMP2_ZP
			BCS NLOOPNOV2
			DEC TMP2_ZP+1
NLOOPNOV2	LDA TMP2_ZP
			BNE NINITLOOP
			LDA TMP2_ZP+1
			BNE NINITLOOP
			RTS
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
INITSPARAMS	STY TMP_ZP+1
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
			RTS
;##################################
INITSTRVARS	LDA #<STRINGVARS_START		; Reset all string variables...
			LDY #>STRINGVARS_START
			STA TMP_ZP
			STY TMP_ZP+1
			LDY #0
INITSTRLOOP	LDA #<EMPTYSTR
			STA (TMP_ZP),Y
			INY
			LDA #<EMPTYSTR
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
			
			LDA #<STRINGARRAYS_START	; ...and all string arrays
			LDY #>STRINGARRAYS_START
ARRAYLOOP	CLC
			ADC #3
			BCC ARRAYSKIP1
			INY
ARRAYSKIP1	CPY #>STRINGARRAYS_END
			BCC ARRAYSKIP2
			CMP #<STRINGARRAYS_END
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
END			RTS
;###################################
STR			LDA #<Y_REG
			LDY #>Y_REG
			JSR $BBA2
			LDY #0
			JSR $BDDF
			LDY #0
			STY TMP_ZP+1
			LDA #$FE
			STA TMP_ZP
			DEY
STRLOOP		INY
			LDA $00FF,Y
			BNE STRLOOP
			INY
			STY $FE
			TYA
			TAX			; Length in X
			LDA #<A_REG
			LDY #>A_REG
			STA TMP2_ZP
			STY TMP2_ZP+1
			JMP COPYONLY ;RTS is implicit
;###################################
VAL			LDA B_REG
			STA $22
			LDA B_REG+1
			STA $23
			LDY #0
			STY $0D
			LDA ($22),Y
			TAY
			INC $22
			BNE VALSTR
			INC $23
VALSTR		JSR $B7B0
			LDX #<X_REG
			LDY #>X_REG
			JMP $BBD7	;RTS is implicit
;###################################
LEN			LDA B_REG
			STA TMP_ZP
			LDA B_REG+1
			STA TMP_ZP+1
			LDY #0
			LDA (TMP_ZP),Y
			TAY
			LDA #0
			JSR $B391
			LDX #<X_REG
			LDY #>X_REG
			JMP $BBD7	;RTS is implicit
;###################################
CHR			LDA STRBUFP
			STA TMP_ZP
			STA A_REG
			LDA STRBUFP+1
			STA TMP_ZP+1
			STA A_REG+1
			LDA #1
			LDY #0
			STA (TMP_ZP),Y
			LDA #<Y_REG
			LDY #>Y_REG
			JSR $BBA2
			JSR $B1AA
			TYA
			LDY #1
			STA (TMP_ZP),Y
			LDA STRBUFP
			CLC
			ADC #2
			STA STRBUFP
			BCC NOCHR1
			INC STRBUF+1
NOCHR1		RTS
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
			INC STRBUF+1
NOCHR2		RTS
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
			JMP COPYSTRING	;RTS is implicit
;###################################
COPYSTRING	STA TMP2_ZP
			STY TMP2_ZP+1
			CPY TMP_ZP+1
			BNE CONTCOPY
			LDA TMP2_ZP
			CMP TMP_ZP
			BNE CONTCOPY
			RTS					; A copy from a variable into the same instance is pointless an will be ignored.
CONTCOPY	LDY #0
			STY TMP_FLAG
			LDA (TMP_ZP),Y
			TAX					; Store the length of the source in X...this is valid until right to the end, where it's not longer used anyway
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
			
ISCONST		JSR CHECKLASTCONST	; Reclaim formerly used memory if possible
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
			CMP HIGHP+1		; "copied down". This is another routine, because of reaons...
			BEQ CHECKXT1
			BCS ALTCOPY
			JMP CHECKMEM
CHECKXT1	LDA TMP_ZP
			CMP HIGHP
			BCS ALTCOPY

CHECKMEM	LDY	ENDSTRBUF+1	; Check, if enough memory is available. This is a rough check, it requires at least 256 bytes to be free or otherwise,
			DEY				; it will fail. This isn't very memory efficient, but it's faster to check this way...
			CPY STRBUFP+1
			BEQ CHECKLOWMEM
			BCS MEMOK
CHECKLOWMEM LDA ENDSTRBUF
			CMP STRBUFP
			BCS MEMOK
			JMP OUTOFMEMORY
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
			ADC #1
			STA STRBUFP
			BCC NOCS1
			INC STRBUFP+1
NOCS1		PLP
			BCC STRFITS
			INC STRBUFP+1
			
STRFITS		LDY TMP_FLAG	; Check if the pointer to the highest mem addr used by an actual string
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
			ADC #1
			STA HIGHP
			STA STRBUFP
			BCC SKIPLOWAS1
			INC HIGHP+1
SKIPLOWAS1	PLP
			BCC SKIPLOWAS2
			INC HIGHP+1
SKIPLOWAS2	LDA HIGHP+1
			STA STRBUFP+1
			RTS
;###################################
; Checks if this variable is the same one that has been stored last. If so, we can reclaim its memory first.
CHECKLASTCONST
			LDY #0
			LDA TMP2_ZP
			CMP LASTVAR
			BNE NOTSAMECONST
			LDA TMP2_ZP+1
			CMP LASTVAR+1
			BNE NOTSAMECONST
			LDA LASTVARP			; The target is the last string that has been added. We can free it's currently used memory then.
			STA HIGHP
			STA STRBUFP
			LDA LASTVARP+1
			STA HIGHP+1
			STA STRBUFP+1
NOTSAMECONST	
			RTS
;###################################
; Checks if this variable is the same one that has been stored last. If so, we can reclaim its memory first.
CHECKLASTVAR
			LDY #0
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
			LDA #0				; Set the current value's length to 0, so that nothing new fits and a copy always happens later
			STA (TMP3_ZP),Y
NOTSAMEVAR	RTS
;###################################
; Stores the last variable reference that has been stored in string memory
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
INTOUT		JMP REALOUT
;###################################
INTOUTBRK  	JMP REALOUTBRK
;###################################
REALOUT_OLD LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $BDDD
			JSR $B487
			JSR $AB21
			JMP $AB3B	;RTS is implicit
;###################################
REALOUT		LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			LDY #0
			JSR $BDDF
			LDY #0
			STY $23
			LDA #$FF
			STA $22
			DEY
STRLOOPRO	INY
			LDA $00FF,Y
			BNE STRLOOPRO
			INY
			TYA
			TAX
			JMP $AB25	;RTS is implicit
;###################################
REALOUTBRK  LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			LDY #0
			JSR $BDDF
			LDY #0
			STY $23
			LDA #$FF
			STA $22
			DEY
STRLOOPROB	INY
			LDA $00FF,Y
			BNE STRLOOPROB
			INY
			TYA
			TAX
			JSR $AB25
LINEBREAK	LDA #$0D
			JMP $FFD2
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
			LDA HIGHP			; Update the memory pointer to the last actually assigned one
			STA STRBUFP
			LDA HIGHP+1
			STA STRBUFP+1
			RTS
;###################################
STROUTBRK	LDA A_REG
			STA $22
			LDA A_REG+1
			STA $23
			LDY #0
			LDA ($22),Y
			TAX
			INC $22
			BNE PRINTSTR2
			INC $23
PRINTSTR2	JSR $AB25
			LDA HIGHP			; Update the memory pointer to the last actually assigned one
			STA STRBUFP
			LDA HIGHP+1
			STA STRBUFP+1
			LDA #$0D
			JMP $FFD2 	;RTS is implicit
;###################################
ARRAYACCESS_STRING
			LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
; #######
ARRAYACCESS_INTEGER
			LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
			LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
			LDX #<X_REG
			STX TMP_ZP
			LDY #>X_REG
			STY TMP_ZP+1
			JMP COPY3_XY	;RTS is implicit
;###################################
ARRAYSTORE_STRING
			LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
; #######
ARRAYSTORE_INTEGER
			LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
			LDA #<X_REG
			LDY #>X_REG
			JSR $BBA2
			JSR $B1AA
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
			LDA TMP_REG
			CLC
			ADC #5
			STA TMP_REG
			BCC NOPV3
			INC TMP_REG+1
NOPV3		LDY TMP_REG+1
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
INCTMPZP	LDA TMP_ZP
			CLC
			ADC TMP3_ZP
			STA TMP_ZP
			BCC NOPV2
			INC TMP_ZP+1
NOPV2		RTS
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

OUTOFMEMORY	JMP $A435

ILLEGALQUANTITY
			JMP $B248
 
ERROR		JMP $AF08	;General purpose error, here a syntax error
 
SQRTTABLE
	.BYTE 03 11 18 25 32 38 44 50
	.BYTE 58 69 79 89 98 107 115 123

