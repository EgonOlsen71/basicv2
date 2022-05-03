10 read a
20 print "a=";a
30 data 35
40 restore:read a
50 for i=1 to 3:read a,b:print "a,b=";a;",";b:next
60 dim a$(10):b=3
70 read a$(b*2)
80 print "str=";a$(2*b)
90 read a$:print a$:end
100 data 1,2,3,4,5,6
110 data "hello world","Blah"