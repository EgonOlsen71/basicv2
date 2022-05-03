 1 m=9000
10 dim a$(m)
20 print "freier stringspeicher: " fre(0)
30 b$=chr$(65)
40 print "array setup ..."
50 for i=0 to m : a$(i)=b$: next
60 print "garbage collection ..."
70 ti$="000000"
80 print fre(0) "bytes frei"
90 print "dauer (hhmmss): " ti$ " /" int(ti/3600+1) "minuten"