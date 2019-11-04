10 a=0:screen a:gosub1000
20 a=a+2:screen a:gosub1000
30 screen 128:gosub1000
40 screen 2:print"this should error...":screen 1:end
1000 printchr$(147);"press any key!"
1005 geta$:if a$=""then1005
1010 return