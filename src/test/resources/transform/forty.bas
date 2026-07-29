5 goto 10
6 next:if a=0 then end
7 goto 50
8 next:goto 50
10 for i=0 to 10
20 print i;
30 goto 80
40 a=0:goto 6
50 print:for i=11 to 15
60 print i;
70 goto 40
80 a=1:on (i and 1)+1 goto 6,8