10 print chr$(147)
20 poke 36879,14
30 for y=0 to 22
40 for x=0 to 21
50 pa=4096+x+22*y
60 ca=37888+x+22*y
70 poke pa,81
80 poke ca,0
90 next x
100 next y
105 for x=0 to 15
110 read d
120 pa=4096+22*22+x
125 ca=37888+x+22*22
130 poke pa,d
135 poke ca,1
140 next x
145 data 22,9,3,50,48,32,56,48,39,19,32,4,9,19,3,15
150 c = int(rnd(1)*8)
160 x = int(rnd(1)*11)
170 y = int(rnd(1)*11)
180 ca=37888+x+22*y
190 cb=37888+21-x+22*y
200 cc=37888+x+462-22*y
210 cd=37888+21-x+462-22*y
220 poke ca,c
230 poke cb,c
240 poke cc,c
250 poke cd,c
260 goto 150