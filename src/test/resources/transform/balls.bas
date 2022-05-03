10 poke53280,0:poke53281,0
20 print"number of ball (1-255)?"
30 input n
40 if n<1 or n>255 then 20
60 print chr$(147);
70 dim bx(255):dim by(255):dim bc(255)
75 dim dx(255):dim dy(255)
80 for b=0ton
90 bx(b)=int(rnd(1)*40)
100 by(b)=int(rnd(1)*25)
105 bc(b)=int(rnd(1)*14)+1
106 dx(b)=int(rnd(1)*2)
108 rem dy(b)=int(rnd(1)*2)
109 dy(b)=1
110 next b
120 rem
130 for i=1024to2023:pokei,81:next
140 for i=55295to56295:pokei,0:next
200 ti$="000000":for b=1ton
210 poke55296+by(b)*40+bx(b),0
240 ifdx(b)=0thengosub1010
250 ifdx(b)=1thengosub1040
260 ifdy(b)=0thengosub1070
270 ifdy(b)=1thengosub1100
280 poke55296+by(b)*40+bx(b),bc(b)
290 nextb:printchr$(19);ti
300 goto 200
1000rem
1010ifbx(b)=0thendx(b)=1:return
1020bx(b)=bx(b)-1:return
1030rem
1040ifbx(b)=39thenbx(b)=38:dx(b)=0:return
1050bx(b)=bx(b)+1:return
1060rem
1070ifby(b)=0thendy(b)=1:return
1080by(b)=by(b)-1:return
1090rem
1100ifby(b)=24thenby(b)=23:dy(b)=0:return
1110by(b)=by(b)+1:return