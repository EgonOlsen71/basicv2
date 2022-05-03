*=$c000

REALFAC = $BBA2
INTFAC = $B391
FACMUL = $BA30
FACMEM = $BBD7
MEMARG = $BA8C
FACSTR = $BDDF
CHROUT = $FFD2

			LDY #0
			LDA #0
			; integer in Y/A to FAC
			JSR INTFAC
			LDX #<Y_REG
			LDY #>Y_REG
			; FAC to (X/Y)
			JSR FACMEM
			LDA #<VAR_J
			LDY #>VAR_J
			;LDA #249
			;LDY #186
			; Real in (A/Y) to FAC
			JSR REALFAC
			LDX #<X_REG
			LDY #>X_REG
			; FAC to (X/Y)
			JSR FACMEM
			
			LDA #<Y_REG
			LDY #>Y_REG
			; Real in (A/Y) to FAC
			JSR REALFAC
			LDA #<X_REG
			LDY #>X_REG
			; Real in (A/Y) to ARG
			;JSR MEMARG
			
			
			; FAC = ARG * FAC
			;BEQ NMUL
			;JSR FACMUL
			JSR $BA28
NMUL		LDX #<X_REG
			LDY #>X_REG
			; FAC to (X/Y)
			JSR FACMEM
			JSR REALOUT
			RTS

REALOUT
			LDA X_REG
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
			
X_REG	.REAL 0.0
Y_REG	.REAL 0.0
VAR_J	.REAL 10.0