10 print "running assembler program!"
20 sys 49152
30 print "getting results:"
35 rem poke 1024,23
40 for i=1024 to 1034:printchr$(peek(i));:nexti
45 print
50 for i=1064 to 1092:printchr$(peek(i));:nexti
