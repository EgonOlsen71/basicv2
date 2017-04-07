rem@ £fastfor:£fastarray:£word i=fast,x=fast,y,p,pp,ac,bl:£shortif
rem@ £word wp,vp,cp,vx
rem@ £integer c,cn:£datatype integer

console 1
bl=10
dim xt(bl),yt(bl),xp(bl),yp(bl),xd(bl),yd(bl),sc(bl)
dim i,x,y,b2,b3,p,pp,ac
vp=20000
wp=21000
cp=55296

gosub clearscr
poke 52380,0:poke53281,0:poke 646,2
print "initializing frog engine 0.01..."
gosub clearmem
gosub initfrog
poke 52380,6:poke53281,6
gosub render

key:
get a$:if a$="" then key
console 0
end

render:
for y=5 to 22
yt=y*40+vp
x=8
xloop: vx=yt+x
for i=0 to bl
if xt(i)<>0 then move
if peek(vx)=6 then x=x+1:vx=vx+1:goto skip
xt(i)=x:yt(i)=y
if rnd(0)<0.4 then leftright
xp(i)=6+int(rnd(0)*26)
yp(i)=0
if y>10 then yp(i)=24
goto delta
leftright: 
xp(i)=0
if x>20 then xp(i)=39
yp(i)=4+int(rnd(0)*18)
delta: ly=abs(yt(i)-yp(i)):lx=abs(xt(i)-xp(i))
dx=0:dy=0
if ly>lx then lx=ly
if lx=0 then skipx
dx=(xt(i)-xp(i))/lx
dy=(yt(i)-yp(i))/lx
skipx: xd(i)=dx:yd(i)=dy:sc(i)=peek(xt(i)+yt(i)*40+vp)
ac=ac+1
x=x+1:vx=vx+1
goto paint
move: b2=xp(i):b3=yp(i):p=int(b2+0.5)+int(b3+0.5)*40
xp(i)=b2+xd(i):yp(i)=b3+yd(i):pokecp+p,peek(wp+p)
paint: p1=int(xp(i)+0.5):p2=int(yp(i)+0.5):p=p1+p2*40
pokecp+p,sc(i)
if p1<>xt(i)orp2<>yt(i)thenskip
pokewp+xt(i)+yt(i)*40,sc(i):ac=ac-1:xt(i)=0
skip: next
limit 60
if x<33 then xloop
x=8:if y=22 and ac<>0 then y=21
next
return

initfrog:
cl=0
y=5
x=0
loop:
read c:if c=-99 then return
if c<0 then cl=abs(c):goto loop
if c=100 then cl=0:goto loop
if c<x and c<>0 then y=y+1
if c<>0 then x=c
p=vp+y*40
read cn
for i=p+x to p+cn+x-1:poke i,cl:poke53280,cl:next i
x=x+cn
goto loop

clearmem:
print:print"v-init: allocate screens."
for i=20000 to 20999:pokei,6:next
print"m-loaddefaults: load system defaults."
for i=21000 to 21999:pokei,6:next
print"z-init: init memory daemon."
for i=0 to 999:pokei+55296,6:pokei+1024,160:next
return

clearscr:
print chr$(147)
return

data -1,12,4,24,4,10,4,100,0,2,-1,0,2,22,4,100,0,2,-1,0,2
data 10,2,100,0,4,-1,0,2,-5,0,4,-1,0,2,100,0,4,-1,0,2
data 10,2,100,0,4,-1,0,2,-5,0,4,-1,0,2,100,0,4,-1,0,2
data -5,10,2,-1,0,4,-5,0,8,-1,0,4,-5,0,2
data 8,24,8,24,8,24,100,10,20,-5,10,20,10,20
data 12,16,12,6,-1,0,4,-5,0,6,12,4,-1,0,8,-5,0,4
data 8,2,14,2,-1,0,8,-5,0,2,30,2,10,2,14,2,24,2,28,2
data 8,8,24,8,-99
