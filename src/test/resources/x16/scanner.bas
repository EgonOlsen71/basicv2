100 SCREEN 128 :REM MK3
101 FOR X=0TO7:R(X)=2^X:NEXT
105 RECT 0,0,319,199,$1A
110 Z=05:XO=48:MP=0
115 POKE $9FB5,2
120 FOR X = 0 TO 15
125 M =PEEK(MP+X)
130 FOR Y = 0 TO 7
140 CC=87+28
145 IF M AND R(Y) THEN CC=192
150 ON 1+(Z AND 1) GOSUB 300, 400
160 NEXT
170 NEXT
180 MP=MP+1
190 GET A$:IF A$="" THEN 120
200 POKE $9FB5,0
210 END
300 FRAME XO+8*X,16*Y+30,XO+8*X+7,16*Y+46,CC
310 RETURN
400 XX = 264-8*X
410 RECT XX,16*Y+30,XX+7,16*Y+46,CC
420 FRAME XX,16*Y+30,XX+7,16*Y+46,32
430 RETURN