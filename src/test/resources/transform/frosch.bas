0 V=13*4096:POKEV+24,21:POKEV+32,3:POKEV+33,0:CO=V+256*8:CRT=1024
4 :
13 :
14 :
80 MODE=0
90 PG$="{space*5}":NM$="19":GOTO62000
100 :
110 F=42:FC=20
120 GOTO1500
140 P=0:C=9:M=CRT+542:K=M:L=M:I=9:J=9:
145 Q=13*4096+4*256:POKEQ+4,32:POKEQ+11,0:POKEQ+18,0:POKEQ+24,15
146 POKEQ+2,0:POKEQ+3,8:POKEQ+5,0:POKEQ+6,240:POKEQ+23,240
150 Y=0:CC=CRT+142:DD=CRT+702:EE=CRT+502:FF=CRT+302:G=CRT+790
170 PRINT"{clear}{light green}";:O=500+E:X=CRT+39
200 A$="{home}{down*14}{right*11}":B$="{home}{down*10}{right*11}"
210 C$="{home}{down*6}{right*11}"
220 PRINT:PRINT"{home}{down*13}"TAB(35)"{orange}{sh -}"
230 PRINTTAB(33)"{orange}{sh -} {reverse on} {reverse off}":R$="{reverse on}{light blue}{space*24}{light green}"
240 PRINTTAB(33)"{orange}{reverse on} {reverse off} {reverse on} {reverse off} {sh -}"
250 PRINTTAB(33)"{orange}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}"
260 PRINTTAB(33)"{orange}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}"
270 PRINT"{brown} {cm @*13}"SPC(19)"{orange}{reverse on} {reverse off} {sh -} {reverse on} {reverse off}"
280 PRINT"{brown}{reverse on}{sh pound}{cm t}{space*11}NL{reverse off}"SPC(18)"{orange}{sh -} {sh -} {reverse on} {reverse off}"
290 PRINT"{brown}{reverse on}{sh asterisk}OPEOPM{cm r}OEDO{cm t}{cm g*2}{reverse off}L{green}{cm p}{cm o}{cm i}{reverse on}{cm u}{cm y}{cm t*4}{cm y*2}{cm u*2}{reverse off}{cm i}{cm o*2}{cm p}{orange}{sh -}{green}{cm p}{orange}{sh -}{green}{cm p}{orange}{sh -}{green}{cm @*2}";
300 PRINT"{brown}{reverse on}{cm g*2}{cm m} {cm g}{cm m} {sh -}{cm g}{space*2}{cm g} {cm g}{cm m*2}{light blue}{space*17}{reverse off}{orange}{sh -}{reverse on}{light blue} {reverse off}{orange}{sh -}{reverse on}{light blue} {reverse off}{orange}{sh -}{reverse on}{light blue}{space*2}";
310 PRINT"{brown}{reverse on}{cm g*2}{space*2}{cm g}{cm m} {sh -}{space*3}{cm g} {cm g}{cm m*2}{light blue}{space*19}{reverse off}{orange}{sh -}{reverse on}{light blue}{space*4}";
320 PRINT"{light blue}{space*2}{brown}{reverse off}{cm asterisk}{reverse on} {cm g}{cm m} {cm @}{cm o}{cm @} {reverse off}{sh pound}{reverse on}{light blue}{space*4}{reverse off}"R$;
330 IFMO>0THENPRINT"{reverse on}{light blue}{space*13}hit 'q' to end{space*4}skill"T"{left} {left*3} {reverse off}{light green}";
331 IFMO=0THENPRINT"{reverse on}{light blue}{space*13}frog!{space*2}hit a key to play{space*2}{light green}";
335 POKECRT+999,160:POKECO+999,14
350 PRINT"{reverse off}{light green}{home}{down*8}{right}{space*11}"
360 PRINT"{right}{space*11}"
370 PRINT"{right}{space*11}"
380 PRINT"{right}{space*11}"
390 PRINT"{right}{space*4}{cm @}{cm p}{cm o}{cm p}{space*3}"
400 PRINT"{right}{space*3}{reverse on}{sh pound}{space*2}(q{cm asterisk}{reverse off} "
410 PRINT"{right}{space*2}{reverse on}{sh pound}{space*4}' U
420 PRINT"{right} {reverse on}{sh pound}{cm @*4} ) {reverse off}{sh pound}
430 PRINT"{right}{reverse on}{sh pound}N{space*2}, M {reverse off}{sh pound}
440 PRINT"{right}{reverse on}NN{cm t*2}{space*2}N{cm n}
450 PRINT"{right}{cm asterisk}{reverse on}{cm g}('{cm t*4}{cm asterisk}
460 PRINT"{right*2}{cm y}{cm u*3}{cm asterisk}{reverse on}MMM{cm asterisk}
470 PRINTSPC(9)"{cm y}{cm u}{home}"
480 O=O-(Y+E)
500 POKEQ+1,255:POKEQ+4,33:O=O-1-E/15:POKEQ+4,0:IFO<0THENO=0
508 PRINT"{purple}{home}{down}{right}"INT(O)"{left} calories ";TAB(29)P;" bugs":IFO<1THEN1230
509 FORI=40*TTO240:NEXT
510 IFMODE>0THEN520
511 GETD$:IFD$>""THENPOKE198,0:MODE=1:PN=0:GOSUB62000:GOTO120
512 IFG>CRT+260ANDG<CRT+263THENY=9:GOTO550
513 IFG>CRT+420ANDG<CRT+423THENY=6:GOTO550
514 IFG>CRT+580ANDG<CRT+583THENY=3:GOTO550
515 IFFT<FCTHEN1740
516 FT=1:D%=INT(RND(1)*3)+4
517 IFG<CRT+350THEND%=D%+3
518 IFG>CRT+560THEND%=D%-3
519 Y=D%:GOTO550
520 GETD$:IFD=1ANDD$=""THEN1740
530 IFD$=""THENPOKEM,32:GOTO750
534 IFD$="q"THEN1230
540 Y=VAL(D$):IFY<1THEN520
550 IFY=1ORY=4ORY=7THENX=6:GOTO580
560 IFY=2ORY=5ORY=8THENX=12:GOTO580
570 IFY=3ORY=6ORY=9THENX=18
580 IFY>6THEN660
590 IFY>3THEN630
600 POKEQ+1,0:POKEQ+4,33:PRINTA$;:FORA=1TOX:PRINT"{pink}CI{left}";:POKEQ+1,A*2
610 B=A:AA=CRT+572+A:IFPEEK(AA)=FTHENGOSUB1160:A=X
620 NEXT:FORX=1TOB:PRINT"{pink}{left}K {left*2}";:NEXT:PRINT" ":POKEQ+4,0:GOTO690
630 GOSUB840:POKEQ+1,0:POKEQ+4,33::PRINTB$;:FORA=1TOX:PRINT"{pink}{sh asterisk}I{left}";
640 POKEQ+1,A*2:B=A:AA=CRT+412+A:IFPEEK(AA)=FTHENGOSUB1160:A=X
650 NEXT:FORX=1TOB:PRINT"{pink}{left}K {left*2}";:NEXT:PRINT" ":POKEQ+4,0:GOTO690
660 GOSUB840:POKEQ+1,0:POKEQ+4,33:GOSUB1000:PRINTC$;:FORA=1TOX:PRINT"{pink}{sh asterisk}I{left}";
670 POKEQ+1,A*2:B=A:AA=CRT+252+A:IFPEEK(AA)=FTHENGOSUB1160:A=X
680 NEXT:FORX=1TOB:PRINT"{left}K {left*2}";:NEXT:PRINT" ":POKEQ+4,0:GOSUB840
690 IFAA=KTHENK=EE:GOTO720
700 IFAA=LTHENL=EE-40:GOTO720
710 IFAA=MTHENM=EE-80
720 Y=X:IFD=1THENY=Y/3
730 IFZ=95THENZ=0:O=O+(Y+E)
740 POKE198,0:FC=20:GOTO350
750 N=RND(1):POKEK,32:POKEL,32:POKEM,32
760 IFN<.1126THENPOKEQ+1,240:POKEQ+4,33:M=M+1:K=K-41:L=L+40:C=C-1:I=I-1:GOTO800
770 IFN<.2253THENPOKEQ+1,248:POKEQ+4,33:M=M-1:K=K-1:L=L-1:C=C-1:I=I-1:J=J-1:GOTO800
780 IFN<.5379THENPOKEQ+1,255:POKEQ+4,33:M=M+40:K=K-39:L=L-40:I=I+1:GOTO800
790 M=M-40:K=K+1:L=L+41:I=I+1:J=J+1
800 POKEQ+4,0:IFM<CCORM>DDORC<1ORC>17THENC=9:M=EE
810 POKECO+M-CR,1:POKEM,F:IFL<CCORL>DDORJ<1ORJ>17THENJ=9:L=EE
820 POKECO+L-CR,1:POKEL,F:IFK<CCORK>DDORI<1ORI>17THENI=9:K=EE
822 IFM=LORM=KORL=KTHEN750
824 POKECO+L-CR,1:POKECO+K-CR,1:POKECO+M-CR,1:POKEL,F:POKEK,F:POKEM,F:GOTO500
840 PRINT"{home}{light green}{down*4}{right}{space*11}"
850 PRINT"{right}{space*11}"
860 PRINT"{right}{space*11}"
870 PRINT"{right}{space*11}"
880 PRINT"{right}{space*4}{cm @}{cm p}{cm o}{cm p}{space*3}"
890 PRINT"{right}{space*3}{reverse on}{sh pound}{space*2}(q{cm asterisk}{reverse off} "
900 PRINT"{right}{space*2}{reverse on}{sh pound}{space*4}' U{reverse off}"
910 PRINT"{right} {reverse on}{sh pound}{space*5}) {reverse off}{sh pound}"
920 PRINT"{right}{reverse on}{sh pound}{space*7}{reverse off}{sh pound} "
930 PRINT"{right}{reverse on}N{cm t*5}M {reverse off}{space*2}"
940 PRINT"{right}{cm asterisk}{reverse on}{space*4}, ){cm asterisk}{reverse off} "
950 PRINT"{right}{space*2}{cm y}{cm u}{reverse on}N {reverse off}{sh pound} {cm asterisk}{reverse on}P{reverse off}"
960 PRINT"{right}{space*3}{reverse on}{sh pound} {reverse off}{sh pound}{space*4}"
970 PRINT"{right}{space*2}{reverse on}{sh pound} {reverse off}{sh pound}{space*5}"
980 PRINT"{right}{space*2}{reverse on}('{cm t*4}{cm asterisk}{reverse off}
990 PRINT"{right*3}{cm u*3}{cm asterisk}{reverse on}MMM{cm asterisk}{reverse off}":RETURN
1000 PRINT"{home}{light green}{down*4}{space*5}{cm @}{cm p}{cm o}{cm p}"
1010 PRINT"{right}{space*3}{reverse on}{sh pound}{space*2}(q{cm asterisk}{reverse off}"
1020 PRINT"{right}{space*2}{reverse on}{sh pound}{space*4}' U{reverse off}"
1030 PRINT"{right} {reverse on}{sh pound}{space*5}) {reverse off}{sh pound}"
1040 PRINT"{right}{reverse on}{sh pound}{space*7}{reverse off}{sh pound} "
1050 PRINT"{right}{reverse on} {cm t*2}M{space*4}{reverse off}{space*2}"
1060 PRINT"{right}{cm asterisk}{reverse on}{space*3}M, ){cm asterisk}{reverse off} "
1070 PRINT"{right} {cm asterisk}{reverse on}{space*2}({reverse off}{sh pound}{space*2}{cm asterisk}{reverse on}P
1080 PRINT"{right}{space*2}{cm asterisk}{reverse on}{space*2}{cm asterisk}{reverse off}{space*4}"
1090 PRINT"{right}{space*3}{cm asterisk}{reverse on}{space*2}{cm asterisk}{reverse off}{space*3}"
1100 PRINT"{right}{space*4}{cm asterisk}{reverse on} ){reverse off}{space*3}"
1110 PRINT"{right}{space*4}{reverse on}{sh pound} {reverse off}{sh pound}{space*3}"
1120 PRINT"{right}{space*3}{reverse on}{sh pound} {reverse off}{sh pound}{space*4}"
1130 PRINT"{right}{space*2}{reverse on}{sh pound} {reverse off}{sh pound}{space*5}"
1140 PRINT"{right}{space*2}{reverse on}('{cm t*4}{cm asterisk}{reverse off}
1150 PRINT"{right*3}{cm u*3}{cm asterisk}{reverse on}MMM{cm asterisk}{reverse off}":RETURN
1160 IFPEEK(AA-40)=FTHENP=P+1:O=O+40
1170 IFPEEK(AA+40)=FTHENP=P+1:O=O+40
1180 IFPEEK(AA+1)=FTHENP=P+1:O=O+40
1185 AC=CO+AA-CRT:POKEQ+1,A
1190 POKEAA,170:POKEAA-40,160:POKEAA+40,160:POKEAA-1,160:POKEAA+1,160
1195 POKEAC,4:POKEAC-40,4:POKEAC+40,4:POKEAC-1,4:POKEAC+1,4:POKEQ+1,A*4
1200 POKEAC,2:POKEAC-40,2:POKEAC+40,2:POKEAC-1,2:POKEAC+1,2
1205 POKEAA,32:POKEAA-40,32:POKEAA+40,32:POKEAA-1,32:POKEAA+1,32
1210 P=P+1:G=CRT+788:O=O+40:E=E+.3
1220 FORZ=200TO100STEP-5:POKEQ+1,Z:NEXT:POKEQ+4,0:RETURN
1230 POKEQ+4,65:FORZ=63TO0STEP-.2:POKEQ+1,Z:NEXT:POKEK,32:POKEL,32:POKEM,32
1240 POKEQ+4,0:PRINT"{home}{down}"TAB(37)"{space*2}"
1250 PRINT"{up}{right}you caught"P"{left} bugs!
1270 IFP<40THEN1310
1280 PRINT"{white}{down}{right}he flies, he leaps tall buildings,"
1290 PRINT"{right}his tongue is magic - it's........"
1300 PRINTTAB(8)"{down}{yellow}{reverse on} suuuperrrfrog!! ":GOTO1860
1310 IFP>30THENPRINT"{down}{right}{white}{space*2}bullroarer, king of the pond!!":GOTO1360
1320 IFP>25THENPRINT"{down}{right}{white}{space*2}a bullfrog, well fed!!":GOTO1360
1330 IFP>15THENPRINT"{down}{right}{white}{space*2}a tree frog.":GOTO1360
1340 IFP>10THENPRINT"{down}{right}{white}{space*2}a tadpole.":GOTO1360
1350 PRINT"{down}{right}{white}{space*2}you ought to eat vegetables!
1360 IFMODE=0THENFORI=1TO1000:GETD$:IFD$=""THENNEXT:RUN
1365 IFMODE=0THENMODE=1:GOTO90
1370 PRINT"{cyan}{down}{space*7}play again?{space*11}{left*10}";:GOSUB60000
1390 IFLEFT$(IN$,1)="n"THENRUN
1400 PRINT
1500 IFMODE=0THEND=1:IN$="5":GOTO1840
1510 D=0:PRINT"{up*2}{space*7}do you want three bugs?{space*11}{left*10}";:GOSUB60000
1520 :
1530 IFLEFT$(IN$,1)<>"y"THEND=1
1540 GOTO1820
1740 O=O+.3:POKEQ+1,255:POKEQ+4,33:POKEG,32:S=RND(1):POKEQ+4,0:IFS<.5THENG=G-2
1745 IFMODE=0THENFC=INT(RND(1)*12)+6:FT=FT+1
1750 G=G+1:IFS<.25THENG=G-78
1760 IFG<CRT+72ANDD=1THENG=CRT+790:GOTO500
1770 IFG<FFTHEN1810
1780 IFG<EETHEN1800
1790 G=G-42:POKEQ+1,240:POKEQ+4,33:POKECO+G-CR,1:POKEG,F:POKEQ+4,0:GOTO500
1800 G=G-40:POKEQ+1,248:POKEQ+4,33:POKECO+G-CR,1:POKEG,F:POKEQ+4,0:GOTO500
1810 G=G-41:POKEQ+1,255:POKEQ+4,33:POKECO+G-CR,1:POKEG,F:POKEQ+4,0:GOTO500
1820 PRINT"{up*2} please enter skill level (0 thru 9){space*5}{left*4}";
1830 GOSUB60000
1835 T=VAL(IN$):IFT<0ORT>9THEN1820
1840 T=VAL(IN$):E=(T*2)-4
1850 GOTO140
1860 POKEQ+4,65:FORZ=1TO5:FORX=20TO120:POKEQ+1,X:NEXT:FORX=50TO130:POKEQ+1,X:NEXT
1870 FORX=200TO100STEP-.5:POKEQ+1,X:NEXT:NEXT:POKEQ+4,0:GOTO1360
1880 END
60000 POKE198,0:IN$=" ":ZT=TI:ZC=2:ZD$=CHR$(20)
60010 FORI=1TO2000:GETZ$:IFZ$<>""THEN60070
60020 IFZT<=TITHENPRINTMID$(" {cm p}",ZC,1);"{left}";:ZC=3-ZC:ZT=TI+20
60030 NEXT:RUN
60070 Z=ASC(Z$):ZL=LEN(IN$):IF(ZAND127)<32THENPRINT" {left}";:GOTO60110
60080 IFFLAND(ZAND127)>64AND(ZAND127)<91THENZ$=CHR$((Z+128)AND255)
60090 IFZL>2THEN60010
60100 IN$=IN$+Z$:PRINTZ$;
60110 IFZ=13THENIN$=MID$(IN$,2):PRINT:RETURN
60120 IFZ=20ANDZL>1THENIN$=LEFT$(IN$,ZL-1):PRINT"{left}";:GOTO60010
60130 IFZ=141THENZ$=CHR$(-20*(ZL>1)):FORZ=2TOZL:PRINTZ$;:NEXTZ:GOTO60000
60140 GOTO60010
60200 GOSUB60500
60210 PRINT"{cyan}{space*9}press {reverse on}{purple} space {reverse off}{cyan} to begin";
60240 FORI=0TO3000:GETT$:IFT$=""THENNEXT:RUN
60250 PRINT"{clear}{down*11}":GOTO100
60260 PRINT"{clear}{space*37}"
60265 GOSUB60500
60270 RETURN
60500 FORI=1TO10:PRINT"{sh asterisk*4}";:NEXT:RETURN
62000 PRINT"{clear}{down*2}{cyan}{space*26}"PG$
62010 PRINT"{down}{pink}{space*35}{down}"
62011 PRINT"{down}{white}{space*37}{light blue}{down}"
62020 GOSUB60500
62030 PRINT"{down}{light green}{space*9}>> back to nature <<"
62040 IFMODE=0THENFORI=1TO2000:GETZ$:IFZ$=""THENNEXT:GOTO100
62050 MODE=1
62080 PRINT"{down*3}{yellow}{space*5}do you need the directions?{space*9}{left*8}";:GOSUB60000
62090 IFLEFT$(IN$,1)<>"y"THEN100
62100 PRINT"{clear}{down}{cyan}{space*34}"
62105 GOSUB60500
62110 PRINT"{white} froggy needs bugs to live. you control"
62120 PRINT"{down*2}{right}his {yellow}tongue {white}.........{reverse on}{pink}short{reverse off} {reverse on}{white}medium{reverse off} {reverse on}{light blue}long
62130 PRINT"{down}{white} and {purple}height {white}....{reverse on}{light green}high{reverse off}{space*3}{orange}7{space*5}8{space*5}9"
62140 PRINT"{down}{white} with the{space*5}..{reverse on}{yellow}middle{reverse off} {orange}4{space*5}5{space*5}6"
62150 PRINT"{down}{white} number pad.{space*3}.{reverse on}{cyan}low{reverse off}{space*4}{orange}1{space*5}2{space*5}3"
62160 PRINT"{down*2}{white} the farther he has to reach, the more"
62170 PRINT"{down} energy he uses.{space*2}a higher skill level"
62180 PRINT"{down} will cause a bug to move more quickly"
62190 PRINT"{down} and the frog to consume more energy.{cyan}"
62200 GOSUB60200
