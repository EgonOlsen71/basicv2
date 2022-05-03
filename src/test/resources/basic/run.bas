10 input "welches spiel wollen sie starten (1 oder 2)? ";a$
20 a = val(a$)
25 print"hello!"
30 if a<1 or a>2 then run: rem falsche auswahl dann neustart 
40 if a=1 then run 10000: rem startzeile des 1. spiels
50 if a=2 then run 20000: rem startzeile des 2. spiels
60 end
10000 print "sie haben spiel 1 gestartet": end
20000 print "sie haben spiel 2 gestartet": end