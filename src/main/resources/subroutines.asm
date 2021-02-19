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
RESTARTPRG	LDA #<FPSTACK
			LDY #>FPSTACK
			STA FPSTACKP
			STY FPSTACKP+1
			LDA #<FORSTACK
			LDY #>FORSTACK
			STA FORSTACKP
			STY FORSTACKP+1
			JMP LINE_0			
;###################################
CLR			JMP START
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
RUN			LDX SP_SAVE
			TXS
			JMP PROGRAMSTART
;###################################
RESTORE		LDA #<DATAS
			LDY #>DATAS
			STA DATASP
			STY DATASP+1
			RTS
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
			JMP EXITSTRFUNC
STRFUNCNZ	STA (TMP_ZP),Y
			LDA #<A_REG
			LDY #>A_REG
			STA TMP2_ZP
			STY TMP2_ZP+1
			LDX TMP_REG			; Put length into X for copy
			JSR COPYONLY
EXITSTRFUNC	PLA
			LDY #0
			STA (TMP_ZP),Y		; restore the first byte of the source string on the stack
			RTS
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
USR			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JMP ($0311)
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM	;RTS is implicit
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
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM	;RTS is implicit
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
			BEQ ZEROLEN
			TAY
			LDA #0
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM	;RTS is implicit
ZEROLEN		JMP ZEROSET

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
			TAY
			LDA #0
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
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
			INC STRBUFP+1
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
			INC STRBUFP+1
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
; This check is called in places, where the actual source's length is unknown.
; So we compact assuming the maximum string length of 255. It's not ideal this way
; but it's better than what we did before: Read some random length out of whatever
; memory location TMP_ZP/TMP_ZP+1 was pointing to...
COMPACTMAX
			LDA #$FF
			LDY #$0
			JMP COMPACTF
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
;###################################
GCEXECOMP	LDA STRBUFP
			STA STORE4
			LDA STRBUFP+1
			STA STORE4+1
			JSR GCEXE
			JMP CHECKMEMORY
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
REROUTE		LDA CMD_NUM		; if CMD mode, enable channel output
			BEQ REROUTECMD
			TAX
			STA CHANNEL
			JMP CHKOUT
REROUTECMD	RTS
;###################################
RESETROUTE	LDA CMD_NUM		; if CMD mode, disable channel output
			BEQ RESETROUTECMD
			JMP CLRCHNEW
RESETROUTECMD
			RTS
;###################################
INTOUT		JMP REALOUT
;###################################
INTOUTBRK  	JMP REALOUTBRK
;###################################
REALOUT		JSR REROUTE
			LDA X_REG
			BNE RNOTNULL
			JMP PRINTNULL
RNOTNULL	LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
REALOUTINT	LDY #0
			JSR FACSTR
			LDY #0
			LDA LOFBUF,Y
STRLOOPRO	JSR CHROUT
			INY
			LDA LOFBUF,Y
			BNE STRLOOPRO
			JSR RESETROUTE
			RTS
;###################################
REALOUTBRK  JSR REROUTE
			LDA X_REG
			BNE RNOTNULLBRK
			JMP PRINTNULLBRK
RNOTNULLBRK	LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			LDY #0
			JSR FACSTR
			LDY #0
			LDA LOFBUF,Y
STRLOOPROB	JSR CHROUT
			INY
			LDA LOFBUF,Y
			BNE STRLOOPROB
			LDA #$0D
			JSR RESETROUTE
			JMP CHROUT
;###################################
LINEBREAK	JSR REROUTE
			LDA #$0D
			JSR CHROUT
			JMP RESETROUTE
;###################################
PRINTNULL	JSR REROUTE
			LDA #$20
			JSR CHROUT
			LDA #$30
			JSR CHROUT
			JMP RESETROUTE
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
SINGLECHROUTBRK
			STA TMP_ZP
			JSR REROUTE
			LDA TMP_ZP
			JSR CHROUT
			LDA #$0D
			JSR CHROUT
			JMP RESETROUTE
;###################################
SINGLECHROUT
			STA TMP_ZP
			JSR REROUTE
			LDA TMP_ZP
			JSR CHROUT
			JMP RESETROUTE
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
POS			SEC 
			JSR CRSRPOS
			JSR BYTEFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
;###################################
FRE			
			JSR GCEXE
			LDA ENDSTRBUF
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
;###################################
ARRAYACCESS_INTEGER_SI
			STA G_REG
			STY G_REG+1
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACINT
ARRAYACCESS_INTEGER_INT_SI
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
			RTS
;###################################
;###################################
ARRAYACCESS_INTEGER_S
			STA G_REG
			STY G_REG+1
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
;###################################
ARRAYACCESS_REAL_S
			STA G_REG
			STY G_REG+1
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
;###################################
ARRAYSTORE_INT_INTEGER
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACINT
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
;###################################
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
			JSR FACADD

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
GETNUMBER	
			LDA #8
			LDY #0
			JSR COMPACTF
			LDY #0
			STY CMD_NUM			; Reset CMD target
			JSR GETIN
			CMP #0				; has to happen or otherwise, it won't work for RS232 access
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
QUEUESIZE	LDY INPUTQUEUEP
			LDA #0
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
;###################################
CLEARQUEUE	LDA #$0
			STA INPUTQUEUEP
			RTS
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
READADDPTR	STX TMP_REG+1
			LDA TMP3_ZP
			CLC
			ADC TMP_REG+1
			STA TMP3_ZP
			BCC READADDPTRX
			INC TMP3_ZP+1
READADDPTRX	RTS
;###################################
READNUMBER	JSR READINIT
MORENUMDATA CMP #$2				; Strings are not allowed here
			BNE NUMNUM
			LDA (TMP3_ZP),Y		; ...unless they are empty, which makes them count as 0
			BEQ RNESTR
			CMP #1				; or a ".", which is 0 as well...so length has to be 1..
			BEQ STRGNUMCHK
			JMP SYNTAXERROR
STRGNUMCHK 	INY
			LDA (TMP3_ZP),Y
			CMP #46				; ...and really a "."?
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
			LDX #<Y_REG
			LDY #>Y_REG
			JMP FACMEM		; ...and return
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
NEXTDATA	LDA TMP3_ZP			; Adjust pointer to the next element
			STA DATASP
			LDA TMP3_ZP+1
			STA DATASP+1
			RTS
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
QMARKOUT1	LDA #1
			STA TMP_ZP
			JMP QMARKOUT	
;###################################
QMARKOUT2	LDA #2
			STA TMP_ZP
			JMP QMARKOUT	
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
INPUTSTR	LDA #$0
INPUTSTR2	STA TMP_REG+1
			LDA #$0
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
			LDX #<X_REG
			LDY #>X_REG
			JMP COPY2_XY
			RTS				; Flag error and return
							; check, if the input string looked like a number
NUMOK		LDA TMP_REG
			JSR VALS
			LDA #$0			; flag as number
			STA X_REG
			LDX #<Y_REG
			LDY #>Y_REG
			JMP FACMEM		; ...and return
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
NOTSGTEQ	JMP ZEROSET
;###################################
ZEROSET		LDA #0
			STA X_REG
			STA X_REG+1
			STA X_REG+2
			STA X_REG+3
			STA X_REG+4
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
			BEQ SKIPEQ1
			BCS STRSGTEQRES
SKIPEQ1		LDX #0
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
NOTSGT		JMP ZEROSET
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
NOTSEQ		JMP ZEROSET

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
POPREAL2X	LDA FPSTACKP
			SEC
			SBC #5
			STA FPSTACKP
			BCS NOPVPR2X
			DEC FPSTACKP+1
NOPVPR2X	LDA FPSTACKP
			LDY FPSTACKP+1
			JSR REALFAC
			LDA #<X_REG
			LDY #>X_REG
			JSR MEMARG
			RTS

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
SHR			LDA FACEXP
			BEQ SHLOK
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
PEEKBYTEADDAND
			JSR PEEKBYTEADDSUB
			TYA
			AND B_REG
			TAY
			LDA #0
			JMP PEEKBYTESTORE
;###################################
PEEKBYTEADDOR
			JSR PEEKBYTEADDSUB
			TYA
			ORA B_REG
			TAY
			LDA #0
			JMP PEEKBYTESTORE
;###################################
PEEKBYTEAND
			JSR PEEKBYTESUB
			TYA
			AND A_REG
			TAY
			LDA #0
			JMP PEEKBYTESTORE
;###################################
PEEKBYTEOR
			JSR PEEKBYTESUB
			TYA
			ORA A_REG
			TAY
			LDA #0
			JMP PEEKBYTESTORE
;###################################
PEEKBYTEADD
			JSR PEEKBYTEADDSUB
			JMP PEEKBYTESTORE
;###################################
PEEKBYTESTORE
			JSR	INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
;###################################
PEEKBYTEADDSUB
			JSR PEEKBYTESUB
			TYA
			CLC
			ADC A_REG
			BCC PBNOOV
			INX
PBNOOV		TAY
			TXA
			RTS
;###################################
PEEKBYTESUB
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			STY PEEKBYTE+1
			STA PEEKBYTE+2
PEEKBYTE
			LDY $FFFF
			LDX #0
			RTS
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
LOCKCHANNEL
			PHA
			LDA #$FF
			STA CHLOCKFLAG
			PLA
			RTS
;##################################
UNLOCKCHANNEL
			PHA
			LDA #0
			STA CHLOCKFLAG
			PLA
			JMP CLRCH
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
CLRCHNEW
			LDA CHLOCKFLAG
			BNE SKIPCLRCH
			JMP CLRCH
SKIPCLRCH	
			RTS			
;###################################
REALOUTCHANNEL
			JSR INITOUTCHANNEL
			JSR REALOUT
			JMP CLRCHNEW
;###################################
INTOUTCHANNEL
			JSR INITOUTCHANNEL
			JSR INTOUT
			JMP CLRCHNEW
;###################################
GETSTRCHANNEL
			JSR INITINCHANNEL
			JSR GETSTR
			JMP CLRINCH
;###################################
GETNUMBERCHANNEL
			JSR INITINCHANNEL
			JSR GETNUMBER
			JMP CLRINCH
;###################################
INPUTSTRCHANNEL
			JSR INITINCHANNEL
			JSR INPUTSTR
			JMP CLRINCH
;###################################
INPUTNUMBERCHANNEL
			JSR INITINCHANNEL
			JSR INPUTNUMBER
			JMP CLRINCH
;###################################
STROUTCHANNEL
			JSR INITOUTCHANNEL
			JSR STROUT
			JMP CLRCHNEW
;###################################
LINEBREAKCHANNEL
			JSR INITOUTCHANNEL
			JSR LINEBREAK
			JMP CLRCHNEW
;###################################
SPCCHANNEL
			JSR INITOUTCHANNEL
			LDA CHANNEL
			CMP #3		; To the screen?
			BEQ SPCSCREEN
			JMP TABCHANNEL2
SPCSCREEN	JSR CLRCHNEW
			JMP SPC
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
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			TAX
			JMP EXITCHANNEL
TABSCREEN
			JSR CLRCHNEW
			JMP TAB
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
EXITCHANNEL	CLC
			JSR TABSPC
			JSR CLRCHNEW
			LDA STORE1
			STA IOCHANNEL
			RTS
;###################################
CLRINCH		JSR CLRCH
			LDA STORE1+1
			STA IOCHANNEL
			RTS
;###################################
CMD			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			STY CMD_NUM
			RTS
;###################################
CHECKCMD	LDA CMD_NUM		; if CMD mode, then print an additional space
			BEQ NOCMD
			JSR REROUTE
			LDA #$20
			JMP CHROUT
			JSR RESETROUTE
NOCMD		RTS
;###################################
SAVE		
			<IF BOOST>
			JSR BOOSTOFF
			</IF>
			LDA #1
			STA SECADDR		; set secondary address to 1
			LDA #0
			STA STATUS		; reset status
			STA VERCHK		; reset Load/Verify-Flag

			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			STY DEVICENUM	; Store device number
			JSR SETNAMEPRT
							; Save the normal BASIC program...
			LDX 45
			LDY 46
			LDA #BASICSTART

			JSR SAVEXX
			<IF BOOST>
			JSR BOOSTON
			</IF>
			RTS
;###################################
VERIFY		JSR SETNAMEPRT
			LDA #1
			STA VERCHK		; set verify flag
			JMP LOADINT
;###################################
LOAD		JSR SETNAMEPRT
			LDA #$0
			STA VERCHK		; reset Load/Verify-Flag
			STA STATUS		; reset status
LOADINT		
			<IF BOOST>
			JSR BOOSTOFF
			</IF>
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			STY DEVICENUM	; Store device number
			LDA #<Y_REG		; read secondary address
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			BNE LOADBAS
			LDA BASICSTART	; secondary address 0, load to basic start
			STA LOADEND
			LDA BASICSTART+1			
			STA LOADEND+1
			LDA #0
			JMP SKPBAS
LOADBAS		LDA #1			; set secondary address to 1, if not 0
SKPBAS		STA SECADDR	
			LDA VERCHK		; restore these for load call (which sets them again)
			LDX LOADEND
			LDY LOADEND+1
			JSR LOADXX
			LDA STATUS
			BEQ LOADOK		; Actually, this is for the X16. The C64 ROM doesn't set it to 0, but to 64...shouldn't be an issue though...
			CMP #LOADOK_STATUS
			BEQ LOADOK
			JMP FILENOTFOUND
LOADOK		
			<IF BOOST>
			JSR BOOSTON
			</IF>
			RTS
;###################################
OPEN		JSR SETEMPTYSTR	; Prepare with an empty string
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			STY TMP_REG		; store parameter count in TMP_REG

			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
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
			JMP OPENCH
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
CLOSE		LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			TYA				; file number into A
			JSR CLOSECH
			<IF BOOST>
			JSR BOOSTON
			</IF>
			RTS
;###################################
FACXOR		JSR FACINT		; simple XOR implementation...only needed for WAIT, so it doesn't really matter how optimal it is.
			STY TMP3_ZP			
			JSR ARGFAC
			JSR FACINT
			TYA
			EOR TMP3_ZP
			TAY
			JMP BYTEFAC
;###################################
FINX		LDA #<REAL_CONST_ONE
			LDY #>REAL_CONST_ONE
			JSR REALFAC
			LDA #<X_REG
			LDY #>X_REG
			JSR MEMARG
			JSR ARGADD
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
;###################################
FDEX		LDA #<REAL_CONST_ONE
			LDY #>REAL_CONST_ONE
			JSR REALFAC
			LDA #<X_REG
			LDY #>X_REG
			JSR MEMARG
			JSR FACSUB
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
;###################################
FIDEX		CPY #0
			BNE FIDEXNOV
			SEC
			SBC #$1
FIDEXNOV	DEY
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
;###################################
FIINX		INY
			BNE FIINXNOV
			CLC
			ADC #$1
FIINXNOV	JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
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
NEXTWOFOR	
			<IF BOOST>
			JSR BOOSTDIASBLE
			</IF>
			LDX #$0A
			JMP ERRALL
;###################################
OUTOFDATA	
			<IF BOOST>
			JSR BOOSTDIASBLE
			</IF>
			LDX #$0D 
			JMP ERRALL 
;###################################
OUTOFMEMORY	
			<IF BOOST>
			JSR BOOSTDIASBLE
			</IF>
			LDX #$10
			JMP ERRALL 
;###################################
STRINGTOOLONG
			<IF BOOST>
			JSR BOOSTDIASBLE
			</IF>
			LDX #$17       
			JMP ERRALL 
;###################################
ILLEGALQUANTITY
			<IF BOOST>
			JSR BOOSTDIASBLE
			</IF>
			JMP ERRIQ
;###################################
EXTRAIGNORED
			<IF BOOST>
			JSR BOOSTDIASBLE
			</IF>
			JMP ERREI
;###################################
SYNTAXERROR 
			<IF BOOST>
			JSR BOOSTDIASBLE
			</IF>
			JMP ERRSYN
;###################################
FILENOTFOUND
			JSR CLRCHNEW
			JMP FNFOUT
FNFTXT		.TEXT "i/o error"
   			.BYTE $0
FNFOUT		LDY #0
FNFOUT2		LDA FNFTXT,Y
			BEQ FNFST
			INY
			JSR CHROUT
			JMP FNFOUT2
FNFST		LDY STATUS
			LDA #0
			JSR INTFAC
			JMP REALOUTINT
;###################################
ERROR		
			<IF BOOST>
			JSR BOOSTDIASBLE
			</IF>
			JMP ERRSYN	;General purpose error, here a syntax error
;###################################
SYSTEMCALLDYN
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			STY TMP_ZP
			STA TMP_ZP+1
			JMP SYSTEMCALL
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
SCDO		JSR $FFFF
			PHP
			STA $030C
			STX $030D
			STY $030E
			PLA
			STA $030F
			RTS
;###################################
SETUPMULTIPARS
			LDA BASICPOINTER
			STA BPOINTER_TMP
			LDA BASICPOINTER+1
			STA BPOINTER_TMP+1
			LDA #<BASICBUFFER
			STA BASICPOINTER
			LDA #>BASICBUFFER
			STA BASICPOINTER+1
			LDA #0
			STA BASICTEXTP
			RTS
;###################################
COPYSTRINGPAR
			JSR ADDKOMMA
COPYSTRINGPARNK
			JSR ADDQUOTE
			LDA B_REG
			STA TMP_ZP
			LDA B_REG+1
			STA TMP_ZP+1
			LDY #0
			LDA (TMP_ZP),Y
			TAX
			INC TMP_ZP
			BNE CONTBASICC
			INC TMP_ZP+1
CONTBASICC	JSR BASICCOPY
			JSR ADDQUOTE
			RTS
;###################################
COPYREALPAR
			JSR ADDKOMMA
COPYREALPARNK
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			LDY #1
			JSR FACSTR
			LDY #0
			DEY
CRPSTRLOOP	INY
			LDA LOFBUFH,Y
			BNE CRPSTRLOOP
			STY LOFBUF
			TYA
			TAX			; Length in X
			LDA #<LOFBUFH
			STA TMP_ZP
			LDA #>LOFBUFH
			STA TMP_ZP+1
			LDY #0
			LDA (TMP_ZP),Y
			CMP #$20
			BNE CRPOK
			DEX
			INC TMP_ZP
			BNE CRPOK
			INC TMP_ZP+1
CRPOK		JSR BASICCOPY
			RTS
;###################################
ADDGENERIC
			LDY BASICTEXTP
			STA (TMP2_ZP),Y
			INY
			STY BASICTEXTP
			RTS
;###################################
ADDKOMMA
			JSR BASICTEXTINIT
			LDA #$2C
			JMP ADDGENERIC
;###################################
ADDCOLON
			JSR BASICTEXTINIT
			LDA #$3A
			JMP ADDGENERIC
;###################################
ADDQUOTE
			JSR BASICTEXTINIT
			LDA #$22
			JMP ADDGENERIC
;###################################
PULLDOWNMULTIPARS
			LDA BPOINTER_TMP
			STA BASICPOINTER
			LDA BPOINTER_TMP+1
			STA BASICPOINTER+1
			RTS
;###################################
BASICTEXTINIT
			LDA #<BASICBUFFER
			STA TMP2_ZP
			LDA #>BASICBUFFER
			STA TMP2_ZP+1
			RTS
;###################################
BASICCOPY
			LDY BASICTEXTP
			LDA #0
			STA TMP2_REG
			JSR BASICTEXTINIT
BASICCOPYLOOP
			TYA
			PHA
			LDY TMP2_REG
			LDA (TMP_ZP),Y
			STA TMP2_REG+1
			INY
			STY TMP2_REG
			PLA
			TAY
			LDA TMP2_REG+1
			STA (TMP2_ZP),Y
			INY
			DEX
			BNE BASICCOPYLOOP
			STY BASICTEXTP
			RTS	
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
; Improved floating point routines
; ported from Michael Jørgensen's
; work for the X16. 
; See https://github.com/MJoergen
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
FADDRET1 	
			RTS
;###################################
FADDRET2 	
			JMP ARGFAC    
;###################################
FASTFADDMEM
			JSR MEMARG
FASTFADDARG
			BEQ FADDRET2   		; JUMP IF FAC IS ZERO.
			LDA ARGEXP
			BEQ FADDRET1   		; JUMP IF ARG IS ZERO.
			
			
			SEC
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
SQRTAB   
		 	.BYTE $80 $81 $81 $82 $82 $83 $83 $84 $84 $85 $85 $86 $86 $87 $87 $88
         	.BYTE $88 $88 $89 $89 $8A $8A $8B $8B $8C $8C $8D $8D $8E $8E $8E $8F
         	.BYTE $8F $90 $90 $91 $91 $92 $92 $92 $93 $93 $94 $94 $95 $95 $95 $96
         	.BYTE $96 $97 $97 $98 $98 $98 $99 $99 $9A $9A $9B $9B $9B $9C $9C $9D
         	.BYTE $9D $9D $9E $9E $9F $9F $9F $A0 $A0 $A1 $A1 $A1 $A2 $A2 $A3 $A3
         	.BYTE $A3 $A4 $A4 $A5 $A5 $A5 $A6 $A6 $A6 $A7 $A7 $A8 $A8 $A8 $A9 $A9
         	.BYTE $AA $AA $AA $AB $AB $AB $AC $AC $AD $AD $AD $AE $AE $AE $AF $AF
         	.BYTE $AF $B0 $B0 $B1 $B1 $B1 $B2 $B2 $B2 $B3 $B3 $B3 $B4 $B4 $B4 $B5

         	.BYTE $B5 $B6 $B7 $B7 $B8 $B9 $BA $BA $BB $BC $BC $BD $BE $BE $BF $C0
         	.BYTE $C0 $C1 $C2 $C2 $C3 $C4 $C4 $C5 $C6 $C6 $C7 $C8 $C8 $C9 $C9 $CA
         	.BYTE $CB $CB $CC $CD $CD $CE $CE $CF $D0 $D0 $D1 $D2 $D2 $D3 $D3 $D4
         	.BYTE $D5 $D5 $D6 $D6 $D7 $D8 $D8 $D9 $D9 $DA $DB $DB $DC $DC $DD $DD
         	.BYTE $DE $DF $DF $E0 $E0 $E1 $E1 $E2 $E3 $E3 $E4 $E4 $E5 $E5 $E6 $E6
         	.BYTE $E7 $E8 $E8 $E9 $E9 $EA $EA $EB $EB $EC $ED $ED $EE $EE $EF $EF
         	.BYTE $F0 $F0 $F1 $F1 $F2 $F2 $F3 $F3 $F4 $F4 $F5 $F6 $F6 $F7 $F7 $F8
         	.BYTE $F8 $F9 $F9 $FA $FA $FB $FB $FC $FC $FD $FD $FE $FE $FF $FF $FF

FASTFSQRT
         	LDA FACEXP

         	BNE FSQRT_S0
         	RTS         
FSQRT_S0         
         	BIT FACSGN
         	BPL FSQRT_S1
         	JMP ILLEGALQUANTITY
FSQRT_S1         

         	STA TMP_FREG
        	LDX FACHO
         	STX TMP_FREG+1
         	LDX FACMOH
         	STX TMP_FREG+2
         	LDX FACMO
         	STX TMP_FREG+3
         	LDX FACLO
         	STX TMP_FREG+4

		 	CLC
		 	ADC #1
         	LSR
         	PHP            		; STORE CARRY FLAG
         	CLC
         	ADC #$40
         	STA FACEXP

         	LDA FACHO
         	ASL            		; REMOVE BIT 7
         	PLP            		; RETRIEVE CARRY
         	ROR

         	TAX
         	LDA SQRTAB,X
         	STA FACHO

         	LDA #2
         	STA ITERCNT

FSQRT_S2
         	LDA FACEXP
        	STA TMP2_FREG
         	LDX FACHO
         	STX TMP2_FREG+1
         	LDX FACMOH
         	STX TMP2_FREG+2
         	LDX FACMO
         	STX TMP2_FREG+3
         	LDX FACLO
         	STX TMP2_FREG+4

         	LDA TMP_FREG
         	STA ARGEXP
         	LDX TMP_FREG+1
         	STX ARGHO
         	LDX TMP_FREG+2
         	STX ARGMOH
         	LDX TMP_FREG+3
         	STX ARGMO
         	LDX TMP_FREG+4
         	STX ARGLO

         	LDA #0
		 	STA ARISGN
         	LDA FACEXP
         	JSR ARGDIV      		; CALCULATE S/X

         	LDA TMP2_FREG
         	STA ARGEXP
         	LDX TMP2_FREG+1
         	STX ARGHO
         	LDX TMP2_FREG+2
         	STX ARGMOH
         	LDX TMP2_FREG+3
         	STX ARGMO
         	LDX TMP2_FREG+4
         	STX ARGLO

         	LDA FACEXP
         	JSR FASTFADDARG     	; CALCULATE X + S/X
         	DEC FACEXP     	  		; DIVIDE RESULT BY 2

         	DEC ITERCNT
         	BNE FSQRT_S2

FSQRT_RET     
		 	RTS
;###################################

