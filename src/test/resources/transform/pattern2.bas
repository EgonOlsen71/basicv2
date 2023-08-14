0 cl%(0)=5:s1%=1024:s2%=2024:i%=0
1 poke55296+i%,cl%(i%and2):i%=i%+1:if i%<1000 then 1
2 poke53281,0:c%=32
3 n%=1
4 c%=192-c%:a%=0
5 b%=s1%+a%
6 poke b%,c%
7 b%=b%+n%:if b%<s2% then 6
9 a%=a%+1:if a%<=n% then 5
10 n%=n%+1:if n%<42 then 4