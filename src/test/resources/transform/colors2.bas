1 goto10
2 ifc1=cthenq=1:return
3 ifc2=cthenq=2:return
4 ifc3=cthenq=3:return
5 ifc1=.thenq=1:c1=c:return
6 ifc2=.thenq=2:c2=c:return
7 ifc3=.thenq=3:c3=c:return
8 q=sand3:ifqthenreturn
9 q=peek(a-1)/h(x2)and3:return
10 fori=24576to24576+8000:pokei,0:next
20 v=53248:pokev+33,.:pokev+32,11:dimc1,c2,c3,c,q:s=rnd(-ti)
30 p=32576:w$="wait..":fori=ptop+126:pokei,.:next:fori=.to1:z=v+i+i
40 pokez,136+48*i:pokez+1,235:poke24568+i,253+i:pokev+39+i,3:next
50 poke56576,198:pokev+24,16*7+8:pokev+17,59
60 pokev+23,3:pokev+29,3:pokev+21,3
70 poke56334,.:poke1,51:fori=.tolen(w$)-1:b=v+8*(asc(mid$(w$,i+1))and63)
80 forj=p+i+61*int(i/3)toj+21step3:pokej,peek(b):b=b+1:next:next
90 poke1,55:poke56334,1
100 n=11:a=24576:m=.5:p=n-1:vr=23552:fr=55296-vr:e=1e6:u=16:w=15
110 k=320:d=k-1:t=198:g=24^2:dimx(10),y(10),qx(3,10),qy(7,10),f(w),h(3)
120 fori=.tow:readf(w-i):next:fori=.to3:h(3-i)=4^i:next
130 printchr$(158)chr$(147):f=16*5+2:fori=vrtoi+999:pokei,f:next:pokev+22,24
140 fori=.top
150 x=int(rnd(1)*k):y=int(rnd(1)*2e2):ifi=.then180
160 forj=.toi-1:dx=x-x(j):dy=y-y(j):ifdx*dx+dy*dy<gthen150
170 next
180 x(i)=x:y(i)=y:next
190 fory1=.to199step8
200 fori=.to7:y=y1+i:forj=.top:dy=y-y(j):qy(i,j)=dy*dy:next:next
210 forx1=.todstep8
220 fori=.to3:x=x1+2*i:forj=.top:dx=x-x(j):qx(i,j)=dx*dx:next:next
230 c1=.:c2=.:c3=.:fory2=.to7:s=.
240 forx2=.to3:r=e:fori=.top:r1=qx(x2,i)+qy(y2,i):ifr1<rthenr=r1
250 next:q=.:c=f(m+sqr(r)/4andw):ifcthengosub2
260 s=s*4+q:next:pokea,s:a=a+1:next
270 pokevr,c2+u*c1:pokefr+vr,c3:vr=vr+1:next:next:pokev+21,.
280 fori=.to96:pokev+32,i:next
290 poket,.:waitt,1:end
310 rem farbliste
320 data 10,02,09,08,07,13,05,03
330 data 14,06,04,00,11,12,15,01
340 rem 2020 by neptun
350 :