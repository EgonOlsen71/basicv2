dim cs%(18), xy%(18), ts%(12), ag%(3), sn%(1440)

tx=49152:tz=0
mp%=20:tw%=64:xd%=0:yd%=0:xh%=0:yh%=0:tc%=0:t%=0:l%=0:r%=0
tt%=0:tl%=0:tr%=0:dl%=0:dr%=0:u0%=0:u1%=0:v0%=0:v1%=0
n%=0:df%=0:xs%=0:xe%=0:us%=0:ue%=0:vs%=0:ve%=0:kp%=0
u%=0:v%=0:le%=0:du%=0:dv%=0:x%=0:y%=0:z%=0:tp%=0:sx%=0
cx%=0:sy%=0:cy%=0:sz%=0:cz%=0:c%=0:tv%=0:

gosub unpack
gosub clearscr
gosub setcolor
gosub draw
rem gosub testdraw
end

draw:
gosub setup

xd%=200:yd%=200
xh%=xd%/2:yh%=yd%/2

for i=0 to 720:vl%=512*sin(((i/2)-360)*3.14159265359/180):sn%(i)=vl%:sn%(i+720)=vl%:nexti

for w%=0 to 90
ag%(0)=0:ag%(1)=0:ag%(2)=w%
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
df%=xy%(r%+1)-xy%(t%+1)
if df%<>0 then calc3
dr%=0:u1%=0:v1%=0
goto calc4

calc3:
dr%=dr%/df%
u1%=u1%/df%
v1%=v1%/df%

calc4:
xs%=xy%(t%)*128

us%=ts%(tt%)*128
vs%=ts%(tt%+1)*128

kp%=(xy%(l%)-xy%(t%))*(xy%(r%+1)-xy%(t%+1))
kp%=kp%-(xy%(l%+1)-xy%(t%+1))*(xy%(r%)-xy%(t%))
if kp%<=0 then dontswap
q%=dl%:dl%=dr%:dr%=q%
q%=l%:l%=r%:r%=q%
q%=tl%:tl%=tr%:tr%=q%
q%=u0%:u0%=u1%:u1%=q%

dontswap:
y%=xy%(t%+1)

xe%=xy%(r%)*128-df%*dr%
ue%=ts%(tr%)*128-df%*u1%
ve%=ts%(tr%+1)*128-df%*v1%

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
tp%=int(v%/128)*tw%+int(u%/128)
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
dl%=0:u0%=0:v0%=0:
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
dr%=0:u1%=0:v1%=0:
goto xloop
notnull2:
dr%=dr%/df%
u1%=u1%/df%
v1%=v1%/df%

xloop:
next it%
tc%=tc%+6
next i%
return

testdraw:
tp%=0
for y%=0 to 63
for x%=15 to 31+15
gosub setpixel
tp%=tp%+2
next x%
next y%
return

setpixel:
x2% = x%*2
li% = int(y%/8)
bl% = y% and 7
cp% = int(x2%/8)
ma% = 8192 + li%*320 + cp%*8 + bl%
bp% = 64/(2^(x2% and 7))
if tp%<0 then tp%=0
if tp%>4095 then tp%=4095
poke ma%, peek(ma%) or (bp%*peek(tx+tp%))
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

xn%=x%:yn%=y%:zn%=z%

if ag%(0)=0 then skipx
yn%=(y%*cx%-z%*sx%)/512
zn%=(y%*sx%+z%*cx%)/512
skipx:
if ag%(1)=0 then skipy
zn%=(z%*cy%-x%*sy%)/512
xn%=(z%*sy%+x%*cy%)/512
skipy:
if ag%(2)=0 then skipz
xn%=(x%*cz%-y%*sz%)/512
yn%=(x%*sz%+y%*cz%)/512
skipz:
zn%=zn%-mp%
xy%(c%)=(xh%+((xn%*128)/zn%))/2:c%=c%+1
xy%(c%)=yh%+((yn%*128)/zn%):c%=c%+1
xy%(c%)=z%:c%=c%+1
next p%
return

setup:
cs%(0)=-10:cs%(1)=10:cs%(2)=-mp%
cs%(3)=10:cs%(4)=-10:cs%(5)=-mp%
cs%(6)=-10:cs%(7)=-10:cs%(8)=-mp%

cs%(9)=10:cs%(10)=10:cs%(11)=-mp%
cs%(12)=10:cs%(13)=-10:cs%(14)=-mp%
cs%(15)=-10:cs%(16)=10:cs%(17)=-mp%

ts%(0)=tw%:ts%(1)=0:ts%(2)=0
ts%(3)=tw%:ts%(4)=tw%:ts%(5)=tw%

ts%(6)=0:ts%(7)=0:ts%(8)=0
ts%(9)=tw%:ts%(10)=tw%:ts%(11)=0

rem load and process texture here
return

clearscr:
for i=8192to16192:pokei,0:nexti
return

setcolor:
poke 53281,1
v=6+14*16
for i = 1024 to 2023:poke i,v:next i
for i = 55296 to 56295:poke i,2:next i
return

unpack:
p=tx
packloop:
read c%,v%
if c%=-1 then extend
for i%=1 to c%
pokep,v% 
p=p+4
nexti%
goto packloop

extend:
for i=tx to tx+4095 step 4
v%=peek(i)
poke i+0, (v% and (128+64))/64
poke i+1, (v% and (32+16))/16
poke i+2, (v% and (8+4))/4
poke i+3, (v% and (2+1))
next i
return

data 199,170,1,149,1,106,13,170,1,165,2,85,13,170,3
data 85,12,170,1,165,3,85,12,170,1,149,3,85,12,170
data 4,85,11,170,1,169,4,85,11,170,1,165,2,85,1,86
data 1,85,11,170,1,165,1,85,1,86,13,170,1,149,1,85
data 1,90,13,170,1,149,1,85,1,106,2,170,3,85,1,106
data 7,170,2,85,3,170,3,85,8,170,1,85,1,86,3,170,2
data 85,1,86,8,170,1,85,1,86,3,170,2,85,1,90,8,170
data 1,85,1,86,3,170,2,85,1,106,7,170,1,169,1,85,1
data 90,3,170,1,149,1,85,8,170,1,169,1,85,1,90,13,170
data 1,169,1,85,1,90,13,170,1,169,1,85,1,90,3,170,2
data 255,9,170,1,85,1,86,3,170,2,255,1,234,8,170,1
data 85,1,86,3,170,2,255,1,250,8,170,2,85,3,170,2,255
data 1,254,8,170,2,85,3,170,3,255,8,170,1,149,1,85
data 1,106,2,170,3,255,1,234,7,170,1,149,1,85,1,90
data 13,170,1,165,2,85,1,106,1,165,11,170,1,169,4,85
data 11,170,1,169,4,85,12,170,4,85,12,170,1,149,3,85
data 12,170,1,169,3,85,13,170,1,149,2,85,13,170,1,169
data 1,85,1,86,40,170,1,169,8,170,1,169,6,170,1,154
data 8,170,1,169,6,170,1,106,1,169,1,90,1,102,1,150
data 1,153,1,165,1,169,1,106,2,169,2,170,1,154,2,170
data 1,106,1,166,1,154,1,105,1,166,1,154,1,105,1,166
data 1,154,1,105,1,166,1,153,1,105,1,166,2,170,1,106
data 1,166,1,154,1,105,1,166,1,154,1,105,1,166,1,153
data 1,169,1,154,1,153,1,169,1,86,2,170,1,154,1,166
data 1,154,1,105,1,166,1,154,1,105,1,166,1,154,1,105
data 1,166,1,153,1,169,1,106,4,170,1,106,4,170,1,169
data 1,106,1,153,1,169,1,106,1,170,1,90,160,170,1,170
data -1,-1

