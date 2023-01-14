10 poke 53280,0:poke 53281,0:v=53248
20 poke 2040,14:poke v,50:poke v+1,50
30 poke v+21,1:poke v+39,1
35 for i=896 to 959:poke i,0:next
40 for i=0 to 2:poke 896+i,255:poke 956+i,255:next
50 dim xp(47):for i=0 to 47 step 2:o=i/2
60 p=int(o/8):b=2^(7-(o and 7)):xp(i)=896+p:xp(i+1)=b:next
70 gosub 310:yo=-1:xo=-1:dx=-1:p1=21:p2=21
80 gosub 21000
90 j1=peek(56320):j2=peek(56321):o1=p1:o2=p2
100 if (j1 and 1) then 110
105 p1=p1-3:if p1<-15 then p1=-15:goto 120
110 if (j1 and 2) then 120
115 p1=p1+3:if p1>60 then p1=60
120 if (j2 and 1) then 130
125 p2=p2-3:if p2<-15 then p2=-15:goto 160
130 if (j2 and 2) then 160
135 p2=p2+3:if p2>60 then p2=60
160 if o1<p1 then gosub 12000:goto 180
170 if o1>p1 then gosub 12600
180 if o2<p2 then gosub 12500:goto 200
190 if o2>p2 then gosub 12700
200 poke 896,255:poke 898,255:poke 958,255:poke 956,255
210 x=x+dx:y=y+dy
230 gosub 22000:gosub 15000:xo=x:yo=y:goto 90
300 tt=ti:xa=x:ya=y:gosub 11000
305 poke v,49+2*rnd(0):if ti-tt<60 then 305
308 poke v,50
310 dy=3:y=3:x=12
320 if rnd(0)>.5 then dy=-3:y=57
330 return
10000 gosub 20000:poke p,peek(p) or xp(ix+1):return
11000 gosub 20000:poke p,peek(p) and 255-xp(ix+1):return
12000 oo=896+o1:poke oo,peek(oo) and 127
12010 oo=911+p1:poke oo,peek(oo) or 128:return
12500 oo=898+o2:poke oo,peek(oo) and 254
12510 oo=913+p2:poke oo,peek(oo) or 1:return
12600 oo=911+o1:poke oo,peek(oo) and 127
12610 oo=896+p1:poke oo,peek(oo) or 128:return
12700 oo=913+o2:poke oo,peek(oo) and 254
12710 oo=898+p2:poke oo,peek(oo) or 1:return
15000 if xo>-1 then xa=xo:ya=yo:gosub 11000
15010 xa=x:ya=y:gosub 10000:return
20000 ix=xa+xa:if ix<0 or ix>47 then 300
20010 p=ya+xp(ix):return
21000 for i=p1 to p1+15 step 3:poke 896+i,128:next
21010 for i=p2 to p2+15 step 3:poke 898+i,1:next
21020 return
22000 if y<6 or y>56 then 22100
22010 if x<=1 or x=>22 then 22200
22020 return
22100 dy=-dy:return
22200 pp=p2:if x<=1 then pp=p1
22210 yy=pp+9-y:if abs(yy)>9 then gosub 15000:gosub 300:return
22220 dx=-dx:if yy<-3 then dy=3:return
22230 if yy>3 then dy=-3
22240 return


