10 dim a(5,5)
20 a(3,4) = 42:a(2,3)=2
30 p(2) = 3:p(4)=2
40 print a(3,4);
45 print a(p(2),4);
50 h=4:print a(p(a(p(4),int(asc("!")/11))),h);
55 h=4:print a(0+p(h-2),h);
60 h=p(2):print a(h,4)