10 open2,2,0,chr$(8)+chr$(0)
15 rem input#2,a$:print"i:";a$:goto15
20 get#2,a$ : print a$;
30 get a$ : print a$; : if a$<>""then s$=s$+a$
40 if a$=chr$(13)then print#2,s$; : s$=""
50 goto 20