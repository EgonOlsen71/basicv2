10 poke56,32:poke55,0:clr:fora=828to908:readb:pokea,b:next
20 data 162,2,160,4,208,4,162,4,160,2,142,101,3,142,127,3,140,103,3
30 data 140,129,3,169,0,133,2,133,4,169,216,133,3,169,200,133,5,162,3
40 data 160,0,177,2,145,4,136,208,249,230,3,230,5,202,16,242,169,4,133
50 data 3,169,204,133,5,162,3,160,0,177,2,145,4,136,208,249,230,3,230
60 data 5,202,16,242,96
100 rem ------ mandelzoom-64 ------
120 sm=7:ct=40:rem determines detail
125 rem define region examined below
130 xl=-2.2:xr=.58:yb=-1.25
137 dx=(xr-xl):yt=yb+dx*.9
140 dimco(15):fori=0to15:readco(i):next
150 gosub360:m=159/dx:b1=-m*xl
160 mm=199/(yb-yt):bb=-mm*yt
170 data 1,3,4,2,8,7,13,5,14,6,4,15,14,6,4,15:rem <-- color code schedule
180 for x0=xl to xr step(xr-xl)/159
190 for  y=yt to yb step(yb-yt)/199
200 a=x0*x0-y*y+x0:b=2*x0*y+y:c=0
210 r=a*a-b*b+x0:i=2*a*b+y:c=c+1:s=usr(r*r+i*i):a=r:b=i:ifs<smthenifc<ctthen210
220 x1=int(m*x0+b1+.5)
222 y1=int(mm*y+bb+.5):ifc<6thenco=co((c/15-int(c/15))*15):goto240
225 ifc<ctthenco=1:goto240
230 ifc=ctthenco=0
240 gosub440:next y,x0
250 rem save picture if 's' is pressed
260 geta$:ifa$<>"s"then260
261 sys828:poke53272,21:poke53265,27:poke53270,200
262 print"{clear}{down*2}enter filename (up to 12 char)":inputf$:f$="m-"+left$(f$,12)
270 poke53272,29:poke53265,59:poke53270,216:sys834:k=8192:e=16191:gosub300
280 f$=t$+"s":k=1023:e=2023:gosub300
290 f$=t$+"c":k=55296:e=56295:gosub300:goto260
300 f$="0:"+f$:open15,8,15,"s"+f$:close15:t$=f$
310 zk=peek(53)+256*peek(54)-len(t$):poke782,zk/256:poke781,zk-peek(782)*256
320 poke780,len(t$):sys65469:poke780,1:poke781,8:poke782,1:sys65466
330 poke254,k/256:poke253,k-peek(254)*256:poke780,253:k=e+1:poke782,k/256
340 poke781,k-peek(782)*256:sys65496:t$=right$(t$,len(t$)-2):return
350 rem----- set color graphics mode and clear memory to be used -----
360 print"{clear}":fori=49152to49248:readj:pokei,j:next:poke53280,0:poke53281,0
370 poke251,0:poke252,32:poke253,63:poke254,63:poke49169,0:sys49166
380 sys49152:poke785,39:poke786,192
390 base=8192:poke53272,peek(53272)or8
400 poke53265,peek(53265)or32:poke53270,peek(53270)or16
410 poke251,0:poke252,216:poke253,231:poke254,219:sys49166:return
420 rem ---- plot x1,y1,co ------------
430 rem  0<=x1<160  0<=y1<200 0<=co<15
440 if co=0 then return:rem use screen color code in 53281
450 x=2*x1+1:ro=int(y1/8):ch=int(x/8):ln=y1and7:by=ba+ro*320+8*ch+ln
460 rem --- set color and pixel ---
470 sb=1024+ro*40+ch:rem screen byte
480 se=peek(sb):s9=seand240
490 rem use hi nybble of sb if ok
500 if(s9=0ors9=co*16)then poke sb,seor(co*16):goto580
510 rem use lo nybble of sb if ok
520 s8=seand15:if(s8=0ors8=co)then poke sb,seorco:x=x-1:goto580
530 rem use color mem. if it is ok
540 cm=sb+54272:rem color nybble addr.
550 c1=peek(cm):c3=c1and15
560 if(c3=0orc3=co)thenpokecm,c1 orco:gosub580:x=x-1
570 rem too many colors this char.
580 bi=7-(xand7):pokeby,peek(by)or(2^bi):return
590 data 169,0,133,251,133,253,169,4,133,252,169,8,133,254,160,0,169,27,145,251
600 data 230,251,208,2,230,252,165,251,197,253,208,240,165,252,197,254,208,234
610 data 96,32,43,188,240,52,16,3,76,72,178,32,199,187,165,97,56,233,129,8,74
620 data 24,105,1,40,144,2,105,127,133,97,169,4,133,103,32,202,187,169,92,160,0
630 data 32,15,187,169,87,160,0,32,103,184,198,97,198,103,208,233,96
