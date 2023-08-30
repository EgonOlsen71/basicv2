15 gosub 20000:ti$="000000"
20 x%=24:y%=10:gosub 10320:print ti:end
10320 bc%=81:ch%=32:fc%=bc%:sl%=16384:sh%=16384:ta%=1024
10400 ad%=ta%+40*y%+x%
10410 gosub 10700
10430 if sh%<=sl% then return
10440 ad%=256*h%:ad%=ad%+l%
10450 sl%=sl%+2:h%=peek(sl%+1):l%=peek(sl%)
10460 if peek(ad%)>ch% then 10430
10470 ad%=ad%-1
10480 if peek(ad%)=ch% then 10470
10490 ad%=ad%+1:u%=0:d%=0
10520 poke ad%,fc%
10530 ad%=ad%-40
10540 if peek(ad%)>ch% then u%=0:goto 10560
10550 if u%=0 then gosub 10700:u%=-1
10560 ad%=ad%+80
10570 if peek(ad%)>ch% then d%=0:goto 10590
10580 if d%=0 then gosub 10700:d%=-1
10590 ad%=ad%-39
10600 if peek(ad%)=ch% then 10520
10610 goto 10430

10699 rem push
10700 z%=ad%/256:poke sh%+1,z%:z%=ad% and 255:poke sh%,z%
10702 h%=peek(sl%+1):l%=peek(sl%)
10705 sh%=sh%+2
10720 return

20000 print chr$(147);:i=rnd(-12)
20010 for i=1024 to 2023:poke i,160:next
20020 for i=1024+40 to 2023-40 step 40
20030 for p=0 to 2:xs%=rnd(1)*38+1:xe%=rnd(1)*38+1
20040 if xe%<xs% then t%=xe%:xe%=xs%:xs%=t%
20050 for h=xs%+i to xe%+i:poke h,32:next
20060 next
20070 next:return