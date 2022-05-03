1 rem up, up, and away!
5 print "{clear}"
10 v = 53248 : rem basisadresse des vic
11 poke v+21,28
12 poke 2042,13: poke 2043,13: poke 2044,13
20 for n = 0 to 62 : read q : poke 832+n,q : next
25 poke v+23,12: poke v+29,12
30 for x = 0 to 200
40 poke v+4,x : rem neue x-koordinate
48 poke v+8,x
50 poke v+5,x : rem neue y-koordinate
58 poke v+9,100
60 next x
70 goto 30
200 data 0,127,0,1,255,192,3,255,224,3,231,224
210 data 7,217,240,7,223,240,7,217,240,3,231,224
220 data 3,255,224,3,255,224,2,255,160,1,127,64
230 data 1,62,64,0,156,128,0,156,128,0,73,0,0,73,0
240 data 0,62,0,0,62,0,0,62,0,0,28,0