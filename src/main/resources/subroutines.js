function execute() {
	var lineNumber = 0;
	var running = true;
	var funcName = "PROGRAMSTART";
	while (running) {
		// console.log("Call(1): "+funcName);
		var nextLine = this[funcName]();
		if (nextLine != null) {
			lineNumber = nextLine;
			if (lineNumber == "($JUMP)") {
				lineNumber = JUMP_TARGET;
			}
			if (Number.isInteger(lineNumber)) {
				funcName = "line_" + lineNumber;
			} else {
				funcName = lineNumber;
			}
		} else {
			running = false;
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
	var val = 0;
	if (_forstack.length == 0) {
		throw "RETURN without GOSUB error!";
	}
	do {
		val = _forstack.pop();
		if (val == 1) {
			// skip FORs
			_forstack.pop();
			_forstack.pop();
			_forstack.pop();
			_forstack.pop();
		}
	} while (val != 0);
	return _forstack.pop();
}

function INITFOR(addr, variable) {
	_forstack.push(_stack.pop()); // step
	_forstack.push(_stack.pop()); // end
	_forstack.push(addr); // address
	_forstack.push(variable); // var ref
	_forstack.push(1); // type
}

function NEXT(variable) {
	var found = false;
	do {
		if (_forstack.length == 0) {
			throw "NEXT without FOR error!";
		}
		var type = _forstack.pop();
		if (type == 0) {
			throw "NEXT without FOR error!";
		}
		var stvar = _forstack.pop();
		var addr = _forstack.pop();
		var end = _forstack.pop();
		var step = _forstack.pop();
		found = variable == "0" || variable == stvar;
	} while (!found);
	this[stvar] += step;
	if ((step >= 0 && this[stvar] <= end) || step < 0 && this[stvar] >= end) {
		// restore stack content if needed
		_forstack.push(step); // step
		_forstack.push(end); // end
		_forstack.push(addr); // address
		_forstack.push(stvar); // var ref
		_forstack.push(1); // type
		A_REG = 0;
		JUMP_TARGET = addr;
		return;
	}
	A_REG = 1;
	return;
}

function ARRAYACCESS_REAL() {
	X_REG = G_REG[Math.floor(X_REG)];
}

function ARRAYACCESS_INTEGER() {
	X_REG = Math.floor(G_REG[Math.floor(X_REG)]);
}

function ARRAYSTORE_REAL() {
	G_REG[Math.floor(X_REG)] = Y_REG;
}

function ARRAYSTORE_INTEGER() {
	G_REG[Math.floor(X_REG)] = Math.floor(Y_REG);
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

function WRITETID(value) {
	var d = new Date();
	_time = d.getTime();
	_timeOffset = parseInt(value.substring(0, 2), 10) * 1000 * 60 * 60
			+ parseInt(value.substring(2, 4), 10) * 1000 * 60
			+ parseInt(value.substring(4, 6), 10) * 1000;
	
}

function READTI() {
	var d = new Date();
	var t=d.getTime();
	t=Math.floor((t-_time+_timeOffset)/(1000.0/60.0));
	X_REG=t;
}

function READTID() {
	var d = new Date();
	var t=d.getTime();
	t=(t-_time+_timeOffset);
	var h=Math.floor(t/(1000 * 60 * 60));
	var m=Math.floor((t-(h*(1000 * 60 * 60)))/(1000 * 60));
	var s=Math.floor((t-(h*(1000 * 60 * 60))-m*(1000 * 60))/1000);
	A_REG= ""+h+""+m+""+s;
}

function READSTATUS() {
	return 0;
}

function out(txt) {
	// console.log("["+txt+"]");
	if (txt.indexOf && txt.indexOf("\n") != -1) {
		_line += txt;
		console.log(_line);
		_line = "";
	} else {
		_line += txt;
	}
}