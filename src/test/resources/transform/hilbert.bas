1 dimw%(7):dimb%(7)
10 input"tiefe (1-7)";o%
20 ifo%<1oro%>7then10
30 m%=2^(7-o%)
90 :
100 :
101 : rem   hauptprogramm
102 :
120 gosub10000:gosub200:poke198,0:wait198,1:gosub14000:goto10
130 :
160 :
165 : rem   hilbert-prozedur
170 :
200 ifo%=0theno%=o%+b%:return
205 w%=w%-w%(o%):o%=o%-b%:w%(o%)=-w%(o%+b%):gosub200
220 gosub11400:w%=w%+w%(o%):o%=o%-b%:w%(o%)=w%(o%+b%):gosub200
260 gosub11400:o%=o%-b%:w%(o%)=w%(o%+b%):gosub200
280 w%=w%+w%(o%):gosub11400:o%=o%-b%:w%(o%)=-w%(o%+b%):gosub200
290 w%=w%-w%(o%):o%=o%+b%:return
900 :
910 :
10000 :
10001 : rem  initialisieren
10002 :
10005 poke56576,198:poke56578,63
10020 poke53272,120:poke648,92
10030 poke53265,187:i%=24576
10040 for i=24576to32575:pokei,0:next
10045 for i=23552to24551:pokei,16:next
10055 w%=1:a%=4:b%=1:y%=170:x%=60
10057 w%(o%)=1
10062 b%(7)=1:b%(6)=2:b%(5)=4:b%(4)=8:b%(3)=16:b%(2)=32:b%(1)=64:b%(0)=128
10070 return
10075 :
10077 :
10078 : rem    plot
10080 :
11000 j%=(x%and504)+40*(y%and248)+(y%and7)+24576
11020 pokej%,peek(j%)orb%(x%and7):return
11400 :
11401 :
11402 : rem    move
11403 :
11410 i%=m%
11420 onw%and3goto11520,11540,11560
11440 :
11500 x%=x%+1:gosub11000
11505 i%=i%-1:ifi%then11500
11510 return
11520 y%=y%-1:gosub11000
11525 i%=i%-1:ifi%then11520
11530 return
11540 x%=x%-1:gosub11000
11545 i%=i%-1:ifi%then11540
11550 return
11560 y%=y%+1:gosub11000
11565 i%=i%-1:ifi%then11560
11570 return
13140 :
13150 :
14000 poke53265,27:poke53272,21
14005 poke648,4
14010 poke56578,63:poke56576,151
14020 return
