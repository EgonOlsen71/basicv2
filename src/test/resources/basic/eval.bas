0 rem expression:
1 x$="a*(b+e/(r+t)*11.6)+(12/t+3*2.8)*e+(e/(r+sin(t)*sin(a+cos(b+r))/e)*11.5)"
5 rem setup
10 gosub 1000:gosub 1100
20 gosub 1200:gosub 3000
25 ti$="000000"
30 rem run evaluator
40 gosub 2000
80 print "result:";re
90 print "time:";(ti/60);"seconds"
100 end
1000 rem assign variable values
1001 :
1005 vc=5:dim vn$(vc),vv(vc)
1010 vn$(0)="a":vv(0)=23
1020 vn$(1)="b":vv(1)=12
1030 vn$(2)="e":vv(2)=11.23
1040 vn$(3)="r":vv(3)=2.3
1050 vn$(4)="t":vv(4)=44
1060 return
1100 rem setup possible operands
1101 :
1110 dim op$(8),fs$(3)
1120 op$(0)="+":op$(1)="-":op$(2)="*":op$(3)="/":op$(4)=chr$(94)
1130 op$(5)="sin":op$(6)="cos":op$(7)="tan"
1140 fs$(0)=op$(5):fs$(1)=op$(6):fs$(2)=op$(7)
1150 return
1200 rem setup stack
1201 :
1210 dim sk(100):sp=0:return
2000 rem evaluate expression
2001 :
2010 nu$="":we=0:wm=1:wf=0
2020 le=len(x$):fori=1tole
2030 c$=mid$(x$,i,1)
2040 ifc$>="a"andc$<="z"thengosub3100:goto2800
2045 p=0
2050 ifop$(p)=c$thengosub3400:goto2800
2060 p=p+1:ifp<5then2050
2070 ifc$="("orc$=")"thengosub3600:goto2800
2080 gosub 3800
2800 next
2810 wf=-1:gosub 20000:gosub 10100:re=sv
2900 return
3000 rem remove whitespaces
3001 :
3010 le=len(x$):tm$="":fori=1tole
3020 c$=mid$(x$,i,1)
3030 ifc$<>" "thentm$=tm$+c$
3040 next:x$=tm$:return
3100 rem variable or function call found
3110 :
3120 ifi+3>=len(x$)then3300
3130 f$=mid$(x$,i,3):p=0
3140 iff$=fs$(p)then3170
3150 p=p+1:ifp<3then3140
3160 goto 3300
3170 we=wm+3
3180 sv=p+5:gosub 10000
3190 sv=we:gosub 10000
3200 sv=0:gosub 10000
3210 i=i+2:return
3300 forp=0tovc
3310 ifc$=vn$(p)thennu$=str$(vv(p)):return
3320 next
3330 print"unknown variable: ";c$:end
3400 rem handle operand
3401 :
3405 we=wm
3410 ifc$="*"orc$="/"thenwe=wm+1:goto 3430
3420 ifc$=chr$(94)thenwe=wm+2
3430 iflen(nu$)>0thensv=val(nu$):gosub 10000
3440 wf=we:gosub 20000
3450 gosub 10100:tv=sv
3460 sv=p:gosub 10000
3470 sv=we:gosub 10000
3480 sv=tv:gosub 10000
3490 nu$="":return
3600 rem handle brackets
3601 :
3610 iflen(nu$)>0thensv=val(nu$):gosub 10000:nu$=""
3620 ifc$="("thenwm=wm+10
3630 ifc$=")"thenwm=wm-10
3640 return
3800 if(c$>="0"andc$<"9")orc$="."thennu$=nu$+c$:return
3810 print"syntax error in ";x$;" at position ";i;": ";c$:end
10000 rem push value to stack
10001 :
10010 sk(sp)=sv:sp=sp+1:return
10100 rem pop value from stack
10101 :
10110 sv=sk(sp-1):sp=sp-1:return
20000 rem run calculation
20001 :
20010 :
20020 ifsp<=2thenreturn
20030 ww=wf
20040 ifww<>-1thenww=sk(sp-3)
20050 ifwf>wwthenreturn
20060 gosub 10100:n1=sv
20070 gosub 10100:n2=sv
20080 gosub 10100
20090 gosub 10100:op=sv
20100 on op+1 gosub 21000,21100,21200,21300,21400,21500,21600,21700
20110 sv=n1:gosub 10000
20120 goto 20010
21000 rem +
21010 n1=n2+n1:return
21100 rem -
21110 n1=n2-n1:return
21200 rem *
21210 n1=n2*n1:return
21300 rem /
21310 n1=n2/n1:return
21400 rem power
21410 n1=n2^n1:return
21500 rem sin
21510 n1=sin(n2+n1):return
21600 rem cos
21610 n1=cos(n2+n1):return
21700 rem tan
21710 n1=tan(n2+n1):return


