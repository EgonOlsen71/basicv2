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
125 sr=s
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
230 e=4*1023*1024/2
240 print "expected sum: ";e
250 print "real sum:     ";sr
260 print "integer sum:  ";s
270 if sr<>e then print "real array read mismatch"
280 if s<>e then print "integer array read mismatch"
290 if sr=e and s=e then print "both array reads ok"
300 end
