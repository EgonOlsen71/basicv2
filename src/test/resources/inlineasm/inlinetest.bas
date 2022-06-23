10 print "hallo"
20 rem [ldx #$ff]
30 rem [loopy; inc 53280]
40 rem [dex; bne loopy]

50 rem [numby=$ff; ldx #numby]
55 rem [jmp 60!; *=$c000;]
60 rem [inc 53280]
70 rem [dex; bne 60!]

80 rem [ldx HURZ]
90 rem [inc 53280]
100 rem [dex; bne 90!; jmp 110!; HURZ; .byte 255]

110 for i=250 to 260
120 i%=i:rem [lda i%!; clc; adc #15; sta i%!; lda i%!+1; adc #0; sta i%!+1]
130 print i%,
140 next

5000 goto 10