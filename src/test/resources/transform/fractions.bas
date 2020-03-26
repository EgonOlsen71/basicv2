10 printchr$(147);:poke 53280,15:poke53281,15:poke646,0
20 dim fr%(10),op%(4),op$(1):cn=0:x=0
25 op$(0)="*":op$(1)="/"
30 gosub 1000
40 if x=0 then gosub 1200
45 if cn<=0 then run
50 if cn>=8 then x=1
60 if x=1 then 100
70 gosub 2000:goto 30

100 gosub 2000
110 mg$="gleichung!": gosub 10000
120 dc=0:gosub 1500:poke 53280,15
130 if dc=1 then gosub 2000:mg$="brueche gekuerzt!": gosub 10000
140 dc=0:gosub 1600
150 if dc=1 then gosub 2000:mg$="divisionen ersetzt!": gosub 10000
160 dc=0:gosub 1900:poke 53280,15
170 if dc=1 then gosub 2000:mg$="brueche weiter gekuerzt!": gosub 10000
180 gosub 4000
200 print "{home}";:end

1000 print "{home}{down*10}{space*30}";
1010 print "{home}{down*12}{space*30}";
1015 print "{home}{down*14}{space*30}";
1020 z%=0:print "{home}{down*10}zaehler";((cn/2)+1);:input z%
1030 if z%=0 then x=1:cn=cn-2:return
1040 n%=0:print "{home}{down*12}nenner";((cn/2)+1);:input n%
1050 if n%=0 then n%=1
1060 fr%(cn)=z%:fr%(cn+1)=n%
1070 return

1200 if cn=6 then x=1:return
1205 print "{home}{down*14}{space*30}";
1210 print "{home}{down*14}rechenzeichen (* oder /)";
1220 input a$: if a$="" then x=1:return
1230 if a$<>"*" and a$<>"/" then 1200
1240 op%=0:if a$="/" then op%=1
1250 op%(cn/2)=op%:cn=cn+2:return

1499 rem brueche kuerzen
1500 for i=0 to cn step 2
1510 z%=fr%(i):n%=fr%(i+1)
1520 gosub 1800
1530 fr%(i)=z%:fr%(i+1)=n%
1540 next:return

1599 rem division ersetzen
1600 for i=2 to cn step 2
1610 op%=op%((i-2)/2)
1620 if op%=1 then gosub 1650
1630 next:return
1650 op%((i-2)/2)=0:t%=fr%(i):fr%(i)=fr%(i+1)
1660 fr%(i+1)=t%:dc=1:return

1800 mx%=z%:if n%<mx% then mx%=n%
1805 if mx%<=1 then return
1810 for m=mx% to 2 step -1:poke53280,m and 15
1820 if z%/m = int(z%/m) and n%/m = int(n%/m) then gosub 1840
1825 if m=mx% then m=int(mx%/2)
1830 next:return
1840 z%=z%/m:n%=n%/m:dc=1:return

1899 rem brueche ueber kreuz kuerzen
1900 for i=0 to cn-2 step 2
1910 for p=i+2 to cn step 2
1920 z%=fr%(i):n%=fr%(p+1)
1930 gosub 1800
1940 fr%(i)=z%:fr%(p+1)=n%
1950 z%=fr%(p):n%=fr%(i+1)
1960 gosub 1800
1970 fr%(p)=z%:fr%(i+1)=n%
1980 next p,i:return

1999 rem ausgabe
2000 print chr$(147);
2010 for i=0 to cn step 2
2020 z%=fr%(i):n%=fr%(i+1):op%=-1
2030 if i>0 then op%=op%((i-2)/2)
2040 pp%=i/2:eo=0:gosub 3000
2050 next
2060 if eo=0 and cn>0 then print "{home}{down*3}"spc((i-1)*4+2)"= ?";
2070 return

3000 rem
3010 p%=pp%*8:if n%=0 then eo=1:goto 3110
3020 print"{home}{down*2}";
3030 print spc(p%);
3040 if z%<9999 then print spc(5-len(str$(z%)));
3050 print z%;
3060 print"{home}{down*3}"spc(p%)"-----";
3070 print"{home}{down*4}";
3080 print spc(p%);
3090 if n%<9999 then print spc(5-len(str$(n%)));
3100 print n%;
3110 if op%<>-1 then print"{home}{down*3}"spc(p%-2)op$(op%);
3120 return

4000 sp=1
4010 z1%=fr%(0):n1%=fr%(1):z2%=fr%(2):n2%=fr%(3)
4020 op%=op%(0)
4030 z%=0:n%=0
4040 if op<>0 then print "unbekannte operation: ";op:stop
4050 z%=z1%*z2%:n%=n1%*n2%:gosub 1800:poke 53280,15
4060 for i=4 to cn step 2
4070 fr%(i-2)=fr%(i):fr%(i-1)=fr%(i+1)
4080 op%=(i-2)/2:op%(op%-1)=op%(op%)
4090 next
4100 fr%(0)=z%:fr%(1)=n%
4110 cn=cn-2
4120 if cn=0 then mg$="loesung!"
4130 if cn<>0 then mg$="schritt"+str$(sp):sp=sp+1
4140 gosub 2000:gosub 10000
4150 if cn=0 then 5000
4160 goto 4010

5000 gosub 2000:print "{home}{down*10}ergebnis uebernehmen (j/n)?"
5010 get a$:if a$<>"j" and a$<>"n" then 5010
5020 if a$="n" then run
5030 cn=0:x=0:dc=0:fr%(0)=z%:fr%(1)=n%
5035 for i=2 to 10:fr%(i)=0:next
5040 gosub 2000:goto 40


10000 print "{home}{down*10}"mg$:print
10005 print "taste fuer naechsten schritt!";
10010 geta$:ifa$="" then 10010
10020 return