;###################################
BRCOPYREALAY
			STX BRBUFFER+6		;save X
			LDX #4
			STY BRCOPYLOOP+2	; modify from address
			STA BRCOPYLOOP+1
BRCOPYLOOP	LDA $FFFF,X
			STA BRBUFFER,X
			DEX
			BPL BRCOPYLOOP
			LDX BRBUFFER+6		; restore X
			LDA #<BRBUFFER
			LDY #>BRBUFFER
			RTS
;###################################
BRCOPYREALXY
			PHA					;save A
			LDX BRBUFFER+6
			LDY BRBUFFER+7
			STX BRCOPYLOOP2+4	; modify from address
			STY BRCOPYLOOP2+5
			LDX #4
BRCOPYLOOP2	LDA BRBUFFER,X
			STA $FFFF,X
			DEX
			BPL BRCOPYLOOP2
			PLA					; restore A
			RTS
;###################################
BRCOPYSTRING
			CPY #0
			BNE BRCOPYSTRINGCONT
			RTS
BRCOPYSTRINGCONT
			PHA
			TYA
			PHA
			LDA #<BRBUFFER
			STA BRCOPYSTRINGLOOP+4
			LDA #>BRBUFFER
			STA BRCOPYSTRINGLOOP+5
BRCOPYSTRINGLOOP
			DEY
			LDA (INDEX1),Y
			STA $FFFF,Y
			CPY #0
			BNE BRCOPYSTRINGLOOP
			LDA #<BRBUFFER
			STA INDEX1
			LDA #>BRBUFFER
			STA INDEX1+1
			PLA
			TAY
			PLA
			RTS
;###################################
REALFAC		CPY #>BRROMSTART
			BCC BRREALFACN
			CPY #>BRROMEND
			BCS BRREALFACN
			JSR BRCOPYREALAY
BRREALFACN	JSR ENABLEROM
			JSR BRREALFAC
			JMP DISABLEROM
;###################################
MEMARG		CPY #>BRROMSTART
			BCC BRMEMARGN
			CPY #>BRROMEND
			BCS BRMEMARGN
			JSR BRCOPYREALAY
BRMEMARGN	JSR ENABLEROM
			JSR BRMEMARG
			JMP DISABLEROM
;###################################
MEMMUL		CPY #>BRROMSTART
			BCC BRMEMMULN
			CPY #>BRROMEND
			BCS BRMEMMULN
			JSR BRCOPYREALAY
BRMEMMULN	JSR ENABLEROM
			JSR BRMEMMUL
			JMP DISABLEROM
;###################################
MEMSUB		CPY #>BRROMSTART
			BCC BRMEMSUBN
			CPY #>BRROMEND
			BCS BRMEMSUBN
			JSR BRCOPYREALAY
BRMEMSUBN	JSR ENABLEROM
			JSR BRMEMSUB
			JMP DISABLEROM
;###################################
FACADD		CPY #>BRROMSTART
			BCC BRFACADDN
			CPY #>BRROMEND
			BCS BRFACADDN
			JSR BRCOPYREALAY
BRFACADDN	JSR ENABLEROM
			JSR BRFACADD
			JMP DISABLEROM
;###################################
FACDIV		CPY #>BRROMSTART
			BCC BRFACDIVN
			CPY #>BRROMEND
			BCS BRFACDIVN
			JSR BRCOPYREALAY
BRFACDIVN	JSR ENABLEROM
			JSR BRFACDIV
			JMP DISABLEROM
;###################################
CMPFAC		CPY #>BRROMSTART
			BCC BRCMPFACN
			CPY #>BRROMEND
			BCS BRCMPFACN
			JSR BRCOPYREALAY
BRCMPFACN	JSR ENABLEROM
			JSR BRCMPFAC
			JMP DISABLEROM
;###################################
FACMEM		CPY #>BRROMSTART
			BCC BRFACMEMN
			CPY #>BRROMEND
			BCS BRFACMEMN
			STX BRBUFFER+6			;save X
			STY BRBUFFER+7			;save Y
			LDX #<BRBUFFER
			LDY #>BRBUFFER
			JSR ENABLEROM
			JSR BRFACMEM
			JSR DISABLEROM
			JMP BRCOPYREALXY
BRFACMEMN	JSR ENABLEROM			; x low,y high
			JSR BRFACMEM
			JMP DISABLEROM
;###################################
VALS		PHA
			LDA INDEX1+1			; y = length, INDEX1/INDEX1+1 address
			CMP #>BRROMSTART		
			BCC BRVALSN
			CMP #>BRROMEND		
			BCS BRVALSN
			JSR BRCOPYSTRING
BRVALSN		PLA
			JSR ENABLEROM			
			JSR BRVALS
			JMP DISABLEROM
;###################################
PRINTSTRS	
			PHA
			LDA INDEX1+1			; x = length, INDEX1/INDEX1+1 address 
			CMP #>BRROMSTART		
			BCC BRPRINTSTRSN
			CMP #>BRROMEND		
			BCS BRPRINTSTRSN
			TXA						; move length into Y to reuse copy routine
			TAY
			JSR BRCOPYSTRING
			TYA						; ...and back
			TAX
BRPRINTSTRSN
			PLA
			JSR ENABLEROM
			JSR BRPRINTSTRS
			JMP DISABLEROM
;###################################
SGNFAC		JSR ENABLEROM
			JSR BRSGNFAC
			JMP DISABLEROM
;###################################
ARGADD		JSR ENABLEROM
			JSR BRARGADD
			JMP DISABLEROM
;###################################
ARGAND		JSR ENABLEROM
			JSR BRARGAND
			JMP DISABLEROM
;###################################
ARGDIV		JSR ENABLEROM
			JSR BRARGDIV
			JMP DISABLEROM
;###################################
FACMUL		JSR ENABLEROM
			JSR BRFACMUL
			JMP DISABLEROM
;###################################
FACLOG		JSR ENABLEROM
			JSR BRFACLOG
			JMP DISABLEROM
;###################################
FACSQR		JSR ENABLEROM
			JSR BRFACSQR
			JMP DISABLEROM
;###################################
FACEXPCALL	JSR ENABLEROM
			JSR BRFACEXPCALL
			JMP DISABLEROM
;###################################
FACABS		JSR ENABLEROM
			JSR BRFACABS
			JMP DISABLEROM
;###################################
FACSIN		JSR ENABLEROM
			JSR BRFACSIN
			JMP DISABLEROM
;###################################
FACCOS		JSR ENABLEROM
			JSR BRFACCOS
			JMP DISABLEROM
;###################################
FACTAN		JSR ENABLEROM
			JSR BRFACTAN
			JMP DISABLEROM
;###################################
FACATN		JSR ENABLEROM
			JSR BRFACATN
			JMP DISABLEROM
;###################################
FACSIG		JSR ENABLEROM
			JSR BRFACSIG
			JMP DISABLEROM
;###################################
FACNOT		JSR ENABLEROM
			JSR BRFACNOT
			JMP DISABLEROM
;###################################
FACRND		JSR ENABLEROM
			JSR BRFACRND
			JMP DISABLEROM
;###################################
FACWORD		JSR ENABLEROM
			JSR BRFACWORD
			JMP DISABLEROM
;###################################
BASINT		JSR ENABLEROM
			JSR BRBASINT
			JMP DISABLEROM
;###################################
FACPOW		JSR ENABLEROM
			JSR BRFACPOW
			JMP DISABLEROM
;###################################
FACSUB		JSR ENABLEROM
			JSR BRFACSUB
			JMP DISABLEROM
;###################################
FACOR		JSR ENABLEROM
			JSR BRFACOR
			JMP DISABLEROM
;###################################
ARGFAC		JSR ENABLEROM
			JSR BRARGFAC
			JMP DISABLEROM
;###################################
FACARG		JSR ENABLEROM
			JSR BRFACARG
			JMP DISABLEROM
;###################################
FACSTR		JSR ENABLEROM
			JSR BRFACSTR
			JMP DISABLEROM
;###################################
FACINT		JSR ENABLEROM
			JSR BRFACINT
			JMP DISABLEROM
;###################################
RNDFAC		JSR ENABLEROM
			JSR BRRNDFAC
			JMP DISABLEROM
;###################################
INTFAC		JSR ENABLEROM
			JSR BRINTFAC
			JMP DISABLEROM
;###################################
WRITETIS	JSR ENABLEROM
			JSR BRWRITETIS
			JMP DISABLEROM
;###################################
GETTI		JSR ENABLEROM
			JSR BRGETTI
			JMP DISABLEROM
;###################################
GETTIME		JSR ENABLEROM
			JSR BRGETTIME
			JMP DISABLEROM
;###################################
COPYTIME	JSR ENABLEROM
			JSR BRCOPYTIME
			JMP DISABLEROM
;###################################
TI2FAC		JSR ENABLEROM
			JSR BRTI2FAC
			JMP DISABLEROM
;###################################
BYTEFAC		JSR ENABLEROM
			JSR BRBYTEFAC
			JMP DISABLEROM
;###################################
CRSRRIGHT	JSR ENABLEROM
			JSR BRCRSRRIGHT
			JMP DISABLEROM
;###################################
ERRALL		JSR ENABLEROM
			JSR BRERRALL
			JMP DISABLEROM
;###################################
ERRIQ		JSR ENABLEROM
			JSR BRERRIQ
			JMP DISABLEROM
;###################################
ERREI		JSR ENABLEROM
			JSR BRERREI
			JMP DISABLEROM
;###################################
ERRSYN		JSR ENABLEROM
			JSR BRERRSYN
			JMP DISABLEROM
;###################################
INPUT		JSR ENABLEROM
			JSR BRINPUT
			JMP DISABLEROM
;###################################
