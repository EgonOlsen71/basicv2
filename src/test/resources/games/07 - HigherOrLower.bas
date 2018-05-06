0 PRINT"{clear}":POKE53281,7:POKE53280,6:DIMS$(52):DIMC(52):M=20:D=0:CU=0
1 POKE54296,15:POKE54276,0:POKE54278,240
4 FORJ=0TO3:FORI=1TO13:C(I+J*13)=I:S$(I+J*13)="{black}A"
5 IFJ=1THENS$(I+J*13)="{red}S"
6 IFJ=2THENS$(I+J*13)="{black}X"
7 IFJ=3THENS$(I+J*13)="{red}Z"
8 NEXTI,J
10 POKE54276,0:POKE54276,17
11 POKE54273,34:POKE54272,75:PRINT"{home}{red}money{space*6}{left*6}";M;"p":GOSUB100
13 POKE54273,0:POKE54272,0:CU=CU+1
14 FORI=1TO4
15 P=INT(RND(1)*52+1):IFC(P)=0THEN15
16 N1=N:N$=STR$(C(P)):N=C(P)
17 IFC(P)=1 THENN$=" a"
18 IFC(P)=11THENN$=" j"
19 IFC(P)=12THENN$=" q"
20 IFC(P)=13THENN$=" k"
21 IFC(P)=10THENN$="10"
22 C(P)=0:PRINT"{home}{down}{space*4}{black}^^^^^^^^{red}higher or lower{black}^^^^^^^^^^"
23 IFI=1THEN27
24 PRINT"{home}{down*17}{blue}higher or lower?"
25 PRINT"{home}{down*17}{blue}higher or lower?"
26 GETA$:IFA$<>"h"ANDA$<>"l"THEN25
27 PRINT"{home}{right}";:IFI=2THENPRINT"{home}{right*11}";
28 IFI=3THENPRINT"{home}{right*21}";
29 IFI=4THENPRINT"{home}{right*31}";
30 PRINT"{down*6}{green}{cm +*7}{down}{left*7}{cm +}{space*5}{cm +}{down}{left*7}{cm +}{space*5}{cm +}{down}{left*7}{cm +}{space*5}{cm +}";
31 PRINT"{down}{left*7}{cm +}{space*5}{cm +}";
32 PRINT"{down}{left*7}{cm +}{space*5}{cm +}{down}{left*7}{cm +}{space*5}{cm +}{down}{left*7}{cm +}{space*5}{cm +}{down}{left*7}{cm +*7}"
33 PRINT"{home}{right}";:IFI=2THENPRINT"{home}{right*11}";
34 IFI=3THENPRINT"{home}{right*21}";
35 IF I=4 THENPRINT"{home}{right*31}";
37 PRINT"{down*7}{right}{purple}";N$;:PRINT"{down*3}";S$(P);:PRINT"{down*3}{purple}";N$
38 POKE54276,33:POKE54273,6:POKE54272,206:FORZ=1TO200:NEXT:POKE54273,0
39 POKE54272,0
40 IFA$="h"ANDN1>NTHEN80
41 IFA$="l"ANDN1<NTHEN80
50 FORJ=1TO300:NEXTJ,I:FORI=1TO244STEP2:POKE54273,I:NEXT:POKE54273,0
51 IFD=1THENPRINT"{home}{down*17}{red}you've doubled your money":M=M*2:GOTO53
52 PRINT"{home}{down*17}{purple}well done you've won 5p":M=M+5
53 PRINT"{home}{red}money{space*5}{left*5}";M;"p"
55 D=0:PRINT"{down*18}do you want to play again?"
56 GETA$:IFA$="n"THENEND
57 IFA$<>"y"THEN56
58 IF RND(1)<.5THEN70
59 PRINT"{down}{black}do you want to try 'double or broke'?"
60 GETA$:IFA$="n"THEN70
63 IFA$<>"y"THEN60
65 D=1
70 IFCU>9THEN4
75 GOTO 10
80 FORI=244TO1STEP-2:POKE54273,I:NEXT:POKE54273,0
82 PRINT"{home}{down*17}{purple}hard lines you've lost!"
83 PRINT"{home}{red}money{space*5}{left*5}";M;"p"
85 M=M-5:IFM=0ORD=1THENPRINT"{clear}you're broke! bye":END
86 D=0:PRINT"do you want to play again?{space*13}"
88 GETA$:IFA$="y"THEN70
90 IFA$<>"n"THEN88
95 END
100 PRINT"{home}{down*4}":FORI=1TO19
105 PRINT"{space*38}";
106 NEXT
110 RETURN
