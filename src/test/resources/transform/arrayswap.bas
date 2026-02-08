200 n=3
220 for i=1 to n: d%(i)=i: next
300 for k=1 to n: for t=k to n
310 gosub 500: gosub 500
320 next t,k
330 end
500 i%=d%(k):d%(k)=d%(t):d%(t)=i%
510 print k, t, 100*d%(1)+10*d%(2)+d%(3)
520 return
