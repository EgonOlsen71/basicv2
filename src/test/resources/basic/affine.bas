dim cs%(18), xy%(18), ts%(12), ag%(3), sn%(1440)

tx=49152
mp%=50:tw%=128:xd%=0:yd%=0:xh%=0:yh%=0:tc%=0:t%=0:l%=0:r%=0
tt%=0:tl%=0:tr%=0:dl%=0:dr%=0:u0%=0:u1%=0:v0%=0:v1%=0
n%=0:df%=0:xs%=0:xe%=0:us%=0:ue%=0:vs%=0:ve%=0:kp%=0
u%=0:v%=0:le%=0:du%=0:dv%=0:x%=0:y%=0:z%=0:tp%=0:sx%=0
cx%=0:sy%=0:cy%=0:sz%=0:cz%=0:c%=0

gosub clearscr
gosub setcolor
gosub draw
end

draw:
gosub setup

xd%=200:yd%=200
xh%=xd%/2:yh%=yd%/2

for i=0 to 1440:sn%(i)=512*sin((i/2)-360)*PI/180:nexti

for w%=0 to 360
ag%(0)=w%:ag%(1)=0:ag%(2)=0
gosub rotate
gosub render
gosub paint
nextw%
return

render:
gosub clearscr

tc%=0
for i%=0 to 17 step 9
t%=0:l%=3:r%=6
tt%=0:tl%=2:tr%=4
if xy%(i%+4)>=xy%(i%+1) then top2
t%=3:l%=6:r%=0
tt%=2:tl%=4:tr%=0

top2:
if xy%(i%+7)>=xy%(i%+t%+1) then top3
t%=6:l%=0:r%=3
tt%=4:tl%=0:tr%=2

top3:
t%=t%+i%
l%=l%+i%
r%=r%+i%

tt%=tt%+tc%
tl%=tl%+tc%
tr%=tr%+tc%

dl%=(xy%(l%)-xy%(t%))*128
dr%=(xy%(r%)-xy%(t%))*128
u0%=(ts%(tl%)-ts%(tt%))*128
u1%=(ts%(tr%)-ts%(tt%))*128
v0%=(ts%(tl%+1)-ts%(tt%+1))*128
v1%=(ts%(tr%+1)-ts%(tt%+1))*128

n%=l%
if xy%(n%+1)<=xy%(r%+1) then nok
n%=r%

nok:
df%=xy%(l%+1)-xy%(t%+1)
if df%<>0 then calc1
dl%=0:u0%=0:v0%=0
goto calc2

calc1:
dl%=dl%/df%
u0%=u0%/df%
v0%=v0%/df%

calc2:
df%=xy%(r%+1)-xy%(r%+1)
if df%<>0 then calc3
dr%=0:u1%=0:v1%=0
goto calc4

calc3:
dr%=dr%/df%
u1%=u1%/df%
v1%=v1%/df%

calc4:
xs%=xy%(t)*128
xe%=xs%

us%=ts%(tt%)*128
ue%=us%

vs%=ts%(tt%+1)*128
ve%=vs%

kp%=(xy%(l%)-xy%(t%))*(xy%(r%+1)-xy%(t%+1))-(xy%(l%+1)-xy%(t%+1))*(xy%(r%)-xy%(t%))
if kp%<=0 then dontswap
q%=dl%:dl%=dr%:dr%=q%
q%=l%:l%=r%:r%=q%
q%=tl%:tl%=tr%:tr%=q%
q%=u0%:u0%=u1%:u1%=q%

dontswap:
y%=xy%(t%+1)
for it%=0 to 1
innerloop:
u%=us%:v%=vs%
le%=(xe%-xs%)/128
du%=0:dv%=0

if le%=0 then nodiv
du%=(ue%-us%)/le%
dv%=(ve%-vs%)/le%

nodiv:
for x%=xs%/128 to xe%/128
tp%=(u%/128)*tw%+(v%/128)
: rem range check?
gosub setpixel
u%=u%+du%:v%=v%+dv%
next x%

xs%=xs%+dl%:xe%=xe%+dr%
us%=us%+u0%:vs%=vs%+v0%
ue%=ue%+u1%:ve%=ve%+v1%

y%=y%+1
if y%<=xy%(n%+1) then innerloop

if n%=r% then setr
n%=r%
dl%=(xy%(r%)-xy%(l%))*128
df%=xy%(r%+1)-xy%(l%+1)
xs%=xy%(l%)*128

u0%=(ts%(tr%)-ts%(tl%))*128
v0%=(ts%(tr%+1)-ts%(tl%+1))*128
us%=ts%(tl%)*128
vs%=ts%(tl%+1)*128

if df%<>0 then notnull1
dl=0:u0=0:v0=0:
goto xloop
notnull1:
dl%=dl%/df%
u0%=u0%/df%
v0%=v0%/df%
goto xloop

setr: 
n%=l%
dr%=(xy%(l%)-xy%(r%))*128
df%=xy%(l%+1)-xy%(r%+1)
xe%=xy%(r%)*128

u1%=(ts%(tl%)-ts%(tr%))*128
v1%=(ts%(tl%+1)-ts%(tr%+1))*128
ue%=ts%(tr%)*128
ve%=ts%(tr%+1)*128

if df%<>0 then notnull2
dr=0:u1=0:v1=0:
goto xloop
notnull2:
dr%=dr%/df%
u1%=u1%/df%
v1%=v1%/df%

xloop:
next it%
tc%=tc%+6
next i%

setpixel:
li% = int(y%/8)
bl% = y% and 7
cp% = int(x%/8)
ma% = 8192 + li%*320 + cp%*8 + bl%
bp% = 7 - (x% and 7)
poke ma%, peek(ma%) or 2^bp%
print ma%,peek(ma%),x%,y%,(0 or 2^bp%),(2^bp%)
return

paint:
rem display render
return

rotate:
sx%=sn%(ag%(0)*2)
cx%=-sn%((ag%(0)+90)*2)
sy%=sn%(ag%(1)*2)
cy%=-sn%((ag%(1)+90)*2)
sz%=sn%(ag%(2)*2)
cz%=-sn%((ag%(2)+90)*2)
c%=0

for p%=0 to 17 step 3
x%=cs%(p%)
y%=cs%(p%+1)
z%=cs%(p%+2)+mp%

if ag%(0)=0 then skipx
y%=(y%*cx%-z%*sx%)/512
z%=(y%*sx%+z%*cx%)/512
skipx:
if ag%(1)=0 then skipy
z%=(z%*cy%-x%*sy%)/512
x%=(z%*sy%+x%*cy%)/512
skipy:
if ag%(2)=0 then skipz
x%=(x%*cz%-y%*sz%)/512
y%=(x%*sz%+y%*cz%)/512
skipz:
z%=z%-mp%
xy%(c%)=xh%+((x%*128)/z%):c%=c%+1
xy%(c%)=yh%+((y%*128)/z%):c%=c%+1
xy%(c%)=z%
return

setup:
cs%(0)=-10:cs%(1)=10:cs%(2)=-mp%
cs%(3)=10:cs%(4)=-10:cs%(5)=-mp%
cs%(6)=-10:cs%(7)=-10:cs%(8)=-mp%

cs%(9)=10:cs%(10)=10:cs%(11)=-mp%
cs%(12)=10:cs%(13)=-10:cs%(14)=-mp%
cs%(15)=-10:cs%(16)=-10:cs%(17)=-mp%

ts%(0)=0:ts%(1)=0:ts%(2)=tw%
ts%(3)=tw%:ts%(4)=0:ts%(5)=tw%

ts%(6)=tw%:ts%(7)=0:ts%(8)=tw%
ts%(9)=tw%:ts%(10)=0:ts%(11)=0

rem load and process texture here
return

clearscr:
for i=8192to16192:pokei,0:nexti
return

setcolor:
for i = 1024 TO 2023:poke i,1:next i
return



