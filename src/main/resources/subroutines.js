
function execute() {
	var lineNumber=0;
	var running=true;
	var funcName="PROGRAMSTART";
	while(running) {
		//console.log("Call(1): "+funcName);
		var nextLine=this[funcName]();
		if (nextLine!=null) {
			lineNumber=nextLine;
			if (Number.isInteger(lineNumber)) {
				funcName="line_"+lineNumber;
			} else {
				funcName=lineNumber;
			}
		} else {
			running=false;
		}
	}
}

function START() {
	//
}

function END() {
	//
}

function GOSUB(gosubCont) {
	_forstack.push(gosubCont);
	_forstack.push(0);
}

function RETURN() {
	var val=0;
	do {
		val=_forstack.pop();
	} while(val!=0);
	return _forstack.pop();
}

function WRITETID(value) {
	//
}

function STROUT() {
	out(A_REG);
}

function REALOUT() {
	out(X_REG);
}

function INTOUT() {
	out(X_REG);
}

function CHECKCMD() {
	
}

function LINEBREAK() {
	out("\n");
}

function TABOUT() {
	out("\t");
}

function READTI() {
	//
}

function READTID() {
	//
}

function READSTATUS() {
	//
}

function out(txt) {
	//console.log("["+txt+"]");
	if (txt.indexOf && txt.indexOf("\n")!=-1) {
		_line+=txt;
		console.log(_line);
		_line="";
	} else {
		_line+=txt;
	}
}