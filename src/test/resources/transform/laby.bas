1 rem -- mazegenerator in basic v2
2 rem -- by oliver hermanni
3 rem --
4 rem -- original basic v2 code is from the book
5 rem -- "programming the commodore 64 - the definitive guide"
6 rem -- by raeto collin west
10 poke 53280,peek(53281):print "{clear}"
20 a(0)=-2:a(1)=-80:a(2)=2:a(3)=80
30 sc%=1024:a%=sc%+81+80*int(10*rnd(1))+2*int(10*rnd(1))
40 for j=1 to 23:print"{reverse on}{space*39}":next
100 poke a%,4
110 j%=rnd(1)*4:x%=j%
112 ifs%>sm% then sm%=s%:fi%=b%
120 b%=a%+a(j%)
125 if peek(b%)=160 then poke b%,j%:k%=a%+a(j%)/2:poke k%,32:a%=b%:s%=s%+1:goto 110
130 j%=j%+1 and 3:if j%<>x% then 120
140 j%=peek(a%):poke a%,32:s%=s%-1:if j%<4 then a%=a%-a(j%):goto 110
150 poke a%,1:poke fi%,2
160 goto 160