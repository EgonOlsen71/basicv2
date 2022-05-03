0 rem @ \protocol
10 rem @ \fastfor:\shortif:\datatype byte
12 rem @ \word #,i=fast,x=fast
13 rem @ \constant vic,back,paper,spron,prior,scol,xhi,irq,off,vol,mem
15 rem @ \byte a,x1,x2,y1,y2,xa,xe,ya,ye,co,cc,sx,sy,v1,h1,v2,h2,y(,ys(,co(
16 rem @ \byte p2(,sn
17 dim sc(24),co(23),x(7),y(7),xs(7),ys(7),p2(7)
20 vic=53248:back=vic+32:paper=vic+33: spren=vic+21:off=vic+17:irq=56333
21 xhi=vic+16:scol=vic+39:pri=vic+27: mem=2040
22 vol=54272+24
28 gosub 13000: rem vorbereitung
29 poke back,0: poke paper,0: poke spren,0
30 print "{5}{8}{ct n}{clr} *** Basic-Boss ***"
32 print "{control-q}Programmieren in Basic mit der"
34 print "Geschwindigkeit von Maschinensprache !"
40 print "{control-q}{gray}Unmoeglich? Nein!"
42 print "Dieses Programm wurde von vorne bis"
44 print "hinten in Basic programmiert."
50 print "Dann wurde es vom Basic-Boss in reine"
52 print "Maschinensprache uebersetzt."
60 print "{control-q}Bitte ueberzeugen Sie sich von seiner"
70 print "Geschwindigkeit !"
90 goto 20000
100 print "{clr}{control-q}{control-q} So sieht es aus, wenn die Bild-"
110 print "{control-q} schirmfarbe in schneller Folge"
120 print "{control-q} veraendert wird:": gosub 10020
130 poke irq,127: rem interrupt aus
135 poke off,0: rem bildschirm aus
150 for i=0 to 60000
180 poke back,14
190 poke back,3
200 poke back,3
210 poke back,14
220 poke back,6
240 next i
250 poke irq,129: poke off,27
253 print "{clr}{control-q}{control-q} oder so:": gosub 10020
265 poke irq,127: rem interrupt aus
266 poke off,0: rem bildschirm aus
270 for i=0 to 30000
271 poke back,0
272 poke back,2
273 poke back,2
274 poke back,2
275 poke back,8
276 poke back,8
277 poke back,8
280 poke back,7
281 poke back,1
282 poke back,1
283 poke back,7
284 poke back,8
285 poke back,8
286 poke back,8
287 poke back,2
288 poke back,2
289 poke back,2
290 poke back,2
291 poke back,0
295 next 
300 poke irq,129: poke off,27: return 
305 :
310 print "{clr}{control-q}{control-q} Wenn ein mit dem Basic-Boss"
320 print "{control-q} compiliertes Basicprogramm den"
330 print "{control-q} Bildschirm bearbeitet, sieht das"
340 print "{control-q} so aus:"
350 gosub 10020:x1=10:x2=1:y1=14:y2=4
355 gosub 11000
360 i=0
370 x1=x1+33: if x1>=40 then x1=x1-40
375 x2=x2+17: if x2>=40 then x2=x2-40
380 y1=y1+21: if y1>=25 then y1=y1-25
385 y2=y2+7 : if y2>=25 then y2=y2-25
390 co=(co+1 and 15)
395 gosub 12000
400 i=i+1
405 if i<1000 and peek(198)=0 then 370
410 mu=11: gosub 14000: print "{control-s}{control-q}{control-q} oder so:"
415 gosub 10020
420 gosub 11000:h1=1:v1=2:h2=2:v2=1:i=0
425 x1=1:y1=2:x2=37:y2=22:cc=1
430 if x1 =0 then h1=-h1
440 if x2<=1 then h2=-h2
450 if y1 =0 then v1=-v1
460 if y2 =0 then v2=-v2
470 if x1 =39 then h1=-h1
480 if x2>=38 then h2=-h2
490 if y1 =24 then v1=-v1
500 if y2 =24 then v2=-v2
510 x1=x1+h1:x2=x2+h2
520 y1=y1+v1:y2=y2+v2
525 co=co(cc):cc=cc+1: if cc>23 then cc=0
530 gosub 12000
540 i=i+1: if i<1000 and peek(198)=0 then 430
550 mu=500: gosub 14000: return 
560 :
570 print "{clr}Nun huepfen ein paar Sprites ueber"
580 print "{control-q}den Bildschirm. Allerdings ergibt sich"
590 print "{control-q}hier ein Problem: Das Programm ist"
600 print "{control-q}zu schnell. Es muss also gebremst"
605 print "{control-q}werden:": goto 1000
610 :
620 for i=0 to 7
630 poke mem+i,13
640 poke scol+i,i+1
645 x(i)=130+i*25:y(i)=50+i*18
647 xs(i)=-i:ys(i)=i
650 next i
660 poke pri,0: poke spren,255
662 a=0:c=0
665 :
670 for i=0 to 7
690 if x(i) and 256 then poke xhi,peek(xhi) or p2(i): goto 710
700 poke xhi,peek(xhi) and (255-p2(i))
710 poke vic+i+i,x(i) and 255
715 poke vic+1+i+i,y(i)
720 x(i)=x(i)+xs(i)
730 y(i)=y(i)+ys(i)
740 if x(i)>320 then x(i)=640-x(i):xs(i)=-xs(i): gosub 950
750 if x(i)<24 then x(i)=48-x(i):xs(i)=-xs(i): gosub 950
760 if y(i)<50 then y(i)=100-y(i):ys(i)=-ys(i): gosub 950
770 if y(i)>229 then y(i)=458-y(i):ys(i)=-ys(i): gosub 950
800 rem beschleunigung x und y
810 if a<3 then 880
820 xs(i)=xs(i)-1:ys(i)=ys(i)+1
880 next i
882 if a=3 then a=0
883 a=a+1
886 rem auf rasterstrahl warten
887 if b then if (peek(53248+17) and 128)=0 then 887
890 if peek(198)=0 then 670
900 poke 198,0: return 
950 poke vol,sn:sn=15-sn: return 
990 end 
999 :
1000 gosub 10600:b=0: gosub 610
1010 print "{control-q}{control-q}jetzt ist es gebremst und wird"
1020 print "{control-q}{control-q}mit dem Rasterstrahl synchronisiert."
1030 gosub 10600
1050 b=-1: gosub 610
1090 return 
9999 :
10000 ti$="000000": goto 10100
10010 ti$="000030": goto 10100
10020 ti$="000035": goto 10100
10100 gosub 10600: goto 10500
10500 poke 198,0
10510 get a$: if a$="" and ti$<"000040" then 10510
10520 return 
10600 print "{control-q}{control-q}{control-q} - Taste -": return 
10998 :
11000 for i=1024 to 2023: poke i,160: next 
11010 return 
11997 :
11998 rem rechteck zeichnen mit farbe (x1,y1,x2,y2,ch,co)
11999 rem (x1,y1,x2,y2,ch,co)
12000 if x2>=x1 then xa=x1:xe=x2: goto 12002
12001 xa=x2:xe=x1
12002 if y2>=y1 then ya=y1:ye=y2: goto 12050
12003 ya=y2:ye=y1
12050 for y=sc(ya) to sc(ye) step 40
12060 for x=y+xa to y+xe
12070 poke x,co: next x,y
12090 return 
12998 :
12999 rem multiplikationstabelle
13000 for i=0 to 24:sc(i)=55296+i*40: next 
13010 rem farben einlesen
13020 for a=0 to 23: read co(a): next 
13030 mp=0
13040 for a=0 to 7:p2(a)=2^a: next 
13050 for i=832 to 832+62
13060 read a: poke i,a: next i
13090 return 
13499 rem farbdaten
13500 data 0,6,14,3,1,3,14,6,0,2,8,7,1,7,8,2,0,11,5,13,1,13,5,11
13599 rem spritedaten
13600 data 0,255, 0, 3,255,192, 15
13601 data 255,240, 31,255,248, 63,255
13602 data 252,127,255,254,127,255,254
13603 data 255,255,255,255,255,255,255
13604 data 255,255,255,255,255,255,255
13605 data 255,255,255,255,255,255,255
13606 data 127,255,254,127,255,254, 63
13607 data 255,252, 31,255,248, 15,255
13608 data 240, 3,255,192, 0,255, 0
13998 :
13999 rem bildschirm loeschen (mu)
14000 i=1024:a=21
14010 for a=1 to 5: next a
14020 poke i,32:i=i+mu
14030 if i>=2045 then i=i-1021
14040 if i<>1024 then 14010
14050 return 
20000 :
20010 print "{control-q}{ctrl ;}{ctrl ;}Waehlen Sie:"
20020 print "{control-q} 1...Bildschirmdemo"
20030 print " 2...Spritedemo"
20040 print " 3...Hintergrunddemo"
20050 print " 4...Noch was"
20090 print "{control-q}{control-q}(Thilo Herrmann, 1988)"
20092 :
20094 :
20100 ti$="000000": gosub 10500
20110 if a$>="1" and a$<="4" then mp=val(a$): goto 20130
20120 if a$<>"" then 20100
20125 mp=mp+1: if mp>4 then mp=1
20130 on mp gosub 310,570,100,21000
20140 goto 29
21000 print "{clr}{control-q}{control-q}Sie sollten zum Vergleich mal die"
21010 print "Basic-Version dieses Programmsady."
21015 print "ablaufen lassen !"
21020 print "{control-q}Das Basicprogramm zeigt auch, dass"
21030 print "der Programmierer alle Moeglichkeiten"
21040 print "von Basic ausreizen kann, ohne dass er"
21050 print "unnoetig eingeschraenkt wird."
21060 print "{control-q}Denn ausser solchen Bildschirm-"
21070 print "spielereien kann man auch ernstere"
21080 print "Anwendungen programmieren, da der"
21090 print "Basic-Boss z.B. eine wesentlich"
21100 print "leistungsfaehigere Stringverwaltung"
21110 print "besitzt als der Basicinterpreter. Darum"
21120 print "ist nun auch die Garbage-Collection"
21130 print "um einiges schneller.": gosub 10000
21140 print "{clr}Was das heisst, werden Sie merken,"
21150 print "wenn Sie folgendes Programm ablaufen"
21160 print "lassen:{control-q}"
21170 print "10 dim a$(2000)"
21180 print "20 for i=1 to 2000"
21190 print "30 a$(i)=chr$(65):next i"
21200 print "40 ti$="000000":print"chr$(34)"frei"chr$(34)"fre(0);ti/60"
21210 print "{control-q}Allein der FRE-Befehl benoetigt ca."
21220 print "339 Sekunden, da er eine Garbage-"
21230 print "Collection ausloest."
21240 print "{control-q}Das gleiche Programm koennen Sie nun"
21250 print "in der compilierten Version starten: ": gosub 10000
21260 print "{clr}{control-q}{control-q} gestartet..."
21300 dim a$(2000)
21310 for i=1 to 2000
21320 a$(i)=chr$(65): next i
21330 ti$="000000": print "frei"fre(0);ti/60
21335 print "{control-q}{control-q}Damit ist die Garbage-Collection"
21336 print "{control-q}in diesem Fall etwa 680 mal schneller !"
21340 gosub 10010
21400 print "{clr}{control-q}{control-q}Die Leistungsdaten des Basic-Boss:"
21410 print "{control-q}- kurze Compilate"
21420 print "- optimierter und effizienter Code"
21430 print "- sehr schnelle Variablentypen"
21440 print "- extrem kurze Compilierzeiten"
21450 print "- eine hochflexible Compilerarchitektur"
21460 print "- 62 KByte Basicspeicher"
21470 print "- eine schnelle FOR-NEXT-Schleife"
21480 print "- gepackte und schnelle Daten bei DATA"
21490 print "- stark beschleunigte Arrays"
21500 print "- beliebig lange Variablennamen"
21510 print "- genaue deutsche Fehlermeldungen"
21520 print "- Erzeugung echten Maschinencodes"
21525 print "- kein Kopierschutz"
21530 print "{control-q}{control-q} und noch einiges mehr..."
21540 gosub 10000
21550 print "{clr}{control-q}{control-q}{control-q} Ich bin jedem dankbar, der dieses"
21560 print " {control-q}Demoprogramm weiterverbreitet."
21570 goto 10000
