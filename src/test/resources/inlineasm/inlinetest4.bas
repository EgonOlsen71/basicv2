10 print "hello asm"
20 rem [ldx #$ff]
30 rem [jmp 40!; *=$2000;]
40 rem [inc 53280]
50 rem [dex; bne 40!]
60 goto 10