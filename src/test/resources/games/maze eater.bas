2 for a=192*64 to 210*64+64: poke a,0: next : gosub 26000 : dim bb$(11):ga=0:b$(1)="{ctrl 3}0000000 ....":b$(2)="{ctrl 4}0000000 ....":b$(3)="{ctrl 7}0000000 ....":b$(4)="{ct up arrow}0000000 ....":b$(5)="{gray}0000000 ....":s$="0000000":ti$="000000":xp=272:hi=0:print chr$(8)chr$(142)
10 poke 53280,0: poke 53281,0:v=53248: poke v+21,0:le=1:hh=205:do=0:print"{clr}{white}please wait...."
20 for i=53248 to 53248+15:pokei,0:next
42 poke v+29,4: poke v+23,4:c=1479:c1=1228:fr=191:a$="":sc=0: poke 2040,200: poke 2041,205: poke 2042,192: poke 650,255:se=0
100 co=0:li=3:at=54277:vo=54296:wa=54276:h=54273:su=54278: poke v+21,0: poke v+40,2: poke v+23,0: poke v+29,0: if ga=1 then 226
200 poke 56334,peek(56334) and 254: poke 1,peek(1) and 251: for i=14336 to 14847: poke i,peek(i+38912): next : poke 1,peek(1) or 4: poke 56334,peek(56334) or 1
226 if ga=0 then gosub 1230
230 gosub 30000:gosub 10000: poke v+29,4:poke v+23,4:poke v+17,peek(v+17) and 255-16: poke h,0: poke v+16,0: poke 53272,31:x=138:y=133:x1=44:y1=80: poke v+28,2: poke v+37,1:x6=123:y6=120: poke v+4,x6: poke v+5,y6: poke v+32,12: poke v+33,12: print "{clr}":gosub 810
270 poke v+42,2: print "{control-s}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{white}" tab( 30)hi"{red}": gosub 41000: print "{control-s}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}" tab( 31)a$
272 gosub 28000:jo=0:lt=ti:af=0:ll=le:if ll>4.95 then ll=4.95
274 poke v+17,peek(v+17) or 16
275 ld=ll/1.95:ls=ll/4.5:wz=10:poke v+21,3:poke v+40,2
280 jv=peek(56320):jv=15-(jv and 15):if jv=0 then jv=jo
290 ct=peek(v+30)
360 xo=x:yo=y:co=c:as=201
365 if (jv=4) or ((jv and 4)=4 and jo<3) then x=x-8:c=c-1:as=202:goto 395
370 if (jv=8) or ((jv and 8)=8 and jo<3) then:x=x+8:c=c+1:as=200:goto 395
380 if (jv=1) or ((jv and 1)=1 and jo>3) then y=y-8:c=c-40:as=202:goto 395
390 if (jv=2) or ((jv and 2)=2 and jo>3) then y=y+8:c=c+40:as=200
395 cp=peek(c):if cp=42 then mv=0:x=xo:y=yo:c=co
435 if co=c and jv<>jo and jo>0 then jv=jo:jo=0:goto 360
440 jo=jv:if c=co then as=201:lt=0
442 rem move enemy towards player
443 wz=wz-1:if wz>0 then 510
444 ll=ld:if c=co then ll=ls
445 if en>0 then ll=-ll
446 dx=int(x-x1):dy=int(y-y1)
448 x1=x1+ll*sgn(dx)
450 y1=y1+ll*sgn(dy)
451 hh=208:if abs(dy)>abs(dx) then 454
452 if x1<x then hh=206
453 goto 460
454 if y1>y then hh=205:goto 460
456 hh=207
460 poke 2041,hh:gosub 42000
510 if do=xp then ee=0:en=0:le=le+1:gosub 43000:gosub 770: gosub 810: goto 270: rem 272 = total pill count
545 ss=0:if cp=32 then goto 580:rem nothing
560 if cp=81 then ee=1:en=120:sc=sc+40: for a=0 to 100 step 30: poke h,a*1.2: for b=0 to 50: next b,a:rem power pill
570 if cp=46 or cp=81 then poke c,32:sc=sc+10:gosub 28000:ss=1:do=do+1:if do=100 and fp=0 then poke 2042,fr:poke v+21,7:rem pill
580 ct=peek(v+30):gosub 29000:poke v+2,x1: poke v+3,y1:gosub 1130
581 if ee=0 then 632
585 if en=0 then poke v+40,2
590 if ee=1 then en=en-1
600 if en<0 then en=0:ee=0:goto 630
610 if ee=1 then poke v+40,en+1
620 if en>0 then poke h+7,en/4:goto 632
630 if en<1 then poke h+7,0
632 if ti-lt<8 then 635
634 af=(af+1) and 1:lt=ti
635 if af=1 then as=201
636 poke 2040,as:goto 280
650 if fr=192 then poke v+41,2:a$="{ctrl 7}{193}"
660 if fr=193 then poke v+41,2:a$="{ctrl 7}{211}"
670 if fr=194 then poke v+41,9:a$="{ctrl 7}{216}"
680 if fr=195 then poke v+41,5:a$="{ctrl 7}{218}"
690 if fr=196 then poke v+41,7:a$="{ctrl 7}{215}"
700 return 
710 li=li-1: if li=0 then 20000
711 gosub 41000:x=138:y=133:x1=44:y1=80:c=1479:c1=1228: goto 1170
770 x=138:y=133:x1=44:y1=80:c=1479:c1=1228: do=0:return 
790 poke h,30: for a=0 to 7: next a: poke h,0: return 
800 if co=c then return
802 for a=0 to 8: next a:return: rem similar delay to when playing a munch sound
810 poke 646,0: poke h+7,0:en=0:fr=fr+1:fp=0: print "{control-s}******************************": print "{ctrl 1}*{ctrl 7}{209}{yellow}..........................{ctrl 7}{209}{ctrl 1}*": poke 646,0: print "*{yellow}.{ctrl 1}***{yellow}.{ctrl 1}******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}***{yellow}.{ctrl 1}*": print "{ctrl 1}*{yellow}.{ctrl 1}***{yellow}.{ctrl 1}******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}***{yellow}.{ctrl 1}*"
860 print "*{yellow}.{ctrl 1}***{yellow}.{ctrl 1}******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}***{yellow}.{ctrl 1}*": print "{ctrl 1}*{yellow}.{ctrl 1}***{yellow}....................{ctrl 1}***{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}*******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}**{yellow}.{ctrl 1}******{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}*******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}**{yellow}.{ctrl 1}******{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}*******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}**{yellow}.{ctrl 1}******{yellow}.{ctrl 1}*"
910 print "*{yellow}.{ctrl 1}****{yellow}....{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}**{yellow}....{ctrl 1}***{yellow}.{ctrl 1}*": print "*{yellow}......{ctrl 1}**{yellow}.............{ctrl 1}**{yellow}.....{ctrl 1}*": print "*{yellow}......{ctrl 1}*******{yellow}...{ctrl 1}*******{yellow}.....{ctrl 1}*": print "*{yellow}......{ctrl 1}*******{yellow}...{ctrl 1}*******{yellow}.....{ctrl 1}*": print "*{yellow}......{ctrl 1}**{yellow}.............{ctrl 1}**{yellow}.....{ctrl 1}*"
960 print "*{yellow}.{ctrl 1}****{yellow}....{ctrl 1}***********{yellow}....{ctrl 1}***{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}*******{yellow}.{ctrl 1}***********{yellow}.{ctrl 1}******{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}*******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}**{yellow}.{ctrl 1}******{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}*******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}**{yellow}.{ctrl 1}******{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}***{yellow}....................{ctrl 1}***{yellow}.{ctrl 1}*"
1010 print "*{yellow}.{ctrl 1}***{yellow}.{ctrl 1}*********{yellow}.{ctrl 1}********{yellow}.{ctrl 1}***{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}***{yellow}.{ctrl 1}******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}***{yellow}.{ctrl 1}*": print "*{yellow}.{ctrl 1}***{yellow}.{ctrl 1}******{yellow}.{ctrl 1}**{yellow}.{ctrl 1}**{yellow}.{ctrl 1}*****{yellow}.{ctrl 1}***{yellow}.{ctrl 1}*": print "{ctrl 1}*{ctrl 7}{209}{yellow}..........................{ctrl 7}{209}{ctrl 1}*": print "{ctrl 1}******************************{light blue}"
1060 print "{control-s}" tab( 31)"{yellow}level";le"{red}":print "{control-s}{control-q}{control-q}" tab( 31)"{yellow}score": print "{control-s}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}" tab( 31)"{yellow}high": print "{control-s}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}" tab( 31)"{yellow}lives":  print "{control-s}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}" tab( 31)"        ": if fr=197 then fr=192
1110 gosub 770:gosub 650: return
1130 ct=peek(v+30):if (ct and 1)=0 then return
1132 if (ct and 4)=4 then sc=sc+500: gosub 28000: poke v+21,3:fp=1: goto 1200: rem collected cherry
1135 if (ct and 2)<>2 then return: rem no collision with ghost
1136 if (abs(x-x1)>24) or (abs(y-y1)>24) then return: rem additional bb check
1140 wz=20:if en>0 then sc=sc+100:gosub 28000:x1=44:y1=80:c1=1228: goto 1229: rem caught ghost
1150 jo=0:goto 710: rem caught by ghost
1170 poke wa,17: for a=0 to 200 step 30: poke h,a: for b=0 to 50: next b,a: for a=200 to 0 step -30: poke h,a: for b=0 to 50: next b,a: poke h,0: poke v+30,0: poke wa,33: return 
1200 for a=0 to 100 step 30: poke h,a: for b=0 to 10: next b,a: for a=100 to 0 step -30: poke h,a: for b=0 to 10: next b,a: poke h,0: poke v+30,0: return 
1229 for a=0 to 15: for b=0 to 5: poke h+7,a*b: next b,a: poke h,0: en=0: poke v+2,x1: poke v+3,y1:ct=peek(v+30): return 
1230 for d=200 to 202: for a=0 to 62: read b: poke d*64+a,b: next a,d: data 0,0,0,0,0,0,0,0,0,0,248,0,3,254,0,7,254,0,14,124,0,30,120,0,31,240,0,31,224,0,31,248,0,31,254,0,15,255,0,7,255,0,3,254,0,0,248, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1280 data  0,0,0,0,0,0,0,0,0,0,248,0,3,254,0,7,255,0,15,255,128,31,255,192,31, 255,192,31,255,192,31,255,192,31,255,192,15,255,128,7,255,0,3,254,0,0, 248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1330 data  0,0,0,0,0,0,0,0,0,0,248,0,3,254,0,3,255,0,0,243,128,0,115,192,0,63, 192,0,31,192,0,127,192,1,255,192,3,255,128,3,255,0,3,254,0,0,240, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0: for d=192 to 196: for a=0 to 7: read b: poke d*64+25+a*3,b: next a,d
1370 data  48,8,8,20,36,102,255,102, 12,24,126,215,237,126,44,24, 60,66,255,129,129,255,66,60, 102,255,219,255,102,60,36,102, 255,90,102,36,60,24,24,24: for a=0 to 7: poke 14336+42*8+a,255: next : for a=0 to 7: read b: poke 14336+46*8+a,b: next
1480 data  0,0,24,60,60,24,0,0: for a=0 to 7: poke 14336+32*8+a,0: next : for a=0 to 7: read b: poke 14336+81*8+a,b: next : data 60,60,126,255,255,126,60,60: for a=0 to 7: read b: poke 14336+65*8+a,b: next : data  48,8,8,20,36,102,255,102: for a=0 to 7: read b: poke 14336+83*8+a,b: next : data  12,24,126,215,237,126,44,24
1560 for a=0 to 7: read b: poke 14336+88*8+a,b: next : data  60,66,255,129,129,255,66,60: for a=0 to 7: read b: poke 14336+90*8+a,b: next : data  102,255,219,255,102,60,36,102: for a=0 to 7: read b: poke 14336+87*8+a,b: next : data  255,90,102,36,60,24,24,24: for d=205 to 208: for a=0 to 62: read b: poke d*64+a,b: next a,d
1630 data  2,128,0,10,160,0,42,168,0,170,170,0,158,182,0,158,182,0,150,150,0,150, 150,0,170,170,0,170,170,0,170,170,0,170,170,0,170,170,0,170,170,0,136, 136,0,136,136,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1670 data  2,128,0,10,160,0,42,168,0,170,170,0,150,150,0,158,158,0,158,158,0,150, 150,0,170,170,0,170,170,0,170,170,0,170,170,0,170,170,0,170,170,0,136, 136,0,136,136,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1710 data  2,128,0,10,160,0,42,168,0,170,170,0,150,150,0,150,150,0,158,182,0,158, 182,0,170,170,0,170,170,0,170,170,0,170,170,0,170,170,0,170,170,0,136, 136,0,136,136,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1750 data  2,128,0,10,160,0,42,168,0,170,170,0,150,150,0,182,182,0,182,182,0,150, 150,0,170,170,0,170,170,0,170,170,0,170,170,0,170,170,0,170,170,0,136, 136,0,136,136,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0: for a=0 to 10: read b$:bb$(a)=b$: next 
1776 data e,n,t,e,r, ,l,e,v,e,l: return 
10000 nu=0:lt=ti:af=0:poke v+16,0:x=15:y=108: poke v,x: poke v+1,y: poke v+21,1: poke 2040,200: poke v+39,1:gg=1340
10010 for a=0 to 255 step 8:gg=gg+1: poke v,a: poke gg,32: gosub 25000: poke h,25
10020 if (peek(56320)and 16)=0 then poke v+21,0:return
10030 for b=0 to 10: next b: poke h,0: next a: poke v+16,1: for a=0 to 60 step 8:gg=gg+1: poke v,a: poke gg,32: gosub 25000: poke h,25
10040 if (peek(56320)and 16)=0 then poke v+21,0:return
10060 for b=0 to 10: next b: poke h,0: next a: poke v+16,0: poke v,0:y=y+8: poke v+1,y:nu=nu+1: if nu=7 then nu=0: goto 10080
10070 goto 10010
10080 y=50:x=22: poke v,x: print "{control-s}": poke 2040,200: for a=0 to 10:y=y+8: print chr$(158)bb$(a): poke v+1,y:gosub 25000: 
10085 if (peek(56320)and 16)=0 then poke v+21,0:return
10086 for b=0 to 100: next b,a:gg=1464: print "{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{5}oh dear!!": for b=0 to 400: next b: print "{sh cursor down}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}         ": for a=0 to 10:y=y-8: poke gg,32:gg=gg-40: poke v+1,y: gosub 25000
10090 if (peek(56320)and 16)=0 then poke v+21,0:return
10100 for b=0 to 100: next b,a: for a=0 to 10:y=y+8:gg=gg+40: poke v+1,y: gosub 25000:for b=0 to 100: next b,a
10120 for a=0 to 11:x=x+8:gg=gg+1: poke v,x: gosub 25000:for b=0 to 100: next b,a : poke 2040,200: print "{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}{ctrl ;}";:y=y+8: poke v+1,y: for a=0 to 5:x=x+8: print bb$(a);: poke v,x: gosub 25000
10122 if (peek(56320)and 16)=0 then poke v+21,0:return
10125 for b=0 to 100: next b,a: print " ";: for a=6 to 10:x=x+8: print bb$(a);: poke v,x: gosub 25000
10130 if (peek(56320)and 16)=0 then poke v+21,0:return
10140 for b=0 to 100: next b,a: poke v,182: poke v+1,90: poke v+2,142: poke v+3,90: poke v+28,2: poke v+40,2: poke v+23,3:poke v+29,3: poke v+21,3: poke v+37,1:  print
10150 print "{ctrl 8}{control-q}press f1 to change level": print "use joystick in port 2": 
10160 print "{ctrl 3}{control-q}{control-q}guide fartman around the maze": print "{pink}whilst eating dots and power pods"
10165 hh=205:poke 2041,hh:poke 2040,200
10200 print "{white}{control-s}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}" tab( 24)le: get d$: if d$="{f1}" then le=le+1
10230 if le>5 then le=1
10235 poke 2041,hh
10240 if peek(197)=60 or (peek(56320)and 16)=0 then poke v+21,0:return 
10241 if rnd(1)<0.1 then hh=int(rnd(0)*4)+205
10250 goto 10200
20000 gosub 27000:poke v+21,0: poke vo,0: poke v+32,0: poke v+33,0:s$=str$(sc):n=len(s$):s$=left$("000000",8-n)+right$(s$,n-1): poke 53272,21:k=0: for i=1 to 5: if sc>val(left$(b$(i),7)) then k=i:i=5
20040 next i: if k=0 then 20100
20060 print "{ctrl 7}{clr}{control-q}{control-q}       you are in the top 5{control-q}{control-q}": poke 198,0
20070 print "{ctrl 3}       your name";: input i$: if len(i$)>10 or i$="" then i$="nobody"
20080 for i=4 to k step -1:b$(i+1)=b$(i): next :b$(k)=s$+" "+i$
20100 print "{clr}{ctrl 7}       maze eater heroes{control-q}{control-q}{control-q}": for i=1 to 5: print "{control-q}       "i;b$(i): next i: if sc>hi then hi=sc
20120 gosub 40000
20130 ga=1: goto 10
25000 poke 2040,200+af
25010 if ti-lt<8 then return
25020 af=(af +1) and 1
25030 lt=ti:return
26000 for a=54272 to 54296: poke a,0: next:return
27000 print "{control-s}{white}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}"tab(11)"game over"
27010 poke wa,17: for a=0 to 200 step 20: poke h,a: for b=0 to 120: next b,a: for a=200 to 0 step -20: poke h,a: for b=0 to 120: next b,a: poke h,0: poke v+30,0: poke wa,33: return 
28000 print "{control-s}{control-q}{control-q}{control-q}{control-q}{white}" tab(30)sc"{red}":return
29000 if ss=1 then poke h,30
29005 if x<>xo then for xx=xo to x step sgn(x-xo):poke v,xx:next:poke h,0:for b=0 to 23*(1-ss):next:return
29010 if y<>yo then for yy=yo to y step sgn(y-yo):poke v+1,yy:next::poke h,0:for b=0 to 20*(1-ss):next:return
29020 poke h,0:poke v,x:poke v+1,y:return
30000 print "{clr}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}": print "{ctrl 8}{215}{215}{215}{215}{215} {215}{215}{215}{215} {215}{215}{215}{215} {215}{215}{215}{215}": print "{ctrl 3}{215}{sh space}{215}{sh space}{215}{sh space}{215}{sh space} {215}{sh space}{sh space}{sh space}{sh space}{215}{sh space}{215}": print "{pink}{215}{sh space}{215}{sh space}{215}{sh space}{215}{sh space}{sh space}{215}{sh space}{sh space}{sh space}{215}{sh space}{sh space}{215}": print "{ctrl 7}{215}{sh space}{215}{sh space}{215}{sh space}{215}{215}{215}{215}{sh space}{sh space}{215}{sh space}{sh space}{sh space}{215}{215}{215}  {ctrl 8}e a t e r - {white}hd": print "{ct up arrow}{215}{sh space}{215}{sh space}{215}{sh space}{215}{sh space}{sh space}{215}{sh space}{215}{sh space}{sh space}{sh space}{sh space}{215}": print "{dark gray}{215}{sh space}{215}{sh space}{215}{sh space}{215}{sh space}{sh space}{215}{sh space}{215}{215}{215}{215}{sh space}{215}{215}{215}{215}"
30010 print "{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}{cm y}"
30020 for i=0 to 1000
30030 get k$:if k$=" " or (peek(56320) and 16)=0 then 30050
30040 next
30050 gosub 40010:poke at,32: poke at+7,32: poke su,255: poke su+7,255: poke wa,33: poke wa+7,17: poke vo,15:return
40000 get k$:if k$<>" " and (peek(56320) and 16)<>0 then 40000
40010 get k$:if k$=" " or (peek(56320) and 16)=0 then 40010
40020 return
41000 print "{control-s}{control-s}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{white}" tab( 30)li"{red}"
41010 return
42000 if en<=0 then return
42005 if x1<25 then x1=25:goto 42020
42010 if x1>245 then x1=245
42020 if y1<50 then y1=50:return
42030 if y1>225 then y1=225
42040 return
43000 print "{control-s}{white}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}{control-q}"tab(10)"next  level"
43010 poke h+7,0:poke wa,17: for a=0 to 100 step 10: poke h,a: for b=0 to 120: next b,a: for a=100 to 0 step -10: poke h,a: for b=0 to 120: next b,a: poke h,0: poke v+30,0: poke wa,33: return 

