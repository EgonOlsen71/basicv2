$global:restart = $false
$global:running = $true
$global:keyPressed = $null 
$global:lineNumber = 0
$global:timeOut=0
$global:funcName = "PROGRAMSTART"
$global:tymp=0

function getMemory {
	return $global:_memory
}

function registerKey {
	$k = #$host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	if ($k -ne $null) {
		$global:keyPressed=$k
		$global:_memory[198]=1
	} else {
		$global:keyPressed=$null
		$global:_memory[198]=0
	}
}

function execute {
	do  {
		reinit
		while ($global:running) {
			executeLine
		}
	} while($global:restart)
}


function reinit {
	$global:lineNumber = 0
	$global:funcName = "PROGRAMSTART"
	$global:restart=$false
	$global:running=$true
}

function executeLine {
	$nextLine = invoke-expression $global:funcName.ToString()
	if ($nextLine -ne $null) {
		$lineNumber = $nextLine
		if ($lineNumber -eq "($JUMP)") {
			$lineNumber = $global:JUMP_TARGET
		}
		if (isNumber $lineNumber) {
			$global:funcName = "line_" + $lineNumber
		} else {
			$global:funcName = $lineNumber
		}
	} else {
		$global:running = $false
	}
}

function STARTPRG {
	INIT
	$global:_memory[646]=14
}

function RUN {
	$global:running=$false
	$global:restart=$true
}

function RESTARTPRG {
	$global:running=$false
	$global:restart=$true
}

function ENDPRG {
	#
}

function CLEARQUEUE {
	$global:_inputQueue=@()
}

function QUEUESIZE {
	$global:X_REG=$global:_inputQueue.length
}

function EXTRAIGNORED {
	out "?extra ignored!"
}

function INPUTNUMBER {
	$inp=input
	if (isNumber $inp) {
		$global:Y_REG=parseFloat $inp
		$global:X_REG=0
	} else {
		$global:X_REG=-1
	}
}

function INPUTSTR {
	$inp=input
	$global:A_REG=$inp
}

function GETSTR {
	$global:A_REG=get
}

function GETNUMBER {
	$global:Y_REG=0
	$fk=get
	if ($fk -and (isNumber $fk)) {
		$global:Y_REG=parseFloat $fk
	} else {
		out "?syntax error"
	}
}

function isNumber {
	param($num)
	return ($num -is [double]) -or ($num -is [single]) -or ($num -is [int]) -or ($num -is [long]) -or ($num -is [int32])
}

function isNaN {
	param($num)
	return ([System.Double]::IsNaN($num))
}

function isNumeric {
	param($num)
	return !isNaN (parseFloat $num)
}

function parseFloat {
	param($num)
	return ([double] $num)
}

function GOSUB {
	param($gosubCont)
	$global:_forstack+=$gosubCont
	$global:_forstack+=0
}

function pop {
	param($arr)
	$len=$arr.length-1
	if ($len -lt 0) {
    	throw "Stack underflow!"
	}
	$rv= $arr|select -First $len
	if ($rv -eq $null) {
		return ,@()
	}
	if ($rv -isnot [system.array]) {
		$rv=@($rv)
	}
	return ,$rv
}

function first {
	param($arr)
	$len=$arr.length-1
	return $arr[$len] 
}

function RETURN {
	$val = 0
	if ($global:_forstack.length -eq 0) {
		Throw "RETURN without GOSUB error!"
	}
	do {
		$val = first $global:_forstack
		$global:_forstack = pop $global:_forstack
		if ($val -eq 1) {
			$global:_forstack=pop $global:_forstack
			$global:_forstack=pop $global:_forstack
			$global:_forstack=pop $global:_forstack
			$global:_forstack=pop $global:_forstack
		}
	} while ($val -ne 0)
	$val = first $global:_forstack
	$global:_forstack=pop $global:_forstack
	return $val
}


function adjustStack {
	param($variable)
	$len=$global:_forstack.length
	
	for ($i=$len; $i -gt 0;) {
		$type=$global:_forstack[$i-1]
		if ($type -eq 0) {
			return
		}
		$vary = $global:_forstack[$i-2]
		$addr = $global:_forstack[$i-3]
		$end = $global:_forstack[$i-4]
		$step = $global:_forstack[$i-5]
		$i=$i-5
		if ($vary -eq $variable) {
			$global:_forstack=$global:_forstack[0..($i-1)]
			return
		}
	}
}

function INITFOR {
	param($addr, $variable)
	adjustStack $variable
	$val=first $global:_stack
	$global:_stack=pop $global:_stack
	$global:_forstack+=$val
	$val=first $global:_stack
	$global:_stack=pop $global:_stack
	$global:_forstack+=$val
	$global:_forstack+=$addr
	$global:_forstack+=$variable
	$global:_forstack+=1
}

function NEXT {
	param($variable)
	$found = $false
	do {
		if ($global:_forstack.length -eq 0) {
			Throw "NEXT without FOR error!"
		}
		$type=first $global:_forstack
		$global:_forstack=pop $global:_forstack
		if ($type -eq 0) {
			Throw "NEXT without FOR error!"
		}
		$stvar=first $global:_forstack
		$global:_forstack=pop $global:_forstack
		$addr=first $global:_forstack
		$global:_forstack=pop $global:_forstack
		$end=first $global:_forstack
		$global:_forstack=pop $global:_forstack
		$step=first $global:_forstack
		$global:_forstack=pop $global:_forstack
		$found = $variable -eq "0" -or $variable -eq $stvar
	} while (!$found)
	$vv="$"+"global:"+$stvar
	$vs=$vv
	$vv=$vv+"="+$vv+"+"+$step
	invoke-expression $vv
	$vv=invoke-expression $vs
	if (($step -ge 0 -and $vv -le $end) -or ($step -lt 0 -and $vv -ge $end)) {
		$global:_forstack+=$step
		$global:_forstack+=$end
		$global:_forstack+=$addr
		$global:_forstack+=$stvar
		$global:_forstack+=1
		$global:A_REG = 0
		$global:JUMP_TARGET = $addr
		return
	}
	$global:A_REG = 1
	return
}

function ARRAYACCESS_REAL {
	$global:X_REG = $global:G_REG[([math]::floor($global:X_REG))]
	if ($global:X_REG -eq $null) {
		$global:X_REG = 0
	}
}

function ARRAYACCESS_INTEGER {
	$global:X_REG = $global:G_REG[([math]::floor($global:X_REG))]
	if ($global:X_REG -eq $null) {
		$global:X_REG = 0
	}
	$global:X_REG=([math]::floor($global:X_REG))
}

function ARRAYACCESS_STRING {
	$global:A_REG = $global:G_REG[([math]::floor($global:X_REG))]
	if ($global:A_REG -eq $null) {
		$global:A_REG = ""
	}
}

function ARRAYSTORE_REAL {
	$global:G_REG[([math]::floor($global:X_REG))] = $global:Y_REG
}

function ARRAYSTORE_INTEGER {
	$global:G_REG[([math]::floor($global:X_REG))] = ([math]::floor($global:Y_REG))
}

function ARRAYSTORE_STRING {
	$global:G_REG[([math]::floor($global:X_REG))] = $global:A_REG
}

function STR {
	$global:A_REG=$global:Y_REG.toString()
}

function VAL {
	$global:X_REG=parseFloat ($global:B_REG -replace " ","")
}

function LEN {
	$global:X_REG=$global:B_REG.length
}

function CHR {
	$global:A_REG=[char][int]([math]::floor($global:Y_REG))
}

function ASC {
	if ($global:B_REG.length -eq 0) {
		$global:X_REG=0
		return
	}
	$cc=[int][char]$global:B_REG[0]
#	$c=[char]$global:B_REG[0]
#	if ($c -ge 'a' -and $c -le 'z') {
#		$cc-=32
#	}
	$global:X_REG=$cc
}

function POS {
	$global:X_REG=$global:_line.length
}

function TAB {
	$tb=([math]::floor($global:Y_REG))
	$tb-=$global:_line.length
	for ($i=0; $i -lt $tb; $i++) {
		$global:_line+=" "
	}
}

function SPC {
	$tb=([math]::floor($global:Y_REG))
	for ($i=0; $i -lt $tb; $i++) {
		$global:_line+=" "
	}
}

function FRE {
	$global:X_REG=65535
}

function CONCAT {
	$global:A_REG=$global:A_REG+$global:B_REG
}

function MID {
	if ($global:C_REG -gt $global:B_REG.length) {
		$global:A_REG=""
		return
	}
	$end=$global:C_REG-1 + $global:D_REG
	if ($global:D_REG -eq -1) {
		$end=$global:B_REG.length
	}
	$global:A_REG=$global:B_REG.SubString($global:C_REG-1, $end-($global:C_REG-1))
}

function LEFT {
	if ($global:C_REG -gt $global:B_REG.length) {
		$global:A_REG=$global:B_REG
		return
	}
	if ($global:C_REG -eq 0) {
		$global:A_REG=""
		return
	}
	$global:A_REG=$global:B_REG.SubString(0, $global:C_REG)
}

function RIGHT {
	if ($global:C_REG -gt $global:B_REG.length) {
		$global:A_REG=$global:B_REG
		return
	}
	if ($global:C_REG -eq 0) {
		$global:A_REG=""
		return
	}
	$global:A_REG=$global:B_REG.SubString($global:B_REG.length-$global:C_REG)
}

function SEQ {
	if ($global:A_REG -eq $global:B_REG) {$global:X_REG=-1} else {$global:X_REG=0}
}

function SNEQ {
	if ($global:A_REG -eq $global:B_REG) {$global:X_REG=0} else {$global:X_REG=-1}
}

function SGT {
	if ($global:A_REG -gt $global:B_REG) {$global:X_REG=-1} else {$global:X_REG=0}
}

function SLT {
	if ($global:A_REG -lt $global:B_REG) {$global:X_REG=-1} else {$global:X_REG=0}
}

function SGTEQ {
	if ($global:A_REG -ge $global:B_REG) {$global:X_REG=-1} else {$global:X_REG=0}
}

function SLTEQ {
	if ($global:A_REG -le $global:B_REG) {$global:X_REG=-1} else {$global:X_REG=0}
}

function COMPACT {
}

function COMPACTMAX {
}

function SYSTEMCALLDYN {
}

function APPENDSYSCHAR {
}

function INPUTLENGTHCHECK {
	$global:$_zeroflag=1
}

function SETUPMULTIPARS {
}

function COPYSTRINGPAR {
}

function COPYREALPAR {
}

function ADDCOLON {
}

function PULLDOWNMULTIPARS {
}

function STROUT {
	out $global:A_REG
}

function QMARKOUT1 {
	out "?"
}

function CRSRRIGHT {
	out " "
}

function QMARKOUT2 {
	out "??"
}

function REALOUT {
	out $global:X_REG
}

function INTOUT {
	out $global:X_REG
}

function CHECKCMD {
}

function LINEBREAK {
	out "`n"
}

function TABOUT {
	out "`t"
}

function millis {
	return ([math]::Round((Get-Date).ToFileTime() / 10000000 - 11644473600)*1000)
}

function WRITETID {
	param($value)
	$global:_time = millis
	$global:_timeOffset = [int]($value.SubString(0, 2)) * 1000 * 60 * 60 + [int]($value.SubString(2, 2)) * 1000 * 60 + [int]($value.SubString(4, 2)) * 1000
}

function READTI {
	$t=millis
	$t=([math]::floor(($t-$global:_time+$global:_timeOffset)/(1000.0/60.0)))
	$global:tmpy=$t
}

function READTID {
	$t=millis
	$t=($t-$global:_time+$global:_timeOffset)
	$h=([math]::floor($t/(1000 * 60 * 60)))
	$m=([math]::floor(($t-($h*(1000 * 60 * 60)))/(1000 * 60)))
	$s=([math]::floor(($t-($h*(1000 * 60 * 60))-$m*(1000 * 60))/1000))
	$h=fill $h
	$m=fill $m
	$s=fill $s
	$global:tmpy= $h+$m+$s
}

function fill {
	param($num)
	$num=$num.ToString()
	if ($num.length -eq 1) {
		$num="0"+$num
	}
	return $num
}

function READSTATUS {
	$global:tmpy=0
}

function RESTORE {
	$global:_dataPtr=0
}

function READSTR {
	$global:A_REG=$global:_datas[$global:_dataPtr++]
}

function READNUMBER {
	$num=$global:_datas[$global:_dataPtr++]
	
	if ($num -eq "." -or $num.length -eq 0) {
		$num=0
	}
	$global:Y_REG=$num
}

function FINX {
	throw "Fast inc optimization not supported for target PS!"
}

function FDEX {
	throw "Fast dec optimization not supported for target PS!"
}

function FASTFOR {
	throw "Fast for optimization not supported for target PS!"
}

function OPEN {
	"[OPEN not supported for PS, call ignored: "+$global:B_REG+"/"+$global:X_REG+"/"+$global:C_REG+"/"+$global:D_REG+"]"
}

function CLOSE {
	"[CLOSE not supported for PS, call ignored: "+$global:X_REG+"]"
}

function CMD {
	"[CMD not supported for PS, call ignored: "+$global:X_REG+"]"
}

function REM {
	"[inline assembly ignored!]"
}

function LOCKCHANNEL {
	"[ignored]"
}

function UNLOCKCHANNEL {
	"[ignored]"
}

function STROUTCHANNEL {
	"[PRINT# not supported for PS, redirected to normal PRINT]"
	STROUT
}

function REALOUTCHANNEL {
	"[PRINT# not supported for PS, redirected to normal PRINT]"
	REALOUT
}

function LINEBREAKCHANNEL {
	"[PRINT# not supported for PS, redirected to normal PRINT]"
	LINEBREAK
}

function INTOUTCHANNEL {
	"[PRINT# not supported for PS, redirected to normal PRINT]"
	INTOUT
}

function INPUTNUMBERCHANNEL {
	"[INPUT# not supported for PS, call ignored]"
	$global:X_REG=0
}

function INPUTSTRCHANNEL {
	"[INPUT# not supported for PS, call ignored]"
	$global:A_REG=""
}

function GETSTRCHANNEL {
	"[GET# not supported for PS, call ignored]"
	$global:A_REG=""
}

function GETNUMBERCHANNEL {
	"[GET# not supported for PS, call ignored]"
	$global:X_REG=0
}

function TABOUTCHANNEL {
	"[TAB not supported for PS in file mode, redirected to normal TAB]"
	TAB
}

function SPCOUTCHANNEL {
	"[SPC not supported for PS in file mode, redirected to normal SPC]"
	SPC
}

function TABCHANNEL {
	"[TAB not supported for PS in file mode, redirected to normal TAB]"
	TAB
}

function SPCCHANNEL {
	"[SPC not supported for PS in file mode, redirected to normal SPC]"
	SPC
}

function LOAD {
	"[LOAD not supported for PS in file mode, call ignored]"
}

function SAVE {
	"[SAVE not supported for PS in file mode, call ignored]"
}

function VERIFY {
	"[VERIFY not supported for PS in file mode, call ignored]"
}

function USR {
	$addr=$global:_memory[785] + 256*$global:_memory[786]
	$global:USR_PARAM=$global:X_REG
	$callStr="$"+([Convert]::ToString($addr, 16))
	"[Calling user function named "+$callStr+"]"
	invoke-expression $callStr
}

function input {
	if ($global:_inputQueue.length -gt 0) {
		$vv=first $global:_inputQueue
		$global:_inputQueue=pop $global:_inputQueue
		return $vv
	}
	$inp=Read-Host -Prompt $global:_line
	$global:_line=""
	$parts=$inp.Split(",")
	for ($i=$parts.length; $i>0; $i--) {
		$global:_inputQueue+=$parts[$i]
	}
	return $parts[0]
}

function get {
	return registerKey
}

function out {
	param($txt)
	if ($txt.indexOf -and $txt.indexOf("`n") -ne -1) {
		$global:_line += $txt.SubString(0,$txt.length-1)
		write-host $global:_line
		$global:_line = ""
	} else {
		$global:_line += $txt
	}
}

execute