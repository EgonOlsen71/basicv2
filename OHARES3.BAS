0 POKE 59468,12:REM" Adventure  1.5       copyright(c)1980   by John O'Hare
1 lu=150:lf=2
2 lt=62:REMlight object #
3 tv=15:t7=20:mx=tv*t7:mx=mx+50:REMtv=treasurevalue/t7=#of treasures/mx=max score
4 ol=10:REM object limit
5 FORi=0TO5:READd$(i):NEXT
6 DATA north,south,east,west,up,down
7 tr=7:REMtreasure storage room
8 REM n=nouns/v=verbs/r1=rooms/o=objects/m=messages/c=commands/a=actions
9 GOSUB2200
10 READ n,v,r1,o,m,c,a,dr:DIMn$(n),v$(v),rm$(r1),rm(r1,5),ob(o),ob$(o),ob%(o)
11 lb=57:REM limbo
12 dt=58:REMdeath room
14 ad=3:ad$=" HAUNTEDMANSION ":REM adventure number and name
15 DIM ow$(o),m$(m),c$(c)
16 POKE59468,14:PRINT"Welcome to Adventure"ad
17 PRINT:PRINT""TAB(17-(LEN(ad$)/2));"*"ad$"*"
18 DEFFNr(x)=INT(RND(1)*x)+1
19 gn=4:so=50
20 GOSUB2000
30 FORi=0TOn:READ n$(i):NEXT
40 FORi=0TOv:READ v$(i):NEXT
50 FORi=0TOr1
60 READrm$(i)
70 FORj=0TO5
80 READrm(i,j)
90 NEXT:NEXT
100 FORi=1TOo
110 READ ob$(i),ow$(i),ob%(i),ob(i)
120 NEXT
130 FORi=1TOm
140 READm$(i)
150 NEXT
160 rm$(lb)=rm$(lb)+CHR$(13)+"A sign here says:  LIMBO, find right    exit "
161 rm$(lb)=rm$(lb)+"and live again."
170 FORi=1TOc
171 READc$(i):NEXT
175 r=1:REM (c)1980 john o'hare
176 READw0:DIMw1$(w0),w2$(w0):FORwc=1TOw0:READw1$(wc),w2$(wc):NEXT:READe4$:jp=1
181 FORi=1TO7:READe$(i):NEXT:FORi=1TO3:READhs$(i):NEXT
182 READ e5$
186 PRINT"hit any key to begin adventure"
187 GETa$:IFa$=""THEN187
188 PRINT"":GOSUB4800
189 INPUT"use saved game   n";g$
190 IF g$="n"THEN199
191 PRINT:PRINT"hit any key when tape is ready.":POKE158,0
192 GET sg$:IFsg$=""THEN192
193 rem OPEN1,1,0,"advent"
194 rem INPUT#1,r,lu,df,lf,so,gn,ga,gf
195 rem FORsg=1TOo
196 rem INPUT#1,ob%(sg):NEXT
197 rem CLOSE1
199 PRINT""
200 df=0:IF r>drANDob%(lt)<>-1ANDob%(lt)<>rTHENdf=1
201 IF r=lbORr=dtTHENdf=0
202 IF df=0 THEN 209
203 PRINT"ICAN'T SEE IN THE DARK!"
204 PRINT:GOTO330
209 IF LEFT$(rm$(r),1)="*"THEN rm$=MID$(rm$(r),2):GOTO220
210 PRINT"You're in ";:rm$=rm$(r)
220 PRINTrm$"."
225 IF r=dtTHENPRINT:so=so-12:qf=1:GOTO1200
230 x=1:uf=0
240 PRINT:FORvi=1TOo:IFob%(vi)=rANDx=1THENPRINT"VISIBLEITEMS HERE:":x=0:uf=1
245 IFob%(vi)<>rTHEN260
247 IFLEN(ob$(vi))+POS(0)>36THENPRINT
250 PRINTob$(vi)".  ";
260 NEXT
265 IFufTHENPRINT
270 x=1
280 PRINT:FORoe=0TO5
290 IF rm(r,oe)<>0ANDx=1THENPRINT"OBVIOUSEXITS:":x=0
300 IF rm(r,oe)<>0THENPRINTd$(oe)" ";
310 NEXT:PRINT
315 PRINT""
320 IF ob%(lt)=-1THENlu=lu-1
321 GOSUB400
322 ht=ht+1
325 GOSUB4300
327 GOSUB3900
328 IFgk=1THENgk=0:so=so-5:GOTO200
330 PRINT: PRINT"WHATNEXT   ";
331 i1$="":i2$=""
340 INPUTip$:i1$=ip$
342 IFip$=""THENPRINT"":GOTO330
345 PRINT
350 FORsb=1TOLEN(ip$)
360 IFMID$(ip$,sb,1)=" "THENi1$=LEFT$(ip$,sb-1):i2$=RIGHT$(ip$,LEN(ip$)-sb):GOTO380
370 NEXT
380 GOTO500
390 REM lamp and attack checks
400 IFlu<50ANDlf=2ANDob%(lt)<>0THENPRINT"You're flashlight is getting dim!":lf=1
410 IFlu<38ANDlf=1ANDob%(lt)<>0THENPRINT"You're flashlight is getting dimmer!!":lf=0
420 IF lu<25AND lu>0 ANDob%(lt)<>0THENPRINT:PRINT"LIGHTRUNSOUTIN"lu"TURNS!"
430 IF lu=0AND lf=0THENPRINT"LIGHTHASRUN OUT!!!":lf=-1:ob%(lt)=0
440 REM
450 RETURN
500 IF i1$="go"THENi1$=i2$:i2$=""
501 IF i1$="say"THENi1$=i2$:i2$=""
505 v1$=LEFT$(i1$,3):n1$=LEFT$(i2$,3):i1=0:i2=0
506 IFv1$="fee"ANDn1$="oys"THENn1$="big"
507 FORw3=1TOw0:IFv1$=w1$(w3)THENv1$=w2$(w3)
508 NEXT
509 IFn1$="hou"ORn1$="tra"THENn1$="doo"
510 FORvl=1TOv
520 IF v1$=v$(vl)THENi1=vl:GOTO540
530 NEXT
540 IF i2$=""THEN570
541 FORnl=1TOn
550 IF n1$=n$(nl)THENi2=nl:GOTO570
560 NEXT
570 IF i1=0THENPRINT"YOUUSEWORD(S) IDON'TKNOW":GOTO330
580 IF i1<7ANDi1>0THEN1100
590 mf=0:k=0
595 jp=1:c7=53:IFi1>17THENjp=54:c7=c
600 FORy=jpTOc7
610 IF VAL(MID$(c$(y),1,2))<>i1THEN710
615 IF VAL(MID$(c$(y),3,2))=0THEN630
620 IF VAL(MID$(c$(y),3,2))<>i2THEN710
630 k=0:mf=1:FORz=5TO16STEP4
635 c1=VAL(MID$(c$(y),z,2)):c2=VAL(MID$(c$(y),z+2,2))
640 IFc1=1THENIFob%(c2)<>-1THEN710
650 IFc1=2THENIFr<>c2THEN710
660 IFc1=3THENIFob%(c2)<>0THEN710
680 IFc1=5THENIFob%(c2)<>rTHEN710
695 k=k+1:IF k=3THENan=y:GOTO800
700 NEXT
710 NEXTy
715 IF mf=1THENPRINT"I CAN'T DO THAT NOW.":GOTO730
720 PRINT"IDON'TUNDERSTAND?"
730 GOTO320
800 af=0:dh=0:rf=0:rc=0
805 FORg=17TO34STEP6:a1=VAL(MID$(c$(an),g,2)):a2=VAL(MID$(c$(an),g+2,2))
807 a3=VAL(MID$(c$(an),g+4,2))
810 IF a1=1THENPRINTm$(a2)".":GOTO910
820 IF a1=2THENob=ob%(a2):ob%(a2)=ob%(a3):ob%(a3)=ob:GOTO910
830 IF a1=3THENob%(a2)=0:GOTO910
840 IF a1=4THENob%(a2)=r:GOTO910
850 IF a1=5THENr=a2:rc=1:GOTO910
860 IF a1=6THENdh=1:r=lb:so=so-5:GOTO910
870 IF a1=7THENGOSUB920:GOTO910
880 IF a1=8THENGOSUB1000:GOTO910
885 IFa1=17THENrm(r,a2)=a3:GOTO910
890 IF a1=9THEN ob%(a2)=a3:GOTO910
900 IF a1=10THENGOSUB1050:GOTO910
901 IF a1=77THENdh=1:GOTO910
903 IFa1=18THENGOSUB4200:GOTO910
904 IF a1=11THENrc=1:GOTO910
905 IF a1=12THENGOSUB1200:GOTO910
906 IF a1=13THENqf=1:GOTO1200
907 IF a1=14THENh=a2:af=1:GOSUB950:GOTO910
908 IF a1=15THENe=a2:af=1:GOSUB1030:GOTO910
909 IF a1=16THENGOSUB2500:GOTO910
910 NEXT
911 IF dh=1THENPRINT:GOTO200
912 IF rc=1THEN199
913 GOTO320
920 FORh=1TOo
930 IF n1$=ow$(h)THEN950
940 NEXT:IF i2$<>""THENPRINT"Iseeno "i2$" here!":RETURN
941 PRINT"be specific"
942 RETURN
950 IF ob(h)=1THENPRINT"IT'SBEYONDMYPOWERTODOTHAT!":RETURN
952 IF ob(h)>1THENPRINT"Don't be stupid!":RETURN
955 IF ob%(h)=-1THEN PRINT"I'm already carrying it.":RETURN
960 IF ob%(h)<>rTHENPRINT"IDON'TSEEITHERE!":RETURN
961 os%=0:FORpq=1TOo:IFob%(pq)=-1THENos%=os%+1
962 NEXT
970 IFos%+1>olTHENPRINT"I'VETOOMUCHTOCARRY":RETURN
980 PRINT"ok,":ob%(h)=-1:RETURN
990 REM
1000 IFn1$<>"tre"THEN1008
1001 td%=0:FORtd=1TOo
1002 IFLEFT$(ob$(td),1)<>"*"THEN1006
1003 IFtd=52ANDob%(td)=-1ANDob%(42)<>rTHENPRINTm$(24):ob%(52)=0:ob%(76)=r:GOTO1006
1004 IFtd=52ANDob%(td)=-1THENPRINTm$(43):ob%(td)=r:GOTO1006
1005 IFob%(td)=-1THENob%(td)=r:PRINT"dropped: ";ob$(td):td%=1
1006 NEXTtd:IFtd%=0THENPRINT"You have no treasure to drop."
1007 RETURN
1008 IF i2$=""THENPRINT"be specific":RETURN
1009 FORe=1TOo
1010 IF n1$=ow$(e)THEN1030
1020 NEXT:PRINT"You don't have it!":RETURN
1030 IF ob%(e)=-1THENob%(e)=r:PRINT"ok,":RETURN
1040 PRINT"I'M NOTCARRYINGIT!":RETURN
1050 os=0:PRINT"I'M CARRYING:"
1070 FORi7=1TOo
1080 IFob%(i7)<>-1THEN1090
1081 os=1
1082 IFLEN(ob$(i7))+POS(0)>36THENPRINT
1083 PRINTob$(i7)".  ";
1090 NEXT
1091 IFosTHENPRINT:RETURN
1092 PRINT"nothing":RETURN
1100 IF rm(r,i1-1)=0ANDdf=0THENPRINT"ICAN'T GOINTHATDIRECTION.":GOTO320
1101 IFrm(r,i1-1)=0ANDdf=1THENPRINT"I FELLDOWNANDBROKEMYNECK!!":GOTO1130
1102 IFob%(54)=rANDi1=1THENPRINT"The goblin won't let me by!":GOTO320
1105 IFob%(55)=rANDi1=3THENPRINT"The troll is blocking my way!":GOTO320
1110 r=rm(r,i1-1):GOTO199
1120 END
1130 r=lb:so=so-5:GOTO200
1200 sc=0:FORi=1TOo
1210 IF RIGHT$(ob$(i),1)="*"ANDob%(i)=tr THEN sc=sc+tv
1220 NEXT
1222 IFqf=1THENso=so-4
1223 IFso<0THENso=0
1225 sc=sc+so
1230 IF qf=1THEN1300
1240 PRINT"YOUR SCOREIS"sc"OUTOFAPOSSIBLE"mx
1250 IF sc-so=300THENPRINT:GOTO1300
1255 RETURN
1300 PRINT"You scored"sc"points."
1310 PRINT"There were"mx"points possible."
1311 IFsc<1THENPRINT"You must have nothing but space between youre ears!":END
1312 IFsc<51THENPRINT"You are obviously a rank amateur.":END
1313 IFsc<75THENPRINT"You're score qualifies you as a novice  class adventurer.":END
1314 IFsc<125THENPRINT"You've achieved the rating: Experienced Adventurer":END
1315 IFsc<175THENPRINT"You have reached the 'junior master'    status.":END
1320 IFsc<225THENPRINT"Your score puts you in MASTERADVENTURERclass -D-":END
1330 IFsc<295THENPRINT"Your score puts you in MASTERADVENTURERclass -C-":END
1335 IFsc<345THENPRINT"Your score puts you in MASTER ADVENTURERclass -B-":END
1340 IFsc<350THENPRINT"Your score puts you in MASTERADVENTURERclass -A-":END
1350 IFsc=mxTHENPRINT"All of adventuredom gives tribute"
1355 IFsc=mxTHENPRINT"to you,  ADVENTURERGRANDMASTER!":END
2000 PRINT
2010 PRINT"This is adventure!!!"
2020 PRINT"I will be your eyes and hands as you"
2030 PRINT"search for lost treasure."
2040 PRINT
2050 PRINT"The object is to recover"t7"treasures"
2060 PRINT"and return them to the proper place."
2065 PRINT"Treasures have a '*' in there name":PRINT
2070 PRINT"Use two word commands consisting of"
2080 PRINT"a verb and a noun, example:"
2090 PRINT
2100 PRINT"go west, take gold, enter hole, shoot"
2110 PRINT
2120 PRINT"inventory, save game, drop treasure"
2121 PRINT"hit any key to continue"
2122 GET a$:IFa$=""THEN2122
2123 PRINT"       Words to Know                 "
2125 PRINT"READ - if you have something that can be       read you will read it."
2126 PRINT"ENTER - will take you into a hole,              passage, building, etc..
2127 PRINT"INVENTORY - gives you list of what you              are carrying."
2128 PRINT"LOOK - describes the room you are in."
2129 PRINT:PRINT"Use TAKE and DROP in most cases to      manipulate objects."
2130 PRINT
2131 PRINT"There are many more words that will be  discovered as you explore some may
2132 PRINT"even be magic, usually when youtell me things you should use two words."
2133 PRINT:PRINT"If you find one word doesn't work just  try another."
2151 PRINT
2153 PRINT"Please wait while I load my data..."
2160 RETURN
2165 PRINT"Treasures have a (*) in there name":PRINT
2200 PRINT"";
2400 PRINT"                adventure  "
2402 PRINT"      N  N        M        -by-     "
2404 PRINT"     N  N      M     john o'hare "
2406 PRINT"    N  N        M
2408 PRINT"   N  N              M      VVVVVVV
2410 PRINT"  N  N              M    VVMVVVNVV
2412 PRINT"  P          VVVVVVVVV
2414 PRINT"            VVVMNMNMVV"
2416 PRINT" PP L     VVVVVVVVV"
2418 PRINT" P  M               M    V  M N V"
2420 PRINT"     M               M  N   
2422 PRINT"M   OOPP      
2424 PRINT"PPPP   O       
2426 PRINT"   .      
2428 PRINT"L L    
2430 PRINT" MM           M     
2432 PRINT"  PMOPOP     NVM
2434 PRINT"      PPPPPPPPPPPOOOOO   
2436 PRINT"                  MM
2438 PRINT"                   
2440 PRINT"                   M M"
2442 PRINT"  "
2443 PRINT
2444 PRINT""
2450 PRINT"    hit any key to begin adventure"
2455 GETa$:IFa$=""THEN2455
2460 GOSUB3000
2465 RETURN
2500 PRINT:PRINT"hit any key when tape is ready.":POKE158,0
2501 GETsg$:IFsg$=""THEN2501
2502 rem OPEN1,1,2,"advent"
2503 rem PRINT#1,r:PRINT#1,lu:PRINT#1,df:PRINT#1,lf:PRINT#1,so:PRINT#1,gn:PRINT#1,ga:PRINT#1,gf
2504 rem FORi=1TOo
2505 rem FORsg=1TOo
2506 rem PRINT#1,ob%(sg):NEXT
2507 rem CLOSE1
2508 RETURN
2999 REM  n,v,r,o,m,c,a,dr
3000 POKE32997,32
3010 POKE32997+4,32
3015 FORi=33077TO33076+5:POKEi,32:NEXT
3017 FORi=1TO1500:NEXT
3020 RETURN
3900 IF ob%(54)=rORob%(55)=rORob%(73)=rORob%(74)=rTHENob%(61)=0:RETURN
3999 IFr<8ORr=lbORr=(dt)ORht<35THENRETURN
4000 IFgn=0THENRETURN
4005 IFga=1THENob%(61)=r:GOTO4030
4010 IFFNr(32)=7THENga=1:GOTO3999
4020 ob%(61)=0:RETURN
4030 REM
4040 PRINT"There is a threatening little ghost in  the room with you!"
4050 gf=(1-gf)
4060 IFgfTHENRETURN
4070 PRINT"The ghost attacks!"
4080 IFFNr(6)=2THENPRINT"It got you!":r=lb:ga=0:gk=1:RETURN
4090 PRINT"It missed!"
4100 RETURN
4200 IFFNr(5)>2THENPRINT"You missed!":RETURN
4210 PRINT"You got him!":PRINT"The ghost dissapears in a white mist!"
4220 gn=gn-1:ga=0:gf=0:ob%(61)=0
4230 RETURN
4300 IFr=27THENPRINT"A clock shows the time: ";LEFT$(ti$,2)":"MID$(ti$,3,2)""
4305 IFha=1THENPRINT"The spirit of Hubie Marsten appears and says:":PRINThs$(FNr(3))"."
4306 IFha=1THENob%(74)=r:ha=0
4310 IFFNr(5)=4ANDr>6THENPRINTe$(FNr(7))"."
4315 IFr>3ANDr<7ANDFNr(4)=2THENPRINT"The trees seem to be alive!"
4316 IFr>32ANDr<36ANDob%(74)<>rTHENIFFNr(3)=2THENha=1
4317 IFob%(74)=rANDFNr(3)=2THENPRINT"The spirit vanished??":ob%(74)=0:ha=0
4320 IFob%(54)=rANDFNr(3)=2THEN4400
4330 IFob%(55)=rANDFNr(3)=2THEN4500
4335 IFob%(73)=rANDFNr(3)=2THEN4600
4340 RETURN
4400 PRINT"The goblin attack with an axe in hand!"
4410 IFFNr(6)=4THENPRINT"CRUNCH!!     He gets you!":r=lb:gk=1:RETURN
4420 PRINT"WHOOSH!     He misses!":RETURN
4500 PRINT"The troll attacks!"
4510 IFFNr(7)=6THENPRINT"He smashes your skull!":r=lb:gk=1:RETURN
4520 PRINT"He missed!":RETURN
4600 PRINT"Barlow attacks!"
4610 IFob%(38)=-1THENPRINT"He sees your cross and backs off!":RETURN
4620 IFFNr(4)=3THENPRINT"He got you!!":r=lb:gk=1:RETURN
4630 PRINT"He missed!":RETURN
4800 INPUT  "What time is it (HHMM)";tm$
4805 IFLEN(tm$)<>4THENPRINT"illegal time":GOTO4800
4810 ti$=tm$+"00"
4820 PRINT"thank you friend."
4830 RETURN
10269 DATA 35,31,58,78,59,91,0,35
10279 REM
10289 REM
10299 REM
10309 DATA nnn,mai,big,spi,let,doo,mat,but,kni,bot,liq,des,oys,pap,red
10319 DATA blu,gre,boo,gol,clo,cof,pot,sta,lad,gun,cro,tru,rug,gob,gho,tro,sig
10329 DATA fla,win,gam,pas
10339 DATA vvv,nor,sou,eas,wes,up,dow,tak,dro,ent,inv,loo,sco,qui,hel,pus
10349 DATA rea,ope,mov,sho,run,kil,eat,cli,tur,on,off,dri,cbm,sav,thr,sta
10359 REM
10369 REM
10379 DATA room #0,0,0,0,0,0,0
10389 DATA "*You're on an old worn path",6,0,1,2,0,0
10399 DATA "*You're walking along an old path",5,0,1,3,0,0
10409 DATA "front of a big spooky house",0,7,2,4,0,0
10419 DATA "the haunted forest",5,4,4,5,0,0
10429 DATA "the haunted forest",4,4,6,4,0,0
10439 DATA "the haunted forest",5,4,1,5,0,0
10449 DATA "*You're on the porch of the old house",3,0,0,0,0,0
10459 DATA "an old dusty living room",7,12,9,0,0,0
10469 DATA "the dining room",0,13,10,8,0,0
10479 DATA "the kitchen",0,0,11,9,0,0
10489 DATA "a musty old pantry",0,0,0,10,0,0
10499 DATA "the family room",8,0,13,0,00,0
10509 DATA "a small alcove",9,16,0,12,26,0
10519 DATA "the study",0,17,0,0,0,0
10529 DATA "*You're at the west end of a corridor",0,18,16,0,0,0
10539 DATA "the middle of a corridor",13,19,17,15,0,0
10549 DATA "*You're at the east end of a corridor",14,20,0,16,0,0
10559 DATA "the Den",15,0,0,0,0,0
10569 DATA "the Library",16,0,0,0,0,0
10579 DATA "a Guest Room",17,0,0,21,0,0
10589 DATA "a dusty closet",0,0,20,0,0,0
10599 DATA "the trophy room",0,25,0,0,0,0
10609 DATA "an old dusty nursery",0,26,0,0,0,0
10619 DATA "a large bathroom",0,27,0,0,0,0
10629 DATA "*You're at the west end of a hallway",22,28,26,0,0,0
10639 DATA "a stairwell",23,31,27,25,0,13
10649 DATA "*You're at the east end of a hallway",24,32,0,26,0,0
10659 DATA "the master bedroom",25,0,0,29,0,0
10669 DATA "a dark, dusty closet. A ladderleads up here",0,0,28,0,30,0
10679 DATA "*You're on the ladder",0,0,0,0,0,29
10689 DATA "a yellow bedroom",26,0,0,0,0,0
10699 DATA "a white bedroom",27,0,0,0,0,0
10709 DATA "the west end of the attic",0,0,34,0,0,30
10719 DATA "the east end of the attic",0,35,0,33,0,0
10729 DATA "a dirty old storeroom",34,0,0,0,0,0
10739 DATA "the basement, there is a largeopen door to the south",0,40,0,37,10,0
10749 DATA "a laundry room",0,0,36,38,0,0
10759 DATA "a musty, old room in the      basement",0,39,37,0,0,0
10769 DATA "an old wine cellar",38,0,0,0,0,0
10779 DATA "a chilly, damp room",36,0,0,0,0,0
10789 DATA "a secret underground cavern",0,42,0,0,40,0
10799 DATA "a narrow passage",41,0,43,0,0,0
10809 DATA "a drafty chamber",0,0,44,42,0,0
10819 DATA "a large circular chamber",45,0,46,43,0,0
10829 DATA "a splendid chamber 30 feet    high",47,44,0,0,0,0
10839 DATA "a roughlycarved room, a pit  leads down",0,52,0,44,0,53
10849 DATA "*You're at a junction of three passages",0,45,48,56,0,0
10859 DATA "a dusty passage",0,0,49,47,0,0
10869 DATA "an old broken passage",0,0,50,48,0,0
10879 DATA "*You're at a turn in the passage",0,51,0,49,0,0
10889 DATA "a TORTURE CHAMBER",50,0,0,0,0,0
10899 DATA "a cold damp room",46,0,0,0,0,0
10909 DATA "a pit",0,0,0,0,0,54
10919 DATA "a pit",0,0,0,0,0,55
10929 DATA "a pit.  There are no exits",0,0,0,0,0,0
10939 DATA "a dead end passage",0,0,47,0,0,0
10949 DATA " a misty room with strange    looking exits",1,58,58,58,5,58
10959 DATA " H E L L *",0,0,0,0,0,0
10969 REM
10979 REM                       CLOSE
10989 REM
10999 DATA "MAILBOX (name on it:  Hubie Marsten)",mai,3,1
11009 DATA ring of keys,key,0,0
11019 DATA old letter,let,0,0
11029 DATA "LARGEPADLOCKED DOOR",doo,7,1
11039 DATA "OPENDOOR",doo,0,1
11049 DATA doormat,mat,7,0
11059 DATA "BUTTONBYDOOR (doorbell?)",but,7,1
11069 DATA "SIGN - LEAVETREASUREHERESAYSCORE",sig,7,1
11079 DATA "FURNITURE",fur,8,1
11089 DATA "TABLE & CHAIRS",tab,9,1
11099 DATA *silver candlesticks*,can,9,0
11109 DATA *silver knife*,kni,10,0
11119 DATA pool of blood,blo,10,1
11129 DATA "BIGMAC",big,10,0
11139 DATA "vial of strange liquid",via,11,0
11149 DATA *wallet full of $100s*,wal,12,0
11159 DATA "DESK",des,14,1
11169 DATA slip of paper,pap,0,0
11179 DATA magic gun,gun,0,0
11189 DATA *gold watch*,wat,18,0
11199 DATA *rare painting*,pai,18,0
11209 DATA red book,red,19,0
11219 DATA blue book,blu,19,0
11229 DATA green book,gre,19,0
11239 DATA *gold book*,gol,0,0
11249 DATA "CLOSET",xxx,20,1
11259 DATA bed,bed,20,1
11269 DATA *oriental rug*,rug,20,0
11279 DATA cloths,clo,21,1
11289 DATA *mink*,min,21,0
11299 DATA *gold medal*,med,22,0
11309 DATA crib,cri,23,1
11319 DATA * $1000 savings bond *,bon,23,0
11329 DATA toilet,toi,24,1
11339 DATA sink,sin,24,1
11349 DATA a bubbling potion,pot,24,0
11359 DATA stairs going down,sta,26,1
11369 DATA wooden cross,cro,26,0
11379 DATA "CLOSET",xxx,28,1
11389 DATA *pearl necklace*,nec,28,0
11399 DATA bed,bed,28,1
11409 DATA *velvet pillow*,pil,28,0
11419 DATA ladder,lad,29,1
11429 DATA furniture,fur,31,1
11439 DATA "*Commodore PET*",pet,31,0
11449 DATA furniture,fur,32,1
11459 DATA cobwebs,cob,33,1
11469 DATA *rare family jewels*,jew,34,0
11479 DATA "A body hanging from a noose (Hubie?)",bod,35,1
11489 DATA old trunk,tru,35,1
11499 DATA *rare coins*,coi,0,0
11509 DATA *bottle of rare imported wine*,win,39,0
11519 DATA "An old wooden Coffin",cof,40,1
11529 DATA "A dangerous GOBLIN",gob,45,2
11539 DATA "A mean TROLL",tro,43,2
11549 DATA "a torture rack",rac,51,1
11559 DATA *gold death mask*,mas,51,0
11569 DATA "GIANTOYSTER",oys,52,1
11579 DATA *sack of diamonds*,dia,55,0
11589 DATA *large ruby*,rub,56,0
11599 DATA "AGHOST",gho,0,2
11609 DATA flashlight(on),fla,0,0
11619 DATA flashlight(off),fla,11,0
11629 DATA large rug,xxx,10,1
11639 DATA locked trapdoor,tra,0,1
11649 DATA open trapdoor,tra,0,1
11659 DATA locked trapdoor,tra,30,1
11669 DATA open trapdoor,tra,0,1
11679 DATA *giant pearl*,pea,0,0
11689 DATA stairs going up,sta,13,1
11699 DATA cobwebs,cob,8,1
11709 DATA "SIGNSAYS - YOUSHALLDIE...",sig,5,1
11719 DATA "-Barlow the Vampire-",vam,0,2
11729 DATA "The spirit of Hubie Marston",spi,0,1
11739 DATA empty vial,via,0,0
11749 DATA sweet smelling broken glass,gla,0,0
11759 DATA "PASSAGE",pas,0,1
11760 DATA empty bottle,bot,0,0
11769 DATA nothing happens
11779 DATA "how should I know what to do"
11789 DATA "I'MDEAD"
11799 DATA a couple things fell out
11809 DATA something fell out
11819 DATA the trapdoor creaks open
11829 DATA the door creaks open
11839 DATA"It says: those who enter may not leave  heres a hint they may need"
11849 DATA"If something is too heavy to take, try   to move it"
11859 DATA "OK, I moved it"
11869 DATA "OK, weird laughing comes from the house"
11879 DATA"the troll drinks the potion and turns   into a frog, the frog hops away"
11889 DATA"you got him.  The goblin and disappears in a cloud of black smoke"
11899 DATA "Barlow turns to dust                    and blows away"
11909 DATA "The ghost vaporizes"
11919 DATA "It's poison  I'm dead!"
11929 DATA "Everything changes and...."
11939 DATA "BANGBANGBANG"
11949 DATA you got him
11959 DATA you missed
11969 DATA "it says - Hubie is harmless"
11979 DATA "It says:"
11989 DATA "This book is a treasure"
11999 DATA "The bottle of wine drops with a CRASH!"
12009 DATA "It's empty"
12019 DATA "some treasures may be weapons           shoot goblin-troll potion!
12029 DATA "say CBM"
12039 DATA "Kill a Vampire with *silver*            when trapped, take a drink"
12049 DATA indentify book by color
12059 DATA "I don't have it"
12069 DATA "Where?!?"
12079 DATA "The BLUE book turns into a *gold* book"
12089 DATA "thanks I was hungery"
12099 DATA the flashlight is on
12109 DATA the flashlight is off
12119 DATA "I can't move that!"
12129 DATA there was something under it
12139 DATA "OK,"
12149 DATA "It's locked"
12159 DATA "It's to heavy"
12169 DATA "I need a key"
12179 DATA "The oyster opens up to eat the BIG MAC  and a pearl rolls out!"
12189 DATA "The bottle lands softly on the pillow"
12199 DATA "A voice booms out.....PLEASELEAVEITALONE!"
12209 DATA "The lid of the Coffin rises and Barlow  the vampire jumps out!!!"
12219 DATA "I don't see it here"
12229 DATA "HOW?!?"
12239 DATA"I have nothing to read","NOTWELCOME",closets aren't closed
12249 DATA "I have nothing to eat"
12259 DATA  "I have nothing to drink"
12269 DATA "I don't have a gun"
12279 DATA "I don't have a knife"
12289 DATA "Barlow stops me!"
12299 DATA "There is nothing to attack here"
12309 DATA "The bullets bounce off the shell!"
12310 DATA "He only eats big macs and I don't       have one"
12312 DATA "hic hic, burp.  Boy was that good!"
12319 DATA1000000000000000100000000000000000,1100000000000000110000000000000000
12329 DATA1200000000000000120000000000000000,1300000000000000130000000000000000
12339 DATA0712055800000000014000000000000000,0720055300000000014000000000000000
12349 DATA0726055000000000014000000000000000,0717000000000000012900000000000000
12355 DATA 0731000000000000014400000000000000
12359 DATA 0727056400000000014000000000000000
12369 DATA0732056300000000146300000000000000,0802055803690114014200046900031400
12370 DATA0802055800000000015800000000000000
12379 DATA0821055501360000011200035500033600,0832016300000000156300000000000000
12389 DATA0817000000000000012900000000000000,0905050400000000013900000000000000
12399 DATA0833015205420000014300155200000000,0833015200000000012400155200025276
12402 DATA 0700000000000000070000000000000000,0800000000000000080000000000000000
12409 DATA0905050500000000050800000000000000,0905056600000000053600000000000000
12419 DATA0905056800000000053300000000000000
12429 DATA0919052600000000052100000000000000,0919053900000000052900000000000000
12439 DATA0935057700000000054100000000000000
12445 DATA 1400000000000000010200000000000000
12449 DATA1507050700000000011100000000000000
12459 DATA1604010300000000010800010900000000
12469 DATA1606050600000000012200014900000000
12479 DATA1613011800000000012100000000000000
12489 DATA1617000000000000012900000000000000
12499 DATA1614012200000000012200012600000000
12509 DATA1615012300000000012200012700000000
12519 DATA1616012400000000012200012800000000
12529 DATA1618012500000000012200012300000000
12539 DATA1600000000000000014800000000000000
12549 DATA 1720037305530000012500014500047300
12555 DATA1720055300000000012500000000000000
12559 DATA1705050401020000010700020405170108
12569 DATA1701050103020303010400040300040200
12579 DATA1701050100000000012500000000000000
12589 DATA1705056501020000010600026566170536
12599 DATA1705056500000000014100000000000000
12609 DATA1705050400000000014100000000000000
12619 DATA1705056701020000010600026768170433
12629 DATA1705056700000000014100000000000000
12639 DATA1719000000000000015000000000000000
12649 DATA1711051703180319010400041800041900
12659 DATA1726055003510000010500045100000000
12669 DATA1726055000000000012500000000000000
12679 DATA1711051700000000012500000000000000
12689 DATA 1820057305530000015500000000000000
12699 DATA 1820037305530000014500015500047300
12709 DATA1827056403650366011000013700046500
12719 DATA1820055303770000011000013700047700
12729 DATA1812000000000000013600000000000000
12739 DATA1900056101190000011800180000000000
12749 DATA1900057401190000011800010100000000
12759 DATA1900055401190000011800011300035400
12769 DATA1900055501190000011800010100000000
12779 DATA1900055801190000015700000000000000
12789 DATA1900057301190000011800010100000000
12799 DATA1900011900000000015600000000000000
12809 DATA1900000000000000015300000000000000
12819 DATA2000000000000000013100000000000000
12829 DATA2100000000000000014700000000000000
12839 DATA2200011400000000013300031400000000
12849 DATA2200000000000000015100000000000000
12859 DATA2323054300000000053000000000000000
12869 DATA2400016200000000013500026263770000
12879 DATA2400016300000000013400026263770000
12889 DATA2500016300000000013400026263770000
12899 DATA2600016200000000013500026263770000
12909 DATA2710011502550000011700021575050600
12919 DATA2710011500000000011700021575050800
12925 DATA2733015200000000015900025278000000
12929 DATA2721013600000000011600033600060000
12939 DATA2721000000000000013000000000000000
12940 DATA2710000000000000013000000000000000
12941 DATA2700000000000000015200000000000000
12949 DATA2800012300000000013200022325000000
12959 DATA2800000000000000010100000000000000
12969 DATA2934000000000000160000000000000000
12979 DATA3008057301120000011400097399041200
12989 DATA3008011200000000010100041200000000
12999 DATA3008000000000000015400000000000000
13000 DATA3100057301120000011400097399000000
13001 DATA3100011200000000010100000000000000
13002 DATA3100000000000000015400000000000000
13009 DATA13,n,nor,s,sou,e,eas,w,wes,u,up,d,dow,get,tak,use,sho,sea,ope,att,kil
13010 DATAfir,sho,fee,dro,giv,dro,end
13012 DATA"A black cat runs by","I heard a funny noise","I think I hear footsteps"
13014 DATA "Was that a scream I heard ?","I feel a chill","A spider runs by"
13016 DATA "I think I heard a door slam"
13019 DATA "Who dares to enter this house","You shall die..."
13020 DATA "Get out, get out before it's too late"
13029 DATA"the end"
