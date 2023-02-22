0 goto 10
5 next
6 if i>12 then end
7 i=k:return
10 for i=0 to 11
20 p = -(i and 1)
25 if not(p) then 100
30 gosub 90
40 goto 5
90 for k=i to i+10
100 j=i+99.9:print i,j
110 if p then for i=i to i+2:print ">>";i
120 goto 40

