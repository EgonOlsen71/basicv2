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
