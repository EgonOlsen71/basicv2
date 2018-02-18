num1lo = $62
num1hi = $63
num2lo = $64
num2hi = $65
resultlo = $66
resulthi = $67

*=$c000
add	clc				; clear carry
	lda num1lo
	adc num2lo
	sta resultlo 			; store sum of LSBs
	lda num1hi
	adc num2hi			; add the MSBs using carry from
	sta resulthi 			; the previous calculation
	rts

*=$c100
sub	sec				; set carry for borrow purpose
	lda num1lo
	sbc num2lo			; perform subtraction on the LSBs
	sta resultlo 
	lda num1hi			; do the same for the MSBs, with carry
	sbc num2hi			; set according to the previous result
	sta resulthi 
	rts