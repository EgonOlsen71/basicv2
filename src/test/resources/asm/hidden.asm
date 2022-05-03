*=$c200

DATA=$c000
XP=$c1fb
YP=$c1fd
SP=$c1ff

SCR=$0400
VIC=$d000

INIT:	
		JSR IOOFF
		LDA #0
		STA I
		STA II
		STA CP
		STA LA
		STA XS
		STA YS
		STA CA
		STA CX
		STA CN
		STA OY
		STA CG
		
		LDA XP
		STA XT
		LDA XP+1
		STA XT+1
		LDA YP
		STA YT
		
		LDA #208
		STA CA+1
		
		LDA 53272
		AND #6
		CMP #6
		BNE UPPER
		LDA CA+1
		CLC
		ADC	#$8
		STA CA+1
UPPER:		
		JSR CALCSCR
		
		LDA #64		; calc addr of sprite block
		STA T1
		INC BL
		LDA BL
		CMP #15
		BNE NOT15
		LDA #13
		STA BL
NOT15:			
		STA T2
		JSR MUL
		
		LDA T1		
		STA BS
		LDA T1+1
		STA BS+1
		
		LDA #0		; reset vars
		STA I
		STA II
		STA OY
		STA CG
	
		JSR CHAROFFSET
		
MAINLOOP:		
		LDX I
		LDA DATA,X
		BEQ SKIPDRAW
		STA LA
		
		JSR FILLCP
		
		LDX CX
		BEQ DCPSHIFT
CPSHIFT:
		ASL CP
		DEX
		BNE CPSHIFT
DCPSHIFT:
		LDA #$ff
		EOR CP
		AND LA
		STA LA
		
		LDA CX
		BEQ NOCHK1
		LDA II
		AND #3
		CMP #3
		BEQ NOCHK1
		JSR DRAWRIGHT
				
NOCHK1:
		LDA BS
		CLC
		ADC I
		STA $22
		LDA BS+1
		ADC #0
		STA $23
		LDA LA
		STA ($22),Y

SKIPDRAW:		
		LDX I
		INX
		INX
		INX
		STX I
		
		INC CN
		INC CG
		
		LDA CN
		CMP #8
		BCS NOCHK2
		LDA CG
		CMP #8
		BCS NOCHK2
		CPX #63			; I is still in X
		BCS NOCHK2
		JMP MAINLOOP
		
NOCHK2:
		CPX #65
		BCC CONT1
		JMP EXIT
CONT1:
		LDA CN
		CMP #8
		BNE NOCHK3
		LDA OY
		BNE NOCHK3
		LDA CG
		CMP #8
		BCS NOCHK3
		JSR YOVERFLOW
		JMP MAINLOOP
		
NOCHK3:
		LDA OY
		BEQ NOCHK4
		LDA YP
		SEC
		SBC #8
		STA YP
		LDA #0
		STA OY
NOCHK4:
		LDA XP
		CLC
		ADC #8
		STA XP
		LDA XP+1
		ADC #0
		STA XP+1
		
		INC II
		LDA II
		AND #3
		CMP #3
		BNE NOCHK5
		LDA II
		CLC
		ADC #21
		STA II
		LDA XP
		SEC
		SBC #24
		STA XP
		LDA XP+1
		SBC #0
		STA XP+1
		LDA YP
		CLC
		ADC #8
		STA YP
NOCHK5:
		LDA II
		STA I
		JSR CHAROFFSET
		JSR CALCSCR
		LDA #0
		STA CG
		JMP MAINLOOP
EXIT:
		JSR IOON
RASTERWAIT:	
		;LDA $d012	; wait for raster below sprite
		;CMP YP
		;BCC RASTERWAIT
		
		LDA SP
		TAY
		ASL
		TAX
		LDA XT
		STA VIC,X
		INX
		LDA YT
		STA VIC,X
		
		LDA BYT,Y
		
		LDX XT+1
		BEQ LOW255

		ORA $d010
		STA $d010
		
		JMP RETURN
LOW255:	
		EOR #$ff
		AND $d010
		STA $d010
RETURN:	
		LDA BL
		LDX SP
		STA 2040,X
		
		;LDA #0
		;STA 53280
		RTS

FILLCP:
		LDA CH
		CLC 
		ADC CN
		STA $22
		LDA CH+1
		ADC #0
		STA $23
		LDY #0
		LDA ($22),Y
		STA CP
		RTS

YOVERFLOW:
		LDA #7
		SEC
		SBC CN
		STA CG
		LDA #0
		STA CN
		LDA YP
		CLC
		ADC #8
		STA YP
		JSR CALCSCR
		LDA #1
		STA OY
		RTS

DRAWRIGHT:
		LDA XS
		CMP #39
		BCC DODRAW
		RTS
DODRAW:
		LDA XP	
		CLC
		ADC #8
		STA XP
		LDA XP+1
		ADC #0
		STA XP+1
		JSR CALCSCR
		JSR FILLCP
		
		LDA #8
		SEC
		SBC CX
		TAX
		BEQ DCPSHIFT2
CPSHIFT2:
		LSR CP
		DEX
		BNE CPSHIFT2
DCPSHIFT2:
		LDX CX
		LDA POW,X
		STA MM
		LDA #$ff
		EOR CP
		STA T1
		LDA #$ff
		EOR MM
		AND T1
		ORA MM
		AND LA
		STA LA
		
		LDA XP
		SEC
		SBC #8
		STA XP
		LDA XP+1
		SBC #0
		STA XP+1
		JSR CALCSCR
		RTS

CHAROFFSET:
		LDA YP
		SEC
		SBC #50
		AND #7
		STA CN
		LDA XP
		AND #7
		STA CX
		RTS

CALCSCR:
		LDA XP
		SEC
		SBC #24
		STA T1
		LDA XP+1
		SBC #0
		STA T1+1
		JSR DIV8
		LDA T1
		STA XS		; x-pos on screen
		
		LDA YP
		SEC
		SBC #50
		LSR
		LSR
		LSR
		STA YS		; y-pos on screen
		
		STA T2		; mul by 40
		LDA #40
		STA T1
		JSR MUL
		LDA T1
		CLC			; add x pos
		ADC XS
		STA T1
		LDA T1+1
		ADC #0
		STA T1+1
		
		LDA T1		; add screen address
		CLC
		ADC #<SCR
		STA $22
		LDA T1+1
		ADC #>SCR
		STA $23
		
		LDY #0
		STY T1+1
		LDA ($22),Y
		
		CMP #126		;exclude this char code
		BNE ENDCP
		LDA #32
ENDCP:		
		
		STA T1
		
		JSR MUL8
		
		LDA T1
		CLC
		ADC CA
		STA CH
		LDA T1+1
		ADC CA+1
		STA CH+1
		RTS

DIV8:
		LSR T1+1
		ROR T1
		LSR T1+1
		ROR T1
		LSR T1+1
		ROR T1
		RTS
		
MUL8:
		ASL T1
 		ROL T1+1
 		ASL T1
 		ROL T1+1
 		ASL T1
 		ROL T1+1
		RTS
		
MUL:	
		LDA #$00
 		TAY
 		STY T1+1
 		BEQ ENTERLOOP
DOADD:
		CLC
		ADC T1
		TAX
		TYA
		ADC T1+1
		TAY
		TXA
LOOP:
 		ASL T1
 		ROL T1+1
ENTERLOOP:
 		LSR T2
 		BCS DOADD
 		BNE LOOP
 		
 		STA T1
 		STY T1+1
 		RTS
 		
IOOFF:	
 		SEI
 		LDA 1
 		AND #251
 		STA 1
 		RTS
 
IOON:
		LDA 1
		ORA #4
		STA 1
		CLI
		RTS

I		.byte 0
II 		.byte 0
CP		.byte 0
CG		.byte 0
OY		.byte 0
LA		.byte 0
XS		.byte 0
YS		.byte 0
MM		.byte 0
CA		.word 53248
CH		.word 0
CN		.byte 0
CX		.byte 0
BS		.word 0
T1		.word 0
T2		.word 0
XT 		.word 0
YT		.byte 0
POW		.byte $ff $fe $fc $f8 $f0 $e0 $c0 $80 $00
BYT		.byte 1 2 4 8 16 32 64 128
BL		.byte 13

