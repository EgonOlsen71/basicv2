*=$c000

		ldx #$00    
		ldy #$00           ; Zähler 
loop:   sta $2000,x       ; Bitmap-Speicher 
		dex               
		bne loop          ; innere Schleife 
		iny                    ; äußere Schleife  
		inc *-5              ; Hi-byte im Bitmap-Speicher erhöhen  
		cpy #$20          ; 32*256 Byte = 8 Kbyte 
		bne loop           ; äußere Schleife
		rts 