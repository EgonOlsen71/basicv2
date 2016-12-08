; Dieses Programm l�scht den Bildschirm und gibt einen Text an einer definierten Position aus.
; Programmstart mit SYS 49152

*=$c000   ; Startadresse des Programms

BSOUT = $ffd2

start        lda #147          ; Steuerzeichen f�r Bildschirm l�schen
             jsr BSOUT         ; L�schen durchf�hren

             ldx #03           ; Zeile 3
             ldy #10           ; Spalte 10
             clc               ; Carry-Flag = 0 Cursorposition setzen, = 1 Cursorposition lesen
             jsr $fff0         ; Cursor setzen

             ldx #$00          ; Index f�r Textbuchstaben in X-Register
schleife     lda $c01c,X        ; Zeichen holen
             beq ende          ; Endmarkierung? (wenn 0)
             jsr BSOUT         ; Zeichen am Bildschirm ausgeben
             inx               ; n�chstes Zeichen der Zeichenkette
             jmp schleife

ende         rts               ; R�cksprung ins Basic
