0 dima$(20):printchr$(147):x=15:min=1:max=11:p=1:y=2
100 poke 782,x:    rem x-pos
110 poke 781,p+y:  rem y-pos
120 poke 783,0: poke53280,0:   rem set status
130 sys 65520
205 a$(1)="eins"
210 a$(2)="zwei"
215 a$(3)="drei"
220 a$(4)="vier"
225 a$(5)="fuenf"
230 a$(6)="sechs"
235 a$(7)="sieben{space*2}"
240 a$(8)="acht"
245 a$(9)="neun{space*4}"
250 a$(10)="zehn"
255 a$(11)="elf "
300 for i=min to max
310 print tab(x+1) a$(i)
320 next i