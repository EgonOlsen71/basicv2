10 gosub 54000:xs=5:xd=10:xn=xs+int(xd/2):gs=16
15 gt=gs:ya=0:po=0:ns=gs:np=0:nc=ns:d0=0:d1=0:d2=0:df=0
20 xp=10:yp=0:sc=1024:wd=40:yh=25:eb=32:sb=207:sf=160:cb=99:gosub 50000
25 gosub 51000:gosub 63900:bs=bn:gosub 63900:gosub 56020:gosub 56500
30 rt=0:ft=0:cf=0:xf=0:la$="":tt=ti:ch=sb:gosub 60000
40 tz=ti: if tz-tt>=gs then ya=1:tt=tz
45 gs=gt:gt=ns
60 fc=0:geta$:if a$="" and ya=0 then 40
70 if a$="" then 110
75 poke652,8:poke651,2
80 if a$="s" and la$<>"s" then poke198,0:ft=rt-1:fc=1:if ft<0 then ft=3
90 if a$="a" then xf=-1
95 if a$=" " then gt=0
100 if a$="d" then xf=1
102 if a$="k" then 63700
110 la$=a$:rm=0
115 if fc=1 or xf<>0 then gt=ns-3:gosub 62000
120 if rm=1 then gosub 63950
125 xp=xp+xf:xf=0:rt=ft
130 if ya>0 then gosub 62200:if cf=1 then gosub 62100:goto 1000
135 gosub 63970
140 ya=0:goto 40
1000 if y<=-1 then 40000
1010 xp=xn:bs=bn:gosub 63900:gosub 56500:goto 40
30000 for qq=51200 to 51253:read dq:pokeqq,dq:next
30001 return
30002 data 160,3,177,155,24,109,167,2,133,251,174,168,2,144,1,232,134,252
30003 data 132,2,160,0,173,169,2,145,251,165,251,24,105,0,133,251,165,252
30004 data 105,212,133,252,173,170,2,145,251,164,2,240,4,136,76,2,200,96
40000 print "{home}{down*20}"spc(xs+xd+3)"{red}game over"
40010 poke198,0:wait198,1:run
50000 bm=49152:rem setup blocks
50005 rem long one
50010 poke bm,128:poke bm+1,129:poke bm+2,130:poke bm+3,131
50020 poke bm+4,-2*wd+130:poke bm+5,-wd+130:poke bm+6,130:poke bm+7,wd+130
50030 poke bm+8,128:poke bm+9,129:poke bm+10,130:poke bm+11,131
50040 poke bm+12,-2*wd+130:poke bm+13,-wd+130:poke bm+14,130:poke bm+15,wd+130
50050 rem l-shape left
50060 poke bm+16,128:poke bm+17,128-wd:poke bm+18,129:poke bm+19,130
50070 poke bm+20,128:poke bm+21,128-wd:poke bm+22,129-wd:poke bm+23,128+wd
50080 poke bm+24,128:poke bm+25,129:poke bm+26,130:poke bm+27,130+wd
50090 poke bm+28,129:poke bm+29,129-wd:poke bm+30,129+wd:poke bm+31,128+wd
50092 rem l-shape right
50093 poke bm+32,128:poke bm+33,129:poke bm+34,130:poke bm+35,130-wd
50094 poke bm+36,128:poke bm+37,128-wd:poke bm+38,128+wd:poke bm+39,129+wd
50095 poke bm+40,128:poke bm+41,128+wd:poke bm+42,129:poke bm+43,130
50096 poke bm+44,129:poke bm+45,129-wd:poke bm+46,128-wd:poke bm+47,129+wd
50100 rem cube
50110 poke bm+48,128:poke bm+49,129:poke bm+50,128-wd:poke bm+51,129-wd
50120 poke bm+52,128:poke bm+53,129:poke bm+54,128-wd:poke bm+55,129-wd
50130 poke bm+56,128:poke bm+57,129:poke bm+58,128-wd:poke bm+59,129-wd
50140 poke bm+60,128:poke bm+61,129:poke bm+62,128-wd:poke bm+63,129-wd
50150 rem step right
50160 poke bm+64,128:poke bm+65,129:poke bm+66,129-wd:poke bm+67,130-wd
50170 poke bm+68,128:poke bm+69,128-wd:poke bm+70,129:poke bm+71,129+wd
50180 poke bm+72,128:poke bm+73,129:poke bm+74,129-wd:poke bm+75,130-wd
50190 poke bm+76,128:poke bm+77,128-wd:poke bm+78,129:poke bm+79,129+wd
50200 rem step center
50210 poke bm+80,128:poke bm+81,129:poke bm+82,129-wd:poke bm+83,130
50220 poke bm+84,128:poke bm+85,128-wd:poke bm+86,129:poke bm+87,128+wd
50230 poke bm+88,129:poke bm+89,128-wd:poke bm+90,129-wd:poke bm+91,130-wd
50240 poke bm+92,128:poke bm+93,129:poke bm+94,129-wd:poke bm+95,129+wd
50250 rem step left
50260 poke bm+96,128-wd:poke bm+97,129-wd:poke bm+98,129:poke bm+99,130
50270 poke bm+100,128:poke bm+101,129:poke bm+102,128+wd:poke bm+103,129-wd
50280 poke bm+104,128-wd:poke bm+105,129-wd:poke bm+106,129:poke bm+107,130
50290 poke bm+108,128:poke bm+109,129:poke bm+110,128+wd:poke bm+111,129-wd
50300 poke bm+112,3:poke bm+113,6:poke bm+114,8:poke bm+115,7
50310 poke bm+116,5:poke bm+117,4:poke bm+118,2
50340 return
51000 rem playfield
51010 print chr$(147);:for i=0 to 21
51020 print spc(xs);chr$(125);spc(xd);chr$(125)
51030 next:print spc(xs);chr$(106);:fori=1toxd:printchr$(cb);:next
51040 print chr$(107):dd=xs+xd+3
51050 print chr$(19)"{down*10}"spc(dd)chr$(117);
51055 for i=0 to 6:printchr$(cb);:next:print chr$(105)
51056 print spc(dd)chr$(125)" next: "chr$(125)
51060 for i=1 to 5:print spc(dd)chr$(125)spc(7)chr$(125):next
51080 print spc(dd)chr$(106);:for i=0 to 6:printchr$(cb);:next
51090 print chr$(107):return
54000 poke 53280,0:poke 53281,0:poke 646,7
54010 printchr$(147);"mostris..."
54020 poke 650,192:poke 652,0:gosub 30000
54030 return
55000 gosub 63500:ad=ad-sc:ly=9999:hy=-9999
55010 for i=oo to oo+3:aa=peek(i)+ad
55030 y=int(aa/wd):if y<ly then ly=y
55040 if y>hy then hy=y
55050 next:yd=0
55060 for i=ly to hy
55070 k=i*wd+xs+1+sc:bc=0:for xx=k to k+xd-1
55080 if peek(xx)=sf then bc=bc+1
55090 next
55100 if bc=xd then gosub 55500:yd=yd+1:i=i-1:hy=hy-1
55110 next:gosub 56000:return
55500 for ii=i to 1 step-1:k=ii*wd+xs+1+sc
55510 f=0:for xx=k to k+xd-1
55520 g=xx-wd:j=peek(g):if j=sf then f=f+1
55530 poke54272+xx,peek(54272+g):pokexx,j:next
55540 if f=0 then return
55550 next:return
56000 if yd=0 then return
56010 po=po+int(5^yd)+(23-ly)*2:np=np+yd
56012 if np>=10 then ns=ns-2:np=0:if ns<4 then ns=4
56020 print chr$(19)"{down}"spc(xs+xd+4)"score:         {left*9}";po
56030 print spc(xs+xd+4)"speed:    {left*4}";int((nc-ns)/2)
56040 return
56500 t1=yp:t2=xp:t4=ch
56510 yp=15:xp=xs+xd+6:ch=eb:gosub 60000
56520 t3=bs:bs=bn:ch=sb:gosub 60000
56530 bs=t3:yp=t1:xp=t2:ch=t4:return
60000 gosub 63500
60001 cv=peek(bm+112+bs)
60005 poke 155,oo-bm and 255:poke 156, oo/256
60006 poke 679,ad and 255:poke 680, ad/256
60007 poke 681,ch:poke 682,cv:sys 51200:return
60008 rem old basic copy code, slightly more flickery:
60010 rem for i=oo to oo+3:aa=peek(i)+ad
60030 rem poke aa+54272,cv:poke aa,ch
60040 rem next:return
61000 gosub 63500:ad=ad+wd*ya
61010 for i=oo to oo+3
61050 a2=peek(peek(i)+ad):if a2=sf or a2=cb-32 then cf=1:return
61060 next:cf=0:return
62000 gosub 63600
62010 for i=oo to oo+3
62030 a2=peek(peek(i)+ad):if a2<>eb and a2<>sb then ft=rt:xf=0:return
62040 next:rm=1:return
62100 cf=0:yp=yp-ya:gosub 63000:gosub 55000:return
62200 gosub 63950:gosub 61000:yp=yp+ya:return
63000 ch=sf:gosub 60000:df=0:return
63500 ad=yp*wd+xp+sc-128:oo=bm+bs*16+rt*4:return
63600 ad=yp*wd+xp+xf+sc-128:oo=bm+bs*16+ft*4:return
63700 poke 651,4:poke 652,16:poke 650,0:poke198,0
63710 printchr$(147);"goodbye!":end
63900 bn=int(rnd(0)*7):yp=-1:rt=0:ft=0:xf=0:return
63950 if df=0 then ch=eb:df=1:d0=xp:d1=yp:d2=rt
63960 return
63970 if df=0 then return
63980 ad=d1*wd+d0+sc-128:oo=bm+bs*16+d2*4:gosub 60001
63990 ch=sb:gosub 60000:df=0
63995 return


