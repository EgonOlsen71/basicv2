*=$0400

MEMSTART=2049
MEMEND=53248

DATAPOS=$69
TOTALLEN=$6B
COMPPOS=$6D

IPOS=$6F

SCREEN=$0400

COPYFROM=$61
COPYTO=$63
COPYLEN=$65

RUNCALL=$A871
NEWCALL=$A644
ENDCALL=$A834

		sei
		lda $1
		sta tmpreg
		and #$fe
		sta $1
		
		lda COMPPOS
		sta IPOS
		lda COMPPOS+1
		sta IPOS+1
		
		lda #<MEMSTART
		sta mempos
		lda #>MEMSTART
		sta mempos+1

loop:

		; int target = 0;
		ldy #0
		sty target
		sty target+1

		; int start = readLowHigh(res, i) + memStart;
		lda (IPOS),y
		sta start
		iny
		lda (IPOS),y
		sta start+1
		dey
		
		lda start
		clc
		adc #<MEMSTART
		sta start
		lda start+1
		adc #>MEMSTART
		sta start+1
		
		; i += 2;
		jsr iposplus2

innerloop:

		; int len = res[i] & 0xFF;
		lda (IPOS),y
		sta slen
		
		; i++;
		inc IPOS
		bne skip1
		inc IPOS+1
skip1:

		; target = 0;
		sty target
		sty target+1
		
		; if (len != 0) {
		lda slen
		bne cont1
		jmp skip2

cont1:

		; target = readLowHigh(res, i) + memStart;
		lda (IPOS),y
		sta target
		iny
		lda (IPOS),y
		sta target+1
		dey
		
		lda target
		clc
		adc #<MEMSTART
		sta target
		lda target+1
		adc #>MEMSTART
		sta target+1
		
		; int copyLen = target - pos;
		lda target
		sec
		sbc mempos
		sta clen
		lda target+1
		sbc mempos+1
		sta clen+1
		
		; if (copyLen > 0) {
		lda clen
		bne docopy
		lda clen+1
		bne docopy
		jmp donotcopy

docopy:

		; byteCount += moveData(res, dataPos, pos, copyLen);
		lda DATAPOS
		sta COPYFROM
		lda DATAPOS+1
		sta COPYFROM+1
		
		lda mempos
		sta COPYTO
		lda mempos+1
		sta COPYTO+1
		
		lda clen
		sta COPYLEN
		lda clen+1
		sta COPYLEN+1
		
		jsr copy
		
		; dataPos += copyLen;
		lda DATAPOS
		clc
		adc clen
		sta DATAPOS
		lda DATAPOS+1
		adc clen+1
		sta DATAPOS+1
		
		; pos = target;
		lda target
		sta mempos
		lda target+1
		sta mempos+1

donotcopy:

		; byteCount += moveData(res, start, target, len);
		lda start
		sta COPYFROM
		lda start+1
		sta COPYFROM+1
		
		lda target
		sta COPYTO
		lda target+1
		sta COPYTO+1
		
		lda slen
		sta COPYLEN
		sty COPYLEN+1
		
		jsr copy
		
		;pos += len;
		lda mempos
		clc
		adc slen
		sta mempos
		lda mempos+1
		adc #0
		sta mempos+1
		
		; i += 2;
		jsr iposplus2
		jmp skip3			

skip2:
		; i++;
		inc IPOS
		bne skip3
		inc IPOS+1

skip3:

		; while (target > 0);
		lda target+1
		bne dowhile
		lda target
		bne dowhile
		jmp exitwhile
		
		dowhile:
		jmp innerloop

exitwhile:

		; end of for
		lda IPOS+1
		cmp #>MEMEND
		bcc nextfor
		beq checklow
		jmp endfor
		
		checklow:
		lda IPOS
		cmp #<MEMEND
		bcs endfor
		
		nextfor:
		jmp loop

endfor:

		; int left = compPos - dataPos;
		lda COMPPOS
		sec
		sbc DATAPOS
		sta COPYLEN
		lda COMPPOS+1
		sbc DATAPOS+1
		sta COPYLEN+1
		
		
		; moveData(res, dataPos, pos, left);
		lda DATAPOS
		sta COPYFROM
		lda DATAPOS+1
		sta COPYFROM+1
		
		lda mempos
		sta COPYTO
		lda mempos+1
		sta COPYTO+1
		
		jsr copy
		
		lda mempos
		clc
		adc COPYLEN
		sta 45
		sta 47
		sta 49
		lda mempos+1
		adc COPYLEN+1
		sta 46
		sta 48
		sta 50
		
		; Normal BASIC header, then just call RUN
		<IF !SYSADDR>
		lda tmpreg
		sta $1
		cli
		jmp RUNCALL
		</IF>
		
		; Somewhere else in memory, then copy up and jump into it
		<IF SYSADDR>
		
		lda #<SYSADDR
		sta COPYTO
		lda #>SYSADDR
		sta COPYTO+1
		
		lda 45
		sec
		sbc #<MEMSTART
		sta COPYLEN
		lda 46
		sbc #>MEMSTART
		sta COPYLEN+1
		
		lda #<MEMSTART
		sta COPYFROM
		lda #>MEMSTART
		sta COPYFROM+1
		
		jsr copyup
				
		lda tmpreg
		sta $1
		cli
		
		jsr NEWCALL
		jsr SYSADDR
		jmp ENDCALL
		
copyup:
		ldx COPYLEN+1
		clc
		txa
		adc COPYFROM+1
		sta COPYFROM+1
		clc
		txa
		adc COPYTO+1
		sta COPYTO+1
		inx
		ldy COPYLEN
		beq cuskip3
		dey
		beq cuskip2

culoop:      
		lda (COPYFROM),y
		sta (COPYTO),y
		dey
		bne culoop

cuskip2:    
		lda (COPYFROM),y
		sta (COPYTO),y
  
cuskip3:  
		dey
		dec COPYFROM+1
		dec COPYTO+1
		dex
		bne culoop
		ldy #0
		ldy #0
		rts		
		</IF>

copy:

		ldy #0
		ldx COPYLEN+1
		beq lowonly

cloop:   

		lda (COPYFROM),y
		sta (COPYTO),y
		iny
		bne cloop
		inc COPYFROM+1
		inc COPYTO+1
		dex
		bne cloop

lowonly:   
  
		ldx COPYLEN
		beq endcopy

clooplow:      
		lda (COPYFROM),y
		sta (COPYTO),y
		iny
		dex
		bne clooplow

endcopy:
		ldy #0
		ldx #0
		rts

iposplus2:
		lda IPOS
		clc
		adc #2
		sta IPOS
		lda IPOS+1
		adc #0
		sta IPOS+1
		rts

start:
		.word 0

copystart:
		.word 0

clen:
		.word 0

target:
		.word 0

mempos:
		.word 0

slen:
		.byte 0

tmpreg:
		.byte 0



