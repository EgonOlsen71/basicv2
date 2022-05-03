10 v = 53248
11 poke v+21,1
12 poke 2040,13
20 for n = 0 to 62:read q:poke 832+n,q:poke 49152+n,q:next
25 gosub 900
30 for x = 24 to 200:y=x
35 remx=51:y=53
40 poke v,x 
50 poke v+1,y 
55 xp=x:yp=y:bl=13:sp=0:gosub 1000
60 next x
70 goto 30
200 data 0,127,0,1,255,192,3,255,224,3,231,224
210 data 7,217,240,7,223,240,7,217,240,3,231,224
220 data 3,255,224,3,255,224,2,255,160,1,127,64
230 data 1,62,64,0,156,128,0,156,128,0,73,0,0,73,0
240 data 0,62,0,0,62,0,0,62,0,0,28,0
898 ::
899 rem setup lookup table
900 dim pw(8),ma(8):for i=0 to 7
910 pw(i)=2^i
920 ma(i)=(255*pw(i)) and 255:next
930 pw(i)=256:ro=0:if(peek(53272) and 6)=6 then ro=2048
940 dim i,ii,cp,la,xp,yp,xs,ys
950 return
998 ::
999 rem hide sprite behind certain chars
1000 v=53248:ca=v+ro:s=1024
1020 gosub 5000
1040 bs=bl*64 
1060 i=0:gosub 5020:ii=0:cg=0:oy=0
1065 gosub 5500 
1070 la=peek(49152+i):cp=peek(ch+cn)
1075 if la=0 then 1085
1080 cp=cp*pw(cx):cp=(not cp) and 255:la=la and cp
1082 if cx<>0 then if (ii and 3)<3 then gosub 5100
1084 poke bs+i,la:gosub 5600
1085 i=i+3:cn=cn+1:cg=cg+1
1090 if cn<8 then if cg<8 then if i<63 then 1065 
1100 if i>=66 then return
1102 if cn=8 then if cg<8 then if oy=0 then gosub 5040:goto 1065
1104 if oy then yp=yp-8:oy=0
1110 xp=xp+8:ii=ii+1:if (ii and 3)=3 then ii=ii+21:xp=xp-24:yp=yp+8
1120 i=ii:gosub 5020:gosub 5000
1130 cg=0:goto 1065
4998 ::
4999 rem calculate address of char in ROM
5000 xs=int((xp-24)/8):ys=int((yp-50)/8)
5010 ch=peek(s+xs+40*ys)*8+ca:return
5018 ::
5019 rem calculate new char offsets
5020 cn=yp-50 and 7:cx=xp and 7:return 
5038 ::
5039 rem handle overflow in y direction
5040 cg=7-cn:cn=0:yp=yp+8:gosub 5000:oy=-1:return
5098 ::
5099 rem draw right side of a clipped char
5100 if xs>=39 then return
5110 xp=xp+8:gosub 5000
5130 cp=peek(ch+cn):cp=int(cp/pw(8-cx))
5140 mm=ma(cx)
5150 cp=((not cp) and (not mm and 255)):la=(la and (cp or mm))
5160 xp=xp-8:gosub 5000:return
5498 ::
5499 rem io off
5500 poke 56334,peek(56334) and 254:poke1,peek(1) and 251
5510 return
5598 ::
5599 rem io on
5600 poke 1,peek(1) or 4:poke56334,peek(56334) or 1
5610 return

