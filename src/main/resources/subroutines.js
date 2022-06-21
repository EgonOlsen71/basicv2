this.restart = false;
this.running = true;
this.keyPressed=null;
this.lineNumber = 0;
this.timeOut=0;
this.funcName = "PROGRAMSTART";
this.batchSize=500;
this.tmpy=0;
this.disk=new Disk(this);

function File() {
	this.name;
	this.content=new Array();
}

function FilePointer() {
	this.channel=0;
	this.file=null;
	this.position=0;
	this.disk=null;
	this.master=null;
	
	this.readString = function() {
		return this.readLine();
	}
	
	this.readLine = function() {
		var ret="";
		var content=this.file.content;
		for (var i=this.position; i<content.length; i++) {
			var c=content[i];
			this.position++;
			c=this.master.convert(c);
			if (c==',' || c==':' || c=='\n' || c=='\r') {
				if (c=='\n' && i<content.length-1 && content [i+1]=='\r') {
					this.position++;
				}
				if (c=='\r' && i<content.length-1 && content [i+1]=='\n') {
					this.position++;
				}
				if (i==content.length-1) {
					this.disk.flagError();
				}
				return ret;
			}
			ret=ret+c;
		}
		this.disk.flagError();
		return ret;
	}
}

function Disk(master) {
	this.files=new Array();
	this.openFiles=new Array();
	this.status=0;
	this.master=master;
	
	this.init = function() {
		this.status=0;
	}
	
	this.getStatus = function() {
		return this.status;
	}
	
	this.flagError = function() {
		this.status=64;
	}
	
	this.get = function(channel) {
		for (var i=0; i<this.openFiles.length; i++) {
			var file=this.openFiles[i];
			if (file.channel==channel) {
				return file;
			}
		}
		console.log("Channel "+channel+" not open");
		return null;
	}
	
	this.open = function(channel, device, subAddr, name) {
		this.close(channel);
		
		name=name.toLowerCase();
		var parts=name.split(",");
		var type="s";
		var mode="r";
		if (parts.length>1) {
			name=parts[0];
			if (parts.length==1) {
				mode=parts[1];
			}
			if (parts.length==2) {
				mode=parts[2];
				type=parts[1];
			}
			if (mode.length>1) {
				mode=mode.substring(0,1);
			}
		}
		if (subAddr==0) {
			mode="r";
		}
		if (subAddr==1) {
			mode="w";
		}
		
		var found=null;
		for (var i=0; i<this.files.length; i++) {
			var file=this.files[i];
			if (file.name==name) {
				found=file;
				break;
			}
		}
		
		this.init();
		
		if (!found) {
			found=new File();
			found.name=name;
			
			if (mode=="r") {
				var xhr = new XMLHttpRequest();
				console.log("grabbing file "+name);
				xhr.open('GET', name, false);
				xhr.overrideMimeType("text/plain; charset=x-user-defined");
				xhr.onload = function() {
				    if (xhr.status === 200) {
				        found.content=xhr.responseText.split('');
				        //console.log("debug: "+xhr.responseText);
				        console.log("file "+name+" loaded from remote");
				    }
				    else {
				    	console.log("file "+name+" not found");
				        found.content=new Array();
				    }
				};
				xhr.send();
			}
			
			this.files.push(found);
		}
		
		if (mode=="w") {
			found.content=new Array();
			console.log("emtpy file "+name+" created");
		}
		
		console.log("file "+name+" opened");
		var pointer=new FilePointer();
		pointer.file=found;
		pointer.channel=channel;
		pointer.position=0;
		pointer.disk=this;
		pointer.master=this.master;
		this.openFiles.push(pointer);
	}
	
	this.close = function(channel) {
		this.init();
		for (var i=0; i<this.openFiles.length; i++) {
			var file=this.openFiles[i];
			if (file.channel==channel) {
				console.log("closed channel "+channel+"/"+file.file.name);
				this.openFiles.splice(i, 1);
				break;
			}
		}
	}
}

this.getMemory = function() {
	return this._memory;
}

this.registerKey= function(key) {
	var k=key[1];
	var ctx=this;
	if (k.length>1) {
		k=String.fromCharCode(key[2]);
	}
	if (key[0]) {
		this.keyPressed=k;
		this._memory[198]=1;
		self.setTimeout(function() {
			ctx.keyPressed=null;
			ctx._memory[198]=0;
		}, 200);
	} else {
		this.keyPressed=null;
		this._memory[198]=0;
	}
}

this.execute = function(threaded) {
	if (!threaded) {
		do  {
			this.reinit();
			while (this.running) {
				this.executeLine(threaded);
			}
		} while(this.restart);
	} else {
		this.reinit();
		this.executeThreaded();
	}
}

this.executeThreaded = function() {
	var cnt=0;
	do {
		if (this.restart) {
			this.reinit();
		}
		this.executeLine(true);
	} while(this.running && cnt++<this.batchSize);
	if (this.running) {
		var ctx=this;
		self.setTimeout(function() {
			ctx.executeThreaded();
		}, this.timeOut);
		this.timeOut=0;
	}
}

this.reinit = function() {
	this.lineNumber = 0;
	this.funcName = "PROGRAMSTART";
	this.restart=false;
	this.running=true;
}

this.executeLine = function(threaded) {
	var nextLine = this[this.funcName]();
	if (nextLine != null) {
		this.lineNumber = nextLine;
		if (this.lineNumber == "($JUMP)") {
			this.lineNumber = this.JUMP_TARGET;
		}
		if (Number.isInteger(this.lineNumber)) {
			this.funcName = "line_" + this.lineNumber;
		} else {
			this.funcName = this.lineNumber;
		}
	} else {
		this.running = false;
	}
	if (threaded) {
		_self.postMessage(this.funcName);
	}
}

this.START = function() {
	this.INIT();
	if (!Array.prototype.fill) {
		for (var i=0; i<this._memory.length; i++) {
			this._memory[i]=0;
		}
	} else {
		this._memory.fill(0);
	}
	this._memory[646]=14;
}

this.RUN = function() {
	this.running=false;
	this.restart=true;
}

this.RESTARTPRG = function() {
	// This is not correct behaviour as BASIC does it, because it doesn't preserve the variables, but...who cares?
	this.running=false;
	this.restart=true;
}

this.END = function() {
	//
}

this.CLEARQUEUE = function() {
	this._inputQueue=new Array();
}

this.QUEUESIZE = function() {
	this.X_REG=this._inputQueue.length;
}

this.EXTRAIGNORED = function() {
	out("?extra ignored!");
}

this.INPUTNUMBER = function() {
	var inp=this.input();
	if (this.isNumeric(inp)) {
		this.Y_REG=parseFloat(inp);
		this.X_REG=0;
	} else {
		this.X_REG=-1;
	}
}

this.INPUTSTR = function() {
	var inp=this.input();
	this.A_REG=inp;
}

this.GETSTR = function() {
	this.A_REG=this.get();
}

this.GETNUMBER = function() {
	this.Y_REG=0;
	var fk=this.get();
	if (fk && this.isNumeric(fk)) {
		this.Y_REG=parseFloat(fk);
	} else {
		out("?syntax error");
	}
}

this.isNumeric = function(num) {
	return !isNaN(parseFloat(num));
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

this.adjustStack = function(variable) {
	for (var i=this._forstack.length; i>0;) {
		var type = this._forstack[i-1];
		if (type==0) {
			return;
		}
		var stvar = this._forstack[i-2];
		var addr = this._forstack[i-3];
		var end = this._forstack[i-4];
		var step = this._forstack[i-5];
		i-=5;
		if (stvar==variable) {
			this._forstack=this._forstack.slice(0,i);
			return;
		}
	}
}

this.INITFOR = function(addr, variable) {
	this.adjustStack(variable);
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
	if ((step >= 0 && this[stvar] <= end) || (step < 0 && this[stvar] >= end)) {
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
	if (this.X_REG==null) {
		this.X_REG=0;
	}
}

this.ARRAYACCESS_INTEGER = function() {
	this.X_REG = this.G_REG[Math.floor(this.X_REG)];
	if (this.X_REG==null) {
		this.X_REG=0;
	}
	this.X_REG=Math.floor(this.X_REG);
}

this.ARRAYACCESS_STRING = function() {
	this.A_REG = this.G_REG[Math.floor(this.X_REG)];
	if (this.A_REG==null) {
		this.A_REG="";
	}
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
	this.X_REG=parseFloat((""+this.B_REG).replace(/ /g,""));
}

this.LEN = function() {
	if (this.B_REG==null) {
		this.B_REG="";
	}
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
	var cc=this.B_REG.charCodeAt(0);
	var c=this.B_REG.charAt(0);
	if (c>='a' && c<='z') {
		cc-=32;
	}
	this.X_REG=cc;
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

this.MID = function() {
	if (this.C_REG>this.B_REG.length) {
		this.A_REG="";
		return;
	}
	var end=this.C_REG-1+this.D_REG;
	if (this.D_REG===-1) {
		end=this.B_REG.length;
	}
	this.A_REG=this.B_REG.substring(this.C_REG-1, end);
}

this.LEFT = function() {
	if (this.C_REG>this.B_REG.length) {
		this.A_REG=this.B_REG;
		return;
	}
	if (this.C_REG===0) {
		this.A_REG="";
		return;
	}
	this.A_REG=this.B_REG.substring(0, this.C_REG);
}

this.RIGHT = function() {
	if (this.C_REG>this.B_REG.length) {
		this.A_REG=this.B_REG;
		return;
	}
	if (this.C_REG===0) {
		this.A_REG="";
		return;
	}
	this.A_REG=this.B_REG.substring(this.B_REG.length-this.C_REG);
}

this.SEQ = function() {
	this.X_REG=(this.A_REG===this.B_REG?-1:0);
}

this.SNEQ = function() {
	this.X_REG=(this.A_REG===this.B_REG?0:-1);
}

this.SGT = function() {
	this.X_REG=(this.A_REG>this.B_REG?-1:0);
}

this.SLT = function() {
	this.X_REG=(this.A_REG<this.B_REG?-1:0);
}

this.SGTEQ = function() {
	this.X_REG=(this.A_REG>=this.B_REG?-1:0);
}

this.SLTEQ = function() {
	this.X_REG=(this.A_REG<=this.B_REG?-1:0);
}

this.COMPACT = function() {
	// Nothing to do in this context
}

this.COMPACTMAX = function() {
	// Nothing to do in this context
}

this.SYSTEMCALLDYN = function() {
	// Nothing to do in this context
}

this.SETUPMULTIPARS = function() {
	// Nothing to do in this context
}

this.COPYSTRINGPAR = function() {
	// Nothing to do in this context
}

this.COPYREALPAR = function() {
	// Nothing to do in this context
}

this.ADDCOLON = function() {
	// Nothing to do in this context
}

this.PULLDOWNMULTIPARS = function() {
	// Nothing to do in this context
}

this.STROUT = function() {
	this.out(this.A_REG);
}

this.QMARKOUT1 = function() {
	this.out("?");
}

this.CRSRRIGHT = function() {
	this.out(" ");
}

this.QMARKOUT2 = function() {
	this.out("??");
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
	//console.log("ti: "+t+"/"+this._time+"/"+this._timeOffset+"/"+(t-this._time+this._timeOffset));
	this.tmpy=t;
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
	this.tmpy= h+m+s;
}

this.fill = function(num) {
	num=num.toString(10);
	if (num.length==1) {
		num="0"+num;
	}
	return num;
}

this.READSTATUS = function() {
	this.tmpy= this.disk.getStatus();
}

this.RESTORE = function() {
	this._dataPtr=0;
}

this.READSTR = function() {
	this.A_REG=this._datas[this._dataPtr++];
}

this.READNUMBER = function() {
	var n=this._datas[this._dataPtr++];
	if (n=="" || n==".") {
		n=0;
	}
	this.Y_REG=n;
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

this.OPEN = function() {
	this.disk.open(this.X_REG, this.C_REG, this.D_REG, this.B_REG);
}

this.CLOSE = function() {
	this.disk.close(this.X_REG);
}

this.CMD = function() {
	console.log("[CMD not supported for JS, call ignored: "+this.X_REG+"]");
}

this.STROUTCHANNEL = function() {
	console.log("[PRINT# not supported for JS, redirected to normal PRINT]");
	this.STROUT();
}

this.REALOUTCHANNEL = function() {
	console.log("[PRINT# not supported for JS, redirected to normal PRINT]");
	this.REALOUT();
}

this.LINEBREAKCHANNEL = function() {
	console.log("[PRINT# not supported for JS, redirected to normal PRINT]");
	this.LINEBREAK();
}

this.INTOUTCHANNEL = function() {
	console.log("[PRINT# not supported for JS, redirected to normal PRINT]");
	this.INTOUT();
}

this.INPUTNUMBERCHANNEL = function() {
	var fp=this.disk.get(this.C_REG);
	var inp=fp.readString();
	if (this.isNumeric(inp)) {
		this.Y_REG=parseFloat(inp);
		this.X_REG=0;
	} else {
		this.X_REG=-1;
	}
}

this.INPUTSTRCHANNEL = function() {
	var fp=this.disk.get(this.C_REG);
	this.A_REG=fp.readString();
}

this.GETSTRCHANNEL = function() {
	console.log("[GET# not supported for JS, call ignored]");
	this.A_REG="";
}

this.GETNUMBERCHANNEL = function() {
	console.log("[GET# not supported for JS, call ignored]");
	this.X_REG=0;
}

this.TABOUTCHANNEL = function() {
	console.log("[TAB not supported for JS in file mode, redirected to normal TAB]");
	this.TAB();
}

this.SPCOUTCHANNEL = function() {
	console.log("[SPC not supported for JS in file mode, redirected to normal SPC]");
	this.SPC();
}

this.TABCHANNEL = function() {
	console.log("[TAB not supported for JS in file mode, redirected to normal TAB]");
	this.TAB();
}

this.SPCCHANNEL = function() {
	console.log("[SPC not supported for JS in file mode, redirected to normal SPC]");
	this.SPC();
}

this.LOAD = function() {
	console.log("[LOAD not supported for JS in file mode, call ignored]");
}

this.SAVE = function() {
	console.log("[SAVE not supported for JS in file mode, call ignored]");
}

this.VERIFY = function() {
	console.log("[VERIFY not supported for JS in file mode, call ignored]");
}

this.REM = function() {
	console.log("[inline assembly ignored]");
}

this.USR = function() {
	var addr=this._memory[785] + 256*this._memory[786];
	this.USR_PARAM=this.X_REG;
	var callStr="$"+addr.toString(16);
	console.log("[Calling user function named "+callStr+"]");
	try {
		this[callStr]();
	} catch(e) {
		console.log("[Function call failed]");
	}
}

// Here start the input/output code, that might be adopted to fit ones needs...

this.input = function() {
	if (this._inputQueue.length>0) {
		return this._inputQueue.pop();
	}
	var inp=prompt(this._line);
	this._line="";
	if (inp) {
		var parts=inp.split(",");
		parts.reverse();
		this._inputQueue.push.apply(this._inputQueue, parts);
		return this._inputQueue.pop();
	} else {
		return "";
	}
}

// GET relies on INPUT here, because due to the single threaded nature of 
// Javascript, the concept of a BASIC program constantly polling the keyboard
// doesn't really work in this context unless you stuff the compiled program
// into a web worker or something like that.
this.get = function() {
	var key=this.input();
	if (!key) {
		return ""
	}
	return key.substring(0,1);
}

this.out = function(txt) {
	if (txt.indexOf && txt.indexOf("\n") != -1) {
		this._line += txt;
		this.outputter(this._line);
		this._line = "";
	} else {
		this._line += txt;
	}
}

this.convert = function(c) {
	return c;
}