10 print rnd(ti),chr$(142)
20 poke 53280,0: poke 53281,0
30 for x=0 to 39
40 for y=0 to 24
50 a=55296+x+40*y
60 poke a,1
70 next y,x
80 for x=0 to 39
90 for y=0 to 24
100 a%=1024+x+40*y
110 poke a%,81
120 next y,x
130 for x=0 to 39
140 for y=0 to 24
150 a%=1024+x+40*y
160 z%=int(50*rnd(1))+1
170 b%=32
180 if z%=10 then b%=42
190 if z%=40 then b%=46
200 poke a%,b%
210 next y,x
220 poke 646,1
230 dim fe%(40,25),ri%(3)
240 for x=0 to 39
250 for y=0 to 24
260 fe%(x,y)=160
270 next y,x
280 fe%(1,0)=32
290 fe%(37,24)=32
300 fe%(1,1)=32
310 x%=-1:y%=1
320 x%=x%+2: if x%>37 then x%=1:y%=y%+2
330 if y%>23 then 490
340 a%=fe%(x%,y%)
350 if a%=160 then 320
360 xx%=x%:yy%=y%
370 ri%=0:ri%(1)=0:ri%(2)=0:ri%(3)=0
380 if xx%-2>0 then if fe%(xx%-2,yy%)=160 then ri%=ri%+1:ri%(ri%)=4
390 if xx%+2<39 then if fe%(xx%+2,yy%)=160 then ri%=ri%+1:ri%(ri%)=2
400 if yy%-2>0 then if fe%(xx%,yy%-2)=160 then ri%=ri%+1:ri%(ri%)=1
410 if yy%+2<25 then if fe%(xx%,yy%+2)=160 then ri%=ri%+1:ri%(ri%)=3
420 if ri%=0 then 320
430 a%=int(ri%*rnd(1))+1
440 if ri%(a%)=1 then yy%=yy%-1:fe%(xx%,yy%)=32:yy%=yy%-1:fe%(xx%,yy%)=32
450 if ri%(a%)=2 then xx%=xx%+1:fe%(xx%,yy%)=32:xx%=xx%+1:fe%(xx%,yy%)=32
460 if ri%(a%)=3 then yy%=yy%+1:fe%(xx%,yy%)=32:yy%=yy%+1:fe%(xx%,yy%)=32
470 if ri%(a%)=4 then xx%=xx%-1:fe%(xx%,yy%)=32:xx%=xx%-1:fe%(xx%,yy%)=32
480 goto 370
490 for x=0 to 39
500 for y=0 to 24
510 a%=1024+x+40*y
520 b%=fe%(x,y)
530 poke a%,b%
540 next y,x
550 xx%=0:yy%=0:ri%=0
560 ri%(1)=0:ri%(2)=0:ri%(3)=0
570 x%=1:y%=0
580 a%=1024+x%+40*y%
590 poke a%,81
600 xx%=37:yy%=24:zz%=1
610 a%=1024+xx%+40*yy%
620 poke a%,42
630 get a$
640 if a$="" then a%=1024+x%+40*y%: poke a%,81
650 if a$="q" then 960
660 if a$="w" then gosub 740
670 if a$="d" then gosub 800
680 if a$="s" then gosub 850
690 if a$="a" then gosub 910
700 gosub 1060
710 if x%=xx% and y%=yy% then poke 53280,2
720 if x%<>xx% or y%<>yy% then poke 53280,0
730 goto 630
740 if y%-1<0 then 790
750 if fe%(x%,y%-1)=160 then 790
760 a%=1024+x%+40*y%: poke a%,32
770 y%=y%-1
780 a%=1024+x%+40*y%: poke a%,81
790 return 
800 if fe%(x%+1,y%)=160 then 840
810 a%=1024+x%+40*y%: poke a%,32
820 x%=x%+1
830 a%=1024+x%+40*y%: poke a%,81
840 return 
850 if y%+1>24 then 900
860 if fe%(x%,y%+1)=160 then 900
870 a%=1024+x%+40*y%: poke a%,32
880 y%=y%+1
890 a%=1024+x%+40*y%: poke a%,81
900 return 
910 if fe%(x%-1,y%)=160 then 950
920 a%=1024+x%+40*y%: poke a%,32
930 x%=x%-1
940 a%=1024+x%+40*y%: poke a%,81
950 return 
960 for x=0 to 39
970 for y=0 to 24
980 a%=1024+x+40*y: poke a%,32
990 next y,x
1000 print "***************"
1010 print "*             *"
1020 print "* sabrinachen *"
1030 print "*             *"
1040 print "***************"
1050 clr : end 
1060 a%=zz%:ri%=0
1070 ri%(1)=0:ri%(2)=0:ri%(3)=0
1080 a%=a%-1: if a%<1 then a%=4
1090 gosub 1300
1100 a%=a%+1: if a%>4 then a%=1
1110 gosub 1300
1120 a%=a%+1: if a%>4 then a%=1
1130 gosub 1300
1140 if ri%=0 then gosub 1250
1150 a%=1024+xx%+40*yy%
1160 poke a%,32
1170 zz%=ri%(ri%)
1180 if zz%=1 then yy%=yy%-1
1190 if zz%=2 then xx%=xx%+1
1200 if zz%=3 then yy%=yy%+1
1210 if zz%=4 then xx%=xx%-1
1220 a%=1024+xx%+40*yy%
1230 poke a%,42
1240 return 
1250 a%=zz%
1260 a%=a%+1: if a%>4 then a%=1
1270 a%=a%+1: if a%>4 then a%=1
1280 ri%=ri%+1:ri%(ri%)=a%
1290 return 
1300 on a% goto 1320,1350,1370,1400
1310 goto 960
1320 if yy%-1<0 then 1340
1330 if fe%(xx%,yy%-1)=32 then ri%=ri%+1:ri%(ri%)=1
1340 goto 1410
1350 if fe%(xx%+1,yy%)=32 then ri%=ri%+1:ri%(ri%)=2
1360 goto 1410
1370 if yy%+1>24 then 1390
1380 if fe%(xx%,yy%+1)=32 then ri%=ri%+1:ri%(ri%)=3
1390 goto 1410
1400 if fe%(xx%-1,yy%)=32 then ri%=ri%+1:ri%(ri%)=4
1410 return 
