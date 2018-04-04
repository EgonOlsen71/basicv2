10 poke53280,6:print "{clr}{white}"
20 for i=1984 to 2023:poke i,160:next i
30 a=20:x=-1:y=-1:pu=20
40 poke 1944+a,94:remcn=0
50 get a$:remcn=cn+1:if cn=20000thenend
51 gosub 1000
52 if a$=""then goto 50
55 poke 1944+a,32
60 if a$="{right}"then a=a+1
70 if a$="{left}"then a=a-1
80 if a<0 then a=0
90 if a>39then a=39
95 gosub 2000
100 goto 40
1000 p=1024+x+y*40
1005 if x=-1 then x=int(rnd(0)*40):y=-1:p=1024+x+y*40
1010 if x>-1andy>-1 and p<2024 then poke p,32
1030 y=y+1:p=p+40
1040 if p<2024 then poke p,160
1050 if y>=23 then gosub3000
1055 poke 1944+a,94
1900 return
2000 print"{home}punkte:      "
2010 print"{home}{right}{right}{right}{right}{right}{right}{right}";pu
2020 return
3000 if a=x then pu=pu+10
3010 if a<>x then pu=pu-5
3020 x=-1:pokep,32:gosub 2000
3030 return
            