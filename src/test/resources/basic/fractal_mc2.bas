10 for i=8192to16384:pokei,255:next: rem just to test, if the assembler code below actually works...
100 xl =-2.000:xu =0.500
  110 yl =-1.100:yu=1.100
  115 reps =20
  120 width =160:height =200
  130 xinc =(xu -xl)/width
  140 yinc =(yu-yl)/height
  200 rem main routine
  205 print "{clr}"
  207 gosub 500
  210 for j = 0 to int((height - 1)/2)
  220 for i = 0 to width -1
  230 gosub 300
  240 gosub 600
  260 next
  270 next
  290 remget a$: if a$ = ""then 290
  299 goto 700
  300 rem calculate mandelbrot
  312 nreal = xl + i * xinc
  313 nimg = yl+j*yinc
  315 rz=0:iz=0
  316 r2z=0:i2z=0
  320 for k = 1 to reps
  330 r2z=rz*rz-iz*iz
  340 i2z=2*rz*iz
  350 rz=r2z+nreal
  360 iz=i2z+nimg
  370 if(rz*rz+iz*iz)>4 goto395
  390 next
  395 if k<7 then c=3:return:rem here we are assigning colors
  396 if k<9 then c=2:return
  397 if k<14then c=1:return
  398 c=0
  400 return
  500 rem clear screen
  530 poke 53272, 29:poke 53265, 59
  531 poke53270,peek(53270)or16
  532 poke 53281, 0
  541 gosub 800
  549 rem set screen colors to grays
  550 for r=1024 to 2023:poke r,207:next
  560 for r=55296to56295:poke r,14:next
  598 return
  599 rem draw hi-res
  600 ch=int(i/4)*8
  605 k=height-1-j : rem here we do the mirroring
  610 p =8192 + int(j/8)*320 + ch+(jand7)
  615 p2=8192 + int(k/8)*320 + ch+(kand7)
  625 lb=2^(7-(1+2*(iand3))):rem multicolor low bit
  626 hb=2^(7-(2*(iand3))): rem high bit
  630 if c=0 then return
  635 a=peek(p)
  640 if c=1 then pokep,a or lb
  641 if c=1 then pokep2,a or lb:return
  650 if c=2 then pokep,a or hb
  651 if c=2 then pokep2,a or hb:return
  655 a=a or lb
  660 pokep,a
  661 pokep2,a
  670 pokep, a or hb
  671 pokep2, a or hb
  680 return
  700 rem return to normal
  705 poke 53280, 14:poke 53281,6
  740 poke 53272,21:poke 53265,27
  750 poke 53270,peek(53270)and239
  760 end
  799 rem some machine code to erase the hires screen
  800 for i= 0to 20:read a:poke 49152+i, a:next
  810 data 169,0,162,32,160,0,132,33,134,34,145,33,200,208,251,232,224,64,208,244
  815 data 96
  820 sys49152
  830 return