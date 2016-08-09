10 let w=500:dim f(w):let p=1:let a=3
20 printa:let f(p)=a:let p=p+1:if p>w then stop
30 let a=a+2:let x=1
40 let s=a/f(x):if s=int(s) then 30
50 let x=x+1:if x<p and f(x)*f(x)<=a then 40
60 goto 20
