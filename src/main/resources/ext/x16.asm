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
; see: https://github.com/commanderx16/x16-rom/blob/master/basic/x16additions.s#L64
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
VLOAD		LDA #0			; set secondary address to 0
			STA $B9
			JSR SETNAMEPRT
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			STY $BA			; Store device number
			LDA #<Y_REG		; read secondary address
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			TYA
			AND #$F
			TAY
			INY
			INY
			STY $93			; "abuse" Load/Verify-Flag to store bank
			LDY #0
			STY $90			; reset status
			LDA #<C_REG		; read target address
			LDY #>C_REG
			JSR REALFAC
			JSR FACWORD
			STY $C3
			STA $C4
			LDA $93			; restore these for load call (which sets them again)
			LDX $C3
			LDY $C4
			JSR LOADXX
			LDA $90
			BEQ VLOADOK
			JMP FILENOTFOUND
VLOADOK		RTS
;###################################
LOADEXT		LDA #0			; set secondary address to 0
			STA $B9
			JSR SETNAMEPRT
			LDA #<X_REG
			LDY #>X_REG
			JSR REALFAC
			JSR FACWORD
			STY $BA			; Store device number
			LDA #<Y_REG		; read secondary address
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			STY VERABNK		; switch bank
			LDY #0
			STY $93			; set Load/Verify-Flag to 0
			STY $90			; reset status	
			LDA #<C_REG		; read target address
			LDY #>C_REG
			JSR REALFAC
			JSR FACWORD
			STY $C3
			STA $C4
			LDA $93			; restore these for load call (which sets them again)
			LDX $C3
			LDY $C4
			JSR LOADXX
			LDA $90
			BEQ LOADEXTOK
			JMP FILENOTFOUND
LOADEXTOK	RTS
;###################################