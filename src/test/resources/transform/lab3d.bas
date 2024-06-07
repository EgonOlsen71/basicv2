10 wl%=45:hl%=32:jy%=100
20 ju%=1:jd%=2:jl%=4:jr%=8:jf%=16
30 dr%=0:dd%=1:dl%=2:du%=3
40 dim wd%(19):wd%(0)=3:wd%(1)=2:wd%(2)=2:wd%(3)=2
60 wd%(4)=1:wd%(5)=1:wd%(6)=1:wd%(7)=1:wd%(8)=1
70 dim lo%(3),ro%(3),ao%(3)
80 lo%(dr%) = -40:ro%(dr%) =  40:ao%(dr%) =   1
90 lo%(dd%) =   1:ro%(dd%) =  -1:ao%(dd%) =  40
100 lo%(dl%) =  40:ro%(dl%) = -40:ao%(dl%) =  -1
110 lo%(du%) =  -1:ro%(du%) =   1:ao%(du%) = -40
120 dim ax%(3),ay%(3)
130 ax%(dr%) =  8: ay%(dr%) =  0
140 ax%(dd%) =  0: ay%(dd%) =  8
150 ax%(dl%) = -8: ay%(dl%) =  0
160 ax%(du%) =  0: ay%(du%) = -8
170 fx%=0:fy%=0:di%=0:po=0
180 c$=""
190 poke 56576,(peek(56576) and 252) or 1
200 poke 648,132
210 poke 53280,0:poke 53281,0
230 poke 53272, peek(53272) or 14
240 gosub 10000
250 for i=0 to 103:read b%:poke 47368+i,b%:next i
260 for i=0 to 255:read b%:poke 32768+i,b%:next i
265 dim mv(24):for i=0 to 24:read v:mv(i)=v:next i
270 poke 54286,255: poke 54287, 255:poke 54290,128
280 poke 646,14:print chr$(147);
290 poke 53270, peek(53270) or 16
300 poke 53282,14: poke 53283,15
310 gosub 11000
320 goto 8000

8000 rem game loop
8010 j%=peek(56320):pj%=0:tm%=0
8020 if (j%=pj%) then if tm%<>jy% then 8200
8030 if j%<>pj% then tm%=0:pj%=j%
8040 if (j% and ju%)<>0 then 8070
8050 if peek(po+ao%(di%))<>wl% then po=po+ao%(di%):gosub 10200:gosub 14000
8060 goto 8200
8070 if (j% and jd%)<>0 then 8100
8080 if peek(po-ao%(di%))<>wl% then po=po-ao%(di%):gosub 10400:gosub 14000
8090 goto 8200
8100 if (j% and jr%)<>0 then 8150
8110 di%=(di%+1) and 3
8120 poke 34808,di%
8130 gosub 14000
8140 if (peek(56320) and jr%)=0 then 8140
8150 if (j% and jl%)<>0 then 8200
8160 di%=(di%-1) and 3
8170 poke 34808,di%
8180 gosub 14000
8190 if (peek(56320) and jl%)=0 then 8190
8200 if tm%<jd% then tm%=tm%+1
8210 get c$:if c$=" " then print chr$(147);:run
8220 goto 8000 

10000 rem copy charset
10010 poke 56334, peek(56334) and 254
10020 poke 1, peek(1) and 251
10040 for p=47104 to 47104+2047:poke p,peek(p+8192):next
10050 poke 1, peek(1) or 4
10060 poke 56334, peek(56334) or 1:return  

10200 rem advance arrow
10210 fx%=fx%+ax%(di%)
10220 fy%=fy%+ay%(di%)
10230 poke 53249,fy%
10240 poke 53248,fx% and 255
10250 poke 53264,-(fx%>255)
10260 return

10400 rem retract arrow
10410 fx%=fx%-ax%(di%)
10420 fy%=fy%-ay%(di%)
10430 gosub 10230:return

11000 rem init
11010 gosub 12000
11020 fx%=208:fy%=74
11030 po=33935
11040 di%=dd%:if peek(po+1)=hl% then di%=dr%
11050 poke 53248,fx%:poke 53249,fy%:poke 34808,di%:poke 53269,1
11060 poke 53287,7
11070 gosub 14000
11080 return

12000 rem generate labyrinth
12010 dim d%(3),d2%(3):a=0:b=0:i%=0:x%=0:p=0:k%=0
12020 d%(0)=2:d%(1)=-80:d%(2)=-2:d%(3)=80
12030 d2%(0)=1:d2%(1)=-40:d2%(2)=-1:d2%(3)=40
12040 p=33894:a=p+41:i%=1
12050 pa=p:v%=wl%:c%=17:gosub 13000
12060 pa=p+21504:v%=9:c%=17:gosub 13000
12070 p=p+40:i%=i%+1:if i%<22 then 12050
12080 c%=0:poke a+21504,0:poke a,4
12090 k%=peek(54299) and 3:b=a+d%(k%):c%=peek(b)
12100 if c%<>wl% then 12150
12110 poke b+21504,0:poke b,k%:poke a+d2%(k%),hl%:a=b
12120 k%=peek(54299) and 3:b=a+d%(k%):c%=peek(b)
12130 goto 12100
12150 x%=k%:k%=(k%+1) and 3
12160 if k%=x% then 12250
12170 b=a+d%(k%):c%=peek(b)
12180 if c%<>wl% then k%=(k%+1) and 3:goto 12200
12190 poke b+21504,0:poke b,k%:poke a+d2%(k%),hl%:a=b:goto 12250
12200 goto 12160
12250 if k%<>x% then 12300
12260 k%=peek(a):poke a,hl%
12270 if k%<>4 then a=a-d%(k%)
12300 if k%<>4 then 12090
12310 return

13000 rem memset, addr in pa, val in v%, count in c%
13040 kk%=0
13050 poke pa,v%:kk%=kk%+1:pa=pa+1
13060 if kk%<c% then 13050
13070 return

14000 rem draw labyrinth
14010 k%=0:z%=0:p=po
14020 if z%>=10 then 14200
14030 if peek(p)=wl% then iq%=z%:cq%=45:gosub 15000:goto 14200
14040 k%=wd%(z%)
14050 if k%<1 then k%=1
14070 lh%=0:if peek(p+lo%(di%))=hl% then lh%=wd%(z%)
14080 rh%=0:if peek(p+ro%(di%))=hl% then rh%=wd%(z%)
14090 if (z%>=10) or (k%<1) then 14160
14100 iq%=z%:gosub 16000
14110 if rh%>0 then rh%=rh%-1
14120 if lh%>0 then lh%=lh%-1
14130 z%=z%+1
14140 k%=k%-1
14150 goto 14090
14160 p=p+ao%(di%)
14170 goto 14020
14200 if z%>=10 then iq%=z%:cq%=40:gosub 15000
14210 return

15000 rem drawcap
15020 pj=mv(2+iq%)+iq%
15030 lj%=21-iq%-iq%
15040 kq%=1:c%=lj%:v%=cq%
15050 pa=pj:gosub 13000
15060 kq%=kq%+1:if kq%>lj% then return
15070 pj=pj+40:goto 15050

16000 rem draw strip
16020 pq=mv(iq%+2)+iq%+1
16030 lq%=19-iq%-iq%
16040 pa=pq:v%=34:c%=lq%:gosub 13000:pq=pa
16050 if rh% then gosub 16200:goto 16080
16060 gosub 16400
16080 pq=pq-lq%:pa=pq:c%=lq%:v%=34:gosub 13000
16090 pq=pq-1:if lh% then gosub 16500:goto 16110
16100 gosub 16700
16110 return

16200 rem draw strip sub 1
16210 poke pq,39:pq=pq+40:kq%=2
16220 if kq%>rh% then 16240
16225 poke pq,40:pq=pq+40:kq%=kq%+1
16230 goto 16220
16240 kq%=rh%:eq%=lq%-rh%+1
16250 if kq%>eq% then 16270
16255 poke pq,34:pq=pq+40:kq%=kq%+1
16260 goto 16250
16270 kq%=2
16280 if kq%>rh% then 16300
16285 poke pq,40:pq=pq+40:kq%=kq%+1
16290 goto 16280
16300 poke pq,42:return

16400 rem draw strip sub 2
16410 poke pq,35:pq=pq+40
16420 kq%=1
16430 poke pq,36:pq=pq+40:kq%=kq%+1:if kq%<=lq% then 16430
16450 poke pq,37:return

16500 rem draw strip sub 3
16510 poke pq,43:pq=pq-40:kq%=2
16520 if kq%>lh% then 16540
16525 poke pq,40:pq=pq-40:kq%=kq%+1
16530 goto 16520
16540 kq%=lh%:eq%=lq%-lh%+1
16550 if kq%>eq% then 16570
16555 poke pq,34:pq=pq-40:kq%=kq%+1
16560 goto 16550
16570 kq%=2
16580 if kq%>lh% then 16600
16585 poke pq,40:pq=pq-40:kq%=kq%+1
16590 goto 16580
16600 poke pq,44:return

16700 rem draw strip sub 4
16710 poke pq,38:pq=pq-40
16720 kq%=1
16730 poke pq,36:pq=pq-40:kq%=kq%+1:if kq%<=lq% then 16730
16750 poke pq,33:return

60000 rem chars
60010 data 102,89,86,89,86,85,85,85,102,153,102,153,102,153,102,153
60020 data 101,153,101,149,85,149,85,85,85,85,85,85,85,85,85,85
60030 data 85,85,85,149,101,149,101,153,85,85,86,85,86,89,102,89
60040 data 102,155,109,151,109,183,221,119,221,119,221,119,221,119,221,119
60050 data 0,0,0,0,0,0,0,0,221,183,93,183,109,155,101,155
60060 data 221,119,222,121,214,121,230,153,230,89,230,121,222,117,222,119
60070 data 170,170,170,170,170,170,170,170

60100 rem sprites
60110 data 0,0,0,8,0,0,12,0,0,126,0,0,126,0,0,12
60120 data 0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0
60130 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
60140 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
60150 data 0,0,0,24,0,0,24,0,0,24,0,0,126,0,0,60
60160 data 0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0
60170 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
60180 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
60190 data 0,0,0,16,0,0,48,0,0,126,0,0,126,0,0,48
60200 data 0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0
60210 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
60220 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
60230 data 0,0,0,24,0,0,60,0,0,126,0,0,24,0,0,24
60240 data 0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0
60250 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
60260 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

60300 rem memvid lookup
60310 data 33792, 33832, 33872, 33912, 33952, 33992
60320 data 34032, 34072, 34112, 34152, 34192, 34232
60330 data 34272, 34312, 34352, 34392, 34432, 34472 
60340 data 34512, 34552, 34592, 34632, 34672, 34712
60350 data 34752