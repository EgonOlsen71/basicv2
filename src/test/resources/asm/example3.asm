;Highly sophisticated assembler program that does important things!

*=1064		; Write some stuff into text mode memory (line 2)...because we can!
.text "somewhere, over the rainbow..."

*=$c000   	; Define start address

SCREEN_MEMORY = 1024
SCREEN_MEMORY2=SCREEN_MEMORY+1

setup		 lda #<irqsub			;set irq vector to "irqsub"
			 sta $fffe
			 lda #>irqsub
			 sta $ffff
start        lda #64           		;put an @ into a
             sta SCREEN_MEMORY 		;store in text mode memory

             ldx #03           		;load some random value
             ldy #10           		;load some other random value
             clc               		;clear carry
             jsr somesub       		;jump to some random sub routine

             ldx #$00          		;reset x
loop	     lda TEXT,X        		;get next character
             beq end           		;end reached (0 terminated)
             sta SCREEN_MEMORY2,X   ;write into text mode memory
             inx               		;set pointer to the next char
             jmp loop

end          rts			   		;back to system

somesub		 ldy #56				;load something into y
			 brk					;trigger software irq
			 nop					;has to be here because of...brk...
			 rts

irqsub 		 sei					;disable irqs
			 sty 1500				;store y somewhere in text mode memory
			 iny					;inc y
			 cli					;enable irqs again
			 rti

			 .text "something without meaning!" 		;just filler bytes
TEXT         .text "C64 rocks!"  						;What we actually want to print
             .byte $00         							;end flag
