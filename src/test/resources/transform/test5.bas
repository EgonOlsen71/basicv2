10 a=5:lo%=2:u=3
20 b=155:f%=12:zz=67.4
30 c=a+b+(f%-zz)
40 poke 1024,((c*lo%/3) AND 63) or 96
50 a=5.5
60 b=int(a)*10:g%=b:poke 1025,b:poke1026,g%+b+lo%
70 poke2,a:if a>2then poke2,123:ifa>=5.51then poke2,111
