10 dim pm$(20,1)
20 a$="hello":b$="world":h=0
40 i=0:pm$(i+h,i+1)=a$:printchr$(i+65)
50 i=1:pm$(i+h,0)=b$:printchr$(i+65)
60 print pm$(0,1),pm$(1,0)