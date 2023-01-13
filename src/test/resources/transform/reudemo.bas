0 poke 53280,0:poke 53281,0:poke 646,5:print chr$(147);
10 re = 57088
30 gosub 500:gosub 2000
60 poke 646,7:print chr$(147);
70 goto 3000

500 rem setup address table
505 print "setting up address table..."
510 dim ad%(256*3):ix%=0
520 for ad=0 to 255*1000 step 1000
530 mb%=int(ad/65536)
532 bb%=int(ad/256) and 255
534 lb%=ad-mb%*65536-bb%*256
540 ad%(ix%)=lb%:ad%(ix%+1)=bb%:ad%(ix%+2)=mb%
545 ix%=ix%+3
550 next ad:return

1000 rem setup, target address in ad5, index in ix%
1020 poke re+2,0:poke re+3,4: rem copy from 1024
1030 poke re+4,ad%(ix%):poke re+5,ad%(ix%+1)
1035 poke re+6,ad%(ix%+2): rem addr in reu
1040 poke re+7,232:poke re+8,3: rem copy 1000 Bytes 
1050 return

2000 rem init screens and copy them into reu
2010 ix%=0:for i=0 to 255
2020 for p=1024 to 2023:poke p,i:next p
2050 print chr$(19);i
2060 gosub 1000
2065 ix%=ix%+3
2070 poke re+1,128+16+0: rem copy from ram into reu 
2075 gosub 4000 
2080 next i
2090 return

3000 rem copy screen back from reu
3010 ti$="000000":ix%=0
3020 gosub 1000
3030 poke re+1,128+16+1: rem copy from reu into ram
3035 gosub 4000
3040 ix%=ix%+3:if ix%<256 then 3020
3050 print chr$(147);int((ad / 1024) / (ti / 60));" kbytes/sec."
3060 get a$:if a$="" then 3060
3070 goto 3000

4000 rem wait for completion
4010 if (peek(re) and 64)=0 then 4010
4020 return

 

