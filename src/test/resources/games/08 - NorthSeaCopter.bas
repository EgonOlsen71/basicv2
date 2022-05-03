0 PRINT"{clear}":POKE53280,0:POKE53281,0:V=53248:CO=54272:POKE54296,10:POKE54276,0
1 POKE54276,129:POKE54278,240
2 POKE54273,0:T=0:X=35+INT(RND(1)*180):Y=55:D=(INT(RND(1)*5)-2)/2
3 F=10:POKEV+21,3:POKE2040,13:POKEV+39,1:POKE2041,14:POKEV+40,4:POKEV+28,3
4 POKEV+37,5:POKEV+38,7:FORI=0TO190:READQ:POKEI+832,Q:NEXT
5 PRINT"{home}{down*10}{left*11}{green}U{sh asterisk*6}I{down}{left*8}{sh -}{purple}wind{space*2}{green}{sh -}{down}{left*8}{sh -}{space*6}{sh -}"
6 PRINT"{down}{left*11}{sh -}{purple}desc. {green}{sh -}{down}{left*8}{sh -}{space*6}{sh -}"
7 PRINT"{down}{left*11}{sh -}{purple}fuel{space*2}{green}{sh -}{down}{left*8}{sh -}{space*6}{sh -}{down}{left*8}J{sh asterisk*6}K"
8 FORI=56016TO56055:POKEI,6:POKEI-CO,223:NEXT:FORI=56056TO56296:POKEI,6
9 POKEI-CO,160:NEXT:POKEV,X:POKEV+2,X+24:POKEV+1,Y:POKEV+3,Y:PE=PEEK(V+31)
10 PRINT"{home}{down*6}{right*5}{black}{sh @}L{down}{left*3}{cm l}VV{cm j}{down}{left*4}{cm l}VV{cm j}{down}{left*4}{cm l}VV{cm j}{down}{left*4}{cm l}VV{cm j}{down}{left*4}{cm l}VV{cm j}"
11 PRINT"{right*4}NVVM{down}{left*5}{cm l}VVVV{cm j}{space*4}{reverse on}{cm t}---{cm t}{reverse off}{down}{left*15}{cm l}VVVV{cm j}{space*4}{reverse on}{space*2}^ {cm l}"
15 PRINT"{right*2}{reverse on}{space*3}{cm e*2}{space*3}-{space*5}-{space*4}{reverse off}I"
16 PRINT"{right*3}{reverse on}N{right}{reverse off}PO{right*9}{reverse on}N{right*4}{reverse off}{cm z}"
17 PRINT"{right*3}{reverse on}N{right}{reverse off} {right*10}{reverse on}N"
18 PRINT"{right*3}{reverse on}N{right}{reverse off}{right*11}{reverse on}N"
19 PRINT"{right*3}{reverse on}N{right*12}N"
20 PRINT"{home}{down*12}{left*8}{white}{space*3}{left*3}";D:PRINT"{down*2}{left*7}{space*3}{left*4}";INT(G*10)/10
21 PRINT"{down*2}{left*8}{space*4}{left*4}";INT(F*10)/10
22 T=T+1:POKE2041,14:POKE54273,100
25 IFT=30THENPOKE53281,11:PRINT"{home}{down*5}{left*5}{yellow}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N"
30 IFT=32THENPRINT"{home}{down*5}{left*5} {down}{left*2} {left*2} {down}{left*2} {left*2} {down}{left*2} {left*2} {down}{left*2} {left*2} "
35 IF T=35THENPOKE53281,0:T=0
36 POKE54273,0
40 PE=PEEK(197)
45 IFPE=18ANDF>0THENX=X+2:F=F-.1
50 IFPE=10ANDF>0THENX=X-2:F=F-.1
55 IFPE=9ANDY>50ANDF>0THENY=Y-2:G=0:F=F-.3
66 X=X+D:IFRND(1)<.1THENX=X+2:F=F-.1
68 POKE2041,15:POKE54273,100:Y=Y+G:G=G+.2:IFX>215THENX=215
69 IFX<32THENX=32
70 POKEV,X:POKEV+1,Y:POKEV+2,X+24:POKEV+3,Y
71 IF F=0 THEN POKE 54296,1
72 IFX>11ANDX<120ANDY>135THEN500
78 IFPEEK(V+31)<>0THEN 100
79 POKE54273,0
80 GOTO20
100 POKE53281,11:PRINT"{home}{down*5}{left*5}{white}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N"
101 POKE54296,15:FORI=20TO0STEP-.2:POKE54273,I:NEXT:POKE54273,0
110 FORI=1TO20:POKEV,X-I:POKEV+2,X+I:NEXT
120 FORI=YTO220:POKEV+1,I:POKEV+3,I:POKE54273,I:NEXT:POKE54273,0
130 POKEV,0:POKEV+1,0:POKEV+2,0:POKEV+3,0
150 POKE53281,0:PRINT"{home}{down*5}{left*5}{black}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N{down}{left*2}{cm u}{left*2}N"
180 FORI=1TO2000:NEXT
200 RUN
500 IFG>2THEN100
600 POKE53281,2:POKEV+1,136:POKEV+3,136:POKE54273,0:POKE54276,0:POKE54276,17
605 GOSUB800
610 PRINT"{home}{down*19}{white}{reverse on}{right*3}******* well done *******"
620 PRINT"{reverse on}{right*7}{down}{space*3}another go?{space*3}"
625 GET A$:IFA$="y"THEN RUN
630 IFA$<>"n"THEN625
635 PRINT"{reverse on}{right*2}bye bye."
640 END
800 FORI= 30TO100STEP2:POKE54273,I:NEXT
810 FORI=140TO95STEP-1:POKE54273,I:NEXT
820 FORI=5 TO20STEP .4:POKE54273,I:NEXT
830 FORI=90TO70STEP-.3:POKE54273,I:NEXT
840 FORI=100TO0STEP-3:POKE54273,I:NEXT
850 FORI=20TO10STEP-.2:POKE54273,I:NEXT
860 FORI=90TO70STEP-.2:POKE54273,I:NEXT
870 FORI= 0TO10STEP.1:POKE54273,I:NEXT
880 POKE54273,0:POKE54277,0
890 RETURN
9000 DATA0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,64,0,17,0,0
9010 DATA7,174,0,10,170,0,4,0,0,17,0,0,64,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99
9020 DATA0,0,0,0,0,0,85,85,85,0,16,0,0,215,0,0,251,0,3,184,192,3,184,240
9030 DATA15,186,176,15,190,176,171,190,252,171,170,252,187,255,252,15,255,240
9040 DATA3,223,192,0,16,0,0,16,0,5,85,64,0,0,0,0,0,0,0,0,0,99
9050 DATA0,0,0,0,0,0,0,84,0,0,16,0,0,215,0,0,251,0,3,184,192,3,184,240
9060 DATA15,186,176,15,190,176,171,190,252,171,170,252,187,255,252,15,255,240
9070 DATA3,223,192,0,16,0,0,16,0,5,85,64,0,0,0,0,0,0,0,0,0
62000 T=PEEK(62)*256+PEEK(61)+1
62015 INPUT"program name";N$:CLOSE4:OPEN4,4:PRINT#4, CHR$(1);N$;CHR$(129)
62016 IF N$="delete"THEN62200
62020 PRINT:PRINTCHR$(147);"check sum :-" : LINK=PEEK(44)*256+PEEK(43):E=61999
62100 REM * MAIN LOOP *
62120 T=LINK
62130 LINK=PEEK(T+1)*256+PEEK(T)
62135 LN=PEEK(T+3)*256+PEEK(T+2)
62136 IF LN>E THEN PRINT:PRINT"total=";CH:CLOSE4:END
62137 S$=STR$(LN):L=LEN(S$)-1:S$=MID$(S$,2,L)
62138 PRINT SPC(6-L);S$;
62140 CS=0 : N=0 : C=0
62150 FOR P=T+4 TO LINK-2 :PK=PEEK(P)
62160 IF PK=143 THEN P=LINK-2:GOTO 62190
62165 IF PK=34 THEN C=(C=0)
62170 IF C=0 AND PK=32 THEN 62190
62180 IF PK=137 THEN N=N+1:CS=CS+(203ORN):PK=164
62185 N=N+1:CS=CS+(PK OR N)
62190 NEXT P :CH=CH+CS : PRINT "=";RIGHT$(STR$(CS),LEN(STR$(CS))-1):GOTO 62120
62200 POKET,0:POKET+1,0:POKE46,PEEK(46)-2:CLR
