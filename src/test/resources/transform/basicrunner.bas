100 ?CHR$(147):rem screen clear 
102 POKE 53280,16:rem keret feketere
104 SCR%=1024:rem screen memory base
105 LDR%=45:rem ladder karaktere
108 KR%=81:rem target karakter
109 SK%=65:rem soldier karakter
110 FAL%=102:rem wall karakter
111 AIR%=32:rem semmi/szokoz
112 MAXLDRS%=6:rem maxEnnyiLetraXkoordinatatTudokEltarolniA2DTombben
117 DIM LP%(14)
122 DIMAR%(4):rem T envir. (0..3)//0:UP,1:DN,2:RG,3:LF,4:visszairando
130 DIMS3AR(4):rem Soldier envir.
134 DIMLADS%(24,10):rem a palya osszes letraja letarolva Yszintenkent
136 TX%=17:TY%=3:rem Target coordinates init
146 T1XD%=0:T2YD%=0
156 XS%=0:YS%=23:rem Soldier coordinates init
166 S1XD%=0:S2YD%=0
176 LK%=80:rem LegkozelebbiLetraA'T'-hezDeAz'S'szintjen!!!
186 LT%=0:rem LetraTavolsag
196 LXM%=0:rem igaz, ha a T-hez legkozelebbi letra(az S Y szintjen) X erte
600 rem *****************************
601 rem *** SID INIT
602 FORN=54272TO54296:POKEL,O:NEXTN
909 rem *** map drawing from data ***
910 FORI=1to200:readA%:readB%:pokeA%,B%:NEXTI
920 rem *****************************
930 rem *** storing/drawing LADDERS (from data)
935 rem *** LP:LadderPosition(scr memory),FK:lepcsofok poz.
950 FORJ=0to14:readLP%(J)
955   FK=LP%(J)
960   forK=0to5
980     FK=FK-40
990     pokeFK,LDR%:rem letrafokok kirajzolasa, FK:letrafok poziciok
995   nextK
999 NEXTJ
1000 GOSUB2770:rem letrak tombbe olvasasa a horiz lepes eldontesehez
1002 rem ****************************
1004 rem *** MAIN CYCLE         
1080 pokeSCR%+(TY%*40)+TX%,KR%
1500 FORL=0to1:L=-1
1510    gosub2630:rem S irany feldolgozas
1550    GETK$
1552    UP=0:DN=0:RT=0:LT=0:rem muszaly kinullazni
1553    ifK$=""goto2070:rem ha egyik feltetel sem teljesul 
1555    ifK$=chr$(145)thenUP=-1:rem fel 0
1556    ifK$=chr$(17) thenDN=-1:rem le 1
1558    ifK$=chr$(29) thenRT=-1:rem jobbra 2
1560    ifK$=chr$(157)thenLT=-1:rem balra 3
1565    gosub2125:rem T irany meghatarozas 
1570    gosub2695:rem T irany feldolgozas
2070 NEXTL
2110 rem ****************************
2120 rem *** T IRANY MEGHATAROZAS
2125 T1XD%=0:T2YD%=0:rem reset T direction variables 
2140 if(UP)AND(AR%(0)=LDR%)thenT2YD%=-1:goto2210:rem AR%(4)=AR%(0):rem fel
2155 if(DN)AND(AR%(1)=LDR%)thenT2YD%= 1:goto2210:rem AR%(4)=AR%(1):rem le 
2170 if(RT)thenT1XD%= 1:goto2210:rem AR%(4)=AR%(2) jobbra //egyelore nem h.
2190 if(LT)thenT1XD%=-1:rem AR%(4)=AR%(3) balra //egyelore nem h.
2210 RETURN
2215 rem ****************************
2225 rem *** T KORNYEZET OLVASAS(egyelore csak felette/alatta)
2240 AR%(0)=peek(SCR%+((TY%-1)*40)+TX%):rem feletti
2245 AR%(1)=peek(SCR%+((TY%+1)*40)+TX%):rem alatti
2250 rem AR%(2)=peek(SC%+((TY%)*40)+TX%+1):rem check env on right
2260 rem AR%(3)=peek(SC%+((TY%)*40)+TX%-1):rem check env on left
2261 RETURN
2262 rem ****************************
2264 rem *** S KORNYEZET OLVASAS(egyelore csak felette/alatta)
2265 S3AR(0)=peek(SCR%+((YS%-1)*40)+XS%):rem felette
2266 S3AR(1)=peek(SCR%+((YS%+1)*40)+XS%):rem alatta
2267 FL=(S3AR(0)=LDR%):rem Felette Letra
2268 AL=(S3AR(1)=LDR%):rem Alatta Letra
2270 return
2280 rem ****************************
2290 rem *** S IRANY MEGHATAROZAS //4 fo ag van:left,right,up,down
2300 S1XD%=0:S2YD%=0:LJ%=0:LB%=0:LK%=80:J=0:B=0:rem reset S direction variables
2310 V=(TX%=XS%):rem POKE211,25:POKE214,0:SYS58640:?V:rem Vertikalis egyezes
2315 H=(TY%=YS%):rem Horizontalis egyezes, -1 ha true
2320 F=(TY%<YS%):rem aTazS-hezKepestFentVagyLentHelyezkedikEl(F=-1 ha fent)
2328 A=(notF)AND(notH):rem HaAlattaVan
2333 J=TX%>XS%:B=TX%<XS%:rem A'T'jobbraVagyBalraHelyezkedikEl//Csak akkor vizs
2338 rem Keressuk a T-hez legkozelebbi letra X poziciojat az S szintjen!! >>>
2453 FORM=0TO((LADS%(YS%,0))-1):rem keresemALegkozelebbi,Megfelelo*Letrat,*  
2466    IF(F)AND(not(LADS%(YS%,M+1)>0))goto2473:rem haTazSfelettVanDeAzAktViz
2468    IF(A)AND(not(LADS%(YS%,M+1)<0))goto2473:rem haTazSAlattVanDeAzAktViz
2469    LT%=ABS(ABS(LADS%(YS%,M+1))-TX%):rem LT:azAktVizsgaltLetraTavolsaga
2470    IF(LT%<LK%)THENLK%=LT%:LF%=ABS(LADS%(YS%,M+1)):rem LF:Annak a letra
2473 NEXTM
2483 IF(V)AND(H)goto3575
2500 LJ%=(LF%>XS%):LB%=(LF%<XS%):rem POKE211,25:POKE214,1:SYS58640:?LL%
2508 IF(H)AND(J)thenS1XD%=1:goto2582:rem MiutanEgySzintreKerultekEsJobbraVan
2509 IF(H)AND(B)thenS1XD%=-1:goto2582:rem MiutanEgySzintreKerultekEsBalraVan
2510 IFLJ%thenS1XD%=1:goto2582:rem ha a legkozelebbi letra jobbra van
2515 IFLB%thenS1XD%=-1:goto2582:rem ha a legkozelebbi letra balra van
2535 if(F)AND(FL)thenS2YD%=-1:goto2582:rem ha S folott es van letra
2540 if(A)AND(AL)thenS2YD%=1:rem elseHaSAlattEsVanLetra
2582 RETURN
2615 rem ****************************
2625 rem *** S IRANY FELDOLGOZAS /leptetes(kirajzolas)
2630 pokeSCR%+(YS%*40)+XS%,S3AR(4):rem a torolt karakter visszairasa
2632 rem gosub2979:rem footstep
2635 gosub2265:rem kornyezet beolvasas
2640 gosub2300:rem Soldier irany meghat T koordinatak es kornyezet alapjan
2645 XS%=XS%+S1XD%
2650 YS%=YS%+S2YD%
2655 S3AR(4)=peek(SCR%+(YS%*40)+XS%):rem ElmentemAzSAltalFelulirandoKaraktert
2660 pokeSCR%+(YS%*40)+XS%,SK%:rem S kirajzolas 
2670 return
2680 rem ****************************
2690 rem *** T IRANY FELDOLGOZAS
2695 pokeSCR%+(TY%*40)+TX%,AR%(4):rem a torolt karakter visszairasa 
2700 TX%=TX%+T1XD%
2710 TY%=TY%+T2YD%
2712 AR%(4)=peek(SCR%+(TY%*40)+TX%):rem elmentem a felulirando karaktert
2715 pokeSCR%+(TY%*40)+TX%,KR%:rem T kirajzolas//ha van mozgas
2725 gosub2979:rem footstep
2735 gosub2240:rem uj kornyezet olvasasa
2740 return 
2750 rem ****************************
2760 rem SEARCHING FOR LADDERS Ha egy X ertek negativ akkor lefele vez
2770 FORY=0TO24:rem C:counter(ennyi letra van az adott szinten)
2778    POKE211,25:POKE214,0:SYS58640:?Y:rem debughoz
2779    C=0
2780    forX=0TO39
2785      MP=1024+(Y*40)+X:rem MP mint screen memoria pozicio
2789      IFpeek(MP)<>LDR%thengoto2900
2790      FMP=MP-40:rem else ag FMP mint MemPozicio felett 
2800      AMP=MP+40:rem else ag AMP mint MemPozicio alatt
2810      ifpeek(FMP)=AIR%then:C=C+1:LADS%(Y,0)=C:LADS%(Y,C)=-X:goto2900
2820      ifpeek(AMP)=FAL%then:C=C+1:LADS%(Y,0)=C:LADS%(Y,C)=X:rem FelfeleVezet
2900    nextX
2910 NEXTY
2970 RETURN
2972 rem ****************************
2975 rem *** FOOTSTEP  
2979 VV=54296:WW=54276:AA=54277:HH=54273:LL=54272
2985 XX=15:POKEVV,XX:POKEWW,129:POKEAA,15:POKEHH,40:POKELL,200
2990 POKEWW,0:POKEAA,0
2995 RETURN
3000 rem ****************************
3200 rem *** MAP DATA             
3275 rem platform 5
3280 DATA 1184,102,1185,102,1186,102,1187,102,1188,102,1189,102,1190,102,1191
3285 DATA 102,1192,102,1193,102,1194,102,1195,102,1196,102,1197,102,1198,102
3286 data 1199,102,1200,102,1201,102,1202,102,1203,102,1204,102,1205,102,1206
3287 data 102,1207,102,1208,102,1209,102,1210,102,1211,102,1212,102,1213,102
3288 data 1214,102,1215,102,1216,102,1217,102,1218,102,1219,102,1220,102,1221
3289 data 102,1222,102,1223,102
3323 rem platform 4
3325 DATA 1384,102,1385,102,1386,102,1387,102,1388,102,1389,102,1390,102,1391
3326 data 102,1392,102,1393,102,1394,102,1395,102,1396,102,1397,102,1398,102
3327 data 1399,102,1400,102,1401,102,1402,102,1403,102,1404,102,1405,102,1406
3328 data 102,1407,102,1408,102,1409,102,1410,102,1411,102,1412,102,1413,102
3400 DATA 1414,102,1415,102,1416,102,1417,102,1418,102,1419,102,1420,102,1421
3410 data 102,1422,102,1423,102
3420 rem platform 3
3425 DATA 1584,102,1585,102,1586,102,1587,102,1588,102,1589,102,1590,102,1591
3426 data 102,1592,102,1593,102,1594,102,1595,102,1596,102,1597,102,1598,102
3427 data 1599,102,1600,102,1601,102,1602,102,1603,102,1604,102,1605,102,1606
3428 data 102,1607,102,1608,102,1609,102,1610,102,1611,102,1612,102,1613,102
3430 DATA 1614,102,1615,102,1616,102,1617,102,1618,102,1619,102,1620,102,1621
3440 data 102,1622,102,1623,102
3450 rem platform 2
3460 DATA 1784,102,1785,102,1786,102,1787,102,1788,102,1789,102,1790,102,1791
3465 data 102,1792,102,1793,102,1794,102,1795,102,1796,102,1797,102,1798,102
3466 data 1799,102,1800,102,1801,102,1802,102,1803,102,1804,102,1805,102,1806
3467 data 102,1807,102,1808,102,1809,102,1810,102,1811,102,1812,102,1813,102
3490 DATA 1814,102,1815,102,1816,102,1817,102,1818,102,1819,102,1820,102,1821
3500 data 102,1822,102,1823,102
3510 rem platform 1
3520 DATA 1984,102,1985,102,1986,102,1987,102,1988,102,1989,102,1990,102,1991
3525 data 102,1992,102,1993,102,1994,102,1995,102,1996,102,1997,102,1998,102
3530 data 1999,102,2000,102,2001,102,2002,102,2003,102,2004,102,2005,102,2006
3540 data 102,2007,102,2008,102,2009,102,2010,102,2011,102,2012,102,2013,102
3550 DATA 2014,102,2015,102,2016,102,2017,102,2018,102,2019,102,2020,102,2021
3555 data 102,2022,102,2023,102
3560 rem ladder positions (been put into an 1D array)
3565 DATA 1185,1389,1399,1409,1419,1594,1604,1614,1789,1799,1809,1819,1994,2004
3570 data 2014
3575 ?"megvagy" 
3580 end
