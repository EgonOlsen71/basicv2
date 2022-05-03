10 poke 53280,0:poke 53281,0
20 gosub 10000:mv=12:dim vp%(mv),vs%(mv):sc=0::dd=0:iv=3:rc=200
25 dim ya%(rc),xa%(rc):gosub 12000:gosub 26130
30 x=20:y=10:df=0:xd=-1:yd=-1:gosub 9000
40 v=160:gosub 11000:gosub 11100:gosub 10500
50 gosub 25000:gosub 20000
60 if df=1 then gosub 22000
70 gosub 29000:goto 50

9000 xv=rnd(0):for i=0 to mv
9010 xv=int(rnd(1)*30+3):yv=int(rnd(1)*20)
9020 vp%(i)=xv+yv*40+1024:vs%(i)=5
9030 next
9040 for i=0 to iv-1:vs%(i)=10:next:return

10000 poke646,1:print chr$(147);
10005 poke 211,4:poke 214,5:poke 646,1:sys 58640
10006 print "detecting virus - please wait..."
10010 for i=1025 to 1865 step 40:poke i,93:next
10020 for i=1062 to 1902 step 40:poke i,93:next
10030 for i=1906 to 1941:poke i,64:next
10040 poke 1905,109:poke 1942,125
10050 for i=55296 to 55296+24*40 step 40:poke i,2:next
10060 for i=55335 to 55335+24*40 step 40:poke i,2:next
10070 for i=56216 to 56216+37:poke i,2:next
10080 return

10500 poke 211,4:poke 214,5:poke 646,1:sys 58640
10510 print "                                ":return

11000 ps=y*40:poke 1024+ps,v:return
11100 poke 1944+x,v:return

12000 xa=rnd(0):rp=0:for i=0 to rc
12010 xa=rnd(1):ya=rnd(1)
12020 if xa<0.2 then xa=0:goto 12050
12030 if ya<0.2 then ya=0:goto 12050
12040 xa=xa-0.7:ya=ya-0.7
12050 xa=sgn(xa):ya=sgn(ya)*40
12060 ya%(i)=ya:xa%(i)=xa:next:return

20000 j=peek(56320)
20010 if (j and 1)=1 then 20100
20020 y2=y-1:if y2<0 then 20100
20030 v=32:gosub 11000:y=y2:v=160:gosub 11000
20100 if (j and 2)=2 then 20200
20110 y2=y+1:if y2>21 then 20200
20120 v=32:gosub 11000:y=y2:v=160:gosub 11000
20200 if (j and 4)=4 then 20300
20210 x2=x-1:if x2<2 then 20300
20220 v=32:gosub 11100:x=x2:v=160:gosub 11100
20300 if (j and 8)=8 then 20400
20310 x2=x+1:if x2>37 then 20400
20320 v=32:gosub 11100:x=x2:v=160:gosub 11100
20400 if (j and 16)=16 then 20500
20410 df=1:xd=x:yd=y:xc=2:yc=21
20420 px=yc*40+1024+xd:p=peek(px):if p=91 or p=93 then xd=-1
20430 py=xc+1024+yd*40:p=peek(py):if p=91 or p=64 then yd=-1
20500 return

22000 if xd=-1 then 23000
22010 px=yc*40+1024+xd
22015 p=peek(px):if p=90 then p=32:gosub 26000 
22018 if p=32 then p=93:goto 22200
22020 if p=64 then p=91
22200 poke 54272+px,7:poke px,p:px=px-40:yc=yc-1
22210 if yc>-1 then 22015
23000 if yd=-1 then 24000
23010 py=xc+1024+yd*40
23015 p=peek(py):if p=90 then p=32:gosub 26050 
23018 if p=32 then p=64:goto 23200
23020 if p=93 then p=91
23200 poke 54272+py,7:poke py,p:py=py+1:xc=xc+1
23210 if xc<38 then 23015
24000 xd=-1:yd=-1:return

25000 for i=0 to mv:si=vs%(i)
25005 gosub 28000:if si=11 then 25100
25010 xa=xa%(rp):ya=ya%(rp):rp=rp+1:if rp>rc then rp=0
25020 po=vp%(i):if po<1064 and ya=-1 then ya=0
25030 pn=po+xa+ya:p=peek(pn)
25040 if p=90 and si=10 then gosub 27000:goto 25100
25050 if p<>32 then 25100
25060 poke 54272+pn,si:poke po,32:poke pn,90:vp%(i)=pn
25100 next:return

26000 sv=peek(54272+px) and 15:pp=px:goto 26100
26050 sv=peek(54272+py) and 15:pp=py:goto 26100
26100 gosub 26500
26110 if sv=10 then iv=iv-1
26120 if sv<>11 then sc=sc-100:dd=dd+1
26130 poke 211,2:poke 214,24:poke 646,12:sys 58640:print"score: ";sc;
26140 return

26500 for o=0 to mv:if vp%(o)=pp then vs%(o)=11:return
26510 next:return

27000 px=pn
27010 for o=0 to mv:if vp%(o)=px and o<>i then 27050
27020 next:return
27050 vo=vs%(o):ns=10:if vo=6 then ns=6:gosub 26130
27055 if vo<>10 and vo<>11 and ns=10 then sc=sc-20:iv=iv+1:gosub 26130
27060 pn=po:vs%(o)=ns:xa=0:ya=0
27070 poke 54272+vp%(o),ns:return

28000 if si<>10 then return
28010 r=rnd(1):if r<0.003 then si=11:dd=dd+1:iv=iv-1:sc=sc-30
28020 if r>0.992 then si=6:iv=iv-1:sc=sc+40
28030 gosub 28100:return

28100 vs%(i)=si:poke 54272+vp%(i),si:return

29000 if iv>0 then return
29010 sc=sc+25*(mv-dd)
29020 gosub 26130
29030 poke 211,3:poke 214,5:poke 646,1:sys 58640
29040 print "virus exterminated - fire to start"
29050 if (peek(56320) and 16)=0 then 29050
29060 if (peek(56320) and 16)=0 then run
29070 goto 29060
