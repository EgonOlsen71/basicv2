10 dim sp(256)
20 gosub 10000
30 x=7:y=8:t$="welcome to cbmbasic snake!":gosub20000
40 x=15:y=10:t$="controls:":gosub20000
50 poke 1523,137:poke 1562,138:poke 1564,140:poke 1603,139
60 x=14:y=16:t$="press a key":gosub20000
70 geta$:ifa$=""then70

100 gosub 10000
110 sl = 4:hx = 19:hy = 10:dx = 1:dy = 0
120 sd = 16:hi = 0
130 fori=0tosl:sp(i)=415+i:poke1439+i,209:next
140 gosub 3000
150 gosub 2000
160 if hi = 1 then gosub 1000 
170 goto 100

1000 x=16:y=10:t$="game over":gosub20000
1010 x=15:y=11:t$="press a key":gosub20000
1020 geta$:ifa$=""then1020
1030 return

2000 poke 1024+sp(0), 32
2010 gosub 2800
2020 for i=0 to sl-1:sp(i) = sp(i+1):next
2030 hx = hx+dx
2040 hy = hy+dy
2050 sp(sl) = hx + 40 * hy
2060 gosub 3200
2070 if hi = 1 then return
2080 gosub 3300
2090 for i=1 to sd:gosub 2500:next
2100 gosub 2600
2110 goto 2000

2500 if peek(53266) < 200 then 2500
2510 return

2600 poke 1024+sp(sl), 209:return

2800 geta$:ifa$=""thenreturn
2810 ifa$="i"then2850
2820 ifa$="j"then2900
2830 ifa$="k"then2950
2840 ifa$="l"then2970
2845 return
2850 if dy = 1 then return
2860 dx = 0:dy = -1:return
2900 if dx = 1 then return
2910 dx = -1:dy = 0:return
2950 if dy = -1 then return
2960 dx = 0:dy = 1:return
2970 if dx = -1 then return
2980 dx = 1:dy = 0:return

3000 fl = rnd(0)*1000
3010 if fl < 0 then fl = fl * -1
3020 if fl > 999 then 3000
3030 if peek(1024+fl) <> 32 then 3000
3040 poke 1024+fl, 42:return

3200 if hx = 40 then hi = 1
3210 if hx = -1 then hi = 1
3220 if hy = 0 then hi = 1
3230 if hy = 25 then hi = 1
3240 if peek(1024+hx + 40*hy) = 209 then hi = 1
3250 return 

3300 if peek(1024+hx + 40*hy) = 32 then return
3310 sl = sl + 1:sp(sl) = hx + 40*hy
3320 x=7:y=0:t$="    ":gosub20000
3330 x=7:y=0:t$=str$(sl):gosub20000
3332 poke1031,peek(1031)+128
3340 poke1032,peek(1032)+128:poke1033,peek(1033)+128:poke1034,peek(1034)+128
3350 sd = 16-sl/16	
3360 x=37:y=0:t$="   ":gosub20000
3370 x=37:y=0:t$=str$(int(17-sd)):gosub20000
3380 poke 1061, peek(1061)+128:poke 1062, peek(1062)+128:poke 1063, peek(1063)+128
3390 gosub 3000
3400 return

10000 poke 53280,5
10010 poke 53281,0:poke646,5
10020 for i=1024 to 2023:pokei,32:next
10025 for i=55296 to 56295:pokei, 5:next
10030 x=0:y=0:t$="length: 4     cbmbasic snake   speed: 1":gosub20000
10040 for i=1024 to 1063:poke i, peek(i)+128:next i
10050 return
20000 poke 780,0:poke 781,y:poke 782,x:sys 65520:printt$:return