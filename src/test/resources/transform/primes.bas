10 dim sv%(256):ti$="000000":cp=2
20 poke 53281,0:poke 646,7
30 print chr$(147)"prime numbers up to 255:{down}"
40 am=0
50 gosub 1000
60 if pr=0 then 100
70 print pr",";
80 am=am+1
90 goto 50
100 print"{down}number of primes (expected 54):";am
110 printti$:end
1000 if (sv%(cp)=0) then 1100
1010 cp=cp+1
1020 if cp=256 then pr=0:return
1030 goto 1000
1100 sv%(cp)=1:ml=cp
1110 if ml>=256 then pr=cp:return
1120 sv%(ml)=1:ml=ml+cp
1130 goto 1110
