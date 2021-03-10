0 goto1000
1 print"directory":open1,8,0,"$":get#1,a$,a$:e$=chr$(0)
2 fori=0to1step0:get#1,a$,a$,h$,l$:ifstthenclose1:return
3 print">"asc(h$+e$)+256*asc(l$+e$);
4 fors=0to1:get#1,a$,b$:iflen(b$)>0thenprinta$b$;:s=abs(st):next
5 printa$:next i
1000 gosub1