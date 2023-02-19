10 print chr$(147);"{control-q}{lgrn}micro compiler"
15 rem  von vic cortes
20 g=0:gosub  1780: goto  590
30 rem  .. erste variable
40 gosub  400: poke  a,169: poke  a+1,l:k=2
50 if  v then  poke  a,173: poke  a+2,h:k=3
60 a=a+k: poke  a,174: poke  a+1,c: poke  a+2,h
70 if  v=0 then  poke  a,162: poke  a+1,h
80 a=a+k: return 
90 rem  .. ausdruck
100 p=0: if  peek(u)=194 then  u=u+2:p=1
110 gosub  40
120 if  u>912 then  print "{ctrl 9}overflow":er=er+1: return 
130 o=0:b=peek(u): if  b=173 then  280
140 if  b=172 then  280
150 if  b=170 then  o=109: poke  a,24:a=a+1
160 if  b=171 then  o=237: poke  a,56:a=a+1
170 if  b=175 then  o=45
180 if  b=176 then  o=13
190 if  o=0 then  320
200 u=u+1: gosub  400: poke  a,o-4: poke  a+1,l:k=2
210 if  v then  poke  a,o: poke  a+2,h:k=3
220 a=a+k: poke  a,168: poke  a+1,138:a=a+2
230 poke  a,o: poke  a+1,c: poke  a+2,h
240 if  v=0 then  poke  a,o-4: poke  a+1,h
250 a=a+k: poke  a,170: poke  a+1,152:a=a+2
260 goto  120
270 rem  .. mul/div
280 poke  a,133: poke  a+1,97: poke  a+2,134: poke  a+3,98:a=a+4:u=u+1: gosub  40
290 g=1: poke  a,24: if  b=173 then  poke  a,56
300 d=s+3: gosub  570: poke  a+1,32: poke  a+2,l: poke  a+3,h:a=a+4: goto  120
310 rem  .. peek(ausdruck)
320 if  p=0 then  return 
330 poke  a,133: poke  a+1,34
340 poke  a+2,134: poke  a+3,35
350 poke  a+4,162: poke  a+5,0
360 poke  a+6,160: poke  a+7,0
370 poke  a+8,177: poke  a+9,34
380 a=a+10:u=u+1:p=0: goto  120
390 rem  .. find
400 n=0:v=0: if  peek(u)<65 then  420
410 if  peek(u)<91 then  490
420 t=0: if  peek(u)=170 then  u=u+1: goto  440
430 if  peek(u)=171 then  u=u+1:t=1
440 if  peek(u)<48 or  peek(u)>57 then  print "{ctrl 9}error bei";u-827;peek(u):er=er+1
450 if  peek(u)>47 and  peek(u)<58 then  n=n*10+peek(u)-48:u=u+1: goto  450
460 if  t=0 then  d=n: goto  570
470 d=65536-n: goto  570
480 rem  .. h/l
490 v=peek(u):d=v
500 u=u+1:t=peek(u): if  t>90 then  560
510 if  t<32 then  560
520 if  t=59 then  560
530 if  t=44 then  560
540 if  t=41 then  560
550 if  t>35 then  500
560 d=d-65:d=d+d+680
570 h%=d/256:h=h%:l=d-h*256:c=(l+1) and  255: return 
580 rem  .. source lesen
590 get #2,a1$,a2$:ti$="000000"
600 get #2,l1$,l2$:t=asc(l1$+z$)+asc(l2$+z$): if  t=0 then  1920
610 get #2,s1$,s2$:t=asc(s1$+z$)+asc(s2$+z$)*256
620 s(m)=t:l(m)=a:m=m+1: print "{left}";t;
630 if  f then  t=a-f: poke  f+1,t-2: poke  f+7,t-8: poke  f+9,t-10:f=0
640 j=828: if  peek(653) then  640
650 get #2,b$: if  st then  1920
660 b=asc(b$+z$): poke  j,b: if  q or  b<>32 then  j=j+1
670 if  b=34 then  q= not  q
680 if  b<128 or  q then  print  b$;
690 poke  780,b: poke  15,0
700 if  b>127 and b<204 and q=0 then  poke 782,255: poke 768,185: poke 783,128: sys 42775
710 poke  768,139: if  q then  650
720 if  b<32 then print : gosub  770: goto  600
730 if  b=167 then  gosub  770: goto  640
740 if  b=58 then  j=j-1: gosub  770: goto  640
750 goto  650
760 rem  .. befehl
770 b=peek(828):u=829: poke  j,0: poke  j+1,0
780 if  b=136 then  940
790 if  b=128 or  b=142 or  b=144 then  poke  a,96:a=a+1: return 
800 if  b=158 then  1680
810 if  b=139 then  1040
820 if  b=153 then  1170
830 if  b=151 then  1720
840 if  b=129 then  1510
850 if  b=130 then  1650
860 if  b=143 then  return 
870 if  b=137 then  o=76: goto  1480
880 if  b=141 then  o=32: goto  1480
890 if  b<48 or  b>90 then  920
900 if  b>64 then  950
910 if  b<58 then  u=828:o=76: goto  1480
920 print "{ctrl 9}error";u-827;peek(u):er=er+1: return 
930 rem  .. v=ausdruck
940 for  i=828 to  842: poke  i,peek(i+1): next 
950 u=828: if  peek(u)<65 then  920
960 if  peek(u)>90 then  920
970 u=u+1: if  peek(u)<>178 then  920
980 u=u+1: gosub  100:d=peek(828)
990 gosub  560
1000 poke  a,141: poke  a+1,l: poke  a+2,h
1010 poke  a+3,142: poke  a+4,c: poke  a+5,h
1020 a=a+6: return 
1030 rem  .. if/then
1040 gosub  100:w=peek(u): if  w<177 then  920
1050 if  w>179 then  920
1060 poke  a+0,133: poke  a+1,34: poke  a+2,134: poke  a+3,35:a=a+4:u=u+1
1070 if  w=179 and  peek(u)=177 then  w=180:u=u+1
1080 if  w=177 and  peek(u)=179 then  w=180:u=u+1
1090 gosub  100: poke  a,228: poke  a+1,35: poke  a+2,240: poke  a+3,4:a=a+4:f=a
1100 poke  a+3,6: poke  a+4,197: poke  a+5,34
1110 poke  a,240: poke  a+2,208: poke  a+8,240
1120 if  w=178 then  poke  a,208: poke  a+8,208
1130 if  w=179 then  poke  a,144: poke  a+2,176
1140 if  w=177 then  poke  a,176: poke  a+2,144
1150 poke  a+6,peek(a):a=a+10: return 
1160 rem  .. print
1170 w=peek(u): if  w<32 then  1450
1180 if  w=59 and  peek(u+1)<32 then  return 
1190 if  w=59 then  u=u+1: goto  1170
1200 if  w=199 then  1300: rem  chr$
1210 if  w=34 then  1340: rem "string"
1220 rem  .. print ausdruck
1230 poke  a,169: poke  a+1,29: poke  a+2,32
1240 poke  a+3,210: poke  a+4,255:a=a+5
1250 gosub  100: poke  a,134: poke  a+1,34
1260 poke  a+2,170: poke  a+3,165: poke  a+4,34
1270 poke  a+5,32: poke  a+6,205: poke  a+7,189
1280 a=a+8: goto  1170
1290 rem  .. print chr$(ausdruck)
1300 u=u+1: if  peek(u)<>40 then  920
1310 u=u+1: gosub  100: poke  a,32: poke  a+1,210
1320 poke  a+2,255:a=a+3:u=u+1: goto  1170
1330 rem  .. print "string"
1340 d=a+10: gosub  570: poke  a,169
1350 poke  a+1,l: poke  a+2,160: poke  a+3,h
1360 poke  a+4,32: poke  a+5,30: poke  a+6,171
1370 poke  a+7,24: poke  a+8,144: poke  a+9,0
1380 w=a+9:a=a+10:i=0
1390 i=i+1:u=u+1: if  u>912 then  1430
1400 if  peek(u)=34 then  1430
1410 if  peek(u)=0 then  1430
1420 poke  a,peek(u):a=a+1: goto  1390
1430 poke  w,i: poke  a,0:a=a+1
1440 u=u+1: goto  1170
1450 poke  a,169: poke  a+1,13: poke  a+2,32
1460 poke  a+3,210: poke  a+4,255:a=a+5: return 
1470 rem  .. gosub/goto
1480 poke  a,o: poke  a+1,0: poke  a+2,0: gosub  400
1490 r=r+1:n(r)=n:a(r)=a:a=a+3: return 
1500 rem  .. for
1510 u=831: gosub  100
1520 lp=a: poke  a,76:a=a+3
1530 hu=u:u=829: gosub  40:u=hu+1
1540 poke  a,133: poke  a+1,34: poke  a+2,134: poke  a+3,35:a=a+4
1550 hf=f:w=177: gosub  1090:f=hf
1560 poke  a-1,3: poke  a-3,2: poke  a-9,11
1570 poke  a-2,176: poke  a-4,240
1580 xa=a: poke  a,76:a=a+3
1590 if  peek(u)<>169 then  poke  a,169: poke  a+1,1: poke  a+2,162: poke  a+3,0:a=a+4: goto  1610
1600 u=u+1: gosub  100
1610 u=828:b=170: gosub  150
1620 d=a: gosub  570: poke  lp+1,l: poke  lp+2,h
1630 d=peek(829): gosub  990: return 
1640 rem  .. next
1650 d=lp+3: gosub  570: poke  a,76: poke  a+1,l: poke  a+2,h:a=a+3:d=a: gosub  570
1660 poke  xa+1,l: poke  xa+2,h: return 
1670 rem  .. sys
1680 gosub  100: poke  a,133: poke  a+1,20
1690 poke  a+2,134: poke  a+3,21
1700 poke  a+4,32: poke  a+5,54: poke  a+6,225:a=a+7: return 
1710 rem  .. poke
1720 gosub  100: poke  a,133: poke  a+1,34
1730 poke  a+2,134: poke  a+3,35:a=a+4
1740 if  peek(u)<>44 then  920
1750 u=u+1: gosub  100: poke  a,160: poke  a+1,0
1760 poke  a+2,145: poke  a+3,34:a=a+4: return 
1770 rem  .. init
1780 dim  n(63),a(63),s(255),l(255),t$(75)
1790 a=0:b=0:u=0:i=0:j=0:k=0:v=0:d=0
1800 c=0:h=0:l=0:w=0
1810 poke  53281,0: poke  53280,0: poke  646,15
1820 s$="test.comp":s=49152:z$=chr$(0)
1830 input  "{control-q}name des quelltextes";s$
1840 restore : if  s$="*" then  end 
1850 input "startadresse";s: print :a=s+6
1860 d=a: gosub  570: poke  s,76: poke  s+1,l: poke  s+2,h
1870 poke  s+3,76: poke  s+4,116: poke  s+5,164
1880 open  15,8,15: open  2,8,2,"0:"+s$
1890 input# 15,e1,e2$,e3,e4: if  e1=0 then  return 
1900 print  e1;e2$;e3;e4
1910 rem  .. ende
1920 close  2: close  15
1930 if  r=0 then  1980
1940 for  i=1 to  r:n=n(i):w=a(i):d=0
1950 for  t=0 to  m: if  s(t)=n then  d=l(t):t=m
1960 next  t: gosub  570: poke  w+1,l
1970 poke  w+2,h: next  i
1980 if  g=0 then  2030
1990 d=a: gosub  570: poke  s+4,l: poke  s+5,h
2000 read  d: if  d<0 then  2030
2010 poke  a,d:a=a+1
2020 goto  2000
2030 poke  a,0:e=a+1
2040 print "{control-q}errors";er
2050 print "adressbereich";s;"{left}";e*-1
2060 print s$;" kompiliert, zeit:";ti$
2070 print "{control-q}1=save 2=exec 3=comp 4=quit": poke  198,0
2080 get  x$: if  x$="1" then  2170
2090 if  x$="2" then  2140
2100 if  x$="3" then  gosub  1820: goto  590
2110 if  x$="4" then  end 
2130 goto  2080
2140 for  i=680 to  731: poke  i,0: next 
2150 sys  s: goto  2070
2160 rem  .. save
2170 n$=left$(s$,13)+".ml": input  "{control-q}name";n$
2180 open  15,8,15,"s0:"+n$: close  15:t$=n$
2190 for i=1 to len(t$):poke 831+i,asc(mid$(t$,i,1)):next
2200 poke  782,3: poke  781,64: poke  780,len(t$): sys  65469: poke  780,1
2210 poke  781,8: poke  782,1: sys  65466
2220 poke  254,s/256: poke  253,s-peek(254)*256: poke  780,253: poke  782,e/256
2230 poke  781,e-peek(782)*256: sys  65496
2240 if (peek(783) and  1) or (st and  191) then  print  "disk error"
2250 goto  2070
2260 rem  .. mul/div data
2270 data  133,99,134,100,162,0,134,101
2280 data  134,102,160,16,144,34,6,97
2290 data  38,98,38,101,38,102,56,165
2300 data  101,229,99,170,165,102,229,100
2310 data  144,6,134,101,133,102,230,97
2320 data  136,208,227,165,97,166,98,96
2330 data  70,102,102,101,102,98,102,97
2340 data  136,48,240,144,243,24,165,101
2350 data  101,99,133,101,165,102,101,100
2360 data  133,102,24,144,227,-1
