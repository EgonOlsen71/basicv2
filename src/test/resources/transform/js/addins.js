// Put in global scope...

var canvas=document.getElementById("canvas").getContext("2d");
var id = canvas.createImageData(1,1);
var d = id.data;



// Put as object method

this.$c000 = function() {
	d[0] = this.VAR_CR;
	d[1] = this.VAR_CG;
	d[2] = this.VAR_CB;
	d[3] = 255;
	canvas.putImageData(id, this.VAR_I, this.VAR_J);
}