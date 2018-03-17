10 a$="hello":b$="world"
20 c$=a$+" "+str$(66)+" "+b$+"!!!"
30 print chr$(147)+c$
40 print a$+" "+a$+" "+a$
50 d$=left$(a$,4):print d$;left$(b$,2):print a$
60 print left$(a$,22)
70 d$=right$(a$,4)+str$(1337)+right$(b$,2):print d$
80 print right$(left$(a$,4),2):print right$(a$,20)