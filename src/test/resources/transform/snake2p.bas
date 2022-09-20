10 poke 53280,11: poke 53281,0: poke 646,1
100 dim p%(1,999),h(1),d(1),l(1),c(1),wz(1):cp=0
110 for i=0 to 1:l(i)=2:h(i)=0:d(i)=-1:wz(i)=5:next
120 p%(0,0)=1024+12*40+10:p%(1,0)=1024+12*40+30
130 p%(0,1)=1024+12*40+11:p%(1,1)=1024+12*40+29
136 c(0)=6:c(1)=8
140 print chr$(147);
145 gosub 6005
150 gosub 1000: gosub 6000
160 gosub 3000: gosub 7000
170 cp=(cp+1) and 1
180 goto 150
1000 i=h(cp):sp=i-1:if sp=-1 then sp=l(cp)-1
1020 sa=p%(cp,sp)
1030 ka=p%(cp,i)+d(cp):gosub 4000:poke sa,32
1040 p%(cp,sp)=ka:h(cp)=sp
1050 return 
2000 if l(cp)>999 then return 
2010 l(cp)=l(cp)+1:for i=l(cp)-1 to h(cp)+1 step -1
2020 p%(cp,i)=p%(cp,i-1): next 
2030 sp=h(cp)-1:if sp=-1 then sp=l(cp)-1
2040 h(cp)=h(cp)+1:if h(cp)=l then h(cp)=0
2050 sn=h(cp)-1:if sn=-1 then sn=l(cp)-1
2060 p%(cp,sn)=2:return 
3000 j=peek(56320+cp) and 127
3010 if j=127 then return
3015 d=d(cp) 
3020 if j=126 and d<>40 then d(cp)=-40:return 
3030 if j=125 and d<>-40 then d(cp)=40:return 
3040 if j=123 and d<>1 then d(cp)=-1:return 
3050 if j=119 and d<>-1 then d(cp)=1:return 
3060 rem if (j and 16)=0 then gosub 2000
3070 return 
4000 if ka<1024 then ka=ka+1000
4010 if ka>2023 then ka=ka-1000
4020 if peek(ka)=160 then gosub 5000
4030 if peek(ka)=81 then wz(cp)=5:gosub 2000
4050 poke ka+54272,c(cp):poke ka,160:return 
5000 poke 646,1:print "aua!"
5005 if ((peek(56320)<>127) or (peek(56321)<>255)) then 5005
5010 if ((peek(56320)=127) and (peek(56321)=255)) then 5010
5020 run 
6000 wz(cp)=wz(cp)-1:if wz(cp)<>0 then return 
6005 x=int(4+rnd(0)*31):y=int(2+rnd(0)*20)
6010 p=1024+y*40+x
6020 if peek(p)<>32 then 6005
6030 poke p+54272,1:poke p,81
6050 return
7000 print chr$(19);:poke 646,c(cp)
7010 print spc(34*cp);(l(cp)-2)*100:return 


