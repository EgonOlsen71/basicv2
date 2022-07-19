10 print  chr$(147);
20 print  "******************"
21 print  "*.....******.....*"
22 print  "*...**......**...*"
23 print  "*..*..........*..*"
24 print  "*.*............*.*"
25 print  "*.*............*.*"
26 print  "**......**......**"
27 print  "**.....*..*.....**"
28 print  "**....*....*....**"
29 print  "**....*....*....**"
30 print  "**.....*..*.....**"
31 print  "**......**......**"
32 print  "*.*............*.*"
33 print  "*.*............*.*"
34 print  "*..*..........*..*"
35 print  "*...**......**...*"
36 print  "*.....******.....*"
37 print  "******************"
38 print 
39 :
40 x%=3:y%=9:sc%=1024:ch%=42:t1=ti: gosub 50:t2=ti: print (t2-t1)/60: end 
41 :
50 ad%=sc%+40*(y%+1)+(x%+1):h$=chr$(ad%/256):l$=chr$(ad%-256*asc(h$))
51 if h$="" then return 
52 ad%=256*asc(h$)+asc(l$): gosub 61: if peek(ad%)=ch% then 51
53 ad%=ad%-1: if peek(ad%)<>ch% then 53
54 ad%=ad%+1:u%=0:d%=0
55 poke ad%,ch%:ad%=ad%-40: if peek(ad%)=ch% then u%=0: goto 57
56 if not u% then z$=chr$(ad%/256):h$=h$+z$:l$=l$+chr$(ad%-256*asc(z$)):u%=-1
57 ad%=ad%+80: if peek(ad%)=ch% then d%=0: goto 59
58 if not d% then z$=chr$(ad%/256):h$=h$+z$:l$=l$+chr$(ad%-256*asc(z$)):d%=-1
59 ad%=ad%-39: if peek(ad%)<>ch% then 55
60 goto 51
61 h$=right$(h$,len(h$)-1)
62 l$=right$(l$,len(l$)-1)
63 return 
