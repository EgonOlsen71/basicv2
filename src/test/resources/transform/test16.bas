10 a=3:print sqr(a);exp(a);abs(-a);sgn(-a);sin(a);cos(a);tan(a),rnd(-42)
20 print chr$(147):for i=0 to 10
30 print 10^i, i
40 next i:print"hhhhh";pos(0)
50 a=fre(0): if a<0 then a=a+65536
60 print "free:",a
65 def fn yt(x)=x+2
70 y=5:def fn test(x)=x*x*fnyt(y)
80 d=fntest(23):printd