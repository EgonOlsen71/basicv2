mx% = 11
my% = 11

tm% = 96
tr% = 68
tp% = 80
ts% = 92
th% = 64
tc% = 88
tg% = 104
tw% = 100
te% = 32

goto main

fallable:
	rv% = (t%<>te%) and (t%<>tw%)
	return

moveable:
	rv% = (t%<>te%) and (t%<>tw%)
	return

dissolves:
	rv% = (t%<>te%) and (t%<>tw%) and (t%<>tm%)
	return

set_charset:
	oc% = 12288
	poke 53272,oc%/1024+16
	poke 53280,0
	poke 53281,0
	return

clearscreen:
	print chr$(147);
	return
	
put_tile:
	of% = 1024 + x%*2 + y%*80
	co% = 1
	if t%=tg% then co%=7:goto switchskip
	if t%=tw% then co%=2:goto switchskip
	if t%=tm% then co%=3:goto switchskip
	if t%=tr% then co%=5:goto switchskip
	if t%=tp% then co%=7:goto switchskip
	if t%=ts% then co%=3:goto switchskip
	if t%=th% then co%=8:goto switchskip
	if t%=tc% then co%=12
switchskip:
	if t%=te% then empty
	poke of%,t%:poke of%+1,t%+1:poke of%+40,t%+2:poke of%+41,t%+3:goto tteuq
empty:	
	poke of%,te%:poke of%+1,te%:poke of%+40,te%:poke of%+41,te%
    
tteuq:	
	of = of% + 54272
	poke of,co%
	poke of+1,co%
	poke of+40,co%
	poke of+41,co%
	return

tile_at:
	rv%= peek(1024+x%*2 + y%*80)
	return

invert_tile:
	of% = 1024 + x%*2 + y%*80
	gosub xor_poke
	of%=of%+1:gosub xor_poke
	of%=of%+39:gosub xor_poke
	of%=of%+1:gosub xor_poke
	return

xor_poke:
	poke of%,(peek(of%) or 128)-(peek(of%) and 128):return
	
read_key:
	poke 198,0
peekkey:
	if peek(198)=0 then peekkey
	ky%=peek(631)
	poke 198,0
	if ky%=145 then rv%=0:return
	if ky%=29 then rv%=1:return
	if ky%=17 then rv%=2:return
	if ky%=157 then rv%=3:return
	if ky%=32 then rv%=4:return
	if ky%=3 then rv%=5:return
    goto read_key

level:
	ii%=0
leveloop:
	t%=tw%:x%=0:y%=ii%:gosub put_tile
	x%=11:y%=ii%:gosub put_tile
	x%=ii%:y%=11:gosub put_tile
	ii%=ii%+1:if ii%<12 then leveloop:
	if nr%=1 then gosub level1:return
	gosub level2
	return

level1:
	for ii=1 to 10
		t%=tm%:x%=4:y%=ii:gosub put_tile
		t%=tm%:x%=5:y%=ii:gosub put_tile
	next
	t%=tr%:x%=4:y%=1:gosub put_tile
	t%=tr%:x%=5:y%=0:gosub put_tile
    return
	
level2:
	for ii=3 to 8:t%=tw%:x%=ii:y%=4:gosub put_tile:next
	for ii=5 to 7:t%=tw%:x%=5:y%=ii:gosub put_tile:next
	for ii=6 to 10:t%=tw%:x%=ii:y%=11:gosub put_tile:next
	t%=tr%:x%=3:y%=1:gosub put_tile
	t%=tr%:x%=1:y%=6:gosub put_tile
	t%=tr%:x%=8:y%=2:gosub put_tile
	t%=tp%:x%=3:y%=2:gosub put_tile
	t%=ts%:x%=3:y%=3:gosub put_tile
	t%=ts%:x%=1:y%=9:gosub put_tile
	t%=ts%:x%=2:y%=10:gosub put_tile
	t%=tc%:x%=1:y%=8:gosub put_tile
	t%=tc%:x%=1:y%=10:gosub put_tile
	t%=th%:x%=1:y%=7:gosub put_tile
	t%=th%:x%=8:y%=3:gosub put_tile
	t%=th%:x%=8:y%=11:gosub put_tile
	t%=th%:x%=10:y%=11:gosub put_tile
	return
	
select_pos:
    gosub invert_tile
    gosub read_key:ky%=rv%
    gosub invert_tile
	if ky%=0 then if y%>0 then y%=y%-1:goto select_pos
	if ky%=1 then if x%<mx% then x%=x%+1:goto select_pos
	if ky%=2 then if y%<my% then y%=y%+1:goto select_pos
	if ky%=3 then if x%>0 then x%=x%-1:goto select_pos
	if ky%=4 then rv%=x%*256+y%:return
	if ky%=5 then rv%=-9999
	goto select_pos
	
switch_tiles:
	x%=x1%:y%=y1%:gosub tile_at:t1%=rv%
	x%=x2%:y%=y2%:gosub tile_at:t2%=rv%
	x%=x1%:y%=y1%:t%=t2%:gosub put_tile
	x%=x2%:y%=y2%:t%=t1%:gosub put_tile
	return

resolve:
	sa% = 0
	et% = 2
	ll% = 0
clear_array:
	tt%(ll%,0)=0
	tt%(ll%,1)=0
	ll%=ll%+1:if ll%<128 then clear_array
  
	tt%(0,0)=x1%
	tt%(0,1)=y1%
	tt%(1,0)=x2%
	tt%(1,1)=y2%
	dn% = 0
whily:
	if dn% then return
	cn% = sa%
while1:
	if cn%=et% then skipwhile1
	x% = tt%(cn%,0)
	y% = tt%(cn%,1):yo%=y%
	gosub tile_at:t1%=rv%
	if t1%<>te% then elseif1
	if y%=0 then cn%=cn%+1:goto while1end 
	y%=yo%-1:gosub tile_at:t2%=rv%
	t%=t2%:gosub fallable
	if not rv% then cn%=cn%+1:goto while1end
	x1%=x%:y1%=yo%:x2%=x%:y2%=y%:gosub switch_tiles
	tt%(et%,0) = x%
	tt%(et%,1) = y%
	et%=et%+1
	goto while1end
elseif1:
	if y%>=my% then skipif1
	y%=yo%+1:gosub tile_at:t2%=rv%
	if t2%<>te% then skipif1
	tt%(et%,0) = x%
	tt%(et%,1) = yo%+1
	et%=et%+1
skipif1:
	cn%=cn%+1
while1end:
	goto while1
skipwhile1:
	dn% = 1
	cn%=sa%
loopfor1:
	x% = tt%(cn%,0):xo%=x%
	y% = tt%(cn%,1):yo%=y%
	gosub tile_at:t1%=rv%
	t%=t1%:gosub dissolves
	if not rv% then nexuscn
	for ii=0 to 3:ii%=ii
		nx% = 255
		ny% = 255
		if ii%=0 then if y%>0 then nx%=x%:ny%=y%-1:goto switchbreak3
		if ii%=1 then if x%>0 then nx%=x%-1:ny%=y%:goto switchbreak3
		if ii%=2 then if x%<mx% then nx%=x%+1:ny%=y%:goto switchbreak3
		if ii%=3 then if y%<my% then nx%=x%:ny%=y%+1
switchbreak3:			
		if nx%=255 then nexusii
		x%=nx%:y%=ny%:gosub tile_at:x%=xo%:y%=yo%
		if rv%<>t1% then nexusii
		t%=te%:gosub put_tile
		x%=nx%:y%=ny%:gosub put_tile:x%=xo%:y%=yo%
		tt%(et%,0) = nx%
		tt%(et%,1) = ny%
		et%=et%+1
		dn% = 0
nexusii:
	next ii 
nexuscn:
	cn%=cn%+1
	if cn%<et% then loopfor1
	goto whily


game_loop:
	x% = 0
	y% = 0
loopy:
	gosub select_pos:sp%=rv%
    if sp%=-9999 then return
    x% = sp%/256
    y% = sp% and 255:xo%=x%
	gosub tile_at
	t%=rv%:gosub moveable
    if not rv% then loopy
    dn% = 0
loopy2:
	if dn% then skipwhile2
	gosub read_key:ky%=rv%
	nx% = x%
	cf% = 1
	if ky%=1 then if x%<mx% then nx%=nx%+1:cf%=0
	if ky%=3 then if x%>0 then nx%=nx%-1:cf%=0
	if ky%=4 then dn%=1
	if cf% or dn% then skipwhile3
	x%=nx%:gosub tile_at:x%=xo%
	if rv%<>te% then skipwhile3
	x1%=x%:y1%=y%:x2%=nx%:y2%=y%
	gosub switch_tiles
	gosub resolve
	dn%=1
skipwhile3:
	goto loopy2
skipwhile2:
	goto loopy
 

main:
	dim tt%(127,1)
	gosub set_charset
	lv% = 1
mainloop:
    gosub clearscreen
    nr%=lv%:gosub level
	gosub read_key:ky%=rv%
	if ky%=1 then lv%=lv%+1:if lv%>2 then lv%=1
	if ky%=2 then lv%=lv%-1:if lv%<1 then lv%=2
	if ky%=4 then gosub game_loop
    goto mainloop