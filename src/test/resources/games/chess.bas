10 rem *******************************
20 rem *
30 rem * schachprogramm in basic
40 rem * fuer den rechner commodore 64
50 rem *
60 rem *******************************
70 rem * bedienungshinweise:
80 rem * ===================
90 rem * dies ist ein basic-schach-
100 rem * programm. es wird nach den
110 rem * allgemeinen schachregeln
120 rem * gespielt. wenn sie z.b. von
130 rem * c3 nach e5 ziehen wollen,
140 rem * geben sie einfach c3:e5+return
150 rem * ein. 
155 rem * del = korrektur
160 rem * o   = kleine rochade
170 rem * oo  = grosse rochade
180 rem *******************************
350 rem *** initialisierung ***
370 dim fw(10) :dim f(99) :dim f$(18)
380 dim bs(132):dim sk(132):dim zk(132)
390 dim fa(8)
400 rem
410 rem *** farben *** 
420 rf=0:hf=0
430 zf$=chr$(5)
440 fh$=chr$(154)
450 fd$=chr$(31)
460 ro$=chr$(18)
470 rf$=chr$(146)
480 rem
490 rem *** figurenwerte
500 for a=0 to 9:read fw(a):next
510 data 3,10,10,30,30,50,50,110,999,999
520 rem
530 rem *** scheinfiguren
540 for a=1 to 9:f(a)=10:next
550 for a=90 to 98:f(a)=10:next
560 for a=0 to 80 step 10:f(a)=10:next
570 for a=19 to 99 step 10:f(a)=10:next
580 rem
590 rem *** echte figuren
600 for a=18 to 88 step 10
610 read f(a): next a
620 for a=17 to 87 step 10:f(a)=1:next
630 for a=12 to 82 step 10:f(a)=-1:next
640 for a=11 to 81 step 10
650 read f(a):next a
660 data 5,3,4,7,8,4,3,5
670 data -5,-3,-4,-7,-8,-4,-3,-5
680 rem 
690 rem *** druckzeichen figur
695 for a=0 to 18:read df:f$(a)=chr$(df)
696 if df>128 then f$(a)=chr$(5)+f$(a)
697 next a
700 data 203,203,196,212,212
710 data 204, 211, 194, 194,32
720 data 66,66,83,76
730 data 84,84,68,75,75
770 rem
780 rem *** feldabstaende
790 for a=1 to 8:read fa(a):next
800 data 21,19,12,8,11,9,10,1
810 rem
820 rem *** grossbuchstabe
830 b$=chr$(194) : i$=chr$(201)
840 o$=chr$(207) : p$=chr$(208)
850 s$=chr$(211) : z$=chr$(218)
860 rem
870 rem *** schachbrett
880 poke 53280,rf : poke 53281,hf
890 print chr$(147);
900 print chr$(14)
910 for a=1 to 4
920 print tab(8)"";
930 for b=1 to 2:for c=1 to 4
940 print ro$;fh$;"   ";fd$;"   ";
950 next c
960 print:print tab(8)"";
970 next b
980 for b=1 to 2:for c=1 to 4
990 print ro$;fd$;"   ";fh$;"   ";
1000 next c
1010 print:print tab(8)"";
1020 next b,a
1030 print chr$(19);
1040 print tab(9)"";zf$;
1050 for a=193 to 200
1060 print chr$(a);"  ";
1070 next a
1080 print
1090 for a=8 to 1 step -1
1100 print:print tab(6)a:next a
1110 rem ***
1120 rem *** init/ende
1130 rem ***
1140 rem *** spielteil
1150 rem ***
1160 rem
1170 rem *** hauptschleife ***
1180 gosub 1470
1190 gosub 1680
1200 gosub 3790
1210 gosub 1470
1220 gosub 3960
1230 if ma=1 or pa=1 then 1270
1240 gosub 3790
1250 rem
1260 goto 1180
1270 gosub 7880
1280 if pa<>1 then 1340
1290 print
1300 print tab(17) p$;"att!"
1310 print tab(17)"====="
1320 goto 1400
1340 print tab(14)s$;"chach matt!"
1370 print tab(11)s$;"ie haben gewonnen"
1390 print tab(11)"==================";
1400 end
1410 rem ***
1420 rem *** unterprogramme
1430 rem ***
1440 rem ***
1450 rem ***
1460 rem ***
1470 rem *** steine setzen ***
1480 print chr$(19)
1490 for a=0 to 6 step 2
1500 print:print tab(8)"";
1510 for b=18-a to 88-a step 20
1520 print ro$;fh$;" ";ro$;fh$;f$(f(b)+9);fh$;" ";ro$;fd$;" ";
1525 print ro$;fd$;f$(f(b+10)+9);fd$;" ";
1530 next b
1540 print:print:print tab(8)"";
1550 for b=18-a to 88-a step 20
1560 print ro$;fd$;" ";ro$;fd$;f$(f(b-1)+9);fd$;" ";ro$;fh$;" ";
1565 print ro$;fh$;f$(f(b+9)+9);fh$;" ";
1570 next b
1580 print
1590 next a
1600 return
1610 rem ***
1620 rem ***
1630 rem ***
1640 rem ***
1650 rem ***
1660 rem ***
1670 rem ***
1680 rem *** spielereingabe ***
1690 gosub 7880
1700 print
1705 print tab(12) i$;"hr ";z$;"ug: ";ro$;
1710 print " ";rf$;"- : -- ";
1720 for a=1 to 8:print chr$(157);:next
1730 get in$:if in$="" then 1730
1740 if in$=chr$(20) then 1835
1750 if in$="o" and f(51)=-8 then 2130
1760 if in$<"a" or in$>"h" then 1730
1770 print chr$(asc(in$)+128);
1780 print ro$;" ";rf$;chr$(157);
1790 get ip$:if ip$="" then 1790
1800 if ip$=chr$(20) then 1835
1810 if ip$<"1" or ip$>"8" then 1790
1820 sk=10*(asc(in$)-64)+val(ip$)
1830 if f(sk)<0 then 1840
1835 print chr$(145):goto 1705
1840 print ip$;" : ";ro$;" ";rf$;chr$(157);
1850 get in$:if in$="" then 1850
1860 if in$=chr$(20) then 1835
1870 if in$<"a" or in$>"h" then 1850
1880 print chr$(asc(in$)+128);
1890 print ro$;" ";rf$;chr$(157);
1900 get ip$:if ip$="" then 1900
1910 if ip$=chr$(20) then 1835
1920 if ip$<"1" or ip$>"8" then 1900
1930 print ip$;ro$;" ";rf$;chr$(157);
1940 get e$:if e$="" then 1940
1950 if e$=chr$(20) then 1835
1960 if e$<>chr$(13) then 1940
1970 zk=10*(asc(in$)-64)+val(ip$)
1975 print " ";
1980 if f(zk)>=0 then 2700
1990 for a=1 to 3:print chr$(157);:next
2000 print ro$;" ";rf$;"-";chr$(157);chr$(157);
2010 goto 1850
2120 rem
2130 rem *** rochade ***
2140 ro=1
2150 print " ";o$;"-";o$;"   ";
2160 for a=1 to 3:print chr$(157);:next
2170 print ro$;" ";rf$;chr$(157);
2180 get in$:if in$="" then 2180
2190 if in$=chr$(20) then 1835
2200 if in$=chr$(13) then 2280
2210 if in$<>"0" then 2180
2220 print "-";o$:ro=-1
2230 print ro$;"-";rf$;chr$(157);
2240 get e$:if e$="" then 2240
2250 if e$=chr$(20) then 1835
2260 if e$<>chr$(13) then 2240
2280 if f(46+ro*35)<>-5 then 2600
2290 if f(51+ro*10)<>0 then 2600
2300 if f(51+ro*20)<>0 then 2600
2310 if ro=-1 and f(21)<>0 then 2600
2320 print " ";:b=51
2330 for a=b+1 to 78
2340 if f(a)=0 then next
2350 if f(a)=6 or f(a)=7 then 2600
2360 if f(b+1)=9 then 2600
2370 for a=b+11 to 86 step 11
2380 if f(a)=0 then next
2390 if f(a)=4 or f(a)=7 then 2600
2400 if f(b+11)=9 then 2600
2410 for a=b+10 to 81 step 10
2420 if f(a)=0 then next
2430 if f(a)=6 or f(a)=7 then 2600
2440 if f(b+10)=9 then 2600
2450 for a=b-10 to 11 step -10
2460 if f(a)=0 then next
2470 if f(a)=6 or f(a)=7 then 2600
2480 if f(b-10)=9 then 2600
2490 for a=b-9 to 13 step -9
2500 if f(a)=0 then next
2510 if f(a)=4 or f(a)=7 then 2600
2520 if f(b-9)=9 then 2600
2530 if f(b-19)=3 then 2600
2540 if f(b-8)=3 then 2600
2550 if f(b+12)=3 then 2600
2560 if f(b+21)=3 then 2600
2570 if f(b-9)=2 or f(b+11)=2 then 2600
2580 if b=51+ro*20 then 2620
2590 b=b+ro*10:goto 2330
2600 ro=0
2610 goto 1835
2620 rem *** rochade ausfuehren
2630 f(51)=0:f(51+ro*20)=-9
2640 f(46+ro*35)=0:f(51+ro*10)=-6
2645 goto 3720
2650 rem *** rochade ende
2680 rem ***
2690 rem *** eingabekontrolle ***
2700 rem ***
2710 on abs(f(sk)+1) goto 2780,2860,2920,3080,3080,3240,3320,3320
2730 rem *** bauer 2-schritt ***
2740 if zk-sk<>2 then 2780
2750 if f(sk+1)=0 and f(zk)=0 then 3370
2760 goto 1990
2780 rem *** bauer allgemein ***
2790 if sk-zk<>9 and zk-sk<>11 then 2820
2800 if f(zk)>0 then 3370
2810 goto 1990
2820 if zk-sk<>1 then 1990
2830 if f(zk)<>0 then 1990
2840 goto 3370
2860 rem *** springer ***
2870 for a=1 to 4
2880 if abs(zk-sk)=fa(a) then 3370
2890 next a
2900 goto 1990
2920 rem *** laeufer/dame ***
2930 di=abs(zk-sk):v=sgn(zk-sk)
2940 if di/11=int(di/11) then 2970
2950 if di/9=int(di/9) then 3020
2960 goto 1990
2970 if di=11 then 3370
2980 for a=sk+11*v to zk-11*v step 11*v
2990 if f(a)<>0 then 1990
3000 next a
3010 goto 3370
3020 if di=9 then 3370
3030 for a=sk+9*v to zk-9*v step 9*v
3040 if f(a)<>0 then 1990
3050 next a
3060 goto 3370
3080 rem *** turm/dame ***
3090 di=abs(zk-sk):v=sgn(zk-sk)
3100 if di<8 then 3130
3110 if di/10=int(di/10) then 3180
3120 goto 1990
3130 if di=1 then 3370
3140 for a=sk+v to zk-v step v
3150 if f(a)<>0 then 1990
3160 next a
3170 goto 3370
3180 if di=10 then 3370
3190 for a=sk+10*v to zk-10*v step 10*v
3200 if f(a)<>0 then 1990
3210 next a
3220 goto 3370
3240 rem *** dame ***
3250 di=abs(zk-sk):v=sgn(zk-sk)
3260 if di/11=int(di/11) then 2970
3270 if di/10=int(di/10) then 3180
3280 if di/9=int(di/9) then 3020
3290 if di<8 then 3130
3300 goto 1990
3320 rem *** koenig ***
3330 di=abs(zk-sk)
3340 if di=10 or di=11 then 3370
3350 if di<>1 and di<>9 then 1990
3370 rem *** zugausfuehrung und schachpruefung ***
3380 fz=f(zk):f(zk)=f(sk):f(sk)=0
3390 for pk=11 to 88
3400 if f(pk)=-8 or f(pk)=-9 then 3440
3410 next pk
3440 b=-1
3450 mw=50+b*39:for a=pk+b to mw step b
3460 if f(a)=0 then next
3470 if f(a)>=5 and f(a)<=7 then 3730
3480 if f(pk+b)=8 or f(pk+b)=9 then 3730
3490 for a=pk+b*11 to mw step b*11
3500 if f(a)=0 then next
3510 if f(a)=4 or f(a)=7 then 3730
3520 if f(pk+b*11)=8 or f(pk+b*11)=9 then 3730
3530 for a=pk+b*10 to mw step b*10
3540 if f(a)=0 then next
3550 if f(a)>=5 and f(a)<=7 then 3730
3560 if f(pk+b*10)=8 or f(pk+b*10)=9 then 3730
3570 for a=pk+b*9 to mw step b*9
3580 if f(a)=0 then next
3590 if f(a)=4 or f(a)=7 then 3730
3600 if f(pk+b*9)=8 or f(pk+b*9)=9 then 3730
3610 for a=1 to 4
3620 s=pk+fa(a)*b
3630 if s<11 or s>88 then 3650
3640 if f(s)=3 then 3730
3650 next a
3660 if b=-1 then b=1:goto 3450
3670 if f(pk-9)=1 or f(pk+11)=1 then 3730
3680 if f(pk-9)=2 or f(pk+11)=2 then 3730
3700 if f(zk)=-2 and zk-int(zk/10)*10=8 then f(zk)=-7
3710 if f(zk)=-1 or f(zk)=-5 or f(zk)=-8 then f(zk)=f(zk)-1
3720 return
3730 f(sk)=f(zk):f(zk)=fz:goto 1990
3740 rem ***
3750 rem ***
3760 rem ***
3770 rem ***
3780 rem *** zugangabe
3790 print chr$(19);tab(33)"";
3800 for a=1 to 9:print chr$(17);:next
3810 if ro=0 then 3880
3820 if ro=1 then print " ";
3830 if ro=-1 then print o$;"-";
3835 print o$;"-";o$;" ";
3840 ro=0:goto 3920
3880 print chr$(192+int(sk/10));
3890 print right$(str$(sk),1);":";
3900 print chr$(192+int(zk/10));
3910 print right$(str$(zk),1)
3920 return
3930 rem ***
3940 rem ***
3950 rem ***
3960 rem *** computerzug ***
3970 gosub 7880
3990 print tab(14) b$;"itte warten"
4000 print
4010 print tab(12) s$;"tellungsanalyse"
4020 print
4030 print tab(13) "80 bis zum ";
4040 print z$;"ug"; chr$(145)
4050 zn=0:bz=1
4060 if f(58)=8 then gosub 6140
4070 sk=11
4080 print tab(13) "";
4090 print right$(str$(91-sk),2);
4100 print chr$(145)
4120 if f(sk)<=0 or f(sk)=10 then 4130
4125 gosub 5410
4130 if sk<88 then sk=sk+1:goto 4080
4140 for a=1 to zn-1:for b=a+1 to zn
4150 if bs(a)>=bs(b) then 4190
4160 bs(0)=bs(a):bs(a)=bs(b):bs(b)=bs(0)
4170 sk(0)=sk(a):sk(a)=sk(b):sk(b)=sk(0)
4180 zk(0)=zk(a):zk(a)=zk(b):zk(b)=zk(0)
4190 next b,a
4200 print tab(14)"2";chr$(145)
4210 if bz<zn+1 then 4240
4220 if ma=1 then pa=1:goto 4320
4230 ma=1:bz=1
4240 sk=sk(bz):zk=zk(bz)
4250 if zk>1 then 4300
4260 ro=zk:zk=58+ro*10:f(58)=0:f(58+ro*20)=9
4300 fz=f(zk):f(zk)=f(sk):f(sk)=0
4310 rem ***
4320 rem * kontrolle koenig in schach **
4330 for pk=11 to 88
4340 if f(pk)=8 or f(pk)=9 then 4360
4350 next pk
4360 b=-1
4370 mw=50+b*39
4380 for a=pk+b to mw step b
4390 if f(a)=0 then next
4400 if f(a)>=-7 and f(a)<=-5 then 5320
4410 if f(pk+b)=-8 or f(pk+b)=-9 then 5320
4420 rem 
4430 for a=pk+b*11 to mw step b*11
4440 if f(a)=0 then next
4450 if f(a)=-4 or f(a)=-7 then 5320
4460 if f(pk+b*11)=-8 or f(pk+b*11)=-9 then 5320
4470 rem
4480 for a=pk+b*10 to mw step b*10
4490 if f(a)=0 then next
4500 if f(a)>=-7 and f(a)<=-5 then 5320
4510 if f(pk+b*10)=-8 or f(pk+b*10)=-9 then 5320
4520 rem
4530 for a=pk+b*9 to mw step b*9
4540 if f(a)=0 then next
4550 if f(a)=-4 or f(a)=-7 then 5320
4560 if f(pk+b*9)=-8 or f(pk+b*9)=-9 then 5320
4570 rem
4580 for a=1 to 4
4590 s=pk+fa(a)*b
4600 if s<11 or s>88 then 4620
4610 if f(s)=-3 then 5320
4620 next a
4630 if b=-1 then b=1 : goto 4370
4640 if f(pk-9)=-1 or f(pk+11)=-1 then 5320
4650 if f(pk-9)=-2 or f(pk+11)=-2 then 5320
4660 print tab(14) "1"; chr$(145)
4670 if pa=1 then 5300
4680 if ma=1 then ma=0 : goto 5260
4690 if f(zk)=7 then 4710
4700 if fw(f(zk))<=fw(-fz) then 5260
4705 rem **** deckung von figuren ****
4710 rem **** figur bedroht ??? ****
4720 b=-1
4730 mw=50+b*39
4740 for a=zk+b to mw step b
4750 if f(a)=0 then next
4760 if f(a)>=-7 and f(a)<=-5 then 4990
4770 if f(zk+b)=-8 or f(zk+b)=-9 then 4990
4780 rem
4790 for a=zk+b*11 to mw step b*11
4800 if f(a)=0 then next
4810 if f(a)=-4 or f(a)=-7 then 4990
4820 if f(zk+b*11)=-8 or f(zk+b*11)=-9 then 4990
4830 rem
4840 for a=zk+b*10 to mw step b*10
4850 if f(a)=0 then next
4860 if f(a)>=-7 and f(a)<=-5 then 4990
4870 if f(zk+b*10)=-8 or f(zk+b*10)=-9 then 4990
4880 rem
4890 for a=zk+b*9 to mw step b*9
4900 if f(a)=0 then next
4910 if f(a)=-4 or f(a)=-7 then 4990
4920 if f(zk+b*9)=-8 or f(zk+b*9)=-9 then 4990
4930 rem
4940 for a=1 to 4
4950 s=zk+fa(a)*b
4960 if s<11 or s>88 then 4972
4970 if f(s)=3 then 4990
4972 next a
4974 if b=-1 then b=1:goto 4730
4976 if f(zk+9)=-1 or f(zk-11)=-1 then 4990
4978 if f(zk+9)=-2 or f(zk-11)=-2 then 4990
4980 goto 5260
4990 if f(zk)=7 then 5320
5000 rem **** figur gedeckt ??? ****
5020 b=-1
5030 mw=50+b*39
5040 for a=zk+b to mw step b
5050 if f(a)=0 then next
5060 if f(a)>=5 and f(a)<=7 then 5260
5070 rem
5080 for a=zk+b*11 to mw step b*11
5090 if f(a)=0 then next
5100 if f(a)=4 or f(a)=7 then 5260
5110 rem
5120 for a=zk+b*10 to mw step b*10
5130 if f(a)=0 then next
5140 if f(a)>=5 and f(a)<=7 then 5260
5150 rem
5160 for a=zk+b*9 to mw step b*9
5170 if f(a)=0 then next
5180 if f(a)=4 or f(a)=7 then 5260
5190 rem
5200 for a=1 to 4
5210 s=zk+fa(a)*b
5220 if s<11 or s>88 then 5240
5230 if f(s)=3 then 5260
5240 next a
5242 if b=-1 then b=1 : goto 5030
5244 if f(zk-9)=1 or f(zk+11)=1 then 5260
5246 if f(zk-9)=2 or f(zk+11)=2 then 5260
5250 goto 5320
5260 rem
5270 rem **** deckung von figuren/ende ****
5280 if f(zk)=1 or f(zk)=5 or f(zk)=8 then f(zk)=f(zk)+1
5290 if f(zk)=2 and zk-int(zk/10)*10=1 then f(zk)=7
5300 print tab(14) "0"
5310 return
5320 if pa=1 then pa=0 : goto 5300
5330 f(sk)=f(zk) : f(zk)=fz : bz=bz+1
5340 if ro=0 then 4210
5350 f(58)=8 : f(58+ro*20)=0
5360 ro=0
5370 goto 4210
5380 rem ******************************
5390 rem ****** computerzug/ende ******
5400 rem ******************************
5410 rem ******** zugerzeuger *********
5430 on f(sk)-1 goto 5510,5710,5810,5920,5920,5810,6030,6030
5440 rem
5450 rem ******* bauer 2-schritt *******
5460 if f(sk-2)<>0 then 5510
5470 if f(sk-1)<>0 then 5510
5480 zk=sk-2
5490 f(sk)=2 : gosub 6590 : f(sk)=1
5500 rem
5510 rem ******* bauer allgemein *******
5520 fs=f(sk) : f(sk)=2
5530 if f(sk-11)>=0 then 5580
5540 zk=sk-11
5550 if sk-int(sk/10)*10=2 then f(sk)=7
5560 gosub 6590
5570 if sk-int(sk/10)*10=2 then f(sk)=2
5580 if f(sk-1)<>0 then 5630
5590 zk=sk-1
5600 if sk-int(sk/10)*10=2 then f(sk)=7
5610 gosub 6590
5620 if sk-int(sk/10)*10=2 then f(sk)=2
5630 if f(sk+9)>=0 then 5680
5640 zk=sk+9
5650 if sk-int(sk/10)*10=2 then f(sk)=7
5660 gosub 6590
5670 if sk-int(sk/10)*10=2 then f(sk)=2
5680 f(sk)=fs
5690 goto 6100
5700 rem
5710 rem ********** springer **********
5720 for b1=-1 to 1 step 2
5730 for a1=1 to 4
5740 zk=sk+b1*fa(a1)
5750 if zk<0 then zk=zk+100
5760 if zk>99 then zk=zk-100
5770 if f(zk)<=0 then gosub 6590
5780 next a1,b1
5790 goto 6100
5800 rem
5810 rem ******** laeufer/dame *********
5820 for b1=-1 to 1 step 2
5830 for c1=5 to 6
5840 for a1=sk+b1*fa(c1) to 50+b1*39 step b1*fa(c1)
5850 if f(a1)<=0 then 5870
5860 a1=50+b1*39 : goto 5890
5870 zk=a1 : gosub 6590
5880 if f(a1)<0 then 5860
5890 next a1,c1,b1
5900 if f(sk)<>7 then 6100
5910 rem
5920 rem ********** turm/dame **********
5930 for b1=-1 to 1 step 2
5940 for c1=7 to 8
5950 for a1=sk+b1*fa(c1) to 50+b1*39 step b1*fa(c1)
5960 if f(a1)<=0 then 5980
5970 a1=50+b1*39 : goto 6000
5980 zk=a1 : gosub 6590
5990 if f(a1)<0 then 5970
6000 next a1,c1,b1
6010 goto 6100
6020 rem
6030 rem *********** koenig ************
6040 for b1=-1 to 1 step 2
6050 for a1=5 to 8
6060 zk=sk+b1*fa(a1)
6070 if f(zk)>0 then 6090
6080 gosub 6590
6090 next a1,b1
6100 return
6110 rem ******************************
6120 rem ****** zugerzeuger/ende ******
6130 rem ******************************
6140 rem *** rochade mit kontrolle ****
6150 rem ******************************
6160 ro=-1 : b=58
6170 if f(53+ro*35)<>5 then 6530
6180 if f(58+ro*10)<>0 then 6530
6190 if f(58+ro*20)<>0 then 6530
6200 if ro=-1 and f(28)<>0 then 6530
6210 for a=b-1 to 31 step -1
6220 if f(a)=0 then next
6230 if f(a)=-6 or f(a)=-7 then 6530
6240 if f(b-1)=-9 then 6530
6250 for a=b-11 to 13 step -11
6260 if f(a)=0 then next
6270 if f(a)=-4 or f(a)=-7 then 6530
6280 if f(b-11)=-9 then 6530
6290 for a=b+10 to 88 step 10
6300 if f(a)=0 then next
6310 if f(a)=-6 or f(a)=-7 then 6530
6320 if f(b+10)=-9 then 6530
6330 for a=b-10 to 18 step -10
6340 if f(a)=0 then next
6350 if f(a)=-6 or f(a)=-7 then 6530
6360 if f(b-10)=-9 then 6530
6370 for a=b+9 to 87 step 9
6380 if f(a)=0 then next
6390 if f(a)=-4 or f(a)=-7 then 6530
6400 if f(b+9)=-9 then 6530
6410 if f(b+19)=-3 then 6530
6420 if f(b+8)=-3 then 6530
6430 if f(b-12)=-3 then 6530
6440 if f(b-21)=-3 then 6530
6450 if f(b+9)=-2 or f(b-11)=-2 then 6530
6460 if b=58+ro*20 then 6480
6470 b=b+ro*10 : goto 6210
6480 f(58)=0 : f(58+ro*20)=9
6490 sk=53+ro*35 : zk=58+ro*10
6500 gosub 6590
6510 f(58)=8 : f(58+ro*20)=0
6520 zk(zn)=ro : bs(zn)=bs(zn)+100
6530 if ro=-1 then ro=1 : goto 6170
6540 ro=0
6550 return
6560 rem ***********************
6570 rem ******** rochade/ende ********
6580 rem ******************************
6590 rem ********** wertung ***********
6600 rem ******************************
6610 fz=f(zk) : f(zk)=f(sk) : f(sk)=0
6620 zn=zn+1 : sw=0
6630 for p=11 to 88
6640 if f(p)=0 or f(p)=10 then 7810
6650 if f(p)>0 then 7240
6660 rem ******************************
6670 rem ******* wertung/gegner *******
6680 rem ******************************
6690 sw=sw-3*fw(-f(p))
6710 on -f(p)-1 goto 6720,6810,6900,7010,7010,6900,7120,7120
6720 rem ******* bauer allgemein *******
6730 if f(p+1)=0 then sw=sw-3
6740 if f(p-9)>0 then sw=sw-fw(f(p-9))
6750 if f(p+11)>0 then sw=sw-fw(f(p+11))
6760 if f(p)=-2 then 7810
6770 rem ******* bauer 2-schritt *******
6780 if f(p+1)<>0 then 6800
6790 if f(p+2)=0 then sw=sw-3
6800 goto 7810
6810 rem ********** springer ***********
6820 a=-1
6830 for b=1 to 4
6840 sp=p+a*fa(b)
6850 if sp<11 or sp>88 then 6870
6860 if f(sp)>=0 then sw=sw-fw(f(sp))
6870 next b
6880 if a=-1 then a=1 : goto 6830
6890 goto 7810
6900 rem ******** laeufer/dame *********
6910 b=-1
6920 for c=5 to 6
6930 a=p+b*fa(c)
6940 if f(a)>=0 then sw=sw-fw(f(a))
6950 if f(a)<>0 then 6980
6960 a=a+b*fa(c)
6970 goto 6940
6980 next c
6990 if b=-1 then b=1 : goto 6920
7000 if f(p)<>-7 then 7810
7010 rem ********** turm/dame *********
7020 b=-1
7030 for c=7 to 8
7040 a=p+b*fa(c)
7050 if f(a)>=0 then sw=sw-fw(f(a))
7060 if f(a)<>0 then 7090
7070 a=a+b*fa(c)
7080 goto 7050
7090 next c
7100 if b=-1 then b=1 : goto 7030
7110 goto 7810
7120 rem *********** koenig ************
7130 b=-1
7140 for c=5 to 8
7150 sp=f(p+b*fa(c))
7160 if sp<0 and ro=0 then 7180
7170 sw=sw-fw(abs(sp))
7180 next c
7190 if b=-1 then b=1 : goto 7140
7200 goto 7810
7210 rem ******************************
7220 rem **** wertung/gegner/ende *****
7230 rem ******************************
7240 rem ****** wertung/computer ******
7250 rem ******************************
7260 sw=sw+3*fw(f(p))
7270 on f(p)-1 goto 7290,7390,7480,7590,7590,7480,7700,7700
7290 rem ******* bauer allgemein *******
7300 if f(zk)<=2 then sw=sw+3
7310 if f(p-1)=0 then sw=sw+3
7320 if f(p+9)<0 then sw=sw+fw(-f(p+9))
7330 if f(p-11)<0 then sw=sw+fw(-f(p-11))
7340 if f(p)=2 then 7810
7350 rem ******* bauer 2-schritt *******
7360 if f(p-1)<>0 then 7380
7370 if f(p-2)=0 then sw=sw+3
7380 goto 7810
7390 rem ********** springer ***********
7400 a=-1
7410 for b=1 to 4
7420 sp=p+a*fa(b)
7430 if sp<11 or sp>88 then 7450
7440 if f(sp)<=0 then sw=sw+fw(-f(sp))
7450 next b
7460 if a=-1 then a=1 : goto 7410
7470 goto 7810
7480 rem ******** laeufer/dame *********
7490 b=-1
7500 for c=5 to 6
7510 a=p+b*fa(c)
7520 if f(a)<=0 then sw=sw+fw(-f(a))
7530 if f(a)<>0 then 7560
7540 a=a+b*fa(c)
7550 goto 7520
7560 next c
7570 if b=-1 then b=1 : goto 7500
7580 if f(p)<>7 then 7810
7590 rem ********** turm/dame **********
7600 b=-1
7610 for c=7 to 8
7620 a=p+b*fa(c)
7630 if f(a)<=0 then sw=sw+fw(-f(a))
7640 if f(a)<>0 then 7670
7650 a=a+b*fa(c)
7660 goto 7630
7670 next c
7680 if b=-1 then b=1 : goto 7610
7690 goto 7810
7700 rem *********** koenig ************
7710 b=-1
7720 for c=5 to 8
7730 sp=f(p+b*fa(c))
7740 if sp>0 and ro=0 then 7760
7750 sw=sw+fw(abs(sp))
7760 next c
7770 if b=-1 then b=1 : goto 7720
7780 rem ******************************
7790 rem *** wertung/computer/ende ****
7800 rem ******************************
7810 next p
7820 f(sk)=f(zk) : f(zk)=fz
7830 bs(zn)=sw : sk(zn)=sk : zk(zn)=zk
7840 return
7850 rem 
7860 rem 
7870 rem 
7880 rem *** bildschirm leeren (oben 5 zeilen) ***
7900 print chr$(19);zf$
7910 for a=1 to 18:print:next
7930 for a=1 to 5:print tab(12)"                ":next
7950 for a=1 to 5:print chr$(145);:next
7960 return

