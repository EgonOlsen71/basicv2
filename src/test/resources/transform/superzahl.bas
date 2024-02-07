1000 rem *** superzahl by vitus eisele
1010 ti$="000000"
1030 n=6: gosub 1100
1060 print ti/60
1070 end
1090 rem == findsuper (n)
1100 for i=1 to n: d(i)=i: next
1110 k=1
1190 rem == permut (k)
1200 if k=n goto 1300
1220 t=k
1230 i=d(k):d(k)=d(t):d(t)=i: t(k)=t: k=k+1: gosub 1200
1240 k=k-1: t=t(k): i=d(k):d(k)=d(t):d(t)=i
1250 t=t+1: if t<=n goto 1230
1260 return
1290 rem == issuper (n)
1300 for i=2 to n
1310 gosub 1400: if int(z-int(z/i)*i) then return
1320 next
1330 print z
1340 return
1390 rem === initial (i)
1400 z=0: for i2=1 to i
1410 z=d(i-i2+1)*10^(i2-1)+z
1420 next
1430 return
