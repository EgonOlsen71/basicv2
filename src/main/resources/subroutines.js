this.execute = function() {
	var lineNumber = 0;
	var running = true;
	var funcName = "PROGRAMSTART";
	while (running) {
		//console.log("Call(1): "+funcName);
		var nextLine = this[funcName]();
		if (nextLine != null) {
			lineNumber = nextLine;
			if (lineNumber == "($JUMP)") {
				lineNumber = this.JUMP_TARGET;
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

this.START = function() {
	//
}

this.END = function() {
	//
}

this.GOSUB = function(gosubCont) {
	this._forstack.push(gosubCont);
	this._forstack.push(0);
}

this.RETURN = function() {
	var val = 0;
	if (this._forstack.length == 0) {
		throw "RETURN without GOSUB error!";
	}
	do {
		val = this._forstack.pop();
		if (val == 1) {
			// skip FORs
			this._forstack.pop();
			this._forstack.pop();
			this._forstack.pop();
			this._forstack.pop();
		}
	} while (val != 0);
	return this._forstack.pop();
}

this.INITFOR = function(addr, variable) {
	this._forstack.push(this._stack.pop()); // step
	this._forstack.push(this._stack.pop()); // end
	this._forstack.push(addr); // address
	this._forstack.push(variable); // var ref
	this._forstack.push(1); // type
}

this.NEXT = function(variable) {
	var found = false;
	do {
		if (this._forstack.length == 0) {
			throw "NEXT without FOR error!";
		}
		var type = this._forstack.pop();
		if (type == 0) {
			throw "NEXT without FOR error!";
		}
		var stvar = this._forstack.pop();
		var addr = this._forstack.pop();
		var end = this._forstack.pop();
		var step = this._forstack.pop();
		found = variable == "0" || variable == stvar;
	} while (!found);
	this[stvar] += step;
	if ((step >= 0 && this[stvar] <= end) || step < 0 && this[stvar] >= end) {
		// restore stack content if needed
		this._forstack.push(step); // step
		this._forstack.push(end); // end
		this._forstack.push(addr); // address
		this._forstack.push(stvar); // var ref
		this._forstack.push(1); // type
		this.A_REG = 0;
		this.JUMP_TARGET = addr;
		return;
	}
	this.A_REG = 1;
	return;
}

this.ARRAYACCESS_REAL = function() {
	this.X_REG = this.G_REG[Math.floor(this.X_REG)];
}

this.ARRAYACCESS_INTEGER = function() {
	this.X_REG = Math.floor(this.G_REG[Math.floor(this.X_REG)]);
}

this.ARRAYACCESS_STRING = function() {
	this.A_REG = this.G_REG[Math.floor(this.X_REG)];
}

this.ARRAYSTORE_REAL = function() {
	this.G_REG[Math.floor(this.X_REG)] = this.Y_REG;
}

this.ARRAYSTORE_INTEGER = function() {
	this.G_REG[Math.floor(this.X_REG)] = Math.floor(this.Y_REG);
}

this.ARRAYSTORE_STRING = function() {
	this.G_REG[Math.floor(this.X_REG)] = this.A_REG;
}

this.STR = function() {
	this.A_REG=this.Y_REG.toString(10);
}

this.VAL = function() {
	this.X_REG=parseInt(this.B_REG.replace(/ /g,""), 10);
}

this.LEN = function() {
	this.X_REG=this.B_REG.length;
}

this.CHR = function() {
	this.A_REG=String.fromCharCode(Math.floor(this.Y_REG));
}

this.ASC = function() {
	if (this.B_REG.length==0) {
		this.X_REG=0;
		return;
	}
	this.X_REG=this.B_REG.charCodeAt(0);
}

this.POS = function() {
	this.X_REG=this._line.length;
}

this.TAB = function() {
	var tb=Math.floor(this.Y_REG);
	tb-=this._line.length;
	for (var i=0;i<tb; i++) {
		this._line+=" ";
	}
}

this.SPC = function() {
	var tb=Math.floor(this.Y_REG);
	for (var i=0;i<tb; i++) {
		this._line+=" ";
	}
}

this.FRE = function() {
	this.X_REG=65535;
}

this.CONCAT = function() {
	this.A_REG=this.A_REG+this.B_REG;
}

this.COMPACT = function() {
	// Nothing to do in this context
}

this.STROUT = function() {
	this.out(this.A_REG);
}

this.REALOUT = function() {
	this.out(this.X_REG);
}

this.INTOUT = function() {
	this.out(this.X_REG);
}

this.CHECKCMD = function() {
	//
}

this.LINEBREAK = function() {
	this.out("\n");
}

this.TABOUT = function() {
	this.out("\t");
}

this.WRITETID = function(value) {
	var d = new Date();
	this._time = d.getTime();
	this._timeOffset = parseInt(value.substring(0, 2), 10) * 1000 * 60 * 60
			+ parseInt(value.substring(2, 4), 10) * 1000 * 60
			+ parseInt(value.substring(4, 6), 10) * 1000;
	
}

this.READTI = function() {
	var d = new Date();
	var t=d.getTime();
	t=Math.floor((t-this._time+this._timeOffset)/(1000.0/60.0));
	this.X_REG=t;
}

this.READTID = function() {
	var d = new Date();
	var t=d.getTime();
	t=(t-this._time+this._timeOffset);
	var h=Math.floor(t/(1000 * 60 * 60));
	var m=Math.floor((t-(h*(1000 * 60 * 60)))/(1000 * 60));
	var s=Math.floor((t-(h*(1000 * 60 * 60))-m*(1000 * 60))/1000);
	h=this.fill(h);
	m=this.fill(m);
	s=this.fill(s);
	this.A_REG= h+m+s;
}

this.fill = function(num) {
	num=num.toString(10);
	if (num.length==1) {
		num="0"+num;
	}
	return num;
}

this.READSTATUS = function() {
	return 0;
}

this.FINX = function() {
	throw new Error("Fast inc optimization not supported for target JS!");
}

this.FDEX = function() {
	throw new Error("Fast dec optimization not supported for target JS!");
}

this.FASTFOR = function() {
	throw new Error("Fast for optimization not supported for target JS!");
}

this.out = function(txt) {
	// console.log("["+txt+"]");
	if (txt.indexOf && txt.indexOf("\n") != -1) {
		this._line += txt;
		console.log(this._line);
		this._line = "";
	} else {
		this._line += txt;
	}
}