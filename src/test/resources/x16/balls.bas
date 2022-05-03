10 SCREEN 0
20 print"number of balls (1-255)?"
30 input n
40 if n<1 or n>255 then 20
60 print chr$(147);
70 dim bx(255):dim by(255):dim bc(255)
75 dim dx(255):dim dy(255)
80 for b=0ton
90 bx(b)=int(rnd(1)*40)
100 by(b)=int(rnd(1)*30)
105 bc(b)=int(rnd(1)*14)+1
106 dx(b)=int(rnd(1)*2)
108 rem dy(b)=int(rnd(1)*2)
109 dy(b)=1
110 next b
120 rem
130 fory=0to29:forx=0to39
140 q=y*256+x*2
150 vpoke0,q,81:vpoke0,q+1,0
160 nextx,y
200 for b=1ton
210 vpoke0,by(b)*256+bx(b)*2+1,0
240 ifdx(b)=0thengosub1010
250 ifdx(b)=1thengosub1040
260 ifdy(b)=0thengosub1070
270 ifdy(b)=1thengosub1100
280 vpoke0,by(b)*256+bx(b)*2+1,bc(b)
290 nextb
300 goto 200
1000 rem
1010 ifbx(b)=0thendx(b)=1:return
1020 bx(b)=bx(b)-1:return
1030 rem
1040 ifbx(b)=39thenbx(b)=38:dx(b)=0:return
1050 bx(b)=bx(b)+1:return
1060 rem
1070 ifby(b)=0thendy(b)=1:return
1080 by(b)=by(b)-1:return
1090 rem
1100 ifby(b)=29thenby(b)=28:dy(b)=0:return
1110 by(b)=by(b)+1:return
