10 rem real array read benchmark
20 dim a(1023)
30 for i=0 to 1023
40 a(i)=i
50 next i
60 s=0:t=ti
70 for r=1 to 4
80 for i=0 to 1023
90 s=s+a(i)
100 next i
110 next r
120 tr=ti-t
130 s=0:t=ti
140 for r=1 to 4
150 for i=0 to 1023
160 j%=i:s=s+a(j%)
170 next i
180 next r
190 tn=ti-t
200 print "4096 reads per loop"
210 print "real index:   ";tr;" jiffies"
220 print "integer index:";tn;" jiffies"
230 end
