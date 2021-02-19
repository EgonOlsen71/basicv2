JMP SKIPROMHANDLER
;###################################
ENABLEROM	PHA
			LDA $1
			ORA #$1
			STA $1
			PLA
			RTS
BRBUFFER	.ARRAY 255
;###################################
DISABLEROM	PHA
			LDA $1
			AND #$FE
			STA $1
			PLA
			RTS
;###################################
SKIPROMHANDLER
			JSR DISABLEROM