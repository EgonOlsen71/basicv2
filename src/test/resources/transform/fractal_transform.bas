90 rem **to change the shape, change**
91 rem **xl,xu,yl,yu. reps changes  **
92 rem **the resolution**
100 xl = -2.000:xu = 0.500:ti$="000000"
110 yl = -1.100:yu = 1.100
115 reps = 20
116 iters% = 0
120 width = 320:height = 200
130 xinc = (xu-xl)/width
140 yinc = (yu-yl)/height
200 rem main routine
205 rem print "{clear}"
207 gosub 500
210 for j = 0 to height - 1:poke2,j
215 rem print j
220 : for i = 0 to width - 1 step 2
230 :   gosub 300
231 :   gosub 600
240 : next i
250 next j
260 rem print "Done!"
290 rem get a$:if a$ = "" then 290
299 goto 700
300 rem calculate mandelbrot
310 ismnd = -1
312 nreal = xl + i * xinc
313 nimg  = yl + j * yinc
315 rz = 0:iz = 0
316 r2z = 0:i2z = 0
320 for k = 1 to reps
330 : r2z = rz*rz - iz*iz
340 : i2z  = 2*rz*iz
350 : rz  = r2z+nreal
360 : iz   = i2z +nimg
361 : 
365 iters%=k
370 : if (rz*rz + iz*iz)>4 then ismnd=0:k=reps
390 next k
399 return
500 rem clear screen
530 poke 56576,(peek(56576) and 252) or 2
531 poke 53272,(peek(53272) and (255-8)) or 0
532 poke 53272,(peek(53272) and 15) or 128
533 poke 53265,peek(53265) or 32
534 poke 53270,peek(53270) or 16
540 jj=0:for r=16384 to 24576:poke r,jj:next
550 for r=24576 to 25575:poke r,207:next
560 for r=55296to56295:poke r,14:next
599 return
600 rem draw hires
601 :
620 if ismnd<>0 then return
621 p=16384+int(j/8)*320+int(i/8)*8+(jand7)
622 cc%=iters% and 3
623 tf%=int(2^(7-(((i+1)/8-int((i+1)/8))*8)))
625 if cc%=3 then pokep,peek(p) or int(2^(7-((i/8-int(i/8))*8))) or tf%:return
630 if cc%=2 then pokep,peek(p) or int(2^(7-((i/8-int(i/8))*8))):return
635 pokep,peek(p) or tf%
699 return
700 rem return to normal
740 poke 56576,(peek(56576) and 252) or 3
741 poke 53272, (peek(53272) and (255-8)) or 1
742 poke 53272,(peek(53272) and 15) or 16
743 poke 53265,peek(53265) and 223
744 poke 53270,peek(53270) and 239:print ti
750 end