VPEEK		LDA #<C_REG
			LDY #>C_REG
			JSR REALFAC
			JSR FACWORD
			STY VERAHI
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			STA VERAMID
			STY VERALO
			LDY VERADAT
			LDA #0
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
			RTS
;###################################
DOSCALL		LDA G_REG
			LDY G_REG+1
			STA TMP_ZP
			STY TMP_ZP+1
			LDY #0
			LDA (TMP_ZP),Y	; get string parameter length, keep it in A
			INC G_REG
			BNE SNPNOOVDC
			INC G_REG+1

SNPNOOVDC	LDX G_REG
			LDY G_REG+1
			STX INDEX1
			STY INDEX1+1
			JMP DOS		
;###################################
DOSSTAT		LDA #0
			JMP PTSTAT
;###################################
INITSINGLEPAR
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			TAX
			RTS
;###################################
PLOT		JSR EXTRACTPOINT
			JSR GRAPH_LL_cursor_position
			JSR XTRACTCOLOR
			JSR GRAPH_LL_set_pixel
			RTS
;###################################
LINE		JSR EXTRACTPOINTS
			JSR SETCOLORS
			JSR GRAPH_draw_line
			RTS
;###################################
RECT		JSR EXTRACTPOINTS
			JSR NORMALIZERECT
			JSR SETCOLORS
			SEC
			JSR GRAPH_draw_rect
			RTS
;###################################
FRAME		JSR EXTRACTPOINTS
			JSR NORMALIZERECT
			JSR SETCOLORS
			CLC
			JSR GRAPH_draw_rect
			RTS
;###################################
PRINTCHAR	STZ R0L
			STZ R0H
			JSR GRAPH_set_font
			JSR EXTRACTPOINT
			LDA #<C_REG
			LDY #>C_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			LDX #15
			JSR SETCOLOR
			LDA B_REG
			STA TMP_ZP
			LDA B_REG+1
			STA TMP_ZP+1
			LDY #0
			LDA (TMP_ZP),Y
			STA TMP_REG 			;Length
			INC B_REG
			BNE CHARSKIP
			INC B_REG+1
CHARSKIP				
			LDA B_REG
			STA TMP_ZP
			LDA B_REG+1
			STA TMP_ZP+1			;Pointer hi
			LDY #0
COPYCHAR
			PHY
			LDA (TMP_ZP),Y
			JSR GRAPH_put_char
			PLY
			INY
			CPY TMP_REG
			BNE COPYCHAR
			JMP FREFAC
;###################################
NORMALIZERECT
			LDA R0L
			STA TMP_ZP
			LDA R0H
			STA TMP_ZP+1
			LDA R2L
			STA TMP2_ZP
			LDA R2H
			STA TMP2_ZP+1
			JSR CALCDELTA
			LDA TMP_REG
			BNE NR1
			LDA R0L
			PHA
			LDA R0H
			PHA
			LDA R2L
			STA R0L
			LDA R2H
			STA R0H
			PLA 
			STA R2H
			PLA 
			STA R2L
NR1			LDA TMP3_ZP
			STA R2L
			LDA TMP3_ZP+1
			STA R2H
			INC R2L
			BNE NR3
			INC R2H
			
NR3			LDA R1L
			STA TMP_ZP
			LDA R1H
			STA TMP_ZP+1
			LDA R3L
			STA TMP2_ZP
			LDA R3H
			STA TMP2_ZP+1
			JSR CALCDELTA
			LDA TMP_REG
			BNE NR2
			LDA R1L
			PHA
			LDA R1H
			PHA
			LDA R3L
			STA R1L
			LDA R3H
			STA R1H
			PLA 
			STA R3H
			PLA 
			STA R3L
NR2			LDA TMP3_ZP
			STA R3L
			LDA TMP3_ZP+1
			STA R3H
			INC R3L
			BNE NR4
			INC R3H
NR4			STZ R4L
			STZ R4H
			RTS
;###################################
CALCDELTA	STZ TMP_REG
			LDA TMP_ZP+1
			CMP TMP2_ZP+1
			BCS NOSWAP1
			JSR SWAP
			JMP NOSWAP2
NOSWAP1		BNE NOSWAP2
			LDA TMP_ZP
			CMP TMP2_ZP
			BCS NOSWAP2
			JSR SWAP
NOSWAP2		SEC	
			LDA TMP_ZP
			SBC TMP2_ZP
			STA TMP3_ZP
			LDA TMP_ZP+1
			SBC TMP2_ZP+1
			STA TMP3_ZP+1
			RTS
;###################################
SWAP 		LDA TMP_ZP
			TAX
			LDA TMP_ZP+1
			TAY
			LDA TMP2_ZP
			STA TMP_ZP
			LDA TMP2_ZP+1
			STA TMP_ZP+1
			STX TMP2_ZP
			STY TMP2_ZP+1
			LDA #1
			STA TMP_REG
			RTS
;###################################
RANGEERROR	JMP ILLEGALQUANTITY
;###################################
EXTRACTPOINT
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			TAX
			TYA
			STY R0L
			SEC
			SBC #<320
			TXA
			STA R0H
			SBC #>320
			BCS RANGEERROR
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			TAX
			TYA
			STA R1L
			STZ R1H
			RTS
;###################################
EXTRACTPOINTS
			JSR EXTRACTPOINT
			SEC
			SBC #200
			TXA
			SBC #0
			BCS RANGEERROR
			LDA #<D_REG
			LDY #>D_REG
			JSR REALFAC
			JSR FACWORD
			TAX
			TYA
			STA R2L
			SEC
			SBC #<320
			TXA
			STA R2H
			SBC #>320
			BCS RANGEERROR
			LDA #<E_REG
			LDY #>E_REG
			JSR REALFAC
			JSR FACWORD
			TAX
			TYA
			STA R3L
			STZ R3H
			SEC
			SBC #200
			TXA
			SBC #0
			BCS RANGEERROR
			RTS
;###################################
SETCOLORS	JSR XTRACTCOLOR
			TAX		; color in X as well...needed?
SETCOLOR	JSR GRAPH_set_colors
			RTS
;###################################
XTRACTCOLOR
			LDA #<C_REG
			LDY #>C_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			RTS
;###################################
SCREEN		JSR INITSINGLEPAR
			JMP CSCREEN
;###################################
MOUSEMODE	JSR INITSINGLEPAR
			TXA
			LDX #0
			JMP mouse_config		; because "mouse" appears twice in the symbol table, we can't rely on it and have to call this directly
;###################################
VLOAD		LDA #0			; set secondary address to 0
			STA SECADDR
			JSR SETNAMEPRT
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
			AND #$F
			TAY
			INY
			INY
			STY VERCHK		; "abuse" Load/Verify-Flag to store bank
			LDY #0
			STY STATUS		; reset status
			JMP LOADX16
;###################################
LOADEXT		LDA #0			; set secondary address to 0
			STA SECADDR
			JSR SETNAMEPRT
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			STY DEVICENUM	; Store device number
			LDA #<Y_REG		; read secondary address
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			STY VERABNK		; switch bank
			LDY #0
			STY VERCHK		; set Load/Verify-Flag to 0
			STY STATUS		; reset status	
			JMP LOADX16
;###################################
LOADX16		LDA #<C_REG		; read target address
			LDY #>C_REG
			JSR REALFAC
			JSR FACWORD
			STY LOADEND
			STA LOADEND+1
			LDA VERCHK		; restore these for load call (which sets them again)
			LDX LOADEND
			LDY LOADEND+1
			JSR LOADXX
			LDA STATUS
			BEQ LOADX16OK
			JMP FILENOTFOUND
LOADX16OK	RTS
;###################################
VARBANKON	PHA
			LDA RAMSELECT
			STA TMP_BANK
			LDA #0
			STA RAMSELECT
			PLA
			RTS
;###################################
VARBANKOFF	PHA
			LDA TMP_BANK
			STA RAMSELECT
			PLA
			RTS
;###################################
FACRND_X16	JSR ENTROPY_GET
			JMP FACRND
;###################################
JOY 		JSR joystick_scan
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			TAX
			BEQ VALERRJOY
			AND #$FC
			BNE VALERRJOY
			JSR joystick_get
			EOR #$FF
			TAY
			LDA #0
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
VALERRJOY   JMP ILLEGALQUANTITY
;###################################
COPYTIME	JMP RDTIM
;###################################
GETTIME		STX FACMO
			STY FACMOH
			STA FACLO
			STZ FACHO
			RTS
;###################################
WRITETI		JSR QINT
			LDA FACHO
			BEQ WRITETIOK
			JMP ILLEGALQUANTITY
WRITETIOK	LDA FACHO+3
			LDX FACHO+2
			LDY FACHO+1
			JMP SETTIM
;###################################
CLEARFAC	STZ FACEXP
			STZ FACSGN
			RTS
;###################################
MUL10X		JSR FACARG
			TAX
			BEQ MUL10XR
			CLC
			ADC #2
			BCS GOOVER
			STA FACEXP
			LDX #0
			STX ARISGN
			INX				;clear zero flag
			JSR FADDT		
			INC FACEXP
			BEQ GOOVER
MUL10XR		RTS
GOOVER		JMP ILLEGALQUANTITY
;##################################
WRITEDAD	LDY #0
			LDA (TMP_ZP),Y
			CMP #8
			BNE WRITEDADERR
			
			INC TMP_ZP
			BNE WRITEDAD2
			INC TMP_ZP+1
WRITEDAD2	LDA TMP_ZP
			STA INDEX1
			LDA TMP_ZP+1
			STA INDEX1+1
			
			JSR CLOCK_GET_DATE_TIME
		
			; set the year
			JSR CLEARFAC
			LDY #0
			JSR TIMNUM
			JSR MUL10X
			LDY #1
			JSR TIMNUM
			JSR MUL10X
			LDY #2
			JSR TIMNUM
			JSR MUL10X
			LDY #3
			JSR TIMNUM
			JSR GETADR2
			TAX
			TYA
			SEC
			SBC #<1900
			TAY
			TXA
			SBC #>1900
			BNE WRITEDADERR
			STY R0L
		
			; set the month
			JSR CLEARFAC
			LDY #4
			JSR TIMNUM
			JSR MUL10X
			LDY #5
			JSR TIMNUM
			JSR GETADR2
			TYA
			BEQ WRITEDADERR
			CMP #13
			BCS WRITEDADERR
			STA R0H
		
			; set the day
			JSR CLEARFAC
			LDY #6
			JSR TIMNUM
			JSR MUL10X
			LDY #7
			JSR TIMNUM
			JSR GETADR2
			TYA
			BEQ WRITEDADERR
			CMP #32
			BCS WRITEDADERR
			STA R1L
		
			JMP CLOCK_SET_DATE_TIME
WRITEDADERR JMP ILLEGALQUANTITY
;##################################
READDAD		LDA $FE
			PHA
			
			JSR CLOCK_GET_DATE_TIME
			LDA R1L
			ORA R0H
			ORA R0L
			BNE READDAD2
			LDA #<EMPTYSTR
			STA VAR_DA$
			LDA #>EMPTYSTR
			STA VAR_DA$+1
			PLA
			STA $FE
			RTS

READDAD2
			; read the day
			LDA R1L
			JSR COMPONENT2ASCII
			LDA LOFBUF+3
			PHA
			LDA LOFBUF+2
			PHA
		
			; read the month
			LDA R0H
			JSR COMPONENT2ASCII
			LDA LOFBUF+3
			PHA
			LDA LOFBUF+2
			PHA
		
			; read the year
			LDA R0L
			CLC
			ADC #<1900
			TAY
			LDA #>1900
			JSR COMPONENT2ASCII2
			LDA LOFBUF+1
			STA LOFBUF
			LDA LOFBUF+2
			STA LOFBUF+1
			LDA LOFBUF+3
			STA LOFBUF+2 
			LDA LOFBUF+4
			STA LOFBUF+3 
		
			PLA
			STA LOFBUF+4 		; mm1
			PLA
			STA LOFBUF+5 		; mm2
			PLA
			STA LOFBUF+6 		; dd1
			PLA
			STA LOFBUF+7 		; dd2
			STZ LOFBUF+8 		; terminator (needed?)
		
READDADCOPY	LDA #$FE
			STA TMP_ZP
			LDA #0
			STA TMP_ZP+1
			LDA #$8
			SEI					; prevent $FE from being overwritten. because the x16 doesn't like this
			STA $FE
			LDA #<VAR_DA$
			LDY #>VAR_DA$
			JSR COPYSTRING
			PLA
			STA $FE
			CLI
			RTS
;###################################
WRITETID_X16	
			JSR CLOCK_GET_DATE_TIME
			
			; set hours
			JSR CLEARFAC
			LDY #0
			JSR TIMNUM
			JSR MUL10X
			LDY #1
			JSR TIMNUM
			JSR GETADR2
			CPY #24
			BCS WRITETIDERR
			STY R1H
		
			; set minutes
			JSR CLEARFAC
			LDY #2
			JSR TIMNUM
			JSR MUL10X
			LDY #3
			JSR TIMNUM
			JSR GETADR2
			CPY #60
			BCS WRITETIDERR
			STY R2L
		
			; set seconds
			JSR CLEARFAC
			LDY #4
			JSR TIMNUM
			JSR MUL10X
			LDY #5
			JSR TIMNUM
			JSR GETADR2
			CPY #60
			BCS WRITETIDERR
			STY R2H
			
			JMP CLOCK_SET_DATE_TIME
			
WRITETIDERR	JMP ILLEGALQUANTITY
;###################################
READTID_X16	
			JSR CLOCK_GET_DATE_TIME
			
			LDA R2H				; seconds
			JSR COMPONENT2ASCII
			LDA LOFBUF+3
			PHA
			LDA LOFBUF+2
			PHA
	
			LDA R2L				; minutes
			JSR COMPONENT2ASCII
			LDA LOFBUF+3
			PHA
			LDA LOFBUF+2
			PHA

			LDA R1H				; hours
			JSR COMPONENT2ASCII
			LDA LOFBUF+3
			STA LOFBUF+1 
			LDA LOFBUF+2
			STA LOFBUF

			PLA
			STA LOFBUF+2 		; mm1
			PLA
			STA LOFBUF+3 		; mm2
			PLA
			STA LOFBUF+4 		; ss1
			PLA
			STA LOFBUF+5 		; ss2
			STZ LOFBUF+6 		; terminator (needed?)
			RTS
;###################################
TEXTCOLTAB
	.BYTE $90 $05 $1c $9f $9c $1e $1f $9e
	.BYTE $81 $95 $96 $97 $98 $99 $9a $9b

TEXTCOLOR	JSR INITSINGLEPAR
			CPX #16
			BCC TEXTCOLOROK
			JMP ILLEGALQUANTITY
TEXTCOLOROK	LDA TEXTCOLTAB,X
			JSR CHROUT
			RTS

TEXTBGCOLOR	JSR INITSINGLEPAR
			CPX #16
			BCC TEXTBGCOLOROK
			JMP ILLEGALQUANTITY
TEXTBGCOLOROK	
			LDA TEXTCOLTAB,X
			JSR CHROUT
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			TAX
			CPX #16
			BCC TEXTBGCOLOROK2
			JMP ILLEGALQUANTITY
TEXTBGCOLOROK2
			LDA #1 			; SWAP FG/BG
			JSR CHROUT
			LDA TEXTCOLTAB,X
			JSR CHROUT
			LDA #1 
			JMP CHROUT
;###################################
