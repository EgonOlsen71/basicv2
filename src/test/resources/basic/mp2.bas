1 ft=ti
10 rem  
20 rem  astrophysical speed test : mp2
30 rem  
40 rem   author        : paul salanitri
50 rem  revision      : 2.02
60 rem   revision date : 2 november 1996
70 rem   notes         : for unix systems - define use_time
80 rem                   will now loop until timer ticks over (on pcs too)
90 rem  
100 rem  modifications :
110 rem            2.03 : test timing overhead
120 rem            2.02 : fix spelling of astrophysical!
130 rem            2.01 : first release - tested on sun and sequent (mods)
140 rem            1.00 : source code lost!!!!
150 rem  *********************************************************************/
160 rem version "2.03"
170 rem calc_moon((double)2450000.0 + (double)count);
200 mathpi=3.141592653589793
210 dt=180.0/mathpi
220 au=1.0
300 rem meta-charset 1
400 sl=0
410 print"calculating solution..."
420 rem meta-timing
425 rem fori=1to140:jd=2450000.0:gosub1000:next
430 count=1400
440 fori=1tocount:jd=2450000.0:gosub1000:next
450 rem meta-timing count
460 sl=1: rem print a solution now for checking!
470 jd=2450000.0:gosub1000
900 print(ti-ft)/60"seconds"
910 printi/((ti-ft)/60)"iter per sec"
999 end
1000 rem  the new harmonic solution to the position of the moon 
1010 jd=jd-2415020.0: rem  move to jan 0.5 1900 
1020 t=(jd/36525.0): t2=t*t:
1030 m1=2.732158213e1: m2=3.652596407e2:
1040 m3=2.755455094e1: m4=2.953058868e1:
1050 m5=2.721222039e1: m6=6.798363307e3:
1060 q=jd: m1=q/m1: m2=q/m2:
1070 m3=q/m3: m4=q/m4: m5=q/m5: m6=q/m6:
1080 m1=360.0*(m1-int(m1))
1090 m2=360.0*(m2-int(m2))
1100 m3=360.0*(m3-int(m3))
1110 m4=360.0*(m4-int(m4))
1120 m5=360.0*(m5-int(m5))
1130 m6=360.0*(m6-int(m6))
1140 ml=2.70434164e2+m1-(1.133e-3-1.9e-6*t)*t2:
1150 ms=3.58475833e2+m2-(1.5e-4+3.3e-6*t)*t2:
1160 md=2.96104608e2+m3+(9.192e-3+1.44e-5*t)*t2:
1170 me=3.50737486e2+m4-(1.436e-3-1.9e-6*t)*t2:
1180 mf=11.250889+m5-(3.211e-3+3e-7*t)*t2:
1190 na=2.59183275e2-m6+(2.078e-3+2.2e-6*t)*t2:
1200 a=(51.2+20.2*t)/dt: s1=sin(a): s2=sin(na/dt):
1210 b=346.56+(132.87-9.1731e-3*t)*t:
1220 s3=3.964e-3*sin(b/dt):
1230 c=(na+275.05-2.3*t)/dt:  s4=sin(c):
1240 ml=ml+2.33e-4*s1+s3+1.964e-3*s2:
1250 ms=ms-1.778e-3*s1:
1260 md=md+8.17e-4*s1+s3+2.541e-3*s2:
1270 mf=mf+s3-2.4691e-2*s2-4.328e-3*s4:
1280 me=me+2.011e-3*s1+s3+1.964e-3*s2:
1290 e=1-(2.495e-3+7.52e-6*t)*t: e2=e*e:
1300 ml=ml/dt: ms=ms/dt: na=na/dt:
1310 me=me/dt: mf=mf/dt: md=md/dt:
1320 l=6.28875*sin(md)+1.274018*sin(2.0*me-md):
1330 l=l+6.58309e-1*sin(2.0*me)+2.13616e-1*sin(2.0*md):
1340 l=l-e*1.85596e-1*sin(ms)-1.14336e-1*sin(2.0*mf):
1350 l=l+5.8793e-2*sin(2.0*(me-md)):
1360 l=l+5.7212e-2*e*sin(2.0*me-ms-md)+5.332e-2*sin(2.0*me+md):
1370 l=l+4.5874e-2*e*sin(2.0*me-ms)+4.1024e-2*e*sin(md-ms):
1380 l=l-3.4718e-2*sin(me)-e*3.0465e-2*sin(ms+md):
1390 l=l+1.5326e-2*sin(2.0*(me-mf))-1.2528e-2*sin(2.0*mf+md):
1400 l=l-1.098e-2*sin(2.0*mf-md)+1.0674e-2*sin(4.0*me-md):
1410 l=l+1.0034e-2*sin(3.0*md)+8.548e-3*sin(4.0*me-2.0*md):
1420 l=l-e*7.91e-3*sin(ms-md+2.0*me)-e*6.783e-3*sin(2.0*me+ms):
1430 l=l+5.162e-3*sin(md-me)+e*5e-3*sin(ms+me):
1440 l=l+3.862e-3*sin(4.0*me)+e*4.049e-3*sin(md-ms+2.0*me):
1450 l=l+3.996e-3*sin(2.0*(md+me))+3.665e-3*sin(2.0*me-3.0*md):
1460 l=l+e*2.695e-3*sin(2.0*md-ms)+2.602e-3*sin(md-2.0*(mf+me)):
1470 l=l+e*2.396e-3*sin(2.0*(me-md)-ms)-2.349e-3*sin(md+me):
1480 l=l+e2*2.249e-3*sin(2.0*(me-ms))-e*2.125e-3*sin(2.0*md+ms):
1490 l=l-e2*2.079e-3*sin(2.0*ms)+e2*2.059e-3*sin(2.0*(me-ms)-md):
1500 l=l-1.773e-3*sin(md+2.0*(me-mf))-1.595e-3*sin(2.0*(mf+me)):
1510 l=l+e*1.22e-3*sin(4.0*me-ms-md)-1.11e-3*sin(2.0*(md+mf)):
1520 l=l+8.92e-4*sin(md-3.0*me)-e*8.11e-4*sin(ms+md+2.0*me):
1530 l=l+e*7.61e-4*sin(4.0*me-ms-2.0*md):
1540 l=l+e2*7.04e-4*sin(md-2.0*(ms+me)):
1550 l=l+e*6.93e-4*sin(ms-2.0*(md-me)):
1560 l=l+e*5.98e-4*sin(2.0*(me-mf)-ms):
1570 l=l+5.5e-4*sin(md+4.0*me)+5.38e-4*sin(4.0*md):
1580 l=l+e*5.21e-4*sin(4.0*me-ms)+4.86e-4*sin(2.0*md-me):
1590 l=l+e2*7.17e-4*sin(md-2.0*ms):
1600 mm=ml+l/dt: tp=6.283185308:
1700 ifmm<0.0thenmm=mm+tp:goto1700
1710 ifmm>tpthenmm=mm-tp:goto1700
1800 g=5.128189*sin(mf)+2.80606e-1*sin(md+mf):
1810 g=g+2.77693e-1*sin(md-mf)+1.73238e-1*sin(2.0*me-mf):
1820 g=g+5.5413e-2*sin(2.0*me+mf-md)+4.6272e-2*sin(2.0*me-mf-md):
1830 g=g+3.2573e-2*sin(2.0*me+mf)+1.7198e-2*sin(2.0*md+mf):
1840 g=g+9.267e-3*sin(2.0*me+md-mf)+8.823e-3*sin(2.0*md-mf):
1850 g=g+e*8.247e-3*sin(2.0*me-ms-mf)+4.323e-3*sin(2.0*(me-md)-mf):
1860 g=g+4.2e-3*sin(2.0*me+mf+md)+e*3.372e-3*sin(mf-ms-2.0*me):
1870 g=g+e*2.472e-3*sin(2.0*me+mf-ms-md):
1880 g=g+e*2.222e-3*sin(2.0*me+mf-ms):
1890 g=g+e*2.072e-3*sin(2.0*me-mf-ms-md):
1900 g=g+e*1.877e-3*sin(mf-ms+md)+1.828e-3*sin(4.0*me-mf-md):
1910 g=g-e*1.803e-3*sin(mf+ms)-1.75e-3*sin(3.0*mf):
1920 g=g+e*1.57e-3*sin(md-ms-mf)-1.487e-3*sin(mf+me):
1930 g=g-e*1.481e-3*sin(mf+ms+md)+e*1.417e-3*sin(mf-ms-md):
1940 g=g+e*1.35e-3*sin(mf-ms)+1.33e-3*sin(mf-me):
1950 g=g+1.106e-3*sin(mf+3.0*md)+1.02e-3*sin(4.0*me-mf):
1960 g=g+8.33e-4*sin(mf+4.0*me-md)+7.81e-4*sin(md-3.0*mf):
1970 g=g+6.7e-4*sin(mf+4.0*me-2.0*md)+6.06e-4*sin(2.0*me-3.0*mf):
1980 g=g+5.97e-4*sin(2.0*(me+md)-mf):
1990 g=g+e*4.92e-4*sin(2.0*me+md-ms-mf)+4.5e-4*sin(2.0*(md-me)-mf):
2000 g=g+4.39e-4*sin(3.0*md-mf)+4.23e-4*sin(mf+2.0*(me+md)):
2010 g=g+4.22e-4*sin(2.0*me-mf-3.0*md)-e*3.67e-4*sin(ms+mf+2.0*me-md):
2020 g=g-e*3.53e-4*sin(ms+mf+2.0*me)+3.31e-4*sin(mf+4.0*me):
2030 g=g+e*3.17e-4*sin(2.0*me+mf-ms+md):
2040 g=g+e2*3.06e-4*sin(2.0*(me-ms)-mf)-2.83e-4*sin(md+3.0*mf):
2050 w1=4.664e-4*cos(na):  w2=7.54e-5*cos(c):
2060 bm=g/dt*(1.0-w1-w2):
2070 pm=9.50724e-1+5.1818e-2*cos(md)+9.531e-3*cos(2.0*me-md):
2080 pm=pm+7.843e-3*cos(2.0*me)+2.824e-3*cos(2.0*md):
2090 pm=pm+8.57e-4*cos(2.0*me+md)+e*5.33e-4*cos(2.0*me-ms):
2100 pm=pm+e*4.01e-4*cos(2.0*me-md-ms):
2110 pm=pm+e*3.2e-4*cos(md-ms)-2.71e-4*cos(me):
2120 pm=pm-e*2.64e-4*cos(ms+md)-1.98e-4*cos(2.0*mf-md):
2130 pm=pm+1.73e-4*cos(3.0*md)+1.67e-4*cos(4.0*me-md):
2140 pm=pm-e*1.11e-4*cos(ms)+1.03e-4*cos(4.0*me-2.0*md):
2150 pm=pm-8.4e-5*cos(2.0*md-2.0*me)-e*8.3e-5*cos(2.0*me+ms):
2160 pm=pm+7.9e-5*cos(2.0*me+2.0*md)+7.2e-5*cos(4.0*me):
2170 pm=pm+e*6.4e-5*cos(2.0*me-ms+md)-e*6.3e-5*cos(2.0*me+ms-md):
2180 pm=pm+e*4.1e-5*cos(ms+me)+e*3.5e-5*cos(2.0*md-ms):
2190 pm=pm-3.3e-5*cos(3.0*md-2.0*me)-3e-5*cos(md+me):
2200 pm=pm-2.9e-5*cos(2.0*(mf-me))-e*2.9e-5*cos(2.0*md+ms):
2210 pm=pm+e2*2.6e-5*cos(2.0*(me-ms))-2.3e-5*cos(2.0*(mf-me)+md):
2220 pm=pm+e*1.9e-5*cos(4.0*me-ms-md):
2230 pm=pm/dt:
2240 r=6378.14/sin(pm)/au:
2250 ifsl=0then2300
2260 print"solution for jd=";jd+2415020.0
2270 print"  mm=";mm
2280 print"  bm=";bm
2290 print"  pm=";pm
2300 rem continue
2990 return