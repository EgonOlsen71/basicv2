0 REM"{delete*9}{space*3}printed by{space*12}mike galluchon
100 X=PEEK(648)*256:SYS65517:GP=PEEK(781):IFGP=40THENCR$=CHR$(13)
110 DIMM%(17,17):O$="{down}{space*2}{reverse on}press any key":IFGP<>40THENPOKE36879,110
120 FORJ=1TO17:FORI=2TO16:M%(1,J)=1:M%(17,J)=1:M%(I,17)=1:M%(I,1)=1:NEXTI,J
130 FORI=3TO16STEP2:FORJ=3TO16STEP2:M%(I,J)=1:NEXTJ,I:AJ=.:Q$="n"
140 FORK=1TO37:I=INT(RND(1)*15)+2:J=INT(RND(1)*15)+2:M%(I,J)=1:NEXT:Q=1:B=2:C=2
150 FORI=1TO26:READW:READY:M%(W,Y)=0:NEXT:RESTORE:TI$="000000":E=0:D=-1:AI=D
160 POKE198,0:PRINT"{clear}{white}"TAB(10)Q$:IFM%(B+E,C+D)=1THEN410
170 PRINT"{home} {down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M{down}M"
180 PRINT" {up}N{up}N{up}N{up}N{up}N{up}N{up}N{up}N{up}N{up}N{up}N{up}N{up}/":PRINTTAB(13)"{up}N{up}N{up}N{up}N{up}N{up}N{up}N{up}N{home}"
190 IFM%(B+AI,C+AJ)=0THENGOSUB670
200 IFM%(B-AI,C-AJ)=0THENGOSUB690
210 IFM%(B+2*E,C+2*D)=1THEN470
220 IFM%(B+2*E+AI,C+2*D+AJ)=0THENGOSUB610
230 IFM%(B+2*E-AI,C+2*D-AJ)=0THENGOSUB630
240 IFM%(B+3*E,C+3*D)=1THEN490
250 IFM%(B+4*E,C+4*D)=1THEN540
260 IFM%(B+4*E+AI,C+4*D+AJ)=0THENGOSUB650
270 IFM%(B+4*E-AI,C+4*D-AJ)=0THENGOSUB660
280 IFM%(B+5*E,C+5*D)=1THEN560
290 GOSUB570:GETQ$:IFQ$=""THEN290
300 IFQ$="q"THENPRINT"{clear}":ZS=1:GOSUB720:GOTO850
310 IFQ$="n"THENE=0:D=-1:AI=-1:AJ=0:GOTO160
320 IFQ$="s"THENE=0:D=1:AI=1:AJ=0:GOTO160
330 IFQ$="e"THENE=1:D=0:AI=0:AJ=-1:GOTO160
340 IFQ$="w"THENE=-1:D=0:AI=0:AJ=1:GOTO160
350 IFQ$="h"THENQ$="":GOSUB710:GOTO160
360 IFQ$=" "THENQ$="":GOTO380
370 GOTO290
380 IFM%(B+E,C+D)<>0THEN290
390 IFM%(B+2*E,C+2*D)=1THEN290
400 B=B+2*E:C=C+2*D:GOTO160
410 PRINT"{home}O{cm y*20}P";CR$;:FORI=1TO19
420 PRINT"{cm g}{space*20}{cm m}";CR$;:NEXT
430 PRINT"L{cm p*20}{sh @}{home}"
440 PRINT"{home}";TAB(10)Q$:IFB+E=2ANDC+D=1ANDQ$="n"THENPRINTTAB(8)"{up}{reverse on}start"
450 IFB=16ANDC=16ANDQ$="s"THENPRINTTAB(7);"{white}{down*5}{reverse on}finish":FORI=1TO300:NEXT
460 GOTO290
470 PRINT"{home}{down*4}{right*4}O{cm y*12}P":FORI=1TO12:PRINT"{right*4}{cm g}{space*12}{cm m}":NEXT
480 PRINT"{right*4}L{cm p*12}{sh @}":GOTO290
490 PRINT"{home}{down*5}{right*5}O{cm y*10}P":FORI=1TO10:PRINTTAB(5)"{cm g}{space*10}{cm m}":NEXT
500 PRINTTAB(5)"L{cm p*10}{sh @}"
510 IFB=2ANDC-3=1ANDQ$="n"THENPRINT"{home}{down*7}"TAB(10)"{reverse on}s"
520 IFB=16ANDC+3=17ANDQ$="s"THENPRINT"{home}{down*7}"TAB(10)"{reverse on}f"
530 GOTO290
540 PRINT"{home}{down*8}"TAB(8)"O{cm y*4}P{down}{left*6}{cm g}{space*4}{cm m}{down}{left*6}{cm g}{space*4}{cm m}{down}{left*6}{cm g}{space*4}{cm m}"
550 PRINTTAB(8)"{cm g}{space*4}{cm m}{down}{left*6}L{cm p*4}{sh @}":GOTO290
560 PRINT"{home}":PRINTTAB(9)"{down*8}O{cm y*2}P{down}{left*4}{cm g}{space*2}{cm m}{down}{left*4}{cm g}{space*2}{cm m}{down}{left*4}L{cm p*2}{sh @}":GOTO290
570 IFB<>16ORC<>16ORQ$<>"s"THENRETURN
580 FORI=1TO1E3:NEXT:PRINT"{clear}{down*3}"TAB(5)"you made it":PRINTTAB(5)"in"VAL(TI$)"sec"
590 PRINT"{down*2}"TAB(4)"{reverse on}press any key"
600 FORI=1TO1E3:NEXT:POKE198,0:GOSUB820:PRINT"{clear}":GOTO720
610 PRINT"{home}{down*3}{right}{down}{right*2}{cm m} {down}{left*2}{cm m}P{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}";
620 PRINT"{down}{left*2}{cm m}{sh @}{down}{left*2}{cm m} ":RETURN               
630 PRINT"{home}":PRINTTAB(17)"{down*4}{cm g}{down}{left}{cm g}{down}{left}{cm g}{down}{left}{cm g}{down}{left}{cm g}{down}{left}{cm g}{down}{left}{cm g}{down}{left}{cm g}{down}{left}{cm g}{down}{left}{cm g}";
640 PRINTTAB(16)"{down}{left*2}L{cm g}{down}{left}{cm g}{left*2} {up}{left}L{up}{left}{cm g}{up}{left}{cm g}{up}{left}{cm g}{up}{left}{cm g}{up}{left}{cm g}{up}{left}{cm g}{up}{left}{cm g}{up}{left}{cm g}{up}{left}O{up}{left} ":RETURN
650 PRINT"{home}"TAB(7)"{down*8}{cm m} {down}{left*2}{cm m}P{down}{left*2}{cm m*2}{down}{left*2}{cm m*2}{down}{left*2}{cm m}{sh @}{down}{left*2}{cm m} ":RETURN
660 PRINT"{home}":PRINTTAB(14)"{down*7}{left} {cm g}{down}{left*2}O{cm g}{down}{left*2}{cm g*2}{down}{left*2}{cm g*2}{down}{left*2}L{cm g}{down}{left*2} {cm g}":RETURN
670 PRINT"{home} {down}{left}P{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{cm m}{down}{left}{sh @}{down}{left} {home}"
680 RETURN
690 FORI=X+(2*GP)TOX+(21*GP)STEPGP:POKEI,101:NEXT:POKEX,32
700 POKEX+(1*GP),79:POKEX+(20*GP),76:POKEX+(21*GP),32:RETURN
710 PRINT"{clear}{space*2}you are here":ZS=1
720 FORJ=1TO17:FORI=1TO17
730 IFM%(I,J)=1THENPRINT"{reverse on} {reverse off}";:GOTO770
740 IFI=BANDJ=CTHENPRINT"{cyan}Z{white}";:GOTO770
750 IFM%(I,J)=5THENPRINT"r";:GOTO770
760 PRINT"{right}";
770 NEXTI:PRINT"":NEXTJ
780 IFZSTHENZS=0:RETURN
790 POKE198,0:PRINTO$:GOSUB820:CLR:GOTO100
800 DATA2,2,2,3,2,4,4,2,4,4,4,3,16,14,16,16,14,16,15,16,14,14,8,5,8,6,8,7
810 DATA8,8,8,9,8,10,14,8,14,9,14,10,3,2,2,5,5,2,12,10,10,10,6,6
820 GETA$:IFA$=""THEN820
830 IFA$="q"THENPOKE198,0:SYS198
840 PRINT"{clear}":RETURN
850 PRINTO$:WAIT198,1:POKE198,0:SYS198
