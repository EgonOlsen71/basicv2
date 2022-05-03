80 n=11:p=n-1
100 dim x(10),y(10)
140 fori=.top:printp,i
141 x=int(320*rnd(1)):y=int(2e2*rnd(1)):ifi=.then145
142 forj=.toi-1:dx=x-x(j):dy=y-y(j):ifdx*dx+dy*dy<othen141
143 next
145 x(i)=x:y(i)=y:next:print p,i,j:end
