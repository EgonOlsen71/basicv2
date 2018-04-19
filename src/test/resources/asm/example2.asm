; Dieses Programm löscht den Bildschirm und gibt einen Text an einer definierten Position aus.
; Programmstart mit SYS 49152

*=$c000   ; Startadresse des Programms

BSOUT = $FFD2

start        lda #147          ; Steuerzeichen für Bildschirm löschen
             jsr BSOUT         ; Löschen durchführen

             ldx #03           ; Zeile 3
             ldy #10           ; Spalte 10
             clc               ; Carry-Flag = 0 Cursorposition setzen, = 1 Cursorposition lesen
             jsr $fff0         ; Cursor setzen

             ldx #$00          ; Index für Textbuchstaben in X-Register
schleife     lda TEXT,X        ; Zeichen holen
             beq ende          ; Endmarkierung? (wenn 0)
             jsr BSOUT         ; Zeichen am Bildschirm ausgeben
             inx               ; nächstes Zeichen der Zeichenkette
             jmp schleife

ende         rts               ; Rücksprung ins Basic

			 .text "something without meaning!" ;Go away...
TEXT         .text "C64-WIKI"  ; Zeichenkette
             .byte $00         ; Endemarkierung
