1list
2dimaa$(20)
3rem input"hallo";aa$(4)
4print"aa$:",aa$(4)
10 OPEN 1, 1, 1, "TESTDATEI"
20 PRINT#1,"1. Datensatz" 
30 PRINT#1,"2. Datensatz","(nach 10 Zeichen Abstand) wird fortgesetzt";
40 PRINT#1," wird noch fortgesetzt"
50 PRINT#1,"3. Datensatz"+CHR$(13);
60 PRINT#1,"4. Datensatz"
70 CLOSE 1
100 print"--------------------------------------"
110 OPEN 1, 1, 3, "TESTDATEI,SEQ,A"
115 a=1
120 PRINT#a,"1. Datensatz" 
130 PRINT#a,"2. Datensatz","(nach 10 Zeichen Abstand) wird fortgesetzt";
140 PRINT#a," wird noch fortgesetzt"
150 PRINT#a,"3. Datensatz"+CHR$(13);
160 PRINT#a,"4. Datensatz"
170 CLOSE 1


1000 OPEN 3,3
1010 CMD 3,"TEST";
1020 PRINT "TEXT"
1030 PRINT "DEMO";
1040 PRINT#3,;
1050 CLOSE 3
1060 PRINT "ENDE";


2010 rem schreibt eine 50 zeichen lange sequentiellen datei auf datasette
2020 open 1,8,1, "testfile": cmd 1,;
2030 for x=1 to 50: print "a";: next x
2040 print#1,;: close 1

3000 PRINT:PRINT "Hallo":OPEN 1,1,0,"TESTDATEI,SEQ"
3010 DIM A$(3)
3020 INPUT#1,A$(1),A$(2),A$(3)
3030 INPUT#1,B$
3040 FOR I=1TO3:PRINT"A$("I")=";A$(I):NEXT
3050 PRINT "B$="B$
3060 CLOSE 1
3070 rem GET B$,A$(2)
3080 rem PRINT B$, A$(2)

4000 PRINT:PRINT:OPEN 2,1,0,"TESTDATEI,SEQ"
4010 FOR I=0TO60:GET#2, A$(1):PRINTA$(1);:NEXT