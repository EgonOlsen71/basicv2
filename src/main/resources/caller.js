<html>
<head>
<script id='_compiledCode' src='{*}' type='text/javascript'></script>
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

// Default, not a web worker and output into the console
window.onload=function() {new Compiled().execute();}
</script>
</head><body><pre id='out'></pre></body>
</html>