*=$c000

			; Target
			LDA	#$20
			LDX #$00
			STA TMP_REG+1
			STX TMP_REG
			
			; length
			STA TMP3_REG+1
			STX TMP3_REG
			
			; Source
			LDA	#$21
			LDX #$23
			STA TMP2_REG+1
			STX TMP2_REG
			
			JSR QUICKCOPY
			RTS

QUICKCOPY	LDA TMP_REG
			STA TMEM+1
			LDA TMP_REG+1
			STA TMEM+2
			
			LDA TMP2_REG
			STA SMEM+1
			LDA TMP2_REG+1
			STA SMEM+2
			
			LDY #$0
			LDX TMP3_REG
LOOP	
TMEM		LDA $0000,Y
SMEM		STA $0000,Y
			INY
			BNE YNOOV
			INC TMEM+2
			INC SMEM+2
YNOOV		DEX
			BNE LOOP
			DEC TMP3_REG
			BNE LOOP
			RTS
			

TMP_REG .WORD 0
TMP2_REG .WORD 0
TMP3_REG .WORD 0

