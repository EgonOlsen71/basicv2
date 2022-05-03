0 print "{clr}{down}  division 2000{down}":input"  ";x
1 input"  {96*37}    ";y
2 ify<>int(y)thenx=x*10:y=y*10:goto2
3 ify>2000thenprint"{down} (bis 2000 stellen periodenerkennung)"
4 dimr(2000):ti$="000000"
5 n=int(x/y):x=x-y*n:r(m)=x:ifpeek(211)=0orpeek(211)=40thenprint"{down}";
6 printright$(str$(n),len(str$(n))-1);:ifk=0thenprint".";
7 ifm=0goto10
8 forf=0tom-1:ifr(m)=r(f)goto11
9 next
10 n=0:k=1:m=m+1:x=x*10:goto5
11 ford=1tom-f:print"{left}";:ifpeek(211)=39orpeek(211)=79thenprint"{up}";
12 next:print"{up}";:ford=1tom-f:print"_";:ifpeek(211)=0orpeek(211)=40thenprint"{down}";
13 next:print"{down*2}":printti$:poke198,0:wait198,1:getk$:run
