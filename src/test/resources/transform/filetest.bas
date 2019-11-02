10 open2,8,2,"testfile,s,w"
20 print#2,"yeah!"
30 close 2
40 open2,8,2,"testfile,s,r"
50 get#2,a$:printa$;
60 if a$<>chr$(13)goto50
70 close2:end

