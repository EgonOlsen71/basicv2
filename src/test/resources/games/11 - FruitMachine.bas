1 M=30:W=0
2 DIM R(3):V=53248:POKEV+21,7
3 POKE2040,13:POKE2041,14:POKE2042,15:POKEV+39,2:POKEV+40,5:POKEV+41,9
4 FOR N=0 TO 190:READ Q:POKE832+N,Q:NEXT
5 POKEV,108:POKEV+1,100:POKEV+2,160:POKEV+3,100:POKEV+4,210:POKEV+5,100
10 POKE53281,0:POKE53280,0
20 PRINT"{clear}{yellow}money M{space*6}"
30 PRINT"{down*2}{yellow}{space*6}{reverse on}{space*25}"
31 PRINT"{yellow}{space*6}{reverse on}{space*25}"
32 PRINT"{yellow}{space*6}{reverse on}{space*25}"
33 PRINT"{yellow}{space*6}{reverse on}{space*4}{reverse off}{space*4}{reverse on}{space*2}{reverse off}{space*5}{reverse on}{space*2}{reverse off}{space*4}{reverse on}{space*4}"
34 PRINT"{yellow}{space*6}{reverse on}{space*4}{reverse off}{space*4}{reverse on}{space*2}{reverse off}{space*5}{reverse on}{space*2}{reverse off}{space*4}{reverse on}{space*4}"
35 PRINT"{yellow}{space*6}{reverse on}{space*4}{reverse off}{space*4}{reverse on}{space*2}{reverse off}{space*5}{reverse on}{space*2}{reverse off}{space*4}{reverse on}{space*4}"
36 FOR I=1 TO 7
37 PRINT "{yellow}{space*6}{reverse on}"
38 NEXT
39 PRINT "{home}{down*9}{left*7}{red}{reverse on}{space*3}{reverse off}{down}{left*3}{reverse on}{space*3}{reverse off}{down}{left*2}{white}{reverse on} {down}{left} {down}{left} {down}{left*3}{space*5}"
40 PRINT"{right*11}{space*15}"
41 PRINT"{right*13}{yellow}{cm o*11}"
42 PRINT"{white}{home}{down*18}{cm +*3} {cm +*4} {cm +}{space*2}{cm +}{space*2}{cm +} {cm +*5}"
43 PRINT"{cm +}{space*3}{cm +}{space*2}{cm +} {cm +}{space*2}{cm +}{space*2}{cm +}{space*3}{cm +}"
44 PRINT"{cm +*3} {cm +*3}{space*2}{cm +}{space*2}{cm +}{space*2}{cm +}{space*3}{cm +}"
45 PRINT"{cm +}{space*3}{cm +}{space*2}{cm +} {cm +*4}{space*2}{cm +}{space*3}{cm +}{space*2}machine"
46 PRINT "{down}{cyan}you win M"
100 PRINT"{home}{right*7}{white}{space*5}{left*5}";M
110 PRINT"{down*10}{right*11}{yellow}{reverse on}'c' to carry on{down}{left*15}'q' to quit"
115 POKE 198,0
120 GET A$:IF A$="q" THEN 5000
121 IF A$<>"c" THEN 120
122 GOSUB 8000
125 FOR I=1 TO 3
130 R(I)=INT(RND(1)*3+1):IF RND(1)<.7 AND R(I)=R(I-1) THEN 130
131 IF R(I)=3 AND RND(1)<.6 THEN 130
140 NEXT
141 IF I=2 THEN PRINT "{home}{down*6}{right*16}";
142 IF I=3 THEN PRINT "{home}{down*6}{right*23}";
160 IF R(1)=1 AND R(2)=1 AND R(3)=1 THEN W=10
161 IF R(1)=1 AND R(2)=1 AND R(3)<>1 THEN W=5
162 IF R(1)=2 AND R(2)=2 AND R(3)=3 THEN W=20
163 IF R(1)<>2 AND R(2)=2 AND R(3)<>2 THEN W=15
164 IF R(1)=3 AND R(2)=3 AND R(3)=3 THEN W=100
165 IF R(1)=3 AND R(2)=3 AND R(3)<>3 THEN W=50
166 IF R(1)<>3 AND R(2)=3 AND R(3)<>3 THEN W=50
170 IF W<>0 AND RND(1)<.8 THEN 125
171 POKEV+21,7:FOR Z=1 TO 3
172 IF R(Z)=1 THEN POKEV+38+Z,2
173 IF R(Z)=2 THEN POKEV+38+Z,5
174 IF R(Z)=3 THEN POKEV+38+Z,9
175 POKE2039+Z,R(Z)+12:NEXT
178 PRINT"{home}{down*14}{left*9}{space*4}{down}{left} {down}{left} {down}{left} {down}{left*2}{space*3}{down}{left*3}{space*3}"
179 PRINT"{home}{down*9}{left*7}{red}{reverse on}{space*3}{reverse off}{down}{left*3}{reverse on}{space*3}{reverse off}{down}{left*2}{white}{reverse on} {down}{left} {down}{left} {down}{left*4}{space*4}"
180 PRINT"{home}{down*23}{right*9}{space*3}{left*3}"W
190 M=M-10
200 M=M+W:W=0:IF M>0 THEN GOTO 100
210 PRINT"{home}{red}your broke!!"
220 PRINT"{green}want another game?"
230 GET A$:IF A$="y" THEN RUN
240 IF A$<>"n" THEN 230
250 END
5000 PRINT"{clear}":PRINT"bye bye then"
5010 END
8000 PRINT"{home}{down*9}{left*7}{space*3}{down}{left*3}{space*3}{down}{left*2} {down}{left} {down}{left} {down}{left*4}{space*3}"
8010 PRINT"{home}{down*14}{left*9}{reverse on}{white}{space*4}{down}{left} {down}{left} {down}{left} {down}{left*2}{red}{space*3}{down}{left*3}{space*3}"
8020 POKEV+21,0
8028 FOR I=1 TO 500:NEXT
8030 RETURN
9000 DATA 0,0,96,0,0,224,0,1,224,0,2,224,0,2,96,0,4,32,0,8,0,0,8,0,0,28,0,0,62
9010 DATA 0,0,127,0,0,255,128,1,255,192
9015 DATA 1,255,192,1,255,192,1,255,192,0,255,128,0
9020 DATA 127,0,0,62,0,0,28,0,0,0,0,99
9030 DATA 0,1,128,0,2,0,0,4,0,0,4,0,0,63,0,0,255,128,7,255,192,15,255,224,31,255
9040 DATA 240,63,255,248,63,255,248,63,255,248,63,255,248,31,255,240,31,255,240
9050 DATA 31,255,192,15,255,192,7,255,128,3,255,0,1,255,0,0,60,0,99
9060 DATA 0,0,0,0,24,0,0,36,0,0,36,0,0,24,0,0,60,0,0,127,0,0,255,128,0,255,128
9070 DATA 0,255,128,1,255,192,1,255,192,3,255,224,3,255,224,7,255,240,7,255,240
9080 DATA 7,255,240,15,255,248,127,255,255,63,255,254,0,24,0
