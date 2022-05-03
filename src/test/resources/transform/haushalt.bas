1 REM *****************
2 REM **  HAUSHALT   **
6 REM **     BY      **
8 REM ** M. WOESSNER **
9 REM *****************
10 DIMMO$(12):DIMM(12)
20 DIMPU$(15,2):DIMNU(15)
30 DIMGS(15)
40 DIMGS$(15)
50 DIMP$(15)
60 PRINT"{clear}"
70 GOSUB30000
80 PRINTCHR$(14)
1000 FORI=49152TO49256
1010 READX:POKEI,X:S=S+X:NEXT
1020 REM
1030 FORN=1TO12:READMO$(N):NEXTN
1040 REM
1050 FORN=1TO15:READPU$(N,1):NEXTN
1060 FORN=1TO15:PU$(N,2)="{reverse on}"+PU$(N,1):NEXTN
1070 REM
2000 POKE53281,0:POKE53280,0:PRINT"{clear}":PRINTCHR$(14)
2010 PRINT"{cyan}{down*3}{right*2}Wollen Sie eine Datei laden (J/N)"
2030 GETA$:IFA$=""THEN2030
2040 IFA$="j"THEN10110:REM LADEROUTINE
2041 REM ***
2050 PRINT"{up}{right*2}Wollen Sie das Directory sehen (J/N)"
2060 GETA$:IFA$=""THEN2060
2070 IFA$="j"THEN10010:REM DIRECTORY
2080 PRINT"{up}{right*2}{space*4}Wollen Sie eine Gesamtsumme{space*5}"
2090 PRINT"{down}{right*2}von mehreren Monaten erstellen (J/N)"
2100 GETA$:IFA$=""THEN2100
2110 IFA$="j"THEN10510:REM GESAMTSUMME
2111 REM ***
2120 PRINT"{clear}"
2130 PRINT"{down*3}{right*2}Wollen Sie das Programm beenden (J/N)"
2140 GETA$:IFA$=""THEN2140
2150 IFA$="j"THEN10810:REM SICHER ??
2151 REM ***
2160 PRINT"{clear}{space*15}{reverse on}{purple}HAUSHALT{cyan}"
2170 REM EINGABE
2180 PRINT"{down*2}":PRINTCHR$(14):A$="1":PU=2
2185 FORN=1TO15:PRINT"....................":NEXTN
2186 PRINT"{home}{down*4}"
2190 FORN=1TO15:PRINTPU$(N,1):NEXTN
2191 PRINT"{home}{down*4}"
2192 FORN=1TO15:PRINTTAB(20)GS$(N):NEXTN
2200 PRINT"{down}{right}Cursorbewegung mit <CRSR UP/DOWN>"
2205 PRINT"{right}'RETURN' fuer Eingabe"
2210 PRINT"{right}'S' fuer Sonstiges (z.B. GESAMTSUMMEN)":PRINT"{home}{down*6}"
2220 REM
2229 IFA$="1"THEN2235
2230 GETA$:IFA$=""THEN2230
2235 IFA$<>CHR$(13)THENPRINT"{up}";PU$(PU,1)
2240 IFA$=CHR$(17)THENPU=PU+1
2250 IFA$=CHR$(145)THENPU=PU-1
2260 IFA$=CHR$(13)THENGOSUB5000
2261 IFPU>15THENPU=1
2262 IFPU<1THENPU=15
2263 IFA$="s"THEN15010
2270 PRINT"{home}"
2286 FORN=1TOPU+3:PRINT"{down}";:NEXTN
2290 PRINTPU$(PU,2)
2300 GOTO2230
5000 PRINT"{home}":SU$=""
5010 INPUT"{down*2}{yellow}SUMMENEINGABE{cyan}";SU$:PRINT
5011 IFPEEK(1184)<>32THENV=1
5012 PRINT"{up*2}{space*15}{up}{left*2}{space*23}":IFV=1THENV=0:GOTO5000
5013 GOTO12000
5014 SU=VAL(SU$)
5020 GS(PU)=GS(PU)+SU
5025 PRINT"{home}{down*3}{space*35}"
5030 PRINT"{home}{down*4}"
5035 Y=GS(PU):GOSUB20000:GS$(PU)=Y$
5040 FORN=1TO15:PRINTTAB(20);GS$(N):NEXT
5050 RETURN
9999 END
10000 REM **DIRECTORY**
10010 PRINT"{clear}"
10020 SYS49152
10030 PRINT"{down}Taste"
10040 GETA$:IFA$=""THEN10040
10050 IFOK=0THENGOTO2000
10051 GOTO2160
10055 OK=0:GOTO2160
10060 REM
10100 REM **LADEN**
10110 PRINTCHR$(142)
10120 PRINT"{clear}"
10130 PRINT"{space*7}{reverse on}unterroutine datei laden"
10140 INPUT"{down*2}dateiname{space*2}(monat)";MO$
10150 INPUT"{down*2}jahr z.b. 1986";J$
10170 OPEN2,8,2,MO$+" "+J$+",s,r"
10180 FORN=1TO15
10190 INPUT#2,Z
10200 GS(N)=Z:Z=0
10210 NEXTN
10221 REM ** FEHLERKANAL **
10230 CLOSE2
10233 FORQ=1TO15:Y=GS(Q):GOSUB20000:GS$(Q)=Y$:Y$="":NEXTQ
10235 IFFE=1THENFE=0:GOTO10100
10240 GOTO2160
10250 END
10260 REM
10300 REM ** SPEICHERN **
10310 PRINT"{clear}{down}{space*5}{reverse on}unterroutine datei speichern"
10311 PRINTCHR$(142)
10315 INPUT"{down*2}{right}dateiname (monat)";MO$
10320 INPUT"{down*2}{right}jahr z.b. 1986{space*3}";J$
10330 INPUT"{down*2}{right}alte datei ueberschreiben (j/n)";UE$
10340 IFUE$="j"THENUE$="@:":GOTO10360
10350 IFUE$<>"j"THENUE$=""
10360 OPEN2,8,2,UE$+MO$+" "+J$+",s,w"
10370 FORN=1TO15
10380 Z=GS(N)
10390 PRINT#2,Z
10400 NEXTN
10410 GOSUB10710
10411 REM ** FEHLERKANAL **
10420 CLOSE2
10425 IFFE=1THENFE=0:GOTO10300
10430 PRINTCHR$(14):PRINT"{clear}":RETURN
10440 END
10450 REM
10460 REM
10500 REM ** JAHRESSUMMEN **
10510 PRINT"{clear}";CHR$(142)
10520 PRINT"{down}{space*8}{reverse on}"UNTERROUTINE JAHRESSUMME"
10540 INPUT"{down*2}von wievielen monaten (1-12)";X
10542 PRINT"{clear}{down}1=januar 2=februar 3=maerz 4=april"
10543 PRINT"5=mai{space*4}6=juni{space*4}7=juli{space*2}8=august"
10544 PRINT"9=sept. 10=okt.{space*3}11=nov. 12=dezember"
10545 FORN=1TOX:INPUT"{down}monat (1-12)";M(N):PRINT"ok":FORP=0TO500:NEXT P
10546 PRINT"{up}{space*2}{up}{left*2}{space*17}{up*2}"
10547 IFM(N)<1ORM(N)>12THEN10540
10548 NEXTN
10550 IFX>12ORX<1THENPRINT"{up*4}":GOTO10540
10560 INPUT"{down*2}von welchem jahr (z.b.1986)";J$
10570 FORP=1TOX:M=M(P)
10580 OPEN2,8,2,MO$(M)+" "+J$+",s,r"
10590 FORN=1TO15
10600 INPUT#2,NU(N)
10610 GS(N)=GS(N)+NU(N)
10620 NEXTN
10630 GOSUB10710
10631 REM ** FEHLERKANAL **
10635 IFFE=1THENFE=0:GOTO10510
10640 CLOSE2:PRINTMO$(M);"{space*13}"
10650 NEXTP
10651 FORQ=1TO15:Y=GS(Q):GOSUB20000:GS$(Q)=Y$:Y$="":NEXTQ
10660 GOTO2160
10670 REM
10680 REM
10690 END
10700 REM **FEHLERKANAL**
10710 PRINT"{down}"
10711 OPEN1,8,15
10720 INPUT#1,A,B$,C,D
10725 CLOSE1
10730 PRINTA;B$;C;D:PRINT"{down}"
10740 PRINT"taste{up}":IFA<>0THENFE=1
10750 GETA$:IFA$=""THENGOTO10750
10751 PRINT"{space*5}{up*6}"
10760 IFFE<>0THENPRINTCHR$(14):CLOSE2:GOTO2000
10770 RETURN
10780 REM
10790 END
10800 REM ** PROGRAMM ENDE **
10810 PRINT"{clear}{down*2}Sind Sie sicher (J/N)"
10820 GETA$:IFA$=""THEN10820
10825 IFA$="j"THEN10840
10830 RUN
10840 NEW
10850 REM
10860 REM
10870 END
11000 REM ** DRUCKROUTINE **
11010 PRINT"{clear}":E$="":M$="":J$="":PRINTCHR$(142)
11020 PRINT"{down}{space*8}{reverse on}unterroutine drucken"
11030 INPUT"{down*2}{right*2}monat";M$:IFM$=""THEN11090
11040 FORN=1TOLEN(M$)
11050 E=ASC(MID$(M$,N,1))
11060 IFE>64THENE$=E$+CHR$(E+32)
11061 IFE<=64THENE$=E$+CHR$(E)
11070 NEXTN
11080 M$=E$
11090 INPUT"{down*2}{right*2}jahr";J$
11100 OPEN1,4,8
11110 PRINT#1,CHR$(27)+"-"+CHR$(1)+CHR$(14);
11120 CLOSE1
11130 OPEN1,4,7
11140 PRINT#1,M$;" ";J$:PRINT#1
11150 PRINT#1,"GESAMTSUMMEN":CLOSE1
11160 OPEN1,4,8:PRINT#1,CHR$(27)+"-"+CHR$(0);
11170 PRINT#1
11180 CLOSE1
11190 OPEN1,4,7
11200 FORN=1TO15
11210 P$(N)=PU$(N,1)
11220 NEXTN
11230 FORN=1TO15
11240 IFLEN(P$(N))<22THENP$(N)=P$(N)+" ":GOTO11240
11250 NEXTN
11270 FORN=1TO15
11280 PRINT#1,P$(N);"DM";GS$(N)
11290 NEXTN
11350 PRINT#1
11360 PRINT#1,"GESAMTSUMME";GE$;" DM"
11370 CLOSE1
11380 OPEN1,4,8:PRINT#1,CHR$(27)+"3";:CLOSE1
11390 OPEN1,4,7
11400 PRINT#1,"{space*13}-------------"
11410 CLOSE1
11420 OPEN1,4,8
11430 PRINT#1,CHR$(27)+"@":PRINT#1,CHR$(12):CLOSE1
11440 PRINTCHR$(14):RETURN
12000 FORN=1TOLEN(SU$)
12010 A$=MID$(SU$,N,1)
12020 IFA$<"0"ORA$>"9"THENV=1
12021 IFA$<>"-"ANDV=1THENV=2
12025 IFV=2ANDA$<>"."THENV=3
12026 IFA$=""THENV=0:GOTO5014
12027 IFV=3THENPRINTTAB(10)"{space*19}":V=0:GOTO5000
12028 V=0
12060 NEXTN
12070 GOTO5014
14999 END
15000 REM ** GESSUMMENAUSG. **
15010 PRINT"{clear}":GE=0
15011 GOTO40000
15020 PRINT"{space*12}{light blue}{reverse on}GESAMTSUMMEN"
15030 PRINT"{down}{cyan}"
15031 FORN=1TO15:IFGS$(N)=""THENGS$(N)="{space*5}0.00"
15032 NEXTN
15040 FORN=1TO15:PRINTPU$(N,1);TAB(20);GS$(N):NEXTN
15041 FORN=1TO15:GE=GE+GS(N):NEXTN:Y=GE:GOSUB20000:GE$=Y$
15042 PRINT"{down}{reverse on}GESAMTSUMME ";GE$;"{reverse on} DM"
15050 PRINT"{down}TASTE"
15060 GETA$:IFA$=""THEN15060
15070 PRINT"{clear}{down*2}{right*2}Gesamtsummen drucken (J/N)"
15080 GETA$:IFA$=""THEN15080
15090 IFA$="j"THENGOSUB11010
15091 REM *********-----**DRUCKROUTINE
15100 PRINT"{clear}{up}{right*2}Gesamtsummen Abspeichern (J/N)"
15110 GETA$:IFA$=""THEN15110
15120 IFA$="j"THENGOSUB10310
15121 REM *********-----**SPEICHERN
15130 PRINT"{up}'N' fuer neuen Programmstart{space*6}"
15140 PRINT"{down}'A' zum Veraendern der alten Werte"
15150 GETA$:IFA$=""THEN15150
15160 IFA$="a"THENPU=1:GOTO2160
15170 IFA$="n"THENRUN
15180 GOTO15150
15190 REM
15200 REM
20000 Y$=STR$(Y)
20010 FORN=1TOLEN(Y$)
20020 IFMID$(Y$,N,1)="."THEN20060
20030 NEXTN
20040 Y$=Y$+"."
20050 N=LEN(Y$)
20060 Y$=Y$+"00"
20070 Y$=LEFT$(Y$,N+2)
20080 IFLEFT$(Y$,2)=" ."THENY$="0"+MID$(Y$,2,LEN(Y$))
20090 N=LEN(Y$)
20100 IFLEN(Y$)<9THENY$=" "+Y$:GOTO20100
20120 RETURN
21000 REM *ABSPEICHERN DER EINZELPOSTEN
21010 PRINT"{clear}":PRINTCHR$(142)
21020 PRINT"{down}{space*6}{reverse on}abspeichern der einzelposten{down*3}"
21030 INPUT"{down}name (z.b.januar)";MO$
21040 INPUT"{down}jahr (z.b. 1986)";J$
21050 INPUT"{down}alte datei ueberschreiben (j/n)";UE$
21060 IFUE$="j"THENUE$="@:":GOTO21080
21070 IFUE$<>"j"THENUE$=""
21080 OPEN2,8,2,UE$+MO$+" "+J$+" eipu"+",s,w"
21090 FORN=1TO15
21100 PRINT#2,PU$(N,1)
21105 PRINT#2,PU$(N,2)
21110 NEXTN:CLOSE2
21120 GOSUB10710:PRINTCHR$(14)
21130 REM**-----** FEHLERKANAL
21140 IFFE=1THENFE=0:GOTO21000
21150 GOTO40000
21160 REM ** ENDE **
22000 REM **EINZELPOSTEN LADEN**
22010 PRINT"{clear}":PRINTCHR$(142)
22020 PRINT"{down}{space*8}{reverse on}laden der einzelposten{down*3}"
22030 INPUT"{down*2}name (z.b.januar)";MO$
22040 INPUT"{down*2}jahr (z.b. 1986)";J$
22050 OPEN2,8,2,MO$+" "+J$+" eipu"+",s,r"
22060 FORN=1TO15
22070 INPUT#2,PU$(N,1)
22080 INPUT#2,PU$(N,2)
22090 NEXTN
22100 CLOSE2
22110 GOSUB10710
22120 REM ** FEHLERKANAL **
22130 IFFE=1THENFE=0:GOTO22000
22140 PRINTCHR$(14)
22150 GOTO40000
22999 END
30000 PRINT"{clear}":POKE53281,0:POKE53280,0
30010 PRINTTAB(16)"{down*3}{yellow}MUCKSOFT"
30020 PRINTTAB(16)"{down}{green}PRESENTS"
30030 PRINT"{down*4}"
30040 PRINT"{light blue}{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off}{space*3}{reverse on}{space*3}{reverse off}
30050 PRINT"{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*3}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*4}{reverse on} "
30060 PRINT"{space*5}{reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off}{space*4}{reverse on} "
30070 PRINT"{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*3}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off}{space*4}{reverse on} "
30080 PRINT"{space*5}{reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off} {reverse on}{space*3}{reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on} {reverse off} {reverse on}{space*3}{reverse off}{space*2}{reverse on} "
30090 RETURN
30999 END
40000 PRINT"{clear}{down*2}{space*7}{reverse on}UNTERROUTINE{sh space}SONSTIGES"
40010 PRINT"{down*3}Waehlen Sie:"
40020 PRINT"{down}'1' fuer Gesamtsummenausgabe"
40030 PRINT"{down}'2' zum Definieren einzelner Punkte"
40040 PRINT"{down}'3' fuer Rueckkehr ins Eingabemenue"
40041 PRINT"{down}'4' zum Laden einer Datei"
40042 PRINT"{down}'5' zum Anzeigen des Directorys"
40043 PRINT"{down}'6' zum Abspeichern der Eingabepunkte"
40044 PRINT"{down}'7' zum Laden der Eingabepunkte"
40050 GETA$:IFA$=""THEN40050
40060 IFA$="1"THENPRINT"{clear}":GOTO15020
40070 IFA$="2"THEN40500
40080 IFA$="3"THEN2160
40081 IFA$="4"THEN10110
40082 IFA$="5"THENOK=1:GOTO10010
40083 IFA$="6"THEN21010
40084 IFA$="7"THEN22010
40090 GOTO40050
40500 PRINT"{clear}{space*9}{reverse on}UNTERROUTINE{sh space}DEFINIEREN":A$=""
40510 REM
40520 PRINT"{down}{right}Welchen Wert wollen Sie veraendern ?"
40530 PRINT"{right}Geben Sie die Zahl ein."
40531 PRINT"{right}'0' fuer Zurueckdefinition in normale"
40532 PRINT"{right}Werte."
40533 PRINT"{right}'RETURN' fuer Ende{down}"
40540 FORN=1TO15:IFN<10THENPRINTN;"{space*5}";PU$(N,1):NEXTN
40541 IFN>9THENPRINTN;"{space*4}";PU$(N,1):NEXTN
40550 INPUT"{down}{right}ALSO:";VE$:VE=VAL(VE$):IFVE$="0"THENVE$="":GOTO40700
40551 IFVE<1ORVE>15THEN2160
40552 IFVE$=""THEN2160
40560 VE$="":PRINT"{clear}{down}{right*2}In was soll{space*3}";PU$(VE,1)
40570 INPUT"{down}{right*2}veraendert werden (max 20 Buchstaben){down}{right*2}";A$
40571 IFLEN(A$)>20THENPRINT"{up*4}":GOTO40570
40580 PU$(VE,1)=A$:A$="":PU$(VE,2)="{reverse on}"+PU$(VE,1)
40590 PRINT"{clear}"
40600 GOTO40500
40700 RESTORE
40710 FORI=49152TO49256
40720 READX:NEXT
40730 FORN=1TO12:READX$:NEXTN
40740 FORN=1TO15:READPU$(N,1):NEXTN
40750 FORN=1TO15:PU$(N,2)="{reverse on}"+PU$(N,1):NEXTN
40760 GOTO40500
50020 DATA169,36,133,251,169,251,133,187,169,0,133,188
50030 DATA169,1,133,183,169,8,133,186,169,96,133,185
50040 DATA32,213,243,165,186,32,180,255,165,185,32,150
50050 DATA255,169,0,133,144,160,3,132,251,32,165,255
50060 DATA133,252,164,144,208,47,32,165,255,164,144,208
50070 DATA40,164,251,136,208,233,166,252,32,205,189,169
50080 DATA32,32,210,255,32,165,255,166,144,208,18,170
50090 DATA240,6,32,210,255,76,76,192,169,13,32,210
50100 DATA255,160,2,208,198,32,66,246,96
50110 REM
50120 DATAJANUAR,FEBRUAR,MAERZ,APRIL,MAI,JUNI,JULI,AUGUST,SEPTEMBER,OKTOBER
50130 DATANOVEMBER,DEZEMBER
50140 REM
50150 DATA"Benzin"
50160 DATA"Auto sonstiges"
50170 DATA"Kleidung"
50180 DATA"Medizin+Hygiene"
50190 DATA"Hausrat"
50200 DATA"Haushalt"
50210 DATA"Taschengeld"
50220 DATA"Telefon"
50230 DATA"Garten"
50240 DATA"Grab"
50250 DATA"Sport+Freizeit"
50260 DATA"Bausparen+Hypotheken"
50270 DATA"Strom+Zeitung"
50280 DATA"Sontiges"
50290 DATA"Undefiniert"
