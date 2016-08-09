1 REM quest  by roger chaffee
2 REM inspired by will crowther's adventure
3 REM from byte magazine
4 REM adapted for the pet by
5 REM david a. hook, 58 steel street
6 REM barrie, ont, l4m 2e9
7 REM needs 16k ram
13 REM variables used
14 REM n   node (cave) number
15 REM mo  move counter
16 REM t   current location of treasure (-1 for carrying)
17 REM t1,t2 first & second hiding places
18 REM m6  saves move number when he said 'no' to taking treasure
20 REM m(i,j) map of interconnections
21 REM        for i=0 to 5 (n,e,u,d,w,s)
22 REM        m(i,j) is next node from node j
23 REM bounces--node -2 is to bounce back
24 REM m(0,n)=-2 means a forced move as soon as you reach node n
25 REM m(1,n) of the time you go to node m(2,n)
26 REM and m(3,n) of the time you go to m(4,n) and the rest to m(5,n)
35 REM node n+100 means node n without treasure and n+1 if you do
36 REM node n+200 means node n+1 if you have treasure the second time & n else
45 REM q$   input string
46 REM a$   chars to match in q$
47 REM a2   # chars in a$
48 REM a1   output from input routine
49 REM p    pirate flag (1 if he has you)
50 REM p1   counter for p routine
51 REM n9   old node in move routine
52 REM n8   saves node bounced from
53 REM no   old node in move, for dead end
55 REM ao   old direction in move
56 REM d    debug flag (non-zero to print)
57 REM i,j  counters
58 REM w(i) travel flag (score), w(i)=1 if been to node i
60 REM s    score
61 REM m9   max nodes
80 d=RND(-ti*10e9):d=0
100 POKE59468,PEEK(59468)OR14
120 PRINT""TAB(15)"QUEST3.0"
140 PRINT"You werewalking through the woods, and ";
150 PRINT"you came across the entrance to a cave, ";
160 PRINT"that was covered withbrush."
170 PRINT"People say that many years ago,a Pirate";
180 PRINT"hid his treasure in these woods, but no ";
190 PRINT"one has ever found it.":PRINT"It may still be here, for all I know..."
400 READ m9,t1,t2:DATA 42,23,12
500 DIMw(m9),m(5,m9)
520 FORi=1TOm9:READn:IFi=nTHEN570
550 PRINT"Data-Base problem"i;n:STOP
570 FORj=0TO5:READm(j,i):NEXTj,i
900 PRINT"When you answer a question, I only look ";
910 PRINT"at the first letter, althoughyou may":PRINT"type the whole word, if you wish.
920 GOSUB7500
1000 n=5:mo=0:m6=0:t=t1:p=0:p1=0:FORj=1TOm9:w(j)=0:NEXTj
1110 GOSUB8000:REM describe
1400 REM main loop
1410 REM count moves
1420 mo=mo+1:GOSUB6000:REM move
1460 GOSUB2000:REM check for treasure
1480 GOSUB4000:REM try the pirate
1500 IFt>0ORn<>5THEN1400:REM loop unless finished
1700 GOSUB3000:REM calculate score
1730 PRINT"Congratulations!  You got the Treasure  ";:PRINT"out in";mo;"moves."
1750 PRINT"You get"s+10"Points!"
1760 PRINT"Do you wish to Hunt again";:a$="yn":a2=2
1780 GOSUB5000:ONa1+1GOTO1000,9999,1760
1999 STOP
2000 REM found?
2100 IFt<>nORt<0ORm6+5>moTHENRETURN
2200 PRINT"Do you want to take it with you";:a$="yn":a2=2:GOSUB5000
2240 ONa1+1GOTO2300,2400
2250 PRINT"Well?...":GOTO2200
2300 t=-1:PRINT"OK  let's get out of here.":RETURN
2400 PRINT"We'll leave it here and you can explore";:PRINT" some more.":m6=mo:RETURN
3000 REM score
3010 s=0:IFt1=-1THENs=s+5
3020 IFp=1THENs=s+10
3050 FORj=2TOm9:s=s+w(j):NEXTj:RETURN
4000 REM pirate
4020 IFn=t2ORp=1ORt1=t2ORt<>-1THENRETURN
4060 REM he's at the exit with the treasure.  zap him
4070 IFn=16THENp=160
4080 REM count moves since hitting tight tunnel with treasure
4090 IFp1>0THENp1=p1+1
4100 IFn=3THENp1=p1+1
4110 REM give him a few more moves, then zap him
4120 IFp1<15THENRETURN
4130 PRINT"Suddenlythe Pirate leaps out of the":PRINT"gloom and grabs the treasure ";
4140 PRINT"from you!  'HAH', he shouts, 'You foundmy":PRINT"Treasure, did you?!  Well";
4170 PRINT" I'll hide":PRINT"it better this time!'":PRINT"And he disappears into the ";
4180 PRINT"darkness withthe treasure.":p=1:t=t2:RETURN
5000 REM input
5010 REM first char of a1 input string is compared with letters of a$
5020 REM match returns index in a1
5030 REM no match returns size(a$)+1
5070 INPUTq$:q$=LEFT$(q$,1):FORa1=1TOa2:IFq$=MID$(a$,a1,1)THENa1=a1-1:RETURN
5080 NEXTa1:a1=a2:RETURN
6000 REM move
6030 n9=n:REM remember location for bounce
6050 n8=0:REM set n8to anything but can't go that way
6070 GOSUB7000:REM ask which way
6090 IFn=1THEN6120:REM remember location except for dead end
6100 no=n:ao=a1
6120 PRINT:i=m(a1,n)
6200 IFi=-2THENi=n9
6210 IFd<>0THENPRINT"        Debug"n"to"i
6220 IFi<500THEN6300
6240 i=i-500:FORj=0TO2000:NEXTj:GOTO6200
6300 ONi/100GOTO6340,6370
6310 n=i:GOTO6400:REM normal route
6340 n=i-100:IFt=-1THENn=n+1:REM add one if carrying
6350 GOTO6400
6370 n=i-200:IFt=-1THENn=n+p:REM add one if second time
6400 IFn<>1THEN6500
6410 REM dead end. turn
6420 FORj=0TO5:m(j,n)=2:NEXTj:m(5-ao,n)=no
6500 IFn8<>2THENGOSUB8000:REM print out node description
6520 w(n)=1:n8=n:REM we've been here
6600 IF m(0,n)<>-2THEN6800:REM forced move with random destinations
6660 i=m(5,n):j=100*RND(1):IFm(3,n)>jTHENi=m(4,n)
6700 IFm(1,n)>jTHENi=m(2,n)
6710 IFd<>0THENPRINT"         Debug bounce to"i
6720 GOTO6200:REM new location, so go back
6800 RETURN
7000 REM which way?
7010 PRINTTAB(20)"Which way";:a$="neudwsp":a2=7:GOSUB5000:IFa1<7THEN7300
7160 PRINT"Which way do you want to go?":GOSUB7500:REM instructions
7200 GOSUB8000:GOTO7010:REM describe location again
7300 IFa1<6THEN7400
7320 GOSUB3000:PRINT"You have"s"Points!":REM calc & print score
7350 GOTO7010:REM start again
7400 RETURN
7500 REM instructions
7520 PRINT"Type: 'n'  for  'North'":PRINTTAB(6)"'s'  for  'South'"
7530 PRINTTAB(6)"'e'  for  'East'":PRINTTAB(6)"'w'  for  'West'"
7540 PRINTTAB(6)"'u'  for  'Up'":PRINTTAB(6)"'d'  for  'Down'":PRINTTAB(6)"'p'  for  'Score'
7560 PRINT:RETURN
8000 REM describe location
8010 i=INT(n/5):j=n-5*i+1
8100 ONi+1GOTO8200,8210,8220,8230,8240,8250,8260,8270,8280
8200 ONjGOTO9000,9010,9020,9030,9040
8210 ONjGOTO9050,9060,9070,9080,9090
8220 ONjGOTO9100,9110,9120,9130,9140
8230 ONjGOTO9150,9160,9170,9180,9190
8240 ONjGOTO9200,9210,9220,9230,9240
8250 ONjGOTO9250,9260,9270,9280,9290
8260 ONjGOTO9300,9310,9320,9330,9340
8270 ONjGOTO9350,9360,9370,9380,9390
8280 ONjGOTO9400,9410,9420
8400 IFt<>nTHEN8500
8410 PRINT"The Treasure is here!"
8500 IFt<>t2ORt1=t2ORt1<>nTHEN8600
8530 PRINT"A note on the wall says:":PRINT"'PIRATESNEVERLEAVETHEIRTREASURE"
8540 PRINT"TWICEINTHESAMEPLACE.'"
8600 RETURN
9010 DATA1,0,0,0,0,0,0
9011 PRINT"You're at a dead end!":GOTO8400
9020 DATA2,-2,101,-2,0,0,0
9021 PRINT"You can't go in that direction.":GOTO8400
9030 DATA3,33,2,1,10,106,4
9031 PRINT"A Tunnel goes:  North-South."
9032 PRINT"There is an opening to the West.":GOTO8400
9040 DATA4,3,30,2,11,2,1
9041 PRINT"You're on the brink of a Pit.":GOTO8400
9050 DATA5,8,8,15,10,8,16
9051 PRINT"You're outside the Cave.":PRINT"Go South to enter.":GOTO8400
9060 DATA6,16,3,2,10,2,2
9061 PRINT"You're at the home of the Gnome-King.":PRINT"Fortunately, he's gone for the";
9062 PRINT" day.":GOTO8400
9070 DATA7,-2,101,-2,0,0,0
9071 PRINT"The Gnome-King is here!":PRINT"You'd better get out!":GOTO8400
9080 DATA8,18,18,15,10,18,9
9081 PRINT"You're lost in the woods.":GOTO8400
9090 DATA9,-2,33,5,1,0,-2
9097 GOTO8400
9100 DATA10,-2,101,-2,0,0,0
9101 PRINT"You're not going to get far, digging":PRINT"through rock.":GOTO8400
9110 DATA11,1,13,4,2,1,2
9111 PRINT"You'reat the bottom of a Pit.  A little";:PRINT"stream flows over";
9112 PRINT" the rocks here.":GOTO8400
9120 DATA12,36,2,1,2,1,2
9121 PRINT"You're at a dead end!":GOTO8400
9130 DATA13,2,37,2,1,11,14
9131 PRINT"You're at a wide spot.  There is a":PRINT"sooty patch where somebody has";
9132 PRINT" rested":PRINT"a torch against the wall.  Thereare":PRINT"jagged rocks";
9133 PRINT" above you.":GOTO8400
9140 DATA14,13,1,19,2,31,31
9141 PRINT"You're in a Canyon.  High on the wall":PRINT"above you is scratched the ";
9142 PRINT"message:":PRINT"     'BILBOWASHERE'":GOTO8400
9150 DATA15,-2,101,-2,0,0,0
9151 PRINT"You're not a bird.  You can't fly!":GOTO8400
9160 DATA16,5,33,2,10,1,106
9161 PRINT"You're in a low chamber.  A tight tunnel";:PRINT"goes East, and you can wa";
9162 PRINT"lk to the":PRINT"South or West.  There is light ":PRINT"to the North.":GOTO8400
9170 DATA17,-2,101,-2,0,0,0
9171 PRINT"It's a tight squeeze.  You can't":PRINT"get past with the Treasure."
9172 GOTO8400
9180 DATA18,-2,101,8,0,0,0
9181 PRINT"I don't think you can find the Cave.":GOTO8400
9190 DATA19,224,2,2,14,1,42
9191 PRINT"You're at the top of a climb.":PRINT"Below you a message says:"
9192 PRINT"    'BILBOWASHERE'":GOTO8400
9200 DATA20,226,1,2,2,25,2
9201 PRINT"You're at the North side of a Chasm,":PRINT"too wide to jump.  Ringing ";
9202 PRINT"echoes from":PRINT"below are the only indication of depth.":GOTO8400
9210 DATA21,1,226,2,2,38,25
9211 PRINT"You're in Xanadu.  Below you":PRINT"Alph, the sacred river,runs"
9212 PRINT"throughcaverns measureless to man,":PRINT"down to a sunless sea.":GOTO8400
9220 DATA22,-2,33,13,50,29,30
9221 GOTO8400
9230 DATA23,2,1,2,31,2,2
9231 PRINT"You're on the ledge above the GuillotineRoom.":GOTO8400
9240 DATA24,-2,101,19,0,0,0
9241 PRINT"I hear the Giant there!!!":PRINT"You'd better go back!":GOTO8400
9250 DATA25,21,20,2,2,1,19
9251 PRINT"You're in the Giant's Cavern.  Better":PRINT"not be here when the Giant ";
9252 PRINT"comes!":GOTO8400
9260 DATA26,-2,65,-2,50,11,14
9261 PRINT"You're in the Quest Research and":PRINT"Development Area."
9262 PRINT"I'm sorry, but visitors are not":PRINT"allowed.  You'll have to leave."
9263 GOTO8400
9270 DATA27,2,40,2,2,21,20
9271 PRINT"You're in the Crystal Palace.  The":PRINT"walls resonate with awesome music.
9280 DATA28,-2,60,221,50,14,19
9281 GOTO8400
9290 DATA29,2,42,2,13,1,1
9291 PRINT"You're at the top of a giant stalactite.";:PRINT"You could slide down, ";
9292 PRINT"but you couldn't":PRINT"climb back up.":GOTO8400
9300 DATA30,34,34,2,1,4,2
9301 PRINT"You're in a little Grotto.  There is a":PRINT"book here called: Jane's ";
9302 PRINT"Fighting Ships,";:PRINT"dated1763.":GOTO8400
9310 DATA31,14,14,23,2,1,2
9311 PRINT"You're in the Guillotine Room.  A sharp":PRINT"rockbalancesprecariously ";
9312 PRINT"on the ledge";:PRINT"above you.":GOTO8400
9320 DATA32,-2,101,516,0,0,0
9321 PRINT"You're in a Chute, scramblingdown the":PRINT"rocks!  No way to stop!  ";
9322 PRINT"Hangon!":GOTO8400
9330 DATA33,2,1,2,1,116,3
9331 PRINT"The tight tunnel turns a corner.":GOTO8400
9340 DATA34,1,35,2,1,30,30
9341 PRINT"You're in a little twisty maze.":GOTO8400
9350 DATA35,2,1,2,37,34,36
9351 PRINT"You're in a little twisting maze.":GOTO8400
9360 DATA36,35,2,1,37,34,12
9361 PRINT"You're in a twisting little maze.":GOTO8400
9370 DATA37,2,1,35,2,13,2
9371 PRINT"You're in a twisty little maze.":GOTO8400
9380 DATA38,2,21,2,116,1,2
9381 PRINT"You're in a prehistoric dwelling.  On":PRINT"the wall are drawings of bison";
9382 PRINT" done in":PRINT"red clay.  The floor is strewn with":PRINT"bones, the remains ";
9383 PRINT"of ancient rituals.":PRINT"A smalltunnel goes through the floor.":GOTO8400
9390 DATA39,2,40,2,32,21,26
9391 PRINT"You're in a Black Hole.  The":PRINT"forceof gravityis overwhelming."
9392 GOTO8400
9400 DATA40,40,40,2,2,40,41
9401 PRINT"You're in the Labyrinth.":GOTO8400
9410 DATA41,40,40,40,2,40,39
9411 PRINT"You'rein the Labyrinth.":PRINT"It's very dark in here.":GOTO8400
9420 DATA42,28,28,28,28,28,28
9421 PRINT"You're in the Ashram.  Incenseis heavy":PRINT"in the air, and all ";
9422 PRINT"directions":PRINT"seem the same.":GOTO8400
9430 REM no nodes from here on
9999 END
