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
ucoord = 838
vcoordz = 97
ucoordz = 99
deltau  = 840
deltav = 842
deltauz = 101
deltavz = 105
graphics = 844
temp_low = 846
temp_high = temp_low+1
mem_low = 848
mem_high = mem_low+1

			lda xstart
			sta $fe
			lda vcoord
			sta vcoordz
			lda vcoord+1
			sta vcoordz+1
			lda ucoord
			sta ucoordz
			lda ucoord+1
			sta ucoordz+1
			lda deltau
			sta deltauz
			lda deltau+1
			sta deltauz+1
			lda deltav
			sta deltavz
			lda deltav+1
			sta deltavz+1
loop		lda vcoordz		; (v%/2)
			lsr
			tax				;x = low
			lda vcoordz+1	;a = high
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
			ldx ucoordz 		;x = low
			ldy ucoordz+1	;y = high
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
			sta $fb			; store result in temp
			lda graphics
			sta mem_low
			lda graphics+1
			sta mem_high
			lda $fe			; mt + 2*(x and 252)
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
			sta $fc
			ldy #0
			lda ($fb),y		; peek(...)
			tax
			lda $fe
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
			lda ucoordz		; u%=u%+du%
			clc
			adc deltauz
			bcc cont6
			inc ucoordz+1
cont6		sta ucoordz
			lda ucoordz+1
			clc
			adc deltauz+1
			sta ucoordz+1
			lda vcoordz		; v%=v%+dv%
			clc
			adc deltavz
			bcc cont7
			inc vcoordz+1
cont7		sta vcoordz
			lda vcoordz+1
			clc
			adc deltavz+1
			sta vcoordz+1
			lda $fe
			cmp xend
			beq end
			inc $fe
			jmp loop
end			rts

pots		.byte 6 4 2 0






