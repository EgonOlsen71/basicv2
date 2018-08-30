
var _self=self;

if (self) {
	self.addEventListener('message', function(e) {
	  if(e.data=="run") {
		new Compiled().execute(true);
	  }
	}, false);
}

function executeAsync(srcFile, func) {
	var worker=new Worker(srcFile);
	worker.addEventListener('message', func, false);
	worker.postMessage("run");
}
