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
			STX 34
			STY 35
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
			STA R11L
			JSR EXTRACTCOLOR
			SEC
			SEI
			JSR JSRFAR
			.WORD DRAWPOINT
			.BYTE BANKGEOS
			CLI
			RTS
;###################################
LINE		JSR EXTRACTPOINTS
			JSR EXTRACTCOLOR
			LDA #0
			SEC
			SEI
			JSR JSRFAR
			.WORD DRAWLINE
			.BYTE BANKGEOS
			CLI
			RTS
;###################################
RECT		JSR EXTRACTPOINTS
			LDA R11L
			STA R2L
			LDA R11H
			STA R2H
			JSR NORMALIZERECT
			JSR EXTRACTCOLOR
			SEI
			JSR JSRFAR
			.WORD RECTANGLE
			.BYTE BANKGEOS
			CLI
			RTS
;###################################
FRAME		JSR EXTRACTPOINTS
			LDA R11L
			STA R2L
			LDA R11H
			STA R2H
			JSR NORMALIZERECT
			JSR EXTRACTCOLOR
			LDA TMP_ZP			;Move color to A...because..of course, this is different from line
			SEI
			JSR JSRFAR
			.WORD FRAMERECTANGLE
			.BYTE BANKGEOS
			CLI
			RTS
;###################################
PRINTCHAR	JSR EXTRACTPOINT
			STA R1H
			LDA R3L
			STA R11L
			LDA R3H
			STA R11H
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
			STA R14L 			;Length
			INC B_REG
			BNE CHARSKIP
			INC B_REG+1
CHARSKIP				
			LDA B_REG
			STA R15L 			;Pointer lo
			LDA B_REG+1
			STA R15H 			;Pointer hi
			
			SEI
			JSR JSRFAR
			.WORD USESYSTEMFONT
			.BYTE BANKGEOS
			LDA #27 			;Plaintext
			JSR JSRFAR
			.WORD PUTCHAR
			.BYTE BANKGEOS
			CLI
			LDY #0
COPYCHAR
			LDA (R15),Y
			STY TMP_ZP
			SEI
			JSR JSRFAR
			.WORD PUTCHAR
			.BYTE BANKGEOS
			CLI
			LDY TMP_ZP
			INY
			CPY R14L
			BNE COPYCHAR
			JMP FREFAC
;###################################
NORMALIZERECT
			LDA R2H
			CMP R2L
			BCS NORMALIZERECT1
			LDX R2L
			STX R2H
			STA R2L
NORMALIZERECT1
			LDA R4L
			SEC
			SBC R3L
			LDA R4H
			SBC R3H
			BCS NORMALIZERECT2
			LDA R3L
			LDX R4L
			STX R3L
			STA R4L
			LDA R3H
			LDX R4H
			STX R3H
			STA R4H
NORMALIZERECT2
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
			STY R3L
			SEC
			SBC #<320
			TXA
			STA R3H
			SBC #>320
			BCS RANGEERROR
			LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			TAX
			TYA
			RTS
;###################################
EXTRACTPOINTS
			JSR EXTRACTPOINT
			STA R11L
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
			STA R4L
			SEC
			SBC #<320
			TXA
			STA R4H
			SBC #>320
			BCS RANGEERROR
			LDA #<E_REG
			LDY #>E_REG
			JSR REALFAC
			JSR FACWORD
			TAX
			TYA
			STA R11H
			SEC
			SBC #200
			TXA
			SBC #0
			BCS RANGEERROR
			RTS
;###################################
EXTRACTCOLOR
			LDA #<C_REG
			LDY #>C_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			STA TMP_ZP
			TAX				; color in X as well...needed?
SETCOLOR	SEI		
			JSR JSRFAR
			.WORD _SETCOLOR
			.BYTE BANKGEOS
			CLI
			RTS
;###################################
SCREEN		JSR INITSINGLEPAR
			JMP CSCREEN
;###################################
MOUSEMODE	JSR INITSINGLEPAR
			TXA
			LDX #0
			JMP $FF09		; because "mouse" appears twice in the symbol table, we can't rely on it and have to call this directly
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