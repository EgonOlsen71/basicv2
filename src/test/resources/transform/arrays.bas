10 dim x%,y%
20 dim a%(20,20),a(20,20)
30 t0=ti
40 for x=0 to 19
50 for y=0 to 19
60 a(x,y)=13
70 next:next
80 print "for a(x,y): ";(ti-t0)/60.0
90 t0=ti : rem ================
100 x%=0
110 y%=0
120 a%(x%,y%)=13
130 if y%-18<0 then y%=y%+1:goto 120: rem next y
140 if x%-18<0 then x%=x%+1:goto 110: rem next x
150 print "goto a%(x%,y%): ";(ti-t0)/60.0
155 rem ================
160 dim ai%(20): rem  index for y array
170 dim fa%(400): rem flat a array
180 for i=0 to 19:ai%(i)=i*20:next
190 t0=ti
200 x%=0
210 y%=0
215 rem print ai%(y%)+x%;
220 fa%(ai%(y%)+x%)=13
230 if y%-18<0 then y%=y%+1:goto 215: rem next y
240 if x%-18<0 then x%=x%+1:goto 210: rem
250 print "goto fa%(a%(y%)+x%): ";(ti-t0)/60.0
400 for i=0 to 19:ai%(i)=20480+i*20:next:rem mem at $5000
410 t0=ti
420 x%=0
430 y%=0
440 poke ai%(y%)+x%, 13
450 if y%-18<0 then y%=y%+1:goto 440: rem next y
460 if x%-18<0 then x%=x%+1:goto 430: rem next x
470 print "poke a%(y%)+x%: ";(ti-t0)/60.0