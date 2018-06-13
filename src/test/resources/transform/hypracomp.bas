10 rem     hypra-comp
11 rem von armin biernaczyk
12 rem an der papenburg 41
13 rem 4630 bochum 6
14 rem tel. (0 23 27) 3 55 76
15 :
100 gosub2210:gosub8010:end
130 :
1001 :
1002 : rem --- pass 1 initialisierung
1003 :
1010 poke53280,14:poke53281,6:tr$="1234"+"5":c0$=chr$(0):ge$=chr$(34)
1015 print"{clear}{down}{light blue}{reverse on}{space*4}**** basic v2 compiler v1.4 ****{space*4}"
1025 input"{down*2}{space*5}programmname :";na$:open1,8,15,"s:{pound}?":open2,8,2,na$+",p,r"
1030 input#1,a:close2:close1:ifa=0then1050
1032 print" disk error <space>"
1040 getch$:on(ch$=" ")+2goto1015,1040
1050 print"{down}{yellow}pass 1{light blue}":open1,8,15,"uj":fori=1to3000:next:close1
1058 open5,8,5,"{pound}d,p,w":print#5:close5
1060 open2,8,2,na$+",p,r":get#2,ch$,ch$:open4,8,4,"{pound}k,p,w":open3,8,3,"{pound}1,s,w"
1070 print#4:dimdi%(3),va$(120),va(120)
1075 df%=0:vz%=0:dz%=0:va=40960:an=5030+1:ad=an:tt%=0
1080 fori=828to834:readi%:pokei,i%:next:poke785,60:poke786,3:return
1097 :
1098 : rem --- zeilennummer holen
1099 :
1210 get#2,i$,j$:ifi$+j$=""thenprint#3,"{pi}{pi}";:fl%=0:return
1225 gosub40600:printasc(zl$)+asc(zh$)*256."{up}":print#3,zl$zh$;:fl%=-1:return
1241 :
1242 : rem --- konstante speichern
1243 :
1250 ifdf%thenclose5:df%=0:open4,8,4,"{pound}k,p,a"
1252 on2-kt%goto1270,1275:print#4,chr$(len(ko$))ko$;
1255 i=ad:gosub40010:print#3,chr$(kt%)hl$;:ad=ad+len(ko$)-(kt%=2):return
1270 ifko>255theni=ko:gosub40010:ko$=hl$:print#4,ko$;:goto1255
1272 print#3,"{ct g}"chr$(ko);:return
1275 i=usr(ko):ko$=tr$:print#4,ko$;:goto1255
1301 :
1302 : rem --- konstante einlesen
1303 :
1310 ko$="":kt%=2:i%=ch$<>ge$:ifi%thenko$=ch$
1315 get#2,ch$:ifch$=""thenreturn
1320 ifch$<>ge$and(ch$<>","ornoti%)thenko$=ko$+ch$:goto1315
1325 ifch$<>ge$thenreturn
1330 goto2090
1341 :
1350 ko$=ch$:kt%=-1
1355 gosub2090:ifch$<"0"orch$>"9"then1365
1360 ko$=ko$+ch$:goto1355
1365 ifch$="e"orch$="."thenkt%=0:goto1360
1370 if(ch$="{cm q}"orch$="{cm n}")andright$(ko$,1)="e"then1360
1375 ko=val(ko$):kt%=-(ko=int(ko)andabs(ko)<32768andkt%):return
1500 :
1501 : rem --- benutzerabfragen
1502 :
1510 printn1$n2$;:if(asc(n3$)and3)=1thenprint"%";:goto1520
1515 if(asc(n3$)and3)=2thenprint"$";
1520 ifasc(n3$)>3thenprint" (...)";
1525 print:return
1527 :
1530 print"{down*2}{space*3}variable: ";:gosub1510
1535 input"{down}{space*3}max. laenge";le:le=le+1
1540 print"{up*3}";:fori=1to3:print"{space*35}":next
1545 print"{up*5}";:return
1601 :
1610 print"{down*2}{space*3}feld: ";:gosub1510:di%(3)=0:di%(2)=0:di%(1)=0
1615 input"{down}{space*3}wieviele dimensionen";di%:ifdi%>3ordi%<1thenprint"{up*2}";:goto1615
1620 fori=1todi%:print"{space*3}dimension nr."i"{space*3}:";:inputdi%(i)
1625 ifdi%(i)<1ordi%(i)>32000thenprint"{up}";:i=i-1
1630 next:print"{space*3}ok ? (j/n)"
1635 geti$:ifi$=""then1635
1640 printleft$("{up*7}",di%+4);
1645 fori=1to7:print"{space*34}":next:print"{up*9}";
1650 ifi$<>"j"then1610
1655 va=va-(di%(1)+1)*(di%(2)+1)*(di%(3)+1)*le:ifva<=adthen60070
1660 i=va:gosub40010:print#4,hl$chr$(di%*2+1);
1665 di%(3)=di%(1)*di%(2)*le:di%(2)=di%(1)*le:di%(1)=le:forj=1todi%:i=di%(j)
1670 gosub40010:print#4,hl$;:next:ad=di%*2+3+ad:return
1701 :
1702 : rem --- variablenname lesen
1703 :
1710 n1$=ch$:get#2,ch$:n2$=ch$:i%=-1
1715 if(ch$>"9"orch$<"0")and(ch$>"z"orch$<"a")goto1725
1720 get#2,ch$:i%=0:goto1715
1725 ifi%thenn2$=c0$
1730 n3$=chr$(-(ch$="%")-2*(ch$="$")):ifn3$=c0$then1740
1735 get#2,ch$
1740 ifch$=" "then1735
1745 ifch$="("thenn3$=chr$(asc(n3$)+4):gosub2090
1750 va$=n1$+n2$+n3$:return
1801 :
1802 : rem --- variablenadresse holen
1803 :
1810 gosub1710:i%=1
1811 ifva$=left$(va$(i%),3)then1820
1812 i%=i%+1:ifi%<=vz%then1811
1815 goto1835
1820 i=va(i%):gosub40010:print#3,mid$(va$(i%),3,1)hl$;
1825 iflen(va$(i%))=4thenprint#3,right$(va$(i%),1);
1830 return
1835 ifva$="st"+c0$thenprint#3,"{ct c}{ct a}"chr$(111);:return
1840 ifva$="ti"+c0$thenprint#3,"{ct c}"c0$chr$(112);:return
1845 ifva$="ti{ct b}"thenprint#3,"{ct c}{ct b}"chr$(113);:return
1850 vz%=vz%+1:va$(vz%)=va$:ifn3$=c0$thenva=va-5:va(vz%)=va:i%=vz%:goto1820
1855 ifn3$="{ct a}"thenva=va-2:va(vz%)=va:i%=vz%:goto1820
1860 ifn3$="{ct b}"thengosub1530:va=va-le:va(vz%)=va:i%=vz%:goto1820
1865 ifn3$<"{ct f}"thenle=-(n3$="{ct d}")*5-(n3$="{white}")*2:goto1875
1870 gosub1530
1875 gosub1610:va(vz%)=ad-3-2*di%:i%=vz%:va$(vz%)=va$(vz%)+chr$(di%):goto1820
1900 :
1902 : rem --- datazeilenbearbeitung
1903 :
1910 ifnotdf%thenclose4:df%=-1:open5,8,5,"{pound}d,p,a"
1912 gosub2090
1915 ifch$=""orch$=":"thendz%=dz%+3:print#5,"{ct a}"c0$c0$;:return
1920 ifch$=","thendz%=dz%+3:print#5,"{ct a}"c0$c0$;:goto1912
1925 if(ch$>"9"orch$<"0")andch$<>"+"andch$<>"-"then1940
1927 ifch$="+"thench$="{cm n}"
1928 ifch$="-"thench$="{cm q}"
1930 gosub1350:onkt%goto1932:dz%=dz%+6:i=usr(ko):print#5,c0$tr$;:goto1945
1932 ifko<0thenko=65536+ko
1935 dz%=dz%+3:i=ko:gosub40010:print#5,"{ct a}"hl$;:goto1945
1940 gosub1310:i%=len(ko$):dz%=dz%+i%+2:print#5,"{ct b}"chr$(i%)ko$;
1945 ifch$=""orch$=":"thenreturn
1950 ifch$=","then1912
1955 goto60030
2000 :
2001 : rem --- tokenvorbearbeitung
2002 :
2010 ch%=asc(ch$):ifch%=131then1910
2012 ifch%=134goto2104
2020 ifch%=136then2090
2022 ifch%<>137then2032
2023 iftt%thenprint#3,"{cm m}";:tt%=0
2024 print#3,ch$;:gosub2090:ifch$=","theni=0:gosub40200:goto2024
2026 gosub1350:i=ko:gosub40200:ifch$=","then2024
2028 return
2032 ifch%=139thentt%=-1:goto2084
2034 ifch%=141then2024
2035 ifch%<>143then2038
2036 get#2,ch$:ifch$<>""goto2036
2037 return
2038 ifch%<>161then2050
2040 gosub2090:ifch$="#"thenprint#3,chr$(162);:goto2090
2042 print#3,chr$(161);:return
2050 ifch%<>167then2060
2052 print#3,ch$;:tt%=0:gosub2090
2054 ifch$>="0"andch$<="9"thenprint#3,chr$(137);:gosub1350:i=ko:goto40200
2056 return
2060 ifch%<180orch%>202then2070
2062 print#3,ch$;
2064 gosub2090:ifch$="("then2090
2066 goto60040
2070 ifch%=255thenprint#3,c0$"{cm pound}{cm s}";:goto2090
2080 i%=ch%=138orch%=148orch%=149orch%=150orch%=154orch%=155orch%=162orch%=203
2082 ifi%then60050
2084 print#3,ch$;
2090 get#2,ch$:ifch$=" "then2090
2095 return
2100 :
2101 : rem --- dim-abfrage
2102 :
2104 di%=0:di%(1)=0:di%(2)=0:di%(3)=0:gosub2090:gosub1710:ifn3$<"{ct d}"goto60090
2106 gosub1350:di%=di%+1:ifko<0orko>30000goto60020
2108 di%(di%)=ko:ifdi%<=3andch$=","thengosub2090:goto2106
2110 i%=1:ifch$<>")"goto60020
2112 ifva$=left$(va$(i%),3)then2122
2114 i%=i%+1:ifi%<=vz%then2112
2116 ifn3$<"{ct f}"thenle=-(n3$="{ct d}")*5-(n3$="{white}")*2:goto2120
2118 gosub1530
2120 vz%=vz%+1:va$(vz%)=va$+chr$(di%):va(vz%)=ad:gosub1655
2122 gosub2090:ifch$=","goto2104
2124 return
2200 :
2201 : rem ***** pass 1 hauptprogramm
2202 :
2210 gosub1010
2215 gosub1210:ifnotfl%then2300
2220 gosub2090
2225 ifch$=""thenprint#3,chr$(13);:goto2215
2230 ifch$>chr$(127)thengosub2010:goto2225
2235 ifch$=ge$thengosub1310:gosub1250:goto2225
2240 if(ch$>="0"andch$<="9")orch$="."thengosub1350:gosub1250:goto2225
2245 ifch$="("orch$=")"orch$=";"orch$=":"orch$=","thenprint#3,ch$;:goto2220
2290 ifch$>="a"andch$<="z"thengosub1810:goto2225
2295 goto60060
2300 pr=dz%+2+ad:p2=pr:close4:close3:close2:close5
2305 open5,8,5,"{pound}d,p,a":print#5,"{pi}";:close5:open1,8,15,"c:{pound}x={pound}k,{pound}d":close1
2315 print"{down}variablen :"40960-va" bytes"
2320 print"konstanten:"ad-an" bytes"
2325 print"datazeilen:"dz%" bytes{down}"
2330 ifva<=prthen60070
2335 return
3000 :
3001 : rem --- pass 2 initialisierung
3002 :
3010 dim ar$(142),s1%(20,6),s2%(20),fu%(22,1),pr%(6),pr$(68)
3050 fori=0to142:readi1%,i2%:ar$(i)=" "+chr$(i1%)+chr$(i2%):next
3060 fori=0to22:readfu%(i,0),fu%(i,1):next:fori=0to6:readpr%(i):next
3070 fori=0to68:readi%:pr$(i)=chr$(i%):next
3072 i=pr:gosub40010:pr$(19)=chr$(l%):pr$(20)=chr$(h%)
3076 i=va:gosub40010:pr$(27)=chr$(l%):pr$(22)=chr$(h%)
3080 i=ad+1:gosub40010:pr$(61)=chr$(l%):pr$(65)=chr$(h%)
3084 pr$(53)=pr$(27):pr$(57)=pr$(22)
3090 open4,8,4,"{pound}s,p,w":fori=0to68:print#4,pr$(i);:next:close4
3095 open4,8,4,"{pound}2,p,w":open2,8,2,"{pound}1,s,r":print"{down}{yellow}pass 2{light blue}":return
3200 :
3201 : rem ***** ausdrucksauswertung
3202 :
3210 i%=s1%(s1%,1):ifi%>12then3255
3215 ifs2%<2then60020
3220 if(s2%(s2%)ors2%(s2%-1))<2goto3235
3222 ifs2%(s2%)<2ors2%(s2%-1)<2goto3230
3225 ifi%=0thens2%=s2%-1:print#4,ar$(0);:goto3245
3227 ifi%>6andi%<13thenprint#4,ar$(107+i%);:goto3240
3230 goto60090
3235 print#4,ar$(s2%(s2%)+2*s2%(s2%-1)+4*i%+1);
3240 s2%=s2%-1:s2%(s2%)=-(s2%(s2%)=1ands2%(s2%+1)=1andi%<>4)or-(i%>6)
3245 gosub40700:s1%=s1%-1:return
3255 ifi%>14then3267
3257 ifs2%<1thengoto60020
3260 ifs2%(s2%)<2thenprint#4,ar$(2*(i%-13)+53+s2%(s2%));:goto3245
3265 goto60090
3267 j1%=s1%(s1%,2):j2%=s2%(s2%)
3269 ifi%>38then3310
3270 ifs2%<(1-(i%>35)-(i%=38))then60020
3272 if(i%=32ori%=35)andsr%thensr%=0:print#4,ar$(95);:gosub40700
3275 ifj1%=j2%then3300
3280 ifj1%=3and(j2%=0orj2%=1)then3300
3285 ifj1%=1andj2%=0thenprint#4,ar$(103);:gosub40700:s2%(s2%)=1:goto3300
3290 ifj1%=0andj2%=1thenprint#4,ar$(104);:gosub40700:s2%(s2%)=0:goto3300
3295 ifj1%<>4thengoto60090
3300 ifi%=15ori%=17andj2%=1then3302
3301 print#4,ar$(2*(i%-16)+57-(s2%(s2%)=1));:gosub40700
3302 s2%=s2%+(i%>35)+(i%=38)
3305 ifs1%(s1%,3)<3thens2%(s2%)=s1%(s1%,3)
3306 s1%=s1%-1:return
3310 ifj2%=2thengoto60090
3315 ifj2%=0thenprint#4,ar$(103);:gosub40700
3320 print#4,"{sh pound}"chr$(s1%(s1%,4))"{sh space}"chr$(s1%(s1%,5));:gosub40720
3325 s2%=s2%-s1%(s1%,6)+1:s2%(s2%)=s1%(s1%,3)
3330 iffl%ands1%=1thenprint#4,ar$(99);:goto3245
3335 print#4,ar$(i%+66);:goto3245
3500 :
3501 rem ***** variable auf den stack
3502 :
3510 ifi%>2then3550
3520 gosub40100:i$=ch$:gosub40100:print#4,"{sh pound}"i$"{sh space}"ch$ar$(i%+108);:gosub40710
3525 s2%=s2%+1:s2%(s2%)=i%:return
3550 ifi%>3then3570
3555 s2%=s2%+1:gosub40100:s2%(s2%)=asc(ch$):gosub40100:gosub40700
3556 ifch$<>chr$(112)then3560
3557 ifsr%thenprint#4,ar$(95);:gosub40700
3558 sr%=0:print#4,"8";:pr=pr+1.
3560 print#4,ar$(asc(ch$));:return
3570 ifi%=7thengosub40100:print#4,"{sh pound}"ch$ar$(65);:pr=pr+5.:i%=1:goto3525
3580 s1%=s1%+1:s1%(s1%,0)=1:s1%(s1%,1)=i%+35:s1%(s1%,2)=1:s1%(s1%,3)=i%-4
3585 kl%=kl%+1:gosub40100:s1%(s1%,4)=asc(ch$)
3587 gosub40100:s1%(s1%,5)=asc(ch$)
3590 get#2,ch$:s1%(s1%,6)=asc(ch$):on3-asc(ch$)goto3600,3605
3595 gosub40800
3600 gosub40800
3605 return
3710 s1%=s1%+1:s1%(s1%,0)=1:s1%(s1%,1)=i%:s1%(s1%,2)=j1%:s1%(s1%,3)=j2%
3715 kl%=kl%+1:ifi%<36thenreturn
3720 oni%-36goto3725,3735
3725 gosub40800:s1%(s1%,2)=2:s1%(s1%,3)=2:return
3735 gosub40800:goto3725
3910 i%=-1:ifch$<"{cm e}"andch$>"{sh pound}"theni%=asc(ch$)-170:goto3975
3920 ifch$>"{cm w}"orch$<"{cm e}"thenreturn
3925 pr%=5:i$=ch$:gosub40100
3930 ifch$>"{cm w}"orch$<"{cm e}"then3955
3935 ifch$=i$then60020
3940 ifch$<>"{cm r}"andi$<>"{cm r}"theni%=12:goto3975
3945 ifch$="{cm e}"ori$="{cm e}"theni%=10:goto3975
3950 i%=11:goto3975
3955 ifi$="{cm e}"theni%=7:return
3965 ifi$="{cm r}"theni%=9:return
3970 i%=8:return
3975 ifi%<7thenpr%=pr%(i%)
3980 goto40100
4010 ifpr%>s1%(s1%,0)thens1%=s1%+1:s1%(s1%,0)=pr%:s1%(s1%,1)=i%:return
4015 ifs1%=0thenreturn
4020 rz%=i%:gosub3210:i%=rz%:ifs1%(s1%+1,0)>1then4010
4025 return
4500 :
4501 rem *****  ausdruck hauptprogramm
4502 :
4510 fl%=0:fu%=-1:re%=0:s1%=0:s2%=0:ko%=0:kl%=0:sr%=-1
4515 gosub40100
4520 ifch$>"j"orch$<"{cm h}"then4550
4525 ifnotfu%thengoto4685
4530 re%=0:i%=asc(ch$)-164:j1%=fu%(i%-16,0):j2%=fu%(i%-16,1):gosub3710:goto4515
4550 ifnotre%then4600
4555 gosub3910:ifi%=-1then4610
4560 fu%=-1:re%=0:gosub4010:goto4520
4600 ifch$="{cm n}"then4515
4605 ifch$="{cm q}"thens1%=s1%+1:s1%(s1%,0)=9:s1%(s1%,1)=13:goto4515
4610 ifch$="{cm pound}"thens1%=s1%+1:s1%(s1%,0)=6:s1%(s1%,1)=14:re%=0:goto4515
4615 ifch$<>"("then4630
4617 ifnotfu%then4685
4620 re%=0:kl%=kl%+1:s1%=s1%+1:s1%(s1%,0)=1:s1%(s1%,1)=15:s1%(s1%,2)=4
4625 s1%(s1%,3)=3:goto4515
4630 ifch$<>")"then4650
4635 ifkl%=0then4685
4640 kl%=kl%-1:fu%=0:re%=-1:pr%=1:gosub4010:ifs1%>0ornotfl%goto4515
4645 return
4650 ifch$<>","then4670
4655 ifko%=0then4685
4660 ko%=ko%-1:fu%=-1:re%=0:pr%=1:gosub4010:goto4515
4670 ifch$>"{ct g}"ornotfu%then4685
4675 fu%=ch$>"{ct c}"andch$<"{ct g}":re%=notfu%:i%=asc(ch$):gosub3510:goto4515
4680 :
4681 rem --- ausdruck endauswertung
4682 :
4685 ifko%<>0orkl%<>0then60100
4690 pr%=0:gosub4010:ifs2%=1thenreturn
4692 goto60020
4700 :
4701 rem --- zeilennummer holen
4702 :
4710 gosub40600
4720 ifzh$="{pi}"thenfl%=-1:return
4722 gosub40900:zn=l%+256.*h%:fl%=0:printzn"{up}":return
4801 :
4802 : rem --- ausdruckstyp pruefen
4803 :
4810 gosub4510:ifs2%(1)=1thenreturn
4815 ifs2%(1)=2then60090
4820 print#4,ar$(103);:goto40700
4910 gosub4510:ifs2%(1)=0thenreturn
4915 ifs2%(1)=2thengoto60090
4920 print#4,ar$(104);:goto40700
4960 gosub4510:ifs2%(1)=2thenreturn
4965 goto60090
5001 :
5002 : rem --- let-befehl, linke seite
5003 :
5010 pf%=0
5012 le%=asc(ch$)and3:ph%=-1
5015 ifch$>"{ct b}"then5045
5020 gosub40100:i$=ch$:gosub40100
5025 ifpf%thenprint#4,"{sh pound}"i$"{sh space}"ch$;:gosub40720:goto40100
5030 pl%=asc(i$):ph%=asc(ch$):goto40100
5045 ifch$="{ct c}"then5070
5050 fl%=-1:fu%=-1:re%=0:s1%=0:s2%=0:ko%=0:kl%=0:sr%=-1
5055 i%=asc(ch$):gosub3580:gosub4515
5057 ifpf%thenprint#4,chr$(165)chr$(71)chr$(164)chr$(72);:gosub40720:goto40100
5060 print#4,"{cm g}gh{cm g}hh";
5065 pr=pr+6.:goto40100
5070 get#2,ch$:ifch$="{ct b}"thenget#2,ch$,ch$:return
5075 goto60120
5101 :
5102 : rem ***** variablenzuweisung
5103 :
5110 gosub5010:ifch$<>"{cm r}"then60020
5115 ifle%=3then5135
5120 onle%+1gosub4910,4810,4960
5122 ifph%=-1thenprint#4,chr$(104)chr$(168)chr$(104);:gosub40700:goto5130
5125 print#4,"{sh pound}"chr$(pl%)"{sh space}"chr$(ph%);:gosub40720
5130 print#4,ar$(le%+120+55*(le%=2));:goto40700
5135 gosub4510:ifs2%(1)<>2then60090
5140 print#4," s"chr$(14)"i{ct f}"chr$(240)"{ct c}lh{cm r}{cm g}f8"chr$(233)"{ct f}{f1}"chr$(34)"{sh space}o";
5150 print#4,chr$(132)"#"ar$(90)" "chr$(231)"{sh pound}";
5160 pr=pr+27.:return
5201 :
5202 : rem ***** tokenauswertung
5203 :
5210 ch%=asc(ch$):ifch%>156thenonch%-156goto6665,6715,6765,6865,6915,6960
5212 ifch%>143thenonch%-143goto6120,6162,6265,6320,,,,6415,6465,6512,,,6615
5213 onch%-128goto5315,5415,,5515,5615,,5715,5815,5862,,5915,5965,6015,6065
5215 :
5216 : rem --- end
5217 :
5250 print#4,"l{f3}"chr$(227);:gosub40700:goto40100
5301 :
5302 : rem --- for
5303 :
5315 gosub40100:gosub5110:ifle%>0then60090
5320 ifch$<>"{cm @}"then60020
5325 gosub4910:ifch$<>"{sh pound}"then5335
5330 gosub4910:goto5340
5335 print#4,ar$(123);:gosub40700
5340 ifch$<>chr$(13)andch$<>":"then60020
5345 gosub40710:i=pr:gosub40010
5355 print#4,"{cm i}"chr$(l%)"{sh space}"chr$(h%)ar$(124);:return
5401 :
5402 : rem --- next
5403 :
5415 print#4,ar$(125);:gosub40700
5420 get#2,ch$:ifch$=":"orch$=chr$(13)thenreturn
5425 ifch$>"{ct f}"then60020
5430 i%=3-(ch$>"{ct c}")
5435 get#2,ch$:i%=i%-1:ifi%then5435
5440 ifch$=","then5415
5445 ifch$=":"orch$=chr$(13)thenreturn
5450 goto60020
5501 :
5502 : rem --- input#
5503 :
5515 gosub4810:ifch$<>","then60020
5520 print#4,ar$(130);:gosub40700:gosub40100:gosub5640:print#4," {cm j}{cm q}";:goto40700
5601 :
5602 : rem --- input
5603 :
5615 gosub40100:ifch$<>"{ct b}"then5640
5620 gosub40100:i$=ch$:gosub40100:j$=ch$:gosub40100
5625 ifch$<>";"thenle%=2:pl%=asc(i$):ph%=asc(j$):goto5645
5630 ch$=j$:pf%=-1:gosub5025:print#4,ar$(126);:gosub40700
5640 gosub5010
5645 print#4," "chr$(249)"{cm q}";:ifph%<>-1then5655
5650 print#4,chr$(104)chr$(168)chr$(104);:pr=pr+6.:goto5660
5655 print#4,chr$(169)chr$(pl%)chr$(160)chr$(ph%);:gosub40710
5660 print#4,ar$(le%+127);:gosub40700:ifch$=","thengosub40100:goto5640
5665 return
5701 :
5702 : rem --- read
5703 :
5715 gosub40100:ifch$>"{ct f}"then60020
5720 pf%=-1:gosub5012:print#4,ar$(le%+131);:gosub40700
5725 ifle%=3then60020
5730 ifch$=","then5715
5735 return
5801 :
5802 : rem --- let
5803 :
5815 gosub40100:goto5110
5851 :
5852 : rem --- goto
5853 :
5862 ch%=76
5865 gosub40100:gl%=asc(ch$):gosub40100:gh%=asc(ch$):zg=gh%*256.+gl%
5870 i%=0:ifzg>znthen5885
5880 gosub40520:print#4,chr$(ch%)chr$(l%)chr$(h%);:gosub40700:goto40100
5885 print#4,"{pi}{pi}"chr$(ch%)chr$(gl%)ch$chr$(zz%and255)chr$(zz%/256);
5890 gosub40700:goto40100
5901 :
5902 : rem --- if
5903 :
5915 gosub4810:print#4,ar$(101)"p{ct c}";:gosub40300:pr=pr+8.
5925 ifch$<>chr$(167)then60020
5930 ch$=":":return
5951 :
5952 : rem --- restore
5953 :
5965 print#4," ;{ct h}";:gosub40700:goto40100
6001 :
6002 : rem --- gosub
6003 :
6015 ch%=32:goto5865
6051 :
6052 : rem --- return
6053 :
6065 print#4,chr$(96);:pr=pr+1.
6070 goto40100
6101 :
6102 : rem --- stop
6103 :
6120 print#4,"8lk{cm pound}";:gosub40720:goto40100
6151 :
6152 : rem --- on x goto/gosub
6153 :
6162 gosub4810:ch%=asc(ch$):ifch%=137thench%=76:goto6170
6164 ifch%=141thench%=32:goto6170
6166 goto60020
6170 print#4,ar$(88)ar$(84)"{f1}"chr$(98)"{ct j}"chr$(101)chr$(98);
6180 ifch%=32thenprint#4,"{ct j}";:pr=pr+1.
6185 i=pr+15.:gosub40010:print#4,chr$(141)hl$"{black}"
6190 gosub40250:pr=pr+19.
6192 ifch%=32thenprint#4,chr$(234)chr$(234)chr$(234);:gosub40700
6195 gosub5865:ifch%=32thengosub40250:gosub40700
6200 ifch$=","then6195
6210 ifch$=":"thengosub40900:og%=og%+1
6220 return
6251 :
6252 : rem --- wait
6253 :
6265 gosub4810:ifch$<>","then60020
6270 gosub4810:ifch$<>","then6285
6275 gosub4810
6280 print#4,ar$(97);:goto40700
6285 print#4,"{sh pound}"c0$ar$(65);:gosub40730:goto6280
6301 : rem --- load
6303 :
6320 gosub4960
6325 ifch$=","thengosub4810:goto6340
6330 print#4,"{sh pound}{ct a}"ar$(65);:gosub40730:goto6345
6340 ifch$=","thengosub4810:goto6355
6345 print#4,"{sh pound}"c0$ar$(65);:gosub40730
6355 print#4,ar$(134);:goto40700
6401 :
6402 : rem --- poke
6403 :
6415 gosub4510:ifs2%(1)=2then60090
6420 ifs2%(1)=0thenprint#4,ar$(135);:gosub40700
6425 ifch$<>","thengoto60020
6430 gosub4810:print#4,ar$(136);:goto40700
6451 :
6452 : rem --- print#
6453 :
6465 gosub6665:print#4," {cm j}{cm q}";:goto40700
6501 :
6502 : rem --- print
6503 :
6512 cr%=-1
6515 gosub40100
6517 ifch$=";"thencr%=0:goto6515
6520 ifch$=","thencr%=0:print#4,ar$(140);:gosub40700:goto6515
6525 ifch$<>chr$(163)then6540
6530 cr%=0:gosub4810:print#4,ar$(138);:gosub40700:ifch$<>")"then60020
6535 goto6515
6540 ifch$<>chr$(166)then6552
6545 cr%=0:gosub4810:print#4,ar$(139);:gosub40700:ifch$<>")"thengoto60020
6550 goto6515
6552 ifch$=chr$(13)orch$=":"then6575
6555 cr%=-1:fl%=0:fu%=-1:re%=0:s1%=0:s2%=0:ko%=0:kl%=0:sr%=-1:gosub4520
6560 ifs2%(1)=1thengosub4920
6565 ifs2%(1)<2thenprint#4,ar$(137);:gosub40700:goto6517
6570 print#4,ar$(141);:gosub40700:goto6517
6575 ifnotcr%thenreturn
6580 print#4,ar$(80);:goto40700
6601 :
6602 : rem --- clr
6603 :
6615 print#4," "chr$(231)"{pi} "chr$(20)"{ct h}";:pr=pr+6.
6620 goto40100
6651 :
6652 : rem --- cmd
6653 :
6665 gosub4810:print#4,ar$(142);:gosub40700:ifch$<>","then6580
6670 goto6512
6701 :
6702 : rem --- sys
6703 :
6715 gosub4510:ifs2%(1)=2then60090
6720 ifs2%(1)=0thenprint#4,ar$(135);:gosub40700
6725 print#4,ar$(94);:goto40700
6751 :
6752 : rem --- open
6753 :
6765 gosub4810:ifch$=","then6790
6770 print#4,"{sh pound}{ct a}"ar$(65);:gosub40730
6775 print#4,"{sh pound}"c0$ar$(65);:gosub40730
6780 print#4,"{sh pound}2{sh space}{cm b}"ar$(110);:gosub40710
6785 print#4,ar$(78);:goto40700
6790 gosub4810:ifch$<>","then6775
6795 gosub4810:ifch$<>","then6780
6800 gosub4960:goto6785
6851 :
6852 : rem --- close
6853 :
6865 gosub4810:print#4,ar$(76);:goto40700
6901 :
6902 : rem --- get
6903 :
6915 gosub40100:ifch$>"{ct f}"then60020
6920 pf%=-1:gosub5012:print#4,ar$(70+2*le%);:gosub40700
6925 ifle%=3then60020
6930 ifch$=","then6915
6935 return
6951 :
6952 : rem --- get#
6953 :
6960 gosub4810:ifch$<>","then60020
6965 print#4,ar$(130);:gosub40700
6970 gosub6915:print#4," {cm j}{cm q}";:goto40700
7500 :
8000 :
8001 rem ***** pass 2 hauptprogramm
8002 :
8010 gosub3010:zn=0:og%=0:zh$=c0$:zl$=c0$:zz%=0
8015 gosub4710:iffl%then8050
8020 gosub40100:ifch$>chr$(127)andch$<chr$(163)thengosub5210:goto8030
8025 ifch$<"{ct h}"thengosub5110
8030 ifch$=":"then8020
8035 ifch$=chr$(13)then8015
8040 goto60020
8050 print#4,"l{f3}"chr$(227);:gosub40700
8055 print"{down}programm{space*2}:"pr-p2" bytes"
8057 print"zeilen{space*4}:"zz%/4-og%
8060 ifpr+256>vathengoto60070
8065 close4:close2:open1,8,15,"s:{pound}d,{pound}k,{pound}1":close1
8070 :
8071 rem ***** pass 3
8072 :
8100 print"{down}{yellow}pass 3{light blue}":open2,8,2,"{pound}2,p,r":open4,8,4,"{pound}3,p,w":nz%=0:ja=p2
8102 ifnz%=zz%thenna=60000:goto8110
8105 nz=peek(49152+nz%)+peek(49153+nz%)*256.:printnz"{up}"
8106 na=peek(49154+nz%)+peek(49155+nz%)*256.:nz%=nz%+4
8107 ifja>nathen8102
8110 ja=ja+1:gosub40100:i%=st:ifch$<"{pi}"then8145
8115 ja=ja+1:gosub40100:ifch$<"{pi}"thenprint#4,"{pi}";:goto8145
8120 gosub40100:i$=ch$:gosub40100:gl%=asc(ch$):gosub40100:gh%=asc(ch$):ja=ja+1
8125 gosub40510:print#4,i$chr$(l%)chr$(h%);:goto8107
8145 print#4,ch$;:ifi%<>64then8107
8147 :
8150 close4:close2:open1,8,15,"s:c-"+left$(na$,14)+",{pound}2"
8510 print#1,"c:c-"+left$(na$,14)+"={pound}s,runtime,{pound}x,{pound}3"
8520 print#1,"s:{pound}s,{pound}x,{pound}3":close1:return
40001 :
40002 : rem ***** hilfsroutinen
40003 :
40010 h%=i/256:l%=i-h%*256.:hl$=chr$(l%)+chr$(h%):return
40100 get#2,ch$:ifch$=""thench$=c0$
40110 return
40200 gosub40010
40210 print#3,hl$;:return
40250 i=zn:goto40310
40300 i=zn+1.
40310 gosub40010:print#4,"{pi}{pi}l"hl$chr$(zz%and255)chr$(zz%/256);:return
40510 gosub40100:l%=asc(ch$):gosub40100:i%=l%+256*asc(ch$)
40520 ifi%>=zz%theni=pr-3.:goto40010
40530 j%=peek(49153+i%):ifj%<gh%theni%=i%+4:goto40520
40540 ifj%=gh%thenifpeek(49152+i%)<gl%theni%=i%+4:goto40520
40550 l%=peek(49154+i%):h%=peek(49155+i%):return
40560 :
40600 gosub40100:zl$=ch$:gosub40100:zh$=ch$:return
40630 :
40700 pr=pr+3.:return
40710 pr=pr+7.:return
40720 pr=pr+4.:return
40730 pr=pr+5.:return
40800 s1%=s1%+1:s1%(s1%,0)=1:s1%(s1%,1)=15:s1%(s1%,2)=1:s1%(s1%,3)=1:ko%=ko%+1
40810 return
40890 :
40891 rem ===== zeilennummer speichern
40892 :
40900 i=pr:gosub40010:poke49154+zz%,l%:poke49155+zz%,h%:l%=asc(zl$)
40910 h%=asc(zh$):poke49152+zz%,l%:poke49153+zz%,h%:zz%=zz%+4:return
60000 :
60001 rem ***** fehlermeldungen
60002 :
60020 print"{yellow}{down}syntax fehler !!{light blue}":goto60080
60030 print"{yellow}{down}fehlerhafte datazeile !!{light blue}":goto60080
60040 print"{yellow}{down}'(' wird nach funktionen erwartet !!{light blue}":goto60080
60050 print"{yellow}{down}illegaler befehl !!{light blue}":goto60080
60060 print"{yellow}{down}illegales zeichen !!{light blue}":goto60080
60070 print"{yellow}{down}speicher ist voll !!{light blue}"
60080 close2:close3:close4:close5:end
60090 print"{yellow}{down}falscher variablen-/konstantentyp !!{light blue}":goto60080
60100 print"{yellow}{down}klammer-/kommafehler !!{light blue}":goto60080
60110 print"{yellow}{down}ungueltige sprunganweisung !!{light blue}":goto60080
60120 print"{yellow}{down}ti/st kann nicht beschrieben werden !!{light blue}":goto60080
60130 print"{yellow}{down}falsches goto/gosub !!{light blue}":goto60080
61001 :
61010 data 162,251,160,159,76,212,187
61017 :
61018 rem  adressen der maschinen-
61019 rem  routinen in 'runtime'
61020 :
61100 data  25, 9
61110 data 195,11,192,11,186,11,169,10
61120 data 213,11,210,11,204,11,193,10
61130 data 231,11,228,11,222,11,220,10
61140 data 249,11,246,11,240,11, 42,11
61150 data  11,12,  8,12,  2,12, 50,13
61160 data  29,12, 26,12, 20,12,107,10
61170 data  47,12, 44,12, 38,12,130,10
61180 data 204,12,201,12,195,12, 65,10
61190 data 220,12,217,12,211,12, 72,10
61200 data 236,12,233,12,227,12, 79,10
61210 data 252,12,249,12,243,12, 86,10
61220 data  12,13,  9,13,  3,13, 93,10
61230 data  28,13, 25,13, 19,13,100,10
61240 data  65,12,121,11
61250 data  56,12,153,10
61260 data  59,13, 82,13 :rem sgn
61270 data 123,13,  0, 0 :rem int
61280 data 132,13,141,13 :rem abs
61290 data 167,13,  0, 0 :rem usr
61300 data 158,19,176,13 :rem byte,fre
61310 data 118,19,181,13 :rem let 2,pos
61320 data 192,13,106,19 :rem sqr,get f
61330 data 255,13, 81,19 :rem rnd,get i
61340 data   8,14, 66,19 :rem log,get s
61350 data  17,14, 50,19 :rem exp,close
61360 data  26,14, 33,19 :rem cos,open
61370 data  35,14, 28,19 :rem sin,<cr>
61380 data  44,14,131, 8 :rem tan,pusha
61390 data  53,14,144, 8 :rem atn,popa
61400 data  39,16, 74,14 :rem peek
61410 data 165,14,148, 8 :rem len,incst
61420 data 245,14,105,14 :rem str$,puts
61430 data  42,15, 83,14 :rem val,glen
61440 data 210,14, 15,19 :rem asc,sys
61450 data  74,12,182,14 :rem toss,chr$
61460 data 251,17, 69, 9 :rem wai,left$
61470 data  68, 8,110, 9 :rem (),right$
61480 data 238,17,197, 9 :rem if,mid$
61490 data 138,11,170,11 :rem flp<=>int
61500 data 192, 8,216, 8,238, 8:rem x()
61510 data 197, 8,221, 8,243, 8:rem x
61520 data  79,12, 90,12, 96,12:rem st
61530 data 253,15,  4,16, 11,16:rem > <
61540 data  18,16, 25,16, 32,16:rem >=
61550 data  76,16, 57,16, 92,16:rem let
61560 data 119,16,126,16,151,16:rem for
61570 data 240,16              :rem "x"
61580 data  34,17, 58,17, 11,17:rem inp
61590 data  76,17              :rem in#
61600 data  88,17,162,17,212,17:rem rea
61610 data  26,18,122,18,138,18:rem loa
61620 data 160,18,185,18,206,18:rem pri
61630 data 215,18,229,18       :rem pri
61640 data   3, 19             :rem pr#
61697 :
61700 data 3,3,3,3,3,3,0,0,1,1,1,1
61710 data 0,0,0,0,0,0,0,0,0,0,0,0
61720 data 0,0,0,0,3,1,2,1,0,2,2,0
61730 data 2,1,1,2,1,2,1,2,1,2
61800 data 7,7,8,8,10,4,3
61900 data 1,8,12,8,194,7,158,32,50,48
61910 data 54,50,0,0,0,32,20,8,76,0,0
61920 data 169,0,141,31,8,162,0,169,0
61930 data 157,0,0,224,0,208,7,172,31,8
61940 data 192,160,240,8,232,208,239
61950 data 238,31,8,208,234,169,0,133
61960 data 51,169,0,133,52,169,0,133,65
61970 data 169,0,133,66,96
