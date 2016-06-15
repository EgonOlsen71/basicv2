10 data 1,2,., apfel, "commodore 64", ."gaensefuesschen", "DIES ; IST : EIN # TEST , ODER ? " 
20 read a
30 read b%, c, d$
40 read e$
50 read f$, g$
60 print a, b%, c, d$, e$, f$, g$


100 datacommodore 64      
110 data commodore 64 :
120 data commodore 64 , commodore 64
130 data " commodore 64 "
200 read a$,b$,c$,d$,e$
250 print ,,"zeichenkettenlaenge":print
300 print a$, len(a$)
400 print b$, len(b$)
500 print c$, len(c$)
600 print d$, len(d$)
700 print e$, len(e$)