10 w=500:dim f(500):p=1:a=3:sc=1024
20 print a:f(p)=a:p=p+1:if p>w then stop
30 a=a+2:x=1
40 s=a/f(x):if s=int(s) goto 30
50 x=x+1:if x<p and f(x)*f(x)<=a goto 40
60 goto 20