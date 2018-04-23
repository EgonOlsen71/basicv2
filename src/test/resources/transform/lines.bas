10 dimad%(199):y=0
11 ad%(y)=24576+40*(yand-8)+(yand7):y=y+1:ify<200then11
12 dimb%(7):x=0:s=1
13 b%(7-x)=s:s=s+s:x=x+1:ifx<8then13
14 :
20 poke56576,peek(56576)and192or2:poke53265,59:poke53272,120
21 ad=24576
22 pokead,0:ad=ad+1:ifad<32576then22
23 ad=23552
24 pokead,16:ad=ad+1:ifad<24552then24
25 :
30 x1=int(320.*rnd(1))
31 y1=int(200.*rnd(1))
32 x2=int(320.*rnd(1))
33 y2=int(200.*rnd(1))
34 gosub 50
35 goto 30
36 :
40 ad=ad%(y)+(xand-8)
41 pokead,peek(ad)orb%(xand7)
42 return
43 :
50 sx=1
51 dx=x2-x1
52 if dx>=0 then 56
53 sx=-1
54 dx=-dx
55 :
56 sy=1
57 dy=y2-y1
58 if dy>=0 then 62
59 sy=-1
60 dy=-dy
61 :
62 x=x1
63 y=y1
64 :
65 if dy>dx then 79
66 :
67 e=dx
68 e=e/2
69 :
70 gosub 40
71 if x=x2 then return
72 x=x+sx
73 e=e-dy
74 if e>=0 then 70
75 y=y+sy
76 e=e+dx
77 goto 70
78 :
79 e=dy
80 e=e/2
81 :
82 gosub 40
83 if y=y2 then return
84 y=y+sy
85 e=e-dx
86 if e>=0 then 82
87 x=x+sx
88 e=e+dy
89 goto 82