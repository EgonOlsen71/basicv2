10 fori=0to3
20 oni+1goto100,200,300
30 next
40 fori=0to3
50 oni+1gosub1000,2000,3000
60 next
70 end
100print"1":goto30
200print"2":goto30
300print"3":goto30
1000print"->1":return
2000print"->2":return
3000print"->3":return

