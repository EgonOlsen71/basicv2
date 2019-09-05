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