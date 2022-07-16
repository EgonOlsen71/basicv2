10 print chr$(147);
20 print".....******....."
21 print"...**......**..."
22 print"..*..........*.."
23 print".*............*."
24 print".*............*."
25 print"*......**......*"
26 print"*.....*..*.....*"
27 print"*....*....*....*"
28 print"*....*....*....*"
29 print"*.....*..*.....*"
30 print"*......**......*"
31 print".*............*."
32 print".*............*."
33 print"..*..........*.."
34 print"...**......**..."
35 print".....******....."
37 x%=4:y%=4:gosub 126
39 end
40 rem ----------
126 x$=chr$(x%):y$=chr$(y%)
127 if x$="" then return
128 x%=asc(x$):x$=mid$(x$,2)
129 y%=asc(y$):y$=mid$(y$,2):gosub 138:if p% then 127
130 x%=x%-1:gosub 138: if not p% then 130
131 x%=x%+1:u%=0:d%=0
132 gosub 270:y%=y%-1:gosub 138:if p% then u%=0:goto 134
133 if not u% then x$=x$+chr$(x%):y$=y$+chr$(y%):u%=-1
134 y%=y%+2:gosub 138:if p% then d%=0:goto 136
135 if not d% then x$=x$+chr$(x%):y$=y$+chr$(y%):d%=-1
136 y%=y%-1:x%=x%+1:gosub 138:if not p% then 132
137 goto 127
138 if x%<0 or x%>15 or y%<0 or y%>15 then p%=-1:return
139 gosub200:return
150 rem ----------
200 ad%=1024
210 ad%=ad%+40*y%+x%
220 r%=peek(ad%)
230 if r%=46 then r%=0
240 if r%=42 then r%=-1
245 p%=r%
250 return
260 rem ----------
270 ad%=1024
280 ad%=ad%+40*y%+x%
290 poke ad%,42
300 return
310 rem ----------