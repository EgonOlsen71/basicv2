;for x=int(xs%/di%) to int(xe%/di%)
;tp%=((v%/2) and 4032)+int(u%/di%)
;ma = mt + 2*(x and 252)
;poke ma, peek(ma) or (peek(tx+(tp% and 4095))*pt%(x and 3))
;u%=u%+du%:v%=v%+dv%
;next x

*=$0400

xstart = 834
xend = 835
vcoord = 836
vcoord_h = 837
ucoord = 838
ucoord_h = 839
deltau  = 840
deltau_h = 841
deltav = 842
deltav_h = 843
graphics = 844
graphics_h = 845
temp_low = 846
temp_high = temp_low+1
mem_low = 848
mem_high = mem_low+1

loop		lda vcoord		; (v%/2)
			lsr
			tax				;x = low
			lda vcoord_h	;a = high
			clc
			lsr
			bcc cont
			tay
			txa
			ora #$80
			tax
			tya
cont		and #$0f		; ...and 4032
			sta temp_high
			txa
			and #$c0
			sta temp_low
			lda #$7			;shift counter, u%/di%
			sta $2
			ldx ucoord 		;x = low
			ldy ucoord_h	;y = high
shiftloop	txa
			lsr
			tax
			tya
			clc
			lsr
			bcc cont2
			tay
			txa
			ora #$80
			tax
			jmp cont3
cont2		tay
cont3		dec $2
			bne shiftloop
			txa
			ora temp_low	; a+b
			sta temp_low	; store result in temp
			lda graphics
			sta mem_low
			lda graphics_h
			sta mem_high
			lda xstart		; mt + 2*(x and 252)
			and #$fc
			clc
			asl
			bcc cont4
			inc mem_high
cont4		clc
			adc mem_low
			bcc cont5
			inc mem_high
cont5		sta mem_low
			lda temp_high	; (tp% and 4095)
			and #$0f
			clc
			adc #$c0		; + $c000
			sta temp_high
			sta $fc
			lda temp_low
			sta $fb
			ldy #0
			lda ($fb),y		; peek(...)
			tax
			lda xstart
			and #$03
			tay
			txa
			sta $fb
			lda pots,y
			beq noshift
			sta $2
calc		asl $fb
			dec $2
			bne calc
noshift		lda mem_low
			sta $fc
			lda mem_high
			sta $fd
			ldy #0
			lda ($fc),y		; peek(ma)
			ora $fb
			sta ($fc),y		; poke ma
			lda ucoord		; u%=u%+du%
			clc
			adc deltau
			bcc cont6
			inc ucoord_h
cont6		sta ucoord
			lda ucoord_h
			clc
			adc deltau_h
			sta ucoord_h
			lda vcoord		; v%=v%+dv%
			clc
			adc deltav
			bcc cont7
			inc vcoord_h
cont7		sta vcoord
			lda vcoord_h
			clc
			adc deltav_h
			sta vcoord_h
			lda xstart
			cmp xend
			beq end
			inc xstart
			jmp loop
end			rts

pots		.byte 6 4 2 0






