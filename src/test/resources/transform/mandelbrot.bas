10 wd=30:ht=20:mx=16:t$="000000"
20 poke 53281,0:poke 646,7:print chr$(147)"calculating mandelbrot fractal..."
40 for py=0 to ht-1
50 yy=py/0.4/ht-1
60 for px=0to wd-1
70 xx=px/0.3/wd-2.2:xq=0:yq=0:x=0:y=0:it=0
80 if (it>=mx) or (xq+yq>=4) then 150
90 y=x*y*2+yy
100 x=xq-yq+xx
110 xq=x*x:yq=y*y
120 it=it+1
130 goto 80
150 ad=40*(py+1)+px+4:poke1024+ad,160:poke55296+ad,mx-it
160 next:next
170 print"{down*20}finished in ";ti$