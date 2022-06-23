10 print "hello asm": i%=255
20 rem [ ldx numby ]
30 rem [ inc 53280 ]
40 rem [ dex; bne 30!; jmp 50! ]
45 rem [ numby; .byte 255 ]
50 goto 10