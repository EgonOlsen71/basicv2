10 poke 646,1:print chr$(147);
20 poke 53280,0:poke 53281,0
40 print "bit fiddler / egonolsen71 - 2022"
45 poke 646,5:print "q - quit, x - clear, 0-7 and . to set"
46 poke 646,1
50 y=4:t$="stuck bits (0/1 or . for normal)":gosub 10000
60 y=10:t$="connected/shorted bits":gosub 10000
70 gosub 15000
80 gosub 20000
90 gosub 40000:gosub 41000
100 gosub 5000
1000 print chr$(147);"have a nice basic...":end

5000 ep%=0
5010 cf%=0:gosub 8200:gosub 8000:get a$:gosub 8100
5015 if a$="" then 5010
5020 if a$="q" then return
5025 if a$="x" then gosub 20010:cf%=1:goto 5200
5030 ac%=asc(a$):if ac%=29 then ep%=ep%+1:goto 5070
5040 if ac%=157 then ep%=ep%-1:goto 5070
5050 if ac%=17 then ep%=ep%+8:goto 5070
5060 if ac%=145 then ep%=ep%-8
5070 if ep%<0 then ep%=ep%+16
5080 if ep%>15 then ep%=ep%-16
5090 if ep%<8 then gosub 6000:goto 5200
5100 gosub 6500
5200 if cf%=1 then gosub 7000  
5999 goto 5010

6000 bp%=7-ep%
6010 if a$="." then b0%(bp%)=-1:cf%=1:return
6020 if a$="0" then b0%(bp%)=0:cf%=1:return
6030 if a$="1" then b0%(bp%)=1:cf%=1:return
6040 return

6500 bp%=7-(ep%-8)
6510 if a$<"0" or a$>"7" then return
6520 av%=val(a$):b1%(bp%)=av%:cf%=1:return

7000 poke 53280,11:gosub 21000:gosub 22000
7010 gosub 40000:gosub 41000
7020 poke 53280,0:return

8000 rem 
8010 oc%=peek(cp%):poke cp%,160:return

8100 rem
8110 poke cp%,oc%:return

8200 cp%=40*(7-((ep%>7)*6))+1024+(ep% and 7)*2+1:return

10000 gosub 30000
10005 gosub 11000
10010 print chr$(176);
10020 for i=0 to 6:print chr$(99);chr$(178);:next
10030 print chr$(99);chr$(174)
10040 for i=0 to 8:print chr$(98);" ";:next:print
10050 print chr$(173);
10060 for i=0 to 6:print chr$(99);chr$(177);:next
10070 print chr$(99);chr$(189)
10080 return

11000 poke 646,7:print t$:poke 646,1:for i=7 to 0 step -1
11010 print " ";right$(str$(i),1);
11020 next:print:return

15000 y=6:gosub 30000
15010 print spc(29);chr$(176);
15020 for i=0 to 7:print chr$(99);:next
15030 print chr$(174);:print
15040 for i=0 to 7
15050 print spc(29);chr$(98);spc(8);chr$(98)
15060 next
15070 print spc(29);chr$(173);
15080 for i=0 to 7:print chr$(99);:next
15090 print chr$(189);:return


20000 dim b0%(7), b1%(7),pt%(7)
20010 for i=0 to 7:b0%(i)=-1:b1%(i)=i:pt%(i)=2^i:next
20020 gosub 21000:gosub 22000
20030 return

21000 y=4:gosub 30000:print chr$(17);chr$(17);chr$(17);
21010 for i=7 to 0 step -1
21020 print chr$(29);
21030 if b0%(i)=-1 then print ".";
21040 if b0%(i)=0 then print "0";
21050 if b0%(i)=1 then print "1";
21060 next:return

22000 y=10:gosub 30000:print chr$(17);chr$(17);chr$(17);
22010 for i=7 to 0 step -1
22020 print chr$(29);right$(str$(b1%(i)),1);
22060 next:return

30000 print chr$(19);: for i=1 to y:print chr$(17);:next
30010 return

40000 gosub 50000:i%=0
40010 for i=0 to 34:bv%=peek(58485+i) and 63:gosub 51000
40020 poke 1704+i,bv%:next
40030 bv%=i%:gosub 51000:poke 1744+i%,bv%
40040 i%=i%+1:if i%<256 then 40030
40050 return

41000 gosub 50000:x%=30:y%=7*40
41010 for i=0 to 15:bv%=i:gosub 51000
41020 sc%=1024+x%+y%
41030 poke sc%,160:poke sc%+1,160:poke sc%+40,160:poke sc%+41,160
41035 cc=sc%+54272:poke cc,bv%:poke cc+1,bv%:poke cc+40,bv%:poke cc+41,bv%
41040 x%=x%+2:if x%>37 then x%=30:y%=y%+80
41050 next:return

50000 o%=0:a%=255:for i=7 to 0 step -1
50010 v%=pt%(i):b%=b0%(i):if b%=-1 then 50050
50020 if b%=0 then a%=a%-v%:goto 50050
50030 if b%=1 then o%=o%+v%
50050 next
50060 md%=0:for i=0 to 7:if b1%(i)<>i then md%=1:i=8
50070 next
50080 return

51000 bv%=bv% and a%:bv%=bv% or o%
51010 if md%=0 then return
51020 bo%=bv%:j%=7
51025 jj%=b1%(j%):if jj%=j% then 51060
51030 v%=pt%(j%):bi%=bo% and pt%(jj%)
51040 if bi% then bv%=bv% or v%:goto 51060
51050 bv%=(bv% and (255-v%))
51060 j%=j%-1:if j%>-1 then 51025
51070 return 

