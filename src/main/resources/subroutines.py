restart = False
running = True
keyPressed = None
lineNumber = 0
timeOut=0
funcName = "PROGRAMSTART"
tymp=0
status=0
_files = dict()

def getMemory():
    global _memory
    return _memory
    
def signum(value):
    if value < 0:
        return -1
    if value > 0:
        return 1
    return 0
    
def isNumber(var):
	if isinstance(var, (int, float)):
		return True
	if len(var)==0:
		return False
	try:
	    val = float(var)
	    return True
	except ValueError:
	    return False


def registerKey():
	global _memory
	global keyPressed
	k = keyboard.read_key()
	keyPressed=k
	_memory[198]=1

def execute():
	global running
	global restart
	while True:
		reinit()
		while running:
			executeLine()
		if not restart:
			break

def reinit():
	global lineNumer
	global funcName
	global restart
	global running
	lineNumber = 0
	funcName = "PROGRAMSTART"
	restart=False
	running=True

def executeLine():
	global funcName
	global lineNumber
	global JUMP_TARGET
	global running
	nextLine = globals()[funcName]()
	if nextLine != None:
		lineNumber = nextLine
		if lineNumber == "($JUMP)":
			lineNumber = JUMP_TARGET
		if isNumber(lineNumber):
			funcName = "line_" + str(lineNumber)
		else:
			funcName = lineNumber
	else:
		running = False

def START():
	global _memory
	INIT()
	_memory[646]=14

def RUN():
	global running
	global restart
	running=False
	restart=True

def RESTARTPRG():
	global running
	global restart
	running=False
	restart=True

def END():
	global _line
	if len(_line)>0:
		print(_line)

def CLEARQUEUE():
	global _inputQueue
	_inputQueue=[]

def QUEUESIZE():
	global _inputQueue
	global X_REG
	X_REG=len(_inputQueue)

def EXTRAIGNORED():
	out("?extra ignored!")

def INPUTNUMBER():
	global Y_REG
	global X_REG
	inp=input()
	if isNumber(inp):
		Y_REG=float(inp)
		X_REG=0
	else:
		X_REG=-1

def INPUTSTR():
	global A_REG
	A_REG=input()

def GETSTR():
	global A_REG
	A_REG=get()

def GETNUMBER():
	global Y_REG
	fk=get()
	if isNumber(fk):
		Y_REG=float(fk)
	else:
		out("?syntax error")


def isNaN(number):
	return math.isnan(number)

def isNumeric(number):
	return isNumber(number)

def parseFloat(number):
	return float(number)

def GOSUB(gosubCont):
	global _forstack
	_forstack.append(gosubCont)
	_forstack.append(0)

def pop(arr):
	return arr.pop()
	
def throw(txt):
	raise Exception(txt)

def RETURN():
	global _forstack
	val = 0
	if len(_forstack)==0:
		throw("RETURN without GOSUB error!")
	while True:
		val = _forstack.pop()
		if val == 1:
			_forstack.pop()
			_forstack.pop()
			_forstack.pop()
			_forstack.pop()
		if val==0:
			break
	val = _forstack.pop()
	return val

def adjustStack(variable):
	global _forstack
	i=len(_forstack)
	while i>0:
		type=_forstack[i-1]
		if type == 0:
			return
		vary = _forstack[i-2]
		addr = _forstack[i-3]
		end = _forstack[i-4]
		step = _forstack[i-5]
		i=i-5
		if vary == variable:
			_forstack=_forstack[0:i]
			return

def INITFOR(addr, variable):
	global _stack
	global _forstack
	adjustStack(variable)
	_forstack.append(_stack.pop())
	_forstack.append(_stack.pop())
	_forstack.append(addr)
	_forstack.append(variable)
	_forstack.append(1)

def NEXT(variable):
	global _forstack
	global A_REG
	global JUMP_TARGET
	found = False
	while True:
		if len(_forstack)==0:
			throw("NEXT without FOR error!")
		type=_forstack.pop()
		if type==0:
			throw("NEXT without FOR error!")
		stvar=_forstack.pop()
		addr=_forstack.pop()
		end=_forstack.pop()
		step=_forstack.pop()
		found = (variable == "0" or variable == stvar)
		if found:
			break
	globals()[stvar]+=step
	vv = globals()[stvar]	
	if (step >= 0 and vv <= end) or (step < 0 and vv >= end):
		_forstack.append(step)
		_forstack.append(end)
		_forstack.append(addr)
		_forstack.append(stvar)
		_forstack.append(1)
		A_REG = 0
		JUMP_TARGET = addr
		return
	A_REG = 1


def ARRAYACCESS_REAL():
	global X_REG
	global G_REG
	X_REG = G_REG[int(X_REG)]
	if X_REG == None:
		X_REG = 0

def ARRAYACCESS_INTEGER():
	global X_REG
	global G_REG
	X_REG = G_REG[int(X_REG)]
	if X_REG == None:
		X_REG = 0
	X_REG=int(X_REG)

def ARRAYACCESS_STRING():
	global G_REG
	global A_REG
	global X_REG
	A_REG = str(G_REG[int(X_REG)])
	if A_REG == None:
		A_REG = ""

def ARRAYSTORE_REAL():
	global G_REG
	global Y_REG
	global X_REG
	G_REG[int(X_REG)] = Y_REG

def ARRAYSTORE_INTEGER():
	global G_REG
	global Y_REG
	global X_REG
	G_REG[int(X_REG)] = int(Y_REG)

def ARRAYSTORE_STRING():
	global G_REG
	global A_REG
	global X_REG
	G_REG[int(X_REG)] = A_REG

def STR():
	global A_REG
	global Y_REG
	A_REG=str(Y_REG)
	if A_REG.endswith(".0"):
		A_REG=A_REG.replace(".0", "")

def VAL():
	global B_REG
	global X_REG
	if B_REG==None:
		X_REG=0
		return
	nums = B_REG.replace(" ","")
	num = ""
	for i in range(0,len(nums)):
		char = nums[i]
		if char not in "0123456789.":
			break
		num+=char
	try:
		X_REG=float(num)
	except:
		X_REG=0

def LEN():
	global B_REG
	global X_REG
	if B_REG == None:
		X_REG = 0
		return
	X_REG=len(B_REG)

def CHR():
	global A_REG
	global Y_REG
	A_REG=chr(int(Y_REG))


def ASC():
	global B_REG
	global X_REG
	if B_REG == None or len(B_REG)==0:
		X_REG=0
		return
	X_REG=ord(B_REG[0])

def POS():
	global X_REG
	global _line
	X_REG=len(_line)

def TAB():
	global _line
	global Y_REG
	tb=int(Y_REG)
	tb-=len(_line)
	for i in range(0,tb):
		_line+=" "

def SPC():
	global _line
	global Y_REG
	tb=int(Y_REG)
	for i in range(0,tb):
		_line+=" "

def FRE():
	global X_REG
	X_REG=65535

def CONCAT():
	global B_REG
	global A_REG
	A_REG=A_REG+B_REG

def CHARAT():
	global D_REG
	D_REG=1
	MID()

def MID():
	global D_REG
	global C_REG
	global B_REG
	global A_REG
	if B_REG == None or C_REG > len(B_REG):
		A_REG=""
		return
	end=C_REG-1 + D_REG
	if D_REG==-1:
		end=len(B_REG)
	A_REG=B_REG[C_REG-1:end]

def LEFT():
	global C_REG
	global B_REG
	global A_REG
	if C_REG > len(B_REG):
		A_REG=B_REG
		return
	if C_REG==0:
		A_REG=""
		return
	A_REG=B_REG[:C_REG]

def RIGHT():
	global C_REG
	global B_REG
	global A_REG
	if C_REG > len(B_REG):
		A_REG=B_REG
		return
	if C_REG==0:
		A_REG=""
		return
	A_REG=B_REG[len(B_REG)-C_REG:]

def SEQ():
	global X_REG
	global B_REG
	global A_REG
	if A_REG == B_REG:
		X_REG=-1
	else: 
		X_REG=0

def SNEQ():
	global X_REG
	global B_REG
	global A_REG
	if A_REG == B_REG:
		X_REG=0
	else: 
		X_REG=-1

def SGT():
	global X_REG
	global B_REG
	global A_REG
	if A_REG > B_REG:
		X_REG=-1
	else: 
		X_REG=0

def SLT():
	global X_REG
	global B_REG
	global A_REG
	if A_REG < B_REG:
		X_REG=-1
	else: 
		X_REG=0

def SGTEQ():
	global X_REG
	global B_REG
	global A_REG
	if A_REG >= B_REG:
		X_REG=-1
	else: 
		X_REG=0

def SLTEQ():
	global X_REG
	global B_REG
	global A_REG
	if A_REG <= B_REG:
		X_REG=-1
	else: 
		X_REG=0

def COMPACT():
	pass

def COMPACTMAX():
	pass

def SYSTEMCALLDYN():
	pass

def APPENDSYSCHAR():
	pass

def INPUTLENGTHCHECK():
	global _zeroflag
	_zeroflag = 1

def SETUPMULTIPARS():
	pass

def COPYSTRINGPAR():
	pass

def COPYREALPAR():
	pass

def ADDCOLON():
	pass

def PULLDOWNMULTIPARS():
	pass

def STROUT():
	global A_REG
	out(A_REG)

def QMARKOUT1():
	out("?")

def CRSRRIGHT():
	out(" ")

def QMARKOUT2():
	out("??")

def REALOUT():
	global X_REG
	out(X_REG)

def INTOUT():
	global X_REG
	out(X_REG)

def CHECKCMD():
	pass

def LINEBREAK():
	out("\n")

def TABOUT():
	out("\t")

def millis():
	return int(time.perf_counter() * 1000)

def WRITETID(value):
	global _time
	global _timeOffset
	_time = millis()
	_timeOffset = int(value[0:2])* 1000 * 60 * 60 + int(value[2:4]) * 1000 * 60 + int(value[4:6]) * 1000

def READTI():
	global _time
	global _timeOffset
	global tmpy
	t=millis()
	t=int((t-_time+_timeOffset)/(1000.0/60.0))
	tmpy=t

def READTID():
	global _time
	global _timeOffset
	global tmpy
	t=millis()
	t=t-_time+_timeOffset
	h=int(t/(1000 * 60 * 60))
	m=int(((t-(h*(1000 * 60 * 60)))/(1000 * 60)))
	s=int((t-(h*(1000 * 60 * 60))-m*(1000 * 60))/1000)
	h=fill(h)
	m=fill(m)
	s=fill(s)
	tmpy= h+m+s

def fill(num):
	num=str(num)
	if len(num)==1:
		num="0"+num
	return num

def READSTATUS():
	global tmpy
	global status
	tmpy=status
	status=0

def RESTORE():
	global _dataPtr
	_dataPtr=0

def READSTR():
	global _dataPtr
	global _datas
	global A_REG
	A_REG=_datas[_dataPtr]
	_dataPtr+=1

def READNUMBER():
	global _dataPtr
	global _datas
	global Y_REG
	num=_datas[_dataPtr]
	_dataPtr+=1
	
	if isinstance(num, str) and (num == "." or len(num) == 0):
		num=0
	Y_REG=num

def FINX():
	throw("Fast inc optimization not supported for target PY!")

def FDEX():
	throw("Fast dec optimization not supported for target PY!")

def FASTFOR():
	throw("Fast for optimization not supported for target PY!")

def OPEN():
	global _files
	global G_REG
	global D_REG
	global C_REG
	global X_REG
	global Y_REG
	parts = G_REG.split(",")
	mode = "r"
	fileName = parts[0]
	# we ignore flags for now, just r+ as a mode
	secAddr = int(D_REG)
	device = int(C_REG)
	number = int(X_REG)
	count = int(Y_REG)
	if "r" in parts:
		mode = "r"
	else:
		if "w" in parts:
			mode = "w"
	if count>2:
		if secAddr==0:
			mode = "r"
		else:
			if secAddr==1:
				mode = "w"
		
	if secAddr==15:
		diskOperation(fileName)
		return
	key = "file"+str(number)
	fileHandle = _files.get(key)
	if fileHandle != None:
		throw("File already open error!")
	if mode=="r":
		fileHandle = open(fileName, mode+"b")
	else:
		fileHandle = open(fileName, mode, encoding="ascii")
	_files[key]=fileHandle

def CLOSE():
	global _files
	global X_REG
	key = "file"+str(int(X_REG))
	fileHandle = _files.get(key)
	if fileHandle == None:
		throw("File not open error!")
	fileHandle.close()
	_files.pop(key)

def CMD():
	out("[CMD not supported for PY, call ignored!]")

def diskOperation(fileName):
	out("[Disc operation ignored!]")

def readChar(fileHandle):
	global status
	status = 0
	char = fileHandle.read(1)
	if not char:
		status = 64
		return ""
	# determine, if we reached the end...
	chs = fileHandle.read(1)
	#print(":",chs,":")
	if not chs:
		status = 64
	fileHandle.seek(-1, 1)
	# convert...
	char = char.decode("ascii")
	if ord(char)==10:
		char = chr(13)
		# return convertChar(char)
	return char

def REM():
	out("[inline assembly ignored!]")

def LOCKCHANNEL():
	pass

def UNLOCKCHANNEL():
	pass

def STROUTCHANNEL():
	global _files
	global C_REG
	global A_REG
	fileHandle = openFile(C_REG)
	fileHandle.write(A_REG)

def REALOUTCHANNEL():
	out("[PRINT# not supported for PY, redirected to normal PRINT]")
	REALOUT()

def LINEBREAKCHANNEL():
	global A_REG
	A_REG="\n"
	STROUTCHANNEL()

def INTOUTCHANNEL():
	out("[PRINT# not supported for PY, redirected to normal PRINT]")
	INTOUT()

def INPUTNUMBERCHANNEL():
	global X_REG
	global A_REG
	INPUTSTRCHANNEL()
	X_REG=0
	if A_REG!="":
		X_REG=float(A_REG)

def openFile(number):
	key = "file"+str(int(number))
	fileHandle = _files.get(key)
	if fileHandle == None:
		throw("File not open error!")
	return fileHandle

def INPUTSTRCHANNEL():
	global A_REG
	global C_REG
	global _files
	global status
	fileHandle = openFile(C_REG)
	A_REG=""
	stops = "\n\r:,"
	while True:
		char = readChar(fileHandle)
		if char=="" or char in stops or status==64:
			return
		A_REG+=char

def GETSTRCHANNEL():
	global A_REG
	global C_REG
	global _files
	fileHandle = openFile(C_REG)
	A_REG = readChar(fileHandle)

def GETNUMBERCHANNEL():
	global X_REG
	out("[GET# not supported for PY, call ignored]")
	X_REG=0

def TABOUTCHANNEL():
	out("[TAB not supported for PY in file mode, redirected to normal TAB]")
	TAB()

def SPCOUTCHANNEL():
	out("[SPC not supported for PY in file mode, redirected to normal SPC]")
	SPC()

def TABCHANNEL():
	out("[TAB not supported for PY in file mode, redirected to normal TAB]")
	TAB()

def SPCCHANNEL():
	out("[SPC not supported for PY in file mode, redirected to normal SPC]")
	SPC()

def LOAD():
	out("[LOAD not supported for PY in file mode, call ignored]")

def SAVE():
	out("[SAVE not supported for PY in file mode, call ignored]")

def VERIFY():
	out("[VERIFY not supported for PY in file mode, call ignored]")

def USR():
	global _memory 
	global USR_PARAM
	global X_REG
	addr=_memory[785] + 256*_memory[786]
	USR_PARAM=X_REG
	callStr="$"+hex(addr)
	out("[Calling user function named "+callStr+"]")
	globals()[callStr]()

def input():
	global _inputQueue
	global _line
	if len(_inputQueue)>0:
		return _inputQueue.pop()
		
	inp=__builtins__.input(_line+" ")
	_line=""
	if inp == None or len(inp)==0:
		return ""
	parts=inp.split(",")
	
	# of course, it's not append...why would it...!?
	_inputQueue.extend(parts)
	ret = _inputQueue.pop()
	# print(ret)
	return ret

def get():
	flushOut()
	return keyboard.read_key()

def flushOut():
	global _line
	if len(_line)>0:
		print(_line)
		_line = ""

def out(txt):
	global _line
	if isinstance(txt, str) and  "\n" in txt:
		_line += txt[0:len(txt)-1]
		print(_line)
		_line = ""
	else:
		txt = str(txt)
		if txt.endswith(".0"):
			txt=txt.replace(".0", "")
		_line += txt

def convertChar(char):
		# converts ASCII <-> PETSCII ... not used for now
        code = ord(char)
        if 65 <= code <= 90:
            return chr(code)
        elif 97 <= code <= 122:
            return chr(code - 32)
        elif 193 <= code <= 218:
            return chr(code - 128)
        elif 225 <= code <= 250:
            return chr(code - 128 - 32)
        else:
            return char

execute()
