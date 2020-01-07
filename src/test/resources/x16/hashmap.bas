10 ms=500:gosub 60000
20 gosub 10000
1000 end
10000 rem "unit" test
10010 rem ***
10015 ti$="000000":print"testing put..."
10020 for i=1 to 9:read va$,ky$:gosub 60500
10030 rem print"adding: ";ky$;":";va$;" (size:";ci;")"
10050 gosub 60100:gosub 60500
10060 rem print"ef% status; ";ef%;" (size:";ci;")"
10065 if i<ci then print "?put error":stop
10070 next
10080 restore:print"testing get..."
10090 for i=1 to 9:read va$,ky$:vo$=va$
10100 va$="":gosub 60200
10120 rem print "retrieved ";va$;" (";vo$;")";" for ";ky$
10125 if ef%=1 then print "?get error":stop
10130 next:gosub 60500:co=ci
10135 print"testing remove..."
10140 for i=1 to 3:read ky$:gosub 60500
10150 rem print"removing ";ky$;" (size:";ci;")"
10160 gosub 60300:gosub 60500
10170 rem print "size now:";ci
10175 if ci<>co-1 then print "?remove error":stop
10177 co=ci
10180 va$="":gosub 60200:if ef%<>1 then print"?remove error":stop
10190 next
10196 print"testing add/remove..."
10200 for kv=0to100:ky$="key"+str$(kv):va$="value"+str$(kv)
10210 gosub 60100:gosub 60500
10220 co=ci:ef%=0
10230 if (kv and 1)=1 then 10250
10235 gosub 60300:vo$=va$
10240 va$="":gosub 60500:if ci<>co-1 then print"?remove error": stop
10250 gosub 60200
10260 if (ef%=0) and (kv and 1)<>1 then print "?remove error":stop
10270 if (ef%=1) and (kv and 1)=1 and va$<>vo$ then print "?get error ":stop
10280 next
10290 print "testing clear...":gosub 60700:gosub 60500
10300 if ci>0 then print "?clear error":stop
10310 print "time: ";ti$
10320 return
20000 data "value1","key1"
20010 data "value2","key2"
20020 data "value3","key3"
20030 data "value4","key4"
20040 data "value1new","key1"
20050 data "value3new","key3"
20060 data "value11","kex1"
20070 data "value12","kez1"
20080 data "value13","keu1"
20090 data "key1","key3","kez1"
60000 rem init map, takes maximum required map size in ms.
60005 rem ma% will store the actual size in each bucket's list
60006 rem mt% will store the actual maximum size of the map, which
60007 rem is guaranteed to be at least ms but can be higher.
60008 rem internal variable names used: c%,mp$(),mc%(), th$, ef%, ci, ok%
60009 rem vs$, and bi
60010 rem ***
60015 ma%=int(ms/256+.5):mt%=256*ma%
60020 dim mp$(255,ma%-1,1): dim mc%(256,1)
60030 print "map initialized: ";ms;mt%,ma%:return
60100 rem add to map; value is in va$, key in ky$
60110 rem if the key exists already, ef% will be 0, otherwise 1
60112 rem ***
60120 if mc%(256,0)>=mt% then print"?map full error":stop
60130 th$=ky$:gosub 63000:ok%=ky%
60132 vs$=va$:gosub 60200:if ef%=1 then va$=vs$:goto 60140
60134 mp$(bi,ci,1)=vs$:ef%=0:return
60140 c%=mc%(ky%,0):if mc%(ok%,1)<ky% then mc%(ok%,1)=ky%:goto 60150
60145 if ok%>ky% and mc%(ok%,1)>ky% then mc%(ok%,1)=ky%
60150 if c%<ma% then 60170
60160 ky%=(ky%+1) and 255:goto 60140
60170 mp$(ky%,c%,0)=ky$:mp$(ky%,c%,1)=va$
60180 mc%(ky%,0)=mc%(ky%,0)+1:mc%(256,0)=mc%(256,0)+1:return
60200 rem retrieve an entry from the map, key in ky$, returned value in va$
60210 rem if there is no such key, va$ will be empty and ef% will be 1
60220 rem otherwise, ef% will be 0
60221 rem bi contains the bucket's index, ci the index into that bucket's
60222 rem item list, if ef%=0. Otherwise, they are undefined.
60224 rem ***
60230 ef%=0:va$="":th$=ky$:gosub 63000:ok%=ky%
60240 c%=mc%(ky%,0):if c%=0 then ef%=1:return
60250 for ci=0 to c%-1
60255 if mp$(ky%,ci,0)=ky$ then va$=mp$(ky%,ci,1):bi=ky%:return
60257 next ci
60260 ky%=(ky%+1) and 255
60270 if ky%=ok% or mc%(ok%,1)<ky% then va$="":ef%=1:return
60280 goto 60240
60300 rem remove an entry from the map. The key is in ky$.
60310 rem if there is no such key, ef% will be 1, otherwise it's 0
60315 rem ***
60320 ef%=0:th$=ky$:gosub 63000:ok%=ky%
60330 c%=mc%(ky%,0)
60340 for ci=0 to c%-1
60350 if ky$=mp$(ky%,ci,0) then 60400
60360 next ci
60370 ky%=(ky%+1) and 255
60380 if ky%>mc%(ok%,1) then ef%=1:return
60390 goto 60330
60400 if ci>=c%-1 then mp$(ky%,ci,0)="":goto 60415
60405 for ci=ci+1 to c%-1:mp$(ky%,ci-1,0)=mp$(ky%,ci,0)
60410 mp$(ky%,ci-1,1)=mp$(ky%,ci,1):next ci
60415 mc%(ky%,0)=mc%(ky%,0)-1
60420 if mc%(ky%,0)=0 and mc%(ok%,1)=ky% then mc%(ok%,1)=ky%-1
60430 if mc%(ok%,1)<0 then mc%(ok%,1)=255
60440 mc%(256,0)=mc%(256,0)-1:return
60500 rem return the map's size in ci
60510 ci=mc%(256,0):return
60700 rem clears the map
60710 rem ***
60720 mc%(256,0)=0:mc%(256,1)=0
60730 for ci=0 to 255:mc%(i,0)=0:mc%(i,1)=0
60740 for bi=0 to ma%-1:mp$(ci,bi,0)="":mp$(ci,bi,1)="":next bi
60750 next ci:return
63000 rem calculate hash key, value to hash in th$, key in ky%
63005 if len(th$)=0 then ky%=0:return
63010 ky%=(asc(left$(th$,1))+asc(mid$(th$,len(th$)/2,1))+asc(right$(th$,1)))
63015 ky%=ky% and 255:return

