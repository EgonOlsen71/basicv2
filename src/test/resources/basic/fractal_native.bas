90 rem **to change the shape, change**
91 rem **xl,xu,yl,yu. reps changes  **
92 rem **the resolution**
100 xl = -2.000:xu = 0.500
110 yl = -1.100:yu = 1.100
115 reps = 20
116 iters% = 0
120 width = 320:height = 200
130 xinc = (xu-xl)/width
140 yinc = (yu-yl)/height
200 rem main routine
205 print "{clear}"
207 gosub 500
210 for j = 0 to height - 1
215 rem print j
220 : for i = 0 to width - 1 step 2
230 :   gosub 300
231 :   gosub 600
240 : next i
250 next j
260 print "Done!"
290 rem get a$:if a$ = "" then 290
299 goto 700
300 rem calculate mandelbrot
310 ismnd = -1
312 nreal = xl + i * xinc
313 nimg  = yl + j * yinc
315 rz = 0:iz = 0
316 r2z = 0:i2z = 0
320 for k = 1 to reps
325 remprint k,reps
330 : r2z = rz*rz - iz*iz
340 : i2z  = 2*rz*iz
350 : rz  = r2z+nreal
360 : iz   = i2z +nimg
365 iters%=k
370 : if (rz*rz + iz*iz)>4 then ismnd=0:k=reps
390 next k
399 return
500 rem clear screen
540 for r=8000 to 15999:poke r,0:next
599 return
600 rem draw hires
601 :
620 if ismnd<>0 then return
621 p=8000+int(j/8)*320+int(i/8)*8+(jand7)
622 cc%=iters% and 3
625 if cc%=3 then pokep,peek(p) or int(2^(7-((i/8-int(i/8))*8))) or int(2^(7-(((i+1)/8-int((i+1)/8))*8))):return
630 if cc%=2 then pokep,peek(p) or int(2^(7-((i/8-int(i/8))*8))):return
635 pokep,peek(p) or int(2^(7-(((i+1)/8-int((i+1)/8))*8)))
699 return
700 rem return to normal
750 end