1000 print chr$(147):input "teile...";nu$
1010 input "durch...";di$
1020 if len(di$)>len(nu$)then1000
1030 gosub 10000:gosub 20000
1050 goto 1000
10000 en=2:sa=1:nu$=" "+nu$:nn$="":nr$="":print chr$(147);nu$;":";di$;"="
10010 of$="":ok=0:di=val(di$)
10020 pa$=of$+mid$(nu$,sa+1,en-sa)
10030 va=val(pa$)
10040 if not(va>0 and va<di and en+1<=len(nu$)) then 10100
10050 if len(nn$)>0 then nn$=nn$+"0"
10060 en=en+1
10070 goto 10020
10100 wn=int(va/di):ws=wn*di
10110 re=va-ws:va$=str$(va):va$=right$(va$,len(va$)-1)
10112 printspc(en-len(va$));va$:sp=en-len(va$)-1:ifsp<0thensp=0
10115 ws$=str$(ws):printspc(sp);left$("--------------------",len(ws$)+1)
10116 gosub20000
10118 printspc(sp);"-";right$(ws$,len(ws$)-1)
10120 t$=str$(wn):t$=right$(t$,len(t$)-1)
10130 nn$=nn$+t$:pr$=nn$:gosub30000:gosub20000
10140 t$=str$(re):t$=right$(t$,len(t$)-1)
10150 of$=t$
10160 if en+1>len(nu$) then 10200
10170 sa=en:en=en+1:goto 10020
10200 nr$=str$(re)
10210 printspc(en-len(nr$));nr$
10220 pr$=nn$:if len(nr$)>0 and val(nr$)>0 then pr$=pr$+" r"+nr$
10230 gosub30000:return
20000 cs=peek(53280):poke53280,1
20010 geta$:ifa$=""then20010
20020 poke53280,cs:return
30000 po=len(nu$)+len(di$)+2+1024
30010 for i=1tolen(pr$):as=asc(mid$(pr$,i,1))
30015 if as>58 then as=as-64
30020 pokepo+i,as
30030 next:return

