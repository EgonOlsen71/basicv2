rem@ £fastfor:£fastarray:£word i=fast,x=fast,y,p,pp:£shortif
rem@ £word wp,vp,cp
rem@ £integer c,cn:£datatype integer

console 1
dim i,x,y,p,pp
vp=20000
wp=21000
cp=55296
sp=wp

gosub wipescr
poke 53280,0:poke53281,0:poke 646,2
print "initializing frog engine 0.01..."
gosub wipemem
gosub initfrog
poke 53280,6:poke53281,6
gosub render

key:
get a$:if a$="" then key
console 0
end

render:
y=5:x=8:cl=5:xs=8:ys=5:sc=6
scan:
p=y*40+x
if peek(p+vp)=cl and (peek(p+cp) and 15)<>cl then foundcolor
x=x+1
if x>32 then x=8:y=y+1:if y>21 then skipscan
goto scan
skipscan:
sc=8
if cl=5 then cl=1:x=12:y=5:goto scan
if cl=1 then cl=0:x=14:y=6:goto scan
return

foundcolor:
poke sp,x:poke sp+1,y:sp=sp+2
poke cp+p,cl
limit 20
xt=x+1:yt=y:gosub findnext
if f=0 then xt=x+1:yt=y+1:gosub findnext
if f=0 then xt=x+1:yt=y-1:gosub findnext
if f=0 then xt=x:yt=y+1:gosub findnext
if f=0 then xt=x-1:yt=y:gosub findnext
if f=0 then xt=x-1:yt=y+1:gosub findnext
if f=0 then xt=x-1:yt=y-1:gosub findnext
if f=0 then xt=x:yt=y-1:gosub findnext
if f=1 then draw
y=5:x=8
if sp>wp then x=peek(wp):y=peek(wp+1):sp=wp
goto scan
draw:
xs=x:ys=y
x=xt:y=yt:p=yt*40+xt
goto foundcolor

findnext:
tp=yt*40+xt+vp
c=0:f=0
if (peek(tp-vp+cp) and 15)=cl then return
if peek(tp)<>cl then return
if peek(tp+40)<>cl then c=c+1
if peek(tp+1)<>cl then c=c+1
if peek(tp+41)<>cl then c=c+1
if peek(tp+39)<>cl then c=c+1
if peek(tp-40)<>cl then c=c+1
if peek(tp-39)<>cl then c=c+1
if peek(tp-1)<>cl then c=c+1
if peek(tp-41)<>cl then c=c+1
if c<sc then f=1
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

wipemem:
print:print"v-init: allocate screens."
for i=20000 to 20999:pokei,6:next
print"m-loaddefaults: load system defaults."
for i=0 to 999:pokei+55296,6:pokei+1024,160:next
return

wipescr:
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
