10 a=5.123
20 b%=37
30 c%=a
40 d=a:u%=1024:vr=1030
50 poke u%,a
60 poke vr,peek(u%)
70 gosub 1000:goto 100
80 a=56.222
100 a=a
102 if a=5.123 then poke 1040,b%:if a=2 then poke 1040,123:poke1040,111 
103 if b%=4 then poke 1040,234
110 end
1000 d=99.812
1010 return

