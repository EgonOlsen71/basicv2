var _self=self;
var instance=null;
var conInstance=null;


if (self) {
	self.addEventListener('message', function(e) {
	  if (instance) {
			instance.registerKey(e.data);
	  } else {
		  instance=new Compiled();
		  if(e.data=="run") {
			  instance.execute(true);
		  } else {
			  var comp=instance;
			  var cons=new CbmConsole();
			  conInstance=cons;
			  cons.inject(comp, e.data);
			  comp.execute(true);
		  }
	  }
	}, false);
}

function executeAsync(srcFile, func, cons) {
	var worker=new Worker(srcFile);
	worker.addEventListener('message', func, false);
	if (cons) {
		worker.postMessage("console");
	} else {
		worker.postMessage("run");
	}
	return worker;
}

function CbmConsole() {	
	this.x=0;
	this.y=0;
	this.width=40;
	this.height=25;
	this.vidMem=new Array(1000);
	this.colMem=new Array(1000);
	this.memory=null;
	this.bgColor=6;
	this.fontColor=14;
	this.map = {};
	this.charset=null;
	this.graphicsMode=true;
	this.reverseMode=false;
	this.compiledCode=null;
	
	var _selfy=this;
	
	this.getPokeValue = function(ch) {
		if (Number.isInteger(ch)) {
			ch=String.fromCharCode(ch);
		}
		return _selfy.charset.charCodeAt(_selfy.getConvertedChar(ch)+(_selfy.graphicsMode?0:256));		
	}
	
	this.clearScreen = function() {
		if (_selfy.compiledCode) {
			_selfy.memory = _selfy.compiledCode.getMemory();
			for (var i=0; i<_selfy.width*_selfy.height; i++) {
				_selfy.memory[1024+i]=32;
				_selfy.memory[55296+i]=_selfy.fontColor;
				_selfy.x=0;
				_selfy.y=0;
			}
		}
	}
	
	this.shiftRight = function(pos) {
		var offset = pos;
		var end = _selfy.y * _selfy.width + (((_selfy.y & 1) == 1) ? (_selfy.width-1) : (2*_selfy.width-1));
		_selfy.memory = _selfy.compiledCode.getMemory();
		if (_selfy.memory[1024+end] != 32) {
			return;
		}
		for (var i = end; i > offset; i--) {
			_selfy.memory[1024+i] = _selfy.memory[1024+i - 1];
			_selfy.memory[55296+i] = _selfy.memory[55296+i - 1];
		}
		_selfy.memory[1024+offset]=_selfy.getPokeValue(32);
		_selfy.memory[55296+offset]=_selfy.fontColor;
	}
	
	this.processControlCode = function(code, pos, withSpc) {
		_selfy.memory = _selfy.compiledCode.getMemory();
		var col=_selfy.memory[646];
		
		if (withSpc && code==32) {
			if (_selfy.reverseMode) {
				_selfy.setAtCursor(pos);
			} else {
				_selfy.clearAtCursor(pos);
			}
			_selfy.x++;
		}
		else {
			switch(code) {
				case 147:
					_selfy.clearScreen();
					_selfy.x=0;
					_selfy.y=0;
					break;
				case 19:
					_selfy.x=0;
					_selfy.y=0;
					break;
				case 29:
					_selfy.x++;
					break;
				case 157:
					_selfy.x--;
					break;
				case 17:
					_selfy.y++;
					break;
				case 145:
					_selfy.y--;
					break;
				case 144:
					col = 0;
					break;
				case 5:
					col = 1;
					break;
				case 28:
					col = 2;
					break;
				case 159:
					col = 3;
					break;
				case 156:
					col = 4;
					break;
				case 30:
					col = 5;
					break;
				case 31:
					col = 6;
					break;
				case 158:
					col = 7;
					break;
				case 129:
					col = 8;
					break;
				case 149:
					col = 9;
					break;
				case 150:
					col = 10;
					break;
				case 151:
					col = 11;
					break;
				case 152:
					col = 12;
					break;
				case 153:
					col = 13;
					break;
				case 154:
					col = 14;
					break;
				case 155:
					col = 15;
					break;
				case 18:
					_selfy.reverseMode = true;
					break;
				case 146:
					_selfy.reverseMode = false;
					break;
				case 20:
					_selfy.x--;
					_selfy.clearAtCursor(pos);
					break;
				case 148:
					_selfy.shiftRight(pos);
					_selfy.clearAtCursor(pos);
					break;
				case 13:
					_selfy.reverseMode = false;
					_selfy.y++;
					break;
				case 14:
					_selfy.graphicsMode=false;
					break;
				case 142:
					_selfy.graphicsMode=true;
					break;
				default:
					_selfy.memory[1024+pos]=_selfy.getPokeValue(String.fromCharCode(code));
					_selfy.memory[55296+pos]=_selfy.fontColor;
					_selfy.x++;
					break;
				}
			}	
			
			if (col!=-1) {
				_selfy.fontColor=col;
				_selfy.compiledCode.getMemory()[646]=col;
			}
	}
	
	this.clearAtCursor = function(pos) {
		_selfy.memory = _selfy.compiledCode.getMemory();
		_selfy.memory[1024+pos]=_selfy.getPokeValue(32);
		_selfy.memory[55296+pos]=_selfy.fontColor;
		_selfy.x++;
	}
	
	this.setAtCursor = function(pos) {
		_selfy.memory = _selfy.compiledCode.getMemory();
		_selfy.memory[1024+pos]=_selfy.getPokeValue(160);
		_selfy.memory[55296+pos]=_selfy.fontColor;
		_selfy.x++;
	}
	
	this.inject = function(compiledCode, conElem) {
		_selfy.memory = compiledCode.getMemory();
		compiledCode.superOut=compiledCode.out;
		_selfy.con=conElem;
		_selfy.memory = compiledCode._memory;
		
		_selfy.fillMap();
		_selfy.charset=_selfy.createCharsetMapping();
		_selfy.compiledCode=compiledCode;
		
		compiledCode.convert = function(c) {
			if (c >= 'a' && c <= 'z') {
				c = String.fromCharCode(c.charCodeAt(0) - 32);
			} else if (c >= 'A' && c <= 'Z') {
				c = String.fromCharCode(c.charCodeAt(0) + 32);
			}
			return c;
		}
		
		compiledCode.out = function(val) {
			_selfy.memory = compiledCode.getMemory();
			if (val==null) {
				return;
			}
			val=""+val;
			for(var i=0; i<val.length; i++) {
				var c=val.charAt(i);
				var pos=_selfy.x+_selfy.width*_selfy.y;
				
				var col=_selfy.compiledCode.getMemory()[646];
				_selfy.fontColor=col;
				
				if (c=='{') {
					var end=val.indexOf('}', i);
					if (end!=-1) {
						var subs=val.substring(i,end+1);
						i=end;
						var code=_selfy.getCode(subs);
						if (code!=-1) {
							_selfy.processControlCode(code, pos, true);
						}
						continue;
					}	
				}
				if (_selfy.isChar(c)) {
					_selfy.processControlCode(c.charCodeAt(0), pos, false);
				} else {
					if (_selfy.isBreak(c)) {
						_selfy.x=0;
						_selfy.y++;
						_selfy.reverseMode = false;
					}
				}
				if (_selfy.x==_selfy.width) {
					_selfy.x=0;
					_selfy.y++;
				}
				
				if (_selfy.y>=_selfy.height) {
					_selfy.y=_selfy.height-1;
					for (var p=_selfy.width;p<_selfy.width*_selfy.height;p++) {
						_selfy.memory[1024+p-_selfy.width]=_selfy.memory[1024+p];
						_selfy.memory[55296+p-_selfy.width]=_selfy.memory[55296+p];
					}
					for (var p=_selfy.width*(_selfy.height-1);p<_selfy.width*_selfy.height;p++) {
						_selfy.memory[1024+p]=32;
						_selfy.memory[55296+p]=_selfy.fontColor;
					}
				} 
			}
			
			if (_selfy.memory) {
				_selfy.vidMem = _selfy.memory.slice(1024, 2024);
				_selfy.colMem = _selfy.memory.slice(55296, 56296);
				_selfy.bgColor = _selfy.memory[53281];
			}
			_self.postMessage([_selfy.vidMem, _selfy.colMem, _selfy.bgColor]);
		};
		
		compiledCode.get = function() {
			var key=this.keyPressed;
			if (!key) {
				return ""
			}
			this.timeOut=20;
			this.keyPressed=null;
			this._memory[198]=0;
			return key.substring(0,1);
		};
	}
	
	this.isChar = function(c) {
		return c!="\r" && c!="\n";
	}
	
	this.isBreak = function(c) {
		return c=="\r" || c=="\n";
	}
	
	this.getConvertedChar = function(c) {
		if (c >= 'a' && c <= 'z') {
			c = c.charCodeAt(0) - 96;
		//} else if (c >= 'A' && c <= 'Z') {
		//	c = c.charCodeAt(0) + 32;
		} else {
			c=c.charCodeAt(0);
		}
		c+=(_selfy.reverseMode?128:0);
		return c;
	}
	
	this.setCharAt = function(str, index, replacement) {
		return str.substr(0, index) + replacement+ str.substr(index + replacement.length);
	}
	
	this.createCharsetMapping = function() {
		var sb="";
		sb+="@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_ !\"#$%&'()*+,-./0123456789:;<=>?`abcdefghijklmnopqrstuvwxyz{|}~";
		sb+=" ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿";
		sb+="ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ";
		for (var i = 0; i < 32; i++) {
			sb+=String.fromCharCode(i + 128);
		}
		sb+=String.fromCharCode(224);
		for (var i = 0; i < 31; i++) {
			sb+=String.fromCharCode(i + 256);
		}

		sb+="@";
		for (var i = 0; i < 26; i++) {
			sb+=String.fromCharCode(i + 287);
		}
		sb+="[\\]^_ !\"#$%&'()*+,-./0123456789:;<=>?`";
		sb+="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		sb+="{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿À";
		for (var i = 0; i < 26; i++) {
			sb+=String.fromCharCode(i + 313);
		}
		sb+="ÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ";
		sb+=String.fromCharCode(128);
		sb+="ÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚ";

		for (var i = 27; i < 32; i++) {
			sb+=String.fromCharCode(i + 128);
		}
		sb+=String.fromCharCode(224);
		for (var i = 0; i < 31; i++) {
			sb+=String.fromCharCode(i + 256);
		}

		_selfy.setCharAt(sb, 94 + 256, 'ą');
		_selfy.setCharAt(sb,95 + 256, 'œ');
		_selfy.setCharAt(sb,105 + 256, 'ŕ');
		_selfy.setCharAt(sb,122 + 256, '');

		_selfy.setCharAt(sb,94 + 128 + 256, '¦');
		_selfy.setCharAt(sb,95 + 128 + 256, '');
		_selfy.setCharAt(sb,105 + 128 + 256, 'ŕ');
		_selfy.setCharAt(sb,122 + 128 + 256, '');
		return sb;
	}
	
	this.getCode = function(placeHolder) {
		placeHolder = placeHolder.replace("{", "").replace("}", "").toLowerCase().trim();
		if (_selfy.map[placeHolder]) {
			return _selfy.map[placeHolder];
		}
		return -1;
	}
	
	this.fillMap = function() {
		_selfy.add(32, "space");
		_selfy.add(144, "black", "blk", "ctrl-1");
		_selfy.add(5, "white", "wht", "ctrl-2", "ctrl-e");
		_selfy.add(28, "red", "ctrl-3", "ctrl-pound", "ctrl-£");
		_selfy.add(159, "cyan", "cyn", "ctrl-4");
		_selfy.add(156, "purple", "pur", "pink", "cm-3");
		_selfy.add(30, "green", "grn", "ctrl-6", "ctrl-up arrow", "ctrl-↑");
		_selfy.add(31, "blue", "blu", "ctrl-7", "ctrl-=");
		_selfy.add(158, "yellow", "yel", "ctrl-8");
		_selfy.add(129, "orange", "orng", "orn", "cm-1");
		_selfy.add(149, "brown", "brn", "cm-2");
		_selfy.add(150, "light red", "lred");
		_selfy.add(151, "dark grey", "dark gray", "gry1", "cm-4");
		_selfy.add(152, "grey", "gray", "gry2", "cm-5");
		_selfy.add(153, "light green", "lgrn", "cm-6");
		_selfy.add(154, "light blue", "lblu", "cm-7");
		_selfy.add(155, "light grey", "light gray", "gry3", "cm-8");
		_selfy.add(18, "reverse on", "rvon", "rvson", "ctrl-r", "ctrl-9");
		_selfy.add(146, "reverse off", "rvof", "rvsoff", "ctrl-0");
		_selfy.add(17, "cursor down", "down", "ctrl-q");
		_selfy.add(145, "cursor up", "up", "shift-cursor down", "shift-down", "sh-cursor down", "sh-down");
		_selfy.add(157, "cursor left", "left", "shift-cursor-right", "shift-right", "sh-cursor-right", "sh-right");
		_selfy.add(29, "cursor right", "rght", "right", "ctrl-;");
		_selfy.add(20, "del", "delete", "ctrl-t");
		_selfy.add(14, "ctrl-n");
		_selfy.add(13, "return", "ret", "ctrl-m");
		_selfy.add(148, "insert", "inst", "shift-delete", "sh-delete", "shift-del", "sh-del");
		_selfy.add(147, "clear", "clr", "shift-home", "sh-home", "clr/home");
		_selfy.add(19, "home", "ctrl-s");
		_selfy.add(133, "f1");
		_selfy.add(134, "f3");
		_selfy.add(135, "f5");
		_selfy.add(136, "f7");
		_selfy.add(8, "ctrl-h");
		_selfy.add(9, "ctrl-i");
		_selfy.add(14, "ctrl+n", "ctrl-n");
		_selfy.add(142, "ctrl+/", "ctrl-/");
		_selfy.add(165, "ctrl-g");
		_selfy.add(137, "f2", "shift-f1", "sh-f1");
		_selfy.add(138, "f4", "shift-f3", "sh-f3");
		_selfy.add(139, "f6", "shift-f5", "sh-f5");
		_selfy.add(140, "f8", "shift-f7", "sh-f7");
		_selfy.add(92, "pound", "£");
		_selfy.add(160, "shift-space", "sh-space");
		_selfy.add(33, "shift-1", "sh-1");
		_selfy.add(34, "shift-2", "sh-2");
		_selfy.add(35, "shift-3", "sh-3");
		_selfy.add(36, "shift-4", "sh-4");
		_selfy.add(37, "shift-5", "sh-5");
		_selfy.add(38, "shift-6", "sh-6");
		_selfy.add(39, "shift-7", "sh-7");
		_selfy.add(40, "shift-8", "sh-8");
		_selfy.add(41, "shift-9", "sh-9");
		_selfy.add(42, "*", "asterisk");
		_selfy.add(43, "+", "plus");
		_selfy.add(44, ",", "comma");
		_selfy.add(45, "-", "minus");
		_selfy.add(46, ".", "period");
		_selfy.add(47, "/", "slash");
		_selfy.add(58, ":", "colon");
		_selfy.add(59, ";", "semicolon");
		_selfy.add(60, "shift-comma", "shift-,", "sh-comma", "sh-,");
		_selfy.add(61, "equal", "equals", "eq", "=");
		_selfy.add(62, "shift-period", "shift-.", "sh-period", "sh-.");
		_selfy.add(63, "shift-slash", "shift-/", "sh-slash", "sh-/");
		_selfy.add(64, "@", "at");
		_selfy.add(91, "shift-colon", "shift-:", "sh-colon", "sh-:");
		_selfy.add(93, "shift-semicolon", "shift-;", "sh-semicolon", "sh-;");
		_selfy.add(94, "↑", "^", "up arrow");
		_selfy.add(95, "←", "left arrow");
		_selfy.add(141, "shift-return", "sh-return", "shift-ret", "sh-ret");
		_selfy.add(161, "cm-k");
		_selfy.add(162, "cm-i");
		_selfy.add(163, "cm-t");
		_selfy.add(164, "cm-@", "cm-at");
		_selfy.add(165, "cm-g");
		_selfy.add(166, "cm-+", "cm-plus");
		_selfy.add(167, "cm-m");
		_selfy.add(168, "cm-£", "cm-pound");
		_selfy.add(169, "shift-£", "shift-pound", "sh-£", "sh-pound");
		_selfy.add(170, "cm-n");
		_selfy.add(171, "cm-q");
		_selfy.add(172, "cm-d");
		_selfy.add(173, "cm-z");
		_selfy.add(174, "cm-s");
		_selfy.add(175, "cm-p");
		_selfy.add(176, "cm-a");
		_selfy.add(177, "cm-e");
		_selfy.add(178, "cm-r");
		_selfy.add(179, "cm-w");
		_selfy.add(180, "cm-h");
		_selfy.add(181, "cm-j");
		_selfy.add(182, "cm-l");
		_selfy.add(183, "cm-y");
		_selfy.add(184, "cm-u");
		_selfy.add(185, "cm-o");
		_selfy.add(186, "shift-@", "shift-at", "sh-@", "sh-at");
		_selfy.add(187, "cm-f");
		_selfy.add(188, "cm-c");
		_selfy.add(189, "cm-x");
		_selfy.add(190, "cm-v");
		_selfy.add(191, "cm-b");
		_selfy.add(192, "shift-*", "shift-asterisk", "sh-*", "sh-asterisk");
		_selfy.add(219, "shift-+", "shift-plus", "sh-+", "sh-plus");
		_selfy.add(220, "cm--", "cm-minus");
		_selfy.add(221, "shift--", "shift-minus", "sh--", "sh-minus");
		_selfy.add(222, "shift-↑", "shift-up arrow", "sh-↑", "sh-up arrow");
		_selfy.add(223, "cm-*", "cm-asterisk");

		for (var i = 65; i < 91; i++) {
			var c = String.fromCharCode(i - 65 + 97);
			_selfy.add(i, "shift-" + c, "sh-" + c);
		}
	}
	
	this.add = function() {
		var code=arguments[0];
		for (var i = 1; i < arguments.length; i++) {
			var placy=arguments[i];
			_selfy.map[placy]=code;
			_selfy.map[placy.replace("ctrl", "ct")]=code;
			_selfy.map[placy.replace("ctrl", "control")]=code;
			_selfy.map[placy.replace("-", " ")]=code;
			_selfy.map[placy.replace("ctrl", "ct").replace("-", " ")]=code;
			_selfy.map[placy.replace("ctrl", "control").replace("-", " ")]=code;
		} 
	}
	
	_selfy.clearScreen();
}
