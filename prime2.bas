10 w=500:dim f(w):p=1:a=3
20 printa:f(p)=a:p=p+1:if p>w then stop
30 a=a+2:let x=1
40 s=a/f(x):if s=int(s) goto 30
50 x=x+1:if x<p and f(x)*f(x)<=a goto 40
60 goto 20