100 ?CHR$(147):rem screen clear 
102 poke 53280,16:rem border to black
104 SCR=1024:rem screen memory base address
105 LDR%=45:rem char of ladder
108 KR%=81:rem target (T)
109 SK%=65:rem chaser (S)
110 FAL%=102:rem wall
111 AIR%=32:rem
117 DIMLP%(14)
122 DIMAR%(4):rem envir.(0..3)//0:UP,1:DN,2:RG,3:LF,4:to write back
130 DIMS3AR(4):rem chaser envir.
134 DIMLADS%(24,10):rem storing the ladders position for every Y
136 TX%=27:TY%=23:rem target coordinates init
146 T1XD%=0:T2YD%=0:rem target move
156 XS%=0:YS%=3:rem chaser coordinates init
166 S1XD%=0:S2YD%=0
176 LK%=80:rem nearest ladder distance to Target on chaser's level(Y)
186 LT%=0:rem ladder dist. calc. from array DIMLADS()
600 rem *****************************
601 rem *** SID INIT
602 forN=54272TO54296:pokeL,O:nextN
909 rem *** map drawing from data *** (PRINT is much faster)
910 forI=1to200:readA%:readB%:pokeA%,B%:nextI
920 rem *****************************
930 rem *** STORING/DRAWING LADDERS FROM DATA LINES
935 rem *** LP:LadderPosition(scr memory),FK:ladder step pos.
950 forJ=0to14:readLP%(J)
955   FK=LP%(J)
960   forK=0to5
980     FK=FK-40
990     pokeFK,LDR%:rem drawing l.step, FK:step positions
995   nextK
999 nextJ
1000 gosub2770:rem reading ladders to array
1002 rem ****************************
1004 rem *** MAIN CYCLE         
1080 pokeSCR+(TY%*40)+TX%,KR%
1500 forL=0to1:L=-1
1505    gosub2300:rem calc S movement based on envir.& T pos.
1510    gosub2630:rem proc S movement
1550    GETK$
1552    UP=0:DN=0:RT=0:LT=0
1553    ifK$=""goto2070:rem no button pressed 
1555    ifK$=chr$(145)thenUP=-1:rem up 0
1556    ifK$=chr$(17) thenDN=-1:rem down 1
1558    ifK$=chr$(29) thenRT=-1:rem right 2
1560    ifK$=chr$(157)thenLT=-1:rem left 3
1565    gosub2125:rem calc. T movement 
1570    gosub2695:rem proc T movement
2070 nextL
2110 rem ****************************
2120 rem *** T IRANY MEGHATAROZAS //TARGET MOVEMENT
2125 T1XD%=0:T2YD%=0 
2140 if(UP)AND(AR%(0)=LDR%)thenT2YD%=-1:goto2210:rem AR%(4)=AR%(0):rem fel
2155 if(DN)AND(AR%(1)=LDR%)thenT2YD%= 1:goto2210:rem AR%(4)=AR%(1):rem le 
2170 if(RT)thenT1XD%= 1:goto2210:rem AR%(4)=AR%(2) right //not used
2190 if(LT)thenT1XD%=-1:rem AR%(4)=AR%(3) left //not used
2210 return
2215 rem ****************************
2225 rem *** T KORNYEZET OLVASAS //READING TARGET ENVIRONMENT
2240 AR%(0)=peek(SCR+((TY%-1)*40)+TX%):rem up
2245 AR%(1)=peek(SCR+((TY%+1)*40)+TX%):rem down
2250 rem AR%(2)=peek(SC%+((TY%)*40)+TX%+1):rem right //not used
2260 rem AR%(3)=peek(SC%+((TY%)*40)+TX%-1):rem left //not used
2261 return
2262 rem ****************************
2264 rem *** S KORNYEZET OLVASAS //READING CHASER ENVIRONMENT
2265 S3AR(0)=peek(SCR+((YS%-1)*40)+XS%):rem up
2266 S3AR(1)=peek(SCR+((YS%+1)*40)+XS%):rem down
2267 FL=(S3AR(0)=LDR%):rem ladder above
2268 AL=(S3AR(1)=LDR%):rem ladder below
2270 return
2280 rem ****************************
2290 rem *** S IRANY MEGHATAROZAS //CHASER MOVEMENT
2300 S1XD%=0:S2YD%=0:LJ%=0:LB%=0:LK%=80:J=0:B=0
2310 V=(TX%=XS%):H=(TY%=YS%)
2320 F=(TY%<YS%):A=(notF)AND(notH):rem T location to chaser (up/down) 
2333 J=TX%>XS%:B=TX%<XS%:rem T location to chaser (right/left) //if H=-1(true)
2338 rem searching nearest ladder(X) to T on level(Y) of S >>>
2453 forM=0TO((LADS%(YS%,0))-1)   
2466    if(F)AND(not(LADS%(YS%,M+1)>0))goto2473:rem T above S, ladder goes down
2468    if(A)AND(not(LADS%(YS%,M+1)<0))goto2473:rem T below S, ladder goes up
2469    LT%=ABS(ABS(LADS%(YS%,M+1))-TX%):rem dist of T to ladder
2470    if(LT%<LK%)thenLK%=LT%:LF%=ABS(LADS%(YS%,M+1)):rem LF:X of nearest ladd.
2471    rem poke211,25:poke214,1:SYS58640:?LF%,M:rem for debug
2472    rem forG=0to1000:NEXTG:rem for debug
2473 nextM
2483 if(V)AND(H)goto3575
2500 LJ%=(LF%>XS%):LB%=(LF%<XS%):rem nearest ladder to T is left or right to S
2505 rem poke211,10:poke214,2:SYS58640:?LJ%,LB%,LF%:rem for debug
2508 if(H)AND(J)thenS1XD%=1:goto2582:rem T on same level and right to S
2509 if(H)AND(B)thenS1XD%=-1:goto2582:rem T on same level and left to S
2510 ifLJ%thenS1XD%=1:goto2582:rem nearest ladder to the right
2515 ifLB%thenS1XD%=-1:goto2582:rem nearest ladder to the left
2535 if(F)AND(FL)thenS2YD%=-1:goto2582:rem T above S, S on ladder
2540 if(A)AND(AL)thenS2YD%=1:rem T below S, S on ladder
2582 return
2615 rem ****************************
2625 rem *** S IRANY FELDOLGOZAS //PROC. S MOVEMENT
2630 pokeSCR+(YS%*40)+XS%,S3AR(4):rem drawing back the char stepped over
2645 XS%=XS%+S1XD%
2650 YS%=YS%+S2YD%
2655 S3AR(4)=peek(SCR+(YS%*40)+XS%):rem saving char to step over
2660 pokeSCR+(YS%*40)+XS%,SK%:rem drawing S at new pos 
2665 gosub2265:rem reading new environment of S
2670 return
2680 rem ****************************
2690 rem *** T IRANY FELDOLGOZAS //PROC. T MOVEMENT
2695 pokeSCR+(TY%*40)+TX%,AR%(4):rem drawing back the char stepped over
2700 TX%=TX%+T1XD%
2710 TY%=TY%+T2YD%
2712 AR%(4)=peek(SCR+(TY%*40)+TX%):rem saving char to step over
2715 pokeSCR+(TY%*40)+TX%,KR%:rem drawing T at new pos
2725 rem gosub2979:rem footstep sound
2735 gosub2240:rem reading T's new environment
2740 return 
2750 rem ****************************
2760 rem SEARCHING FOR LADDERS //-X:ladder goes down
2770 forY=0TO24:rem C:count of ladders on level Y
2778    poke211,35:poke214,0:SYS58640:?Y:rem counter
2779    C=0
2780    forX=0TO39
2785      MP=1024+(Y*40)+X:rem scr memory pos
2789      IFpeek(MP)<>LDR%thengoto2900
2790      FMP=MP-40:rem else //char above
2800      AMP=MP+40:rem else //char below 
2810      ifpeek(FMP)=AIR%then:C=C+1:LADS%(Y,0)=C:LADS%(Y,C)=-X:goto2900:rem dwn
2820      ifpeek(AMP)=FAL%then:C=C+1:LADS%(Y,0)=C:LADS%(Y,C)=X:rem ladder up
2900    nextX
2910 nextY
2915 rem checking array
2918 rem FORY=0TO24:rem C:counter (count of ladders on given Y level)
2924    rem forj=1to500:nextj:rem delay...
2929    rem poke211,25:poke214,1:SYS58640:?Y,LADS%(Y,1)
2939 rem NEXTY
2949 rem checking ladders
2959 rem FORT=0TO10
2964    rem ?LADS%(8,T)
2967 rem nextT
2970 return
2972 rem ****************************
2975 rem *** FOOTSTEP sound
2979 VV=54296:WW=54276:AA=54277:HH=54273:LL=54272
2985 XX=15:pokeVV,XX:pokeWW,129:pokeAA,15:pokeHH,40:pokeLL,200
2990 pokeWW,0:pokeAA,0
2995 return
3000 rem ****************************
3200 rem *** MAP DATA             
3275 rem platform 5
3280 data 1184,102,1185,102,1186,102,1187,102,1188,102,1189,102,1190,102,1191
3285 data 102,1192,102,1193,102,1194,102,1195,102,1196,102,1197,102,1198,102
3286 data 1199,102,1200,102,1201,102,1202,102,1203,102,1204,102,1205,102,1206
3287 data 102,1207,102,1208,102,1209,102,1210,102,1211,102,1212,102,1213,102
3288 data 1214,102,1215,102,1216,102,1217,102,1218,102,1219,102,1220,102,1221
3289 data 102,1222,102,1223,102
3323 rem platform 4
3325 data 1384,102,1385,102,1386,102,1387,102,1388,102,1389,102,1390,102,1391
3326 data 102,1392,102,1393,102,1394,102,1395,102,1396,102,1397,102,1398,102
3327 data 1399,102,1400,102,1401,102,1402,102,1403,102,1404,102,1405,102,1406
3328 data 102,1407,102,1408,102,1409,102,1410,102,1411,102,1412,102,1413,102
3400 data 1414,102,1415,102,1416,102,1417,102,1418,102,1419,102,1420,102,1421
3410 data 102,1422,102,1423,102
3420 rem platform 3
3425 data 1584,102,1585,102,1586,102,1587,102,1588,102,1589,102,1590,102,1591
3426 data 102,1592,102,1593,102,1594,102,1595,102,1596,102,1597,102,1598,102
3427 data 1599,102,1600,102,1601,102,1602,102,1603,102,1604,102,1605,102,1606
3428 data 102,1607,102,1608,102,1609,102,1610,102,1611,102,1612,102,1613,102
3430 data 1614,102,1615,102,1616,102,1617,102,1618,102,1619,102,1620,102,1621
3440 data 102,1622,102,1623,102
3450 rem platform 2
3460 data 1784,102,1785,102,1786,102,1787,102,1788,102,1789,102,1790,102,1791
3465 data 102,1792,102,1793,102,1794,102,1795,102,1796,102,1797,102,1798,102
3466 data 1799,102,1800,102,1801,102,1802,102,1803,102,1804,102,1805,102,1806
3467 data 102,1807,102,1808,102,1809,102,1810,102,1811,102,1812,102,1813,102
3490 data 1814,102,1815,102,1816,102,1817,102,1818,102,1819,102,1820,102,1821
3500 data 102,1822,102,1823,102
3510 rem platform 1
3520 data 1984,102,1985,102,1986,102,1987,102,1988,102,1989,102,1990,102,1991
3525 data 102,1992,102,1993,102,1994,102,1995,102,1996,102,1997,102,1998,102
3530 data 1999,102,2000,102,2001,102,2002,102,2003,102,2004,102,2005,102,2006
3540 data 102,2007,102,2008,102,2009,102,2010,102,2011,102,2012,102,2013,102
3550 data 2014,102,2015,102,2016,102,2017,102,2018,102,2019,102,2020,102,2021
3555 data 102,2022,102,2023,102
3560 rem ladder positions (read to 1D array)
3565 data 1185,1389,1399,1409,1419,1594,1604,1614,1789,1799,1809,1819,1994,2004
3570 data 2014
3575 ?"got ya! [=" 
3580 end
