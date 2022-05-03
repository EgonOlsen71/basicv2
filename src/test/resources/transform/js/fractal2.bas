5 print chr$(147)
7 ti$="000000"
8 dimx$(16),z$(11),v,u,a,b,i,r,h,a$,e
10 x1=38:y1=22:e=15:v=48:forx=.toe+1:x$(x)=chr$(v-x):next:i1=-1:i2=1:r1=-2:r2=1
30 h=(r2-r1)/x1:s2=(i2-i1)/y1:yh=y1/2
60 fory=.toyh:i=i1+y*s2:r=r1:a$="":forx=.tox1:v=r:u=i
110 forn=.toe:a=v*v:b=u*u:ifa+b<=4thenu=u*v*2+i:v=a-b+r:next
120 a$=a$+x$(n):r=r+h:nextx:printa$:z$(yh-y)=a$:next
130 fory=1toyh:printz$(y):next
10000 print"zeit: ";ti$;