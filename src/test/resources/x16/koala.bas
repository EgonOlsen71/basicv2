10 TI=0
15 PRINT CHR$(147):INPUT"PICTURE FILE:";A$
18 IF A$="" THEN A$="TESTIMG2.PIC"
20 GOSUB 20000:GOSUB 10000:TT=TI
30 GETA$:IFA$=""THEN30
40 GOSUB 25000:PRINT"TIME: ";TT:END
10000 LOADA$,8,1,40960
10015 BS=40960:SS=BS+8000:CS=SS+1000:BG=CS+1000
10055 MP=0:MC=0:MS=0:YA=0:X=0:Y=0:D=4:BO=PEEK(40801):X2=0
10060 FORI=0TO7999
10070 PP=BS+MP:GOSUB 16000:B=PP
10080 P=INT(B/64):GOSUB 15000:PSET X2,Y,CV:PSET X2+1,Y,CV
10100 P=(B/16) AND 3:GOSUB 15000:PSET X2+2,Y,CV:PSET X2+3,Y,CV
10120 P=(B/4) AND 3:GOSUB 15000:PSET X2+4,Y,CV:PSET X2+5,Y,CV
10140 P=B AND 3:GOSUB 15000:PSET X2+6,Y,CV:PSET X2+7,Y,CV
10190 X=X+4:MP=MP+8:X2=X2+8
10200 IF X<160 THEN NEXT:RETURN
10210 X=0:X2=0:Y=Y+1:MP=MP-319:MC=MC+1:IFMC=8THENMS=MS+320:MP=MS:MC=0:YA=YA+40
10220 NEXT
11000 RETURN
15000 IF P=0 THEN PP=BG:GOSUB 16000:CV=PP AND 15:RETURN
15010 CP=X/D+YA
15020 IF P=3 THEN PP=CS+CP:GOSUB 16000:CV=PP AND 15:RETURN
15030 IF P=2 THEN PP=SS+CP:GOSUB 16000:CV=PP AND 15:RETURN
15040 IF P=1 THEN PP=SS+CP:GOSUB 16000:CV=PP/16:RETURN
15050 PRINT "????":GOSUB 25000:END
16000 BA=1:IF (PP>49151) THEN PP=PP-8192:BA=2
16015 POKE40801,BA:PP=PEEK(PP):POKE40801,BO:RETURN
20000 SCREEN 128:RETURN
25000 SCREEN 2:PRINTCHR$(147);:RETURN