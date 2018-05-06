0 REM * A DAY AT THE RACES *
1 M=100:CO=54272:POKE53280,0:POKE53281,0
2 FORN=0TO126:READQ:POKE832+N,Q:NEXTN
3 V=53248:POKEV+21,15:POKE2040,13:POKE2041,13:POKE2042,13:POKE2043,13
4 POKEV+39,2:POKEV+40,3:POKEV+41,4:POKEV+42,5
5 POKE54296,15:POKE54277,64:POKE54278,128:POKE54276,129:POKE54273,0
9 POKE54272,0
10 PRINT"{clear}{white}{space*12}a day at the races"
11 FOR I=1 TO 4:OD(I)=INT(RND(1)*10+1):NEXT
20 PRINT"{down*2}{green}you have {pound}";M;"left."
21 IFM=0THEN500
25 PRINT"{down*2}{purple}horse{space*13}odds"
26 PRINT"{cm pound*22}"
30 PRINT"{down}{white}1. {red}red devil{space*5}{white}";OD(1);"/1"
32 PRINT"{down}{white}2. {cyan}the blue max{space*2}{white}";OD(2);"/1"
34 PRINT"{down}{white}3. {purple}pink lady{space*5}{white}";OD(3);"/1"
36 PRINT"{down}{white}4. {green}green goblin{space*2}{white}";OD(4);"/1"
40 PRINT"{down*2}{yellow}. bet how much"
50 INPUTB:IFB>MTHENPRINT"{up}{space*10}{up*4}":GOTO40
60 PRINT"{down}on which horse (1,2,3,4)"
70 INPUTH:IFH<1ORH>4THENPRINT"{up}{space*11}{up*3}":GOTO60
80 PRINT"{down}{reverse on}{space*13}press any key{space*14}";
90 GETA$:IFA$=""THEN90
100 PRINT"{clear}":POKE53281,5:POKE53280,8:FORI=55496TO56135:POKEI,0:POKEI-CO,160
101 NEXT
102 FORI=55456TO55495:POKEI,1:POKEI-CO,35:NEXT
103 FORI=56136TO56175:POKEI,0:POKEI-CO,163:NEXT
105 PRINT"{home}{down*6}{left*10}{reverse on} {down}{left} {down}{left} {down}{left} {down}{left} {down}{left} {down}{left}f{down}{left}i{down}{left}n{down}{left}i{down}{left}s{down}{left}h{down}{left} {down}{left} {down}{left} {down}{left} {down}{left}"
106 PRINT"{home}{down*5}{right}{reverse on} {down}{left} {down}{left} {down}{left} {down}{left} {down}{left} {down}{left}s{down}{left}t{down}{left}a{down}{left}r{down}{left}t{down}{left} {down}{left} {down}{left} {down}{left} {down}{left} {down}{left}"
110 H(1)=20:H(2)=20:H(3)=20:H(4)=20:LE=1
120 FORI=0TO3:POKEV+I*2,H(I+1):POKEV+I*2,90+(I*35):NEXT
125 IFLE=1THENLE=0:GOTO130
126 IFLE=0THENLE=1
130 FORI=0TO3
131 POKE2040+I,13+LE:IFLE=0THENPOKE54273,2:POKE54272,37
132 IFRND(1)<.45OR(OD(I+1)<5ANDRND(1)<.4)THENH(I+1)=H(I+1)+INT(RND(1)*5):GOTO135
133 H(I+1)=H(I+1)+1
135 POKEV+I*2,H(I+1):POKEV+1+I*2,90+(I*35):IFLE=0THENPOKE54273,0:POKE54272,0
136 IFH(I+1)>240THEN200
140 NEXT:GOTO125
200 FORZ=1TO500:NEXT
205 POKE53281,0:POKE53280,0:PRINT"{clear}{cyan}":FORZ=0TO3:POKEV+Z*2,0:NEXT:HN=I+1
206 GOSUB5000
210 PRINT" {white}wins."
220 PRINT"{down}you bet on ";:HN=H:GOSUB5000
230 IFI+1<>HTHEN300
240 PRINT" too!"
245 M=M+OD(I+1)*B
250 PRINT"{green}so you've won {pound}";OD(I+1)*B
260 GOTO30
300 PRINT:PRINT"{red}you've lost {pound}";B
310 PRINT"{down}{green}bad luck!"
315 M=M-B
320 IFM<1THENFORI=1TO3000:NEXT:GOTO10
350 PRINT"do you want to play again?"
360 GETA$:IFA$="y"THEN10
370 IFA$<>"n"THEN360
380 PRINT"{white}{down*2}bye bye!"
390 END
500 PRINT"{yellow}you're broke!"
505 M=100
510 GOTO350
5000 IFHN=1THENPRINT"{red}red devil";
5010 IFHN=2THENPRINT"{blue}the blue max";
5020 IFHN=3THENPRINT"{purple}the pink lady";
5030 IFHN=4THENPRINT"{green}green goblin";
5040 RETURN
9000 DATA0,14,0,0,14,20,0,12,28,0,28,26,0,31,63,0,28,255,0,28,247,0,127,227,3
9010 DATA255,224,7,255,224,15,255,224,25,255,224,25,255,224,57,216,112,49,222
9020 DATA112,97,192,48,97,192,48,225,128,96,3,128,96,3,0,224,7,0,224,99
9030 DATA0,14,0,0,14,20,0,12,28,0,28,26,0,31,63,0,28,255,0,28,247,0,127,227,3
9040 DATA255,224,7,255,224,15,255,224,25,255,224,25,255,224,57,216,112,49,222
9050 DATA112,97,192,48,97,192,48,48,192,96,3,128,192,3,1,128,0,0,0
