10 DIM XD(4):XD(3)=3:XD(2)=12:XD(1)=48:XD(0)=192
105 VPOKE 15,2,128:VPOKE 15,1,128:POKE 218,40
110 VPOKE 15,$3005,$10
120 VPOKE 15,$3001,$10
130 VPOKE 15,$3000,$A1
140 A=66:B=0:GOSUB 4000
141 A=24:B=1:GOSUB 4000
142 A=20:B=2:GOSUB 4000
143 A=17:B=3:GOSUB 4000
145 POKE 646,3:PRINT CHR$(147);
1000 FOR X = 0 TO 500
1010 Y=X:GOSUB 10000
1030 NEXT
1040 REM
2000 FOR X = 0 TO 500
2010 Y=X:GOSUB 20000
2030 NEXT
2040 END
4000 REM
4010 PV = VPEEK(15, $1000+A*2)
4020 VPOKE 15,$1000+B*2,PV
4030 PV = VPEEK(15, $1000+A*2+1)
4040 VPOKE 15,$1000+B*2+1,PV
4050 RETURN
10000 REM DRAW
10010 WI=160:XP=INT(X/4):CV=XD(X-XP*4)
10020 PO=$4000+Y*WI+XP
10021 IF(PO>$FFFF) GOTO 10024
10022 VPOKE 0, PO, VPEEK(0,PO) OR CV
10023 GOTO 10030
10024 VPOKE 1, (PO-$FFFF-1), VPEEK(1,(PO-$FFFF-1)) OR CV
10030 RETURN
20000 REM ERASE
20010 WI=160:XP=INT(X/4):CV=XD(X-XP*4)
20020 PO=$4000+Y*WI+XP
20021 IF(PO>$FFFF) GOTO 20024
20022 VPOKE 0, PO, 0
20023 GOTO 20030
20024 VPOKE 1, (PO-$FFFF-1), 0
20030 RETURN