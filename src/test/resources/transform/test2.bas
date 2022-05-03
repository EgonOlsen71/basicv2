10 a=5:b%=-a/2:printb%:a$="yepp!"
20 print "value:";a+2;a-3,(10+a)*(a+4),(20/a)
30 gosub 100:print"end!"
32 if a=4thenprint"a is 4":print"...or is it?"
33 if a=5thenprint"a is 5":printa$
35 for i=1to10:print"i=";i:nexti:print"ended at ";i
36 for i=10to0step-2.5:print"i=";i:next
40 end
100 print "hello, i'm here!":goto200
110 return
200 print"and here!":gosub500
210 print"yeah":goto110
500 print"and also here!":return
