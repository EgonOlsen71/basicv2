a=1
b=2:c=3
hurz:
fori=0to100:printi:nexti
a=a+b:ifa>20thenend
ifc=10thenhurz
ifc=11gototerminate
ifc=12thengototerminate
ifc=13thengosubnothing:print"never happens":gotohurz
goto hurz
on c goto hurz,hurz,terminate
terminate: end
nothing:
return
