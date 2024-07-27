8 dimv,u,a,b,n,s,i,r,z,x,h,y,d
10 x1=38:y1=22:ns=48:ne=33:z=0
20 i1=-1.0:i2=1.0:r1=-2.0:r2=1.0
30 h=(r2-r1)/x1:s2=(i2-i1)/y1:yh=y1
40 fory=ztoyh:i=i1+y*s2:r=r1
60 forx=ztox1:v=r:u=i:forn=48to33step-1:a=v*v:b=u*u
110 ifa+b<=4thenu=u*v*2+i:v=a-b+r:next
130 s=s+1:print chr$(n);chr$(n);:r=r+h:nextx:print:next

