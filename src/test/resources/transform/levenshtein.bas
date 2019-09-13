5 ti$="000000"
10 input"1. wort";a$:input"2. wort";b$
20 l0=len(a$)+1:l1=len(b$)+1
30 dim co(255):dim nc(255)
40 for i=0tol0-1:co(i)=i:next
50 for j=1tol1-1
60 nc(0)=j
70 for i=1tol0-1
80 ma=1: if mid$(a$,i,1)=mid$(b$,j,1) then ma=0
90 cr=co(i-1)+ma
100 ci=co(i)+1
110 cd=nc(i-1)+1
120 ct=ci:ifcd<cithenct=cd
130 cj=cr:ifct<crthencj=ct
140 nc(i)=cj
150 nexti
160 for i=0tol0-1
170 ov=co(i):co(i)=nc(i):nc(i)=ov
180 nexti
190 nextj
200 print co(l0-1):printti$,ti
