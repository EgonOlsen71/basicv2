gr = 0.3
vb = -0.8
hb = -0.95
fr = 0.2
mi = 24.0
mx = 318.0
my = 228.0

gosub init

loop:
	gosub update
	wait 53265, 128 : rem wait one frame
	gosub draw
	goto loop
 
update:
	x = x + vx
	y = y + vy
	vy = vy + gr

	rem -- hit the wall
	if (x >= mx and vx > 0) or (x <= mi and vx < 0) then vx = vx * hb
	rem -- hit the ground
	if y >= my and vy > 0.0 then gosub move
	return

move:
	if abs(vx) < 0.2 then end
	vy = vy * vb
		  
	if vx > 0.0 then vx = vx - fr:return
	vx = vx + fr
	return
  
draw:
	sx% = int(x)
	sy% = int(y)
	poke 53248, sx%
	po%=0
	if sx% > 255 then po%=1
	poke 53264, po%
	poke 53249, sy%
	return
  
init:
    x = 28.0
    y = 48.0
    vy = 0.0
    vx = 5.5
    poke 53269, 1 : rem enable sprite
    gosub read_sprite
    poke 2040, 15 : rem sprite pointer
	return

read_sprite:
	for i=0 to 62
	read a%
	poke 960+i,a%
	next
	return
	data 0,126,0,3,255,192,7,255,224,31,255,248
	data 31,255,248,63,255,252,127,255,254
	data 127,255,254,255,255,255,255,255,255
	data 255,255,255,255,255,255,255,255,255
	data 127,255,254,127,255,254,63,255,252
	data 31,255,248,31,255,248,7,255,224
	data 3,255,192,0,126,0