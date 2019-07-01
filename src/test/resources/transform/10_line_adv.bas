1 i=1:j=0:k=0:x$="cannot doyou walk opened   closed   a sword  a key    nothing"
2 x$=x$+"  a chest  a dragon a corpse ":o$="open chest":s$="get sword":l$="look "
3 print"you are in a ";mid$("cavepit halllake",i*4-3,4):inputu$
4 m=2*(u$="north")*(i<3)-2*(u$="south")*(i>2)-(i=2andu$="west")+(i=3andu$="east")
5 a=-(3+j-2*(k=2))*(i=2andu$=l$+"chest")-(11-(k=2))*(i=3andu$="kill dragon")-(m<>0)
6 a=a-(5+i)*(u$+" "=l$)-(6-k)*(u$="inventory")-(6+(k=0))*(i=4andu$=l$+"corpse")
7 b=100*i+10*j+k:a=a-10*(b=400andu$="get key")-2*(b=201andu$=o$)-10*(b=211andu$=s$)
8 i=i+m:j=j-(a=2):k=k-(a=10)
9 printmid$(x$+"taken    you died you won. ",a*9+1,9)
10 ifa<11goto3
