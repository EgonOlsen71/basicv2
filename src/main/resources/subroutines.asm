;###################################
START
			LDA #<FPSTACK
			LDY #>FPSTACK
			STA FPSTACKP
			STY FPSTACKP+1
			LDA #<FORSTACK
			LDY #>FORSTACK
			STA FORSTACKP
			STY FORSTACKP+1
			LDA #0
			STA CONCATBUFP
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
			LDA #0
			TAY
			TAX
			STA $C6
			CLC
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
MID			LDA #<D_REG
			LDY #>D_REG
			JSR REALFAC
			JSR SGNFAC
			ROL
			BCC MIDLENGTH		; an actual length was given...
			JSR STRFUNCINT		; ...no, it wasn't.
			LDA TMP_REG			; copy start position from TMP_REG into TMP_REG+1
			STA TMP_REG+1
			BNE MIDOK2
			JMP ILLEGALQUANTITY	; start has to be larger than 0
MIDOK2		DEC TMP_REG+1		; BASIC starts at 1, we start at 0
			LDA (TMP_ZP),Y
			SEC
			SBC TMP_REG+1
			STA TMP_REG			; store the calculated length
			BCS	MIDNOV
			STY TMP_REG			; Set length to 0, if start>string length
			JMP MIDNOV
MIDLENGTH	JSR FACWORD
			STY TMP2_REG		; save the length in TMP2_REG
			JSR STRFUNCINT
			LDA TMP_REG			; copy start position from TMP_REG into TMP_REG+1
			BNE MIDOK
			JMP ILLEGALQUANTITY	; start has to be larger than 0
MIDOK		LDX TMP2_REG
			STX TMP_REG			; store the length saved above in TMP_REG
			STA TMP_REG+1
			DEC TMP_REG+1		; BASIC starts at 1, we start at 0
MIDNOV		LDA TMP_REG+1		; the starting position
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
RIGHT		JSR STRFUNCINT
			LDA (TMP_ZP),Y
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
LEFT		JSR STRFUNCINT
			STY TMP_REG+1		; store the start position (always 0 for left$)
			LDA (TMP_ZP),Y
			CMP TMP_REG			; compare the source string's length with the parameter
			BCS LEFTBELOW
			STA TMP_REG			; length>source length? -> clamp to source length
LEFTBELOW	JMP STRFUNC
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
; Generic function for string function like for left$, right$ and mid$. It reuses the actual code to
; copy strings for an assignment but it jumps into it at a "copy only" stage. However, it still assumes
; that the source pointer points towards the length of the source string and it resets the concat buffer pointer.
; These are both behaviours that we have to adapt to, so we are adjusting and/or saving/restoring some values here.
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
			LDA CONCATBUFP		; save the current concatbuffer position...
			PHA
			LDA TMP_REG
			BNE STRFUNCNZ
			LDA #<EMPTYSTR
			STA A_REG
			LDA #>EMPTYSTR
			STA A_REG+1
			JMP EXITSTRFUNC
STRFUNCNZ	STA (TMP_ZP),Y
			LDA #<A_REG
			LDY #>A_REG
			STA TMP2_ZP
			STY TMP2_ZP+1
			JSR COPYONLY
EXITSTRFUNC	PLA
			STA CONCATBUFP		; and restore it (because COPYONLY nulls it)
			PLA
			LDY #0
			STA (TMP_ZP),Y		; restore the first byte of the source string on the stack
			RTS
;###################################
CONCAT		LDX CONCATBUFP
			BNE BUFFERUSED		;Checks if the buffer already contains some data
			LDA A_REG			;No? Then the first content is stored in A_REG
			STA TMP_ZP
			LDA A_REG+1
			STA TMP_ZP+1
			JSR COPY2CONCAT		;...copy into the buffer
BUFFERUSED	LDA B_REG			;copy the content to append
			STA TMP_ZP
			LDA B_REG+1
			STA TMP_ZP+1
			JSR COPY2CONCAT		;..and copy it
			LDA #<CONCATBUFP	; adjust A_REG so that it points to the buffer
			STA A_REG
			LDA #>CONCATBUFP
			STA A_REG+1
			RTS
;###################################
COPY2CONCAT	LDY #0
			LDA (TMP_ZP),Y
			STA TMP2_ZP
			INC TMP_ZP
			BNE COPY2CONT
			INC TMP_ZP+1
COPY2CONT	LDX CONCATBUFP
COPY2LOOP	LDA (TMP_ZP),Y
			STA CONCATBUF,X
			INY
			INX
			BNE MEMORYOK
			JMP OUTOFMEMORY
MEMORYOK	CPY TMP2_ZP
			BNE COPY2LOOP
			STX CONCATBUFP
			RTS
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

			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
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
STR			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			LDY #0
			JSR FACSTR
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
			LDA CONCATBUFP	; save the current concatbuffer position...
			PHA
			JSR COPYONLY
			PLA
			STA CONCATBUFP	; and restore it (because COPYONLY nulls it)
			RTS
;###################################
USR			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JMP ($0311)
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM	;RTS is implicit
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
VALSTR		JSR VALS
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM	;RTS is implicit
;###################################
TAB			JSR TABSPCINIT
			SEC
			JMP TABSPC
;###################################
SPC			JSR TABSPCINIT
			CLC
			JMP TABSPC
;###################################
TABSPCINIT	SEC
			JSR CRSRPOS
			STY $09
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			TAX
			RTS
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
LEN			LDA B_REG
			STA TMP_ZP
			LDA B_REG+1
			STA TMP_ZP+1
			LDY #0
			LDA (TMP_ZP),Y
			TAY
			LDA #0
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM	;RTS is implicit
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
			JSR REALFAC
			JSR FACWORD
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
			JSR WRITETIS
			RTS
;###################################
READTID		LDA #0
			STA $70
			JSR TI2FAC 
			LDY #0
			STY $5E
			DEY
			STY $71
			LDY #$06
			STY $5D
			LDY #$24
			JSR GETTI
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
EXITCOPY	LDA #0
			STA CONCATBUFP	; Reset the work buffer
			RTS
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
			LDA #0
			STA CONCATBUFP	; Reset the work buffer
			RTS
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
REALOUT		LDA X_REG
			BNE RNOTNULL
			JMP PRINTNULL
RNOTNULL	LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			LDY #0
			JSR FACSTR
			LDY #0
			LDA $00FF,Y
STRLOOPRO	JSR CHROUT
			INY
			LDA $00FF,Y
			BNE STRLOOPRO
			RTS
;###################################
REALOUTBRK  LDA X_REG
			BNE RNOTNULLBRK
			JMP PRINTNULLBRK
RNOTNULLBRK	LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			LDY #0
			JSR FACSTR
			LDY #0
			LDA $00FF,Y
STRLOOPROB	JSR CHROUT
			INY
			LDA $00FF,Y
			BNE STRLOOPROB
			LDA #$0D
			JMP CHROUT

;###################################
LINEBREAK	LDA #$0D
			JMP CHROUT

;###################################
PRINTNULL	LDA #$20
			JSR CHROUT
			LDA #$30
			JMP CHROUT
;###################################
PRINTNULLBRK
			LDA #$20
			JSR CHROUT
			LDA #$30
			JSR CHROUT
			LDA #$0D
			JMP CHROUT
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
PRINTSTR	JSR PRINTSTRS
			LDA HIGHP			; Update the memory pointer to the last actually assigned one
			STA STRBUFP
			LDA HIGHP+1
			STA STRBUFP+1
			LDA #0
			STA CONCATBUFP	; Reset the work buffer
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
PRINTSTR2	JSR PRINTSTRS
			LDA HIGHP			; Update the memory pointer to the last actually assigned one
			STA STRBUFP
			LDA HIGHP+1
			STA STRBUFP+1
			LDA #0
			STA CONCATBUFP	; Reset the work buffer
			LDA #$0D
			JMP CHROUT 	;RTS is implicit
;###################################
POS			SEC 
			JSR CRSRPOS
			JSR BYTEFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
;###################################
FRE			LDA ENDSTRBUF
			SEC
			SBC STRBUFP
			TAY
			LDA ENDSTRBUF+1
			SBC STRBUFP+1
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
;###################################
TABOUT		SEC 
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
ARRAYACCESS_STRING
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
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
; #######
ARRAYACCESS_INTEGER
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
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
			LDY #1
			LDA (TMP_ZP),Y
			TAX
			DEY
			LDA (TMP_ZP),Y
			TAY
			TXA
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			; FAC to (X/Y)
			JMP FACMEM	;RTS is implicit
; #######
ARRAYACCESS_REAL
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
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
			LDX #<X_REG
			STX TMP_ZP
			LDY #>X_REG
			STY TMP_ZP+1
			JMP COPY3_XY	;RTS is implicit
;###################################
ARRAYSTORE_STRING
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
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
; #######
ARRAYSTORE_INTEGER
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
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
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACINT
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
			JSR REALFAC
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
			JSR FACADD   ;M-ADD

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

CMPFOR		LDA #5
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
STEPZERO	BCC STEPPOS
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
GETNUMBER	JSR GETIN
			BEQ IGNOREKEY
			CMP #$2B
			BEQ IGNOREKEY
			CMP #$2C
			BEQ IGNOREKEY
			CMP #$2D
			BEQ IGNOREKEY
			CMP #$2E
			BEQ IGNOREKEY
			CMP #$45
			BEQ IGNOREKEY
			JMP SOMENUMKEY
IGNOREKEY	LDA #<REAL_CONST_ZERO
			STA TMP3_ZP
			LDA #>REAL_CONST_ZERO
			STA TMP3_ZP+1
			LDX #<Y_REG
			LDY #>Y_REG
			JSR COPY2_XY
			RTS
SOMENUMKEY	SEC
			SBC #$30
			BCC NUMERROR
			CMP #$0A
			BCS NUMERROR
			TAY
			JSR BYTEFAC
			LDX #<Y_REG
			LDY #>Y_REG
			JMP FACMEM
NUMERROR	JMP	SYNTAXERROR		
;###################################
GETSTR		JSR GETIN
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
			INC STRBUF+1
GETSTR1		RTS

;###################################
SGTEQ		JSR CMPSTRGTEQ
			LDA TMP3_ZP
			BNE NOTSGTEQ
			LDA #<REAL_CONST_MINUS_ONE
			STA TMP3_ZP
			LDA #>REAL_CONST_MINUS_ONE
			STA TMP3_ZP+1
			LDX #<X_REG
			LDY #>X_REG
			JMP COPY2_XY
NOTSGTEQ	LDA #0
			STA X_REG
			RTS

;###################################
SLTEQ		LDA A_REG
			LDX B_REG
			STX A_REG
			STA B_REG
			LDA A_REG+1
			LDX B_REG+1
			STX A_REG+1
			STA B_REG+1
			JMP SGTEQ

;###################################
CMPSTRGTEQ	LDY #0				;Returns 0 if A>=B, something else otherwise
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
			BNE CMPSTRSK3
			LDA TMP2_ZP
			CMP TMP_ZP
			BNE CMPSTRSK3
			LDX #0
			JMP STRSGTEQRES

CMPSTRSK3	LDA (TMP2_ZP),Y
			STA TMP3_ZP+1
			LDA (TMP_ZP),Y
			STA TMP3_ZP
			CMP TMP3_ZP+1
			BCC DONTSWAPEQ
			LDA TMP3_ZP+1
DONTSWAPEQ	TAX
			BNE NOTZSTR2
			LDX #1
			LDA TMP3_ZP+1
			CMP TMP3_ZP
			BCC STRSGTEQRES
			LDX #0
			JMP STRSGTEQRES
NOTZSTR2	INC TMP_ZP
			BNE SCGTEQSKP1
			INC TMP_ZP+1
SCGTEQSKP1	INC TMP2_ZP
			BNE CMPSGTEQLOOP
			INC TMP2_ZP+1	
CMPSGTEQLOOP	
			LDA (TMP_ZP),Y
			CMP (TMP2_ZP),Y
			BEQ SGTEQCONT2
			BCC STRSGTEQRES
			LDX #0
			JMP STRSGTEQRES
SGTEQCONT2	INY
			DEX
			BNE CMPSGTEQLOOP
			LDA TMP3_ZP+1					; All equal so far...decide based on the length then
			CMP TMP3_ZP
			BEQ STRSGTEQRES
			BCC STRSGTEQRES
			LDX #1 
STRSGTEQRES	STX TMP3_ZP
			RTS	
			
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
SGT			JSR CMPSTRGT
			LDA TMP3_ZP
			BNE NOTSGT
			LDA #<REAL_CONST_MINUS_ONE
			STA TMP3_ZP
			LDA #>REAL_CONST_MINUS_ONE
			STA TMP3_ZP+1
			LDX #<X_REG
			LDY #>X_REG
			JMP COPY2_XY
NOTSGT		LDA #0				; If the exponent is 0, the whole number is...
			STA X_REG
			RTS

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
			BEQ STRSGTRES
			BCC STRSGTRES
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
SEQ			JSR CMPSTR
			LDA TMP3_ZP
			BNE NOTSEQ
			LDA #<REAL_CONST_MINUS_ONE
			STA TMP3_ZP
			LDA #>REAL_CONST_MINUS_ONE
			STA TMP3_ZP+1
			LDX #<X_REG
			LDY #>X_REG
			JMP COPY2_XY
NOTSEQ		LDA #0
			STA X_REG
			RTS

;###################################
SNEQ		JSR CMPSTR
			LDA TMP3_ZP
			BEQ NOTSEQ
			LDA #<REAL_CONST_MINUS_ONE
			STA TMP3_ZP
			LDA #>REAL_CONST_MINUS_ONE
			STA TMP3_ZP+1
			LDX #<X_REG
			LDY #>X_REG
			JMP COPY2_XY

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
READNUMBER	RTS

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
POPINT		LDA FPSTACKP
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
			STA TMP_ZP
			INY
			LDA (TMP2_ZP),Y
			STA TMP_ZP+1
			RTS
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
			LDA FPSTACKP
			CLC
			ADC #5
			STA FPSTACKP
			BCC NOPVRFPXX
			INC FPSTACKP+1
NOPVRFPXX	RTS
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
POPREAL		LDA FPSTACKP
			SEC
			SBC #5
			STA FPSTACKP
			BCS NOPVPR
			DEC FPSTACKP+1
NOPVPR		LDA FPSTACKP
			LDY FPSTACKP+1
			JSR REALFAC
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
FASTAND		LDA $69			; Check ARG for 0
			BNE CHECKFAC	
			STA $61			; if so, set FAC to 0 and exit
			RTS
CHECKFAC	LDA $61			; Check if there's a -1 in FAC1
			BNE FACNOTNULL
			RTS				; FAC is 0, then exit
FACNOTNULL	CMP #$81
			BNE NORMALAND
			LDA $62
			CMP #$80
			BNE NORMALAND
			LDA $63
			BNE NORMALAND
			LDA $64
			BNE NORMALAND
			LDA $65
			BNE NORMALAND
			LDA $66
			AND #$80
			CMP #$80
			BNE NORMALAND
			LDA $69			; Check if there's a -1 in ARG
			CMP #$81
			BNE NORMALAND
			LDA $6A
			CMP #$80
			BNE NORMALAND
			LDA $6B
			BNE NORMALAND
			LDA $6C
			BNE NORMALAND
			LDA $6D
			BNE NORMALAND
			LDA $6E
			AND #$80
			CMP #$80
			BNE NORMALAND
			RTS				; both, FAC1 and ARG contain -1...then we leave FAC1 untouched and return
NORMALAND	JMP ARGAND
;###################################
FASTOR		LDA $61			; Check FAC for 0
			BNE CHECKFACOR
			LDA $69			; if so, is ARG = 0 as well?
			BNE CHECKARGOR	; no, continue with ARG (FAC is still 0 here)
			RTS				; yes? Then we leave FAC untouched
CHECKFACOR	LDA $61			; Check if there's a -1 in FAC1
			CMP #$81
			BNE NORMALOR
			LDA $62
			CMP #$80
			BNE NORMALOR
			LDA $63
			BNE NORMALOR
			LDA $64
			BNE NORMALOR
			LDA $65
			BNE NORMALOR
			LDA $66
			AND #$80
			CMP #$80
			BNE NORMALOR
CHECKARGOR	LDA $69			; Check if there's a -1 in ARG
			BNE CHECKARGOR2
			RTS 			; ARG is actually 0? Then the value of FAC doesn't change. We can exit here
CHECKARGOR2	CMP #$81
			BNE NORMALOR
			LDA $6A
			CMP #$80
			BNE NORMALOR
			LDA $6B
			BNE NORMALOR
			LDA $6C
			BNE NORMALOR
			LDA $6D
			BNE NORMALOR
			LDA $6E
			AND #$80
			CMP #$80
			BNE NORMALOR
			JMP ARGFAC		; ARG is 1, so just copy it to FAC and exit (implicit)
NORMALOR	JMP FACOR
;###################################
SQRT		LDX #<TMP_FREG
			LDY #>TMP_FREG
			JSR FACMEM
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
			CLC
			ROR
			BCS SQRTADD
			LDX #$80
			STX TMP2_FREG+1
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
			LDA #<TMP2_FREG
			LDY #>TMP2_FREG
			JSR REALFAC
MINUS		LDA #<TMP_FREG
			LDY #>TMP_FREG
			JSR FACDIV 
			LDA #<TMP2_FREG
			LDY #>TMP2_FREG
			JSR FACADD
			DEC $61
			LDX #<TMP2_FREG
			LDY #>TMP2_FREG
			JSR FACMEM
			DEC $FB
			BNE MINUS
DONE		RTS
;###################################
NEXTWOFOR	LDX #$0A
			JMP $A437
;###################################
OUTOFMEMORY	
			JMP $A435
;###################################
ILLEGALQUANTITY
			JMP $B248
;###################################
SYNTAXERROR 
ERROR		JMP $AF08	;General purpose error, here a syntax error
;###################################

