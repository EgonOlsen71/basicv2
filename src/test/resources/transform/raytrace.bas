0 rem *** simple raytracer by marco64  14.06.2008 ***
10 dim kx(10), ky(10), kz(10), kr(10)
11 ak=3-1:ti$="000000"
12 kx(0)=3:ky(0)=9:kz(0)=50:kr(0)=9
13 kx(1)=-12:ky(1)=7:kz(1)=80:kr(1)=7
14 kx(2)=-3:ky(2)=3:kz(2)=35:kr(2)=3
15 bx=0:by=5:bz=-17:be=25
16 lx=-50:ly=300:lz=50
17 gb=10:ga=16384
18 gosub 1000
19 for i=ga to ga+8000:poke i,255:next
20 for i=24576 to 25575:poke i,15:next
21 for pb=0 to 8000
22 poke ga+pb,170
23 zw=pb and 7:y=int(pb/320)*8+zw
24 zw=int(pb/8):zx=(zw-int(zw/40)*40)*8
25 pw=0
30 for px=0 to 7
31 x=zx+px
32 zw=gb/320:rx=x*zw-gb/2:ry=-y*zw+200/2*zw:rz=be
33 zw=sqr(rx*rx+ry*ry+rz*rz):rx=rx/zw:ry=ry/zw:rz=rz/zw
34 ox=bx:oy=by:oz=bz
40 rem
41 gosub 90
42 on -((oy+t*ry)>0) goto 50
43 rem
44 la=-oy/ry:sx=ox+la*rx:sy=0:sz=oz+la*rz
45 zw=(int(sx/5) and 1)+(int(sz/5) and 1):fa=(zw=1)+1
46 ox=sx:oy=sy:oz=sz:rx=ox+lx:ry=oy+ly:rz=oz+lz:gosub90
47 on -(k=-1) goto 80
48 fa=((x and 1)<>(y and 1))+1
49 goto 80
50 rem
51 if k=-1 then fa=0:goto 80       
60 rem
62 x1=kx(k)*rx+ky(k)*ry+kz(k)*rz:x2=ox*rx+oy*ry+oz*rz:x3=rx*rx+ry*ry+rz*rz
63 la=(x1-x2)/x3:f1=(ox+la*rx)-kx(k):f2=(oy+la*ry)-ky(k):f3=(oz+la*rz)-kz(k)
64 d=sqr(f1*f1+f2*f2+f3*f3)
65 if (kr(k)*.95<d) then fa=1:goto80
70 rem
71 ox=ox+t*rx:oy=oy+t*ry:oz=oz+t*rz
72 nx=kx(k)-ox:ny=ky(k)-oy:nz=kz(k)-oz
73 zw=nx*rx+ny*ry+nz*rz:rx=rx-2*zw*nx:ry=ry-2*zw*ny:rz=rz-2*zw*nz
74 zw=sqr(rx*rx+ry*ry+rz*rz):rx=rx/zw:ry=ry/zw:rz=rz/zw
75 goto 40
80 rem
81 pw=pw*2+fa
82 next px
83 poke ga+pb,pw
84 next pb
85 gosub 2000:print chr$(147);ti$:end     
90 rem
91 k=-1:t=99999
92 for i=0 to ak
93 rem
94 zw= rx*rx + ry*ry + rz*rz:o3=oy-ky(i):o4=oz-kz(i)
95 o5=ox-kx(i):p=(2*(rx*o5+ry*o3+rz*o4))/zw
96 q=((ox-kx(i))*o5+o3*o3+o4*o4-kr(i)*kr(i))/zw
97 z1=-p/2
98 z2=((p*p)/4-q)
99 if z2<0 then next:return 
100 wu=sqr(z2)
101 x1=z1+wu:x2=z1-wu
102 z0=-((x1>.001)and(x1<t)):z1=-z0+1:k=z0*i+z1*k:t=z0*x1+z1*t
103 z0=-((x2>.001)and(x2<t)):z1=-z0+1:k=z0*i+z1*k:t=z0*x2+z1*t
104 next:return
1000 poke 56576,(peek(56576) and 252) or 2
1010 poke 53272,(peek(53272) and (255-8)) or 0
1020 poke 53272,(peek(53272) and 15) or 128
1030 poke 53265,peek(53265) or 32
1050 return
2000 poke 56576,(peek(56576) and 252) or 3
2010 poke 53272, (peek(53272) and (255-8)) or 1
2020 poke 53272,(peek(53272) and 15) or 16
2030 poke 53265,peek(53265) and 223
2040 return







 

