0 CLR:PRINTCHR$(14)"{home*2}""{clear}":POKE59468,12:PRINTCHR$(142)
1 PRINT"{clear}{down*8}"SPC(15)"blackjack":PRINTSPC(12)"copyright 1978"
2 PRINTSPC(4)"commodore business machines inc":FORI=1TO1000:NEXT
3 REM PART# 321009
5 DIM C%(51)
6 W1$="{up*9}":W2$="{down*9}":W3$="{left*7}":W4$="{right*7}":W7$=W2$+"{down*3}"
7 B$="":FORZ1=1TO30:B$=B$+" ":NEXT
8 W8$="{reverse on}{space*7}{reverse off}":W9$="{cm +*7}":YY$="you have":FF=1
22 PRINT"{clear}":YZ$="ASXZa234567891jqk":GOSUB30:GOTO235
30 W$="s h u f f l i n g":GOSUB50110:GOSUB51540
35 FORI=0TO51:C%(I)=I:NEXT
40 FORI=0TO51
41 R=51*RND(1)+1
42 TE=C%(I):C%(I)=C%(R):C%(R)=TE:NEXT:R=0:E=1
45 RETURN
100 PRINT"{reverse on}a{down}{left}"Y$"{right*2}{down} {left}{down*2}"Y$"{left}{down*2} {right*2}{down}"Y$"{down}{left}a{reverse off}";:RETURN
101 PRINT"{reverse on}2{down}{left}"Y$"{right*2}{down}"Y$"{left}{down*4}"Y$"{right*2}{down}"Y$"{down}{left}2{reverse off}";:RETURN
102 PRINT"{reverse on}3{down}{left}"Y$"{right*2}{down}"Y$"{left}{down*2}"Y$"{left}{down*2}"Y$"{right*2}{down}"Y$"{down}{left}3{reverse off}";:RETURN
103 GOSUB116:GOTO119
104 GOSUB103:GOTO121
105 GOSUB117:GOTO119
106 GOSUB105:PRINT"{reverse on}{up*4}{left*3}"Y$;:RETURN
107 GOSUB118:GOTO119
108 GOSUB107:GOTO121
109 GOSUB118:PRINT"{reverse on}{down*2}"W1$W3$"10{down}{right}{down}"Y$"{left}{down*4}"Y$"{right*2}{down*2}{left}10{reverse off}";:RETURN
110 PRINT"{down}{reverse on}{space*2}{reverse on}{cm asterisk}{reverse off} {reverse on}{sh pound}{right*2}"W3$"{down}{right}G{cm n} {cm g}{right*2}"W3$"{down}{right}G{reverse off}{space*3}{right*3}"W3$"{down}{reverse on}G{reverse off}{space*3}{reverse on}H{right}";
111 PRINTW3$"{reverse on}{down}{right} {reverse off}{space*3}{reverse on}H{right}"W3$"{down}{right*2}{reverse off}{space*3}{reverse on}H{right}"W3$"{right*2}{cm m*2}{cm g}H{right}"W3$"{reverse off}{down}{right*2}{sh pound} {cm asterisk}{reverse off}{right*2}";:GOTO119
112 PRINT"{down}{reverse on}{space*2}{reverse on}{sh pound}{cm t}T {right}"W3$"{down}{right}{reverse off}{sh pound}{reverse on}B {cm j}{right*2}"W3$"{down}{right}{reverse off}{space*4}{reverse on}{cm f}{right*2}"W3$"{reverse off}{down}{space*5}";
113 PRINT  W3$"{down}{right*2}{reverse on}{cm c}{reverse off}{space*4}"W3$"{reverse on}{down}{right*3}{cm l} {sh -}{sh pound}"W3$"{reverse off}{down}{right*2}{reverse on} Y{cm @}{reverse off}{sh pound}{reverse off}{right*2}";:GOTO119
114 PRINT"{down}{reverse on}{space*2}{reverse on}{cm asterisk}{reverse off}{space*2}{reverse on}{sh pound}{right*2}"W3$"{down} {cm n} {reverse off} {right*2}"W3$"{down}{right}{reverse off}{sh pound}{space*3}{cm c}{right}"W3$"{down}{reverse on} {reverse off}{space*5}{reverse on} ";
115 PRINTW3$"{down}{right}{reverse off}{cm f}{reverse off}{space*3}{reverse on}{sh pound}"   W3$"{down}{right*2}{reverse off}{space*3}{reverse on}H{right}"W3$"{right*2} {reverse off} {reverse on}{cm m}{cm g}{right}"W3$"{reverse off}{down}{right*2}{sh pound}{space*2}{cm asterisk}{right*2}";:GOTO119
116 PRINT"{reverse on}{sh space}{down}{left} " Y$"{right*3}"Y$"{down*6}{left*5}"Y$"{right*3}"Y$  " {reverse off}";:RETURN
117 GOSUB116:PRINT"{reverse on}{left*6}{up*3}"Y$"{right*3}"Y$"{down*3}{right}{reverse off}";:RETURN
118 GOSUB116:PRINT"{reverse on}{up*4}{left*6}"Y$"{right*3}"Y$"{down*2}{left*5}"Y$"{right*3}"Y$"{down*2}{right}{reverse off}";:RETURN
119 IFX$="p"THENPRINTW1$"{reverse on}{down*2}"W3$N$"{left}{down}"Y$W2$W4$"{left*2}{up*2}"N$"{up}{left}"Y$"{left}{reverse off}";:RETURN
120 IFX$="d"THENPRINTW1$"{reverse on}{down}"W3$N$"{left}{down}"Y$W2$W4$"{left*2}{up*2}"N$"{up}{left}"Y$"{left}{reverse off}";:RETURN
121 PRINT"{reverse on}{up*3}{left*3}"Y$"{right*3}{down*4}{reverse off}";:RETURN
130 IFZ<>3THENRETURN
131 W$="you win":IFT=TYTHENW$="you split"
132 IFT<TYTHENW$="dealer wins"
133 GOSUB50100:W$="":RETURN
235 S$="":B=0:A=0:C=0:V=0:VV=0:X7=0:X8=0:Z=0
30000 PRINT"{home}"SPC(20)LEFT$(B$,19)"{home}"SPC(20)"your bet? ";:Z9=6:GOSUB51530:Z9=0
30020 BJ=0:X2=INT(X1):IFX2<1THEN30000
30101 IFX2>25000THENW$="house limit = $25000":GOSUB50100:GOTO30000
30102 H=1:L7=X2:DD=X2:PRINT"{clear}":GOSUB49121:PRINT"{home}"SPC(20)"bet $"X2
30110 IFR>36THENGOSUB30
30900 X$="p":GOSUB52000
31004 D2=X3:D2$=N$:D5$=Y$:X=12:Y=0
31300 GOSUB53000:GOSUB50700
31910 X$="d":GOSUB52200
40100 H=0:X=0:Y=0:GOSUB53000
40200 D1=X3:D1$=N$:D3$=Y$:H=1:Y=Y-1
40210 X$="p":GOSUB52800
40217 IFZ=3THENP2=X8
40218 D4=X3:D4$=N$:D6$=Y$
40224 T5$=STR$(X8)
40225 Y=Y+3:GOSUB53000:GOSUB50700
40360 IFC>1ORZ>0THENRETURN
40370 Y=Y+6
40380 X$="d":GOSUB52800:GOSUB53000:Y=Y-1:GOSUB50700
40560 IFC>2THENRETURN
40566 Y=Y-5
40570 IFX3=1THENGOSUB59700
40700 W$=YY$+STR$(X8):GOSUB59800
40710 IFX7=21ORX8=21ORX8>21THEN49000
40720 IFC=5ANDX8<22THEN49000
40723 IFC=2ANDD4=D2ANDZ=0THEN57000
40726 W$="do you want a hit?(y/n)":IFC<3THENW$=LEFT$(W$,22)+"/d)"
40730 GOSUB51500
40910 IFJ$="y"THENGOSUB40210:GOTO40700
40950 IFJ$="n"THEN49000
40956 IFJ$="d"ANDC<3THEN59600
40960 GOTO40720
45000 CC=C:X$="d":X=0:Y=0:GOSUB53000:X3=D1:N$=D1$:Y$=D3$:GOSUB50700:Y=Y+6
45001 IFZ=3ANDVV=0ANDX8<21THENW$=YY$+STR$(X8):GOSUB59800
45002 IFZ<3ANDX8<22THENW$=YY$+STR$(X8):GOSUB59800
45015 IFX7=21THEN45021
45016 IFCC=2ANDX8=21ANDZ<>3THEN45021
45018 IFX7>16THEN45021
45020 Y=Y+4:C=4:GOSUB40380:GOTO45015
45021 IFZ<>3THEN46000
45022 IFP2=21ANDVV=0THENC=CC:GOTO58000
45023 IFVVTHENGOSUB59500
45024 IFP2>21THENGOSUB57500
45025 IFX7<22THEN45031
45027 PRINT"{home}{down}"W2$"{reverse off}busted with"X7
45028 IFVV=0ANDP2<21THENT=T+DD
45029 IFV=0ANDP1<21THENT=T+X2
45030 GOTO49004
45031 IFV=0ANDP1<21ANDP1>X7THENT=T+X2
45032 IFP1<21ANDX7>P1ANDV=0THENT=T-X2
45033 IFP2<21ANDX7>P2ANDVV=0THENT=T-DD
45034 IFVV=0ANDP2<21ANDP2>X7THENT=T+DD
46000 GOTO49004
49000 IFC=5ANDX8<22ANDZ=3THENVV=9
49001 IFC=5ANDX8<22ANDZ<3THENV=8
49002 IFZ=2THEN49005
49003 GOTO45000
49004 IFZ=3THEN49110
49005 IFX8>21THENGOSUB57500:GOTO49110
49006 IFX7>21ANDV=0THEN59010
49007 IFX8=21THENGOTO58000
49009 IFX7=21THENGOTO58500
49010 IFV=8THENGOSUB59500:GOTO49110
49011 IFZ=2THEN57100
49015 IFX8>X7THEN59010
49020 IFX8=X7THEN59030
49030 IFX8<X7THEN59050
49110 IFZ=2THENGOTO57100
49116 IFX7<22THENPRINT"{home}{down}"W2$"{reverse off}dealer has"X7
49117 IFZ=0THENGOSUB50100
49120 GOSUB130:GOSUB49121:GOTO235
49121 TY=T:IFT=0THENW$="broke even"
49122 IFT>0THENW$="winning $"+STR$(T)
49123 IFT<0THENW$="losing $"+STR$(ABS(T))
49125 W$=W$+LEFT$(B$,20-LEN(W$)):IFFF=0THENPRINT"{home}"W$
49126 IFFF=1THENFF=0
49127 RETURN
50100 IFBJ=0ANDX8=21ANDX7<>21THENW$="you win"
50105 W$=W$+"{reverse off}"+B$:W$=LEFT$(W$,32)
50110 FORZ1=1TO10:PRINT"{home}"W7$"{up}{reverse on}"W$"{home}"W7$"{up}{reverse off}"W$:NEXTZ1:RETURN
50700 ONX3GOSUB100,101,102,103,104,105,106,107,108,109,110,112,114
50740 RETURN
51500 PRINT"{home}"W7$W4$"{up}"W$"{space*3}{left*3}";
51530 GOSUB63000:X1=VAL(W$):J$=W$
51540 PRINT"{home}"W7$"{up}"B$"{space*8}":RETURN
52000 REM
52200 TE=C%(R):X3=INT(TE/4)+1:Y$=MID$(YZ$,TE-4*(X3-1)+1,1)
52210 N$=MID$(YZ$,X3+4,1):X9=X3
52220 R=R+1
52620 IFX3>9THENX9=10
52625 IFX3=1THENX9=11
52630 IFX$<>"p"THEN52650
52635 X8=X8+X9:IFX3=1THENA=A+1
52640 IFA>0THENIFX8>21THENX8=X8-10:A=A-1
52645 RETURN
52650 X7=X7+X9
52651 IFX3=1THENB=B+1
52652 IFX8<22ANDX7=X8THEN52670
52660 IFB>0ANDX7>21THENX7=X7-10:B=B-1
52670 IFX8>21THENC=3
52700 RETURN
52800 C=C+1
52810 IFX$="d"THENX=0
52820 IFX$="p"THENX=12
52830 GOTO52200
53000 PRINT"{home}"
53100 IFX$="p"THENX=12
53120 IFX$="d"THEN X=0
53130 IFX=0THEN53405
53200 FORZ1=1TOX:PRINT"{down}";:NEXT
53405 IFY=0THEN53701
53500 FORZ1=1TOY:PRINT"{right}";:NEXT
53701 IFX$="d"ANDC=2THEN53710
53705 IFY>0ANDC>0THENPRINT"{reverse on}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}{cm m}{left}{down}"W1$"{right}";
53710 FORZ1=1TO9
53805 IFH=0THENPRINTW9$"{down}{left*7}";
53810 IFH=1THENPRINTW8$"{down}{left*7}";
53910 NEXT
53920 IFH=1THENPRINTW1$;
53930 RETURN
57000 W$="do you want to split?(y/n)":GOSUB51500
57010 IFJ$="n"THENGOTO40726
57015 IFJ$<>"y"THEN57000
57020 IFD2=1THENA=1
57021 F=X8/2:IFD2=1THENF=11:X8=11
57025 PRINT"{home}"W2$"{down*3}":FORZ1=1TO9:PRINTB$:NEXT:C=0
57030 X$="p":X=13:Y=0:GOSUB53000:X3=D2:N$=D2$:Y$=D5$:GOSUB50700
57040 X$="p":X=13:Y=20:GOSUB53000:X3=D4:N$=D4$:Y$=D6$:GOSUB50700
57070 X8=F:C=1:Y=-1:Z=2:X=13:GOSUB40210:GOTO40700
57100 IFV=0ANDX8<22THENW$=YY$+STR$(X8):GOSUB59800
57110 A=0:P1=X8:X8=F:C=2:IFD2=1THENA=1
57170 X$="p":X8=F:C=1:Y=19:Z=3:X=13:GOSUB40210:GOTO40700
57500 IFZ=3THENT=T-DD
57505 IFZ<3THENT=T-X2
57510 W$="busted with"+T5$:GOSUB59800:F9=20:W$="dealer won":RETURN
58000 IFC>2THEN58100
58003 IFZ=0ANDX7=X8THEN59030
58005 IFZ=3THENT=T+(1.5*DD)
58015 IFZ<3THENT=T+(1.5*X2)
58025 BJ=1:W$="you win with {reverse on}blackjack{reverse off}":GOTO49110
58100 IFZ=0ANDX7=X8THEN59030
58101 IFZ=0ANDV=8THENGOSUB59500:GOTO49110
58102 IFZ<3THENT=T+X2
58103 IFZ=3THENT=T+DD
58105 W$=YY$+" 21":GOSUB59800:IFX7<>X8THEN49110
58500 IFX7=X8THEN59030
58502 IFC>2THEN58600
58510 W$="dealer wins with {reverse on}blackjack":T=T-X2:GOTO49110
58600 IFZ=0THENIFX7=X8THEN59030
58610 IFZ=3THENT=T-DD
58620 IFZ<3THENT=T-X2
58630 W$="dealer wins":GOTO49110
59010 T=T+X2:W$="you win"
59013 IFX7>21THENPRINT"{home}{down}"W2$"{reverse off}busted with"X7:W$="you win"
59029 GOTO49110
59030 W$="this is a push"
59037 IFC=2THENIFX7=21THENW$="both have blackjack"
59040 GOTO49110
59050 T=T-X2:W$="dealer wins":GOTO 49110
59500 IFZ=3THENT=T+DD
59510 IFZ<3THENT=T+X2
59520 W$="5 card charlie !":IFZ>0THEN59800
59530 RETURN
59600 IFZ<3THENX2=X2*2
59605 IFZ=3THENDD=DD*2
59606 GOSUB40210:GOTO49000
59700 W$="insurance?(y/n)":GOSUB51500
59720 IFJ$="n"THENRETURN
59722 IFJ$="y"THEN59730
59724 GOTO59700
59730 W$="insurance bet $":Z9=6:GOSUB51500:I=INT(X1):IFI<1ORI>25000THEN59730
59750 Z9=0:IFX7=21THENT=T+2*I:RETURN
59760 W$="no blackjack lost your insurance":GOSUB50100:GOSUB51540
59770 T=T-I:RETURN
59800 IFZ<3THENPRINT"{home}{up}{reverse off}"W7$W$"{space*2}":RETURN
59810 IFZ=3THENPRINT"{home}{up}{reverse off}"W7$W4$W4$W4$"{left}"W$"{space*2}":RETURN
59820 RETURN
63000 W$="":Z1$="{cm +}":Z2$=" "
63020 PRINTZ1$"{left}";:Z1=1
63025 GETJ$:IFJ$<>""THEN63100
63030 Z1=Z1+1:IFZ1<15THEN63025
63040 Z$=Z1$:Z1$=Z2$:Z2$=Z$:GOTO63020
63100 IFASC(J$)=13THENPRINT" {left}";:RETURN
63110 IFASC(J$)=20THEN63200
63130 J=ASC(J$)AND127:IFJ=34ORJ=19ORJ=17ORJ=29ORJ=69THEN63020
63140 W$=W$+J$:PRINT" {left}"J$;:IFLEN(W$)<Z9THEN63020
63150 IFLEN(W$)>=Z9THENRETURN
63160 PRINT" {left}"J$;:GOTO63020
63200 IFLEN(W$)<1THEN63000
63210 PRINTJ$;:IFLEN(W$)=1THEN63000
63220 W$=LEFT$(W$,LEN(W$)-1):GOTO63020
63999 END:REM "end of blackjack property of commodore{delete*21}
