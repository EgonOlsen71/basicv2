*=$c000

		ldx #$00    
		ldy #$00           ; Z�hler 
loop:   sta $2000,x       ; Bitmap-Speicher 
		dex               
		bne loop          ; innere Schleife 
		iny                    ; �u�ere Schleife  
		inc *-5              ; Hi-byte im Bitmap-Speicher erh�hen  
		cpy #$20          ; 32*256 Byte = 8 Kbyte 
		bne loop           ; �u�ere Schleife
		rts 