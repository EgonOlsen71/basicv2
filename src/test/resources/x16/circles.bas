120 screen 128:fori=0to10
130 y(i)=200*rnd(1):x(i)=320*rnd(1)
140 next
150 forx=0to319:fory=0to199:r=1e6:fori=0to10
180 r1=sqr((x-x(i))*(x-x(i))+(y-y(i))*(y-y(i)))
190 ifr1<rthenr=r1
200 next:psetx,y,r/3and1:next:next
210 geta$:ifa$=""then 210


