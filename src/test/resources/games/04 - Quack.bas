0 POKE55,255:POKE56,47:CO=54272:A1=10:S=0:POKE54296,15:POKE54278,240:POKE54276,3
1 PRINT"{clear}":POKE53281,0:POKE53280,0:V=53248:POKEV+21,63:POKE2040,192:POKE2041,193
2 FORI=1TO4:POKE2041+I,194:POKEV+40+I,2+I:NEXT:POKEV+39,8:POKEV+40,1:POKEV+29,1
3 FORI=0TO254:READQ:POKE12288+I,Q:NEXT
4 P=120:X=132:Y=217:POKEV,120:POKEV+1,220:POKEV+2,X:POKEV+3,Y:FORI=0TO3
5 X(I+1)=(I+1)*40:Y(I+1)=90:POKEV+4+I*2,X(I+1):POKEV+5+I*2,Y(I+1):NEXT
6 I=PEEK(V+30):FORI=55376TO56256STEP40:POKEI,4:POKEI-CO,160:POKEI+32,4
7 POKEI-CO+32,160:NEXT:FORI=55336TO55368:POKEI,4:POKEI-CO,160:NEXT
8 TI$="000000":PRINT"{home}{red}******************{green}quack{red}**************"
9 PRINT"{home}{down*4}{left*5}{white}time{down*5}{left*5}score"
10 PE=PEEK(197)
11 PRINT"{home}{down*6}{left*5}{yellow}";RIGHT$(TI$,2):PRINT"{home}{down*12}{left*5}";S;
12 PRINT"{down*3}{left*2}{space*2}{left*3}";A1:IFTI$="000100"THEN200
13 IFPE=12ANDP>35THENP=P-4:IFAR=0THENX=X-4
14 IFPE=20ANDP<237THENP=P+4:IFAR=0THENX=X+4
15 IFPE=36ANDAR=0ANDA1>0THENA1=A1-1:AR=5:GOSUB300
18 Y=Y-AR:Z=PEEK(V+30):IFZ>3ANDY>90THENGOSUB100
19 IFY<60THENY=217:AR=0:X=P+12:POKEV+3,Y
20 POKEV,P:POKEV+2,X:IFAR>0THENPOKEV+3,Y
30 FORI=0TO3:X(I+1)=X(I+1)+3:IFX(I+1)>241THENX(I+1)=35:POKE2042+I,194
40 POKEV+4+I*2,X(I+1):POKEV+5+I*2,Y(I+1):NEXT
50 GOTO 10
100 S=S+10:Z=PEEK(V+30):A=5:IFZAND8THENA=1
105 IFZAND16THENA=2
110 IFZAND32THENA=3
113 IFZAND4THENA=4
115 POKE2042+A,195:AR=0:Y=218:X=P+12:POKEV+3,Y:
120 POKE54276,0:POKE54276,33
125 FORI=15TO1STEP-.5:POKE54273,I*2:POKE54296,I:NEXT:POKE54296,15:POKE54273,0
130 Z=PEEK(V+30):RETURN
200 POKE54276,0:POKE54276,17:FORI=240TO1STEP-3:POKE54273,I:NEXT:POKE54273,0
210 FORI=1TO11:POKEV+I,0:NEXT
220 PRINT"{clear}{green}your time is up!"
230 PRINT"{down*2}{red}you shot";S/10;"birds."
240 IF S>50THENPRINT"{white}well done!!!"
250 PRINT"{down*3}{purple}do you want another go?"
260 GET A$:IF A$="y"THENRUN
270 IFA$<>"n"THEN260
280 END
300 POKE54276,0:POKE54276,129:FORI=1TO80STEP2:POKE54273,I:NEXT:POKE54273,0
310 RETURN
9000 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,56,0,0,238,0,1,199,0
9010 DATA3,1,192,6,0,192,12,0,96,24,0,48,48,0,24,110,0,236,1,199,0,0,56,0
9020 DATA 0,0,0,0,0,0,0,0,0,99
9030 DATA 0,0,0,0,0,0,0,16,0,0,56,0,0,56,0,0,124,0,0,16,0,0,16,0,0,16,0,0,16
9040 DATA0,0,16,0,0,16,0,0,16,0,0,16,0,0,16,0,0,16,0,0,16,0,0,16,0,0,16,0,0,16
9050 DATA 0,0,16,0,99
9060 DATA0,0,0,0,0,0,0,0,0,0,0,6,0,7,232,120,7,176,252,7,232,126,3,134,63,255,0
9070 DATA63,255,0,31,255,0,15,255,0,15,255,0,15,255,0,3,248,0,0,128,0,1,0,0
9080 DATA 2,0,0,4,0,0,6,0,0,5,0,0,99
9090 DATA0,0,0,5,0,0,6,0,0,4,0,0,4,0,0,2,128,0,1,248,0,0,255,0,3,255,0,15
9100 DATA255,0,15,255,0,15,255,0,31,255,0,63,3,134,63,7,232,126,7,176,252,7,232
9110 DATA120,0,6,0,0,0,0,0,0,0,0,0,0,0,0
