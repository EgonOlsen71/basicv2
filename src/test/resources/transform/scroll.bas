
0 poke 53280, peek(53281)
1 let l$="{control+n}{home}"
2 let a$=" Here is a little scrolly dem
3 let a$=a$+"o using a 'go to'-less tec
4 let a$=a$+"hnique. Hellos to Ruby Mae
5 let a$=a$+". Press a key to exit.....
6 print"{clr/home}"
7 let i=.:let o=1:let l=len(a$)-o
8 let s=53270:let r=7:let kb=198
9 let w=53273:let sl=39
10 let x=7:poke 56335,peek(56334)and254
11 fori=.toostep.:pokew,o:waitw,o:::::::::
12 pokes,x:printl$left$(a$,sl):x=x-o:ifx<.thena$=right$(a$,l)+left$(a$,o)
13 i=peek(kb):ifx<.thenx=7
14 next
15 poke s,200
16 poke 56334,peek(56334) or 1:get k$:poke kb,.