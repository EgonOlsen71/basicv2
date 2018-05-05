5 print"initial:";fre(0):f$="12345678901234"
10 dimz$(50):dimu$(50):forx=0to1000:ti$="000000":for i=1to50 
20 a$=left$(f$,rnd(0)*10):b$=left$(f$,rnd(0)*10)
21 c$=left$(f$,rnd(0)*10):d$=left$(f$,rnd(0)*10)
25 e$="uuu"+a$+f$:u$(i)=z$(i)+"kkkk":z$(i)=e$+b$
26 REMprint "e:";e$:print "u:";u$(i):print "z:";z$(i):print "f:";f$
27 remgetzz$:ifzz$=""then27
28 remprintfre(0)
30 next:printx;"(";ti;")":next

