5 print "write file"
10 open 3,8,2,"testfile,s,w"
20 print#3,"yeah!"
30 close 3
35 print "read by get"
40 open 4,8,2,"testfile,s,r"
50 get#4,a$:print a$;
60 if a$<>chr$(13) goto 50
70 close 4
75 print:print "read by input"
80 open 4,8,2,"testfile,s,r"
90 input#4,a$
100 close 4:print a$

