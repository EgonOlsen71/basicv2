100 for i=49152 to 49177
110 read x:poke i,x:s=s+x:next
120 data 32,253,174,32,158,183,138,72,32,253,174,32
130 data 158,183,104,168,24,32,240,255,32,253,174,76
140 data 164,170
150 if s<>3566 then print"fehler in den datas!":end
160 poke 646,7:print chr$(147);:s=49152:c=0
200 for i=0 to 2*3.14159 step 0.1
205 if (c and 6)=6 then c=7
210 x=int(sin(i)*8):y=int(cos(i)*8)+10:poke 646,c:c=c+1
220 a$=chr$(113):xp=x+20
230 if xp>=18 then 260
240 xi=xp+1
250 po=1024+y*40+xi:if peek(po)=32 then poke po,64:xi=xi+1:goto 250
260 sys s,xp,y,a$
270 next
