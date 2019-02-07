10 print "{clr}{red}":ti$="000000":for b=99 to 1 step -1
20 gosub 100
30 t$=t$+" of beer on the wall"
40 print t$;", ";t$
50 print "take one down and pass it around, "
60 if b-1<=0 then print "no more bottles of beer on the wall":goto 80
70 gosub 200:print " of beer on the wall"
80 print:next
91 print "go to the store and buy some more, 99 bottles of beer on the wall"
92 print ti:end
100 t$=str$(b)+" bottle":if b>1 then t$=t$+"s"
110 return
200 a=b-1:print str$(a)+" bottle";
210 if a>1 then print "s";
220 return

