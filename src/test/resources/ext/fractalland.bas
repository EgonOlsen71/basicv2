5 GROFF:PRINTCHR$(147);:GOSUB50000
10 WE=1:BR=8:BL=6:GR=5:SC=0
20 INPUT"X-COORDINATE: X=";X1
30 INPUT"Y-COORDINATE: Y=";Y1
40 XC=X1:YC=Y1
50 GOSUB 10000
60 PRINT"HEIGHT AT ";X1;"/";Y1;":";INT(Z*1000+.5)/1000
70 INPUT"VIEWER'S HEIGHT: Z=";H:IF H<Z THEN 60
80 INPUT"VIEWING ANGLE: W=";KU
85 GOSUB 30000:GOSUB 40000
90 KU=KU*3.1415926/180:SI=SIN(KU):CO=COS(KU)
100 FOR V=1 TO 600 STEP 2
110 E=H/V*10
120 FOR HO=-160 TO 160
130 FA=GR
140 HC=E*HO*0.0093
160 XC=X1+HC*CO+E*SI
170 YC=Y1-HC*SI+E*CO
180 GOSUB 10000
190 IF HO>-160 THEN Z=ZA*0.7+Z*0.3
200 IF Z<0 THEN FA=BL:Z=-0.0001
210 C=(Z-H)*V/H
220 ZA=Z
230 GOSUB 20000
240 CA=C
250 NEXT:GGETA$:IFA$="X" THEN 255
252 NEXT
255 FILLMODE0:COLOR255,255,255:RECT 0,0,319,199
260 T2$=TI$:GGETA$:IFA$=""THEN260
270 GROFF:PRINT"TIME:";T2$:END
10000 XA=0:YA=0:Z=2
10010 X2=ABS(XA):Y2=ABS(YA)
10020 XN=X2-Y2-XC
10030 YA=2*(YA*XA)-YC
10040 XA=XN:Z=Z-0.05
10050 IF Z<-0.0001 THEN RETURN
10060 IF X2+Y2>400 THEN RETURN
10070 GOTO 10010
20000 IF ABS(C)>102 THEN C=102*SGN(C)
20010 IA=160+HO:IB=161+HO:JA=98-C:JB=99-C
20020 IF JA>199 THEN JA=199
20030 IF JB>199 THEN JB=199
20040 IF JA<0 THEN JA=0
20045 IF JB<0 THEN JB=0
20050 IF IB<320 THEN COLOR255,255,255:LINE IB,199,IB,JA
20055 IF IA>319 THEN RETURN
20060 COLOR221,136,85:LINE IA,199,IA,JB
20062 IF FA=GR THEN COLOR 0,200,85
20064 IF FA=BL THEN COLOR 0,0,170
20070 IF C<0 THEN LINE IA,JB,IA,JB
20080 IF C>CA+0.3 THEN YK=99-CA:IF YK>=0 THEN COLOR96,38,0:LINE IA,YK,IA,JB
20090 LINE IA,JA,IA,JA:RETURN
30000 GRON 320,200:COLOR 0,136,255:CLEAR
30005 GGETA$:IFA$=""THEN30005
30010 TI$="000000":RETURN
40000 FORI=4 TO 96 STEP 2
40010 J=(I/96)^6.6:J=J*94
40020 BF=RND(0)+0.7:BF=BF*I*0.14
40030 AP=RND(0)*520-100:BF=BF*(2-RND(0)*0.8)
40040 FOR HO=-BF TO BF
40050 XB=HO+AP:IF ABS(XB-160)>160 THEN 40110
40060 C1=BF*BF-HO*HO:C1=C1/BF
40070 YB=C1*J*0.006:YC=95-J:YL=YC-C1:YJ=YC-YB:YK=YC+YB
40072 IF YL<0 THEN YL=0
40073 IF YJ<0 THEN YJ=0
40074 IF YC<0 THEN YC=0
40076 IF YK<0 THEN YK=0
40078 IF XB<0 OR XB>319 THEN 40110
40080 COLOR255,255,255:LINE XB,YC,XB,YL
40090 COLOR187,187,187:LINE XB,YJ,XB,YK
40100 COLOR170,255,238:LINE XB,YJ,XB,YJ
40110 NEXT:NEXT
40120 COLOR255,255,255:LINE 0,98,319,98:RETURN
50000 PRINT "FRACTALLAND - THE UNCALCULATED COUNTRY"
50010 PRINT "--------------------------------------"
50030 PRINT:PRINT "ENTER X,Y POSITION, A HEIGHT AND THE VIEWING ANGLE"
50040 PRINT "TO RENDER THE FRACTAL LANDSCAPE AT THAT POSITION."
50050 PRINT "NICE STARTING VALUES ARE: X=1.5, Y=0, HEIGHT=3, ANGLE=270"
50060 PRINT:RETURN