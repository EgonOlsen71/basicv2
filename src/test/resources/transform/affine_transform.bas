rem@ £varstart $6590
ti$="000000"
dim pt%(4), cs%(18), xy%(18), ts%(12), ag(3)

w=40

tx=49152:tz=0:di=128
mp=25:tw=64:xd=.:yd=.:xh=.:yh=.:tc=.:t=.:l=.:r=.
tt=.:tl=.:tr=.:dl=.:dr=.:u0=.:u1=.:v0=.:v1=.
n=.:df=.:de=.:xs=.:xe=.:us=.:ue=.:vs=.:ve=.:kp=.
u=.:v=.:le=.:du=.:dv=.:x=.:y=.:z=.:tp=.:si=.
co=.:c=.:tv=.:mt=.:ma=.:xc=.:yv=.:zc=.:xn=.:yn=.:zn=.

gosub unpack
gosub bitmapon
gosub clearscr
gosub setcolor
gosub draw
tt=ti
rem key: get a$:if a$=""then key
gosub bitmapoff
print tt
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

xd=200:yd=200
xh=xd/2:yh=yd/2

for i=0 to 3:pt%(i)=64/(2^(2*i)):nexti

w=0.3
gosub mapit
return

mapit:
ag(0)=w:ag(1)=0:ag(2)=w
gosub rotate
gosub render
return

render:
gosub clearscr

tc=0
for i=0 to 17 step 9

t=0:l=3:r=6
tt=0:tl=2:tr=4

if xy%(i+4)>=xy%(i+1) then top2
t=3:l=6:r=0
tt=2:tl=4:tr=0

top2:
if xy%(i+7)>=xy%(i+t+1) then top3
t=6:l=0:r=3
tt=4:tl=0:tr=2

top3:
t=t+i
l=l+i
r=r+i

tt=tt+tc
tl=tl+tc
tr=tr+tc

dl=(xy%(l)-xy%(t))*di
dr=(xy%(r)-xy%(t))*di
u0=(ts%(tl)-ts%(tt))*di
u1=(ts%(tr)-ts%(tt))*di
v0=(ts%(tl+1)-ts%(tt+1))*di
v1=(ts%(tr+1)-ts%(tt+1))*di

n=l
if xy%(n+1)<=xy%(r+1) then nok
n=r

nok:
df=xy%(l+1)-xy%(t+1)
if df<>0 then calc1
dl=0:u0=0:v0=0
goto calc2

calc1:
dl=dl/df
u0=u0/df
v0=v0/df

calc2:
de=xy%(r+1)-xy%(t+1)
if de<>0 then calc3
dr=0:u1=0:v1=0
goto calc4

calc3:
dr=dr/de
u1=u1/de
v1=v1/de

calc4:
xs=xy%(t)*di

us=ts%(tt)*di
vs=ts%(tt+1)*di

kp=(xy%(l)-xy%(t))*(xy%(r+1)-xy%(t+1))
kp=kp-(xy%(l+1)-xy%(t+1))*(xy%(r)-xy%(t))
sw=0
if kp<=0 then dontswap
sw=1
q=dl:dl=dr:dr=q
q=df:df=de:de=q
q=l:l=r:r=q
q=tl:tl=tr:tr=q
q=u0:u0=u1:u1=q
q=v0:v0=v1:v1=q

dontswap:
y=xy%(t+1)

ue=us
ve=vs
xe=xy%(r)*di-de*dr


doit:
for it=0 to 1
innerloop:
u=us:v=vs
le=(xe-xs)/di
du=0:dv=0

if le=0 then nodiv
du=(ue-us)/le
dv=(ve-vs)/le

nodiv:
mt=16384 + int(y/8)*320 + (y and 7)
for x=int(xs/di) to int(xe/di)
tp=((v/2) and 4032)+int(u/di)
ma = mt + 2*(x and 252)
poke ma, peek(ma) or (peek(tx+(tp and 4095))*pt%(x and 3))
u=u+du:v=v+dv
next x

xs=xs+dl:xe=xe+dr
us=us+u0:vs=vs+v0
ue=ue+u1:ve=ve+v1

y=y+1
if y<=xy%(n+1) then innerloop

if n=r then setr
n=r
dl=(xy%(r)-xy%(l))*di
df=xy%(r+1)-xy%(l+1)
xs=xy%(l)*di

u0=(ts%(tr)-ts%(tl))*di
v0=(ts%(tr+1)-ts%(tl+1))*di
us=ts%(tl)*di
vs=ts%(tl+1)*di

if df<>0 then notnull1
dl=0:u0=0:v0=0:
goto xloop
notnull1:
dl=dl/df
u0=u0/df
v0=v0/df
goto xloop

setr: 
n=l
dr=(xy%(l)-xy%(r))*di
df=xy%(l+1)-xy%(r+1)
xe=xy%(r)*di

u1=(ts%(tl)-ts%(tr))*di
v1=(ts%(tl+1)-ts%(tr+1))*di
ue=ts%(tr)*di
ve=ts%(tr+1)*di

if df<>0 then notnull2
dr=0:u1=0:v1=0:
goto xloop
notnull2:
dr=dr/df
u1=u1/df
v1=v1/df

xloop:
next it
tc=tc+6
next i
return

rotate:
c=0
for p=0 to 17 step 3
xc=cs%(p)
yc=cs%(p+1)
zc=cs%(p+2)+mp

xn=xc:yn=yc:zn=zc

if ag(0)=0 then skipx
si=sin(ag(0))
co=cos(ag(0))
yn=(yc*co-zc*si)
zn=(yc*si+zc*co)
yc=yn
zc=zn
skipx:
if ag(1)=0 then skipy
si=sin(ag(1))
co=cos(ag(1))
zn=(zc*co-xc*si)
xn=(zc*si+xc*co)
xc=xn
zc=zn
skipy:
if ag(2)=0 then skipz
si=sin(ag(2))
co=cos(ag(2))
xn=(xc*co-yc*si)
yn=(xc*si+yc*co)
skipz:
zn=zn-mp
xy%(c)=(xh+((xn*di)/zn))/2:c=c+1
xy%(c)=yh+((yn*di)/zn):c=c+1
xy%(c)=z:c=c+1
next p
return

setup:
cs%(0)=-10:cs%(1)=10:cs%(2)=-mp
cs%(3)=10:cs%(4)=-10:cs%(5)=-mp
cs%(6)=-10:cs%(7)=-10:cs%(8)=-mp

cs%(9)=10:cs%(10)=10:cs%(11)=-mp
cs%(12)=10:cs%(13)=-10:cs%(14)=-mp
cs%(15)=-10:cs%(16)=10:cs%(17)=-mp

ts%(0)=tw:ts%(1)=0:ts%(2)=0
ts%(3)=tw:ts%(4)=tw:ts%(5)=tw

ts%(6)=0:ts%(7)=0:ts%(8)=0
ts%(9)=tw:ts%(10)=tw:ts%(11)=0

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
print"{clr}unpacking texture..."
p=tx
packloop:
read c,v%
if c=0 then extend
for i=1 to c
pokep,v%
poke 53280,v%
p=p+4
nexti
goto packloop

extend:
for i=tx to tx+4095 step 4
v=peek(i)
poke i+0, (v and 192)/64
poke i+1, (v and 48)/16
poke i+2, (v and 12)/4
poke i+3, (v and 3)
poke 53280,v
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

