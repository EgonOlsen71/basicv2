<html>
<head>
<meta charset="UTF-8">
<style>
@font-face { font-family: 'petscii';
             src: url('CommodoreServer.ttf') format('truetype'); }
			 
.con {
	font-family:petscii;
}			 
</style>
<script id='_compiledCode' src='{*}' type='text/javascript'></script>
<script id='_console' src='console.js' type='text/javascript'></script>
<script type='text/javascript'>
var preout=function(txt) {document.getElementById('out').insertAdjacentHTML('beforeend',txt);};

// Use this to execute the code with output redirected into the pre-tag
//window.onload=function() {new Compiled(preout).execute();}

/*
// Use this to execute the code in a web worker
window.onload=function() {
	executeAsync(document.getElementById('_compiledCode').src, function(e) {
		console.log(e.data);
	});
}
*/

/*
// Use this to execute it in an onscreen, C64 like console with basic support for PETSCII
window.onload=function() {
	var clientCon=new CbmConsoleClient(document.getElementById("con"));
	var worker=executeAsync(document.getElementById('_compiledCode').src, function(e) {
		if (Array.isArray(e.data)) {
			clientCon.render(e.data[0], e.data[1], e.data[2]);
		}		
	}, document.getElementById('con'));
	var el=document.getElementById('con');
	el.onkeypress = function(event) {
		worker.postMessage([true, event.key, event.which]);
	};
	el.focus();
}
*/

// Default, not a web worker and output into the console
window.onload=function() {new Compiled().execute();}
</script>
</head><body><pre id='out'></pre><div tabindex="0" id="con" class="con"></div></body>
</html>