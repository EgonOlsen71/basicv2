10 v=53248:pokev+33,0:pokev+32,0:printchr$(158)chr$(142)chr$(8)chr$(147)
20 vr%=1024:t%=255:z%=rnd(-ti):z%=77:r%=peek(1):x$="starwars":dim l%(8),c%(3)
30 fori=0to2:readc%(i):next:data11,12,15
40 fori=0tolen(x$)-1:of%=vr%+8*(iand3)+124-4e2*(i>3):poke56334,0:poke1,51
50 b=v+8*(asc(mid$(x$,i+1))and63)
60 forj=0to7:l%(j+1)=peek(b+j):next
70 poke1,r%:poke56334,1
80 forj=0to8:b%=l%(j)
90 w%=int(b%/2)or(b%*2and t%)
100 ifj>0thenw%=w%orl%(j-1)
110 ifj<8thenw%=w%orl%(j+1)
120 w%=w%andnot b%:k%=7
130 ifw%and1thenpoke of%+k%+40*j,z%
140 k%=k%-1:w%=int(w%/2):ifw%then130
150 next:next
160 fori=0to99:n=vr%+1e3*rnd(1)
165 ifpeek(n)=32thenpoken,46:poke54272+n,c%(rnd(1)*3)
170 next:poke198,0:wait198,1:sys58648