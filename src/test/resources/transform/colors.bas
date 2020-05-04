10 fori=8192to16384:pokei,0:next
20 v=53248:gosub280:z=rnd(-ti):c$=chr$(147):kd=4
30 p=832:w$="wait..":fori=pto958:pokei,.:next:poke56334,.:poke1,51
40 fori=.tolen(w$)-1:b=v+8*(asc(mid$(w$,i+1))and63)
50 forj=p+i+61*int(i/3)toj+21step3:pokej,peek(b):b=b+1:next:next
60 poke1,55:poke56334,1:fori=.to1:z=v+i+i:pokez,136+48*i:pokez+1,140
70 poke2040+i,13+i:pokev+39+i,3:next:pokev+23,3:pokev+29,3:pokev+21,3
80 n=11:printc$:a=8192:c=39:p=n-1:vr=1024:fr=55296-vr:d=504:e=1e6:w=15
100 l=199:m=.5:t=198:dimf(15),ye(255),x(10),y(10),u(10),h(7)
105 fori=.tow:readf(w-i):next
110 fori=.tol:ye(i)=a+c*(iandd)+i:next:fori=.to3:h(i+i)=4^(3-i):next:poke646,.
120 printc$chr$(5):fori=vrtoi+999:pokei,.:next
130 pokev+17,59:pokev+24,24:pokev+22,24
140 o=576:fori=.top
141 x=int(320*rnd(1)):y=int(2e2*rnd(1)):ifi=.then145
142 forj=.toi-1:dx=x-x(j):dy=y-y(j):ifdx*dx+dy*dy<othen141
143 next
145 x(i)=x:y(i)=y:next:o=240
150 forx=.to319step2:q=.:g=xandd:k=h(xand7):fori=.top:dx=x-x(i):u(i)=dx*dx:next
160 fory=.tol:r=e:fori=.top:dy=y-y(i):r1=u(i)+dy*dy:ifr1<rthenr=r1
170 next:c=f(m+sqr(r)/kdandw)
175 ifcthenb=g+ye(y):gosub500:pokeb,peek(b)or(q*k)
180 next:next
200 pokev+32,.:pokev+21,.
260 poket,.:waitt,1
270 gosub280:printc$:poket,.:poke56,160:clr:end
280 sys58784:pokev+33,.:pokev+32,11:return
500 vf=vr+int(x/8)+5*(yandd)
1020 lb=peek(fr+vf)andw:iflb=cthenq=3:return
1030 iflb=.thenpokefr+vf,c:q=3:return
1040 by=peek(vf):lb=byandw:iflb=cthenq=2:return
1050 iflb=.thenpokevf,(byando)orc:q=2:return
1060 hb=int(by/16):ifhb=cthenq=1:return
1080 ifhb=.thenpokevf,lbor(16*c):q=1:return
1100 q=(peek(b)/k/4)and3:return
1200 :
2000 rem liste der farben
2010 data 10,02,09,08,07,13,05,03
2020 data 14,06,04,00,11,12,15,01
2030 rem 2020 by neptun
2040 :