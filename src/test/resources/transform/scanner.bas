0 poke 53280,15:poke 53281,15:poke 646,0:dim by%(255):c0$=chr$(0)
10 print chr$(147);"disk scanner":print:lb=0:cb=0:xm=0
15 print"search term can be hex or ascii."
16 print"for hex, use $ prefix. Like: $ffa01222"
17 print"for ascii, just enter the text.":print
20 input "search for";t$
25 er=0:gosub 3000: if er=1 then 10
26 input "start at track";tt
30 print chr$(147);"scanning for":print t$:print 
35 cb=0:if tt<1 or tt>35 then tt=1
40 ti$="000000":open 1,8,15:open 2,8,2,"#"
42 t=tt:s=0:sm=21:ts=0:ss=0:sb=0
43 if t>17 then sm=19
44 if t>24 then sm=18
45 if t>30 then sm=17
50 print#1,"u1:";2;0;t;s:sc=0
52 poke 781,2:sys 65478
55 poke 1024+37,t:poke 1024+38,s
70 get a$:c%=asc(a$+c0$)
72 poke 1024+39,sc
75 if by%(cb)<>c% then co=cb:cb=0:if co>0 then gosub 1000
80 if by%(cb)=c% then cb=cb+1:gosub 2000
90 if cb=1 then ts=t:ss=s:sb=sc
100 if cb=lb then gosub 200
110 sc=sc+1:if sc<256 then 70
120 s=s+1:if s=sm then s=0:t=t+1
130 if t<36 then 43
160 sys 65484:close 2:close 1
170 open 1,8,15,"i":close 1
199 print:print"scan completed in ";ti$:end
200 print "found at track";ts; " sector";ss;" byte"sb
210 cb=0:gosub 1000:return
1000 for i=55296+40 to 55296+40+lb*xm
1010 poke i,0:next:return
2000 for i=55296+40 to 55296+40+cb*xm-1
2010 poke i,7:next:return
3000 if t$="" then er=1: return
3010 if left$(t$,1)="$" then 3100
3020 lb=len(t$):xm=1
3030 for i=1 to lb:c1$=mid$(t$,i,1)
3040 by%(cp)=asc(c1$):cp=cp+1:next:return
3100 t$=right$(t$,len(t$)-1):lb=len(t$)/2:xm=2
3105 if (len(t$) and 1)=1 then er=1:return
3110 for i=1 to lb*2 step 2:c1$=mid$(t$,i,1):c2$=mid$(t$,i+1,1)
3120 c1=asc(c1$):c2=asc(c2$):if c1>64 then c1=c1-7
3130 if c2>64 then c2=c2-7
3140 c1=c1-48:c2=c2-48:vl=c1*16+c2
3150 if vl<0 or vl>255 then er=1:return
3160 by%(cb)=vl:cb=cb+1:next:return
