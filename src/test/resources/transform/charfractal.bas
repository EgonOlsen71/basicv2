5 print chr$(147)
7 ti$="000000"
10 x1=38:y1=22
20 i1=-1.0:i2=1.0:r1=-2.0:r2=1.0
30 s1=(r2-r1)/x1:s2=(i2-i1)/y1
40 for y=0 to y1
50 i3=i1+s2*y
60 for x=0 to x1
70 r3=r1+s1*x:z1=r3:z2=i3
80 for n=0 to 15
90 a=z1*z1:b=z2*z2
100 if a+b>4.0 goto 130
110 z2=2*z1*z2+i3:z1=a-b+r3
120 next n
130 print chr$(48-n);
140 next x
150 print
160 next y
10000 print"zeit: ";ti$;
10010 geta$:if a$="" then 10010
