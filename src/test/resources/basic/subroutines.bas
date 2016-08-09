20 A$ = "dieser text soll auf den monitor ausgegeben werden !": GOSUB 1000
30 GOSUB 2000: A$ = "...dieser text ebenfalls..." : A = 160
40 GOSUB 1000: PRINT "Hier geht das BASIC-Programm weiter": GOSUB 2000
100 END
1000 REM Unterprogramm "Ausgabe"
1010 IF LEN(A$) = 0 THEN RETURN
1020 FOR X=1 TO LEN(A$)
1030 ZE = ASC (MID$ (A$, X, 1))
1040 print chr$(ze);
1050 FOR Y=0 TO 333333: NEXT Y, X
1060 RETURN
2000 REM Unterprogramm "Warte auf Taste"
2010 GET B$ : IF B$="" THEN 2010
2030 RETURN : PRINT "Test" : 