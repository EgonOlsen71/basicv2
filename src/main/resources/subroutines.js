function execute() {
	var lineNumber=0;
	var running=true;
	var funcName="PROGRAMSTART";
	while(running) {
		var nextLine=this[funcName]();
		if (nextLine!=null) {
			lineNumber=nextLine;
			funcName="line_"+lineNumber;
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