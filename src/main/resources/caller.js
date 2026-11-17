<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<style>
@font-face { font-family: 'petscii';
             src: url('CommodoreServer.ttf') format('truetype'); }
			 
.con {
	display:inline-block;
	position:relative;
	font-family:petscii, monospace;
	font-size:min(1rem, 2.3vw);
	line-height: 1.0;
	width:40ch;
	height:25em;
	white-space:nowrap;
	overflow:hidden;
}
.con.cursor-active::after {
	content:"";
	position:absolute;
	left:var(--cursor-left);
	top:var(--cursor-top);
	width:1ch;
	height:1em;
	background-color:var(--cursor-color);
	animation:cursor-blink 1s step-end infinite;
	pointer-events:none;
}
@keyframes cursor-blink {
	50% { opacity:0; }
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
			clientCon.render(e.data[0], e.data[1], e.data[2], e.data[3], e.data[4], e.data[5]);
		}		
	}, document.getElementById('con'));
	var el=document.getElementById('con');
	el.onkeydown = function(event) {
		if (event.key=="Backspace" || event.key=="Enter") {
			worker.postMessage([true, event.key, event.which || event.keyCode]);
			event.preventDefault();
		}
	};
	el.onkeypress = function(event) {
		if (event.key=="Backspace" || event.key=="Enter") {
			return;
		}
		worker.postMessage([true, event.key, event.which]);
		event.preventDefault();
	};
	el.focus();
}
*/

// Default, not a web worker and output into the console
window.onload=function() {new Compiled().execute();}
</script>
</head><body><pre id='out'></pre><div tabindex="0" id="con" class="con"></div></body>
</html>
