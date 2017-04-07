console 1
bl=10
dim bs(bl,6)
dim i,x,y,b2,b3,p,pp,pv,ac
vp=20000
wp=21000
bp=1024
cp=55296

gosub clearscr
print "initializing frog engine 0.01..."
gosub clearmem
gosub initfrog
gosub clearscr
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
if bs(i,0)<>0 then move
if peek(vx)<160 then x=x+1:vx=vx+1:goto skip
bs(i,0)=x:bs(i,1)=y
if rnd(0)<0.4 then leftright
bs(i,2)=6+int(rnd(0)*26)
bs(i,3)=0
if y>10 then bs(i,3)=24
goto delta
leftright: 
bs(i,2)=0
if x>20 then bs(i,2)=39
bs(i,3)=4+int(rnd(0)*18)
delta: ly=abs(bs(i,1)-bs(i,3)):lx=abs(bs(i,0)-bs(i,2))
dx=0:dy=0
if ly>lx then lx=ly
if lx=0 then skipx
dx=(bs(i,0)-bs(i,2))/lx
dy=(bs(i,1)-bs(i,3))/lx
skipx: bs(i,4)=dx:bs(i,5)=dy:bs(i,6)=bs(i,0)+bs(i,1)*40+vp
ac=ac+1
x=x+1:vx=vx+1
goto paint
move: b2=bs(i,2):b3=bs(i,3):p=int(b2+0.5)+int(b3+0.5)*40:pv=peek(wp+p)
bs(i,2)=b2+bs(i,4):bs(i,3)=b3+bs(i,5):pokebp+p,pvand240:pokecp+p,pvand15
paint: p1=int(bs(i,2)+0.5):p2=int(bs(i,3)+0.5):p=p1+p2*40
pokebp+p,160:pokecp+p,peek(bs(i,6))and15
if p1<>bs(i,0)orp2<>bs(i,1)thenskip
bs(i,0)=0:pokewp-vp+bs(i,6),peek(bs(i,6)):ac=ac-1
skip: next
limit 40
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
for i=p+x to p+cn+x-1:poke i,160 or cl:next i
x=x+cn
goto loop

clearmem:
for i=20000 to 21999:pokei,32:next
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
