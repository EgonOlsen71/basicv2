1 dim v,it,x,y,x1,y1,ad,o,co,cd:poke198,0
2 dimc%(16):c%(0)=32:c%(1)=126:c%(2)=124:c%(3)=226:c%(4)=123
3 c%(5)=97:c%(6)=255:c%(7)=236:c%(8)=108:c%(9)=127:c%(10)=225
4 c%(11)=251:c%(12)=98:c%(13)=252:c%(14)=254:c%(15)=160
5 poke53280,0:poke53281,0:poke646,9:printchr$(147);
10 xs=2+rnd(0)*3:xe=35+rnd(0)*4:ye=10+rnd(0)*12:ys=10+rnd(0)*12
12 if int(ye)=int(ys) then ys=ys+3
15 if rnd(0)<0.5thent=xs:xs=xe:xe=t
20 dim xp%(3000),yp%(3000):cp=0:rc=0:df=0.00001:rn=1:m=1
30 gosub 10000
40 cc=0
50 ifcc>=cp or rn=4then20000
60 xs=xp%(cc):xe=xp%(cc+1):ys=yp%(cc):ye=yp%(cc+1)
70 rn=xp%(cc+2):cc=cc+3
80 gosub 10000
90 goto 50
10000 xs=xs+xs:xe=xe+xe:ys=ys+ys:ye=ye+ye
10010 x=xs:y=ys:dy=abs(ye-ys):dx=abs(xe-xs)
10020 ifdy=0thendy=df
10030 ifdx=0thendx=df
10040 d=dy:yd=sgn(ye-ys):xd=(xe-xs)/d
10050 ifdx>dythend=dx:xd=sgn(xe-xs):yd=(ye-ys)/d
10055 ifxd=0andyd=0thenreturn
10060 co=0:cd=int(d)
10070 x1=int(x):y1=int(y)
10080 ad=1024+40*int(y/2)+int(x/2)
10085 ifad<1024orad>2023thenreturn
10090 v=peek(ad):it=(1-((x1and1)=1))*(1-3*((y1and1)=1))
10100 ct=c%(it):if v=32 then 10140
10110 if ct=v or v=81 then 10150
10120 foro=1to15:ifc%(o)=vthenct=c%(it or o):o=15
10130 next
10140 poke ad,ct:ifco>2thengosub 30000
10145 if (rn<=2) then 10150
10146 cr=54272+ad:pokecr,5
10147 if rnd(0)<0.03 then poke cr,2:pokead,81
10150 x=x+xd:y=y+yd:if x>=80 or x<0 then return
10155 if y<0 or y>=50 then return
10160 co=co+1:ifco=cdthenreturn
10170 goto 10070
20000 poke646,1:printspc(11);"frohe weihnachten!"
20010 geta$:ifa$=""then 20010
20020 printchr$(147):run
30000 rv=rnd(0):rc=rc+0.1
30010 if rv*1/(rn*rn)<rc and cp<3000 then 30030
30020 return
30030 xj=xd:ifxj=0thenxj=df
30035 rc=0
30040 m=m*-1
30050 s=m*(0.8+rnd(0)/2)
30055 ff=rn*rn:ifrn>=2thenff=1.3*ff
30060 mm=15/ff:db=rnd(0)*mm+mm
30070 xh=(x+xd*db)/2:yh=(y+yd*db)/2
30080 cs=cos(s):ss=sin(s):xk=x/2:yk=y/2
30085 xh=-xk+xh:yh=-yk+yh:
30090 xn=xh*cs-yh*ss:yn=xh*ss+yh*cs
30100 xp%(cp)=xk:xp%(cp+1)=xk+xn:yp%(cp)=yk:yp%(cp+1)=yk+yn
30110 xp%(cp+2)=rn+1:cp=cp+3:return
