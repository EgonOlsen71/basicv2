10 print"Free memory: ",fre(0)
20 print
30 print "Hello World:";rnd(0)
40 print "USR is supported, but doesn't output anything useful:",USR(10),"See?"
50 print abs(-123),abs(-222.334)
60 PRINT ATN(1),ATN(1)*4 ; π ; ATN(1)*4 - π
65 gurk=35:print gu,gurk
70 print ti,time
80 print ti$,time$
90 PRINT EXP(1), LOG(10), LOG(1), Sgn(0),Sgn(1),Sgn(-223939.22)
100 print sqr(56)
110 a$="hello world!":print len(a$), len("gwurk"), len("gwurk"+a$)
120 print asc("abs")
130 print val("123234"),val("-11333.333e+02")
140 print chr$(asc("b"))
150 print "great: "+str$(val("-11333.333e+02"))

160 A$="monday morning"
170 FOR X=0 TO LEN(A$)+1 
180 PRINT LEFT$(A$,X):  NEXT X

200 FOR P=1 TO 20
210 PRINT RIGHT$("  "+STR$(P),3); RIGHT$("      "+STR$(2^P),8)
220 NEXT P

230 A$="monday morning"
240 FOR X=0 TO LEN(A$)+1 
250 PRINT RIGHT$(A$,X): NEXT X

260 print "Status:",status