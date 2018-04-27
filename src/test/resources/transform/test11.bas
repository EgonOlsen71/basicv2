10 a$="hello":b$="world":c$="world":d$="hello1":ti$="000000"
20 print a$=b$,
30 print a$<>b$,
40 print c$=b$,b$<>c$,b$=b$
50 print c$=a$,
60 print a$>b$,a$<b$,b$>=c$,b$<=c$
65 print"gt"
70 print a$>b$,b$>a$,b$>c$,a$>d$,d$>a$
75 print"lt"
80 print a$<b$,b$<a$,b$<c$,a$<d$,d$<a$
85 print"lteq"
90 print a$<=b$,b$<=a$,b$<=c$,a$<=d$,d$<=a$
92 print"gteq"
95 print a$>=b$,b$>=a$,b$>=c$,a$>=d$,d$>=a$
97 print"all"
100 print a$>h$,h$<a$,a$<h$,a$=h$,a$>=h$,a$<=h$
101 printh$>=a$,h$<=a$
105 print"h"
110 print h$>h$,h$<h$,h$=h$,h$>=h$,(h$<=h$)+3.4
