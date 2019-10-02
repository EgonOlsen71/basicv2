10 c=32000:b=0:ti$="000000":for i=0 to 40000
20 if i<30000 then b=b+1
25 if i=20000 then print "halftime"
30 c=c-1:u=peek(b+1):poke 832,35
40 next
50 printb,c,u,ti