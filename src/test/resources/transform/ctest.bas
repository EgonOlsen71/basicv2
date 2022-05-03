0 o=1:w=255:goto10
1 forj=1to256:fori=1024to2023:pokei,(peek(i)+o)andw:next:next:return
2 forj=1to128:fori=1024to2023:pokei,peek(i)+o:next:next:return
3 forj=1to256:fori=1024to2023:pokei,(peek(i)+1)and255:next:next:return
4 forj=1to128:fori=1024to2023:pokei,peek(i)+1:next:next:return
10 print"waehle test:"
12 print" 1. 256 tests m/ variablen (schnell 256)
14 print" 2. 128 tests m/ variablen (schnell 128)
16 print" 3. 256 tests m/ konstant
18 print" 4. 128 tests m/ konstant
100 wait198,1:geta$:a=val(a$):ifa<1ora>4thenprint"ungültig. bitte nochmal":goto100
102 print"compiler test ("a$"): ";:ti$="000000"
104 onagosub1,2,3,4
106 print"fertig in ";ti$