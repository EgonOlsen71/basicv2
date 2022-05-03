print"basic test: ";:ti$="000000"
forj=0to255:fori=1024to2023:pokei,1+peek(i)and255:next:next
t$=str$(int(ti/60)):t=len(t$)
t$=right$(t$,t-1):h$=left$(ti$,2)+":"
m$=mid$(ti$,3,2)+":":s$=right$(ti$,2)
printh$m$s$" ("t$" seconds)"