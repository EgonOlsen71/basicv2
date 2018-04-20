10 f$="1234567890":dimz$(50):dimu$(50):forx=0to1000:for i=1to50 
20 a$=left$(f$,rnd(0)*10):b$=left$(f$,rnd(0)*10)
21 c$=left$(f$,rnd(0)*10):d$=left$(f$,rnd(0)*10)
25 e$="uuu"+a$+f$:u$(i)=z$(i)+"kkkk":z$(i)=e$+b$
30 next:printfre(0):next




