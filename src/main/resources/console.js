function CbmConsoleClient(elem) {	
	this.width=40;
	this.height=25;
	this.elem=elem;
	this.colors = ['#000000', '#FFFFFF', '#813338', '#75CEC8', '#8E3C97', '#56AC4D', '#2E2C9B', '#EDF171', '#8E5029', '#553800', '#C46C71', '#4A4A4A', '#7B7B7B', '#A9FF9F', '#706DEB', '#B2B2B2'];
	
	var _self=this;
	var lastColor=null;
	
	this.getHtml = function(pos, charCode, colorCode) {
		var c=String.fromCharCode(charCode);
		if (charCode==32) {
			c="&nbsp;";
		}
		if (lastColor!=colorCode) {
			c="<span style='color:"+_self.colors[colorCode]+"'>"+c;
			lastColor=colorCode;
		}
		if ((pos+1) % _self.width==0) {
			c+="<br/>";
		}
		return c;
	}	
	
	this.render = function(vidMem, colMem, bgColor) {
		var html="";
		elem.style.backgroundColor=_self.colors[bgColor];
		lastColor=null;
		for (var i=0; i<_self.width*_self.height; i++) {
			html=html+_self.getHtml(i, vidMem[i], colMem[i]);
		}
		elem.innerHTML=html+"</span>";
	}

}