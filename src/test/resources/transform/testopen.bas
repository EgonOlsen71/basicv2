5 print"scratching files...":open1,8,15,"s:test*":close1
10 print"writing...":open1,8,10,"test2,seq,w":a=65.331
15 print#1,"troet","yeah";tab(5);"5";spc(5);"5":print#1,chr$(111);spc(3),a
20 close1:print"done!";spc(5);"!"