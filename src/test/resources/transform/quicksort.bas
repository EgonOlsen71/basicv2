100 dim f%(1000),l%(50),r%(50)
105 n%=1000
110 print"feld fuellen...{space*2}";:t=ti
130 fori=1ton%:f%(i)=rnd(1)*32000:next
140 t=ti-t:printt/60"sec"
160 print"feld sortieren... ";:t=ti
180 l%(1)=1:r%(1)=n%:t%=0:gosub500
190 t=ti-t:printt/60"sec"
220 end
230 :
500 t%=t%+1:ifl%(t%)>=r%(t%)then600
510 l%=l%(t%):r%=r%(t%):v%=f%((l%+r%)/2)
520 ifl%>r%then580
530 iff%(l%)<v%thenl%=l%+1:goto530
540 iff%(r%)>v%thenr%=r%-1:goto540
550 ifl%>r%then580
560 h%=f%(l%):f%(l%)=f%(r%):f%(r%)=h%
570 l%=l%+1:r%=r%-1:goto520
580 r%(t%+1)=r%:l%(1+t%)=l%(t%):gosub500
590 l%(t%+1)=l%:r%(1+t%)=r%(t%):gosub500
600 t%=t%-1:return
