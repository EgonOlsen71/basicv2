VPEEK		LDA #<Y_REG
			LDY #>Y_REG
			JSR REALFAC
			JSR FACWORD
			STA TMP_ZP+1
			STY TMP_ZP
			LDA #<C_REG
			LDY #>C_REG
			JSR REALFAC
			JSR FACWORD
			STY 2			; has to be modified to match the actual requirement. This is just a placeholder for now.
			LDY #0
			LDA (TMP_ZP),Y
			TAY
			LDA #0
			JSR INTFAC
			LDX #<X_REG
			LDY #>X_REG
			JMP FACMEM
			LDA #0
			STA 2			; has to be modified to match the actual requirement. This is just a placeholder for now.
			RTS
;###################################