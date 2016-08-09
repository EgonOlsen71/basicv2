10 print "* 64er online - mini textadventure *"
20 print
30 print "sie befinden sich im wald der hexe schrumpeldei."
40 print "es wird langsam dunkel und ihnen ist kalt."
50 print
60 print "wo moechten sie hin? (norden, sueden, westen)"
70 input a$
80 if a$="norden" then goto 200
90 if a$="sueden" then goto 300
100 if a$="westen" then goto 400
110 if a$="osten" then goto 400
120 print "entschuldigen sie bitte! ich konnte ihre eingabe nicht verstehen!"
130 goto 50
200 print "sie sind der hexe schrumpeldei direkt in die arme gelaufen."
210 goto 1000
300 print "sie haben es geschafft! der ausgang des waldes liegt vor ihnen."
310 goto 1000
400 print "es wird immer dunkler."
410 print "aus der fernde ist das heulen von bissigen woelfen zu hoeren"
420 goto 50
1000 print "ende"