rem@ £allram:£fastfor:£shortif:£fastarray
rem@ £word x=fast, ma=fast, mt, tx, tz, v, i
rem@ £varstart $6590

dim pt%(4), cs%(18), xy%(18), ts%(12), ag%(3), sn%(1440)

w%=40

tx=49152:tz=0:di%=128
mp%=25:tw%=64:xd%=0:yd%=0:xh%=0:yh%=0:tc%=0:t%=0:l%=0:r%=0
tt%=0:tl%=0:tr%=0:dl%=0:dr%=0:u0%=0:u1%=0:v0%=0:v1%=0
n%=0:df%=0:de%=0:xs%=0:xe%=0:us%=0:ue%=0:vs%=0:ve%=0:kp%=0
u%=0:v%=0:le%=0:du%=0:dv%=0:x=0:y%=0:z%=0:tp%=0:si%=0
co%=0:c%=0:tv%=0:mt=0:ma=0:xc=.:yv=.:zc=.:xn=.:yn=.:zn=.

gosub bitmapon
gosub unpack
gosub clearscr
gosub setcolor
gosub draw
key: get a$:if a$=""then key
gosub bitmapoff
end

bitmapon:
poke 56576,(peek(56576) and 252) or 2
poke 53272,(peek(53272) and (255-8)) or 0
poke 53272,(peek(53272) and 15) or 128
poke 53265,peek(53265) or 32
poke 53270,peek(53270) or 16
return

bitmapoff:
poke 56576,(peek(56576) and 252) or 3
poke 53272, (peek(53272) and (255-8)) or 1
poke 53272,(peek(53272) and 15) or 16
poke 53265,peek(53265) and 223
poke 53270,peek(53270) and 239
return

draw:
gosub setup

xd%=200:yd%=200
xh%=xd%/2:yh%=yd%/2

for i=0 to 720:vl%=512*sin(((i/2)-360)*3.14159265359/180)
sn%(i)=vl%:sn%(i+720)=vl%:nexti
for i=0 to 3:pt%(i)=64/(2^(2*i)):nexti

for w=0 to 360:w%=w
gosub mapit
next w
return

mapit:
ag%(0)=w%:ag%(1)=0:ag%(2)=w%
gosub rotate
gosub render
gosub paint
return

render:
gosub clearscr

tc%=0
for i=0 to 17 step 9

t%=0:l%=3:r%=6
tt%=0:tl%=2:tr%=4

if xy%(i+4)>=xy%(i+1) then top2
t%=3:l%=6:r%=0
tt%=2:tl%=4:tr%=0

top2:
if xy%(i+7)>=xy%(i+t%+1) then top3
t%=6:l%=0:r%=3
tt%=4:tl%=0:tr%=2

top3:
t%=t%+i
l%=l%+i
r%=r%+i

tt%=tt%+tc%
tl%=tl%+tc%
tr%=tr%+tc%

dl%=(xy%(l%)-xy%(t%))*di%
dr%=(xy%(r%)-xy%(t%))*di%
u0%=(ts%(tl%)-ts%(tt%))*di%
u1%=(ts%(tr%)-ts%(tt%))*di%
v0%=(ts%(tl%+1)-ts%(tt%+1))*di%
v1%=(ts%(tr%+1)-ts%(tt%+1))*di%

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
de%=xy%(r%+1)-xy%(t%+1)
if de%<>0 then calc3
dr%=0:u1%=0:v1%=0
goto calc4

calc3:
dr%=dr%/de%
u1%=u1%/de%
v1%=v1%/de%

calc4:
xs%=xy%(t%)*di%

us%=ts%(tt%)*di%
vs%=ts%(tt%+1)*di%

kp%=(xy%(l%)-xy%(t%))*(xy%(r%+1)-xy%(t%+1))
kp%=kp%-(xy%(l%+1)-xy%(t%+1))*(xy%(r%)-xy%(t%))
sw%=0
if kp%<=0 then dontswap
sw%=1
q%=dl%:dl%=dr%:dr%=q%
q%=df%:df%=de%:de%=q%
q%=l%:l%=r%:r%=q%
q%=tl%:tl%=tr%:tr%=q%
q%=u0%:u0%=u1%:u1%=q%
q%=v0%:v0%=v1%:v1%=q%

dontswap:
y%=xy%(t%+1)

ue%=us%
ve%=vs%
xe%=xy%(r%)*di%-de%*dr%


doit:
for it=0 to 1
innerloop:
u%=us%:v%=vs%
le%=(xe%-xs%)/di%
du%=0:dv%=0

if le%=0 then nodiv
du%=(ue%-us%)/le%
dv%=(ve%-vs%)/le%

nodiv:
mt=16384 + int(y%/8)*320 + (y% and 7)

if xs%>xe% then noline:

t=int(xs%/di%):poke 834,t
t=int(xe%/di%):poke 835,t
if u%<0 then u%=0
if v%<0 then v%=0
t=v%:poke 836,t-int(t/256)*256:poke 837,t/256
t=u%:poke 838,t-int(t/256)*256:poke 839,t/256
t=mt:poke 844,t-int(t/256)*256:poke 845,t/256
if du%>=0 then posu
t=abs(du%):lb=t-int(t/256)*256:hb=t/256
hb=(hb or 255) and not(hb and 255)
lb=(lb or 255) and not(lb and 255)
lb=lb+1
if lb>255 then hb=hb+1:lb=0
poke 840,lb
poke 841,hb
goto calcv

posu:
t=du%:poke 840,t-int(t/256)*256:poke 841,t/256

calcv:
if dv%>=0 then posu2
t=abs(dv%):lb=t-int(t/256)*256:hb=t/256
hb=(hb or 255) and not(hb and 255)
lb=(lb or 255) and not(lb and 255)
lb=lb+1
if lb>255 then hb=hb+1:lb=0
poke 842,lb
poke 843,hb
goto asmloop

posu2:
t=dv%:poke 842,t-int(t/256)*256:poke 843,t/256
asmloop:
sys 1024

noline:
xs%=xs%+dl%:xe%=xe%+dr%
us%=us%+u0%:vs%=vs%+v0%
ue%=ue%+u1%:ve%=ve%+v1%

y%=y%+1
if y%<=xy%(n%+1) then innerloop

if n%=r% then setr
n%=r%
dl%=(xy%(r%)-xy%(l%))*di%
df%=xy%(r%+1)-xy%(l%+1)
xs%=xy%(l%)*di%

u0%=(ts%(tr%)-ts%(tl%))*di%
v0%=(ts%(tr%+1)-ts%(tl%+1))*di%
us%=ts%(tl%)*di%
vs%=ts%(tl%+1)*di%

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
dr%=(xy%(l%)-xy%(r%))*di%
df%=xy%(l%+1)-xy%(r%+1)
xe%=xy%(r%)*di%

u1%=(ts%(tl%)-ts%(tr%))*di%
v1%=(ts%(tl%+1)-ts%(tr%+1))*di%
ue%=ts%(tr%)*di%
ve%=ts%(tr%+1)*di%

if df%<>0 then notnull2
dr%=0:u1%=0:v1%=0:
goto xloop
notnull2:
dr%=dr%/df%
u1%=u1%/df%
v1%=v1%/df%

xloop:
next it
tc%=tc%+6
next i
return

paint:
rem not needed on actual hardware 
sys 832
return

rotate:
c%=0
for p=0 to 17 step 3
xc=cs%(p)
yc=cs%(p+1)
zc=cs%(p+2)+mp%

xn=xc:yn=yc:zn=zc

if ag%(0)=0 then skipx
si%=sn%(ag%(0)*2)
co%=sn%((ag%(0)+90)*2)
yn=(yc*co%-zc*si%)/512
zn=(yc*si%+zc*co%)/512
yc=yn
zc=zn
skipx:
if ag%(1)=0 then skipy
si%=sn%(ag%(1)*2)
co%=sn%((ag%(1)+90)*2)
zn=(zc*co%-xc*si%)/512
xn=(zc*si%+xc*co%)/512
xc=xn
zc=zn
skipy:
if ag%(2)=0 then skipz
si%=sn%(ag%(2)*2)
co%=sn%((ag%(2)+90)*2)
xn=(xc*co%-yc*si%)/512
yn=(xc*si%+yc*co%)/512
skipz:
zn=zn-mp%
xy%(c%)=(xh%+((xn*di%)/zn))/2:c%=c%+1
xy%(c%)=yh%+((yn*di%)/zn):c%=c%+1
xy%(c%)=z:c%=c%+1
next p
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

poke 832, 234
poke 833, 96

return

clearscr:
for i=16384to24383:pokei,0:nexti
return

setcolor:
poke 53281,1
v=14+6*16
for i = 24576 to 25575:poke i,v:next i
for i = 55296 to 56295:poke i,2:next i
return

unpack:
ml=1024
p=tx
packloop:
read c,v%
if c=0 then extend
for i=1 to c
pokep,v% 
p=p+4
nexti
goto packloop

extend:
read c
if c=-1 then unzip
poke ml,c
ml=ml+1
goto extend

unzip:
for i=tx to tx+4095 step 4
v%=peek(i)
poke i+0, (v% and 192)/64
poke i+1, (v% and 48)/16
poke i+2, (v% and 12)/4
poke i+3, (v% and 3)
next i
return

data 199,170,1,85,1,90,13,170,1,149,2,85,12,170,1,169
data 3,85,12,170,1,165,3,85,12,170,4,85,11,170,1,169
data 4,85,11,170,1,169,4,85,11,170,1,165,4,85,11,170
data 1,149,2,85,1,170,1,169,11,170,1,149,1,85,1,90
data 13,170,2,85,1,106,2,170,3,85,1,106,7,170,2,85
data 3,170,3,85,8,170,1,85,1,86,3,170,2,85,1,86,8,170
data 1,85,1,86,3,170,2,85,1,90,7,170,1,169,1,85,1,86
data 3,170,2,85,1,106,7,170,1,169,1,85,1,86,3,170,2
data 85,8,170,1,169,1,85,1,86,13,170,1,169,1,85,1,86
data 13,170,1,169,1,85,1,86,3,170,2,255,1,106,7,170
data 1,169,1,85,1,86,3,170,2,255,1,218,8,170,1,85,1
data 86,3,170,2,255,1,250,8,170,2,85,3,170,2,255,1
data 254,8,170,2,85,3,170,3,255,8,170,1,149,1,85,1
data 106,2,170,3,255,1,234,7,170,1,149,1,85,1,86,13
data 170,1,165,2,85,1,106,1,165,11,170,1,165,4,85,11
data 170,1,169,4,85,12,170,4,85,12,170,1,149,3,85,12
data 170,1,169,3,85,13,170,3,85,13,170,1,169,1,85,1
data 86,40,170,1,165,8,170,1,169,6,170,1,154,8,170
data 1,169,6,170,1,90,1,165,1,90,1,85,1,150,1,153,1
data 101,1,165,1,106,1,89,1,165,1,105,1,154,1,90,2
data 170,1,106,1,166,1,150,1,105,1,166,1,154,1,105
data 1,166,1,153,1,105,1,150,1,153,1,105,1,166,2,170
data 1,90,1,166,1,150,1,105,1,165,1,154,1,105,1,150
data 1,153,1,105,1,154,1,153,1,105,1,86,2,170,1,150
data 1,166,1,154,1,105,1,165,1,154,1,105,1,166,1,153
data 1,105,1,150,1,153,1,169,1,106,2,170,2,169,1,106
data 1,105,1,166,1,154,1,105,1,169,1,106,1,85,1,165
data 1,105,1,170,1,86,160,170,1,170
data 0,0
rem innerloop ml code
data 173,68,3,74,170,173,69,3,24,74
data 144,6,168,138,9,128,170,152,41,15
data 141,79,3,138,41,192,141,78,3,169
data 7,133,2,174,70,3,172,71,3,138
data 74,170,152,24,74,144,8,168,138,9
data 128,170,76,56,4,168,198,2,208,235
data 138,13,78,3,141,78,3,173,76,3
data 141,80,3,173,77,3,141,81,3,173
data 66,3,41,252,24,10,144,3,238,81
data 3,24,109,80,3,144,3,238,81,3
data 141,80,3,173,79,3,41,15,24,105
data 192,141,79,3,133,252,173,78,3,133
data 251,160,0,177,251,170,173,66,3,41
data 3,168,138,133,251,185,231,4,240,8
data 133,2,6,251,198,2,208,250,173,80
data 3,133,252,173,81,3,133,253,160,0
data 177,252,5,251,145,252,173,70,3,24
data 109,72,3,144,3,238,71,3,141,70
data 3,173,71,3,24,109,73,3,141,71
data 3,173,68,3,24,109,74,3,144,3
data 238,69,3,141,68,3,173,69,3,24
data 109,75,3,141,69,3,173,66,3,205
data 67,3,240,6,238,66,3,76,0,4
data 96,6,4,2,0,-1

