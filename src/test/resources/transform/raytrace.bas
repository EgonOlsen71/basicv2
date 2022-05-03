0 rem *** simple raytracer by marco64  14.06.2008 *** calculating time: 30 hours ***
10 dim kx(10), ky(10), kz(10), kr(10)
11 ak=3-1
12 kx(0)=3:   ky(0)=9: kz(0)=50: kr(0)=9
13 kx(1)=-12: ky(1)=7: kz(1)=80: kr(1)=7
14 kx(2)=-3:  ky(2)=3: kz(2)=35: kr(2)=3
15 bx=0: by=5: bz=-17: be=25
16 lx=-50: ly=300: lz=50
17 gb=10
18 poke 53272,29: poke 53265,59
20 for i=1024 to 2023: poke i,15: poke 54272+i,0: next
21 for pb= 0 to 8000
22 poke 8192+pb,170
23 zw=pb and 7: y=int(pb/320)*8+zw
24 zw=int(pb/8): zx=(zw-int(zw/40)*40)*8
25 pw=0
30 for px=0 to 7
31 x=zx+px
32 zw=gb/320: rx=x*zw-gb/2: ry=-y*zw+200/2*zw: rz=be
33 zw=sqr(rx*rx+ry*ry+rz*rz): rx=rx/zw:ry=ry/zw: rz=rz/zw
34 ox=bx: oy=by: oz=bz
40 :rem  beginne raytraceing
41 gosub 90
42 on -((oy+t*ry)>0) goto 50
43 :rem schnitt mit boden
44 la=-oy/ry: sx=ox+la*rx: sy=0: sz=oz+la*rz
45 zw=(int(sx/5) and 1)+(int(sz/5) and 1): fa=(zw=1)+1
46 ox=sx: oy=sy: oz=sz: rx=ox+lx: ry=oy+ly: rz=oz+lz: gosub90
47 on -(k=-1) goto 80
48 fa=((x and 1)<>(y and 1))+1
49 goto 80
50 :rem schnitt mit himmel
51 if k=-1 then fa=0: goto 80       
60 :rem schnitt mit kugeln
61 :rem berechnung der umrandung der geschnittenen kugel, durch abstand kugelmittelpunkt zum sichtstahl
62 x1= kx(k)*rx + ky(k)*ry + kz(k)*rz:  x2= ox*rx + oy*ry + oz*rz:  x3= rx*rx + ry*ry + rz*rz
63 la=(x1-x2)/x3: f1=(ox+la*rx)-kx(k): f2=(oy+la*ry)-ky(k): f3=(oz+la*rz)-kz(k)
64 d=sqr(f1*f1 + f2*f2 + f3*f3)
65 if (kr(k)*.95<d) then fa=1: goto80



70 :rem berechnung der kugel reflektion

71 ox=ox+t*rx: oy=oy+t*ry: oz=oz+t*rz                                  :rem schnittpunkt mit der kugel ist der neue ortsvektor 

72 nx=kx(k)-ox: ny=ky(k)-oy: nz=kz(k)-oz                               :rem einfalls lot (normale) zur refektionsberechnung
  
73 zw=nx*rx+ny*ry+nz*rz: rx=rx-2*zw*nx: ry=ry-2*zw*ny: rz=rz-2*zw*nz   :rem neuer richtungsvektor ist der reflektionsstahl von der kugel

74 zw=sqr(rx*rx+ry*ry+rz*rz): rx=rx/zw: ry=ry/zw: rz=rz/zw             :rem neuen richtungsvektor vereinheitlichen (einheitsvektor)

75 goto 40                                                             :rem neuer raytrace schritt mit reflektionstahl als neue "betrachterposition" 



80 :rem pixel farbe wurde berechnet

81 pw=pw*2+fa            :rem 8 x-pixel der speicherstelle(pb) aufreihen
  
82 next px               :rem naechster x-pixel
  
83 poke 8192+pb,pw       :rem die 8 pixel auf den bildschirm scheiben

84 next pb               :rem naechste bildadresse

85 cont                  :rem endlosschleife        



90 :rem funktion: minimale entfernung des schnittpunkts sichtsstahl->kugeln

91 k=-1 : t=99999                    :rem init  k=geschnittene kugel, t= entfernung zum schnitt

92 for i=0 to ak                     :rem alle kugeln auf schnitt durchtesten
  
93 :rem schnittentfernung zur kugel mit hilfe der p,q formel

94 zw= rx*rx + ry*ry + rz*rz
95 p=( 2 * ( rx*(ox-kx(i)) + ry*(oy-ky(i)) + rz*(oz-kz(i)) ) ) / zw
96 q=( (ox-kx(i))*(ox-kx(i)) + (oy-ky(i))*(oy-ky(i)) + (oz-kz(i))*(oz-kz(i)) - kr(i)*kr(i) ) / zw

97 z1=-p/2                           :rem zwischenergebnisse
98 z2=((p*p)/4-q)

99 if z2<0 then next: return         :rem es existiert kein schnitt mit der kugel, naechste kugel testen
    


100 wu=sqr(z2)
   
101 x1=z1+wu: x2=z1-wu                                               :rem die 2loesungen der pq formel (schnittentfernungen)
 
102 z0=-((x1>.001)and(x1<t)): z1=-z0+1: k=z0*i+z1*k: t=z0*x1+z1*t    :rem if x1<t then k=i: t=x1 

103 z0=-((x2>.001)and(x2<t)): z1=-z0+1: k=z0*i+z1*k: t=z0*x2+z1*t    :rem if x2<t then k=i: t=x2 

104 next: return                                                     :rem naechste kugel testen






 

